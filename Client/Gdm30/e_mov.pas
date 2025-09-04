
unit e_mov;

interface

uses StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms, ComCtrls, Grids,
     DB, nxdb, Menus, cxLookAndFeelPainters, cxButtons,
     dxmdaset, cxPC, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
     cxMaskEdit, cxDropDownEdit, cxCalendar, cxGroupBox, cxRadioGroup,
     cxSpinEdit, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
     cxDataStorage, cxDBData, cxGridLevel, cxGridCustomTableView,
     cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
     dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
     cxDataControllerConditionalFormattingRulesManagerDialog,
     cxLookAndFeels, cxLabel, cxPCdxBarPopupMenu, cxNavigator,
     dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations, cxIntegerEdit,

     AppContainer,
     Gim10Fields,
     Gim30Fields,

     Spring,
     Datamanager,
     ReportManager,
     EnterpriseDataAccess,
     AppForms,
     GridTableViewController,

     dmi_mov,

     dm_ine, dxUIAClasses;


type

    TOnObtenNroCopiasEvent = procedure( LineaMovimientoFields : TLineaMovimientoFields; var NroCopias : SmallInt ) of object;

    TEtqMovForm = class(TgxForm)
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    Report: TgxReportManager;
    MovimientoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataFormato: TSmallintField;
    DataPropietario: TWideStringField;
    DataSerie: TWideStringField;
    DataNroDocumentoInicial: TIntegerField;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataContenedor: TSmallintField;
    DataPrimeraPosicion: TSmallintField;
    DataNroDocumentoFinal: TIntegerField;
    BottomPanel: TcxGroupBox;
    FormatoCtrl: TcxDBSpinEdit;
    PrimeraPosicionCtrl: TcxDBSpinEdit;
    GridDataTable: TnxeTable;
    GridDataTableNroLinea: TSmallintField;
    GridDataTableCodigo: TWideStringField;
    GridDataTableDescripcion: TWideStringField;
    GridDataTableNroCopias: TSmallintField;
    GridDataTableNroRegistro: TIntegerField;
    GridDataSource: TDataSource;
    ClientPanel: TcxGroupBox;
    GridPanel: TcxGroupBox;
    GridTableViewController1: TGridTableViewController;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewNroCopias: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    ContenedorCtrl: TcxDBRadioGroup;
    GridDataTableNroBultoAlbaran: TIntegerField;
    GridDataTableNroBultosAlbaran: TIntegerField;
    GridDataTableNroBultosLinea: TIntegerField;
    Label8: TcxLabel;
    Label16: TcxLabel;
    FormatoLabel: TcxLabel;
    Label9: TcxLabel;
    TopPanel: TcxGroupBox;
    SelectionPanel: TcxGroupBox;
    Label5: TcxLabel;
    PageControl: TcxPageControl;
    NroDocumentoTS: TcxTabSheet;
    gxRangeBox3: TgxRangeBox;
    DocumentoLabel: TcxLabel;
    NroDocumentoInicialCtrl: TcxDBTextEdit;
    NroDocumentoFinalCtrl: TcxDBTextEdit;
    PropietarioFechaTS: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    Label4: TcxLabel;
    Label7: TcxLabel;
    Label6: TcxLabel;
    Label11: TcxLabel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    SeriePanel: TcxGroupBox;
    Label1: TcxLabel;
    Label2: TcxLabel;
    SerieFacturacionCtrl: TcxDBTextEdit;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    GridDataTableVolumenAlbaran: TCurrencyField;
    GridDataTableKilosAlbaran: TCurrencyField;
    cxGroupBox1: TcxGroupBox;
    DocumentoTS: TcxTabSheet;
    PropietarioCtrl: TcxDBTextEdit;
    SerieCtrl: TcxDBTextEdit;
    NroAlbaranCtrl: TcxDBIntegerEdit;
    cxLabel1: TcxLabel;
    Label3: TcxLabel;
    cxLabel2: TcxLabel;
    Label10: TcxLabel;
    DataNroDocumento: TIntegerField;
    Bevel1: TShape;
    TarifaCtrl: TcxDBTextEdit;
    Label19: TcxLabel;
    cxLabel3: TcxLabel;
    DataTarifa: TWideStringField;
    cxLabel4: TcxLabel;
    procedure ReportSetReportName;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ReportSelectPrinter;
    procedure NroDocumentoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerPreparedForm;
    procedure GridViewCodigoPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieFacturacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieFacturacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TopPanelExit(Sender: TObject);
    procedure ContenedorCtrlPropertiesValuePosted(Sender: TObject);
    procedure CodigoProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure NroAlbaranCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TarifaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TarifaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure GridDataTableNewRecord(DataSet: TDataSet);
    procedure GridViewCodigoPropertiesValuePosted(Sender: TObject);
    private

      ModeloImpreso : TModeloImpreso;

      FOnObtenNroCopias : Event< TOnObtenNroCopiasEvent >;

      procedure ActualizaRejilla;
      procedure DoOnSelect( Target : TcxCustomEdit = nil );

    public

      class var
      TipoMovimiento : TTipoMovimiento;
      Serie : String;
      NroDocumento : LongInt;
      CodigoPropietario : String;

      RptEtiquetaArticuloTable : TnxeTable;
      RptEtiquetaArticuloFields : TEtiquetaArticuloFields;
      MovimientoFields : TMovimientoFields;
      LineaMovimientoFields : TLineaMovimientoFields;
      TiposIVAFields : TTiposIVAFields;
      DsArticuloFields : TArticuloFields;

      property OnObtenNroCopias : Event< TOnObtenNroCopiasEvent > read FOnObtenNroCopias write FOnObtenNroCopias;
    end;

