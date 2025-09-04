unit SuscriptionConsts;

interface

const  CCL_ERROR                    = 0;
       CCL_CORRECTA                 = 1;
       CCL_CADUCADA                 = 2;   // Est� a�n en el periodo de renovaci�n (NroDiasRenovacion)
       CCL_EXPIRADA                 = 3;
       CCL_USUARIOINCORRECTO        = 4;
       CCL_NROPROGRAMAINCORRECTO    = 5;
       CCL_VERSIONINCORRECTA        = 6;
       CCL_NROSERIEINCORRECTO       = 7;
       CCL_NROPROGRAMADIFERENTE     = 8;
       CCL_NROUSUARIOSDIFERENTE     = 9;
       CCL_NOFACTURADO              = 10;
       CCL_PENDIENTECOBRO           = 11; // El efecto ha sido emitido pero est� pendiente de cobro y fuera de plazo
       CCL_ERRORINTERNO             = 12;
       CCL_BLOQUEADO                = 13; // Ha sido marcado como bloqueado en la tarjeta de registro (temporalmente dado de baja)

       TextoEstadoSuscripcion       : array[ CCL_ERROR..CCL_BLOQUEADO ] of String =
                                    ( 'Suscripci�n no v�lida.',
                                      'Suscripci�n correcta.',
                                      'Suscripci�n caducada. Debe renovarla lo antes posible.',
                                      'La suscripci�n ha expirado.',
                                      'C�digo o nombre de usuario incorrectos.',
                                      'N�mero de aplicaci�n incorrecto.',
                                      'Versi�n incorrecta.',
                                      'N�mero de serie incorrecto.',
                                      'Aplicaci�n incorrecta.',
                                      'N�mero de usuarios incorrecto',
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

       ListaCodigosArticulo : array[ 1..6 ] of String = ( '00220001',   // Gesti�n contable
                                                          '00220002',   // Terminal punto de venta (TPV)
                                                          '00220003',   // Gesti�n contable, financiera y comercial
                                                          '00220004',   // Previsi�n de la producci�n
                                                          '00220005',   // Gesti�n financiera y comercial
                                                          '00220006' ); // Preventa

       TextoAplicacion : array[ 1..6 ] of String = ( 'Gesti�n contable y financiera',
                                                     'Terminal Punto de Venta',
                                                     'Gesti�n contable, financiera y comercial',
                                                     'Previsi�n de la producci�n',
                                                     'Gesti�n financiera y comercial',
                                                     'Preventa y Autoventa' );

       FicheroAplicacion : array[ 1..6 ] of String = ( 'Contable',
                                                       'TPV',
                                                       'ContableComercial',
                                                       'Prevision',
                                                       'Comercial',
                                                       'Preventa' );
       CodigoVendedorSuscripcion = 'VS';
       

resourceString
       RsErrorComprobacion = 'ERROR : No se ha podido completar la comprobaci�n de la licencia.';

implementation

end.
