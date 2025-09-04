unit b_rcp;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes, Windows,
  ExtCtrls, Graphics, ComCtrls,
  AppContainer,
  DataManager,
  dm_art, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,

  Gim30Fields, cxLabel, cxDBLabel, dxSkinsCore, dxSkinscxPCPainter,
  cxLookAndFeels, dxSkinsDefaultPainters, cxGroupBox, cxNavigator, dxBar,
  dxDateRanges, AppForms, GridTableViewController, dxScrollbarAnnotations,
  dxUIAClasses;

type
  TBrwRcpForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    ProveedorTable: TnxeTable;
    ProveedorDataSource: TDataSource;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    ConsumoComprasDataSource: TDataSource;
    GridTableViewController: TGridTableViewController;
    GridViewFamiliaArticulo: TcxGridDBColumn;
    GridViewCodigoClaseA: TcxGridDBColumn;
    GridViewCodigoClaseB: TcxGridDBColumn;
    GridViewCodigoClaseC: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewTotalUnidades: TcxGridDBColumn;
    GridViewTotalImporte: TcxGridDBColumn;
    GridViewPrecioMedio: TcxGridDBColumn;
    ProveedorTableCodigo: TWideStringField;
    ProveedorTableNombre: TWideStringField;
    cxDBLabel1: TcxDBLabel;
    ConsumoComprasQuery: TnxeQuery;
    ConsumoComprasQueryEjercicio: TSmallintField;
    ConsumoComprasQueryFamiliaArticulo: TWideStringField;
    ConsumoComprasQueryCodigoClaseA: TWideStringField;
    ConsumoComprasQueryCodigoClaseB: TWideStringField;
    ConsumoComprasQueryCodigoClaseC: TWideStringField;
    ConsumoComprasQueryDescripcion: TWideStringField;
    ConsumoComprasQueryTotalUnidades: TBCDField;
    ConsumoComprasQueryTotalImporte: TBCDField;
    ConsumoComprasQueryPrecioMedio: TBCDField;
    GridViewEjercicio: TcxGridDBColumn;
    Label10: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    dxBarManager1: TdxBarManager;
    PopupMenu: TdxBarPopupMenu;
    FichaArticuloItem: TdxBarButton;
    procedure FormManagerInitializeForm;
    procedure FichaArticuloItemClick(Sender: TObject);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ConsumoComprasQueryCalcFields(DataSet: TDataSet);
    procedure GridTableViewControllerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure ProveedorTableUpdateState(DataSet: TDataSet);
    procedure FormManagerReportRequest;
    procedure ProveedorTableGetRecord(DataSet: TDataSet);
  private

  public

    ConsumoAcumulado : TConsumoAcumulado;

    procedure FichaArticulo;
  end;

var  BrwRcpForm: TBrwRcpForm = nil;

procedure RelacionConsumoProveedores( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,

       dm_pro,
       dm_cls,
       dm_sto,
       dm_sec,

       a_pro,
       a_art,

       cx_pro,

       l_cap;

procedure RelacionConsumoProveedores( KeyValues : array of const );
begin
     CreateEditForm( TBrwRcpForm, BrwRcpForm, KeyValues );
end;

procedure TBrwRcpForm.FormManagerInitializeForm;
begin

     Clase.SetupGridColumns( GridViewCodigoClaseA, GridViewCodigoClaseB, GridViewCodigoClaseC, 4 );

     With DataModule00.DmEmpresaFields do
       begin
       SetColumnDecimals( GridViewTotalUnidades, Compras_DecCantidad.Value );
       SetColumnsDecimals( [ GridViewTotalImporte, GridViewPrecioMedio ], Compras_DecPrecio.Value );
       end;
end;

procedure TBrwRcpForm.FormManagerReportRequest;
begin
     ListadoConsumoProveedores;
end;

procedure TBrwRcpForm.GridTableViewControllerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     FichaArticulo;
end;

procedure TBrwRcpForm.ConsumoComprasQueryCalcFields(DataSet: TDataSet);
begin
     If   ConsumoComprasQueryTotalUnidades.Value<>0.0
     then ConsumoComprasQueryPrecioMedio.Value := ConsumoComprasQueryTotalImporte.Value / ConsumoComprasQueryTotalUnidades.Value
     else ConsumoComprasQueryPrecioMedio.Value := 0.0;
end;

procedure TBrwRcpForm.ProveedorTableGetRecord(DataSet: TDataSet);
begin
     ConsumoComprasQuery.ExecSQLFields( 'SELECT Ejercicio, FamiliaArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, Articulo.Descripcion,' +
                                        '( Unidades_Enero + Unidades_Febrero + Unidades_Marzo + Unidades_Abril + Unidades_Mayo + Unidades_Junio + Unidades_Julio + Unidades_Agosto + Unidades_Septiembre + Unidades_Octubre + Unidades_Noviembre + Unidades_Diciembre ) AS TotalUnidades, ' +
                                        '( Importe_Enero + Importe_Febrero + Importe_Marzo + Importe_Abril + Importe_Mayo + Importe_Junio + Importe_Julio + Importe_Agosto + Importe_Septiembre + Importe_Octubre + Importe_Noviembre + Importe_Diciembre ) AS TotalImporte ' +
                                        'FROM ConsumoCompras LEFT JOIN Articulo ON ( Articulo.Codigo=ConsumoCompras.FamiliaArticulo ) ' +
                                        'WHERE Proveedor=? AND Tipo=2 ' +
                                        'ORDER BY Ejercicio DESC, FamiliaArticulo',
                                        [ ProveedorTableCodigo ] );
     GridView.ViewData.Expand( True );
end;

procedure TBrwRcpForm.ProveedorTableUpdateState(DataSet: TDataSet);
begin
     ConsumoComprasDataSource.Enabled := ProveedorTable.State in [ dsBrowse, dsEdit ];
end;

procedure TBrwRcpForm.CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TBrwRcpForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TBrwRcpForm.FichaArticuloItemClick(Sender: TObject);
begin
     FichaArticulo;
end;

procedure TBrwRcpForm.FichaArticulo;
begin
     MntArticulos( [ ConsumoComprasQueryFamiliaArticulo.Value ] );
end;

end.

