
unit l_bss;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,
  AppContainer,
  Mask,
  ComCtrls,

  DB,
  nxdb,
  DataManager,
  ReportManager,

  Menus, cxLookAndFeelPainters, cxButtons, cxGroupBox,
  cxRadioGroup, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxSpinEdit, dxmdaset, cxCheckBox,

  Gim10Fields,

  dm_sal, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel;


type
    TrptBssForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    SaldosInicialesCtrl: TcxDBCheckBox;
    ExcluirSaldoCeroCtrl: TcxDBCheckBox;
    report: TgxReportManager;
    SaldosTable: TnxeTable;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataSeleccionCentroCoste: TSmallintField;
    DataCentroCoste: TWideStringField;
    DataPeriodo: TSmallintField;
    DataSource: TDataSource;
    PeriodoCtrl: TcxDBSpinEdit;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    SeleccionCentroCosteCtrl: TcxDBRadioGroup;
    CentroCosteCtrl: TcxDBTextEdit;
    gxRangeBox1: TgxRangeBox;
    DataSaldosIniciales: TBooleanField;
    DataExcluirSaldosNulos: TBooleanField;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label3: TcxLabel;
    Label8: TcxLabel;
    Label7: TcxLabel;
    Label9: TcxLabel;
    descCentroCosteLabel: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoFinalCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoInicialCtrlPropertiesValidate(Sender: TcxCustomEdit;
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
    procedure PeriodoCtrlPropertiesValuePosted(Sender: TObject);
    procedure reportBeforeStart;
    private
    procedure SeleccionaRegistros;

    public

      RelacionSaldosTable : TnxeTable;
      RelacionSaldosFields: TRelacionSaldosFields;
      SaldosFields : TSaldosFields;

      Nivel,
      LongCodigo : smallInt;
      Seleccion : Boolean;

    end;

var
  rptBssForm : TrptBssForm = nil;

procedure BalanceSumasySaldos;


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
       rsMsg1 = 'Nivel incorrecto.';

procedure balanceSumasySaldos;
begin
     CreateReportForm( TrptBssForm, rptBssForm );
end;

procedure TrptBssForm.initializeForm;
begin
     SaldosFields := TSaldosFields.Create( SaldosTable );

     SeleccionCentroCosteCtrl.Enabled := DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;

     DataCodigoInicial.Value := '000';
     DataCodigoFinal.Value := '999';
     DataSeleccionCentroCoste.Value := 0;
     DataPeriodo.Value := MonthOf( ApplicationContainer.TodayDate );
     DataSaldosIniciales.Value := True;
     DataExcluirSaldosNulos.Value := False;
     
end;

procedure TrptBssForm.PeriodoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TrptBssForm.PeriodoCtrlPropertiesValuePosted(Sender: TObject);
begin
     If   PeriodoCtrl.EditValue=0
     then SaldosInicialesCtrl.Checked := True;
     SaldosInicialesCtrl.Enabled := PeriodoCtrl.EditValue<>0;
end;

procedure TrptBssForm.reportBeforeStart;
begin
     With Report do
       begin

       RelacionSaldosTable  := CreateEmptyTable( 'RelacionSaldos', DataModule10.GetSQL( 'RelacionSaldos' ) );
       RelacionSaldosFields := TRelacionSaldosFields.create( RelacionSaldosTable );

       SeleccionaRegistros;

       With DataSeleccionCentroCoste do
         If   Active
         then SetValueField( DataSeleccionCentroCoste )
         else SetValue( RsSeleccionCentroCoste, 2 );    // No existen centros de coste

       SetValue( RsDescCentroCoste, DescCentroCosteLabel.Caption );
       SetValue( RsTextoPeriodo, StrMonth( DataPeriodo.Value, False  ) );
       end;

end;

procedure TrptBssForm.SeleccionCentroCosteCtrlPropertiesChange(Sender: TObject);
begin
     CentroCosteCtrl.Enabled := DataSeleccionCentroCoste.Value=1;
end;

procedure TrptBssForm.SeleccionaRegistros;

var   CuentaActual : String;
      SumaDebePeriodo,
      SumaHaberPeriodo : Decimal;
      SumasySaldos : ISumasySaldos;

begin

     With SaldosTable do
       begin

       CuentaActual := '';
       LongCodigo := System.Length( TrimRight( DataCodigoInicial.Value ) );

       SumaDebePeriodo := 0.0;
       SumaHaberPeriodo := 0.0;

       SetRange( [ ApplicationContainer.Ejercicio, DataCodigoInicial.Value, ''          ],
                 [ ApplicationContainer.Ejercicio, Cuenta.CodigoSeleccion( DataCodigoFinal.Value, Seleccion ), HighStrCode ] );

       ApplicationContainer.StartProgression( RecordCount );

       First;
       While not Eof  do
         begin

         If   Length( SaldosFields.Codigo.Value )=LongCodigo
         then begin

              If   SaldosFields.codigo.Value<>CuentaActual
              then If   Cuenta.SeleccionValida( SaldosFields.codigo.Value, DataCodigoInicial.Value, DataCodigoFinal.Value, Seleccion, Nivel )
                   then begin

                        CuentaActual := SaldosFields.codigo.Value;

                        ApplicationContainer.ShowProgression;

                        SumasySaldos := Saldos.SaldoPeriodo( SaldosFields.codigo.Value,
                                                             DataCentroCoste.Value,
                                                             DataSeleccionCentroCoste.Value=0,
                                                             ApplicationContainer.Ejercicio,
                                                             0,
                                                             DataPeriodo.Value,
                                                             True );

                        If   not( DataExcluirSaldosNulos.Value and ( SumasySaldos.Saldo=0.0 ) )
                        then If   ( DataSaldosIniciales.Value and ( SumasySaldos.SaldoInicial<>0.0 ) ) or
                                  ( SumasySaldos.Debe[ DataPeriodo.Value ]<>0.0 ) or
                                  ( SumasySaldos.Haber[ DataPeriodo.Value ]<>0.0 ) or
                                  ( SumasySaldos.SumaDebe<>0.0 ) or
                                  ( SumasySaldos.SumaHaber<>0.0 )
                             then begin

                                  RelacionSaldosTable.Append;

                                  RelacionSaldosFields.Cuenta.Value := SaldosFields.Codigo.Value;
                                  RelacionSaldosFields.DescripcionCuenta.Value := Cuenta.Descripcion( SaldosFields.Codigo.Value, False, True );

                                  RelacionSaldosFields.SaldoInicial.Value := SumasySaldos.SaldoInicial;

                                  SumaDebePeriodo := SumasySaldos.Debe[ DataPeriodo.Value ];
                                  SumaHaberPeriodo := SumasySaldos.Haber[ DataPeriodo.Value ];

                                  RelacionSaldosFields.DebePeriodo.Value := SumaDebePeriodo;
                                  RelacionSaldosFields.HaberPeriodo.Value := SumaHaberPeriodo;
                                  RelacionSaldosFields.Debe.Value := SumasySaldos.SumaDebe;
                                  RelacionSaldosFields.Haber.Value := SumasySaldos.SumaHaber;
                                  RelacionSaldosFields.Saldo.Value := SumasySaldos.Saldo;

                                  RelacionSaldosTable.Post;
                                  end;

                        end;

              end;

         next;
         end;

       end;

     ApplicationContainer.endProgression;


end;

procedure TrptBssForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TrptBssForm.CodigoFinalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not FormManager.ValidatingFormData
     then begin
          DisplayValue := RightPad( Copy( DisplayValue, 1, LongCodigo ), LongCodigo, '9' );
          Cuenta.CompruebaSeleccion( DataCodigoInicial.Value, DisplayValue, Seleccion, Nivel );
          end;
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True, False );
end;

procedure TrptBssForm.CodigoInicialCtrlPropertiesEditValueChanged( Sender: TObject);
begin
     If   CodigoInicialCtrl.Editing
     then CodigoFinalCtrl.PostEditValue( Copy( '999999999', 1, LongCodigo ) );
end;

procedure TrptBssForm.CodigoInicialCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
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

procedure TrptBssForm.CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TrptBssForm.CentroCosteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TrptBssForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, False );
end;

end.

