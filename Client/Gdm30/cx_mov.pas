
unit cx_mov;

interface

uses Forms, AppForms, Classes, Controls,

  AppContainer,
  LibUtils,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit,

  dm_mov, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  cxLookAndFeelPainters, QueryForm, cxContainer, dxSkinsDefaultPainters,
  cxGroupBox, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  dxUIAClasses;

type
  TCxMovForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryEjercicio: TSmallintField;
    QueryNroOperacion: TIntegerField;
    QueryTipoMovimiento: TSmallintField;
    QueryDescripcion: TWideStringField;
    QuerySerie: TWideStringField;
    QueryNroDocumento: TIntegerField;
    QueryFecha: TDateField;
    QueryPropietario: TWideStringField;
    TableViewNroOperacion: TcxGridDBColumn;
    TableViewTipoMovimiento: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewSerie: TcxGridDBColumn;
    TableViewNroDocumento: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    TableViewPropietario: TcxGridDBColumn;
    QueryImporteNeto: TBCDField;
    TableViewImporteNeto: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
    procedure QueryPanelUserSelection;
  private
    ImporteBruto,
    DescuentosArticulos,
    ImporteNeto : Decimal;
    class var
    OnUserSelection : TDataEditEvent;
  protected
  end;

var  CxMovForm : TCxMovForm = nil;

procedure ConsultaMovimientos( Edit          : TcxCustomEdit;
                               InitialState : TQueryGridInitialState = qgsNormal;
                               UserSelection : TDataEditEvent = nil );

implementation

{$R *.dfm}

uses SysUtils,
     DateUtils,

     EnterpriseDataAccess,

     Gim00Fields,

     a_mov;

procedure ConsultaMovimientos( Edit          : TcxCustomEdit;
                               InitialState : TQueryGridInitialState = qgsNormal;
                               UserSelection : TDataEditEvent = nil );

var  DateSelection : TDateSelection;
     FechaInicial,
     FechaFinal : TDateTime;

begin

     TCxMovForm.OnUserSelection := UserSelection;

     If   ShiftKey
     then begin
          DateSelection := dsFixed;
          FechaInicial := IncYear( ApplicationContainer.FirstDayOfYearDate, -1 );
          FechaFinal := ApplicationContainer.LastDayOfYearDate;
          end
     else begin
          DateSelection := dsFrom30DaysAgo;
          FechaInicial := 0;
          FechaFinal := 0;
          end;

     CreateQueryForm( TCxMovForm, CxMovForm, Edit, InitialState, DateSelection, FechaInicial, FechaFinal );
end;

procedure TCxMovForm.FormCreate(Sender: TObject);
begin
     SetColumnDecimals( TableViewImporteNeto );
     QueryPanel.OnDataSelected := OnUserSelection;
end;

procedure TCxMovForm.QueryCalcFields(DataSet: TDataSet);
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

procedure TCxMovForm.QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
begin
     If   Column=TableViewImporteNeto
     then Query.RefreshQuery;
end;

procedure TCxMovForm.QueryPanelUserSelection;
begin
     MntMovimientosAlmacen( [ QueryEjercicio.Value, QueryNroOperacion.Value ] );
end;

end.
