 unit b_cpa;

interface

uses StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
     cxEdit, DB, cxDBData, nxdb, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
     cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
     DBCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,

     cxCalendar, dxSkinsCore, dxSkinsDefaultPainters,
     dxSkinscxPCPainter, cxContainer, cxGroupBox, cxLookAndFeels, cxNavigator, cxCurrencyEdit,
     cxRichEdit, dxDateRanges, dxScrollbarAnnotations, dxmdaset, cxGridBandedTableView, cxGridDBBandedTableView,

     GridTableViewController,

     LibUtils,

     AppContainer,
     DataManager,
     EnterpriseDataAccess,
     AppForms,
     SessionDataAccess,


     Gim10Fields,
     Gim30Fields,

     dmi_mov, dxUIAClasses;

type
  TUpdateSelectionEvent = procedure( LineList : TList ) of object;

  TBrwCpaForm = class(TgxForm)
    FormManager: TgxFormManager;
    MemDataSource: TDataSource;
    DataPanel: TgxEditPanel;
    Grid: TcxGrid;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    CloseButton: TgBitBtn;
    LineaMovimientoTable: TnxeTable;
    LineaMovimientoTableEjercicio: TSmallintField;
    LineaMovimientoTableNroOperacion: TIntegerField;
    LineaMovimientoTableNroPagina: TSmallintField;
    LineaMovimientoTableNroLinea: TSmallintField;
    LineaMovimientoTableNroRegistro: TUnsignedAutoIncField;
    LineaMovimientoTableCodigoArticulo: TWideStringField;
    LineaMovimientoTableCodigoClaseA: TWideStringField;
    LineaMovimientoTableCodigoClaseB: TWideStringField;
    LineaMovimientoTableCodigoClaseC: TWideStringField;
    LineaMovimientoTableDescripcion: TWideStringField;
    LineaMovimientoTablePrecio: TFloatField;
    LineaMovimientoTableDescuento: TBCDField;
    LineaMovimientoDataSource: TDataSource;
    TableView: TcxGridDBBandedTableView;
    TableViewCodigoArticulo: TcxGridDBBandedColumn;
    TableViewCodigoClaseA: TcxGridDBBandedColumn;
    TableViewCodigoClaseB: TcxGridDBBandedColumn;
    TableViewCodigoClaseC: TcxGridDBBandedColumn;
    TableViewDescripcion: TcxGridDBBandedColumn;
    TableViewPrecioCompra: TcxGridDBBandedColumn;
    TableViewDescuentoCompra: TcxGridDBBandedColumn;
    TableViewMargen: TcxGridDBBandedColumn;
    TableViewPrecioVenta: TcxGridDBBandedColumn;
    TableViewRecargo: TcxGridDBBandedColumn;
    TableViewDescuento: TcxGridDBBandedColumn;
    MemTable: TnxeTable;
    MemTableCodigoArticulo: TStringField;
    MemTableCodigoClaseA: TStringField;
    MemTableCodigoClaseB: TStringField;
    MemTableCodigoClaseC: TStringField;
    MemTableDescripcion: TStringField;
    MemTablePrecioCompra: TFloatField;
    MemTableMargen: TCurrencyField;
    MemTablePrecioVenta: TFloatField;
    MemTableRecargo: TCurrencyField;
    MemTableDescuento: TCurrencyField;
    MemTableDescuentoCompra: TCurrencyField;
    MemTableNroLinea: TSmallintField;
    OkButton: TgBitBtn;
    ArticuloTable: TnxeTable;
    LineaMovimientoTableCantidad: TBCDField;
    BandStyleRepository: TcxStyleRepository;
    CaptionStyle: TcxStyle;
    MemTablePrecioVentaIVA: TFloatField;
    TableViewPrecioVentaIVA: TcxGridDBBandedColumn;
    LineaMovimientoTableFecha: TDateField;
    ActualizarButton: TgBitBtn;
    LineaMovimientoTableFechaAplicacion: TDateField;
    LineaMovimientoTableFechaCaducidad: TDateField;
    LineaMovimientoTableAsignacionOrigen: TSmallintField;
    LineaMovimientoTableTipoMovimientoOrigen: TSmallintField;
    LineaMovimientoTableEjercicioOrigen: TSmallintField;
    LineaMovimientoTableNroOperacionOrigen: TIntegerField;
    LineaMovimientoTableNroRegistroOrigen: TIntegerField;
    LineaMovimientoTableUIDArticulo: TGuidField;
    LineaMovimientoTableLoteFabricacion: TWideStringField;
    LineaMovimientoTableNumeroSerie: TWideStringField;
    LineaMovimientoTableCampoLibre1: TWideStringField;
    LineaMovimientoTableCampoLibre2: TWideStringField;
    LineaMovimientoTableCampoLibre3: TDateField;
    LineaMovimientoTableCampoLibre4: TBCDField;
    LineaMovimientoTableCodigoAlmacen: TWideStringField;
    LineaMovimientoTableUbicacion: TWideStringField;
    LineaMovimientoTableCantidadAjustada: TBCDField;
    LineaMovimientoTableCantidadProcesada: TBCDField;
    LineaMovimientoTableProcesada: TBooleanField;
    LineaMovimientoTablePrecioDivisa: TBCDField;
    LineaMovimientoTableRecargo: TBCDField;
    LineaMovimientoTablePuntoVerde: TBCDField;
    LineaMovimientoTableNroCajas: TBCDField;
    LineaMovimientoTableLargo: TBCDField;
    LineaMovimientoTableAncho: TBCDField;
    LineaMovimientoTableAlto: TBCDField;
    LineaMovimientoTableBultos: TBCDField;
    LineaMovimientoTableImporteRecargo: TBCDField;
    LineaMovimientoTablePorcentajeRecargo: TBCDField;
    LineaMovimientoTableNoCalcularMargen: TBooleanField;
    LineaMovimientoTableTipoLinea: TWideStringField;
    LineaMovimientoTableOferta: TBooleanField;
    LineaMovimientoTablePesoEnvase: TBCDField;
    LineaMovimientoTableTara: TBCDField;
    LineaMovimientoTablePeso: TBCDField;
    LineaMovimientoTableImporteBruto: TBCDField;
    LineaMovimientoTableImporteDescuento: TBCDField;
    LineaMovimientoTableImporteNeto: TBCDField;
    LineaMovimientoTableCodigoTipoIVA: TSmallintField;
    LineaMovimientoTableCuotaIVA: TBCDField;
    LineaMovimientoTableCuotaRE: TBCDField;
    LineaMovimientoTablePrecioIVA: TBCDField;
    LineaMovimientoTableImporteTotal: TBCDField;
    LineaMovimientoTableParametros: TWordField;
    LineaMovimientoTableAnotacion: TWideMemoField;
    LineaMovimientoTableCampoLibre5: TWideStringField;
    LineaMovimientoTableContribucionRAP: TBCDField;
    procedure FormManagerInitializeForm;
    procedure TableViewMargenPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerOkButton;
    procedure FormManagerPreparedForm;
    procedure TableViewPrecioVentaIVAPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure ActualizarButtonClick(Sender: TObject);
  private
    procedure CalculaPreciosVentaLinea( Margen : Decimal );
    procedure ReposicionaEditor( Columna : TcxGridDBBandedColumn );
  protected

  class var
    Ejercicio : SmallInt;
    NroOperacion : LongInt;

  public

    LineaMovimientoFields : TLineaMovimientoFields;
    ArticuloFields : TArticuloFields;
    DsTiposIVAFields : TTiposIVAFields;

  end;


