
unit cx_fcg;

interface

uses Forms, AppForms, Classes, Controls,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, dxSkinsCore,
  dxSkinscxPCPainter, cxLookAndFeels, cxLookAndFeelPainters, QueryForm,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator,

  AppManager, cxIntegerEdit, cxTextEdit, dxDateRanges,
  dxScrollbarAnnotations, dxUIAClasses;

type
  TCxFcgForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QuerySerie: TWideStringField;
    QueryFecha: TDateField;
    QueryPropietario: TWideStringField;
    QueryNombre: TWideStringField;
    TableViewFecha: TcxGridDBColumn;
    TableViewPropietario: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    QueryEjercicio: TSmallintField;
    QueryNroEfecto: TSmallintField;
    QueryNroRegistro: TIntegerField;
    TableViewNroRegistro: TcxGridDBColumn;
    QueryImporte: TBCDField;
    TableViewImporte: TcxGridDBColumn;
    QueryNroAsiento: TIntegerField;
    QueryTipoAsiento: TSmallintField;
    TableViewSerieNroFactura: TcxGridDBColumn;
    TableViewNroFactura: TcxGridDBColumn;
    QueryNroFactura: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure QueryPanelUserSelection;
    procedure QueryPanelAfterReadQueryState;
  private
  protected
    class var
    OnUserSelection : TDataEditEvent;
  end;

var  CxFcgForm : TCxFcgForm = nil;

procedure ConsultaFrasRecibidas( LockRangeField  : TField;
                                 Edit            : TcxCustomEdit;
                                 InitialState    : TQueryGridInitialState = qgsNormal;
                                 UserSelection   : TDataEditEvent = nil );

implementation

{$R *.dfm}

uses SysUtils,
     LibUtils,

     Gim10Fields,

     dmi_ast,

     a_fcg,

     dm_fac,
     dm_ast;

procedure ConsultaFrasRecibidas( LockRangeField  : TField;
                                 Edit            : TcxCustomEdit;
                                 InitialState    : TQueryGridInitialState = qgsNormal;
                                 UserSelection   : TDataEditEvent = nil );

begin
     TCxFcgForm.OnUSerSelection := USerSelection;
     CreateQueryForm( TCxFcgForm, CxFcgForm, LockRangeField, Edit, InitialState, dsFrom30DaysAgo );
end;

procedure TCxFcgForm.FormCreate(Sender: TObject);
begin
     // NOTA :  El campo TipoAsiento de la consulta es necesario para vincularla con el TargetTable
     SetColumnDecimals( TableViewImporte );
     QueryPanel.OnDataSelected := OnUserSelection;
end;

procedure TCxFcgForm.QueryCalcFields(DataSet: TDataSet);

var  BaseImponible,
     CuotaIVA,
     CuotaRE,
     ImporteTotal : Decimal;

begin
     If   TableViewImporte.Visible
     then begin
          BaseImponible := 0.0;
          CuotaIVA := 0.0;
          CuotaRE := 0.0;
          ImporteTotal := 0.0;
          If   Asiento.ObtenImportesFactura( QueryEjercicio.Value, QueryNroAsiento.Value, BaseImponible, CuotaIVA, CuotaRE, ImporteTotal )
          then QueryImporte.Value := ImporteTotal;
          end;
end;

procedure TCxFcgForm.QueryPanelAfterReadQueryState;
begin
     TableViewNombre.Visible := not Assigned( QueryPanel.LockedColumn );
end;

procedure TCxFcgForm.QueryPanelColumVisibilityChanged( Column : TcxGridDBColumn );
begin
     If   Query.Active and
          ( Column=TableViewImporte )
     then TableView.DataController.RefreshExternalData;
end;

procedure TCxFcgForm.QueryPanelUserSelection;
begin
     MntFacturasRecibidas( [ taFraRecibida, QueryEjercicio.Value, QueryPropietario.Value, QuerySerie.Value, QueryNroFactura.Value, NroEfectoRegistroFactura ] );
end;

end.
