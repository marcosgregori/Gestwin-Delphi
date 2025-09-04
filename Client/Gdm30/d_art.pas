unit d_art;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes, Windows,
  ExtCtrls,

  LibUtils,
  AppContainer,

  Grids, Graphics, ComCtrls,

  PrintSystem, Menus, cxLookAndFeelPainters,
  cxButtons, cxPC, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  DB, dxmdaset, DataManager, cxCheckBox,

  Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxLookAndFeels,
  cxLabel, cxGroupBox, cxPCdxBarPopupMenu, cxNavigator, dxBarBuiltInMenu,

  dmi_sto, dxDateRanges, AppForms, GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations, cxGridChartView, cxGridDBChartView, dxPScxGridLnk,

  dm_art, dxUIAClasses;

type
  TBrwArtForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    PageControl: TcxPageControl;
    ComprasTabSheet: TcxTabSheet;
    TabSheet3: TcxTabSheet;
    TabSheet1: TcxTabSheet;
    ButtonsPanel: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    GraficosTabSheet: TcxTabSheet;
    leftPanel: TcxGroupBox;
    Panel2: TcxGroupBox;
    Data: TgxMemData;
    DataCodigoArticulo: TWideStringField;
    DataTodasLasClases: TBooleanField;
    DataCodigoClaseA: TWideStringField;
    DataCodigoClaseB: TWideStringField;
    DataCodigoClaseC: TWideStringField;
    DataTodosLosAlmacenes: TBooleanField;
    DataCodigoAlmacen: TWideStringField;
    DataUbicacion: TWideStringField;
    DataSource: TDataSource;
    CodigoArticuloCtrl: TcxDBTextEdit;
    CodigoClaseACtrl: TcxDBTextEdit;
    CodigoClaseBCtrl: TcxDBTextEdit;
    CodigoAlmacenCtrl: TcxDBTextEdit;
    CodigoClaseCCtrl: TcxDBTextEdit;
    UbicacionCtrl: TcxDBTextEdit;
    TodasLasClasesCtrl: TcxDBCheckBox;
    TodosLosAlmacenesCtrl: TcxDBCheckBox;
    GridData: TgxMemData;
    GridDataTextoPeriodo: TWideStringField;
    GridDataSource: TDataSource;
    GridDataUnidadesCompras1: TBCDField;
    GridDataImporteCompras1: TBCDField;
    GridDataDescuentosCompras1: TBCDField;
    GridDataPorcentajeDtoCompras1: TBCDField;
    GridDataUnidadesCompras2: TBCDField;
    GridDataImporteCompras2: TBCDField;
    GridDataDescuentosCompras2: TBCDField;
    GridDataPorcentajeDtoCompras2: TBCDField;
    GridDataUnidadesVentas1: TBCDField;
    GridDataImporteVentas1: TBCDField;
    GridDataDescuentosVentas1: TBCDField;
    GridDataPorcentajeDtoVentas1: TBCDField;
    GridDataUnidadesVentas2: TBCDField;
    GridDataImporteVentas2: TBCDField;
    GridDataDescuentosVentas2: TBCDField;
    GridDataPorcentajeDtoVentas2: TBCDField;
    Grid1: TcxGrid;
    TableView1: TcxGridDBTableView;
    TableView1Periodo: TcxGridDBColumn;
    Grid1Level: TcxGridLevel;
    TableView1UnidadesCompras1: TcxGridDBColumn;
    TableView1ImporteCompras1: TcxGridDBColumn;
    TableView1DescuentosCompras1: TcxGridDBColumn;
    TableView1PorcentajeDtoCompras1: TcxGridDBColumn;
    TableView1UnidadesCompras2: TcxGridDBColumn;
    TableView1ImporteCompras2: TcxGridDBColumn;
    TableView1DescuentosCompras2: TcxGridDBColumn;
    TableView1PorcentajeDtoCompras2: TcxGridDBColumn;
    TableView1Column: TcxGridDBColumn;
    Grid2: TcxGrid;
    TableView2: TcxGridDBTableView;
    Grid2Level: TcxGridLevel;
    TableView2Periodo: TcxGridDBColumn;
    TableView2UnidadesVentas1: TcxGridDBColumn;
    TableView2ImporteVentas1: TcxGridDBColumn;
    TableView2DescuentosVentas1: TcxGridDBColumn;
    TableView2PorcentajeDtoVentas1: TcxGridDBColumn;
    TableView2UnidadesVentas2: TcxGridDBColumn;
    TableView2ImporteVentas2: TcxGridDBColumn;
    TableView2DescuentosVentas2: TcxGridDBColumn;
    TableView2PorcentajeDtoVentas2: TcxGridDBColumn;
    TableView2Column: TcxGridDBColumn;
    codigoCtrlCaption: TcxLabel;
    DescArticuloLabel: TcxLabel;
    capClaseALabel: TcxLabel;
    capClaseBLabel: TcxLabel;
    DescClaseALabel: TcxLabel;
    DescClaseBLabel: TcxLabel;
    DescAlmacenLabel: TcxLabel;
    capClaseCLabel: TcxLabel;
    DescClaseCLabel: TcxLabel;
    Label10: TcxLabel;
    Label11: TcxLabel;
    Label1: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label3: TcxLabel;
    Label12: TcxLabel;
    Label32: TcxLabel;
    Label43: TcxLabel;
    Label41: TcxLabel;
    Label44: TcxLabel;
    Label46: TcxLabel;
    Label50: TcxLabel;
    Label52: TcxLabel;
    Label4: TcxLabel;
    Label20: TcxLabel;
    Label21: TcxLabel;
    Label26: TcxLabel;
    Label28: TcxLabel;
    Label30: TcxLabel;
    Label40: TcxLabel;
    Label47: TcxLabel;
    Label48: TcxLabel;
    Label53: TcxLabel;
    Label54: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label2: TcxLabel;
    Label24: TcxLabel;
    Label25: TcxLabel;
    Label36: TcxLabel;
    Label38: TcxLabel;
    Label39: TcxLabel;
    Label42: TcxLabel;
    Label37: TcxLabel;
    PrintPopupMenu: TPopupMenu;
    ImprimirItem: TMenuItem;
    GridFooter: TGridTableViewPanel;
    EjercicioCompras1Panel: TGridTableViewPanelGroupBox;
    EjercicioCompras2Panel: TGridTableViewPanelGroupBox;
    GridTableViewPane1: TGridTableViewPanel;
    EjercicioVentas1Panel: TGridTableViewPanelGroupBox;
    EjercicioVentas2Panel: TGridTableViewPanelGroupBox;
    Panel1: TcxGroupBox;
    Panel10: TcxGroupBox;
    Label31: TcxLabel;
    Ejercicio1Label: TcxLabel;
    Ejercicio2Label: TcxLabel;
    GridDataNroPeriodo: TSmallintField;
    UltimaCompraLabel: TcxLabel;
    CosteMedioLabel: TcxLabel;
    ImporteComprasLabel: TcxLabel;
    ImporteDescuentosComprasLabel: TcxLabel;
    DescuentosSComprasLabel: TcxLabel;
    UltimoCosteEntradaLabel: TcxLabel;
    UltimaEntradaLabel: TcxLabel;
    UltimaEntradaCosteLabel: TcxLabel;
    PrecioMedioCompraLabel: TcxLabel;
    UltimoPrecioCompraLabel: TcxLabel;
    UltimaVentaLabel: TcxLabel;
    PrecioMedioVentaLabel: TcxLabel;
    UltimoPrecioVentaLabel: TcxLabel;
    ImporteVentasLabel: TcxLabel;
    ImporteDescuentosVentasLabel: TcxLabel;
    DescuentosSVentasLabel: TcxLabel;
    UltimaSalidaLabel: TcxLabel;
    UltimoPrecioSalidaLabel: TcxLabel;
    MargenMedioLabel: TcxLabel;
    ExistenciasUltimoCosteLabel: TcxLabel;
    ExistenciasCosteMedioLabel: TcxLabel;
    MargenMedioComercialLabel: TcxLabel;
    StockActualLabel: TcxLabel;
    StockMinimoLabel: TcxLabel;
    StockMaximoLabel: TcxLabel;
    PendienteServirLabel: TcxLabel;
    PendienteRecibirLabel: TcxLabel;
    StockVirtualLabel: TcxLabel;
    GridChart1Level: TcxGridLevel;
    GridChart1: TcxGrid;
    GridChart1View: TcxGridDBChartView;
    GridChart1ViewSeries1: TcxGridDBChartSeries;
    GridChart1ViewSeries2: TcxGridDBChartSeries;
    GridChart2: TcxGrid;
    GridChart2View: TcxGridDBChartView;
    GridChart2Series1: TcxGridDBChartSeries;
    GridChart2Series2: TcxGridDBChartSeries;
    GridChart2Level: TcxGridLevel;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure FormManagerFocusedAreaChanged;
    procedure FormManagerGraphicRequest;
    procedure FormResize(Sender: TObject);
    procedure CodigoArticuloCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TodasLasClasesCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure CodigoClaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TodosLosAlmacenesCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure CodigoAlmacenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoAlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoAlmacenCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure UbicacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure UbicacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure UbicacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ImprimirItemClick(Sender: TObject);
  private
    EjercicioActual : SmallInt;
    ArticuloFields : TArticuloFields;
    FGridReportLink : TdxGridReportLink;
    procedure InitializeGridData( const NroOrden : SmallInt; const NroMes : SmallInt );
    procedure UpdateGridData( const NroOrden : SmallInt; const NroMes : SmallInt );
    procedure ShowPrintPreview( Chart : TcxGrid );
  public
    AcumuladoArticulo : TAcumuladoArticulo;
    ExistenciasArticulo : IExistenciasArticulo;
    StockMinimo,
    StockMaximo,
    ImporteMinimo,
    ImporteMaximo : Decimal;

  end;

