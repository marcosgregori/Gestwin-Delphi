unit a_odf;

interface

uses
 Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Grids, Menus, cxLookAndFeelPainters, cxGraphics, DB, nxdb,
  DataManager, cxMaskEdit, cxDropDownEdit, cxDBEdit, cxIndexedComboBox,
  cxCurrencyEdit, cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxLookAndFeels, dxSkinsCore, cxLabel, cxGroupBox, dxSkinsDefaultPainters,

  cxSpinEdit, cxDurationEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  cxIntegerEdit, cxCalendar, cxCheckBox, dxDateRanges, GridTableViewController, dxScrollbarAnnotations,

  LibUtils,
  AppForms,

  Gim30Fields,
  Gim70Fields,

  dmi_odf, dxBarBuiltInMenu, cxPC, f_not, dxUIAClasses;

type
  TMntOdfForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    NroOrdenCtrl: TcxDBIntegerEdit;
    OrdenFabricacionTable: TnxeTable;
    dataPanel: TgxEditPanel;
    OrdenFabricacionDataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    HeaderGroupBox: TcxGroupBox;
    LinesGroupBox: TcxGroupBox;
    LineaOFOperacionTable: TnxeTable;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    GridTableViewController: TGridTableViewController;
    LineaOFOperacionDataSource: TDataSource;
    LineaOFOperacionTableEjercicio: TSmallintField;
    LineaOFOperacionTableTipo: TSmallintField;
    LineaOFOperacionTableNroOrden: TIntegerField;
    LineaOFOperacionTableNroProceso: TSmallintField;
    LineaOFOperacionTableCodigoOperacion: TWideStringField;
    LineaOFOperacionTableOperacionExterna: TBooleanField;
    LineaOFOperacionTableCodigoSubcontratista: TWideStringField;
    LineaOFOperacionTableCodigoMaquina: TWideStringField;
    LineaOFOperacionTableTurno: TSmallintField;
    LineaOFOperacionTableFechaInicio: TDateField;
    LineaOFOperacionTableFechaFinalizacion: TDateField;
    LineaOFOperacionTableObservaciones: TWideStringField;
    GridViewNroProceso: TcxGridDBColumn;
    GridViewCodigoOperacion: TcxGridDBColumn;
    GridViewOperacionExterna: TcxGridDBColumn;
    GridViewCodigoSubcontratista: TcxGridDBColumn;
    GridViewFechaInicio: TcxGridDBColumn;
    GridViewFechaFinalizacion: TcxGridDBColumn;
    GridViewObservaciones: TcxGridDBColumn;
    LineaOFOperacionTableDescripcion: TWideStringField;
    GridViewDescripcion: TcxGridDBColumn;
    EstadoLabel: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    CargasCtrl: TcxDBTextEdit;
    SituacionButton: TgBitBtn;
    TareasButton: TgBitBtn;
    ReasignarButton: TgBitBtn;
    GridViewCodigoMaquina: TcxGridDBColumn;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxLabel3: TcxLabel;
    EjercicioPedidoCtrl: TcxDBSpinEdit;
    DescPedidoLabel: TcxLabel;
    NroPedidoCtrl: TcxDBIntegerEdit;
    CodigoArticuloCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    DescArticuloLabel: TcxLabel;
    cxLabel2: TcxLabel;
    LoteCtrl: TcxDBTextEdit;
    Label2: TcxLabel;
    FechaCtrl: TcxDBDateEdit;
    PrioridadCtrl: TcxDBIndexedComboBox;
    PrioridadLabel: TcxLabel;
    cxGroupBox4: TcxGroupBox;
    capClaseALabel: TcxLabel;
    CodigoClaseACtrl: TcxDBTextEdit;
    DescClaseALabel: TcxLabel;
    cxGroupBox3: TcxGroupBox;
    CodigoClaseBCtrl: TcxDBTextEdit;
    capClaseBLabel: TcxLabel;
    DescClaseBLabel: TcxLabel;
    cxGroupBox5: TcxGroupBox;
    CodigoClaseCCtrl: TcxDBTextEdit;
    capClaseCLabel: TcxLabel;
    DescClaseCLabel: TcxLabel;
    cxGroupBox6: TcxGroupBox;
    UnidadesAFabricarCtrl: TcxDBCurrencyEdit;
    LineaOFOperacionTableDescripcionOperacion: TWideStringField;
    GridViewDescripcionOperacion: TcxGridDBColumn;
    Panel1: TcxGroupBox;
    SerieCtrl: TcxDBTextEdit;
    SeparadorSerieLabel: TcxLabel;
    DetallesPageControl: TcxPageControl;
    ProcesosTabSheet: TcxTabSheet;
    AnotacionesTabSheet: TcxTabSheet;
    AnnotationFrame1: TAnnotationFrame;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure OrdenFabricacionTableNewRecord(DataSet: TDataSet);
    procedure LineaOFOperacionTableCalcFields(DataSet: TDataSet);
    procedure TableViewCodigoCostePropertiesEditRequest(Sender: TcxCustomEdit);
    procedure OrdenFabricacionTableUpdateState(DataSet: TDataSet);
    procedure OrdenFabricacionTableBeforeDelete(DataSet: TDataSet);
    procedure OrdenFabricacionTableGetRecord(DataSet: TDataSet);
    procedure NroOrdenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure PedidoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure NroPedidoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure OrdenFabricacionTableSetKey(DataSet: TDataSet);
    procedure LineaOFOperacionTableNewRecord(DataSet: TDataSet);
    function OrdenFabricacionTableCanEditRecord(Dataset: TDataSet): Boolean;
    procedure OrdenFabricacionTableBeforeEdit(DataSet: TDataSet);
    procedure CodigoClaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure LoteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValuePosted(Sender: TObject);
    procedure ReasignarButtonClick(Sender: TObject);
    procedure GridViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure LineaOFOperacionTableBeforeEdit(DataSet: TDataSet);
    procedure GridViewCodigoOperacionPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoOperacionPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoOperacionPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewCodigoOperacionPropertiesValuePosted(Sender: TObject);
    procedure LineaOFOperacionTableBeforePost(DataSet: TDataSet);
    procedure GridViewOperacionExternaPropertiesEditValueChanged(Sender: TObject);
    procedure GridViewOperacionExternaPropertiesChange(Sender: TObject);
    procedure GridViewCodigoMaquinaPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoMaquinaPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoMaquinaPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewCodigoSubcontratistaPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewCodigoSubcontratistaPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoSubcontratistaPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure LineaOFOperacionTableAfterPost(DataSet: TDataSet);
    procedure FormManagerReportFormRequest;
    procedure OrdenFabricacionTableBeforePost(DataSet: TDataSet);
    procedure UnidadesAFabricarCtrlPropertiesValuePosted(Sender: TObject);
    procedure OrdenFabricacionTableAfterPost(DataSet: TDataSet);
    procedure OrdenFabricacionTableRemoteDelete(DataSet: TDataSet);
    procedure OrdenFabricacionTableRemotePost(DataSet: TDataSet);
    procedure FormManagerShowCantEditMessage;
    procedure CargasCtrlPropertiesValuePosted(Sender: TObject);
    procedure TareasButtonClick(Sender: TObject);
    procedure SituacionButtonClick(Sender: TObject);
    procedure SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private
    OrdenFabricacionFields : TOrdenFabricacionFields;
    LineaOFOperacionFields : TLineaOFOperacionFields;

    ArticuloFields : TArticuloFields;
    MovimientoFields : TMovimientoFields;

    FEstadoOrdenFabricacion : TEstadoOrdenFabricacion;
    FReasignar,
    FOrdenCompletada,
    FAjusteCompletado : Boolean;
    FCantidadesModificadas : Boolean;

    procedure UpdateComponentsState;
    procedure FinalizaCreacionOrdenes(ProcessCanceled: Boolean);
    procedure DoCreateOrderProcess;
    procedure DoSeleccionaPedido( Target : TcxCustomEdit = nil );
    procedure AjustaFechasFabricacion;
    procedure DoAdjustDatesProcess;
    procedure RefreshRecord;
    procedure SetCantidadesModificadas( const Value : Boolean );
    procedure DoOnSeleccionRelacionMateriales( Target : TcxCustomEdit = nil );

  public

    property CantidadesModificadas : Boolean read FCantidadesModificadas write SetCantidadesModificadas;

  end;

