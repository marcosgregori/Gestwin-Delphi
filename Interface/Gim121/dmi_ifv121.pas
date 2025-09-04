{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_ifv121;

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
     CLSID_ImportacionFacturas121Service : TGuid = '{C500071C-F24C-4408-9694-64D7EE7CF67D}';

type

    IImportacionFacturas121Service = interface( ISessionModule )
      ['{21633398-6364-41E7-B523-54603DF6A854}']

      procedure EjecutaProceso( ContenidoFichero : String; Diario : Boolean = True );
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IImportacionFacturas121Service ) );

end.