var BrwCpaForm: TBrwCpaForm = nil;

procedure CambioPreciosAlbaranesCompra( Ejercicio      : SmallInt;
                                        NroOperacion   : LongInt );

implementation

{$R *.DFM}

uses   SysUtils,
       Math,
       Variants,

       Gdm00Dm,
       Gim00Fields,

       dm_cls,
       dm_pro,
       dm_cli,
       dm_art,
       dm_mov,
       dm_fdv,

       a_mov,

       b_msg;

resourceString
      RsMsg7  = 'El valor del margen no puede ser igual o superior a 100.0.';
      RsMsg8  = 'Sus margenes se calculan sobre el precio de venta y, por lo tanto, no pueden superar el valor del 100%.'#13'Puede indicar que los márgenes se calculen sobre el precio de compra activando la opción correspondiente [B]Configuración de la aplicación[/B].';

procedure CambioPreciosAlbaranesCompra( Ejercicio      : SmallInt;
                                        NroOperacion   : LongInt );
begin

     TBrwCpaForm.Ejercicio := Ejercicio;
     TBrwCpaForm.NroOperacion := NroOperacion;

     CreateEditForm( TBrwCpaForm, BrwCpaForm );
end;

procedure TBrwCpaForm.ActualizarButtonClick(Sender: TObject);

