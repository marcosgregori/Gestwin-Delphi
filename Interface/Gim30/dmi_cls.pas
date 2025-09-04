{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_cls;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,
     DataManager,
     Gim10Fields,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,

     SessionIntf;

const
     CLSID_ClaseService : TGuid = '{D1B3ABEE-E01E-4C76-87CB-70035274928F}';

type

  IClaseService = interface( ISessionModule )
    ['{36BE99BC-DB3F-44EE-A53E-F169AFFEE7AE}']

    end;

const tcClaseA = 1;
      tcClaseB = 2;
      tcClaseC = 3;

      // Tipos de recipientes

      trpEnvase     = 0;
      trpContenedor = 1;

      // Tipos de envases

      tenReutilizable = 0;
      tenDesechable   = 1;

type  TNroClase = tcClaseA..tcClaseC;
      TTipoRecipiente = trpEnvase..trpContenedor;
      TTipoEnvase = tenReutilizable..tenDesechable;

      TTarifaClase = ( ttcCompras, ttcVentas );

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IClaseService ) );

end.


