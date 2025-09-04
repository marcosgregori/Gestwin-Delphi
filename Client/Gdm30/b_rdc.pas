unit b_rdc;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes, Windows,
  ExtCtrls, Grids, Graphics, ComCtrls,

  LibUtils,
  AppContainer,
  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, nxdb, DataManager,
  cxCheckBox, cxPC, cxLabel, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, dxmdaset, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxCurrencyEdit, cxMaskEdit, cxDropDownEdit, cxDBLabel,

  Spring,

  Gim10Fields,
  Gim30Fields,

  dm_mov, cxLookAndFeels, cxGroupBox, cxPCdxBarPopupMenu, cxNavigator,
  dxBarBuiltInMenu, dxDateRanges, AppForms, GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations, dxUIAClasses;

type
  TBrwRdcForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    NombreCtrl: TcxDBLabel;
    PageControl: TcxPageControl;
    PresupuestosTS: TcxTabSheet;
    pedidosTS: TcxTabSheet;
    AlbaranesTS: TcxTabSheet;
    facturasTS: TcxTabSheet;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Panel1: TcxGroupBox;
    Panel2: TcxGroupBox;
    EfectosTS: TcxTabSheet;
    ClienteTable: TnxeTable;
    Data: TDataSource;
    Panel4: TcxGroupBox;
    documentosPendientePanel: TcxGroupBox;
    ClienteTableCodigo: TWideStringField;
    ClienteTableNombre: TWideStringField;
    PresupuestoTable: TnxeTable;
    PresupuestosView: TcxGridDBTableView;
    PresupuestosLevel: TcxGridLevel;
    PresupuestosGrid: TcxGrid;
    PresupuestoData: TDataSource;
    PresupuestosViewNroDocumento: TcxGridDBColumn;
    PresupuestosViewFecha: TcxGridDBColumn;
    PresupuestosViewFechaEmision: TcxGridDBColumn;
    PresupuestosViewImporteBruto: TcxGridDBColumn;
    PresupuestosViewDescuentoArticulos: TcxGridDBColumn;
    PresupuestosViewImporteNeto: TcxGridDBColumn;
    PresupuestosViewTextoSituacion: TcxGridDBColumn;
    PedidoVentasGrid: TcxGrid;
    PedidoVentasView: TcxGridDBTableView;
    PedidoVentasLevel: TcxGridLevel;
    PedidoVentasTable: TnxeTable;
    PedidoVentasData: TDataSource;
    PedidoVentasViewNroDocumento: TcxGridDBColumn;
    PedidoVentasViewSerie: TcxGridDBColumn;
    PedidoVentasViewFecha: TcxGridDBColumn;
    PedidoVentasViewFechaAplicacion: TcxGridDBColumn;
    PedidoVentasViewNroDocumentoPropietario: TcxGridDBColumn;
    PedidoVentasViewImporteBruto: TcxGridDBColumn;
    PedidoVentasViewDescuentoArticulos: TcxGridDBColumn;
    PedidoVentasViewImporteNeto: TcxGridDBColumn;
    PedidoVentasViewTextoSituacion: TcxGridDBColumn;
    MovimientoAlmacenTable: TnxeTable;
    MovimientoAlmacenData: TDataSource;
    MovimientoAlmacenGrid: TcxGrid;
    MovimientoAlmacenView: TcxGridDBTableView;
    MovimientoAlmacenLevel: TcxGridLevel;
    MovimientoAlmacenViewSerie: TcxGridDBColumn;
    MovimientoAlmacenViewNroDocumento: TcxGridDBColumn;
    MovimientoAlmacenViewFecha: TcxGridDBColumn;
    MovimientoAlmacenViewFechaEmision: TcxGridDBColumn;
    MovimientoAlmacenViewImporteNeto: TcxGridDBColumn;
    MovimientoAlmacenViewNroFactura: TcxGridDBColumn;
    MovimientoAlmacenViewFacturado: TcxGridDBColumn;
    FacturaVentasTable: TnxeTable;
    FacturaVentasData: TDataSource;
    EfectoCobrarGrid: TcxGrid;
    EfectoCobrarView: TcxGridDBTableView;
    EfectoCobrarLevel: TcxGridLevel;
    EfectoCobrarTable: TnxeTable;
    EfectoCobrarData: TDataSource;
    EfectoCobrarViewSerie: TcxGridDBColumn;
    EfectoCobrarViewNroFactura: TcxGridDBColumn;
    EfectoCobrarViewNroEfecto: TcxGridDBColumn;
    EfectoCobrarViewFechaLibramiento: TcxGridDBColumn;
    EfectoCobrarViewEntidad: TcxGridDBColumn;
    EfectoCobrarViewFechaVencimiento: TcxGridDBColumn;
    EfectoCobrarViewFechaCobro: TcxGridDBColumn;
    EfectoCobrarViewConcepto: TcxGridDBColumn;
    EfectoCobrarViewNroRemesa: TcxGridDBColumn;
    EfectoCobrarViewImporte: TcxGridDBColumn;
    EfectoCobrarViewImpagado: TcxGridDBColumn;
    ClienteTableSubcuenta: TWideStringField;
    PresupuestosViewEstado: TcxGridDBColumn;
    PedidoVentasViewSituacion: TcxGridDBColumn;
    FacturaVentasGrid: TcxGrid;
    FacturaVentasView: TcxGridDBTableView;
    FacturaVentasLevel: TcxGridLevel;
    FacturaVentasViewSerie: TcxGridDBColumn;
    FacturaVentasViewNroFactura: TcxGridDBColumn;
    FacturaVentasViewCodigoCliente: TcxGridDBColumn;
    FacturaVentasViewFecha: TcxGridDBColumn;
    FacturaVentasViewNetoFactura: TcxGridDBColumn;
    FacturaVentasViewCuotaIVA: TcxGridDBColumn;
    FacturaVentasViewCuotaRE: TcxGridDBColumn;
    FacturaVentasViewTotalFactura: TcxGridDBColumn;
    FacturaVentasViewTraspasada: TcxGridDBColumn;
    MovimientoAlmacenViewImporteBruto: TcxGridDBColumn;
    MovimientoAlmacenViewDescuentosArticulos: TcxGridDBColumn;
    PresupuestosViewAnotacion: TcxGridDBColumn;
    PedidoVentasViewAnotacion: TcxGridDBColumn;
    MovimientoAlmacenViewAnotacion: TcxGridDBColumn;
    FacturaVentasViewAnotacion: TcxGridDBColumn;
    FacturaVentasViewDtoES: TcxGridDBColumn;
    FacturaVentasViewDtoPP: TcxGridDBColumn;
    EfectoCobrarViewPendiente: TcxGridDBColumn;
    SoloPendientesCtrl: TcxCheckBox;
    PresupuestoTableEjercicio: TSmallintField;
    PresupuestoTableNroOperacion: TIntegerField;
    PresupuestoTableTipoMovimiento: TSmallintField;
    PresupuestoTablePropietario: TWideStringField;
    PresupuestoTableSerie: TWideStringField;
    PresupuestoTableNroDocumento: TIntegerField;
    PresupuestoTableFecha: TDateField;
    PresupuestoTableFechaAplicacion: TDateField;
    PresupuestoTableFechaEmision: TDateField;
    PresupuestoTableFechaAuxiliar: TDateField;
    PresupuestoTableSituacion: TSmallintField;
    PresupuestoTableAnotacion: TWideMemoField;
    PresupuestoTableImporteBruto: TBCDField;
    PresupuestoTableDescuentosArticulos: TBCDField;
    PedidoVentasTableEjercicio: TSmallintField;
    PedidoVentasTableNroOperacion: TIntegerField;
    PedidoVentasTableTipoMovimiento: TSmallintField;
    PedidoVentasTablePropietario: TWideStringField;
    PedidoVentasTableSerie: TWideStringField;
    PedidoVentasTableNroDocumento: TIntegerField;
    PedidoVentasTableFecha: TDateField;
    PedidoVentasTableFechaAplicacion: TDateField;
    PedidoVentasTableFechaEmision: TDateField;
    PedidoVentasTableNroDocumentoPropietario: TWideStringField;
    PedidoVentasTableSituacion: TSmallintField;
    PedidoVentasTableRevisado: TBooleanField;
    PedidoVentasTableAnotacion: TWideMemoField;
    PedidoVentasTableImporteBruto: TBCDField;
    PedidoVentasTableDescuentosArticulos: TBCDField;
    MovimientoAlmacenTableEjercicio: TSmallintField;
    MovimientoAlmacenTableNroOperacion: TIntegerField;
    MovimientoAlmacenTableTipoMovimiento: TSmallintField;
    MovimientoAlmacenTablePropietario: TWideStringField;
    MovimientoAlmacenTableSerie: TWideStringField;
    MovimientoAlmacenTableNroDocumento: TIntegerField;
    MovimientoAlmacenTableFecha: TDateField;
    MovimientoAlmacenTableFechaAplicacion: TDateField;
    MovimientoAlmacenTableFechaEmision: TDateField;
    MovimientoAlmacenTableEjercicioFactura: TSmallintField;
    MovimientoAlmacenTablePropietarioFactura: TWideStringField;
    MovimientoAlmacenTableSerieFactura: TWideStringField;
    MovimientoAlmacenTableNroFactura: TIntegerField;
    MovimientoAlmacenTableFacturado: TBooleanField;
    MovimientoAlmacenTableAnotacion: TWideMemoField;
    MovimientoAlmacenTableImporteBruto: TBCDField;
    MovimientoAlmacenTableDescuentosArticulos: TBCDField;
    PresupuestoTableImporteNeto: TBCDField;
    PedidoVentasTableImporteNeto: TBCDField;
    MovimientoAlmacenTableImporteNeto: TBCDField;
    PresupuestoTableTextoEstado: TWideStringField;
    PedidoVentasTableTextoSituacion: TWideStringField;
    EfectoCobrarTablePendiente: TBooleanField;
    EfectoCobrarTableEjercicio: TSmallintField;
    EfectoCobrarTableSerie: TWideStringField;
    EfectoCobrarTableNroFactura: TIntegerField;
    EfectoCobrarTableNroEfecto: TSmallintField;
    EfectoCobrarTableFechaVencimiento: TDateField;
    EfectoCobrarTableFechaCobro: TDateField;
    EfectoCobrarTableConcepto: TWideStringField;
    EfectoCobrarTableEjercicioRemesa: TSmallintField;
    EfectoCobrarTableNroRemesa: TIntegerField;
    EfectoCobrarTableImporte: TBCDField;
    EfectoCobrarTableImporteCobrado: TBCDField;
    EfectoCobrarTableConceptoCobro: TWideStringField;
    EfectoCobrarTableVendedor: TWideStringField;
    EfectoCobrarTableGrupoFacturacion: TWideStringField;
    EfectoCobrarTableRevisado: TBooleanField;
    EfectoCobrarTableImpagado: TBooleanField;
    EfectoCobrarTableCancelado: TBooleanField;
    EfectoCobrarTableVolverAEmitir: TBooleanField;
    EfectoCobrarTableNroEfectoReemitido: TSmallintField;
    EfectoCobrarTableFechaLibramiento: TDateField;
    EfectoCobrarTableFechaEmision: TDateField;
    EfectoCobrarTableFormaDePago: TWideStringField;
    EfectoCobrarTableGastosGestion: TBCDField;
    EfectoCobrarTableGastosDevolucion: TBCDField;
    EfectoCobrarTableSubcuentaGastos: TWideStringField;
    EfectoCobrarTableFechaCancelacion: TDateField;
    EfectoCobrarTableNroAstoCancelacion: TIntegerField;
    EfectoCobrarTableFechaImpagado: TDateField;
    EfectoCobrarTableNroAsientoImpagado: TIntegerField;
    EfectoCobrarTableDiferenciaCambio: TBCDField;
    EfectoCobrarTableGenerarEfectoDiferencia: TBooleanField;
    EfectoCobrarTableSubcuentaDiferencia: TWideStringField;
    EfectoCobrarTableNroAsientoCartera: TIntegerField;
    EfectoCobrarTableNroAsientoCobro: TIntegerField;
    EfectoCobrarTableCodigoCliente: TWideStringField;
    EfectoCobrarTableNroEfectoDiferencia: TSmallintField;
    codigoCtrlCaption: TcxLabel;
    Label2: TcxLabel;
    Label1: TcxLabel;
    Label3: TcxLabel;
    EfectoCobrarTableAnotacion: TWideMemoField;
    EfectoCobrarViewImporteCobrado: TcxGridDBColumn;
    PresupuestosTableViewManager: TGridTableViewController;
    PedidosTableViewManager: TGridTableViewController;
    MovimientosTableViewManager: TGridTableViewController;
    FacturasTableViewManager: TGridTableViewController;
    EfectosTableViewManager: TGridTableViewController;
    EfectoCobrarTableSubcuentaCliente: TWideStringField;
    EfectoCobrarTableSubcuentaEntidad: TWideStringField;
    Shape1: TShape;
    PendienteCobroBox: TcxLabel;
    PendienteFacturarBox: TcxLabel;
    PresupuestosViewSerie: TcxGridDBColumn;
    procedure SoloPendientesCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure ClienteTableGetRecord(DataSet: TDataSet);
    function PresupuestoTableCheckValidRecord(Dataset: TDataSet): Boolean;
    procedure FacturaVentasViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    function EfectoCobrarTableCheckValidRecord(Dataset: TDataSet): Boolean;
    procedure EfectoCobrarTableCalcFields(DataSet: TDataSet);
    procedure EfectoCobrarViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    function FacturaVentasTableCheckValidRecord(
      Dataset: TDataSet): Boolean;
    function MovimientoAlmacenTableCheckValidRecord(
      Dataset: TDataSet): Boolean;
    procedure PedidoVentasViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure PresupuestosViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure MovimientoAlmacenViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure MovimientoAlmacenTableCalcFields(DataSet: TDataSet);
    function PedidoVentasTableCheckValidRecord(Dataset: TDataSet): Boolean;
    procedure PedidoVentasTableCalcFields(DataSet: TDataSet);
    procedure PresupuestoTableCalcFields(DataSet: TDataSet);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormManagerInitializeForm;
    procedure ClienteTableBeforeEdit(DataSet: TDataSet);
    procedure FormManagerReportRequest;
    procedure FormManagerSetupToolBar(Enable: Boolean);
    procedure PageControlChange(Sender: TObject);
    procedure PresupuestosTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure PedidosTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure MovimientosTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure FacturasTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure EfectosTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    function PresupuestosTableViewManagerCanShowOrigin: Boolean;
    function PresupuestosTableViewManagerShowOrigin: Boolean;
    function PedidosTableViewManagerCanShowOrigin: Boolean;
    function PedidosTableViewManagerShowOrigin: Boolean;
    function MovimientosTableViewManagerCanShowOrigin: Boolean;
    function MovimientosTableViewManagerShowOrigin: Boolean;
    function FacturasTableViewManagerCanShowOrigin: Boolean;
    function FacturasTableViewManagerShowOrigin: Boolean;
    function EfectosTableViewManagerCanShowOrigin: Boolean;
    function EfectosTableViewManagerShowOrigin: Boolean;
  private

    ImporteBruto,
    DescuentosArticulos,
    ImporteNeto : Decimal;
    FechaInicial,
    FechaFinal    : TDateTime;
    EjercicioInicial,
    EjercicioFinal : SmallInt;

    EfectoCobrarFields : TEfectoCobrarFields;
    FacturaVentasFields : TFacturaVentasFields;

    FOnMuestraTicket : Event<TMuestraMovimientoEvent>;

    procedure ActualizaDocumentos;
    procedure DesactivaDatasets;
    procedure FijaColorLineaPendiente( ACanvas : TcxCanvas; Pendiente : Boolean );

  public
    property OnMuestraTicket : Event<TMuestraMovimientoEvent> read FOnMuestraTicket write FOnMuestraTicket;
  end;