var
  MntOdfForm: TMntOdfForm = nil;

procedure MntOrdenesFabricacion( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       DateUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm70Dm,
       Gdm70Frm,

       b_msg,
       b_pro,
       b_odf,
       b_tof,

       a_cdc,
       a_cls,
       a_lmp,
       a_opc,
       a_maq,
       a_pro,
       a_sdf,

       dmi_mov,
       dmi_cpr,

       dm_cls,
       dm_clp,  { Clases en producción }
       dm_odf,
       dm_mov,
       dm_cpr,
       dm_cli,
       dm_art,
       dm_lmp,
       dm_maq,
       dm_pro,
       dm_opc,
       dm_sdf,

       cx_cls1,
       cx_lmp,
       cx_ldp1,
       cx_ldp2,
       cx_opc,
       cx_maq,
       cx_pro,
       cx_mve,
       cx_odf,
       cx_sdf,

       r_odf;

resourceString
      RsMsg1   = 'El artículo tiene un stock negativo. Se considerará que no hay existencias.';
      RsMsg2   = 'Completando la orden de fabricación';
      RsMsg3   = 'Reasignando las fechas de fabricación.';
      RsMsg5   = '< Operacion dada de baja >';
      RsMsg6   = 'Esta es una operación EXTERNA. No puede asignar una máquina.';
      RsMsg7   = 'Esta es una operacion INTERNA. No puede asignar un subcontratista.';
      RsMsg8   = '¿Esta seguro de que desea modificar la fecha de inicio de este proceso?';
      RsMsg9   = 'Si reajusta la fecha de inicio de este proceso serán tambien ajustadas todas las  órdenes de fabricacion vinculadas con ésta.';
      RsMsg10  = '¿Esta seguro de que desea modificar la fecha, prioridad, unidades y/o las cargas a fabricar de esta orden?';
      RsMsg11  = 'El reajuste afectará a los tiempos de fabricación de esta orden y de todas las órdenes vinculadas, pero NO al numero de unidades a fabricar de estas últimas.';
      RsMsg12  = '¿Esta seguro de que desea modificar la fecha de finalización de este proceso?';
      RsMsg15  = 'Esta orden ya ha sido iniciada. No podrá modificar las cantidades ni las fechas de inicio y fin de operaciones ya realizadas.';
      RsMsg16  = 'Esta orden ha finalizado. No podrá modificar ningún dato a no ser que cambie su estado.';
      RsMsg17  = 'Esta orden está cerrada (ha finalizado y ha sido cerrado el ciclo de fabricación). No puede ser modificada.';
      RsMsg18  = 'Esta orden de fabricación ha sido iniciada y no puede darse de baja.';
      RsMsg19  = 'Si desea, de todas formas, suprimirla, dé de baja todos los informes de fabricación y notificaciones de esta órden y reintente el proceso.';
      RsMsg20  = 'No puede editar este proceso puesto que ya se han realizado movimientos con el mismo.';
      RsMsg21  = 'Si desea, de todas formas, modificarlo, suprima todos los informes de fabricación (o notificaciones de entrada/salida) de este proceso y reinténtelo.';
      RsMsg22  = 'Esta máquina es de un tipo diferente al indicado en la operación.';
      RsMsg23  = '¿Esta seguro de que desea modificar este proceso?';
      RsMsg24  = 'Tenga en cuenta que este cambio afectará a todas las asignaciones de tareas existentes de este proceso y los siguientes.';
      RsMsg25  = 'Este proceso reasignará las tareas del proceso, intentando reutilizar las posibles vacantes de tareas previamente programadas y luego eliminadas.';
      RsMsg26  = '¿Esta seguro de que desea reasignar esta orden de fabricación?';
      RsMsg27  = 'No ha modificado la prioridad, unidades a fabricar ni el número de cargas.';

procedure MntOrdenesFabricacion( KeyValues : array of const );
begin
     CreateEditForm( TMntOdfForm, MntOdfForm, KeyValues, Gds70Frm.ProduccionSection );
end;

procedure TMntOdfForm.RefreshRecord;
begin
     OrdenFabricacionTable.Refresh;
     GridView.DataController.UpdateItems( False );
end;

procedure TMntOdfForm.SerieCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] );
end;

