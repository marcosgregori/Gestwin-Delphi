
unit N1RecTypes;

interface

uses comun30;

resourceString
       rsCentrosCoste         = 'CentrosCoste';
       rsCodigoPostal         = 'CodigoPostal';
       rsTipo                 = 'Tipo';
       rsFecha                = 'Fecha';
       rsDebeInicial          = 'DebeInicial';
       rsHaberInicial         = 'HaberInicial';
       rsPeriodoInicial       = 'PeriodoInicial';
       rsPeriodoFinal         = 'PeriodoFinal';
       rsPeriodo              = 'Periodo';
       rsDescripcion          = RsDescripcion;
       rsCodigoInicial        = 'CodigoInicial';
       rsCodigoFinal          = 'CodigoFinal';
       rsSeleccionCentroCoste = 'SeleccionCentroCoste';
       rsCentroCoste          = 'CentroCoste';
       rsFechaInicial         = 'FechaInicial';
       rsFechaFinal           = 'FechaFinal';

const  nroMaximoBasesImponibles = 12;
       nroMaximoEfectos         = 24;

type

       TRelacionEfectos = packed record
         nroEfectos       : 0..nroMaximoEfectos;
         fechaLibramiento : array[ 0..nroMaximoEfectos ] of TDateRec;
         fechaVencimiento : array[ 0..nroMaximoEfectos ] of TDateRec;
         importe          : array[ 0..nroMaximoEfectos ] of double;
         end;

{  2 - clientes  }

       TClienteRec  = packed record

         codigo           : string5;
         nombre,
         domicilio        : string40;               { alargado en la 9.0 }
         localidad        : string30;               { alargado en la 9.0 }
         codigoPais       : string3;                { nuevo en la 9.0 }
         codigoProvincia  : string2;                { nuevo en la 9.0 }
         codigoPostal     : string3;
         telefono         : string20;
         fax              : string20;
         NIF              : string15;
         codigoVendedor   : string2;
         subcuenta        : string9;
         codigoDivisa     : string3;                { nuevo en la 9.0 }
         campoLibre1,
         campoLibre2      : string40;
         campoLibre3,
         campoLibre4      : string20;

         envios           : packed record
           nombre,
           domicilio           : string40;
           localidad           : string30;
           codigoProvincia     : string2;               { nuevo en la 9.0 }
           codigoPostal        : string3;
           formaEnvio          : string30;              { alargado en la 9.0 }
           codigoTransportista : string2;
           end;

         factura : packed record
           descuentoPP,
           descuentoES,
           recargoFinanciero: double;
           modeloIVA,
           tipoFijoIVA,
           tipoRetencion    : smallInt;
           credito          : double;
           grupoCliente,
           reservado        : string3;
           codigoTarifa     : string2;
           comision         : double;
           nroCopias        : smallInt;
           moneda           : smallInt;             { nuevo en la 9.0 }
           end;

         cobro : packed record
           nombre,
           domicilio        : string40;
           localidad        : string30;
           codigoProvincia  : string2;              { nuevo en la 9.0 }
           codigoPostal     : string3;
           codigoFormaCobro : string2;
           diaCobro1,
           diaCobro2,
           mesNoCobro       : smallInt;
           codigoEntidad    : string4;
           entidad          : string30;
           codigoSucursal   : string4;
           sucursal         : string30;
           codigoDC         : string2;            { nuevo en la 9.0 }
           codigoCC         : string10;
           subcuenta        : string9;
           codigoINE        : string9;            { nuevo en la 8.2 }
           riesgoLimite     : double;
           end;

         end;

{ 06 - Direcciones de correo }

       TDireccionRec = packed record
         codigo      : string2;
         nombre      : string40;
         esUnGrupo   : boolean;
         eMail       : string80;
         codigoGrupo : string2;
         end;

