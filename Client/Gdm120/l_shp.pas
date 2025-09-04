
unit l_shp;

interface

uses StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms, ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  dxmdaset, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  cxGraphics, cxIndexedComboBox, cxPC, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, cxLabel,
  cxGroupBox, cxPCdxBarPopupMenu, dxBarBuiltInMenu, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, dxScrollbarAnnotations,

  EditSelector,

  AppContainer,
  AppForms,
  DataManager,
  ReportManager,

  Gim10Fields,
  Gim30Fields,

  dm_hpd120;

type
    TRptShpForm = class(TgxForm)
    FormManager: TgxFormManager;
    MovimientoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    DataPanel: TgxEditPanel;
    Report: TgxReportManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataNroDocumentoInicial: TIntegerField;
    DataNroDocumentoFinal: TIntegerField;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    gxRangeBox2: TgxRangeBox;
    NroDocumentoInicialCtrl: TcxDBTextEdit;
    NroDocumentoFinalCtrl: TcxDBTextEdit;
    TabSheet2: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    Label27: TcxLabel;
    DocumentoLabel: TcxLabel;
    Label6: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    SeriesFacturacionTable: TnxeTable;
    SeriesFacturacionTableNroRegistro: TSmallintField;
    SeriesFacturacionTableCodigo: TStringField;
    SeriesFacturacionTableDescripcion: TStringField;
    SeriesFacturacionDataSource: TDataSource;
    GridViewRepository: TcxGridViewRepository;
    SeriesFacturacionTableView: TcxGridDBTableView;
    SeriesFacturacionTableViewCodigo: TcxGridDBColumn;
    SeriesFacturacionTableViewDescripcion: TcxGridDBColumn;
    DataSerieInicial: TStringField;
    DataSerieFinal: TStringField;
    SerieRangeBox: TgxRangeBox;
    SerieInicialCtrl: TcxDBTextEdit;
    SerieFinalCtrl: TcxDBTextEdit;
    cxLabel6: TcxLabel;
    SerieEditSelector: TgxEditSelector;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    SeriePanel: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure SerieFacturacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieFacturacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SeriesFacturacionTableViewCodigoPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure ReportSetReportName;
    private
    protected
       class var CostesAsociados : Boolean;
    public
      MovimientoFields,
      PedidoCompraFields,
      AlbaranCompraFields : TMovimientoFields;
      LineaMovimientoFields,
      LineaPedidoCompraFields,
      LineaAlbaranCompraFields : TLineaMovimientoFields;
      SerieFacturacionFields : TSerieFacturacionFields;
      HojaPedidoTable : TnxeTable;
      HojaPedidoFields : THojaPedidoFields;
      end;

var  RptShpForm: TRptShpForm = nil;

procedure ListadoSituacionHojasPedido( CostesAsociados : Boolean = False );


implementation

uses   SysUtils,
       LibUtils,

       Gdm00Dm,
       Gdm30Dm,

       Gim00Fields,

       dmi_mov,
       dmi_sto,

       dm_sto,
       dm_cls,
       dm_cli,
       dm_art,
       dm_mov,
       dm_fdc,
       dm_fdv,
       dm_alm,
       dm_sdf,
       dm_pro,

       b_msg,

       cx_art,
       cx_cli,
       cx_alm,
       cx_ven,
       cx_fco,
       cx_rac,
       cx_gdc,
       cx_sdf;

{$R *.DFM}

resourceString
       RsTituloCostesAsociados = 'Listado de costes asociados a hojas de pedido';

procedure ListadoSituacionHojasPedido( CostesAsociados : Boolean = False );
begin
     TRptShpForm.CostesAsociados := CostesAsociados;
     CreateReportForm( TRptShpForm, RptShpForm );
end;

procedure TRptShpForm.InitializeForm;
begin

     If   CostesAsociados
     then Caption := RsTituloCostesAsociados;

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );

     PedidoCompraFields := TMovimientoFields.Create( Self );
     LineaPedidoCompraFields := TLineaMovimientoFields.Create( Self );
     AlbaranCompraFields := TMovimientoFields.Create( Self );
     LineaAlbaranCompraFields := TLineaMovimientoFields.Create( Self );
     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );

     SetupPanelableCtrl( SerieInicialCtrl, DataModule00.DmEmpresaFields.Ventas_SeriesPedido.Value, { AdjustFormHeight } True );

     DataSerieFinal.Value := HighStrCode;
     DataNroDocumentoInicial.Value := 1;
     DataNroDocumentoFinal.Value := 99999999;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;

end;

procedure TRptShpForm.ReportSetReportName;
begin
     With Report do
       If   CostesAsociados
       then FileName := 'dm120\l_chp'
       else FileName := 'dm120\l_shp';
end;

