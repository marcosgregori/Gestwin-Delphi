{$ALIGN OFF} {$OPTIMIZATION OFF}

unit Gim116Fields;

interface

uses  DB,
      DataManager;

{$TYPEINFO ON}   // Rtti

const

    // Índice de cada parámetro en el campo Parametros de la línea de movimientos (bitwise)

    pinCantoPulido  = 0;
    pinBisel        = 1;
    pinBilateral2   = 2;
    pinBilateral4   = 3;
    pinTaladro      = 4;
    pinFigura       = 5;
    pinMaster       = 6;
    pinEspecial     = 7;
    pinTemplado     = 8;
    pinEstrias      = 9;
    pinPintado      = 10;
    pinEmbalaje     = 11;
    pinCalidad      = 12;
    pinCorte        = 13;

    // Índices de los valores del array CantidadParametro y PrecioParametro

    ppCantos     = 1;
    ppTaladros   = 2;
    ppEscots     = 3;
    ppPuntas     = 4;
    ppVarios     = 5;
    ppEmbalaje   = 6;

type
    TCantidadParametroArray = Array[ ppCantos..ppEmbalaje ] of TBCDField;
    TPrecioParametroArray = Array[ ppCantos..ppEmbalaje ] of TFloatField;

    TLineaValoracionManufacturaFields = class( TnxeDatasetFields )
    public
       Ejercicio : TSmallIntField;
       NroOperacion : TIntegerField;
       NroRegistroLinea : TIntegerField;
       SuperficieLargo : TBCDField;
       SuperficieAncho : TBCDField;
       Largo : TBCDField;
       Corto : TBCDField;
       MetrosLineales : TBCDField;
       EmbalajeLargo : TBCDField;
       EmbalajeAncho : TBCDField;
       MetrosCuadrados : TBCDField;
       CantidadParametro : TCantidadParametroArray;
       PrecioParametro : TPrecioParametroArray;
       SubtotalCantos : TBCDField;
       SubtotalTaladro : TBCDField;
       SubtotalEmbalaje : TBCDField;
       TotalManufactura : TBCDField;
       PorcentajeIncremento : TBCDField;
       Incremento : TBCDField;
       ImporteNeto : TBCDField;
    end;


implementation

end.
