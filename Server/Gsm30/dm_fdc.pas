
unit dm_fdc;

interface

uses
  Windows, Messages, SysUtils, Classes, 
  System.Generics.Collections,

  DB,
  nxdb,
  nxsdTypes,

  DataManager,
  ServerDataModule,
  LibUtils,
  SessionIntf,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,

  dmi_iva,
  dmi_fdc,

  FacturaComprasIntf,
  ParametrosFacturacionIntf;

type

   TInsertLineEvent = procedure( TipoIVAArticulo, TipoIVADefectoManual : SmallInt; ProveedorFields : TProveedorFields; ArticuloFields : TArticuloFields; MovimientoFields : TMovimientoFields;LineaMovimientoFields : TLineaMovimientoFields ) of object;

   TSubcuentaFamilia = class
     Activo : Boolean;
     Subcuenta : String;
     CentroCoste : String;
     TipoImpositivo : SmallInt;
     BaseImponible,
     CuotaIVA  : Decimal;
     end;

   TFacturaComprasService = class( TSessionModule, IFacturaComprasService )
     protected

     procedure AssignSession( const SessionID : Integer ); override;

     procedure RecalculaFactura( FacturaCompras : IFacturaCompras; ModificarCuotaIVA : Boolean );
     function GeneraFacturas( ParametrosFacturacion : IParametrosFacturacion; RelacionAlbaranesTableName : String = '' ) : IParametrosFacturacion;
     procedure CierreCicloFacturacion( FechaInicial, FechaFinal : TDate; Contabilizar : Boolean );
     procedure RecuperaFactura( Ejercicio : SmallInt; CodigoProveedor, SerieNroFactura : String );
     procedure RecalculaAlbaranesFactura( Ejercicio : SmallInt; CodigoProveedor, SerieNroFactura  : String );
     end;

  TFacturaComprasModule = class(TServerDataModule)
    DmEfectoTable: TnxeTable;
    DmProveedorTable: TnxeTable;
    DmProveedorDatEconTable: TnxeTable;
    DmFormaPagoTable: TnxeTable;
    DmArticuloDatEconTable: TnxeTable;
    DmFacturaComprasTable: TnxeTable;
    DmMovimientoTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    DmFacturaComprasAuxTable: TnxeTable;
    DmMovimientoCajaTable: TnxeTable;
    DmAsientoTable: TnxeTable;
    DmApunteTable: TnxeTable;
    DmEfectoPagarTable: TnxeTable;
    DmFamiliaTable: TnxeTable;
    RelacionAlbaranesTable: TnxeTable;
    DmFacturaTable: TnxeTable;
    ConsultaFacturas: TnxeQuery;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);

  private

    DmFacturaComprasFields,
    DmFacturaComprasAuxFields : TFacturaComprasFields;
    DmFacturaFields : TFacturaFields;
    DmEfectoFields : TEfectoFields;
    DmMovimientoFields : TMovimientoFields;
    DmLineaMovimientoFields : TLineaMovimientoFields;
    DmProveedorFields : TProveedorFields;
    DmProveedorDatEconFields : TProveedorDatEconFields;
    DmFamiliaFields : TFamiliaFields;
    DmFormaPagoFields : TFormaPagoFields;
    DmArticuloDatEconFields : TArticuloDatEconFields;
    DmMovimientoCajaFields : TMovimientoCajaFields;
    DmAsientoFields : TAsientoFields;
    DmApunteFields : TApunteFields;
    DmEfectoPagarFields : TEfectoPagarFields;

    DsPaisFields : TPaisFields;
    DsArticuloFields : TArticuloFields;
    DsTiposIVAFields,
    DsTiposRetencionFields : TTiposIVAFields;
    DsFacturaComprasFields : TFacturaComprasFields;

    RelacionAlbaranesFields : TRelacionAlbaranesFields;

    ImporteCuotaIVA,
    ImporteRecFinancRetencion,
    // TotalLinea,
    PuntoVerdeLinea,
    SumaCoste,
    SumaBruto,
    SumaNeto,
    SumaNetoRetencion,
    SumaDtosProveedorRetencion,
    SumaIVAIncluido,

    ImporteDtoESRetencion,
    ImporteDtoPPRetencion : Decimal;

    CodigoSubcuenta,
    CuentaCompras,
    CuentaDevCompras,
    CuentaDtoPP,
    CuentaRecargoFinanciero,
    CuentaPortes : String;

    RelacionEfectos : TRelacionEfectos;

    PilaSubcuentas : TObjectList< TSubcuentaFamilia >;
    SubcuentaFamilia : TSubcuentaFamilia;

    function AplicaCondicionesPago( FacturaComprasFields : TFacturaComprasFields; AplicarDescuentoyRecargo : Boolean = True ) : Boolean;
    procedure DoInsertLine( TipoIVAArticulo, TipoIVADefectoManual: SmallInt; ProveedorFields: TProveedorFields; ArticuloFields: TArticuloFields; MovimientoFields: TMovimientoFields; LineaMovimientoFields: TLineaMovimientoFields);
    procedure InicializaPila;
    procedure InsertarEnPila( Subcuenta, CentroCoste: String; TipoImpositivo: SmallInt; BaseImponible, CuotaIVA : Decimal);

  public

    NroTotalCopias,
    NroOperacionActual : LongInt;

    CalcularIVA : Boolean;
    TipoIVADefectoManual : SmallInt;

    function Obten( Ejercicio : SmallInt; Propietario : String; SerieNroFactura : String ) : Boolean;

    function  ProximaSerieNroFactura( Ejercicio : SmallInt; Propietario : String; SerieNroFactura : String ) : String;
    function  DesgloseIVA( LineaDesglose, Opcion : SmallInt; var TasasArray : TTasasArray ) : Decimal; overload;
    // function  DesgloseIVA( LineaDesglose, Opcion, ModeloIVA : SmallInt; Fecha : TDateTime; var BaseImponibleFields : TListaValoresImpositivosFields ) : Decimal; overload;
    procedure ObtenTipoIVAArticulo( ArticuloFields : TArticuloFields; ProveedorFields : TProveedorFields; Fecha : TDateTime; TiposIVAFields : TTiposIVAFields );

    procedure CalculaImportes( LineaMovimientoFields : TLineaMovimientoFields;
                               ArticuloFields        : TArticuloFields;
                               RedondeaImportes      : Boolean = True ); overload;

    procedure CalculaImportes(     Cantidad          : Decimal;
                                   UnidadesPorPrecio : Integer;
                                   Precio            : Double;
                                   Ecotasa,
                                   Descuento         : Decimal;
                               var ImporteBruto      : Decimal;
                               var DescuentoArticulo : Decimal;
                               var ImporteNeto       : Decimal;
                                   RedondeaImportes  : Boolean = True ); overload;

    procedure CalculaImportes( Cantidad           : TBCDField;
                               UnidadesPorPrecio  : TIntegerField;
                               Precio             : TFloatField;
                               Ecotasa,
                               Descuento,
                               ImporteBruto,
                               ImporteDescuento,
                               ImporteNeto        : TBCDField;
                               RedondeaImportes   : Boolean = True ); overload;

    procedure CalculaImportesIVA(  LineaMovimientoFields  : TLineaMovimientoFields;
                                   ProveedorFields        : TProveedorFields;
                                   ArticuloFields         : TArticuloFields;
                                   TiposIVAFields         : TTiposIVAFields );

    function  CalculoEspecial( LineaMovimientoFields : TLineaMovimientoFields ) : Decimal;
    procedure ObtenCuotaPortes( Importe : Decimal; Fecha : TDate; ModeloIVA : SmallInt; var CuotaIVA  : Decimal );

    procedure ObtenBasesyCuotasFactura(     Ejercicio        : SmallInt;
                                            CodigoProveedor,
                                            SerieNroFactura  : String;
                                        var TasasArray       : TTasasArray;
                                        out TotalCuotaIVA    : Decimal );

    procedure RecalculaAlbaranesFactura( Ejercicio : SmallInt; CodigoProveedor, SerieNroFactura  : String );

    procedure RecalculaFactura( FacturaCompras : IFacturaCompras; ModificarCuotaIVA : Boolean ); overload;
    procedure RecalculaFactura(     FacturaComprasFields : TFacturaComprasFields;
                                    RecuperaProveedor,
                                    ModificarCuotaIVA    : Boolean;
                                var TasasArray           : TTasasArray ); overload;

    // procedure GeneraEfectosFactura( FacturaCompras : IFacturaCompras ); overload;
    // procedure GeneraEfectosFactura( FacturaComprasFields : TFacturaComprasFields ); overload;

    function GeneraFacturas( ParametrosFacturacion : IParametrosFacturacion; RelacionAlbaranesTableName : String = '' ) : IParametrosFacturacion;

    procedure ActualizaDatosEconomicos( FacturaComprasFields : TFacturaComprasFields; OnInsertLine : TInsertLineEvent; Sustraer, ActualizarConsumos : Boolean );
    procedure CierreCicloFacturacion( FechaInicial, FechaFinal: TDate; Contabilizar : Boolean );
    procedure RecuperaFactura( Ejercicio : SmallInt; CodigoProveedor, SerieNroFactura : String );

  end;

const FmtCantidadCompra  = 'FmtCantidadCompra';
      FmtPrecioCompra    = 'FmtPrecioCompra';
      FmtDescuentoCompra = 'FmtDescuentoCompra';

      // Origen de las facturas de compras

      ofrSujetoPasivo     = 0;
      ofrIntracomunitaria = 1;
      ofrInversionSP      = 2;

implementation

uses Math,
     DateUtils,
     AppManager,
     BaseServerContainer,
     BaseSessionData,
     SessionData,

     nxrdClass,
     nxrbTypes,
     nxsrServerEngine,
     nxllBDE,

     dmi_ast,
     dmi_art,
     dmi_mov,
     dmi_fac,

     dm_pai,
     dm_sub,
     dm_pro,
     dm_iva,
     dm_pga,
     dm_mov,
     dm_art,
     dm_sto,
     dm_ecc,

     dm_ast;

const

     DecimalesImportesCuotas = 4;  // En compras los cálculos nunca llevan el IVA incluido

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.DFM}

resourceString

     RsMsg1  = 'No encuentro la factura a eliminar.';
     RsMsg2  = 'La ficha del proveedor %s ha sido dada de baja. El albarán %d no será facturado.';
     RsMsg3  = 'Número de factura duplicado.';
     RsMsg4  = 'El número de factura %d ya existe. El programa le asignará a la nueva factura el número %d.';
     RsMsg5  = 'Ha desaparecido el albarán nº %d que había seleccionado previamente para facturar.';
     RsMsg6  = 'Se ha interrumpido el proceso de facturación.';
     RsMsg7  = 'La factura que estaba intendo emitir no ha sido generada y los albaranes que incluía siguen pendientes de facturar.';
     RsMsg8  = 'Factura de compra, albarán : %s, %d.';
     RsMsg9  = 'La forma de pago %s ha sido dada de baja.';
     RsMsg10 = 'No he conseguido recuperar la ficha del proveedor %s.';
     RsMsg11 = 'El proveedor ha sido dado de baja. Revise el estado de sus ficheros.';
     RsMsg12 = 'Impresión de facturas de compra.';
     RsMsg13 = 'El proveedor de código %s ha sido dado de baja. La factura nº %s no será procesada.';
     RsMsg14 = 'El artículo %s ha sido dado de baja. Aparece en el albarán %d.';
     RsMsg15 = 'Se procesará como si fuera una línea manual.';
     RsMsg16 = 'Ha ocurrido un error al reconstruir los resultados de la factura %s del proveedor %s.';
     RsMsg17 = 'Seleccionando albaranes a facturar';
     RsMsg18 = 'Generando facturas';
     RsMsg19 = 'Factura de compra del proveedor %s nº %s. Albarán nº %d.';
     RsMsg20 = 'La fecha de facturación no pertenece al ejercicio activo.';
     RsMsg22 = 'Albarán del proveedor %s, nº %s.';
     RsMsg23 = 'Periodos impositivos distintos.';
     // RsMsg24 = 'El albarán %s del proveedor %s, pertenece a un periodo impositivo distinto al de la fecha de facturación.'#13'Si ha recibido albaranes en los que se muestran los importes con I.V.A. incluído, éstos no coincidirán con los de la factura.';
     RsMsg25 = 'Creada la factura nº %s del proveedor %s, %s';
     RsMsg26 = 'Mensaje del sistema : ';

     // Cierre del ciclo de facturación

     RsMsg31  = 'Contabilizando';
     RsMsg32  = 'S/Fra. Nº %s';
     RsMsg33  = 'La forma de pago utilizada en la factura %s del proveedor %s ha sido dada de baja. Se utilizará la forma de pago por defecto.';
     RsMsg34  = 'El efecto a pagar nº %s del proveedor %s no ha sido reescrito porque constaba como contabilizado.';
     RsMsg35  = 'El asiento nº %d tiene el mismo número de documento que la factura que se intenta contabilizar.';

     //..
     RsMsg39 = 'Pago factura nº ';
     RsMsg40 = 'Abono factura nº ';
     RsMsg41 = 'Periodos impositivos distintos.';
     RsMsg42 = 'El albarán %s %d del proveedor %s, pertenece a un periodo impositivo distinto al de la fecha de facturación. Inclúyalo en facturas de ese mismo periodo.';
     RsMsg43 = 'Se ha interrumpido el proceso de cierre.';
     //..
     RsMsg45 = 'Las cuotas de I.V.A./R.E. calculadas de la factura nº %s %s no coinciden con las originales.';
     RsMsg46 = 'Compruebe si se han cambiado los tipos impositivos o el modelo de I.V.A. del proveedor.';
     RsMsg49 = 'La factura %s %s ha generado el asiento nº %d.';
     RsMsg52 = 'La fecha de la factura nº %s del proveedor %s no pertenece al trimestre actual. No se ha contabilizado';
     //..
     RsMsg55 = 'No he conseguido recuperar la ficha del tipo de retención %d.';

     // Recuperación de facturas

     RsMsg62 = 'Recuperada la factura %s, del proveedor %s, %s';
     RsMsg63 = 'No se ha podido recuperar la factura.';
     RsMsg64 = 'El sistema ha devuelto el siguiente error : %s.';
     RsMsg66 = 'No se ha podido localizar el asiento correspondiente a esta factura.';
     RsMsg67 = 'No se ha suprimido ningún asiento, pero la factura constará igualmente a partir de ahora como no contabilizada.';