var  BrwRdcForm: TBrwRdcForm = nil;

procedure RelacionDocumentosClientes( keyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       DateUtils,
       AppManager,

       Variants,

       EnterpriseDataAccess,
       PDFViewer,

       Gim00Fields,
       Gdm30Frm,

       dmi_pga,
       dmi_mov,

       dm_pga,
       dm_cli,
       dm_rcl,
       dm_fdv,
       dm_tma,
       dm_sal,
       dm_ecc,

       a_cli,
       a_mve,
       a_fdv,
       a_ecc,

       cx_cli,

       r_mov,
       r_fdv,
       l_ecc;

resourceString
       RsMsg1   = 'Pendiente';
       RsMsg2   = 'Aceptado';
       RsMsg3   = 'Cancelado';
       RsMsg4   = 'Pendiente';
       RsMsg5   = 'Parcialm. servido';
       RsMsg6   = 'Servido';
       RsMsg7   = '&Tickets';
       RsMsg8   = 'Haga doble click (o pulse la barra espaciadora) sobre la línea del documento para acceder a la ventana de mantenimiento del mismo.';

procedure RelacionDocumentosClientes( keyValues : array of const );
begin
     CreateEditForm( TBrwRdcForm, brwRdcForm, KeyValues, TGds30Frm.ResultadosSection );
end;

function TBrwRdcForm.FacturasTableViewManagerCanShowOrigin: Boolean;
begin
     Result := FacturaVentasView.Controller.SelectedRowCount=1;
end;

function TBrwRdcForm.FacturasTableViewManagerShowOrigin: Boolean;
begin
     With FacturaVentasFields do
       MntFacturasVenta( [ Ejercicio.Value, Serie.Value, NroFactura.Value ] );
end;

procedure TBrwRdcForm.FacturasTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     FacturasTableViewManagerShowOrigin;
end;

function TBrwRdcForm.FacturaVentasTableCheckValidRecord(Dataset: TDataSet): Boolean;
begin
     Result := not SoloPendientesCtrl.Checked or ( not FacturaVentasFields.Traspasada.Value );
end;

procedure TBrwRdcForm.FacturaVentasViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     FijaColorLineaPendiente( ACanvas, not VarToBoolean( AViewInfo.GridRecord.Values[ FacturaVentasViewTraspasada.Index ] ) );
end;

procedure TBrwRdcForm.FormManagerInitializeForm;
begin
     ID := idBrwRdcForm;

     FacturaVentasFields := TFacturaVentasFields.Create( FacturaVentasTable );
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );

     SetColumnsDecimals( [ PresupuestosViewImporteBruto,
                           PresupuestosViewDescuentoArticulos,
                           PresupuestosViewImporteNeto,
                           PedidoVentasViewImporteBruto,
                           PedidoVentasViewDescuentoArticulos,
                           PedidoVentasViewImporteNeto,

                           MovimientoAlmacenViewImporteBruto,
                           MovimientoAlmacenViewDescuentosArticulos,
                           MovimientoAlmacenViewImporteNeto,

                           FacturaVentasViewNetoFactura,
                           FacturaVentasViewDtoPP,
                           FacturaVentasViewDtoES,
                           FacturaVentasViewCuotaIVA,
                           FacturaVentasViewCuotaRE,
                           FacturaVentasViewTotalFactura,

                           EfectoCobrarViewImporte,
                           EfectoCobrarViewImporteCobrado ] );

     PresupuestosTS.TabVisible := ProgramNumber<>pnTPV;
     EfectosTS.TabVisible := ProgramNumber<>pnTPV;

     PresupuestosViewSerie.Visible := Movimiento.SeriesEnDocumentosVenta( tmPresupuesto );
     PedidoVentasViewSerie.Visible := Movimiento.SeriesEnDocumentosVenta( tmPedidoVenta );

     {
     PresupuestosGrid.Hint := RsMsg8;
     PedidoVentasGrid.Hint := RsMsg8;
     MovimientoAlmacenGrid.Hint := RsMsg8;
     FacturaVentasGrid.Hint := RsMsg8;
     EfectoCobrarGrid.Hint := RsMsg8;
     }

     If   ProgramNumber=pnTPV
     then AlbaranesTS.Caption := RsMsg7;