var  EtqMovForm: TEtqMovForm = nil;

procedure EtiquetasArticulosDesdeMovimientos( TipoMovimiento : TTipoMovimiento;
                                              Serie          : String;
                                              NroDocumento   : LongInt;
                                              CodigoPropietario  : String );

implementation

uses   SysUtils,
       LibUtils,
       AppManager,

       Gdm00Dm,
       Gdm30Dm,
       Gim00Fields,

       dm_pro,
       dm_cli,
       dm_cdt,
       dm_tma,
       dm_art,
       dm_cls,
       dm_iva,
       dm_sdf,
       dm_fdc,
       dm_fdv,
       dm_mov,

       a_imp,

       b_msg,

       cx_pro,
       cx_cli,
       cx_art,
       cx_imp,
       cx_sdf,
       cx_mco,
       cx_mov,
       cx_mve,
       cx_cdt;

{$R *.DFM}

resourceString
       RsNroOperacion = 'Nº de operación';

procedure EtiquetasArticulosDesdeMovimientos( TipoMovimiento : TTipoMovimiento;
                                              Serie          : String;
                                              NroDocumento   : LongInt;
                                              CodigoPropietario  : String );
begin
     TEtqMovForm.TipoMovimiento := TipoMovimiento;
     TEtqMovForm.Serie := Serie;
     TEtqMovForm.NroDocumento := NroDocumento;
     TEtqMovForm.CodigoPropietario := CodigoPropietario;
     CreateEditForm( TEtqMovForm, EtqMovForm );
end;

