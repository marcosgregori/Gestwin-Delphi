
unit cx_can;

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
  dxSkinscxPCPainter, DataManager, QueryForm, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxGroupBox, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations;

type
  TCxCanForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCentroCoste: TWideStringField;
    QueryCodigo: TWideStringField;
    QueryDescripcion: TWideStringField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewCentroCoste: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure queryPanelDataSelected(Target: TcxCustomEdit);
  private

  protected
    class var
    CentroCosteField : TWideStringField;
  end;

var  CxCanForm : TCxCanForm = nil;

procedure ConsultaCuentasAnaliticas( Edit             : TcxCustomEdit;
                                     CentroCosteField : TWideStringField;
                                     InitialState : TQueryGridInitialState = qgsNormal );

implementation

uses  SysUtils,

      // dm_rac,

      Gim00Fields;

{$R *.dfm}

procedure ConsultaCuentasAnaliticas( Edit             : TcxCustomEdit;
                                     CentroCosteField : TWideStringField;
                                     InitialState : TQueryGridInitialState = qgsNormal );
begin
     TCxCanForm.CentroCosteField := CentroCosteField;
     CreateQueryForm( TCxCanForm, CxCanForm, Edit, InitialState );
end;

procedure TCxCanForm.FormCreate(Sender: TObject);

var  CentroCosteVacio : Boolean;

begin
     If   Assigned( CentroCosteField )
     then begin
          CentroCosteVacio := ValueIsEmpty( CentroCosteField.Value );
          If   not CentroCosteVacio
          then Query.SQL.Add( ' WHERE CentroCoste=' + QuotedStr( CentroCosteField.Value ) );
          TableViewCentroCoste.Visible := CentroCosteVacio;
          end;
     Query.SQL.Add( ' ORDER BY Codigo' );
end;

procedure TCxCanForm.queryPanelDataSelected(Target: TcxCustomEdit);
begin
     If   Assigned( CentroCosteField )
     then CentroCosteField.Value := QueryCentroCoste.Value;

     With QueryPanel do
       If   Assigned( TargetControl )
       then TargetControl.PostEditValue( QueryCodigo.Value );
end;

end.