var  BrwArtForm: TBrwArtForm = nil;

procedure DatosEconomicosArticulos( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       Math,
       
       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dm_cls,
       dm_alm,
       dm_ubi,
       dm_sto,
       dm_sec,
       
       a_art,
       a_cls,
       a_alm,
       a_ubi,

       cx_art,
       cx_alm,
       cx_ubi,
       cx_cls1,

       l_dea,
       g_dea;

procedure DatosEconomicosArticulos( KeyValues : array of const );
begin
     CreateEditForm( TBrwArtForm, brwArtForm, KeyValues, TGds30Frm.ResultadosSection );
end;

procedure TBrwArtForm.FormManagerReportRequest;
begin
     ListadoDatosEconomicosArticulos;
end;

procedure TBrwArtForm.FormManagerInitializeForm;

var   StrEjercicioActual,
      StrEjercicioAnterior : String;

begin

     ArticuloFields := TArticuloFields.Create( Self );

     Clase.SetupEditControls( CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl, 0 );

     DataTodasLasClases.Value := True;
     TodasLasClasesCtrl.Enabled := DataModule00.DmEmpresaFields.Articulo_ExisteClase[ tcClaseA ].Value;
     DataTodosLosAlmacenes.Value := True;
     TodosLosAlmacenesCtrl.Enabled := DataModule00.DmEmpresaFields.Stock_MultiAlmacen.Value;

     If   DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value
     then begin
          ComprasTabSheet.TabVisible := False;
          GraficosTabSheet.TabVisible := False;
          end;

     StrEjercicioActual := IntToStr( ApplicationContainer.Ejercicio );
     StrEjercicioAnterior := IntToStr( ApplicationContainer.Ejercicio - 1 );

     EjercicioCompras1Panel.Caption := StrEjercicioActual;
     EjercicioCompras2Panel.Caption := StrEjercicioAnterior;
     EjercicioVentas1Panel.Caption := StrEjercicioActual;
     EjercicioVentas2Panel.Caption := StrEjercicioAnterior;

     Ejercicio1Label.Caption := StrEjercicioActual;
     Ejercicio2Label.Caption := StrEjercicioAnterior;

     SetBCDFieldsDecimals( [ GridDataUnidadesCompras1, GridDataUnidadesCompras2 ],  DataModule00.DmEmpresaFields.Compras_DecCantidad.Value );
     SetBCDFieldsDecimals( [ GridDataImporteCompras1, GridDataDescuentosCompras1, GridDataImporteCompras2, GridDataDescuentosCompras2 ] );
     SetBCDFieldsDecimals( [ GridDataPorcentajeDtoCompras1, GridDataPorcentajeDtoCompras2 ], 2 );

     SetFooterSummaryItemsDecimals( TableView1, [ 0, 1, 2, 4, 5, 6 ] );
     SetFooterSummaryItemsDecimals( TableView1, [ 3, 7 ], 2 );

     SetBCDFieldsDecimals( [ GridDataUnidadesVentas1, GridDataUnidadesVentas2 ],  DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value );
     SetBCDFieldsDecimals( [ GridDataImporteVentas1, GridDataDescuentosVentas1, GridDataImporteVentas2, GridDataDescuentosVentas2 ] );
     SetBCDFieldsDecimals( [ GridDataPorcentajeDtoVentas1, GridDataPorcentajeDtoVentas2 ], 2 );

     SetFooterSummaryItemsDecimals( TableView2, [ 0, 1, 2, 4, 5, 6 ] );
     SetFooterSummaryItemsDecimals( TableView2, [ 3, 7 ], 2 );

     ActualizaRegistrosPeriodo( GridData, dsoCreate, InitializeGridData );

     If   Assigned( FormValues ) and ( High( FormValues )=0 )
     then DataCodigoArticulo.Value := FormValues[ 0 ];

     FGridReportLink := TdxGridReportLink.Create( Self );
     FGridReportLink.ComponentPrinter := PrintSystemDataModule.ComponentPrinter;

     FormResize( nil );
end;

procedure TBrwArtForm.CodigoAlmacenCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.EditingValue ] );
end;

