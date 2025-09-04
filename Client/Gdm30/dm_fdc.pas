
unit dm_fdc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB,
  nxdb,

  AppManager,
  DataManager,
  ReportManager,
  AppForms,
  LibUtils,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,

  dmi_fdc,

  FacturaComprasIntf,
  ParametrosFacturacionIntf;

const FmtCantidadCompra  = 'FmtCantidadCompra';
      FmtPrecioCompra    = 'FmtPrecioCompra';
      FmtDescuentoCompra = 'FmtDescuentoCompra';

      // Origen de las facturas de compras

      ofrSujetoPasivo     = 0;
      ofrIntracomunitaria = 1;
      ofrInversionSP      = 2;

      // Parámetros del registro

      ncrMostrarAnotacionesCompras = 'MostrarAnotacionesCompras';

type

  TOrigenFactura = ofrSujetoPasivo..ofrInversionSP;

  TInsertLineEvent = procedure( TipoIVAArticulo, TipoIVADefectoManual : SmallInt; ProveedorFields : TProveedorFields; ArticuloFields : TArticuloFields; MovimientoFields : TMovimientoFields;LineaMovimientoFields : TLineaMovimientoFields ) of object;

  TFacturaComprasModule = class(TDataModule)
    DmEfectoTable: TnxeTable;
    DmProveedorTable: TnxeTable;
    DmProveedorDatEconTable: TnxeTable;
    DmFormaPagoTable: TnxeTable;
    Report: TgxReportManager;
    DmArticuloDatEconTable: TnxeTable;
    DmFacturaComprasTable: TnxeTable;
    DmMovimientoTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    DmFacturaComprasAuxTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure ReportSetReportName;
    procedure ReportSelectPrinter;

  private

    FacturaComprasService : IFacturaComprasService;

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
    ImporteDtoPPRetencion,

    SumaDtosArticulo,
    SumaDtosProveedor,
    TotalAlbaran : Decimal;

    RelacionEfectos : TRelacionEfectos;

    CodigoProveedorActual : String;
    PrimerAlbaran : Boolean;
    FormatoImpreso : SmallInt;  // Actualizado por imprimefacturas para que pueda ser utilizado por el Report

    procedure AplicaCondicionesPago( FacturaComprasFields : TFacturaComprasFields; aplicarDescuentoyRecargo : Boolean = True );

  public

    DmFacturaComprasFields,
    DmFacturaComprasAuxFields : TFacturaComprasFields;
    DmEfectoFields : TEfectoFields;
    DmMovimientoFields : TMovimientoFields;
    DmLineaMovimientoFields : TLineaMovimientoFields;
    DmProveedorFields : TProveedorFields;
    DmProveedorDatEconFields : TProveedorDatEconFields;
    DmFormaPagoFields : TFormaPagoFields;
    DmArticuloDatEconFields : TArticuloDatEconFields;
    DsTiposIVAFields : TTiposIVAFields;
    DsDivisaFields : TDivisaFields;

    DsArticuloFields : TArticuloFields;

    NroTotalCopias,
    NroOperacionActual : LongInt;

    CalcularIVA : Boolean;
    TipoIVADefectoManual : SmallInt;

    function Obten( Ejercicio : SmallInt; Propietario : String; SerieNroFactura : String; FacturaComprasFields : TFacturaComprasFields = nil ) : Boolean;
    procedure Suprime( Propietario : String; SerieNroFactura : String );
    procedure SuprimeRelaciones( FacturaComprasFields : TFacturaComprasFields; SuprimeRegistroFactura : Boolean = True );
    function DesgloseIVA( LineaDesglose, Opcion : SmallInt; var TasasArray : TTasasArray ) : Decimal;

    procedure ObtenTipoIVAArticulo( Fecha : TDateTime; ArticuloFields : TArticuloFields; ProveedorFields : TProveedorFields; TiposIVAFields : TTiposIVAFields = nil);
    function TextoOrigen( Origen : TOrigenFactura ) : String;

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
                                   TiposIVAFields         : TTiposIVAFields ); overload;

    procedure FijaDecimalesInforme( Report : TgxReportManager );
    procedure ObtenCuotaPortes( Importe : Decimal; Fecha : TDate; ModeloIVA : SmallInt; var CuotaIVA  : Decimal );
    procedure AcumulaValoresImpositivos( var TasasArray: TTasasArray; Fecha: TDate; ModeloIVA: SmallInt; CalcularIVA: Boolean; var Sumas: TTasaRecord);

    procedure RecalculaFactura( FacturaComprasFields : TFacturaComprasFields; ModificarCuotaIVA : Boolean );
    function  GeneraFacturas( ParametrosFacturacion : IParametrosFacturacion; RelacionAlbaranesTable : TnxeTable = nil ) : IParametrosFacturacion;    procedure ImprimeFacturas( ParametrosFacturacion : IParametrosFacturacion );
    procedure CierreCicloFacturacion( FechaInicial, FechaFinal : TDate; Contabilizar : Boolean );
    procedure RecuperaFactura( Ejercicio : SmallInt; CodigoProveedor, SerieNroFactura : String );
    procedure RecalculaAlbaranesFactura( Ejercicio : SmallInt; CodigoProveedor, SerieNroFactura  : String );
  end;

