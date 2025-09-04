
unit cx_odf;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  EnterpriseDataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, QueryForm, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinscxPCPainter, cxContainer,
  dxSkinsDefaultPainters, cxGroupBox, cxNavigator, dxDateRanges, cxTextEdit,
  dxScrollbarAnnotations;

type
  TCxOdfForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryEjercicio: TSmallintField;
    QueryNroOrden: TIntegerField;
    QueryCodigoArticulo: TWideStringField;
    QueryDescripcion: TWideStringField;
    QueryFechaInicio: TDateField;
    QueryFechaFinalizacion: TDateField;
    QueryNroPedido: TIntegerField;
    QueryPropietario: TWideStringField;
    QueryNombre: TWideStringField;
    TableViewNroOrden: TcxGridDBColumn;
    TableViewCodigoArticulo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewFechaInicio: TcxGridDBColumn;
    TableViewFechaFinalizacion: TcxGridDBColumn;
    TableViewNroPedido: TcxGridDBColumn;
    TableViewPropietario: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewEjercicio: TcxGridDBColumn;
    QueryCodigoClaseA: TWideStringField;
    QueryCodigoClaseB: TWideStringField;
    QueryCodigoClaseC: TWideStringField;
    QueryLote: TWideStringField;
    TableViewCodigoClaseA: TcxGridDBColumn;
    TableViewCodigoClaseB: TcxGridDBColumn;
    TableViewCodigoClaseC: TcxGridDBColumn;
    TableViewLote: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
  protected
  class var
    OnUserSelection : TDataEditEvent;
  public
  end;

var  CxOdfForm : TCxOdfForm = nil;

procedure ConsultaOrdenesFabricacion( Ejercicio     : SmallInt;
                                      Edit          : TcxCustomEdit;
                                      InitialState : TQueryGridInitialState = qgsNormal;
                                      UserSelection : TDataEditEvent = nil );

implementation

{$R *.dfm}

uses   SysUtils,

       dm_clp;  // Clases en producción

procedure ConsultaOrdenesFabricacion( Ejercicio     : SmallInt;
                                      Edit          : TcxCustomEdit;
                                      InitialState : TQueryGridInitialState = qgsNormal;
                                      UserSelection : TDataEditEvent = nil );

var  FechaInicial,
     FechaFinal : TDateTime;

begin
     TCxOdfForm.OnUserSelection := UserSelection;

     If   Ejercicio=0
     then Ejercicio := ApplicationContainer.Ejercicio;

     FechaInicial := EncodeDate( Ejercicio, 1, 1 );
     FechaFinal := EncodeDate( Ejercicio, 12, 31 );
     CreateQueryForm( TcxOdfForm, CxOdfForm, Edit, InitialState, dsFixed, FechaInicial, FechaFinal );
end;

procedure TCxOdfForm.FormCreate(Sender: TObject);
begin
     ClaseProduccion.SetupGridColumns( TableViewCodigoClaseA, TableViewCodigoClaseB, TableViewCodigoClaseC, 4 );
     QueryPanel.OnDataSelected := OnUserSelection;
end;

end.