procedure TMntOdfForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TMntOdfForm.SerieCtrlPropertiesValidate( Sender : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error : Boolean );
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntOdfForm.SetCantidadesModificadas(const Value: Boolean);
begin
     If   Value<>FCantidadesModificadas
     then begin
          FCantidadesModificadas := Value;
          UpdateComponentsState;
          end;
end;

procedure TMntOdfForm.LineaOFOperacionTableAfterPost(DataSet: TDataSet);
begin
     AjustaFechasFabricacion;
     If   FAjusteCompletado
     then begin
          OrdenFabricacionTable.Cancel;
          RefreshRecord;
          end
     else OrdenFabricacionTable.Edit;
end;

procedure TMntOdfForm.LineaOFOperacionTableBeforeEdit(DataSet: TDataSet);

var  ExistenciasContenedor : IExistenciasContenedor;

begin
     ExistenciasContenedor := Contenedor.ContenidoProceso( YearOf( OrdenFabricacionFields.FechaLanzamiento.Value ), OrdenFabricacionFields.NroOrden.Value, LineaOFOperacionFields.NroProceso.Value, cnProductoAcabado );
     If   ExistenciasContenedor.Salidas<>0.0
     then begin
          ShowNotification( ntStop, RsMsg20, RsMsg21 );
          Abort;
          end;
