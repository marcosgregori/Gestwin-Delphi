
unit cx_mdc;

interface

uses Forms, AppForms, Classes, Controls,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit, dxSkinsCore,
  dxSkinscxPCPainter, cxLookAndFeels, cxLookAndFeelPainters, QueryForm,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type
  TCxMdcForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryEjercicio: TSmallintField;
    QuerySerie: TWideStringField;
    QueryNroOperacion: TIntegerField;
    QueryFecha: TDateField;
    QueryOperacion: TWideStringField;
    QueryDescripcion: TWideStringField;
    QueryImporte: TBCDField;
    TableViewNroOperacion: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    TableViewOperacion: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewImporte: TcxGridDBColumn;
    TableViewSerie: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
  protected
    class var
    TodasLasSeries : Boolean;
    Serie : String;
  end;

var  CxMdcForm : TCxMdcForm = nil;

procedure ConsultaMovimientosCaja( TodasLasSeries : Boolean;
                                   Serie          : String;
                                   Edit           : TcxCustomEdit;
                                   InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses LibUtils;

procedure ConsultaMovimientosCaja( TodasLasSeries : Boolean;
                                   Serie          : String;
                                   Edit           : TcxCustomEdit;
                                   InitialState : TQueryGridInitialState = qgsNormal );

begin
     If   ShiftKey
     then TodasLasSeries := True;
     TCxMdcForm.TodasLasSeries := TodasLasSeries;
     TCxMdcForm.Serie := Serie;
     CreateQueryForm( TCxMdcForm, CxMdcForm, Edit, InitialState, dsFrom30DaysAgo );
end;

procedure TCxMdcForm.FormCreate(Sender: TObject);
begin
     With Query do
       begin
       Params[ 0 ].Value := TodasLasSeries;
       Params[ 1 ].Value := Serie;
       end;
     TableViewSerie.Visible := not TodasLasSeries;
end;

end.
