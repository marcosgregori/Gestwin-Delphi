{$ALIGN OFF} {$OPTIMIZATION OFF}

unit Gim204Fields;

interface

uses   DB,
       DataManager;

{$TYPEINFO ON}   // Rtti

type

    TPackingListFields = class( TnxeDatasetFields )
      public
       Ejercicio : TSmallIntField;
       NroOperacion : TIntegerField;
       NroPalets : TSmallIntField;
       TipoContenedor : TSmallIntField;
       NroContenedor : TWideStringField;
       NroPrecinto : TWideStringField;
     end;

implementation

end.