end;

procedure TBrwRdcForm.FormManagerReportRequest;

var  TipoMovimiento : TTipoMovimiento;
     FijarFechas : Boolean;
     FechaInicial,
     FechaFinal : TDateTime;

begin
     case PageControl.ActivePageIndex of
       0..2 : begin
              FijarFechas := False;
              case PageControl.ActivePageIndex of
                0 : begin
                    TipoMovimiento := tmPresupuesto;
                    With PresupuestosView.ViewData do
                      If   RowCount>0
                      then begin
                           FechaInicial := Rows[ RowCount - 1 ].Values[ PresupuestosViewFecha.Index ];
                           FechaFinal := Rows[ 0 ].Values[ PresupuestosViewFecha.Index ];
                           FijarFechas := True;
                           end;
                    end;
                1 : begin
                    TipoMovimiento := tmPedidoVenta;
                    With PedidoVentasView.ViewData do
                      If   RowCount>0
                      then begin
                           FechaInicial := Rows[ RowCount - 1 ].Values[ PedidoVentasViewFecha.Index ];
                           FechaFinal := Rows[ 0 ].Values[ PedidoVentasViewFecha.Index ];
                           FijarFechas := True;
                           end;
                    end;
                2 : begin
                    TipoMovimiento := tmVenta;
                    With MovimientoAlmacenView.ViewData do
                      If   RowCount>0
                      then begin
                           FechaInicial := Rows[ RowCount - 1 ].Values[ MovimientoAlmacenViewFecha.Index ];
                           FechaFinal := Rows[ 0 ].Values[ MovimientoAlmacenViewFecha.Index ];
                           FijarFechas := True;
                           end;
                    end;
                end;

              ImpresionMovimientos( False, TipoMovimiento, ApplicationContainer.Ejercicio, ClienteTableCodigo.Value, '', 0 );

              If   Assigned( RptMovForm )
              then With RptMovForm do
                     begin
                     SeleccionPageControl.ActivePageIndex := 1;
                     If   FijarFechas
                     then begin
                          DataFechaInicial.Value := FechaInicial;
                          DataFechaFinal.Value := FechaFinal;
                          end;
                     DataDetallado.Value := False;
                     FormManager.ValidateDataArea( faData );
                     end;
              end;

          3 : begin
              ImpresionFacturasVenta( ApplicationContainer.Ejercicio, '', 0, 0 );
              If   Assigned( RptFdvForm )
              then With RptFdvForm, FacturaVentasView.ViewData do
                     begin
                     PageControl.ActivePageIndex := 1;
                     If   RowCount>0
                     then begin
                          DataFechaInicial.Value := Rows[ RowCount - 1 ].Values[ FacturaVentasViewFecha.Index ];
                          DataFechaFinal.Value := Rows[ 0 ].Values[ FacturaVentasViewFecha.Index ];
                          end;
                     DataClienteInicial.Value := ClienteTableCodigo.Value;
                     DataClienteFinal.Value := ClienteTableCodigo.Value;
                     FormManager.ValidateDataArea( faData );
                     end;
              end;

       4 : begin
           ListadoEfectosCobrar;
           If   Assigned( RptEccForm )
           then With RptEccForm, EfectoCobrarView.ViewData do
                  begin
                  If   RowCount>0
                  then begin
                       DataFechaInicial.Value := Rows[ RowCount - 1 ].Values[ EfectoCobrarViewFechaVencimiento.Index ];
                       DataFechaFinal.Value := Rows[ 0 ].Values[ EfectoCobrarViewFechaVencimiento.Index ];
                       end;
                  DataClienteInicial.Value := ClienteTableSubcuenta.Value;
                  DataClienteFinal.Value := ClienteTableSubcuenta.Value;
                  If   SoloPendientesCtrl.Checked
                  then DataSituacion.Value := 1
                  else DataSituacion.Value := 0;
                     DataAGruparEntidad.Value := True;
                  FormManager.ValidateDataArea( faData );
                  end;
           end;
       end;
       