end;

procedure TMntOdfForm.LineaOFOperacionTableBeforePost(DataSet: TDataSet);
begin
     If   LineaOFOperacionTable.Modified
     then If   ShowNotification( ntQuestion, RsMsg23, RsMsg24 )<>mrYes
          then Abort;

end;

procedure TMntOdfForm.LineaOFOperacionTableCalcFields(DataSet: TDataSet);
begin
     LineaOFOperacionTableDescripcionOperacion.Value := Operacion.Descripcion( LineaOFOperacionTableCodigoOperacion.Value, False );
     If   LineaOFOperacionTableOperacionExterna.Value
     then LineaOFOperacionTableDescripcion.Value := Proveedor.Descripcion( LineaOFOperacionTableCodigoSubcontratista.Value, False )
     else LineaOFOperacionTableDescripcion.value := Maquina.Descripcion( LineaOFOperacionTableCodigoMaquina.Value, False );
end;

procedure TMntOdfForm.LineaOFOperacionTableNewRecord( DataSet : TDataSet );
begin
     With LineaOFOperacionFields do
       begin
       Ejercicio.Value := OrdenFabricacionFields.Ejercicio.Value;
       Tipo.Value := moOrden;
       NroOrden.Value := OrdenFabricacionFields.NroOrden.Value;
       end;
end;

procedure TMntOdfForm.LoteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DataModule00.DmEmpresaFields.Stock_TrazabilidadPorLotes.Value 
     then ConsultaLotesProductos2( Sender, OrdenFabricacionFields.CodigoArticulo.Value, OrdenFabricacionFields.FechaLanzamiento.Value, nil, scAmbas )
     else ConsultaLotesProductos1( Sender, OrdenFabricacionFields.CodigoArticulo.Value );
end;

procedure TMntOdfForm.UnidadesAFabricarCtrlPropertiesValuePosted(Sender: TObject);
begin
     If   OrdenFabricacionFields.Cargas.Value=0.0
     then If   ArticuloFields.UnidadesCarga.Value=0.0
          then OrdenFabricacionFields.Cargas.Value := 1
          else OrdenFabricacionFields.Cargas.Value := Round( OrdenFabricacionFields.UnidadesAFabricar.Value / ArticuloFields.UnidadesCarga.Value );
     CantidadesModificadas := True;
end;

procedure TmntOdfForm.DoCreateOrderProcess;
begin
     FOrdenCompletada := OrdenFabricacion.ActualizaOrden( OrdenFabricacionFields, FReasignar );
end;

procedure TMntOdfForm.AjustaFechasFabricacion;
begin
     CreateProcessForm( DoAdjustDatesProcess, RsMsg3 );
end;

procedure TmntOdfForm.DoAdjustDatesProcess;

var  FechaInicio,
     FechaFinalizacion : TDate;

begin

     FechaInicio := LineaOFOperacionFields.FechaInicio.Value;

     With OrdenFabricacionFields do
       FAjusteCompletado := OrdenFabricacion.AjustaFechasFabricacion( Ejercicio.Value,
                                                                      NroOrden.Value,
                                                                      LineaOFOperacionFields.NroProceso.Value,
                                                                      FechaInicio,
                                                                      FechaFinalizacion,
                                                                      True,
                                                                      True,
                                                                      True );
