unit b_rdp;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes, Windows,
  ExtCtrls, Grids, Graphics, ComCtrls,

  LibUtils,
  AppContainer,
  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, nxdb, DataManager,
  cxCheckBox, cxPC, cxLabel, cxDBLabel, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, dxmdaset,

  Gim10Fields,
  Gim30Fields,
  cxCurrencyEdit, cxMaskEdit, cxDropDownEdit, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, cxGroupBox,
  cxPCdxBarPopupMenu, cxNavigator, dxBarBuiltInMenu, cxIntegerEdit,
  dxDateRanges, AppForms, GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations, dxUIAClasses;

type
  TBrwRdpForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    PageControl: TcxPageControl;
    OfertasTS: TcxTabSheet;
    pedidosTS: TcxTabSheet;
    albaranesTS: TcxTabSheet;
    facturasTS: TcxTabSheet;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Panel2: TcxGroupBox;
    efectosTS: TcxTabSheet;
    ProveedorTable: TnxeTable;
    Data: TDataSource;
    Panel4: TcxGroupBox;
    documentosPendientePanel: TcxGroupBox;
    ProveedorTableCodigo: TWideStringField;
    ProveedorTableNombre: TWideStringField;
    OfertaTable: TnxeTable;
    OfertaView: TcxGridDBTableView;
    OfertaLevel: TcxGridLevel;
    OfertaGrid: TcxGrid;
    OfertaData: TDataSource;
    OfertaViewNroOferta: TcxGridDBColumn;
    OfertaViewFecha: TcxGridDBColumn;
    OfertaViewFechaCancelacion: TcxGridDBColumn;
    OfertaViewImporteBruto: TcxGridDBColumn;
    OfertaViewDescuentoArticulos: TcxGridDBColumn;
    OfertaViewImporteNeto: TcxGridDBColumn;
    OfertaViewRevisado: TcxGridDBColumn;
    PedidoComprasGrid: TcxGrid;
    PedidoComprasView: TcxGridDBTableView;
    PedidoComprasLevel: TcxGridLevel;
    PedidoComprasTable: TnxeTable;
    PedidoComprasData: TDataSource;
    PedidoComprasViewNro_Pedido: TcxGridDBColumn;
    PedidoComprasViewFecha: TcxGridDBColumn;
    PedidoComprasViewFecha_Entrega: TcxGridDBColumn;
    PedidoComprasViewNroPedidoCliente: TcxGridDBColumn;
    PedidoComprasViewImporteBruto: TcxGridDBColumn;
    PedidoComprasViewDescuentoArticulos: TcxGridDBColumn;
    PedidoComprasViewImporteNeto: TcxGridDBColumn;
    PedidoComprasViewTextoSituacion: TcxGridDBColumn;
    MovimientoAlmacenTable: TnxeTable;
    MovimientoAlmacenData: TDataSource;
    MovimientoAlmacenGrid: TcxGrid;
    MovimientoAlmacenView: TcxGridDBTableView;
    MovimientoAlmacenLevel: TcxGridLevel;
    MovimientoAlmacenViewSerie: TcxGridDBColumn;
    MovimientoAlmacenViewNro_Documento: TcxGridDBColumn;
    MovimientoAlmacenViewFecha: TcxGridDBColumn;
    MovimientoAlmacenViewFecha_Emision: TcxGridDBColumn;
    MovimientoAlmacenViewImporteNeto: TcxGridDBColumn;
    MovimientoAlmacenViewNroFactura: TcxGridDBColumn;
    MovimientoAlmacenViewFacturado: TcxGridDBColumn;
    FacturaComprasTable: TnxeTable;
    FacturaComprasData: TDataSource;
    FacturaComprasTableEjercicio: TSmallintField;
    FacturaComprasTableFecha: TDateField;
    FacturaComprasTableNeto_Factura: TBCDField;
    FacturaComprasTableCuota_IVA: TBCDField;
    FacturaComprasTableTotal_Factura: TBCDField;
    FacturaComprasTableTraspasada: TBooleanField;
    EfectoPagarGrid: TcxGrid;
    EfectoPagarView: TcxGridDBTableView;
    EfectoPagarLevel: TcxGridLevel;
    EfectoPagarTable: TnxeTable;
    EfectoPagarData: TDataSource;
    EfectoPagarViewSerie: TcxGridDBColumn;
    EfectoPagarViewNroFactura: TcxGridDBColumn;
    EfectoPagarViewNroEfecto: TcxGridDBColumn;
    EfectoPagarViewFechaLibramiento: TcxGridDBColumn;
    EfectoPagarViewEntidad: TcxGridDBColumn;
    EfectoPagarViewFechaVencimiento: TcxGridDBColumn;
    EfectoPagarViewFechaCobro: TcxGridDBColumn;
    EfectoPagarViewConcepto: TcxGridDBColumn;
    EfectoPagarViewImporte: TcxGridDBColumn;
    EfectoPagarViewImpagado: TcxGridDBColumn;
    ProveedorTableSubcuenta: TWideStringField;
    OfertaViewEstado: TcxGridDBColumn;
    PedidoComprasViewSituacion: TcxGridDBColumn;
    FacturaComprasGrid: TcxGrid;
    FacturaComprasView: TcxGridDBTableView;
    FacturaComprasLevel: TcxGridLevel;
    FacturaComprasViewSerie: TcxGridDBColumn;
    FacturaComprasViewNroFactura: TcxGridDBColumn;
    FacturaComprasViewFecha: TcxGridDBColumn;
    FacturaComprasViewNeto_Factura: TcxGridDBColumn;
    FacturaComprasViewCuota_IVA: TcxGridDBColumn;
    FacturaComprasViewTotal_Factura: TcxGridDBColumn;
    FacturaComprasViewTraspasada: TcxGridDBColumn;
    MovimientoAlmacenViewImporteBruto: TcxGridDBColumn;
    MovimientoAlmacenViewDescuentoArticulos: TcxGridDBColumn;
    OfertaViewAnotacion: TcxGridDBColumn;
    PedidoComprasViewAnotacion: TcxGridDBColumn;
    MovimientoAlmacenViewAnotacion: TcxGridDBColumn;
    FacturaComprasTableAnotacion: TWideMemoField;
    FacturaComprasViewAnotacion: TcxGridDBColumn;
    FacturaComprasViewDtoES: TcxGridDBColumn;
    FacturaComprasViewDtoPP: TcxGridDBColumn;
    FacturaComprasTableProveedor: TWideStringField;
    FacturaComprasTableImporteDtoPP: TBCDField;
    FacturaComprasTableImporteDtoES: TBCDField;
    EfectoPagarTableEjercicio: TSmallintField;
    EfectoPagarTableNroFactura: TIntegerField;
    EfectoPagarTableNroEfecto: TSmallintField;
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
    EfectoPagarTablePendiente: TBooleanField;
    EfectoPagarViewPendiente: TcxGridDBColumn;
    SoloPendientesCtrl: TcxCheckBox;
    OfertaTableEjercicio: TSmallintField;
    OfertaTableNroOperacion: TIntegerField;
    OfertaTableTipoMovimiento: TSmallintField;
    OfertaTablePropietario: TWideStringField;
    OfertaTableSerie: TWideStringField;
    OfertaTableNroDocumento: TIntegerField;
    OfertaTableFecha: TDateField;
    OfertaTableFechaAplicacion: TDateField;
    OfertaTableRevisado: TBooleanField;
    PedidoComprasTableEjercicio: TSmallintField;
    PedidoComprasTableNroOperacion: TIntegerField;
    PedidoComprasTableTipoMovimiento: TSmallintField;
    PedidoComprasTablePropietario: TWideStringField;
    PedidoComprasTableSerie: TWideStringField;
    PedidoComprasTableNroDocumento: TIntegerField;
    PedidoComprasTableFecha: TDateField;
    PedidoComprasTableFechaAplicacion: TDateField;
    PedidoComprasTableSituacion: TSmallintField;
    MovimientoAlmacenTableEjercicio: TSmallintField;
    MovimientoAlmacenTableNroOperacion: TIntegerField;
    MovimientoAlmacenTableTipoMovimiento: TSmallintField;
    MovimientoAlmacenTablePropietario: TWideStringField;
    MovimientoAlmacenTableSerie: TWideStringField;
    MovimientoAlmacenTableNroDocumento: TIntegerField;
    MovimientoAlmacenTableFecha: TDateField;
    MovimientoAlmacenTableFechaAplicacion: TDateField;
    MovimientoAlmacenTableFechaEmision: TDateField;
    MovimientoAlmacenTableFacturado: TBooleanField;
    OfertaTableImporteBruto: TBCDField;
    OfertaTableDescuentosArticulos: TBCDField;
    OfertaTableImporteNeto: TBCDField;
    PedidoComprasTableImporteBruto: TBCDField;
    PedidoComprasTableDescuentosArticulos: TBCDField;
    PedidoComprasTableImporteNeto: TBCDField;
    MovimientoAlmacenTableImporteBruto: TBCDField;
    MovimientoAlmacenTableDescuentosArticulos: TBCDField;
    MovimientoAlmacenTableImporteNeto: TBCDField;
    PedidoComprasTableFechaEmision: TDateField;
    PedidoComprasTableTextoSituacion: TWideStringField;
    OfertasTableViewManager: TGridTableViewController;
    EfectoPagarTableDiferenciaCambio: TBCDField;
    EfectoPagarTableSubcuentaDiferencia: TWideStringField;
    EfectoPagarTableCodigoProveedor: TWideStringField;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    Label3: TcxLabel;
    EfectoPagarViewImportePagado: TcxGridDBColumn;
    EfectoPagarTableAnotacion: TWideMemoField;
    NombreCtrl: TcxDBLabel;
    PedidosTableViewManager: TGridTableViewController;
    MovimientosTableViewManager: TGridTableViewController;
    FacturasTableViewManager: TGridTableViewController;
    EfectosTableViewManager: TGridTableViewController;
    EfectoPagarTableSubcuentaProveedor: TWideStringField;
    EfectoPagarTableSubcuentaEntidad: TWideStringField;
    EfectoPagarTableGenerarEfectoDiferencia: TBooleanField;
    EfectoPagarTableSerie: TWideStringField;
    FacturaComprasViewSerieNroFactura: TcxGridDBColumn;
    EfectoPagarTableSerieNroFactura: TStringField;
    EfectoPagarViewSerieNroFactura: TcxGridDBColumn;
    MovimientoAlmacenTableSerieFactura: TWideStringField;
    Shape1: TShape;
    PendientePagoBox: TcxLabel;
    EfectoPagarTableGastosGestion: TBCDField;
    EfectoPagarTableSubcuentaGastos: TWideStringField;
    FacturaComprasTableSerieNroFactura: TWideStringField;
    EfectoPagarViewNroRemesa: TcxGridDBColumn;
    procedure ProveedorTableGetRecord(DataSet: TDataSet);
    procedure ProveedorTableBeforeEdit(DataSet: TDataSet);
    function OfertaTableCheckValidRecord(Dataset: TDataSet): Boolean;
    procedure EfectoPagarTableAfterOpen(DataSet: TDataSet);
    procedure FacturaComprasViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    function EfectoPagarTableCheckValidRecord(Dataset: TDataSet): Boolean;
    procedure EfectoPagarTableCalcFields(DataSet: TDataSet);
    procedure EfectoPagarViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    function FacturaComprasTableCheckValidRecord(
      Dataset: TDataSet): Boolean;
    function MovimientoAlmacenTableCheckValidRecord(
      Dataset: TDataSet): Boolean;
    procedure PedidoComprasViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure OfertaViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure MovimientoAlmacenViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure MovimientoAlmacenTableCalcFields(DataSet: TDataSet);
    function PedidoComprasTableCheckValidRecord(Dataset: TDataSet): Boolean;
    procedure PedidoComprasTableCalcFields(DataSet: TDataSet);
    procedure OfertaTableCalcFields(DataSet: TDataSet);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormManagerInitializeForm;
    procedure PageControlChange(Sender: TObject);
    procedure FormManagerReportRequest;
    procedure FormManagerSetupToolBar(Enable: Boolean);
    procedure OfertasTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure PedidosTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure MovimientosTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure FacturasTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure EfectosTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure SoloPendientesCtrlPropertiesEditValueChanged(Sender: TObject);
    function OfertasTableViewManagerCanShowOrigin: Boolean;
    function OfertasTableViewManagerShowOrigin: Boolean;
    function PedidosTableViewManagerShowOrigin: Boolean;
    function PedidosTableViewManagerCanShowOrigin: Boolean;
    function MovimientosTableViewManagerCanShowOrigin: Boolean;
    function MovimientosTableViewManagerShowOrigin: Boolean;
    function FacturasTableViewManagerCanShowOrigin: Boolean;
    function FacturasTableViewManagerShowOrigin: Boolean;
    function EfectosTableViewManagerShowOrigin: Boolean;
    function EfectosTableViewManagerCanShowOrigin: Boolean;
  private

    FShowContent : Boolean;

    ImporteBruto,
    DescuentosArticulos,
    ImporteNeto : Decimal;

    procedure ActualizaDocumentos;
    procedure DesactivaDatasets;
    procedure FijaColorLineaPendiente( ACanvas : TcxCanvas; Pendiente : Boolean );

  public
    EfectoPagarFields : TEfectoPagarFields;
  end;