procedure TFacturaComprasModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmFacturaComprasFields := TFacturaComprasFields.Create( DmFacturaComprasTable );
     DmFacturaComprasAuxFields := TFacturaComprasFields.Create( DmFacturaComprasAuxTable );
     DmFacturaFields := TFacturaFields.Create( DmFacturaTable );
     DmEfectoFields := TEfectoFields.Create( DmEfectoTable );
     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
     DmProveedorFields := TProveedorFields.Create( DmProveedorTable );
     DmProveedorDatEconFields := TProveedorDatEconFields.Create( DmProveedorDatEconTable );
     DmFamiliaFields := TFamiliaFields.Create( DmFamiliaTable );
     DmFormaPagoFields := TFormaPagoFields.Create( DmFormaPagoTable );
     DmArticuloDatEconFields := TArticuloDatEconFields.Create( DmArticuloDatEconTable );
     DmMovimientoCajaFields := TMovimientoCajaFields.Create( DmMovimientoCajaTable );
     DmAsientoFields := TAsientoFields.Create( DmAsientoTable );
     DmApunteFields := TApunteFields.Create( DmApunteTable );
     DmEfectoPagarFields := TEfectoPagarFields.Create( DmEfectoPagarTable );

     DsTiposIVAFields := TTiposIVAFields.Create( Self );

     { Es importante que este DsArticuloFields sea StaticData y no esté asociado a una tabla porque se utiliza como contenedor en
       las llamadas a la función SessionDataModule.Dm30.ArticuloModule.Obten y, cuando el artículo no existe o es una línea manual,
       se crea un registro por defecto que no puede ser actualizado desde una tabla }

     DsPaisFields := TPaisFields.Create( Self );
     DsArticuloFields := TArticuloFields.Create( Self );
     DsTiposRetencionFields := TTiposIVAFields.Create( Self );
     DsFacturaComprasFields := TFacturaComprasFields.Create( Self );

     PilaSubcuentas := TObjectList< TSubcuentaFamilia >.Create( { OwnsObjects } True );

end;

procedure TFacturaComprasModule.ServerDataModuleDestroy(Sender: TObject);
begin
     try
       If   Assigned( PilaSubcuentas )
       then PilaSubcuentas.Free;
       PilaSubcuentas := nil;
       SessionDataModule.Dm30.FacturaComprasModule := nil;
     except on E : Exception do
       begin
       LogException( E, Self );
       raise;
       end;
     end;

end;

function TFacturaComprasModule.Obten( Ejercicio       : SmallInt;
                                      Propietario     : String;
                                      SerieNroFactura : String ) : Boolean;

begin
     With DmFacturaComprasTable do
       begin
       IndexFieldNames := 'Ejercicio;Proveedor;SerieNroFactura';
       Result := FindKey( [ Ejercicio, Propietario, SerieNroFactura ] )
       end;
end;

procedure TFacturaComprasModule.ObtenTipoIVAArticulo( ArticuloFields     : TArticuloFields;
                                                      ProveedorFields    : TProveedorFields;
                                                      Fecha              : TDateTime;
                                                      TiposIVAFields     : TTiposIVAFields );

var  TipoDeIVA : SmallInt;

begin

     If   ArticuloFields.Codigo.IsNull
     then TipoDeIVA := SessionDataModule.Dm10.TasaModule.TipoIVAGlobal( Fecha, rgTipoIVAManual )
     else TipoDeIVA := ArticuloFields.TipoIVA.Value;

     If   Assigned( ProveedorFields )
     then If   ProveedorFields.Factura_ModeloIVA.Value=mipExento
          then TipoDeIVA := 0 // Exento
          else If   ( ProveedorFields.Factura_ModeloIVA.Value in [ mipTipoFijo, mipRegimenEspecial ] ) and not ArticuloFields.NoAplicarTipoFijo.Value
               then TipoDeIVA := ProveedorFields.Factura_TipoFijoIVA.Value;

     SessionDataModule.Dm10.TasaModule.TipoIVA( Fecha, TipoDeIVA, TiposIVAFields );
end;

function TFacturaComprasModule.ProximaSerieNroFactura( Ejercicio       : SmallInt;
                                                       Propietario     : String;
                                                       SerieNroFactura : String    ) : String;
var  PosicionNumero : Integer;
     SQLText : String;
     NroFactura : Integer;
     I : SmallInt;
     NuevaSerieNroFactura : String;
     SerieNumerica : Boolean;
     LongitudSerie : SmallInt;

begin
     NroFactura := 1;
     try

       try

         LongitudSerie := Length( SerieNroFactura );
         PosicionNumero := LongitudSerie + 1;

         SQLText := 'SELECT TOP 1 Ejercicio, Proveedor, SerieNroFactura, ';

         If   SerieNroFactura=''
         then begin
              StrAdd( SQLText, '( CAST( SerieNroFactura AS Integer ) ) AS Numero, ' );
              StrAdd( SQLText, ' SUBSTRING( CAST( CAST( POWER( 10, ( 8 - CHAR_LENGTH( TOSTRING( CAST( SerieNroFactura AS BIGINT ) ) ) ) ) AS BIGINT ) AS VARCHAR( 8 ) ) FROM 2) || TOSTRING( CAST( SerieNroFactura AS BIGINT ) ) AS NumeroFormateado ' );
              end
         else begin
              StrAdd( SQLText, '( CAST( SUBSTRING( SerieNroFactura FROM ' + IntToStr( PosicionNumero ) + ' ) AS Integer ) ) AS Numero, ' );
              StrAdd( SQLText, 'SUBSTRING( CAST( CAST( POWER( 10, ( 8 - CHAR_LENGTH( TOSTRING( CAST( SUBSTRING( SerieNroFactura FROM ' +
                               IntToStr( PosicionNumero ) + ' ) AS BIGINT ) ) ) ) ) AS BIGINT ) AS VARCHAR( 8 ) ) FROM 2 ) || TOSTRING( CAST( SUBSTRING( SerieNroFactura FROM ' +
                               IntToStr( PosicionNumero ) + ' ) AS BIGINT ) ) AS NumeroFormateado ' );
              end;

         StrAdd( SQLText, 'FROM FacturaCompras ' +
                          'WHERE Ejercicio=' + IntToStr( Ejercicio ) + ' AND Proveedor=' + QuotedStr( Propietario ) );

         If   SerieNroFactura=''
         then StrAdd( SQLText, ' AND SerieNroFactura SIMILAR TO ''^[" ",0-9]+$''' )
         else StrAdd( SQLText, ' AND SerieNroFactura SIMILAR TO ''^' + SerieNroFactura + '[" ",0-9]+$''' );

         StrAdd( SQLText,'ORDER BY NumeroFormateado DESC' );

         ConsultaFacturas.SQL.Text := SQLText;
         ConsultaFacturas.Open;

         If   ConsultaFacturas.RecordCount=1
         then NroFactura := ConsultaFacturas.FieldValues[ 'Numero' ] + 1;

       except
         end;

     finally

       ConsultaFacturas.Close;

       Result := IntToStr( NroFactura );
       If   SerieNroFactura<>''
       then Result := SerieNroFactura + ' ' + Result;

       end;

end;

function TFacturaComprasModule.DesgloseIVA(    LineaDesglose,
                                               Opcion         : SmallInt;
                                           var TasasArray     : TTasasArray ) : Decimal;

var   Index1,
      Index2 : SmallInt;

begin
     Result := 0.0;
     Index1 := 0;
     Index2  := 1;
     While ( Index1<=NroMaximoTiposTasas ) do
       begin
       If   TasasArray[ Index1 ].BaseImponible<>0
       then With TasasArray[ Index1 ] do
              begin
              If   Index2=LineaDesglose
              then begin
                   case Opcion of
                     1 : Result := BaseImponible;
                     2 : Result := TipoIVA;
                     3 : Result := CuotaIVA;
                     4 : ;
                     5 : ;
                     6 : Result := Importe;
                     end;
                   Exit;
                   end;
              Inc( Index2 );
              end;
       Inc( Index1 );
       end;
end;

procedure TFacturaComprasModule.CalculaImportes(    Cantidad          : Decimal;
                                                    UnidadesPorPrecio : Integer;
                                                    Precio            : Double;
                                                    Ecotasa,
                                                    Descuento         : Decimal;
                                                var ImporteBruto      : Decimal;
                                                var DescuentoArticulo : Decimal;
                                                var ImporteNeto       : Decimal;
                                                    RedondeaImportes  : Boolean = True );

var  BaseDescuentos : Decimal;

begin
     If   Cantidad=0.0
     then begin
          ImporteBruto := 0.0;
          DescuentoArticulo := 0.0;
          ImporteNeto := 0.0;
          end
     else begin
          If   SessionDataModule.EmpresaFields.Articulo_UnidadesPorPrecio.Value and ( UnidadesPorPrecio>0 )
          then Cantidad := Cantidad / UnidadesPorPrecio;
          ImporteBruto := Cantidad * ( Precio + Ecotasa );
          BaseDescuentos := Cantidad * Precio;
          DescuentoArticulo := ( BaseDescuentos * Descuento ) / 100.0;
          ImporteNeto := ImporteBruto - DescuentoArticulo;

          If   RedondeaImportes
          then begin
               ImporteNeto := Redondea( ImporteNeto, DecimalesImportesCuotas );
               ImporteBruto := Redondea( ImporteBruto, DecimalesImportesCuotas );
               end;

          end;
end;

procedure TFacturaComprasModule.CalculaImportes( LineaMovimientoFields : TLineaMovimientoFields;
                                                 ArticuloFields        : TArticuloFields;
                                                 RedondeaImportes      : Boolean = True );

var  ImporteBrutoLinea,
     ImporteDescuentoLinea,
     ImporteNetoLinea : Decimal;

begin
     With LineaMovimientoFields do
       begin
       CalculaImportes( Cantidad.Value, ArticuloFields.UnidadesPrecioCompra.Value, Precio.Value, PuntoVerde.Value, Descuento.Value, ImporteBrutoLinea, ImporteDescuentoLinea, ImporteNetoLinea, RedondeaImportes );
       ImporteBruto.Value := ImporteBrutoLinea;
       ImporteDescuento.Value := ImporteDescuentoLinea;
       ImporteNeto.Value := ImporteNetoLinea;
       end;
end;

procedure TFacturaComprasModule.CalculaImportes( Cantidad           : TBCDField;
                                                 UnidadesPorPrecio  : TIntegerField;
                                                 Precio             : TFloatField;
                                                 Ecotasa,
                                                 Descuento,
                                                 ImporteBruto,
                                                 ImporteDescuento,
                                                 ImporteNeto        : TBCDField;
                                                 RedondeaImportes   : Boolean = True );
var  ImporteBrutoLinea,
     ImporteDescuentoLinea,
     ImporteNetoLinea,
     PuntoVerde  : Decimal;

begin
     If   Assigned( Ecotasa )
     then PuntoVerde := Ecotasa.Value
     else PuntoVerde := 0.0;

     CalculaImportes( Cantidad.Value, UnidadesPorPrecio.Value, Precio.Value, PuntoVerde, Descuento.Value, ImporteBrutoLinea, ImporteDescuentoLinea, ImporteNetoLinea, RedondeaImportes );

     If   Assigned( ImporteBruto)
     then ImporteBruto.Value := ImporteBrutoLinea;
     If   Assigned( ImporteDescuento )
     then ImporteDescuento.Value := ImporteDescuentoLinea;
     ImporteNeto.Value := ImporteNetoLinea;
end;

procedure TFacturaComprasModule.CalculaImportesIVA(  LineaMovimientoFields  : TLineaMovimientoFields;
                                                     ProveedorFields        : TProveedorFields;
                                                     ArticuloFields         : TArticuloFields;
                                                     TiposIVAFields         : TTiposIVAFields );

var  AplicarIVA : Boolean;

