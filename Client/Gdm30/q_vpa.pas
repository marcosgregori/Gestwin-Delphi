unit q_vpa;

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

  m_vpa;

type
  TGridVpaForm = class(TgxForm)
    FormManager: TgxFormManager;
    ConsultaTable: TnxeTable;
    QueryGridFrame: TQueryGridFrame;
    ConsultaTablePropietario: TWideStringField;
    ConsultaTablePeriodicidad: TSmallintField;
    ConsultaTableMesPago: TSmallintField;
    ConsultaTableNoAplicar: TBooleanField;
    ConsultaTableUltimaAplicacion: TDateField;
    ConsultaTableRegistroAuxiliar: TWideStringField;
    ConsultaTableNroFicha: TIntegerField;
    ConsultaTableNroRegistro: TSmallintField;
    ConsultaTableCodigoArticulo: TWideStringField;
    ConsultaTableCodigoClaseA: TWideStringField;
    ConsultaTableCodigoClaseB: TWideStringField;
    ConsultaTableCodigoClaseC: TWideStringField;
    ConsultaTableNumeroSerie: TWideStringField;
    ConsultaTableDescripcion: TWideStringField;
    ConsultaTableCantidad: TBCDField;
    ConsultaTablePrecio: TFloatField;
    ConsultaTableRecargo: TBCDField;
    ConsultaTableDescuento: TBCDField;
    ConsultaTableAnotacion: TWideMemoField;
    ConsultaTablePropietarioNombre: TWideStringField;
    ConsultaTableImporteBruto: TBCDField;
    ConsultaTableImporteDescuento: TBCDField;
    ConsultaTableImporteNeto: TBCDField;
    ConsultaTableProcesada: TBooleanField;
    procedure FormManagerInitializeForm;
    procedure FormManagerDestroyForm;
    procedure QueryGridFrameGridViewCustomDrawGroupCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
    procedure QueryGridFrameGridViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private

    procedure DoUserSelection(Sender: TObject; var AHandled : Boolean);

  protected

  class var
    VpaQueryModule : TVpaQueryModule;

  public
    NroFichaColumn,
    CodigoArticuloColumn,
    CodigoClaseAColumn,
    CodigoClaseBColumn,
    CodigoClaseCColumn,
    DescripcionColumn,
    CantidadColumn,
    PrecioColumn,
    RecargoColumn,
    DescuentoColumn,
    PropietarioColumn,
    PropietarioNombreColumn,
    ImporteBrutoColumn,
    DescuentoArticuloColumn,
    ImporteNetoColumn,
    NoAplicarColumn : TcxGridDBColumn;
    DefaultGroupSummaryItem : TcxGridDBTableSummaryItem;

  end;

var  GridVpaForm : TGridVpaForm = nil;

procedure RejillaVentasPeriodicasArticulo( VpaQueryModule : TVpaQueryModule );

implementation

{$R *.dfm}

uses  LibUtils,
      EnterpriseDataAccess,
      SessionDataAccess,

      cxGridCommon,

      Gdm00Dm,

      Gim00Fields,
      Gim30Fields,

      dm_cls,
      dm_cli,

      a_vpe;

resourceString
     RsMsg1  = 'Haga doble <click> con el ratón -o pulse la barra espaciadora-\nsobre una línea para acceder a la ficha de venta periódica.';

procedure RejillaVentasPeriodicasArticulo( VpaQueryModule : TVpaQueryModule );
begin
     TGridVpaForm.VpaQueryModule := VpaQueryModule;
     CreateGridForm( TGridVpaForm, GridVpaForm );
end;

procedure TGridVpaForm.FormManagerDestroyForm;
begin
     GridVpaForm := nil;
end;

