unit b_tof;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
     ExtCtrls, Generics.Collections,

  AppContainer,

  Grids, Menus, cxLookAndFeelPainters, cxGraphics, DB, nxdb,
  DataManager, cxMaskEdit, cxDropDownEdit, cxDBEdit, cxIndexedComboBox,
  cxCurrencyEdit, cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxLookAndFeels, dxSkinsCore, cxLabel, cxGroupBox, dxSkinsDefaultPainters,

  cxSpinEdit, cxDurationEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  cxIntegerEdit, cxCalendar, cxCheckBox, dxDateRanges, GridTableViewController, cxDBLabel, cxScrollBox, dxBar, dxScrollbarAnnotations,

  LibUtils,
  AppForms,
  Gim30Fields,
  Gim70Fields,

  dmi_odf,

  b_odf_1, cxTimeEdit;

type
  TBoxTofForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    NroOrdenCtrl: TcxDBIntegerEdit;
    OrdenFabricacionTable: TnxeTable;
    dataPanel: TgxEditPanel;
    OrdenFabricacionDataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    HeaderGroupBox: TcxGroupBox;
    SecuenciaAsignacionTable: TnxeTable;
    EstadoLabel: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxLabel3: TcxLabel;
    DescPedidoLabel: TcxLabel;
    cxLabel1: TcxLabel;
    DescArticuloLabel: TcxLabel;
    cxLabel2: TcxLabel;
    Label2: TcxLabel;
    PrioridadLabel: TcxLabel;
    cxGroupBox4: TcxGroupBox;
    capClaseALabel: TcxLabel;
    DescClaseALabel: TcxLabel;
    cxGroupBox3: TcxGroupBox;
    capClaseBLabel: TcxLabel;
    DescClaseBLabel: TcxLabel;
    cxGroupBox5: TcxGroupBox;
    capClaseCLabel: TcxLabel;
    DescClaseCLabel: TcxLabel;
    EjercicioPedidoLabel: TcxLabel;
    NroPedidoLabel: TcxLabel;
    CodigoArticuloCtrl: TcxDBLabel;
    CodigoClaseACtrl: TcxDBLabel;
    CodigoClaseBCtrl: TcxDBLabel;
    CodigoClaseCCtrl: TcxDBLabel;
    LoteCtrl: TcxDBLabel;
    UnidadesAFabricarCtrl: TcxDBLabel;
    CargasCtrl: TcxDBLabel;
    FechaCtrl: TcxDBLabel;
    DescPrioridadLabel: TcxLabel;
    SecuenciaAsignacionPanel: TcxGroupBox;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    GridTableViewController: TGridTableViewController;
    SecuenciaAsignacionDataSource: TDataSource;
    SecuenciaAsignacionTableEjercicio: TSmallintField;
    SecuenciaAsignacionTableNroOrdenFabricacion: TIntegerField;
    SecuenciaAsignacionTableNroProceso: TSmallintField;
    SecuenciaAsignacionTableSegmento: TSmallintField;
    SecuenciaAsignacionTableCodigoMaquina: TWideStringField;
    SecuenciaAsignacionTableFecha: TDateField;
    SecuenciaAsignacionTableTurno: TSmallintField;
    SecuenciaAsignacionTableNroOrdenEntrada: TSmallintField;
    SecuenciaAsignacionTablePrioridad: TSmallintField;
    SecuenciaAsignacionTableTiempo: TLongWordField;
    SecuenciaAsignacionTableCantidad: TBCDField;
    SecuenciaAsignacionTableRealizado: TBooleanField;
    TableViewNroProceso: TcxGridDBColumn;
    TableViewSegmento: TcxGridDBColumn;
    TableViewCodigoMaquina: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    TableViewTurno: TcxGridDBColumn;
    TableViewTiempo: TcxGridDBColumn;
    TableViewCantidad: TcxGridDBColumn;
    TableViewRealizado: TcxGridDBColumn;
    SecuenciaAsignacionTableDescripcion: TWideStringField;
    TableViewDescripcion: TcxGridDBColumn;
    InformeFabricacionTable: TnxeTable;
    SecuenciaAsignacionTableCorrectas: TBCDField;
    SecuenciaAsignacionTableDefectuosas: TBCDField;
    TableViewCorrectas: TcxGridDBColumn;
    TableViewDefectuosas: TcxGridDBColumn;
    InformeFabricacionTableEjercicio: TSmallintField;
    InformeFabricacionTableNroOrden: TIntegerField;
    InformeFabricacionTableNroProceso: TSmallintField;
    InformeFabricacionTableFecha: TDateField;
    InformeFabricacionTableTurno: TSmallintField;
    InformeFabricacionTableCorrectas: TBCDField;
    InformeFabricacionTableDefectuosas: TBCDField;
    BarManager: TdxBarManager;
    EditarInformeItem: TdxBarButton;
    RejillaPopupMenu: TdxBarPopupMenu;
    SecuenciaAsignacionTableHoraInicio: TTimeField;
    SecuenciaAsignacionTableHoraInicioMostrar: TTimeField;
    TableViewHoraInicioMostrar: TcxGridDBColumn;
    InformeFabricacionTableHoraInicio: TTimeField;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure NroOrdenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure OrdenFabricacionTableSetKey(DataSet: TDataSet);
    procedure FormManagerReportFormRequest;
    procedure SecuenciaAsignacionTableCalcFields(DataSet: TDataSet);
    procedure GridTableViewControllerUserSelection(Sender: TObject;
      var AHandled: Boolean);
    procedure OrdenFabricacionTableGetRecord(DataSet: TDataSet);
    procedure OrdenFabricacionTableUpdateState(DataSet: TDataSet);
    procedure EditarInformeItemClick(Sender: TObject);

  private

    OrdenFabricacionFields : TOrdenFabricacionFields;
    SecuenciaAsignacionFields : TSecuenciaAsignacionFields;

    ArticuloFields : TArticuloFields;

    FEstadoOrdenFabricacion : TEstadoOrdenFabricacion;

    procedure EditarInformeFabricacion;

  public
  end;

