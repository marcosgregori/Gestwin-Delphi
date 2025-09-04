unit Gim60Fields;

interface

uses   DB,
       DataManager;

{$TYPEINFO ON}   // Rtti

type

  TRegistroExportacionFields = class( TnxeDatasetFields)
  public
    TipoDocumento : TSmallIntField;
    Ejercicio : TSmallIntField;
    Serie : TWideStringField;
    NroDocumento : TIntegerField;
    NroRegistro : TSmallIntField;
  end;


implementation

end.
