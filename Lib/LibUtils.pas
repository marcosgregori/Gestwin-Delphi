unit LibUtils;

{$OPTIMIZATION ON}
{$WARN SYMBOL_PLATFORM OFF}

interface

uses    {$IFDEF MSWINDOWS}
        Windows,
        {$ENDIF}
        System.UITypes,
        SysUtils,
        Classes,
        Controls,
        Generics.Collections,
        ObjAuto,
        TypInfo,
        Variants,
        Forms,
        Graphics;


type    Decimal = Currency;

        TFormClass = class of TForm;

        TDateFormat = ( dfDefault, dfDefault2, dfShort, dfLong, dfDetailed, dfCompact, dfCompact2, dfSQL, dfSQLDateTime, dfReversed, dfReversed2 );
        TTimeFormat = ( tfDefault, tfHoursMinutes, tfHoursMinutes2, tfMinutesSeconds );
        TDurationFormat = ( rfDefault, rfHoursMinutes, rfFull );
        TBooleanFormat = ( bfChecked, bfYesNo, bfTrueFalse, bfSQL );
        TVersionString = ( vsEndUSerName, vsFileVersion );
        TTimeStampTimeValue = ( tvDontModify, tvLowest, tvHighest );

        TDuration = LongInt;

        TVariantArray = array of Variant;
        TIntegerArray = array of Integer;
        TLongIntArray = array of LongInt;
        TStringArray = array of String;

        TPrgExitNotification = function( RequestForExit : Boolean;
                                         Force          : Boolean = False;
                                         SilentMode     : Boolean = False  ) : Boolean;

        TCompactList<T> = class( TList<T> )
          public
          function Add(const Value: T): Integer;
          function Remove( const Value : T ) : Boolean;
          function Get( const Index : Integer ) : T;
          end;

        TEnumUtils = class
          class function GetAs<T>( Valor : String ) : T;
          end;

        TCycle = record
          Value : LongWord;  // El valor actual
          Cycle : SmallInt;  // Cada cuanto se activa

          class operator Initialize ( out Dest: TCycle );

          procedure Reset;
          function Filled : Boolean;
          end;
		  
        TWrapperEvent = procedure( Value : TControl ) of object;

        TProcedureWrapper = class
          private
            FProc : TWrapperEvent;
          public
            constructor Create( AProc : TWrapperEvent );
            procedure Execute( Value : TControl );
            end;