procedure TBrwArtForm.CodigoAlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TBrwArtForm.CodigoAlmacenCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, ErrorTExt, Error );
end;

procedure TBrwArtForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TBrwArtForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TBrwArtForm.CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, ArticuloFields );
     StockMinimo := ArticuloFields.Stock_Minimo.Value;
     StockMaximo := ArticuloFields.Stock_Maximo.Value;
end;

procedure TBrwArtForm.CodigoClaseCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaClases1( TNroClase( Sender.Tag ), Sender );
end;

procedure TBrwArtForm.CodigoClaseCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( TNroClase( Sender.Tag ), DataTodasLasClases.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwArtForm.CodigoClaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( Sender.Tag ), Sender.EditingValue ] );
end;

procedure TBrwArtForm.ImprimirItemClick(Sender: TObject);
begin
     If   ActiveControl is TcxGridSite
     then ShowPrintPreview( TcxGrid( TcxGridSite( ActiveControl ).Container ) );
end;

procedure TBrwArtForm.InitializeGridData( const NroOrden : SmallInt;
                                          const NroMes   : SmallInt );
begin
     GridDataTextoPeriodo.Value := StrMonth( NroMes, True );
end;

procedure TBrwArtForm.UpdateGridData( const NroOrden : SmallInt;
                                      const NroMes   : SmallInt );

