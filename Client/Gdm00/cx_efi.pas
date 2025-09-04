
unit cx_efi;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, QueryForm,

  dm_efi, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinscxPCPainter, cxContainer, dxSkinsDefaultPainters, cxGroupBox,
  DataManager, cxNavigator, dxDateRanges, dxScrollbarAnnotations;

type
  TCxEfiForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    QueryFichero: TSmallintField;
    QueryNroRegistro: TSmallintField;
    QueryDescripcion: TWideStringField;
    cxGridDBTableViewNroRegistro: TcxGridDBColumn;
    cxGridDBTableViewDescripcion: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
  protected
    class var
    TipoFichero : TTipoFicheroEstructura;
  end;

var  CxEfiForm : TCxEfiForm = nil;

procedure ConsultaEstructuraFicheros( TipoFichero  : TTipoFicheroEstructura;
                                      Edit         : TcxCustomEdit;
                                      InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaEstructuraFicheros( TipoFichero  : TTipoFicheroEstructura;
                                      Edit         : TcxCustomEdit;
                                      InitialState : TQueryGridInitialState = qgsNormal );
begin
     TCxEfiForm.TipoFichero := TipoFichero;
     CreateQueryForm( TCxEfiForm, CxEfiForm, Edit, InitialState );
end;

procedure TCxEfiForm.FormCreate(Sender: TObject);
begin
     Query.Params[ 0 ].Value := TipoFichero;
end;

end.