var  FacturaComprasModule: TFacturaComprasModule = nil;

function FacturaCompras : TFacturaComprasModule;

implementation

uses cxEdit,

     DateUtils,
     EnterpriseDataAccess,
     NexusRpcData,
     AppContainer,

     Gdm00Dm,
     Gdm30Dm,

     dmi_iva,
     dmi_mov,
     dmi_fac,

     dm_emp,
     dm_cdi,
     dm_tca,
     dm_efe,
     dm_pro,
     dm_rpr,  // Relaciones de proveedores
     dm_iva,
     dm_pga,
     dm_mov,
     dm_art,
     dm_sto,
     dm_ecc,   // por desgloseVencimientos
     dm_ecp,
     dm_fpa,
     dm_cls,
     dm_fac,
     dm_ine,

     b_msg,
     b_pro,
     f_prg;

const

     DecimalesImportesCuotas = 4;  // En compras los cálculos nunca llevan el IVA incluido

{$R *.DFM}

resourceString
     RsMsg1  = 'No encuentro la factura a eliminar.';
     RsMsg2  = 'La ficha del proveedor %s ha sido dada de baja. El albarán %d no será facturado.';
     RsMsg3  = 'Número de factura duplicado.';
     RsMsg4  = 'El número de factura %d  ya existe. El programa le asignará a la nueva factura el número %d.';
     RsMsg5  = 'Ha desaparecido el albarán nº %d que había seleccionado previamente para facturar.';
     RsMsg6  = 'Se ha interrumpido el proceso de facturación.';
     RsMsg7  = 'La factura que estaba intendo emitir no ha sido generada y los albaranes que incluía siguen pendientes de facturar.';
     RsMsg8  = 'Factura de compra, albarán : %d, %d.';
     RsMsg9  = 'La forma de pago %s ha sido dada de baja.';
     RsMsg10 = 'No he conseguido recuperar la ficha del proveedor %s.';
     RsMsg11 = 'El proveedor ha sido dado de baja. Revise el estado de sus ficheros.';
     RsMsg12 = 'Impresión de facturas de compra.';
     RsMsg13 = 'El proveedor de código %s ha sido dado de baja. La factura nº %d no será procesada.';
     RsMsg14 = 'El artículo %s ha sido dado de baja. Aparece en el albarán %d.';
     RsMsg15 = 'Se procesará como si fuera una línea manual.';
     RsMsg16 = 'Ha ocurrido un error al reconstruir los resultados de la factura %s %d del proveedor %s.';
     RsMsg17 = 'Seleccionando albaranes a facturar';
     RsMsg18 = 'Generando facturas';
     RsMsg19 = 'Factura de compra del proveedor %s nº %d. Albarán nº %d.';
     RsMsg20 = 'La fecha de facturación no pertenece al ejercicio activo.';
     RsMsg22 = 'Albarán del proveedor %s, nº %s %d.';
     RsMsg23 = 'Periodos impositivos distintos.';
     RsMsg24 = 'El albarán %s %d del proveedor %s, pertenece a un periodo impositivo distinto al de la fecha de facturación.'#13'Si ha recibido albaranes en los que se muestran los importes con I.V.A. incluído, éstos no coincidirán con los de la factura.';
     RsMsg25 = 'Creada la factura nº %s %d del proveedor %s, %s';
     RsMsg26 = 'Mensaje del sistema : ';

function FacturaCompras : TFacturaComprasModule;
begin
     CreateDataModule( TFacturaComprasModule, FacturaComprasModule );
     Result := FacturaComprasModule;
end;

procedure TFacturaComprasModule.DataModuleCreate(Sender: TObject);
begin

     NexusRpc.CreateRemoteInstance( CLSID_FacturaComprasService, IFacturaComprasService, FacturaComprasService );

     DmFacturaComprasFields := TFacturaComprasFields.Create( DmFacturaComprasTable );
     DmFacturaComprasAuxFields := TFacturaComprasFields.Create( DmFacturaComprasAuxTable );
     DmEfectoFields := TEfectoFields.Create( DmEfectoTable );
     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
     DmProveedorFields := TProveedorFields.Create( DmProveedorTable );
     DmProveedorDatEconFields := TProveedorDatEconFields.Create( DmProveedorDatEconTable );
     DmFormaPagoFields := TFormaPagoFields.Create( DmFormaPagoTable );
     DmArticuloDatEconFields := TArticuloDatEconFields.Create( DmArticuloDatEconTable );

     DsTiposIVAFields := TTiposIVAFields.Create( Self );
     DsDivisaFields := TDivisaFields.Create( Self );
     DsArticuloFields := TArticuloFields.Create( Self );
end;

procedure TFacturaComprasModule.DataModuleDestroy(Sender: TObject);
begin
     FacturaComprasModule := nil;
end;

procedure TFacturaComprasModule.SuprimeRelaciones( FacturaComprasFields   : TFacturaComprasFields;
                                                   SuprimeRegistroFactura : Boolean = True );
