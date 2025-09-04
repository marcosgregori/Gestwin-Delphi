
{******************************************}
{                                          }
{             FastScript v1.9              }
{                Resources                 }
{                                          }
{  (c) 2003-2007 by Alexander Tzyganenko,  }
{             Fast Reports Inc             }
{                                          }
{******************************************}

//VCL uses section
{$IFNDEF FMX}
unit fs_iconst;
{$ENDIF}

interface

{$i fs.inc}

var
  SLangNotFound: String;
  SInvalidLanguage: String;
  SIdRedeclared: String;
  SUnknownType: String;
  SIncompatibleTypes: String;
  SIdUndeclared: String;
  SClassRequired: String;
  SIndexRequired: String;
  SStringError: String;
  SClassError: String;
  SArrayRequired: String;
  SVarRequired: String;
  SNotEnoughParams: String;
  STooManyParams: String;
  SLeftCantAssigned: String;
  SForError: String;
  SEventError: String;
  SComponentError: String;
  SComponentAssignError: String;


implementation

initialization
  SLangNotFound := 'Lenguaje ''%s'' no encontrado';
  SInvalidLanguage := 'Lenguaje no válido';
  SIdRedeclared := 'Identificador redeclarado: ';
  SUnknownType := 'Tipo desconocido: ';
  SIncompatibleTypes := 'Tipos incompatibles';
  SIdUndeclared := 'Identificador no declarado: ';
  SClassRequired := 'Se requiere el tipo de la clase';
  SIndexRequired := 'Se requiere un índice';
  SStringError := 'La cadena no está entre las propiedades o métodos';
  SClassError := 'La clase %s no tiene propiedad por defecto';
  SArrayRequired := 'Se requiere un Array';
  SVarRequired := 'Variable requirida';
  SNotEnoughParams := 'Faltan parámetros';
  STooManyParams := 'Sobran parámetros';
  SLeftCantAssigned := 'El lado izquierdo no se puede asignar a';
  SForError := 'Los bucles For necesitan una variable numérica';
  SEventError := 'El manejador del evento ha de ser un procedimiento';
  SComponentError := 'Componente de nombre %s no encontrado';
  SComponentAssignError := 'No se puede asignar el valor al campo del componente %s';

end.