var  EditColumn : TcxGridDBBandedColumn;

begin
     With MemTable do
       try
         DisableControls;
         First;
         While not Eof do
           begin
           Edit;
           CalculaPreciosVentaLinea( MemTableMargen.Value );
           Post;
           Next;
           end;
       finally
         EnableControls;
         If   TableViewPrecioVenta.Options.Focusing
         then EditColumn := TableViewPrecioVenta
         else EditColumn := TableViewPrecioVentaIVA;
         ReposicionaEditor( EditColumn );
         end;
end;

procedure TBrwCpaForm.FormManagerInitializeForm;
begin

     Clase.SetupGridColumns( TableViewCodigoClaseA, TableViewCodigoClaseB, TableViewCodigoClaseC );

     With DataModule00.DmEmpresaFields do
       begin
       TableViewRecargo.Visible := Ventas_Recargos.Value;
       SetColumnDecimals( TableViewPrecioCompra, Compras_DecPrecio.Value );
       SetColumnDecimals( TableViewDescuentoCompra, Compras_DecDto.Value );
       SetColumnsDecimals( [ TableViewPrecioVenta, TableViewRecargo ], Ventas_DecPrecio.Value );
       SetColumnsDecimals( [ TableViewPrecioVentaIVA, TableViewMargen ] );
       SetColumnDecimals( TableViewDescuento, Ventas_DecDto.Value );

       TableViewPrecioVenta.Options.Editing := not Articulo_PreciosIVA.Value;
       TableViewPrecioVenta.Options.Focusing := not Articulo_PreciosIVA.Value;

       TableViewPrecioVentaIVA.Visible := Articulo_PreciosIVA.Value;
       end;

     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     ArticuloFields := TArticuloFields.Create( ArticuloTable );

     DsTiposIVAFields := TTiposIVAFields.Create( Self );

     // Ejercicio;NroOperacion;NroPagina;NroLinea

     MemTable.Database := SessionDataModule.InMemoryDatabase;
     MemTable.Open;

     MemTable.DisableControls;

     With LineaMovimientoTable do
       begin
       SetRange( [ Ejercicio, NroOperacion ] );
       First;
       While not Eof do
         begin

         If   ( LineaMovimientoFields.Cantidad.Value>0.0 ) and
              ( LineaMovimientoFields.Precio.Value>0.0 ) and
              ArticuloTable.FindKey( [ LineaMovimientoFields.CodigoArticulo.Value ] )
         then begin

              FacturaVentas.ObtenTipoIVAArticulo( LineaMovimientoFields.Fecha.Value, ArticuloFields, DsTiposIVAFields );

              MemTable.Append;

              MemTableNroLinea.Value := LineaMovimientoFields.NroLinea.Value;

              MemTableCodigoArticulo.Value := LineaMovimientoFields.CodigoArticulo.Value;
              MemTableCodigoClaseA.Value := LineaMovimientoFields.CodigoClaseA.Value;
              MemTableCodigoClaseB.Value := LineaMovimientoFields.CodigoClaseB.Value;
              MemTableCodigoClaseC.Value := LineaMovimientoFields.CodigoClaseC.Value;
              MemTableDescripcion.Value := LineaMovimientoFields.Descripcion.Value;
              MemTablePrecioCompra.Value := LineaMovimientoFields.Precio.Value;
              MemTableDescuentoCompra.Value := LineaMovimientoFields.Descuento.Value;

              MemTableMargen.Value := ArticuloFields.MargenComercial.Value;
              MemTablePrecioVenta.Value := ArticuloFields.Precio_Venta.Value;
              If   DataModule00.DmEmpresaFields.Articulo_PreciosIVA.Value
              then MemTablePrecioVentaIVA.Value := Redondea( ArticuloFields.Precio_Venta.Value + Redondea( ArticuloFields.Precio_Venta.Value  * DsTiposIVAFields.IVARepercutido.Value / 100.0 ) );
              MemTableRecargo.Value := ArticuloFields.Recargo_Venta.Value;
              MemTableDescuento.Value := ArticuloFields.Dto_Venta.Value;

              MemTable.Post;
              end;

         Next;
         end;

       end;

     MemTable.EnableControls;
