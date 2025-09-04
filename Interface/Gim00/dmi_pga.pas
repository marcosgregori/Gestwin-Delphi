{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_pga;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,
     DataManager,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,

     SessionIntf;

const    ctGlobal            = 0;
         ctEmpresa           = 1;
         ctUsuario           = 2;
         ctParametrosVentana = 3;
         ctBackup            = 4;
         ctCamposConsulta    = 5;

         // Añadidos nuevos tipos de registro para almacenar parámetros varios

         ctRelFichExp       = 100;     // Relacion de ficheros exportados la última vez
         ctImpAlbExternos   = 101;     // Configuración del proceso de importación de albaranes externos (otras aplicaciones)
         ctRelFichPreventa  = 102;     // Relacion de ficheros que se exportan en preventa
         ctSeguridad        = 103 ;    // Configuración de seguridad : certificados y firma digital

         ParamBlobFieldName = 'Data';

         FiltroParamName    = '@Filtro';

         pnDesarrollo        = 0;
         pnContable          = 1;
         pnTPV               = 2;
         pnContableComercial = 3;
         pnPrevision         = 4;
         pnComercial         = 5;
         pnPreventa          = 6;
         pnProduccion        = 7;
         //.. 8
         pnTareas            = 9;
         pnDDE               = 10;
         pnDemostracion      = 19;

          // Parámetros del registro

         ncrAplicacion        = 'Aplicacion';     // Grupo parámetros de la aplicación
         ncrOAuthAccess       = 'OAuthAccess';
         ncrProveedorOAuth    = 'OAuthProvider';
         ncrClientID          = 'ClientID';
         ncrTenantID          = 'TenantID';
         ncrClientSecret      = 'ClientSecret';
         ncrRefreshToken      = 'RefreshToken';

         // Nº Fichero DiarioProcesos (Campo Opcion)

         frdNinguno              = 0;
         frdUsuario              = 1;
         frdProveedor            = 2;
         frdCliente              = 3;
         frdArticulo             = 4;
         frdInmovilizado         = 5;
         frdTarifaVentas         = 6;
         frdExistenciasArticulo  = 7;
         frdTarifaVentasArticulo = 8;
         frdRelacionMateriales   = 9;
         frdRelacionOperaciones  = 10;

type     TTipoRegistroConfiguracion = ctGlobal..ctRelFichPreventa;

implementation

initialization

end.



