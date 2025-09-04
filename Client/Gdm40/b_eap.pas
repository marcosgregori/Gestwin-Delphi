unit b_eap;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes, Windows,
  ExtCtrls, Grids, Graphics, ComCtrls, Menus, cxLookAndFeelPainters,
  cxButtons, cxPC, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  DB, dxmdaset, cxCheckBox,

  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxLookAndFeels,
  cxLabel, nxdb, sqlset, cxGroupBox, cxNavigator, dxDateRanges, dxScrollbarAnnotations,

  LibUtils,
  AppContainer,
  AppForms,
  DataManager,
  GridTableViewController,

  Gim30Fields,

  dm_art, dxUIAClasses;

type
  TBrwEapForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
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
    ConsultaQuery: TnxeQuery;
    ConsultaDataSource: TDataSource;
    ConsultaQueryPropietario: TWideStringField;
    ConsultaQueryNroOperacion: TIntegerField;
    ConsultaQueryNroRegistro: TLongWordField;
    ConsultaQueryCantidad: TBCDField;
    ConsultaQueryCantidadProcesada: TBCDField;
    ConsultaQueryNombre: TWideStringField;
    SQLSet: TgxSQLSet;
    ConsultaQueryCantidadCargada: TBCDField;
    ConsultaQueryCabeceraCliente: TWideStringField;
    cxLabel1: TcxLabel;
    ExistenciasLabel: TcxLabel;
    DataTodasLasUbicaciones: TBooleanField;
    TodasLasUbicacionesCtrl: TcxDBCheckBox;
    ConsultaQuerySerie: TWideStringField;
    ConsultaQueryNroDocumento: TIntegerField;
    ConsultaQueryLoteFabricacion: TWideStringField;
    ConsultaQueryCodigoClaseA: TWideStringField;
    ConsultaQueryCodigoClaseB: TWideStringField;
    ConsultaQueryCodigoClaseC: TWideStringField;
    Panel1: TcxGroupBox;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewCabeceraCliente: TcxGridDBColumn;
    GridViewPropietario: TcxGridDBColumn;
    GridViewNombre: TcxGridDBColumn;
    GridViewNroOperacion: TcxGridDBColumn;
    GridViewSerie: TcxGridDBColumn;
    GridViewNroDocumento: TcxGridDBColumn;
    GridViewLoteFabricacion: TcxGridDBColumn;
    GridViewCodigoClaseA: TcxGridDBColumn;
    GridViewCodigoClaseB: TcxGridDBColumn;
    GridViewCodigoClaseC: TcxGridDBColumn;
    GridViewNroRegistro: TcxGridDBColumn;
    GridViewCantidad: TcxGridDBColumn;
    GridViewCantidadCargada: TcxGridDBColumn;
    GridViewCantidadProcesada: TcxGridDBColumn;
    Level: TcxGridLevel;
    GridTableViewController: TGridTableViewController;
    ConsultaQueryFecha: TDateField;
    GridViewFecha: TcxGridDBColumn;
    ConsultaQueryFechaAplicacion: TDateField;
    GridViewFechaAplicacion: TcxGridDBColumn;
    ConsultaQueryUbicacion: TWideStringField;
    GridViewUbicacion: TcxGridDBColumn;
    ConsultaQueryCodigoAlmacen: TWideStringField;
    GridViewCodigoAlmacen: TcxGridDBColumn;
    cxLabel2: TcxLabel;
    ExistenciasVirtualesLabel: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxLabel3: TcxLabel;
    DisponibleLabel: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure FormManagerFocusedAreaChanged;
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
    procedure ConsultaQueryCalcFields(DataSet: TDataSet);
    procedure GridTableViewControllerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure GridViewDataControllerSummaryAfterSummary(
      ASender: TcxDataSummary);
  private
    SaldoExistencias : Decimal;
  public

  end;

var  BrwEapForm: TBrwEapForm = nil;