end;

procedure TmntOdfForm.FinalizaCreacionOrdenes( ProcessCanceled : Boolean );
begin
     {
     With OrdenFabricacionTable do
       begin

       If   SeleccionArticulos
       then OrdenFabricacion.SuprimePreSeleccionArticulos;

       If   ProcessCanceled
       then Cancel
       else begin
            State := esEdit;   // si no, se suprime el registro cuando está activada la preinserción
            Cancel;
            end;
       end;

     try
       MuestraReport;
     except
       end;
     }
end;

procedure TmntOdfForm.UpdateComponentsState;

var  ComponentsEnabled : Boolean;

begin
     ComponentsEnabled := OrdenFabricacionTable.State in [ dsSetKey, dsInsert ];
     SetGroupBoxControlsEnabled( HeaderGroupBox, ComponentsEnabled, { Force } True );  // Ahora es recursivo
     FechaCtrl.Enabled := ( FEstadoOrdenFabricacion=eoNoIniciada ) and ( CodigoArticuloCtrl.EditValue<>'' );
     PrioridadCtrl.Enabled := ( FEstadoOrdenFabricacion in [ eoNoIniciada, eoEnCurso ] ) and ( CodigoArticuloCtrl.EditValue<>'' );
     UnidadesAFabricarCtrl.Enabled := ( FEstadoOrdenFabricacion=eoNoIniciada ) and ( CodigoArticuloCtrl.EditValue<>'' );
     CargasCtrl.Enabled := UnidadesAFabricarCtrl.Enabled;
     TareasButton.Enabled := OrdenFabricacionTable.State=dsEdit;
     SituacionButton.Enabled := ( OrdenFabricacionTable.State=dsEdit ) and ( FEstadoOrdenFabricacion<>eoNoIniciada );
     DeleteButton.Enabled := ( OrdenFabricacionTable.State=dsEdit ) and ( FEstadoOrdenFabricacion=eoNoIniciada );
     ReasignarButton.Enabled := ( OrdenFabricacionTable.State=dsEdit ) and ( FEstadoOrdenFabricacion in [ eoNoIniciada, eoEnCurso ] ) and not FCantidadesModificadas;
     // Grid.Enabled := OrdenFabricacionTable.State=dsEdit;
end;

procedure TMntOdfForm.OrdenFabricacionTableGetRecord(DataSet: TDataSet);
begin

     If   Assigned( OrdenFabricacionFields ) and
          not OrdenFabricacionFields.Ejercicio.IsNull
     then begin

          With OrdenFabricacionFields do
            FEstadoOrdenFabricacion := OrdenFabricacion.Estado( Ejercicio.Value, Tipo.Value, NroOrden.Value );

          EstadoLabel.Caption := OrdenFabricacion.TextoEstado( FEstadoOrdenFabricacion );

          case FEstadoOrdenFabricacion of
            eoNoIniciada  : EstadoLabel.Style.TextColor := clIconGreen;
            eoEnCurso     : EstadoLabel.Style.TextColor := clIconOrange;
            eoFinalizada,
            eoCerrada     : EstadoLabel.Style.TextColor := clIconRed;
            end;

          // Hay que obtener la ficha del artículo porque la validación del código de artículo puede estar desactivada

          Articulo.Obten( OrdenFabricacionFields.CodigoArticulo.Value, ArticuloFields );

          end;

     CantidadesModificadas := False;
end;

procedure TMntOdfForm.CodigoClaseCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With OrdenFabricacionFields do
       dm_cls.ConsultaClases( TNroClase( Sender.Tag ), CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, '', Sender );
end;

