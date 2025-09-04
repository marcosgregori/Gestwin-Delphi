
unit cx_prv;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  DataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb,

  QueryForm, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinscxPCPainter, cxContainer, dxSkinsDefaultPainters, cxGroupBox,
  DataManager, cxNavigator, dxDateRanges, dxScrollbarAnnotations;

type
  TCxPrvForm = class(TgxForm)
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
    procedure FormCreate(Sender: TObject);
  private
  protected
    class var
    CodigoPais : String;
  end;

var  CxPrvForm : TCxPrvForm = nil;

procedure ConsultaProvincias( CodigoPais   : String;
                              Edit         : TcxCustomEdit;
                              InitialState : TQueryGridInitialState = qgsNormal ); overload;

implementation

{$R *.dfm}

procedure ConsultaProvincias( CodigoPais   : String;
                              Edit         : TcxCustomEdit;
                              InitialState : TQueryGridInitialState = qgsNormal );
begin
     TCxPrvForm.CodigoPais := CodigoPais;
     CreateQueryForm( TCxPrvForm, CxPrvForm, Edit, InitialState );
end;

procedure TCxPrvForm.FormCreate(Sender: TObject);
begin
     Query.Params[ 0 ].Value := CodigoPais;
end;

end.
