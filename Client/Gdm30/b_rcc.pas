unit b_rcc;

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

  Gim30Fields, cxLabel, cxDBLabel, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLookAndFeels, cxGroupBox, cxNavigator, dxBar,
  dxDateRanges, AppForms, GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations, dxUIAClasses;

type
  TBrwRccForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    ClienteTable: TnxeTable;
    ClienteDataSource: TDataSource;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    ConsumoVentasDataSource: TDataSource;
    GridTableViewController: TGridTableViewController;
    GridViewFamiliaArticulo: TcxGridDBColumn;
    GridViewCodigoClaseA: TcxGridDBColumn;
    GridViewCodigoClaseB: TcxGridDBColumn;
    GridViewCodigoClaseC: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewTotalUnidades: TcxGridDBColumn;
    GridViewTotalImporte: TcxGridDBColumn;
    GridViewPrecioMedio: TcxGridDBColumn;
    ClienteTableCodigo: TWideStringField;
    ClienteTableNombre: TWideStringField;
    NombreClienteLabel: TcxDBLabel;
    ConsumoVentasQuery: TnxeQuery;
    ConsumoVentasQueryEjercicio: TSmallintField;
    ConsumoVentasQueryFamiliaArticulo: TWideStringField;
    ConsumoVentasQueryCodigoClaseA: TWideStringField;
    ConsumoVentasQueryCodigoClaseB: TWideStringField;
    ConsumoVentasQueryCodigoClaseC: TWideStringField;
    ConsumoVentasQueryDescripcion: TWideStringField;
    ConsumoVentasQueryTotalUnidades: TBCDField;
    ConsumoVentasQueryTotalImporte: TBCDField;
    ConsumoVentasQueryPrecioMedio: TBCDField;
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
    procedure ConsumoVentasQueryCalcFields(DataSet: TDataSet);
    procedure GridTableViewControllerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure ClienteTableUpdateState(DataSet: TDataSet);
    procedure FormManagerReportRequest;
    procedure ClienteTableGetRecord(DataSet: TDataSet);
  private

  public

    ConsumoAcumulado : TConsumoAcumulado;

    procedure FichaArticulo;
  end;

var  BrwRccForm: TBrwRccForm = nil;

procedure RelacionConsumoClientes( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,

       EnterpriseDataAccess,
       Gdm00Dm,

       dm_cli,
       dm_cls,
       dm_sto,
       dm_sec,

       a_cli,
       a_art,

       cx_cli,

       l_ccl;

procedure RelacionConsumoClientes( KeyValues : array of const );
begin
     CreateEditForm( TBrwRccForm, BrwRccForm, KeyValues );
end;

procedure TBrwRccForm.FormManagerInitializeForm;
begin

     Clase.SetupGridColumns( GridViewCodigoClaseA, GridViewCodigoClaseB, GridViewCodigoClaseC, 4 );

     With DataModule00.DmEmpresaFields do
       begin
       SetColumnDecimals( GridViewTotalUnidades, Ventas_DecCantidad.Value );
       SetColumnsDecimals( [ GridViewTotalImporte, GridViewPrecioMedio ], Ventas_DecPrecio.Value );
       end;

end;

procedure TBrwRccForm.FormManagerReportRequest;
begin
     ListadoConsumoClientes;
end;

procedure TBrwRccForm.GridTableViewControllerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     FichaArticulo;
end;

procedure TBrwRccForm.ConsumoVentasQueryCalcFields(DataSet: TDataSet);
begin
     If   ConsumoVentasQueryTotalUnidades.Value=0.0
     then ConsumoVentasQueryPrecioMedio.Value := 0.0
     else ConsumoVentasQueryPrecioMedio.Value := ConsumoVentasQueryTotalImporte.Value / ConsumoVentasQueryTotalUnidades.Value;
end;

procedure TBrwRccForm.ClienteTableGetRecord(DataSet: TDataSet);
begin
     ConsumoVentasQuery.ExecSQLFields( 'SELECT Ejercicio, FamiliaArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, Articulo.Descripcion,' +
                                       '( Unidades_Enero + Unidades_Febrero + Unidades_Marzo + Unidades_Abril + Unidades_Mayo + Unidades_Junio + Unidades_Julio + Unidades_Agosto + Unidades_Septiembre + Unidades_Octubre + Unidades_Noviembre + Unidades_Diciembre ) AS TotalUnidades, ' +
                                       '( Importe_Enero + Importe_Febrero + Importe_Marzo + Importe_Abril + Importe_Mayo + Importe_Junio + Importe_Julio + Importe_Agosto + Importe_Septiembre + Importe_Octubre + Importe_Noviembre + Importe_Diciembre ) AS TotalImporte ' +
                                       'FROM ConsumoVentas LEFT JOIN Articulo ON ( Articulo.Codigo=ConsumoVentas.FamiliaArticulo ) ' +
                                       'WHERE Cliente=? AND Tipo=2 ' +
                                       'ORDER BY Ejercicio DESC, FamiliaArticulo',
                                       [ ClienteTableCodigo ] );
     GridView.ViewData.Expand( True );
end;

procedure TBrwRccForm.ClienteTableUpdateState(DataSet: TDataSet);
begin
     ConsumoVentasDataSource.Enabled := ClienteTable.State in [ dsBrowse, dsEdit ];
end;

procedure TBrwRccForm.CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TBrwRccForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TBrwRccForm.FichaArticuloItemClick(Sender: TObject);
begin
     FichaArticulo;
end;

procedure TBrwRccForm.FichaArticulo;
begin
     MntArticulos( [ ConsumoVentasQueryFamiliaArticulo.Value ] );
end;

end.

