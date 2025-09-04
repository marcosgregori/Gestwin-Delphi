{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_idf;

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
     nxsdTypes,

     SessionIntf,

     Gim30Fields,
     Gim70Fields,

     dmi_cla,

     OrdenFabricacionIntf,
     InformeFabricacionIntf;

const
     CLSID_InformeFabricacionService : TGuid = '{BDD7EB1F-42BD-4EBC-B0E3-9508F467FF72}';

type
    IInformeFabricacionService = interface( ISessionModule )
     ['{ACD75FC8-880C-4907-BAD1-9A57D5A45CE4}']

      procedure ActualizaInformeFabricacion( InformeFabricacion : IInformeFabricacion; RecalcularProceso : Boolean );
      function  SuprimeInformeFabricacion( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroOrden: LongInt; NroProceso : SmallInt; Fecha : TDate; Turno : SmallInt; RecalcularProceso : Boolean ) : Boolean;

      function CalculaCosteArticulo( OrdenFabricacion : IOrdenFabricacion ) : Decimal;
      function ActualizaReferenciasRegistro( OrdenFabricacion : IOrdenFabricacion; InformeFabricacion : IInformeFabricacion; Descontar : Boolean ) : Boolean;
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IInformeFabricacionService ) );

end.



