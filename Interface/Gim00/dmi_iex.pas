{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_iex;

interface

uses SysUtils,
     Classes;

const tdCualquiera = -1;
      tdFicheroMaestro = 0;
      tdAsiento = 1;
      tdPedidoCompras = 2;
      tdAlbaranCompras = 3;
      tdPresupuesto = 4;
      tdPedidoVentas = 5;
      tdAlbaranVentas = 6;
      tdMovimientoAlmacen = 7;
      tdPreventa = 8;
      tdTareas = 9;
      tdFacturaPDF = 10;
      tdImpresoCliente = 11;
      tdInforme = 12;
      tdMandato = 13;
      tdPresupuestoPDF = 14;
      tdPedidoVentasPDF = 15;
      tdAlbaranVentasPDF = 16;
      tdArticulo = 17;
      tdOfertaPDF = 18;
      tdPedidoComprasPDF = 19;
      tdAlbaranComprasPDF = 20;
      tdOferta = 21;
      tdCartaOperacionesClientes = 22;
      tdFacturaXML = 23;

      // ...
      tdSuscripcion = 98;     // tdSuscripcion y tdContactoWeb son dos tipos internos
      tdContactoWeb = 99;     // utilizados en la gestión de suscripciones a GESTWIN.NET

      // TMailProtocol

      mailPOP3 = 0;
      mailIMAP = 1;
      mailSMTP = 2;

type  TTipoDatosExportados   =  tdCualquiera..tdContactoWeb;

      TBackupInfo = packed record
        Empresa    : String[ 3 ];
        Ejercicio  : SmallInt;
        Usuario    : String[ 3 ];
        Nombre     : String[ 30 ];
        Fecha      : TDateTime;
        TipoDatos  : TTipoDatosExportados;
        Version,
        Release,
        Recuperado : Word;
        end;

      TStrBool  = String[ 6 ];

      TFormatoFichero = ( fmGestwin, fmTexto );

      TCheckRecordIRTProcedure = reference to procedure( ListaParametros : TStringList );

implementation

initialization

end.