begin

     // No redondeo de momento los importes para poder utilizar los valores en el cálculo del I.V.A.

     CalculaImportes( LineaMovimientoFields, ArticuloFields, False );

     ObtenTipoIVAArticulo( ArticuloFields, ProveedorFields, LineaMovimientoFields.Fecha.Value, TiposIVAFields );

     With LineaMovimientoFields do
       begin

       PrecioIVA.Value := Precio.Value;
       CodigoTipoIVA.Value := 0;
       CuotaIVA.Value := 0.0;

       If   Assigned( ProveedorFields ) and ProveedorFields.Initialized
       then AplicarIVA := ( ProveedorFields.Factura_ModeloIVA.Value<>mipExento ) and not( ProveedorFields.Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ] )
       else AplicarIVA := True;

       // Necesito el tipo de IVA de los proveedores intracomunitarios y con inversión del sujeto pasivo para el cierre

       If   AplicarIVA or ( ProveedorFields.Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ] )
       then CodigoTipoIVA.Value := TiposIVAFields.Codigo.Value;

       If   AplicarIVA
       then begin
            CuotaIVA.Value := Redondea( ( ImporteNeto.Value * TiposIVAFields.IVASoportado.Value ) / 100.0, DecimalesImportesCuotas );
            PrecioIVA.Value := Redondea( Precio.Value + ( Precio.Value * TiposIVAFields.IVASoportado.Value / 100.0 ) );
            end;

       ImporteBruto.Value := Redondea( ImporteBruto.Value, DecimalesImportesCuotas );
       ImporteNeto.Value := Redondea( ImporteNeto.Value, DecimalesImportesCuotas );
       ImporteTotal.Value := Redondea( ImporteNeto.Value + CuotaIVA.Value, DecimalesImportesCuotas );

       end;

end;

function TFacturaComprasModule.CalculoEspecial( LineaMovimientoFields : TLineaMovimientoFields ) : Decimal;

function Multiplo3( Valor : Decimal ) : Decimal;

var   ValorEntero : LongInt;

begin
     ValorEntero := Trunc( Valor / 3 );
     If   ( ( Valor / 3 ) - ValorEntero )=0
     then Result := Valor
     else begin
          Inc( ValorEntero );
          Result := ValorEntero * 3;
          end;
end;

begin

     Result := 0.0;

     With SessionDataModule.EmpresaFields, LineaMovimientoFields do
       begin

       If   ( Compras_Cantidades.Value=0 ) or
            ( ( Compras_Cantidades.Value=1 ) and ( ( Largo.Value=0.0 ) or ( Ancho.Value=0.0 ) ) ) or
            ( ( Compras_Cantidades.Value=2 ) and ( ( Largo.Value=0.0 ) or ( Ancho.Value=0.0 ) or ( Alto.Value=0.0 ) ) )
       then Exit;

       case Compras_Cantidades.Value of
         1 : Result := Largo.Value * Ancho.Value;
         2 : case Compras_Calculo.Value of
               0 : Result := Largo.Value * Ancho.Value * Alto.Value;
               1 : Result := ( Multiplo3( Largo.Value ) * Multiplo3( Ancho.Value ) * Alto.Value ) * 0.0001;   { Cristal }
               end;
         end;

       end;

end;

function TFacturaComprasModule.AplicaCondicionesPago( FacturaComprasFields     : TFacturaComprasFields;
                                                      AplicarDescuentoyRecargo : Boolean = True ) : Boolean;
begin
     If   not DmFormaPagoTable.FindKey( [ FacturaComprasFields.CodigoFormaPago.Value ] )
     then begin
     	 	  SessionDataModule.SendNotification( ntStop, Format( RsMsg9, [ FacturaComprasFields.CodigoFormaPago.Value ] ) );
          Result := False;
          Exit;
          end;

     FacturaComprasFields.DiaPago1.Value := DmProveedorFields.Pago_DiaPago1.Value;
     FacturaComprasFields.DiaPago2.Value := DmProveedorFields.Pago_DiaPago2.Value;

     If   AplicarDescuentoyRecargo
     then begin

          If   DmFormaPagoFields.DescuentoPP.Value
          then If   ValueIsEmpty( DmProveedorFields.Factura_DtoPP.Value )
               then FacturaComprasFields.DescuentoPP.Value := DmFormaPagoFields.TipoDescuentoPP.Value
               else FacturaComprasFields.DescuentoPP.Value := DmProveedorFields.Factura_DtoPP.Value;

          If   DmFormaPagoFields.RecargoFinanciero.Value
          then If   ValueIsEmpty( DmProveedorFields.Factura_RecFinanc.Value )
               then FacturaComprasFields.RecargoFinanciero.Value := DmFormaPagoFields.TipoRecargoFinanc.Value
               else FacturaComprasFields.RecargoFinanciero.Value := DmProveedorFields.Factura_RecFinanc.Value;

          end;

     Result := True;

end;

procedure TFacturaComprasModule.ObtenCuotaPortes(     Importe   : Decimal;
                                                      Fecha     : TDate;
                                                      ModeloIVA : SmallInt;
                                                  var CuotaIVA  : Decimal );

var  PorcentajeIVA : Decimal;

begin
     CuotaIVA := 0.0;
     If   not( ( ModeloIVA=mipExento ) or ( Importe=0.0 ) )
     then begin
          SessionDataModule.Dm10.TasaModule.TipoIVA( Fecha, SessionDataModule.Dm10.TasaModule.TipoIVAGlobal( Fecha, rgTipoIVAPortes ), DsTiposIVAFields );
          CuotaIVA := Redondea( ( Importe * DsTiposIVAFields.IVASoportado.Value ) / 100.0 );
          end;
end;

procedure TFacturaComprasModule.ActualizaDatosEconomicos( FacturaComprasFields : TFacturaComprasFields;
                                                          OnInsertLine         : TInsertLineEvent;
                                                          Sustraer             : Boolean;
                                                          ActualizarConsumos   : Boolean );

var  NroMes : SmallInt;

begin

     try

       CalcularIVA := True;
       NroMes := MonthOf( FacturaComprasFields.Fecha.Value );

       If   not DmProveedorTable.FindKey( [ FacturaComprasFields.Proveedor.Value ] )
       then begin
            SessionDataModule.SendNotification( ntStop, Format( RsMsg13, [ FacturaComprasFields.Proveedor.Value, FacturaComprasFields.SerieNroFactura.Value ] ) );
            Abort;
            end
       else begin

            CalcularIVA := ( DmProveedorFields.Factura_ModeloIVA.Value<>mipExento ) and not ( FacturaComprasFields.Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ] );

            If   DmProveedorFields.Factura_ModeloIVA.Value in [ mipTipoFijo, mipRegimenEspecial ]
            then TipoIVADefectoManual := DmProveedorFields.Factura_TipoFijoIVA.Value
            else TipoIVADefectoManual := SessionDataModule.Dm10.TasaModule.TipoIVAGlobal( FacturaComprasFields.Fecha.Value, rgTipoIVAManual );

            With DmProveedorDatEconTable do
              begin

              If   not FindKey( [ FacturaComprasFields.Ejercicio.Value, FacturaComprasFields.Proveedor.Value ] )
              then SessionDataModule.Dm30.RelacionesProveedorModule.AltaDatosEconomicos( FacturaComprasFields.Ejercicio.Value, FacturaComprasFields.Proveedor.Value, DmProveedorDatEconTable );

              try

                Edit;

                With DmProveedorDatEconFields do
                  begin
                  If   FechaUltFactura.Value<FacturaComprasFields.Fecha.Value
                  then FechaUltFactura.Value := FacturaComprasFields.Fecha.Value;
                  Descuentos[ NroMes ].Value := Descuentos[ NroMes ].Value + DecSign( FacturaComprasFields.DescuentoProveedores.Value, not Sustraer );
                  Compras[ NroMes ].Value := Compras[ NroMes ].Value + DecSign( FacturaComprasFields.NetoFactura.Value, not Sustraer );
                  end;

                Post;

                except
                  Cancel;
                  raise;
                  end;

              end;

            With DmMovimientoTable do
              try
                IndexFieldNames := 'TipoMovimiento;EjercicioFactura;PropietarioFactura;SerieFactura;NroFactura';
                With FacturaComprasFields do
                  SetRange( [ tmCompra, Ejercicio.Value, Proveedor.Value, SerieNroFactura.Value, 0 ],
                            [ tmCompra, Ejercicio.Value, Proveedor.Value, SerieNroFactura.Value, 0 ] );
                First;
                While not Eof do
                  begin

                  SessionDataModule.SendNotification( ntRecord, Format( RsMsg8, [ FacturaComprasFields.SerieNroFactura.Value, DmMovimientoFields.NroDocumento.Value ] ) );

                  NroMes := MonthOf( DmMovimientoFields.Fecha.Value );

                  With DmLineaMovimientoTable do
                    try

                      With DmMovimientoFields do
                        SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallInt, MaxSmallInt ] );

                      First;
                      While not Eof do
                        begin

                        If   not SessionDataModule.Dm30.ArticuloModule.Obten( DmLineaMovimientoFields.CodigoArticulo.Value, DsArticuloFields )
                        then If   DmLineaMovimientoFields.CodigoArticulo.Value<>ArticuloManual
                             then SessionDataModule.SendNotification( ntStop, Format( RsMsg14, [ DmLineaMovimientoFields.CodigoArticulo.Value, DmMovimientoFields.NroDocumento.Value ] ), RsMsg15 );

                        If   DmLineaMovimientoFields.Cantidad.Value<>0.0
                        then begin

                             With DmArticuloDatEconTable, DmLineaMovimientoFields do
                               If   not FindKey( [ Ejercicio.Value, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, CodigoAlmacen.Value ] )
                               then SessionDataModule.Dm30.ArticuloModule.AltaDatosEconomicos( Ejercicio.Value, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, CodigoAlmacen.Value, DmArticuloDatEconTable );

                             try

                               DmArticuloDatEconTable.Edit;

                               With DmArticuloDatEconFields do
                                 begin
                                 UnidadesCompras[ NroMes ].Value := UnidadesCompras[ NroMes ].Value + DecSign( DmLineaMovimientoFields.Cantidad.Value, not Sustraer );
                                 ImporteCompras[ NroMes ].Value := ImporteCompras[ NroMes ].Value + DecSign( DmLineaMovimientoFields.ImporteNeto.Value, not Sustraer );
                                 ImporteDescuentosCompras[ NroMes ].Value := ImporteDescuentosCompras[ NroMes ].Value + DecSign( DmLineaMovimientoFields.ImporteDescuento.Value, not Sustraer );
                                 end;

                               DmArticuloDatEconTable.Post;

                             except
                               DmArticuloDatEconTable.Cancel;
                               raise;
                               end;

                             If   ActualizarConsumos
                             then begin
                                  SessionDataModule.Dm30.StockAlmacenModule.ActualizaConsumoCompras( tcArticulo,
                                                                                                     FacturaComprasFields.Proveedor.Value,
                                                                                                     DmLineaMovimientoFields.CodigoArticulo.Value,
                                                                                                     DmLineaMovimientoFields.CodigoClaseA.Value,
                                                                                                     DmLineaMovimientoFields.CodigoClaseB.Value,
                                                                                                     DmLineaMovimientoFields.CodigoClaseC.Value,
                                                                                                     DmLineaMovimientoFields.Fecha.Value,
                                                                                                     DecSign( DmLineaMovimientoFields.Cantidad.Value, not Sustraer ),
                                                                                                     DecSign( DmLineaMovimientoFields.ImporteNeto.Value, not Sustraer ),
                                                                                                     DecSign( DmLineaMovimientoFields.ImporteDescuento.Value, not Sustraer ) );

                                  If   not ValueIsEmpty( DsArticuloFields.Familia.Value )
                                  then SessionDataModule.Dm30.StockAlmacenModule.ActualizaConsumoCompras( tcFamilia,
                                                                                                          FacturaComprasFields.Proveedor.Value,
                                                                                                          DsArticuloFields.Familia.Value,
                                                                                                          DmLineaMovimientoFields.CodigoClaseA.Value,
                                                                                                          DmLineaMovimientoFields.CodigoClaseB.Value,
                                                                                                          DmLineaMovimientoFields.CodigoClaseC.Value,
                                                                                                          DmLineaMovimientoFields.Fecha.Value,
                                                                                                          DecSign( DmLineaMovimientoFields.Cantidad.Value, not Sustraer ),
                                                                                                          DecSign( DmLineaMovimientoFields.ImporteNeto.Value, not Sustraer ),
                                                                                                          DecSign( DmLineaMovimientoFields.ImporteDescuento.Value, not Sustraer ) );
                                  end;

                             end;

                        If   Assigned( OnInsertLine )
                        then OnInsertLine( DmLineaMovimientoFields.CodigoTipoIVA.Value,
                                           TipoIVADefectoManual,
                                           DmProveedorFields,
                                           DsArticuloFields,
                                           DmMovimientoFields,
                                           DmLineaMovimientoFields );

                        Next;
                        end;

                    finally
                      CancelRange;
                      end;

                  try
                    Edit;
                    DmMovimientoFields.Traspasado.Value := not Sustraer;
                    Post;
                  except
                    Cancel;
                    raise;
                    end;

                  Next;
                  end;

              finally
                CancelRange;
                end;
            end;

     except on E : Exception do
       SessionDataModule.SendNotification( ntWarning, Format( RsMsg16, [ FacturaComprasFields.SerieNroFactura.Value, FacturaComprasFields.Proveedor.Value ] ), RsMsg26 + ExceptionMessage( E ) );
       end;
