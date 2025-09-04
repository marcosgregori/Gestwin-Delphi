unit b_gdt;

interface

uses Forms, Buttons, StdCtrls,
     Mask, Controls, Classes, ExtCtrls, Graphics,

    AppContainer,
    Menus, cxLookAndFeelPainters, cxButtons, cxStyles,
  cxGraphics, DB, nxdb, DataManager, cxDBEdit, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxIndexedComboBox, cxControls,
  cxGrid, cxCustomData, cxFilter, cxData, cxDataStorage, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, dxmdaset,

  cxCheckBox, dxSkinsCore, dxSkinscxPCPainter, cxGroupBox,
  cxLookAndFeels, dxSkinsDefaultPainters, cxLabel, cxNavigator, dxDateRanges,

  Gim10Fields,
  Gim90Fields,

  AppForms,
  GridTableViewController, dxScrollbarAnnotations;

type
  TBoxGdtForm = class(TgxForm)
    TareaQuery: TnxeQuery;
    DataPanel: TgxEditPanel;
    ButtonsPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    TecnicoTable: TnxeTable;
    Panel3: TcxGroupBox;
    InsertButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TareaDataSource: TDataSource;
    TableViewManager: TGridTableViewController;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoTecnico: TWideStringField;
    DataMostrar: TSmallintField;
    TableViewNroTarea: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    TableViewCodigoCliente: TcxGridDBColumn;
    TableViewCodigoTecnico: TcxGridDBColumn;
    TableViewUrgente: TcxGridDBColumn;
    TableViewAsunto: TcxGridDBColumn;
    TableViewFechaResolucion: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    KeyPanel: TgxEditPanel;
    MostrarCtrl: TcxDBIndexedComboBox;
    CodigoTecnicoCtrl: TcxDBTextEdit;
    AceptarButton: TgBitBtn;
    AgruparCtrl: TcxDBCheckBox;
    DataAgrupar: TBooleanField;
    TableViewTelefono: TcxGridDBColumn;
    Label1: TcxLabel;
    DescTecnicoLabel: TcxLabel;
    ExpandirButton: TcxButton;
    ColapsarButton: TcxButton;
    TableViewResolucion: TcxGridDBColumn;
    TareaQueryEjercicio: TSmallintField;
    TareaQueryNroTarea: TIntegerField;
    TareaQueryEstado: TSmallintField;
    TareaQueryFecha: TDateField;
    TareaQueryCodigoCliente: TWideStringField;
    TareaQueryCodigoTecnico: TWideStringField;
    TareaQueryUrgente: TBooleanField;
    TareaQueryPrioridad: TSmallintField;
    TareaQueryCodigoTipoTarea: TWideStringField;
    TareaQueryAsunto: TWideStringField;
    TareaQueryFechaResolucion: TDateField;
    TareaQueryTiempo: TLongWordField;
    TareaQueryDuracion: TTimeField;
    TareaQueryResolucion: TWideStringField;
    TareaQueryNombre: TWideStringField;
    TareaQueryTelefono: TWideStringField;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    function FormManagerCanClose: Boolean;
    procedure InsertButtonClick(Sender: TObject);
    procedure CodigoTecnicoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoTecnicoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoTecnicoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormManagerFocusedAreaChanged;
    procedure TableViewManagerInsert(Sender: TObject);
    procedure FormManagerActivateForm;
    procedure AgruparCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ExpandirButtonClick(Sender: TObject);
    procedure ColapsarButtonClick(Sender: TObject);
    procedure TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
  private

  public

    TareaFields : TTareaFields;
    ClienteFields : TClienteFields;

    procedure InsertaTarea;
    procedure ResetGrid;
  end;

var BoxGdtForm: TBoxGdtForm;

procedure GestionTareas;

implementation

uses   DateUtils,
       LibUtils,

       dm_cli,
       dm_tar,

       a_tar,
       a_tec,

       cx_tec,

       l_tar;

{$R *.DFM}

procedure GestionTareas;
begin
     CreateEditForm( TBoxGdtForm, BoxGdtForm );
end;

procedure TBoxGdtForm.FormManagerInitializeForm;
begin
     DataMostrar.Value := 0;
end;

procedure TBoxGdtForm.ResetGrid;

var  EstadoInicial,
     EstadoFinal : SmallInt;
     FechaInicial,
     FechaFinal : TDateTime;
     SQLString : String;