var  BrwRdpForm: TBrwRdpForm = nil;

procedure RelacionDocumentosProveedores( keyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       DateUtils,
       Variants,

       EnterpriseDataAccess,

       Gim00Fields,
       Gdm30Frm,

       dmi_mov,

       dm_mov,
       dm_pro,
       dm_fdc,
       dm_fac,
       dm_tma,
       dm_sal,
       dm_ecp,

       a_pro,
       a_mco,
       a_fdc,
       a_ecp,

       cx_pro,

       r_mov,
       l_fdc,
       l_ecp;

resourceString

       RsMsg4   = 'Pendiente';
       RsMsg5   = 'Parcialm. servido';
       RsMsg6   = 'Servido';
       RsMsg8   = 'Haga doble click (o pulse la barra espaciadora) sobre la línea del documento para acceder a la ventana de mantenimiento del mismo.';

procedure RelacionDocumentosProveedores( KeyValues : array of const );
begin
     CreateEditForm( TBrwRdpForm, BrwRdpForm, KeyValues, TGds30Frm.ResultadosSection );
end;

function TBrwRdpForm.FacturaComprasTableCheckValidRecord(Dataset: TDataSet): Boolean;
begin
     Result := not SoloPendientesCtrl.Checked or ( not FacturaComprasTableTraspasada.Value );
end;

procedure TBrwRdpForm.FacturaComprasViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     FijaColorLineaPendiente( ACanvas, not VarToBoolean( AViewInfo.GridRecord.Values[ FacturaComprasViewTraspasada.Index ] ) );
end;

function TBrwRdpForm.FacturasTableViewManagerCanShowOrigin: Boolean;
begin
     Result := FacturaComprasView.Controller.SelectedRowCount=1;
end;

function TBrwRdpForm.FacturasTableViewManagerShowOrigin: Boolean;
begin
     MntFacturasCompra( [ FacturaComprasTableEjercicio.Value, FacturaComprasTableProveedor.Value, FacturaComprastableSerieNroFactura.Value ] );
end;

procedure TBrwRdpForm.FacturasTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     FacturasTableViewManagerShowOrigin;
end;

procedure TBrwRdpForm.FormManagerInitializeForm;
begin
     SetColumnsDecimals( [ OfertaViewImporteBruto,
                           OfertaViewDescuentoArticulos,
                           OfertaViewImporteNeto,

                           PedidoComprasViewImporteBruto,
                           PedidoComprasViewDescuentoArticulos,
                           PedidoComprasViewImporteNeto,

                           MovimientoAlmacenViewImporteBruto,
                           MovimientoAlmacenViewDescuentoArticulos,
                           MovimientoAlmacenViewImporteNeto,

                           FacturaComprasViewNeto_Factura,
                           FacturaComprasViewDtoPP,
                           FacturaComprasViewDtoES,
                           FacturaComprasViewCuota_IVA,
                           FacturaComprasViewTotal_Factura,

                           EfectoPagarViewImporte,
                           EfectoPagarViewImportePagado ] );

     OfertaGrid.Hint := RsMsg8;
     PedidoComprasGrid.Hint := RsMsg8;
     MovimientoAlmacenGrid.Hint := RsMsg8;
     FacturaComprasGrid.Hint := RsMsg8;
     EfectoPagarGrid.Hint := RsMsg8;

end;

procedure TBrwRdpForm.FormManagerReportRequest;

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
                    TipoMovimiento := tmOferta;
                    With OfertaView.ViewData do
                      If   RowCount>0
                      then begin
                           FechaInicial := Rows[ RowCount - 1 ].Values[ OfertaViewFecha.Index ];
                           FechaFinal := Rows[ 0 ].Values[ OfertaViewFecha.Index ];
                           FijarFechas := True;
                           end;
                    end;
                1 : begin
                    TipoMovimiento := tmPedidoCompra;
                    With PedidoComprasView.ViewData do
                      If   RowCount>0
                      then begin
                           FechaInicial := Rows[ RowCount - 1 ].Values[ PedidoComprasViewFecha.Index ];
                           FechaFinal := Rows[ 0 ].Values[ PedidoComprasViewFecha.Index ];
                           FijarFechas := True;
                           end;
                    end;
                2 : begin
                    TipoMovimiento := tmCompra;
                    With MovimientoAlmacenView.ViewData do
                      If   RowCount>0
                      then begin
                           FechaInicial := Rows[ RowCount - 1 ].Values[ MovimientoAlmacenViewFecha.Index ];
                           FechaFinal := Rows[ 0 ].Values[ MovimientoAlmacenViewFecha.Index ];
                           FijarFechas := True;
                           end;
                    end;
                end;

              ImpresionMovimientos( False, TipoMovimiento, ApplicationContainer.Ejercicio, ProveedorTableCodigo.Value, '', 0 );

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
              ListadoFacturasCompra;
              If   Assigned( RptFdcForm )
              then With RptFdcForm, FacturaComprasView.ViewData do
                     begin
                     If   RowCount>0
                     then begin
                          DataFechaInicial.Value := Rows[ RowCount - 1 ].Values[ FacturaComprasViewFecha.Index ];
                          DataFechaFinal.Value := Rows[ 0 ].Values[ FacturaComprasViewFecha.Index ];
                          end;
                     DataProveedorInicial.Value := ProveedorTableCodigo.Value;
                     DataProveedorFinal.Value := ProveedorTableCodigo.Value;
                     FormManager.ValidateDataArea( faData );
                     end;
              end;

       4 : begin
           ListadoEfectosPagar;
           If   Assigned( RptEcpForm )
           then With RptEcpForm, EfectoPagarView.ViewData do
                  begin
                  If   RowCount>0
                  then begin
                       DataFechaInicial.Value := Rows[ RowCount - 1 ].Values[ EfectoPagarViewFechaVencimiento.Index ];
                       DataFechaFinal.Value := Rows[ 0 ].Values[ EfectoPagarViewFechaVencimiento.Index ];
                       end;
                  DataProveedorInicial.Value := ProveedorTableSubcuenta.Value;
                  DataProveedorFinal.Value := ProveedorTableSubcuenta.Value;
                  If   SoloPendientesCtrl.Checked
                  then DataSituacion.Value := 1
                  else DataSituacion.Value := 0;
                     DataAGruparEntidad.Value := True;
                  FormManager.ValidateDataArea( faData );
                  end;
           end;
       end;


end;

procedure TBrwRdpForm.FormManagerSetupToolBar(Enable: Boolean);
begin
     ApplicationContainer.ReportButton.Enabled := Enable and FormManager.DataAreaFocused;
end;

function TBrwRdpForm.MovimientosTableViewManagerCanShowOrigin: Boolean;
begin
     Result := MovimientoAlmacenView.Controller.SelectedRowCount=1;
end;

function TBrwRdpForm.MovimientosTableViewManagerShowOrigin: Boolean;
begin
     MntMovimientosCompra( [ tmCompra, MovimientoAlmacenTableEjercicio.Value, MovimientoAlmacenTablePropietario.Value, MovimientoAlmacenTableSerie.Value, MovimientoAlmacenTableNroDocumento.Value ] );
end;

procedure TBrwRdpForm.MovimientosTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     MovimientosTableViewManagerShowOrigin;
end;

procedure TBrwRdpForm.ProveedorTableBeforeEdit(DataSet: TDataSet);
begin
     DesactivaDatasets;
end;

procedure TBrwRdpForm.ProveedorTableGetRecord(DataSet: TDataSet);
begin
     ActualizaDocumentos;
end;

procedure TBrwRdpForm.CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TBrwRdpForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TBrwRdpForm.SoloPendientesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ActualizaDocumentos;
     DocumentosPendientePanel.Visible := not SoloPendientesCtrl.Checked;
end;

function TBrwRdpForm.OfertasTableViewManagerCanShowOrigin: Boolean;
begin
     Result := OfertaView.Controller.SelectedRowCount=1;
end;

function TBrwRdpForm.OfertasTableViewManagerShowOrigin: Boolean;
begin
     MntMovimientosCompra( [ tmOferta, OfertaTableEjercicio.Value, OfertaTablePropietario.Value, '', OfertaTableNroDocumento.Value ] );
end;

procedure TBrwRdpForm.OfertasTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     OfertasTableViewManagerShowOrigin;
end;

procedure TBrwRdpForm.MovimientoAlmacenViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean );
begin
     FijaColorLineaPendiente( ACanvas, not VarToBoolean( AViewInfo.GridRecord.Values[ MovimientoAlmacenViewFacturado.Index ] ) );
