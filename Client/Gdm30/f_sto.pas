unit f_sto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB,
  cxGridCustomView, cxGridDBTableView, cxGridDBBandedTableView, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinsDefaultPainters, cxLabel, cxGroupBox, dxUIAClasses,

  Gim30Fields,

  GridTableViewController,

  AppContainer,

  dmi_sto,

  dm_sto;

type
  TStockFrame = class(TFrame)
    DataPanel: TcxGroupBox;
    ultimoPrecioVentaLabel: TcxLabel;
    Label1: TcxLabel;
    VirtualLabel: TcxLabel;
    pendienteServirLabel: TcxLabel;
    ExistenciasLabel: TcxLabel;
    fechaUltSalidaLabel: TcxLabel;
    costeUltEntradaLabel: TcxLabel;
    fechaUltEntradaLabel: TcxLabel;
    Label22: TcxLabel;
    Label21: TcxLabel;
    Label20: TcxLabel;
    Label19: TcxLabel;
    Label18: TcxLabel;
    Label16: TcxLabel;
    Label15: TcxLabel;
    pendienteRecibirLabel: TcxLabel;
    StockPanel: TcxGroupBox;
  private
    FSeccion : TSeccionComercial;
    FMostrarConsumosCliente : Boolean;
    FGridView : TcxCustomGridView;

    FCodigoArticulo,
    FCodigoClaseA,
    FCodigoClaseB,
    FCodigoClaseC,
    FCodigoAlmacen,
    FCodigoUbicacion : String;

  public
    procedure Actualiza( var ExistenciasArticulo : IExistenciasArticulo; CodigoPropietario : String );
  end;

function CreaPanelStock( Seccion            : TSeccionComercial;
                         ParentContainer    : TCustomControl;
                         GridView           : TcxCustomGridView ) : TStockFrame;

procedure ObtenyMuestraExistencias(     GridView                : TcxGridDBTableView;
                                        GridTableViewController : TGridTableViewController;
                                        LineaMovimientoFields   : TLineaMovimientoFields;
                                    var ExistenciasArticulo     : IExistenciasArticulo;
                                        CodigoCliente           : String = '';
                                        StockFrame              : TStockFrame = nil );

implementation

uses Math,
     LibUtils,

     Gdm00Dm,
     Gim00Fields,

     dm_rcl,
     dm_fdv,
     dm_art,
     dm_alm;

{$R *.dfm}

function CreaPanelStock( Seccion            : TSeccionComercial;
                         ParentContainer    : TCustomControl;
                         GridView           : TcxCustomGridView ) : TStockFrame;
begin
     var StockFrame := TStockFrame.Create( ParentContainer.Owner );
     If   Assigned( StockFrame )
     then With StockFrame do
            begin

            StockPanel.Parent := ParentContainer;
            StockPanel.Top  := 0;
            StockPanel.Left := ParentContainer.Width - Width;
            StockPanel.Height := ParentContainer.Height;
            StockPanel.Align := alNone;
            StockPanel.Anchors := [ akRight, akTop, akBottom ];

            FSeccion := Seccion;
            FMostrarConsumosCliente := ( FSeccion=scVentas ) and ApplicationContainer.IsModuleActive( [ 60 ] );  // Pre-Autoventa
            FGridView := GridView;

            If   DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value or FMostrarConsumosCliente
            then begin
                 Label16.Visible := False;
                 CosteUltEntradaLabel.Visible := False;
                 end;

            end;
     Result := StockFrame;
end;

procedure TStockFrame.Actualiza( var ExistenciasArticulo : IExistenciasArticulo;
                                     CodigoPropietario   : String );

var ImporteBruto,
    DescuentoArticulo,
    ImporteNeto : Decimal;
    IsVisible : Boolean;

procedure LimpiaFicha;
begin
     PendienteRecibirLabel.Caption := '';
     ExistenciasLabel.Caption := '';
     PendienteServirLabel.Caption := '';
     VirtualLabel.Caption := '';
     FechaUltEntradaLabel.Caption := '';
     CosteUltEntradaLabel.Caption := '';
     UltimoPrecioVentaLabel.Caption := '';
     FechaUltSalidaLabel.Caption := '';

     FCodigoArticulo := '';  // Para resetarlo
end;

