unit a_edi;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls, Grids,

  Menus, cxLookAndFeelPainters, cxButtons,
  cxCurrencyEdit, cxDBEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, nxdb, DataManager, AppContainer,

  Gim10Fields, dxSkinsCore, dxSkinscxPCPainter, cxGroupBox, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxNavigator, cxIntegerEdit, dxDateRanges,

  AppForms,
  GridTableViewController, dxScrollbarAnnotations, dxUIAClasses;

type
  TMntEdiForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    InmovilizadoTable: TnxeTable;
    dataPanel: TgxEditPanel;
    LineaInmovilizadoTable: TnxeTable;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    Panel1: TcxGroupBox;
    CodigoProveedorCtrl: TcxDBTextEdit;
    SerieNroFacturaCtrl: TcxDBTextEdit;
    CuentaAmortizacionCtrl: TcxDBTextEdit;
    TipoCtrl: TcxDBCurrencyEdit;
    UbicacionCtrl: TcxDBTextEdit;
    FechaCompraCtrl: TcxDBDateEdit;
    ImporteCtrl: TcxDBCurrencyEdit;
    CentroCosteCtrl: TcxDBTextEdit;
    InmovilizadoDataSource: TDataSource;
    LineaInmovilizadoDataSource: TDataSource;
    LineaInmovilizadoTableCodigo: TWideStringField;
    LineaInmovilizadoTableNroRegistro: TSmallintField;
    LineaInmovilizadoTableFecha: TDateField;
    LineaInmovilizadoTableDescripcion: TWideStringField;
    LineaInmovilizadoTableImporte: TBCDField;
    codigoLabel: TcxLabel;
    DescCodigoLabel: TcxLabel;
    Label1: TcxLabel;
    DescProveedorLabel: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    DescAmortizacionLabel: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label11: TcxLabel;
    Label12: TcxLabel;
    Label13: TcxLabel;
    Label4: TcxLabel;
    Label8: TcxLabel;
    DescCCLabel: TcxLabel;
    Label9: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    TableViewManager: TGridTableViewController;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewFecha: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewImporte: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    Label14: TcxLabel;
    CampoLibre1Panel: TcxGroupBox;
    Campo1Label: TcxLabel;
    CampoLibre1Ctrl: TcxDBTextEdit;
    CampoLibre2Panel: TcxGroupBox;
    Campo2Label: TcxLabel;
    CampoLibre2Ctrl: TcxDBTextEdit;
    CampoLibre3Panel: TcxGroupBox;
    Campo3Label: TcxLabel;
    CampoLibre3Ctrl: TcxDBTextEdit;
    CampoLibre4Panel: TcxGroupBox;
    Campo4Label: TcxLabel;
    CampoLibre4Ctrl: TcxDBTextEdit;
    EjerciciosBox: TcxLabel;
    SubcuentaButton: TgBitBtn;
    LineaInmovilizadoTableCodigoProveedor: TWideStringField;
    LineaInmovilizadoTableSerieNroFactura: TWideStringField;
    GridViewCodigoProveedor: TcxGridDBColumn;
    GridViewSerieNroFactura: TcxGridDBColumn;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CentroCosteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CentroCosteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SubcuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SubcuentaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoProveedorCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure CuentaAmortizacionCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure SubcuentaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CuentaAmortizacionCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure FacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TipoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroFacturaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure InmovilizadoTableBeforePost(DataSet: TDataSet);
    procedure InmovilizadoTableRecordChanged(DataSet: TDataSet);
    procedure CuentaAmortizacionCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure LineaInmovilizadoTableBeforePost(DataSet: TDataSet);
    procedure SubcuentaButtonClick(Sender: TObject);
    procedure GridViewSerieNroFacturaPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewSerieNroFacturaPropertiesValuePosted(
      Sender: TObject);
    procedure SerieCtrlPropertiesValuePosted(Sender: TObject);
    procedure GridViewCodigoProveedorPropertiesEnter(
      Sender: TcxCustomEdit);
  private


  public
    InmovilizadoFields : TInmovilizadoFields;
    LineaInmovilizadoFields : TLineaInmovilizadoFields;

    procedure DoSelected( Target : TcxCustomEdit = nil );
    procedure DoSerieNroFacturaLineaSelected( Target : TcxCustomEdit = nil );
  end;

var MntEdiForm: TMntEdiForm = nil;