end;

procedure TBrwRdpForm.OfertaViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     FijaColorLineaPendiente( ACanvas, not VarToBoolean( AViewInfo.GridRecord.Values[ OfertaViewRevisado.Index ] ) );
end;

procedure TBrwRdpForm.OfertaTableCalcFields(DataSet: TDataSet);
begin
     Movimiento.ObtenImporteMovimiento( OfertaTableEjercicio.Value,
                                        OfertaTableNroOperacion.Value,
                                        ImporteBruto,
                                        DescuentosArticulos,
                                        ImporteNeto );

     OfertaTableImporteBruto.Value := ImporteBruto;
     OfertaTableDescuentosArticulos.Value := DescuentosArticulos;
     OfertaTableImporteNeto.Value := ImporteNeto;
end;

function TBrwRdpForm.OfertaTableCheckValidRecord(Dataset: TDataSet): Boolean;
begin
     Result := not not SoloPendientesCtrl.Checked or not OfertaTableRevisado.Value;
end;

procedure TBrwRdpForm.PageControlChange(Sender: TObject);
begin
     ActualizaDocumentos;
end;

procedure TBrwRdpForm.PedidoComprasTableCalcFields(DataSet: TDataSet);
begin
     Movimiento.ObtenImporteMovimiento( PedidoComprasTableEjercicio.Value,
                                        PedidoComprasTableNroOperacion.Value,
                                        ImporteBruto,
                                        DescuentosArticulos,
                                        ImporteNeto );

     PedidoComprasTableImporteBruto.Value := ImporteBruto;
     PedidoComprasTableDescuentosArticulos.Value := DescuentosArticulos;
     PedidoComprasTableImporteNeto.Value := ImporteNeto;

     With PedidoComprasTableTextoSituacion do
       case PedidoComprasTableSituacion.Value of
         0 : Value := RsMsg4;
         1 : Value := RsMsg5;
         2 : Value := RsMsg6;
       end;
