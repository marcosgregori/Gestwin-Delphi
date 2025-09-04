unit a_fcg;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
     ExtCtrls, ComCtrls, Menus,

     cxLookAndFeelPainters, cxButtons, DB, nxdb, cxCheckBox, cxDBEdit, cxPC, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxStyles, cxCustomData,
     cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel,
     cxGridCustomTableView, cxGridTableView, cxClasses, cxGridCustomView,
     cxGridDBTableView, cxGrid, cxMaskEdit, cxDropDownEdit, cxCalendar,
     dxmdaset, cxCurrencyEdit, cxSpinEdit, dxSkinsCore,
     dxSkinsDefaultPainters, dxSkinscxPCPainter, cxGroupBox, cxLookAndFeels,
     cxLabel, cxPCdxBarPopupMenu, cxNavigator, cxIndexedComboBox, cxIntegerEdit,
     dxBar, cxSplitter, cxScrollBox, dxBarBuiltInMenu, dxDateRanges, GridTableViewController, dxScrollbarAnnotations,

     LibUtils,
     AppContainer,
     AppForms,
     DataManager,

     Gim00Fields,
     Gim10Fields,

     dmi_iva, dxUIAClasses;

type
  TMntFcgForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    SerieNroFacturaCtrl: TcxDBTextEdit;
    AsientoTable: TnxeTable;
    DataPanel: TgxEditPanel;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    RetencionesTabSheet: TcxTabSheet;
    PagosTabSheet: TcxTabSheet;
    ApunteTable: TnxeTable;
    ApunteConsultaTable: TnxeTable;
    BaseRetencionCtrl: TcxDBCurrencyEdit;
    TipoRetencionCtrl: TcxDBSpinEdit;
    ImporteRetencionCtrl: TcxDBCurrencyEdit;
    EfectoPagarTable: TnxeTable;
    SubcuentaRetencionCtrl: TcxDBTextEdit;
    PropietarioCtrl: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    Panel1: TcxGroupBox;
    Panel4: TcxGroupBox;
    FormaPagoCtrl: TcxDBTextEdit;
    GenerarEfectosButton: TgBitBtn;
    AsientoDataSource: TDataSource;
    ApunteDataSource: TDataSource;
    EfectoPagarDataSource: TDataSource;
    ApunteGrid: TcxGrid;
    ApunteGridView: TcxGridDBTableView;
    ApunteGridLevel: TcxGridLevel;
    ApunteGridViewManager: TGridTableViewController;
    EfectoPagarGrid: TcxGrid;
    EfectoPagarTableView: TcxGridDBTableView;
    EfectoPagarGridLevel: TcxGridLevel;
    EfectoPagarTableViewManager: TGridTableViewController;
    ApunteTableEjercicio: TSmallintField;
    ApunteTableNroAsiento: TIntegerField;
    ApunteTableNroApunte: TSmallintField;
    ApunteTableSubcuenta: TWideStringField;
    ApunteTableCentroCoste: TWideStringField;
    ApunteTableContrapartida: TWideStringField;
    ApunteTableConcepto: TWideStringField;
    ApunteTableTipoApunte: TSmallintField;
    ApunteTablePunteo: TBooleanField;
    ApunteTableBaseImponible: TBCDField;
    ApunteTableTipo: TSmallintField;
    ApunteTableCuotaIVA: TBCDField;
    ApunteTableCuotaRE: TBCDField;
    ApunteTableImporteTotal: TBCDField;
    ApunteGridViewSubcuenta: TcxGridDBColumn;
    ApunteGridViewBaseImponible: TcxGridDBColumn;
    ApunteGridViewTipo: TcxGridDBColumn;
    ApunteGridViewCuotaIVA: TcxGridDBColumn;
    ApunteGridViewImporteTotal: TcxGridDBColumn;
    Data: TgxMemData;
    AsientoMemDataSource: TDataSource;
    DataConcepto: TWideStringField;
    DataSubcuentaRetencion: TWideStringField;
    DataBaseRetencion: TBCDField;
    DataTipoRetencion: TSmallintField;
    DataImporteRetencion: TBCDField;
    DataFormaPago: TWideStringField;
    LockRangeButton: TgxLockRangeButton;
    ApunteTableDescripcion: TWideStringField;
    ApunteTableTipoIVA: TBCDField;
    ApunteTableFecha: TDateField;
    ApunteGridViewDescripcion: TcxGridDBColumn;
    ApunteGridViewTipoIVA: TcxGridDBColumn;
    ApunteGridViewCentroCoste: TcxGridDBColumn;
    EfectoPagarTableEjercicio: TSmallintField;
    EfectoPagarTableProveedor: TWideStringField;
    EfectoPagarTableNroFactura: TIntegerField;
    EfectoPagarTableNroEfecto: TSmallintField;
    EfectoPagarTableEntidad: TWideStringField;
    EfectoPagarTableFechaVencimiento: TDateField;
    EfectoPagarTableFechaPago: TDateField;
    EfectoPagarTableConcepto: TWideStringField;
    EfectoPagarTableImporte: TBCDField;
    EfectoPagarTableImportePagado: TBCDField;
    EfectoPagarTableConceptoPago: TWideStringField;
    EfectoPagarTableFechaLibramiento: TDateField;
    EfectoPagarTableFechaEmision: TDateField;
    EfectoPagarTableFormaDePago: TWideStringField;
    EfectoPagarTableNroAsiento: TIntegerField;
    EfectoPagarTableEjercicioRemesa: TSmallintField;
    EfectoPagarTableNroRemesa: TIntegerField;
    EfectoPagarTableRevisado: TBooleanField;
    EfectoPagarTableViewNroEfecto: TcxGridDBColumn;
    EfectoPagarTableViewEntidad: TcxGridDBColumn;
    EfectoPagarTableViewFechaVencimiento: TcxGridDBColumn;
    EfectoPagarTableViewFechaPago: TcxGridDBColumn;
    EfectoPagarTableViewImporte: TcxGridDBColumn;
    EfectoPagarTableViewDescripcion: TcxGridDBColumn;
    EfectoPagarTableDescripcion: TWideStringField;
    EfectoPagarTableDiferenciaCambio: TBCDField;
    EfectoPagarTableSubcuentaDiferencia: TWideStringField;
    ApunteTableDebe: TBCDField;
    ApunteTableHaber: TBCDField;
    EfectoPagarTableCodigoProveedor: TWideStringField;
    codigoCtrlCaption: TcxLabel;
    EstadoLabel: TcxLabel;
    Label4: TcxLabel;
    DescPropietarioLabel: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label8: TcxLabel;
    importeNoSujetoLabel: TcxLabel;
    DescTipoRetencionLabel: TcxLabel;
    Label7: TcxLabel;
    Label16: TcxLabel;
    DescSubcuentaRetencionLabel: TcxLabel;
    DescFormaPagoLabel: TcxLabel;
    Label10: TcxLabel;
    Label23: TcxLabel;
    Label11: TcxLabel;
    Label15: TcxLabel;
    retencionTotalLabel: TcxLabel;
    EfectoPagarTableAnotacion: TWideMemoField;
    ApunteTableCuentaAnalitica: TWideStringField;
    ApunteGridViewCuentaAnalitica: TcxGridDBColumn;
    EfectoPagarTableGenerarEfectoDiferencia: TBooleanField;
    FacturaTable: TnxeTable;
    FacturaDataSource: TDataSource;
    MainPageControl: TcxPageControl;
    ContenidoTS: TcxTabSheet;
    cxLabel8: TcxLabel;
    RegimenOTrascendenciaCtrl: TcxDBIndexedComboBox;
    FiscalTS: TcxTabSheet;
    ConceptoCtrl: TcxDBTextEdit;
    FechaCtrl: TcxDBDateEdit;
    NombreCtrl: TcxDBTextEdit;
    NroRegistroCtrl: TcxDBIntegerEdit;
    FechaDocumentoCtrl: TcxDBDateEdit;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label9: TcxLabel;
    capNroRegistroLabel: TcxLabel;
    Label13: TcxLabel;
    cxLabel2: TcxLabel;
    TipoFacturaCtrl: TcxDBIndexedComboBox;
    EjercicioFraRectificadaCtrl: TcxDBSpinEdit;
    SerieFraRectificadaCtrl: TcxDBTextEdit;
    cxLabel3: TcxLabel;
    Label14: TcxLabel;
    Label22: TcxLabel;
    EfectoPagarTableSerie: TWideStringField;
    InversionSujetoPasivoCtrl: TcxDBCheckBox;
    DataInversionSujetoPasivo: TBooleanField;
    TopGroupBox: TcxScrollBox;
    SumaBaseImponibleBox: TcxLabel;
    SumaCuotaIVABox: TcxLabel;
    SumaRetencionBox: TcxLabel;
    SumaImporteTotalBox: TcxLabel;
    PopupMenu: TdxBarPopupMenu;
    BarManager: TdxBarManager;
    EditarEccItem: TdxBarButton;
    AnotacionPagoItem: TdxBarButton;
    RelacionesPopupMenu: TdxBarPopupMenu;
    ProveedorItem: TdxBarButton;
    AsientoItem: TdxBarButton;
    cxSplitter1: TcxSplitter;
    cxGroupBox2: TcxGroupBox;
    BrowseAsientoTable: TnxeTable;
    FechaFraRectificadaBox: TcxLabel;
    BloquearPagoItem: TdxBarButton;
    EfectoPagarTableViewNroRemesa: TcxGridDBColumn;
    FiscalPageControl: TcxPageControl;
    FacturaRectificadaTS: TcxTabSheet;
    IntracomunitariaTS: TcxTabSheet;
    cxLabel12: TcxLabel;
    ClaveOperacionIntracomunitariaCtrl: TcxDBIndexedComboBox;
    MainTabControl: TcxTabControl;
    cxGroupBox1: TcxGroupBox;
    procedure FormManagerNoteRequest;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure GenerarEfectosButtonClick(Sender: TObject);
    procedure EditarEccItemClick(Sender: TObject);
    procedure AsientoItemClick(Sender: TObject);
    procedure ProveedorItemClick(Sender: TObject);
    procedure AsientoTableNewRecord(DataSet: TDataSet);
    procedure ApunteTableBeforePost(DataSet: TDataSet);
    procedure AsientoTableAfterDelete(DataSet: TDataSet);
    procedure ApunteTableGetRecord(DataSet: TDataSet);
    procedure AsientoTableSetKey(DataSet: TDataSet);
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure ApunteTableCalcFields(DataSet: TDataSet);
    procedure ApunteGridViewDataControllerSummaryAfterSummary(
      ASender: TcxDataSummary);
    procedure SucuentaPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SubcuentaPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure SubcuentaPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure TipoRetencionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EfectoPagarTableCalcFields(DataSet: TDataSet);
    procedure BaseRetencionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormaPagoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormaPagoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormaPagoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FacturaPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ApunteGridViewCentroCostePropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure ApunteGridViewCentroCostePropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ApunteGridViewCentroCostePropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure PropietarioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ApunteGridViewTipoPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure ApunteGridViewTipoPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ApunteGridViewTipoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TipoRetencionCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure TipoRetencionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ConceptoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ConceptoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ApunteTableFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure ApunteGridViewTipoPropertiesEditValueChanged(
      Sender: TObject);
    procedure ApunteGridViewBaseImponiblePropertiesEditValueChanged(
      Sender: TObject);
    procedure ApunteGridViewCuotaIVAPropertiesEditValueChanged(
      Sender: TObject);
    procedure TipoRetencionCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure BaseRetencionCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ImporteRetencionCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure ConceptoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ApunteTableNewRecord(DataSet: TDataSet);
    procedure ApunteGridViewFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure FormaPagoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure AnotacionPagoItemClick(Sender: TObject);
    procedure FormManagerActivateForm;
    procedure ApunteGridViewSubcuentaPropertiesEnter(
      Sender: TcxCustomEdit);
    procedure PropietarioCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure NombreCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure ConceptoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure BaseRetencionCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure TipoRetencionCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure FormaPagoCtrlPropertiesValuePosted(Sender: TObject);
    function AsientoTableCanEditRecord(Dataset: TDataSet): Boolean;
    function FormManagerCopyCurrentRecord: Boolean;
    procedure AsientoTableUpdateState(DataSet: TDataSet);
    procedure FormaPagoCtrlPropertiesDefaultValue(Sender: TcxCustomEdit);
    procedure NroRegistroCtrlPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    function FormManagerActivateRelatedDocsButton: Boolean;
    procedure AsientoMemDataSourceDataChange(Sender: TObject;
      Field: TField);
    procedure AsientoTableBeforeCancel(DataSet: TDataSet);
    procedure FechaDocumentoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure ApunteGridViewCuentaAnaliticaPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure ApunteGridViewCuentaAnaliticaPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ApunteGridViewCuentaAnaliticaPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure EfectoPagarTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure FormManagerFocusedAreaChanged;
    procedure TipoRetencionCtrlPropertiesValuePosted(Sender: TObject);
    procedure ApunteTableRemoteDelete(DataSet: TDataSet);
    procedure ApunteTableRemotePost(DataSet: TDataSet);
    procedure AsientoTableRemoteDelete(DataSet: TDataSet);
    procedure AsientoTableRemotePost(DataSet: TDataSet);
    procedure TipoRegimenPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure AsientoTableAfterEdit(DataSet: TDataSet);
    procedure AsientoTableAfterInsert(DataSet: TDataSet);
    procedure AsientoTableBeforePost(DataSet: TDataSet);
    procedure FraRectificadaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FraRectificadaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure EjercicioFraRectificadaCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure FacturaTableNewRecord(DataSet: TDataSet);
    function FormManagerDeleteButton: Boolean;
    procedure RegimenOTrascendenciaCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure InversionSujetoPasivoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure MainPageControlChange(Sender: TObject);
    procedure MainTabControlChange(Sender: TObject);
    procedure AsientoTableGetRecord(DataSet: TDataSet);
    procedure BloquearPagoItemClick(Sender: TObject);
    procedure FormManagerQueryGridRequest;
    procedure SerieNroFacturaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ApunteTableUpdateState(DataSet: TDataSet);
    procedure AsientoTableBeforeEdit(DataSet: TDataSet);
    procedure AsientoTableBeforeDelete(DataSet: TDataSet);
  private

    DataFieldValues : TFieldValuesArray;

    ActualizandoRegistro,
    CambiandoOrigen : Boolean;

    SumaBaseImponible,
    SumaCuotaIVA,
    SumaImporteTotal : Decimal;

    RecalculaLinea,
    RecalculaCuotaIVA,
    DatosProveedorDisponibles : Boolean;

    function  ActualizaTotalFactura : Decimal;
    procedure ActualizaMantenimientoAsientos;
    procedure MuestraTotalesFactura;
    procedure RecalculaImporteRetencion;
    procedure RecalculaImportesLinea( Force : Boolean = False );
    procedure MuestraEfectos;
    procedure GeneracionEfectos;
    procedure CompruebaGeneracionEfectos;
    procedure DoOnCopyCurrentRecord;
    procedure UpdatePageControlState;

    function GetAsientoFields : TAsientoFields;
    function GetApunteFields : TApunteFields;

    procedure OnFraRectificativaSelected( Target : TcxCustomEdit = nil );
    procedure RecalculaImportesTodasLasLineas;
    function ObtenRegistroFactura: Boolean;
    procedure ActualizaDatosRegistro;

  public

    FAsientoFields : TAsientoFields;
    FApunteFields : TApunteFields;
    ApunteConsultaFields : TApunteFields;
    FacturaFields : TFacturaFields;
    AsientoFacturaRectificadaFields : TAsientoFields;

    PaisFields : TPaisFields;
    EfectoPagarFields : TEfectoPagarFields;
    TiposRetencionFields,
    TiposIVAFields  : TTiposIVAFields;
    ProveedorFields : TProveedorFields;

    FEstadoPresentacion : TEstadoPresentacionSII;

    property AsientoFields : TAsientoFields read GetAsientoFields;
    property ApunteFields : TApunteFields read GetApunteFields;
  end;