end;

procedure TBrwCpaForm.FormManagerOkButton;
begin
     //
     With MemTable do
       try
         DisableControls;
         First;
         While not Eof do
           begin

           If   ArticuloTable.FindKey( [ MemTableCodigoArticulo.Value ] )
           then begin

                ArticuloTable.Edit;

                ArticuloFields.Precio_Venta.Value := MemTablePrecioVenta.Value;
                ArticuloFields.MargenComercial.Value := MemTableMargen.Value;
                ArticuloFields.Recargo_Venta.Value := MemTableRecargo.Value;
                ArticuloFields.Dto_Venta.Value := MemTableDescuento.Value;

                ArticuloTable.Post;

                end;

           Next;
           end;
       finally
         EnableControls;
         end;

end;

procedure TBrwCpaForm.ReposicionaEditor( Columna : TcxGridDBBandedColumn );
begin
     TableView.Site.SetFocus;
     TableView.Controller.GoToFirst;
     TableView.DataController.Edit;
     TableView.Controller.EditingController.ShowEdit( Columna );
end;

procedure TBrwCpaForm.FormManagerPreparedForm;
begin
     ReposicionaEditor( TableViewMargen );
end;

procedure TBrwCpaForm.CalculaPreciosVentaLinea( Margen : Decimal );
begin
     MemTablePrecioVenta.Value := Articulo.CalculaPrecioSobreMargenCompra( MemTablePrecioCompra.Value, MemTableDescuentoCompra.Value, Margen );
     If   DataModule00.DmEmpresaFields.Articulo_PreciosIVA.Value
     then If   ArticuloTable.FindKey( [ MemTableCodigoArticulo.Value ] )
          then begin
               FacturaVentas.ObtenTipoIVAArticulo( ApplicationContainer.TodayDate, ArticuloFields, DsTiposIVAFields );
               MemTablePrecioVentaIVA.Value := Redondea( MemTablePrecioVenta.Value + Redondea( MemTablePrecioVenta.Value * DsTiposIVAFields.IVARepercutido.Value / 100.0 ) );
               end;
end;

procedure TBrwCpaForm.TableViewMargenPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Margen : Decimal;

begin
     Margen := VarToDecimal( DisplayValue );
     If   ( Margen>=100.0 ) and not DataModule00.DmEmpresaFields.Articulo_MargenSobrePrecioCompra.Value
     then begin
          Error := True;
          ErrorText := JoinMessage( RsMsg7, RsMsg8 );
          end
     else If   not TableViewManager.ValidatingTableView
          then CalculaPreciosVentaLinea( Margen );
end;

procedure TBrwCpaForm.TableViewPrecioVentaIVAPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  PrecioVenta : Double;

begin
     If   DataModule00.DmEmpresaFields.Articulo_PreciosIVA.Value and
          not TableViewManager.ValidatingTableView and
          ( Sender.ModifiedAfterEnter )
     then begin
          Movimiento.ObtenPrecioVentaBase( DsTiposIVAFields, 1, VarAsType( DisplayValue, varDouble ), PrecioVenta, False );
          MemTablePrecioVenta.Value := PrecioVenta
          end;
end;

end.


