
unit cx_hdc;

interface

uses Forms, AppForms, Classes, Controls,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit,

  dm_mov, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  cxLookAndFeelPainters, QueryForm, cxContainer, dxSkinsDefaultPainters,
  cxGroupBox, cxNavigator, dxDateRanges, dxScrollbarAnnotations;

type
  TCxHdcForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryEjercicio: TSmallintField;
    QueryNroHoja: TIntegerField;
    QueryCodigoTransportista: TWideStringField;
    QueryNombre: TWideStringField;
    QueryFecha: TDateField;
    QueryNoProcesar: TBooleanField;
    TableViewNroHoja: TcxGridDBColumn;
    TableViewCodigoTransportista: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    TableViewNoProcesar: TcxGridDBColumn;
  private

  protected
  end;

var  CxHdcForm : TCxHdcForm = nil;

procedure ConsultaHojasCarga( Edit   : TcxCustomEdit;
                              InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses SysUtils,
     DateUtils,
     LibUtils,
     EnterpriseDataAccess,

     Gim00Fields;

procedure ConsultaHojasCarga( Edit   : TcxCustomEdit;
                              InitialState : TQueryGridInitialState = qgsNormal );

var  DateSelection : TDateSelection;
     FechaInicial : TDateTime;
     FechaFinal : TDateTime;

begin
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

     CreateQueryForm( TCxHdcForm, CxHdcForm, Edit, InitialState, DateSelection, FechaInicial, FechaFinal );
end;

end.
