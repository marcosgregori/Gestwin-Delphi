
unit cx_tcv;

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
  dxSkinscxPCPainter, cxLookAndFeels, cxLookAndFeelPainters, QueryForm,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type
  TCxTcvForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    GridDBTableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TarifaCantidadVentaTable: TnxeTable;
    QueryCodigoCliente: TWideStringField;
    QueryCodigoArticulo: TWideStringField;
    QueryCodigoClaseA: TWideStringField;
    QueryCodigoClaseB: TWideStringField;
    QueryCodigoClaseC: TWideStringField;
    QueryNroRegistro: TSmallintField;
    QueryCantidadMinima: TBCDField;
    QueryCantidadMaxima: TBCDField;
    QueryDescuento: TBCDField;
    GridDBTableViewNroRegistro: TcxGridDBColumn;
    GridDBTableViewCantidadMinima: TcxGridDBColumn;
    GridDBTableViewCantidadMaxima: TcxGridDBColumn;
    GridDBTableViewPrecio: TcxGridDBColumn;
    GridDBTableViewDescuento: TcxGridDBColumn;
    QueryPrecio: TFloatField;
    procedure QueryBeforeOpen(DataSet: TDataSet);
  private

  protected
    class var
    CodigoCliente,
    CodigoArticulo,
    CodigoClaseA,
    CodigoClaseB,
    CodigoClaseC : String;
    OnUserSelection : TDataEditEvent;
  end;

var  CxTcvForm : TCxTcvForm = nil;

procedure ConsultaTarifaCantidadVentas( Edit           : TcxCustomEdit;
                                        CodigoCliente  : String;
                                        CodigoArticulo : String;
                                        CodigoClaseA,
                                        CodigoClaseB,
                                        CodigoClaseC   : String;
                                        UserSelection  : TDataEditEvent );

implementation

{$R *.dfm}

procedure ConsultaTarifaCantidadVentas( Edit           : TcxCustomEdit;
                                        CodigoCliente  : String;
                                        CodigoArticulo : String;
                                        CodigoClaseA,
                                        CodigoClaseB,
                                        CodigoClaseC   : String;
                                        UserSelection  : TDataEditEvent );

begin

     TCxTcvForm.CodigoCliente := CodigoCliente;
     TCxTcvForm.CodigoArticulo := CodigoArticulo;
     TCxTcvForm.CodigoClaseA := CodigoClaseA;
     TCxTcvForm.CodigoClaseB := CodigoClaseB;
     TCxTcvForm.CodigoClaseC := CodigoClaseC;
     TCxTcvForm.OnUserSelection := UserSelection;

     CreateQueryForm( TCxTcvForm, CxTcvForm, Edit );
end;

procedure TCxTcvForm.QueryBeforeOpen(DataSet: TDataSet);
begin

     If   not TarifaCantidadVentaTable.FindKey( [ CodigoCliente, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, 0 ] )
     then CodigoCliente := '';

     With Query do
       begin
       Params[ 0 ].Value := CodigoCliente;
       Params[ 1 ].Value := CodigoArticulo;
       Params[ 2 ].Value := CodigoClaseA;
       Params[ 3 ].Value := CodigoClaseB;
       Params[ 4 ].Value := CodigoClaseC;
       end;

     QueryPanel.OnDataSelected := OnUserSelection;
end;

end.