procedure MntElementosInmovilizado( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       Variants,
       DateUtils,
       LibUtils,
       AppManager,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm10Frm,

       AsientoIntf,

       dmi_pga,
       dmi_ast,

       dm_pga,
       dm_ast,
       dm_sub,
       dm_cco,
       dm_edi,
       dm_fac,

       b_msg,

       a_sub,
       a_cco,
       a_fcg,

       cx_sub,
       cx_edi,
       cx_fcg,
       cx_cco,

       l_edi;

resourceString
       RsMsg3 = 'Utilice sólo subcuentas de los grupos 20, 21 y 22.';
       RsMsg4 = 'Los elementos de inmovilizado deben pertenecer a los grupos 20. Gastos de establecimiento, 21. Inmovilizaciones inmateriales o 22. Inmovilizaciones materiales.';
       RsMsg5 = 'La subcuenta introducida no coincide con la propuesta por la aplicación.';
       RsMsg6 = 'Si aplica una codificación inadecuada de subcuentas puede originar un cálculo incorrecto de las amortizaciones.'#13'¿Desea utilizar de todos modos la subcuenta indicada?';
       RsMsg8 = 'A. A. ';
       RsMsg9 = 'Amortización ';
       RsMsg10 = 'La factura no pertenece al ejercicio activo.';

procedure MntElementosInmovilizado( KeyValues : array of const );
begin
     CreateEditForm( TMntEdiForm, MntEdiForm, KeyValues, TGds10Frm.InmovilizadoSection );
end;

procedure TMntEdiForm.FormManagerInitializeForm;
begin

     InmovilizadoFields := TInmovilizadoFields.Create( InmovilizadoTable );
     LineaInmovilizadoFields := TLineaInmovilizadoFields.Create( LineaInmovilizadoTable );

     InmovilizadoFields.CodigoProveedor.Origin := 'Propietario';  // Se necesita en la consulta de SerieCtrl

     CentroCosteCtrl.Enabled:= DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;
     SetEditControlDecimals( TipoCtrl, 2 );
     SetEditControlDecimals( ImporteCtrl );
     SetColumnDecimals( GridViewImporte );

     SetupPanelableCtrls( [ CampoLibre1Ctrl, CampoLibre2Ctrl, CampoLibre3Ctrl, CampoLibre4Ctrl ],
                          function ( Index : SmallInt; Edit : TcxCustomEdit ) : Boolean
                            begin
                            var LabelCaption := DataModule00.DmEmpresaFields.Inmovilizado_CampoLibre[ Index + 1 ].Value;
                            Result := not ValueIsEmpty( LabelCaption );
                            If   Result and Assigned( Edit.CaptionLabel )
                            then TcxLabel( Edit.CaptionLabel ).Caption := LabelCaption;
                            end,
                          True );

     SetFieldRange( LineaInmovilizadoFields.NroRegistro );

end;

procedure TMntEdiForm.DoSelected;
begin
     With CxFcgForm do
       If   EjercicioFecha( QueryFecha.Value )<>ApplicationContainer.Ejercicio
       then ShowHintMsg( RsMsg10, '', SerieNroFacturaCtrl )
       else begin
            //* 28.03.2003 Permito hacer consultas de cualquier proveedor al pulsar <Shift>
            CodigoProveedorCtrl.PostEditValue( QueryPropietario.Value );
            SerieNroFacturaCtrl.PostEditValue( QuerySerie.Value );
            end;
end;

procedure TMntEdiForm.FormManagerReportRequest;
begin
     ListadoElementosInmovilizado;
end;

procedure TMntEdiForm.GridViewCodigoProveedorPropertiesEnter(Sender: TcxCustomEdit);
begin
     If   ValueIsEmpty( Sender.EditValue )
     then Sender.EditValue := InmovilizadoFields.CodigoProveedor.Value;
end;

procedure TMntEdiForm.GridViewSerieNroFacturaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFrasRecibidas( LineaInmovilizadoFields.CodigoProveedor, Sender, qgsNormal, DoSerieNroFacturaLineaSelected );
end;

procedure TMntEdiForm.GridViewSerieNroFacturaPropertiesValuePosted(Sender: TObject);

var Asiento : IAsiento;
    BaseImponible,
    CuotaIVA,
    CuotaRE,
    ImporteTotal : Decimal;

begin
     If   LineaInmovilizadoTable.Editing
     then With LineaInmovilizadoFields do
            If   Factura.ObtenImportesFacturaRecibida( EjercicioFecha( Fecha.Value ), CodigoProveedor.Value, SerieNroFactura.Value, Asiento, BaseImponible, CuotaIVA, ImporteTotal )
            then Importe.Value := BaseImponible;
end;

procedure TMntEdiForm.DoSerieNroFacturaLineaSelected( Target : TcxCustomEdit = nil );
begin
     With CxFcgForm do
       If   EjercicioFecha( QueryFecha.Value )<>ApplicationContainer.Ejercicio
       then ShowHintMsg( RsMsg10, '', Target )
       else begin
            LineaInmovilizadoTable.Edit;  // Por si acaso
            LineaInmovilizadoFields.CodigoProveedor.Value:= QueryPropietario.Value;
            Target.PostEditValue( QuerySerie.Value );
            end;
end;

procedure TMntEdiForm.InmovilizadoTableBeforePost(DataSet: TDataSet);
begin
     If   InmovilizadoTable.State=dsInsert
     then With InmovilizadoFields do
            Cuenta.InsertaSubcuenta( Inmovilizado.SubcuentaDotacion( CuentaAmortizacion.Value ), RsMsg9 + DescCodigoLabel.Caption );
     ApplicationContainer.ProcessRecordChangesLog( InmovilizadoTable, frdInmovilizado );
end;

procedure TMntEdiForm.InmovilizadoTableRecordChanged(DataSet: TDataSet);
begin
     EjerciciosBox.Caption := '';
end;

procedure TMntEdiForm.LineaInmovilizadoTableBeforePost(DataSet: TDataSet);
begin
     If   not LineaInmovilizadoTable.ControlsDisabled
     then ApplicationContainer.ProcessRecordChangesLog( LineaInmovilizadoTable, frdInmovilizado );
end;

procedure TMntEdiForm.NroFacturaCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     If   InmovilizadoTable.State=dsEdit
     then With InmovilizadoFields do
            MntFacturasRecibidas( [ taFraRecibida, EjercicioFecha( FechaCompra.Value ), CodigoProveedor.Value, SerieNroFactura.Value, 0, NroEfectoRegistroFactura ] );
end;

procedure TMntEdiForm.CentroCosteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCentrosCoste( [ Sender.EditingValue ] );
end;

procedure TMntEdiForm.CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TMntEdiForm.CentroCosteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorTExt, Error );
end;