var  Porcentaje : Decimal;

begin

     With AcumuladoArticulo do
       begin

       // Compras

       If   ( ImporteComprasMes[ NroMes ] + ImporteDescuentosComprasMes[ NroMes ] )=0.0
       then Porcentaje := 0.0
       else Porcentaje := ( ImporteDescuentosComprasMes[ NroMes ] * 100.0 ) / ( ImporteComprasMes[ NroMes ] + ImporteDescuentosComprasMes[ NroMes ] );

       If   EjercicioActual=ApplicationContainer.Ejercicio
       then begin
            GridDataUnidadesCompras1.Value := UnidadesComprasMes[ NroMes ];
            GridDataImporteCompras1.Value := ImporteComprasMes[ NroMes ];
            GridDataDescuentosCompras1.Value := ImporteDescuentosComprasMes[ NroMes ];
            GridDataPorcentajeDtoCompras1.Value := Porcentaje;
            end
       else begin
            GridDataUnidadesCompras2.Value := UnidadesComprasMes[ NroMes ];
            GridDataImporteCompras2.Value := ImporteComprasMes[ NroMes ];
            GridDataDescuentosCompras2.Value := ImporteDescuentosComprasMes[ NroMes ];
            GridDataPorcentajeDtoCompras2.Value := Porcentaje;
            end;

       If   ImporteComprasMes[ NroMes ]<ImporteMinimo
       then ImporteMinimo := ImporteComprasMes[ NroMes ];
       If   ImporteComprasMes[ NroMes ]>ImporteMaximo
       then ImporteMaximo := ImporteComprasMes[ NroMes ];

       // Ventas

       If   ( ImporteVentasMes[ NroMes ] + ImporteDescuentosVentasMes[ NroMes ] )=0.0     // El importe neto + descuentos = importe bruto
       then Porcentaje := 0.0
       else Porcentaje := ( ImporteDescuentosVentasMes[ NroMes ] * 100.0 ) / ( ImporteVentasMes[ NroMes ] + ImporteDescuentosVentasMes[ NroMes ] );

       If   EjercicioActual=ApplicationContainer.Ejercicio
       then begin
            GridDataUnidadesVentas1.Value := UnidadesVentasMes[ NroMes ];
            GridDataImporteVentas1.Value := ImporteVentasMes[ NroMes ];
            GridDataDescuentosVentas1.Value := ImporteDescuentosVentasMes[ NroMes ];
            GridDataPorcentajeDtoVentas1.Value := Porcentaje;
            end
       else begin
            GridDataUnidadesVentas2.Value := UnidadesVentasMes[ NroMes ];
            GridDataImporteVentas2.Value := ImporteVentasMes[ NroMes ];
            GridDataDescuentosVentas2.Value := ImporteDescuentosVentasMes[ NroMes ];
            GridDataPorcentajeDtoVentas2.Value := Porcentaje;
            end;

       If   ImporteVentasMes[ NroMes ]<ImporteMinimo
       then ImporteMinimo := ImporteVentasMes[ NroMes ];
       If   ImporteVentasMes[ NroMes ]>ImporteMaximo
       then ImporteMaximo := ImporteVentasMes[ NroMes ];

       end;

