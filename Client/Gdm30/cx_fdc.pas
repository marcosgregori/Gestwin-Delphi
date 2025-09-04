
unit cx_fdc;

interface

uses Forms, AppForms, Classes, Controls,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit, cxCheckBox,
  dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels, cxLookAndFeelPainters, QueryForm,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator, cxIntegerEdit, cxTextEdit,
  dxDateRanges, dxScrollbarAnnotations;

type
  TCxFdcForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryFecha: TDateField;
    QueryNombre: TWideStringField;
    TableViewFecha: TcxGridDBColumn;
    TableViewProveedor: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    QueryTotalFactura: TBCDField;
    QueryTraspasada: TBooleanField;
    TableViewImporte: TcxGridDBColumn;
    TableViewTraspasada: TcxGridDBColumn;
    QueryProveedor: TWideStringField;
    QueryEjercicio: TSmallintField;
    QuerySerieNroFactura: TWideStringField;
    TableViewSerieNroFactura: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure QueryPanelUserSelection;
    procedure QueryPanelAfterReadQueryState;
  private
  protected
  class var
    OnUserSelection : TDataEditEvent;
    LockRange : Boolean;
  public
  end;

var  CxFdcForm : TCxFdcForm = nil;

procedure ConsultaFacturasCompra( LockRangeField  : TField;
                                  Edit            : TcxCustomEdit;
                                  InitialState    : TQueryGridInitialState = qgsNormal;
                                  UserSelection   : TDataEditEvent = nil;
                                  LockRange       : Boolean = False );

implementation

{$R *.dfm}

uses SysUtils,
     LibUtils,

     EnterpriseDataAccess,

     a_fdc,

     dm_fac;

procedure ConsultaFacturasCompra( LockRangeField : TField;
                                  Edit           : TcxCustomEdit;
                                  InitialState   : TQueryGridInitialState = qgsNormal;
                                  UserSelection  : TDataEditEvent = nil;
                                  LockRange      : Boolean = False );
begin
     TCxFdcForm.OnUSerSelection := UserSelection;
     TCxFdcForm.LockRange:= LockRange;
     CreateQueryForm( TCxFdcForm, CxFdcForm, LockRangeField, Edit, InitialState, dsFrom30DaysAgo );
end;

procedure TCxFdcForm.FormCreate(Sender: TObject);
begin
     SetColumnDecimals( TableViewImporte );
     QueryPanel.OnDataSelected := TCxFdcForm.OnUserSelection;
end;

procedure TCxFdcForm.QueryPanelAfterReadQueryState;
begin
     QueryPanel.LockRange := QueryPanel.LockRange or LockRange;
     TableViewNombre.Visible := not QueryPanel.LockRange;
end;

procedure TCxFdcForm.QueryPanelUserSelection;
begin
     MntFacturasCompra( [ QueryEjercicio.Value, QueryProveedor.Value, QuerySerieNroFactura.Value ] );
end;

end.