end;

procedure TBrwRdcForm.FormManagerSetupToolBar(Enable: Boolean);
begin
     ApplicationContainer.ReportButton.Enabled := Enable and FormManager.DataAreaFocused;
end;

procedure TBrwRdcForm.ClienteTableBeforeEdit(DataSet: TDataSet);
begin
     DesactivaDatasets;
end;

procedure TBrwRdcForm.ClienteTableGetRecord(DataSet: TDataSet);
begin
     ActualizaDocumentos;
end;

procedure TBrwRdcForm.CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TBrwRdcForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TBrwRdcForm.MovimientoAlmacenViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean );
begin
     FijaColorLineaPendiente( ACanvas, not VarToBoolean( AViewInfo.GridRecord.Values[ MovimientoAlmacenViewFacturado.Index ] ) );
end;

function TBrwRdcForm.MovimientosTableViewManagerCanShowOrigin: Boolean;
begin
     Result := MovimientoAlmacenView.Controller.SelectedRowCount=1;
end;

{
function TBrwRdcForm.MovimientosTableViewManagerShowDocument: Boolean;

var  Fichero : String;
     ListaFicheros : TStringList;

begin
     ListaFicheros := TStringList.Create;
     try
       Fichero := ApplicationPath + 'doc_' + CodigoEmpresaActual + '\Albaranes de venta\' + IntToStr( MovimientoAlmacenTableEjercicio.Value ) + '\PDF\fav' + IntToStr( MovimientoAlmacenTableEjercicio.Value ) + '_' + MovimientoAlmacenTableSerie.Value + '_' + IntToStr( MovimientoAlmacenTableNroDocumento.Value ) + '.pdf';
       If   FileExists( Fichero )
       then ListaFicheros.Add( Fichero );
       If   ListaFicheros.Count>0
       then VistaFicheroPDF( ListaFicheros )
       else ;
     finally
       ListaFicheros.Free;
       end;
end;
}

