{$ALIGN OFF} {$OPTIMIZATION OFF}

unit Gim119Fields;

interface

uses  DB,
      DataManager,

      Gim00Fields;

{$TYPEINFO ON}   // Rtti

const ctParametrosModulo119 = 1119;

type

    TSocioAUNAFields = class( TnxeDatasetFields )
    public
      IdSocio : TWideStringField;
      Nombre : TWideStringField;
      CIF : TWideStringField;
    end;

    TAlmacenAUNAFields = class( TnxeDatasetFields )
    public
      IdSocio : TWideStringField;
      IdAlmacen : TWideStringField;
      Nombre : TWideStringField;
    end;

implementation

end.
