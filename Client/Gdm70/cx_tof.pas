
unit cx_tof;

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
  dxSkinsDefaultPainters, cxGroupBox, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, cxDurationEdit;

type
  TCxTofForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryNroOrdenFabricacion: TIntegerField;
    QueryNroProceso: TSmallintField;
    QuerySegmento: TSmallintField;
    QueryCodigoMaquina: TWideStringField;
    QueryFecha: TDateField;
    QueryTurno: TSmallintField;
    QueryTiempo: TLongWordField;
    QueryCodigoArticulo: TWideStringField;
    QueryCodigoClaseA: TWideStringField;
    QueryCodigoClaseB: TWideStringField;
    QueryCodigoClaseC: TWideStringField;
    QueryDescripcion: TWideStringField;
    TableViewNroOrdenFabricacion: TcxGridDBColumn;
    TableViewNroProceso: TcxGridDBColumn;
    TableViewSegmento: TcxGridDBColumn;
    TableViewCodigoMaquina: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    TableViewTurno: TcxGridDBColumn;
    TableViewTiempo: TcxGridDBColumn;
    TableViewCodigoArticulo: TcxGridDBColumn;
    TableViewCodigoClaseA: TcxGridDBColumn;
    TableViewCodigoClaseB: TcxGridDBColumn;
    TableViewCodigoClaseC: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    QueryEjercicio: TSmallintField;
    procedure FormCreate(Sender: TObject);
  private
  protected
  class var
    NroOrden : LongInt;
    NroProceso : SmallInt;
    OnUserSelection : TDataEditEvent;
    SoloTareasPendientes : Boolean;
  public
  end;

var  CxTofForm : TCxTofForm = nil;

procedure ConsultaTareasFabricacion( Ejercicio            : SmallInt;
                                     NroOrden             : LongInt;
                                     NroProceso           : SmallInt;
                                     SoloTareasPendientes : Boolean = False;
                                     UserSelection        : TDataEditEvent = nil );

implementation

{$R *.dfm}

uses   SysUtils,
       LibUtils,

       dm_cls;

procedure ConsultaTareasFabricacion( Ejercicio            : SmallInt;
                                     NroOrden             : LongInt;
                                     NroProceso           : SmallInt;
                                     SoloTareasPendientes : Boolean = False;
                                     UserSelection        : TDataEditEvent = nil );
begin
     TCxTofForm.NroOrden := NroOrden;
     TCxTofForm.NroProceso := NroProceso;
     TCxTofForm.OnUserSelection := UserSelection;
     TCxTofForm.SoloTareasPendientes := SoloTareasPendientes;
     CreateQueryForm( TCxTofForm, CxTofForm, nil, qgsNormal, dsFixed );
end;

procedure TCxTofForm.FormCreate(Sender: TObject);

var  NroOrdenInicial,
     NroOrdenFinal : LongInt;
     NroProcesoInicial,
     NroProcesoFinal : SmallInt;

     SQLCommand,
     SQLWhere : String;

begin
     QueryPanel.OnDataSelected := OnUserSelection;

     Clase.SetupGridColumns( TableViewCodigoClaseA, TableViewCodigoClaseB, TableViewCodigoClaseC, 4 );

     If   NroOrden=0
     then begin
          NroOrdenInicial := 1;
          NroOrdenFinal := MaxLongint;
          end
     else begin
          NroOrdenInicial := NroOrden;
          NroOrdenFinal := NroOrden;
          end;

     If   NroProceso=0
     then begin
          NroProcesoInicial := 1;
          NroProcesoFinal := MaxSmallint;
          end
     else begin
          NroProcesoInicial := NroProceso;
          NroProcesoFinal := NroProceso;
          end;

     SQLCommand := Query.SQL.Text;

     SQLWhere := Format( '( NroOrden BETWEEN %d AND %d ) AND ( NroProceso BETWEEN %d AND %d )',
                         [ NroOrdenInicial, NroOrdenFinal, NroProcesoInicial, NroProcesoFinal ] );

     If   SoloTareasPendientes
     then SQLWhere := SQLWhere + ' AND NOT Realizado ';

     SetSQLVar( SQLCommand, 'Seleccion', SQLWhere );

     Query.SQL.Text := SQLCommand;

end;

end.
