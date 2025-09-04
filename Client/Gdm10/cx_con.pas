
unit cx_con;

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
  TcxConForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    QueryNroConcepto: TSmallIntField;
    QueryDescripcion: TWideStringField;
    dataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridDBTableViewNroConcepto: TcxGridDBColumn;
    cxGridDBTableViewDescripcion: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    procedure FormCreate(Sender: TObject);
  private
  protected
    class var
    ReturnDescription : Boolean;
  end;

var  cxConForm : TcxConForm = nil;

procedure ConsultaConceptosApunte( Edit              : TcxCustomEdit;
                                   InitialState : TQueryGridInitialState = qgsNormal;
                                   ReturnDescription : Boolean = False );

implementation

{$R *.dfm}

procedure ConsultaConceptosApunte( Edit              : TcxCustomEdit;
                                   InitialState : TQueryGridInitialState = qgsNormal;
                                   ReturnDescription : Boolean = False );
begin
     TcxConForm.ReturnDescription := ReturnDescription;
     CreateQueryForm( TcxConForm, cxConForm, Edit, InitialState );
end;

procedure TcxConForm.FormCreate(Sender: TObject);
begin
     If   ReturnDescription
     then QueryPanel.SourceField := QueryDescripcion;
end;

end.