end;

function TBrwRdpForm.PedidoComprasTableCheckValidRecord(Dataset: TDataSet): Boolean;
begin
     Result := not SoloPendientesCtrl.Checked or ( PedidoComprasTableSituacion.Value<2 );
end;

procedure TBrwRdpForm.PedidoComprasViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     FijaColorLineaPendiente( ACanvas, ( VarToInteger( AViewInfo.GridRecord.Values[ PedidoComprasViewSituacion.Index ] )<2 ) );
end;

function TBrwRdpForm.PedidosTableViewManagerCanShowOrigin: Boolean;
begin
     Result := PedidoComprasView.Controller.SelectedRowCount=1;
end;

function TBrwRdpForm.PedidosTableViewManagerShowOrigin: Boolean;
begin
     MntMovimientosCompra( [ tmPedidoCompra, PedidoComprasTableEjercicio.Value, PedidoComprasTablePropietario.Value, '', PedidoComprasTableNroDocumento.Value ] );
end;

procedure TBrwRdpForm.PedidosTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     PedidosTableViewManagerShowOrigin;
end;

procedure TBrwRdpForm.MovimientoAlmacenTableCalcFields(DataSet: TDataSet);
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

function TBrwRdpForm.MovimientoAlmacenTableCheckValidRecord(Dataset: TDataSet): Boolean;
begin
     Result := not SoloPendientesCtrl.Checked or not MovimientoAlmacenTableFacturado.Value;