procedure TGridVpaForm.FormManagerInitializeForm;
begin

     ID := idGridVpaForm;

     With QueryGridFrame do
       begin

       Grid.Hint := RsMsg1;

       Setup( VpaQueryModule, ConsultaTable );

       NroFichaColumn := CreateColumn( 'NroFicha', 'Nº ficha', 45, { IsVisible } False );
       CodigoArticuloColumn := CreateColumn( 'CodigoArticulo', 'Artículo', 90 );
       CodigoClaseAColumn := CreateColumn( 'CodigoClaseA', '', 25 );
       CodigoClaseBColumn := CreateColumn( 'CodigoClaseB', '', 25 );
       CodigoClaseCColumn := CreateColumn( 'CodigoClaseC', '', 25 );
       DescripcionColumn := CreateColumn( RsDescripcion, 'Descripción', 390, VpaQueryModule.Agrupar=0 );
       PropietarioColumn := CreateColumn( 'Propietario', 'Cliente', 60 );
       PropietarioNombreColumn := CreateColumn( 'PropietarioNombre', 'Nombre', 390, VpaQueryModule.Agrupar=1 );
       CantidadColumn := CreateColumn( 'Cantidad', 'Cantidad', 70 );
       PrecioColumn := CreateColumn( 'Precio', 'Precio', 70, VpaQueryModule.Valorar );
       RecargoColumn := CreateColumn( 'Recargo', 'Recargo', 70, VpaQueryModule.Valorar and DataModule00.DmEmpresaFields.Ventas_Recargos.Value );
       DescuentoColumn := CreateColumn( 'Descuento', '% Dto.', 45, VpaQueryModule.Valorar );
       ImporteBrutoColumn := CreateColumn( 'ImporteBruto', 'Imp. bruto', 90, VpaQueryModule.Valorar );
       DescuentoArticuloColumn := CreateColumn( 'ImporteDescuento', 'Descuento', 90, VpaQueryModule.Valorar );
       ImporteNetoColumn := CreateColumn( 'ImporteNeto', 'Importe', 90, VpaQueryModule.Valorar );
       NoAplicarColumn := CreateColumn( 'NoAplicar', 'N/A', 30 );

       If   VpaQueryModule.Agrupar=0
       then AddGroupsIndex( [ PropietarioColumn ] )
       else AddGroupsIndex( [ CodigoArticuloColumn ] );

       AddDefaultGroupSummaryItems( [ CantidadColumn, ImporteBrutoColumn, ImporteNetoColumn ] );

       With DataModule00.DmEmpresaFields do
         begin
         SetColumnDecimals( CantidadColumn, DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value );
         SetColumnsDecimals( [ PrecioColumn, RecargoColumn ], DataModule00.DmEmpresaFields.Ventas_DecPrecio.Value );
         SetColumnDecimals( DescuentoColumn, 2 );
         SetColumnsDecimals( [ ImporteBrutoColumn, ImporteNetoColumn ] );
         end;

       Clase.SetupGridColumns( CodigoClaseAColumn, CodigoClaseBColumn, CodigoClaseCColumn );

       GridTableViewController.OnUserSelection := DoUserSelection;

       FullExpand;
       end;
end;

procedure TGridVpaForm.QueryGridFrameGridViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                                 ACanvas   : TcxCanvas;
                                                                 AViewInfo : TcxGridTableDataCellViewInfo;
                                                             var ADone     : Boolean );
begin
     If   not AViewInfo.Selected
     then If   VarToBoolean( AViewInfo.GridRecord.Values[ NoAplicarColumn.Index ] )
          then ACanvas.Font.Color := clWebCoral;
end;

procedure TGridVpaForm.QueryGridFrameGridViewCustomDrawGroupCell(     Sender    : TcxCustomGridTableView;
                                                                      ACanvas   : TcxCanvas;
                                                                      AViewInfo : TcxGridTableCellViewInfo;
                                                                  var ADone     : Boolean );
begin
     With AViewInfo do
       If   Text.Contains( 'Artículo :' )
       then Text := 'Articulo : ' +  GridRecord.Values[ CodigoArticuloColumn.Index ] + ' , ' + GridView.DataController.Values[ GridRecord.RecordIndex, DescripcionColumn.Index ]
       else If   Text.Contains( 'Cliente :' )
            then Text := 'Cliente : ' +  GridRecord.Values[ PropietarioColumn.Index ] + ' , ' + GridView.DataController.Values[ GridRecord.RecordIndex, PropietarioNombreColumn.Index ];
end;

procedure TGridVpaForm.DoUserSelection( Sender: TObject; var AHandled : Boolean);
begin
     With QueryGridFrame.GridView.Controller do
       If   Assigned( FocusedRecord )
       then With FocusedRecord do
              MntVentasPeriodicas( [ Values[ NroFichaColumn.Index ] ] );
end;

end.

