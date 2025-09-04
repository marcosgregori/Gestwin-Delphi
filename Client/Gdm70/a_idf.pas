

unit a_idf;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Grids, Menus, cxLookAndFeelPainters, cxGraphics, DB, nxdb,
  DataManager, cxMaskEdit, cxDropDownEdit, cxDBEdit, cxIndexedComboBox,
  cxCurrencyEdit, cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxLookAndFeels, dxSkinsCore, cxLabel, cxGroupBox, dxSkinsDefaultPainters,

  cxSpinEdit, cxDurationEdit, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  cxIntegerEdit,

  LibUtils,

  Gim30Fields,
  Gim70Fields,

  dmi_odf, cxCalendar, cxCheckBox, dxBarBuiltInMenu, cxPC, cxTimeEdit, f_not,
  dxDateRanges, AppForms, GridTableViewController, dxScrollbarAnnotations,
  dxUIAClasses;

type
  TMntIdfForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    NroOrdenCtrl: TcxDBIntegerEdit;
    InformeFabricacionTable: TnxeTable;
    DataPanel: TgxEditPanel;
    InformeFabricacionDataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    HeaderGroupBox: TcxGroupBox;
    LinesGroupBox: TcxGroupBox;
    LineaInformeFabricacionTable: TnxeTable;
    LineaInformeFabricacionDataSource: TDataSource;
    EstadoLabel: TcxLabel;
    ReasignarButton: TgBitBtn;
    EjercicioCtrl: TcxDBSpinEdit;
    Tareas1Button: TgBitBtn;
    cxLabel6: TcxLabel;
    NroProcesoCtrl: TcxDBSpinEdit;
    cxLabel7: TcxLabel;
    FechaCtrl: TcxDBDateEdit;
    cxLabel8: TcxLabel;
    TurnoCtrl: TcxDBSpinEdit;
    DescOperacionLabel: TcxLabel;
    DescMaquinaLabel: TcxLabel;
    DescTurnoLabel: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxGroupBox3: TcxGroupBox;
    cxGroupBox4: TcxGroupBox;
    cxGroupBox5: TcxGroupBox;
    cxLabel3: TcxLabel;
    cxLabel1: TcxLabel;
    DescArticuloLabel: TcxLabel;
    capClaseALabel: TcxLabel;
    DescClaseALabel: TcxLabel;
    capClaseBLabel: TcxLabel;
    DescClaseBLabel: TcxLabel;
    capClaseCLabel: TcxLabel;
    DescClaseCLabel: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel12: TcxLabel;
    cxLabel13: TcxLabel;
    DataPageControl: TcxPageControl;
    FabricacionTS: TcxTabSheet;
    OperariosTS: TcxTabSheet;
    ComponentesTS: TcxTabSheet;
    cxLabel4: TcxLabel;
    CorrectasCtrl: TcxDBCurrencyEdit;
    cxLabel5: TcxLabel;
    DefectuosasCtrl: TcxDBCurrencyEdit;
    cxLabel14: TcxLabel;
    CodigoDefectoCtrl: TcxDBSpinEdit;
    IncorpExtraidasCtrl: TcxDBCurrencyEdit;
    cxLabel15: TcxLabel;
    MermaExcesoCtrl: TcxDBCurrencyEdit;
    cxLabel16: TcxLabel;
    cxLabel17: TcxLabel;
    cxLabel18: TcxLabel;
    HoraInicioCtrl: TcxDBTimeEdit;
    HoraFinalizacionCtrl: TcxDBTimeEdit;
    cxLabel19: TcxLabel;
    cxLabel20: TcxLabel;
    cxLabel21: TcxLabel;
    cxLabel22: TcxLabel;
    cxLabel23: TcxLabel;
    CodigoIncidenciaCtrl: TcxDBSpinEdit;
    cxLabel24: TcxLabel;
    TarifasPanel: TcxGroupBox;
    OperariosGrid: TcxGrid;
    OperariosGridLevel: TcxGridLevel;
    OperariosTableView: TcxGridDBTableView;
    GridTableViewController: TGridTableViewController;
    cxGroupBox9: TcxGroupBox;
    ComponentesGrid: TcxGrid;
    ComponentesTableView: TcxGridDBTableView;
    ComponentesGridLevel: TcxGridLevel;
    GridTableViewController1: TGridTableViewController;
    LineaInformeFabricacionTableEjercicio: TSmallintField;
    LineaInformeFabricacionTableNroOrden: TIntegerField;
    LineaInformeFabricacionTableNroProceso: TSmallintField;
    LineaInformeFabricacionTableFecha: TDateField;
    LineaInformeFabricacionTableTurno: TSmallintField;
    LineaInformeFabricacionTableNroRegistro: TSmallintField;
    LineaInformeFabricacionTableCodigoOperario: TWideStringField;
    LineaOFComponenteDataSource: TDataSource;
    LineaOFComponenteTable: TnxeTable;
    LineaOFComponenteTableEjercicio: TSmallintField;
    LineaOFComponenteTableTipo: TSmallintField;
    LineaOFComponenteTableNroOrden: TIntegerField;
    LineaOFComponenteTableNroProceso: TSmallintField;
    LineaOFComponenteTableNroRegistro: TSmallintField;
    LineaOFComponenteTableCodigoArticulo: TWideStringField;
    LineaOFComponenteTableCodigoClaseA: TWideStringField;
    LineaOFComponenteTableCodigoClaseB: TWideStringField;
    LineaOFComponenteTableCodigoClaseC: TWideStringField;
    LineaOFComponenteTableLote: TWideStringField;
    ObservacionesTS: TcxTabSheet;
    TAnnotationFrame1: TAnnotationFrame;
    cxLabel25: TcxLabel;
    IncExtClaseACtrl: TcxDBTextEdit;
    cxLabel26: TcxLabel;
    cxLabel27: TcxLabel;
    cxLabel28: TcxLabel;
    DescPedidoLabel: TcxLabel;
    MasDefectosButton: TgBitBtn;
    DefectoInformeFabricacionTable: TnxeTable;
    LineaOFOperacionTable: TnxeTable;
    SecuenciaAsignacionTable: TnxeTable;
    SecuenciaAsignacion1Table: TnxeTable;
    OperariosMaquinaTable: TnxeTable;
    ComponentesTableViewCodigoArticulo: TcxGridDBColumn;
    ComponentesTableViewCodigoClaseA: TcxGridDBColumn;
    ComponentesTableViewCodigoClaseB: TcxGridDBColumn;
    ComponentesTableViewCodigoClaseC: TcxGridDBColumn;
    ComponentesTableViewLote: TcxGridDBColumn;
    ComponentesTableViewCantidad: TcxGridDBColumn;
    ComponentesTableViewConsumoPrevisto: TcxGridDBColumn;
    ComponentesTableViewConsumoReal: TcxGridDBColumn;
    OperariosTableViewCodigoOperario: TcxGridDBColumn;
    LineaOFComponenteTableDescripcion: TWideStringField;
    ComponentesTableViewDescripcion: TcxGridDBColumn;
    LineaInformeFabricacionTableNombre: TWideStringField;
    OperariosTableViewNombre: TcxGridDBColumn;
    LoteBox: TcxLabel;
    AProcesarBox: TcxLabel;
    DuracionPrevistaBox: TcxLabel;
    CodigoClaseCBox: TcxLabel;
    CodigoClaseBBox: TcxLabel;
    CodigoClaseABox: TcxLabel;
    EjercicioPedidoBox: TcxLabel;
    NroPedidoBox: TcxLabel;
    CodigoArticuloBox: TcxLabel;
    DuracionLabel: TcxLabel;
    Tareas2Button: TgBitBtn;
    PreparacionCtrl: TcxDBDurationEdit;
    FabricacionCtrl: TcxDBDurationEdit;
    LineaOFComponenteTableCantidadOriginal: TFloatField;
    LineaOFComponenteTableCantidad: TFloatField;
    LineaOFComponenteTableConsumoPrevisto: TFloatField;
    LineaOFComponenteTableConsumoReal: TFloatField;
    procedure FormManagerInitializeForm;
    procedure InformeFabricacionTableNewRecord(DataSet: TDataSet);
    procedure InformeFabricacionTableUpdateState(DataSet: TDataSet);
    procedure InformeFabricacionTableBeforeDelete(DataSet: TDataSet);
    function InformeFabricacionTableCanEditRecord(Dataset: TDataSet): Boolean;
    procedure TableViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    function LineaInformeFabricacionTableCanEditRecord(Dataset: TDataSet): Boolean;
    procedure TableViewCodigoSubcontratistaPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure NroOrdenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure TurnoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure TurnoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TurnoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure DefectuosasCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure InicioFinCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure FabricacionCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure CodigoIncidenciaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoIncidenciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoIncidenciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure NroProcesoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure NroOrdenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure LineaOFComponenteTableCalcFields(DataSet: TDataSet);
    procedure LineaInformeFabricacionTableCalcFields(DataSet: TDataSet);
    procedure OperariosTableViewCodigoOperarioPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure OperariosTableViewCodigoOperarioPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure OperariosTableViewCodigoOperarioPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure EjercicioCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure FechaCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure EjercicioCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure Tareas1ButtonClick(Sender: TObject);
    procedure InformeFabricacionTableGetRecord(DataSet: TDataSet);
    procedure MermaExcesoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure ComponentesTableViewCantidadPropertiesValuePosted(Sender: TObject);
    procedure FormManagerBeforePostEditRecord;
    procedure LineaOFComponenteTableApplyMasterRange(DataSet: TDataSet);
    procedure InformeFabricacionTableBeforeCancel(DataSet: TDataSet);
    procedure InformeFabricacionTableRemoteDelete(DataSet: TDataSet);
    procedure InformeFabricacionTableRemotePost(DataSet: TDataSet);
    procedure IncExtClaseACtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure IncExtClaseACtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoDefectoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoDefectoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoDefectoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure IncExtClaseACtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure InformeFabricacionTableAfterInsert(DataSet: TDataSet);
    procedure Tareas2ButtonClick(Sender: TObject);
    procedure InicioFinCtrlPropertiesValuePosted(Sender: TObject);
    procedure PreparacionCtrlPropertiesValuePosted(Sender: TObject);
    procedure CorrectasCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ComponentesTableViewLotePropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ComponentesTableViewCodigoArticuloPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ComponentesTableViewCodigoArticuloPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ComponentesTableViewCodigoArticuloPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure LineaOFComponenteTableNewRecord(DataSet: TDataSet);
    procedure LineaOFComponenteTableBeforePost(DataSet: TDataSet);
    procedure LineaInformeFabricacionTableBeforePost(DataSet: TDataSet);
  private

    InformeFabricacionFields,
    PrevInformeFabricacionFields : TInformeFabricacionFields;
    LineaInformeFabricacionFields : TLineaInformeFabricacionFields;
    LineaOFComponenteFields : TLineaOFComponenteFields;
    LineaOFOperacionFields : TLineaOFOperacionFields;
    SecuenciaAsignacionFields,
    SecuenciaAsignacion1Fields : TSecuenciaAsignacionFields;
    OperariosMaquinaFields : TOperariosMaquinaFields;
    DefectoInformeFabricacionFields : TDefectoInformeFabricacionFields;

    OrdenFabricacionFields : TOrdenFabricacionFields;

    FechaFinalizacion : TDate;
    DuracionTarea : TDuration;
    CantidadProcesoAnterior : Decimal;
    EstadoOrdenFabricacion : TEstadoOrdenFabricacion;

    NroOrdenListaOperarios : LongInt;
    NroProcesoListaOperarios : SmallInt;
    FechaListaOperarios : TDate;
    TurnoListaOperarios : SmallInt;

    CantidadProcesada,
    TotalCantidad,
    TotalConsumoPrevisto,
    TotalConsumoReal : Decimal;

    RegistroNuevo,
    RecalcularProceso : Boolean;

    StockProcesoAnterior,
    CantidadPendienteAnterior,
    CantidadAtipica,
    Cantidad,
    CantidadProcesadaCorrecta : Decimal;

    procedure DoOnUpdateSelection( NroOrden : LongInt; NroProceso : SmallInt; Fecha : TDate; Turno : SmallInt );
    procedure DoOnNroOrdenSelected( Target : TcxCustomEdit = nil );

    function  UltimaTareaDelProceso : Boolean;
    procedure MuestraDuracion;
    function  ObtenTarea : Boolean;
    procedure CompruebaCantidadProceso( Avisar : Boolean );
    procedure CompruebaListaDefectos;
    procedure ActualizaConsumo;

    procedure UpdateComponentsState;
    procedure DoOnSeleccionTarea( Target : TcxCustomEdit = nil );

  public
  end;

