
unit cx_cop;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  DataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, QueryForm, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinscxPCPainter, cxContainer,
  dxSkinsDefaultPainters, cxGroupBox, DataManager, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type
  TCxCopForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryNombre: TWideStringField;
    cxGridDBTableViewCodigo: TcxGridDBColumn;
    cxGridDBTableViewNombre: TcxGridDBColumn;
    QueryCodigoPais: TWideStringField;
    QueryCodigoProvincia: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
  protected
    class var
    CodigoPais,
    CodigoProvincia : String;
  end;

var  CxCopForm : TCxCopForm = nil;

procedure ConsultaCodigosPostales( CodigoPais,
                                   CodigoProvincia : String;
                                   Edit            : TcxCustomEdit;
                                   InitialState    : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaCodigosPostales( CodigoPais,
                                   CodigoProvincia : String;
                                   Edit            : TcxCustomEdit;
                                   InitialState    : TQueryGridInitialState = qgsNormal );
begin
     TCxCopForm.CodigoPais := CodigoPais;
     TCxCopForm.CodigoProvincia := CodigoProvincia;
     CreateQueryForm( TCxCopForm, CxCopForm, Edit, InitialState );
end;

procedure TCxCopForm.FormCreate(Sender: TObject);
begin
     With Query do
       begin
       Params[ 0 ].Value := CodigoPais;
       Params[ 1 ].Value := CodigoProvincia;
       end;
end;

end.
