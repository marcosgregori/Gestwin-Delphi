
unit AppRecTypes;

interface

uses comun;

const codigoSpain  = '011';     // El código por defecto para España
      prImpreso    = 1000;      // constante para el nroPrograma del registro informeExternoRec 

Type  TEmpresaRec  = packed record
        codigo             : string3;

        nombre,
        domicilio          : string30;
        localidad          : string20;
        codigoPais         : string3;
        codigoProvincia    : string2;
        codigoPostal       : string3;
        NIF                : string15;
        telefono,
        fax                : string[ 20 ];
        dataPath           : string[ 127 ];
        usoFuturo          : array[ 1..128 ] of byte;

        compras : packed record
          ultNroFactura        : longInt;
          decimales            : array[ 1..4 ] of smallInt;
          consumo,
          visualizarStock,
          emitirFacturas       : boolean;
          cantidades           : smallInt;
          nombreCajas          : string5;
          metodoCalculo        : smallInt;
          redondearImporteNeto,
          actualizarTarifas,
          ubicaciones,
          numerosDeSerie,
          lotesFabricacion,
          divisas              : boolean;
          almacenDefecto       : string2;
          usoFuturo1           : array[ 1..20 ] of byte;
          end;

        ventas : packed record
          contabilizarMovCaja  : boolean;
          reservado1           : array[ 0..4 ] of byte;
          decimales            : array[ 1..4 ] of smallInt;
          consumo,
          visualizarStock,
          dtoPrevio,
          formaPagoDocumentos,
          seriesPedido         : boolean;
          cantidades           : smallInt;
          nombreCajas          : string5;
          metodoCalculo        : smallInt;
          redondearImporteNeto,
          ubicaciones,
          numerosDeSerie,
          lotesFabricacion     : boolean;
          serieDefecto         : string2;
          almacenDefecto       : string2;
          mostrarRiesgoPedido,
          mostrarRiesgoAlbaran,
          transportistas       : boolean;
          reservado2           : array[ 0..1 ] of byte;
          comprobarCorrDoc     : boolean;
          usoFuturo2           : array[ 1..2 ] of byte;
          end;

        preventa : packed record
          activa               : boolean;
          serie                : string2;
          documentoDestino     : smallInt;
          todosLosArticulos    : boolean;
          serieArtRetirados    : string2;
          usoFuturo2           : array[ 1..6 ] of byte;
          end;

        almacen : packed record
          multiAlmacen,
          altasFabricacion,
          lotesProductos,
          ubicaciones            : boolean;
          almacenDefecto,
          almacenPreventa        : string2;
          avisoStock,
          impedirSalidasSinStock : boolean;
          usoFuturo3             : array[ 1..20 ] of byte;
          end;

        contabilidad : packed record
          mesInicial           : smallInt;
          centrosCoste,
          nroRegistroFras,
          retenciones,
          bloqueoTrimestres,
          euros,
          divisas,
          nroRegistroAsientos  : boolean;
          usoFuturo4           : array[ 1..20 ] of byte;
          end;

        cliente : packed record
          registroAuxiliar     : boolean;
          campoAuxiliar        : array[ 1..8 ] of string[ 15 ];
          gruposCliente        : boolean;
          tarifasCodigo,
          tarifasConsumo,
          referencias,
          ventasPeriodicas     : boolean;
          camposLibres         : boolean;
          campoLibre           : array[ 1..4 ] of string[ 15 ];
          canalPorSerie,       
          aplicarDtosTarifas   : boolean;
          usoFuturo5           : array[ 1..20 ] of byte;
          end;

        proveedor : packed record
          camposLibres         : boolean;
          campoLibre           : array[ 1..4 ] of string[ 15 ];
          usoFuturo5           : array[ 1..20 ] of byte;
          end;

        articulo : packed record
          cajas,
          pallets,
          ubicacion,
          bultos               : boolean;
          existeClase          : array[ 1..3 ] of boolean;
          nombreClase          : array[ 1..3 ] of string10;
          tarifaClases,
          puntoVerde,
          gestionPreciosIVA,
          camposLibres         : boolean;
          campoLibre           : array[ 1..4 ] of string[ 15 ];
          usoFuturo6           : array[ 1..20 ] of byte;
          end;

        vendedor : packed record
          comisionPorCliente   : boolean;
          usoFuturo7           : array[ 1..10 ] of byte;
          end;

        fabricacion : packed record
          lotesfabricacion     : boolean;
          usoFuturo8           : array[ 1..10 ] of byte;
          end;

        end;