{  7 - proveedores }

       TProveedorRec  = packed record

         codigo           : string5;
         nombre,
         domicilio        : string40;
         localidad        : string30;
         codigoPais       : string3;
         codigoProvincia  : string2;
         codigoPostal     : string3;
         telefono         : string20;
         fax              : string20;
         NIF              : string15;
         subcuenta        : string9;
         codigoDivisa     : string3;

         campoLibre1,
         campoLibre2      : string40;
         campoLibre3,
         campoLibre4      : string20;

         envios : packed record
           nombre,
           domicilio       : string40;
           localidad       : string30;
           codigoProvincia : string2;
           codigoPostal    : string3;
           formaEnvio      : string30;
           end;

         factura : packed record
           descuentoPP,
           descuentoES,
           recargoFinanciero : double;
           modeloIVA,
           tipoFijoIVA,
           tipoRetencion     : smallInt;
           subcuentaCompras  : string9;     //* 23.12.1999  Esta es la cuenta de compras por defecto
           end;

         pago : packed record
           nombre,
           domicilio       : string40;
           localidad       : string30;
           codigoProvincia : string2;
           codigoPostal    : string3;
           codigoFormaPago : string2;
           diaPago1,
           diaPago2,
           mesNoPago       : smallInt;
           codigoEntidad   : string4;
           entidad         : string30;
           codigoSucursal  : string4;
           sucursal        : string30;
           codigoDC        : string2;       
           codigoCC        : string10;
           subcuenta       : string9;
           end;

         end;

{ Ficheros de la Gestión contable --- }

{ 30 }
Type  TCuentaRec = packed record
        codigo       : string9;
        codNivel     : smallInt;
        descripcion  : string40;
        end;

{ 31 }

       TSaldosRec = packed record
         ejercicio   : smallInt;
         codigo      : string9;
         centroCoste : string3;
         mes         : array[ 0..14, 1..2 ] of double;
         end;


{ 32 }
      TAsientoRec = packed record
        ejercicio        : smallInt;
        nroAsiento       : longInt;
        fecha            : TDateRec;

        tipoAsiento      : smallInt;

        serie            : string2;
        nroDocumento     : longInt;
        nroEfecto        : smallInt;
        fechaDocumento   : TDateRec;
        
        propietario      : string9;
        nroRegistro      : longInt;
        nombre           : string40;
        end;

{ 33 }

      TApunteRec = packed record

        ejercicio     : smallInt;
        nroAsiento    : longInt;
        nroApunte     : smallInt;

        fecha         : TDateRec;
        subcuenta     : string9;
	centroCoste   : string3;
        contrapartida : string9;
        concepto      : string30;

        cargo         : boolean;
        importe       : double;
        tipoApunte    : smallInt;       // Nuevo en la 9.0. Sustituye a 'Automático'
        punteado      : boolean;

        baseImponible : double;
        tipo          : smallInt;
        cuotaIVA,
        cuotaRE,
        importeTotal  : double;
        end;

{ 34 }

      TCentroCosteRec = packed record
	codigo      : string3;
	descripcion : string30;
        end;

{ 35 }

      TConceptoApteRec = packed record
        nroConcepto    : smallInt;
        descripcion    : string20;
        end;

{ 36 }

      TRelacionesDivisaRec = packed record
        codigoDivisa            : string3;
        ctaDifPositivasCambio,
        ctaDifNegativasCambio   : string9;
        end;
        
{ 37 }

      TExistenciaRec  = packed record

        ejercicio   : smallInt;
        subcuenta   : string9;
        centroCoste : string3;

        saldo       : array[ 0..12 ] of double;
        end;

{ 38 }

      TTipoAsientoRec  = packed record

        nroRegistro    : smallInt;

        descripcion    : string25;
        documento,
        registro       : boolean;
        end;

{ 39 }

      TLineaTipoAsientoRec = packed record

        nroRegistro,
        nroLinea       : smallInt;

        subcuenta      : string9;
        centroCoste    : string3;
        contrapartida  : string9;
        concepto       : string25;
        DH             : string1;
        importe        : double;     { nuevo en la 8.2 }
        end;

