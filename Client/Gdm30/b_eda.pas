unit b_eda;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes, Windows,
  ExtCtrls,

  LibUtils,
  AppContainer,

  Grids,
  Graphics,
  ComCtrls,

  Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox, cxDBEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxHeader, DB, dxmdaset,
  DataManager, nxdb,

  Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox, cxStyles, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  dxUIAClasses;

type
  TBrwEdaForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoArticuloCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    CodigoClaseACtrl: TcxDBTextEdit;
    CodigoClaseBCtrl: TcxDBTextEdit;
    CodigoAlmacenCtrl: TcxDBTextEdit;
    CodigoClaseCCtrl: TcxDBTextEdit;
    UbicacionCtrl: TcxDBTextEdit;
    TodasLasClasesCtrl: TcxDBCheckBox;
    TodosLosAlmacenesCtrl: TcxDBCheckBox;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoArticulo: TWideStringField;
    DataTodasLasClases: TBooleanField;
    DataCodigoClaseA: TWideStringField;
    DataCodigoClaseB: TWideStringField;
    DataCodigoClaseC: TWideStringField;
    DataTodosLosAlmacenes: TBooleanField;
    DataCodigoAlmacen: TWideStringField;
    DataUbicacion: TWideStringField;
    DataTodasLasUbicaciones: TBooleanField;
    TodasLasUbicacionesCtrl: TcxDBCheckBox;
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
    Label3: TcxLabel;
    Label4: TcxLabel;
    UltimoCosteLabel: TcxLabel;
    CosteMedioLabel: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label2: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    TableViewPeriodo: TcxGridDBColumn;
    TableViewNombrePeriodo: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    GridDataSource: TDataSource;
    GridData: TgxMemData;
    GridDataIndice: TSmallintField;
    GridDataEntradas: TBCDField;
    GridDataSalidas: TBCDField;
    GridDataSaldo: TBCDField;
    GridDataNombrePeriodo: TStringField;
    TableViewEntradas: TcxGridDBColumn;
    TableViewSalidas: TcxGridDBColumn;
    TableViewSaldo: TcxGridDBColumn;
    PendienteRecibirBox: TcxLabel;
    PendienteServirBox: TcxLabel;
    CosteMedioBox: TcxLabel;
    UltimaSalidaBox: TcxLabel;
    UltimoCosteBox: TcxLabel;
    UltimaEntradaBox: TcxLabel;
    ExistenciasVirtualesBox: TcxLabel;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure FormManagerFocusedAreaChanged;
    procedure CodigoArticuloCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TodosLosAlmacenesCtrlPropertiesEditValueChange(
      Sender: TObject);
    procedure CodigoClaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure UbicacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure UbicacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure UbicacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TodasLasClasesCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure CodigoAlmacenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoAlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoAlmacenCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure TodasLasUbicacionesCtrlPropertiesEditValueChanged(
      Sender: TObject);
  private

  public
    AcumuladoExistencias : Decimal;

  end;

var  BrwEdaForm: TBrwEdaForm = nil;

procedure ConsultaExistenciasMensuales;

implementation

{$R *.DFM}

uses   Math,
       SysUtils,

       Gdm00Dm,

       dmi_sto,

       dm_art,
       dm_cls,
       dm_alm,
       dm_ubi,
       dm_sto,

       a_art,
       a_cls,
       a_alm,
       a_ubi,

       cx_cls1,
       cx_art,
       cx_alm,
       cx_ubi,

       l_eda;

procedure ConsultaExistenciasMensuales;
begin
     CreateEditForm( TBrwEdaForm, BrwEdaForm );
end;

procedure TBrwEdaForm.FormManagerReportRequest;
begin
     ListadoExistenciasArticulos;
end;

procedure TBrwEdaForm.FormManagerInitializeForm;

var   I, J : SmallInt;

begin

     TableViewNombrePeriodo.Styles.Content := ApplicationContainer.EditFixedColumnStyle;

     Clase.SetupEditControls( CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl, 0 );

     DataTodasLasClases.Value := True;
     TodasLasClasesCtrl.Enabled := DataModule00.DmEmpresaFields.Articulo_ExisteClase[ tcClaseA ].Value;
     DataTodosLosAlmacenes.Value := True;
     TodosLosAlmacenesCtrl.Enabled := DataModule00.DmEmpresaFields.Stock_MultiAlmacen.Value;

     With DataModule00.DmEmpresaFields do
       begin
       SetColumnDecimals( TableViewEntradas, Compras_DecCantidad.Value );
       SetColumnDecimals( TableViewSalidas, Ventas_DecCantidad.Value );
       SetColumnDecimals( TableViewSaldo, Max( Compras_DecCantidad.Value, Ventas_DecCantidad.Value ) );

       SetFooterSummaryItemDecimals( TableView, 0, Compras_DecCantidad.Value );
       SetFooterSummaryItemDecimals( TableView, 1, Ventas_DecCantidad.Value );
       end;

     If   DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value
     then begin
          UltimoCosteLabel.Visible := False;
          UltimoCosteBox.Visible := False;
          CosteMedioLabel.Visible := False;
          CosteMedioBox.Visible  := False;
          end;

     GridData.Active := True;
end;