var
  BoxTofForm: TBoxTofForm = nil;

procedure ConsultaTareasOrden( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Graphics,
       SysUtils,
       DateUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm70Dm,
       Gdm70Frm,

       a_idf,

       b_msg,
       b_pro,

       dmi_mov,
       dmi_cpr,

       dm_odf,
       dm_mov,
       dm_cpr,
       dm_cli,
       dm_cls,
       dm_art,
       dm_lmp,
       dm_maq,
       dm_pro,
       dm_opc,

       cx_odf,

       r_odf;

procedure ConsultaTareasOrden( KeyValues : array of const );
begin
     CreateEditForm( TBoxTofForm, BoxTofForm, KeyValues, Gds70Frm.ProduccionSection );
end;

procedure TBoxTofForm.FormManagerInitializeForm;
begin

     OrdenFabricacionFields := TOrdenFabricacionFields.Create( OrdenFabricacionTable );
     SecuenciaAsignacionFields := TSecuenciaAsignacionFields.Create( SecuenciaAsignacionTable );

     ArticuloFields := TArticuloFields.Create( Self );

     Clase.SetupEditControls( CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl, 0, True );

     With DataModule00.DmEmpresaFields do
       begin
       SetBCDFieldDecimals( OrdenFabricacionFields.UnidadesAFabricar, Ventas_DecCantidad.Value );
       SetColumnsDecimals( [ TableViewCantidad, TableViewCorrectas, TableViewDefectuosas ], Ventas_DecCantidad.Value );
       end;

     OrdenFabricacionTable.SetDefaultRangeValues( [ ApplicationContainer.Ejercicio, moOrden ], [ ApplicationContainer.Ejercicio, moOrden ] );
     SetFieldRange( OrdenFabricacionFields.NroOrden );

end;

procedure TBoxTofForm.FormManagerReportFormRequest;
begin
     InformeOrdenesFabricacion( OrdenFabricacionFields.NroOrden.Value, True );
end;

procedure TBoxTofForm.FormManagerReportRequest;
begin
     InformeOrdenesFabricacion( OrdenFabricacionFields.NroOrden.Value );
end;

procedure TBoxTofForm.GridTableViewControllerUserSelection(Sender: TObject;var AHandled: Boolean);
begin
     EditarInformeFabricacion;
end;

procedure TBoxTofForm.EditarInformeItemClick(Sender: TObject);
begin
     EditarInformeFabricacion;
end;

procedure TBoxTofForm.EditarInformeFabricacion;
begin
     With SecuenciaAsignacionFields do
       MntInformesFabricacion( [ Ejercicio.Value, NroOrdenFabricacion.Value, NroProceso.Value, Fecha.Value, Turno.Value ] );
end;

procedure TBoxTofForm.OrdenFabricacionTableGetRecord(DataSet: TDataSet);
begin
     // Ejercicio;NroOrdenFabricacion;NroProceso;Segmento

     With OrdenFabricacionFields do
       begin

       SecuenciaAsignacionTable.SetRange( [ Ejercicio.Value, NroOrden.Value, 1, 0 ], [ Ejercicio.Value, NroOrden.Value, MaxSmallint, MaxSmallint ] );

       If   OrdenFabricacionFields.NroPedido.Value<>0
       then begin
            EjercicioPedidoLabel.Caption := IntToStr( OrdenFabricacionFields.EjercicioPedido.Value );
            NroPedidoLabel.Caption := IntToStr( OrdenFabricacionFields.NroPedido.Value );
            end
       else begin
            EjercicioPedidoLabel.Caption := '';
            NroPedidoLabel.Caption := '';
            end;

       DescArticuloLabel.Caption := Articulo.Descripcion( OrdenFabricacionFields.CodigoArticulo.Value );
       If   OrdenFabricacionFields.CodigoClaseA.Value=''
       then DescClaseALabel.Caption := ''
       else DescClaseALabel.Caption := Clase.Descripcion( tcClaseA, OrdenFabricacionFields.CodigoClaseA.Value );
       If   OrdenFabricacionFields.CodigoClaseA.Value=''
       then DescClaseBLabel.Caption := ''
       else DescClaseBLabel.Caption := Clase.Descripcion( tcClaseB, OrdenFabricacionFields.CodigoClaseB.Value );
       If   OrdenFabricacionFields.CodigoClaseA.Value=''
       then DescClaseCLabel.Caption := ''
       else DescClaseCLabel.Caption := Clase.Descripcion( tcClaseC, OrdenFabricacionFields.CodigoClaseC.Value );

       DescPrioridadLabel.Caption := OrdenFabricacion.TextoPrioridad( Prioridad.Value );

       TableView.DataController.RefreshExternalData;
       end;
end;

procedure TBoxTofForm.OrdenFabricacionTableSetKey(DataSet: TDataSet);
begin
     OrdenFabricacionFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
end;

procedure TBoxTofForm.OrdenFabricacionTableUpdateState(DataSet: TDataSet);
begin
     SecuenciaAsignacionDataSource.Enabled := OrdenFabricacionTable.State<>dsSetKey;
end;

procedure TBoxTofForm.NroOrdenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOrdenesFabricacion( ApplicationContainer.Ejercicio, Sender, qgsLinked );
end;

procedure TBoxTofForm.SecuenciaAsignacionTableCalcFields(DataSet: TDataSet);
begin

     SecuenciaAsignacionTableDescripcion.Value := Maquina.Descripcion( SecuenciaAsignacionTableCodigoMaquina.Value );
     SecuenciaAsignacionTableHoraInicioMostrar.Value := SecuenciaAsignacionTableHoraInicio.Value;

    // Ejercicio;NroOrden;NroProceso;Fecha;Turno

    If   SecuenciaAsignacionTable.Active and
         InformeFabricacionTable.Active
    then If   InformeFabricacionTable.FindKey( [ SecuenciaAsignacionTableEjercicio.Value,
                                                 SecuenciaAsignacionTableNroOrdenFabricacion.Value,
                                                 SecuenciaAsignacionTableNroProceso.Value,
                                                 SecuenciaAsignacionTableFecha.Value,
                                                 SecuenciaAsignacionTableTurno.Value ] )
         then begin
              SecuenciaAsignacionTableHoraInicioMostrar.Value := InformeFabricacionTableHoraInicio.Value;
              SecuenciaAsignacionTableCorrectas.Value := InformeFabricacionTableCorrectas.Value;
              SecuenciaAsignacionTableDefectuosas.Value := InformeFabricacionTableDefectuosas.Value;
              end;

end;

end.