procedure EstadoArticulosPendientes( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       DateUtils,

       Gdm00Dm,
       Gdm30Frm,

       dmi_mov,
       dmi_sto,

       dm_cls,
       dm_alm,
       dm_ubi,
       dm_mov,
       dm_sto,
       dm_hdc,

       a_art,
       a_cls,
       a_alm,
       a_ubi,
       a_mov,

       cx_art,
       cx_alm,
       cx_ubi,
       cx_cls1,

       l_eap;

procedure EstadoArticulosPendientes( KeyValues : array of const );
begin
     CreateEditForm( TBrwEapForm, BrwEapForm, KeyValues );
end;

procedure TBrwEapForm.ConsultaQueryCalcFields(DataSet: TDataSet);
begin
     ConsultaQueryCantidadCargada.Value := HojaCarga.ObtenCantidadCargada( ConsultaQueryNroRegistro.Value );
end;

procedure TBrwEapForm.FormManagerReportRequest;
begin
     ListadoEstadoArticulosPendientes;
end;

procedure TBrwEapForm.GridTableViewControllerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     MntMovimientosPorNroRegistro( ConsultaQueryNroRegistro.Value );
end;

procedure TBrwEapForm.GridViewDataControllerSummaryAfterSummary(ASender: TcxDataSummary);

var  CargadoTotal : Decimal;

begin
     CargadoTotal := VarToDecimal( ASender.FooterSummaryValues[ 1 ] );
     DisponibleLabel.Caption := StrFormat( SaldoExistencias - CargadoTotal, DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value );
end;

procedure TBrwEapForm.FormManagerInitializeForm;
begin

     Clase.SetupEditControls( CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl, 0 );

     With DataModule00.DmEmpresaFields do
       begin
       DataTodasLasClases.Value := True;
       TodasLasClasesCtrl.Enabled := Articulo_ExisteClase[ tcClaseA ].Value;
       DataTodosLosAlmacenes.Value := True;
       TodosLosAlmacenesCtrl.Enabled := Stock_MultiAlmacen.Value;
       GridViewSerie.Visible := Movimiento.SeriesEnDocumentosVenta( tmPedidoVenta );
       GridViewLoteFabricacion.Visible := Stock_LotesProductos.Value;
       Clase.SetupGridColumns( GridViewCodigoClaseA, GridViewCodigoClaseB, GridViewCodigoClaseC, 4 );
       SetColumnsDecimals( [ GridViewCantidad, GridViewCantidadCargada, GridViewCantidadProcesada ], Ventas_DecCantidad.Value );
       SetFooterSummaryItemsDecimals( GridView, [ 0, 1, 2 ] , Ventas_DecCantidad.Value );
       end;

     If   Assigned( FormValues ) and ( High( FormValues )=0 )
     then DataCodigoArticulo.Value := FormValues[ 0 ];

end;

procedure TBrwEapForm.CodigoAlmacenCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.EditingValue ] );
end;

procedure TBrwEapForm.CodigoAlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TBrwEapForm.CodigoAlmacenCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scVentas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwEapForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TBrwEapForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TBrwEapForm.CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwEapForm.CodigoClaseCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaClases1( TNroClase( Sender.Tag ), Sender );
end;

procedure TBrwEapForm.CodigoClaseCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( TNroClase( Sender.Tag ), DataTodasLasClases.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwEapForm.CodigoClaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( Sender.Tag ), Sender.EditingValue ] );
end;

procedure TBrwEapForm.FormManagerFocusedAreaChanged;

var  SQLSeleccion,
     SQLText : String;
     ExistenciasArticulo : IExistenciasArticulo;

