
{ ******************************************

              FastReport v3.0
          NX enduser components

  Creado por : Marcos Gregori Forestier

  ****************************************** }

unit frxNXRTTI;

interface

uses
  Windows, Classes, fs_iinterpreter, frxClass, frxNXComponents, SysUtils, Variants, Math,

  LibUtils;


{$I frx.inc}

{ El tipo SmallInt no existe en PascalScript. Solo Byte (que es también un Integer), Word, Integer, LongInt y Cardinal }

type
  TTipoConsultaTipoIVA = ( tcIVASoportado, tcIVARepercutido, tcRE, tcRetencion );
  TConsultaTipoIVAEvent = function( Tipo : TTipoConsultaTipoIVA; Fecha : TDate; CodigoPais : String; NroRegistro : Integer ) : Decimal of object;
  TDescripcionTasaEvent = function( Modelo : Integer; NroRegistro : Integer; Fecha : TDate; CodigoPais : String ) : String of object;
  TCostePeriodoEvent = function( CodigoArticulo : String; CodigoClaseA, CodigoClaseB, CodigoClaseC : String; TodosLosLotes : Boolean; LoteFabricacion : String; TodosLosAlmacenes : Boolean; CodigoAlmacen : String; TodasLasUbicaciones : Boolean; CodigoUbicacion : String; Ejercicio : Integer; MesInicial, MesFinal : Byte ) : Decimal of object;
  TCosteFechaEvent = function( CodigoArticulo : String; TodasLasClases : Boolean; CodigoClaseA, CodigoClaseB, CodigoClaseC : String; TodosLosLotes : Boolean; LoteFabricacion : String; TodosLosAlmacenes : Boolean; CodigoAlmacen : String; TodasLasUbicaciones : Boolean; CodigoUbicacion : String; Fecha : TDate ) : Decimal of object;
  TExistenciasEvent = function( CodigoArticulo : String; TodasLasClases : Boolean; CodigoClaseA, CodigoClaseB, CodigoClaseC : String; TodosLosLotes : Boolean; LoteFabricacion : String; TodosLosAlmacenes : Boolean; CodigoAlmacen : String; TodasLasUbicaciones : Boolean; CodigoUbicacion : String; ObtenCoste : Boolean; Ejercicio : Integer; MesInicial, MesFinal : Byte ) : Decimal of object;
  TSaldoPeriodoEvent = function( SubCuenta : String; CentroCoste : String; TodosLosCC : Boolean; Ejercicio : Integer; MesInicial, MesFinal : Byte; Apertura : Boolean = False ) : Decimal of object;
  TObtenDCIBANEvent = function( CodigoIBAN : String ) : String;

  TFunctions = class(TfsRTTIModule)
  private

    function CallMethod(Instance: TObject; ClassType: TClass; const MethodName: String; var Params: Variant): Variant;
    function CallMethod1(Instance: TObject; ClassType: TClass; const MethodName: String; var Params: Variant): Variant;
    function CallMethod2(Instance: TObject; ClassType: TClass; const MethodName: String; var Params: Variant): Variant;

    function GetProp( Instance : TObject; ClassType : TClass; const PropName : String ) : Variant;
    (*
    function SQLDateString( date : integer ) : string;
    function DateToString( date : integer; format : Byte ) : string;
    function DMYToDate( day, month, year : word ) : integer;
    *)


  public
    constructor Create(AScript: TfsScript); override;
    destructor Destroy; override;
  end;

var  Functions : TFunctions;

     // Estos eventos son asignados y des-asignados (nil) por los mismos módulos en los que están definidos

     ConsultaTipoIVAEvent : TConsultaTipoIVAEvent = nil;
     DescripcionTasaEvent : TDescripcionTasaEvent = nil;
     CostePeriodoEvent : TCostePeriodoEvent = nil;
     CosteFechaEvent : TCosteFechaEvent = nil;
     ExistenciasEvent : TExistenciasEvent = nil;
     SaldoPeriodoEvent : TSaldoPeriodoEvent = nil;
     ObtenDCIBANEvent : TObtenDCIBANEvent = nil;

implementation

uses  fs_itools,

      procID,
      nxDB,

      AppManager,
      TextConvert,

      cxDateUtils;

const CatMath = 'ctMath';
      CatString = 'ctString';
      CatConv = 'ctConv';
      CatGestwin = 'Gestwin';
      CatFormat = 'ctFormat';