end;

procedure TBrwArtForm.FormManagerFocusedAreaChanged;

var   I : SmallInt;

      TotalUnidadesCompras1,
      TotalImporteCompras1,
      TotalImporteDescuentosCompras1,
      DtosCompras1,
      TotalUnidadesVentas1,
      TotalImporteVentas1,
      TotalImporteDescuentosVentas1,
      DtosVentas1 : Decimal;


begin

     If   FormManager.DataAreaFocused
     then begin

          With StockAlmacen, Articulo, AcumuladoArticulo do
            begin

            ActualizaRegistrosPeriodo( GridData, dsoClear );

            // Ejercicio actual

            EjercicioActual := ApplicationContainer.Ejercicio;

            ExistenciasArticulo := CalculaResultados( DataCodigoArticulo.Value,
                                                      DataTodasLasClases.Value,
                                                      DataCodigoClaseA.Value,
                                                      DataCodigoClaseB.Value,
                                                      DataCodigoClaseC.Value,
                                                      DataCodigoAlmacen.Value,
                                                      EjercicioActual,
                                                      0,
                                                      ApplicationContainer.NroMesFinal,
                                                      DataTodosLosAlmacenes.Value,
                                                      DataTodasLasClases.Value,
                                                      AcumuladoArticulo );
            // Compras

            If   TotalUnidadesCompras<>0.0
            then PrecioMedioCompra := TotalImporteCompras / TotalUnidadesCompras
            else PrecioMedioCompra := 0.0;

            UltimaCompraLabel.Caption := ' ' + StrFormatDate( ExistenciasArticulo.FechaUltCompra, dfDefault2 );
            UltimoPrecioCompraLabel.Caption := StrFormat( ExistenciasArticulo.PrecioUltCompra, DataModule00.DmEmpresaFields.Compras_DecPrecio.Value );

            UltimaEntradaLabel.Caption := ' ' + StrFormatDate( ExistenciasArticulo.FechaUltEntrada, dfDefault2 );
            UltimaEntradaCosteLabel.Caption := StrFormatDate( ExistenciasArticulo.FechaUltEntradaCoste, dfDefault2 );
            UltimoCosteEntradaLabel.Caption := StrFormat( ExistenciasArticulo.CosteUltEntrada, DataModule00.DmEmpresaFields.Compras_DecPrecio.Value );

            PrecioMedioCompraLabel.Caption := StrFormat( PrecioMedioCompra, DataModule00.DmEmpresaFields.Compras_DecPrecio.Value );
            CosteMedioLabel.Caption := StrFormat( ExistenciasArticulo.CosteMedio, DataModule00.DmEmpresaFields.Compras_DecPrecio.Value );

            ImporteComprasLabel.Caption := StrFormat( TotalImporteCompras, DecimalesMoneda );
            ImporteDescuentosComprasLabel.Caption := StrFormat( TotalImporteDescuentosCompras, DecimalesMoneda );
            DescuentosSComprasLabel.Caption := StrFormat( DtosCompras, 2 );

            ImporteMinimo := 0.0;
            ImporteMaximo := 0.0;

            ActualizaRegistrosPeriodo( GridData, dsoUpdate, UpdateGridData );

            TotalUnidadesCompras1 := TotalUnidadesCompras;
            TotalImporteCompras1 := TotalImporteCompras;
            TotalImporteDescuentosCompras1 := TotalImporteDescuentosCompras;
            DtosCompras1 := DtosCompras;

            // Ventas

            UltimaVentaLabel.Caption := ' ' + StrFormatDate( ExistenciasArticulo.FechaUltVenta, dfDefault2 );
            UltimoPrecioVentaLabel.Caption := StrFormat( ExistenciasArticulo.PrecioUltVenta, Min( DataModule00.DmEmpresaFields.Ventas_DecPrecio.Value, 4 ) );

            UltimaSalidaLabel.Caption := ' ' + StrFormatDate( ExistenciasArticulo.FechaUltSalida, dfDefault2 );
            UltimoPrecioSalidaLabel.Caption := StrFormat( ExistenciasArticulo.PrecioUltSalida, Min( DataModule00.DmEmpresaFields.Ventas_DecPrecio.Value, 4 ) );

            PrecioMedioVentaLabel.Caption := StrFormat( PrecioMedioVenta, Min( DataModule00.DmEmpresaFields.Ventas_DecPrecio.Value, 4 ) );
            MargenMedioLabel.Caption := StrFormat( MargenMedio, MIn( DataModule00.DmEmpresaFields.Ventas_DecPrecio.Value, 4 ) );

            ImporteVentasLabel.Caption := StrFormat( TotalImporteVentas, DecimalesMoneda );
            ImporteDescuentosVentasLabel.Caption := StrFormat( TotalImporteDescuentosVentas, DecimalesMoneda );
            DescuentosSVentasLabel.Caption := StrFormat( DtosVentas, 2 );

            TotalUnidadesVentas1 := TotalUnidadesVentas;
            TotalImporteVentas1 := TotalImporteVentas;
            TotalImporteDescuentosVentas1 := TotalImporteDescuentosVentas;
            DtosVentas1 := DtosVentas;

            // Almacén

            StockMinimoLabel.Caption := StrFormat( StockMinimo, DataModule00.DmEmpresaFields.Compras_DecCantidad.Value );
            StockmaximoLabel.Caption := StrFormat( Stockmaximo, DataModule00.DmEmpresaFields.Compras_DecCantidad.Value );
            StockActualLabel.Caption := StrFormat( ExistenciasArticulo.SumaExistencias.Saldo, DataModule00.DmEmpresaFields.Compras_DecCantidad.Value );

            ExistenciasCosteMedioLabel.Caption := StrFormat( ExistenciasArticulo.CosteMedio * ExistenciasArticulo.SumaExistencias.Saldo, DecimalesMoneda );
            ExistenciasUltimoCosteLabel.Caption := StrFormat( ExistenciasArticulo.CosteUltEntrada * ExistenciasArticulo.SumaExistencias.Saldo, DecimalesMoneda );
            MargenMedioComercialLabel.Caption := StrFormat( MargenMedio, DecimalesMoneda );

            PendienteRecibirLabel.Caption := StrFormat( ExistenciasArticulo.SumaExistencias.PendienteRecibir, DataModule00.DmEmpresaFields.compras_DecCantidad.Value );
            PendienteServirLabel.Caption := StrFormat( ExistenciasArticulo.SumaExistencias.PendienteServir, DataModule00.DmEmpresaFields.compras_DecCantidad.Value );
            StockVirtualLabel.Caption := StrFormat( ExistenciasArticulo.SumaExistencias.PendienteRecibir + ExistenciasArticulo.SumaExistencias.Saldo - ExistenciasArticulo.SumaExistencias.PendienteServir, DataModule00.DmEmpresaFields.compras_DecCantidad.Value );

            // Ejercicio anterior

            EjercicioActual := ApplicationContainer.Ejercicio - 1;

            ExistenciasArticulo := CalculaResultados( DataCodigoArticulo.Value,
                                                      DataTodasLasClases.Value,
                                                      DataCodigoClaseA.Value,
                                                      DataCodigoClaseB.Value,
                                                      DataCodigoClaseC.Value,
                                                      DataCodigoAlmacen.Value,
                                                      EjercicioActual,
                                                      0,
                                                      ApplicationContainer.NroMesFinal,
                                                      DataTodosLosAlmacenes.Value,
                                                      DataTodasLasClases.Value,
                                                      AcumuladoArticulo );

            ActualizaRegistrosPeriodo( GridData, dsoUpdate, UpdateGridData );

            GridChart1View.DiagramColumn.AxisValue.MaxValue := ImporteMaximo;
            GridChart1View.DiagramColumn.AxisValue.MinValue := ImporteMinimo;

            GridChart2View.DiagramColumn.AxisValue.MaxValue := ImporteMaximo;
            GridChart2View.DiagramColumn.AxisValue.MinValue := ImporteMinimo;

            With TableView1.DataController.Summary do
              begin
              FooterSummaryValues[ 0 ] := TotalUnidadesCompras1;
              FooterSummaryValues[ 1 ] := TotalImporteCompras1;
              FooterSummaryValues[ 2 ] := TotalImporteDescuentosCompras1;
              FooterSummaryValues[ 3 ] := Redondea( DtosCompras1 );
              FooterSummaryValues[ 4 ] := TotalUnidadesCompras;
              FooterSummaryValues[ 5 ] := TotalImporteCompras;
              FooterSummaryValues[ 6 ] := TotalImporteDescuentosCompras;
              FooterSummaryValues[ 7 ] := Redondea( DtosCompras );
              end;

            With TableView2.DataController.Summary do
              begin
              FooterSummaryValues[ 0 ] := TotalUnidadesVentas1;
              FooterSummaryValues[ 1 ] := TotalImporteVentas1;
              FooterSummaryValues[ 2 ] := TotalImporteDescuentosVentas1;
              FooterSummaryValues[ 3 ] := Redondea( DtosVentas1 );
              FooterSummaryValues[ 4 ] := TotalUnidadesVentas;
              FooterSummaryValues[ 5 ] := TotalImporteVentas;
              FooterSummaryValues[ 6 ] := TotalImporteDescuentosVentas;
              FooterSummaryValues[ 7 ] := Redondea( DtosVentas );
              end;

            end;

          end
     else begin

          UltimaEntradaLabel.Caption := '';
          UltimoCosteEntradaLabel.Caption := '';
          UltimaCompraLabel.Caption := '';
          UltimoPrecioCompraLabel.Caption := '';
          UltimaEntradaCosteLabel.Caption := '';
          PrecioMedioCompraLabel.Caption := '';
          CosteMedioLabel.Caption := '';
          ImporteComprasLabel.Caption := '';
          ImporteDescuentosComprasLabel.Caption := '';
          DescuentosSComprasLabel.Caption := '';

          With TableView1.DataController.Summary do
            For I := 0 to FooterSummaryItems.Count - 1 do
              FooterSummaryValues[ I ] := 0.0;

          // Ventas

          UltimaVentaLabel.Caption := '';
          UltimoPrecioVentaLabel.Caption := '';
          UltimaSalidaLabel.Caption := '';
          UltimoPrecioSalidaLabel.Caption := '';
          PrecioMedioVentaLabel.Caption := '';
          MargenMedioLabel.Caption := '';
          ImporteVentasLabel.Caption := '';
          ImporteDescuentosVentasLabel.Caption := '';
          DescuentosSVentasLabel.Caption := '';

          With TableView2.DataController.Summary do
            For I := 0 to FooterSummaryItems.Count - 1 do
              FooterSummaryValues[ I ] := 0.0;

          // Almacén

          StockMinimoLabel.Caption := '';
          StockmaximoLabel.Caption := '';
          StockActualLabel.Caption := '';

          ExistenciasCosteMedioLabel.Caption := '';
          ExistenciasUltimoCosteLabel.Caption := '';
          MargenMedioComercialLabel.Caption := '';

          PendienteRecibirLabel.Caption := '';
          PendienteServirLabel.Caption := '';
          StockVirtualLabel.Caption := '';

          end;

     PrintPopupMenu.AutoPopup := FormManager.DataAreaFocused;