{ 54 }

      TUsuarioRec = packed record

        codigo         : string[ 2 ];
        nombre         : string[ 30 ];
        serieDefecto,
        almacenDefecto : string2;
        password       : string10;
        codigoEmpresa  : string3;
        case byte of
          0 : ( accesos                 : array[ 1..60 ] of smallInt );
          1 : ( acGC,
                acGCFicheros,
                acGCAsientos,
                acGCListados,
                acGCProcesos,

                acLI,
                acLIFicheros,

                acPC,
                acPCFicheros,

                acEI,
                acEIFicheros,

                acCO,
                acCOFicheros,
                acCOProveedores,
                acCOTarifas,
                acCOFormasPago,
                acCORelaciones,
                acCOProcesos,

                acVE,
                acVEFicheros,
                acVEClientes,
                acVEVendedores,
                acVESeries,
                acVETarifas,
                acVEFormasCobro,
                acVERelaciones,
                acVEProcesos,

                acAL,
                acALFicheros,
                acALArticulos,
                acALListasMateriales,
                acALAlmacenes,
                acALTiposMovimiento,
                acALReservado,
                acALProcesos,

                acRE,

                acGP,
                acGPFicheros,
                acGPRelaciones,
                acGPOperarios,
                acGPMaquinas,
                acGPOperaciones,
                acGPTurnos,
                acGPPrevision,
                acGPLanzamiento,
                acGPSeguimiento,
                acGPNotificaciones,
                acGPProcesos,

                acCaFicheros,
                acCaCaja,
                acCaListados,
                acCaProcesos,
                acCaArqueo             : smallInt;

                reservado3             : array[ 0..5 ] of byte;

                acApProcesosCriticos   : smallInt );
          end;

{ 55 }

      TProvinciaRec = packed record
        codigoPais  : string3;
        nroRegistro : smallInt;
        codigo      : string2;
        nombre      : string30;
        end;

