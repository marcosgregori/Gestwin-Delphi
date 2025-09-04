
unit cx_cdt;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  EnterpriseDataAccess,
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
  TcxCdtForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryDescripcion: TWideStringField;
    cxGridDBTableViewCodigo: TcxGridDBColumn;
    cxGridDBTableViewDescripcion: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
  class var
    OnDataSelected : TDataEditEvent;
  public
  end;

var  CxCdtForm : TcxCdtForm = nil;

procedure ConsultaCodigosTarifa( Edit           : TcxCustomEdit;
                                 InitialState   : TQueryGridInitialState = qgsNormal;
                                 OnDataSelected : TDataEditEvent = nil );

implementation

{$R *.dfm}

procedure ConsultaCodigosTarifa( Edit           : TcxCustomEdit;
                                 InitialState   : TQueryGridInitialState = qgsNormal;
                                 OnDataSelected : TDataEditEvent = nil );
begin
     TcxCdtForm.OnDataSelected := OnDataSelected;
     CreateQueryForm( TcxCdtForm, cxCdtForm, Edit, InitialState );
end;

procedure TcxCdtForm.FormCreate( Sender : TObject );
begin
     QueryPanel.OnDataSelected := OnDataSelected;
end;

end.