function TBrwRdcForm.MovimientosTableViewManagerShowOrigin: Boolean;
begin
     If   FOnMuestraTicket.CanInvoke
     then FOnMuestraTicket.Invoke( tmVenta, MovimientoAlmacenTableEjercicio.Value, MovimientoAlmacenTableSerie.Value, MovimientoAlmacenTableNroDocumento.Value )
     else MntMovimientosVenta( [ tmVenta, MovimientoAlmacenTableEjercicio.Value, MovimientoAlmacenTableSerie.Value, MovimientoAlmacenTableNroDocumento.Value ] );
end;

procedure TBrwRdcForm.MovimientosTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     MovimientosTableViewManagerShowOrigin;
end;

function TBrwRdcForm.PresupuestosTableViewManagerCanShowOrigin: Boolean;
begin
     Result := PresupuestosView.Controller.SelectedRowCount=1;
end;

function TBrwRdcForm.PresupuestosTableViewManagerShowOrigin: Boolean;
begin
     MntMovimientosVenta( [ tmPresupuesto, PresupuestoTableEjercicio.Value, PresupuestoTableSerie.Value, PresupuestoTableNroDocumento.Value ] );
end;

procedure TBrwRdcForm.PresupuestosTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     PresupuestosTableViewManagerShowOrigin;
end;

