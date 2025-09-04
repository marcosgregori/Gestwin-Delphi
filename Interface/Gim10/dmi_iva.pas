{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_iva;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,
     DataManager,

     Gim00Fields,
     Gim10Fields,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,

     SessionIntf;

const  rgTiposIVA      = 0;      // 1..24
       rgRetenciones   = 500;    // 501..512
       rgTipoIVAPortes = 999;
       rgTipoIVAManual = 1000;
       rgRelaciones    = 1001;   // 1001..srPortesVentas=1010

       DecimalesTasas  = 2;

       DescripcionTiposIVADefecto : array[ 1..3 ] of String = ( 'Normal', 'Reducido', 'Super reducido' );


       PorcentajeTiposIVAAnteriorDefecto : array[ 1..3, 1..2 ] of Double = ( ( 18.0, 4.0 ),
                                                                             (  8.0, 1.0 ),
                                                                             (  4.0, 0.5 ) );

       PorcentajeTiposIVADefecto : array[ 1..3, 1..2 ] of Double = ( ( 21.0,  5.2 ),
                                                                     ( 10.0,  1.4 ),
                                                                     (  4.0,  0.5 ) );

       CtaIVASoportadoDefecto            = '472000000';
       CtaIVASoportadoDevengadoDefecto   = '472100000';
       CtaIVARepercutidoDefecto          = '477000000';
       CtaIVARepercutidoDevengadoDefecto = '477100000';

       CtaIVASoportadoDevengado          = '4721';
       CtaIVARepercutidoDevengado        = '4771';

       // Secciones de IVA

       siSoportado        = 0;
       siRepercutido      = 1;
       siAmbos            = 2;

       // Formatos por secciones

       fsiSoportado        = 0;
       fsiRepercutido      = 1;
       fsiAmbos            = 2;
       fsiSoportadoCorto   = 3;
       fsiRepercutidoCorto = 4;
       fsiAmbosCorto       = 5;
       fsiSoloDescripcion  = 6;

       // Modelos de IVA de clientes

       micExento          = 0;
       micSinRE           = 1;
       micConRE           = 2;
       micTipoFijo        = 3;
       micVentasOnline    = 4;

       // Modelos de IVA de proveedores

       mipExento          = 0;
       mipNormal          = 1;
       mipTipoFijo        = 2;
       mipRegimenEspecial = 3;  // Regimen especial de agricultura, ganaderia y pesca

       TextoRazonRectificacion1a16 : array[ 1..16 ] of String = ( 'Número de la factura',
                                                                  'Serie de la factura',
                                                                  'Fecha expedición',
                                                                  'Nombre y apellidos/Razón Social-Emisor',
                                                                  'Nombre y apellidos/Razón Social-Receptor',
                                                                  'Identificación fiscal Emisor/obligado',
                                                                  'Identificación fiscal Receptor',
                                                                  'Domicilio Emisor/Obligado',
                                                                  'Domicilio Receptor',
                                                                  'Detalle Operación',
                                                                  'Porcentaje impositivo a aplicar',
                                                                  'Cuota tributaria a aplicar',
                                                                  'Fecha/Periodo a aplicar',
                                                                  'Clase de factura',
                                                                  'Literales legales',
                                                                  'Base imponible' );

       TextoRazonRectificacion80a85 : array[ 80..85 ] of String = ( 'Cálculo de cuotas repercutidas',
                                                                    'Cálculo de cuotas retenidas',
                                                                    'Base imponible modificada por devolución de envases / embalajes',
                                                                    'Base imponible modificada por descuentos y bonificaciones',
                                                                    'Base imponible modificada por resolución firme, judicial o administrativa',
                                                                    'Base imponible modificada cuotas repercutidas no satisfechas. Auto de declaración de concurso' );


       TextoMetodoRectificacion1a4 : array[ 1..4 ] of String = ( 'Rectificación íntegra',
                                                                 'Rectificación por diferencias',
                                                                 'Rectificación por descuento por volumen de operaciones durante un periodo',
                                                                 'Autorizadas por la Agencia Tributaria' );


type   TSeccionIVA = siSoportado..siAmbos;
       TModeloIVACliente = micExento..micTipoFijo;
       TModeloIVAProveedor = mipExento..mipRegimenEspecial;
       TFormatoSeccionIVA = fsiSoportado..fsiSoloDescripcion;

       TSubcuentaRelacion = ( srVentas,
                              srDevolucionesVentas,
                              srCompras,
                              srDevolucionesCompras,
                              srDescuentoPP,
                              srDescuentoPC,
                              srRecargoFinancieroCompras,
                              srRecargoFinancieroVentas,
                              srPortesCompras,
                              srPortesVentas               );

       TTipoPorcentaje   =  ( tpIVASoportado,
                              tpIVARepercutido,
                              tpRERepercutido );

const
     CLSID_TasaService : TGuid = '{CE0E1D7A-465C-4B3F-972A-479013FE9A7A}';

type

  ITasaService = interface( ISessionModule )
    ['{3DAEC4BE-1849-4AEC-96E7-65F37DF050E4}']

    function CopiaRegistros( FechaAplicacion, Fecha : TDate; TipoRegistro : SmallInt = rgTiposIVA; CodigoPais : String = CodigoEspaña ) : Boolean;
    end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( ITasaService ) );

end.


