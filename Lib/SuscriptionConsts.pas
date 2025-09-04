unit SuscriptionConsts;

interface

const  CCL_ERROR                    = 0;
       CCL_CORRECTA                 = 1;
       CCL_CADUCADA                 = 2;   // Está aún en el periodo de renovación (NroDiasRenovacion)
       CCL_EXPIRADA                 = 3;
       CCL_USUARIOINCORRECTO        = 4;
       CCL_NROPROGRAMAINCORRECTO    = 5;
       CCL_VERSIONINCORRECTA        = 6;
       CCL_NROSERIEINCORRECTO       = 7;
       CCL_NROPROGRAMADIFERENTE     = 8;
       CCL_NROUSUARIOSDIFERENTE     = 9;
       CCL_NOFACTURADO              = 10;
       CCL_PENDIENTECOBRO           = 11; // El efecto ha sido emitido pero está pendiente de cobro y fuera de plazo
       CCL_ERRORINTERNO             = 12;
       CCL_BLOQUEADO                = 13; // Ha sido marcado como bloqueado en la tarjeta de registro (temporalmente dado de baja)

       TextoEstadoSuscripcion       : array[ CCL_ERROR..CCL_BLOQUEADO ] of String =
                                    ( 'Suscripción no válida.',
                                      'Suscripción correcta.',
                                      'Suscripción caducada. Debe renovarla lo antes posible.',
                                      'La suscripción ha expirado.',
                                      'Código o nombre de usuario incorrectos.',
                                      'Número de aplicación incorrecto.',
                                      'Versión incorrecta.',
                                      'Número de serie incorrecto.',
                                      'Aplicación incorrecta.',
                                      'Número de usuarios incorrecto',
                                      'No facturado.',
                                      'Pendiente de cobro.',
                                      'Error interno.',
                                      'Bloqueado.' );
       // Estados de la remesa

       erPendiente = 0;
       erCobrada = 1;
       erDescontada = 2;
       erCancelada = 3;

       NroDiasCobro = 30;
       NroDiasRenovacion = 30;

       // Tipo de operacion

       idCompruebaLicencia = 1;
       idCompruebaSuscripcion = 2;

       ListaCodigosArticulo : array[ 1..6 ] of String = ( '00220001',   // Gestión contable
                                                          '00220002',   // Terminal punto de venta (TPV)
                                                          '00220003',   // Gestión contable, financiera y comercial
                                                          '00220004',   // Previsión de la producción
                                                          '00220005',   // Gestión financiera y comercial
                                                          '00220006' ); // Preventa

       TextoAplicacion : array[ 1..6 ] of String = ( 'Gestión contable y financiera',
                                                     'Terminal Punto de Venta',
                                                     'Gestión contable, financiera y comercial',
                                                     'Previsión de la producción',
                                                     'Gestión financiera y comercial',
                                                     'Preventa y Autoventa' );

       FicheroAplicacion : array[ 1..6 ] of String = ( 'Contable',
                                                       'TPV',
                                                       'ContableComercial',
                                                       'Prevision',
                                                       'Comercial',
                                                       'Preventa' );
       CodigoVendedorSuscripcion = 'VS';
       

resourceString
       RsErrorComprobacion = 'ERROR : No se ha podido completar la comprobación de la licencia.';

implementation

end.
