{##############################################################################}
{# NexusDB: nxllComponentStrings.pas 4.7516                                  #}
{# Copyright (c) UnSquashable Pty. Ltd. 2003-2025                             #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: Resourcestrings for Base component classes                        #}
{##############################################################################}

{$I nxDefine.inc}

unit nxllComponentStrings;

interface

resourcestring
  rsNilPointer = '<puntero nulo>';
  rsUnnamedInst = '<instancia %s sin nombre>';
  rsInstNoCode = '%s. %s [sin c�digo de error]';
  rsInstHasErrorCode = '%s. %s [$%x/%d]';
  rsMustBeInactive = 'Este componente debe estar inactivo al realizar esta operaci�n.';
  rsMustBeStarted = 'Este componente debe estar iniciado al realizar esta operaci�n.';
  rsMustBeInactiveOrStopped = 'Este componente debe estar inactivo o detenido al realizar esta operaci�n.';
  rsInvalidStateTransition = 'Transici�n de estado no v�lida.';
  rsComponentIsDisabled = 'El componente est� desactivado.';

  rsStateInactive    = 'Inactivo';
  rsStateStopped     = 'Parado';
  rsStateStarted     = 'Iniciado';
  rsStateUnsupported = 'No soportado';
  rsStateFailed      = 'Ha fallado';

  rsStateTransitionInvalid      = 'No v�lido';
  rsStateTransitionNone         = 'Ninguno';
  rsStateTransitionInitializing = 'Inicializando';
  rsStateTransitionDeactivating = 'Desactivando';
  rsStateTransitionStarting     = 'Iniciado';
  rsStateTransitionStopping     = 'Parando';

implementation

end.
