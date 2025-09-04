{$ALIGN OFF} {$OPTIMIZATION OFF}

unit Gim40Fields;

interface

uses  DB,
      LibUtils,
      Datamanager,

      Gim00Fields;

const ctParametrosModuloAprovisionamiento = 1004;

type
    TParametrosAprovisionamientoRec = packed record
      case Byte of
        0 : ( Parametros                 : TParametrosRec );
        1 : ( Reservado1                 : array[ 0..21 ] of Byte;
              MetodoCalculoMargen        : SmallInt;
              MargenPorcentualVenta      : Decimal;
              Reservado2                 : Boolean;
              SerieAlbaranesSalida       : String[ 2 ];
              Reservado3                 : array[ 0..16 ] of Byte;
              DocumentoHojaCarga         : SmallInt    );
        end;

     TTransportistaFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Nombre : TWideStringField;
     end;

     THojaCargaFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       NroHoja : TIntegerField;
       Fecha : TDateField;
       CodigoTransportista : TWideStringField;
       EjercicioReubicacion : TSmallIntField;
       NroOperacionReubicacion : TIntegerField;
       NoProcesar : TBooleanField;
       Procesado : TBooleanField;
       Anotacion : TWideMemoField;
     end;

     TLineaHojaCargaFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       NroHoja : TIntegerField;
       NroLinea : TSmallIntField;
       EjercicioOrigen : TSmallIntField;
       NroOperacionOrigen : TIntegerField;
       NroRegistroOrigen : TIntegerField;
       CodigoAlmacen : TWideStringField;
       Ubicacion : TWideStringField;
       NroCajas : TBCDField;
       Cargado : TBCDField;
       EjercicioDestino : TSmallIntField;
       NroOperacionDestino : TIntegerField;
       NroRegistroDestino : TIntegerField;
       Anotacion : TWideMemoField;
     end;

    // Ficheros temporales

    TAprovisionamientoFields = class( TnxeDatasetFields )
     public
       NroRegistro : TLongWordField;
       CodigoArticulo : TWideStringField;
       Descripcion : TWideStringField;
       CodigoProveedor : TWideStringField;
       CodigoAlmacenOrigen  : TWideStringField;
       StockMinimoOrigen,
       StockMaximoOrigen,
       ExistenciasOrigen : TBCDField;
       CodigoAlmacenDestino : TWideStringField;
       StockMinimoDestino,
       StockMaximoDestino,
       ExistenciasDestino,
       DisponibleEnOrigen,
       NecesidadEnDestino : TBCDField;
       PendienteRecibir : TBCDField;
       PendienteServir : TBCDField;
       Reposicion : TBCDField;
       ImporteNeto : TBCDField;
       Seleccionada : TBooleanField;
       NoCubierto : TBooleanField;
     end;

implementation

end.