procedure TBrwRdcForm.PresupuestosViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     FijaColorLineaPendiente( ACanvas, ( VarToInteger( AViewInfo.GridRecord.Values[ PresupuestosViewEstado.Index ] )=0 ) );
end;

procedure TBrwRdcForm.PresupuestoTableCalcFields(DataSet: TDataSet);
begin
     Movimiento.ObtenImporteMovimiento( PresupuestoTableEjercicio.Value,
                                        PresupuestoTableNroOperacion.Value,
                                        ImporteBruto,
                                        DescuentosArticulos,
                                        ImporteNeto );

     PresupuestoTableImporteBruto.Value := ImporteBruto;
     PresupuestoTableDescuentosArticulos.Value := DescuentosArticulos;
     PresupuestoTableImporteNeto.Value := ImporteNeto;

     With PresupuestoTableTextoEstado do
       case PresupuestoTableSituacion.Value of
         eprPendiente : Value := RsMsg1;
         eprAceptado  : Value := RsMsg2;
         eprCancelado : Value := RsMsg3;
         end;
end;

function TBrwRdcForm.PresupuestoTableCheckValidRecord(Dataset: TDataSet): Boolean;
begin
     Result := not SoloPendientesCtrl.Checked or ( PresupuestoTableSituacion.Value=0 );