begin

     With FacturaComprasFields do
       try

         EnterpriseDataModule.StartTransaction( [ DmMovimientoTable,
                                                  Factura.DmFacturaComercialTable ] );

         Efecto.SuprimeEfectos( scCompras, Proveedor.Value, SerieNroFactura.Value, 0 );

         With DmMovimientoTable do
           begin

           IndexFieldNames := 'TipoMovimiento;EjercicioFactura;PropietarioFactura;SerieFactura;NroFactura';

           try

             SetRange( [ tmCompra, Ejercicio.Value, Proveedor.Value, SerieNroFactura.Value, 0 ],
                       [ tmCompra, Ejercicio.Value, Proveedor.Value, SerieNroFactura.Value, 0 ] );

             First;
             While not Eof do
               begin

               try

                 With DmMovimientoFields do
                   begin
                   Edit;
                   EjercicioFactura.Clear;
                   PropietarioFactura.Clear;
                   SerieFactura.Clear;
                   Facturado.Value := False;
                   end;

                 Post;

               except
                 Cancel;
                 raise;
                 end;

               end;

           finally
             CancelRange;
             IndexFieldNames := 'Ejercicio;NroOperacion';
             end;

           end;

           If   SuprimeRegistroFactura
           then Factura.SuprimeRegistroComercialFactura( tfFacturaCompras, Proveedor.Value, SerieNroFactura.Value, 0 );

           EnterpriseDataModule.Commit;

         except
           EnterpriseDataModule.RollBack;
           end;

end;

function TFacturaComprasModule.TextoOrigen( Origen : TOrigenFactura ): String;

const  TextoOrigenArray : array[ TOrigenFactura ] of String = ( 'Sujeto pasivo', 'Intracomunitaria', 'Inversión del sujeto pasivo' );

begin
     Result := TextoOrigenArray[ Origen ];
end;

function TFacturaComprasModule.Obten( Ejercicio            : SmallInt;
                                      Propietario          : String;
                                      SerieNroFactura      : String;
                                      FacturaComprasFields : TFacturaComprasFields = nil ) : Boolean;

begin
     With DmFacturaComprasTable do
       begin
       IndexFieldNames := 'Ejercicio;Proveedor;SerieNroFactura';
       Result := FindKey( [ Ejercicio, Propietario, SerieNroFactura ] )
       end;
     If   Assigned( FacturaComprasFields )
     then FacturaComprasFields.Update( DmFacturaComprasTable );
end;

procedure TFacturaComprasModule.ObtenTipoIVAArticulo( Fecha              : TDateTime;
                                                      ArticuloFields     : TArticuloFields;
                                                      ProveedorFields    : TProveedorFields;
                                                      TiposIVAFields     : TTiposIVAFields = nil );

var  TipoDeIVA : SmallInt;

begin

     If   ArticuloFields.Codigo.IsNull
     then TipoDeIVA := Tasa.TipoIVAGlobal( Fecha, rgTipoIVAManual )
     else TipoDeIVA := ArticuloFields.TipoIVA.Value;

     If   Assigned( ProveedorFields )
     then If   ProveedorFields.Factura_ModeloIVA.Value=mipExento
          then TipoDeIVA := 0 // Exento
          else If   ( ProveedorFields.Factura_ModeloIVA.Value in [ mipTipoFijo, mipRegimenEspecial ] ) and not ArticuloFields.NoAplicarTipoFijo.Value
               then TipoDeIVA := ProveedorFields.Factura_TipoFijoIVA.Value;

     Tasa.TipoIVA( Fecha, TipoDeIVA, TiposIVAFields );
end;

procedure TFacturaComprasModule.Suprime( Propietario     : String;
                                         SerieNroFactura : String );

begin

     With DmFacturaComprasTable do
       begin
       IndexFieldNames := 'Ejercicio;Proveedor;SerieNroFactura';
       If   FindKey( [ ApplicationContainer.Ejercicio, Propietario, SerieNroFactura ] )
       then Delete
       else ShowNotification( ntWarning, RsMsg1, '' );
       end;

     SuprimeRelaciones( DmFacturaComprasFields );
end;

function TFacturaComprasModule.DesgloseIVA(    LineaDesglose,
                                               Opcion         : SmallInt;
                                           var TasasArray     : TTasasArray ) : Decimal;

var   Index1,
      Index2 : SmallInt;

begin
     Result := 0.0;
     Index1 := 0;
     Index2 := 1;
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

          If   DataModule00.DmEmpresaFields.Articulo_UnidadesPorPrecio.Value and ( UnidadesPorPrecio>0 )
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

     ObtenTipoIVAArticulo( LineaMovimientoFields.Fecha.Value, ArticuloFields, ProveedorFields, TiposIVAFields );

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

procedure TFacturaComprasModule.RecuperaFactura( Ejercicio : SmallInt; CodigoProveedor, SerieNroFactura : String );
begin
     FacturaComprasService.RecuperaFactura( Ejercicio, CodigoProveedor, SerieNroFactura );
end;

