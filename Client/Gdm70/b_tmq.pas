unit b_tmq;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes, ExtCtrls,
  Grids, Menus, cxLookAndFeelPainters, cxGraphics, DB, nxdb,
  cxMaskEdit, cxDropDownEdit, cxDBEdit, cxIndexedComboBox,
  cxCurrencyEdit, cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxLookAndFeels, dxSkinsCore, cxLabel, cxGroupBox, dxSkinsDefaultPainters,
  cxSpinEdit, cxDurationEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, dxDateRanges, cxCalendar, dxmdaset,

  LibUtils,
  AppContainer,
  AppForms,
  DataManager,
  GridTableViewController,

  Gim70Fields, dxBar, dxScrollbarAnnotations, cxTimeEdit;

type
  TBoxTmqForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoMaquinaCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    codigoCtrlCaption: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    SecuenciaAsignacionTable: TnxeTable;
    SecuenciaAsignacionDataSource: TDataSource;
    cxLabel1: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    SecuenciaAsignacionPanel: TcxGroupBox;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    GridTableViewController: TGridTableViewController;
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
    TableViewTiempo: TcxGridDBColumn;
    TableViewCantidad: TcxGridDBColumn;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoMaquina: TStringField;
    DataFechaInicial: TDateField;
    DataEstado: TSmallintField;
    TableViewNroOrdenFabricacion: TcxGridDBColumn;
    OrdenFabricacionTable: TnxeTable;
    SecuenciaAsignacionTableCodigoArticulo: TStringField;
    SecuenciaAsignacionTableCodigoClaseA: TStringField;
    SecuenciaAsignacionTableCodigoClaseB: TStringField;
    SecuenciaAsignacionTableCodigoClaseC: TStringField;
    TableViewCodigoArticulo: TcxGridDBColumn;
    TableViewCodigoClaseA: TcxGridDBColumn;
    TableViewCodigoClaseB: TcxGridDBColumn;
    TableViewCodigoClaseC: TcxGridDBColumn;
    SecuenciaAsignacionTableDescripcionArticulo: TStringField;
    TableViewDescripcionArticulo: TcxGridDBColumn;
    DataFechaFinal: TDateField;
    gxRangeBox1: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    Label6: TcxLabel;
    EstadoCtrl: TcxDBIndexedComboBox;
    TableViewFecha: TcxGridDBColumn;
    TableViewTurno: TcxGridDBColumn;
    BarManager: TdxBarManager;
    EditarInformeItem: TdxBarButton;
    RejillaPopupMenu: TdxBarPopupMenu;
    EditarOrdenItem: TdxBarButton;
    TableViewRealizado: TcxGridDBColumn;
    InformeFabricacionTable: TnxeTable;
    SecuenciaAsignacionTableHoraInicioMostrar: TTimeField;
    SecuenciaAsignacionTableHoraFinalizacionMostrar: TTimeField;
    TableViewHoraInicio: TcxGridDBColumn;
    TableViewHoraFinalizacion: TcxGridDBColumn;
    SecuenciaAsignacionTableHoraInicio: TTimeField;
    procedure FormManagerInitializeForm;
    procedure SecuenciaAsignacionTableCalcFields(DataSet: TDataSet);
    procedure CodigoMaquinaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoMaquinaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoMaquinaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure FormManagerFocusedAreaChanged;
    procedure SecuenciaAsignacionTableFilterRecord(DataSet: TDataSet;var Accept: Boolean);
    procedure EditarOrdenItemClick(Sender: TObject);
    procedure EditarInformeItemClick(Sender: TObject);
    procedure GridTableViewControllerUserSelection(Sender: TObject;
      var AHandled: Boolean);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private

    FSecuenciaAsignacionFields : TSecuenciaAsignacionFields;
    OrdenFabricacionFields : TOrdenFabricacionFields;
    InformeFabricacionFields : TInformeFabricacionFields;

    MaquinaFields : TMaquinaFields;

    function GetSecuenciaAsignacionFields: TSecuenciaAsignacionFields;

    procedure EditarInformeFabricacion;
    procedure EditarOrdenFabricacion;

    property SecuenciaAsignacionFields : TSecuenciaAsignacionFields read GetSecuenciaAsignacionFields;

  public
  end;

var
  BoxTmqForm: TBoxTmqForm = nil;

procedure ConsultaTareasMaquina;

implementation

{$R *.DFM}

uses   DateUtils,

       Gdm70Dm,
       Gdm70Frm,

       dmi_odf,

       b_msg,

       dm_maq,
       dm_ope,
       dm_tur,
       dm_art,
       dm_cls,

       a_maq,
       a_tur,
       a_opr,
       a_odf,
       a_idf,

       cx_maq,
       cx_tur;

resourceString
      RsMsg1 = '';

procedure ConsultaTareasMaquina;
begin
     CreateEditForm( TBoxTmqForm, BoxTmqForm, [], Gds70Frm.ProduccionSection );
end;

procedure TBoxTmqForm.CodigoMaquinaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntMaquinas( [ Sender.EditingValue ] );
end;

procedure TBoxTmqForm.CodigoMaquinaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMaquinas( Sender );
end;