end;

procedure TBrwRdcForm.SoloPendientesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ActualizaDocumentos;
     DocumentosPendientePanel.Visible := not SoloPendientesCtrl.Checked;
end;

procedure TBrwRdcForm.PageControlChange(Sender: TObject);
begin
     ActualizaDocumentos;
end;

function TBrwRdcForm.PedidosTableViewManagerCanShowOrigin: Boolean;
begin
     Result := PedidoVentasView.Controller.SelectedRowCount=1;
end;

function TBrwRdcForm.PedidosTableViewManagerShowOrigin: Boolean;
begin
     MntMovimientosVenta( [ tmPedidoVenta, PedidoVentasTableEjercicio.Value, PedidoVentasTableSerie.Value, PedidoVentasTableNroDocumento.Value ] );
end;

procedure TBrwRdcForm.PedidosTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     PedidosTableViewManagerShowOrigin;
end;

procedure TBrwRdcForm.PedidoVentasTableCalcFields(DataSet: TDataSet);
begin
     Movimiento.ObtenImporteMovimiento( PedidoVentasTableEjercicio.Value,
                                        PedidoVentasTableNroOperacion.Value,
                                        ImporteBruto,
                                        DescuentosArticulos,
                                        ImporteNeto );

     PedidoVentasTableImporteBruto.Value := ImporteBruto;
     PedidoVentasTableDescuentosArticulos.Value := DescuentosArticulos;
     PedidoVentasTableImporteNeto.Value := ImporteNeto;

     With PedidoVentasTableTextoSituacion do
       case PedidoVentasTableSituacion.Value of
         0 : Value := RsMsg4;
         1 : Value := RsMsg5;
         2 : Value := RsMsg6;
         end;

end;

function TBrwRdcForm.PedidoVentasTableCheckValidRecord(Dataset: TDataSet): Boolean;
begin
     Result := not SoloPendientesCtrl.Checked or ( PedidoVentasTableSituacion.Value<2 );
end;

procedure TBrwRdcForm.PedidoVentasViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     FijaColorLineaPendiente( ACanvas, ( VarToInteger( AViewInfo.GridRecord.Values[ PedidoVentasViewSituacion.Index ] )<2 ) );
end;

procedure TBrwRdcForm.MovimientoAlmacenTableCalcFields(DataSet: TDataSet);
begin
     Movimiento.ObtenImporteMovimiento( MovimientoAlmacenTableEjercicio.Value,
                                        MovimientoAlmacenTableNroOperacion.Value,
                                        ImporteBruto,
                                        DescuentosArticulos,
                                        ImporteNeto );

     MovimientoAlmacenTableImporteBruto.Value := ImporteBruto;
     MovimientoAlmacenTableDescuentosArticulos.Value := DescuentosArticulos;
     MovimientoAlmacenTableImporteNeto.Value := ImporteNeto;

end;

function TBrwRdcForm.MovimientoAlmacenTableCheckValidRecord(Dataset: TDataSet): Boolean;
begin
     Result := not SoloPendientesCtrl.Checked or not MovimientoAlmacenTableFacturado.Value;
end;

procedure TBrwRdcForm.DesactivaDatasets;
begin
     PresupuestoData.Enabled := False;
     PedidoVentasData.Enabled := False;
     MovimientoAlmacenData.Enabled := False;
     FacturaVentasData.Enabled := False;
     EfectoCobrarData.Enabled := False;
end;

procedure TBrwRdcForm.ActualizaDocumentos;

