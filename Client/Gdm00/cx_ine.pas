
unit cx_ine;

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
  TcxIneForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    QueryNroRegistro: TSmallintField;
    QueryDescripcion: TWideStringField;
    cxGridDBTableViewNroRegistro: TcxGridDBColumn;
    cxGridDBTableViewDescripcion: TcxGridDBColumn;
    QueryTipoDocumento: TSmallintField;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var  cxIneForm : TcxIneForm = nil;

procedure ConsultaInformesExternos( Edit         : TcxCustomEdit;
                                    InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses  dm_ine;

procedure ConsultaInformesExternos( Edit         : TcxCustomEdit;
                                    InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxIneForm, cxIneForm, Edit, InitialState );
end;

procedure TcxIneForm.FormCreate(Sender: TObject);
begin
     Query.Params[ 0 ].Value := Ord( impDefinidoUsuario );
end;

end.