begin

     If   FormManager.DataAreaFocused
     then begin

          GridViewCodigoAlmacen.Visible := DataModule00.DmEmpresaFields.Stock_MultiAlmacen.Value and DataTodosLosAlmacenes.Value;
          GridViewUbicacion.Visible := DataModule00.DmEmpresaFields.Stock_Ubicaciones.Value and DataTodasLasUbicaciones.Value;

          ExistenciasArticulo := StockAlmacen.ObtenStock( DataCodigoArticulo.Value,
                                                          DataTodasLasClases.Value,
                                                          DataCodigoClaseA.Value,
                                                          DataCodigoClaseB.Value,
                                                          DataCodigoClaseC.Value,
                                                          True,
                                                          '',
                                                          DataTodosLosAlmacenes.Value,
                                                          DataCodigoAlmacen.Value,
                                                          DataTodasLasUbicaciones.Value,
                                                          DataUbicacion.Value,
                                                          False,
                                                          ApplicationContainer.Ejercicio,
                                                          0,
                                                          ApplicationContainer.NroMesFinal );

          With ExistenciasArticulo.SumaExistencias do
            begin
            SaldoExistencias := Saldo;
            ExistenciasLabel.Caption := StrFormat( Saldo, DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value );
            ExistenciasVirtualesLabel.Caption := StrFormat( PendienteRecibir + Saldo - PendienteServir, DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value );
            end;

          SQLSeleccion := SQLFieldsFormat( ' CodigoArticulo=? ', [ DataCodigoArticulo ] );

          If   not DataTodosLosAlmacenes.Value
          then begin
               StrAdd( SQLSeleccion, SQLFieldsFormat( ' AND CodigoAlmacen=? ', [ DataCodigoAlmacen ] ) );
               If   not DataToDasLasUbicaciones.Value
               then StrAdd( SQLSeleccion, SQLFieldsFormat( ' AND Ubicacion=? ', [ DataUbicacion ] ) );
               end;

          Clase.AddSQLSelect( SQLSeleccion, DataCodigoClaseA, DataCodigoClaseB, DataCodigoClaseC, DataTodasLasClases.Value );

          // Un año de movimientos pendientes (de momento es fijo, ya veremos la reacción de los usuarios)

          StrAdd( SQLSeleccion, ' AND Fecha BETWEEN ' + SQLDateString( IncYear( ApplicationContainer.TodayDate, -1 ) ) + ' AND ' + SQLDateString( ApplicationContainer.TodayDate ) + ' ' );

          SQLText := SQLSet.GetSQLText;
          SetSQLVar( SQLText, 'Seleccion', SQLSeleccion );

          With ConsultaQuery do
            begin
             Close;
             SQL.Text := SQLText;
             Open;
             end;

          ConsultaDataSource.Enabled := True;

          GridView.ViewData.Expand( True );
          end
     else begin
          SaldoExistencias := 0.0;
          ExistenciasLabel.Caption := '';
          ConsultaDataSource.Enabled := False;
          ConsultaQuery.Close;
          end;
end;

procedure TBrwEapForm.TodasLasClasesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ValidateEditControls( [ CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl ] );
end;

procedure TBrwEapForm.TodosLosAlmacenesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
      With DataModule00.DmEmpresaFields do
       begin
       CodigoAlmacenCtrl.Enabled := Stock_MultiAlmacen.Value and not DataTodosLosAlmacenes.Value;
       If   DataTodosLosAlmacenes.Value
       then DataTodasLasUbicaciones.Value := True;
       TodasLasUbicacionesCtrl.Enabled := Stock_Ubicaciones.Value and not DataTodosLosAlmacenes.Value;
       UbicacionCtrl.Enabled := TodasLasUbicacionesCtrl.Enabled and not DataTodasLasUbicaciones.Value and Stock_Ubicaciones.Value  and not DataTodosLosAlmacenes.Value;
       UbicacionCtrl.IsEditValidated := False;
       end;
end;

procedure TBrwEapForm.UbicacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntUbicaciones( [ DataCodigoAlmacen.Value, Sender.EditingValue ] );
end;

procedure TBrwEapForm.UbicacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUbicaciones( DataCodigoAlmacen.Value, ubTodas, Sender );
end;

procedure TBrwEapForm.UbicacionCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Ubicacion.Valida( DataCodigoAlmacen.Value, True, Sender, DisplayValue, ErrorText, Error );
end;

end.