var  MntFcgForm: TMntFcgForm = nil;

procedure MntFacturasRecibidas( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Variants,
       SysUtils,

       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm10Frm,

       b_msg,
       b_cfc,
       b_blp,
       bx_not,

       dmi_ast,
       dmi_fac,

       dm_pga,
       dm_pai,
       dm_sal,
       dm_iva,
       dm_sub,
       dm_ast,
       dm_fpa,
       dm_ecp,
       dm_fac,
       dm_cco,
       dm_con,
       dm_pro,
       dm_can,
       dm_rpf,

       cx_sub,
       cx_ret,
       cx_fpa,
       cx_fcg,
       cx_cco,
       cx_iva,
       cx_con,
       cx_can,

       a_ast,
       a_sub,
       a_ret,
       a_fpa,
       a_cco,
       a_ecp,
       a_iva,
       a_con,
       a_pro,
       a_ape,
       a_can,

       l_fcg;

resourceString
        RsMsg1  = 'Asiento nº %d.';
        RsMsg2  = 'S/Fra. Nº %s';
        // RsMsg3  = 'No ha especificado la forma de pago.';
        RsMsg4  = 'El importe sujeto a retención no puede ser superior %s de la factura.';
        RsMsg5  = 'al importe total';
        RsMsg6  = 'a la base imponible';
        RsMsg7  = 'La suma de la base imponible y la cuota de I.V.A. no coincide con el importe total.';
        RsMsg8  = '¿Esta seguro de que desea SUPRIMIR y volver a generar los efectos de esta factura?';
        RsMsg9  = 'Los apuntes con tipo de I.V.A. nulo deben tener, al menos, base imponible.';
        RsMsg10 = 'No puede utilizar la factura actual como factura rectificada.';
        RsMsg11 = 'Si modifica el origen de esta factura se tendrán que recalcular los importes totales de cada linea.';
        RsMsg12 = 'Si ha realizado ajustes manuales se perderán.'#13'¿Esta seguro de que desea realizar el cambio?';
        // RsMsg13 = 'No puede introducir apuntes sin ningún importe.';
        RsMsg14 = '¿Está seguro de que quiere rejustar el contador de números de registro?';
        RsMsg15 = 'Antes de realizar esta función debería asegurarse de que ningún otro usuario está editando el registro de facturas recibidas.';
        RsMsg16 = 'No se puede reiniciar el contador porque no se está editando el registro.';
        RsMsg17 = 'Reintente el proceso desde un registro editable.';
        RsMsg18 = 'No se han podido generar los efectos de la factura.';
        RsMsg19 = 'No se ha podido localizar la factura recién creada.';
        RsMsg20 = 'Esta factura consta como presentada';
        RsMsg21 = '¿Está seguro de que desea poder editarla?'#13'Si modifica el documento, los datos existentes en el registro de la Agencia Tributaria podrían diferir de los de su contabilidad.';
        RsMsg22 = 'No existe ninguna factura con esta serie y número en el ejercicio indicado.';

        RsMsg24 = 'No puede suprimir facturas que ya han sido suministradas.';
        RsMsg25 = 'No se ha encontrado el registro de la factura de este asiento.';
        RsMsg26 = 'Edite el registro y guárdelo para generar el registro correspondiente.';

procedure MntFacturasRecibidas( KeyValues : array of const );
begin
     CreateEditForm( TMntFcgForm, MntFcgForm, KeyValues, TGds10Frm.LibrosIVASection );
end;

procedure TMntFcgForm.FormManagerReportRequest;
begin
     ListadoFacturasRecibidas;
end;

procedure TMntFcgForm.FormaPagoCtrlPropertiesDefaultValue(Sender: TcxCustomEdit);
begin
     If   DatosProveedorDisponibles
     then FormaPagoCtrl.PostEditValue( ProveedorFields.Pago_FormaPago.Value );
end;

procedure TMntFcgForm.FormaPagoCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntFormasPago( [ Sender.EditingValue ] );
end;

procedure TMntFcgForm.GeneracionEfectos;

var Str : String;
    SinFormaPago : Boolean;

procedure CancelaProcesoGeneracion;
begin
     With FormaPagoCtrl do
       begin
       SetFocus;
       SelectAll;
       DataBinding.SetModified;  // Esto es para provocar la validación aunque el usuario no modifique el campo
       Abort;
       end;
end;

begin
     If   GenerarEfectosButton.Enabled
     then try

            AsientoTable.Edit;

            SinFormaPago := ValueIsEmpty( DataFormaPago.Value );

            If   EfectoPagar.ExistenEfectos( AsientoFields.Ejercicio.Value, AsientoFields.Propietario.Value, AsientoFields.Serie.Value, AsientoFields.NroFactura.Value )
            then begin
                 If   SinFormaPago
                 then Str := ''
                 else Str := 'y volver a generar ';
                 If   ShowNotification( ntQuestionWarning, Format( RsMsg8, [ Str ] ), '' )<>mrYes
                 then CancelaProcesoGeneracion;
                 end;

            If   EfectoPagar.CompruebaEfectos( AsientoFields.Ejercicio.Value, AsientoFields.Propietario.Value, AsientoFields.Serie.Value )
            then begin

                 If   SinFormaPago
                 then EfectoPagar.SuprimeEfectosFactura( AsientoFields.Ejercicio.Value, AsientoFields.Propietario.Value, AsientoFields.Serie.Value )
                 else If   not EfectoPagar.GeneraEfectos( AsientoFields.NroAsiento.Value, AsientoFields.Propietario.Value, DataFormaPago.Value, ActualizaTotalFactura )
                      then CancelaProcesoGeneracion;

                 EfectoPagarTable.Refresh;
                 EfectoPagarGrid.SetFocus;

                 end;

          except on E : Exception do
            If   E is EAbort
            then raise
            else begin
                 ShowNotification( ntStop, RsMsg18 );
                 CancelaProcesoGeneracion;
                 end;
          end;
end;

procedure TMntFcgForm.FormaPagoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With FormaPagoCtrl do
       If   ValueIsEmpty( EditValue ) and DatosProveedorDisponibles and AsientoTable.Inserting
       then begin
            CompruebaGeneracionEfectos;
            EditValue := ProveedorFields.Pago_FormaPago.Value;
            end;
end;

procedure TMntFcgForm.FormaPagoCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaFormasPago( Sender );
end;

procedure TMntFcgForm.CompruebaGeneracionEfectos;
begin
     GenerarEfectosButton.Enabled := not ValueIsEmpty( PropietarioCtrl.EditValue ) and ( ActualizaTotalFactura<>0.0 );
end;

procedure TMntFcgForm.FormaPagoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GenerarEfectosButton.Enabled := False;
     If   ValueIsEmpty( DisplayValue )
     then FormaPagoCtrl.ClearDescription
     else begin
          FormaPago.Valida( Sender, DisplayValue, ErrorText, Error );
          If   not Error
          then CompruebaGeneracionEfectos;
          end;
end;

procedure TMntFcgForm.FormaPagoCtrlPropertiesValuePosted(Sender: TObject);
begin
     GeneracionEfectos;
end;

procedure TMntFcgForm.FormManagerActivateForm;
begin
     If   not FormManager.Cancelling
     then EfectoPagarTable.Refresh;
end;

function TMntFcgForm.FormManagerActivateRelatedDocsButton: Boolean;
begin
     Result := ( AsientoTable.State=dsBrowse ) and not ( ( AsientoFields.Serie.Value='' ) and ValueIsEmpty( AsientoFields.NroFactura.Value ) );
end;

function TMntFcgForm.FormManagerCopyCurrentRecord: Boolean;
begin
     With AsientoFields do
       CopiaFacturaRecibida( Propietario.Value, Serie.Value, DoOnCopyCurrentRecord );
     Result := False;
end;

function TMntFcgForm.FormManagerDeleteButton: Boolean;
begin
     Result := True;
     If   FEstadoPresentacion<>erpPendiente
     then begin
          ShowNotification( ntStop, RsMsg24 );
          Abort;
          end;
end;

procedure TMntFcgForm.FormManagerFocusedAreaChanged;
begin
     If   FormManager.DataAreaFocused
     then FormaPagoCtrl.Properties.Required := ( ApplicationContainer.Ejercicio>=2014 ) and ( ProveedorFields.Factura_RegimenEspecialCC.Value or DataModule00.DmEmpresaFields.RegimenEspecialCriterioCaja.Value );
end;

procedure TMntFcgForm.DoOnCopyCurrentRecord;

var  CodigoPropietario,
     SerieNroFactura : String;
     Suprimir : Boolean;

begin
     CodigoPropietario := BoxCfcForm.DataCodigoPropietario.Value;
     SerieNroFactura := BoxCfcForm.DataSerieNroFactura.Value;
     Suprimir := BoxCfcForm.DataSuprimir.Value;

     EfectoPagar.CopiaFacturaRecibida( AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, CodigoPropietario, SerieNroFactura, Suprimir );
     // TipoAsiento;Ejercicio;Propietario;Serie;NroFactura;NroEfecto
     If   AsientoTable.FindKey( [ taFraRecibida, ApplicationContainer.Ejercicio, CodigoPropietario, SerieNroFactura, 0, NroEfectoRegistroFactura ] )
     then FormManager.SelectFirstKeyControl
     else begin
          ShowNotification( ntStop, RsMsg19 );
          AsientoTable.Cancel;
          end;

end;

procedure TMntFcgForm.FormManagerInitializeForm;
begin

     ID := idMntFcgForm;

     ApunteConsultaFields := TApunteFields.Create( ApunteConsultaTable );
     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );
     FacturaFields := TFacturaFields.Create( FacturaTable );

     SetFieldRange( AsientoFields.NroFactura, 0 );
     SetFieldRange( FacturaFields.NroFacturaRectificada, 0 );

     PaisFields := TPaisFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Proveedor.DmProveedorTable, True );
     TiposIVAFields := TTiposIVAFields.Create( Self );
     TiposRetencionFields := TTiposIVAFields.Create( Self );
     AsientoFacturaRectificadaFields := TAsientoFields.Create( Self );

     NroRegistroCtrl.Enabled := DataModule00.DmEmpresaFields.Contable_NroRegistro.Value;

     //** 05.10.2009 Evitando que los usuarios normales puedan reiniciar el contador del número de registro

     If   not UsuarioMaestro
     then begin
          NroRegistroCtrl.Hint := '';
          NroRegistroCtrl.Properties.OnExtendedFunction := nil;
          end;

     AsientoFields.Serie.ValidChars := SerieNroFacturaCharSet;

     ApunteGridViewCentroCoste.Visible := DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;

     SetColumnsDecimals( [ ApunteGridViewBaseImponible, ApunteGridViewCuotaIVA, ApunteGridViewImporteTotal ] );
     SetColumnDecimals( EfectoPagarTableViewImporte );

     SetEditControlsDecimals( [ BaseRetencionCtrl, ImporteRetencionCtrl ] );

     SetBarItemsVisible( [ BloquearPagoItem ], ApplicationContainer.IsModuleActive( [ 118 ] ) and DataModule00.UserIsACreditManager );

     Data.Active := True;

     //* 02.08.2004  Compruebo si el ejercicio está cerrado

     Asiento.CompruebaEjercicioCerrado( { EditarAsiento } True );

     BrowseAsientoTable.SetRange( [ taFraRecibida, ApplicationContainer.FirstDayOfYearDate ],
                                  [ taFraRecibida, ApplicationContainer.LastDayOfYearDate ] );