procedure TEtqMovForm.InitializeForm;
begin

     Id := IdEtqMovForm;

     MovimientoFields  := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     TiposIVAFields := TTiposIVAFields.Create( Self );

     DsArticuloFields := TArticuloFields.Create( Self );

     DocumentoLabel.Caption := Movimiento.TextoNroDocumento( TipoMovimiento );

     { El origen por tipo de movimiento permitidos son :
         Albaranes de compra
         Pedidos de venta
         Albaranes de venta
         Movimientos (desde el mantenimiento correspondiente)
     }

     If   not ( ( TipoMovimiento in [ tmPedidoVenta, tmVenta ] ) and Movimiento.SeriesEnDocumentosVenta( TipoMovimiento ) )
     then SetupPanelableCtrl( SerieFacturacionCtrl, False );
          
     DocumentoTS.TabVisible := TipoMovimiento=tmCompra;
     NroDocumentoTS.TabVisible := TipoMovimiento<>tmCompra;

     If   TipoMovimiento<>tmVenta
     then begin
          NroDocumentoTS.Caption := RsNroOperacion;
          PropietarioFechaTS.TabVisible := False;
          end;

     If   TipoMovimiento in [ tmPedidoVenta, tmVenta ]
     then begin
          Report.FileName := 'fee';
          ModeloImpreso := impEtiquetasEnvio;
          end
     else begin
          Report.FileName := 'fea';
          ModeloImpreso := impEtiquetasArticulos;
          With ContenedorCtrl.Properties do
            begin
            Items[ 1 ].Enabled := False;
            Items[ 3 ].Enabled := False;
            end;
          end;

     TarifaCtrl.Enabled := not ( TipoMovimiento in [ tmPedidoVenta, tmVenta ] );

     DataPropietario.Value := CodigoPropietario;
     DataNroDocumento.Value := NroDocumento;
     DataSerie.Value := Serie;
     DataNroDocumentoInicial.Value := NroDocumento;
     DataNroDocumentoFinal.Value := NroDocumento;
     DataCodigoInicial.Value := CodigoPropietario;
     DataCodigoFinal.Value := CodigoPropietario;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataContenedor.Value := 0;

     With ContenedorCtrl.Properties do
       begin
       Items[ 1 ].Enabled := DataModule00.DmEmpresaFields.Articulo_Bultos.Value;
       Items[ 2 ].Enabled := DataModule00.DmEmpresaFields.Articulo_Cajas.Value;
       Items[ 3 ].Enabled := DataModule00.DmEmpresaFields.Articulo_Pallets.Value;
       end;

     DataPrimeraPosicion.Value := 1;

end;

procedure TEtqMovForm.NroAlbaranCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMovimientosCompra( tmCompra, sdTodos, DataPropietario, Sender, qgsNormal, DoOnSelect );
end;

procedure TEtqMovForm.DoOnSelect( Target : TcxCustomEdit = nil );
begin
     With CxMcoForm[ tmCompra ] do
       begin
       DataPropietario.Value := QueryPropietario.Value;
       DataSerie.Value := QuerySerie.Value;
       DataNroDocumento.Value := QueryNroDocumento.Value;
       end;
end;

procedure TEtqMovForm.NroDocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   TipoMovimiento in [ tmPedidoVenta, tmVenta ]
     then ConsultaMovimientosVenta( TipoMovimiento, sdTodos, DataSerie, Sender )
     else ConsultaMovimientos( Sender );
end;

procedure TEtqMovForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( ModeloImpreso ), Sender.EditingValue ] );
end;

procedure TEtqMovForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( ModeloImpreso, Sender );
end;

procedure TEtqMovForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( ModeloImpreso, Sender, DisplayValue, ErrorText, Error );
end;

procedure TEtqMovForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var   Index,
      NroCopiaActualLinea : SmallInt;
      NroUnidadesLinea : Integer;
      
	     _PrecioVenta : Double;
      _PuntoVerde,
      _RecargoVenta,
      _Descuento : Decimal;
      EsUnaOferta : Boolean;