{ TFunctions }

constructor TFunctions.Create(AScript: TfsScript);

// var fsCV : TfsClassVariable;

begin

     inherited Create(AScript);

     With AScript do
       begin

       With AddClass( TfrxNXDatabase, 'TfrxCustomDatabase' ) do
         AddProperty( 'Path', 'String', GetProp, nil );

       With AddClass( TfrxNXTable, 'TfrxCustomTable' ) do
         AddMethod('function FindKey(const KeyValues: Array ): Boolean', CallMethod );

       With AddClass( TfrxNXQuery, 'TfrxCustomQuery' ) do
         AddMethod('procedure ExecSQL', CallMethod );


       {
       Lo guardo como ejemplo

       fsCV := findClass( 'TfrxCustomEngine' );
       If   assigned( fsCV )
       then fsCV.AddMethod('procedure EndPage', CallMethod);
       }


       AddMethod('function Power(Base, Exponent : Extended): Extended', CallMethod1, CatMath);
       AddMethod('function Redondea(Valor:Extended; Decimales : Integer): Extended', CallMethod1, CatMath);

       AddMethod('function StringReplace(const S, OldPattern, NewPattern: string ):String;', CallMethod1, CatString);

       AddMethod('function StrToIntDef(S: String; Default : Integer): Integer', CallMethod1, CatConv);
       AddMethod('function StrToFloatDef(S: String; Default : Extended): Extended', CallMethod1, CatConv);
       AddMethod('function StrMonth(M: Byte; Short : Boolean = False): String', CallMethod1, CatConv);
       AddMethod('function QuotedStr(S: String): String', CallMethod1, CatConv);
       AddMethod('function SysDate: TDateTime', CallMethod1, CatConv);
       AddMethod('function RTFToPlainText(S: String ): String', CallMethod1, CatConv);
       AddMethod('function Cifra(Valor:Currency): String', CallMethod1, CatConv);

       AddMethod('function FormatDuration(Value: LongInt; Format : Integer = 0 ): String', CallMethod1, CatFormat);

       AddMethod('function TipoIVASoportado( NroRegistro : Integer; Fecha: TDateTime = 0 ):Currency', CallMethod2, CatGestwin );
       AddMethod('function TipoIVARepercutido( NroRegistro : Integer; Fecha: TDateTime = 0; CodigoPais : String = '' ):Currency', CallMethod2, CatGestwin );
       AddMethod('function TipoRE( NroRegistro : Integer; Fecha: TDateTime = 0 ):Currency', CallMethod2, CatGestwin );
       AddMethod('function TipoRetencion( NroRegistro : Integer; Fecha: TDateTime = 0 ):Currency', CallMethod2, CatGestwin );
       AddMethod('function DescripcionTasa( Modelo : Integer; NroRegistro : Integer; Fecha: TDateTime = 0; CodigoPais : String = '' ):Currency', CallMethod2, CatGestwin );
       AddMethod('function CostePeriodo( CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC: String; TodosLosLotes: Boolean; LoteFabricacion: String; TodosLosAlmacenes: Boolean; CodigoAlmacen: String; '+
                 'TodasLasUbicaciones: Boolean; CodigoUbicacion: String; Ejercicio : Integer; MesInicial, MesFinal: Byte ) : Currency', CallMethod2, CatGestwin );
       AddMethod('function CosteFecha( CodigoArticulo : String; TodasLasClases : Boolean; CodigoClaseA, CodigoClaseB, CodigoClaseC: String; TodosLosLotes: Boolean; LoteFabricacion: String; TodosLosAlmacenes: Boolean; CodigoAlmacen: String; '+
                 'TodasLasUbicaciones: Boolean; CodigoUbicacion: String; Fecha : TDate ) : Currency', CallMethod2, CatGestwin );
       AddMethod('function ExistenciasArticulo( CodigoArticulo : String; TodasLasClases : Boolean; CodigoClaseA, CodigoClaseB, CodigoClaseC : String; TodosLosLotes : Boolean; LoteFabricacion : String; TodosLosAlmacenes : Boolean; ' +
                  'CodigoAlmacen : String; TodasLasUbicaciones : Boolean; CodigoUbicacion : String; Ejercicio : Integer; MesInicial, MesFinal : Byte ) : Currency', CallMethod2, CatGestwin );
       AddMethod('function SaldoPeriodo( SubCuenta: String, CentroCoste: String; TodosLosCC: Boolean; Ejercicio : Integer; MesInicial, MesFinal: Byte; Apertura: Boolean = False; LimpiaDatos: Boolean = True ) : Currency', CallMethod2, CatGestwin );
       AddMethod('function CalculaPorcentaje( Valor1, Valor2 : Currency; RangoAjustado : Boolean = False): Integer', CallMethod2, CatGestwin );
       AddMethod('function ObtenDCIBAN( Valor1 : String ): String', CallMethod2, CatGestwin );
       end;

    Functions := Self;  // Anticipando

