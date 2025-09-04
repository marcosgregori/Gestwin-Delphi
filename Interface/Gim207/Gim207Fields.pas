{$ALIGN OFF} {$OPTIMIZATION OFF}

unit Gim207Fields;

interface

uses   DB,
       DataManager;

{$TYPEINFO ON}   // Rtti

const SeparadorClases = '·';

type

  TCategoriaFields = class( TnxeDatasetFields)
  public
    Codigo : TWideStringField;
    Nombre : TWideStringField;
    CodigoPadre : TWideStringField;
    DespuesDeCodigo : TWideStringField;
    Descripcion : TWideStringField;
    CodigoFamilia : TWideStringField;
    Activo: TBooleanField;
  end;

  TCategoriasArticuloFields = class( TnxeDatasetFields)
  public
    CodigoArticulo : TWideStringField;
    NroOrden : TSmallIntField;
    CodigoCategoria : TWideStringField;
    end;

implementation

end.
