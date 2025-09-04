{$ALIGN OFF} {$OPTIMIZATION OFF}

unit Gim103Fields;

interface

uses  DB,
      DataManager,

      Gim00Fields;

{$TYPEINFO ON}   // Rtti

const ctParametrosModulo103 = 1103;

type

    TParametrosImportacionRec = packed record
      case byte of
        0 : ( Parametros           : TParametrosRec );
        1 : ( FicheroMovimientos   : String[ 80 ];
              SerieAlbaranDestino  : String[ 2 ]    );
        end;


implementation

end.
