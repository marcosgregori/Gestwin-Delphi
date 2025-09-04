
unit cx_cpt;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, dxSkinsCore, dxSkinscxPCPainter,
  DataManager, QueryForm, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type
  TcxCptForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    QueryNroCapturador: TSmallintField;
    QueryDescripcion: TWideStringField;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    TableViewNroCapturador: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    procedure FormCreate(Sender: TObject);
  private
  protected
    class var
    ReturnDescription : Boolean;
  end;

var  cxCptForm : TcxCptForm = nil;

procedure ConsultaCapturadores( Edit              : TcxCustomEdit;
                                InitialState : TQueryGridInitialState = qgsNormal;
                                ReturnDescription : Boolean = False );

implementation

{$R *.dfm}

procedure ConsultaCapturadores( Edit              : TcxCustomEdit;
                                InitialState : TQueryGridInitialState = qgsNormal;
                                ReturnDescription : Boolean = False );
begin
     TcxCptForm.ReturnDescription := ReturnDescription;
     CreateQueryForm( TCxCptForm, CxCptForm, Edit, InitialState );
end;

procedure TcxCptForm.FormCreate(Sender: TObject);
begin
     If   ReturnDescription
     then QueryPanel.SourceField := QueryDescripcion;
end;

end.