procedure TMntOdfForm.CodigoClaseCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( TNroClase( Sender.Tag ), False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntOdfForm.CargasCtrlPropertiesValuePosted(Sender: TObject);
begin
     CantidadesModificadas := True;
end;

procedure TMntOdfForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntRelacionMaterialesProcesos( [ Sender.EditingValue ] );
end;

procedure TMntOdfForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRelacionMateriales( Sender, qgsNormal, DoOnSeleccionRelacionMateriales );
end;

procedure TMntOdfForm.DoOnSeleccionRelacionMateriales( Target : TcxCustomEdit = nil );
begin
     CodigoArticuloCtrl.PostEditValue( CxLmpForm.QueryCodigoArticulo.Value );
     CodigoClaseACtrl.PostEditValue( CxLmpForm.QueryCodigoClaseA.Value );
     CodigoClaseBCtrl.PostEditValue( CxLmpForm.QueryCodigoClaseB.Value );
     CodigoClaseCCtrl.PostEditValue( CxLmpForm.QueryCodigoClaseC.Value );
end;

procedure TMntOdfForm.CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ListaMaterialesProcesos.Valida( Sender, DisplayValue, ErrorText, Error, ArticuloFields );
end;

procedure TMntOdfForm.CodigoArticuloCtrlPropertiesValuePosted(Sender: TObject);
begin
     UpdateComponentsState;
end;

procedure TMntOdfForm.CodigoClaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( Sender.Tag ), Sender.EditingValue ] );
end;

procedure TMntOdfForm.FormManagerInitializeForm;
begin
     OrdenFabricacionFields := TOrdenFabricacionFields.Create( OrdenFabricacionTable );
     LineaOFOperacionFields := TLineaOFOperacionFields.Create( LineaOFOperacionTable );

     ArticuloFields := TArticuloFields.Create( Self );
     MovimientoFields := TMovimientoFields.Create( Self );

     With DataModule00.DmEmpresaFields do
       begin
       SetEditControlsDecimals( [ UnidadesAFabricarCtrl ], Ventas_DecCantidad.Value );

       end;

     If   Movimiento.SeriesEnDocumentosVenta( tmPedidoVenta )
     then FormManager.FirstDataControl := SerieCtrl
     else begin
          SerieCtrl.Visible := False;
          SeparadorSerieLabel.Visible := False;
          end;

     // SetColumnDecimals( TableViewCoste );

     ClaseProduccion.SetupEditControls( CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl, 0, True );

     OrdenFabricacionTable.SetDefaultRangeValues( [ ApplicationContainer.Ejercicio, moOrden ], [ ApplicationContainer.Ejercicio, moOrden ] );
     SetFieldRange( OrdenFabricacionFields.NroOrden );

end;

procedure TMntOdfForm.FormManagerReportFormRequest;
begin
     InformeOrdenesFabricacion( OrdenFabricacionFields.NroOrden.Value, True );
end;

procedure TMntOdfForm.FormManagerReportRequest;
begin
     InformeOrdenesFabricacion( OrdenFabricacionFields.NroOrden.Value );
end;

procedure TMntOdfForm.FormManagerShowCantEditMessage;
begin
     case FEstadoOrdenFabricacion of
       eoFinalizada : ShowNotification( ntWarning, RsMsg16 );
       eoCerrada    : ShowNotification( ntStop, RsMsg17 );
       end;
end;

procedure TMntOdfForm.GridViewCodigoMaquinaPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntMaquinas( [ Sender.EditingValue ] );
end;

procedure TMntOdfForm.GridViewCodigoMaquinaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMaquinas( Sender );
end;

procedure TMntOdfForm.GridViewCodigoMaquinaPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Maquina.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntOdfForm.GridViewCodigoOperacionPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntOperaciones( [ Sender.EditingValue ] );
end;

procedure TMntOdfForm.GridViewCodigoOperacionPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOperaciones( topAmbas, Sender );
end;

procedure TMntOdfForm.GridViewCodigoOperacionPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Operacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntOdfForm.GridViewCodigoOperacionPropertiesValuePosted(Sender: TObject);
begin
     If   LineaOFOperacionFields.CodigoOperacion.OldValue<>LineaOFOperacionFields.CodigoOperacion.Value
     then With LineaOFOperacionFields do
            begin
            CodigoMaquina.Clear;
            CodigoSubcontratista.Clear;
            end;
end;

procedure TMntOdfForm.GridViewCodigoSubcontratistaPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TMntOdfForm.GridViewCodigoSubcontratistaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TMntOdfForm.GridViewCodigoSubcontratistaPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntOdfForm.GridViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     (*
     With AViewInfo.GridRecord do
       { If   not AViewInfo.Selected
       then }If   VarToInteger( Values[ GridViewEstado.Index ] )=2
       then ACanvas.Font.Color := clMaroon;
     *)
end;

procedure TMntOdfForm.GridViewOperacionExternaPropertiesChange(Sender: TObject);

var  OperacionExterna : Boolean;