end;

procedure TMntFcgForm.AnotacionPagoItemClick(Sender: TObject);
begin
     With AsientoFields do
       MntAnotacionPagoEfectos( [ Ejercicio.Value,
                                  Propietario.Value,
                                  Serie.Value,
                                  NroFactura.Value,
                                  EfectoPagarFields.NroEfecto.Value ] );
end;

procedure TMntFcgForm.ApunteGridViewBaseImponiblePropertiesEditValueChanged(Sender: TObject);
begin
     RecalculaLinea := ApunteGridViewBaseImponible.Editing;
     RecalculaCuotaIVA := True;
end;

procedure TMntFcgForm.ApunteGridViewCentroCostePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCentrosCoste( [ Sender.EditingValue ] );
end;

procedure TMntFcgForm.ApunteGridViewCentroCostePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TMntFcgForm.ApunteGridViewCentroCostePropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntFcgForm.ApunteGridViewCuentaAnaliticaPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntCuentaAnalitica( [ ApunteFields.CentroCoste.Value,  Sender.EditingValue ] );
end;

procedure TMntFcgForm.ApunteGridViewCuentaAnaliticaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentasAnaliticas( Sender, ApunteFields.CentroCoste );
end;

procedure TMntFcgForm.ApunteGridViewCuentaAnaliticaPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CuentaAnalitica.Valida( ApunteFields.CentroCoste.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntFcgForm.ApunteGridViewCuotaIVAPropertiesEditValueChanged(Sender: TObject);
begin
     RecalculaLinea := ApunteGridViewCuotaIVA.Editing;
end;

procedure TMntFcgForm.ApunteGridViewDataControllerSummaryAfterSummary( ASender: TcxDataSummary);
begin

     With ASender do
       If   VarIsNull( FooterSummaryValues[ 0 ] )
       then begin
            SumaBaseImponible := 0.0;
            SumaCuotaIVA := 0.0;
            SumaImporteTotal := 0.0;
            end
       else begin
            SumaBaseImponible := FooterSummaryValues[ 0 ];
            SumaCuotaIVA := FooterSummaryValues[ 1 ];
            SumaImporteTotal := FooterSummaryValues[ 2 ];
            end;

     MuestraTotalesFactura;
end;

procedure TMntFcgForm.ApunteGridViewFocusedItemChanged(Sender: TcxCustomGridTableView; APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
begin
     If   ApunteGridView.DataController.IsEditing
     then RecalculaImportesLinea;
end;

procedure TMntFcgForm.ApunteGridViewSubcuentaPropertiesEnter(Sender: TcxCustomEdit);
begin
     With ApunteGridViewSubcuenta do
       If   ValueIsEmpty( EditValue ) and ( ApunteTable.RecordCount=0 )
       then If   ValueIsEmpty( ProveedorFields.Factura_CtaCompras.Value )
            then EditValue := '6'
            else EditValue := ProveedorFields.Factura_CtaCompras.Value;
end;

procedure TMntFcgForm.FacturaPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaFrasRecibidas( AsientoFields.Propietario, Sender, qgsLinked );
end;

procedure TMntFcgForm.FacturaTableNewRecord(DataSet: TDataSet);

var  CodigoPais : String;
     ModeloIVA : TModeloIVAProveedor;
begin

     // Los registros de factura, en la sección contable, se vinculan utilizando el número de asiento

     If   Assigned( FacturaFields ) and not AsientoFields.NroAsiento.IsNull
     then With FacturaFields do
            begin
            Tipo.Value := tfAsiento;
            Ejercicio.Value := AsientoFields.Ejercicio.Value;
            NroRegistro.Value := AsientoFields.NroAsiento.Value;

            If   DatosProveedorDisponibles
            then begin
                 CodigoPais := ProveedorFields.CodigoPais.Value;
                 ModeloIVA := ProveedorFields.Factura_ModeloIVA.Value;
                 end
            else begin
                 CodigoPais := CodigoEspaña;
                 ModeloIVA := mipNormal;
                 end;

            Factura.CompletaRegistroFacturaRecibida( ProveedorFields.Subcuenta.Value, CodigoPais, ModeloIVA, FacturaFields );

            end;
end;

procedure TMntFcgForm.UpdatePageControlState;

var  FacturaRectificativa,
     Intracomunitaria,
     MostrarInformacionFiscal : Boolean;

procedure SetupTabSheet( TabSheet : TcxTabSheet; Visible : Boolean );
begin
     TabSheet.TabVisible := Visible;
     TabSheet.Enabled := Visible;
     If   Visible
     then FiscalPageControl.ActivePage := TabSheet;
end;

begin
     FacturaRectificativa := TipoFacturaCtrl.ItemIndex in [ tfrRectificativa_80_1_2..tfrRectificativaSimplificada ];  // Facturas rectificativas
     Intracomunitaria := DataModule00.Exportacion and ( AsientoFields.Origen.Value=ofrIntracomunitaria );
     MostrarInformacionFiscal := FacturaRectificativa or Intracomunitaria;
     MainTabControl.HideTabs := not MostrarInformacionFiscal;

     SetupTabSheet( FacturaRectificadaTS, FacturaRectificativa );
     SetupTabSheet( IntracomunitariaTS, Intracomunitaria );

     FiscalTS.Enabled := MostrarInformacionFiscal;                        // Si no se desactiva se intentará validar
     If   not FiscalTS.Enabled
     then MainPageControl.ActivePage := ContenidoTS;
end;

procedure TMntFcgForm.FechaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   Sender.Editing
     then begin
          ValidateYear( DisplayValue, ErrorText, Error );
          If   not Error
          then Asiento.CompruebaTrimestre( DisplayValue, ErrorText, Error );
          end;
end;

procedure TMntFcgForm.FechaDocumentoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   Sender.Editing
     then begin
          ValidateYear( DisplayValue, ErrorText, Error, True );
          If   not Error and ( AsientoTable.State=dsEdit )
          then Tasa.CompruebaCambioTipoImpositivo( siSoportado, DisplayValue, AsientoFields.FechaDocumento.Value, ErrorText, Error );
          end;
end;

procedure TMntFcgForm.SerieNroFacturaCtrlPropertiesValidate( Sender : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean );
begin
     // Parece ser que el SII se lia un poco si pones espacios (y alguien los ha puesto, claro). Solo se podía con Ctrl+Ins.
     If   SerieNroFacturaCtrl.Editing
     then DisplayValue := Factura.SerieNroFacturaValidoSII( DisplayValue );
end;

procedure TMntFcgForm.SubcuentaPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntFcgForm.SubcuentaPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntFcgForm.ApunteGridViewTipoPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTiposIVA( True );
end;

procedure TMntFcgForm.ApunteGridViewTipoPropertiesEditValueChanged(Sender: TObject);
begin
     RecalculaLinea := ApunteGridViewTipo.Editing;
     RecalculaCuotaIVA := True;
end;

procedure TMntFcgForm.ApunteGridViewTipoPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaTiposIVA( Sender, siSoportado, AsientoFields.Fecha.Value );
end;

procedure TMntFcgForm.ApunteGridViewTipoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Tasa.ValidaTasa( Sender, DisplayValue, ErrorText, Error, siSoportado, AsientoFields.FechaDocumento.Value );

     If   Assigned( Sender ) and Sender.EditModified
     then begin
          If   DatosProveedorDisponibles and ( ProveedorFields.Factura_ModeloIVA.Value in [ mipTipoFijo, mipRegimenEspecial ] )   // Tipo fijo de I.V.A.
          then DisplayValue := ProveedorFields.Factura_TipoFijoIVA.Value;

          If   ValueIsEmpty( DisplayValue )
          then If   ValueIsEmpty( ApunteTableBaseImponible.Value )
               then begin
                    Error := True;
                    ErrorText := RsMsg9;
                    end;
          end;
end;

procedure TMntFcgForm.ApunteTableBeforePost(DataSet: TDataSet);

var   SumaTotal : Decimal;

begin
     If   not ( not ApunteGridView.DataController.InCheckBrowseMode and ApunteTable.ControlsDisabled )
     then With ApunteFields do
            begin

            If   Tipo.Value=0
            then ImporteTotal.Value := BaseImponible.Value
            else If   ( BaseImponible.Value=0.0 ) and
                      ( CuotaIVA.Value=0.0 )      and
                      ( ImporteTotal.Value<>0.0 )
                 then begin
                      Tasa.TipoIVA( AsientoFields.FechaDocumento.Value, Tipo.Value, TiposIVAFields );
                      BaseImponible.Value := ImporteTotal.Value / ( 1 + ( TiposIVAFields.IVASoportado.Value / 100.0 ) );
                      CuotaIVA.Value := Redondea( ( BaseImponible.Value * TiposIVAFields.IVASoportado.Value ) / 100.0 );
                      BaseImponible.Value := ImporteTotal.Value - CuotaIVA.Value;
                      end;

            If   AsientoFields.Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ]
            then ImporteTotal.Value := BaseImponible.Value
            else begin
                 SumaTotal := Redondea( BaseImponible.Value + CuotaIVA.Value );
                 If   SumaTotal<>ImporteTotal.Value
                 then begin
                      ShowNotification( ntStop, RsMsg7, '' );
                      Abort;
                      end;
                 end;

            {
            If   ImporteTotal.Value=0.0
            then begin
                 ShowNotification( ntStop, RsMsg13, '' );
                 Abort;
                 end;
            }

            Contrapartida.Value := AsientoFields.Propietario.Value;

            SetSignedValue( Debe, Haber, BaseImponible.Value );
            end;

end;

procedure TMntFcgForm.ApunteTableCalcFields(DataSet: TDataSet);
begin
     If   Assigned( TiposIVAFields ) and ApunteDataSource.Enabled
     then begin
          If   ValueIsEmpty( ApunteTableSubcuenta.Value )
          then ApunteTableDescripcion.Clear
          else ApunteTableDescripcion.Value := Cuenta.Descripcion( ApunteTableSubcuenta.Value, True, False );
          Tasa.TipoIVA( AsientoFields.FechaDocumento.Value, ApunteTableTipo.Value, TiposIVAFields );
          ApunteTableTipoIVA.Value := TiposIVAFields.IVASoportado.Value;
          end;
end;

procedure TMntFcgForm.ApunteTableFilterRecord( DataSet: TDataSet; var Accept: Boolean);
begin
     Accept := ( ApunteTableNroApunte.Value>1 ) and ( ApunteTableTipoApunte.Value=tapManual );
end;

procedure TMntFcgForm.ApunteTableGetRecord(DataSet: TDataSet);
begin
     If   Assigned( ApunteFields )
     then With ApunteFields do
            Tasa.TipoIVA( AsientoFields.FechaDocumento.Value, Tipo.Value, TiposIVAFields );
end;

procedure TMntFcgForm.ApunteTableNewRecord( DataSet : TDataSet );
begin
     With ApunteFields do
       begin
       Ejercicio.Value := AsientoFields.Ejercicio.Value;
       NroAsiento.Value := AsientoFields.NroAsiento.Value;
       Fecha.Value := AsientoFields.Fecha.Value;
       TipoApunte.Value := tapManual;

       With Tipo do
         If   DatosProveedorDisponibles
         then case ProveedorFields.Factura_ModeloIVA.Value of
                mipExento          : Value := 0;  // Exento de I.V.A.
                mipNormal          : Value := Tasa.TipoIVAGlobal( Fecha.Value, rgTipoIVAManual );
                mipTipoFijo,
                mipRegimenEspecial : Value := ProveedorFields.Factura_TipoFijoIVA.Value;
                end
         else Value := 1;
       end;
end;

procedure TMntFcgForm.ActualizaMantenimientoAsientos;
begin
     If   not AsientoTable.DeletingMasterRecord
     then With AsientoFields do
            ActualizaMntAsientos( [ Ejercicio.Value, NroAsiento.Value ] );
end;

procedure TMntFcgForm.ApunteTableRemoteDelete(DataSet: TDataSet);
begin
     Asiento.SuprimeApunteFactura( AsientoFields, ApunteFields );
     ActualizaMantenimientoAsientos;
end;

procedure TMntFcgForm.ApunteTableRemotePost(DataSet: TDataSet);
begin
     Asiento.ActualizaApunteFactura( AsientoFields, ApunteFields );
     ActualizaMantenimientoAsientos;
end;

procedure TMntFcgForm.ApunteTableUpdateState(DataSet: TDataSet);
begin
     If   FormManager.FormInitialized and ApunteTable.Active
     then begin
          var ExistenApuntes := ApunteTable.RecordCount>0;
          RetencionesTabSheet.Enabled := ExistenApuntes;
          PagosTabSheet.Enabled := ExistenApuntes;
          end;
end;

function TMntFcgForm.ActualizaTotalFactura : Decimal;
begin
     If   DataBaseRetencion.Value=0.0         // Es una factura con retención vieja
     then Result := SumaImporteTotal
     else Result := SumaImporteTotal - DataImporteRetencion.Value;

     SumaImporteTotalBox.Caption := StrFormat( Result );
end;

procedure TMntFcgForm.MuestraTotalesFactura;
begin
     SumaBaseImponibleBox.Caption := StrFormat( SumaBaseImponible );
     SumaCuotaIVABox.Caption := StrFormat( SumaCuotaIVA );
     SumaRetencionBox.Caption := StrFormat( -DataImporteRetencion.Value );

     ActualizaTotalFactura;
end;

procedure TMntFcgForm.NombreCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With NombreCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := DescPropietarioLabel.Caption;
end;

procedure TMntFcgForm.FraRectificadaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFrasRecibidas( nil, Sender, qgsNormal, OnFraRectificativaSelected );
end;

procedure TMntFcgForm.FraRectificadaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Ejercicio : SmallInt;
     Propietario,
     Serie : String;

begin

     If   Assigned( FacturaFields ) and
          ( EjercicioFraRectificadaCtrl.Editing or SerieFraRectificadaCtrl.Editing )
     then begin

          FechaFraRectificadaBox.Caption := '';

          Propietario := AsientoFields.Propietario.Value;
          Ejercicio := FacturaFields.EjercicioFraRectificada.Value;
          Serie := FacturaFields.SerieFraRectificada.Value;

          If   Sender=EjercicioFraRectificadaCtrl
          then Ejercicio :=  VarToSmallInt( DisplayValue )
          else If   Sender=SerieFraRectificadaCtrl
               then Serie := VarToStr( DisplayValue );

          If   Serie=''    // No es un valor obligatorio
          then Exit;

          Error := False;
          If    ( Ejercicio=AsientoFields.Ejercicio.Value ) and
                ( Serie=AsientoFields.Serie.Value )
          then begin
               Error := True;
               ErrorText := RsMsg10;
               end
          else If   Asiento.ObtenDocumento( taFraRecibida, Ejercicio, Propietario, Serie, 0, NroEfectoRegistroFactura, AsientoFacturaRectificadaFields )
               then begin
                    FechaFraRectificadaBox.Caption := StrFormatDate( AsientoFacturaRectificadaFields.Fecha.Value, dfDefault2 );
                    EjercicioFraRectificadaCtrl.IsEditValidated := True;
                    SerieFraRectificadaCtrl.IsEditValidated := True;
                    end
               else begin
                    Error := True;
                    ErrorText := RsMsg22;
                    end;
          end;
end;

procedure TMntFcgForm.OnFraRectificativaSelected( Target : TcxCustomEdit = nil );
begin
     With CxFcgForm do
       begin
       EjercicioFraRectificadaCtrl.PostEditValue( QueryEjercicio.Value );
       SerieFraRectificadaCtrl.PostEditValue( QuerySerie.Value );
       end;
end;

procedure TMntFcgForm.NroRegistroCtrlPropertiesExtendedFunction(Sender: TcxCustomEdit);
begin
     If   not AsientoTable.Editing
     then ShowNotification( ntStop, RsMsg16, RsMsg17 )
     else If   ShowNotification( ntQuestionWarning, RsMsg14, RsMsg15 )=mrYes
          then AsientoFields.NroRegistro.Value := Asiento.ProximoNroRegistro( taFraRecibida, True );     //..
end;

procedure TMntFcgForm.RecalculaImporteRetencion;
begin
     If   Assigned( TiposRetencionFields )
     then DataImporteRetencion.Value := Redondea( ( DataBaseRetencion.Value * TiposRetencionFields.Retencion.Value  ) / 100.0 );
     MuestraTotalesFactura;
end;

procedure TMntFcgForm.SucuentaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True );
end;

