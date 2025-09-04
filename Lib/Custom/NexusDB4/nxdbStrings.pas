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
  rsNoOwningSession = 'Sin sesión';
  rsAliasNoChangeForImplicitDatabase = 'AliasName no se puede cambiar para una base de datos implícita';
  rsAliasNameOrPathRequired = 'Se debe especificar AliasName o AliasPath';
  rsTableMustBeActive = 'La tabla %d (%s) debe estar activa';
  rsDataSetCantOpenDatabase = 'DataSet no puede abrir su base de datos';
  rsFltNoFldAccess = 'No hay acceso al campo mientras se está filtrando el DataSet';
  rsNoFldBuffAccess = 'No hay acceso al búfer de campo';
  rsBlobAccessNoMatch = 'El campo es de solo lectura, pero la secuencia BLOB se está abriendo para el acceso de lectura / escritura';
  rsBlobTblNoEdit = 'La secuencia BLOB se está abriendo para el acceso de lectura / escritura pero el DataSet no se está editando';
  rsDataSetNotEditing = 'DataSet no está en modo edición';
  rsDataSetEditing = 'DataSet en modo de edición';
  rsDataSetCantGetBuf = 'No se pudo recuperar el búfer activo';
  rsBeginBatchAppendNotCalled = 'BeginBatchAppend no fue llamado';
  rsInvalidFieldType = 'El tipo de campo "%s" especificado para el campo "%s" no es compatible';
  rsTblCircDataLink = 'Enlace de datos circular con fuente de datos [%s]';
  rsQuerySetParamsFail = 'Ha fallado el conjunto de parámetros de la consulta: %s%s';
  rsQueryGetParamsFail = 'Los parámetros de obtención de consulta fallaron: %s%s';
  rsQueryPrepareFail = 'Ha fallado la preparación de la consulta: %s%s';
  rsQueryExecFail = 'Ha fallado la ejecución de la consulta: %s%s';
  rsEmptySQLStatement = 'No se ha especificado una sentencia SQL';
  rsStreamDisconnected = 'El flujo ha sido desconectado';
  rsMustFreeBlobStreams = 'Todos los flujos BLOB deben liberarse antes de ejecutar esta operación';
  rsParamValueError = 'Valor no válido para el parámetro ''%s''';
  rsUnnamedParam = '<ParamaetroSinNombre:%d>';
  rsCachedDataSetCantReferenceItself = 'TnxCachedDataSet no puede hacer referencia a sí mismo';
  rsInOnFilterRecordNotPossible = 'El DataSet no puede estar dentro de un OnFilterRecord durante esta operación';

implementation

end.
