
unit cx_apv;

interface

uses Forms, AppForms, Classes, Controls,

  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit, dxSkinsCore,
  dxSkinscxPCPainter, cxLookAndFeels, cxLookAndFeelPainters, QueryForm,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator,

  LibUtils,
  AppManager,
  AppContainer, dxDateRanges, dxScrollbarAnnotations;

type
  TCxApvForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
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
    QueryNroDocumento: TIntegerField;
    QueryNroOperacion: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
  private
    ImporteBruto,
    DescuentosArticulos,
    ImporteNeto : Decimal;

  protected
    class var Serie : String;
    class var CodigoCliente  : String;
    class var FechaInicial : TDateTime;
    class var FechaFinal : TDateTime;
    class var OnUserSelection : TDataEditEvent;
  end;

var  CxApvForm : TCxApvForm = nil;

procedure ConsultaAlbaranesVentaPendientes( UnaSerie        : String;
                                            UnCodigoCliente : String;
                                            Edit            : TcxCustomEdit;
                                            UserSelection   : TDataEditEvent = nil;
                                            InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses SysUtils,
     EnterpriseDataAccess,

     dm_mov;

procedure ConsultaAlbaranesVentaPendientes( UnaSerie        : String;
                                            UnCodigoCliente : String;
                                            Edit            : TcxCustomEdit;
                                            UserSelection   : TDataEditEvent = nil;
                                            InitialState : TQueryGridInitialState = qgsNormal );
begin
     TCxApvForm.OnUserSelection := UserSelection;
     TCxApvForm.Serie := UnaSerie;
     TCxApvForm.CodigoCliente := UnCodigoCliente;
     CreateQueryForm( TCxApvForm, CxApvForm, Edit, InitialState, dsFrom30DaysAgo);
end;

procedure TCxApvForm.FormCreate(Sender: TObject);
begin
     With Query do
       begin
       Params[ 0 ].Value := CodigoCliente;
       Params[ 1 ].Value := Serie;
       end;

     SetColumnDecimals( TableViewImporteNeto );

     QueryPanel.OnDataSelected := OnUserSelection;
end;

procedure TCxApvForm.QueryCalcFields(DataSet: TDataSet);
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

end.