procedure TBoxTmqForm.CodigoMaquinaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Maquina.Valida( Sender, DisplayValue, ErrorText, Error, False, MaquinaFields );
end;

procedure TBoxTmqForm.EditarOrdenItemClick(Sender: TObject);
begin
     EditarOrdenFabricacion;
end;

procedure TBoxTmqForm.EditarInformeFabricacion;
begin
     With SecuenciaAsignacionFields do
       MntInformesFabricacion( [ Ejercicio.Value, NroOrdenFabricacion.Value, NroProceso.Value, Fecha.Value, Turno.Value ] );
end;

procedure TBoxTmqForm.EditarInformeItemClick(Sender: TObject);
begin
     EditarInformeFabricacion;
end;

procedure TBoxTmqForm.EditarOrdenFabricacion;
begin
     With SecuenciaAsignacionFields do
       MntOrdenesFabricacion( [ Ejercicio.Value, moOrden, NroOrdenFabricacion.Value ] );
end;

procedure TBoxTmqForm.FechaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error, { IncludeLastYear } True );
end;

procedure TBoxTmqForm.FormManagerFocusedAreaChanged;
begin
     // CodigoMaquina;Fecha;Turno;NroOrdenEntrada

     If   FormManager.DataAreaFocused
     then SecuenciaAsignacionTable.SetRange( [ DataCodigoMaquina.Value, DataFechaInicial.Value, 1, 0 ],
                                             [ DataCodigoMaquina.Value, DataFechaFinal.Value, 99, MaxSmallint ] );
     SecuenciaAsignacionDataSource.Enabled := FormManager.DataAreaFocused;

end;

procedure TBoxTmqForm.FormManagerInitializeForm;
begin

     OrdenFabricacionFields := TOrdenFabricacionFields.Create( OrdenFabricacionTable );
     InformeFabricacionFields := TInformeFabricacionFields.Create( InformeFabricacionTable );

     MaquinaFields := TMaquinaFields.Create( Self );

     Clase.SetupGridColumns( TableViewCodigoClaseA, TableViewCodigoClaseB, TableViewCodigoClaseC, 4 );

     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;

end;

function TBoxTmqForm.GetSecuenciaAsignacionFields: TSecuenciaAsignacionFields;
begin
     If   not Assigned( FSecuenciaAsignacionFields )
     then FSecuenciaAsignacionFields := TSecuenciaAsignacionFields.Create( SecuenciaAsignacionTable );
     Result := FSecuenciaAsignacionFields;
end;

procedure TBoxTmqForm.GridTableViewControllerUserSelection(Sender: TObject;var AHandled: Boolean);
begin
     EditarInformeFabricacion;
end;

procedure TBoxTmqForm.SecuenciaAsignacionTableCalcFields(DataSet: TDataSet);
begin
     If   OrdenFabricacionTable.Active and Assigned( SecuenciaAsignacionFields )
     then With SecuenciaAsignacionFields do
            begin

            If   OrdenFabricacionTable.FindKey( [ Ejercicio.value, moOrden, NroOrdenFabricacion.Value ] )
            then begin
                 SecuenciaAsignacionTableCodigoArticulo.Value := OrdenFabricacionFields.CodigoArticulo.Value;
                 SecuenciaAsignacionTableCodigoClaseA.Value := OrdenFabricacionFields.CodigoClaseA.Value;
                 SecuenciaAsignacionTableCodigoClaseB.Value := OrdenFabricacionFields.CodigoClaseB.Value;
                 SecuenciaAsignacionTableCodigoClaseC.Value := OrdenFabricacionFields.CodigoClaseC.Value;
                 SecuenciaAsignacionTableDescripcionArticulo.Value := Articulo.Descripcion( OrdenFabricacionFields.CodigoArticulo.Value );
                 end;

            SecuenciaAsignacionTableHoraInicioMostrar.Value := SecuenciaAsignacionTableHoraInicio.Value;
            SecuenciaAsignacionTableHoraFinalizacionMostrar.Value := IncSecond( SecuenciaAsignacionTableHoraInicio.Value, SecuenciaAsignacionTableTiempo.Value );

            // Ejercicio;NroOrden;NroProceso;Fecha;Turno

            If   SecuenciaAsignacionTableRealizado.Value
            then If   InformeFabricacionTable.FindKey( [ Ejercicio.value, NroOrdenFabricacion.Value, NroProceso.Value, Fecha.Value, Turno.Value ] )
                 then begin
                      SecuenciaAsignacionTableHoraInicioMostrar.Value := InformeFabricacionFields.HoraInicio.Value;
                      SecuenciaAsignacionTableHoraFinalizacionMostrar.Value := InformeFabricacionFields.HoraFinalizacion.Value;
                      end;

            end;
end;

procedure TBoxTmqForm.SecuenciaAsignacionTableFilterRecord( DataSet: TDataSet; var Accept: Boolean);
begin
     Accept := ( DataEstado.Value=0 ) or
               ( ( DataEstado.Value=1 ) and not SecuenciaAsignacionFields.Realizado.Value ) or
               ( ( DataEstado.Value=2 ) and SecuenciaAsignacionFields.Realizado.Value );
end;

end.