procedure TRptShpForm.SerieFacturacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( sender );
end;

procedure TRptShpForm.SerieFacturacionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptShpForm.SeriesFacturacionTableViewCodigoPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, SerieFacturacionFields );
     If   not Error and SeriesFacturacionTable.Editing
     then SeriesFacturacionTableDescripcion.Value := SerieFacturacionFields.Descripcion.Value;
end;

procedure TRptShpForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var  SerieInicial,
     SerieFinal : String;
     ExistenciasArticulo : IExistenciasArticulo;

begin

     With MovimientoTable, MovimientoFields do
       try

         case PageControl.ActivePageIndex of
           0 : begin
               IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';
               SerieEditSelector.GetRangeSelection( SerieInicial, SerieFinal );
               SetRange( [ tmPedidoVenta, ApplicationContainer.Ejercicio, SerieInicial, DataNroDocumentoInicial.Value ],
                         [ tmPedidoVenta, ApplicationContainer.Ejercicio, SerieFinal, DataNroDocumentoFinal.Value ] );
               end;
           1 : begin
               IndexFieldNames := 'TipoMovimiento;Fecha';
               SetRange( [ tmPedidoVenta, DataFechaInicial.Value ], [ tmPedidoVenta, DataFechaFinal.Value ] );
               end;
          end;

         ApplicationContainer.StartProgression( RecordCount );

         First;
         While not Eof do
           begin

           With MovimientoFields do
             If   SerieEditSelector.ValidValue( Serie.Value )
             then With LineaMovimientoTable do
                    begin

                    With MovimientoFields do
                      SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

                    First;
                    While not Eof do
                      begin

                      // Ejercicio, Serie, NroDocumento, CodigoProveedor, NroLinea

                      var ExistePedidoCompra := False;
                      var ExisteAlbaranCompra := False;

                      If   HojasDePedido120.ObtenLineaMovimientoDestino( LineaMovimientoFields ) and
                           ( HojasDePedido120.LineaMovimientoDestinoFields.CantidadProcesada.Value>0.0 )
                      then begin

                           ExistePedidoCompra := True;
                           PedidoCompraFields.Update( HojasDePedido120.DmMovimientoDestinoTable );
                           LineaPedidoCompraFields.Update( HojasDePedido120.DmLineaMovimientoDestinoTable );

                           // Obtengo el albarán al que se ha exportado el pedido de compra (si existe)

                           If   CostesAsociados and
                                ( LineaPedidoCompraFields.Parametros.Value<>1 ) and  // Esta marcada como 'No pedir al proveedor'. No hace falta comprobar si existe el pedido de compra.
                                HojasDePedido120.ObtenLineaMovimientoDestino( LineaPedidoCompraFields, tmPedidoCompra, tmCompra )
                           then begin
                                ExisteAlbaranCompra := True;
                                AlbaranCompraFields.Update( HojasDePedido120.DmMovimientoDestinoTable );
                                LineaAlbaranCompraFields.Update( HojasDePedido120.DmLineaMovimientoDestinoTable );
                                end;

                           end;

                      If   not CostesAsociados or ExistePedidoCompra
                      then begin

                           HojaPedidoTable.Append;

                           HojaPedidoFields.Ejercicio.Value := MovimientoFields.Ejercicio.Value;
                           HojaPedidoFields.Serie.Value := MovimientoFields.Serie.Value;
                           HojaPedidoFields.NroDocumento.Value := MovimientoFields.NroDocumento.Value;
                           HojaPedidoFields.NroOperacion.Value := MovimientoFields.NroOPeracion.Value;
                           HojaPedidoFields.Fecha.Value := MovimientoFields.Fecha.Value;
                           HojaPedidoFields.FechaEntrega.Value := MovimientoFields.FechaAplicacion.Value;
                           HojaPedidoFields.CodigoCliente.Value := MovimientoFields.Propietario.Value;
                           HojaPedidoFields.NombreCliente.Value := Cliente.Descripcion( MovimientoFields.Propietario.Value );
                           HojaPedidoFields.NroLinea.Value := LineaMovimientoFields.NroLinea.Value;
                           HojaPedidoFields.CodigoArticulo.Value  := LineaMovimientoFields.CodigoArticulo.Value;
                           HojaPedidoFields.CodigoClaseA.Value := LineaMovimientoFields.CodigoClaseA.Value;
                           HojaPedidoFields.CodigoClaseB.Value := LineaMovimientoFields.CodigoClaseB.Value;
                           HojaPedidoFields.CodigoClaseC.Value := LineaMovimientoFields.CodigoClaseC.Value;
                           HojaPedidoFields.Descripcion.Value := LineaMovimientoFields.Descripcion.Value;
                           HojaPedidoFields.CodigoAlmacen.Value := LineaMovimientoFields.CodigoAlmacen.Value;
                           HojaPedidoFields.NombreAlmacen.Value := Almacen.Descripcion( LineaMovimientoFields.CodigoAlmacen.Value );
                           HojaPedidoFields.Cantidad.Value := LineaMovimientoFields.CantidadAjustada.Value;
                           HojaPedidoFields.Servido.Value := LineaMovimientoFields.CantidadProcesada.Value;
                           HojaPedidoFields.Precio.Value := LineaMovimientoFields.Precio.Value;
                           HojaPedidoFields.ImporteBruto.Value := LineaMovimientoFields.ImporteBruto.Value;
                           HojaPedidoFields.Descuento.Value := LineaMovimientoFields.Descuento.Value;
                           HojaPedidoFields.Recargo.Value := LineaMovimientoFields.Recargo.Value;
                           HojaPedidoFields.ImporteNeto.Value := LineaMovimientoFields.ImporteNeto.Value;

                           ExistenciasArticulo := StockAlmacen.ObtenStock( HojaPedidoFields.CodigoArticulo.Value,
                                                                           False,
                                                                           HojaPedidoFields.CodigoClaseA.Value,
                                                                           HojaPedidoFields.CodigoClaseB.Value,
                                                                           HojaPedidoFields.CodigoClaseC.Value,
                                                                           True,
                                                                           '',
                                                                           False,
                                                                           HojaPedidoFields.CodigoAlmacen.Value,
                                                                           True,
                                                                           '',
                                                                           True,
                                                                           ApplicationContainer.Ejercicio,
                                                                           0,
                                                                           ApplicationContainer.NroMesFinal );

                           HojaPedidoFields.Existencias.Value := ExistenciasArticulo.SumaExistencias.Saldo;
                           HojaPedidoFields.ExistenciasVirtuales.Value := HojaPedidoFields.Cantidad.Value + ExistenciasArticulo.SumaExistencias.Saldo;

                           If   ExistePedidoCompra
                           then begin
                                HojaPedidoFields.Ejercicio1.Value := PedidoCompraFields.Ejercicio.Value;
                                HojaPedidoFields.Serie1.Value := PedidoCompraFields.Serie.Value;
                                HojaPedidoFields.NroDocumento1.Value := PedidoCompraFields.NroDocumento.Value;
                                HojaPedidoFields.NroOperacion1.Value := PedidoCompraFields.NroOperacion.Value;
                                HojaPedidoFields.CodigoProveedor.Value := PedidoCompraFields.Propietario.Value;
                                HojaPedidoFields.NombreProveedor.Value := Proveedor.Descripcion( HojaPedidoFields.CodigoProveedor.Value );
                                HojaPedidoFields.Recibido.Value := LineaPedidoCompraFields.CantidadProcesada.Value;
                                end;

                           If   ExisteAlbaranCompra
                           then begin
                                HojaPedidoFields.Ejercicio2.Value := AlbaranCompraFields.Ejercicio.Value;
                                HojaPedidoFields.Serie2.Value := AlbaranCompraFields.Serie.Value;
                                HojaPedidoFields.NroDocumento2.Value := AlbaranCompraFields.NroDocumento.Value;
                                HojaPedidoFields.NroOperacion2.Value := AlbaranCompraFields.NroOperacion.Value;
                                HojaPedidoFields.PrecioCompra.Value := LineaAlbaranCompraFields.Precio.Value;
                                end
                           else HojaPedidoFields.PrecioCompra.Value := ExistenciasArticulo.CosteUltEntrada;

                           HojaPedidoTable.Post;

                           end;

                      Next;
                      end;

                    end;

           ApplicationContainer.ShowProgression;
           Next;
           end;

       finally
         ApplicationContainer.EndProgression;
         end;

     CheckEmptyReportTable( HojaPedidoTable );

end;

begin
     With Report do
       try

         Load;

         HojaPedidoTable := Report.CreateEmptyTable( 'HojaPedido', HojasDePedido120.SQLSet.GetSQLText( 'HojaPedido' ) );
         HojaPedidoFields := THojaPedidoFields.Create( HojaPedidoTable );

         HojaPedidoTable.IndexFieldNames := 'Ejercicio;Serie;NroDocumento;CodigoProveedor;NroLinea';

         SeleccionaRegistros;

         Clase.SetReportTitles( Report, 4 );

         FacturaCompras.FijaDecimalesInforme( Report );
         FacturaVentas.FijaDecimalesInforme( Report );


         SetValue( RsTextoSeleccionSeries, IfThen( DataModule00.DmEmpresaFields.Ventas_SeriesPedido.Value, SerieEditSelector.GetReportSelectionText, '' ) );
         SetValue( RsSeleccion, PageControl.ActivePageIndex );

         Start;

       except on E : Exception do
         Cancel( E );
         end;
end;

end.