begin
     try

       GridDataTable.DisableControls;

       With RptEtiquetaArticuloTable do
         For Index := 1 to DataPrimeraPosicion.Value - 1 do
           begin
           Append;
           Post;
           end;

       LineaMovimientoTable.IndexFieldNames := 'NroRegistro';
       MovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion';

       With GridDataTable do
         begin

         ApplicationContainer.StartProgression( RecordCount );

         First;
         While not Eof do
           begin

           For NroCopiaActualLinea := 1 to GridDataTableNroCopias.Value do
             begin

             If   LineaMovimientoTable.FindKey( [ GridDataTableNroRegistro.Value ] )
             then If   MovimientoTable.FindKey( [ LineaMovimientoFields.Ejercicio.Value, LineaMovimientoFields.NroOperacion.Value] )
                    then begin

                         Articulo.Obten( LineaMovimientoFields.CodigoArticulo.Value, DsArticuloFields );

                         NroUnidadesLinea := Trunc( Abs( LineaMovimientoFields.Cantidad.Value ) );

                         With RptEtiquetaArticuloFields do
                           begin

                           RptEtiquetaArticuloTable.Append;

                           NroRegistro.Value := LineaMovimientoFields.NroRegistro.Value;
                           Codigo.Value := LineaMovimientoFields.CodigoArticulo.Value;
                           CodigoClaseA.Value := LineaMovimientoFields.CodigoClaseA.Value;
                           DescripcionClaseA.Value := Clase.Descripcion( tcClaseA, CodigoClaseA.Value, False );
                           CodigoClaseB.Value := LineaMovimientoFields.CodigoClaseB.Value;
                           DescripcionClaseB.Value := Clase.Descripcion( tcClaseB, CodigoClaseB.Value, False );
                           CodigoClaseC.Value := LineaMovimientoFields.CodigoClaseC.Value;
                           DescripcionClaseC.Value := Clase.Descripcion( tcClaseC, CodigoClaseC.Value, False );
                           Descripcion.Value := LineaMovimientoFields.Descripcion.Value;
                           CodigoBarras.Value := DsArticuloFields.CodigoBarras.Value;
                           LoteFabricacion.Value := LineaMovimientoFields.LoteFabricacion.Value;
                           NumeroSerie.Value := LineaMovimientoFields.NumeroSerie.Value;
                           ReferenciaCliente.Value := Articulo.ReferenciaCliente( MovimientoFields.Propietario.Value, Codigo.Value );
                           CodigoAlmacen.Value := LineaMovimientoFields.CodigoAlmacen.Value;
                           Ubicacion.Value := LineaMovimientoFields.Ubicacion.Value;
                           TipoLinea.Value := LineaMovimientoFields.TipoLinea.Value;
                           Cantidad.Value := Abs( LineaMovimientoFields.Cantidad.Value );
                           Anotacion.Value := DsArticuloFields.Anotacion.Value;

                           Tasa.TipoIVA( ApplicationContainer.TodayDate, DsArticuloFields.TipoIVA.Value, TiposIVAFields );

                           TipoIVA.Value := TiposIVAFields.IVARepercutido.Value;
                           Descuento.Value := LineaMovimientoFields.Descuento.Value;

                           Precio.Value := LineaMovimientoFields.Precio.Value;
                           PrecioIVAIncluido.Value := LineaMovimientoFields.PrecioIVA.Value;

                           If   ModeloImpreso=impEtiquetasArticulos // o lo que es lo mismo, si el movimiento no es tmPedidoVenta o tmVenta
                           then begin

                                _PrecioVenta := 0.0;
                                _PuntoVerde := 0.0;
                                _RecargoVenta := 0.0;
                                _Descuento := 0.0;
                                EsUnaOferta := False;

                                Articulo.ObtenPrecioyDtoVenta( tmNoDefinido,
                                                               '',    // Ningún cliente en concreto
                                                               Codigo.Value,
                                                               CodigoClaseA.Value,
                                                               CodigoClaseB.Value,
                                                               CodigoClaseC.Value,
                                                               -1.0,  // Para que no se tengan en cuenta las cantidades minimas
                                                               _PrecioVenta,
                                                               _PuntoVerde,
                                                               _RecargoVenta,
                                                               _Descuento,
                                                               EsUnaOferta,
                                                               DataTarifa.Value,
                                                               True );

                                PrecioVenta.Value := _PrecioVenta;
                                PrecioVentaIVAIncluido.Value := Redondea( PrecioVenta.Value + ( ( PrecioVenta.Value * TipoIVA.Value ) / 100.0 ) );
                                PuntoVerde.Value := _PuntoVerde;
                                RecargoVenta.Value := _RecargoVenta;
                                Descuento.Value := _Descuento;

                                If   TipoMovimiento in [ tmPedidoCompra, tmCompra ]
                                then begin
                                     Proveedor_Codigo.Value := MovimientoFields.Propietario.Value;
                                     ReferenciaProveedor.Value := Articulo.ReferenciaProveedor( MovimientoFields.Propietario.Value, Codigo.Value, True );
                                     end;

                                end
                           else begin

                                PrecioVenta.Value := LineaMovimientoFields.Precio.Value;
                                PrecioVentaIVAIncluido.Value := LineaMovimientoFields.PrecioIVA.Value;
                                Bultos.Value := DsArticuloFields.Bultos.Value;
                                Volumen.Value := DsArticuloFields.Volumen.Value;
                                Kilos.Value := DsArticuloFields.Kilos.Value;

                                If   DataContenedor.Value=1   // Impresión por bultos
                                then begin
                                     NroBultoLinea.Value := NroCopiaActualLinea;
                                     NroBultoAlbaran.Value := GridDataTableNroBultoAlbaran.Value;
                                     NroBultosLinea.Value := GridDataTableNroBultosLinea.Value;
                                     VolumenLinea.Value := Volumen.Value * NroUnidadesLinea;
                                     KilosLinea.Value := Kilos.Value * NroUnidadesLinea;
                                     end;

                                NroBultosAlbaran.Value := GridDataTableNroBultosAlbaran.Value;
                                VolumenAlbaran.Value := GridDataTableVolumenAlbaran.Value;
                                KilosAlbaran.Value := GridDataTableKilosAlbaran.Value;

                                // Aquí es seguro que es un tmPedidoVenta o tmVenta

                                Cliente_Codigo.Value := MovimientoFields.Propietario.Value;

                                If   TipoMovimiento=tmPedidoVenta
                                then begin
                                     EjercicioPedido.Value := MovimientoFields.Ejercicio.Value;;
                                     NroOperacionPedido.Value := MovimientoFields.NroOperacion.Value;
                                     NroPedido.Value := MovimientoFields.NroDocumento.Value;
                                     NroLineaPedido.Value := LineaMovimientoFields.NroLinea.Value;
                                     end;

                                CodigoVendedor.Value := MovimientoFields.CodigoVendedor.Value;
                                RegistroAuxiliar.Value := MovimientoFields.RegistroAuxiliar.Value;
                                GrupoCliente.Value := MovimientoFields.GrupoFacturacion.Value;

                                end;

                           EjercicioAlbaran.Value := MovimientoFields.Ejercicio.Value;
                           NroOperacionAlbaran.Value := MovimientoFields.NroOperacion.Value;
                           FechaAlbaran.Value := MovimientoFields.Fecha.Value;
                           SerieAlbaran.Value := MovimientoFields.Serie.Value;
                           NroAlbaran.Value := MovimientoFields.NroDocumento.Value;
                           NroLineaAlbaran.Value := LineaMovimientoFields.NroLinea.Value;

                           If   LineaMovimientoFields.TipoMovimientoOrigen.Value in [ Ord( tmPedidoCompra ), Ord( tmPedidoVenta ) ]
                           then begin
                                Movimiento.ObtenRegistro( LineaMovimientoFields.NroRegistroOrigen.Value );
                                EjercicioPedido.Value := LineaMovimientoFields.EjercicioOrigen.Value;
                                NroOperacionPedido.Value := LineaMovimientoFields.NroOperacionOrigen.Value;
                                NroPedido.Value := LineaMovimientoFields.NroOperacionOrigen.Value;
                                NroLineaPedido.Value := Movimiento.DmLineaMovimientoFields.NroLinea.Value;
                                end;

                           RptEtiquetaArticuloTable.Post;
                           ApplicationContainer.ShowProgression;
                           end;

                         end;
             end;

           Next;
           end;

         end;


     finally
       ApplicationContainer.EndProgression;
       GridDataTable.EnableControls;
       end;