begin
     OperacionExterna := GridViewOperacionExterna.EditValue;
end;

procedure TMntOdfForm.GridViewOperacionExternaPropertiesEditValueChanged(Sender: TObject);

var  OperacionExterna : Boolean;

begin

     OperacionExterna := TcxCustomEdit( Sender ).EditValue;
     
     With GridViewCodigoMaquina.Options do
       begin
       Editing := not OperacionExterna;
       Focusing := not OperacionExterna;
       end;

     With GridViewCodigoSubcontratista.Options do
       begin
       Editing := OperacionExterna;
       Focusing := OperacionExterna;
       end;

     If   LineaOFOperacionTable.Editing
     then With LineaOFOperacionFields do
            If   OperacionExterna.Value
            then CodigoMaquina.Clear
            else CodigoSubcontratista.Clear;
end;

procedure TMntOdfForm.OrdenFabricacionTableAfterPost(DataSet: TDataSet);
begin
       If   FOrdenCompletada
       then begin
            OrdenFabricacionTable.Cancel;
            RefreshRecord;
            end
       else OrdenFabricacionTable.Edit;
end;

procedure TMntOdfForm.OrdenFabricacionTableBeforeDelete(DataSet: TDataSet);
begin
     If   FEstadoOrdenFabricacion<>eoNoIniciada
     then begin
          ShowNotification( ntStop, RsMsg18, RsMsg19 );
          Abort;
          end;
end;

procedure TMntOdfForm.OrdenFabricacionTableBeforeEdit(DataSet: TDataSet);
begin
     If   FEstadoOrdenFabricacion=eoEnCurso
     then ShowNotification( ntWarning, RsMsg15 );
end;

procedure TMntOdfForm.OrdenFabricacionTableBeforePost(DataSet: TDataSet);

procedure CancelaProceso;
begin
     OrdenFabricacionTable.Cancel;
     Abort;
end;

begin

     OrdenFabricacionFields.EjercicioLanzamiento.Value := YearOf( OrdenFabricacionFields.FechaLanzamiento.Value );

     FReasignar := OrdenFabricacionTable.State=dsInsert;

     If   OrdenFabricacionTable.State=dsEdit
     then If  ( OrdenFabricacionFields.FechaLanzamiento.Value<>OrdenFabricacionFields.FechaLanzamiento.OldValue ) or
              ( OrdenFabricacionFields.Prioridad.Value<>OrdenFabricacionFields.Prioridad.OldValue ) or
              ( OrdenFabricacionFields.UnidadesAFabricar.Value<>OrdenFabricacionFields.UnidadesAFabricar.OldValue ) or
              ( OrdenFabricacionFields.Cargas.Value<>OrdenFabricacionFields.Cargas.OldValue )
          then If   ShowNotification( ntQuestion, RsMsg10, RsMsg11 )<>mrYes
               then CancelaProceso
               else FReasignar := True;
          {
          else If   ShowNotification( ntQuestion, RsMsg27, RsMsg26 )<>mrYes
               then CancelaProceso;
          }
end;

function TMntOdfForm.OrdenFabricacionTableCanEditRecord(Dataset: TDataSet): Boolean;
begin
     Result := ( OrdenFabricacionFields.Ejercicio.Value=ApplicationContainer.Ejercicio ) and not ( FEstadoOrdenFabricacion in [ eoFinalizada, eoCerrada ] );
end;

procedure TMntOdfForm.OrdenFabricacionTableNewRecord(DataSet: TDataSet);
begin

     With OrdenFabricacionFields do
       begin
       Ejercicio.Value := ApplicationContainer.Ejercicio;

       SeriePedido.Value := '';
       EjercicioPedido.Value := ApplicationContainer.Ejercicio;
       FechaLanzamiento.Value := ApplicationContainer.TodayDate;

       Prioridad.Value := 1;  // Por defecto, media

       Contenedor.SuprimeReferenciasOrden( Ejercicio.Value, NroOrden.Value );
       end;

     FEstadoOrdenFabricacion := eoNoIniciada;
     EstadoLabel.Caption := '';

     UpdateComponentsState;
end;

procedure TMntOdfForm.OrdenFabricacionTableRemoteDelete(DataSet: TDataSet);
begin
     OrdenFabricacion.SuprimeOrden( OrdenFabricacionFields, { SuprimeCabecera } True, { SuprimeLineas } True );
