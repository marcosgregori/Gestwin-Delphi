
unit cx_ret;

interface

uses Forms, AppForms, Classes, Controls,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit,


  dm_iva, cxCheckBox, dxSkinsCore, dxSkinscxPCPainter, QueryForm,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  dxSkinsDefaultPainters, cxGroupBox, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations;

type
  TCxRetForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigo: TSmallintField;
    QueryDescripcion: TWideStringField;
    QueryIVASoportado: TBCDField;
    QueryCtaSoportado: TWideStringField;
    QueryIVAREpercutido: TBCDField;
    QueryRERepercutido: TBCDField;
    QueryCtaRepercutido: TWideStringField;
    QueryLiquidable: TBooleanField;
    QuerySobreTotal: TBooleanField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewRetencion: TcxGridDBColumn;
    TableViewLiquidable: TcxGridDBColumn;
    TableViewSobreTotal: TcxGridDBColumn;
    QueryCodigoRetencion: TLargeintField;
    procedure FormCreate(Sender: TObject);
  private
    class var Fecha : TDate;
  public
  end;

var  CxRetForm : TCxRetForm = nil;

procedure ConsultaRetenciones( Fecha  : TDateTime;
                               Edit   : TcxCustomEdit;
                               InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses  dmi_iva;

procedure ConsultaRetenciones( Fecha  : TDateTime;
                               Edit   : TcxCustomEdit;
                               InitialState : TQueryGridInitialState = qgsNormal );
begin
     TcxRetForm.Fecha := Fecha;
     CreateQueryForm( TcxRetForm, cxRetForm, Edit, InitialState );
end;

procedure TCxRetForm.FormCreate(Sender: TObject);
begin
     SetColumnDecimals( TableViewRetencion );

     Query.Params[ 0 ].Value := Tasa.UltimaFechaAplicacion( Fecha, { Retencion } True );
end;

end.