procedure TFacturaComprasModule.CierreCicloFacturacion( FechaInicial, FechaFinal: TDate; Contabilizar: Boolean);
begin
     FacturaComprasService.CierreCicloFacturacion( FechaInicial, FechaFinal, Contabilizar );
end;

procedure TFacturaComprasModule.AplicaCondicionesPago( FacturaComprasFields     : TFacturaComprasFields;
                                                       AplicarDescuentoyRecargo : Boolean = True );
begin
     If   not DmFormaPagoTable.FindKey( [ FacturaComprasFields.CodigoFormaPago.Value ] )
     then begin
          ShowNotification( ntStop, Format( RsMsg9, [ FacturaComprasFields.CodigoFormaPago.Value ] ) );
          Abort;
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

end;

procedure TFacturaComprasModule.RecalculaAlbaranesFactura(Ejercicio: SmallInt; CodigoProveedor, SerieNroFactura: String);
begin
     FacturaComprasService.RecalculaAlbaranesFactura( Ejercicio, CodigoProveedor, SerieNroFactura );
end;

procedure TFacturaComprasModule.RecalculaFactura( FacturaComprasFields : TFacturaComprasFields;
                                                  ModificarCuotaIVA    : Boolean );
begin
     FacturaComprasService.RecalculaFactura( TFacturaCompras.FromDataset( FacturaComprasFields ), ModificarCuotaIVA  );
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
          Tasa.TipoIVA( Fecha, Tasa.TipoIVAGlobal( Fecha, rgTipoIVAPortes ), DsTiposIVAFields );
          CuotaIVA := Redondea( ( Importe * DsTiposIVAFields.IVASoportado.Value ) / 100.0 );
          end;
end;

function TFacturaComprasModule.GeneraFacturas( ParametrosFacturacion  : IParametrosFacturacion;
                                               RelacionAlbaranesTable : TnxeTable = nil ) : IParametrosFacturacion;
var  TableName : String;

begin
     If   Assigned( RelacionAlbaranesTable )
     then TableName := RelacionAlbaranesTable.TableName
     else TableName := '';
     Result := FacturaComprasService.GeneraFacturas( ParametrosFacturacion, TableName );
end;

procedure TFacturaComprasModule.ImprimeFacturas( ParametrosFacturacion : IParametrosFacturacion );

var   RptCabeceraTable,
      RptLineasTable : TnxeTable;

      RptCabeceraFields : TCabeceraFields;
      RptLineasFields : TLineasFields;

procedure GeneraRegistroFactura;

var   Index,
      TipoIVAArticulo : SmallInt;
      ImporteDescuentos,
      ImporteBaseDescuentos : Decimal;
      RecordFieldValues : TFieldValuesArray;
      TasasArray : TTasasArray;
      ImporteIVAPortes : Decimal;
      TipoDeCambio : Double;

