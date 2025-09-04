
unit cx_tdv;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppManager,
  AppContainer,
  EnterpriseDataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels,
  cxLookAndFeelPainters, QueryForm, cxContainer, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type
  TCxTdvForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TarifaCantidadVentaTable: TnxeTable;
    QueryCodigoTarifa: TWideStringField;
    QueryRecargo: TBCDField;
    QueryDescuento: TBCDField;
    QueryDescripcion: TWideStringField;
    TableViewCodigoTarifa: TcxGridDBColumn;
    TableViewPrecio: TcxGridDBColumn;
    TableViewRecargo: TcxGridDBColumn;
    TableViewDescuento: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    QueryPrecio: TFloatField;
    procedure FormCreate(Sender: TObject);
  private

  protected
    class var
    CodigoArticulo : String;
    OnUserSelection : TDataEditEvent;
  end;

var  CxTdvForm : TCxTdvForm = nil;

procedure ConsultaTarifasVenta( Edit           : TcxCustomEdit;
                                CodigoArticulo : String;
                                UserSelection  : TDataEditEvent );

implementation

uses  Gdm00Dm,
      Gim00Fields;

{$R *.dfm}

procedure ConsultaTarifasVenta( Edit           : TcxCustomEdit;
                                CodigoArticulo : String;
                                UserSelection  : TDataEditEvent );

begin
     TCxTdvForm.CodigoArticulo := CodigoArticulo;
     TCxTdvForm.OnUserSelection := UserSelection;
     CreateQueryForm( TCxTdvForm, CxTdvForm, Edit );
end;

procedure TCxTdvForm.FormCreate(Sender: TObject);
begin
     With DataModule00.DmEmpresaFields do
       begin
       SetColumnsDecimals( [ TableViewPrecio, TableViewrecargo ], Ventas_DecPrecio.Value );
       SetColumnDecimals( TableViewDescuento, Ventas_DecDto.Value );
       end;

     Query.Params[ 0 ].Value := CodigoArticulo;
     QueryPanel.OnDataSelected := OnUserSelection;
end;

end.