end;

procedure TMntOdfForm.OrdenFabricacionTableRemotePost(DataSet: TDataSet);
begin
     If   FReasignar
     then CreateProcessForm( DoCreateOrderProcess, RsMsg2 )
     else DoCreateOrderProcess;
end;

procedure TMntOdfForm.OrdenFabricacionTableSetKey(DataSet: TDataSet);
begin
     OrdenFabricacionFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
end;

procedure TMntOdfForm.OrdenFabricacionTableUpdateState(DataSet: TDataSet);
begin
     UpdateComponentsState;
     LineaOFOperacionDataSource.Enabled := not ( OrdenFabricacionTable.State in [ dsSetKey, dsInsert ] );
end;

procedure TMntOdfForm.TableViewCodigoCostePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosCoste( [ Sender.EditingValue ] );
end;

procedure TMntOdfForm.TareasButtonClick(Sender: TObject);
begin
     With OrdenFabricacionFields do
       ConsultaTareasOrden( [ Ejercicio.Value, Tipo.Value, NroOrden.Value ] );
end;

procedure TMntOdfForm.NroOrdenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOrdenesFabricacion( ApplicationContainer.Ejercicio, Sender, qgsLinked );
end;

procedure TMntOdfForm.NroPedidoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With OrdenFabricacionFields do
       ConsultaMovimientosVenta( tmPedidoVenta, sdTodos, SeriePedido, Sender, qgsNormal, '', DoSeleccionaPedido );
end;

procedure TMntOdfForm.DoSeleccionaPedido( Target : TcxCustomEdit = nil );
begin
     With CxMveForm[ tmPedidoVenta ] do
       begin
       EjercicioPedidoCtrl.PostEditValue( QueryEjercicio.Value );
       SerieCtrl.PostEditValue( QuerySerie.Value );
       NroPedidoCtrl.PostEditValue( QueryNroDocumento.Value );
       end;
end;

procedure TMntOdfForm.SituacionButtonClick(Sender: TObject);
begin
     With OrdenFabricacionFields do
       SituacionOrdenFabricacion( [ Ejercicio.Value, Tipo.Value, NroOrden.Value ] );
end;

procedure TMntOdfForm.PedidoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Descripcion : String;
     EjercicioPedido : SmallInt;
     NroPedido : LongInt;
     SeriePedido : String;

begin

     Descripcion := '';
     SeriePedido := OrdenFabricacionFields.SeriePedido.Value;

     If   Sender=EjercicioPedidoCtrl
     then begin
          EjercicioPedido := VarToInteger( DisplayValue );
          NroPedido := OrdenFabricacionFields.NroPedido.Value;
          If   EjercicioPedidoCtrl.Editing
          then begin
               SerieCtrl.Enabled := EjercicioPedido<>0;
               NroPedidoCtrl.Enabled := EjercicioPedido<>0;
               ResetTab;
               end;
          end
     else If   Sender=NroPedidoCtrl
          then begin
               EjercicioPedido := OrdenFabricacionFields.EjercicioPedido.Value;
               NroPedido := VarToInteger( DisplayValue );
               end;

     If   ( EjercicioPedido<>0 ) and ( NroPedido<>0 )
     then begin
          Movimiento.Valida( Sender, tmPedidoVenta, EjercicioPedido, SeriePedido, NroPedido, ErrorText, Error, { IsInfoControl } False, MovimientoFields );
          If   not Error
          then Descripcion := StrFormatDate( MovimientoFields.Fecha.Value ) + ', ' + Cliente.Descripcion( MovimientoFields.Propietario.Value );
          end;

     NroPedidoCtrl.Description := Descripcion;

end;

procedure TMntOdfForm.ReasignarButtonClick(Sender: TObject);
begin
     OrdenFabricacionTable.Post;
     LineaOFOperacionTable.First;
     AjustaFechasFabricacion;
     If   FAjusteCompletado
     then begin
          // El estado de OrdenFabricacionTable es, debido al Post previo, dsBrowse, por lo que el Cancel no posicionará el cursor en el área de clave.
          OrdenFabricacionTable.Cancel;
          FormManager.SelectFirstKeyControl;
          OrdenFabricacionTable.Refresh;
          end
     else OrdenFabricacionTable.Edit;
end;


end.