begin

     try

     RptCabeceraTable.Append;

     With RptCabeceraFields do
       begin

       Movimiento.InicializaValoresImpositivos( TasasArray );

       Ejercicio.Value := DmFacturaComprasFields.Ejercicio.Value;
       Serie.Value := DmFacturaComprasFields.SerieNroFactura.Value;
       codigoPropietario.Value := DmFacturaComprasFields.Proveedor.Value;
       CodigoFormaPago.Value := DmFacturaComprasFields.CodigoFormaPago.Value;

       DmProveedorTable.FindKey( [ DmFacturaComprasFields.Proveedor.Value ] );
       If   DmFacturaComprasFields.CodigoFormaPago.Value<>''
       then FormaPago.Obten( DmFacturaComprasFields.CodigoFormaPago.Value, DmFormaPagoFields, True );
       CalcularIVA := ( DmProveedorFields.Factura_ModeloIVA.Value<>mipExento ) and not ( DmFacturaComprasFields.Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ] );

       DescripcionFormaPago.Value := DmFormaPagoFields.Descripcion.Value;
       CodigoDivisa.Value := DmProveedorFields.CodigoDivisa.Value;
       If   CodigoDivisa.Value<>''
       then begin
            If   Divisa.Obten( CodigoDivisa.Value, DsDivisaFields )
            then begin
                 DescripcionDivisa.Value := DsDivisaFields.Descripcion.Value;
                 PrecisionDivisa.Value := DsDivisaFields.PrecisionRedondeo.Value;
                 end;
            If   dm_tca.TipoCambio.Obten( CodigoDivisa.Value, DmFacturaComprasFields.Fecha.Value, TipoDeCambio )
            then TipoCambio.Value := TipoDeCambio;
            end;

       NroTotalCopias := 1;

       With DmMovimientoTable do
         try
           IndexFieldNames := 'TipoMovimiento;EjercicioFactura;PropietarioFactura;SerieFactura;NroFactura';

           With DmFacturaComprasFields do
             SetRange( [ tmCompra, Ejercicio.Value, Proveedor.Value, SerieNroFactura.Value, 0 ],
                       [ tmCompra, Ejercicio.Value, Proveedor.Value, SerieNroFactura.Value, 0 ] );

           First;
           While not Eof do
             begin

             With DmLineaMovimientoTable do
               try

                 With DmMovimientoFields do
                   SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

                 First;
                 While not Eof do
                   begin

                   RptLineasTable.Append;

                   With RptLineasFields do
                     begin

                     TotalBultos.Value := 0.0;
                     TotalKilos.Value := 0.0;
                     TotalVolumen.Value := 0.0;
                     Largo.Value := DmLineaMovimientoFields.Largo.Value;
                     Ancho.Value := DmLineaMovimientoFields.Ancho.Value;
                     Alto.Value := DmLineaMovimientoFields.Alto.Value;
                     Cantidad.Value := DmLineaMovimientoFields.Cantidad.Value;

                     If   Articulo.Obten( DmLineaMovimientoFields.CodigoArticulo.Value, DsArticuloFields, True )
                     then begin

                          CodigoArticulo.Value := DmLineaMovimientoFields.CodigoArticulo.Value;
                          AsignacionOrigen.Value := DmLineaMovimientoFields.AsignacionOrigen.Value;

                          If   Cantidad.Value>0.0
                          then begin

                               SumaCajas.Value := SumaCajas.Value + DmLineaMovimientoFields.NroCajas.Value;

                               If   DataModule00.DmEmpresaFields.Articulo_Pallets.Value and
                                    ( DsArticuloFields.UnidadesPorPallet.Value<>0.0 )
                               then begin
                                    TotalPallets.Value := Cantidad.Value / DsArticuloFields.UnidadesPorPallet.Value;
                                    With TotalPallets do
                                      If   Value<>Round( Value )
                                      then Value := Int( Value ) + 1;
                                    SumaPallets.Value := SumaPallets.Value + TotalPallets.Value;
                                    end;

                               If   DataModule00.DmEmpresaFields.Articulo_Bultos.Value
                               then begin
                                    TotalBultos.Value  := Cantidad.Value   * DsArticuloFields.Bultos.Value;
                                    TotalKilos.Value   := Cantidad.Value   * DsArticuloFields.Kilos.Value;
                                    TotalVolumen.Value := Cantidad.Value   * DsArticuloFields.Volumen.Value;

                                    SumaBultos.Value  := SumaBultos.Value  + TotalBultos.Value;
                                    SumaKilos.Value   := SumaKilos.Value   + TotalKilos.Value;
                                    SumaVolumen.Value := SumaVolumen.Value + TotalVolumen.Value;
                                    end;
                               end;
                          UnidadesPrecio.Value := DsArticuloFields.UnidadesPrecioCompra.Value;
                          end;

                     TipoIVAArticulo := DsArticuloFields.TipoIVA.Value;

                     ImporteBruto.Value := DmLineaMovimientoFields.ImporteBruto.Value;
                     ImporteDescuento.Value := DmLineaMovimientoFields.ImporteDescuento.Value;
                     ImporteNeto.Value := DmLineaMovimientoFields.ImporteNeto.Value;
                     CuotaIVA.Value := DmLineaMovimientoFields.CuotaIVA.Value;
                     CuotaRE.Value := DmLineaMovimientoFields.CuotaRE.Value;
                     TotalLinea.Value := DmLineaMovimientoFields.ImporteTotal.Value;

                     Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
                     NroDocumento.Value := DmMovimientoFields.NroDocumento.Value;
                     NroOperacionDoc.Value := DmMovimientoFields.NroOperacion.Value;
                     NroRegistroDoc.Value := DmLineaMovimientoFields.NroRegistro.Value;
                     NroRegistro.Value := DmLineaMovimientoFields.NroLinea.Value;
                     EjercicioDocumento.Value := DmMovimientoFields.Ejercicio.Value;
                     Fecha.Value := DmMovimientoFields.Fecha.Value;
                     TipoMovimientoOrigen.Value := DmLineaMovimientoFields.TipoMovimientoOrigen.Value;
                     EjercicioOrigen.Value := DmLineaMovimientoFields.EjercicioOrigen.Value;
                     NroOperacionOrigen.Value := DmLineaMovimientoFields.NroOperacionOrigen.Value;
                     NroRegistroOrigen.Value := DmLineaMovimientoFields.NroRegistroOrigen.Value;
                     EjercicioDocumento.Value := DmMovimientoFields.Ejercicio.Value;
                     SerieDocumento.Value := DmMovimientoFields.Serie.Value;
                     NroDocumento.Value := DmMovimientoFields.NroDocumento.Value;
                     Referencia.Value := Articulo.ReferenciaProveedor( CodigoPropietario.Value, CodigoArticulo.Value, True );
                     CodigoClaseA.Value := DmLineaMovimientoFields.CodigoClaseA.Value;
                     DescripcionClaseA.Value := Clase.Descripcion( tcClaseA, DmLineaMovimientoFields.CodigoClaseA.Value, True );
                     CodigoClaseB.Value := DmLineaMovimientoFields.CodigoClaseB.Value;
                     DescripcionClaseB.Value := Clase.Descripcion( tcClaseB, DmLineaMovimientoFields.CodigoClaseB.Value, True );
                     CodigoClaseC.Value := DmLineaMovimientoFields.CodigoClaseC.Value;
                     DescripcionClaseC.Value := Clase.Descripcion( tcClaseC, DmLineaMovimientoFields.CodigoClaseC.Value, True );
                     LoteFabricacion.Value := DmLineaMovimientoFields.LoteFabricacion.Value;
                     NumeroSerie.Value := DmLineaMovimientoFields.NumeroSerie.Value;
                     CampoLibre1.Value := DmLineaMovimientoFields.CampoLibre1.Value;
                     CampoLibre2.Value := DmLineaMovimientoFields.CampoLibre2.Value;
                     CampoLibre3.Value := DmLineaMovimientoFields.CampoLibre3.Value;
                     CampoLibre4.Value := DmLineaMovimientoFields.CampoLibre4.Value;
                     Descripcion.Value := DmLineaMovimientoFields.Descripcion.Value;
                     Anotacion.Value := DmLineaMovimientoFields.Anotacion.Value;

                     CodigoAlmacen.Value := DmLineaMovimientoFields.CodigoAlmacen.Value;
                     Precio.Value := DmLineaMovimientoFields.Precio.Value;
                     PrecioDivisa.Value := DmLineaMovimientoFields.PrecioDivisa.Value;
                     PuntoVerde.Value := DmLineaMovimientoFields.PuntoVerde.Value;
                     Recargo.Value := DmLineaMovimientoFields.Recargo.Value;
                     Descuento.Value := DmLineaMovimientoFields.Descuento.Value;
                     ImportePuntoVerde.Value := PuntoVerde.Value * Cantidad.Value;
                     CodigoTipoIVA.Value := DmLineaMovimientoFields.CodigoTipoIVA.Value;

                     Movimiento.AcumulaValoresImpositivosLinea( DmLineaMovimientoFields, '', TasasArray );

                     If   CalcularIVA
                     then begin
                          Tasa.TipoIVA( Fecha.Value, CodigoTipoIVA.Value, DsTiposIVAFields );
                          TipoIVA.Value := DsTiposIVAFields.IVASoportado.Value;
                          end;

                     NroCajas.Value := DmLineaMovimientoFields.NroCajas.Value;

                     With RptLineasTable do
                       begin
                       RecordFieldValues := GetFieldValues;
                       For Index := 1 to NroTotalCopias do
                         begin

                         try

                           If   Index>1
                           then begin
                                Append;
                                SetFieldValues( RecordFieldValues );
                                end;
                           Edit;
                           NroOperacion.Value := NroOperacionActual + Pred( Index );
                           Post;

                         except
                           Cancel;
                           raise;
                           end;

                         end;
                       end;

                     end;

                   Next;
                   end;

               finally
                 CancelRange;
                 end;

             Next;
             end;

         finally
           CancelRange;
           end;

       Ejercicio.Value := DmFacturaComprasFields.Ejercicio.Value;
       Serie.Value := DmFacturaComprasFields.SerieNroFactura.Value;
       FechaDocumento.Value := DmFacturaComprasFields.Fecha.Value;
       Fecha1.Value := DmFacturaComprasFields.FechaRecepcion.Value;
       DescuentoES.Value := DmFacturaComprasFields.DescuentoES.Value;
       ImporteDtoES.Value := DmFacturaComprasFields.importeDtoES.Value;
       DescuentoPP.Value := DmFacturaComprasFields.DescuentoPP.Value;
       ImporteDtoPP.Value := DmFacturaComprasFields.importeDtoPP.Value;
       ImportePuntoVerde.Value := DmFacturaComprasFields.ImportePuntoVerde.Value;
       BrutoArticulos.Value := DmFacturaComprasFields.BrutoArticulos.Value;
       DescuentoArticulos.Value := DmFacturaComprasFields.DescuentoArticulos.Value;
       DescuentoPropietario.Value := DmFacturaComprasFields.DescuentoProveedores.Value;
       NetoArticulos.Value := DmFacturaComprasFields.NetoFactura.Value - DmFacturaComprasFields.ImportePuntoVerde.Value;
       ImporteNeto.Value := DmFacturaComprasFields.NetoFactura.Value - DmFacturaComprasFields.DescuentoProveedores.Value + DmFacturaComprasFields.Portes.Value + DmFacturaComprasFields.importeRecFinanciero.Value;
       TotalCuotaIVA.Value := DmFacturaComprasFields.CuotaIVA.Value;

       var RecalcularCuotas := ( DescuentoES.Value<>0.0 ) or ( DescuentoPP.Value<>0.0 );
       var TipoIVAPortes := Tasa.TipoIVAGlobal( DmFacturaComprasFields.Fecha.Value, rgTipoIVAPortes );

       If   DmFacturaComprasFields.Portes.Value<>0.0
       then TasasArray[ TipoIVAPortes ].BaseImponible := TasasArray[ TipoIVAPortes ].BaseImponible + DmFacturaComprasFields.Portes.Value;

       For Index := 0 to NroMaximoTiposTasas do
         begin

         If   TasasArray[ Index ].BaseImponible<>0.0
         then begin

              ImporteBaseDescuentos := TasasArray[ Index ].BaseImponible;
              If   Index=TipoIVAPortes
              then ImporteBaseDescuentos := ImporteBaseDescuentos - DmFacturaComprasFields.Portes.Value;

              ImporteBaseDescuentos := ImporteBaseDescuentos - TasasArray[ Index ].BaseNoSujetaDto;

              ImporteDescuentos := 0.0;

              If   DescuentoES.Value<>0.0
              then DecAdd( ImporteDescuentos, Redondea( ( ImporteBaseDescuentos * DescuentoES.Value ) / 100.0 ) );
              If   DescuentoPP.Value<>0.0
              then DecAdd( ImporteDescuentos, Redondea( ( ( ImporteBaseDescuentos - ImporteDescuentos ) * DescuentoPP.Value ) / 100.0 ) );

              DecAdd( TasasArray[ Index ].BaseImponible, -ImporteDescuentos );
              end;

         If   ( Index=0 ) and ( DmFacturaComprasFields.ImporteRecFinanciero.Value<>0.0 )
         then DecAdd( TasasArray[ 0 ].BaseImponible, DmFacturaComprasFields.ImporteRecFinanciero.Value );

         Tasa.TipoIVA( DmFacturaComprasFields.Fecha.Value, Index, DsTiposIVAFields );

         If   CalcularIVA and ( RecalcularCuotas or ( ( DmFacturaComprasFields.Portes.Value<>0.0 ) and ( Index=TipoIVAPortes ) ) )
         then begin
              TasasArray[ Index ].TipoIVA := DsTiposIVAFields.IVASoportado.Value;
              TasasArray[ Index ].CuotaIVA := ( TasasArray[ Index ].BaseImponible * DsTiposIVAFields.IVASoportado.Value ) / 100.0;
              end;

         TasasArray[ Index ].Importe := Redondea( TasasArray[ Index ].BaseImponible + TasasArray[ Index ].CuotaIVA );

         end;

       If   CalcularIVA
       then begin

            For Index := 1 to NroMaximoTiposTasas do
              If   TasasArray[ Index ].BaseImponible<>0.0
              then begin
                   PrimerTipoIVA.Value := TasasArray[ Index ].TipoIVA;
                   Break;
                   end;

            For Index := 1 to NroMaximoTiposTasasImpreso do
              begin
              BaseImponible[ Index ].Value := FacturaCompras.DesgloseIVA( Index, 1, TasasArray );
              TipoIVA[ Index ].Value := FacturaCompras.DesgloseIVA( Index, 2, TasasArray );
              CuotaIVA[ Index ].Value := FacturaCompras.DesgloseIVA( Index, 3, TasasArray );
              TipoRE[ Index ].Value := FacturaCompras.DesgloseIVA( Index, 4, TasasArray );
              CuotaRE[ Index ].Value := FacturaCompras.DesgloseIVA( Index, 5, TasasArray );
              ImporteTotal[ Index ].Value := FacturaCompras.DesgloseIVA( Index, 6, TasasArray );
              end;

            end;

       ObtenCuotaPortes( DmFacturaComprasFields.Portes.Value,
                         DmFacturaComprasFields.Fecha.Value,
                         DmProveedorFields.Factura_ModeloIVA.Value,
                         ImporteIVAPortes );

       PorcentajeRecFinanc.Value := DmFacturaComprasFields.recargoFinanciero.Value;
       RecargoFinanciero.Value := DmFacturaComprasFields.importeRecFinanciero.Value;
       TipoRetencion.Value := DmFacturaComprasFields.TipoRetencion.Value;

       Tasa.TipoRetencion( FechaDocumento.Value, TipoRetencion.Value, DsTiposIVAFields );

       PorcentajeRetencion.Value := DsTiposIVAFields.Retencion.Value;
       BaseCalculoRetencion.Value := DmFacturaComprasFields.BaseCalculoRetencion.Value;
       ImporteRetencion.Value := -dmFacturaComprasFields.ImporteRetencion.Value;
       Portes.Value := DmFacturaComprasFields.Portes.Value;
       CuotaIVAPortes.Value := ImporteIVAPortes;
       TotalImporte.Value := DmFacturaComprasFields.TotalFactura.Value;

       Efecto.ObtenVencimientos( scCompras,
                                 DmFacturaComprasFields.Ejercicio.Value,
                                 DmFacturaComprasFields.Proveedor.Value,
                                 DmFacturaComprasFields.SerieNroFactura.Value,
                                 0,
                                 RelacionEfectos );

       For Index := 1 to RelacionEfectos.NroEfectos do
         If   Index>6        // Aunque se pueden incluir tantos efectos como se desee, sólo se pasan los 6 primeros
         then Break
         else begin
              FechaVencimiento[ Index ].Value := RelacionEfectos.FechaVencimiento[ Index ];
              ImporteVencimiento[ Index ].Value := RelacionEfectos.Importe[ Index ];
              end;

       ImporteCifra.Value := Cifra( DmFacturaComprasFields.TotalFactura.Value );
       SumaIVAyRE.Value := DmFacturaComprasFields.CuotaIVA.Value;
       Anotacion.Value := DmFacturaComprasFields.Anotacion.Value;
       CodigoEmpresa.Value := CodigoEmpresaActual;

       With RptCabeceraTable do
         begin
         RecordFieldValues := GetFieldValues;
         For Index := 1 to NroTotalCopias do
           begin
           If   Index>1
           then begin
                Append;
                SetFieldValues( RecordFieldValues );
                end;
           try
             Edit;
             NroOperacion.Value := NroOperacionActual + Pred( Index );
             If   ParametrosFacturacion.CopiaPropietario
             then NroCopia.Value := Index
             else NroCopia.Value := 2;    // cuando no es para el Proveedor siempre es copia ...
             Post;
           except
             Cancel;
             raise;
             end;
           end;
         end;

       Inc( NroOperacionActual, NroTotalCopias );

       ApplicationContainer.ShowProgression;

       end;

     finally
       end;

