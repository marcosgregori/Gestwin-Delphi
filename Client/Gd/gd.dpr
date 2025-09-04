program gd;

uses
  nxReplacementMemoryManager,
  nxReplacementMove,
  cxLookAndFeels,
  Windows,
  Forms,
  AppForm,
  nxsdServerEngine,
  gd.dxSettings in 'gd.dxSettings.pas';

{$R *.res}

// Estas opciones hacen que se cargue toda la aplicación en memoria y evita que se lean páginas desde el servidor cuando se necesitan (entre otras cosas)

const  IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE = $8000;

{$SetPEOptFlags IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE}
{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP or IMAGE_FILE_NET_RUN_FROM_SWAP}


begin

      // Configuración de NexusDB

     nxDisableFeature( nxfClientMessageReduction );
     nxDisableFeature( nxfDelaySetToBookmark );
     nxEnableFeature( nxfAllowLocalFilterForRecordGetBatch );

     TdxVisualRefinements.LightBorders := True;

     Application.Initialize;
     Application.CreateForm(TApplicationForm, ApplicationForm);
     Application.Run;

end.
