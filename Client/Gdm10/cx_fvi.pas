
unit cx_fvi;

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

  AppManager, dxDateRanges, dxScrollbarAnnotations;

type
  TCxFviForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QuerySerie: TWideStringField;
    QueryNroFactura: TIntegerField;
    QueryFecha: TDateField;
    QueryPropietario: TWideStringField;
    QueryNombre: TWideStringField;
    TableViewSerie: TcxGridDBColumn;
    TableViewNroFactura: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    TableViewPropietario: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    QueryTipoAsiento: TSmallintField;
    QueryEjercicio: TSmallintField;
    QueryNroEfecto: TSmallintField;
    QueryNroAsiento: TIntegerField;
    QueryImporte: TBCDField;
    TableViewImporte: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
    procedure QueryPanelUserSelection;
  private
  protected
    class var
    Propietario : String;
    OnUserSelection : TDataEditEvent;
  end;

var  CxFviForm : TCxFviForm = nil;

procedure ConsultaFrasEmitidas( LockRangeField : TField;
                                Edit           : TcxCustomEdit;
                                InitialState   : TQueryGridInitialState = qgsNormal;
                                UserSelection  : TDataEditEvent = nil;
                                Propietario    : String = '' );

implementation

{$R *.dfm}

uses LibUtils,

     Gim10Fields,

     a_fvi,

     dmi_ast,
     dm_ast;


procedure ConsultaFrasEmitidas( LockRangeField : TField;
                                Edit           : TcxCustomEdit;
                                InitialState   : TQueryGridInitialState = qgsNormal;
                                UserSelection  : TDataEditEvent = nil;
                                Propietario    : String = '' );

begin
     TCxFviForm.Propietario := Propietario;
     TCxFviForm.OnUserSelection := UserSelection;
     CreateQueryForm( TCxFviForm, CxFviForm, LockRangeField, Edit, InitialState, dsFrom30DaysAgo );
end;

procedure TCxFviForm.FormCreate( Sender : TObject );
begin

     // NOTA :  El campo TipoAsiento de la consulta es necesario para vincularla con el TargetTable

     With Query do
       begin
       Params[ 0 ].Value := Propietario='';
       Params[ 1 ].Value := Propietario;
       end;

     SetColumnDecimals( TableViewImporte );

     QueryPanel.OnDataSelected := OnUserSelection;
end;

procedure TCxFviForm.QueryCalcFields(DataSet: TDataSet);

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

procedure TCxFviForm.QueryPanelColumVisibilityChanged( Column: TcxGridDBColumn);
begin
      If   Query.Active and
           ( Column=TableViewImporte )
     then TableView.DataController.RefreshExternalData;
end;

procedure TCxFviForm.QueryPanelUserSelection;
begin
     MntFacturasEmitidas( [ taFraEmitida, QueryEjercicio.Value, QuerySerie.Value, QueryNroFactura.Value, NroEfectoRegistroFactura ] );
end;

end.