end;

procedure SeleccionaRegistros;
begin

     With DmFacturaComprasTable, ParametrosFacturacion do
       try

         If   EjercicioFactura=0
         then EjercicioFactura := ApplicationContainer.Ejercicio;

         case TipoSeleccion of
           tsDocumento :
             begin
             IndexFieldNames := 'Ejercicio;Proveedor;SerieNroFactura';
             SetRange( [ EjercicioFactura, CodigoPropietario, SerieInicial ],
                       [ EjercicioFactura, CodigoPropietario, SerieFinal ] );
             end;
           tsFecha :
             begin
             IndexFieldNames := 'Proveedor;Fecha';
             SetRange( [ PropietarioInicial, FechaInicial ], [ PropietarioFinal, FechaFinal ] );
             end;

           end;

         NroOperacionActual := 1;

         ApplicationContainer.StartProgression( RecordCount );

         First;
         while not Eof do
           begin
           GeneraRegistroFactura;
           Next;
           end;

       finally
         CancelRange;
         end;

     ApplicationContainer.EndProgression;
end;

begin

     FormatoImpreso := ParametrosFacturacion.Formato;

     With Report do
       begin
       try

         Load( False );

         RptCabeceraTable := CreateEmptyTable( 'Cabecera', DataModule30.SQLSet );
         RptCabeceraFields := TCabeceraFields.Create( RptCabeceraTable );
         RptLineasTable := CreateEmptyTable( 'Lineas', DataModule30.SQLSet );
         RptLineasFields := TLineasFields.Create( RptLineasTable );

         MainDataSet := RptCabeceraTable;

         OpenReportTables;

         SeleccionaRegistros;

         FacturaCompras.FijaDecimalesInforme( Report );

         ToPrinter := True;

         Start;

         Detach;

       except on e : exception do cancel( e );
         end;

       end;