end;

begin
     Enabled := False;

     With Report do
       try

         Load;

         RptEtiquetaArticuloTable := CreateEmptyTable( 'EtiquetaArticulo', DataModule30.SQLSet );
         RptEtiquetaArticuloFields := TEtiquetaArticuloFields.Create( RptEtiquetaArticuloTable );

         SeleccionaRegistros;

         MainDataset := RptEtiquetaArticuloTable;

         FacturaCompras.FijaDecimalesInforme( Report );
         FacturaVentas.FijaDecimalesInforme( Report );

         Start;

       except on E : Exception do Cancel( E );
         end;

end;

procedure TEtqMovForm.FormManagerPreparedForm;
begin
     ActualizaRejilla;
end;

procedure TEtqMovForm.GridDataTableNewRecord(DataSet: TDataSet);
begin
     GridDataTableNroCopias.Value := 1;
end;

procedure TEtqMovForm.GridViewCodigoPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TEtqMovForm.GridViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TEtqMovForm.GridViewCodigoPropertiesValuePosted(Sender: TObject);
begin
     GridDataTableDescripcion.Value := Articulo.Descripcion( GridDataTableCodigo.Value, False );
end;

procedure TEtqMovForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   TipoMovimiento=tmCompra
     then ConsultaProveedores( Sender )
     else ConsultaClientes( Sender );