end;

procedure TBrwRdpForm.DesactivaDatasets;
begin
     OfertaData.Enabled := False;
     PedidoComprasData.Enabled := False;
     MovimientoAlmacenData.Enabled := False;
     FacturaComprasData.Enabled := False;
     EfectoPagarData.Enabled := False;
     FShowContent := False;
end;

procedure TBrwRdpForm.ActualizaDocumentos;

var   FechaInicial,
      FechaFinal    : TDateTime;
      EjercicioInicial,
      EjercicioFinal : SmallInt;
      PendientePago : Decimal;

begin
     DesactivaDatasets;

     If   ProveedorTableCodigo.Value<>''
     then begin

          FechaInicial := LowestDateTime;
          FechaFinal := HighestDateTime;
          EjercicioInicial := 0;
          EjercicioFinal := MaxSmallint;

          case PageControl.ActivePageIndex of
            0 : begin

                // TipoMovimiento;Propietario;Fecha

                With OfertaTable do
                  begin
                  SetRange( [ tmOferta, ProveedorTableCodigo.Value, FechaFinal ], [ tmOferta, ProveedorTableCodigo.Value, FechaInicial ] );
                  Refresh;
                  end;

                OfertaData.Enabled := True;
                end;

            1 : begin

                // TipoMovimiento;Propietario;Fecha

                With PedidoComprasTable do
                  begin
                  SetRange( [ tmPedidoCompra, ProveedorTableCodigo.Value, FechaFinal ], [ tmPedidoCompra, ProveedorTableCodigo.Value, FechaInicial ] );
                  Refresh;
                  end;

                PedidoComprasData.Enabled := True;
                end;

            2 : begin

                // TipoMovimiento;Propietario;Fecha

                With MovimientoAlmacenTable do
                  begin
                  SetRange( [ tmCompra, ProveedorTableCodigo.Value, FechaFinal ], [ tmCompra, ProveedorTableCodigo.Value, FechaInicial ] );
                  Refresh;
                  end;

                MovimientoAlmacenData.Enabled := True;
                end;

            3 : begin

                // Proveedor;Fecha

                With FacturaComprasTable do
                  begin
                  SetRange( [ ProveedorTableCodigo.Value, FechaFinal ], [ ProveedorTableCodigo.Value, FechaInicial ] );
                  Refresh;
                  end;

                PendientePago := Saldos.SaldoPeriodo( ProveedorTableCodigo.Value, '', True, ApplicationContainer.Ejercicio, 0, 12 ).Saldo;
                PendientePagoBox.Caption := StrFormat( PendientePago, DecimalesMoneda );

                FacturaComprasData.Enabled := True;
                end;

            4 : begin

                // SubcuentaProveedor;FechaLibramiento

                With EfectoPagarTable do
                  begin
                  SetRange( [ ProveedorTableSubcuenta.Value, FechaFinal ], [ ProveedorTableSubcuenta.Value, FechaInicial ] );
                  Refresh;
                  end;

                EfectoPagarData.Enabled := True;
                end;

            end;
          end;