procedure TMntFcgForm.TipoRegimenPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
          UpdatePageControlState;
end;

procedure TMntFcgForm.TipoRetencionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntRetenciones( True );
end;

procedure TMntFcgForm.TipoRetencionCtrlPropertiesEditValueChanged(Sender: TObject);

var  ValorNulo : Boolean;

begin
     With TipoRetencionCtrl do
       begin

       ValorNulo := ValueIsEmpty( EditValue, varSmallInt );

       SubcuentaRetencionCtrl.Enabled := not ValorNulo;
       BaseRetencionCtrl.Enabled := not ValorNulo;
       ImporteRetencionCtrl.Enabled := not ValorNulo;

       If   Editing and ValorNulo
       then begin
            DataBaseRetencion.Clear;
            SubcuentaRetencionCtrl.Clear;
            DataImporteRetencion.Clear;
            end;

       end;

end;

procedure TMntFcgForm.TipoRetencionCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With TipoRetencionCtrl do
       If   ValueIsEmpty( EditValue ) and DatosProveedorDisponibles
       then EditValue := ProveedorFields.Factura_TipoRet.Value;
end;

procedure TMntFcgForm.TipoRetencionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRetenciones( AsientoFields.FechaDocumento.Value, Sender );
end;

procedure TMntFcgForm.TipoRetencionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Tasa.ValidaRetencion( AsientoFields.FechaDocumento.Value, Sender, DisplayValue, ErrorText, Error, TiposRetencionFields );
end;