end;

procedure TEtqMovForm.CodigoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   TipoMovimiento=tmCompra
     then Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True )
     else Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TEtqMovForm.CodigoProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TEtqMovForm.CodigoProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TEtqMovForm.ContenedorCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaRejilla;
end;

procedure TEtqMovForm.ReportSelectPrinter;
begin
     Report.ReportPrinter := InformeExterno.Impresora;
end;

procedure TEtqMovForm.ReportSetReportName;
begin
     Report.FileName := InformeExterno.Fichero;
end;

procedure TEtqMovForm.SerieFacturacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TEtqMovForm.SerieFacturacionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TEtqMovForm.TarifaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosTarifa( Sender );
end;

procedure TEtqMovForm.TarifaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoTarifa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TEtqMovForm.TopPanelExit(Sender: TObject);
begin
     If   Data.Modified
     then ActualizaRejilla;
end;

procedure TEtqMovForm.ActualizaRejilla;

var  NroLinea,
     NroCopias,
     NroBultos : SmallInt;
     Volumen,
     Kilos : Decimal;

     NroUnidadesLinea : Integer;
     NroCopiasLinea,
     TotalCopiasAlbaran,
     NroCopiaActualAlbaran : SmallInt;

     TotalNroBultos : SmallInt;
     TotalVolumenAlbaran,
     TotalKilosAlbaran : Decimal;

function CalculaDatosLinea : Boolean;
begin

     NroCopias := 0;
     NroBultos := 0;
     Volumen := 0.0;
     Kilos := 0.0;

     Result := Articulo.Obten( LineaMovimientoFields.CodigoArticulo.Value, DsArticuloFields );

     If   Result
     then begin
          NroUnidadesLinea := Trunc( Abs( LineaMovimientoFields.Cantidad.Value ) );
          If   DataModule00.DmEmpresaFields.Articulo_Bultos.Value
          then begin

               If   DataModule00.DmEmpresaFields.Ventas_EditarBultosAlbaran.Value and
                    ( LineaMovimientoFields.Bultos.Value<>0.0 )
               then NroBultos := Trunc( LineaMovimientoFields.Bultos.Value )
               else NroBultos := Trunc( DsArticuloFields.Bultos.Value * NroUnidadesLinea );

               Volumen := DsArticuloFields.Volumen.Value * NroUnidadesLinea;
               Kilos := DsArticuloFields.Kilos.Value * NroUnidadesLinea;
               end;

          try

          If   FOnObtenNroCopias.CanInvoke and ( DataContenedor.Value=1 )
          then FOnObtenNroCopias.Invoke( LineaMovimientoFields, NroCopias )
          else case DataContenedor.Value of
                 0 : NroCopias := NroUnidadesLinea;

                 1 : NroCopias := NroBultos;

                 2 : If   LineaMovimientoFields.NroCajas.Value=0
                     then begin

                          // Si el usuario tiene activadas las cajas, la cantidad introducida en la línea del documento es determinante

                          If   not DataModule00.DmEmpresaFields.Articulo_Cajas.Value
                          then If   ( NroUnidadesLinea<>0 )                           and
                                    ( DsArticuloFields.unidadesPorCaja.Value<>0 )
                               then NroCopias := Trunc( NroUnidadesLinea / DsArticuloFields.UnidadesPorCaja.Value );

                          end
                     else NroCopias := Trunc( LineaMovimientoFields.NroCajas.Value );

                 3 : If   ( NroUnidadesLinea<>0 ) and ( DsArticuloFields.UnidadesPorPallet.Value<>0 )
                     then NroCopias := Trunc( NroUnidadesLinea / DsArticuloFields.UnidadesPorPallet.Value );

                 4 : NroCopias := 1;
                 end;


          except
            end;

          end;

