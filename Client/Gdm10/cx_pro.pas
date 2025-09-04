
unit cx_pro;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  EnterpriseDataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, cxRichEdit, dxSkinsCore,
  dxSkinscxPCPainter, DataManager, QueryForm, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, dxSkinsDefaultPainters, cxGroupBox,
  cxNavigator, dxDateRanges, dxScrollbarAnnotations;

type
  TcxProForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryNombre: TWideStringField;
    QueryEnvios_Nombre: TWideStringField;
    QueryTelefono: TWideStringField;
    QueryFax: TWideStringField;
    QueryEMail: TWideStringField;
    QueryCampoLibre1: TWideStringField;
    QueryCampoLibre2: TWideStringField;
    QueryCampoLibre3: TWideStringField;
    QueryCampoLibre4: TWideStringField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewEnvios_Nombre: TcxGridDBColumn;
    TableViewTelefono: TcxGridDBColumn;
    TableViewFax: TcxGridDBColumn;
    TableViewEMail: TcxGridDBColumn;
    TableViewCampoLibre1: TcxGridDBColumn;
    TableViewCampoLibre2: TcxGridDBColumn;
    TableViewCampoLibre3: TcxGridDBColumn;
    TableViewCampoLibre4: TcxGridDBColumn;
    QueryDomicilio: TWideStringField;
    QueryLocalidad: TWideStringField;
    TableViewDomicilio: TcxGridDBColumn;
    TableViewLocalidad: TcxGridDBColumn;
    QueryNIF: TWideStringField;
    TableViewNIF: TcxGridDBColumn;
    QueryAnotacion: TWideMemoField;
    TableViewAnotacion: TcxGridDBColumn;
    ProveedorTable: TnxeTable;
    QueryObsoleto: TBooleanField;
    TableViewObsoleto: TcxGridDBColumn;
    procedure QueryPanelUserSelection;
    procedure FormCreate(Sender: TObject);
    procedure ProveedorTableFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure TableViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
  protected
    class var IncluirObsoletos : Boolean;
  public
  
  end;

var  cxProForm : TcxProForm = nil;

procedure ConsultaProveedores( Edit             : TcxCustomEdit;
                               InitialState : TQueryGridInitialState = qgsNormal;
                               IncluirObsoletos : Boolean = False );

implementation

{$R *.dfm}

uses  Graphics,

      LibUtils,

      Gdm00Dm,
      a_pro;

procedure ConsultaProveedores( Edit             : TcxCustomEdit;
                               InitialState : TQueryGridInitialState = qgsNormal;
                               IncluirObsoletos : Boolean = False );
begin
     TcxProForm.IncluirObsoletos := IncluirObsoletos;
     CreateQueryForm( TcxProForm, cxProForm, Edit, InitialState );
end;

procedure TcxProForm.FormCreate(Sender: TObject);

var  SQLText : String;

procedure SetupCampoLibre( CampoLibre : TWideStringField;
                           Column     : TcxGridDBColumn );
begin
     Column.VisibleForCustomization := DataModule00.DmEmpresaFields.Proveedor_CampLibre.Value and ( CampoLibre.Value<>'' );
     If   Column.VisibleForCustomization
     then Column.Caption := CampoLibre.Value;
end;

begin

     With DataModule00.DmEmpresaFields do
       begin
       SetupCampoLibre( Proveedor_CampoLib[ 1 ], TableViewCampoLibre1 );
       SetupCampoLibre( Proveedor_CampoLib[ 2 ], TableViewCampoLibre2 );
       SetupCampoLibre( Proveedor_CampoLib[ 3 ], TableViewCampoLibre3 );
       SetupCampoLibre( Proveedor_CampoLib[ 4 ], TableViewCampoLibre4 );
       end;

     If   IncluirObsoletos
     then SQLText := ''
     else SQLText := ' WHERE NOT Obsoleto ';
     StrAdd( SQLText, ' ORDER BY Codigo ' );
     Query.SQL.Text := Query.SQL.Text + SQLText;
end;

procedure TcxProForm.ProveedorTableFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
     Accept := IncluirObsoletos or not ProveedorTable.FieldValues[ 'Obsoleto' ];
end;

procedure TcxProForm.QueryPanelUserSelection;
begin
     MntProveedores( [ QueryCodigo.Value ] );
end;

procedure TcxProForm.TableViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     If   not AViewInfo.Selected
     then If   IncluirObsoletos and VarToBoolean( AViewInfo.GridRecord.Values[ TableViewObsoleto.Index ] )
          then ACanvas.Font.Color := clGray;
end;

end.