end;

destructor TFunctions.Destroy;
begin
     If   fsGlobalUnit<>nil
     then fsGlobalUnit.RemoveItems( Self );
     inherited;
end;

function TFunctions.CallMethod(       Instance   : TObject;
                                      ClassType  : TClass;
                                const MethodName : String;
                                var   Params     : Variant ): Variant;

var  VarRecParams : TVarRecArray;
     SPtrList: TList;

begin
     Result := 0;
     If   ClassType=TfrxNXQuery
     then begin
          If   MethodName='EXECSQL'
          then TfrxNXQuery( Instance ).Query.ExecSQL;
          end
     else If   ClassType=TfrxNXTable
          then begin
               If   MethodName='FINDKEY'
               then begin
                    try
                      VariantToVarRec( Params[ 0 ], VarRecParams, SPtrList );
                      Result := TfrxNXTable( Instance ).Table.FindKey( VarRecParams );
                    finally
                      ClearVarRec( VarRecParams, SPtrList );
                      end;
                    end;
               end;
     {
     else If   ClassType=TfrxCustomEngine
          then If   MethodName='ENDPAGE'
               then TfrxCustomEngine(Instance).EndPage;
     }
end;

function TFunctions.CallMethod1(       Instance   : TObject;
                                       ClassType  : TClass;
                                 const MethodName : String;
                                 var   Params     : Variant): Variant;

var  Value : String;

begin
     If   MethodName = 'POWER'
     then Result := Power( Params[ 0 ], Params[ 1 ] )
     else If   MethodName = 'STRINGREPLACE'
          then Result := StringReplace( Params[ 0 ], Params[ 1 ], Params[ 2 ], [ rfReplaceAll, rfIgnoreCase ] )
          else If   MethodName = 'STRTOINTDEF'
               then Result := StrToIntDef( Params[ 0 ], Params[ 1 ] )
                else If   MethodName = 'STRTOFLOATDEF'
                     then begin
                          Value := StringReplace( Params[ 0 ], ',', '.', [ rfReplaceAll, rfIgnoreCase ] );
                          Result := StrToFloatDef( Value, Params[ 1 ] );
                          end
                     else If   MethodName = 'STRMONTH'
                          then Result := StrMonth( Params[ 0 ], Params[ 1 ] )
                          else If   MethodName = 'QUOTEDSTR'
                               then Result := QuotedStr( Params[ 0 ] )
                               else If   MethodName = 'SYSDATE'
                                    then Result := Date
                                    else If   MethodName = 'RTFTOPLAINTEXT'
                                    then Result := TextConverter.ToPlainText( Params[ 0 ] )
                                    else If   MethodName = 'CIFRA'
                                         then Result := Cifra( Params[ 0 ] )
                                         else If   MethodName = 'REDONDEA'
                                              then Result := Redondea( Params[ 0 ], Params[ 1 ] )
                                              else If   MethodName = 'FORMATDURATION'
                                                   then begin
                                                        var Format := Params[ 1 ];
                                                        If   ( Format<0 ) or ( Format>2 )
                                                        then Format := 0;
                                                        Result := cxFormatDuration( TcxDurationFormat( Format ), Params[ 0 ] );
                                                        end;
end;

// ApplicationContainer.ExecuteProcedures( imProcedure, [ pidCreateStockModule, pidCreateSaldosModule, pidCreateTiposIVAModule ] );

function TFunctions.CallMethod2(       Instance   : TObject;
                                       ClassType  : TClass;
                                 const MethodName : String;
                                 var   Params     : Variant): Variant;

function ConsultaTipoIVA( Tipo        : TTipoConsultaTipoIVA;
                          NroRegistro : Integer;
                          Fecha       : TDateTime;
                          CodigoPais  : String = '' ) : Currency;