begin

     TareaQuery.Close;

     TableViewCodigoTecnico.Visible := ValueIsEmpty( DataCodigoTecnico.Value );

     FechaInicial := IncDay( ApplicationContainer.TodayDate, -180 );   // Unos seis meses
     FechaFinal := ApplicationContainer.TodayDate;

     SQLString := 'SELECT Tarea.*, Cliente.Nombre, Cliente.Telefono FROM Tarea LEFT JOIN Cliente ON ( Tarea.CodigoCliente=Cliente.Codigo ) WHERE ';

     case DataMostrar.Value of
       0 : StrAdd( SQLString, 'Estado=0 AND' );
       1 : StrAdd( SQLString, 'Estado=1 AND' );
       2 : ;
      end;

     StrAdd( SQLString, SQLFormat( ' Fecha BETWEEN %s and %s', [ SQLDateString( FechaInicial ), SQLDateString( FechaFinal ) ] ) );

     If   not ValueIsEmpty( DataCodigoTecnico.Value )
     then StrAdd( SQLString, SQLFormat( ' AND CodigoTecnico=%s', [ DataCodigoTecnico ] ) );

     StrAdd( SQLString, ' ORDER BY Fecha, NroTarea' );
     
     With TareaQuery do
       begin
       SQL.Text := SQLString;
       Open;
       Last;
       end;
     
     TareaFields := TTareaFields.Create( TareaQuery );

end;

procedure TBoxGdtForm.TableViewCustomDrawCell( Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     With AViewInfo do
       If   not Selected
       then If   VarToBoolean( GridRecord.Values[ TableViewUrgente.Index ], False )
            then ACanvas.Brush.Color:= clLightRed;
end;

procedure TBoxGdtForm.TableViewManagerInsert(Sender: TObject);
begin
     InsertaTarea;
end;

procedure TBoxGdtForm.TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     With TareaFields do
       MntTareas( [ Ejercicio.Value, NroTarea.Value ] );
end;

procedure TBoxGdtForm.AgruparCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     TableView.OptionsView.GroupByBox := AgruparCtrl.Checked;
     ExpandirButton.Visible := AgruparCtrl.Checked;
     ColapsarButton.Visible := AgruparCtrl.Checked;
end;

procedure TBoxGdtForm.CodigoTecnicoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTecnicos( [ Sender.EditingValue ] );
end;

procedure TBoxGdtForm.CodigoTecnicoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTecnicos( Sender );
end;

procedure TBoxGdtForm.CodigoTecnicoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     With CodigoTecnicoCtrl do
       If   ValueIsEmpty( DisplayValue )
       then Description :=  RsgMsgTodos
       else ValidateRelation( Sender, TecnicoTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, 'Nombre' );
end;

procedure TBoxGdtForm.ColapsarButtonClick(Sender: TObject);
begin
     TableView.ViewData.Collapse( True );
     Grid.SetFocus;
end;

procedure TBoxGdtForm.ExpandirButtonClick(Sender: TObject);
begin
     TableView.ViewData.Expand( True );
     Grid.SetFocus;
end;

procedure TBoxGdtForm.FormManagerReportRequest;
begin
     ListadoTareas( DataMostrar.Value, DataCodigoTecnico.Value );
end;

procedure TBoxGdtForm.FormManagerActivateForm;
begin
     ResetGrid;
end;

function TBoxGdtForm.FormManagerCanClose: Boolean;
begin
     Result := FormManager.ButtonPressed<>mrOk;
end;

procedure TBoxGdtForm.FormManagerFocusedAreaChanged;
begin
     With FormManager do
       begin
       If   DataAreaFocused
       then ResetGrid;
       TareaDataSource.Enabled := DataAreaFocused;
       end;
end;

procedure TBoxGdtForm.InsertButtonClick(Sender: TObject);
begin
     InsertaTarea;
end;

procedure TBoxGdtForm.InsertaTarea;
begin
     Grid.SetFocus;
     MntTareas( [ ApplicationContainer.Ejercicio, Tarea.ProximoNroTarea ] );
     If   Assigned( MntTarForm )
     then With MntTarForm do
            If   TareaTable.State=dsSetKey
            then begin
                 FormManager.SelectFirstDataControl;
                 If   DataCodigoTecnico.Value<>''
                 then CodigoTecnicoCtrl.PostEditValue( DataCodigoTecnico.Value );
                 end;
end;

end.

