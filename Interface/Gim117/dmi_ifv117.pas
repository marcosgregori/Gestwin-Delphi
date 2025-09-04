{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_ifv117;

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

const
     CLSID_ImportacionFacturasVenta117Service : TGuid = '{D7E32F1C-2A60-440B-8F2F-3E9B949FEB4A}';

type

    IImportacionFacturasVenta117Service = interface( ISessionModule )
      ['{441C65E4-84BC-445F-9A8A-1BE8FCA3371D}']

      procedure EjecutaProceso( ContenidoFichero : String );
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IImportacionFacturasVenta117Service ) );

end.