{ 40 - anotaciones --- }

       TBufferAnotacion  = array[ 0..511 ] of ansiChar;

       TAnotacionRec = packed record
         ejercicio     : smallInt;
         tipo          : smallInt;
         propietario   : string13;
         serie         : string2;
         nroOperacion  : longInt;
         nroRegistro   : smallInt;
         buffer        : TBufferAnotacion;
         end;

{ 41 }

      TEfectoCobrarRec  = packed record
        ejercicio          : smallInt;
        serie              : string2;
        nroFactura         : longInt;
        nroEfecto          : smallInt;
        codigoCliente,
        codigoEntidad      : string9;
        fechaVencimiento,
        fechaCobro         : TDateRec;           // La fecha del cobro o de la cancelación del efecto
        concepto           : string30;
        ejercicioRemesa    : smallInt;
        nroRemesa          : longInt;
        importe,
        importeCobrado     : double;
        conceptoCobro      : string30;
        codigoVendedor     : string2;
        codigoGrupoCliente : string3;
        revisado,
        impagado,
        cancelado,
        volverAEmitir      : boolean;
        nroEfectoReemitido : smallInt;
        fechaLibramiento   : TDateRec;
        codigoFormaCobro   : string2;
        gastosGestion,
        gastosDevolucion   : double;
        subcuentaGastos    : string9;
        nroAsiento         : longInt;
        fechaCancelacion   : TDateRec;
        nroAstoCancelacion : longInt;
        fechaImpagado      : TDateRec;
        nroAstoImpagado    : longInt;
        end;

{ 42 }

      TRemesaRec  = packed record
        ejercicio            : smallInt;
        nroRemesa            : longInt;
        fecha                : TDateRec;
        codigoEntidad        : string9;
        _codigoBanco         : string2;         // *** Obsoleto, debería desaparecer en alguna versión futura
        fechaVtoInicial,
        fechaVtoFinal        : TDateRec;
        concepto             : string30;
        importeGastos        : double;
        estado               : smallInt;        // Pendiente=0, cobrada=1, descontada=2 o cancelada=3
        fechaCobro           : TDateRec;
        nroAsientoCobro      : longInt;
        fechaDescuento       : TDateRec;
        nroAsientoDescuento1,
        nroAsientoDescuento2 : longInt;
        fechaCancelacion     : TDateRec;
        nroAstoCancelacion,
        reservado            : longInt;
        end;

{ 43 }

      TEfectoPagarRec  = packed record
        ejercicio        : smallInt;
        codigoProveedor  : string9;
        serie            : string2;
        nroFactura       : longInt;
        nroEfecto        : smallInt;
        codigoEntidad    : string9;
        fechaVencimiento,
        fechaPago        : TDateRec;
        concepto         : string30;
        importe,
        importePagado    : double;
        conceptoPago     : string30;
        fechaLibramiento : TDateRec;
        codigoFormaPago  : string2;
        nroAsiento       : longInt;
        ejercicioRemesa  : smallInt;
        nroRemesa        : longInt;
        end;

{ 44 }

      TDisponibilidadRec = packed record
       codigo      : string9;
       nroRegistro : smallInt;
       subcuenta   : string9;
       limite      : double;
       end;
       
