{$ALIGN OFF} {$OPTIMIZATION OFF}

unit Gim114Fields;

interface

uses  DB,
      DataManager,

      Gim00Fields;

{$TYPEINFO ON}   // Rtti

const ctParametrosModulo114 = 1114;

type

    TDocumentoControlMercanciasFields = class( TnxeDatasetFields)
  public
    Ejercicio : TSmallIntField;
    NroOperacion : TIntegerField;
    Tipo : TSmallIntField;
    CodigoNaviera : TWideStringField;
    Destino : TWideStringField;
    FechaCarga : TDateField;
    Plataforma : TSmallIntField;
    LugarOrigen : TWideStringField;
    LugarDestino : TWideStringField;
    Peso : TBCDField;
    NumeroContenedor : TWideStringField;
    Precinto : TWideStringField;
    CodigoCliente : TWideStringField;
    ReferenciaCliente : TWideStringField;
    CodigoTransportista : TWideStringField;
    OrdenNaviera : TWideStringField;
    SituacionCarga : TSmallIntField;
    NroOperacionCompra : TIntegerField;
    NroOperacionVenta : TIntegerField;
    Observaciones : TWideMemoField;
  end;

  TCargaFields = class( TnxeDatasetFields)
  public
    Ejercicio : TSmallIntField;
    NroOperacion : TIntegerField;
    NroLinea : TSmallIntField;
    CodigoFabrica : TWideStringField;
    Referencia : TWideStringField;
    Hora : TTimeField;
    end;

  TFabricaFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Nombre : TWideStringField;
       Domicilio : TWideStringField;
       Localidad : TWideStringField;
       CodigoPais : TWideStringField;
       CodigoProvincia : TWideStringField;
       CodigoPostal : TWideStringField;
       Telefono : TWideStringField;
       Movil : TWideStringField;
       Fax : TWideStringField;
       EMail : TWideStringField;
       CodigoArticulo : TWideStringField;
       Anotacion : TWideMemoField;
     end;

  TNavieraFields = class( TnxeDatasetFields)
  public
    Codigo : TWideStringField;
    Nombre : TWideStringField;
    end;


implementation

end.