procedure TMntFcgForm.TipoRetencionCtrlPropertiesValuePosted(Sender: TObject);

var  Subcuenta : String;

begin
     With TipoRetencionCtrl do
       begin

       If   ValueIsEmpty( EditValue, varSmallInt )
       then begin
            DataBaseRetencion.Clear;
            SubcuentaRetencionCtrl.Clear;
            DataImporteRetencion.Clear;
            end
       else begin

            With TiposRetencionFields do
              begin

              If   CtaRetACuenta.Value=''
              then CtaRetACuenta.Value := CodigoCuentaDefecto( cpCtaRetACuenta );

              If   Desglosar.Value
              then begin
                   Subcuenta := Copy( CtaRetACuenta.Value, 1, 4 ) + Copy( AsientoFields.Propietario.Value, 5, 5 );
                   Cuenta.InsertaSubcuenta( Subcuenta, AsientoFields.Nombre.Value );
                   end
              else Subcuenta := CtaRetACuenta.Value;

              SubcuentaRetencionCtrl.PostEditValue( Subcuenta );

              end;

            If   TiposRetencionFields.SobreTotal.Value
            then DataBaseRetencion.Value := SumaImporteTotal
            else DataBaseRetencion.Value := SumaBaseImponible;

            end;

       RecalculaImporteRetencion;

       ResetTab;

       end;

