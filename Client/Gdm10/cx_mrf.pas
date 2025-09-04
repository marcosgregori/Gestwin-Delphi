
unit cx_mrf;

interface

uses Forms, AppForms, Classes, Controls,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, dxSkinsCore,
  dxSkinscxPCPainter, dxmdaset, cxLookAndFeels, cxLookAndFeelPainters, QueryForm,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  TCxMrfForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewCodigo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    Data: TgxMemData;
    DataCodigo: TSmallintField;
    DataDescripcion: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var  CxMrfForm : TCxMrfForm = nil;

procedure ConsultaMetodosRectificacion( Edit         : TcxCustomEdit;
                                        InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses EnterpriseDataAccess,

     dm_iva;

procedure ConsultaMetodosRectificacion( Edit         : TcxCustomEdit;
                                        InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TCxMrfForm, CxMrfForm, Edit, InitialState);
end;

procedure TCxMrfForm.FormCreate(Sender: TObject);

var  I : SmallInt;

begin
     With Data do
       begin
       Open;
       For I in [ 1..5 ] do
         begin
         Append;
         DataCodigo.Value := I;
         DataDescripcion.Value := Tasa.TextoMetodoRectificacion( I );
         Post;
         end;
       First;
       end;
end;

end.