const   ListaPeriodos : TArray<String> = [ 'Apertura',
                                           'Enero',
                                           'Febrero',
                                           'Marzo',
                                           'Abril',
                                           'Mayo',
                                           'Junio',
                                           'Julio',
                                           'Agosto',
                                           'Septiembre',
                                           'Octubre',
                                           'Noviembre',
                                           'Diciembre',
                                           'Regularización',
                                           'Cierre' ];


         HighStrCode = 'ZZZZZZZZZZZZZZZZZZZZZZZZZ';
         HighestChar = 'Z';
         ChSp = ' ';
         ChZr = '0';
         PrecisionMoneda = 0.01;
         DecimalesMoneda = 2;
         LowestStrDate = '01/01/1900 00:00:00';
         OrdZero = Ord( '0' );
         HTML_BR = ''#13'';

         AlfaNumCharSet = [ 'a'..'z', 'A'..'Z', '0'..'9' ];
         FileNameCharSet = AlfaNumCharSet + [ '-', '_', '(', ')' ];
         DirtyCodeCharSet = AlfaNumCharSet + [ '!', '#', '$', '%', '&', '''', '(', ')', ',', '-', '.', ';', '@', '[', ']', '_' ];
         CleanCodeCharSet = AlfaNumCharSet + [ '-', '.', '_',  '(', ')' ];

var      DateTimeFormatSettings,
         InvariantFormatSettings : TFormatSettings;

{$IFDEF MSWINDOWS}
function IsKeyPressed( Key : SmallInt ) : Boolean;
function ShiftKey : Boolean;
function ControlKey : Boolean;
function TabKey : Boolean;
function AltGrKey : Boolean;
{$ENDIF}

function StrDecimal( Valor : Decimal; Decimales : SmallInt = 2 ) : String;
function StrDate( Value : TDateTime ) : String;
function StrBoolean( Valor : Boolean ) : String;
function StrInt( Numero : LongInt; VoidIfZero : Boolean = False ) : String;
function StrIntPadded( Numero : Int64; Sp : Byte; Ch : Char = ChZr ) : String;
function StrConst( Count : Integer; Ch : Char = ChSp ) : String;

function StringArrayIndexOf( StringArray : TStringArray; SearchStr : String; IgnoreCase : Boolean = False ) : SmallInt;
function IntegerArrayIndexOf( IntegerArray : TIntegerArray; Value : Integer ) : SmallInt;

function IfThen( const Condition : Boolean; ATrue, AFalse : Variant ) : Variant; overload;
function IfThen( const Condition : Boolean; ATrue : Variant) : Variant; overload;
function IfThen( const Condition : Boolean; ATrue, AFalse : TObject ) : TObject; overload;
function RightPad( St : String; Len : Byte; Ch : Char = ChSp ) : String;
function LeftPad( St : String; Len : Byte; Ch : Char = ChZr ) : String;
function PadIf( Value : String; Pad : String = ' '; LeftPad : Boolean = False ) : String; overload;
function PadIf( Values : TStringArray; Pad : String = ' '; LeftPad : Boolean = False ) : String; overload;

function StrRemoveChars( St : String; CharSet : TSysCharSet ) : String;
function StrChangeChar( St : String; OldChar, NewChar : Char ) : String;
function StrCharCount( St : String; Ch : Char ) : SmallInt;
function StrToChar( St : String ) : Char;
function StrCaption( St : String; Capitalize : Boolean = False ) : String;
function StrToBool( St : String ) : Boolean;
function StrToDate( Value  : String; Format : TDateFormat = dfDefault2 ) : TDate;  // El motivo de utilizar mi propia función es que SysUtils.StrToDate es sensible a la configuración local del SO
function StrToDateTime( Value  : String ) : TDateTime;
function StrMonth( NroPeriodo : Byte; Short : Boolean = False ) : String;
function StrContains( St : String; SubString : TStringArray; IgnoreCase : Boolean = True ) : Boolean;
function StrToExtended( Value : String ) : Extended;
function StrToDecimal( Value : String ) : Decimal;

function IsAlphabeticString( St : String ) : Boolean;
function IsNumericString( St : String ) : Boolean;
function LoCase( Ch : Char ) : Char;
function CheckIntRange( Value, Lo, High, ResetValue : Integer ) : Integer;
function StrToUNIFI( St : String; DefChar : Char = ChSp ): String;
function StrToXML( St : String ) : String;
function StrToHex( const St : AnsiString ) : AnsiString;
function StrToHTML( const Str : AnsiString; AIgnoredString : AnsiString = '' ) : AnsiString;
function StrToJSONText( Value : String ) : String;
function StrToJSONHTMLText( Value : String ) : String;
function Capitaliza( Cadena : String; Capital : Boolean = True; Plural : Boolean = False ) : String;
function IsNumeric( Value : String ) : Boolean;
function BoolToStr( Value : Boolean ) : String;
function DecimalToStr( Value : Decimal ) : String;
function ExtendedToStr( Value : Extended ) : String;

function Cifra ( Valor : Double ) : String;
function ObtenDC( Codigo : String ) : Char;

function SQLDateString( ADate : TDateTime ) : String;
function SQLDateTimeString( ADate : TDateTime; TimeStampTimeValue : TTimeStampTimeValue = tvDontModify ) : String;
function SQLTimeString( ATime : TDateTime ) : String;
function SQLGuid( AGuid : TGuid ) : String;
function SQLIntegerArray( Value : Array of LongInt ) : String;

function DMYToDateStamp( Day, Month, Year : Word ) : Integer;
function HMSToTimeStamp( Hours, Minutes, Seconds : Word ) : Integer;
function GetTimeStamp( Time : Integer; Date : Integer) : TTimeStamp;
{$IFDEF MSWINDOWS}
function FileTimeToDateTime( FileTime : TFileTime ) : TDateTime;
{$ENDIF}
function StrTSToDateTime( Value : String ) : TDateTime;
function MonthQuarter( Value : SmallInt ) : SmallInt;
function DateQuarter( Value : TDate ) : SmallInt;

function CleanStr( St : String ) : String;
function ExtractSubString( St : String; DelimiterChar : Char = #32; StartPos : SmallInt = 1 ) : String; overload;
function RemoveSuffix ( St : String; DelimiterChar : Char = '_'; MaxSuffixSize : SmallInt = 1 ) : String;
function ExtractSubString( St : String; var position : SmallInt; DelimiterChar : Char = #32 ) : String; overload;
function RightPos( const ASub, AIn : String; AStart : Integer = -1 ) : Integer;
procedure StrAdd( var St : String; AddStr : String ); overload;
procedure ExtractStringList( St : String; StringList : TStringList; ClearList : Boolean = False; DelimiterChar : Char = ',' ); deprecated;  // Usar ExtractStrings
procedure ExtractHelper( const Pfn : String; var DotPos : Integer; var SlashPos : Integer);
function ExtractFileNameWithoutExtension( const pfn : String ) : String;
function AddPathDelim( Path : String; PathDelim : Char = '\' ) : String;
function JoinMessage( Part1, Part2 : String ) : String;
function SplitMessage( Msg : String; var Part1 : String; var Part2 : String ) : Boolean;

function Precision( Decimales : SmallInt ) : Extended;

function Decimales( Value : Decimal ) : SmallInt; overload;
function Decimales( Value : Double ): SmallInt; overload;

function Redondea( const Valor : Decimal; Decimales : ShortInt = DecimalesMoneda ) : Decimal;
function RedondeaExt( const Valor : Extended; Decimales : ShortInt = DecimalesMoneda ) : Extended;
function Trunca( const Valor : Decimal; Decimales : ShortInt = DecimalesMoneda ) : Decimal;

function LowestInt( IArray : array of LongInt ) : LongInt;
// function IntStr( St : String ) : SmallInt;
function IntSign( SData : Integer; Positive : Boolean ) : Integer;
function CalculaPorcentaje( Valor1, Valor2 : Double; RangoAjustado : Boolean = False ) : SmallInt;
function BoolToByte( Value : Boolean ) : Byte;

procedure DecAdd( var SData : Decimal; iData : Decimal );
function  DecSign( SData : Decimal; Positive : Boolean ) : Decimal;

function StrYear( Year : Word ) : String;
function AccountingYear( ADate : TDateTime; AFirstMonth : Word ) : Word;

{$IFDEF MSWINDOWS}
function GetProcessID( ExeFileName : String ) : DWORD;
function ProcessExecute( var ProcessInformation : TProcessInformation; CommandLine : String; CurrentDirectory : String = ''; CmdShow : Integer = SW_SHOWNORMAL; WaitUntilInitialized : Boolean = False ) : Boolean;
function ProcessExists( ExeFileName : String ) : Boolean;
function KillProcess( ExeFileName : String ) : Boolean;
function RunProcess( hWnd: HWND; Filename: string; Parameters: string; RunAsAdmin : Boolean = False ) : Boolean;
{$ENDIF}

procedure Delay( Milliseconds : Longint );

procedure SetStrIfNull( var Dest : String; var Source : String   );
procedure SetIntIfNull( var Dest : SmallInt; var Source : SmallInt );
function  GetStrDef( Value : String; Default : String ) : String;
procedure SortIntegerArray( var a : TIntegerArray; Top : SmallInt );

function ValueIsEmpty( Value : Variant; ValueType : TVarType = varUnknown ) : Boolean;
{$IFNDEF NEXTGEN}
function VarRecToVariant( Value : TVarRec ) : Variant;
function VarRecToVariantArray( Values : array of const ) : TVariantArray;
{$ENDIF}
function VarToBoolean( Value : Variant; Default : Boolean = False ) : Boolean;
function VarToBooleanInt( Value : Variant ) : Integer;
function VarToInteger( Value : Variant; Default : Integer = 0 ) : Integer;
function VarToSmallInt( Value : Variant; Default : SmallInt = 0 ) : SmallInt;
function VarToDecimal( Value : Variant; Default : Decimal = 0.0 ) : Decimal;
function VarToDouble( Value : Variant; Default : Double = 0.0 ) : Double;
function VarToDate( Value : Variant; Default : TDate = 0 ) : TDate;
function VarToTime( Value : Variant; Default : TTime = 0 ) : TTime;
function VarToDuration( Value : Variant; Default : TDuration = 0 ) : TDuration;
function VarToAnsiStr(const V: Variant): String;
function VarIsVoid( const V : Variant ) : Boolean;
function VarIsString( Value : Variant ) : Boolean;

function EncodeDuration( D, H, M, S : LongInt ) : TDuration;
procedure DecodeDuration( Duration : TDuration; var D, H, M, S : LongInt; Format : TDurationFormat = rfDefault );

function StrFormat( Valor : Extended; Dc : ShortInt = DecimalesMoneda; BlankIfZero : Boolean = False; InvariantFormat : Boolean = False ) : String;
// function StrFormatAndPad( Valor : Extended; Dc : ShortInt = DecimalesMoneda; BlankIfZero : Boolean = False; RightPadding : SmallInt = 1 ) : String;
function StrFormatDate( DateTime : TDateTime; Format : TDateFormat = dfDefault2; DateSeparator : Char = '/' ) : String; overload;
function StrFormatTime( DateTime : TDateTime; Format : TTimeFormat = tfDefault ) : String; overload;
function StrFormatDuration( Duration : TDuration; Format : TDurationFormat = rfDefault; TimeSeparator : Char = ':' ) : string;
function StrFormatBool( Data : Boolean; Format : TBooleanFormat ) : String;
function StrFormatInt( Value : Integer; BlankIfZero : Boolean = True ) : String;
function StrSetVars( SourceString : String; Names, Values : TStringArray ) : String;

procedure CSVExtractParameters( StLinea : String; ListaParametros  : TStringList; Separador : Char = ','; ComprobarCadenas : Boolean = True );
procedure CSVDate( St  : String; var Day : Word; var Month : Word; var Year : Word ); overload;
function CSVDate( St : String ) : TDateTime; overload;
function CSVLongInt( St : String ) : LongInt;
function CSVInteger( St : String ) : SmallInt;
function CSVByte( St : String ) : Byte;
function CSVBoolean( St : String ) : Boolean;
function CSVFloat( St : String ) : Double;

{$IFDEF MSWINDOWS}
function GetSpecialFolder( ALocation  : Integer ) : String;
function GetLastErrorMessage : String;

function FMM4MemoryUsed : Cardinal;
function CurrentProcessMemory : NativeUInt;

function IsRemoteSession: Boolean;
{$ENDIF}

function RemoveHintTags( Text : String ) : String;
function RemoveHTMLTags( Text : String ) : String;
function OpenWebPage( WebPage : String ) : Boolean;

function GetGUID : TGuid;
function IsEmptyGUID( Value : TGuid ) : Boolean;
function IsValidEMail( Value : String ) : Boolean;

{$IFDEF MSWINDOWS}
procedure SaveBitmap( ABitmap : TBitmap; var AValue: AnsiString );
{$ENDIF}
function LoadFileToString( const FileName : TFileName ) : String;
function ValidFileName( Value : String ) : String;

function MethodIsImplemented( const AClass : TClass; MethodName : String ) : Boolean;

function IsBitSet( const AValueToCheck, ABitIndex : Integer ): Boolean;
function SetBit( const AValueToAlter, ABitIndex: Integer ) : Integer;      // Pone a 1
function ResetBit( const AValueToAlter, ABitIndex: Integer ) : Integer;    // Pone a 0
function ToggleBit( const AValueToAlter, ABitIndex: Integer ) : Integer;

implementation

uses  Rtti,
      {$IFDEF MSWINDOWS}
      ShellAPI,
      PsAPI,
      TlHelp32,
      Messages,
      ShlObj,
      {$ENDIF}
      DateUtils,
      StrUtils,
      Math;

const KeyMask = $8000;
      MaxDoubleError : Double = 0.0000001;
      BoolCheckChar = #149;

var   CicloContador : LongInt = 20;

// Funciones

{$IFDEF MSWINDOWS}

function IsKeyPressed( Key : SmallInt ) : Boolean;
begin
     Result := ( GetKeyState( Key ) and KeyMask )=KeyMask;
end;

function  ShiftKey : Boolean;
begin
     Result := IsKeyPressed( vk_shift );
end;

function  ControlKey : Boolean;
begin
     Result := IsKeyPressed( vk_control );
end;

function  AltGrKey : Boolean;
begin
     Result := IsKeyPressed( vk_RMenu );
end;

function  TabKey : Boolean;
begin
     Result := IsKeyPressed( vk_tab );
end;

{$ENDIF}

function StrDecimal( Valor : Decimal; Decimales : SmallInt = 2 ) : String;
begin
     Str( Valor:0:Decimales, Result );
end;

function StrDate( Value : TDateTime ) : String;
begin
     Result := FormatDateTime( 'YYYY-MM-DD', Value );
end;

function DateString( Value : TDateTime ) : String;
begin
     Result := FormatDateTime( 'YYYY-MM-DD', Value );
end;

function  StrBoolean( Valor : Boolean ) : String;
begin
     If   Valor
     then Result := 'Si'
     else Result := 'No';
end;

function StrInt( Numero     : LongInt;
                 VoidIfZero : Boolean = False ) : String;

var St : String;

begin
     St := IntToStr( Numero );
     If   VoidIfZero and ( St=ChZr )
     then St := '';
     Result := St;
end;

function RemoveHintTags( Text : String ) : String;
begin
     Result := StringReplace( Text, '\n', ' ', [ rfReplaceAll, rfIgnoreCase ] );
     Result := StringReplace( Result, #13, ' ', [ rfReplaceAll, rfIgnoreCase ] );
end;

function RemoveHTMLTags( Text : String ) : String;

var  I : SmallInt;
     InTag : Boolean;

begin
     Result := '';
     Text := StringReplace( Text, ''#13'', #13, [ rfReplaceAll, rfIgnoreCase ] );
     InTag := False;
     For I := 1 to Length( Text ) do
       begin
       If   Text[ I ]='<'
       then InTag := True
       else If   ( Text[ I ]='>' ) and InTag
            then InTag := False
            else If   not InTag
                 then Result := Result + Text[ I ];
       end;
end;

function OpenWebPage( WebPage : String ) : Boolean;
begin
     {$IFDEF FMX}
     // No implementado
     {$ELSE}
     Result := ShellExecute( Application.MainForm.Handle, 'open', PChar( WebPage ), '', '', SW_SHOW )>32;
     {$ENDIF}
end;

function StrIntPadded( Numero : Int64;
                       Sp     : Byte;
                       Ch     : Char = ChZr ) : String;
begin
     Result := LeftPad( IntToStr( Numero ), Sp, Ch );
end;

{
function IntStr( St : String ) : SmallInt;

var Dummy,
    Value  : LongInt;

begin
     Val( St, Value, Dummy );
     Result := Value;
end;
}

//* 03.06.2004  Alterado el orden de los parámetros para permitir el Valor por defecto

function StrConst ( Count : Integer;
                    Ch    : Char = ChSp ) : String;
begin
     Result := StringOfChar( Ch, Count );
end;

function StrMonth( NroPeriodo : Byte;
                   Short      : Boolean = False ) : String;
begin
     Result := '';
     If   NroPeriodo in [ 0..14 ]
     then If   Short
          then begin
               case NroPeriodo of
                 0, 13, 14 : Result := '<' + Copy( ListaPeriodos[ NroPeriodo ], 2, 1 ) + '>';
                 else        Result := Copy( ListaPeriodos[ NroPeriodo ], 1, 3 );
                 end;
               end
          else Result := ListaPeriodos[ NroPeriodo ];
end;

function IfThen( const Condition : Boolean; ATrue, AFalse : Variant ) : Variant;
begin
     If   Condition
     then Result := ATrue
     else Result := AFalse;
end;

function IfThen( const Condition : Boolean; ATrue : Variant ) : Variant;
begin
     If   Condition
     then Result := ATrue
     else Result := '';
end;

function IfThen( const Condition : Boolean; ATrue, AFalse : TObject ) : TObject;
begin
     If   Condition
     then Result := ATrue
     else Result := AFalse;
end;

function RightPad ( St  : String;
                    Len : Byte;
                    Ch  : Char = ChSp ) : String;
begin
    If   Length( St )<Len
    then Result := St + StrConst( Len - Length( St ), Ch )
    else If   Length( St )>Len
         then Result := Copy( St, 1, Len )
         else Result := St;
end;


function LeftPad ( St  : String;
                   Len : Byte;
                   Ch  : Char = ChZr ) : String;
begin
    If   Length( St )<Len
    then Result := StrConst( Len - Length( St ), Ch ) + St
    else If   Length( St )>Len
         then Result := Copy( St, Length( St ) - Len + 1, Len )
         else Result := St;
end;

function PadIf( Value   : String;
                Pad     : String = ' ';
                LeftPad : Boolean = False ) : String;
begin
     Result := Value;
     If   Result<>''
     then If   LeftPad
          then Result := Pad + Result
          else Result := Result + Pad;
end;

function StringArrayIndexOf( StringArray : TStringArray;
                             SearchStr   : String;
                             IgnoreCase  : Boolean = False ) : SmallInt;
begin
     Result := -1;
     If   IgnoreCase
     then SearchStr := UpperCase( SearchStr );
     For var Inx : SmallInt := Low( StringArray ) to High( StringArray ) do
       begin
       If   ( IgnoreCase and ( UpperCase( StringArray[ Inx ] )=SearchStr ) ) or
            ( StringArray[ Inx ]=SearchStr )
       then begin
            Result := Inx;
            Exit;
            end;
       end;
end;

function IntegerArrayIndexOf( IntegerArray : TIntegerArray; Value : Integer ) : SmallInt;
begin
     Result := -1;
     For var Inx : SmallInt := Low( IntegerArray ) to High( IntegerArray ) do
       If   IntegerArray[ Inx ]=Value
       then begin
            Result := Inx;
            Exit;
            end;
end;

function PadIf( Values: TStringArray; Pad : String = ' '; LeftPad : Boolean = False ) : String;
begin
     Result := '';

     try

       For var Value : String in Values do
         Result := Result + PadIf( Value, Pad, LeftPad );

       If   LeftPad  // Cuando es una relación de cadenas no quiero pads sueltos en los extremos
       then Result := Copy( Result, Pad.Length, MaxInt )
       else Result := Copy( Result, 1, Result.Length - Pad.Length );

     except
       end;

end;

function StrCharCount( St : String; Ch : Char ) : SmallInt;

var   I, Count : SmallInt;

begin
     Count := 0;
     For I := 1 to Length( St ) do
       If   St[ I ]=Ch
       then Inc( Count );
     Result := Count;
end;

function StrToChar( St : String ) : Char;
begin
     If   Length( St )>0
     then Result := St[ 1 ]
     else Result := #0;
end;

function LoCase( Ch : Char ) : Char;
begin
     Result := Ch;
     case Result of
       'A'..'Z':  Inc( Result, Ord( 'a' ) - Ord( 'A' ) );
       end;
end;

function CheckIntRange( Value, Lo, High, ResetValue : Integer ) : Integer;
begin
     If   not Value in [ Lo..High ]
     then Value := ResetValue;
     Result := Value;
end;

function StrToUNIFI( St      : String;
                     DefChar : Char = ChSp ) : String;

var    I, J : SmallInt;
       Ch : Char;

const  ChOrigen  : Array[ 0..9 ] of Char = ( 'Ñ', 'ñ', 'Ç', 'ç', 'á', 'é', 'í', 'ó', 'ú', 'ü' );
       ChDestino : Array[ 0..9 ] of Char = ( 'N', 'n', 'C', 'c', 'a', 'e', 'i', 'o', 'u', 'u' );
begin
     Result := '';
     For I := 1 to Length( St ) do
       If   CharInset( St[ I ], [ 'A'..'Z', 'a'..'z', '0'..'9', '/', '-', '?', ':', '(', ')', '.', ',', ' ', '+' ] )
       then Result := Result + St [ I ]
       else begin
            Ch := DefChar;
            For J := 0 to 9 do
              If   St[ I ]=ChOrigen[ J ]
              then begin
                   Ch := ChDestino[ J ];
                   Break;
                   end;
            Result := Result + Ch;
            end;
end;

function StrToXML( St : String ) : String;

var    I : SmallInt;
       Sch : String;

begin
     Result := '';
     For I := 1 to Length( St ) do
       begin
       If   St[ I ]='&'
       then Sch := '&amp;'
       else If   St[ I ]='<'
            then Sch := '&lt;'
            else Sch := St[ I ];
       Result := Result + Sch;
       end;
end;

function StrToHex(const St : AnsiString): AnsiString;

var Len, i: Integer;
    C, H, L: Byte;

function HexChar(N : Byte) : AnsiChar;
begin
     If   ( N<10 )
     then Result := AnsiChar( Chr( Ord( '0' ) + N ) )
     else Result := AnsiChar( Chr( Ord( 'A' ) + ( N - 10 ) ) );
end;

begin
     Len := Length( St );
     SetLength( Result, Len shl 1 );
     For i := 1 to Len do
       begin
       C := Ord( St[ I ] );
       H := ( C shr 4 ) and $F;
       L := C and $F;
       Result[ I shl 1 - 1 ] := HexChar( H );
       Result[ I shl 1 ] := HexChar( L );
       end;
end;

function StrToHTML( const Str : AnsiString; AIgnoredString : AnsiString = '' ) : AnsiString;

var  I : Integer;
     C : AnsiChar;
     S : AnsiString;

begin
     Result := '';
     For I := 1 to Length( Str ) do
       begin
       C := Str[ I ];
       If   ( ( C in [ '0'..'9', 'A'..'Z', 'a'..'z', '.', '-' ] ) or ( Pos( C, AIgnoredString )>0 ) )
       then Result := Result + C
       else begin
            S := C;
            Result := Result + '%' + StrToHex( S );
            end;
       end;
end;

function Capitaliza( Cadena  : String;
                     Capital : Boolean = True;
                     Plural  : Boolean = False ) : String;

var   I  : SmallInt;
const Excepciones : array of String =  [ 'Pallet' ];

begin
     Result := Cadena;
     If   Plural
     then begin
          If   ( CharInSet( Upcase( Result[ Length( Result ) ] ), [ 'A','E','I','O','U' ] ) ) or
               MatchText( Cadena, Excepciones ) // Case-insensible
          then Result := Result + 's'
          else Result := Result + 'es';
          For I := 1 to Length( Result ) do
            If   CharInSet( Result[ I ], [ 'A'..'Z' ] )
            then Result[ I ] := LoCase( Result[ I ] )
            else If   Plural
                 then case Result[ I ] of
                        'Á', 'á'  : Result[ I ] := 'a';
                        'É', 'é'  : Result[ I ] := 'e';
                        'Í', 'í'  : Result[ I ] := 'i';
                        'Ó', 'ó'  : Result[ I ] := 'o';
                        'Ú', 'ú'  : Result[ I ] := 'u';
                        end;
          end;
     If   Capital
     then Result[ 1 ] := UpCase( Result[ 1 ] )
     else Result[ 1 ] := LoCase( Result[ 1 ] );
end;

function Cifra ( Valor : Double ) : String;

Var    D,
       L : SmallInt;
       StValor,
       St,
       TextoValor : String;
       Negativo : Boolean;
       CaracterSexo : Char;
       Masculino : Boolean;

const StUnidades : array[ 1..19 ] of String = ( 'una', 'dos', 'tres', 'cuatro', 'cinco', 'seis', 'siete', 'ocho', 'nueve', 'diez',
                                                   'once', 'doce', 'trece', 'catorce', 'quince', 'dieciseis' , 'diecisiete', 'dieciocho', 'diecinueve' );
      StDecenas  : array[ 1..9  ] of String = ( 'diez', 'veinte', 'treinta', 'cuarenta', 'cincuenta', 'sesenta', 'setenta', 'ochenta', 'noventa' );
      StCentenas : array[ 1..9  ] of String = ( 'ciento', 'doscient?s', 'trescient?s', 'cuatrocient?s', 'quinient?s', 'seiscient?s', 'setecient?s', 'ochocient?s', 'novecient?s' );

function Texto_Grupo( Cadena : String ) : String;

Var  Texto : String;
     I, J, K : Integer;
     ExistenCentenas,
     ExistenDecenas : Boolean;

begin
     ExistenCentenas := False;
     ExistenDecenas := False;
     Texto := '';

     I := 1;
     repeat
       If   Cadena[ I ] <>'0'
       then begin
            Val( Cadena[ I ], J, K );
            case I of
              1 : begin
                  If   ( Cadena[ I ]='1' ) and ( Copy( Cadena, 2, 2 )='00' )
                  then begin
                       Texto := 'cien';
                       I := 3;
                       end
                  else Texto := Texto + StCentenas[ J ] + ' ';
                  ExistenCentenas := True;
                  end;
              2 : begin
                  If   Cadena[ I ]='1'
                  then begin
                       If   Cadena[ 3 ]='0'
                       then Texto := Texto + 'diez'
                       else begin
                            Val( Copy( Cadena, 2, 2 ), J, K );
                            Texto := Texto + StUnidades[ J ];
                            end;
                       I := 3;
                       end
                  else Texto := Texto + StDecenas[ J ] + ' ';
                  ExistenDecenas := True;
                  end;
              3 : If   ( not( ExistenCentenas ) and not( ExistenDecenas ) ) or
                       ( ExistenCentenas   and not( ExistenDecenas ) )
                  then Texto := Texto + StUnidades[ J ]
                  else Texto := Texto + 'y ' + StUnidades[ J ];
              end;
            end;
       Inc( I );
       until ( I=4 ) or ( I>Length( Cadena ) );

     Result := Texto;
end;


begin
     TextoValor := '';
     try

       Masculino := True; // Euros

       If   Valor<0.0
       then begin
            Negativo := True;
            Valor := Abs( Valor );
            end
       else Negativo := False;

       Str( Valor:0:2, StValor );
       D  := Pos( '.', StValor );
       If   D=0
       then St := StValor
       else St := Copy( StValor, 1, D - 1 );

       L := Length( St );
       St := LeftPad( St, 9 );

       If   L > 6
       then begin
            If   Copy( St, 1, 3 )='001'
            then TextoValor := 'Un millon '
            else TextoValor := Texto_Grupo( Copy( St, 1, 3 ) ) + ' millones, ';
            end;

       If   L > 3
       then begin
            If   Copy( St, 4, 3 )='001'
            then TextoValor := TextoValor + ' mil '
            else If   Copy( St, 4, 3 )<>'000'
                 then TextoValor := TextoValor + Texto_Grupo( Copy( St, 4, 3 ) ) + ' mil ';
            end;

       TextoValor := TextoValor + Texto_Grupo( Copy( St, 7, 3 ) );

       If   D<>0
       then begin
            St := '0' + Copy( StValor, D + 1, 2 );  // En realidad solo acepto centimos
            If   St<>'000'
            then TextoValor := TextoValor + ' con ' + Texto_Grupo( St ) + ' centimos';
            end;

       If   Negativo
       then TextoValor := 'Menos ' + TextoValor;

       If   Masculino
       then CaracterSexo := 'o'
       else CaracterSexo := 'a';

       For L := 1 to Length( TextoValor ) do
         If   TextoValor[ L ]='?'
         then TextoValor[ L ] := CaracterSexo;

     except
       end;

     Result := TextoValor; //  + '.';

end;

function IsNumeric( Value : String ) : Boolean;

var  I : SmallInt;

begin
     Result := True;
     For I := 1 to Value.Length do
       If   not ( CharInSet( Value[ I ], [ '0'..'9', '.', ',', ' ' ] ) )
       then begin
            Result := False;
            Exit;
            end;

end;

function ObtenDC( Codigo : String ) : Char;

const  Peso : array[ 1..10 ] of Byte = ( 6, 3, 7, 9, 10, 5, 8, 4, 2, 1 );

Var    I,
       Posicion : SmallInt;
       Suma : Integer;
       Digito : SmallInt;

begin
     Result   := '*';

     try

       Suma := 0;
       Posicion := 1;
       For I := Length( Codigo ) downto 1 do
         If   CharInSet( Codigo[ I ], [ '0'..'9' ] )
         then begin
              Digito := Ord( Codigo[ I ] ) - OrdZero;
              Inc( Suma, Digito * Peso[ Posicion ] );
              Inc( Posicion );
              end
         else Abort;

       Suma := 11 - ( Suma mod 11 );
       If   Suma=10
       then Suma := 1
       else If   Suma=11
            then Suma := 0;
       Result := Char( Suma + OrdZero );

     except
       end;

end;

function  StrCaption( St         : String;
                      Capitalize : Boolean = False ) : String;
begin
     Result := StrRemoveChars( St, [ '&' ] );
     If   Length( Result )>0
     then If   Capitalize
          then Result[ 1 ] := UpCase( Result[ 1 ] )
          else Result[ 1 ] := LoCase( Result[ 1 ] );
end;

procedure StrAdd( var St     : String;
                      AddStr : String );
begin
     St := St + AddStr;
end;

function StrRemoveChars( St      : String;
                         CharSet : TSysCharSet ) : String;

var  I : SmallInt;

begin
     I := 1;
     While ( I<=Length( St ) ) do
       If   CharInSet( St[ I ], CharSet )
       then Delete( St, I, 1 )
       else Inc( I );
     Result := St;
end;

function  StrChangeChar( St      : String;
                         OldChar,
                         NewChar : Char ) : String;

var  I : SmallInt;

begin
     For I := 1 to Length( St ) do
       If   St[ I ]=OldChar
       then St[ I ] := NewChar;
     Result := St;
end;

function StrToBool( St : String ) : Boolean;
begin
     If   Length( St )>0
     then Result := ( CharInSet( UpCase( St[ 1 ] ), [ 'T', 'S', 'V', '1' ] ) ) or ( St='-1' )
     else Result := False;
end;

function BoolToStr( Value : Boolean ) : String;
begin
     If   Value
     then Result := '1'
     else Result := '0';
end;

function DecimalToStr( Value : Decimal ) : String;
begin
     Result := CurrToStr( Value, TFormatSettings.Invariant );
end;

function ExtendedToStr( Value : Extended ) : String;
begin
     Result := FloatToStr(Value, TFormatSettings.Invariant );
end;


function  IsNumericString( St : String ) : Boolean;

var  Sl, I : SmallInt;

begin
     Sl := Length( St );
     For I := 1 to Sl do
       If   not( CharInSet( St[ I ], [ '0'..'9' ] ) )
       then begin
            Result := False;
            Exit;
            end;
     Result := True;
end;

function  IsAlphabeticString( St : String ) : Boolean;

var  Sl, I : SmallInt;

begin
     Sl := Length( St );
     For I := 1 to Sl do
       If   not( CharInSet( UpCase( St[ I ] ), [ 'A'..'Z' ] ) )
       then begin
            Result := False;
            Exit;
            end;
     Result := True;
end;

function StrContains( St : String; SubString : TStringArray; IgnoreCase : Boolean = True ) : Boolean;

var  I : SmallInt;

begin
     Result := False;
     If   IgnoreCase
     then St := UpperCase( St );
     For I := 0 to High( SubString ) do
       begin
       If   IgnoreCase
       then SubString[ I ] := UpperCase( SubString[ I ] );
       If   Pos( SubString[ I ], St )<>0
       then begin
            Result := True;
            Break;
            end;
       end;
end;

function StrToJSONText( Value : String ) : String;

const IllegalCharArray : array of Char = [ #10, #13, #9, '"', '\' ];
      EscapeValueArray : array of Char = [ 'f', 'r', 't', '"', '\' ];

var  I, J : SmallInt;

begin
     I := 1;
     While I <= Length( Value ) do
       begin
       For J := Low( IllegalCharArray ) to High( IllegalCharArray ) do
         If   Value[ I ]=IllegalCharArray[ J ]
         then begin
              Delete( Value, I, 1 );
              Insert( '\' + EscapeValueArray[ J ], Value, I );
              Inc( I );
              Break;
              end;
       Inc( I );
       end;
     Result := Value;
end;

function StrToJSONHTMLText( Value : String ) : String;

const IllegalCharArray : array of Char = [ #10, #13, #9, '"', '\' ];
      EscapeValueArray : array of String = [ '', '\n', '&#9;', '\"', '\\' ];

var  I, J : SmallInt;

begin
     I := 1;
     While I <= Length( Value ) do
       begin
       For J := Low( IllegalCharArray ) to High( IllegalCharArray ) do
         If   Value[ I ]=IllegalCharArray[ J ]
         then begin
              Delete( Value, I, 1 );
              Insert( EscapeValueArray[ J ], Value, I );
              If   EscapeValueArray[ J ]=''
              then Dec( I )
              else Inc( I, Length( EscapeValueArray[ J ] ) - 1 );
              Break;
              end;
       Inc( I );
       end;
     Result := Value;
end;

function StrToExtended( Value : String ) : Extended;
begin
     Value := StrChangeChar( Value, ',', '.' );
     Result := StrToFloat( Value, TFormatSettings.Invariant );
end;

function StrToDecimal( Value : String ) : Decimal;
begin
     Value := StrChangeChar( Value, ',', '.' );
     Result := StrToCurr( Value, TFormatSettings.Invariant );
end;

function DMYToDateStamp( Day, Month, Year : Word ) : Integer;

var  Md : Word;

begin
     Md := DaysInAMonth( Year, Month );
     If   Day>Md
     then Day := Md;
     Result := DateTimeToTimeStamp( EncodeDate( Year, Month, Day ) ).Date;
end;

function HMSToTimeStamp( Hours, Minutes, Seconds : Word ) : Integer;
begin
     Result := DateTimeToTimeStamp( EncodeTime( Hours, Minutes, Seconds, 0 ) ).Time;
end;

function StrYear( Year : Word ) : String;

var   BYear  : SmallInt;

begin
     If   Year>=2000
     then BYear := Year - 2000
     else BYear := Year - 1900;
     StrYear := StrIntPadded( BYear, 2 );
end;

function IsLeapYear( Year : Word ) : Boolean;
begin
     Result := ( Year mod 4 = 0) and ( ( Year mod 100 <> 0 ) or ( Year mod 400 = 0 ) );
end;

function GetTimeStamp( Time : Integer;
                       Date : Integer) : TTimeStamp;
begin
     Result.Time := Time;
     Result.Date := Date;
end;

function MonthQuarter( Value : SmallInt ) : SmallInt;
begin
     Result := ( Pred( Value ) div 3 ) + 1;
end;

function DateQuarter( Value : TDate ) : SmallInt;
begin
     Result := MonthQuarter( MonthOf( Value ) );
end;

//  '2016-04-03 18:07:28'

function StrTSToDateTime( Value : String ) : TDateTime;

var  Day, Month, Year, Hour, Minute, Second : Word;

begin
     try
       Year := StrToInt( Copy( Value, 1, 4 ) );
       Month := StrToInt( Copy( Value, 6, 2 ) );
       Day := StrToInt( Copy( Value, 9, 2 ) );
       Hour := StrToInt( Copy( Value, 12, 2 ) );
       Minute := StrToInt( Copy( Value, 15, 2 ) );
       Second := StrToInt( Copy( Value, 18, 2 ) );
       Result := EncodeDateTime( Year, Month, Day, Hour, Minute, Second, 0 );
     except
       Result := 0;
       end;

end;

function SQLDateString( ADate : TDateTime ) : String;
begin
     Result := 'DATE ' + QuotedStr( StrFormatDate( ADate, dfSQL ) );
end;

function SQLDateTimeString( ADate              : TDateTime;
                            TimeStampTimeValue : TTimeStampTimeValue = tvDontModify ) : String;

var TimeStr : String;

begin
     Case TimeStampTimeValue of
       tvLowest  : ADate := EncodeDateTime( ADate.Year, ADate.Month, ADate.Day, 0, 0, 0, 0 );
       tvHighest : ADate := EncodeDateTime( ADate.Year, ADate.Month, ADate.Day, 23, 59, 59, 999 );
       end;
     Result := 'DATETIME ' + QuotedStr( StrFormatDate( ADate, dfSQLDateTime ) );
end;

function SQLTimeString( ATime : TDateTime ) : String;
begin
     Result := 'TIME ' + QuotedStr( StrFormatTime( ATime, tfDefault ) );
end;

function SQLGuid( AGuid : TGuid ) : String;
begin
     Result := 'GUID ' + QuotedStr( GuidToString( AGuid ) );
end;

function SQLIntegerArray( Value : Array of LongInt ) : String;

var  I : SmallInt;

begin
     Result := '';
     For I := Low( Value ) to High( Value ) do
       begin
       If   I<>Low( Value )
       then Result := Result + ',';
       Result := Result + IntToStr( Value[ I ] );
       end;
end;

function Redondea( const Valor     : Decimal;
                         Decimales : ShortInt = DecimalesMoneda ) : Decimal;

var  LFactor : Decimal;

begin
     If   Decimales>4
     then Decimales := 4;
     LFactor := IntPower( 10.0, -Decimales );
     If   Valor<0
     then Result := Int( ( Valor / LFactor) - 0.5 ) * LFactor
     else Result := Int( ( Valor / LFactor) + 0.5 ) * LFactor;
end;

function Trunca( const Valor     : Decimal;
                       Decimales : ShortInt = DecimalesMoneda ) : Decimal;

var  LFactor : Decimal;

begin
     If   Decimales>4
     then Decimales := 4;
     LFactor := IntPower( 10.0, -Decimales );
     Result := Int( ( Valor / LFactor ) ) * LFactor
end;

function RedondeaExt( const Valor     : Extended;
                            Decimales : ShortInt = DecimalesMoneda ) : Extended;
begin
     Result := SimpleRoundTo( Valor, -Decimales );
end;

function Precision( Decimales : SmallInt ) : Extended;
begin
     Result := 1 / IntPower( 10.0, Decimales );
end;

function Decimales( Value : Double ) : SmallInt;

var   Sp  : SmallInt;
      St  : String;

begin
     Result := 0;
     try
       St := FloatToStr( Abs( Value ) );
       Sp := Pos( FormatSettings.DecimalSeparator, St );
       If   Sp<>0
       then Result := Length( St ) - Sp;
     except
       end;
end;

function Decimales( Value : Decimal ) : SmallInt;

var   Sp : SmallInt;
      St : String;

begin
     Result := 0;
     try
       St := CurrToStr( Abs( Value ) );
       Sp := Pos( FormatSettings.DecimalSeparator, St );
       If   Sp<>0
       then Result := Length( St ) - Sp;
     except
       end;
end;

function  LowestInt( IArray : array of LongInt ) : LongInt;

var   I : SmallInt;

begin
     Result := MaxLongInt;
     For I := 0 to High( IArray ) do
       If   IArray[ I ]<Result
       then Result := IArray[ I ];
end;

procedure DecAdd( var SData : Decimal;
                      IData : Decimal );
begin
     SData := SData + iData;
end;

function  DecSign( SData    : Decimal;
                   Positive : Boolean ) : Decimal;
begin
     If   not Positive
     then SData := -SData;
     Result := SData;
end;

function  IntSign( SData    : Integer;
                   Positive : Boolean ) : Integer;
begin
     If   not Positive
     then SData := -SData;
     Result := SData;
end;

function CalculaPorcentaje( Valor1,
                            Valor2        : Double;
                            RangoAjustado : Boolean = False ) : SmallInt;
begin
     If   Valor1=0.0
     then begin
          If   Valor2=0.0
          then Result := 0
          else Result := -100;
          end
     else If   Valor2=0.0
          then begin
               If   Valor1=0.0
               then Result := 0
               else Result := 100;
               end
          else begin
               If   Valor2>Valor1
               then Result := -Round( ( ( Valor2 - Valor1 ) * 100.0 ) / Valor2 )
               else Result := Round( ( ( Valor1 - Valor2 ) * 100.0 ) / Valor1 );
               If   RangoAjustado
               then begin
                    If   Result>100
                    then Result := 100
                    else If   Result<-100
                         then Result := -100;
                    end
               end;
end;

function BoolToByte( Value : Boolean ) : Byte;
begin
     If   Value
     then Result := 1
     else Result := 0;
end;

function CleanStr( St : String ) : String;

var   I : SmallInt;

begin
     For I := Length( St ) downto 1 do
       If   not ( CharInSet( St[ I ], [ ' '..'%', #39..#255 ] ) )
       then Delete( St, I, 1 );
     Result := St;
end;

function  RemoveSuffix ( St            : String;
                         DelimiterChar : Char = '_';
                         MaxSuffixSize : SmallInt = 1 ) : String;

var  I,
     StLen,
     SuffixLen : SmallInt;

begin
     Result := St;
     If   Pos( DelimiterChar, St )<>0
     then begin
          StLen := Length( St );
          For I := StLen downto 1 do
            If   St[ I ]=DelimiterChar
            then Break;
          SuffixLen := StLen - I;
          If   MaxSuffixSize<=SuffixLen
          then Result := Copy( St, 1, I - 1 );
          end;
end;

function  ExtractSubString ( St            : String;
                             DelimiterChar : Char = #32;
                             StartPos      : SmallInt = 1 ) : String;

var  I : SmallInt;

begin
     For I := StartPos to Length( St ) do
       If   St[ I ]=DelimiterChar
       then Break;
     Result := Copy( St, StartPos, I - StartPos );
end;

function  ExtractSubString (     St            : String;
                             var Position      : SmallInt;
                                 DelimiterChar : Char = #32 ) : String;
var  Sp,
     Len : SmallInt;

begin
     Len := Length( St );
     Sp := Position;
     Result := '';
     While ( Sp<=Len ) do
       If   St[ Sp ]=DelimiterChar
       then Break
       else Inc( Sp );
     Result := Copy( St, Position, Sp - Position );
     Position := Sp + 1;
end;

procedure ExtractStringList( St            : String;
                             StringList    : TStringList;
                             ClearList     : Boolean = False;
                             DelimiterChar : Char = ',' );
var  I : SmallInt;
     SubString : String;

begin
     If   ClearList
     then StringList.Clear;
     I := 1;
     While ( I<=Length( St ) ) do
       begin
       SubString := ExtractSubString( St, I, DelimiterChar );
       StringList.Add( SubString );
       end;
end;

procedure ExtractHelper( const Pfn      : String;
                         var   DotPos   : Integer;
                         var   SlashPos : Integer);
var I : Integer;

begin
     DotPos := 0;
     SlashPos := 0;
     I := Length( Pfn );
     While ( I>0 ) and ( ( DotPos=0 ) or ( SlashPos=0 ) ) do
       begin
       If   ( Pfn[ I ]='.' )
       then begin
            If   ( DotPos=0 )
            then DotPos := I;
            end
       else If   ( Pfn[ I ]='\' )
            then begin
            SlashPos := I;
            If   ( DotPos=0 )
            then DotPos := Succ( Length( Pfn ) );
            end;
       Dec( I );
       end;
     If   ( DotPos=0 )
     then DotPos := Succ( Length( Pfn ) );
end;

function RightPos( const ASub,
                         AIn    : String;
                         AStart : Integer = -1 ) : Integer;
var  I : Integer;
     LStartPos: Integer;
     LTokenLen: Integer;

begin
     Result := 0;
     LTokenLen := Length( ASub );
     If   AStart<0
     then AStart := Length( AIn );
     If   AStart<( Length( AIn ) - LTokenLen + 1 )
     then LStartPos := AStart
     else LStartPos := ( Length( AIn ) - LTokenLen + 1 );
     For I := LStartPos downto 1 do
       If   Copy( AIn, I, LTokenLen )=ASub
       then begin
            Result := I;
            Break;
            end;
end;

function ExtractFileNameWithoutExtension( const Pfn : String ) : String;

var  DotPos, SlashPos : Integer;

begin
     ExtractHelper( pfn, DotPos, SlashPos );
     Result := Copy( pfn, Succ( SlashPos ), Pred( DotPos - SlashPos ) );
end;

function AddPathDelim( Path      : String;
                       PathDelim : Char = '\' ) : String;
begin
     If   ( Path<>'' ) and ( Copy( Path, Length( Path ), 1 )<>PathDelim )
     then Result := Path + PathDelim
     else Result := Path;
end;

function JoinMessage( Part1, Part2 : String ) : String;
begin
     If   Part2<>''
     then Result := Part1 + '|' + Part2
     else Result := Part1;
end;

function SplitMessage(     Msg   : String;
                       var Part1 : String;
                       var Part2 : String ) : Boolean;

var  Sp : SmallInt;

begin
     Sp := Pos( '|', Msg );
     If   Sp=0
     then begin
          Part1 := Msg;
          Part2 := '';
          end
     else begin
          Part1 := Copy( Msg, 1, Sp - 1 );
          Part2 := Copy( Msg, Sp + 1, MaxInt );
          end;
     Result := Sp<>0;
end;

function GetStrDef( Value   : String;
                    Default : String ) : String;
begin
     If   Value=''
     then Result := Default
     else Result := Value;
end;

procedure SetStrIfNull( var Dest   : String;
                        var Source : String   );
begin
     If   Dest=''
     then Dest := Source;
end;

procedure SetIntIfNull( var Dest   : SmallInt;
                        var Source : SmallInt );
begin
     If   Dest=0
     then Dest := Source;
end;

{$IFDEF MSWINDOWS}
procedure KeyEvent( Key : Word; Shift : TShiftState = [] );
begin

     try
       If   ssShift in Shift
       then keybd_event( vk_shift, 0, 0, 0 );
       If   ssAlt in Shift   // Es <AltGr> no <Alt>
       then keybd_event( vk_RMenu, 0, 0, 0 );
       keybd_event( Key, 0, 0, 0 );
     Finally
       keybd_event( Key, 0, KEYEVENTF_KEYUP, 0 );
       If   ssAlt in Shift
       then keybd_event( vk_rMenu, 0, KEYEVENTF_KEYUP, 0 );
       If   ssShift in Shift
       then keybd_event( vk_shift, 0, KEYEVENTF_KEYUP, 0 );
       end;
end;
{$ENDIF}

// TQuickSort ---------------------------------------------------------------

procedure SortIntegerArray( var A   : TIntegerArray;
                                Top : SmallInt );

procedure QuickSort( var A    : TIntegerArray;
                         ILo,
                         IHi  : Integer);
var  Lo,
     Hi,
     Mid,
     T : Integer;

begin
     Lo := ILo;
     Hi := IHi;
     Mid := A[ ( Lo + Hi ) div 2 ];
     repeat
       while A[ Lo ]<Mid do
         Inc( Lo );
       while A[ Hi ]>Mid do
         Dec( Hi );

       If   Lo<=Hi
       then begin
            T := A[ Lo ];
            A[ Lo ] := A[ Hi ];
            A[ Hi ] := T;
            Inc( Lo );
            Dec( Hi );
            end;
     until Lo>Hi;

    If   Hi>ILo
    then QuickSort( A, ILo, Hi );
    If   Lo<IHi
    then QuickSort( A, Lo, IHi );
end;

begin
     try
       If   Top>High( A )
       then Top := High( A );
       If   Top>0
       then QuickSort( A, low( A ), Top );
     except on E : Exception do
       // ShowException( E, nil );
       end;
end;

{$IFDEF MSWINDOWS}

function ProcessExecute( var ProcessInformation   : TProcessInformation;
                             CommandLine          : String;
                             CurrentDirectory     : String = '';
                             CmdShow              : Integer = SW_SHOWNORMAL;
                             WaitUntilInitialized : Boolean = False ) : Boolean;

const MaxWaitForInitilization = 60000;  // Un minuto como máximo
      MaxCommandLineSize = 2048;  // Puede ser de hasta 8191 caracteres

var   StartUpInfo : TStartUpInfo;
      CommandString : array[ 0..MaxCommandLineSize ] of Char;  // El parámetro de CreateProcess no puede ser una constante o un parámetro
      CurrentDirectoryString : array[ 0..MaxCommandLineSize ] of Char;
      PCurrentDirectoryString : PWideChar;

begin
     FillChar( ProcessInformation, SizeOf( ProcessInformation ), #0 );
     FillChar( StartUpInfo, SizeOf( StartUpInfo ), #0 );
     StartUpInfo.cb := SizeOf( StartUpInfo );
     StartUpInfo.dwFlags := STARTF_USESHOWWINDOW;
     StartUpInfo.wShowWindow := CmdShow;
     StrCopy( PWideChar( @CommandString[ 0 ] ), PWideChar( CommandLine ) );
     If   CurrentDirectory<>''
     then begin
          StrCopy( PWideChar( @CurrentDirectoryString[ 0 ] ), PWideChar( CurrentDirectory ) );
          PCurrentDirectoryString := @CurrentDirectoryString[ 0 ];
          end
     else PCurrentDirectoryString := nil;
     Result := CreateProcess( nil, PWideChar( @CommandString[ 0 ] ), nil, nil, True, 0, nil, PCurrentDirectoryString, StartUpInfo, ProcessInformation );
     If   Result and WaitUntilInitialized
     then Result := WaitForInputIdle( ProcessInformation.hProcess, MaxWaitForInitilization )=0;
end;

function GetProcessID( ExeFileName : String ) : DWORD;

var ContinueLoop : BOOL;
    FSnapshotHandle : THandle;
    FProcessEntry32 : TProcessEntry32;

begin
     Result := 0;
     FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
     FProcessEntry32.dwSize := SizeOf( FProcessEntry32 );
     ContinueLoop := Process32First( FSnapshotHandle, FProcessEntry32 );
     While ( Integer( ContinueLoop )<>0 ) and ( Result=0 ) do
       begin
       If   ( FProcessEntry32.th32ProcessID<>GetCurrentProcessId ) and   // Evito que el proceso en curso se considere
            ( ( UpperCase( ExtractFileName( FProcessEntry32.szExeFile ) )=UpperCase( ExeFileName ) ) or
              ( UpperCase( FProcessEntry32.szExeFile )=UpperCase( ExeFileName ) ) )
       then Result := FProcessEntry32.th32ProcessID;
       ContinueLoop := Process32Next( FSnapshotHandle, FProcessEntry32 );
       end;
     CloseHandle( FSnapshotHandle );
end;

function ProcessExists( ExeFileName : String ) : Boolean;
begin
     Result := GetProcessID( ExeFileName )<>0;
end;

function KillProcess( ExeFileName : String ) : Boolean;

var  ProcessID : DWORD;

begin
     Result := False;
     ProcessID := GetProcessID( ExeFileName );
     If   ProcessID<>0
     then Result := TerminateProcess( OpenProcess( PROCESS_TERMINATE, BOOL( 1 ), ProcessID ), 0 );
end;

function RunProcess( HWnd       : HWND;
                     Filename   : string;
                     Parameters : string;
                     RunAsAdmin : Boolean = False ) : Boolean;

var  sei : TShellExecuteInfo;

begin
     ZeroMemory( @sei, SizeOf( sei ) );
     sei.cbSize := SizeOf(TShellExecuteInfo);
     sei.Wnd := hwnd;
     sei.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
     If   RunAsAdmin
     then sei.lpVerb := PChar( 'runas' );
     sei.lpFile := PChar(Filename); // PAnsiChar;
     If   Parameters<>''
     then sei.lpParameters := PChar( Parameters ); // PAnsiChar;
     sei.nShow := SW_SHOWNORMAL; //Integer;

     Result := ShellExecuteEx( @sei );
end;

{$ENDIF}

// Variants

{$IFNDEF NEXTGEN}

function VarRecToVariant( Value : TVarRec ) : Variant;
begin
     With Value do
       case VType of
         vtInteger       : Result := VInteger;
         vtBoolean       : Result := VBoolean;
         vtChar          : Result := VChar;
         vtExtended      : Result := VExtended^;
         vtString        : Result := VString^;
         vtPChar         : Result := VPChar^;
         vtAnsiString    : Result := String( VAnsiString );
         vtCurrency      : Result := VCurrency^;
         vtVariant       : Result := Variant( VVariant^ );
         vtInt64         : Result := VInt64^;
         vtWideString    : Result := WideString( VWideString );
         vtUnicodeString : Result := UnicodeString( VUnicodeString );
         else           raise Exception.Create( 'Error de conversión de VarRec a Variant' );
       end;
end;

{$ENDIF}

function VarIsString( Value : Variant ) : Boolean;
begin
     case VarType( Value ) of
       varOleStr,
       varUString,
       varString   : Result := True;
       else          Result := False;
       end;
end;

function ValueIsEmpty( Value     : Variant;
                       ValueType : TVarType = varUnknown ) : Boolean;
begin
     Result := VarIsNull( Value ) or VarIsEmpty( Value );
     If   not Result
     then case VarType( Value ) of
            varSmallInt,
            varInteger,
            varInt64,
            varDate       : Result := Value=0;
            varDouble,
            varCurrency   : Result := Value=0.0;

            // Cuando el Variant es un String puede ser el resultado de la obtención directa del Valor desde
            // el TcxCustomEdit. En ese caso puede ser en realidad de cualquier otro tipo. Para poder comprobar
            // estos valores hay que pasar el Valor del tipo en VarType y la comprobación se hace directamente
            // comparando el String con sus valores nulos

            varOleStr,
            varUString,
            varString     : case ValueType of
                              varUnknown,
                              varString   : Result := Value='';
                              varSmallInt,
                              varInteger,
                              varInt64,
                              varDouble,
                              varCurrency : Result := ( Value=ChZr ) or ( Value='' );
                              varDate     : Result := ( Value='0:00:00' ) or ( Value='00:00' ) or ( Value='' );  // TDateTime
                              end;
            end;
end;

function  VarToBoolean( Value   : Variant;
                        Default : Boolean = False ) : Boolean;
begin
     If   ValueIsEmpty( Value )
     then Result := Default
     else Result := Value;
end;

function VarToBooleanInt( Value : Variant ) : Integer;
begin
     Result := 0;
     If   not ValueIsEmpty( Value, varBoolean ) and Value
     then Result := 1;
end;

function  VarToDecimal( Value   : Variant;
                        Default : Decimal = 0.0 ) : Decimal;
begin
     If   ValueIsEmpty( Value, varCurrency )
     then Result := Default
     else Result := Value;
end;

function VarToDouble( Value : Variant; Default : Double = 0.0 ) : Double;
begin
     If   ValueIsEmpty( Value, varDouble )
     then Result := Default
     else Result := Value;
end;

function  VarToInteger( Value   : Variant;
                        Default : Integer = 0 ) : Integer;
begin
     If   ValueIsEmpty( Value, varInteger )
     then Result := Default
     else Result := Value;
end;

function  VarToSmallInt( Value   : Variant;
                         Default : SmallInt = 0 ) : SmallInt;
begin
     If   ValueIsEmpty( Value, varSmallInt )
     then Result := Default
     else Result := Value;
end;

function VarToAnsiStr( const V : Variant ) : String;
begin
     If   VarIsType( V, varString )
     then Result := String( V )
     else Result := String( VarToStr( V ) );
end;

function VarToDate( Value : Variant; Default : TDate = 0 ) : TDate;
begin
     If   ValueIsEmpty( Value, varDate)
     then Result := Default
     else If   VarIsString( Value )
          then Result := StrToDate( Value )
          else Result := Value;
end;

function VarToTime( Value : Variant; Default : TTime = 0 ) : TTime;
begin
     If   ValueIsEmpty( Value, varDate )   // Es un TDateTime
     then Result := Default
     else If   VarIsString( Value )
          then Result := StrToTime( Value )
          else Result := Value;
end;

function VarToDuration( Value : Variant; Default : TDuration = 0 ) : TDuration;
begin
     If   ValueIsEmpty( Value, varInteger )
     then Result := Default
     else Result := Value;
end;

function VarIsVoid( const V : Variant ) : Boolean;
begin
     Result := VarIsNull( V ) or VarIsEmpty( V );
end;

{$IFNDEF NEXTGEN}
function VarRecToVariantArray( Values : array of const ) : TVariantArray;

var   I, Segments  : SmallInt;

begin
     Result := nil;
     Segments := High( Values );
     If   Segments<>-1
     then begin
          SetLength( Result, Segments + 1 );
          For I := 0 to Segments do
            Result[ I ] := VarRecToVariant( Values[ I ] );
          end;
end;
{$ENDIF}

// StrFormat

function StrFormat( Valor           : Extended;
                    Dc              : ShortInt = DecimalesMoneda;
                    BlankIfZero     : Boolean = False;
                    InvariantFormat : Boolean = False ) : String;
begin
     If   BlankIfZero and ( Valor=0.0 )
     then Result := ''
     else If   InvariantFormat
          then Result := FloatToStrF( RedondeaExt( Valor, Dc ), ffNumber, 15, Dc, InvariantFormatSettings )
          else Result := FloatToStrF( RedondeaExt( Valor, Dc ), ffNumber, 15, Dc );
end;

{
function StrFormatAndPad( Valor        : Extended;
                          Dc           : ShortInt = DecimalesMoneda;
                          BlankIfZero  : Boolean = False;
                          RightPadding : SmallInt = 1 ) : String;
begin
     If   BlankIfZero and ( Valor=0.0 )
     then Result := ''
     else begin
          Result := FloatToStrF( RedondeaExt( Valor, Dc ), ffNumber, 15, Dc );
          If   RightPadding<>0
          then Result := Result + StrConst( RightPadding );
          end;
end;
}

function StrToDate( Value  : String;
                    Format : TDateFormat = dfDefault2 ) : TDate;

var  DateValues : TStringList;
     Day, Month, Year : Word;

begin
     DateValues := TStringList.Create;
     try

       try

         ExtractStrings( { Separators } [ '/', '.', '-' ], { WhiteSpace } [ ' ' ], PChar( Value ), DateValues );

         case Format of
          dfSQL :
             begin         // YYYY-MM-DD
             Year := StrToInt( DateValues.Strings[ 0 ] );
             Month := StrToInt( DateValues.Strings[ 1 ] );
             Day := StrToInt( DateValues.Strings[ 2 ] );
             end
            else           // dfDefault :  // DD.MM.YY
              begin
              Day := StrToInt( DateValues.Strings[ 0 ] );
              Month := StrToInt( DateValues.Strings[ 1 ] );
              Year := StrToInt( DateValues.Strings[ 2 ] );
              If   Length( DateValues.Strings[ 2 ] )=2
              then If   Year<50
                   then Year := 2000 + Year
                   else Year := 1900 + Year;
              end;

           end;
         Result := EncodeDate( Year, Month, Day );
       except
         Result := 0;
         end;

     finally
       DateValues.Free;
       end;
end;

function StrToDateTime( Value  : String ) : TDateTime;

var  Day, Month, Year, AHour, AMinute, ASecond : Word;
     Sp : SmallInt;

begin

     try

       Day := StrToInt( Copy( Value, 1, 2 ) );
       Month := StrToInt( Copy( Value, 4, 2 ) );
       Year:= StrToInt( Copy( Value, 7, 4 ) );

       // El primer valor, la hora, puede ser simplemente un 0, y no 00. Por ejemplo 0:00:25

       Sp := Value.Length - 4;

       If  Sp>10
       then begin

            If   Sp=15  //  12/01/2019 17:00:45
            then AHour := StrToInt( Copy( Value, 12, 2 ) )
            else AHour := StrToInt( Copy( Value, 12, 1 ) );

            AMinute := StrToInt( Copy( Value, Sp, 2 ) );
            Inc( Sp, 3 );
            ASecond := StrToInt( Copy( Value, Sp, 2 ) );

            end
       else begin
            AHour := 0;
            AMinute := 0;
            ASecond := 0;
            end;

       Result := EncodeDateTime( Year, Month, Day, AHour, AMinute, ASecond, 0 );
     except
       Result := 0;
       end;
end;

function  StrFormatDate( DateTime      : TDateTime;
                         Format        : TDateFormat = dfDefault2;
                         DateSeparator : Char = '/' ) : String;

var  SaveDateSeparator : Char;

begin
     Result :=  '';
     If   DateTime<>0
     then begin

          // FormatDateTime utiliza siempre el DateSeparator definido en FormatSetting.
          // Si se utiliza -por ejemplo- el separador '/' y FormatSetting.DateSeparator='.', se utilizará el punto.

          SaveDateSeparator := FormatSettings.DateSeparator;
          FormatSettings.DateSeparator := DateSeparator;

          try

             case Format of
               dfCompact     : Result := FormatDateTime( 'ddmmyy', DateTime );
               dfCompact2    : Result := FormatDateTime( 'ddmmyyyy', DateTime );
               dfShort       : Result := FormatDateTime( 'dd' + DateSeparator + 'mm', DateTime );
               dfDefault     : Result := FormatDateTime( 'dd' + DateSeparator + 'mm' + DateSeparator + 'yy', DateTime );
               dfDefault2    : Result := FormatDateTime( 'dd' + DateSeparator + 'mm' + DateSeparator + 'yyyy', DateTime );
               dfLong        : Result := FormatDateTime( 'dd' + DateSeparator + 'mmm' + DateSeparator + 'yy', DateTime );
               dfDetailed    : Result := FormatDateTime( 'dddd, dd' + ''' de ''' + 'mmmm' + ''' de ''' + 'yyyy', DateTime );
               dfSQL         : Result := FormatDateTime( 'yyyy-mm-dd', DateTime );
               dfSQLDateTime : Result := FormatDateTime( 'yyyy-mm-dd HH:MM:SS', DateTime );
               dfReversed    : Result := FormatDateTime( 'yymmdd', DateTime );
               dfReversed2 : Result := FormatDateTime( 'yyyymmdd', DateTime );
               end;

          finally
            FormatSettings.DateSeparator := SaveDateSeparator;
            end;

          end;
end;

function StrFormatTime( DateTime : TDateTime;
                        Format   : TTimeFormat = tfDefault ) : String;
begin
     Result := '';
     case Format of
        tfDefault        : Result := FormatDateTime( 'hh:nn:ss', DateTime );
        tfHoursMinutes   : Result := FormatDateTime( 'hh:nn', DateTime );
        tfHoursMinutes2  : Result := FormatDateTime( 'hhnn', DateTime );
        tfMinutesSeconds : Result := FormatDateTime( 'nn:ss', DateTime );
        end;
end;

// Duration

procedure DecodeDuration  (     Duration  : TDuration;
                            var D,
                                H,
                                M,
                                S         : LongInt;
                                Format    : TDurationFormat = rfDefault );
begin
     S := 0;
     M := 0;
     H := 0;
     D := 0;

     case Format of
       rfHoursMinutes :
         begin
         M := Duration div 60;
         If   M<>0
         then begin
              H := M div 60;
              If   H<>0
              then M := M mod 60;
              end;
         end;
       rfDefault :
         begin
         S := duration;
         M := S div 60;
         H := 0;
         D := 0;
         If   M<>0
         then begin
              S := S mod 60;
              H := M div 60;
              If   H<>0
              then M := M mod 60;
              end;
         end;
       rfFull :
         begin
         S := duration;
         M := S div 60;
         H := 0;
         D := 0;
         If   M<>0
         then begin
              S := S mod 60;
              H := M div 60;
              If   H<>0
              then begin
                   M := M mod 60;
                   D := H div 24;
                   If   D<>0
                   then H := H mod 24;
                   end;
              end;
         end;
       end;
end;

function EncodeDuration( D, H, M, S : LongInt ) : TDuration;
begin
     Result := S + ( M * 60 ) + ( H * 3600 ) + ( D * 86400 );
end;

function StrFormatDuration( Duration      : TDuration;
                            Format        : TDurationFormat = rfDefault;
                            TimeSeparator : Char = ':' ) : String;

var   D, H, M, S : LongInt;

begin
     If   Duration=0
     then Result := ''
     else begin
          DecodeDuration( Duration, D, H, M, S, Format );
          case Format of
            rfHoursMinutes :
              Result := StrIntPadded( H, 2 ) + TimeSeparator + StrIntPadded( M, 2 );
            rfDefault :
              Result := StrIntPadded( H, 2 ) + TimeSeparator +  StrIntPadded( M, 2 ) + TimeSeparator + StrIntPadded( S, 2 );
            rfFull :
              Result := StrIntPadded( D, 3 ) + ' ' + StrIntPadded( H, 2 ) + TimeSeparator + StrIntPadded( M, 2 ) + TimeSeparator + StrIntPadded( S, 2 );
            end;
          end;
end;

function  StrFormatBool( Data : Boolean; Format : TBooleanFormat ) : String;
begin
     Result := '';
     case Format of
       bfChecked    : If   Data
                      then Result := BoolCheckChar;
       bfYesNo      : If   Data
                      then Result := 'Sí'
                      else Result := 'No';
       bfTrueFalse  : If   Data
                      then Result := 'Verdadero'
                      else Result := 'Falso';
       bfSQL        : If   Data
                      then Result := 'True'
                      else Result := 'False';
       end;
end;

function StrSetVars( SourceString : String;
                     Names,
                     Values       : TStringArray ) : String;
begin
     Result := SourceString;
     For var Index := 0 to High( Names ) do
       Result := StringReplace( Result, '<' + Names[ Index ] + '>', Values [ Index ], [ rfReplaceAll, rfIgnoreCase ] );
end;

function  StrFormatInt( Value       : Integer;
                        BlankIfZero : Boolean = True ) : String;
begin
     If   ( Value=0 ) and BlankIfZero
     then Result := ''
     else Result := IntToStr( Value );
end;

function MethodIsImplemented( const AClass     : TClass;
                                    MethodName : String ) : Boolean;

var Method : TRttiMethod;

begin
     Result := False;
     Method := TRttiContext.Create.GetType( AClass.ClassInfo ).GetMethod( MethodName );
     If   Assigned( Method )
     then Result := CompareText( AClass.ClassName, Method.Parent.Name )=0;
end;

{ Algunos valores de ALocation :

  CSIDL_COMMON_APPDATA  All Users\Application Data
  CSIDL_WINDOWS         GetWindowsDirectory()
  CSIDL_SYSTEM          GetSystemDirectory()
  CSIDL_PROGRAM_FILES   C:\Program Files

}

{$IFDEF MSWINDOWS}

function GetSpecialFolder( ALocation  : Integer ) : String;

var PIdl : PItemIDList;
    HPath : PChar;

begin
    Result := '';
    If   Succeeded( SHGetSpecialFolderLocation( 0, ALocation, PIdl ) )
    then begin
         HPath := StrAlloc( Max_Path );
         try
           SHGetPathFromIDList( PIdl, HPath );
           SetLastError( 0 ) ;
           Result := PChar( HPath );
         finally
           StrDispose( HPath ) ;
           end;
         end;
end;

function IsRemoteSession: Boolean;
begin
     Result := GetSystemMetrics( sm_RemoteSession )<>0;
end;

{$ENDIF}

{
procedure Delay( Milliseconds : Longint );

var  StartTime : Extended;

begin
     StartTime := Time;
     While Time<StartTime + ( Miliseconds / 100000000 ) do
       Application.ProcessMessages;
end;
}
procedure Delay( Milliseconds : Longint );

var  iStart, iStop: DWORD;

begin
     iStart := GetTickCount;
     repeat
       iStop := GetTickCount;
       Application.ProcessMessages;
       Sleep( 2 );  // Dos segundos
     until ( iStop - iStart ) >= Milliseconds;
end;

{
procedure Delay( Milliseconds : Longint );

var Targettime: Longint;
    Msg : TMsg;

begin
     Targettime := GetTickCount + Milliseconds;
     While Targettime > GetTickCount do
       If   PeekMessage( Msg, 0, 0, 0, PM_REMOVE )
       then begin
            If   Msg.message=WM_QUIT
            then begin
                 PostQuitMessage( Msg.wParam );
                 Break;
                 end;
            TranslateMessage( Msg );
            DispatchMessage( Msg );
            end;
end;
}
function AccountingYear( ADate       : TDateTime;
                         AFirstMonth : Word ) : Word;

var   Day,
      Month,
      Year : Word;

begin
     DecodeDate( ADate, Year, Month, Day );
     If   AFirstMonth=1
     then Result := Year
     else If   ( Month>=AFirstMonth ) and ( Month<=12 )
          then Result := Year
          else Result := Year - 1;
end;

{$IFDEF MSWINDOWS}
function FMM4MemoryUsed : Cardinal;

var St : TMemoryManagerState;
    Sb : TSmallBlockTypeState;

begin
    GetMemoryManagerState( St );
    Result := St.TotalAllocatedMediumBlockSize + St.TotalAllocatedLargeBlockSize;
    For Sb in St.SmallBlockTypeStates do
      Result := Result + Sb.UseableBlockSize * Sb.AllocatedBlockCount;
end;

{$WARN NO_RETVAL OFF}
function CurrentProcessMemory : NativeUInt;

var MemCounters : TProcessMemoryCounters;

begin
     MemCounters.Cb := SizeOf( MemCounters );
     If   GetProcessMemoryInfo( GetCurrentProcess, @MemCounters, SizeOf( MemCounters ) )
     then Result := MemCounters.WorkingSetSize
     else RaiseLastOSError;
end;
{$WARN NO_RETVAL ON}

function GetLastErrorMessage : String;
begin
     Result := SysErrorMessage( GetLastError );
end;
{$ENDIF}

function GetGUID : TGuid;
begin
     CreateGUID( Result );
end;

function IsEmptyGUID( Value : TGuid ) : Boolean;
begin
     Result := Value=TGuid.Empty
end;

function IsValidEMail( Value : String ) : Boolean;
begin
     Result := ( Pos( '@', Value )> 4) and ( Pos( '.', Value )>8 );
end;

{ TCompactList<T> }

function TCompactList<T>.Add(const Value: T): Integer;

var  N : Integer;

begin
     N := IndexOf( T( nil ) );  // Reutilizando bajas
     If   N<>-1
     then begin
          Items[ N ] := Value;
          Result := N;
          end
     else Result := inherited Add( Value );
end;

function TCompactList<T>.Get( const Index : Integer ) : T;
begin
     If   ( Index>=0 ) and ( Index<Count )
     then Result := Items[ Index ]
     else Result := T( nil );
end;

// Este remove no empaqueta la lista, con lo que se invalidarían los valores ya asignados

function TCompactList<T>.Remove(const Value: T): Boolean;

var  Index : Integer;

begin
     Result := False;
     Index := IndexOf( Value );
     If   Index<>-1
     then begin
          Items[ Index ] := T( nil );
          Result := True;
          end;
end;

// ---------------------------

{$IFDEF MSWINDOWS}
procedure SaveBitmap( ABitmap : TBitmap; var AValue: AnsiString );

var AStream: TMemoryStream;

begin
     AStream := TMemoryStream.Create;
     try
        ABitmap.SaveToStream( AStream );
        AStream.Position := 0;
        SetLength( AValue, AStream.Size );
        AStream.ReadBuffer( AValue[1], AStream.Size );
     finally
       AStream.Free;
       end;
end;
{$ENDIF}

function LoadFileToString( const FileName : TFileName ) : String;

var LStrings: TStringList;

begin
    LStrings := TStringList.Create;
    try
      LStrings.Loadfromfile( FileName );
      Result := LStrings.Text;
    finally
      FreeAndNil( LStrings );
      end;
end;

function ValidFileName( Value : String ) : String;

var  I : SmallInt;

begin
     For I := 1 to Length( Value ) do
       If   not( CharInSet( Value[ I ], FileNameCharSet ) )
       then Value[ I ] := '-';
     Result := Value;
end;

{$IFDEF MSWINDOWS}
function FileTimeToDateTime( FileTime : TFileTime ) : TDateTime;

var LocalTime : TFileTime;
    DOSTime : Integer;

begin
     FileTimeToLocalFileTime( FileTime, LocalTime );
     FileTimeToDosDateTime( LocalTime, LongRec( DOSTime ).Hi, LongRec( DOSTime ).Lo );
     Result := FileDateToDateTime( DOSTime );
end;
{$ENDIF}

// Manejo de ficheros CSV

procedure CSVExtractParameters( StLinea          : String;
                                ListaParametros  : TStringList;
                                Separador        : Char = ',';
                                ComprobarCadenas : Boolean = True );

Var  Pc,
     Ps,
     XLen  : SmallInt;
     Qc    : Char;

begin

     ListaParametros.Clear;

     StLinea := TrimRight( StLinea );

     While Length( StLinea )>0 do
       begin

       Qc := StLinea[ 1 ];
       If   ComprobarCadenas and CharInSet( Qc, [ '"', '''' ] )
       then begin
            Delete( StLinea, 1, 1 );
            Ps := Pos( Qc, StLinea );
            If   Ps<>0
            then Delete( StLinea, Ps, 1 );
            Pc := Pos( Separador, StLinea, Ps );
            end
       else Pc := Pos( Separador, StLinea );

       If   Pc=0
       then XLen := Length( StLinea )
       else XLen := Pred( Pc );

       ListaParametros.Add( Trim( Copy( StLinea, 1, XLen ) ) );
       Delete( StLinea, 1, XLen + 1 );

       If   ( Pc<>0 ) and ( Length( StLinea )=0 ) // Aunque el último parámetro esté vacío debe insertarse
       then ListaParametros.Add( '' );

       end;
end;

procedure CSVDate(     St    : String;
                   var Day   : Word;
                   var Month : Word;
                   var Year  : Word );

function GetNextValue( Check : Boolean ) : SmallInt;

Var   Slash  : byte;
      St1    : String;
      Value  : SmallInt;

begin
     Slash := Pos( '/', St );
     If   Slash=0
     then Slash := Length( St )
     else dec( Slash );

     Value := 0;
     St1 := Copy( St, 1, Slash );
     try
       Value := StrToInt( St1 );
     except
       end;

     If   Check
     then If   ( Value<1 ) or ( Value>31 )
          then Value := 0;
     Delete( St, 1, succ( Slash ) );

     Result := Value;
end;

begin
     If   St=''
     then begin
          Day := 0;
          Month := 0;
          Year := 0;
          end
     else begin
     Day := GetNextValue( True  );
     Month := GetNextValue( True  );
     Year := GetNextValue( False );
     If   ( Year<>0 ) and ( Year<100 )
     then If   Year>50
          then Inc( Year, 1900 )
          else Inc( Year, 2000 );
          end;
end;

function CSVDate( St : String ) : TDateTime;

var   Day,
      Month,
      Year  : Word;

begin
     CSVDate( St, Day, Month, Year );
     If   Day=0  // Fechas nulas '00/00/00'  o ''
     then Result := 0
     else Result := EncodeDate( Year, Month, Day );
end;

function  CSVFloat( St : String ) : Double;

Var   Value : Double;
      Pc : SmallInt;
      Code : LongInt;

begin
     try

       // Sustituyo las comas por puntos decimales

       Pc := Pos( ',', St );
       If   Pc<>0
       then St[ Pc ] := '.';

       Val( St, Value, Code );
     except
       Value := 0.0;
       end;
     Result := Value;
end;

function CSVLongInt( St : String ) : LongInt;

var   Value : LongInt;

begin
     try
       Value := StrToInt( St );
     except
       Value := 0;
       end;
     Result := Value;
end;


function CSVInteger( St : String ) : SmallInt;

Var   Value : SmallInt;

begin
     try
       Value := StrToInt( St );
     except
       Value := 0;
       end;
     Result := Value;
end;

function CSVByte( St : String ) : Byte;

Var   Value : Byte;

begin
     try
       Value := StrToInt( St );
     except
       Value := 0;
       end;
     Result := Value;
end;

function CSVBoolean( St : String ) : Boolean;
begin
     Result := UpperCase( St )='TRUE';
end;

procedure SetupUnit;
begin
     DateTimeFormatSettings := TFormatSettings.Create( 'es-ES' );
     DateTimeFormatSettings.ShortDateFormat := 'dd/mm/yyyy';
     DateTimeFormatSettings.ShortTimeFormat := 'hh:nn:ss';
     DateTimeFormatSettings.DateSeparator := '/';
     DateTimeFormatSettings.TimeSeparator := ':';

     InvariantFormatSettings := TFormatSettings.Create( 'en-US' );
end;

{ TEnumUtils }

class function TEnumUtils.GetAs< T >( Valor : String ) : T;

var  Tipo: PTypeInfo;
     Temp: Integer;
     PTemp: Pointer;

begin
     Tipo := TypeInfo( T );
     Temp := GetEnumValue( Tipo, Valor );
     PTemp := @Temp;
     Result := T( PTemp^ );
end;

function IsBitSet( const AValueToCheck, ABitIndex : Integer ): Boolean;
begin
     Result := AValueToCheck and ( 1 shl ABitIndex) <> 0;
end;


function SetBit( const AValueToAlter, ABitIndex: Integer ) : Integer;
begin
     Result := AValueToAlter or ( 1 shl ABitIndex );
end;


function ResetBit( const AValueToAlter, ABitIndex: Integer ) : Integer;
begin
     Result := AValueToAlter and ( not ( 1 shl ABitIndex ) );
end;

function ToggleBit( const AValueToAlter, ABitIndex: Integer ) : Integer;
begin
     Result := AValueToAlter xor ( 1 shl ABitIndex );
end;

{ TCycle }

class operator TCycle.Initialize( out Dest : TCycle );
begin
     Dest.Value:= 1;
     Dest.Cycle := 30;
end;

procedure TCycle.Reset;
begin
     Initialize( Self );
end;

function TCycle.Filled : Boolean;
begin
     Result := Value=Cycle;
     If   Result
     then Value := 1
     else Inc( Value);
end;

// TProcedureWrapper

{
  Lo utilizo en eventos de Spring4D que utilizan procedimientos simples, no métodos de objetos
}

constructor TProcedureWrapper.Create;
begin
     inherited Create;
     FProc := AProc;
end;


procedure TProcedureWrapper.Execute(  Value : TControl );
begin
     If   Assigned( FProc )
     then FProc( Value );
end;

initialization
     SetupUnit;

end.
