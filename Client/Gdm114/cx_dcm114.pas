
unit cx_dcm114;

interface

uses Forms, Classes, Controls,

  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit, cxCheckBox,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxGroupBox, cxNavigator,

  AppContainer,
  AppForms,
  QueryForm, dxDateRanges, dxScrollbarAnnotations;

type
  TCxDcmForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryEjercicio: TSmallintField;
    QueryNroOperacion: TIntegerField;
    QueryTipo: TSmallintField;
    QueryCodigoNaviera: TWideStringField;
    QueryDestino: TWideStringField;
    QueryFechaCarga: TDateField;
    TableViewEjercicio: TcxGridDBColumn;
    TableViewNroOperacion: TcxGridDBColumn;
    TableViewCodigoNaviera: TcxGridDBColumn;
    TableViewDestino: TcxGridDBColumn;
    QueryLugarOrigen: TWideStringField;
    TableViewFechaCarga: TcxGridDBColumn;
    TableViewLugarOrigen: TcxGridDBColumn;
    QueryPlataforma: TSmallintField;
    QueryLugarDestino: TWideStringField;
    TableViewTipo: TcxGridDBColumn;
    TableViewPlataforma: TcxGridDBColumn;
    TableViewLugarDestino: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure QueryPanelUserSelection;
  private
  public
    class var
    FechaInicial : TDateTime;
    FechaFinal : TDateTime;
    OnUserSelection : TDataEditEvent;
  end;

var  CxDcmForm : TCxDcmForm = nil;

procedure ConsultaDocumentosControlMercancias( Edit           : TcxCustomEdit;
                                               InitialState : TQueryGridInitialState = qgsNormal;
                                               UserSelection  : TDataEditEvent = nil );

implementation

{$R *.dfm}

uses SysUtils,
     LibUtils,

     EnterpriseDataAccess,

     a_dcm114;

procedure ConsultaDocumentosControlMercancias( Edit           : TcxCustomEdit;
                                               InitialState : TQueryGridInitialState = qgsNormal;
                                               UserSelection  : TDataEditEvent = nil );
begin
     TCxDcmForm.OnUserSelection := UserSelection;
     CreateQueryForm( TCxDcmForm, CxDcmForm, Edit, InitialState, dsFrom30DaysAgo );
end;

procedure TCxDcmForm.FormCreate(Sender: TObject);
begin
     QueryPanel.OnDataSelected := OnUserSelection;
end;

procedure TCxDcmForm.QueryPanelUserSelection;
begin
     MntDocumentosControlMercancias( [ QueryEjercicio.Value, QueryNroOperacion.Value ] );
end;

end.


