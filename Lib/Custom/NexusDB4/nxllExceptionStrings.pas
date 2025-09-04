{##############################################################################}
{# NexusDB: nxllExceptionStrings.pas 4.7516                                  #}
{# Copyright (c) UnSquashable Pty. Ltd. 2003-2025                             #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: Resourcestrings for Base Exception class                          #}
{##############################################################################}

{$I nxDefine.inc}

unit nxllExceptionStrings;

interface

resourcestring
  rsNexusDB = 'NexusDB: ';

  rsNoErrorCode = '%s [sin código de error]';
  rsHasErrorCode = '%s [$%x/%d]';

  rsOSError = 'Error del sistema operativo: %s ($%x/%d)';
  rsOSErrorUnk = 'Una llamada a una función del SO ha fallado.';
  rsOSErrorAction = 'Error del sistema operativo en %s: %s ($%x/%d)';
  rsOSErrorActionUnk = 'Una llamada a una función del SO ha fallado en %s';

const
  csOSError  = 'OSError';
  csAction   = 'Action';
  csModule   = 'Module';

implementation

end.