end;

procedure TFacturaComprasModule.CierreCicloFacturacion( FechaInicial, FechaFinal: TDate; Contabilizar : Boolean );

var   Offset,
      Index  : SmallInt;

      Canceled : Boolean;

      BaseCalculoDescuentos,

      BaseImp,
      ImporteNeto,

      NetoFactura,
      SumaCuotas,

      SumaBaseImponible,
      SumaCuotasLinea,
      SumaImporteTotalLinea,

      NetoFra,
      CuotasFactura,
      ImporteDtoES,
      ImporteDtoPP,
      CuotaIVAPortes,
      Diferencia : Decimal;

      DescuadreCuotas,
      DescuadreBases,
      DescuadreImportes : Boolean;

      TipoImpositivo : SmallInt;

      TipoDeIVA,
      TipoManual : SmallInt;
      ConceptoApunte : String;

      TasasArray : TTasasArray;

procedure GeneraAsiento;

var  SubcuentaProveedor,
     SubcuentaRetACuenta,
     SubcuentaIVASoportado,
     SubcuentaIVARepercutido : String;
     PrimerApunteIVA,
     NroAsientoActual,
     NroApunteActual : Integer;
     Offset : SmallInt;
     ApunteFieldValues : TFieldValuesArray;

     CuotasArray  : Array [ 0..NroMaximoTiposTasas ] of Decimal;

begin

     SubcuentaProveedor := DmProveedorFields.Subcuenta.Value;

     SessionDataModule.Dm10.CuentaModule.InsertaSubcuenta( SubcuentaProveedor, DmProveedorFields.Nombre.Value );

     // Compruebo si existe un Asiento con el mismo nº de documento
     // TipoAsiento;Ejercicio;Propietario;Serie;NroFactura;NroEfecto

     With DmFacturaComprasFields do
       If   DmAsientoTable.FindKey( [ taFraRecibida, Ejercicio.Value, SubcuentaProveedor, SerieNroFactura.Value, 0, NroEfectoRegistroFactura ] )
       then begin
            Canceled := SessionDataModule.SendNotification( ntError, Format( RsMsg35, [ DmAsientoFields.NroAsiento.Value ] ) );
            Abort;
            end;

     NroAsientoActual := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;

     DmAsientoTable.Append;

     DmAsientoFields.TipoAsiento.Value := taFraRecibida;
     DmAsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
     DmAsientoFields.NroAsiento.Value := NroAsientoActual;
     DmAsientoFields.Fecha.Value := DmFacturaComprasFields.FechaRecepcion.Value;
     DmAsientoFields.FechaDocumento.Value  := DmFacturaComprasFields.Fecha.Value;
     DmAsientoFields.Propietario.Value := SubcuentaProveedor;
     DmAsientoFields.Nombre.Value := DmProveedorFields.Nombre.Value;
     DmAsientoFields.Serie.Value := DmFacturaComprasFields.SerieNroFactura.Value;
     DmAsientoFields.NroFactura.Value := 0;
     DmAsientoFields.NroEfecto.Value := NroEfectoRegistroFactura;

     If   DmFacturaComprasFields.NroRegistro.Value=0
     then begin
          DmAsientoFields.NroRegistro.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroRegistro( taFraRecibida );
          DmFacturaComprasTable.Edit;
          DmFacturaComprasFields.NroRegistro.Value := DmAsientoFields.NroRegistro.Value;
          end
     else DmAsientoFields.NroRegistro.Value := DmFacturaComprasFields.NroRegistro.Value;

     DmAsientoFields.Origen.Value := DmFacturaComprasFields.Origen.Value;

     ConceptoApunte := Format( RsMsg32, [ DmAsientoFields.Serie.Value ] );

     SumaBaseImponible := 0.0;
     SumaCuotasLinea := 0.0;
     SumaImporteTotalLinea := 0.0;
     CuotasFactura := 0.0;

     NroApunteActual := 2;
     Offset := 0;

     While ( Offset<PilaSubcuentas.Count ) do
       begin

       PilaSubcuentas[ Offset ].BaseImponible := Redondea( PilaSubcuentas[ Offset ].BaseImponible );
       PilaSubcuentas[ Offset ].CuotaIVA := Redondea( PilaSubcuentas[ Offset ].CuotaIVA );

       If   ( PilaSubcuentas[ Offset ].BaseImponible<>0.0 ) or
            ( ( DmFacturaComprasFields.TotalFactura.Value=0.0 ) and PilaSubcuentas[ Offset ].Activo )
       then begin

            DmApunteTable.Append;

            DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
            DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
            DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
            DmApunteFields.Concepto.Value := ConceptoApunte;
            DmApunteFields.Contrapartida.Value := SubcuentaProveedor;

            DmApunteFields.NroApunte.Value := NroApunteActual;
            DmApunteFields.Subcuenta.Value := PilaSubcuentas[ Offset ].Subcuenta;
            DmApunteFields.CentroCoste.Value := PilaSubcuentas[ Offset ].CentroCoste;
            SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, PilaSubcuentas[ Offset ].BaseImponible );
            DmApunteFields.BaseImponible.Value := PilaSubcuentas[ Offset ].BaseImponible;
            DmApunteFields.TipoApunte.Value := tapManual;

            // Aunque las cuotas de las facturas intracomunitarias no se calculan ni muestran en la gestión comercial
            // son necesarias en los libros de I.V.A. para la liquidación

            If   CalcularIVA or ( DmFacturaComprasFields.Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ] )
            then begin
                 DmApunteFields.Tipo.Value := PilaSubcuentas[ Offset ].TipoImpositivo;
                 If   DmFacturaComprasFields.Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ]
                 then begin
                      SessionDataModule.Dm10.TasaModule.TipoIVA( DmAsientoFields.Fecha.Value, PilaSubcuentas[ Offset ].TipoImpositivo, DsTiposIVAFields );
                      DmApunteFields.CuotaIVA.Value := Redondea( PilaSubcuentas[ Offset ].BaseImponible * DsTiposIVAFields.IVASoportado.Value / 100 );
                      end
                 else DmApunteFields.CuotaIVA.Value := PilaSubcuentas[ Offset ].CuotaIVA;
                 end
            else begin
                 DmApunteFields.Tipo.Value := 0;   // Tipo nulo
                 DmApunteFields.CuotaIVA.Value := 0.0;
                 end;

            If   DmFacturaComprasFields.Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ]
            then DmApunteFields.ImporteTotal.Value := DmApunteFields.BaseImponible.Value
            else DmApunteFields.ImporteTotal.Value := DmApunteFields.BaseImponible.Value + DmApunteFields.CuotaIVA.Value;

            DecAdd( SumaBaseImponible, DmApunteFields.BaseImponible.Value );

            If   not ( DmFacturaComprasFields.Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ] )
            then DecAdd( SumaCuotasLinea, DmApunteFields.CuotaIVA.Value );

            DecAdd( SumaImporteTotalLinea, DmApunteFields.ImporteTotal.Value  );

            SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

            DmApunteTable.Post;

            Inc( NroApunteActual );

            end;

       Inc( Offset );
       end;

     // Tratamiento de las retenciones

     If   DmFacturaComprasFields.ImporteRetencion.Value<>0.0
     then begin

          DmApunteTable.Append;

          SessionDataModule.Dm10.TasaModule.TipoRetencion( DmFacturaComprasFields.Fecha.Value, DmFacturaComprasFields.TipoRetencion.Value, DsTiposRetencionFields );

          If   DsTiposRetencionFields.CtaRetACuenta.Value=''
          then SubcuentaRetACuenta := SessionDataModule.Dm10.CuentaModule.CodigoCuentaDefecto( cpCtaRetACuenta )
          else SubcuentaRetACuenta := DsTiposRetencionFields.CtaRetACuenta.Value;

          DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
          DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
          DmApunteFields.NroApunte.Value := NroApunteActual;
          DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;

          If   DsTiposRetencionFields.Desglosar.Value
          then begin
               DmApunteFields.Subcuenta.Value := Copy( SubcuentaRetACuenta, 1, 4 ) + Copy( DmAsientoFields.Propietario.Value, 5, 5 );
               SessionDataModule.Dm10.CuentaModule.InsertaSubcuenta( DmApunteFields.Subcuenta.Value, DmAsientoFields.Nombre.Value );
               end
          else DmApunteFields.Subcuenta.Value := SubcuentaRetACuenta;

          DmApunteFields.Contrapartida.Value := DmAsientoFields.Propietario.Value;
          DmApunteFields.Concepto.Value := ConceptoApunte;

          SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, DmFacturaComprasFields.ImporteRetencion.Value, True );

          DmApunteFields.BaseImponible.Value := DmFacturaComprasFields.BaseCalculoRetencion.Value;
          DmApunteFields.Tipo.Value := DmFacturaComprasFields.TipoRetencion.Value;
          DmApunteFields.CuotaIVA.Value := 0.0;
          DmApunteFields.CuotaRE.Value := 0.0;
          DmApunteFields.ImporteTotal.Value := 0.0;
          DmApunteFields.TipoApunte.Value := tapRetencion;

          SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

          DmApunteTable.Post;

          DecAdd( SumaImporteTotalLinea, -DmFacturaComprasFields.ImporteRetencion.Value );

          Inc( NroApunteActual );
          end;

     If   NroApunteActual>2
     then begin

          DmApunteTable.Append;

          DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
          DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
          DmApunteFields.NroApunte.Value := 1;
          DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
          DmApunteFields.Subcuenta.Value := DmAsientoFields.Propietario.Value;
          DmApunteFields.Concepto.Value := ConceptoApunte;

          SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, DmFacturaComprasFields.TotalFactura.Value, True );

          DmApunteFields.BaseImponible.Value := 0.0;
          DmApunteFields.Tipo.Value := 0;
          DmApunteFields.CuotaIVA.Value := 0.0;
          DmApunteFields.ImporteTotal.Value := 0.0;

          SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

          DmApunteTable.Post;

          NetoFra := DmFacturaComprasFields.NetoFactura.Value -
                     DmFacturaComprasFields.DescuentoProveedores.Value +
                     DmFacturaComprasFields.ImporteRecFinanciero.Value +
                     DmFacturaComprasFields.Portes.Value;

          DescuadreCuotas := SumaCuotasLinea <> DmFacturaComprasFields.CuotaIVA.Value;
          DescuadreBases := NetoFra <> SumaBaseImponible;
          DescuadreImportes := SumaImporteTotalLinea <> DmFacturaComprasFields.TotalFactura.Value;

          If   DescuadreCuotas or DescuadreBases or DescuadreImportes
          then With DmApunteTable do
                 begin
                 CancelRange;
                 If   FindKey( [ DmAsientoFields.Ejercicio.Value, DmAsientoFields.NroAsiento.Value, 2 ] )
                 then try

                        SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, True );

                        Edit;

                        If   DescuadreBases
                        then begin
                             Diferencia := NetoFra - SumaBaseImponible;
                             DmApunteFields.BaseImponible.Value := DmApunteFields.BaseImponible.Value + Diferencia;

                             // La base imponible tiene signo, pero el Importe es su valor absoluto

                             SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, GetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber ) + Diferencia );
                             end;

                        If   DescuadreCuotas
                        then begin
                             Diferencia := DmFacturaComprasFields.CuotaIVA.Value - SumaCuotasLinea;
                             DmApunteFields.CuotaIVA.Value := DmApunteFields.CuotaIVA.Value + Diferencia;
                             end;

                        If   DescuadreImportes
                        then begin
                             Diferencia  := DmFacturaComprasFields.TotalFactura.Value - SumaImporteTotalLinea;
                             DmApunteFields.ImporteTotal.Value := DmApunteFields.ImporteTotal.Value + Diferencia;
                             end;

                        If   ( DmApunteFields.Debe.Value=0.0 ) and ( DmApunteFields.Haber.Value=0.0 )
                        then Delete
                        else begin
                             SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );
                             Post;
                             end;

                      except
                        Cancel;
                        raise;
                        end;

                 end;

          // Completando el Asiento

          If   CalcularIVA or ( DmFacturaComprasFields.Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ] )
          then begin

               CuotasFactura := 0.0;

               FillChar( CuotasArray, SizeOf( CuotasArray ), #0 );

               With DmApunteTable do
                 try

                   With DmAsientoFields do
                     SetRange( [ Ejercicio.Value, NroAsiento.Value, 2 ], [ Ejercicio.Value, NroAsiento.Value, MaxSmallInt ] );

                   First;
                   While not Eof do
                     begin
                     With DmApunteFields do
                       begin
                       DecAdd( CuotasArray[ Tipo.Value ], CuotaIVA.Value );
                       DecAdd( CuotasFactura,  CuotaIVA.Value );
                       end;
                     Next;
                     end;

                 finally
                   CancelRange;
                   end;

               If   not ( DmFacturaComprasFields.Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ] )
               then With DmFacturaComprasFields do
                      If   Redondea( CuotasFactura )<>Redondea( CuotaIVA.Value )
                      then begin
                           SessionDataModule.SendNotification( ntError, Format( RsMsg45, [ Proveedor.Value, SerieNroFactura.Value ] ), RsMsg46 );
                           Abort;
                           end;

               For Offset := 1 to NroMaximoTiposTasas do
                 If   CuotasArray[ Offset ]<>0.0
                 then begin

                      With SessionDataModule.Dm10.TasaModule do
                        begin

                        TipoIVA( DmAsientoFields.Fecha.Value, Offset, DsTiposIVAFields );

                        If   DsTiposIVAFields.CtaRepercutido.Value=''
                        then SubcuentaIVARepercutido := SessionDataModule.Dm10.CuentaModule.CodigoCuentaDefecto( cpCtaIVARepercutido )
                        else SubcuentaIVARepercutido := DsTiposIVAFields.CtaRepercutido.Value;

                        If   DsTiposIVAFields.CtaSoportado.Value=''
                        then SubcuentaIVASoportado := SessionDataModule.Dm10.CuentaModule.CodigoCuentaDefecto( cpCtaIVASoportado )
                        else SubcuentaIVASoportado := DsTiposIVAFields.CtaSoportado.Value;

                        end;

                      DmApunteTable.Append;

                      DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                      DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
                      DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
                      DmApunteFields.NroApunte.Value := NroApunteActual;
                      DmApunteFields.Subcuenta.Value := SubcuentaIVASoportado;
                      DmApunteFields.Contrapartida.Value := DmAsientoFields.Propietario.Value;
                      DmApunteFields.Concepto.Value := ConceptoApunte;
                      SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, CuotasArray[ Offset ] );
                      DmApunteFields.TipoApunte.Value := tapCuotaIVA;
                      DmApunteFields.BaseImponible.Value := 0.0;
                      DmApunteFields.Tipo.Value := Offset;
                      DmApunteFields.CuotaIVA.Value := 0.0;
                      DmApunteFields.ImporteTotal.Value := 0.0;

                      ApunteFieldValues := DmApunteTable.GetFieldValues;

                      SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                      DmApunteTable.Post;

                      Inc( NroApunteActual );

                      If   DmFacturaComprasFields.Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ]
                      then begin
                           DmApunteTable.Append;
                           DmApunteTable.SetFieldValues( ApunteFieldValues );
                           DmApunteFields.NroApunte.Value := NroApunteActual;
                           DmApunteFields.Subcuenta.Value := SubcuentaIVARepercutido;
                           SwapFieldValues( DmApunteFields.Debe, DmApunteFields.Haber );
                           SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );
                           DmApunteTable.Post;
                           Inc( NroApunteActual );
                           end;

                      end;

               end;
			   
          DmAsientoTable.Post;

          With DmFacturaComprasFields do
            SessionDataModule.Dm10.FacturaModule.CopiaRegistroFactura( tfFacturaCompras, Proveedor.Value, SerieNroFactura.Value, 0, DmAsientoFields.NroAsiento.Value );

          With DmFacturaComprasFields do
            Canceled := SessionDataModule.SendNotification( ntInformation, Format( RsMsg49, [ Proveedor.Value, SerieNroFactura.Value, DmAsientoFields.NroAsiento.Value ] ) );

          end
     else DmAsientoTable.Cancel;