var
  MntIdfForm: TMntIdfForm = nil;

procedure MntInformesFabricacion( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       DateUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm70Dm,
       Gdm70Frm,

       a_pde7,

       b_msg,
       b_pro,

       a_art,
       a_cdc,
       a_cls,
       a_lmp,
       a_opc,
       a_maq,
       a_pro,
       a_tur,
       a_inc,
       a_ope,
       a_def,

       dmi_mov,
       dmi_cpr,

       dm_idf,
       dm_odf,
       dm_mov,
       dm_cpr,
       dm_cli,
       dm_cls,
       dm_clp,  { Clases en producción }
       dm_art,
       dm_lmp,
       dm_maq,
       dm_pro,
       dm_opc,
       dm_tur,
       dm_inc,
       dm_ope,
       dm_def,

       cx_art,
       cx_tof,
       cx_cls1,
       cx_lmp,
       cx_ldp1,
       cx_ldp2,
       cx_opc,
       cx_maq,
       cx_pro,
       cx_mve,
       cx_odf,
       cx_tur,
       cx_inc,
       cx_opr,
       cx_def;

       {
       l_odf;
       }

resourceString
     RsMsg1  = 'Debe introducir una cantidad de articulos defectuosos puesto que no ha especificado ningún valor en correctas.';
     RsMsg3  = 'Este proceso corresponde a una operación externa.';
     RsMsg4  = 'Utilice las NOTIFICACIONES DE ENTRADA Y SALIDA para reflejar este tipo de operaciones.';
     RsMsg6  = 'El registro actual no se va a actualizar.';
     RsMsg8  = 'El número de unidades es superior al registrado en el proceso anterior.';
     RsMsg9  = 'No he conseguido recuperar el registro del proceso actual.';
     RsMsg10 = 'No se ha podido realizar el trasvase de material desde/hacia los contenedor involucrados.';
     RsMsg11 = 'Revise el estado de sus ficheros y , en particular, el de la orden de fabricación utilizada.';
     RsMsg12 = 'No existe ningúna tarea asignada en la fecha y turno indicados.';
     RsMsg13 = 'Utilice el botón [Tareas ...] para consultar las existentes.';
     RsMsg14 = 'Revise los informes de fabricacion anteriores a éste.';
     RsMsg15 = 'Las cantidades introducidas no coinciden con la producción esperada.';
     RsMsg16 = 'Se van a comprobar las cantidades y fechas de inicio y finalización de los procesos involucrados.' + #13 + 'Si los valores introducidos no son correctos pulse [Cancelar].';
     RsMsg17 = 'El número de proceso especificado no existe.';
     RsMsg18 = 'El proceso actual ha finalizado y se ha producido una variación en las cantidades a procesar de la orden de fabricación.';
     RsMsg20 = 'Traspasado. Movimiento de almacén nº %d.';
     RsMsg21 = 'No puede editar este informe. La orden de fabricación está cerrada (ya ha sido traspasada).';
     RsMsg22 = 'Si desea rectificar este informe deberá antes quitar la marca de traspaso de la orden a la que pertenece.';
     // RsMsg23 = 'Lanzada el %s. (%d)';
     RsMsg24 = 'Solo puede especificar órdenes de fabricación del ejercicio anterior o actual.';
     RsMsg25 = 'La cantidad procesada ( correctas + defectuosas ) no puede ser diferente de la esperada.';
     RsMsg26 = 'Ésta es la última tarea de este proceso y el incremento de la producción no se ha justificado mediante la introducción de excesos.';
     RsMsg27 = 'La supresión de este informe puede afectar a las tareas posteriores de esta órden.';
     RsMsg28 = '¿Desea reajustar las tareas afectadas por esta supresion, realizando de nuevo la asignación de las mismas?.';
     RsMsg29 = 'No hay ningún operario asignado a la máquina y turno de este proceso.';
     RsMsg30 = 'Asigne un operario a la máquina y reintente la creación del informe';
     RsMsg31 = 'La hora de finalización debe ser posterior a la de inicio.';
     RsMsg32 = 'Ya ha incluído a este operario en la relación.';

procedure MntInformesFabricacion( KeyValues : array of const );
begin
     CreateEditForm( TMntIdfForm, MntIdfForm, KeyValues, Gds70Frm.ProduccionSection );
end;

procedure TMntIdfForm.DefectuosasCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var   Defectuosas : Decimal;
      ExistList : Boolean;

begin
     DefectoInformeFabricacionTable.First;
     Defectuosas := VarToDecimal( DisplayValue );
     CodigoDefectoCtrl.Enabled := ( Defectuosas<>0.0 ) and DefectoInformeFabricacionTable.Eof;
     // Más adelante ... MasDefectosButton.Enabled := ( Defectuosas<>0.0 ) or not DefectoInformeFabricacionTable.Eof;
     DefectuosasCtrl.Enabled := DefectoInformeFabricacionTable.Eof;
     CompruebaListaDefectos;
     If   DefectuosasCtrl.Editing
     then ResetTab;
end;

procedure TMntIdfForm.CodigoDefectoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntDefectos( [ Sender.EditingValue ] );
end;

procedure TMntIdfForm.CodigoDefectoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaDefectos( Sender );
end;

procedure TMntIdfForm.CodigoDefectoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Defecto.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntIdfForm.CodigoIncidenciaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntIncidencias( [ Sender.EditingValue ] );
end;

procedure TMntIdfForm.CodigoIncidenciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaIncidencias( Sender );
end;

procedure TMntIdfForm.CodigoIncidenciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Incidencia.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntIdfForm.ComponentesTableViewCantidadPropertiesValuePosted(Sender: TObject);
begin
     ActualizaConsumo;
end;

procedure TMntIdfForm.ActualizaConsumo;
begin
      // Si se modifica la cantidad se recalcula el consumo real

     If   LineaOFComponenteTable.Editing and
          ( LineaOFComponenteTableCantidad.Value<>LineaOFComponenteTableCantidad.OldValue )
     then LineaOFComponenteTableConsumoReal.Value := LineaOFComponenteTableCantidad.Value * OrdenfabricacionFields.UnidadesAFabricar.Value;

end;

procedure TMntIdfForm.ComponentesTableViewCodigoArticuloPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntIdfForm.ComponentesTableViewCodigoArticuloPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TMntIdfForm.ComponentesTableViewCodigoArticuloPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntIdfForm.ComponentesTableViewLotePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DataModule00.DmEmpresaFields.Stock_TrazabilidadPorLotes.Value
     then ConsultaLotesProductos2( Sender, LineaOFComponenteFields.CodigoArticulo.Value, InformeFabricacionFields.Fecha.Value, nil, scAmbas )
     else ConsultaLotesProductos1( Sender, LineaOFComponenteFields.CodigoArticulo.Value );
end;

procedure TMntIdfForm.CompruebaCantidadProceso(Avisar: Boolean);
begin
     {
      Posible reajuste del proceso SIGUIENTE (y posteriores, por supuesto)

      Comprobacion 1 : 1 - Si se está editando el informe cabe el reajuste si ya está introducido el último de este proceso.
                       2 - Si es un informe nuevo, sólo si éste es el último del proceso.

      Comprobación 2: Si la suma de cantidades correctas no coincide con la suma de unidades a fabricar del proceso actual o
                      se han producido mermas/incrementos o extracciones/incorporaciones
                      habrá que reconsiderar las unidades a fabricar a partir del próximo proceso.

      }

      // La variable cantidad se calcula en BeforePost, por lo tanto, sólo se puede llamar al procedimiento tras él.

      With SecuenciaAsignacion1Table { InformeFabricacionFields } do
        If   UltimaTareaDelProceso
        then begin

             CantidadProcesadaCorrecta := InformeFabricacionFields.Correctas.Value;
             If   not RegistroNuevo
             then CantidadProcesadaCorrecta := CantidadProcesadaCorrecta - PrevInformeFabricacionFields.Correctas.Value;

             CantidadAtipica := Contenedor.ContenidoProceso( OrdenFabricacionFields.EjercicioLanzamiento.Value,
                                                             OrdenFabricacionFields.NroOrden.Value,
                                                             InformeFabricacionFields.NroProceso.Value,
                                                             cnProductoContenedorAtipico ).Saldo;

             // Compruebo que no sea, además, el último proceso de la orden

             If   ( CantidadPendienteAnterior<>CantidadProcesadaCorrecta + InformeFabricacionFields.IncorpExtraidas.Value ) or
                  ( CantidadAtipica<>0.0 )
             then begin
                  RecalcularProceso := True;
                  If   Avisar
                  then If   ShowNotification( ntAcceptCancel, RsMsg18, RsMsg16 )<>mrOk
                       then Abort;
                  end;
             end;

end;

procedure TMntIdfForm.DoOnUpdateSelection(NroOrden: Integer; NroProceso: SmallInt; Fecha: TDate; Turno: SmallInt);
begin

end;

procedure TMntIdfForm.EjercicioCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     If   ValueIsEmpty( EjercicioCtrl.EditValue )
     then EjercicioCtrl.EditValue := ApplicationContainer.Ejercicio;
end;

procedure TMntIdfForm.EjercicioCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Ejercicio : SmallInt;

begin
     Ejercicio := VarToInteger( DisplayValue );
     If   ( Ejercicio<>ApplicationContainer.Ejercicio ) and
          ( Ejercicio<>ApplicationContainer.Ejercicio - 1 )
     then begin
          Error := True;
          ErrorText := RsMsg24;
          end;
end;

procedure TMntIdfForm.CompruebaListaDefectos;
begin
     If   InformeFabricacionFields.Defectuosas.Value=0
     then begin
          DefectoInformeFabricacionTable.DeleteRecords;   // El rango está fijado por MasterSource
          CodigoDefectoCtrl.Clear;
          end;
end;

procedure TMntIdfForm.CorrectasCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     DefectuosasCtrl.Enabled := SecuenciaAsignacionFields.Cantidad.Value > VarToDecimal( DisplayValue );
     If   CorrectasCtrl.Editing
     then ResetTab;
end;

procedure TMntIdfForm.NroProcesoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  NroProceso : Integer;

begin
     DescOperacionLabel.Caption := '';
     DescMaquinaLabel.Caption := '';

     NroProceso := VarToInteger( DisplayValue );

     If   Assigned( OrdenFabricacionFields ) and
          OrdenFabricacionFields.Initialized and
          ( OrdenFabricacionFields.NroOrden.Value<>0 ) and
          LineaOFOperacionTable.FindKey( [ OrdenFabricacionFields.Ejercicio.Value, moOrden, OrdenFabricacionFields.NroOrden.Value, NroProceso ] )
     then begin

          If   LineaOFOperacionFields.OperacionExterna.Value
          then begin
               Error := True;
               ErrorText := JoinMessage( RsMsg3, RsMsg4 );
               Exit;
               end;

          DescOperacionLabel.Caption := 'Segmento :  ' + IntToStr( SecuenciaAsignacionFields.Segmento.Value ) + ',  Operación : ' + LineaOFOperacionFields.CodigoOperacion.Value + ', ' +Operacion.Descripcion( LineaOFOperacionFields.CodigoOperacion.Value );
          DescMaquinaLabel.Caption := LineaOFOperacionFields.CodigoMaquina.Value + ', ' + Maquina.Descripcion( LineaOFOperacionFields.CodigoMaquina.Value );

          end
     else begin
          Error := True;
          ErrorText := RsMsg17;
          end;

     Tareas2Button.Enabled := ( NroProceso<>0 ) and not Error;
end;

procedure TMntIdfForm.FabricacionCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     If   ( InformeFabricacionFields.Fabricacion.Value=0 ) and ( DuracionTarea<>0 )
     then FabricacionCtrl.EditValue := DuracionTarea - InformeFabricacionFields.Preparacion.Value;
end;

procedure TMntIdfForm.FechaCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     If   ValueIsEmpty( FechaCtrl.EditValue )
     then FechaCtrl.EditValue := ApplicationContainer.TodayDate;
end;

procedure TMntIdfForm.FormManagerBeforePostEditRecord;
begin

     With OrdenFabricacion do
       begin

       RecalcularProceso := False;

       If   not RegistroNuevo and
            ( PrevInformeFabricacionFields.Correctas.Value=InformeFabricacionFields.Correctas.Value ) and
            ( PrevInformeFabricacionFields.Defectuosas.Value=InformeFabricacionFields.Defectuosas.Value ) and
            ( PrevInformeFabricacionFields.MermaExceso.Value=InformeFabricacionFields.MermaExceso.Value ) and
            ( PrevInformeFabricacionFields.IncorpExtraidas.Value=InformeFabricacionFields.IncorpExtraidas.Value )
       then Exit;

       CantidadProcesada := InformeFabricacionFields.Correctas.Value + InformeFabricacionFields.Defectuosas.Value;
       If   not RegistroNuevo
       then CantidadProcesada := CantidadProcesada - ( PrevInformeFabricacionFields.Correctas.Value + PrevInformeFabricacionFields.Defectuosas.Value );

       If   InformeFabricacioNFields.NroProceso.Value>1
       then begin

            StockProcesoAnterior := Contenedor.ContenidoProceso( OrdenFabricacionFields.EjercicioLanzamiento.Value,
                                                                 InformeFabricacionFields.NroOrden.Value,
                                                                 InformeFabricacionFields.NroProceso.Value - 1,
                                                                 cnProductoAcabadoCorrecto ).Saldo;

            // Compruebo que el número de unidades que se han fabricado no exceda del que es posible justificar de acuerdo con
            // el informe de fabricacion del proceso anterior

            If   CantidadProcesada - InformeFabricacionFields.MermaExceso.Value>StockProcesoAnterior
            then begin
                 ShowNotification( ntStop, RsMsg8, RsMsg14 );
                 Abort;
                 end;

            end;

       { Posible reajuste del proceso ACTUAL (y posteriores, por supuesto)
         Comprobación 1 : Si la cantidad correcta más la defectuosa no coincide con la cantidad a procesar,
                           que es = cantidad inicial a procesar + mermas/excesos.
       }

       If   UltimaTareaDelProceso
       then If   CantidadProcesada - InformeFabricacionFields.MermaExceso.Value>CantidadPendienteAnterior
            then begin
                 ShowNotification( ntStop, RsMsg25, RsMsg26 );
                 Abort;
                 end;

       If   ( InformeFabricacionFields.Correctas.Value + InformeFabricacionFields.Defectuosas.Value <> SecuenciaAsignacionFields.Cantidad.Value + InformeFabricacionFields.MermaExceso.Value ) or // Comprobación 1
            ( ParametrosProduccionRec.RealizarProduccionPrevista and ( InformeFabricacionFields.NroProceso.Value=1 ) and ( InformeFabricacionFields.Correctas.Value <> SecuenciaAsignacionFields.Cantidad.Value ) ) or
            ( not RegistroNuevo and ( ( PrevInformeFabricacionFields.Correctas.Value <> InformeFabricacionFields.Correctas.Value ) or
                                      ( PrevInformeFabricacionFields.Defectuosas.Value <> InformeFabricacionFields.Defectuosas.Value ) or
                                      ( PrevInformeFabricacionFields.MermaExceso.Value <> InformeFabricacionFields.MermaExceso.Value ) or
                                      ( PrevInformeFabricacionFields.IncorpExtraidas.Value <> InformeFabricacionFields.IncorpExtraidas.Value) ) )
       then begin
            RecalcularProceso := True;
            If   ShowNotification( ntAcceptCancel, RsMsg15, RsMsg16 )<>mrOk
            then Abort;
            end
       else CompruebaCantidadProceso( True );

       end;

end;

procedure TMntIdfForm.FormManagerInitializeForm;
begin
     InformeFabricacionFields := TInformeFabricacionFields.Create( InformeFabricacionTable );
     LineaInformeFabricacionFields := TLineaInformeFabricacionFields.Create( LineaInformeFabricacionTable );
     LineaOFComponenteFields := TLineaOFComponenteFields.Create( LineaOFComponenteTable );
     LineaOFOperacionFields := TLineaOFOperacionFields.Create( LineaOFOperacionTable );
     SecuenciaAsignacionFields := TSecuenciaAsignacionFields.Create( SecuenciaAsignacionTable );
     SecuenciaAsignacion1Fields := TSecuenciaAsignacionFields.Create( SecuenciaAsignacion1Table );
     OperariosMaquinaFields := TOperariosMaquinaFields.Create( OperariosMaquinaTable );
     DefectoInformeFabricacionFields := TDefectoInformeFabricacionFields.Create( DefectoInformeFabricacionTable );

     OrdenFabricacionFields := TOrdenFabricacionFields.Create( Self );
     PrevInformeFabricacionFields := TInformeFabricacionFields.Create( Self );

     ClaseProduccion.SetupEditControl( IncExtClaseACtrl, tcClaseA, 0 );
     ClaseProduccion.SetupEditControls( CodigoClaseABox, CodigoClaseBBox, CodigoClaseCBox, 0, True );
     ClaseProduccion.SetupGridColumns( ComponentesTableViewCodigoClaseA, ComponentesTableViewCodigoClaseB, ComponentesTableViewCodigoClaseC, 4 );

     MermaExcesoCtrl.Enabled := ParametrosProduccionRec.MermaExcesoArticulos;
     IncorpExtraidasCtrl.Enabled := ParametrosProduccionRec.IncorporarExtraerArticulos;
     IncExtClaseACtrl.Enabled := ParametrosProduccionRec.IncorporarExtraerArticulos;

     InformeFabricacionTable.SetDefaultRangeValues( [ ApplicationContainer.Ejercicio - 1 ], [ ApplicationContainer.Ejercicio ] );
     SetFieldRange( InformeFabricacionFields.NroOrden );

     With DataModule00.DmEmpresaFields do
       begin
       SetEditControlsDecimals( [ CorrectasCtrl, DefectuosasCtrl, IncorpExtraidasCtrl, MermaExcesoCtrl ], Ventas_DecCantidad.Value );

       end;

     // ComponentesTableView

     SetColumnDecimals( ComponentesTableViewCantidad, ParametrosProduccionRec.DecimalesComponentes );
     SetColumnDecimals( ComponentesTableViewConsumoPrevisto, ParametrosProduccionRec.DecimalesComponentes );
     SetColumnDecimals( ComponentesTableViewConsumoReal, ParametrosProduccionRec.DecimalesComponentes );

     If   ParametrosProduccionRec.AjusteAutomaticoConsumos
     then ComponentesTableView.OptionsData.Editing := False

end;

procedure TMntIdfForm.LineaInformeFabricacionTableBeforePost(DataSet: TDataSet);
begin
     If   not LineaInformeFabricacionTable.ControlsDisabled
     then begin
          LineaInformeFabricacionFields.Ejercicio.Value := InformeFabricacionFields.Ejercicio.Value;
          LineaInformeFabricacionFields.NroOrden.Value := InformeFabricacionFields.NroOrden.Value;
          LineaInformeFabricacionFields.NroProceso.Value := InformeFabricacionFields.NroProceso.Value;
          LineaInformeFabricacionFields.Fecha.Value := InformeFabricacionFields.Fecha.Value;
          LineaInformeFabricacionFields.Turno.Value := InformeFabricacionFields.Turno.Value;
          end;
end;

procedure TMntIdfForm.LineaInformeFabricacionTableCalcFields(DataSet: TDataSet);
begin
     LineaInformeFabricacionTableNombre.Value := Operario.Descripcion( '', LineaInformeFabricacionTableCodigoOperario.Value );
end;

function TMntIdfForm.LineaInformeFabricacionTableCanEditRecord(Dataset: TDataSet): Boolean;
begin
     //..
end;

procedure TMntIdfForm.LineaOFComponenteTableApplyMasterRange(DataSet: TDataSet);
begin
     If   LineaOFComponenteTable.Active
     then With InformeFabricacionFields do
            LineaOFComponenteTable.SetRange( [ Ejercicio.Value, moOrden, NroOrden.Value, NroProceso.Value ] );
end;

procedure TMntIdfForm.LineaOFComponenteTableBeforePost(DataSet: TDataSet);
begin
     ActualizaConsumo;
end;

procedure TMntIdfForm.LineaOFComponenteTableCalcFields(DataSet: TDataSet);
begin
     LineaOFComponenteTableDescripcion.Value := Articulo.Descripcion( LineaOFComponenteTableCodigoArticulo.Value, False );
end;

procedure TMntIdfForm.LineaOFComponenteTableNewRecord(DataSet: TDataSet);
begin
     LineaOFComponenteFields.Ejercicio.Value := InformeFabricacionFields.Ejercicio.Value;
     LineaOFComponenteFields.Tipo.Value := moOrden;
     LineaOFComponenteFields.NroOrden.Value := InformeFabricacionFields.NroOrden.Value;
     LineaOFComponenteFields.NroProceso.Value := InformeFabricacionFields.NroProceso.Value;
end;

procedure TMntIdfForm.MermaExcesoCtrlPropertiesEnter(Sender: TcxCustomEdit);

var  MermaCalculada : Decimal;

begin

     // Calculo automático de las mermas

     If   InformeFabricacionFields.MermaExceso.IsNull
     then begin
          MermaCalculada := SecuenciaAsignacionFields.Cantidad.Value -
                            InformeFabricacionFields.Correctas.Value -
                            InformeFabricacionFields.Defectuosas.Value;
          If   MermaCalculada<>0
          then InformeFabricacionFields.MermaExceso.Value := -MermaCalculada;
          end;

end;

procedure TMntIdfForm.MuestraDuracion;
begin
     If   not InformeFabricacionFields.HoraInicio.IsNull  and
          not InformeFabricacionFields.HoraFinalizacion.IsNull
     then begin
          If   InformeFabricacionFields.HoraInicio.Value>InformeFabricacionFields.HoraFinalizacion.Value
          then DuracionTarea := SecondsBetween( InformeFabricacionFields.HoraInicio.Value, EncodeTime( 23, 59, 59, 999 ) ) + 1 +
                                SecondsBetween( EncodeTime( 0, 0, 0, 0 ), InformeFabricacionFields.HoraFinalizacion.Value )
          else DuracionTarea := SecondsBetween( InformeFabricacionFields.HoraInicio.Value, InformeFabricacionFields.HoraFinalizacion.Value );
          DuracionLabel.Caption := StrFormatDuration( DuracionTarea )
          end
     else begin
          DuracionTarea := 0;
          DuracionLabel.Clear;
          end;
end;

procedure TMntIdfForm.NroOrdenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOrdenesFabricacion( InformeFabricacionFields.Ejercicio.Value, Sender, qgsNormal, DoOnNroOrdenSelected );
end;

procedure TMntIdfForm.DoOnNroOrdenSelected( Target : TcxCustomEdit = nil );
begin
     InformeFabricacionTable.Edit;   // Se puede pulsar F4 sin estar en modo edición del registro
     With CxOdfForm do
       begin
       InformeFabricacionFields.Ejercicio.Value := QueryEjercicio.Value;
       InformeFabricacionFields.NroOrden.Value := QueryNroOrden.Value;
       end;
end;

procedure TMntIdfForm.NroOrdenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin

     EjercicioPedidoBox.Caption := '';
     NroPedidoBox.Caption := '';
     DescPedidoLabel.Caption := '';
     CodigoArticuloBox.Caption := '';
     DescArticuloLabel.Caption := '';
     DescOperacionLabel.Caption := '';
     DescMaquinaLabel.Caption := '';

     OrdenFabricacion.Valida( InformeFabricacionFields.Ejercicio.Value, moOrden, Sender, DisplayValue, ErrorText, Error, { IsInfoControl } False, { ShowFullDescription } False, OrdenFabricacionFields );
     If   not Error
     then begin
          EstadoOrdenFabricacion := OrdenFabricacion.Estado( InformeFabricacionFields.Ejercicio.Value, moOrden, InformeFabricacionFields.NroOrden.Value );
          If   OrdenFabricacionFields.NroPedido.Value<>0
          then begin
               EjercicioPedidoBox.Caption := StrInt( OrdenFabricacionFields.EjercicioPedido.Value );
               NroPedidoBox.Caption := StrInt( OrdenFabricacionFields.NroPedido.Value );
               If   Movimiento.ObtenMovimiento( tmPedidoVenta, OrdenFabricacionFields.EjercicioPedido.Value, '', OrdenFabricacionFields.NroPedido.Value )
               then DescPedidoLabel.Caption := Cliente.Descripcion( Movimiento.DmMovimientoFields.Propietario.Value );
               end;
         CodigoArticuloBox.Caption := OrdenFabricacionFields.CodigoArticulo.Value + ' ' + OrdenFabricacionFields.CodigoClaseA.Value + ' ' + OrdenFabricacionFields.CodigoClaseB.Value + ' ' + OrdenFabricacionFields.CodigoClaseC.Value;
         DescArticuloLabel.Caption := Articulo.Descripcion( OrdenFabricacionFields.CodigoArticulo.Value );
         end;

end;

function TMntIdfForm.ObtenTarea: Boolean;
begin

     Result := False;

     AProcesarBox.Caption := '';
     DuracionPrevistaBox.Caption   := '';

     // Ejercicio;NroOrdenFabricacion;NroProceso;Fecha;Turno

     With InformeFabricacionFields do
       If   NroOrden.Value<>0
       then If   SecuenciaAsignacionTable.FindKey( [ Ejercicio.Value, NroOrden.Value, NroProceso.Value, Fecha.Value, Turno.Value ] )
            then begin
                 AProcesarBox.Caption := StrFormat( SecuenciaAsignacionFields.Cantidad.Value, DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value );
                 DuracionPrevistaBox.Caption := StrFormatDuration( SecuenciaAsignacionFields.Tiempo.Value );
                 Result := True;
                 end;

end;
procedure TMntIdfForm.OperariosTableViewCodigoOperarioPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntOperarios( [ Sender.EditingValue ] );
end;

procedure TMntIdfForm.OperariosTableViewCodigoOperarioPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOperarios( Sender );
end;

procedure TMntIdfForm.OperariosTableViewCodigoOperarioPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Operario.Valida( '', Sender, DisplayValue, ErrorText, Error );
     If   not Error and ( LineaInformeFabricacionTable.State=dsInsert )
     then With InformeFabricacionFields do
            begin
            var CodigoOperario := VarToAnsiStr( DisplayValue );
            With OperariosTableView.DataController do
              For var RecIndex := 0 to RecordCount - 1 do
                If   RecIndex<>FocusedRecordIndex
                then If   VarToAnsiStr( GetValue( RecIndex, OperariosTableViewCodigoOperario.Index ) )=CodigoOperario
                     then begin
                          Error := True;
                          ErrorText := RsMsg32;
                          end;
            end;
end;

procedure TMntIdfForm.PreparacionCtrlPropertiesValuePosted(Sender: TObject);
begin
     If   ( InformeFabricacionFields.Fabricacion.Value=0 ) and ( DuracionTarea<>0 )
     then InformeFabricacionFields.Fabricacion.Value := DuracionTarea - InformeFabricacionFields.Preparacion.Value;
end;

procedure TMntIdfForm.InicioFinCtrlPropertiesValuePosted(Sender: TObject);
begin
     If   InformeFabricacionFields.HoraFinalizacion.Value=0
     then InformeFabricacionFields.HoraFinalizacion.Value := IncSecond( InformeFabricacionFields.HoraInicio.Value, SecuenciaAsignacionFields.Tiempo.Value );
     MuestraDuracion;
end;

procedure TMntIdfForm.Tareas1ButtonClick(Sender: TObject);
begin
     With InformeFabricacionFields do
       ConsultaTareasFabricacion( Ejercicio.Value, NroOrden.Value, 0, not ShiftKey, DoOnSeleccionTarea );
end;

procedure TMntIdfForm.Tareas2ButtonClick(Sender: TObject);
begin
     With InformeFabricacionFields do
       ConsultaTareasFabricacion( Ejercicio.Value, NroOrden.Value, NroProceso.Value, not ShiftKey, DoOnSeleccionTarea );
end;

procedure TMntIdfForm.DoOnSeleccionTarea( Target : TcxCustomEdit = nil );
begin
     With CxTofForm do
       begin
       EjercicioCtrl.PostEditValue( QueryEjercicio.Value );
       NroOrdenCtrl.PostEditValue( QueryNroOrdenFabricacion.Value );
       NroProcesoCtrl.PostEditValue( QueryNroProceso.Value );
       FechaCtrl.PostEditValue( QueryFecha.Value );
       TurnoCtrl.PostEditValue( QueryTurno.Value );
       TurnoCtrl.SetFocus;
       end;
end;

procedure TMntIdfForm.InicioFinCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  HoraInicio,
     HoraFinalizacion : TTime;

begin
     If   Sender=HoraInicioCtrl
     then begin
          HoraInicio := VarToTime( DisplayValue );
          HoraFinalizacion := InformeFabricacionFields.HoraFinalizacion.Value;
          end
     else begin
          HoraInicio := InformeFabricacionFields.HoraInicio.Value;
          HoraFinalizacion := VarToTime( DisplayValue );
          end;

     { If   ( HoraInicio<>0 ) and ( HoraFinalizacion<>0 ) and ( HoraInicio>=HoraFinalizacion )
     then begin
          Error := True;
          ErrorText := RsMsg31;
          DuracionLabel.Clear;
          end
     else } MuestraDuracion;

end;

procedure TMntIdfForm.TableViewCodigoSubcontratistaPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntIdfForm.TableViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     (*
     With AViewInfo.GridRecord do
       { If   not AViewInfo.Selected
       then }If   VarToInteger( Values[ TableViewEstado.Index ] )=2
       then ACanvas.Font.Color := clMaroon;
     *)
end;

procedure TMntIdfForm.TurnoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTurnos( [ Sender.EditingValue ] );
end;

procedure TMntIdfForm.TurnoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTurnos( Sender );
end;

procedure TMntIdfForm.TurnoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Turno.Valida( Sender, DisplayValue, ErrorText, Error );
end;

function TMntIdfForm.UltimaTareaDelProceso: Boolean;
begin
     With SecuenciaAsignacion1Table  do
       begin
       Result := ( not RegistroNuevo and not FindEqualLast( [ InformeFabricacionFields.Ejercicio.Value, InformeFabricacionFields.NroOrden.Value, InformeFabricacionFields.NroProceso.Value ] ) and ( SecuenciaAsignacion1Fields.Segmento.Value<>SecuenciaAsignacionFields.Segmento.Value ) ) or
                 (     RegistroNuevo and not FindKey( [ InformeFabricacionFields.Ejercicio.Value, InformeFabricacionFields.NroOrden.Value, InformeFabricacionFields.NroProceso.Value, SecuenciaAsignacionFields.Segmento.Value + 1 ] ) );
       If   Result
       then CantidadPendienteAnterior := Contenedor.ContenidoOrden( YearOf( OrdenFabricacionFields.FechaLanzamiento.Value ),
                                                                    InformeFabricacionFields.NroOrden.Value,
                                                                    0,
                                                                    InformeFabricacionFields.NroProceso.Value - 1,
                                                                    cnProductoAcabadoCorrecto ).Saldo;
       end;
end;

procedure TMntIdfForm.UpdateComponentsState;
begin

end;

procedure TMntIdfForm.IncExtClaseACtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [tcClaseA, Sender.EditingValue ] );
end;