end;

procedure TBrwArtForm.TodasLasClasesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     {
     If   TodasLasClasesCtrl.Checked
     then begin
          CodigoClaseACtrl.Enabled := False;
          CodigoClaseBCtrl.Enabled := False;
          CodigoClaseCCtrl.Enabled := False;
          end
     else Clase.SetupEditControls( CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl, 0 );
     }
     ValidateEditControl( CodigoClaseACtrl );
     ValidateEditControl( CodigoClaseBCtrl );
     ValidateEditControl( CodigoClaseCCtrl );
end;

procedure TBrwArtForm.TodosLosAlmacenesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With DataModule00.DmEmpresaFields do
       begin
       CodigoAlmacenCtrl.Enabled := Stock_multiAlmacen.Value and not DataTodosLosAlmacenes.Value;
       UbicacionCtrl.Enabled:= Stock_Ubicaciones.Value  and not DataTodosLosAlmacenes.Value;
       end;
end;

procedure TBrwArtForm.UbicacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntUbicaciones( [ DataCodigoAlmacen.Value, Sender.EditingValue ] );
end;

procedure TBrwArtForm.UbicacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUbicaciones( DataCodigoAlmacen.Value, ubTodas, Sender );
end;

procedure TBrwArtForm.UbicacionCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then UbicacionCtrl.Description := RsgMsgTodas
     else Ubicacion.Valida( DataCodigoAlmacen.Value, True, Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwArtForm.FormManagerGraphicRequest;
begin
     GraficosArticulos;
end;

procedure TBrwArtForm.FormResize(Sender: TObject);
begin
     LeftPanel.Width := GraficosTabSheet.Width div 2;
end;

procedure TBrwArtForm.ShowPrintPreview( Chart : TcxGrid );
begin
     FGridReportLink.Component := Chart;
     PrintSystemDataModule.ComponentPrinter.Preview( False, FGridReportLink );
end;

end.