end;

procedure GeneraEfectos;

var   SubcuentaProveedor : String;
      Offset : SmallInt;

begin

     SubcuentaProveedor := DmProveedorFields.Subcuenta.Value;
     SessionDataModule.Dm10.CuentaModule.InsertaSubcuenta( SubcuentaProveedor, DmProveedorFields.Nombre.Value );

     If   not DmFormaPagoTable.FindKey( [ DmFacturaComprasFields.CodigoFormaPago.Value ] )
     then begin

          Canceled := SessionDataModule.SendNotification( ntWarning, Format( RsMsg33, [ DmFacturaComprasFields.SerieNroFactura.Value, DmFacturaComprasFields.Proveedor.Value ] ) );

          try
            DmFormaPagoTable.Append;
            DmFormaPagoFields.Plazos.Value := 1;
            DmFormaPagoFields.PrimerVencimiento.Value := 0;
            DmFormaPagoFields.Intervalo.Value := 0;
            DmFormaPagoFields.CrearRegistro.Value := True;
          finally
            DmFormaPagoTable.Browse;
            end;

          end;

     If   DmFormaPagoFields.CrearRegistro.Value
     then begin

          With DmFacturaComprasFields do
            SessionDataModule.Dm30.EfectoModule.ObtenVencimientos( scCompras, Ejercicio.Value, Proveedor.Value, SerieNroFactura.Value, 0, RelacionEfectos );

          With RelacionEfectos do
            begin

            If   DmFormaPagoFields.Plazos.Value=0
            then begin
                 FechaVencimiento[ 0 ] := DmFacturaComprasFields.Fecha.Value;
                 Importe[ 0 ] := DmFacturaComprasFields.TotalFactura.Value;
                 end;

            { Suprimo todos los efectos que pudieran existir de esta factura }

            With DmFacturaComprasFields do
              If   not SessionDataModule.Dm10.EfectoPagarModule.CompruebaEfectos( Ejercicio.Value, SubcuentaProveedor, SerieNroFactura.Value, True )
              then Abort;

            For Offset := 0 to NroEfectos do
              begin

              // Ejercicio;SubcuentaProveedor;Serie;NroFactura;NroEfecto

              If   Importe[ Offset ]<>0.0
              then If   not DmEfectoPagarTable.FindKey( [ DmFacturaComprasFields.Ejercicio.Value, SubcuentaProveedor, DmFacturaComprasFields.SerieNroFactura.Value, 0, Offset ] )
                   then begin

                        DmEfectoPagarTable.Append;

                        DmEfectoPagarFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                        DmEfectoPagarFields.SubcuentaProveedor.Value := SubcuentaProveedor;
                        DmEfectoPagarFields.Serie.Value := DmFacturaComprasFields.SerieNroFactura.Value;
                        DmEfectoPagarFields.NroFactura.Value := 0;
                        DmEfectoPagarFields.NroEfecto.Value := Offset;

                        If   FechaLibramiento[ Offset ]=0
                        then DmEfectoPagarFields.FechaLibramiento.Value := DmFacturaComprasFields.Fecha.Value
                        else DmEfectoPagarFields.FechaLibramiento.Value := FechaLibramiento[ Offset ];

                        DmEfectoPagarFields.FechaVencimiento.Value := FechaVencimiento[ Offset ];
                        DmEfectoPagarFields.Concepto.Value := SessionDataModule.Dm10.EfectoPagarModule.TextoConcepto( DmEfectoPagarFields );
                        DmEfectoPagarFields.SubcuentaEntidad.Value := SessionDataModule.Dm10.EfectoPagarModule.ObtenCanalPreferente( DmProveedorFields, DmFacturaComprasFields.CodigoFormaPago.Value );
                        DmEfectoPagarFields.Importe.Value := Importe[ Offset ];
                        DmEfectoPagarFields.FormaDePago.Value := DmFacturaComprasFields.CodigoFormaPago.Value;
                        DmEfectoPagarFields.CodigoProveedor.Value := DmFacturaComprasFields.Proveedor.Value;

                        If   Offset=0
                        then begin

                             With DmEfectoPagarFields do
                               begin

                               ImportePagado.Value := Importe.Value;
                               FechaPago.Value := FechaVencimiento.Value;

                               If   ImportePagado.Value>=0.0
                               then ConceptoPago.Value := RsMsg39
                               else ConceptoPago.Value := RsMsg40;

                               ConceptoPago.Value := ConceptoPago.Value + Serie.Value;
                               end;

                             SessionDataModule.Dm10.EfectoPagarModule.ActualizaAnotacionPago( DmEfectoPagarFields );
                             end
                        else DmEfectoPagarTable.Post;

                        end;
              end;
            end;

          end;

end;

begin

     Canceled := False;

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmAsientoTable,
                                                                     DmApunteTable,
                                                                     DmEfectoPagarTable,

                                                                     DmFacturaComprasTable ] );

     try

       With SessionDataModule.Dm10.TasaModule do
         begin

         CuentaCompras := ObtenRelacion( srCompras );
         If   CuentaCompras=''
         then begin
              CuentaCompras := SessionDataModule.Dm10.CuentaModule.CodigoCuentaDefecto( cpCtaCompras );
              SessionDataModule.Dm10.CuentaModule.InsertaSubcuenta( CuentaCompras, SessionDataModule.Dm10.CuentaModule.DescripcionCuentaDefecto( cpCtaCompras ) );
              end;

         CuentaDevCompras := ObtenRelacion( srDevolucionesCompras );
         If   CuentaDevCompras=''
         then begin
              CuentaDevCompras := SessionDataModule.Dm10.CuentaModule.CodigoCuentaDefecto( cpCtaDevCompras );
              SessionDataModule.Dm10.CuentaModule.InsertaSubcuenta( CuentaDevCompras, SessionDataModule.Dm10.CuentaModule.DescripcionCuentaDefecto( cpCtaDevCompras ) );
              end;

         CuentaDtoPP := ObtenRelacion( srDescuentoPP );
         If   CuentaDtoPP=''
         then begin
              CuentaDtoPP := SessionDataModule.Dm10.CuentaModule.CodigoCuentaDefecto( cpctaDescuentoPP );
              SessionDataModule.Dm10.CuentaModule.InsertaSubcuenta( CuentaDtoPP, SessionDataModule.Dm10.CuentaModule.DescripcionCuentaDefecto( cpctaDescuentoPP ) );
              end;

         CuentaRecargoFinanciero := ObtenRelacion( srRecargoFinancieroCompras );
         If   CuentaRecargoFinanciero=''
         then begin
              CuentaRecargoFinanciero := SessionDataModule.Dm10.CuentaModule.CodigoCuentaDefecto( cpCtaRecargoFinancieroCompras );
              SessionDataModule.Dm10.CuentaModule.InsertaSubcuenta( CuentaRecargoFinanciero, SessionDataModule.Dm10.CuentaModule.DescripcionCuentaDefecto( cpCtaRecargoFinancieroCompras ) );
              end;

         CuentaPortes := ObtenRelacion( srPortesCompras );
         If   CuentaPortes=''
         then begin
              CuentaPortes := SessionDataModule.Dm10.CuentaModule.CodigoCuentaDefecto( cpCtaPortesCompras );
              SessionDataModule.Dm10.CuentaModule.InsertaSubcuenta( CuentaPortes, SessionDataModule.Dm10.CuentaModule.DescripcionCuentaDefecto( cpCtaPortesCompras ) );
              end;

         TipoManual := TipoIVAGlobal( SessionDataModule.FechaHoy, rgTipoIVAManual );
         end;

       With DmFacturaComprasTable do
         try

           IndexFieldNames := 'FechaRecepcion';

           SetRange( [ FechaInicial ], [ FechaFinal ] );

           First;
           While not Eof do
             begin

             If   not DmFacturaComprasFields.Traspasada.Value
             then If   not SessionDataModule.Dm10.AsientoModule.TrimestreCorrecto( MonthOf( DmFacturaComprasFields.FechaRecepcion.Value ) )
                  then Canceled := SessionDataModule.SendNotification( ntWarning, Format( RsMsg52, [ DmFacturaComprasFields.SerieNroFactura.Value, DmFacturaComprasFields.Proveedor.Value ] ) )
                  else begin

                       InicializaPila;

                       ActualizaDatosEconomicos( DmFacturaComprasFields, DoInsertLine, False, True );

                       Offset := 0;
                       While ( Offset<PilaSubcuentas.Count ) do
                         begin

                         If   PilaSubcuentas[ Offset ].BaseImponible<>0.0
                         then begin

                              // Aprovecho para agrupar las bases imponibles por tipo impositivo

                              TipoImpositivo := PilaSubcuentas[ Offset ].TipoImpositivo;
                              BaseImp := PilaSubcuentas[ Offset ].BaseImponible;

                              If   DmFacturaComprasFields.DescuentoES.Value<>0.0
                              then begin
                                   ImporteDtoES := Redondea( ( BaseImp * DmFacturaComprasFields.DescuentoES.Value ) / 100 );
                                   PilaSubcuentas[ Offset ].BaseImponible := PilaSubcuentas[ Offset ].BaseImponible - ImporteDtoES;
                                   end;

                              end;

                         Inc( Offset );
                         end;

                       // Empieza el tratamiento de los descuentos en factura

                       If   ( DmFacturaComprasFields.DescuentoES.Value<>0.0 ) or
                            ( DmFacturaComprasFields.DescuentoPP.Value<>0.0 )
                       then begin

                            With DmFacturaComprasFields do
                              ObtenBasesyCuotasFactura( Ejercicio.Value, Proveedor.Value, SerieNroFactura.Value, TasasArray, ImporteCuotaIVA );

                            For Index := 0 to NroMaximoTiposTasas do
                              If   TasasArray[ Index ].TieneBases
                              then begin

                                   BaseCalculoDescuentos := TasasArray[ Index ].BaseImponible - TasasArray[ Index ].BaseNoSujetaDto;

                                   If   Index=SessionDataModule.Dm10.TasaModule.TipoIVAGlobal( DmFacturaComprasFields.Fecha.Value, rgTipoIVAPortes )
                                   then BaseCalculoDescuentos := BaseCalculoDescuentos - DmFacturaComprasFields.Portes.Value;

                                   If   DmFacturaComprasFields.DescuentoES.Value=0.0
                                   then ImporteDtoES := 0.0
                                   else ImporteDtoES := Redondea( ( BaseCalculoDescuentos * DmFacturaComprasFields.DescuentoES.Value ) / 100 );

                                   If   DmFacturaComprasFields.DescuentoPP.Value=0.0
                                   then ImporteDtoPP := 0.0
                                   else ImporteDtoPP := Redondea( ( ( BaseCalculoDescuentos - ImporteDtoES ) * DmFacturaComprasFields.DescuentoPP.Value ) / 100 );

                                   If   ImporteDtoPP<>0.0
                                   then begin
                                        If   CalcularIVA
                                        then TipoImpositivo := Index
                                        else TipoImpositivo := 0;
                                        InsertarEnPila( CuentaDtoPP, '', TipoImpositivo, -ImporteDtoPP, 0.0 );
                                        end;

                                   end;

                            end;

                       // Recargo financiero

                       With DmFacturaComprasFields do
                         If   ImporteRecFinanciero.Value<>0.0
                         then InsertarEnPila( CuentaRecargoFinanciero, '', 0, ImporteRecFinanciero.Value, 0.0 );

                       // Portes

                       If   DmFacturaComprasFields.Portes.Value<>0.0
                       then begin
                            If   CalcularIVA or ( DmFacturaComprasFields.Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ] )
                            then TipoImpositivo := SessionDataModule.Dm10.TasaModule.TipoIVAGlobal( DmFacturaComprasFields.Fecha.Value, rgTipoIVAPortes )
                            else TipoImpositivo := 0;
                            ObtenCuotaPortes( DmFacturaComprasFields.Portes.Value, DmFacturaComprasFields.Fecha.Value, DmProveedorFields.Factura_ModeloIVA.Value, CuotaIVAPortes );
                            // DecAdd( ListaBaseImponible[ TipoImpositivo ], DmFacturaComprasFields.Portes.Value );
                            InsertarEnPila( CuentaPortes, '', TipoImpositivo, DmFacturaComprasFields.Portes.Value, CuotaIVAPortes );
                            end;

                       // Si la factura tiene descuentos hay que recalcular las cuotas del I.V.A.

                       If   CalcularIVA and
                            ( ( DmFacturaComprasFields.DescuentoES.Value<>0.0 ) or ( DmFacturaComprasFields.DescuentoPP.Value<>0.0 ) )
                       then begin
                            Offset := 0;
                            While ( Offset<PilaSubcuentas.Count ) do
                              begin
                              If   ( PilaSubcuentas[ Offset ].BaseImponible<>0.0 ) and
                                   ( PilaSubcuentas[ Offset ].TipoImpositivo<>0 )
                              then begin
                                   SessionDataModule.Dm10.TasaModule.TipoIVA( DmFacturaComprasFields.Fecha.Value, PilaSubcuentas[ Offset ].TipoImpositivo, DsTiposIVAFields );
                                   PilaSubcuentas[ Offset ].CuotaIVA := Redondea( PilaSubcuentas[ Offset ].BaseImponible * DsTiposIVAFields.IVASoportado.Value / 100 );
                                   end;
                              Inc( Offset );
                              end;
                            end;

                       If   Contabilizar
                       then begin
                            GeneraAsiento;
                            If   ( DmFacturaComprasFields.TotalFactura.Value<>0.0 )
                            then GeneraEfectos;
                            end;

                       try
                         Edit;
                         DmFacturaComprasFields.Traspasada.Value := True;
                         Post;
                       except
                         Cancel;
                         raise;
                         end;
                       end;

             Next;

             If   Canceled
             then Abort;

             end;

         finally
           CancelRange;
           PilaSubcuentas.Clear;
           end;

       TransactionTag.Commit;

   except on E : Exception do
     begin
     TransactionTag.RollBack;
     SessionDataModule.SendNotification( ntError, RsMsg43 + HTML_BR + RsProcesoInterrumpido );
     end;
     end;

