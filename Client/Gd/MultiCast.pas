unit MultiCast;

interface

uses  Classes,
      Generics.Collections;

type   TEventDispatcher = class( TComponent )

         end;

       TMultiCast = class
       public Add( AComponent : TComponent; AEvent : TEvent; AHandler : TEvent );
         end;

// Ejemplo de uso MultiCast.Add( AComponent, AEvent, AHandler );

implementation

end.
