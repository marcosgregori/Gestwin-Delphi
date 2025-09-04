
unit l_sda;

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

  Gim10Fields,

  dm_sal,
  Menus,
  cxLookAndFeelPainters,
  cxButtons, cxGraphics, cxDropDownEdit, cxDBEdit, cxCurrencyEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit,
  dxmdaset, cxIndexedComboBox, dxSkinsCore, dxSkinsDefaultPainters,
  cxLookAndFeels, cxLabel, cxGroupBox, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, EditSelector,
  dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;


type
    TRptSdaForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    PeriodoCtrl: TcxDBSpinEdit;
    ImporteMinimoCtrl: TcxDBCurrencyEdit;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    TipoCtrl: TcxDBIndexedComboBox;
    OrdenarCtrl: TcxDBIndexedComboBox;
    SaldosQuery: TnxeQuery;
    report: TgxReportManager;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataSource: TDataSource;
    DataPeriodo: TSmallintField;
    DataTipo: TSmallintField;
    DataImporteMinimo: TBCDField;
    DataOrdenar: TSmallintField;
    CuentaRangeBox: TgxRangeBox;
    Label5: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label6: TcxLabel;
    Label3: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    EditSelector: TgxEditSelector;
    CuentasTable: TnxeTable;
    CuentasTableNroRegistro: TSmallintField;
    CuentasTableCodigo: TStringField;
    CuentasTableDescripcion: TStringField;
    CuentasDataSource: TDataSource;
    cxGridViewRepository1: TcxGridViewRepository;
    CuentasTableView: TcxGridDBTableView;
    CuentasTableViewCodigo: TcxGridDBColumn;
    CuentasTableViewDescripcion: TcxGridDBColumn;
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
    procedure PeriodoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoInicialCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure CuentasTableViewCodigoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    private

    public

      RelacionSaldosTable : TnxeTable;
      RelacionSaldosFields : TRelacionSaldosFields;
      SaldosFields : TSaldosFields;

      Nivel,
      LongCodigo : smallInt;
      Seleccion : Boolean;
    end;

var
  RptSdaForm : TRptSdaForm = nil;

procedure saldosDeudoresAcreedores;


implementation

uses   Variants,
       DateUtils,
       LibUtils,
       EnterpriseDataAccess,

       Gdm10Dm,
       dmi_sal,

       dm_pga,
       dm_sub,

       b_msg,

       cx_sub;

{$R *.DFM}

resourceString
       RsMsg1 = 'Nivel incorrecto.';

procedure SaldosDeudoresAcreedores;
begin
     CreateReportForm( TrptSdaForm, rptSdaForm );
end;

procedure TRptSdaForm.InitializeForm;
begin

     SetEditControlDecimals( ImporteMinimoCtrl );

     DataCodigoInicial.Value := '000';
     DataCodigoFinal.Value := '999';
     DataPeriodo.Value := MonthOf( ApplicationContainer.TodayDate );
     DataTipo.Value := 0;
     DataOrdenar.Value := 0;

     EditSelector.EditMode := tesRange;
end;

procedure TRptSdaForm.PeriodoCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptSdaForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var   QueryText,
      CodigoInicial,
      CodigoFinal,
      CuentaActual  : String;
      SumasySaldos : ISumasySaldos;

begin

     With SaldosQuery do
       begin

       CuentaActual := '';
       LongCodigo := System.Length( TrimRight( DataCodigoInicial.Value ) );

       CodigoInicial := DataCodigoInicial.Value;
       CodigoFinal := Cuenta.CodigoSeleccion( DataCodigoFinal.Value, Seleccion );

       QueryText := 'SELECT * FROM Saldos WHERE Ejercicio=' + IntToStr( ApplicationContainer.Ejercicio ) + ' AND ' +
                    EditSelector.GetSQLSelection +
                    ' ORDER BY Codigo';

       SaldosQuery.SQL.Text := QueryText;

       SaldosQuery.Open;

       SaldosFields := TSaldosFields.Create( SaldosQuery );

       ApplicationContainer.StartProgression( RecordCount );

       try

         First;
         While not Eof  do
           begin

           If   Length( SaldosFields.Codigo.Value )=LongCodigo
           then begin

                If   SaldosFields.Codigo.Value<>CuentaActual
                then If   ( EditSelector.EditMode<>tesRange ) or Cuenta.SeleccionValida( SaldosFields.Codigo.Value, DataCodigoInicial.Value, DataCodigoFinal.Value, Seleccion, Nivel )
                     then begin

                          CuentaActual := SaldosFields.Codigo.Value;

                          ApplicationContainer.ShowProgression;

                          SumasySaldos := Saldos.SaldoPeriodo( SaldosFields.Codigo.Value, '', True, ApplicationContainer.Ejercicio, 0, DataPeriodo.Value, True );

                          If   ( ( ( DataTipo.Value=0 ) and ( SumasySaldos.Saldo>0.0 ) ) or ( ( DataTipo.Value=1 ) and ( SumasySaldos.Saldo<0.0 ) ) ) and
                               ( ( DataImporteMinimo.Value=0.0 ) or ( Abs( SumasySaldos.Saldo )>=DataImporteMinimo.Value ) )
                          then begin

                               RelacionSaldosTable.Append;

                               RelacionSaldosFields.Cuenta.Value := SaldosFields.Codigo.Value;
                               RelacionSaldosFields.DescripcionCuenta.Value := Cuenta.Descripcion( SaldosFields.Codigo.Value, False, True );
                               RelacionSaldosFields.Saldo.Value := SumasySaldos.Saldo;

                               RelacionSaldosTable.Post;
                               end;

                     end;

                end;

           next;
           end;

       finally
         SaldosQuery.Close;
         ApplicationContainer.EndProgression;
         end;

       end;

end;

begin
     With Report do
       try

         Load;

         RelacionSaldosTable := CreateEmptyTable( 'RelacionSaldos', DataModule10.GetSQL( 'RelacionSaldos' ) );
         RelacionSaldosFields := TRelacionSaldosFields.Create( RelacionSaldosTable );

         SeleccionaRegistros;

         SetValue( RsTextoPeriodo, StrMonth( DataPeriodo.Value, False ) );

         With RelacionSaldosTable do
           case DataOrdenar.Value of
             0 : IndexFieldNames := 'Cuenta';
             1 : IndexFieldNames := 'DescripcionCuenta';
             2 : IndexName       := 'Index4';  // NexusDB tiene un pequeño problema con el uso de IndexFieldNames aquí
             end;

         SetValue( RsSeleccion, EditSelector.GetReportSelectionText );

         Start;

       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptSdaForm.CodigoCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, False );
end;

procedure TRptSdaForm.CodigoFinalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     If   not FormManager.ValidatingFormData
     then begin
          DisplayValue := RightPad( Copy( DisplayValue, 1, LongCodigo ), LongCodigo, '9' );
          Cuenta.CompruebaSeleccion( DataCodigoInicial.Value, DisplayValue, Seleccion, Nivel );
          end;
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True, False );
end;

procedure TRptSdaForm.CodigoInicialCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   CodigoInicialCtrl.Editing
     then CodigoFinalCtrl.PostEditValue( Copy( '999999999', 1, LongCodigo ) );
end;

procedure TRptSdaForm.CodigoInicialCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
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
               ErrorText := rsMsg1;
               end;
          end;
     If   not Error
     then Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True, False );
end;

procedure TRptSdaForm.CuentasTableViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     var Descripcion := Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, False, False );
     If   not Error and CuentasTable.Editing
     then CuentasTableDescripcion.Value := Descripcion;
end;

end.
