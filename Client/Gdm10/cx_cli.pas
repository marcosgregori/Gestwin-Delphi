
unit cx_cli;

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
  dxSkinscxPCPainter, DataManager, cxLookAndFeels, cxLookAndFeelPainters, QueryForm,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type
  TcxCliForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewCodigo: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewEnvios_Nombre: TcxGridDBColumn;
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
    QueryEnvios_FormaEnvio: TWideStringField;
    TableViewEnvios_FormaEnvio: TcxGridDBColumn;
    QueryCodigoPais: TWideStringField;
    QueryEnvios_Domicilio: TWideStringField;
    QueryEnvios_Localidad: TWideStringField;
    TableViewCodigoPais: TcxGridDBColumn;
    TableViewEnvios_Domicilio: TcxGridDBColumn;
    TableViewEnvios_Localidad: TcxGridDBColumn;
    QueryObsoleto: TBooleanField;
    TableViewObsoleto: TcxGridDBColumn;
    ClienteTable: TnxeTable;
    procedure FormCreate(Sender: TObject);
    procedure TableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure queryPanelUserSelection;
    procedure ClienteTableFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
  protected
    class var
    IncluirObsoletos : Boolean;
    OnUserSelection : TDataEditEvent;
  public
  end;

var  cxCliForm : TcxCliForm = nil;

procedure ConsultaClientes( Edit             : TcxCustomEdit;
                            InitialState     : TQueryGridInitialState = qgsNormal;
                            IncluirObsoletos : Boolean = False;
                            UserSelection    : TDataEditEvent = nil );
implementation

{$R *.dfm}

uses Graphics,
     SysUtils,
     LibUtils,
     Variants,

     Gdm00Dm,
     Gim00Fields,

     a_cli;

procedure ConsultaClientes( Edit             : TcxCustomEdit;
                            InitialState     : TQueryGridInitialState = qgsNormal;
                            IncluirObsoletos : Boolean = False;
                            UserSelection    : TDataEditEvent = nil );
begin
     TcxCliForm.IncluirObsoletos := IncluirObsoletos;
     TcxCliForm.OnUserSelection := UserSelection;
     CreateQueryForm( TcxCliForm, cxCliForm, Edit, InitialState);
end;

procedure TcxCliForm.ClienteTableFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin                                           
     // Se tiene que activar el filtro porque los ficheros maestros, aunque usen un sentencia SQL, en su primera aparición utilizan esta tabla 
     // para mejorar el rendimiento                                                
     Accept := IncluirObsoletos or not ClienteTable.FieldValues[ 'Obsoleto' ];
end;

procedure TcxCliForm.FormCreate(Sender: TObject);

var  SQLText : String;

procedure SetupCampoLibre( CampoLibre : TWideStringField;
                           Column     : TcxGridDBColumn );
begin
     Column.VisibleForCustomization := DataModule00.DmEmpresaFields.Cliente_CamposLibres.Value and ( CampoLibre.Value<>'' );
     If   Column.VisibleForCustomization
     then Column.Caption := CampoLibre.Value;
end;

begin

     With DataModule00.DmEmpresaFields do
       begin
       SetupCampoLibre( Cliente_CampoLibre[ 1 ], TableViewCampoLibre1 );
       SetupCampoLibre( Cliente_CampoLibre[ 2 ], TableViewCampoLibre2 );
       SetupCampoLibre( Cliente_CampoLibre[ 3 ], TableViewCampoLibre3 );
       SetupCampoLibre( Cliente_CampoLibre[ 4 ], TableViewCampoLibre4 );
       end;

     If   IncluirObsoletos
       then SQLText := ''
       else SQLText := ' WHERE NOT Obsoleto ';
       StrAdd( SQLText, ' ORDER BY Codigo ' );
       Query.SQL.Text := Query.SQL.Text + SQLText;

     QueryPanel.OnDataSelected := OnUserSelection;
end;

procedure TcxCliForm.QueryPanelUserSelection;
begin
     MntClientes(  [ QueryCodigo.Value ] );
end;

procedure TcxCliForm.TableViewCustomDrawCell( Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     If   not AViewInfo.Selected
     then If   IncluirObsoletos and VarToBoolean( AViewInfo.GridRecord.Values[ TableViewObsoleto.Index ] )
          then ACanvas.Font.Color := clGray;
end;

end.