procedure TMntIdfForm.IncExtClaseACtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( tcClaseA, Sender );
end;

procedure TMntIdfForm.IncExtClaseACtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseA, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntIdfForm.InformeFabricacionTableAfterInsert(DataSet: TDataSet);
begin
     If   Assigned( InformeFabricacionFields ) and
          ( InformeFabricacionTable.State=dsInsert ) and
          ( InformeFabricacionFields.NroOrden.Value<>0 )
     then begin

          If   not ObtenTarea
          then begin
               ShowHintMsg( RsMsg12, RsMsg13 );
               FormManager.SelectFirstKeyControl;
               Abort;
               end;

          EnterpriseDataModule.StartTransaction( [ LineaOFComponenteTable, LineaInformeFabricacionTable ] );

          try

            try

              InformeFabricacionFields.HoraInicio.Value := SecuenciaAsignacionFields.HoraInicio.Value;
              InformeFabricacionFields.HoraFinalizacion.Value := IncSecond( SecuenciaAsignacionFields.HoraInicio.Value, SecuenciaAsignacionFields.Tiempo.Value );

              LineaInformeFabricacionTable.DisableControls;
              LineaOFComponenteTable.DisableControls;

              // Por si se han modificado las cantidades y suprimido y vuelto a generar el informe de fabricación

              With LineaOFComponenteTable do
                begin
                With InformeFabricacionFields do
                  SetRange( [ Ejercicio.Value, moOrden, NroOrden.Value,  NroProceso.Value ] );
                First;
                While not Eof do
                  begin
                  If   LineaOFComponenteFields.Cantidad.Value<>LineaOFComponenteFields.CantidadOriginal.Value
                  then begin
                       Edit;
                       LineaOFComponenteFields.Cantidad.Value := LineaOFComponenteFields.CantidadOriginal.Value;
                       LineaOFComponenteTableConsumoReal.Value := LineaOFComponenteFields.Cantidad.Value * OrdenfabricacionFields.UnidadesAFabricar.Value;
                       Post;
                       end;
                  Next;
                  end;

                end;

              With LineaInformeFabricacionTable  do
                try
                  With InformeFabricacionFields do
                    SetRange( [ Ejercicio.Value, NroOrden.Value, NroProceso.Value, Fecha.Value, Turno.Value, 1 ],
                              [ Ejercicio.Value, NroOrden.Value, NroProceso.Value, Fecha.Value, Turno.Value, MaxSmallint ] );
                  DeleteRecords;
                finally
                  CancelRange;
                  Cancel;
                  end;

              With OperariosMaquinaTable do
                begin
                SetRange( [ LineaOFOperacionFields.CodigoMaquina.Value, InformeFabricacionFields.Turno.Value, 1 ],
                          [ LineaOFOperacionFields.CodigoMaquina.Value, InformeFabricacionFields.Turno.Value, MaxSmallint ] );
                First;
                If   Eof
                then begin
                     ShowHintMsg( RsMsg29, RsMsg30 );
                     FormManager.SelectFirstKeyControl;
                     Abort;
                     end;

                While not Eof do
                  begin
                  With LineaInformeFabricacionTable do
                    begin
                    Append;

                    LineaInformeFabricacionFields.Ejercicio.Value := InformeFabricacionFields.Ejercicio.Value;
                    LineaInformeFabricacionFields.NroOrden.Value := InformeFabricacionFields.NroOrden.Value;
                    LineaInformeFabricacionFields.NroProceso.Value := InformeFabricacionFields.NroProceso.Value;
                    LineaInformeFabricacionFields.Fecha.Value := InformeFabricacionFields.Fecha.Value;
                    LineaInformeFabricacionFields.Turno.Value := InformeFabricacionFields.Turno.Value;

                    LineaInformeFabricacionFields.NroRegistro.Value := OperariosMaquinaFields.NroRegistro.Value;
                    LineaInformeFabricacionFields.CodigoOperario.Value := OperariosMaquinaFields.CodigoOperario.Value;

                    Post;
                    end;

                  Next;
                  end;

                OperariosTableView.DataController.UpdateData;
                end;

              EnterpriseDataModule.Commit;

            finally
              LineaOFComponenteTable.EnableControls;
              LineaInformeFabricacionTable.EnableControls;
              end;

          except
            EnterpriseDataModule.Rollback;
            raise;
            end;

          end;