end;

procedure TMntFcgForm.LockRangeButtonLockRange( var KeyValues: TFieldValuesArray);
begin
     With AsientoTable do
       begin

       // KeyValues : TipoAsiento;Ejercicio;Propietario;Serie;NroFactura;NroEfecto

       KeyValues[ 0 ] := taFraRecibida;
       KeyValues[ 1 ] := ApplicationContainer.Ejercicio;

       If   not LockRangeButton.Down
       then KeyValues[ 2 ] := UnAssigned; // Propietario

       KeyValues[ 3 ] := UnAssigned; // Serie
       KeyValues[ 4 ] := UnAssigned; // NroFactura
       KeyValues[ 5 ] := NroEfectoRegistroFactura;
       end;
end;

procedure TMntFcgForm.GenerarEfectosButtonClick(Sender: TObject);
begin
     GeneracionEfectos;
end;

function TMntFcgForm.GetApunteFields: TApunteFields;
begin
     If   not Assigned( FApunteFields )
     then FApunteFields := TApunteFields.Create( ApunteTable );
     Result := FApunteFields;
end;

function TMntFcgForm.GetAsientoFields: TAsientoFields;
begin
     If   not Assigned( FAsientoFields )
     then FAsientoFields := TAsientoFields.Create( AsientoTable );
     Result := FAsientoFields;
end;

procedure TMntFcgForm.EfectoPagarTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     MuestraEfectos;
end;

procedure TMntFcgForm.EjercicioFraRectificadaCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With EjercicioFraRectificadaCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := ApplicationContainer.Ejercicio;
end;

procedure TMntFcgForm.ImporteRetencionCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ImporteRetencionCtrl.Editing
     then MuestraTotalesFactura;
end;

procedure TMntFcgForm.InversionSujetoPasivoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   not CambiandoOrigen and
          AsientoTable.Editing and
          InversionSujetoPasivoCtrl.Editing
     then try
            CambiandoOrigen := True;
            var ModificandoRegistro := AsientoTable.State=dsEdit;
            If   ModificandoRegistro and ( ShowNotification( ntQuestionWarning, RsMsg11, RsMsg12 )<>mrYes )
            then With DataInversionSujetoPasivo do
                   begin
                   Value := OldValue;
                   InversionSujetoPasivoCtrl.Refresh;
                   end
            else begin
                 If   InversionSujetoPasivoCtrl.Checked
                 then begin
                      AsientoFields.Origen.Value := ofrInversionSP;
                      If   FacturaFields.RegimenOtrascendencia.Value=8       // Adquisiciones intracomunitarias de bienes y prestaciones de servicios
                      then FacturaFields.RegimenOtrascendencia.Value := 0;
                      end
                 else AsientoFields.Origen.Value := ofrSujetoPasivo;
                 If   ModificandoRegistro
                 then RecalculaImportesTodasLasLineas;
                 end;
          finally
            CambiandoOrigen := False;
            end;
end;