end;

procedure TFacturaComprasModule.InicializaPila;

var   Index  : SmallInt;

begin

     PilaSubcuentas.Clear;

     For Index := 0 to NroMaximoTiposTasas do
       begin

       SubcuentaFamilia := TSubcuentaFamilia.Create;

       SubcuentaFamilia.Activo := False;
       SubcuentaFamilia.Subcuenta := CuentaCompras;
       SubcuentaFamilia.CentroCoste := '';
       SubcuentaFamilia.TipoImpositivo := Index;

       PilaSubcuentas.Add( SubcuentaFamilia );

       end;

end;

procedure TFacturaComprasModule.InsertarEnPila( Subcuenta       : String;
                                                CentroCoste     : String;
                                                TipoImpositivo  : SmallInt;
                                                BaseImponible,
                                                CuotaIVA        : Decimal );

var   Encontrado : Boolean;
      Index : SmallInt;

begin

      Index := 0;
      Encontrado := False;

      repeat

        If   ( Subcuenta=PilaSubcuentas[ Index ].Subcuenta ) and
             ( CentroCoste=PilaSubcuentas[ Index ].CentroCoste ) and
             ( TipoImpositivo=PilaSubcuentas[ Index ].TipoImpositivo )
        then begin
             PilaSubcuentas[ Index ].Activo := True;
             PilaSubcuentas[ Index ].BaseImponible := PilaSubcuentas[ Index ].BaseImponible + BaseImponible;
             PilaSubcuentas[ Index ].CuotaIVA := PilaSubcuentas[ Index ].CuotaIVA + CuotaIVA;
             Encontrado := True;
             end
       else Inc( Index );

      until ( Index>=PilaSubcuentas.Count ) or
            Encontrado;

      If   not Encontrado
      then begin

           SubcuentaFamilia := TSubcuentaFamilia.Create;

           SubcuentaFamilia.Activo := True;
           SubcuentaFamilia.Subcuenta := Subcuenta;
           SubcuentaFamilia.CentroCoste := CentroCoste;
           SubcuentaFamilia.TipoImpositivo := TipoImpositivo;
           SubcuentaFamilia.BaseImponible  := BaseImponible;
           SubcuentaFamilia.CuotaIVA  := CuotaIVA;

           PilaSubcuentas.Add( SubcuentaFamilia );
           end;

end;

procedure TFacturaComprasModule.DoInsertLine( TipoIVAArticulo,
                                              TipoIVADefectoManual   : SmallInt;
                                              ProveedorFields        : TProveedorFields;
                                              ArticuloFields         : TArticuloFields;
                                              MovimientoFields       : TMovimientoFields;
                                              LineaMovimientoFields  : TLineaMovimientoFields );

begin
     With LineaMovimientoFields do
       begin

       //* 24.12.1999 Añadida la Cuenta de compras específica del proveedor

       If   ImporteNeto.Value<0.0
       then CodigoSubcuenta := CuentaDevCompras
       else If   ValueIsEmpty( ProveedorFields.Factura_CtaCompras.Value )
            then CodigoSubcuenta := CuentaCompras
            else CodigoSubcuenta := ProveedorFields.Factura_CtaCompras.Value;

       If   not ValueIsEmpty( ArticuloFields.Familia.Value )
       then If   DmFamiliaTable.FindKey( [ ArticuloFields.Familia.Value ] )
            then If   ImporteNeto.Value<0.0
                 then begin
                      If   not ValueIsEmpty( DmFamiliaFields.Cta_DevCompras.Value )
                      then CodigoSubcuenta := DmFamiliaFields.Cta_DevCompras.Value;
                      end
                 else If   not ValueIsEmpty( DmFamiliaFields.Cta_Compras.Value )
                      then CodigoSubcuenta := DmFamiliaFields.Cta_Compras.Value;

       InsertarEnPila( CodigoSubcuenta, MovimientoFields.CentroCoste.Value, TipoIVAArticulo, ImporteNeto.Value, CuotaIVA.Value );
       end;
end;

procedure TFacturaComprasModule.RecuperaFactura( Ejercicio         : SmallInt;
                                                 CodigoProveedor,
                                                 SerieNroFactura   : String );

var  SubcuentaProveedor : String;

begin
     DmFacturaComprasTable.IndexFieldNames := 'Ejercicio;Proveedor;SerieNroFactura';
     If   DmFacturaComprasTable.FindKey( [ Ejercicio, CodigoProveedor, SerieNroFactura ] )
     then If   DmFacturaComprasFields.Traspasada.Value
          then begin

               var TransactionTag := SessionDataModule.StartTransactionWith( [ DmFacturaComprasTable ] );

               try

                 If   DmProveedorTable.FindKey( [ DmFacturaComprasFields.Proveedor.Value ] )
                 then begin

                      SubcuentaProveedor := DmProveedorFields.Subcuenta.Value;

                      If   SessionDataModule.Dm10.EfectoPagarModule.CompruebaEfectos( DmFacturaComprasFields.Ejercicio.Value, SubcuentaProveedor, DmFacturaComprasFields.SerieNroFactura.Value )
                      then begin
                           SessionDataModule.Dm10.EfectoPagarModule.SuprimeEfectosFactura( DmFacturaComprasFields.Ejercicio.Value, SubcuentaProveedor, DmFacturaComprasFields.SerieNroFactura.Value );

                           With DmFacturaComprasFields do
                             If   DmAsientoTable.FindKey( [ taFraRecibida, Ejercicio.Value, SubcuentaProveedor, SerieNroFactura.Value, 0, NroEfectoRegistroFactura ] )
                             then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( DmAsientoFields )
                             else SessionDataModule.SendNotification( ntWarning, RsMsg66, RsMsg67 );

                           ActualizaDatosEconomicos( DmFacturaComprasFields, nil, True, True );
                           end
                      else Abort;

                      end;

                 try
                   DmFacturaComprasTable.Edit;
                   DmFacturaComprasFields.Traspasada.Value := False;
                   SessionDataModule.SendNotification( ntInformation, Format( RsMsg62, [ DmFacturaComprasFields.SerieNroFactura.Value, DmFacturaComprasFields.Proveedor.Value, DmProveedorFields.Nombre.Value ] ) );
                   DmFacturaComprasTable.Post;
                 except
                   DmFacturaComprasTable.Cancel;
                   raise;
                   end;

                 TransactionTag.Commit;

               except on E : Exception do
                 begin
                 TransactionTag.Rollback;
                 SessionDataModule.SendNotification( ntError, RsMsg63, Format( RsMsg64, [ ExceptionMessage( E, { AbortMessage } True ) ] ) );
                 end;
               end;

               end;
end;

procedure TFacturaComprasModule.ObtenBasesyCuotasFactura(     Ejercicio        : SmallInt;
                                                              CodigoProveedor,
                                                              SerieNroFactura  : String;
                                                          var TasasArray       : TTasasArray;
                                                          out TotalCuotaIVA    : Decimal );
begin

     FillChar( TasasArray, SizeOf( TTasasArray ) ,#0 );

     DmMovimientoTable.IndexFieldNames := 'TipoMovimiento;EjercicioFactura;PropietarioFactura;SerieFactura;NroFactura';

     With DmMovimientoTable do
       try

         SetRange( [ tmCompra, Ejercicio, CodigoProveedor, SerieNroFactura, 0 ] );

         First;
         While not Eof do
           begin

           With DmLineaMovimientoTable do
             begin

             With DmMovimientoFields do
               SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallInt, MaxSmallInt ] );

             First;
             While not Eof do
               begin
               var CodigoTipoIVA := DmLineaMovimientoFields.CodigoTipoIVA.Value;
               If   CodigoTipoIVA in [ 0..NroMaximoTiposTasas ]
               then begin
                    TasasArray[ CodigoTipoIVA ].TieneBases := True;
                    DecAdd( TasasArray[ CodigoTipoIVA ].BaseImponible, DmLineaMovimientoFields.ImporteNeto.Value );
                    DecAdd( TasasArray[ CodigoTipoIVA ].BaseNoSujetaDto, DmLineaMovimientoFields.CantidadAjustada.Value * DmLineaMovimientoFields.PuntoVerde.Value );
                    DecAdd( TasasArray[ CodigoTipoIVA ].CuotaIVA, DmLineaMovimientoFields.CuotaIVA.Value );
                    DecAdd( TasasArray[ CodigoTipoIVA ].CuotaRE, DmLineaMovimientoFields.CuotaRE.Value );
                    DecAdd( TasasArray[ CodigoTipoIVA ].Importe, DmLineaMovimientoFields.ImporteTotal.Value );
                    If   ( CodigoTipoIVA<>0 ) and ( TasasArray[ CodigoTipoIVA ].TipoIVA=0.0 )
                    then begin
                         SessionDataModule.Dm10.TasaModule.TipoIVA( DmLineaMovimientoFields.Fecha.Value, CodigoTipoIVA, DsTiposIVAFields );
                         TasasArray[ CodigoTipoIVA ].TipoIVA := DsTiposIVAFields.IVASoportado.Value;
                         end;
                    end;
               Next;
               end;

             end;

           Next;
           end;

         // Obtengo la sumas de cuotas del IVA

         TotalCuotaIVA := 0.0;
         For var I := 0 to NroMaximoTiposTasas do
           If   TasasArray[ I ].CuotaIVA<>0.0
           then DecAdd( TotalCuotaIVA, Redondea( TasasArray[ I ].CuotaIVA ) );

       finally
         DmMovimientoTable.CancelRange;
         DmMovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion';
         DmLineaMovimientoTable.CancelRange;
         end;

