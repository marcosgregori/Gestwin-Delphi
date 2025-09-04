
unit cx_apc;

interface

uses Forms, AppForms, Classes, Controls,

  AppManager,
  LibUtils,
  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels,
  cxLookAndFeelPainters, QueryForm, cxContainer, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type
  TcxApcForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryEjercicio: TSmallintField;
    QuerySerie: TWideStringField;
    QueryFecha: TDateField;
    QueryImporteNeto: TBCDField;
    TableViewNro_Documento: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    TableViewImporteNeto: TcxGridDBColumn;
    TableViewSerie: TcxGridDBColumn;
    QueryNroDocumento: TIntegerField;
    QueryNroOperacion: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure QueryAfterOpen(DataSet: TDataSet);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure queryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
  private
    SQLString : String;
  public
    class var
    OnUserSelection : TDataEditEvent;
    FechaInicial : TDateTime;
    FechaFinal : TDateTime;
    CodigoProveedor : String;
  end;

var  CxApcForm : TcxApcForm = nil;

procedure ConsultaAlbaranesCompraPendientes( UnCodigoProveedor : String;
                                             Edit              : TcxCustomEdit;
                                             UserSelection     : TDataEditEvent = nil;
                                             InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses SysUtils,
     EnterpriseDataAccess,

     dm_mov;

procedure ConsultaAlbaranesCompraPendientes( UnCodigoProveedor : String;
                                             Edit              : TcxCustomEdit;
                                             UserSelection     : TDataEditEvent = nil;
                                             InitialState      : TQueryGridInitialState = qgsNormal );
begin
     With TcxApcForm do
       begin
       OnUserSelection := UserSelection;
       CodigoProveedor := UnCodigoProveedor;
       CreateQueryForm( TcxApcForm, CxApcForm, Edit, InitialState, dsFrom30DaysAgo );
       end;
end;

procedure TcxApcForm.FormCreate(Sender: TObject);
begin
     With Query do
       begin
       Params[ 0 ].Value := CodigoProveedor;
       end;

     SetColumnDecimals( TableViewImporteNeto );

     QueryPanel.OnDataSelected := OnUserSelection;
end;

procedure TcxApcForm.QueryAfterOpen(DataSet: TDataSet);
begin
     SQLString := Query.SQL.Text;
end;

procedure TcxApcForm.QueryCalcFields(DataSet: TDataSet);

var   ImporteBruto,
      DescuentosArticulos,
      ImporteNeto : Decimal;

begin
     If   TableViewImporteNeto.Visible
     then begin
          Movimiento.ObtenImporteMovimiento( QueryEjercicio.Value,
                                             QueryNroOperacion.Value,
                                             ImporteBruto,
                                             DescuentosArticulos,
                                             ImporteNeto );

          QueryImporteNeto.Value := ImporteNeto;
          end;
end;

procedure TcxApcForm.queryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
begin
     If   Column=TableViewImporteNeto
     then Query.RefreshQuery;
end;

end.