begin

     IsVisible := FGridView.Site.IsFocused and Assigned( ExistenciasArticulo );
     If   FGridView is TcxGridDBTableView
     then IsVisible := IsVisible and TcxGridDBTableView( FGridView ).Controller.IsEditing
     else If   FGridView is TcxGridDBBandedTableView
          then IsVisible := IsVisible and TcxGridDBBandedTableView( FGridView ).Controller.IsEditing;

     StockPanel.Visible := IsVisible;
     StockPanel.Left := StockPanel.Parent.Width - StockPanel.Width;

     If   IsVisible and Assigned( ExistenciasArticulo )
     then With DataModule00.DmEmpresaFields do
            begin

            BringToFront;

            PendienteRecibirLabel.Caption := StrFormat( ExistenciasArticulo.SumaExistencias.PendienteRecibir, Ventas_DecCantidad.Value );
            ExistenciasLabel.Caption := StrFormat( ExistenciasArticulo.SumaExistencias.Saldo, Ventas_DecCantidad.Value );
            PendienteServirLabel.Caption := StrFormat( ExistenciasArticulo.SumaExistencias.PendienteServir, Ventas_DecCantidad.Value );
            VirtualLabel.Caption := StrFormat( ExistenciasArticulo.SumaExistencias.PendienteRecibir + ExistenciasArticulo.SumaExistencias.Saldo - ExistenciasArticulo.SumaExistencias.PendienteServir, Ventas_DecCantidad.Value );

            If   FMostrarConsumosCliente
            then With RelacionesCliente do
                   begin
                   If   DmConsumosClienteTable.FindKey( [ CodigoPropietario, ExistenciasArticulo.CodigoArticulo, ExistenciasArticulo.CodigoClaseA, ExistenciasArticulo.CodigoClaseB, ExistenciasArticulo.CodigoClaseC ] )
                   then begin

                        If   ConsumosClienteFields.Cantidad.Value<>0.0
                        then begin
                             FacturaVentas.CalculaImportes( ConsumosClienteFields.Cantidad.Value,
                                                            ExistenciasArticulo.UnidadesPrecioVenta,
                                                            ConsumosClienteFields.Precio.Value,
                                                            ConsumosClienteFields.PuntoVerde.Value,
                                                            ConsumosClienteFields.ContribucionRAP.Value,
                                                            ConsumosClienteFields.Recargo.Value,
                                                            ConsumosClienteFields.Descuento.Value,
                                                            ImporteBruto,
                                                            DescuentoArticulo,
                                                            ImporteNeto );

                             UltimoPrecioVentaLabel.Caption := StrFormat( ImporteNeto / ConsumosClienteFields.Cantidad.Value, Min( Ventas_DecPrecio.Value, 4 ) );
                             FechaUltSalidaLabel.Caption := StrFormatDate( ConsumosClienteFields.Fecha.Value, dfDefault );
                             end;

                        end
                   else begin
                        UltimoPrecioVentaLabel.Caption := '';
                        FechaUltSalidaLabel.Caption := '';
                        end;
                   end
            else With ExistenciasArticulo do
                   begin
                   FechaUltEntradaLabel.Caption := StrFormatDate( FechaUltEntrada, dfDefault );
                   CosteUltEntradaLabel.Caption := StrFormat( CosteUltEntrada, Compras_DecPrecio.Value );
                   UltimoPrecioVentaLabel.Caption := StrFormat( PrecioUltSalida, Min( Ventas_DecPrecio.Value, 4 ) );
                   FechaUltSalidaLabel.Caption := StrFormatDate( FechaUltSalida, dfDefault );
                   end;

            end
     else LimpiaFicha;

end;

procedure ObtenyMuestraExistencias(     GridView                : TcxGridDBTableView;
                                        GridTableViewController : TGridTableViewController;
                                        LineaMovimientoFields   : TLineaMovimientoFields;
                                    var ExistenciasArticulo     : IExistenciasArticulo;
                                        CodigoCliente           : String = '';
                                        StockFrame              : TStockFrame = nil );

var  ExistenciasPorLote,
     TodasLasUbicaciones : Boolean;

begin

     If   Assigned( LineaMovimientoFields )
     then With LineaMovimientoFields do
            begin

            If   ( CodigoArticulo.Value='' ) or
                 ( CodigoArticulo.Value=ArticuloManual ) or
                 ( not GridTableViewController.ValidatingTableView and not GridView.Controller.IsEditing )
            then begin
                 If   Assigned( ExistenciasArticulo )
                 then ExistenciasArticulo.Clear;
                 end
            else If  not Assigned( ExistenciasArticulo ) or
                     ( ExistenciasArticulo.CodigoArticulo<>CodigoArticulo.Value ) or
                     ( ExistenciasArticulo.CodigoClaseA<>CodigoClaseA.Value ) or
                     ( ExistenciasArticulo.CodigoClaseB<>CodigoClaseB.Value ) or
                     ( ExistenciasArticulo.CodigoClaseC<>CodigoClaseC.Value ) or
                     ( ExistenciasArticulo.LoteFabricacion<>LoteFabricacion.Value ) or
                     ( ExistenciasArticulo.CodigoAlmacen<>CodigoAlmacen.Value ) or
                     ( ExistenciasArticulo.CodigoUbicacion<>Ubicacion.Value )
                 then begin

                      //* La comprobación de existencias se hace por lote cuando éstos están activados

                      ExistenciasPorLote := DataModule00.DmEmpresaFields.Stock_LotesProductos.Value and not ValueIsEmpty( LoteFabricacion.Value );
                      TodasLasUbicaciones := ValueIsEmpty( Ubicacion.Value );

                      ExistenciasArticulo := StockAlmacen.ObtenStock( CodigoArticulo.Value,
                                                                      False,
                                                                      CodigoClaseA.Value,
                                                                      CodigoClaseB.Value,
                                                                      CodigoClaseC.Value,
                                                                      not ExistenciasPorLote,
                                                                      LoteFabricacion.Value,
                                                                      False,
                                                                      CodigoAlmacen.Value,
                                                                      TodasLasUbicaciones,
                                                                      Ubicacion.Value,
                                                                      True,
                                                                      Ejercicio.Value,
                                                                      0,
                                                                      ApplicationContainer.NroMesFinal );

                      end;

            If   Assigned( StockFrame )
            then StockFrame.Actualiza( ExistenciasArticulo, CodigoCliente );
            end;

end;

end.