end;

procedure TFacturaComprasModule.RecalculaFactura(     FacturaCompras    : IFacturaCompras;
                                                      ModificarCuotaIVA : Boolean );

var  TableCursor : TnxServerTableCursor;
     TasasArray : TTasasArray;

begin
     DmFacturaComprasTable.IndexFieldNames := 'Ejercicio;Proveedor;SerieNroFactura';
     If   TnxServerTableCursor.LookupByID( FacturaCompras.RemoteCursorID, TableCursor )=DBIERR_NONE
     then If   DmFacturaComprasTable.FindKey( [ FacturaCompras.Ejercicio, FacturaCompras.Proveedor ,FacturaCompras.SerieNroFactura ] )
          then begin
               TableCursor.RecordLockRelease( False );
               FacturaCompras.ToDataset( DmFacturaComprasFields );
               RecalculaFactura( DmFacturaComprasFields, True, ModificarCuotaIVA, TasasArray );
               DmFacturaComprasTable.Post;
               end;
end;

procedure TFacturaComprasModule.RecalculaAlbaranesFactura( Ejercicio        : SmallInt;
                                                           CodigoProveedor,
                                                           SerieNroFactura  : String );
begin
     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmMovimientoTable ] );

     try

       With DmMovimientoTable do
         begin

         IndexFieldNames := 'TipoMovimiento;EjercicioFactura;PropietarioFactura;SerieFactura;NroFactura';

         SetRange( [ tmCompra, Ejercicio, CodigoProveedor, SerieNroFactura ] );

         First;
         While not Eof do
           begin
           SessionDataModule.Dm30.MovimientoModule.RecalculaMovimiento( DmMovimientoFields  );
           Next;
           end;

         end;

       TransactionTag.Commit;

     except on E : exception do
       begin
       TransactionTag.Rollback;
       SessionDataModule.SendDatabaseError( nil, E );
       raise;
       end;

     end;
end;

procedure TFacturaComprasModule.RecalculaFactura(     FacturaComprasFields : TFacturaComprasFields;
                                                      RecuperaProveedor,
                                                      ModificarCuotaIVA    : Boolean;
                                                  var TasasArray           : TTasasArray );

Var  SumaBaseImponible : Decimal;
     Indice : SmallInt;
     ImporteBaseImp,
     ImporteDescuentos,
     ImporteBaseDescuentos,

     SumaDtosProveedor,
     SumaDtosProveedorRetencion,
     NetoFacturaBaseDtos,
     NetoFraRetencionBaseDtos : Decimal;

     TipoIVAPortes : SmallInt;
     CuotaIVAPortes : Decimal;

     RecalcularIVA : Boolean;

begin

     SumaBaseImponible  := 0.0;

     With FacturaComprasFields do
       begin

       If   RecuperaProveedor
       then If   DmProveedorTable.FindKey( [ Proveedor.Value ] )
            then begin
                 CalcularIVA := ( DmProveedorFields.Factura_ModeloIVA.Value<>mipExento ) and not ( Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ] );
                 AplicaCondicionesPago( FacturaComprasFields, False );
                 end
            else begin
                 SessionDataModule.SendNotification( ntStop, Format( RsMsg10, [ Proveedor.Value ] ), RsMsg11 );
                 Abort;
                 end;

       ObtenBasesyCuotasFactura( Ejercicio.Value, Proveedor.Value, SerieNroFactura.Value, TasasArray, ImporteCuotaIVA );

       TipoIVAPortes := SessionDataModule.Dm10.TasaModule.TipoIVAGlobal( Fecha.Value, rgTipoIVAPortes );

       If   Portes.Value<>0.0
       then begin
            TasasArray[ TipoIVAPortes ].BaseImponible := TasasArray[ TipoIVAPortes ].BaseImponible + Portes.Value;
            TasasArray[ TipoIVAPortes ].TieneBases := True;
            end;

       { Si la factura tiene descuentos hay que recalcular las cuotas sí o sí }

       RecalcularIVA := ( DescuentoES.Value<>0.0 ) or ( DescuentoPP.Value<>0.0 );

       If   ModificarCuotaIVA
       then If   RecalcularIVA
            then CuotaIVA.Value := 0.0
            else begin

                 CuotaIVA.Value := ImporteCuotaIVA;

                 If   ( Portes.Value<>0.0 ) and not ( Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ] )
                 then begin
                      ObtenCuotaPortes( Portes.Value, Fecha.Value, DmProveedorFields.Factura_ModeloIVA.Value, CuotaIVAPortes );
                      CuotaIVA.Value := CuotaIVA.Value + CuotaIVAPortes;
                      end;

                 end;

       For Indice := 0 to NroMaximoTiposTasas do
         If   TasasArray[ Indice ].TieneBases
         then begin

              TasasArray[ Indice ].BaseImponible := Redondea( TasasArray[ Indice ].BaseImponible );

              ImporteBaseImp := TasasArray[ Indice ].BaseImponible;

              DecAdd( SumaBaseImponible, TasasArray[ Indice ].BaseImponible );

              ImporteBaseDescuentos := ImporteBaseImp;
              If   Indice=TipoIVAPortes
              then ImporteBaseDescuentos := ImporteBaseDescuentos - Portes.Value;

              ImporteBaseDescuentos := ImporteBaseDescuentos - TasasArray[ Indice ].BaseNoSujetaDto;
              ImporteDescuentos := 0.0;

              If   DescuentoES.Value<>0.0
              then DecAdd( ImporteDescuentos, Redondea( ( ImporteBaseDescuentos * DescuentoES.Value ) / 100.0 ) );
              If   DescuentoPP.Value<>0.0
              then DecAdd( ImporteDescuentos, Redondea( ( ( ImporteBaseDescuentos - ImporteDescuentos ) * DescuentoPP.Value ) / 100.0 ) );

              DecAdd( ImporteBaseImp, -ImporteDescuentos );

              If   ModificarCuotaIVA and
                   RecalcularIVA and
                   CalcularIVA  and
                   ( Indice<>0 )
              then begin
                   SessionDataModule.Dm10.TasaModule.TipoIVA( Fecha.Value, Indice, DsTiposIVAFields );
                   ImporteCuotaIVA := Redondea( ( ImporteBaseImp * DsTiposIVAFields.IVASoportado.Value ) / 100.0 );
                   CuotaIVA.Value := CuotaIVA.Value + ImporteCuotaIVA;
                   end;

              end;

         CuotaIVA.Value := Redondea( CuotaIVA.Value );

         NetoFactura.Value := SumaBaseImponible - Portes.Value;
         NetoFacturaBaseDtos := NetoFactura.Value - ImportePuntoVerde.Value;
         NetoFraRetencionBaseDtos := NetoFacturaRetencion.Value - ImportePuntoVerde.Value;

         If   ValueIsEmpty( DescuentoES.Value )
         then begin
              ImporteDtoES.Value := 0.0;
              ImporteDtoESRetencion := 0.0;
              end
         else begin
              ImporteDtoES.Value := Redondea( ( NetoFacturaBaseDtos * DescuentoES.Value ) / 100.0 );
              ImporteDtoESRetencion := Redondea( ( NetoFraRetencionBaseDtos * DescuentoES.Value ) / 100.0 );
              end;

         If   ValueIsEmpty( DescuentoPP.Value )
         then begin
              ImporteDtoPP.Value := 0.0;
              ImporteDtoPPRetencion := 0.0;
              end
         else begin
              ImporteDtoPP.Value := Redondea( ( ( NetoFacturaBaseDtos - ImporteDtoES.Value ) * DescuentoPP.Value ) / 100.0 );
              ImporteDtoPPRetencion := Redondea( ( ( NetoFraRetencionBaseDtos - ImporteDtoESRetencion ) * DescuentoPP.Value ) / 100.0 );
              end;

         SumaDtosProveedor := ImporteDtoPP.Value + ImporteDtoES.Value;
         SumaDtosProveedorRetencion := ImporteDtoPPRetencion + ImporteDtoESRetencion;

         If   ValueIsEmpty( RecargoFinanciero.Value )
         then begin
              ImporteRecFinanciero.Value := 0.0;
              ImporteRecFinancRetencion := 0.0;
              end
         else begin
              ImporteRecFinanciero.Value := Redondea( ( ( NetoFactura.Value - SumaDtosProveedor ) * RecargoFinanciero.Value ) / 100.0 );
              ImporteRecFinancRetencion := Redondea( ( ( NetoFacturaRetencion.Value - SumaDtosProveedorRetencion ) * RecargoFinanciero.Value ) / 100.0 );
              end;

       DescuentoProveedores.Value := Redondea( SumaDtosProveedor );
       TotalFactura.Value := NetoFactura.Value - DescuentoProveedores.Value + ImporteRecFinanciero.Value + Portes.Value;

       If   CalcularIVA and not ( Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ] )
       then TotalFactura.Value := TotalFactura.Value + CuotaIVA.Value;

       If   ValueIsEmpty( TipoRetencion.Value )
       then ImporteRetencion.Value := 0.0
       else If   SessionDataModule.Dm10.TasaModule.TipoRetencion( Fecha.Value, TipoRetencion.Value, DsTiposRetencionFields )
            then begin
                 If   DsTiposRetencionFields.SobreTotal.Value
                 then BaseCalculoRetencion.Value := TotalFactura.Value  // No se consideran los artículos no sujetos a retención
                 else BaseCalculoRetencion.Value := NetoFacturaRetencion.Value - SumaDtosProveedorRetencion + ImporteRecFinancRetencion;
                 ImporteRetencion.Value := Redondea( BaseCalculoRetencion.Value * DsTiposRetencionFields.Retencion.Value / 100.0 );
                 TotalFactura.Value := TotalFactura.Value - ImporteRetencion.Value;
                 end
            else begin
                 SessionDataModule.SendNotification( ntStop, Format( RsMsg55, [ TipoRetencion.Value ] ) );
                 Abort;
                 end;

       With FacturaComprasFields do
         If   ValueIsEmpty( DmFormaPagoFields.Plazos.Value )
         then SessionDataModule.Dm30.EfectoModule.SuprimeEfectos( scCompras, Proveedor.Value, SerieNroFactura.Value, 0 )
         else begin
              DesgloseVencimientos( Fecha.Value,
                                    DmFormaPagoFields.Plazos.Value,
                                    DmFormaPagoFields.PrimerVencimiento.Value,
                                    DmFormaPagoFields.Intervalo.Value,
                                    DiaPago1.Value,
                                    DiaPago2.Value,
                                    DmProveedorFields.Pago_MesNoPago.Value,
                                    False,
                                    TotalFactura.Value,
                                    RelacionEfectos );

              SessionDataModule.Dm30.EfectoModule.GeneraEfectos( scCompras, Proveedor.Value, SerieNroFactura.Value, 0, Fecha.Value, RelacionEfectos );
              end;

       end;

end;

function TFacturaComprasModule.GeneraFacturas( ParametrosFacturacion      : IParametrosFacturacion;
                                               RelacionAlbaranesTableName : String = '' ) : IParametrosFacturacion;

var  Canceled,
     Correct,
     PrimerAlbaran : Boolean;

     NroRegistroRelacion : Integer;

     SerieNroFactura,
     CodigoProveedorActual : String;

     SumaDtosArticulo,
     SumaNeto,
     SumaIVAIncluido,
     SumaDtosProveedor,

     TotalAlbaran : Decimal;

     RelacionAlbaranesFields : TRelacionAlbaranesFields;

     FechaAplicacion,
     FechaAplicacionFacturacion : TDate;

     TasasArray : TTasasArray;

procedure CalculoLinea;
begin

       With DmLineaMovimientoFields do
         begin

         SessionDataModule.Dm30.ArticuloModule.Obten( CodigoArticulo.Value, DsArticuloFields );

         PuntoVerdeLinea := Cantidad.Value * PuntoVerde.Value;

         DmFacturaComprasFields.ImportePuntoVerde.Value := DmFacturaComprasFields.ImportePuntoVerde.Value + PuntoVerdeLinea;

         DecAdd( SumaBruto, ImporteBruto.Value );
         DecAdd( SumaDtosArticulo, ImporteDescuento.Value );
         DecAdd( SumaNeto, ImporteNeto.Value );
         DecAdd( SumaIVAIncluido, ImporteTotal.Value );

         If   not ValueIsEmpty( DmFacturaComprasFields.TipoRetencion.Value ) and not DsArticuloFields.NoAplicarRetencion.Value
         then DecAdd( SumaNetoRetencion, ImporteNeto.Value );

         DecAdd( TasasArray[ CodigoTipoIVA.Value ].BaseImponible, ImporteNeto.Value );
         DecAdd( TasasArray[ CodigoTipoIVA.Value ].BaseNoSujetaDto, PuntoVerdeLinea );

         DecAdd( TotalAlbaran, ImporteNeto.Value );
         end;
end;

