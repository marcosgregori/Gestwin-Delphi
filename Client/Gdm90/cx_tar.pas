
unit cx_tar;

interface

uses Forms, AppForms, Classes, Controls,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit, cxCheckBox,
  dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels, cxLookAndFeelPainters, QueryForm,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type
  TCxTarForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryEjercicio: TSmallintField;
    QueryNroTarea: TIntegerField;
    QueryEstado: TSmallintField;
    QueryFecha: TDateField;
    QueryCodigoCliente: TWideStringField;
    QueryCodigoTecnico: TWideStringField;
    QueryUrgente: TBooleanField;
    QueryCodigoTipoTarea: TWideStringField;
    QueryAsunto: TWideStringField;
    QueryFechaResolucion: TDateField;
    QueryResolucion: TWideStringField;
    QueryNombre: TWideStringField;
    TableViewNroTarea: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    TableViewCodigoCliente: TcxGridDBColumn;
    TableViewCodigoTecnico: TcxGridDBColumn;
    TableViewUrgente: TcxGridDBColumn;
    TableViewAsunto: TcxGridDBColumn;
    TableViewFechaResolucion: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    QueryTiempo: TLongWordField;
    QueryDuracion: TTimeField;
  private
  protected
    class var
    FechaInicial,
    FechaFinal : TDateTime;
  end;

var  CxTarForm : TCxTarForm = nil;

procedure ConsultaTareas( Edit   : TcxCustomEdit;
                          InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaTareas( Edit   : TcxCustomEdit;
                          InitialState : TQueryGridInitialState = qgsNormal );

begin
     CreateQueryForm( TCxTarForm, CxTarForm, Edit, InitialState , dsFrom30DaysAgo );
end;

end.
