unit b_eom;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Grids, Menus, cxLookAndFeelPainters, cxGraphics, DB, nxdb,
  DataManager, cxMaskEdit, cxDropDownEdit, cxDBEdit, cxIndexedComboBox,
  cxCurrencyEdit, cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxLookAndFeels, dxSkinsCore, cxLabel, cxGroupBox, dxSkinsDefaultPainters,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  cxSpinEdit, cxDurationEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,

  LibUtils,
  Gim70Fields, dxDateRanges, AppForms, GridTableViewController, cxCalendar,
  dxmdaset, dxScrollbarAnnotations, cxTimeEdit;

type
  TBoxEomForm = class(TgxForm)
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
    NroTurnoCtrl: TcxDBSpinEdit;
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
    TableViewNroOrdenEntrada: TcxGridDBColumn;
    TableViewTiempo: TcxGridDBColumn;
    TableViewCantidad: TcxGridDBColumn;
    cxLabel2: TcxLabel;
    FechaCtrl: TcxDBDateEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoMaquina: TStringField;
    DataFecha: TDateField;
    DataTurno: TSmallintField;
    TableViewEjercicio: TcxGridDBColumn;
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
    RenumerarButton: TgBitBtn;
    SecuenciaAsignacionTableHoraInicio: TTimeField;
    TableViewHoraInicio: TcxGridDBColumn;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure SecuenciaAsignacionTableCalcFields(DataSet: TDataSet);
    procedure CodigoMaquinaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoMaquinaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoMaquinaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure NroTurnoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure NroTurnoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure NroTurnoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure FormManagerFocusedAreaChanged;
    procedure SecuenciaAsignacionTableFilterRecord(DataSet: TDataSet;var Accept: Boolean);
    procedure RenumerarButtonClick(Sender: TObject);
    procedure FormManagerReportFormRequest;
    procedure GridTableViewControllerAfterRowShift(Sender: TObject);
  private

    FSecuenciaAsignacionFields : TSecuenciaAsignacionFields;
    OrdenFabricacionFields : TOrdenFabricacionFields;

    MaquinaFields : TMaquinaFields;

    function GetSecuenciaAsignacionFields: TSecuenciaAsignacionFields;
    procedure ReordenaSecuenciaAsignacion;

    property SecuenciaAsignacionFields : TSecuenciaAsignacionFields read GetSecuenciaAsignacionFields;

  public
  end;

var
  BoxEomForm: TBoxEomForm = nil;

procedure EntradaOrdenesEnMaquinas( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Gdm70Dm,
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

       cx_maq,
       cx_tur,
       cx_opr,

       l_eom;

resourceString
      RsMsg1 = '';

procedure EntradaOrdenesEnMaquinas( KeyValues : array of const );
begin
     CreateEditForm( TBoxEomForm, BoxEomForm, KeyValues, Gds70Frm.ProduccionSection );
end;

procedure TBoxEomForm.CodigoMaquinaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntMaquinas( [ Sender.EditingValue ] );
end;

procedure TBoxEomForm.CodigoMaquinaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMaquinas( Sender );
end;

procedure TBoxEomForm.CodigoMaquinaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Maquina.Valida( Sender, DisplayValue, ErrorText, Error, False, MaquinaFields );
end;

procedure TBoxEomForm.FormManagerFocusedAreaChanged;
begin
     If   FormManager.DataAreaFocused
     then SecuenciaAsignacionTable.SetRange( [ DataCodigoMaquina.Value, DataFecha.Value, DataTurno.Value, 0 ],
                                             [ DataCodigoMaquina.Value, DataFecha.Value, DataTurno.Value, MaxSmallint ] );
     SecuenciaAsignacionDataSource.Enabled := FormManager.DataAreaFocused;
     RenumerarButton.Enabled := FormManager.DataAreaFocused;
end;

procedure TBoxEomForm.FormManagerInitializeForm;
begin

     OrdenFabricacionFields := TOrdenFabricacionFields.Create( OrdenFabricacionTable );

     MaquinaFields := TMaquinaFields.Create( Self );

     Clase.SetupGridColumns( TableViewCodigoClaseA, TableViewCodigoClaseB, TableViewCodigoClaseC, 4 );

     DataFecha.Value := ApplicationContainer.TodayDate;

end;

procedure TBoxEomForm.FormManagerReportFormRequest;
begin
     ListadoEntradaOrdenesEnMaquinas( True );
end;

procedure TBoxEomForm.FormManagerReportRequest;
begin
     ListadoEntradaOrdenesEnMaquinas;
end;

function TBoxEomForm.GetSecuenciaAsignacionFields: TSecuenciaAsignacionFields;
begin
     If   not Assigned( FSecuenciaAsignacionFields )
     then FSecuenciaAsignacionFields := TSecuenciaAsignacionFields.Create( SecuenciaAsignacionTable );
     Result := FSecuenciaAsignacionFields;
end;

procedure TBoxEomForm.ReordenaSecuenciaAsignacion;
begin
     Maquina.OrdenaSecuenciaTurno( DatacodigoMaquina.Value, DataFecha.Value, DataTurno.Value );
     TableView.DataController.RefreshExternalData;
end;

procedure TBoxEomForm.GridTableViewControllerAfterRowShift(Sender: TObject);
begin
     ReordenaSecuenciaAsignacion;
end;

procedure TBoxEomForm.NroTurnoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTurnos( [ Sender.EditingValue ] );
end;

procedure TBoxEomForm.NroTurnoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTurnos( Sender );
end;

procedure TBoxEomForm.NroTurnoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Turno.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxEomForm.RenumerarButtonClick(Sender: TObject);
begin
     Maquina.OrdenaSecuenciaTurno( DatacodigoMaquina.Value, DataFecha.Value, DataTurno.Value, { Reordenar } True );
     TableView.DataController.RefreshExternalData;
end;

procedure TBoxEomForm.SecuenciaAsignacionTableCalcFields(DataSet: TDataSet);
begin
     If   OrdenFabricacionTable.Active
     then With SecuenciaAsignacionFields do
            If   OrdenFabricacionTable.FindKey( [ Ejercicio.value, moOrden, NroOrdenFabricacion.value ] )
            then begin
                 SecuenciaAsignacionTableCodigoArticulo.Value := OrdenFabricacionFields.CodigoArticulo.Value;
                 SecuenciaAsignacionTableCodigoClaseA.Value := OrdenFabricacionFields.CodigoClaseA.Value;
                 SecuenciaAsignacionTableCodigoClaseB.Value := OrdenFabricacionFields.CodigoClaseB.Value;
                 SecuenciaAsignacionTableCodigoClaseC.Value := OrdenFabricacionFields.CodigoClaseC.Value;
                 SecuenciaAsignacionTableDescripcionArticulo.Value := Articulo.Descripcion( OrdenFabricacionFields.CodigoArticulo.Value );
                 end;
end;

procedure TBoxEomForm.SecuenciaAsignacionTableFilterRecord( DataSet: TDataSet; var Accept: Boolean);
begin
     Accept := not SecuenciaAsignacionFields.Realizado.Value;
end;

end.
