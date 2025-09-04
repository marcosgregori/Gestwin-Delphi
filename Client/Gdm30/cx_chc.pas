
unit cx_chc;

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
  TcxChcForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewCodigo: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewEnvios_Nombre: TcxGridDBColumn;
    QueryCodigoCliente: TWideStringField;
    QueryNombre: TWideStringField;
    TableViewTelefono: TcxGridDBColumn;
    TableViewFax: TcxGridDBColumn;
    TableViewEMail: TcxGridDBColumn;
    TableViewCampoLibre1: TcxGridDBColumn;
    TableViewCampoLibre2: TcxGridDBColumn;
    TableViewCampoLibre3: TcxGridDBColumn;
    TableViewCampoLibre4: TcxGridDBColumn;
    TableViewDomicilio: TcxGridDBColumn;
    TableViewLocalidad: TcxGridDBColumn;
    TableViewNIF: TcxGridDBColumn;
    TableViewAnotacion: TcxGridDBColumn;
    TableViewEnvios_FormaEnvio: TcxGridDBColumn;
    TableViewCodigoPais: TcxGridDBColumn;
    TableViewEnvios_Domicilio: TcxGridDBColumn;
    TableViewEnvios_Localidad: TcxGridDBColumn;
    TableViewObsoleto: TcxGridDBColumn;
    QueryNroOrden: TSmallintField;
    procedure FormCreate(Sender: TObject);
  private
  protected
    class var
    OnUserSelection : TDataEditEvent;
  public
  end;

var  cxChcForm : TcxChcForm = nil;

procedure ConsultaConsumosHabituales( Edit          : TcxCustomEdit;
                                      InitialState : TQueryGridInitialState = qgsNormal;
                                      UserSelection : TDataEditEvent = nil );
implementation

{$R *.dfm}

uses Graphics,
     SysUtils,
     LibUtils,
     Variants;

procedure ConsultaConsumosHabituales( Edit             : TcxCustomEdit;
                                      InitialState : TQueryGridInitialState = qgsNormal;
                                      UserSelection    : TDataEditEvent = nil );
begin
     TcxChcForm.OnUserSelection := UserSelection;
     CreateQueryForm( TcxChcForm, cxChcForm, Edit, InitialState );
end;

procedure TcxChcForm.FormCreate(Sender: TObject);
begin
     QueryPanel.OnDataSelected := OnUserSelection;
end;

end.

