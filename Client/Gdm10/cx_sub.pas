
unit cx_sub;

interface

uses Forms, AppForms, Classes, Controls,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, dxSkinsCore,
  dxSkinscxPCPainter, cxLookAndFeels, cxLookAndFeelPainters, QueryForm,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type
  TcxSubForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryNivel: TSmallIntField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    QueryDescripcion: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
  protected
    class var
    SoloSubcuentas : Boolean;
    OnUserSelection : TDataEditEvent;
  end;

var  CxSubForm : TcxSubForm = nil;

procedure ConsultaCuentas( Edit           : TcxCustomEdit;
                           InitialState : TQueryGridInitialState = qgsNormal;
                           SoloSubcuentas : Boolean = True;
                           SinExtracto    : Boolean = False;
                           UserSelection  : TDataEditEvent = nil );

implementation

{$R *.dfm}

uses LibUtils,
     EnterpriseDataAccess,
     Variants,

     dm_sub,

     b_ext;

procedure ConsultaCuentas( Edit           : TcxCustomEdit;
                           InitialState : TQueryGridInitialState = qgsNormal;
                           SoloSubcuentas : Boolean = True;
                           SinExtracto    : Boolean = False;
                           UserSelection  : TDataEditEvent = nil );

var  EsUnaSubcuenta : Boolean;

begin
     If   VarIsNull( Edit.EditingValue )
     then EsUnaSubcuenta := False
     else EsUnaSubcuenta := Length( Edit.EditingValue )=9;

     // Si es una subcuenta y se quiere mostrar el extracto entonces se llama a 'ExtractoCuentas', pero además, si es una subcuenta
     // y no se quiere mostrar por defecto el extracto pero el usuario pulsa Shift, entonces se muestra el extracto (por oposición y como opción complementaria)

     TcxSubForm.SoloSubcuentas := SoloSubcuentas;
     TcxSubForm.OnUserSelection := UserSelection;
     If   EsUnaSubcuenta  and ( ( not SinExtracto and ( InitialState<>qgsLinked ) and not ShiftKey ) or ( SinExtracto and ShiftKey ) )
     then ExtractoCuentas( [ Edit.EditingValue ] )
     else CreateQueryForm( TcxSubForm, cxSubForm, Edit, InitialState );
end;

procedure TcxSubForm.FormCreate(Sender: TObject);
begin
     With Query.SQL do
       begin
       If   SoloSubcuentas
       then Add( ' WHERE Nivel=' + StrInt( Cuenta.NivelSubcuenta ) );
       Add( ' ORDER BY Codigo' );
       end;
     QueryPanel.OnDataSelected := OnUserSelection;
end;

end.
