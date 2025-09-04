
unit cx_cat;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  EnterpriseDataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, DataManager, cxLookAndFeels, cxLookAndFeelPainters, QueryForm,
  cxContainer, cxGroupBox, cxNavigator, cxLabel,

  Gim30Fields,
  cxTL,
  cxInplaceContainer,
  cxTLData,
  cxDBTL,
  cxMaskEdit,
  Vcl.Menus,
  cxButtons,
  cxTLdxBarBuiltInMenu, dxScrollbarAnnotations;

type
  TCxCatForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    TreeList: TcxDBTreeList;
    TreeListCodigo: TcxDBTreeListColumn;
    TreeListNombre: TcxDBTreeListColumn;
    cxGroupBox1: TcxGroupBox;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    QueryCodigo: TWideStringField;
    QueryCodigoPadre: TWideStringField;
    QueryNombre: TWideStringField;
  private
  protected
  public
  end;

var  CxCatForm : TCxCatForm = nil;

procedure ConsultaCategorias( Edit         : TcxCustomEdit;
                              InitialState : TQueryGridInitialState = qgsNormal);

implementation


{$R *.dfm}

procedure ConsultaCategorias( Edit         : TcxCustomEdit;
                              InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TCxCatForm, CxCatForm, Edit, InitialState );
end;


end.

