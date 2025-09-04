unit q_cps;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, nxdb, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGrid, Menus, Buttons, ExtCtrls, AppForms, cxGridDBTableView,
  cxCurrencyEdit, cxLookAndFeelPainters, StdCtrls, cxButtons,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxContainer,
  cxGroupBox, cxLookAndFeels, cxNavigator, dxDateRanges, dxBar,

  AppContainer,
  DataManager,
  GridTableViewController,
  QueryGrid,
  m_cps;

type
  TGridCpsForm = class(TgxForm)
    FormManager: TgxFormManager;
    ConsultaTable: TnxeTable;
    ConsultaTableNroRegistro: TLongWordField;
    ConsultaTableCodigoAlmacen: TWideStringField;
    ConsultaTableCodigoArticulo: TWideStringField;
    ConsultaTableCodigoClaseA: TWideStringField;
    ConsultaTableCodigoClaseB: TWideStringField;
    ConsultaTableCodigoClaseC: TWideStringField;
    ConsultaTableDescripcion: TWideStringField;
    ConsultaTableNombreAlmacen: TWideStringField;
    ConsultaTableNroCajas: TBCDField;
    ConsultaTableCantidad: TBCDField;
    ConsultaTablePendiente: TBCDField;
    ConsultaTableParametros: TWordField;
    ConsultaTablePrecio: TFloatField;
    ConsultaTableEcotasa: TBCDField;
    ConsultaTableDescuento: TBCDField;
    ConsultaTableRecargo: TBCDField;
    ConsultaTableEjercicio: TSmallintField;
    ConsultaTableSerie: TWideStringField;
    ConsultaTableNroDocumento: TIntegerField;
    ConsultaTableNroOperacion: TIntegerField;
    ConsultaTableCodigoPropietario: TWideStringField;
    ConsultaTableNombrePropietario: TWideStringField;
    ConsultaTableFechaDocumento: TDateField;
    ConsultaTableFechaAplicacion: TDateField;
    QueryGridFrame: TQueryGridFrame;
    procedure FormManagerInitializeForm;
    procedure FormManagerDestroyForm;
  private

    procedure DoUserSelection(Sender: TObject; var AHandled : Boolean);
  protected
  class var
    CpsQueryModule : TCpsQueryModule;
  public
    NroRegistroColumn,
    CodigoAlmacenColumn,
    NombreAlmacenColumn,
    CodigoArticuloColumn,
    CodigoClaseAColumn,
    CodigoClaseBColumn,
    CodigoClaseCColumn,
    DescripcionColumn,
    CantidadColumn,
    PendienteColumn,
    ParametrosColumn,
    FechaColumn,
    FechaAplicacionColumn : TcxGridDBColumn;
    DefaultGroupSummaryItem : TcxGridDBTableSummaryItem;

  end;

var  GridCpsForm : TGridCpsForm = nil;

procedure RejillaPendienteServir( CpsQueryModule : TCpsQueryModule );

implementation

{$R *.dfm}

uses  EnterpriseDataAccess,
      SessionDataAccess,

      Gdm00Dm,

      Gim00Fields,
      Gim30Fields,

      dm_cls,

      a_mov;

resourceString
     RsMsg1  = 'Haga doble <click> con el ratón -o pulse la barra espaciadora-\nsobre una línea para acceder al pedido de venta.';

procedure RejillaPendienteServir( CpsQueryModule : TCpsQueryModule );
begin
     TGridCpsForm.CpsQueryModule := CpsQueryModule;
     CreateGridForm( TGridCpsForm, GridCpsForm );
end;

procedure TGridCpsForm.FormManagerDestroyForm;
begin
     GridCpsForm := nil;
end;

procedure TGridCpsForm.FormManagerInitializeForm;
begin

     ID := idGridCpsForm;

     With QueryGridFrame do
       begin

       Grid.Hint := RsMsg1;

       Setup( CpsQueryModule, ConsultaTable );

       NroRegistroColumn := CreateColumn( 'NroRegistro', 'Nº registro', 45, False );
       CodigoArticuloColumn := CreateColumn( 'CodigoArticulo', 'Artículo', 90 );
       CodigoClaseAColumn := CreateColumn( 'CodigoClaseA', '', 25 );
       CodigoClaseBColumn := CreateColumn( 'CodigoClaseB', '', 25 );
       CodigoClaseCColumn := CreateColumn( 'CodigoClaseC', '', 25 );
       DescripcionColumn := CreateColumn( RsDescripcion, 'Descripción', 390 );
       CodigoAlmacenColumn := CreateColumn( 'CodigoAlmacen', 'Alm.', 35 );
       CantidadColumn := CreateColumn( 'Cantidad', 'Cantidad', 70 );
       PendienteColumn := CreateColumn( 'Pendiente', 'Pendiente', 70 );
       ParametrosColumn := CreateColumn( 'Parametros', 'Parametros', 110, False );
       FechaColumn := CreateColumn( 'FechaDocumento', 'Fecha', 80 );
       FechaAplicacionColumn := CreateColumn( 'FechaAplicacion', 'Entrega', 80 );

       AddGroupsIndex( [ CodigoAlmacenColumn ] );
       AddDefaultGroupSummaryItems( [ CantidadColumn, PendienteColumn ] );

       SetColumnsDecimals( [ CantidadColumn, PendienteColumn ], DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value );
       SetDefaultGroupSummaryItemsDecimals( GridView,  [ 0, 1 ], DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value );

       Clase.SetupGridColumns( CodigoClaseAColumn, CodigoClaseBColumn, CodigoClaseCColumn );

       GridTableViewController.OnUserSelection := DoUserSelection;

       FullExpand;
       end;
end;

procedure TGridCpsForm.DoUserSelection( Sender: TObject; var AHandled : Boolean);
begin
     With QueryGridFrame.GridView.Controller do
       If   Assigned( FocusedRecord )
       then With FocusedRecord do
              MntMovimientosPorNroRegistro( Values[ NroRegistroColumn.Index ] );
end;

end.