begin
     If   not Assigned( ConsultaTipoIVAEvent )
     then ExecuteProcedures( imProcedure, [ pidCreateTiposIVAModule ] );
     If   Assigned( ConsultaTipoIVAEvent )
     then Result := ConsultaTipoIVAEvent( Tipo, Fecha, CodigoPais, NroRegistro )
     else Result := 0.0;
end;

function CostePeriodo( CodigoArticulo      : String;
                       CodigoClaseA,
                       CodigoClaseB,
                       CodigoClaseC        : String;
                       TodosLosLotes       : Boolean;
                       LoteFabricacion     : String;
                       TodosLosAlmacenes   : Boolean;
                       CodigoAlmacen       : String;
                       TodasLasUbicaciones : Boolean;
                       CodigoUbicacion     : String;
                       Ejercicio           : Integer;
                       MesInicial,
                       MesFinal            : Byte ) : Decimal;
begin
     If   not Assigned( CostePeriodoEvent )
     then ExecuteProcedures( imProcedure, [ pidCreateStockModule ] );
     If   Assigned( CostePeriodoEvent )
     then Result := CostePeriodoEvent( CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, TodosLosLotes, LoteFabricacion, TodosLosAlmacenes, CodigoAlmacen, TodasLasUbicaciones, CodigoUbicacion, Ejercicio, MesInicial, MesFinal )
     else Result := 0.0;
end;

function CosteFecha( CodigoArticulo      : String;
                     TodasLasClases      : Boolean;
                     CodigoClaseA,
                     CodigoClaseB,
                     CodigoClaseC        : String;
                     TodosLosLotes       : Boolean;
                     LoteFabricacion     : String;
                     TodosLosAlmacenes   : Boolean;
                     CodigoAlmacen       : String;
                     TodasLasUbicaciones : Boolean;
                     CodigoUbicacion     : String;
                     Fecha               : TDate ) : Decimal;
begin
     If   not Assigned( CosteFechaEvent )
     then ExecuteProcedures( imProcedure, [ pidCreateStockModule ] );
     If   Assigned( CosteFechaEvent )
     then Result := CosteFechaEvent( CodigoArticulo, TodasLasClases, CodigoClaseA, CodigoClaseB, CodigoClaseC, TodosLosLotes, LoteFabricacion, TodosLosAlmacenes, CodigoAlmacen, TodasLasUbicaciones, CodigoUbicacion, Fecha )
     else Result := 0.0;
end;

function Existencias( CodigoArticulo      : String;
                      TodasLasClases      : Boolean;
                      CodigoClaseA,
                      CodigoClaseB,
                      CodigoClaseC        : String;
                      TodosLosLotes       : Boolean;
                      LoteFabricacion     : String;
                      TodosLosAlmacenes   : Boolean;
                      CodigoAlmacen       : String;
                      TodasLasUbicaciones : Boolean;
                      CodigoUbicacion     : String;
                      Ejercicio           : Integer;
                      MesInicial,
                      MesFinal            : Byte ) : Decimal;
begin
     If   not Assigned( ExistenciasEvent )
     then ExecuteProcedures( imProcedure, [ pidCreateStockModule ] );
     If   Assigned( ExistenciasEvent )
     then Result := ExistenciasEvent( CodigoArticulo, TodasLasClases, CodigoClaseA, CodigoClaseB, CodigoClaseC, TodosLosLotes, LoteFabricacion, TodosLosAlmacenes, CodigoAlmacen, TodasLasUbicaciones, CodigoUbicacion, False, Ejercicio, MesInicial, MesFinal )
     else Result := 0.0;
end;

function SaldoPeriodo( SubCuenta    : String;
                       CentroCoste  : String;
                       TodosLosCC   : Boolean;
                       Ejercicio    : Integer;
                       MesInicial,
                       MesFinal     : Byte;
                       Apertura     : Boolean = False ) : Decimal;
begin
     If   not Assigned( SaldoPeriodoEvent )
     then ExecuteProcedures( imProcedure, [ pidCreateSaldosModule ] );
     If   Assigned( SaldoPeriodoEvent )
     then Result := SaldoPeriodoEvent( SubCuenta, CentroCoste, TodosLosCC, Ejercicio, MesInicial, MesFinal, Apertura )
     else Result := 0.0;
end;