end;

begin

     With MovimientoTable do
       begin

       case PageControl.ActivePageIndex of

         0 : begin
             IndexFieldNames := 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento';
             SetRange( [ tmCompra, ApplicationContainer.Ejercicio, DataPropietario.Value, DataSerie.Value, DataNroDocumento.Value ],
                       [ tmCompra, ApplicationContainer.Ejercicio, DataPropietario.Value, DataSerie.Value, DataNroDocumento.Value ] );
             end;

         1 : If   TipoMovimiento in [ tmPedidoVenta, tmVenta ]
             then begin
                  IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';
                  SetRange( [ TipoMovimiento, ApplicationContainer.Ejercicio, DataSerie.Value, DataNroDocumentoInicial.Value ],
                            [ TipoMovimiento, ApplicationContainer.Ejercicio, DataSerie.Value, DataNroDocumentoFinal.Value ] );
                  end
             else begin
                  IndexFieldNames := 'Ejercicio;NroOperacion';
                  SetRange( [ ApplicationContainer.Ejercicio, DataNroDocumentoInicial.Value ],
                            [ ApplicationContainer.Ejercicio, DataNroDocumentoFinal.Value ] );
                  end;

         2 : begin
             IndexFieldNames := 'TipoMovimiento;Propietario;Fecha';
             SetRange( [ TipoMovimiento, DataCodigoInicial.Value, DataFechaInicial.Value ],
                       [ TipoMovimiento, DataCodigoFinal.Value, DataFechaFinal.Value ] );
             end;

         end;

       First;
       try
         GridDataTable.DisableControls;
         GridDataTable.DeleteRecords;
         NroLinea := 1;
         While not Eof do
           begin

           TotalCopiasAlbaran := 0;
           TotalNroBultos := 0;
           TotalVolumenAlbaran := 0.0;
           TotalKilosAlbaran := 0.0;

           With LineaMovimientoTable do
             begin

             IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';

             With MovimientoFields do
               SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

             // Primero calculo los totales del albarán

             First;
             While not Eof do
               begin
               If   LineaMovimientoFields.CodigoArticulo.Value<>ArticuloManual
               then If   CalculaDatosLinea
                    then begin
                         Inc( TotalNroBultos, NroBultos );
                         DecAdd( TotalVolumenAlbaran, Volumen );
                         DecAdd( TotalKilosAlbaran, Kilos );
                         end;
               Next;
               end;

             NroCopiaActualAlbaran := 1;

             First;
             While not Eof do
               begin

               If   LineaMovimientoFields.CodigoArticulo.Value<>ArticuloManual
               then If   CalculaDatosLinea and ( NroCopias<>0 )
                    then With GridDataTable do
                           begin
                           Append;

                           GridDataTableNroLinea.Value := NroLinea;
                           GridDataTableCodigo.Value := LineaMovimientoFields.CodigoArticulo.Value;
                           GridDataTableDescripcion.Value := DsArticuloFields.Descripcion.Value;
                           GridDataTableNroCopias.Value := NroCopias;
                           GridDataTableNroRegistro.Value := LineaMovimientoFields.NroRegistro.Value;

                           If   DataModule00.DmEmpresaFields.Articulo_Bultos.Value
                           then begin
                                GridDataTableNroBultoAlbaran.Value := NroCopiaActualAlbaran;
                                GridDataTableNroBultosLinea.Value := NroBultos;
                                end;

                           GridDataTableNroBultosAlbaran.Value := TotalNroBultos;
                           GridDataTableVolumenAlbaran.Value := TotalVolumenAlbaran;
                           GridDataTableKilosAlbaran.Value := TotalKilosAlbaran;

                           Post;
                           Inc( NroLinea );
                           Inc( NroCopiaActualAlbaran );
                           end;

               Next;
               end;

             end;

           Next;
           end;

         Data.Modified := False;

       finally
         GridDataTable.EnableControls;
         end;
       end;
end;

end.