var  PendienteCobro,
     PendienteFacturar : Decimal;

begin
     DesactivaDatasets;

     FechaInicial := LowestDateTime;
     FechaFinal := HighestDateTime;
     EjercicioInicial := 0;
     EjercicioFinal := MaxSmallint;

     case PageControl.ActivePageIndex of
       0 : begin

           // TipoMovimiento;Propietario;Fecha

           With PresupuestoTable do
             begin
             SetRange( [ tmPresupuesto, ClienteTableCodigo.Value, FechaFinal ], [ tmPresupuesto, ClienteTableCodigo.Value, FechaInicial ] );
             Refresh;
             end;

           PresupuestoData.Enabled := True;
           end;

       1 : begin

           // TipoMovimiento;Propietario;Fecha

           With PedidoVentasTable do
             begin
             SetRange( [ tmPedidoVenta, ClienteTableCodigo.Value, FechaFinal ], [ tmPedidoVenta, ClienteTableCodigo.Value, FechaInicial ] );
             Refresh;
             end;

           PedidoVentasData.Enabled := True;
           end;

       2 : begin

           // TipoMovimiento;Propietario;Fecha

           With MovimientoAlmacenTable do
             begin
             SetRange( [ tmVenta, ClienteTableCodigo.Value, FechaFinal ], [ tmVenta, ClienteTableCodigo.Value, FechaInicial ] );
             Refresh;
             end;

           MovimientoAlmacenData.Enabled := True;

           If   RelacionesCliente.DmClienteDatEconTable.FindKey( [ ApplicationContainer.Ejercicio, ClienteTableCodigo.Value ] )
           then PendienteFacturar := RelacionesCliente.ClienteDatEconFields.Pendiente.Value
           else PendienteFacturar := 0.0;

           PendienteFacturarBox.Caption := StrFormat( PendienteFacturar, DecimalesMoneda );

           end;

       3 : begin

           // CodigoCliente;Fecha

           With FacturaVentasTable do
             begin
             SetRange( [ ClienteTableCodigo.Value, FechaFinal ], [ ClienteTableCodigo.Value, FechaInicial ] );
             Refresh;
             end;

           FacturaVentasData.Enabled := True;

           //*  06.11.2000 Añadido el pendiente de cobro

           PendienteCobro := Saldos.SaldoPeriodo( ClienteTableSubcuenta.Value, '', True, ApplicationContainer.Ejercicio, 0, ApplicationContainer.NroMesFinal ).Saldo;
           PendienteCobroBox.Caption := StrFormat( PendienteCobro, DecimalesMoneda );

           end;

       4 : begin

           // Cliente;FechaLibramiento

           With EfectoCobrarTable do
             begin
             SetRange( [ ClienteTableSubcuenta.Value, FechaFinal ], [ ClienteTableSubcuenta.Value, FechaInicial ] );
             Refresh;
             end;

           EfectoCobrarData.Enabled := True;
           end;

       end;

end;

procedure TBrwRdcForm.EfectoCobrarTableCalcFields(DataSet: TDataSet);
begin
     If   Assigned( EfectoCobrarFields )
     then EfectoCobrarTablePendiente.Value := EfectoCobrar.EfectoPendiente( EfectoCobrarFields );
end;

function TBrwRdcForm.EfectoCobrarTableCheckValidRecord(Dataset: TDataSet): Boolean;
begin
     Result := not SoloPendientesCtrl.Checked or EfectoCobrarTablePendiente.Value;
end;

procedure TBrwRdcForm.EfectoCobrarViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     FijaColorLineaPendiente( ACanvas, VarToBoolean(AViewInfo.GridRecord.Values[ EfectoCobrarViewPendiente.Index ] ) );
end;

function TBrwRdcForm.EfectosTableViewManagerCanShowOrigin: Boolean;
begin
     Result := EfectoCobrarView.Controller.SelectedRowCount=1;
end;

function TBrwRdcForm.EfectosTableViewManagerShowOrigin: Boolean;
begin
     MntEfectosCobrar( [ EfectoCobrarTableEjercicio.Value, EfectoCobrarTableSerie.Value, EfectoCobrarTableNroFactura.Value, EfectoCobrarTableNroEfecto.Value ] );
end;

procedure TBrwRdcForm.EfectosTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     EfectosTableViewManagerShowOrigin;
end;

procedure TBrwRdcForm.FijaColorLineaPendiente( ACanvas   : TcxCanvas;
                                               Pendiente : Boolean );
begin
     With ACanvas do
       If   not SoloPendientesCtrl.Checked and Pendiente
       then begin
            Brush.Color := clLightRed;
            Font.Color := clBlack;
            end;

end;

end.

