{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_dcm114;

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
     CLSID_DocumentoControlMercanciasService : TGuid = '{4863441C-7738-4F3C-ABD9-8CF4C1B27047}';

type

    IDocumentoControlMercanciasService = interface( ISessionModule )
      ['{3C508F0A-CC01-4348-8950-5D6D3FDA0EFC}']

      function ProximoNroOperacion : LongInt;
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IDocumentoControlMercanciasService ) );

end.