procedure TMntEdiForm.FacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFrasRecibidas( InmovilizadoFields.CodigoProveedor, Sender, qgsNormal, DoSelected );
end;

procedure TMntEdiForm.SerieCtrlPropertiesValuePosted(Sender: TObject);
var Asiento : IAsiento;
    BaseImponible,
    CuotaIVA,
    CuotaRE,
    ImporteTotal : Decimal;

begin
     If   SerieNroFacturaCtrl.Editing // and ( InmovilizadoTable.State=dsInsert )
     then With InmovilizadoFields do
            If   Factura.ObtenImportesFacturaRecibida( ApplicationContainer.Ejercicio, CodigoProveedor.Value, SerieNroFactura.Value, Asiento, BaseImponible, CuotaIVA, ImporteTotal )
            then begin
                 FechaCompraCtrl.PostEditValue( Asiento.Fecha );
                 ImporteCtrl.PostEditValue( BaseImponible );
                 end;
end;

procedure TMntEdiForm.SubcuentaButtonClick(Sender: TObject);
begin
     ConsultaCuentas( CodigoCtrl, qgsNormal, { SoloSubcuentas } True, {SinExtracto} True );
end;

procedure TMntEdiForm.SubcuentaCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntEdiForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var   CodigoGrupo : String;

begin
     If   not ValueIsEmpty( DisplayValue )
     then begin
          CodigoGrupo := Copy( DisplayValue, 1, 2 );
          If   ( CodigoGrupo<>'20' ) and
               ( CodigoGrupo<>'21' ) and
               ( CodigoGrupo<>'22' )
          then begin
               Error := True;
               ErrorText := JoinMessage( RsMsg3, RsMsg4 );
               end
          else Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
          end;
end;

procedure TMntEdiForm.CodigoProveedorCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With CodigoProveedorCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '4';
end;

procedure TMntEdiForm.SubcuentaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntEdiForm.TipoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then EjerciciosBox.Caption := ''
     else EjerciciosBox.Caption := StrFormat( 100.0 / VarToDecimal( DisplayValue ), 1 );
end;

procedure TMntEdiForm.CuentaAmortizacionCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With CuentaAmortizacionCtrl do
       If   Editing
       then If   InmovilizadoFields.CuentaAmortizacion.Value<>Inmovilizado.SubcuentaAmortizAcumulada( InmovilizadoFields.Codigo.Value )
            then If   ShowNotification( ntQuestionWarning, RsMsg5, RsMsg6 )<>mrYes
                 then begin
                      With InmovilizadoFields.Codigo do
                        Value := OldValue;
                      Refresh;
                      end;
end;

procedure TMntEdiForm.CuentaAmortizacionCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With CuentaAmortizacionCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := Inmovilizado.SubcuentaAmortizAcumulada( InmovilizadoFields.Codigo.Value );
end;

procedure TMntEdiForm.SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender );
end;

procedure TMntEdiForm.CuentaAmortizacionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
      If   CuentaAmortizacionCtrl.Editing
      then If   InmovilizadoTable.State=dsInsert
           then With InmovilizadoFields do
                  Cuenta.InsertaSubcuenta( DisplayValue, RsMsg8 + DescCodigoLabel.Caption );
      If   not Error
      then Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntEdiForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   ShiftKey
     then ConsultaCuentas( Sender )
     else ConsultaElementosInmovilizado( Sender, qgsLinked );
end;

end.