{ 45 }

      TBancoRec = packed record

        subcuenta       : string9;
        nombre,
        domicilio       : string40;
        localidad       : string30;
        codigoPais      : string3;
        codigoProvincia : string2;
        codigoPostal    : string3;
        ctaRiesgo,
        ctaIntereses    : string9;
        riesgo          : double;
        formato         : smallInt;

        adeudos : packed record
          presentador          : string[ 30 ];
          NIFPresentador       : string[ 9 ];
          entidadReceptora     : string[ 4 ];
          oficinaReceptora     : string[ 4 ];
          entidadDeposito      : string[ 4 ];
          oficinaDeposito      : string[ 4 ];
          DCDeposito           : string[ 2 ];
          cuentaDeposito       : string[ 10 ];
          codigoINE            : string[ 9 ];
          sufijoCI             : string[ 3 ];
          entidadAdeudo        : string[ 4 ];
          oficinaAdeudo        : string[ 4 ];
          DCAdeudo             : string[ 2 ];
          cuentaAdeudo         : string[ 10 ];
          entidadImpagados     : string[ 4 ];
          oficinaImpagados     : string[ 4 ];
          DCImpagados          : string[ 2 ];
          cuentaImpagados      : string[ 10 ];
          CIC                  : string[ 15 ];
          end;

        _codigo         : string2;
        reservado       : array[ 0..9 ] of byte;
        end;

{ 46 }

      TInmovilizadoRec = packed record
       codigo                : string9;
       centroCoste           : string3;
       codigoProveedor       : string9;
       serie                 : string2;
       nroFactura            : longInt;
       cuentaAmortizacion    : string9;
       tipo                  : double;
       Ubicacion             : string30;
       fechaCompra           : TDateRec;
       importe               : double;
       end;

{ 47 }

     TLineaInmovilizadoRec = packed record
       codigo                : string9;
       nroRegistro           : smallInt;
       fecha                 : TDateRec;
       descripcion           : string30;
       importe               : double;
       end;


{ 66 - forma de pago  ---------------------------------------------------- }

       TFormaPagoRec = packed record
         codigo                : string2;
         descripcion           : string30;
         plazos,
         primerVto,
         intervalo             : smallInt;
         aplicarDescuentoPP    : boolean;
         tipoDescuentoPP       : double;
         aplicarRecFinanciero  : boolean;
         tipoRecargoFinanciero : double;
         emitir,
         crearRegistro         : boolean;
         tipoDeDocumento       : smallInt;
         gastos                : smallInt;
         noContabilizar        : boolean;
         end;

{ 67 - forma de cobro  ---------------------------------------------------- }

       TFormaCobroRec = packed record
         codigo                : string2;
         descripcion           : string30;
         plazos,
         primerVto,
         intervalo,
         diaCobro1,
         diaCobro2             : smallInt;
         aplicarDescuentoPP    : boolean;
         tipoDescuentoPP       : double;
         aplicarRecFinanciero  : boolean;
         tipoRecargoFinanciero : double;
         emitir,
         crearRegistro         : boolean;
         tipoDeDocumento       : smallInt;
         aceptado              : boolean;
         gastos                : smallInt;        
         noContabilizar        : boolean;
         end;

{ 71 - Remesas de pago }

      TRemesaPagoRec  = packed record
        ejercicio            : smallInt;
        nroRemesa            : longInt;
        fecha                : TDateRec;
        _codigoBanco         : string2;
        codigoEntidad,
        codigoProveedor      : string9;
        fechaVtoInicial,
        fechaVtoFinal        : TDateRec;
        concepto             : string30;
        importeGastos        : double;
        estado               : smallInt;        // Pendiente=0, Pagada=1
        fechaPago            : TDateRec;
        nroAsientoPago       : longInt;
        end;

{ 72 - tipos de IVA  }

      TTipoIVARec = packed record
        ejercicio         : smallInt;
        codigo            : smallInt;
        descripcion       : string15;
        case byte of
          0 : ( IVASoportado      : double;
                ctaSoportado      : string9;
                IVARepercutido,
                RERepercutido     : double;
                ctaRepercutido    : string9;
                liquidable        : boolean );

          1 : ( retencion         : double;
                ctaRetACuenta     : string9;
                reserved1,
                reserved2         : double;
                ctaRetPracticada  : string9;
                desglosar,
                sobreTotal        : boolean );
          end;


implementation

end.


