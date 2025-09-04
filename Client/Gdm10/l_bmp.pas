
unit l_bmp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls,
  ReportManager,
  DB,
  nxdb,
  DataManager,

  Menus, cxLookAndFeelPainters, cxButtons, dxmdaset, cxDBEdit,
  cxTextEdit, cxMaskEdit, cxSpinEdit, cxControls, cxContainer, cxEdit,
  cxCheckBox, cxGroupBox, cxRadioGroup,

  Gim10Fields,
  dm_sal, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel;


type
    TrptBmpForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    NivelesCtrl: TcxDBCheckBox;
    PeriodoInicialCtrl: TcxDBSpinEdit;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    PeriodoFinalCtrl: TcxDBSpinEdit;
    SaldosTable: TnxeTable;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataSource: TDataSource;
    SeleccionCentroCosteCtrl: TcxDBRadioGroup;
    CentroCosteCtrl: TcxDBTextEdit;
    DataSeleccionCentroCoste: TSmallIntField;
    DataCentroCoste: TWideStringField;
    DataPeriodoInicial: TSmallIntField;
    DataPeriodoFinal: TSmallIntField;
    DataNiveles: TBooleanField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    DataSaldosIniciales: TBooleanField;
    SaldosInicialesCtrl: TcxDBCheckBox;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label3: TcxLabel;
    Label8: TcxLabel;
    Label11: TcxLabel;
    Label7: TcxLabel;
    Label9: TcxLabel;
    descCentroCosteLabel: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoInicialCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoFinalCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SeleccionCentroCosteCtrlPropertiesChange(Sender: TObject);
    procedure CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CentroCosteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PeriodoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoInicialCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ReportBeforeStart;
    private
    procedure SeleccionaRegistros;

    public

      RelacionSaldosTable  : TnxeTable;
      RelacionSaldosFields : TRelacionSaldosFields;
      SaldosFields : TSaldosFields;

      Nivel,
      LongCodigo : SmallInt;
      Seleccion : Boolean;
    end;

var
  rptBmpForm : TrptBmpForm = nil;

procedure BalanceMovimientos;


implementation

uses   Variants,
       DateUtils,
       LibUtils,

       Gdm00Dm,
       Gdm10Dm,
       Gim00Fields,

       dmi_sal,

       dm_pga,
       dm_sub,
       dm_cco,

       b_msg,

       cx_sub,
       cx_cco;

{$R *.DFM}

resourceString
       RsMsg1 = 'Nivel incorrecto.';

procedure BalanceMovimientos;
begin
     createReportForm( TrptBmpForm, rptBmpForm );
end;

procedure TrptBmpForm.initializeForm;
begin
     SaldosFields := TSaldosFields.create( SaldosTable );

     SeleccionCentroCosteCtrl.Enabled := DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;

     DataCodigoInicial.Value := '000';
     DataCodigoFinal.Value := '999';
     DataSeleccionCentroCoste.Value := 0;
     DataPeriodoInicial.Value := 0;
     DataPeriodoFinal.Value := MonthOf( ApplicationContainer.TodayDate );
     DataSaldosIniciales.Value := True;
end;

procedure TrptBmpForm.PeriodoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TrptBmpForm.ReportBeforeStart;
begin
     With Report do
       begin

       RelacionSaldosTable  := CreateEmptyTable( 'RelacionSaldos', DataModule10.GetSQL( 'RelacionSaldos' ) );
       RelacionSaldosFields := TRelacionSaldosFields.Create( RelacionSaldosTable );

       SeleccionaRegistros;

       With DataSeleccionCentroCoste do
         If   Active
         then SetValueField( DataSeleccionCentroCoste )
         else SetValue( RsSeleccionCentroCoste, 2 );    // No existen centros de coste

       SetValue( RsDescCentroCoste, DescCentroCosteLabel.Caption );
       
       SetValue( RsTextoPeriodoInicial, StrMonth( DataPeriodoInicial.Value, False ) );
       SetValue( RsTextoPeriodoFinal, StrMonth( DataPeriodoFinal.Value, False ) );

       end;

end;

procedure TrptBmpForm.SeleccionCentroCosteCtrlPropertiesChange(Sender: TObject);
begin
     CentroCosteCtrl.Enabled := DataSeleccionCentroCoste.Value=1;
end;

procedure TrptBmpForm.SeleccionaRegistros;

var   CuentaActual : String;
      Index : SmallInt;

procedure InsertaSaldo( Codigo : String );

