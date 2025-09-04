unit q_cpr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, nxdb, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGrid, Menus, Buttons, ExtCtrls, AppForms, cxGridDBTableView,
  cxCurrencyEdit, cxLookAndFeelPainters, StdCtrls, cxButtons, AppContainer,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxContainer,
  cxGroupBox, DataManager, cxLookAndFeels, QueryGrid,

  m_cpr, cxNavigator, dxDateRanges, dxBar, GridTableViewController;

type
  TGridCprForm = class(TgxForm)
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
  private
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
      FechaColumn,
      FechaAplicacionColumn : TcxGridDBColumn;
      DefaultGroupSummaryItem : TcxGridDBTableSummaryItem;

      procedure DoUserSelection(Sender: TObject; var AHandled : Boolean);

  protected
  class var
    CprQueryModule : TCprQueryModule;
  public

  end;

procedure RejillaPendienteRecibir( CprQueryModule : TCprQueryModule );

implementation

{$R *.dfm}

uses  EnterpriseDataAccess,

      Gdm00Dm,
      Gim00Fields,

      dm_cls,

      l_cpr,
      a_mov;

resourceString
     RsMsg1  = 'Haga doble <click> con el ratón -o pulse la barra espaciadora-\nsobre una línea para acceder al pedido de compra.';

procedure RejillaPendienteRecibir( CprQueryModule : TCprQueryModule );
begin
     TGridCprForm.CprQueryModule := CprQueryModule;
     CreateGridForm( TGridCprForm );
end;

procedure TGridCprForm.FormManagerInitializeForm;
begin

     With QueryGridFrame do
       begin

       Grid.Hint := RsMsg1;

       Setup( CprQueryModule, ConsultaTable );

       NroRegistroColumn := CreateColumn( 'NroRegistro', 'Nº registro', 45, False );
       CodigoArticuloColumn := CreateColumn( 'CodigoArticulo', 'Artículo', 90 );
       CodigoClaseAColumn := CreateColumn( 'CodigoClaseA', '', 25 );
       CodigoClaseBColumn := CreateColumn( 'CodigoClaseB', '', 25 );
       CodigoClaseCColumn := CreateColumn( 'CodigoClaseC', '', 25 );
       DescripcionColumn := CreateColumn( RsDescripcion, 'Descripción', 390 );
       CodigoAlmacenColumn := CreateColumn( 'CodigoAlmacen', 'Alm.', 35 );
       CantidadColumn := CreateColumn( 'Cantidad', 'Cantidad', 70 );
       PendienteColumn := CreateColumn( 'Pendiente', 'Pendiente', 70 );
       FechaColumn := CreateColumn( 'FechaDocumento', 'Fecha', 80 );
       FechaAplicacionColumn := CreateColumn( 'FechaAplicacion', 'Recepción', 80 );

       AddGroupsIndex( [ CodigoAlmacenColumn ] );
       AddDefaultGroupSummaryItems( CantidadColumn );

       SetColumnsDecimals( [ CantidadColumn, PendienteColumn ], DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value );
       Clase.SetupGridColumns( CodigoClaseAColumn, CodigoClaseBColumn, CodigoClaseCColumn );

       GridTableViewController.OnUserSelection := DoUserSelection;

       FullExpand;
       end;
end;

procedure TGridCprForm.DoUserSelection( Sender: TObject; var AHandled : Boolean);
begin
     With QueryGridFrame.GridView.Controller do
       If   Assigned( FocusedRecord )
       then With FocusedRecord do
              MntMovimientosPorNroRegistro( Values[ NroRegistroColumn.Index ] );
end;

end.