end;

procedure TMntIdfForm.InformeFabricacionTableBeforeCancel(DataSet: TDataSet);
begin
     If   RegistroNuevo
     then LineaInformeFabricacionTable.DeleteRecords;
end;

procedure TMntIdfForm.InformeFabricacionTableBeforeDelete(DataSet: TDataSet);
begin
     RecalcularProceso := False;
     If   not RegistroNuevo
     then RecalcularProceso := ShowNotification( ntQuestionWarning, RsMsg27, RsMsg28 )=mrYes;
end;

function TMntIdfForm.InformeFabricacionTableCanEditRecord(Dataset: TDataSet): Boolean;
begin
     Result := ( InformeFabricacionFields.Ejercicio.Value=ApplicationContainer.Ejercicio ) and
               ( EstadoOrdenFabricacion<>eoCerrada );
end;

procedure TMntIdfForm.InformeFabricacionTableGetRecord(DataSet: TDataSet);
begin
     ObtenTarea;
     If   not FormManager.PostingCurrentRecord
     then begin
          RegistroNuevo := InformeFabricacionTable.State=dsInsert;
          PrevInformeFabricacionFields.Update( InformeFabricacionTable );
          end;
end;

procedure TMntIdfForm.InformeFabricacionTableNewRecord(DataSet: TDataSet);
begin
     EstadoLabel.Caption := '';
     UpdateComponentsState;
end;

procedure TMntIdfForm.InformeFabricacionTableRemoteDelete(DataSet: TDataSet);
begin
     InformeFabricacion.SuprimeInformeFabricacion( InformeFabricacionFields, RecalcularProceso );
end;

procedure TMntIdfForm.InformeFabricacionTableRemotePost(DataSet: TDataSet);
begin
     InformeFabricacion.ActualizaInformeFabricacion( InformeFabricacionFields, RecalcularProceso );
end;

procedure TMntIdfForm.InformeFabricacionTableUpdateState(DataSet: TDataSet);
begin
     If   FormManager.FormPrepared
     then begin
          UpdateComponentsState;
          LineaInformeFabricacionDataSource.Enabled := InformeFabricacionTable.State<>dsSetKey;
          LineaOFComponenteDataSource.Enabled := LineaInformeFabricacionDataSource.Enabled;
          end;
end;

end.