{ 56 }

      TParametrosRec    = array[ 1..128 ] of byte;
      TArrayCampo       = array[ 1..11 ] of smallInt;

      TConfiguracionRec = packed record
        aplicacion,
        tipo             : smallInt;
        codigo           : string5;
        case byte of
          0 : ( parametros                 : TParametrosRec );

          1 : ( preInsercion,
                transacciones,
                accesoRemoto,
                simularTab                 : boolean;
                localizacionWebSoporte     : smallInt;
                direccionCorreo            : string30;
                reservado                  : array[ 1..10 ] of byte;
                subrayadoLineas            : boolean;

                servidorSMTP               : string20;
                puertoSMTP                 : smallInt;
                servidorPOP3               : string20;
                puertoPOP3                 : smallInt;
                usuarioCorreo              : string20;
                passwordCorreo             : string10                );

          2 : ( ventanaInicial             : smallInt;
                pathFicheroDatosCapturador : string[ 60 ]            );

          // Módulo TPV

          3 : ( insAutAlbaranes,
                puertoCOMVisor,
                modeloVisor                : smallInt;
                inicializarPuerto          : boolean;
                impresoraVisor             : string[ 60 ];
                puertoCOMCajon,
                modeloCajon,
                documentoArqueo            : smallInt;
                textoVisor1,
                textoVisor2                : string[ 20 ];
                adaptadoAlEuro             : boolean;
                saldoInicialCaja           : double                 );

                // La variable adaptado al Euro indica si el módulo TPV ha sido
                // o no adaptado al Euro, independientemente de si N3 lo está

          // Producción

          4 : ( almacenComponentes,
               almacenProdAcabado         : string2;
               tipoJornadaSabado          : smallInt;
               retrasoMaximoLanzamiento,
               decimalesComponentes       : smallInt;
               metodoCalculoCoste         : smallInt;
               incrementoPorcentualCoste  : double;
               metodoCalculoMargen        : smallInt;
               margenPorcentualVenta      : double;
               usarLotesfabricacion       : boolean;
               serieAlbaranesSalida       : string2;
               metodoNumeracionLote       : smallInt;
               retrasoMaximoTareas        : smallInt;
               mantenerTurnoEnAsignacion,
               incorporarExtraerArticulos : boolean;
               almacenProdDefectuoso      : string2;
               almacenarProdDefectuosos,
               mermaExcesoArticulos,
               realizarProduccionPrevista,
               ajusteAutomaticoConsumos,
               noDescontarComponentes     : boolean;
               almacenExtracciones        : string2                 );

          // II.EE.

          5 : ( articuloLiquidacion        : string13;
                almacenTanque              : string2;
                tipoDevoluciones           : smallInt               );

          // Modulo Hormigones

          6 : ( ficheroImportacion         : string[ 80 ];
                posicionCampo,
                longitudCampo              : TArrayCampo;
                campoObra                  : smallInt;              );
          end;

{ 57 }

      TInformeExternoRec = packed record
        nroPrograma,
        nroRegistro      : smallInt;
        descripcion      : string30;
        fichero          : string128;
        codigoEmpresa    : string3;
        codigoUsuario    : string2;        //* 23.12.1999 Añadido para permitir aplicar distintos formatos por usuario
        seccion          : smallInt;
        impresora        : string128;
        end;

{ 58 }
      TFicherosRec = packed record
        codigoEmpresa    : string3;
        nombreFichero    : string20;
        localizacion     : smallInt;
        comentario       : string40;
        end;

{ 59 }

      TPaisRec = packed record
        codigo      : string3;
        nombre      : string40;
        end;

      TDivisaRec = packed record
        codigo      : string3;
        descripcion : string30;
        precision   : double;
        cambioFijo  : boolean;
        tipoCambio  : double;
        end;

      TTipoCambioRec = packed record
        fecha         : TDateRec;
        codigoDivisa  : string3;
        tipoCambio    : double;
        end;

      TPlantillaGraficoRec = packed record
        tipo          : smallInt;
        nroOperacion  : longInt;
        nroRegistro   : smallInt;
        descripcion   : string40;
        nroEjercicio  : smallInt;
        codigo1,
        codigo2       : string20;
        codigo3,
        codigo4,
        codigo5       : string5;
        operacion1,
        operacion2,
        operacion3    : smallInt;
        opcion1,
        opcion2,
        opcion3       : boolean;
        usoFuturo     : array[ 1..20 ] of byte;
        end;

{ 114 y 115 }

      TEstructuraFicheroRec = packed record
        fichero,
        nroRegistro      : smallInt;
        descripcion      : string30;
        ficheroExterno   : string80;
        decimalImplicito : boolean;
        formato          : smallInt;
        separador        : string1;
        usoFuturo        : array[ 0..74 ] of byte;
        end;

      TLineaEstructuraFicheroRec = packed record
        fichero,
        nroRegistro,
        nroLinea     : smallInt;
        campo        : string20;
        inicio,
        longitud     : smallInt;
        constante    : string40;
        automatico   : boolean;
        decimales    : smallInt;
        incluir      : boolean;
        usoFuturo    : array[ 0..6 ] of byte;
        end;

implementation

end.