procedure TBrwEdaForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TBrwEdaForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwEdaForm.CodigoClaseCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases( TNroClase( Sender.Tag ), DataCodigoArticulo.Value, DataCodigoClaseA.Value, DataCodigoClaseB.Value, DataCodigoClaseC.Value, '', Sender );
end;

procedure TBrwEdaForm.CodigoClaseCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( TNroClase( Sender.Tag ), DataTodasLasClases.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwEdaForm.CodigoClaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( Sender.Tag ), Sender.EditingValue ] );
end;

procedure TBrwEdaForm.CodigoAlmacenCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.EditingValue ] );
end;

procedure TBrwEdaForm.CodigoAlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TBrwEdaForm.CodigoAlmacenCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwEdaForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TBrwEdaForm.TodasLasClasesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ValidateEditControl( CodigoClaseACtrl );
     ValidateEditControl( CodigoClaseBCtrl );
     ValidateEditControl( CodigoClaseCCtrl );
end;

procedure TBrwEdaForm.TodasLasUbicacionesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With DataModule00.DmEmpresaFields do
       UbicacionCtrl.Enabled:= TodasLasUbicacionesCtrl.Enabled and not DataTodasLasUbicaciones.Value and Stock_Ubicaciones.Value  and not DataTodosLosAlmacenes.Value;
end;

procedure TBrwEdaForm.TodosLosAlmacenesCtrlPropertiesEditValueChange(Sender: TObject);
begin
     With DataModule00.DmEmpresaFields do
       begin
       CodigoAlmacenCtrl.Enabled := Stock_MultiAlmacen.Value and not DataTodosLosAlmacenes.Value;
       If   DataTodosLosAlmacenes.Value
       then DataTodasLasUbicaciones.Value := True;
       TodasLasUbicacionesCtrl.Enabled := Stock_Ubicaciones.Value and not DataTodosLosAlmacenes.Value;
       end;
end;

procedure TBrwEdaForm.UbicacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntUbicaciones( [ DataCodigoAlmacen.Value, Sender.EditingValue ] );
end;

procedure TBrwEdaForm.UbicacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUbicaciones( DataCodigoAlmacen.Value, ubTodas, Sender );
end;

procedure TBrwEdaForm.UbicacionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Ubicacion.Valida( DataCodigoAlmacen.Value, True, Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwEdaForm.FormManagerFocusedAreaChanged;

var   AcumuladoExistencias : Decimal;
      I, J : SmallInt;
      ExistenciasArticulo : IExistenciasArticulo;

procedure InsertaRegistroPeriodo( NroMes, Indice : SmallInt );
begin
     With StockAlmacen, ExistenciasArticulo.SumaExistencias do
       begin

       AcumuladoExistencias := AcumuladoExistencias + MovimientosEntradaMes[ NroMes ] - MovimientosSalidaMes[ NroMes ];

       GridData.Append;
       GridDataIndice.Value := Indice;
       GridDataNombrePeriodo.Value := StPeriodo[ NroMes ];
       GridDataEntradas.Value := MovimientosEntradaMes[ NroMes ];
       GridDataSalidas.Value := MovimientosSalidaMes[ NroMes ];
       GridDataSaldo.Value := AcumuladoExistencias;
       GridData.Post;
       end;

end;

begin
     If   FormManager.DataAreaFocused
     then begin

          GridData.DeleteAllRecords;

          With StockAlmacen do
            begin

            ExistenciasArticulo := ObtenStock( DataCodigoArticulo.Value,
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
                                               True,
                                               ApplicationContainer.Ejercicio,
                                               0,
                                               ApplicationContainer.NroMesFinal );

            With DataModule00.DmEmpresaFields, ExistenciasArticulo do
              begin
              UltimaEntradaBox.Caption := StrFormatDate( FechaUltEntrada, dfDefault2 );
              UltimaSalidaBox.Caption := StrFormatDate( FechaUltSalida, dfDefault2 );
              UltimoCosteBox.Caption := StrFormat( CosteUltEntrada, Compras_DecPrecio.Value );
              CosteMedioBox.Caption := StrFormat( CosteMedio, Compras_DecPrecio.Value );
              PendienteRecibirBox.Caption := StrFormat( SumaExistencias.PendienteRecibir, Compras_DecCantidad.Value );
              PendienteServirBox.Caption := StrFormat( SumaExistencias.PendienteServir, Ventas_DecCantidad.Value );
              ExistenciasVirtualesBox.Caption := StrFormat( SumaExistencias.PendienteRecibir + SumaExistencias.Saldo - SumaExistencias.PendienteServir, Max( Compras_DecCantidad.Value, Ventas_DecCantidad.Value ) );

              AcumuladoExistencias := 0.0;

              InsertaRegistroPeriodo( 0, 0 );
              I := ApplicationContainer.NroMesInicial;
              J := 1;
              repeat
                InsertaRegistroPeriodo( I, J );
                Inc( J );
                Inc( I );
                If   I=13
                then I := 1;
              until J=13;

              end;

            GridDataSource.Enabled := True;
            end;

          end
     else begin
          UltimaEntradaBox.Caption := '';
          UltimaSalidaBox.Caption := '';
          UltimoCosteBox.Caption := '';
          CosteMedioBox.Caption := '';
          PendienteRecibirBox.Caption := '';
          PendienteServirBox.Caption := '';
          ExistenciasVirtualesBox.Caption := '';
          GridDataSource.Enabled := False;
          end;
end;

end.