begin

     If   not SessionDataModule.IsValidYear( ParametrosFacturacion.FechaFacturacion )
     then begin
          SessionDataModule.SendNotification( ntStop, RsMsg20, RsMsg6 );
          Abort;
          end;

     try

       try

         With ParametrosFacturacion, DmMovimientoTable do
           begin

           FechaAplicacionFacturacion := SessionDataModule.Dm10.TasaModule.UltimaFechaAplicacion( FechaFacturacion );

           RelacionAlbaranesTable.PreserveTemporalTableName := RelacionAlbaranesTableName<>'';
           If   RelacionAlbaranesTable.PreserveTemporalTableName
           then RelacionAlbaranesTable.TableName := RelacionAlbaranesTableName;

           RelacionAlbaranesTable.Open;

           RelacionAlbaranesFields := TRelacionAlbaranesFields.Create( RelacionAlbaranesTable );

           If   TipoSeleccion<>tsRelacion
           then try

                  RelacionAlbaranesTable.DeleteRecords( True );   // Por si acaso

                  If   not UnaSolaFactura
                  then Canceled := SessionDataModule.SendNotification( ntInformation, RsMsg17 );

                  case TipoSeleccion of
                    tsDocumento :
                      begin
                      IndexFieldNames := 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento';
                      SetRange( [ tmCompra, SessionDataModule.Ejercicio, PropietarioInicial, SerieInicial, NroDocumentoInicial ],
                                [ tmCompra, SessionDataModule.Ejercicio, PropietarioFinal, SerieFinal, NroDocumentoFinal ] );
                      end;
                    tsFecha :
                      begin
                      IndexFieldNames := 'TipoMovimiento;Propietario;Fecha';
                      SetRange( [ tmCompra, PropietarioInicial, FechaInicial ],
                                [ tmCompra, PropietarioFinal, FechaFinal ] );
                      end;
                    end;

                  NroRegistroRelacion := 1;

                  First;
                  While not Eof do
                    begin

                    If   not DmMovimientoFields.NoFacturar.Value and
                         not DmMovimientoFields.Facturado.Value and
                         (  UnaSolaFactura or ( not UnaSolaFactura and ( ( DmMovimientoFields.Serie.Value=Serie ) or ( Serie='' ) ) ) )
                    then begin

                         With RelacionAlbaranesTable do
                           begin

                           Append;

                           With RelacionAlbaranesFields do
                             begin
                             RelacionAlbaranesFields.NroRegistro.Value := NroRegistroRelacion;
                             Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
                             Propietario.Value := DmMovimientoFields.Propietario.Value;
                             Fecha.Value := DmMovimientoFields.Fecha.Value;
                             Serie.Value := DmMovimientoFields.Serie.Value;
                             NroDocumento.Value := DmMovimientoFields.NroDocumento.Value;
                             NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
                             end;

                           Post;

                           Inc( NroRegistroRelacion );

                           With DmMovimientoFields do
                             Canceled := SessionDataModule.SendNotification( ntRecord, Format( RsMsg22, [ Propietario.Value, Serie.Value ] ) );

                           end;

                         end;

                    If   Canceled
                    then Abort;

                    Next;
                    end;

                finally
                  CancelRange;
                  end;

           If   not UnaSolaFactura
           then Canceled := SessionDataModule.SendNotification( ntInformation, RsMsg18 );

           IndexFieldNames := 'Ejercicio;NroOperacion';

           With RelacionAlbaranesTable do
             begin
             IndexFieldNames := 'Codigo;Propietario;Fecha;Serie;NroDocumento';
             CancelRange;
             First;
             While not Eof do
               begin

               If   DmMovimientoTable.FindKey( [ RelacionAlbaranesFields.Ejercicio.Value, RelacionAlbaranesFields.NroOperacion.Value ] )
               then begin

                    Correct := True;
                    CodigoProveedorActual := RelacionAlbaranesFields.Propietario.Value;

                    If   DmProveedorTable.FindKey( [ DmMovimientoFields.Propietario.Value ] )
                    then CalcularIVA := ( DmProveedorFields.Factura_ModeloIVA.Value<>mipExento ) and not ( DmProveedorFields.Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ] )
                    else begin
                         With DmMovimientoFields do
                           SessionDataModule.SendNotification( ntStop, Format( RsMsg2, [ Propietario.Value, NroDocumento.Value ] ), '' );
                         Abort;
                         end;

                    If   Correct
                    then begin

                         // Ejercicio;Proveedor;SerieNroFactura

                         If   UnaSolaFactura
                         then SerieNroFactura := Serie
                         else SerieNroFactura := ProximaSerieNroFactura( SessionDataModule.Ejercicio, DmMovimientoFields.Propietario.Value, Serie );

                         var TransactionTag := SessionDataModule.StartTransactionWith(  [ DmMovimientoTable,
                                                                                          DmProveedorDatEconTable,
                                                                                          DmFacturaTable,
                                                                                          DmFacturaComprasTable ],

                                                                                          False );   // Sin notificaciones

                         try

                           DmFacturaComprasTable.Append;

                           DmFacturaComprasFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                           DmFacturaComprasFields.Proveedor.Value := DmMovimientoFields.Propietario.Value;
                           DmFacturaComprasFields.SerieNroFactura.Value := SerieNroFactura;

                           DmFacturaComprasFields.Fecha.Value := FechaFacturacion;
                           DmFacturaComprasFields.FechaRecepcion.Value := FechaFacturacion;
                           DmFacturaComprasFields.Proveedor.Value := DmMovimientoFields.Propietario.Value;
                           DmFacturaComprasFields.DescuentoES.Value := DmProveedorFields.Factura_DtoES.Value;
                           DmFacturaComprasFields.TipoRetencion.Value := DmProveedorFields.Factura_TipoRet.Value;
                           DmFacturaComprasFields.CodigoFormaPago.Value := DmProveedorFields.Pago_FormaPago.Value;
                           DmFacturaComprasFields.Origen.Value := DmProveedorFields.Origen.Value;

                           SumaCoste := 0.0;
                           SumaBruto := 0.0;
                           SumaNeto := 0.0;
                           SumaNetoRetencion := 0.0;
                           SumaDtosArticulo := 0.0;
                           SumaDtosProveedor := 0.0;
                           SumaIVAIncluido := 0.0;

                           FillChar( TasasArray, SizeOf( TasasArray ), #0 );

                           AplicaCondicionesPago( DmFacturaComprasFields );

                           PrimerAlbaran := True;

                           While not Eof and ( CodigoProveedorActual=RelacionAlbaranesFields.Propietario.Value ) do
                             begin

                             If   DmMovimientoTable.FindKey( [ RelacionAlbaranesFields.Ejercicio.Value, RelacionAlbaranesFields.NroOperacion.Value ] )
                             then begin

                                  // Comprobando que el usuario no mezcle documentos de periodos impositivos distintos en la facturación

                                  FechaAplicacion := SessionDataModule.Dm10.TasaModule.UltimaFechaAplicacion( DmMovimientoFields.Fecha.Value );
                                  If   FechaAplicacionFacturacion<>FechaAplicacion
                                  then With DmMovimientoFields do
                                         begin
                                         SessionDataModule.SendNotification( ntStop, RsMsg41, Format( RsMsg42, [ Serie.Value, NroDocumento.Value, Propietario.Value ] ) );
                                         Abort;
                                         end;

                                  With DmMovimientoFields do
                                    Canceled := SessionDataModule.SendNotification( ntRecord, Format( RsMsg22, [ Propietario.Value, Serie.Value, NroDocumento.Value ] ) );

                                  DmFacturaComprasFields.Portes.Value := DmFacturaComprasFields.Portes.Value + DmMovimientoFields.Portes.Value;

                                  TotalAlbaran := 0.0;
                                  With DmLineaMovimientoTable do
                                    try

                                      With DmMovimientoFields do
                                        SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallInt, MaxSmallInt ] );
                                      First;
                                      While not Eof do
                                        begin
                                        CalculoLinea;
                                        Next;
                                        end;

                                    finally
                                      CancelRange;
                                      end;

                                  try
                                    DmMovimientoTable.Edit;

                                    DmMovimientoFields.NoFacturar.Value := False;
                                    DmMovimientoFields.Facturado.Value := True;
                                    DmMovimientoFields.EjercicioFactura.Value := DmFacturaComprasFields.Ejercicio.Value;
                                    DmMovimientoFields.SerieFactura.Value := DmFacturaComprasFields.SerieNroFactura.Value;
                                    DmMovimientoFields.NroFactura.Value := 0;
                                    DmMovimientoFields.PropietarioFactura.Value := DmFacturaComprasFields.Proveedor.Value;

                                    DmMovimientoTable.Post;

                                  except
                                    DmMovimientoTable.Cancel;
                                    raise;
                                    end;

                                  end;

                             Canceled := SessionDataModule.SendNotification( ntRecord, Format( RsMsg19, [ DmFacturaComprasFields.Proveedor.Value,
                                                                                                          DmFacturaComprasFields.SerieNroFactura.Value,
                                                                                                          DmMovimientoFields.NroDocumento.Value ] ) );

                             If   Canceled
                             then Abort;

                             Next;
                             end;

                           DmFacturaComprasFields.NetoFacturaRetencion.Value := Redondea( SumaNetoRetencion );

                           RecalculaFactura( DmFacturaComprasFields, False, True, TasasArray );

                           DmFacturaComprasFields.BrutoArticulos.Value := Redondea( SumaBruto );
                           DmFacturaComprasFields.DescuentoArticulos.Value := Redondea( SumaDtosArticulo );

                           // Creando el registro de la factura con los datos fiscales

                           With DmFacturaComprasFields do
                             try

                               If   DmFacturaTable.FindKey( [ tfFacturaCompras, Ejercicio.Value, Proveedor.Value, SerieNroFactura.Value, 0 ] )
                               then DmFacturaTable.Edit
                               else begin
                                    DmFacturaTable.Append;

                                    DmFacturaFields.Tipo.Value := tfFacturaCompras;
                                    DmFacturaFields.Ejercicio.Value := Ejercicio.Value;
                                    DmFacturaFields.Propietario.Value := Proveedor.Value;
                                    DmFacturaFields.SerieFactura.Value := SerieNroFactura.Value;
                                    DmFacturaFields.NroRegistro.Value := 0;

                                    end;

                               SessionDataModule.Dm10.FacturaModule.CompletaRegistroFacturaRecibida( DmProveedorFields.Subcuenta.Value,
                                                                                                     DmProveedorFields.CodigoPais.Value,
                                                                                                     DmProveedorFields.Factura_ModeloIVA.Value,
                                                                                                     DmFacturaFields );

                               DmFacturaTable.Post;

                             except
                               DmFacturaTable.Cancel;
                               raise;
                               end;

                           DmFacturaComprasTable.Post;

                           TransactionTag.Commit;

                           With DmFacturaComprasFields do
                             Canceled := SessionDataModule.SendNotification( ntInformation, Format( RsMsg25, [ SerieNroFactura.Value, Proveedor.Value, DmProveedorFields.Nombre.Value ] ) );

                           If   Canceled
                           then Abort;

                         except
                           DmFacturaComprasTable.Cancel;
                           TransactionTag.Rollback;
                           raise;
                           end;

                         end
                    else While not Eof and ( CodigoProveedorActual=RelacionAlbaranesFields.Propietario.Value ) do
                           Next;

                    end
               else begin
                    SessionDataModule.SendNotification( ntStop, Format( RsMsg5, [ RelacionAlbaranesFields.NroDocumento ] ) );
                    Abort;
                    end;

               end;

             end;

           end;

       except
         RelacionAlbaranesTable.Close;
         SessionDataModule.SendNotification( ntExceptionError, RsMsg6, RsMsg7 );
         end;

     finally
       RelacionAlbaranesTable.Close;
       Result := ParametrosFacturacion;
       end;

end;

{ TFacturaComprasService }

procedure TFacturaComprasService.AssignSession( const SessionID : Integer );
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

function TFacturaComprasService.GeneraFacturas( ParametrosFacturacion: IParametrosFacturacion; RelacionAlbaranesTableName: String): IParametrosFacturacion;
begin
     Result := SessionDataModule.Dm30.FacturaComprasModule.GeneraFacturas( ParametrosFacturacion, RelacionAlbaranesTableName );
end;

procedure TFacturaComprasService.RecalculaAlbaranesFactura( Ejercicio: SmallInt; CodigoProveedor, SerieNroFactura: String);
begin
     SessionDataModule.Dm30.FacturaComprasModule.RecalculaAlbaranesFactura( Ejercicio, CodigoProveedor, SerieNroFactura );
end;

procedure TFacturaComprasService.RecalculaFactura( FacturaCompras : IFacturaCompras; ModificarCuotaIVA : Boolean );
begin
     SessionDataModule.Dm30.FacturaComprasModule.RecalculaFactura( FacturaCompras, ModificarCuotaIVA );
end;

procedure TFacturaComprasService.RecuperaFactura(Ejercicio: SmallInt; CodigoProveedor, SerieNroFactura : String );
begin
     SessionDataModule.Dm30.FacturaComprasModule.RecuperaFactura( Ejercicio, CodigoProveedor, SerieNroFactura );
end;

procedure TFacturaComprasService.CierreCicloFacturacion( FechaInicial, FechaFinal: TDate; Contabilizar : Boolean );
begin
     SessionDataModule.Dm30.FacturaComprasModule.CierreCicloFacturacion( FechaInicial, FechaFinal, Contabilizar );
end;

var  FacturaComprasControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_FacturaComprasService, TFacturaComprasService, FacturaComprasControl );

end.