procedure TMntFcgForm.RecalculaImportesTodasLasLineas;
begin
     With ApunteTable do
       try
         DisableControls;
         First;
         While not Eof do
           begin
           Edit;
           RecalculaImportesLinea( True );
           Post;
           Next;
           end;
       finally
         AsientoTable.Update;
         EnableControls;
         end;
end;

procedure TMntFcgForm.RegimenOTrascendenciaCtrlPropertiesEditValueChanged(Sender: TObject);

var  NuevoOrigen : SmallInt;

begin
     If   not CambiandoOrigen
     then If   AsientoTable.Editing // and RegimenOTrascendenciaCtrl.Editing
          then begin
               CambiandoOrigen := True;
               try
                 If   RegimenOTrascendenciaCtrl.ItemIndex=8        // Adquisiciones intracomunitarias de bienes y prestaciones de servicios
                 then NuevoOrigen := ofrIntracomunitaria
                 else If   DataInversionSujetoPasivo.Value
                      then NuevoOrigen := ofrInversionSP
                      else NuevoOrigen := ofrSujetoPasivo;
                 If   NuevoOrigen<>AsientoFields.Origen.Value
                 then If   ( AsientoTable.State=dsEdit ) and
                           ( ShowNotification( ntQuestionWarning, RsMsg11, RsMsg12 )<>mrYes )
                      then With FacturaFields.RegimenOTrascendencia do
                             begin
                             Value := OldValue;
                             RegimenOTrascendenciaCtrl.Refresh;
                             end
                      else begin
                           AsientoFields.Origen.Value := NuevoOrigen;
                           DataInversionSujetoPasivo.Value := NuevoOrigen=ofrInversionSP;
                           If   AsientoTable.State=dsEdit
                           then RecalculaImportesTodasLasLineas;
                           UpdatePageControlState;
                           end;
               finally
                 CambiandoOrigen := False;
                 end;
               end;
end;

procedure TMntFcgForm.RecalculaImportesLinea( Force : Boolean );
begin
     With ApunteFields do
       If   RecalculaLinea or CambiandoOrigen
       then begin

            If   RecalculaCuotaIVA
            then If   Tipo.Value=0
                 then CuotaIVA.Value := 0.0
                 else begin
                      Tasa.TipoIVA( AsientoFields.FechaDocumento.Value, Tipo.Value, TiposIVAFields );
                      CuotaIVA.Value := Redondea( ( BaseImponible.Value * TiposIVAFields.IVASoportado.Value ) / 100.0 );
                      end;

            With ImporteTotal do
              If   AsientoFields.Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ]
              then Value := BaseImponible.Value
              else Value := Redondea( BaseImponible.Value + CuotaIVA.Value );

            ApunteTable.Modified := True;

            RecalculaLinea := False;
            RecalculaCuotaIVA := False;
            end;
end;

procedure TMntFcgForm.EditarEccItemClick(Sender: TObject);
begin
     MuestraEfectos;
end;

procedure TMntFcgForm.MainPageControlChange(Sender: TObject);
begin
     MainTabControl.TabIndex := MainPageControl.ActivePageIndex;
end;

procedure TMntFcgForm.MainTabControlChange(Sender: TObject);
begin
     MainPageControl.ActivePageIndex := MainTabControl.TabIndex;
end;

procedure TMntFcgForm.MuestraEfectos;
begin
     With AsientoFields do
       MntEfectosPagar( [ Ejercicio.Value, Propietario.Value, Serie.Value, NroFactura.Value, EfectoPagarFields.NroEfecto.Value ] );
end;

procedure TMntFcgForm.EfectoPagarTableCalcFields(DataSet: TDataSet);
begin
     EfectoPagarTableDescripcion.Value := Cuenta.Descripcion( EfectoPagarTableEntidad.Value, True, False );
end;

procedure TMntFcgForm.AsientoItemClick(Sender: TObject);
begin
     With AsientoFields do
       MntAsientos( [ Ejercicio.Value, NroAsiento.Value ] );
end;

procedure TMntFcgForm.AsientoMemDataSourceDataChange(Sender: TObject; Field: TField);
begin
     With AsientoTable do
       If   not ActualizandoRegistro and ( State=dsEdit )
       then Modified := True;
end;

procedure TMntFcgForm.AsientoTableAfterDelete(DataSet: TDataSet);
begin
     ActualizaMntAsientos( [ ApplicationContainer.Ejercicio, 0 ] );
end;

procedure TMntFcgForm.AsientoTableAfterEdit(DataSet: TDataSet);
begin

     //** 27.04.2017 Antes no existía el registro de factura, por lo que debo comprobar si se ha conseguido recuperar antes de intentar editarlo

     If   ObtenRegistroFactura
     then FacturaTable.Edit
     else begin
          FacturaTable.Append;       // El registro de factura no existe, aunque el asiento ya había sido creado : hay que generar un registro sobre la marcha
          FacturaTable.PostAndEdit;
          end;

end;

function TMntFcgForm.ObtenRegistroFactura : Boolean;
begin
     Result := FacturaTable.FindKey( [ tfAsiento, AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value ] );
end;

procedure TMntFcgForm.AsientoTableAfterInsert(DataSet: TDataSet);
begin
     With FacturaTable do
       begin
       Append;
       Edit;
       end;
end;

procedure TMntFcgForm.AsientoTableBeforeCancel(DataSet: TDataSet);
begin
     SetRecordFieldValues( Data, DataFieldValues );
end;

procedure TMntFcgForm.AsientoTableBeforeDelete(DataSet: TDataSet);
begin
     If   FEstadoPresentacion=erpPendiente
     then RegistroPresentacion.SuprimeRegistroPresentacion( rpFacturaRecibida, AsientoFields.Propietario.Value, AsientoFields.Serie.Value, AsientoFields.NroFactura.Value );
end;

procedure TMntFcgForm.AsientoTableBeforeEdit(DataSet: TDataSet);
begin
     If   not AsientoTable.SettingKey and ( FEstadoPresentacion<>erpPendiente )
     then If   ShowNotification( ntQuestionWarning, RsMsg20, RsMsg21 )<>mrYes
          then Abort;
end;

procedure TMntFcgForm.AsientoTableBeforePost(DataSet: TDataSet);
begin
     FacturaTable.Post;
     If   FEstadoPresentacion<>erpPendiente
     then RegistroPresentacion.MarcaComoModificadoRegistroPresentacion( rpFacturaRecibida, AsientoFields.Propietario.Value, AsientoFields.Serie.Value, AsientoFields.NroFactura.Value );
end;

function TMntFcgForm.AsientoTableCanEditRecord(Dataset: TDataSet): Boolean;
begin
     Result := EjercicioActual( AsientoFields.Fecha.Value );
end;

procedure TMntFcgForm.AsientoTableGetRecord(DataSet: TDataSet);
begin
     If   AsientoFields.TipoAsiento.Value=taFraRecibida
     then begin
          FEstadoPresentacion := RegistroPresentacion.ObtenEstadoPresentacionSii( rpFacturaRecibida, AsientoFields.Propietario.Value, AsientoFields.Serie.Value, AsientoFields.NroFactura.Value );
          ActualizaDatosRegistro;
          If   ( AsientoTable.State=dsBrowse ) and
               not FormManager.FocusingDataPanel and
               not FormManager.EnablingDatasources and
               not AsientoFields.NroAsiento.IsNull
          then If   not ObtenRegistroFactura
               then ShowNotification( ntWarning, RsMsg25, RsMsg26 );
          end;
end;

procedure TMntFcgForm.AsientoTableNewRecord(DataSet: TDataSet);
begin

     With AsientoFields do
       begin
       NroAsiento.Value := Asiento.ProximoNroAsiento;
       NroFactura.Value := 0;
       Fecha.Value := ApplicationContainer.TodayDate;
       FechaDocumento.Value := ApplicationContainer.TodayDate;
       NroRegistro.Value := Asiento.ProximoNroRegistro( taFraRecibida );
       If   DatosProveedorDisponibles
       then Origen.Value := ProveedorFields.Origen.Value
       else Origen.Value := ofrSujetoPasivo;
       end;

     DataConcepto.Value := '';
     DataTipoRetencion.Value := 0;
     DataSubcuentaRetencion.Value := '';
     DataBaseRetencion.Value := 0.0;
     DataImporteRetencion.Value := 0.0;
     DataFormaPago.Value := '';
     DataInversionSujetoPasivo.Value := AsientoFields.Origen.Value=ofrInversionSP;