function DescripcionTasa( Modelo,
                          NroRegistro : Integer;
                          Fecha       : TDateTime;
                          CodigoPais  : String = '' ) : String;
begin
     If   not Assigned( DescripcionTasaEvent )
     then ExecuteProcedures( imProcedure, [ pidCreateTiposIVAModule ] );
     If   Assigned( DescripcionTasaEvent )
     then Result := DescripcionTasaEvent( Modelo, NroRegistro, Fecha, CodigoPais )
     else Result := '';
end;

function ObtenDCIBAN( CodigoIBAN : String ) : String;
begin
     If   Assigned( ObtenDCIBANEvent )
     then Result := ObtenDCIBANEvent( CodigoIBAN )
     else Result := CodigoIBAN;
end;

begin
     If   MethodName = 'TIPOIVASOPORTADO'
     then Result := ConsultaTipoIVA( tcIVASoportado, Params[ 0 ], Params[ 1 ] )
     else If   MethodName = 'TIPOIVAREPERCUTIDO'
          then Result := ConsultaTipoIVA( tcIVARepercutido, Params[ 0 ], Params[ 1 ], Params[ 2 ] )
          else If   MethodName = 'DESCRIPCIONTASA'
               then Result := DescripcionTasa( Params[ 0 ], Params[ 1 ], Params[ 2 ], Params[ 3 ] )
               else If   MethodName = 'TIPORE'
                    then Result := ConsultaTipoIVA( tcRE, Params[ 0 ], Params[ 1 ] )
                    else If   MethodName = 'TIPORETENCION'
                    then Result := ConsultaTipoIVA( tcRetencion, Params[ 0 ], Params[ 1 ] )
                         else If   MethodName = 'COSTEPERIODO'
                              then Result := CostePeriodo( Params[ 0 ], Params[ 1 ], Params[ 2 ], Params[ 3 ], Params[ 4 ], Params[ 5 ], Params[ 6 ], Params[ 7 ], Params[ 8 ], Params[ 9 ], Params[ 10 ], Params[ 11 ], Params[ 12 ] )
                              else If   MethodName = 'COSTEFECHA'
                                   then Result := CosteFecha( Params[ 0 ], Params[ 1 ], Params[ 2 ], Params[ 3 ], Params[ 4 ], Params[ 5 ], Params[ 6 ], Params[ 7 ], Params[ 8 ], Params[ 9 ], Params[ 10 ], Params[ 11 ] )
                                   else If   MethodName = 'EXISTENCIASARTICULO'
                                        then Result := Existencias( Params[ 0 ], Params[ 1 ], Params[ 2 ], Params[ 3 ], Params[ 4 ], Params[ 5 ], Params[ 6 ], Params[ 7 ], Params[ 8 ], Params[ 9 ], Params[ 10 ], Params[ 11 ], Params[ 12 ], Params[ 13 ] )
                                        else If   MethodName = 'SALDOPERIODO'
                                             then Result := SaldoPeriodo( Params[ 0 ], Params[ 1 ], Params[ 2 ], Params[ 3 ], Params[ 4 ], Params[ 5 ], Params[ 6 ] )
                                             else If   MethodName='CALCULAPORCENTAJE'
                                                  then Result := CalculaPorcentaje( Params[ 0 ], Params[ 1 ], Params[ 2 ] )
                                                  else If   MethodName='OBTENDCIBAN'
                                                       then Result := ObtenDCIBAN( Params[ 0 ] );
end;

function TFunctions.GetProp(       Instance  : TObject;
                                   ClassType : TClass;
                             const PropName  : String ) : Variant;
begin
     Result := 0;

     If   ClassType=TfrxNXDatabase
     then If   PropName='PATH'
          then Result := '"' + TfrxNXDatabase( Instance ).DatabaseName + '"';
end;

(*
function TFunctions.SQLDateString( date : integer ) : string;
begin
     Result := 'DATE ' + quotedStr( strFormatDate( date, dfSQL ) );
end;

function TFunctions.DateToString( date   : integer;
                                  format : Byte      ) : string;
begin
     Result := strFormatDate( date, TDateFormat( format) );
end;

function TFunctions.DMYToDate( day, month, year : word ) : integer;
begin
     Result := ApplicationContainer.DMYToDate( day, month, year );
end;
*)

initialization
   fsRTTIModules.Add( TFunctions );

end.
