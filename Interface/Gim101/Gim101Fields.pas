{$ALIGN OFF} {$OPTIMIZATION OFF}

unit Gim101Fields;

interface

uses  DB,
      DataManager,

      Gim00Fields;

{$TYPEINFO ON}   // Rtti

const ctParametrosModulo101 = 1101;

type

  TArrayCampo = array[ 1..17 ] of SmallInt;

  // DataBuffer del fichero de configuración

  Type TParametrosHormigonesRec = packed record
    case byte of
      0 : ( Parametros          : TParametrosRec );
      1 : ( FicheroImportacion  : String[ 80 ];
            PosicionCampo,
            LongitudCampo       : TArrayCampo;
            CampoObra           : SmallInt;      );
      end;

implementation

end.
