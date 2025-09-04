
unit cx_rrf;

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
  dxDateRanges, dxScrollbarAnnotations;

type
  TCxRrfForm = class(TgxForm)
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

var  CxRrfForm : TCxRrfForm = nil;

procedure ConsultaRazonesRectificacion( Edit   : TcxCustomEdit;
                                        InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses EnterpriseDataAccess,

     dm_iva;

procedure ConsultaRazonesRectificacion( Edit   : TcxCustomEdit;
                                        InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TCxRrfForm, CxRrfForm, Edit, InitialState);
end;

procedure TCxRrfForm.FormCreate(Sender: TObject);

var  I : SmallInt;

begin
     With Data do
       begin
       Open;
       For I in [ 1..16, 80..85 ] do
         begin
         Append;
         DataCodigo.Value := I;
         DataDescripcion.Value := Tasa.TextoRazonRectificacion( I );
         Post;
         end;
       First;
       end;
end;

end.