var  SumasySaldos : ISumasySaldos;

begin
     ApplicationContainer.ShowProgression;

     If   not RelacionSaldosTable.FindKey( [ Codigo ] )
     then begin

          SumasySaldos := Saldos.SaldoPeriodo( Codigo,
                                               DataCentroCoste.Value,
                                               DataSeleccionCentroCoste.Value=0,
                                               ApplicationContainer.Ejercicio,
                                               DataPeriodoInicial.Value,
                                               DataPeriodoFinal.Value,
                                               True );

          If   ( SumasySaldos.SumaDebe<>0.0 ) or ( SumasySaldos.SumaHaber<>0.0 )
          then begin

               RelacionSaldosTable.Append;

               RelacionSaldosFields.Cuenta.Value := Codigo;
               RelacionSaldosFields.DescripcionCuenta.Value := Cuenta.Descripcion( Codigo, False, True );

               //* 09.11.2009  Sustrayendo los saldos de apertura para que se puedan mostrar los saldos sin ellos

               If   DataSaldosIniciales.Value
               then begin
                    RelacionSaldosFields.Debe.Value := SumasySaldos.SumaDebe;
                    RelacionSaldosFields.Haber.Value := SumasySaldos.SumaHaber;
                    RelacionSaldosFields.Saldo.Value := SumasySaldos.Saldo;
                    end
               else begin
                    RelacionSaldosFields.Debe.Value := SumasySaldos.SumaDebe - SumasySaldos.SumaDebeInicial;
                    RelacionSaldosFields.Haber.Value := SumasySaldos.SumaHaber - SumasySaldos.SumaHaberInicial;
                    RelacionSaldosFields.Saldo.Value := SumasySaldos.Saldo - SumasySaldos.SaldoInicial;
                    end;

               RelacionSaldosTable.Post;
               end;

          end;

end;

begin

     RelacionSaldosTable.IndexFieldNames := 'Cuenta';

     With SaldosTable do
       begin

       CuentaActual := '';
       LongCodigo   := System.Length( TrimRight( DataCodigoInicial.Value ) );

       SetRange( [ ApplicationContainer.Ejercicio, DataCodigoInicial.Value, ''  ],
                 [ ApplicationContainer.Ejercicio, Cuenta.CodigoSeleccion( DataCodigoFinal.Value, Seleccion ), HighStrCode ] );

       ApplicationContainer.StartProgression( recordCount );

       First;
       While not eof  do
         begin

         If   length( SaldosFields.Codigo.Value )=LongCodigo
         then begin

              If   SaldosFields.Codigo.Value<>CuentaActual
              then If   Cuenta.SeleccionValida( SaldosFields.codigo.Value, DataCodigoInicial.Value, DataCodigoFinal.Value, Seleccion, Nivel )
                   then begin

                        CuentaActual := SaldosFields.Codigo.Value;
                        InsertaSaldo( CuentaActual );

                        If   DataNiveles.Value
                        then For Index := 1 to Nivel - 1 do
                               InsertaSaldo( Copy( CuentaActual, 1, Index ) );

                        end;
              end;
         Next;
         end;

       end;

     ApplicationContainer.EndProgression;
end;

procedure TrptBmpForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TrptBmpForm.CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TrptBmpForm.CentroCosteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TrptBmpForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, False );
end;

procedure TrptBmpForm.CodigoFinalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     If   not FormManager.ValidatingFormData
     then begin
          DisplayValue := RightPad( Copy( DisplayValue, 1, LongCodigo ), LongCodigo, '9' );
          Cuenta.CompruebaSeleccion( DataCodigoInicial.Value, DisplayValue, Seleccion, Nivel );
          end;
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True, False );
end;

procedure TrptBmpForm.CodigoInicialCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   CodigoInicialCtrl.Editing
     then CodigoFinalCtrl.PostEditValue( Copy( '999999999', 1, LongCodigo ) );
end;

procedure TrptBmpForm.CodigoInicialCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     LongCodigo := System.Length( TrimRight( VarToStr( DisplayValue ) ) );
     If   not FormManager.ValidatingFormData
     then begin
          If   LongCodigo in [ 1..5, 9 ]
          then begin
               If   LongCodigo=9
               then Nivel := Cuenta.NivelSubcuenta
               else Nivel := LongCodigo;
               end
          else begin
               Error := True;
               ErrorText := RsMsg1;
               end;
          end;
     If   not Error
     then Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True, False );
end;

end.

