
unit cx_opc;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  EnterpriseDataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCheckBox, QueryForm,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinscxPCPainter,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type

  TTipoOperacion = ( topInterna, topExterna, topAmbas );

  TCxOpcForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryDescripcion: TWideStringField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    QueryOperacionExterna: TBooleanField;
    TableViewOperacionExterna: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure QueryFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
  protected
  class var
    TipoOperacion : TTipoOperacion;
  end;

var  CxOpcForm : TCxOpcForm = nil;

procedure ConsultaOperaciones( TipoOperacion : TTipoOperacion;
                               Edit          : TcxCustomEdit;
                               InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaOperaciones( TipoOperacion : TTipoOperacion;
                               Edit          : TcxCustomEdit;
                               InitialState : TQueryGridInitialState = qgsNormal );
begin
     TCxOpcForm.TipoOperacion := TipoOperacion;
     CreateQueryForm( TCxOpcForm, CxOpcForm, Edit, InitialState );
end;

procedure TCxOpcForm.FormCreate(Sender: TObject);
begin
     TableViewOperacionExterna.Visible := ( TipoOperacion=topAmbas );
end;

procedure TCxOpcForm.QueryFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
     Accept := ( TipoOperacion=topAmbas ) or
               ( ( TipoOperacion=topInterna ) and not QueryOperacionExterna.Value ) or
               ( ( TipoOperacion=topExterna ) and QueryOperacionExterna.Value );
end;

end.
