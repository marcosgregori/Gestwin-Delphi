{$ALIGN OFF} {$OPTIMIZATION OFF}

unit Gim203Fields;

interface

uses   DB,
       DataManager;

{$TYPEINFO ON}   // Rtti

type

   TStockEnvasesFields = class( TnxeDatasetFields )
      public
       Propietario : TWideStringField;
       TipoEnvase : TSmallIntField;
       CodigoEnvase : TWideStringField;
       Cantidad : TBCDField;
     end;

implementation

end.