end;

procedure TMntFcgForm.ActualizaDatosRegistro;

var  TextoEstado : String;

begin

     If   not AsientoTable.RecordOpened
     then try

            ActualizandoRegistro := True;

            SumaBaseImponible := 0.0;
            SumaCuotaIVA := 0.0;
            SumaImporteTotal := 0.0;

            try

              Data.DisableControls;

              Data.Edit;
              Data.ClearFields;

              DataSubcuentaRetencion.Value := '';
              DataBaseRetencion.Value := 0.0;
              DataTipoRetencion.Value := 0;
              DataImporteRetencion.Value := 0.0;

              DataInversionSujetoPasivo.Value := AsientoFields.Origen.Value=ofrInversionSP;

              DescSubcuentaRetencionLabel.Caption := '';

              With ApunteConsultaTable do
                begin

                With AsientoFields do
                  SetRange( [ Ejercicio.Value, NroAsiento.Value, 2 ], [ Ejercicio.Value, NroAsiento.Value, MaxSmallint ] );

                First;

                If   not Eof
                then DataConcepto.Value := ApunteConsultaFields.Concepto.Value;

                While not Eof do
                  begin

                  With ApunteConsultaFields do
                    case TipoApunte.Value of
                      tapManual    : begin
                                     DecAdd( SumaBaseImponible, BaseImponible.Value );
                                     DecAdd( SumaCuotaIVA, CuotaIVA.Value );
                                     DecAdd( SumaImporteTotal, ImporteTotal.Value  );
                                     end;
                      tapRetencion : begin
                                     DataSubcuentaRetencion.Value  := Subcuenta.Value;
                                     DataBaseRetencion.Value := BaseImponible.Value;
                                     DataTipoRetencion.Value := Tipo.Value;
                                     DataImporteRetencion.Value := GetSignedValue( Debe, Haber, True );
                                     end;
                      end;

                  Next;
                  end;

                With EfectoPagarTable do
                  If   RecordCount=0
                  then DataFormaPago.Clear
                  else DataFormaPago.Value := EfectoPagarFields.FormaDePago.Value;

                end;

              If   ValueIsEmpty( AsientoFields.NroAsiento.Value )
              then EstadoLabel.Caption := ''
              else begin
                   TextoEstado := Format( RsMsg1, [ AsientoFields.NroAsiento.Value ] );

                   If   FEstadoPresentacion<>erpPendiente
                   then begin
                        StrAdd( TextoEstado, ' (Presentada' );
                        If   FEstadoPresentacion=erpAnulado
                        then StrAdd( TextoEstado, ' y anulada)' )
                        else StrAdd( TextoEstado, ')' );
                        end;

                   If   AsientoFields.Bloqueado.Value
                   then StrAdd( TextoEstado, ' (Pago bloqueado)' );

                   EstadoLabel.Caption := TextoEstado;
                   end;

            finally
              DataFieldValues := GetRecordFieldValues( Data );
              Data.EnableControls;
              end;

            MuestraTotalesFactura;

          finally
            ActualizandoRegistro := False;
            end;
end;

procedure TMntFcgForm.AsientoTableRemoteDelete(DataSet: TDataSet);
begin
     FacturaTable.Cancel;
     Asiento.SuprimeFacturaRecibida( AsientoFields );
end;

procedure TMntFcgForm.AsientoTableRemotePost(DataSet: TDataSet);
begin
     try

       Asiento.ActualizaFactura( AsientoFields,
                                 DataConcepto.Value,
                                 DataSubcuentaRetencion.Value,
                                 DataTipoRetencion.Value,
                                 DataBaseRetencion.Value,
                                 DataImporteRetencion.Value );

       If   not AsientoTable.DeletingMasterRecord
       then With AsientoFields do
              ActualizaMntAsientos( [ Ejercicio.Value, NroAsiento.Value ] );

     except on E : Exception do ShowException( E, Self );
       end;

end;

procedure TMntFcgForm.AsientoTableSetKey(DataSet: TDataSet);
begin
     If   not AsientoTable.UpdatingProcess
     then begin

          With AsientoFields do
            begin
            Ejercicio.Value := ApplicationContainer.Ejercicio;
            TipoAsiento.Value := taFraRecibida;
            If   Serie.IsNull
            then Serie.Value :='';
            NroEfecto.Value := NroEfectoRegistroFactura;
            end;

          With Data do
            begin
            Edit;
            ClearFields;
            end;

          EstadoLabel.Caption := '';
          end;
end;

procedure TMntFcgForm.AsientoTableUpdateState(DataSet: TDataSet);
begin
     If   FormManager.FormInitialized and not AsientoTable.ControlsDisabled
     then begin
          ApunteDataSource.Enabled := AsientoTable.State<>dsSetKey;
          EfectoPagarDataSource.Enabled := AsientoTable.State<>dsSetKey;
          ApunteTableUpdateState( nil );
          end;
end;

procedure TMntFcgForm.BaseRetencionCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   BaseRetencionCtrl.Editing
     then RecalculaImporteRetencion;
end;

procedure TMntFcgForm.BaseRetencionCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With BaseRetencionCtrl do
       If   ValueIsEmpty( EditValue )
       then begin
            If   TiposRetencionFields.SobreTotal.Value
            then EditValue := SumaImporteTotal
            else EditValue := SumaBaseImponible;
            end;
end;

procedure TMntFcgForm.BaseRetencionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var   BaseRetencion,
      ImporteMaximo : Decimal;

begin
     With BaseRetencionCtrl do
       If   Editing
       then begin
            BaseRetencion := VarToDecimal( DisplayValue );
            If   TiposRetencionFields.SobreTotal.Value
            then ImporteMaximo := SumaImporteTotal + DataImporteRetencion.Value
            else ImporteMaximo := SumaBaseImponible;
            If   ( ( ImporteMaximo>0.0 ) and ( ImporteMaximo<BaseRetencion ) ) or
                 ( ( ImporteMaximo<0.0 ) and ( ImporteMaximo>BaseRetencion ) )
            then begin
                 Value := ImporteMaximo;
                 Error := True;
                 If   TiposRetencionFields.SobreTotal.Value
                 then ErrorText := Format( RsMsg4, [ RsMsg5 ] )
                 else ErrorText := Format( RsMsg4, [ RsMsg6 ] );
                 end;
            If   BaseRetencion=0.0
            then ImporteNoSujetoLabel.Caption := ''
            else ImporteNoSujetoLabel.Caption := StrFormat(  ImporteMaximo - BaseRetencion, DecimalesMoneda );

            end;
end;

procedure TMntFcgForm.BloquearPagoItemClick(Sender: TObject);
begin
     With AsientoFields do
       BloqueoPagosFacturaIVA( Ejercicio.Value, Propietario.Value, Serie.Value );
end;

procedure TMntFcgForm.ConceptoCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntConceptosApunte( [] );
end;

procedure TMntFcgForm.ConceptoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With ConceptoCtrl do
       If   ValueIsEmpty( EditValue )
       then With AsientoFields do
              EditValue:= Format( RsMsg2, [ Serie.Value ] );
end;

procedure TMntFcgForm.ConceptoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaConceptosApunte( Sender, qgsNormal, True );
end;

procedure TMntFcgForm.ConceptoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   Sender.EditModified
     then ConceptoApunte.CompruebaTexto( DisplayValue, ErrorText, Error );
end;

procedure TMntFcgForm.PropietarioCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     If   not AsientoTable.ControlsDisabled
     then With PropietarioCtrl do
            If   ValueIsEmpty( EditValue )
            then EditValue := '4';
end;

procedure TMntFcgForm.PropietarioCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     DatosProveedorDisponibles := False;
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error and Assigned( ProveedorFields )
     then DatosProveedorDisponibles := Proveedor.ObtenPorSubcuenta( DisplayValue, ProveedorFields );
end;

procedure TMntFcgForm.ProveedorItemClick(Sender: TObject);
begin
     MntProveedoresPorSubcuenta( AsientoFields.Propietario.Value );
end;

procedure TMntFcgForm.FormManagerNoteRequest;
begin
     MntAnotacion( AsientoFields.Anotacion );
end;

procedure TMntFcgForm.FormManagerQueryGridRequest;
begin
     ConsultaFrasRecibidas( AsientoFields.Propietario, SerieNroFacturaCtrl, qgsDetached );
end;

end.