end;

procedure TBrwRdpForm.EfectoPagarTableAfterOpen(DataSet: TDataSet);
begin
     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );
end;

procedure TBrwRdpForm.EfectoPagarTableCalcFields(DataSet: TDataSet);
begin
     EfectoPagarTableSerieNroFactura.Value := Factura.TextoSerieNroFactura( EfectoPagarTableSerie.Value, EfectoPagarTableNroFactura.Value );

     If   Assigned( EfectoPagarFields )
     then EfectoPagarTablePendiente.Value := EfectoPagar.EfectoPendiente( EfectoPagarFields );
end;

function TBrwRdpForm.EfectoPagarTableCheckValidRecord(Dataset: TDataSet): Boolean;
begin
     Result := not SoloPendientesCtrl.Checked or EfectoPagarTablePendiente.Value;
end;

procedure TBrwRdpForm.EfectoPagarViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     FijaColorLineaPendiente( ACanvas, VarToBoolean( AViewInfo.GridRecord.Values[ EfectoPagarViewPendiente.Index ] ) );
end;

function TBrwRdpForm.EfectosTableViewManagerCanShowOrigin: Boolean;
begin
     Result := EfectoPagarView.Controller.SelectedRowCount=1;
end;

function TBrwRdpForm.EfectosTableViewManagerShowOrigin: Boolean;
begin
     MntEfectosPagar( [ EfectoPagarTableEjercicio.Value, EfectoPagarTableSubcuentaProveedor.Value, EfectoPagarTableSerie.Value, EfectoPagarTableNroFactura.Value, EfectoPagarTableNroEfecto.Value ] );
end;

procedure TBrwRdpForm.EfectosTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     EfectosTableViewManagerShowOrigin;
end;

procedure TBrwRdpForm.FijaColorLineaPendiente( ACanvas   : TcxCanvas;
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