end;

procedure TFacturaComprasModule.ReportSetReportName;
begin
     With Report do
       begin
       If   FormatoImpreso=0
       then FileName := 'ffc'
       else FileName := InformeExterno.Fichero;
       Title := RsMsg12;
       end;
end;

procedure TFacturaComprasModule.ReportSelectPrinter;
begin
     Report.ReportPrinter := informeExterno.Impresora;
end;

procedure TFacturaComprasModule.FijaDecimalesInforme( Report : TgxReportManager );
begin
     With Report, DataModule00.DmEmpresaFields do
       begin
       SetNumberVarFormat( FmtCantidadCompra, Compras_DecCantidad.Value );
       SetNumberVarFormat( FmtPrecioCompra,Compras_DecPrecio.Value );
       SetNumberVarFormat( FmtDescuentoCompra, Compras_DecDto.Value );
       end;
end;

procedure TFacturaComprasModule.AcumulaValoresImpositivos( var TasasArray  : TTasasArray;
                                                               Fecha       : TDate;
                                                               ModeloIVA   : SmallInt;
                                                               CalcularIVA : Boolean;
                                                           var Sumas       : TTasaRecord );

var   Index : SmallInt;

begin

     FillChar( Sumas, SizeOf( Sumas ), #0 );

     For Index := 0 to NroMaximoTiposTasas do
       begin
       
       // Aprovecho para redondear las sumas por tipo impositivo 

       With TasasArray[ Index ] do
         begin
         BaseImponible := Redondea( BaseImponible );
         BaseNoSujetaDto := Redondea( BaseNoSujetaDto );
         CuotaIVA := Redondea( CuotaIVA );
         Importe := BaseImponible + BaseNoSujetaDto + CuotaIVA;
         end;

       DecAdd( Sumas.BaseImponible, TasasArray[ Index ].BaseImponible );
       DecAdd( Sumas.BaseNoSujetaDto, TasasArray[ Index ].BaseNoSujetaDto );
       DecAdd( Sumas.CuotaIVA, TasasArray[ Index ].CuotaIVA );
       DecAdd( Sumas.Importe, TasasArray[ Index ].Importe );

       If   CalcularIVA and ( Index<>0 )
       then If   ( TasasArray[ Index ].BaseImponible<>0.0 ) and
                 ( Sumas.TipoIVA=0.0 )
            then Sumas.TipoIVA := TasasArray[ Index ].TipoIVA;

       end;

end;

end.


