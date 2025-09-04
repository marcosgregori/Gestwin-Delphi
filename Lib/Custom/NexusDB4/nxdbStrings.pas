{##############################################################################}
{# NexusDB: nxdbStrings.pas 4.7516                                           #}
{# Copyright (c) UnSquashable Pty. Ltd. 2003-2025                             #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: Resourcestrings for Data Access Components                        #}
{##############################################################################}

{$I nxDefine.inc}

unit nxdbStrings;

interface

resourcestring
  rsNoOwningSession = 'Sin sesi�n';
  rsAliasNoChangeForImplicitDatabase = 'AliasName no se puede cambiar para una base de datos impl�cita';
  rsAliasNameOrPathRequired = 'Se debe especificar AliasName o AliasPath';
  rsTableMustBeActive = 'La tabla %d (%s) debe estar activa';
  rsDataSetCantOpenDatabase = 'DataSet no puede abrir su base de datos';
  rsFltNoFldAccess = 'No hay acceso al campo mientras se est� filtrando el DataSet';
  rsNoFldBuffAccess = 'No hay acceso al b�fer de campo';
  rsBlobAccessNoMatch = 'El campo es de solo lectura, pero la secuencia BLOB se est� abriendo para el acceso de lectura / escritura';
  rsBlobTblNoEdit = 'La secuencia BLOB se est� abriendo para el acceso de lectura / escritura pero el DataSet no se est� editando';
  rsDataSetNotEditing = 'DataSet no est� en modo edici�n';
  rsDataSetEditing = 'DataSet en modo de edici�n';
  rsDataSetCantGetBuf = 'No se pudo recuperar el b�fer activo';
  rsBeginBatchAppendNotCalled = 'BeginBatchAppend no fue llamado';
  rsInvalidFieldType = 'El tipo de campo "%s" especificado para el campo "%s" no es compatible';
  rsTblCircDataLink = 'Enlace de datos circular con fuente de datos [%s]';
  rsQuerySetParamsFail = 'Ha fallado el conjunto de par�metros de la consulta: %s%s';
  rsQueryGetParamsFail = 'Los par�metros de obtenci�n de consulta fallaron: %s%s';
  rsQueryPrepareFail = 'Ha fallado la preparaci�n de la consulta: %s%s';
  rsQueryExecFail = 'Ha fallado la ejecuci�n de la consulta: %s%s';
  rsEmptySQLStatement = 'No se ha especificado una sentencia SQL';
  rsStreamDisconnected = 'El flujo ha sido desconectado';
  rsMustFreeBlobStreams = 'Todos los flujos BLOB deben liberarse antes de ejecutar esta operaci�n';
  rsParamValueError = 'Valor no v�lido para el par�metro ''%s''';
  rsUnnamedParam = '<ParamaetroSinNombre:%d>';
  rsCachedDataSetCantReferenceItself = 'TnxCachedDataSet no puede hacer referencia a s� mismo';
  rsInOnFilterRecordNotPossible = 'El DataSet no puede estar dentro de un OnFilterRecord durante esta operaci�n';

implementation

end.
