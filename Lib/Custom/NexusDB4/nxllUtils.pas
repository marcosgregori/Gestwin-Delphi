{##############################################################################}
{# NexusDB: nxllUtils.pas 4.7516                                             #}
{# NexusDB Memory Manager: nxllUtils.pas %MMVERSION%                          #}
{# Copyright (c) UnSquashable Pty. Ltd. 2003-2025                             #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: low level utility functions                                       #}
{##############################################################################}

{$I nxDefine.inc}

unit nxllUtils;

interface

uses
  {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF},
  SysConst,
  SysUtils,
  Types,
  Variants,
  Classes,
  nxllFastMove,
  nxllFastFillChar,
  nxllTypes;

{== comparison functions ==}
function nxCmpB8(            a, b : TnxByte8)                         : TnxValueRelationship;
function nxCmpW16(           a, b : TnxWord16)                        : TnxValueRelationship;
function nxCmpW32(           a, b : TnxWord32)                        : TnxValueRelationship;
function nxCmpObj(           a, b : TObject)                          : TnxValueRelationship;
function nxCmpPtr(           a, b : Pointer)                          : TnxValueRelationship;
function nxCmpI8(            a, b : TnxInt8)                          : TnxValueRelationship;
function nxCmpI16(           a, b : TnxInt16)                         : TnxValueRelationship;
function nxCmpI32(           a, b : TnxInt32)                         : TnxValueRelationship;
function nxCmpI64(const      a, b : TnxInt64)                         : TnxValueRelationship;
function nxCmpI64Ptr(        a, b : PnxInt64)                         : TnxValueRelationship;
function nxCmpBytes(         a, b : Pointer; MaxLen : TnxWord32)      : TnxValueRelationship;
function nxCmpDynBytes(      a, b : TnxDynByteArray)                  : TnxValueRelationship;
function nxCmpShStr(const    a, b : TnxShStr; MaxLen : TnxByte8 = 255): TnxValueRelationship;
function nxCmpShStrUC(const  a, b : TnxShStr; MaxLen : TnxByte8 = 255): TnxValueRelationship;
function nxCmpStr(const      a, b : string)                           : TnxValueRelationship;
function nxCmpStrUC(const    a, b : string)                           : TnxValueRelationship;
function nxCmpSingle(const   a, b : TnxSingle)                        : TnxValueRelationship;
function nxCmpDouble(const   a, b : TnxDouble)                        : TnxValueRelationship;
function nxCmpExtended(const a, b : TnxExtended)                      : TnxValueRelationship;
{$NODEFINE nxCmpExtended}

function nxSameDynBytes(     a, b : TnxDynByteArray)                  : Boolean;
function nxSameGuid    (     a, b : TnxGuid)                          : Boolean;

function nxStartsWith(const s, t: string): Boolean;

{== minimum/maximum functions ==}
function nxMinWC(       a, b : TnxWideChar) : TnxWideChar;
function nxMinW16(      a, b : TnxWord16)   : TnxWord16;
function nxMaxW16(      a, b : TnxWord16)   : TnxWord16;
function nxMinW32(      a, b : TnxWord32)   : TnxWord32;
function nxMaxW32(      a, b : TnxWord32)   : TnxWord32;
function nxMinI32(      a, b : TnxInt32)    : TnxInt32;
function nxMaxI32(      a, b : TnxInt32)    : TnxInt32;
function nxMinI64(const a, b : TnxInt64)    : TnxInt64;
function nxMaxI64(const a, b : TnxInt64)    : TnxInt64;

{== BitSet functions ==}
procedure nxClearAllBits(BitSet : Pointer; BitCount : Integer); register;
procedure nxClearBit(BitSet : Pointer; Bit : Integer); register;
function nxIsBitSet(BitSet : Pointer; Bit : Integer) : Boolean; register;
procedure nxSetAllBits(BitSet : Pointer; BitCount : Integer); register;
procedure nxSetBit(BitSet : Pointer; Bit : Integer); register;
//function nxFirstSetBit(BitSet : Pointer; BitCount : Integer): Integer; register;
function nxFirstClearBit(BitSet : Pointer; BitCount : Integer): Integer; register;

//procedure nxBitsAnd(Target, Source : PnxByteArray; BitCount : Integer); register;
procedure nxBitsOr(Target, Source : PnxByteArray; BitCount : Integer); register;
//procedure nxBitsAndNot(Target, Source : PnxByteArray; BitCount : Integer); register;
//procedure nxBitsXor(Target, Source : PnxByteArray; BitCount : Integer); register;

{== String functions ==}
function nxAnsiStrIComp(S1, S2: PAnsiChar): Integer;
function nxAnsiStrLIComp(S1, S2: PAnsiChar; MaxLen: Cardinal): Integer;

function  nxCommaizeChL(L : Integer; Ch : Char) : string;

procedure nxStrSplit(S          : string;
               const SplitChars : TnxCharSet;
                 var Left       : string;
                 var Right      : string);

{== Wide-String functions ==}
function nxCharToWideChar(Ch: AnsiChar): WideChar;
function nxNullStrLToWideStr(ZStr: PAnsiChar; WS: PWideChar; MaxLen: Integer): PWideChar;
function nxShStrLToWideStr(const S: TnxShStr; WS: PWideChar; MaxLen: Integer): PWideChar;
function nxWideCharToChar(WC: WideChar): AnsiChar;
function nxWideStrLToNullStr(WS: PWideChar; ZStr: PAnsiChar; MaxLen: Integer): PAnsiChar;
function nxWideStrLToShStr(WS: PWideChar; MaxLen: Integer): TnxShStr;
function nxWideStrLToWideStr(aSourceValue, aTargetValue: PWideChar; MaxLength: Integer): PWideChar;
procedure nxExpandAnsiToWide(aSource : PAnsiChar;
                             aTarget : PWideChar;
                             aCount  : Cardinal);
procedure nxSwapByteOrder(aWideString : PWideChar;
                          aCount      : Cardinal);
function nxWideStrLower(Str: PWideChar): PWideChar;
function nxAnsiStrPos(S1, S2: PAnsiChar): Integer;
function nxWideStrPos(S1, S2: PWideChar): Integer;

procedure nxStringToWideChar(const Source: UnicodeString; Dest: PWideChar; DestSize: Integer);

{== ByteArray functions ==}
procedure HexStringToByteArray(S : string; ArrayLength : Integer; ByteArray : Pointer);
function nxHexStrToByteArray(const aHexString: string): TnxDynByte8Array;

{== Hash functions ==}
function nxCalcELFHash(const Buffer; BufSize : Integer) : TnxWord32;
function nxCalcStrELFHash(const S : AnsiString) : TnxWord32; overload;
function nxCalcStrELFHash(const S : UnicodeString) : TnxWord32; overload;
function nxCalcShStrELFHash(const S : TnxShStr) : TnxWord32;

{== file handlings functions ==}
function nxVerifyExtension(const Ext : string) : Boolean;
function nxVerifyFileName(const FileName : string) : Boolean;

{== command line functions ==}
function nxFindCmdLineSwitch(const aSwitch: string): Boolean;
function nxFindCmdLineParam(const aSwitch     : string;
                            const aChars      : TSysCharSet;
                                  aIgnoreCase : Boolean;
                              out aValue      : string)
                                              : Boolean; overload;
function nxFindCmdLineParamOptional(const aSwitch     : string;
                                    const aChars      : TSysCharSet;
                                          aIgnoreCase : Boolean;
                                      out aValue      : string)
                                                      : Boolean; overload;
function nxFindCmdLineParam(const aSwitch : string;
                              out aValue  : string)
                                          : Boolean; overload;
function nxFindCmdLineParamOptional(const aSwitch : string;
                                      out aValue  : string)
                                                  : Boolean; overload;

{== other functions ==}
function nxIntToAnsiStr(aInt: Integer): AnsiString; overload;
function nxIntToAnsiStr(aInt: Int64): AnsiString; overload;

function nxAnsiStrToIntDef(const S: AnsiString; Default: Integer): Integer;
function nxWideStrToIntDef(const S: WideString; Default: Integer): Integer;

function nxIntToWideStr(aInt: Integer): UnicodeString; overload;
function nxIntToWideStr(aInt: Int64): UnicodeString; overload;

function nxFloatToAnsiStr(const Value          : Extended;
                          const FormatSettings : TFormatSettings): AnsiString;
function nxFloatToWideStr(const Value          : Extended;
                          const FormatSettings : TFormatSettings): UnicodeString;

function nxTimeToAnsiStr(const aDateTime       : TDateTime;
                         const aFormatSettings : TFormatSettings)
                                               : AnsiString;
function nxTimeToWideStr(const aDateTime       : TDateTime;
                         const aFormatSettings : TFormatSettings)
                                               : UnicodeString;

function nxDateToAnsiStr(const aDateTime       : TDateTime;
                         const aFormatSettings : TFormatSettings)
                                               : AnsiString;
function nxDateToWideStr(const aDateTime       : TDateTime;
                         const aFormatSettings : TFormatSettings)
                                               : UnicodeString;

function nxDateTimeToAnsiStr(const aDateTime       : TDateTime;
                             const aFormatSettings : TFormatSettings)
                                                   : AnsiString;
function nxDateTimeToWideStr(const aDateTime       : TDateTime;
                             const aFormatSettings : TFormatSettings)
                                                   : UnicodeString;

function nxGUIDToAnsiString(const aGUID: TGUID): AnsiString;
function nxGUIDToWideString(const aGUID: TGUID): UnicodeString;

function nxIsSystemTable(const aTableName: string): Boolean;

{$IFNDEF FPC}
function nxGetCSIDLShellFolder(CSIDLFolder : integer) : string;
{$ENDIF}
function nxPathEncode(const ASrc: string): string;
function nxCharIsInSet(AString: string; const ACharPos: Integer; ASet: TSysCharSet): Boolean;

function nxAddLineBreakForMultiLine(const s: string): string;

function nxVarRecAsString(const aVarRec: TVarRec): string;
function nxVarRecAsAnsiString(const aVarRec: TVarRec): AnsiString;
function nxVarRecAsUnicodeString(const aVarRec: TVarRec): UnicodeString;


{ on OS before Windos Vista, returns the exe directory.
  on Vista, returns directory under All users\Application Data }
function nxAppHomeDirectory(aCommonAppdataSubDir: string) : string;

{== date/time functions ==}
function nxMakeTimeStamp(const aDate : TnxDate; const aTime : TnxTime) : TTimeStamp;


resourcestring
  rsOSError = 'Win32 Error in %s.  Code: %d.'#10'%s';
  rsUnkOSError = 'A Win32 API function failed in %s.';
  rsOSErrorSourceUnknown = '[unknown]';
  rsInvalidHexChar = 'Invalid character encountered - use only hexadecimal digits 0..9, A..F!';
  rsCantCreateAppDir = 'No se ha podido crear el directorio raiz de la aplicación : '; //..


procedure nxRaiseLastOSError(aSilentException: Boolean; const aSource: string; aErrorCode : TnxResult = 0); overload;
procedure nxRaiseLastOSError(aSilentException: Boolean; aSource: PResStringRec; aErrorCode : TnxResult = 0); overload;
procedure nxRaiseLastOSError(const aSource: string; aErrorCode : TnxResult = 0); overload;
procedure nxRaiseLastOSError(aSource: PResStringRec; aErrorCode : TnxResult = 0); overload;
procedure nxRaiseLastOSError(aSilentException: Boolean; aErrorCode : TnxResult = 0); overload;
procedure nxRaiseLastOSError; overload; register;

function nxOSCheck(RetVal: Boolean): Boolean; overload;
function nxOSCheck(RetVal: Boolean; const aSource: PResStringRec): Boolean; overload;
function nxOSCheck(RetVal: Boolean; const aSource: string): Boolean; overload;

function nxHRCheck(RetVal: HRESULT): HRESULT; overload;
function nxHRCheck(RetVal: HRESULT; const aSource: PResStringRec): HRESULT; overload;
function nxHRCheck(RetVal: HRESULT; const aSource: string): HRESULT; overload;

function nxOSIsWindowsVistaOrBetter : Boolean;

var
  nxDefaultUserCodePage    : Integer;
  nxRaiseLastOSErrorSimple : procedure = nxRaiseLastOSError;

function nxGetThreadCodePage: Integer;

{$IFNDEF NX_MEMMAN_ONLY}
function nxCheckValidIdent(const aIdent       : string;
                                 aErrorCode   : TnxResult;
                                 aAllowEmpty  : Boolean;
                                 aAllowSystem : Boolean = True)
                                              : TnxResult;
function nxMakeValidIdent(const aIdent : string)
                                       : string; overload;

function nxMakeValidIdent(const aIdent           : string;
                                aValidIdentChars : TnxCharSet)
                                                 : string; overload;
{$ENDIF}

type                                                  
  TConvertStringSecurityDescriptorToSecurityDescriptor = function(StringSecurityDescriptor : LPCTSTR;
                                                                  StringSDRevision         : DWORD;
                                                              var SecurityDescriptor       : PSECURITY_DESCRIPTOR;
                                                                  SecurityDescriptorSize   : PULONG)
                                                                                           : BOOL; stdcall;
  TConvertSecurityDescriptorToStringSecurityDescriptor = function(SecurityDescriptor          : PSECURITY_DESCRIPTOR;
                                                                  RequestedStringSDRevision   : DWORD;
                                                                  SecurityInformation         : SECURITY_INFORMATION;
                                                              var StringSecurityDescriptor    : LPTSTR;
                                                                  StringSecurityDescriptorLen : PULONG)
                                                                                              : BOOL; stdcall;

const
  SDDL_REVISION_1 = 1;
  SDDL_REVISION   = SDDL_REVISION_1;

var
  _ConvertStringSecurityDescriptorToSecurityDescriptor : TConvertStringSecurityDescriptorToSecurityDescriptor;
  _ConvertSecurityDescriptorToStringSecurityDescriptor : TConvertSecurityDescriptorToStringSecurityDescriptor;

procedure nxUnmapViewOfFileAndNil(var p{: Pointer}); register;
procedure nxCloseHandleAndNull(var aHandle: THandle); register;
procedure nxCloseHandleAndInvalidate(var aHandle: THandle); register;
procedure nxCloseEventAndSetAndNull(var aHandle: THandle); register;

const
  nxFullAccessSD : array[0..47] of Byte =  (1, 0, 4, 128, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 20, 0, 0, 0, 2, 0, 28, 0, 1, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0,
    16, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0); //'D:(A;;GA;;;WD)' DACL:(SDDL_ACCESS_ALLOWED;;SDDL_FILE_ALL;;;SDDL_EVERYONE)

function nxSetPrivilege(aPrivilegeName: string; aEnable: Boolean): Boolean;

var
  sGlobalNamePrefix : string;
  sLocalNamePrefix : string;

{$IFNDEF FPC}
function nxClassFromPtr(aPtr : Pointer)
                             : TClass;
function nxIsClassInstance(aPtr   : Pointer;
                       out aClass : TClass)
                                  : Boolean;
function nxIsClassInstanceOfType(aPtr   : Pointer;
                                 aClass : TClass)
                                        : Boolean;
function nxPtrIsClassOfType(aPtr   : Pointer;
                            aClass : TClass)
                                   : Boolean;
{$ENDIF}

type
  TMemoryStatusEx = record
    dwLength: Cardinal;
    dwMemoryLoad: Cardinal;
    ullTotalPhys: Int64;
    ullAvailPhys: Int64;
    ullTotalPageFile: Int64;
    ullAvailPageFile: Int64;
    ullTotalVirtual: Int64;
    ullAvailVirtual: Int64;
    ullAvailExtendedVirtual: Int64;
  end;

type
  TGlobalMemoryStatusEx = function(var lpBuffer: TMemoryStatusEx): LongBool; stdcall;

var
  _GlobalMemoryStatusEx : TGlobalMemoryStatusEx;

function EmulateGlobalMemoryStatusEx(var lpBuffer: TMemoryStatusEx): LongBool; stdcall;

function nxIsValidLocale(LocaleID: DWord): Boolean;
function nxIsValidCodepage(CodepageID: DWord): Boolean;
function nxCollationList: TStringList;
function nxCodePageList: TStringList;

function nxCollationNameFromLocale(LocaleID: DWord): WideString;
function nxCharacterSetNameFromCodepage(CodepageID: DWord): WideString;
function nxLocaleFromCollation(const CollationName: string): Integer;
function nxCodepageFromCharacterSet(const CharacterSetName: string): Integer;

type
  PFormatSettings = ^TFormatSettings;

function nxFormatSettingFromLocaleID(LocaleID: DWord): PFormatSettings;

type
  TnxLocaleNameMapping = record
    lnmID   : LCID;
    lnmName : string;
  end;

const
  nxLocaleNameMappings : array [0..141] of TnxLocaleNameMapping = (
    (lnmID: 1078; lnmName: 'Afrikaans'),
    (lnmID: 1052; lnmName: 'Albanian'),
    (lnmID: 5121; lnmName: 'Arabic (Algeria)'),
    (lnmID: 15361; lnmName: 'Arabic (Bahrain)'),
    (lnmID: 3073; lnmName: 'Arabic (Egypt)'),
    (lnmID: 2049; lnmName: 'Arabic (Iraq)'),
    (lnmID: 11265; lnmName: 'Arabic (Jordan)'),
    (lnmID: 13313; lnmName: 'Arabic (Kuwait)'),
    (lnmID: 12289; lnmName: 'Arabic (Lebanon)'),
    (lnmID: 4097; lnmName: 'Arabic (Libya)'),
    (lnmID: 6145; lnmName: 'Arabic (Morocco)'),
    (lnmID: 8193; lnmName: 'Arabic (Oman)'),
    (lnmID: 16385; lnmName: 'Arabic (Qatar)'),
    (lnmID: 1025; lnmName: 'Arabic (Saudi Arabia)'),
    (lnmID: 10241; lnmName: 'Arabic (Syria)'),
    (lnmID: 7169; lnmName: 'Arabic (Tunisia)'),
    (lnmID: 14337; lnmName: 'Arabic (U.A.E.)'),
    (lnmID: 9217; lnmName: 'Arabic (Yemen)'),
    (lnmID: 1067; lnmName: 'Armenian'),
    (lnmID: 2092; lnmName: 'Azeri (Cyrillic)'),
    (lnmID: 1068; lnmName: 'Azeri (Latin)'),
    (lnmID: 1069; lnmName: 'Basque'),
    (lnmID: 1059; lnmName: 'Belarusian'),
    (lnmID: 1026; lnmName: 'Bulgarian'),
    (lnmID: 1027; lnmName: 'Catalan'),
    (lnmID: 3076; lnmName: 'Chinese (Hong Kong S.A.R.) Stroke Count'),
    (lnmID: 5124; lnmName: 'Chinese (Macau S.A.R.) Pronunciation'),
    (lnmID: 136196; lnmName: 'Chinese (Macau S.A.R.) Stroke Count'),
    (lnmID: 2052; lnmName: 'Chinese (PRC) Pronunciation'),
    (lnmID: 133124; lnmName: 'Chinese (PRC) Stroke Count'),
    (lnmID: 4100; lnmName: 'Chinese (Singapore) Pronunciation'),
    (lnmID: 135172; lnmName: 'Chinese (Singapore) Stroke Count'),
    (lnmID: 197636; lnmName: 'Chinese (Taiwan) Bopomofo'),
    (lnmID: 1028; lnmName: 'Chinese (Taiwan) Stroke Count'),
    (lnmID: 1050; lnmName: 'Croatian'),
    (lnmID: 1029; lnmName: 'Czech'),
    (lnmID: 1030; lnmName: 'Danish'),
    (lnmID: 1125; lnmName: 'Divehi'),
    (lnmID: 2067; lnmName: 'Dutch (Belgium)'),
    (lnmID: 1043; lnmName: 'Dutch (Netherlands)'),
    (lnmID: 3081; lnmName: 'English (Australia)'),
    (lnmID: 10249; lnmName: 'English (Belize)'),
    (lnmID: 4105; lnmName: 'English (Canada)'),
    (lnmID: 9225; lnmName: 'English (Caribbean)'),
    (lnmID: 6153; lnmName: 'English (Ireland)'),
    (lnmID: 8201; lnmName: 'English (Jamaica)'),
    (lnmID: 5129; lnmName: 'English (New Zealand)'),
    (lnmID: 13321; lnmName: 'English (Philippines)'),
    (lnmID: 7177; lnmName: 'English (South Africa)'),
    (lnmID: 11273; lnmName: 'English (Trinidad)'),
    (lnmID: 2057; lnmName: 'English (United Kingdom)'),
    (lnmID: 1033; lnmName: 'English (United States)'),
    (lnmID: 12297; lnmName: 'English (Zimbabwe)'),
    (lnmID: 1061; lnmName: 'Estonian'),
    (lnmID: 1080; lnmName: 'Faroese'),
    (lnmID: 1065; lnmName: 'Farsi'),
    (lnmID: 1035; lnmName: 'Finnish'),
    (lnmID: 2060; lnmName: 'French (Belgium)'),
    (lnmID: 3084; lnmName: 'French (Canada)'),
    (lnmID: 1036; lnmName: 'French (France)'),
    (lnmID: 5132; lnmName: 'French (Luxembourg)'),
    (lnmID: 6156; lnmName: 'French (Monaco)'),
    (lnmID: 4108; lnmName: 'French (Switzerland)'),
    (lnmID: 1071; lnmName: 'FYRO Macedonian'),
    (lnmID: 1110; lnmName: 'Galician'),
    (lnmID: 66615; lnmName: 'Georgian Modern'),
    (lnmID: 1079; lnmName: 'Georgian Traditional'),
    (lnmID: 3079; lnmName: 'German (Austria)'),
    (lnmID: 1031; lnmName: 'German (Germany) Dictionary'),
    (lnmID: 66567; lnmName: 'German (Germany) Phone Book (DIN)'),
    (lnmID: 5127; lnmName: 'German (Liechtenstein)'),
    (lnmID: 4103; lnmName: 'German (Luxembourg)'),
    (lnmID: 2055; lnmName: 'German (Switzerland)'),
    (lnmID: 1032; lnmName: 'Greek'),
    (lnmID: 1095; lnmName: 'Gujarati'),
    (lnmID: 1037; lnmName: 'Hebrew'),
    (lnmID: 1081; lnmName: 'Hindi'),
    (lnmID: 1038; lnmName: 'Hungarian'),
    (lnmID: 66574; lnmName: 'Hungarian Technical'),
    (lnmID: 1039; lnmName: 'Icelandic'),
    (lnmID: 1057; lnmName: 'Indonesian'),
    (lnmID: 1040; lnmName: 'Italian (Italy)'),
    (lnmID: 2064; lnmName: 'Italian (Switzerland)'),
    (lnmID: 1041; lnmName: 'Japanese XJIS'),
    (lnmID: 1099; lnmName: 'Kannada'),
    (lnmID: 1087; lnmName: 'Kazakh'),
    (lnmID: 1111; lnmName: 'Konkani'),
    (lnmID: 1042; lnmName: 'Korean Dictionary'),
    (lnmID: 1088; lnmName: 'Kyrgyz (Cyrillic)'),
    (lnmID: 1062; lnmName: 'Latvian'),
    (lnmID: 1063; lnmName: 'Lithuanian'),
    (lnmID: 2110; lnmName: 'Malay (Brunei Darussalam)'),
    (lnmID: 1086; lnmName: 'Malay (Malaysia)'),
    (lnmID: 1102; lnmName: 'Marathi'),
    (lnmID: 1104; lnmName: 'Mongolian (Cyrillic)'),
    (lnmID: 1044; lnmName: 'Norwegian (Bokmal)'),
    (lnmID: 2068; lnmName: 'Norwegian (Nynorsk)'),
    (lnmID: 1045; lnmName: 'Polish'),
    (lnmID: 1046; lnmName: 'Portuguese (Brazil)'),
    (lnmID: 2070; lnmName: 'Portuguese (Portugal)'),
    (lnmID: 1094; lnmName: 'Punjabi'),
    (lnmID: 1048; lnmName: 'Romanian'),
    (lnmID: 1049; lnmName: 'Russian'),
    (lnmID: 1103; lnmName: 'Sanskrit'),
    (lnmID: 3098; lnmName: 'Serbian (Cyrillic)'),
    (lnmID: 2074; lnmName: 'Serbian (Latin)'),
    (lnmID: 1051; lnmName: 'Slovak'),
    (lnmID: 1060; lnmName: 'Slovenian'),
    (lnmID: 11274; lnmName: 'Spanish (Argentina)'),
    (lnmID: 16394; lnmName: 'Spanish (Bolivia)'),
    (lnmID: 13322; lnmName: 'Spanish (Chile)'),
    (lnmID: 9226; lnmName: 'Spanish (Colombia)'),
    (lnmID: 5130; lnmName: 'Spanish (Costa Rica)'),
    (lnmID: 7178; lnmName: 'Spanish (Dominican Republic)'),
    (lnmID: 12298; lnmName: 'Spanish (Ecuador)'),
    (lnmID: 17418; lnmName: 'Spanish (El Salvador)'),
    (lnmID: 4106; lnmName: 'Spanish (Guatemala)'),
    (lnmID: 18442; lnmName: 'Spanish (Honduras)'),
    (lnmID: 3082; lnmName: 'Spanish (International Sort) International'),
    (lnmID: 2058; lnmName: 'Spanish (Mexico)'),
    (lnmID: 19466; lnmName: 'Spanish (Nicaragua)'),
    (lnmID: 6154; lnmName: 'Spanish (Panama)'),
    (lnmID: 15370; lnmName: 'Spanish (Paraguay)'),
    (lnmID: 10250; lnmName: 'Spanish (Peru)'),
    (lnmID: 20490; lnmName: 'Spanish (Puerto Rico)'),
    (lnmID: 1034; lnmName: 'Spanish (Traditional Sort) Traditional'),
    (lnmID: 14346; lnmName: 'Spanish (Uruguay)'),
    (lnmID: 8202; lnmName: 'Spanish (Venezuela)'),
    (lnmID: 1089; lnmName: 'Swahili'),
    (lnmID: 1053; lnmName: 'Swedish'),
    (lnmID: 2077; lnmName: 'Swedish (Finland)'),
    (lnmID: 1114; lnmName: 'Syriac'),
    (lnmID: 1097; lnmName: 'Tamil'),
    (lnmID: 1092; lnmName: 'Tatar'),
    (lnmID: 1098; lnmName: 'Telugu'),
    (lnmID: 1054; lnmName: 'Thai'),
    (lnmID: 1055; lnmName: 'Turkish'),
    (lnmID: 1058; lnmName: 'Ukrainian'),
    (lnmID: 1056; lnmName: 'Urdu'),
    (lnmID: 2115; lnmName: 'Uzbek (Cyrillic)'),
    (lnmID: 1091; lnmName: 'Uzbek (Latin)'),
    (lnmID: 1066; lnmName: 'Vietnamese')
  );

type
  PNLSVersionInfo = ^TNLSVersionInfo;
  TNLSVersionInfo = record
    dwNLSVersionInfoSize : DWORD;
    dwNLSVersion         : DWORD;
    dwDefinedVersion     : DWORD;
  end;

  PNLSVersionInfoEx = ^TNLSVersionInfoEx;
  TNLSVersionInfoEx = record
    dwNLSVersionInfoSize : DWORD;
    dwNLSVersion         : DWORD;
    dwDefinedVersion     : DWORD;
    dwEffectiveId        : DWORD;
    guidCustomVersion    : TGUID;
  end;

  TGetNLSVersion = function (Function_: DWORD; Locale: LCID; lpVersionInformation: PNLSVersionInfo): BOOL; stdcall;

var
  _GetNLSVersion : TGetNLSVersion;

procedure GetNLSVersionCompareString(aLocale: LCID; out aVersionInfo: TNLSVersionInfoEx);

{$IFDEF FPC}
function Succeeded(Res: HResult): Boolean;
{$ENDIF}

type
  TnxSupportsMultiResult = (
    smrNone,
    smrSome,
    smrAll
  );

function nxSupportsMulti(const Instance: IInterface; const IIDs: array of TGUID; const Intfs: array of PnxInterface): TnxSupportsMultiResult;

function nxStringsToArray(aStrings: TStrings): TnxDynStringArray;

var _ServiceStillBusy: procedure of object;

procedure ServiceStillBusy;

function nxStrCompW(const Str1, Str2: PWideChar): Integer;
function nxStrICompW(const Str1, Str2: PWideChar): Integer;
function nxStrLCompW(const Str1, Str2: PWideChar; MaxLen: Cardinal): Integer;
function nxStrLICompW(const Str1, Str2: PWideChar; MaxLen: Cardinal): Integer;

function nxVarArrayLength(const V: Variant; Dim: Integer): Integer;


function nxNewArray(const aFirstElement: UnicodeString): TnxUnicodeStrings; overload;

procedure nxAddToArray(var aArray: TnxUnicodeStrings; const aElement: UnicodeString); overload;

function nxRemoveFromArray(var aArray: TnxUnicodeStrings; aIndex: Integer): UnicodeString; overload;

{$IFNDEF DCC12OrLater}
function UTF8EncodeToShortString(const aWide: WideString): ShortString; overload;
function UTF8EncodeToShortString(const aAnsi: RawByteString): ShortString; overload;
function UTF8ToUnicodeString(const aShort: ShortString): UnicodeString; overload;
function UTF8ToUnicodeString(const aAnsi: RawByteString): UnicodeString; overload;
{$ENDIF DCC12OrLater}

var
  _nxDisconnectObject : function(const aInstance: InxInterface): HRESULT = nil;

function nxDisconnectObject(const aInstance: InxInterface): HRESULT;

procedure nxUnicodeStringsToDelphiStrings(const aUnicodeStrings : TnxUnicodeStrings;
                                                aStrings        : TStrings);
function nxDelphiStringsToUnicodeStrings(aStrings : TStrings)
                                                  : TnxUnicodeStrings;

var
  nxInvariantFormatSettings : TFormatSettings;

type
  TnxFSObjectID = packed record
    ObjectId      : TGUID;
    BirthVolumeId : TGUID;
    BirthObjectId : TGUID;
    DomainId      : TGUID;
  end;

function nxFSGetOrCreateObjectID(const aFile: THandle; out aObjectID: TnxFSObjectID): Boolean;

type
  TnxFileUniqueId = record
    fuiCreationTime       : TFileTime;
    fuiVolumeSerialNumber : UInt64;
    fuiFileId             : TGUID;
  end;

function nxGetFileUniqueId(aFile: THandle; out aUniqueId: TnxFileUniqueId): Boolean;

{$IFDEF DCC16OrLater}
type
  TnxEncodingHelper = class helper for TEncoding
    function GetString(aData: Pointer; aSize: Integer): string; overload;
    function GetBytes(const aString: string; var aBytes; aSize: Integer): Integer; overload;
  end;
{$ENDIF}

{$IFNDEF DCC29OrLater}
  function IsBufferValid(const Bytes: Pointer; ByteCount: Integer): Boolean;
{$ENDIF}

function nxGetSafeUTF8Length(aData: PByte; aDesiredLength, aMaxLength: TnxMemSize): TnxMemSize;

implementation

{$IFNDEF NX_MEMMAN_ONLY}
uses
  SHFolder,
  ShlObj,
  nxllMemoryManager,
  nxllBde,
  nxllBdeStrings,
  nxllException,
  nxllSync,
  nxllConst,
  nxllList,
  nxllLockedFuncs;
{$ENDIF}

{$IFNDEF NX_EMBEDDEDSERVER_ONLY}
  {$INCLUDE Server\nxServicename.inc}
{$ENDIF}

{$IFDEF CPUX86}
var
  _nxFillChar : TnxFillChar;
{$ENDIF}

resourcestring
  rsHexStringOddLength = 'Hex string has an odd length';
  rsInvalidCharacterInHexString = 'Invalid character in hex string at character %d: %s';

{==comparison functions =======================================================}
function nxCmpB8(a, b : TnxByte8) : TnxValueRelationship;
{$IFDEF CPUX86}
asm
  xor ecx, ecx
  cmp al, dl
  ja @@GT
  je @@EQ
@@LT:
  dec ecx
  dec ecx
@@GT:
  inc ecx
@@EQ:
  mov eax, ecx
end;
{$ELSE}
begin
  if      a > b then Result := nxGreaterThan
  else if a < b then Result := nxSmallerThan
  else               Result := nxEqual;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxCmpW16(a, b : TnxWord16) : TnxValueRelationship;
{$IFDEF CPUX86}
asm
  xor ecx, ecx
  cmp ax, dx
  ja @@GT
  je @@EQ
@@LT:
  dec ecx
  dec ecx
@@GT:
  inc ecx
@@EQ:
  mov eax, ecx
end;
{$ELSE}
begin
  if      a > b then Result := nxGreaterThan
  else if a < b then Result := nxSmallerThan
  else               Result := nxEqual;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxCmpW32(a, b : TnxWord32) : TnxValueRelationship;
{$IFDEF CPUX86}
asm
  xor ecx, ecx
  cmp eax, edx
  ja @@GT
  je @@EQ
@@LT:
  dec ecx
  dec ecx
@@GT:
  inc ecx
@@EQ:
  mov eax, ecx
end;
{$ELSE}
begin
  if      a > b then Result := nxGreaterThan
  else if a < b then Result := nxSmallerThan
  else               Result := nxEqual;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxCmpObj(a, b : TObject) : TnxValueRelationship;
{$IFDEF CPUX86}
asm
  xor ecx, ecx
  cmp eax, edx
  ja @@GT
  je @@EQ
@@LT:
  dec ecx
  dec ecx
@@GT:
  inc ecx
@@EQ:
  mov eax, ecx
end;
{$ELSE}
begin
  if      TnxNativeUInt(a) > TnxNativeUInt(b) then Result := nxGreaterThan
  else if TnxNativeUInt(a) < TnxNativeUInt(b) then Result := nxSmallerThan
  else                                             Result := nxEqual;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxCmpPtr(a, b : Pointer) : TnxValueRelationship;
{$IFDEF CPUX86}
asm
  xor ecx, ecx
  cmp eax, edx
  ja @@GT
  je @@EQ
@@LT:
  dec ecx
  dec ecx
@@GT:
  inc ecx
@@EQ:
  mov eax, ecx
end;
{$ELSE}
begin
  if      TnxNativeUInt(a) > TnxNativeUInt(b) then Result := nxGreaterThan
  else if TnxNativeUInt(a) < TnxNativeUInt(b) then Result := nxSmallerThan
  else                                             Result := nxEqual;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxCmpI8(a, b : TnxInt8) : TnxValueRelationship;
{$IFDEF CPUX86}
asm
  xor ecx, ecx
  cmp al, dl
  jg @@GT
  je @@EQ
@@LT:
  dec ecx
  dec ecx
@@GT:
  inc ecx
@@EQ:
  mov eax, ecx
end;
{$ELSE}
begin
  if      a > b then Result := nxGreaterThan
  else if a < b then Result := nxSmallerThan
  else               Result := nxEqual;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxCmpI16(a, b : TnxInt16) : TnxValueRelationship;
{$IFDEF CPUX86}
asm
  xor ecx, ecx
  cmp ax, dx
  jg @@GT
  je @@EQ
@@LT:
  dec ecx
  dec ecx
@@GT:
  inc ecx
@@EQ:
  mov eax, ecx
end;
{$ELSE}
begin
  if      a > b then Result := nxGreaterThan
  else if a < b then Result := nxSmallerThan
  else               Result := nxEqual;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxCmpI32(a, b : TnxInt32) : TnxValueRelationship;
{$IFDEF CPUX86}
asm
  xor ecx, ecx
  cmp eax, edx
  jg @@GT
  je @@EQ
@@LT:
  dec ecx
  dec ecx
@@GT:
  inc ecx
@@EQ:
  mov eax, ecx
end;
{$ELSE}
begin
  if      a > b then Result := nxGreaterThan
  else if a < b then Result := nxSmallerThan
  else               Result := nxEqual;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxCmpI64(const a, b : TnxInt64) : TnxValueRelationship;
{$IFDEF CPUX86}
asm
  xor eax, eax
  mov edx, [ebp+20]
  cmp edx, [ebp+12]
  jg @@GT
  jl @@LT
  mov edx, [ebp+16]
  cmp edx, [ebp+8]
  ja @@GT
  je @@EQ
@@LT:
  dec eax
  dec eax
@@GT:
  inc eax
@@EQ:
end;
{$ELSE}
begin
  if      a > b then Result := nxGreaterThan
  else if a < b then Result := nxSmallerThan
  else               Result := nxEqual;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxCmpI64Ptr(a, b : PnxInt64): TnxValueRelationship;
{$IFDEF CPUX86}
asm
  mov ecx, [eax + 4]
  cmp ecx, [edx + 4]
  jg @@GT
  jl @@LT

  mov ecx, [eax]
  cmp ecx, [edx]
  ja @@GT
  je @@EQ

@@LT:
  mov al, -1
  ret
@@GT:
  mov al, 1
  ret
@@EQ:
  xor eax, eax
end;
{$ELSE}
begin
  if      a^ > b^ then Result := nxGreaterThan
  else if a^ < b^ then Result := nxSmallerThan
  else                 Result := nxEqual;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxCmpBytes(a, b : Pointer; MaxLen : TnxWord32) : TnxValueRelationship;
{$IFDEF CPUX86}
asm
  push esi
  push edi
  mov esi, eax
  mov edi, edx
  xor eax, eax
  or ecx, ecx
  jz @@Equal
  repe cmpsb
  jb @@Exit
  je @@Equal
  inc eax
@@Equal:
  inc eax
@@Exit:
  dec eax
  pop edi
  pop esi
end;
{$ELSE}
var
  lA : PnxByteArray absolute a;
  lB : PnxByteArray absolute b;

  i: Integer;
begin
  if MaxLen > 0 then
    for i := 0 to Pred(MaxLen) do
      if      lA[i] > lB[i] then Exit(nxGreaterThan)
      else if lA[i] < lB[i] then Exit(nxSmallerThan);
  Result := nxEqual;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxCmpDynBytes(a, b : TnxDynByteArray) : TnxValueRelationship;
var
  LenA : Integer;
  LenB : Integer;
begin
  LenA := Length(a);
  LenB := Length(b);

  if (LenA > 0) and (LenB > 0) then
    Result := nxCmpBytes(@a[0], @b[0], nxMinI32(LenA, LenB))
  else
    Result := nxEqual;

  if Result = nxEqual then
    Result := nxCmpI16(LenA, LenB);
end;
{------------------------------------------------------------------------------}
function nxCmpShStr(const a, b : TnxShStr; MaxLen : TnxByte8) : TnxValueRelationship;
{$IFDEF CPUX86}
asm
  push esi
  push edi
  mov esi, eax
  mov edi, edx
  movzx ecx, cl
  mov ch, cl
  xor eax, eax
  mov dl, [esi]
  inc esi
  mov dh, [edi]
  inc edi
  cmp cl, dl
  jbe @@Check2ndLength
  mov cl, dl
@@Check2ndLength:
  cmp cl, dh
  jbe @@CalcSigLengths
  mov cl, dh
@@CalcSigLengths:
  cmp dl, ch
  jbe @@Calc2ndSigLength
  mov dl, ch
@@Calc2ndSigLength:
  cmp dh, ch
  jbe @@CompareStrings
  mov dh, ch
@@CompareStrings:
  movzx ecx, cl
  or ecx, ecx
  jz @@CompareLengths
  repe cmpsb
  jb @@Exit
  ja @@GT
@@CompareLengths:
  cmp dl, dh
  je @@Equal
  jb @@Exit
@@GT:
  inc eax
@@Equal:
  inc eax
@@Exit:
  dec eax
  pop edi
  pop esi
end;
{$ELSE}
var
  i          : Integer;
  LenA, LenB : Integer;
begin
  LenA := Length(a);
  if LenA > MaxLen then
    LenA := MaxLen;

  LenB := Length(b);
  if LenB > MaxLen then
    LenB := MaxLen;

  I := 1;
  while (I <= LenA) and (I <= LenB) do begin
    if (a[i] <> b[i]) then
      Exit(nxCmpB8(Ord(a[i]), Ord(b[i])));
    Inc(I);
  end;

  Result := nxCmpI32(LenA, LenB);
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxCmpShStrUC(const a, b : TnxShStr; MaxLen : TnxByte8) : TnxValueRelationship;
{$IFDEF CPUX86}
asm
  push esi
  push edi
  push ebx
  mov esi, eax
  mov edi, edx
  movzx ecx, cl
  mov ch, cl
  xor eax, eax
  mov dl, [esi]
  inc esi
  mov dh, [edi]
  inc edi
  cmp cl, dl
  jbe @@Check2ndLength
  mov cl, dl
@@Check2ndLength:
  cmp cl, dh
  jbe @@CalcSigLengths
  mov cl, dh
@@CalcSigLengths:
  cmp dl, ch
  jbe @@Calc2ndSigLength
  mov dl, ch
@@Calc2ndSigLength:
  cmp dh, ch
  jbe @@CompareStrings
  mov dh, ch
@@CompareStrings:
  movzx ecx, cl
  or ecx, ecx
  jz @@CompareLengths
@@NextChars:
  mov bl, [esi]
  cmp bl, 'a'
  jb @@OtherChar
  cmp bl, 'z'
  ja @@OtherChar
  sub bl, 'a'-'A'
@@OtherChar:
  mov bh, [edi]
  cmp bh, 'a'
  jb @@CompareChars
  cmp bh, 'z'
  ja @@CompareChars
  sub bh, 'a'-'A'
@@CompareChars:
  cmp bl, bh
  jb @@Exit
  ja @@GT
  inc esi
  inc edi
  dec ecx
  jnz @@NextChars
@@CompareLengths:
  cmp dl, dh
  je @@Equal
  jb @@Exit
@@GT:
  inc eax
@@Equal:
  inc eax
@@Exit:
  dec eax
  pop ebx
  pop edi
  pop esi
end;
{$ELSE}
var
  i            : Integer;
  LenA, LenB   : Integer;
  CharA, CharB : AnsiChar;
begin
  LenA := Length(a);
  if LenA > MaxLen then
    LenA := MaxLen;

  LenB := Length(b);
  if LenB > MaxLen then
    LenB := MaxLen;

  I := 1;
  while (I <= LenA) and (I <= LenB) do begin
    CharA := a[i];
    if CharA in ['a'..'z'] then
      CharA := AnsiChar(Byte(CharA) xor $20);

    CharB := b[i];
    if CharB in ['a'..'z'] then
      CharB := AnsiChar(Byte(CharB) xor $20);

    if (CharA <> CharB) then
      Exit(nxCmpB8(Ord(CharA), Ord(CharB)));
    Inc(I);
  end;

  Result := nxCmpI32(LenA, LenB);
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxCmpStr(const a, b : string): TnxValueRelationship;
begin
  Result := {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF}.CompareString
             (LOCALE_SYSTEM_DEFAULT,
              0,
              PChar(a), -1,
              PChar(b), -1)-2
end;
{------------------------------------------------------------------------------}
function nxCmpStrUC(const a, b : string): TnxValueRelationship;
begin
  Result := {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF}.CompareString
             (LOCALE_SYSTEM_DEFAULT,
              NORM_IGNORECASE,
              PChar(a), -1,
              PChar(b), -1)-2
end;
{------------------------------------------------------------------------------}
function nxCmpSingle(const a, b : TnxSingle) : TnxValueRelationship;
begin
  if      a > b then Result := nxGreaterThan
  else if a < b then Result := nxSmallerThan
  else               Result := nxEqual;
end;
{------------------------------------------------------------------------------}
function nxCmpDouble(const a, b : TnxDouble) : TnxValueRelationship;
begin
  if      a > b then Result := nxGreaterThan
  else if a < b then Result := nxSmallerThan
  else               Result := nxEqual;
end;
{------------------------------------------------------------------------------}
function nxCmpExtended(const a, b : TnxExtended) : TnxValueRelationship;
begin
  if      a > b then Result := nxGreaterThan
  else if a < b then Result := nxSmallerThan
  else               Result := nxEqual;
end;
{==============================================================================}



{===nxSameDynBytes=============================================================}
function nxSameDynBytes(a, b : TnxDynByteArray): Boolean;
var
  LenA : Integer;
  LenB : Integer;
begin
  LenA := Length(a);
  LenB := Length(b);

  Result := LenA = LenB;
  if Result and (LenA > 0) then
    Result := nxCmpBytes(@a[0], @b[0], LenA) = nxEqual;
end;
{==============================================================================}



{===nxSameGuid=================================================================}
function nxSameGuid(a, b : TnxGuid): Boolean;
begin
  Result := nxCmpBytes(@a, @b, SizeOf(TnxGuid)) = nxEqual;
end;
{==============================================================================}



{==============================================================================}
function nxStartsWith(const s, t: string): Boolean;
var
  i: Integer;
begin
  Result := Length(s) >= Length(t);
  if Result then
    for i := 1 to Length(t) do
      if s[i] <> t[i] then begin
        Result := False;
        Exit;
      end;
end;
{==============================================================================}



{== minimum/maximum functions =================================================}
function nxMinWC(a, b : TnxWideChar) : TnxWideChar;
{$IFDEF CPUX86}
asm
  cmp ax, dx
  jbe @@Exit
  mov ax, dx
@@Exit:
end;
{$ELSE}
begin
  if a < b
    then Result := a
    else Result := b;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxMinW16(a, b : TnxWord16) : TnxWord16;
{$IFDEF CPUX86}
asm
  cmp ax, dx
  jbe @@Exit
  mov ax, dx
@@Exit:
end;
{$ELSE}
begin
  if a < b
    then Result := a
    else Result := b;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxMaxW16(a, b : TnxWord16) : TnxWord16;
{$IFDEF CPUX86}
asm
  cmp ax, dx
  jae @@Exit
  mov ax, dx
@@Exit:
end;
{$ELSE}
begin
  if a > b
    then Result := a
    else Result := b;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxMinW32(a, b : TnxWord32) : TnxWord32;
{$IFDEF CPUX86}
asm
  cmp eax, edx
  jbe @@Exit
  mov eax, edx
@@Exit:
end;
{$ELSE}
begin
  if a < b
    then Result := a
    else Result := b;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxMaxW32(a, b : TnxWord32) : TnxWord32;
{$IFDEF CPUX86}
asm
  cmp eax, edx
  jae @@Exit
  mov eax, edx
@@Exit:
end;
{$ELSE}
begin
  if a > b
    then Result := a
    else Result := b;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxMinI32(a, b : TnxInt32) : TnxInt32;
{$IFDEF CPUX86}
asm
  cmp eax, edx
  jle @@Exit
  mov eax, edx
@@Exit:
end;
{$ELSE}
begin
  if a < b
    then Result := a
    else Result := b;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxMaxI32(a, b : TnxInt32) : TnxInt32;
{$IFDEF CPUX86}
asm
  cmp eax, edx
  jge @@Exit
  mov eax, edx
@@Exit:
end;
{$ELSE}
begin
  if a > b
    then Result := a
    else Result := b;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxMinI64(const a, b : TnxInt64) : TnxInt64;
{$IFDEF CPUX86}
asm
  mov edx, [ebp+12]
  cmp edx, [ebp+20]
  jg  @@AIsSmaller
  mov eax, [ebp+8]
  jl  @@Exit
  cmp eax, [ebp+16]
  jbe @@Exit
@@AIsSmaller:
  mov eax, [ebp+16]
  mov edx, [ebp+20]
@@Exit:
end;
{$ELSE}
begin
  if a < b
    then Result := a
    else Result := b;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxMaxI64(const a, b : TnxInt64) : TnxInt64;
{$IFDEF CPUX86}
asm
  mov edx, [ebp+12]
  cmp edx, [ebp+20]
  jl  @@AIsGreater
  mov eax, [ebp+8]
  jg  @@Exit
  cmp eax, [ebp+16]
  jae @@Exit
@@AIsGreater:
  mov eax, [ebp+16]
  mov edx, [ebp+20]
@@Exit:
end;
{$ELSE}
begin
  if a > b
    then Result := a
    else Result := b;
end;
{$ENDIF}
{==============================================================================}



{== BitSet functions ==========================================================}
procedure nxClearAllBits(BitSet : Pointer; BitCount : Integer);
{$IFDEF CPUX86}
asm
  add edx, 7
  shr edx, 3
  xor cl, cl
  jmp [_nxFillChar]
end;
{$ELSE}
begin
  nxFillChar(BitSet^, (BitCount + 7) shr 3, 0);
end;
{$ENDIF}
{------------------------------------------------------------------------------}
procedure nxClearBit(BitSet : Pointer; Bit : Integer);
asm
  {$IFDEF CPUX86}
  btr [eax], edx
  {$ELSE}
  btr [rcx], edx
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function nxIsBitSet(BitSet : Pointer; Bit : Integer) : Boolean;
asm
  {$IFDEF CPUX86}
  mov   ecx,  eax
  xor   eax,  eax
  bt   [ecx], edx
  adc   eax,  eax
  {$ELSE}
  bt   [rcx], edx
  setc al
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
procedure nxSetAllBits(BitSet : Pointer; BitCount : Integer);
{$IFDEF CPUX86}
asm
  add edx, 7
  shr edx, 3
  mov cl, $ff
  jmp [_nxFillChar]
end;
{$ELSE}
begin
  nxFillChar(BitSet^, (BitCount + 7) shr 3, $FF);
end;
{$ENDIF}
{------------------------------------------------------------------------------}
procedure nxSetBit(BitSet : Pointer; Bit : Integer);
asm
  {$IFDEF CPUX86}
  bts [eax], edx
  {$ELSE}
  bts [rcx], edx
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
{function nxFirstSetBit(BitSet : Pointer; BitCount : Integer): Integer; register;
asm
     push  ebx

     xor   ecx, ecx
  @@Loop:
     bsf   ebx, [eax]
     jz   @@AllZero
     add   ecx, ebx
     cmp   edx,ecx
     jnle @@FoundIt
     jmp  @@NotFound
  @@AllZero:
     add   ecx,$20
     add   eax,$04
     cmp   edx,ecx
     jnle @@Loop

  @@NotFound:
     mov   ecx, -1
  @@FoundIt:
     mov   eax, ecx

     pop   ebx
end;}
{------------------------------------------------------------------------------}
function nxFirstClearBit(BitSet : Pointer; BitCount : Integer): Integer; register;
asm
  {$IFDEF CPUX86}
     push  ebx

     xor   ecx, ecx
  @@Loop:
     mov   ebx, [eax]
     not   ebx
     bsf   ebx, ebx
     jz   @@AllZero
     add   ecx, ebx
     cmp   edx,ecx
     jnle @@FoundIt
     jmp  @@NotFound
  @@AllZero:
     add   ecx,$20
     add   eax,$04
     cmp   edx,ecx
     jnle @@Loop

  @@NotFound:
     mov   ecx, -1
  @@FoundIt:
     mov   eax, ecx

     pop   ebx
  {$ELSE}
     mov   r8, rcx

     xor   ecx, ecx
  @@Loop:
     mov   eax, [r8]
     not   eax
     bsf   eax, eax
     jz   @@AllZero
     add   ecx, eax
     cmp   edx, ecx
     jnle @@FoundIt
     jmp  @@NotFound
  @@AllZero:
     add   ecx, $20
     add   r8,  $04
     cmp   edx, ecx
     jnle @@Loop

  @@NotFound:
     mov   ecx, -1
  @@FoundIt:
     mov   eax, ecx
  {$ENDIF}
end;
(*
{------------------------------------------------------------------------------}
procedure nxBitsAnd(Target, Source : PnxByteArray; BitCount : Integer); register;
asm
    push   ebx
    push   ebp

    add    ecx, 7
    and    ecx, $FFFFFFF8
    shr    ecx, 3

    mov    ebp, ecx
    shr    ecx, 2

  @@LoopDWord:
    jcxz  @@DoneDWord
    dec    ecx
    mov    ebx, [edx + ecx * 4]
    and    [eax + ecx * 4], ebx
    jmp   @@LoopDWord

  @@DoneDWord:
    mov    ecx, ebp
    and    ecx, $03
    jcxz  @@DoneAll

    shr    ebp, 2
    lea    eax, [eax + ebp * 4]
    lea    edx, [edx + ebp * 4]

  @@LoopByte:
    dec    ecx
    mov    bl, [edx + ecx]
    and    [eax + ecx], bl
    jcxz  @@DoneAll
    jmp   @@LoopByte

  @@DoneAll:
    pop    ebp
    pop    ebx
end;
{------------------------------------------------------------------------------} *)
procedure nxBitsOr(Target, Source : PnxByteArray; BitCount : Integer); register;
{$IFDEF CPUX86}
asm
    {Target: eax; Source: edx; BitCount: ecx}
    push   ebx
    push   ebp

    add    ecx, 7
    shr    ecx, 3

    mov    ebp, ecx
    shr    ecx, 2

  @@LoopDWord:
    jecxz @@DoneDWord
    dec    ecx
    mov    ebx, [edx + ecx * 4]
    or     [eax + ecx * 4], ebx
    jmp   @@LoopDWord

  @@DoneDWord:
    mov    ecx, ebp
    and    ecx, $03
    jz    @@DoneAll

    shr    ebp, 2
    lea    eax, [eax + ebp * 4]
    lea    edx, [edx + ebp * 4]

  @@LoopByte:
    dec    ecx
    mov    bl, [edx + ecx]
    or     [eax + ecx], bl
    jecxz @@DoneAll
    jmp   @@LoopByte

  @@DoneAll:
    pop    ebp
    pop    ebx
end;
{$ELSE}
asm
    {Target: rcx; Source: rdx; BitCount: r8d}
    mov    rax, rcx

    add    r8d, 7
    shr    r8d, 3

    mov    ecx, r8d
    shr    ecx, 2

    {Target: rax; Source: rdx; BitCount: r8d/ecx}

  @@LoopDWord:
    jecxz @@DoneDWord
    dec    ecx
    mov    r9d, [rdx + rcx * 4]
    or     [rax + rcx * 4], r9d
    jmp   @@LoopDWord

  @@DoneDWord:
    mov    ecx, r8d
    and    ecx, $03
    jz    @@DoneAll

    shr    r8d, 2
    lea    r9, [rax + r8 * 4]
    lea    rdx, [rdx + r8 * 4]

  @@LoopByte:
    dec    ecx
    mov    al, [rdx + rcx]
    or     [r9 + rcx], al
    jecxz @@DoneAll
    jmp   @@LoopByte

  @@DoneAll:
end;
{$ENDIF}
(*
{------------------------------------------------------------------------------}
procedure nxBitsAndNot(Target, Source : PnxByteArray; BitCount : Integer); register;
asm
    push   ebx
    push   ebp

    add    ecx, 7
    and    ecx, $FFFFFFF8
    shr    ecx, 3

    mov    ebp, ecx
    shr    ecx, 2

  @@LoopDWord:
    jcxz  @@DoneDWord
    dec    ecx
    mov    ebx, [edx + ecx * 4]
    not    ebx
    and    [eax + ecx * 4], ebx
    jmp   @@LoopDWord

  @@DoneDWord:
    mov    ecx, ebp
    and    ecx, $03
    jcxz  @@DoneAll

    shr    ebp, 2
    lea    eax, [eax + ebp * 4]
    lea    edx, [edx + ebp * 4]

  @@LoopByte:
    dec    ecx
    mov    bl, [edx + ecx]
    not    bl
    and    [eax + ecx], bl
    jcxz  @@DoneAll
    jmp   @@LoopByte

  @@DoneAll:
    pop    ebp
    pop    ebx
end;
{------------------------------------------------------------------------------}
procedure nxBitsXor(Target, Source : PnxByteArray; BitCount : Integer); register;
asm
    push   ebx
    push   ebp

    add    ecx, 7
    and    ecx, $FFFFFFF8
    shr    ecx, 3

    mov    ebp, ecx
    shr    ecx, 2

  @@LoopDWord:
    jcxz  @@DoneDWord
    dec    ecx
    mov    ebx, [edx + ecx * 4]
    xor    [eax + ecx * 4], ebx
    jmp   @@LoopDWord

  @@DoneDWord:
    mov    ecx, ebp
    and    ecx, $03
    jcxz  @@DoneAll

    shr    ebp, 2
    lea    eax, [eax + ebp * 4]
    lea    edx, [edx + ebp * 4]

  @@LoopByte:
    dec    ecx
    mov    bl, [edx + ecx]
    xor    [eax + ecx], bl
    jcxz  @@DoneAll
    jmp   @@LoopByte

  @@DoneAll:
    pop    ebp
    pop    ebx
end; *)
{==============================================================================}



{== string functions ==========================================================}
function nxAnsiStrIComp(S1, S2: PAnsiChar): Integer;
begin
  {$IFDEF SafeAnsiCompare}
  Result := AnsiStrIComp(AnsiStrLower(S1), AnsiStrLower(S2));
  {$ELSE}
  Result := AnsiStrIComp(S1, S2);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function nxAnsiStrLIComp(S1, S2: PAnsiChar; MaxLen: Cardinal): Integer;
begin
  {$IFDEF SafeAnsiCompare}
  Result := AnsiStrLIComp(AnsiStrLower(S1), AnsiStrLower(S2), MaxLen);
  {$ELSE}
  Result := AnsiStrLIComp(S1, S2, MaxLen);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function nxAnsiStrPos(S1, S2: PAnsiChar): Integer;
begin
//  {$IFDEF SafeAnsiCompare}
//  If AnsiStrPos(AnsiStrLower(S1), AnsiStrLower(S2)) = Nil Then Result := -1 Else Result := 0;
//  {$ELSE}
  If AnsiStrPos(S1, S2) = Nil Then Result := -1 Else Result := 0;
//  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function nxWideStrLower(Str: PWideChar): PWideChar;
begin
  Result := CharLowerW(Str);
end;
{------------------------------------------------------------------------------}
function WideStrPos(const Str1, Str2: PWideChar): PWideChar; assembler;
{$IFDEF CPUX86}
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        OR      EAX,EAX
        JE      @@2
        OR      EDX,EDX
        JE      @@2
        MOV     EBX,EAX
        MOV     EDI,EDX
        XOR     AX,AX
        MOV     ECX,0FFFFFFFFH
        REPNE   SCASW
        NOT     ECX
        DEC     ECX
        JE      @@2
        MOV     ESI,ECX
        MOV     EDI,EBX
        MOV     ECX,0FFFFFFFFH
        REPNE   SCASW
        NOT     ECX
        SUB     ECX,ESI
        JBE     @@2
        MOV     EDI,EBX
        LEA     EBX,[ESI-1]
@@1:    MOV     ESI,EDX
        LODSW
        REPNE   SCASW
        JNE     @@2
        MOV     EAX,ECX
        PUSH    EDI
        MOV     ECX,EBX
        REPE    CMPSW
        POP     EDI
        MOV     ECX,EAX
        JNE     @@1
        LEA     EAX,[EDI-2]
        JMP     @@3
@@2:    XOR     EAX,EAX
@@3:    POP     EBX
        POP     ESI
        POP     EDI
end;
{$ELSE}
var
  MatchStart, LStr1, LStr2: PWideChar;
begin
  Result := nil;
  if (Str1^ = #0) or (Str2^ = #0) then
    Exit;

  MatchStart := Str1;
  while MatchStart^<> #0 do
  begin
    if MatchStart^ = Str2^ then
    begin
      LStr1 := MatchStart+1;
      LStr2 := Str2+1;
      while True do
      begin
        if LStr2^ = #0 then
          Exit(MatchStart);
        if (LStr1^ <> LStr2^) or (LStr1^ = #0) then
          Break;
        Inc(LStr1);
        Inc(LStr2);
      end;
    end;
    Inc(MatchStart);
  end;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function nxWideStrPos(S1, S2: PWideChar): Integer;
begin
  If WideStrPos(S1, S2) = Nil Then Result := -1 Else Result := 0;
end;
{------------------------------------------------------------------------------}
procedure nxStringToWideChar(const Source: UnicodeString; Dest: PWideChar; DestSize: Integer);
begin
  if not Assigned(Dest) then
    Exit;

  DestSize := nxMinI32(DestSize, Length(Source));
  if DestSize > 0 then
    Move(Source[1], Dest[0], DestSize * SizeOf(WideChar));
  Dest[DestSize] := #0;
end;
{------------------------------------------------------------------------------}
function nxCommaizeChL(L : Integer; Ch : Char) : string;
  {-Convert a long Integer to a string with Ch in comma positions}
var
  Temp : string;
  NumCommas, I, Len : Cardinal;
  Neg : Boolean;
begin
  SetLength(Temp, 1);
  Temp[1] := Ch;
  if L < 0 then begin
    Neg := True;
    L := Abs(L);
  end else
    Neg := False;
  Result := IntToStr(L);
  Len := Length(Result);
  NumCommas := (Pred(Len)) div 3;
  for I := 1 to NumCommas do
    {$IFDEF SUPPORTS_DOTTED_UNITNAMES}System.{$ENDIF}Insert(Temp, Result, Succ(Len-(I * 3)));
  if Neg then
    {$IFDEF SUPPORTS_DOTTED_UNITNAMES}System.{$ENDIF}Insert('-', Result, 1);
end;
{------------------------------------------------------------------------------}
procedure nxStrSplit(S          : string;
               const SplitChars : TnxCharSet;
                 var Left       : string;
                 var Right      : string);
var
  i, j: Integer;
begin
  Left := S;
  Right := '';
  for i := 1 to Length(S) do begin
    j := Ord(s[i]);
    if (j < 256) and (AnsiChar(j) in SplitChars) then begin
      Left := Copy(S, 1, I - 1);
      Right := Copy(S, I + 1, High(Integer));
      Break;
    end;
  end;
end;
{==============================================================================}



{== Wide-string functions =====================================================}
function nxCharToWideChar(Ch: AnsiChar): WideChar;
begin
  Result := WideChar(Ord(Ch));
end;
{------------------------------------------------------------------------------}
function nxNullStrLToWideStr(ZStr: PAnsiChar; WS: PWideChar; MaxLen: Integer): PWideChar;
begin
  WS[MultiByteToWideChar(0, 0, ZStr, MaxLen, WS, MaxLen)] := #0;
  Result := WS;
end;
{------------------------------------------------------------------------------}
function nxShStrLToWideStr(const S: TnxShStr; WS: PWideChar; MaxLen: Integer): PWideChar;
begin
  WS[MultiByteToWideChar(0, 0, @S[1], MaxLen, WS, MaxLen + 1)] := #0;
  Result := WS;
end;
{------------------------------------------------------------------------------}
function nxWideCharToChar(WC: WideChar): AnsiChar;
begin
  if WC >= #256 then WC := #0;
  Result := AnsiChar(Ord(WC));
end;
{------------------------------------------------------------------------------}
function nxWideStrLToNullStr(WS: PWideChar; ZStr: PAnsiChar; MaxLen: Integer): PAnsiChar;
begin
  ZStr[WideCharToMultiByte(0, 0, WS, MaxLen, ZStr, MaxLen, nil, nil)] := #0;
  Result := ZStr;
end;
{------------------------------------------------------------------------------}
function nxWideStrLToShStr(WS: PWideChar; MaxLen: Integer): TnxShStr;
var
  s : string;
  a : AnsiString;
begin
  s := WideCharLenToString(WS, MaxLen);
  a := AnsiString(s);
  if Length(a) > 255 then
    SetLength(a, 255);
  Result := a;
end;
{------------------------------------------------------------------------------}
function nxWideStrLToWideStr(aSourceValue, aTargetValue: PWideChar; MaxLength: Integer): PWideChar;
begin
  { Assumption: MaxLength is really # units multiplied by 2, which is how
    a Wide string's length is stored in the table's data dictionary. }
  Move(aSourceValue^, aTargetValue^, MaxLength);
  aTargetValue[MaxLength div 2] := #0;
  Result := aTargetValue;
end;
{------------------------------------------------------------------------------}
procedure nxExpandAnsiToWide(aSource : PAnsiChar;
                             aTarget : PWideChar;
                             aCount  : Cardinal);
{$IFDEF CPUX86}
asm
  AND     ECX, ECX
  JZ      @@Exit
  PUSH    ESI
  MOV     ESI, EAX
  XOR     EAX, EAX
@@Loop:
  MOV     AL, [ESI]
  INC     ESI
  MOV     [EDX], AX
  ADD     EDX, 2
  SUB     ECX, 1
  JNZ     @@Loop
  POP     ESI
@@Exit:
end;
{$ELSE}
begin
  while aCount > 0 do begin
    Word(aTarget^) := Byte(aSource^);
    Inc(aTarget);
    Inc(aSource);
    Dec(aCount);
  end;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
procedure nxSwapByteOrder(aWideString : PWideChar;
                          aCount      : Cardinal);
{$IFDEF CPUX86}
asm
  {aWideString: EAX; aCount: EDX}
  AND   EDX, EDX
  JZ    @@Exit;
  MOV   ECX, EDX
@@Loop:
  MOV   DX, [EAX];
  XCHG  DL, DH
  MOV   [EAX], DX;
  ADD   EAX, 2
  SUB   ECX, 1
  JNZ   @@Loop
@@Exit:
end;
{$ELSE}
asm
  {aWideString: RCX; aCount: EDX}
  AND   EDX, EDX
  JZ    @@Exit;
  MOV   RAX, RCX
  MOV   ECX, EDX
  {aWideString: RAX; aCount: ECX}
@@Loop:
  MOV   DX, [RAX];
  XCHG  DL, DH
  MOV   [RAX], DX;
  ADD   RAX, 2
  SUB   ECX, 1
  JNZ   @@Loop
@@Exit:
end;
{$ENDIF}
{==============================================================================}



{== ByteArray functions ============================================================}
procedure HexStringToByteArray(S : string; ArrayLength : Integer; ByteArray : Pointer);
var
  idx : Integer;
  BArr : PnxByteArray absolute ByteArray;
begin
  for idx := 0 to ArrayLength-1 do begin
    if Odd(Length(S)) then
      S := S + '0';
    if Length(S)>1 then begin
      try
        BArr[idx] := StrToInt('$'+Copy(S, 1, 2));
      except
        on EConvertError do begin
          raise EConvertError.Create(rsInvalidHexChar);
        end;
      end;
      Delete(S, 1, 2);
    end
    else
      BArr[idx] := 0;
  end;
end;
{------------------------------------------------------------------------------}
function nxHexStrToByteArray(const aHexString: string): TnxDynByte8Array;
var
  lStringLen : Integer;
  lBytesLen  : Integer;
  lByteIdx   : Integer;
  lSourcePtr : PChar;
  lTargetPtr : PByte;
const
  caHexLookupNum:   array['0'..'9'] of Byte = (0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
  caHexLookupCharL: array['a'..'f'] of Byte = (10, 11, 12, 13, 14, 15);
  caHexLookupCharU: array['A'..'F'] of Byte = (10, 11, 12, 13, 14, 15);
begin
  Result := nil;
  if aHexString = '' then
    Exit;

  lStringLen := Length(aHexString);

  if Odd(lStringLen) then
    raise EnxBaseException.nxCreate(DBIERR_OUTOFRANGE, @rsHexStringOddLength);

  lBytesLen := lStringLen div 2;
  SetLength(Result, lBytesLen);

  lSourcePtr := PChar(aHexString);
  lTargetPtr := PByte(Result);

  for lByteIdx := 0 to Pred(lBytesLen) do begin
    case lSourcePtr^ of
      '0'..'9': lTargetPtr^ := caHexLookupNum[lSourcePtr^] shl 4;
      'a'..'f': lTargetPtr^ := caHexLookupCharL[lSourcePtr^] shl 4;
      'A'..'F': lTargetPtr^ := caHexLookupCharU[lSourcePtr^] shl 4;
    else
      raise EnxBaseException.nxCreate(DBIERR_INVALIDPARAM, @rsInvalidCharacterInHexString, [(lByteIdx * 2) + 1, lSourcePtr^]);
    end;
    Inc(lSourcePtr);
    case lSourcePtr^ of
      '0'..'9': lTargetPtr^ := lTargetPtr^ or caHexLookupNum[lSourcePtr^];
      'a'..'f': lTargetPtr^ := lTargetPtr^ or caHexLookupCharL[lSourcePtr^];
      'A'..'F': lTargetPtr^ := lTargetPtr^ or caHexLookupCharU[lSourcePtr^];
    else
      raise EnxBaseException.nxCreate(DBIERR_INVALIDPARAM, @rsInvalidCharacterInHexString, [(lByteIdx * 2) + 2, lSourcePtr^]);
    end;
    Inc(lSourcePtr);
    Inc(lTargetPtr);
  end;
end;
{==============================================================================}



{== Hash functions ============================================================}
{$IFOPT Q+}
  {$DEFINE QWasOn}
{$ENDIF}
{$Q-}
function nxCalcELFHash(const Buffer; BufSize : Integer) : TnxWord32;
var
  BufAsBytes : TnxByteArray absolute Buffer;
  G : TnxWord32;
  i : Integer;
begin
  Result := 0;
  for i := 0 to pred(BufSize) do begin
    Result := (Result shl 4) + BufAsBytes[i];
    G := Result and $F0000000;
    if (G <> 0) then
      Result := Result xor (G shr 24);
    Result := Result and (not G);
  end;
end;
{$IFDEF QWasOn}
  {$UNDEF QWasOn}
  {$Q+}
{$ENDIF}
{------------------------------------------------------------------------------}
function nxCalcStrELFHash(const S : AnsiString) : TnxWord32;
begin
  if Length(s) > 0 then
    Result := nxCalcELFHash(S[1], length(S))
  else
    Result := 0;
end;
{------------------------------------------------------------------------------}
function nxCalcStrELFHash(const S : UnicodeString) : TnxWord32;
begin
  if Length(s) > 0 then
    Result := nxCalcELFHash(S[1], length(S) * SizeOf(s[1]))
  else
    Result := 0;
end;
{------------------------------------------------------------------------------}
function nxCalcShStrELFHash(const S : TnxShStr) : TnxWord32;
begin
  Result := nxCalcELFHash(S[1], length(S));
end;
{==============================================================================}

{== file handlings functions ==================================================}
function ValidFileNameHelper(const S : string) : Boolean;
const
  UnacceptableChars : set of AnsiChar =
    ['"', '*', '.', '/', ':', '<', '>', '?', '\', '|'];
var
  i, j : Integer;
  LenS : Integer;
begin
  Result := false;
  LenS := Length(S);
  if 0 < LenS then begin
    for i := 1 to LenS do begin
      j := Ord(S[i]);
      if (j < 256) and (AnsiChar(j) in UnacceptableChars) then
        Exit;
    end;
    Result := true;
  end;
end;
{------------------------------------------------------------------------------}
function nxVerifyExtension(const Ext : string) : Boolean;
begin
  Result := ValidFileNameHelper(Ext);
end;
{------------------------------------------------------------------------------}
function nxVerifyFileName(const FileName : string) : Boolean;
begin
  Result := ValidFileNameHelper(FileName);
end;
{==============================================================================}



{==============================================================================}
function nxFindCmdLineSwitch(const aSwitch: string): Boolean;
begin
  Result := FindCmdLineSwitch(aSwitch, ['-', '/'], True);
end;
{------------------------------------------------------------------------------}
function nxFindCmdLineParam(const aSwitch : string;
                              out aValue  : string)
                                          : Boolean;
begin
  Result := nxFindCmdLineParam(aSwitch, ['-', '/'], True, aValue);
end;
{------------------------------------------------------------------------------}
function nxFindCmdLineParamOptional(const aSwitch : string;
                                      out aValue  : string)
                                                  : Boolean;
begin
  Result := nxFindCmdLineParamOptional(aSwitch, ['-', '/'], True, aValue);
end;
{------------------------------------------------------------------------------}
function nxIntToAnsiStr(aInt: Integer): AnsiString;
begin
  Result := AnsiString(IntToStr(aInt));
end;
{------------------------------------------------------------------------------}
function nxIntToAnsiStr(aInt: Int64): AnsiString;
begin
  Result := AnsiString(IntToStr(aInt));
end;
{------------------------------------------------------------------------------}
function nxAnsiStrToIntDef(const S: AnsiString; Default: Integer): Integer;
begin
  Result := StrToIntDef(string(S), Default);
end;
{------------------------------------------------------------------------------}
function nxWideStrToIntDef(const S: WideString; Default: Integer): Integer;
begin
  Result := StrToIntDef(S, Default);
end;
{------------------------------------------------------------------------------}
function nxIntToWideStr(aInt: Integer): UnicodeString;
begin
  Result := IntToStr(aInt);
end;
{------------------------------------------------------------------------------}
function nxIntToWideStr(aInt: Int64): UnicodeString;
begin
  Result := IntToStr(aInt);
end;
{------------------------------------------------------------------------------}
function nxFindCmdLineParam(const aSwitch     : string;
                            const aChars      : TSysCharSet;
                                  aIgnoreCase : Boolean;
                              out aValue      : string)
                                              : Boolean;
var
  i, j : Integer;
  s    : string;
begin
  Result := False;
  aValue := '';
  for i := 1 to ParamCount do begin
    s := ParamStr(i);
    if Length(s) < 1 then
      continue;
    j := Ord(s[1]);
    if (aChars = []) or ((j < 256) and (AnsiChar(j) in aChars)) then
      if aIgnoreCase then begin
        if AnsiCompareText(Copy(s, 2, Length(aSwitch)), aSwitch) = 0 then begin
          if (length(s)>(length(aSwitch)+2)) and (s[Length(aSwitch) + 2] = ':') then begin
            aValue := Copy(s, Length(aSwitch) + 3, MaxInt);
            Result := True;
          end;
          Exit;
        end;
      end else
        if AnsiCompareStr(Copy(s, 2, Length(aSwitch)), aSwitch) = 0 then begin
          if s[Length(aSwitch) + 2] = ':' then begin
            aValue := Copy(s, Length(aSwitch) + 3, MaxInt);
            Result := True;
          end;
          Exit;
        end;
  end;
end;
{------------------------------------------------------------------------------}
function nxFindCmdLineParamOptional(const aSwitch     : string;
                                    const aChars      : TSysCharSet;
                                          aIgnoreCase : Boolean;
                                      out aValue      : string)
                                                      : Boolean;
var
  i, j : Integer;
  s    : string;
begin
  Result := False;
  aValue := '';
  for i := 1 to ParamCount do begin
    s := ParamStr(i);
    if Length(s) < 1 then
      continue;
    j := Ord(s[1]);
    if (aChars = []) or ((j < 256) and (AnsiChar(j) in aChars)) then
      if aIgnoreCase then begin
        if AnsiCompareText(Copy(s, 2, Length(aSwitch)), aSwitch) = 0 then begin
          Result := True;
          if (length(s)>(length(aSwitch)+2)) and (s[Length(aSwitch) + 2] = ':') then
            aValue := Copy(s, Length(aSwitch) + 3, MaxInt);
          Exit;
        end;
      end else
        if AnsiCompareStr(Copy(s, 2, Length(aSwitch)), aSwitch) = 0 then begin
          Result := True;
          if s[Length(aSwitch) + 2] = ':' then
            aValue := Copy(s, Length(aSwitch) + 3, MaxInt);
          Exit;
        end;
  end;
end;
{------------------------------------------------------------------------------}
function nxFloatToAnsiStr(const Value          : Extended;
                          const FormatSettings : TFormatSettings): AnsiString;
begin
  Result := AnsiString(FloatToStr(Value, FormatSettings));
end;
{------------------------------------------------------------------------------}
function nxFloatToWideStr(const Value          : Extended;
                          const FormatSettings : TFormatSettings): UnicodeString;
begin
  Result := FloatToStr(Value, FormatSettings);
end;
{------------------------------------------------------------------------------}
function nxTimeToAnsiStr(const aDateTime       : TDateTime;
                         const aFormatSettings : TFormatSettings)
                                               : AnsiString;
begin
  Result := AnsiString(TimeToStr(aDateTime, aFormatSettings));
end;
{------------------------------------------------------------------------------}
function nxTimeToWideStr(const aDateTime       : TDateTime;
                         const aFormatSettings : TFormatSettings)
                                               : UnicodeString;
begin
  Result := TimeToStr(aDateTime, aFormatSettings);
end;
{------------------------------------------------------------------------------}
function nxDateToAnsiStr(const aDateTime       : TDateTime;
                         const aFormatSettings : TFormatSettings)
                                               : AnsiString;
begin
  Result := AnsiString(DateToStr(aDateTime, aFormatSettings));
end;
{------------------------------------------------------------------------------}
function nxDateToWideStr(const aDateTime       : TDateTime;
                         const aFormatSettings : TFormatSettings)
                                               : UnicodeString;
begin
  Result := DateToStr(aDateTime, aFormatSettings);
end;
{------------------------------------------------------------------------------}
function nxDateTimeToAnsiStr(const aDateTime       : TDateTime;
                             const aFormatSettings : TFormatSettings)
                                                   : AnsiString;
begin
  Result := AnsiString(DateTimeToStr(aDateTime, aFormatSettings));
end;
{------------------------------------------------------------------------------}
function nxDateTimeToWideStr(const aDateTime       : TDateTime;
                             const aFormatSettings : TFormatSettings)
                                                   : UnicodeString;
begin
  Result := DateTimeToStr(aDateTime, aFormatSettings);
end;
{------------------------------------------------------------------------------}
function nxGUIDToAnsiString(const aGUID: TGUID): AnsiString;
begin
  Result := AnsiString(GUIDToString(aGUID));
end;
{------------------------------------------------------------------------------}
function nxGUIDToWideString(const aGUID: TGUID): UnicodeString;
begin
  Result := UnicodeString(GUIDToString(aGUID));
end;
{------------------------------------------------------------------------------}
function nxIsSystemTable(const aTableName: string): Boolean;
begin
  Result := Pos('$SQL$', aTableName) = 1;
end;
{------------------------------------------------------------------------------}
{$IFNDEF FPC}
function nxGetCSIDLShellFolder(CSIDLFolder : integer) : string;
begin
  SetLength(Result, MAX_PATH);
  SHGetSpecialFolderPath(0, PChar(Result), CSIDLFolder, True);
  SetLength(Result, StrLen(PChar(Result)));
  if (Result <> '') then
    Result := IncludeTrailingBackslash(Result);
end;
{$ENDIF}
{------------------------------------------------------------------------------}

function nxCharIsInSet(AString: string; const ACharPos: Integer; ASet: TSysCharSet): Boolean;
begin
  if ACharPos > Length(AString) then begin
    Result := False;
  end else begin
    Result := AnsiString(AString[ACharPos])[1] in ASet;
  end;
end;

function nxAddLineBreakForMultiLine(const s: string): string;
var
  sl : TStringList;
  i  : Integer;
begin
  sl := TStringList.Create;
  try
    sl.Text := s;
    for i := Pred(sl.Count) downto 0 do
      if Trim(sl[i]) = '' then
        sl.Delete(i)
      else
        break;

    if sl.Count > 1 then begin
      sl.Add('');
      Result := sl.Text;
    end else if sl.Count = 1 then
      Result := TrimRight(sl[0])
    else
      Result := '';
  finally
    sl.Free;
  end;
end;

{$IFDEF DCC12OrLater}
{$WARN IMPLICIT_STRING_CAST OFF}
{$WARN IMPLICIT_STRING_CAST_LOSS OFF}
{$ENDIF}

function nxVarRecAsString(const aVarRec: TVarRec): string;
begin
  with aVarRec do
    case VType of
      vtChar:          Result := VChar;
      vtString:        Result := VString^;
      vtPChar:         Result := VPChar;
      vtWideChar:      Result := VWideChar;
      vtPWideChar:     Result := VPWideChar;
      vtAnsiString:    Result := AnsiString(VAnsiString);
      vtWideString:    Result := WideString(VWideString);
      {$IFDEF DCC12OrLater}
      vtUnicodeString: Result := UnicodeString(VUnicodeString);
      {$ENDIF}
    else
      Result := '';
    end;
end;

function nxVarRecAsAnsiString(const aVarRec: TVarRec): AnsiString;
begin
  with aVarRec do
    case VType of
      vtChar:          Result := VChar;
      vtString:        Result := VString^;
      vtPChar:         Result := VPChar;
      vtWideChar:      Result := VWideChar;
      vtPWideChar:     Result := VPWideChar;
      vtAnsiString:    Result := AnsiString(VAnsiString);
      vtWideString:    Result := WideString(VWideString);
      {$IFDEF DCC12OrLater}
      vtUnicodeString: Result := UnicodeString(VUnicodeString);
      {$ENDIF}
    else
      Result := '';
    end;
end;

function nxVarRecAsUnicodeString(const aVarRec: TVarRec): UnicodeString;
begin
  with aVarRec do
    case VType of
      vtChar:          Result := VChar;
      vtString:        Result := VString^;
      vtPChar:         Result := VPChar;
      vtWideChar:      Result := VWideChar;
      vtPWideChar:     Result := VPWideChar;
      vtAnsiString:    Result := AnsiString(VAnsiString);
      vtWideString:    Result := WideString(VWideString);
      {$IFDEF DCC12OrLater}
      vtUnicodeString: Result := UnicodeString(VUnicodeString);
      {$ENDIF}
    else
      Result := '';
    end;
end;

{$IFDEF DCC12OrLater}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$ENDIF}

function nxPathEncode(const ASrc: string): string;
const
  UnsafeChars = ['\', ':', '*', '#', '%', '<', '>', '+', ' ','[',']'];  {do not localize}
var
  i: Integer;
begin
  Result := '';    {Do not Localize}
  for i := 1 to Length(ASrc) do begin
    if (nxCharIsInSet(ASrc, i, UnsafeChars)) or (ASrc[i] >= #$80) or (ASrc[i] < #32) then begin
      Result := Result + '%' + IntToHex(Ord(ASrc[i]), 2);  {do not localize}
    end else begin
      Result := Result + ASrc[i];
    end;
  end;
end;

function nxAppHomeDirectory(aCommonAppdataSubDir: String) : String;
var
  aName: string;
begin
   if nxFindCmdLineParam('CONFIG', aName) then
  begin
    result := ExcludeTrailingBackslash(aName);
    if (pos(':', aName) < 1) and (Pos('\\', aName) <> 1) then
      result:=ExcludeTrailingBackslash(ExtractFilePath(ParamStr(0))+aName);
    if not ForceDirectories(Result) then
      raise Exception.Create('Could not create App Home Directory: ' + Result);
    Result := IncludeTrailingBackslash(Result);
    exit;
  end;

(*  //..
{$IFNDEF FPC}
  if nxOSIsWindowsVistaOrBetter then begin
    { All users\Application Data }
    Result := nxGetCSIDLShellFolder(CSIDL_COMMON_APPDATA) + aCommonAppdataSubDir;

    if nxFindCmdLineParam('CONFIG', aName) then
      lFileName := aName
    else
      lFileName := nxPathEncode(extractFilePath(paramstr(0)));

    Result:=IncludeTrailingBackslash(Result)+lFileName;

    if not ForceDirectories(Result) then
      raise Exception.Create('Could not create App Home Directory: ' + Result);
    Result := IncludeTrailingBackslash(Result);
  end
  else
{$ENDIF}
  begin
  *)
    Result := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))+ 'ServerData' );
  (*
  end;
  *)

  If   nxFindCmdLineParam( 'SERVICENAME', AName) {$IFNDEF NX_EMBEDDEDSERVER_ONLY} and ( UpperCase( AName )<>UpperCase( nxcDefaultServiceName ) ){$ENDIF}
  then Result := Result + AName + '\';

  If   not ForceDirectories( Result )
  then raise Exception.Create( rsCantCreateAppDir + Result );

end;
{==============================================================================}


{== date/time functions =======================================================}
function nxMakeTimeStamp(const aDate : TnxDate; const aTime : TnxTime) : TTimeStamp;
begin
  Result.Date := aDate;
  Result.Time := aTime;
end;
{==============================================================================}



{==nxRaiseLastOSError==========================================================}
procedure nxRaiseLastOSError(aSilentException: Boolean; const aSource: string; aErrorCode : TnxResult); overload;
begin                                                                      
  if aSilentException then begin
    if GetLastError <> 0 then
      Abort;
  end else
    {$IFNDEF NX_MEMMAN_ONLY}
    raise nxCreateOSError(EnxBaseException, aErrorCode, aSource);
    {$ELSE}
    RaiseLastWin32Error;
    {$ENDIF}
end;
{------------------------------------------------------------------------------}
procedure nxRaiseLastOSError(const aSource: string; aErrorCode : TnxResult = 0); overload;
begin
  nxRaiseLastOSError(false, aSource, aErrorCode);
end;
{------------------------------------------------------------------------------}
procedure nxRaiseLastOSError(aSource: PResStringRec; aErrorCode : TnxResult = 0); overload;
begin
  nxRaiseLastOSError(false, LoadResString(aSource), aErrorCode);
end;
{------------------------------------------------------------------------------}
procedure nxRaiseLastOSError(aSilentException: Boolean; aSource: PResStringRec; aErrorCode : TnxResult = 0); overload;
begin
  nxRaiseLastOSError(aSilentException, LoadResString(aSource), aErrorCode);
end;
{------------------------------------------------------------------------------}
procedure nxRaiseLastOSError; overload;
begin
  nxRaiseLastOSError(false, rsOSErrorSourceUnknown);
end;
{------------------------------------------------------------------------------}
procedure nxRaiseLastOSError(aSilentException: Boolean; aErrorCode : TnxResult = 0); overload;
begin
  nxRaiseLastOSError(aSilentException, rsOSErrorSourceUnknown, aErrorCode);
end;
{==============================================================================}



{===nxOSCheck==================================================================}
function nxOSCheck(RetVal: Boolean): Boolean;
begin
  Result := nxOSCheck(RetVal, @rsOSErrorSourceUnknown);
end;
{------------------------------------------------------------------------------}
function nxOSCheck(RetVal: Boolean; const aSource: PResStringRec): Boolean;
begin
  Result := RetVal;
  if not Result then
    nxOSCheck(RetVal, LoadResString(aSource));
end;
{------------------------------------------------------------------------------}
function nxOSCheck(RetVal: Boolean; const aSource: string): Boolean;
begin
  if not RetVal then
    nxRaiseLastOSError(aSource);
  Result := RetVal;
end;
{==============================================================================}



{===nxHRCheck==================================================================}
function nxHRCheck(RetVal: HRESULT): HRESULT;
begin
  Result := nxHRCheck(RetVal, @rsOSErrorSourceUnknown);
end;
{------------------------------------------------------------------------------}
function nxHRCheck(RetVal: HRESULT; const aSource: PResStringRec): HRESULT;
begin
  Result := RetVal;
  if RetVal < 0 then
    nxHRCheck(RetVal, LoadResString(aSource));
end;
{------------------------------------------------------------------------------}
function nxHRCheck(RetVal: HRESULT; const aSource: string): HRESULT;
begin
  if RetVal < 0 then begin
    SetLastError(Cardinal(RetVal));
    nxRaiseLastOSError(aSource);
  end;
  Result := RetVal;
end;
{==============================================================================}



{===nxOSIsWindowsVistaOrBetter=================================================}
function nxOSIsWindowsVistaOrBetter : Boolean;
begin
  Result :=
    (Win32Platform = VER_PLATFORM_WIN32_NT) and
    (Win32MajorVersion >= 6);
end;
{==============================================================================}


{$IFNDEF NX_MEMMAN_ONLY}
{==============================================================================}
function nxCheckValidIdent(const aIdent       : string;
                                 aErrorCode   : TnxResult;
                                 aAllowEmpty  : Boolean;
                                 aAllowSystem : Boolean)
                                              : TnxResult;
var
  i, j : Integer;
begin
  if aIdent = '' then begin
    if not aAllowEmpty then begin
      Result :=
        EnxBaseException.nxSetMessage(aErrorCode,
          nxcOrgMessageMarker + ' Empty string is not allowed.');
      Exit;
    end;
  end else begin
{$ifndef extendedliterals}
    if (aIdent[1] = ' ') or (aIdent[Length(aIdent)] = ' ') then begin
      Result :=
        EnxBaseException.nxSetMessage(aErrorCode,
          nxcOrgMessageMarker + ' Leading/trailing spaces are not allowed.');
      Exit;
    end;
{$endif}

    if Length(aIdent) > 128 then begin
      Result :=
        EnxBaseException.nxSetMessage(aErrorCode,
          nxcOrgMessageMarker + ' Maximum length of 128 characters has been exceeded.');
      Exit;
    end;

    for i := 1 to Length(aIdent) do begin
      j := Ord(aIdent[i]);
      if (j > 255) or not (AnsiChar(j) in nxcValidIdentChars) then begin
        Result :=
          EnxBaseException.nxSetMessage(aErrorCode,
            nxcOrgMessageMarker + ' "'+aIdent[i]+'" is not a valid character.');
        Exit;
      end;
    end;
    if not aAllowSystem and (aIdent[1] = '$') then begin
      Result :=
        EnxBaseException.nxSetMessage(aErrorCode,
          nxcOrgMessageMarker + ' Reserved Identifier not allowed.');
      Exit;
    end;

  end;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function nxMakeValidIdent(const aIdent : string)
                                       : string; overload;
var
  i, j : Integer;
begin
  Result := aIdent;

  if Length(Result) > 128 then
    SetLength(Result, 128);

  i := 1;
  while (i <= Length(Result)) and (Result[i] = ' ') do begin
    Result[i] := '_';
    Inc(i);
  end;

  while i <= Length(Result) do begin
    j := Ord(Result[i]);
    if (j > 255) or not (AnsiChar(j) in nxcValidIdentChars) then
      Result[i] := '_';
    Inc(i);
  end;

  i := Length(Result);
  while (i >= 1) and (Result[i] = ' ') do begin
    Result[i] := '_';
    Dec(i);
  end;
end;
{------------------------------------------------------------------------------}
function nxMakeValidIdent(const aIdent           : string;
                                aValidIdentChars : TnxCharSet)
                                                 : string; overload;
var
  i, j : Integer;
begin
  Result := aIdent;

  if Length(Result) > 128 then
    SetLength(Result, 128);

  i := 1;
  while (i <= Length(Result)) and (Result[i] = ' ') do begin
    Result[i] := '_';
    Inc(i);
  end;

  while i <= Length(Result) do begin
    j := Ord(Result[i]);
    if (j > 255) or not (AnsiChar(j) in aValidIdentChars) then
      Result[i] := '_';
    Inc(i);
  end;

  i := Length(Result);
  while (i >= 1) and (Result[i] = ' ') do begin
    Result[i] := '_';
    Dec(i);
  end;
end;
{==============================================================================}
{$ENDIF}



{==============================================================================}
procedure nxUnmapViewOfFileAndNil(var p{: Pointer}); register;
{$IFDEF CPUX86}
asm
       xor   ecx, ecx
  lock xchg  [eax], ecx
       test  ecx, ecx
       jz   @@Exit
       push  ecx                    {push return address on the stack again}
       call  UnmapViewOfFile
       test  eax, eax
       jnz  @@Exit
  @@RaiseError:
       jmp   [nxRaiseLastOSErrorSimple]
  @@Exit:
end;
{$ELSE}
var
  q: Pointer;
begin
  q := LockedExchange(Pointer(P), nil);
  if Assigned(q) then
    if not UnmapViewOfFile(q) then
      nxRaiseLastOSErrorSimple;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
procedure nxCloseHandleAndNull(var aHandle: THandle); register;
{$IFDEF CPUX86}
asm
       xor   ecx, ecx
  lock xchg  [eax], ecx
       test  ecx, ecx
       jz   @@Exit
       cmp   ecx, $FFFFFFFF
       je   @@Exit
       push  ecx                    {push return address on the stack again}
       call  CloseHandle
       test  eax, eax
       jnz  @@Exit
  @@RaiseError:
       jmp   [nxRaiseLastOSErrorSimple]
  @@Exit:
end;
{$ELSE}
var
  q: THandle;
begin
  q := LockedExchange(aHandle, 0);
  if (q <> 0) and (q <> (not THandle(0))) then
    if not CloseHandle(q) then
      nxRaiseLastOSErrorSimple;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
procedure nxCloseHandleAndInvalidate(var aHandle: THandle); register;
{$IFDEF CPUX86}
asm
       mov   ecx, $FFFFFFFF
  lock xchg  [eax], ecx
       test  ecx, ecx
       jz   @@Exit
       cmp   ecx, $FFFFFFFF
       je   @@Exit
       push  ecx                    {push return address on the stack again}
       call  CloseHandle
       test  eax, eax
       jnz  @@Exit
  @@RaiseError:
       jmp   [nxRaiseLastOSErrorSimple]
  @@Exit:
end;
{$ELSE}
var
  q: THandle;
begin
  q := LockedExchange(aHandle, (not THandle(0)));
  if (q <> 0) and (q <> (not THandle(0))) then
    if not CloseHandle(q) then
      nxRaiseLastOSErrorSimple;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
procedure nxCloseEventAndSetAndNull(var aHandle: THandle); register;
{$IFDEF CPUX86}
asm
       xor   ecx, ecx
  lock xchg  [eax], ecx
       test  ecx, ecx
       jz   @@Exit
       cmp   ecx, $FFFFFFFF
       je   @@Exit

       push  ecx                    {for CloseHandle}
       push  ecx                    {for SetEvent}

       call  SetEvent
       test  eax, eax
       jz   @@RaiseError

       call  CloseHandle            {aHandle^ is still on the stack}
       test  eax, eax
       jnz  @@Exit

  @@RaiseError:
       jmp   [nxRaiseLastOSErrorSimple]
  @@Exit:
end;
{$ELSE}
var
  q: THandle;
begin
  q := LockedExchange(aHandle, 0);
  if (q <> 0) and (q <> (not THandle(0))) then begin
    if not SetEvent(q) then
      nxRaiseLastOSErrorSimple;
    if not CloseHandle(q) then
      nxRaiseLastOSErrorSimple;
  end;
end;
{$ENDIF}
{==============================================================================}



{===nxSetPrivilege=============================================================}
function nxSetPrivilege(aPrivilegeName: string; aEnable: Boolean): Boolean;
const
  cNilTokenPrivileges : PTokenPrivileges = nil;
var
  TP                          : TTokenPrivileges;
  Token                       : THandle;
  dwRetLen                    : DWord;
begin
  Result := False;

  SetLastError(ERROR_NOT_SUPPORTED);
  if Win32Platform >= VER_PLATFORM_WIN32_NT then
    if OpenProcessToken(GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES, Token) then try
      TP.PrivilegeCount := 1;
      if LookupPrivilegeValue(nil, PChar(aPrivilegeName), TP.Privileges[0].LUID) then begin
        if aEnable then
          TP.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED
        else
          tp.Privileges[0].Attributes := 0;

        dwRetLen := 0;
        Result := AdjustTokenPrivileges(Token, False, TP, 0, cNilTokenPrivileges^, dwRetLen);
        if Result then
          Result := GetLastError = ERROR_SUCCESS;
      end;
    finally
      CloseHandle(Token);
    end;
end;
{==============================================================================}


{==============================================================================}
function nxClassFromPtr(aPtr : Pointer)
                             : TClass;
begin
  Result := nil;
  if IsBadReadPtr(aPtr, 4) then
    Exit;
  aPtr := Pointer(aPtr^);
  {$IFNDEF FPC}
  if IsBadReadPtr( Pointer(TnxNativeInt(aPtr) + vmtSelfPtr) , vmtCreateObject - vmtSelfPtr) then
    Exit;
  if PPointer(TnxNativeInt(aPtr) + vmtSelfPtr)^ <> aPtr then
    Exit;
  {$ELSE}
  if IsBadReadPtr( Pointer(TnxNativeInt(aPtr) + vmtInstanceSize) , vmtToString - vmtInstanceSize) then
    Exit;
  if PPointer(TnxNativeInt(aPtr) + vmtInstanceSize)^ <> aPtr then
    Exit;
  {$ENDIF}
  Result := aPtr;
end;
{------------------------------------------------------------------------------}
function nxIsClassInstance(aPtr   : Pointer;
                       out aClass : TClass)
                                  : Boolean;
var
  lClassPtr: Pointer;
begin
  Result := False;
  aClass := nil;
  if not Assigned(aPtr) then
    Exit;
  if IsBadReadPtr(aPtr, SizeOf(Pointer)) then
    Exit;
  lClassPtr := Pointer(aPtr^);
  if IsBadReadPtr( Pointer(TnxNativeInt(lClassPtr) + vmtSelfPtr) , vmtCreateObject - vmtSelfPtr) then
    Exit;
  if PPointer(TnxNativeInt(lClassPtr) + vmtSelfPtr)^ <> lClassPtr then
    Exit;
  if IsBadReadPtr(aPtr, TClass(lClassPtr).InstanceSize) then
    Exit;
  aClass := lClassPtr;
  Result := True;
end;
{------------------------------------------------------------------------------}
function nxIsClassInstanceOfType(aPtr   : Pointer;
                                 aClass : TClass)
                                        : Boolean;
var
  ClassPtr: TClass;
begin
  Result := nxIsClassInstance(aPtr, ClassPtr) and ClassPtr.InheritsFrom(aClass);
end;                                        
{------------------------------------------------------------------------------}
function nxPtrIsClassOfType(aPtr   : Pointer;
                            aClass : TClass)
                                   : Boolean;
begin
  Result := False;

  aPtr := nxClassFromPtr(aPtr);

  while Assigned(aPtr) do begin

    Result := aPtr = Pointer(aClass);
    if Result then
      Exit;

    aPtr := nxClassFromPtr(PPointer( TnxNativeUInt(aPtr) - TnxNativeUInt( -vmtParent ) )^);
  end;
end;
{==============================================================================}


{===EmulateGlobalMemoryStatusEx================================================}
function EmulateGlobalMemoryStatusEx(var lpBuffer: TMemoryStatusEx): LongBool; stdcall;
var
  MemoryStatus : TMemoryStatus;
begin
  MemoryStatus.dwLength := SizeOf(MemoryStatus);
  GlobalMemoryStatus(MemoryStatus);
  with lpBuffer do begin
    dwMemoryLoad := MemoryStatus.dwMemoryLoad;
    ullTotalPhys := MemoryStatus.dwTotalPhys;
    ullAvailPhys := MemoryStatus.dwAvailPhys;
    ullTotalPageFile := MemoryStatus.dwTotalPageFile;
    ullAvailPageFile := MemoryStatus.dwAvailPageFile;
    ullTotalVirtual  := MemoryStatus.dwTotalVirtual;
    ullAvailVirtual  := MemoryStatus.dwAvailVirtual;
    ullAvailExtendedVirtual := 0;
  end;
  Result := True;
end;
{==============================================================================}



{===InitProcs==================================================================}
procedure InitProcs;
var
  advapi32 : THandle;
  kernel32 : THandle;
begin
  advapi32 := GetModuleHandle('advapi32');
  if advapi32 <> 0 then begin
    Pointer(@_ConvertStringSecurityDescriptorToSecurityDescriptor) :=
      GetProcAddress(advapi32, 'ConvertStringSecurityDescriptorToSecurityDescriptorA');
    Pointer(@_ConvertSecurityDescriptorToStringSecurityDescriptor) :=
      GetProcAddress(advapi32, 'ConvertSecurityDescriptorToStringSecurityDescriptorA');
  end;

  kernel32 := GetModuleHandle('kernel32');
  if kernel32 <> 0 then begin
    Pointer(@_GlobalMemoryStatusEx) :=
      GetProcAddress(kernel32, 'GlobalMemoryStatusEx');
    Pointer(@_GetNLSVersion) :=
      GetProcAddress(kernel32, 'GetNLSVersion');
  end;

  if not Assigned(_GlobalMemoryStatusEx) then
    _GlobalMemoryStatusEx := EmulateGlobalMemoryStatusEx;
end;
{==============================================================================}

threadvar
  _ThreadLocale   : LCID;
  _ThreadCodePage : Integer;

{==============================================================================}
function nxGetThreadCodePage: Integer;

  function LCIDToCodePage(ALcid: LCID): Integer;
  const
    CP_ACP = 0;                                // system default code page
    LOCALE_IDEFAULTANSICODEPAGE = $00001004;   // default ansi code page
  var
    ResultCode: Integer;
    Buffer: array [0..6] of Char;
  begin
    GetLocaleInfo(ALcid, LOCALE_IDEFAULTANSICODEPAGE, Buffer, Length(Buffer));
    Val(Buffer, Result, ResultCode);
    if ResultCode <> 0 then
      Result := -1;
  end;

var
  ThreadLocale: LCID;
begin
  ThreadLocale := GetThreadLocale;
  if ThreadLocale <> _ThreadLocale then begin
    _ThreadCodePage := LCIDToCodePage(ThreadLocale);
    _ThreadLocale := ThreadLocale;
  end;
  Result := _ThreadCodePage;
end;
{==============================================================================}



{==============================================================================}
procedure InitDefaultUserCodePage;

  function LCIDToCodePage(ALcid: LCID): Integer;
  const
    CP_ACP = 0;                                // system default code page
    LOCALE_IDEFAULTANSICODEPAGE = $00001004;   // default ansi code page
  var
    ResultCode: Integer;
    Buffer: array [0..6] of Char;
  begin
    GetLocaleInfo(ALcid, LOCALE_IDEFAULTANSICODEPAGE, Buffer, Length(Buffer));
    Val(Buffer, Result, ResultCode);
    if ResultCode <> 0 then
      Result := CP_ACP;
  end;

begin
  // High bit is set for Win95/98/ME
  if GetVersion and $80000000 <> $80000000 then
  begin
    if Lo(GetVersion) > 4 then
      nxDefaultUserCodePage := 3  // Use CP_THREAD_ACP with Win2K/XP
    else
      // Use thread's current locale with NT4
      nxDefaultUserCodePage := LCIDToCodePage(GetThreadLocale);
  end
  else
    // Convert thread's current locale with Win95/98/ME
    nxDefaultUserCodePage := LCIDToCodePage(GetThreadLocale);
end;
{==============================================================================}

{==============================================================================}
function nxIsValidLocale(LocaleID: DWord): Boolean;
begin
  Result := nxCollationList.IndexOfObject(TObject(LocaleID)) <> -1;
end;

function nxIsValidCodepage(CodepageID: DWord): Boolean;
begin
  Result := nxCodePageList.IndexOfObject(TObject(CodepageID)) <> -1;
end;

var
  _CollationListPadlock : TnxPadlock;
  _CollationList        : TStringList;
  _CollationListTemp    : TStringList;

  _CodePageListPadlock  : TnxPadlock;
  _CodePageList         : TStringList;
  _CodePageListTemp     : TStringList;

function EnumLocalesProc(lpLocaleString: PChar): Integer; stdcall;
var
  Buffer : array[0..255] of char;
  LocID  : LCID;
  i      : Integer;
  S, t   : string;
const
  LOCALE_SSORTNAME              = $00001013; // sort name
begin
  LocID := StrToInt('$' + string(lpLocaleString));
  Result := 1;

  for i := Low(nxLocaleNameMappings) to High(nxLocaleNameMappings) do
    with nxLocaleNameMappings[i] do
      if lnmID = LocID then begin
        _CollationListTemp.AddObject(lnmName, TObject(LocID));
        Exit;
      end;

  GetLocaleInfo(LocID, LOCALE_SLANGUAGE, Buffer, Length(Buffer));
  s := Buffer;
  GetLocaleInfo(LocID, LOCALE_SSORTNAME, Buffer, Length(Buffer));
  t := Buffer;

  if SameText(t, 'Default') then
    t := '';
  if t <> '' then
    s := Trim(s + ' ' + t);
  s := Trim(s);

  _CollationListTemp.AddObject(s, TObject(LocID));
end;

type
  TCpInfoEx = packed record
    MaxCharSize: DWord;
    DefaultChar: array[0..MAX_DEFAULTCHAR-1] of AnsiChar;
    LeadByte : array[0..MAX_LEADBYTES-1] of byte;
    UnicodeDefaultChar: WideChar;
    CodePage: DWord;
    CodePageName: array[0..MAX_PATH-1] of char;
  end;

type
  TGetCPInfoEx = function(CodePage: UINT; Flags: UINT; var lpCPInfo: TCPInfoEx): BOOL; stdcall;
var
  GetCPInfoEx: TGetCPInfoEx;

function ExtractParenthesizedText(const Source: string): string;
var
  i1: Integer;
begin
  i1 := pos('(', Source);
  if i1 = 0 then
    Result := Source
  else begin
    Result := copy(Source, i1 + 1, MaxInt);
    i1 := pos(')', Result);
    if i1 > 0 then
      SetLength(Result, i1 - 1);
  end;
end;

function EnumCodePagesProc(lpLocaleString: PChar): Integer; stdcall;
var
  Buffer: array[0..255] of char;
  CpInfoEx: TCpInfoEx absolute Buffer;
  CpID: UINT;
begin
  CpID := StrToInt(string(lpLocaleString));

  if Assigned(GetCpInfoEx) then begin
    if GetCPInfoEx(CpID, 0, CpInfoEx) then
      _CodePageListTemp.AddObject(ExtractParenthesizedText(CpInfoEx.CodePageName), TObject(CpID));
  end else
    _CodePageListTemp.AddObject(IntToStr(CpID), TObject(CpID));

  Result := 1;
end;

function nxCollationList: TStringList;
const
  LCID_ALTERNATE_SORTS = $00000004; // alternate sort locale ids
begin
  if not Assigned(_CollationList) then begin
    TnxPadlock.CreateAndLock(_CollationListPadlock);
    try
      if not Assigned(_CollationList) then begin
        _CollationListTemp := TStringList.Create;
        _CollationListTemp.Sorted := True;
        EnumSystemLocales(@EnumLocalesProc , LCID_SUPPORTED or LCID_ALTERNATE_SORTS);
        if _CollationListTemp.Count = 0 then
          { some versions of windows don't support LCID_ALTERNATE_SORTS,
            try again without }
          EnumSystemLocales(@EnumLocalesProc , LCID_SUPPORTED);
        _CollationList := _CollationListTemp;
        _CollationListTemp := nil;
      end;
    finally
      _CollationListPadlock.Unlock;
    end;
  end;
  Result := _CollationList;
end;

function nxCodePageList: TStringList;
begin
  if not Assigned(_CodePageList) then begin
    TnxPadlock.CreateAndLock(_CodePageListPadlock);
    try
      if not Assigned(_CodePageList) then begin
        _CodePageListTemp := TStringList.Create;
        _CodePageListTemp.Sorted := True;
        {$IFDEF UNICODE}
        GetCPInfoEx := GetProcAddress(GetModuleHandle('KERNEL32.DLL'), 'GetCPInfoExW');
        {$ELSE}
        GetCPInfoEx := GetProcAddress(GetModuleHandle('KERNEL32.DLL'), 'GetCPInfoExA');
        {$ENDIF}
        EnumSystemCodePages(@EnumCodePagesProc , CP_SUPPORTED);
        _CodePageList := _CodePageListTemp;
        _CodePageListTemp := nil;
      end;
    finally
      _CodePageListPadlock.Unlock;
    end;
  end;
  Result := _CodePageList;
end;

function nxLocaleFromCollation(const CollationName: string): Integer;
begin
  Result := nxCollationList.IndexOf(CollationName);
  if Result <> -1 then
    Result := Integer(nxCollationList.Objects[Result]);
end;

function nxCollationNameFromLocale(LocaleID: DWord): WideString;
var
  i: Integer;
begin
  i := nxCollationList.IndexOfObject(TObject(LocaleID));
  if i = -1 then
    Result := '<Unknown>'
  else
    Result := WideString(nxCollationList[i]);
end;

function nxCodepageFromCharacterSet(const CharacterSetName: string): Integer;
begin
  Result := nxCodePageList.IndexOf(CharacterSetName);
  if Result <> -1 then
    Result := Integer(nxCodePageList.Objects[Result]);
end;

function nxCharacterSetNameFromCodepage(CodepageID: DWord): WideString;
var
  i: Integer;
begin
  i := nxCodePageList.IndexOfObject(TObject(CodepageID));
  if i = -1 then
    Result := '<Unknown>'
  else
    Result := WideString(nxCodePageList[i]);
end;

var
  _FormatSettingListPadlock : TnxPadlock;
  _FormatSettingList        : TnxFastStringListCS;
type
  _FormatSetting = class
    FormatSetting: TFormatSettings;
    constructor Create(aLocaleID: DWord);
  end;

function nxFormatSettingFromLocaleID(LocaleID: DWord): PFormatSettings;
var
  Locale        : string;
  Inx           : Integer;
  FormatSetting : _FormatSetting;
begin
  TnxPadlock.CreateAndLock(_FormatSettingListPadlock, True);
  try

    Locale := IntToStr(LocaleID);

    if not Assigned(_FormatSettingList) then begin
      _FormatSettingList := TnxFastStringListCS.CreateSorted;

      FormatSetting := _FormatSetting.Create(LocaleID);
      _FormatSettingList.AddObject(Locale, FormatSetting);
    end else
      if _FormatSettingList.Find(Locale, Inx) then
        FormatSetting:= _FormatSetting(_FormatSettingList.Objects[Inx])
      else begin
        FormatSetting := _FormatSetting.Create(LocaleID);
        _FormatSettingList.AddObject(Locale, FormatSetting);
      end;

  finally
    _FormatSettingListPadlock.Unlock;
  end;

  Result := @FormatSetting.FormatSetting;
end;


{ _FormatSetting }

constructor _FormatSetting.Create(aLocaleID: DWord);
begin
  GetLocaleFormatSettings(aLocaleID, FormatSetting);
  inherited Create;
end;

procedure FreeFormatSettingList;
var
  i: integer;
begin
  if Assigned(_FormatSettingList) then
    for i := 0 to Pred(_FormatSettingList.Count) do
      _FormatSettingList.Objects[i].Free;
  nxFreeAndNil(_FormatSettingList);
end;

procedure GetNLSVersionCompareString(aLocale: LCID; out aVersionInfo: TNLSVersionInfoEx);
const
  COMPARE_STRING    =  $0001;
begin
  nxFillChar(aVersionInfo, SizeOf(aVersionInfo), 0);
  aVersionInfo.dwEffectiveId := aLocale;
  if Assigned(_GetNLSVersion) then begin
    aVersionInfo.dwNLSVersionInfoSize := SizeOf(TNLSVersionInfoEx);
    if not _GetNLSVersion(COMPARE_STRING, aLocale, Pointer(@aVersionInfo)) then begin
      aVersionInfo.dwNLSVersionInfoSize := SizeOf(TNLSVersionInfo);
      _GetNLSVersion(COMPARE_STRING, aLocale, Pointer(@aVersionInfo));
    end;
  end;

  if not nxIsValidLocale(aVersionInfo.dwEffectiveId) then
    aVersionInfo.dwEffectiveId := 0;
end;

{$IFNDEF DCC16OrLater}
const
  FILE_DEVICE_FILE_SYSTEM         = $00000009;
  FILE_ANY_ACCESS     = 0;
  METHOD_BUFFERED             = 0;
  FSCTL_CREATE_OR_GET_OBJECT_ID =
    (FILE_DEVICE_FILE_SYSTEM shl 16) or (FILE_ANY_ACCESS shl 14) or (48 shl 2) or (METHOD_BUFFERED);
{$ENDIF}

function nxFSGetOrCreateObjectID(const aFile: THandle; out aObjectID: TnxFSObjectID): Boolean;
var
  dwBytesReturned: DWORD;
begin
  Result := False;
  FillChar(aObjectID, SizeOf(aObjectID), 0);

  if aFile <> INVALID_HANDLE_VALUE then
    Result := DeviceIoControl(aFile, FSCTL_CREATE_OR_GET_OBJECT_ID, nil, 0, @aObjectID, SizeOf(aObjectID), dwBytesReturned, nil);
end;

function nxFSGetFileInformation(const  aFile: THandle; var aFileInformation: TByHandleFileInformation): Boolean;
begin
  Result := False;
  if aFile <> INVALID_HANDLE_VALUE then
    Result := GetFileInformationByHandle(aFile, aFileInformation);
end;

{$IFDEF FPC}
function Succeeded(Res: HResult): Boolean;
begin
  Result := Res and $80000000 = 0;
end;
{$ENDIF}

function nxSupportsMulti(const Instance: IInterface; const IIDs: array of TGUID; const Intfs: array of PnxInterface): TnxSupportsMultiResult;
var
  MultiQI     : IMultiQI;
  i           : Integer;
  AnyAssigned : Boolean;
  AnyError    : Boolean;
  MultiQIs    : array of TMULTI_QI;
begin
  AnyAssigned := False;
  AnyError := False;

  Assert(Length(IIDs) = Length(Intfs));
  if (Length(IIDs) > 1) and Supports(Instance, IMultiQI, MultiQI) then begin
    SetLength(MultiQIs, Length(IIDs));
    for i := Low(IIDs) to High(IIDs) do
      with MultiQIs[i] do begin
        IID := @IIDs[i];
        pItf := nil;
        hr := E_UNEXPECTED;
      end;
    if Succeeded(MultiQI.QueryMultipleInterfaces(Length(IIDs), @MultiQIs[0])) then begin
      for i := Low(IIDs) to High(IIDs) do
        with MultiQIs[i] do
          if Succeeded(hr) then begin
            Intfs[i]^ := pItf;
            AnyAssigned := True;
          end else
            AnyError := True;
    end else begin
      AnyError := True;
      for i := Low(IIDs) to High(IIDs) do
        Intfs[i]^ := nil;
    end;
  end else
    for i := Low(IIDs) to High(IIDs) do begin
      if Supports(Instance, IIDs[i], Intfs[i]^) then
        AnyAssigned := True
      else begin
        AnyError := True;
        Intfs[i]^ := nil;
      end;
    end;

  if AnyAssigned then
    if AnyError then
      Result := smrSome
    else
      Result := smrAll
  else
    Result := smrNone;
end;

function nxStringsToArray(aStrings: TStrings): TnxDynStringArray;
var
  i: Integer;
begin
  Result := nil;
  if Assigned(aStrings) and (aStrings.Count > 0) then begin
    SetLength(Result, aStrings.Count);
    for i := Low(Result) to High(Result) do
      Result[i] := aStrings[i];
  end;
end;

procedure ServiceStillBusy;
begin
  if Assigned(_ServiceStillBusy) then
    _ServiceStillBusy;
end;

function nxStrCompW(const Str1, Str2: PWideChar): Integer;
var
  P1, P2: PWideChar;
  C1, C2: WideChar;
begin
  P1 := Str1;
  P2 := Str2;
  while True do
  begin
    C1 := P1^;
    C2 := P2^;

    if (C1 <> C2) or (C1 = #0) then
    begin
      Result := Ord(C1) - Ord(C2);
      Exit;
    end;

    Inc(P1);
    Inc(P2);
  end;
end;

function nxStrICompW(const Str1, Str2: PWideChar): Integer;
var
  P1, P2: PWideChar;
  C1, C2: WideChar;
begin
  P1 := Str1;
  P2 := Str2;
  while True do
  begin
    C1 := P1^;
    C2 := P2^;

    case C1 of
      'a'..'z':
        C1 := WideChar(Word(C1) xor $0020);
    end;

    case C2 of
      'a'..'z':
        C2 := WideChar(Word(C2) xor $0020);
    end;

    if (C1 <> C2) or (C1 = #0) then
    begin
      Result := Ord(C1) - Ord(C2);
      Exit;
    end;

    Inc(P1);
    Inc(P2);
  end;
end;

function nxStrLCompW(const Str1, Str2: PWideChar; MaxLen: Cardinal): Integer;
var
  P1, P2: PWideChar;
  I: Cardinal;
  C1, C2: WideChar;
begin
  P1 := Str1;
  P2 := Str2;
  I := 0;
  while I < MaxLen do
  begin
    C1 := P1^;
    C2 := P2^;

    if (C1 <> C2) or (C1 = #0) then
    begin
      Result := Ord(C1) - Ord(C2);
      Exit;
    end;

    Inc(P1);
    Inc(P2);
    Inc(I);
  end;
  Result := 0;
end;

function nxStrLICompW(const Str1, Str2: PWideChar; MaxLen: Cardinal): Integer;
var
  P1, P2: PWideChar;
  I: Cardinal;
  C1, C2: WideChar;
begin
  P1 := Str1;
  P2 := Str2;
  I := 0;
  while I < MaxLen do
  begin
    C1 := P1^;
    C2 := P2^;

    case C1 of
      'a'..'z':
        C1 := WideChar(Word(C1) xor $0020);
    end;

    case C2 of
      'a'..'z':
        C2 := WideChar(Word(C2) xor $0020);
    end;

    if (C1 <> C2) or (C1 = #0) then
    begin
      Result := Ord(C1) - Ord(C2);
      Exit;
    end;

    Inc(P1);
    Inc(P2);
    Inc(I);
  end;
  Result := 0;
end;

function nxVarArrayLength(const V: Variant; Dim: Integer): Integer;
begin
  Result := Succ(VarArrayHighBound(V, 1) - VarArrayLowBound(V, 1));
end;

function nxNewArray(const aFirstElement: UnicodeString): TnxUnicodeStrings; overload;
begin
  Result := nil;
  if aFirstElement <> '' then begin
    SetLength(Result, 1);
    Result[0] := aFirstElement;
  end;
end;

procedure nxAddToArray(var aArray: TnxUnicodeStrings; const aElement: UnicodeString);
begin
  SetLength(aArray, Succ(Length(aArray)));
  aArray[High(aArray)] := aElement;
end;

function nxRemoveFromArray(var aArray: TnxUnicodeStrings; aIndex: Integer): UnicodeString; overload;
begin
  Result := aArray[aIndex];
  aArray[aIndex] := '';
  if (aIndex < High(aArray))  then begin
    nxMove(aArray[Succ(aIndex)], aArray[aIndex], SizeOf(Pointer) * (High(aArray) - aIndex));
    Pointer(aArray[aIndex]) := nil;
  end;
  SetLength(aArray, Pred(Length(aArray)));
end;

{$IFNDEF DCC12OrLater}
function UTF8EncodeToShortString(const aWide: WideString): ShortString; overload;
begin
  Result := UTF8Encode(aWide);
end;

function UTF8EncodeToShortString(const aAnsi: RawByteString): ShortString; overload;
begin
  Result := UTF8Encode(WideString(aAnsi));
end;

function UTF8ToUnicodeString(const aShort: ShortString): UnicodeString; overload;
begin
  Result := UTF8Decode(UTF8String(aShort));
end;

function UTF8ToUnicodeString(const aAnsi: RawByteString): UnicodeString; overload;
begin
  Result := UTF8Decode(UTF8String(aAnsi));
end;
{$ENDIF DCC12OrLater}

function nxDisconnectObject(const aInstance: InxInterface): HRESULT;
begin
  if Assigned(_nxDisconnectObject) then
    Result := _nxDisconnectObject(aInstance)
  else
    Result := E_NOTIMPL;
end;

procedure nxUnicodeStringsToDelphiStrings(const aUnicodeStrings : TnxUnicodeStrings;
                                                aStrings        : TStrings);
var
  i: Integer;
begin
  aStrings.BeginUpdate;
  try
    aStrings.Clear;
    for i := Low(aUnicodeStrings) to High(aUnicodeStrings) do
      aStrings.Add(string(aUnicodeStrings[i]));
  finally
    aStrings.EndUpdate;
  end;
end;

function nxDelphiStringsToUnicodeStrings(aStrings : TStrings)
                                                  : TnxUnicodeStrings;
var
  i: Integer;
begin
  SetLength(Result, aStrings.Count);
  for i := 0 to Pred(aStrings.Count) do
    Result[i] := UnicodeString(aStrings[i]);
end;

{$IFNDEF DCC12OrLater}
const
  LOCALE_INVARIANT = $7f;
{$ENDIF}

{$MINENUMSIZE 4}

type
  FILE_INFO_BY_HANDLE_CLASS = (
    FileBasicInfo = 0,
    FileStandardInfo = 1,
    FileNameInfo = 2,
    FileRenameInfo = 3,
    FileDispositionInfo = 4,
    FileAllocationInfo = 5,
    FileEndOfFileInfo = 6,
    FileStreamInfo = 7,
    FileCompressionInfo = 8,
    FileAttributeTagInfo = 9,
    FileIdBothDirectoryInfo = 10,
    FileIdBothDirectoryRestartInfo = 11,
    FileIoPriorityHintInfo = 12,
    FileRemoteProtocolInfo = 13,
    FileFullDirectoryInfo = 14,
    FileFullDirectoryRestartInfo = 15,
    FileStorageInfo = 16,
    FileAlignmentInfo = 17,
    FileIdInfo = 18,
    FileIdExtdDirectoryInfo = 19,
    FileIdExtdDirectoryRestartInfo = 20,
    MaximumFileInfoByHandlesClass
  );

type
  TGetFileInformationByHandleExFunc = function(hFile: THandle; FileInformationClass: FILE_INFO_BY_HANDLE_CLASS;
    lpFileInformation: Pointer; dwBufferSize: DWORD): BOOL; stdcall;

var
  GetFileInformationByHandleEx: TGetFileInformationByHandleExFunc = nil;

type
  FILE_ID_128 = record
    Identifier: array [0..15] of Byte;
  end;

  TFileIdInfo = record
    VolumeSerialNumber : UInt64;
    FileId             : FILE_ID_128;
  end;
  PFileIdInfo = ^TFileIdInfo;

procedure LoadGetFileInformationByHandleEx;
var
  Kernel32Handle: HMODULE;
begin
  Kernel32Handle := GetModuleHandle('kernel32.dll');
  if Kernel32Handle <> 0 then
    @GetFileInformationByHandleEx := GetProcAddress(Kernel32Handle, 'GetFileInformationByHandleEx');
end;

function nxGetFileUniqueId(aFile: THandle; out aUniqueId: TnxFileUniqueId): Boolean;
var
  lFileInformation: TByHandleFileInformation;
  lFileIdInfo     : TFileIdInfo;
  lFileId64       : TnxWord64Rec;
begin
  Result := False;
  FillChar(aUniqueId, SizeOf(aUniqueId), 0);

  if GetFileInformationByHandle(aFile, lFileInformation) then begin
    aUniqueId.fuiCreationTime := lFileInformation.ftCreationTime;

    Result := Assigned(GetFileInformationByHandleEx) and
              GetFileInformationByHandleEx(aFile, FileIdInfo, @lFileIdInfo, SizeOf(lFileIdInfo));

    if Result then begin
      aUniqueId.fuiVolumeSerialNumber := lFileIdInfo.VolumeSerialNumber;
      Move(lFileIdInfo.FileId.Identifier, aUniqueId.fuiFileId, SizeOf(TGUID));
    end else begin
      Result := True;
      aUniqueId.fuiVolumeSerialNumber := lFileInformation.dwVolumeSerialNumber;
      lFileId64.iHigh := lFileInformation.nFileIndexHigh;
      lFileId64.iLow := lFileInformation.nFileIndexLow;
      Move(lFileId64, aUniqueId.fuiFileId.D1, SizeOf(lFileId64));
    end;
  end;
end;

{ TnxEncodingHelper }

{$IFDEF DCC16OrLater}
function TnxEncodingHelper.GetBytes(const aString: string; var aBytes; aSize: Integer): Integer;
var
  lLength: Integer;
begin
  lLength := Length(aString);
  if lLength < 1 then
    Exit(0);
  Result := GetBytes(PChar(aString), lLength, PByte(@aBytes), aSize);
end;

function TnxEncodingHelper.GetString(aData: Pointer; aSize: Integer): string;
var
  lMaxCharCount,
  lCharCount      : Integer;
begin
  Result := '';
  if not Assigned(aData) or (aSize < 1) then
    Exit;

  lMaxCharCount := GetMaxCharCount(aSize);
  Assert(lMaxCharCount > 0);
  SetLength(Result, lMaxCharCount);

  lCharCount := GetChars(PByte(aData), aSize, @Result[1], lMaxCharCount);
  if lCharCount < 1 then
    raise EEncodingError.CreateRes(@SNoMappingForUnicodeCharacter);

  if lCharCount < lMaxCharCount then
    SetLength(Result, lCharCount);
end;
{$ENDIF}

{$IFNDEF DCC29OrLater}
function IsBufferValid(const Bytes: Pointer; ByteCount: Integer): Boolean;
// Copyright (c) 2008-2010 Bjoern Hoehrmann <bjoern@hoehrmann.de>
// See http://bjoern.hoehrmann.de/utf-8/decoder/dfa/ for details.
const
  UTF8_ACCEPT = 0;
  UTF8_REJECT = 12;
  utf8d: array [0..255] of Byte = (
    // The first part of the table maps bytes to character classes that
    // to reduce the size of the transition table and create bitmasks.
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
     1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,  9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,
     7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,  7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,
     8,8,2,2,2,2,2,2,2,2,2,2,2,2,2,2,  2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,
    10,3,3,3,3,3,3,3,3,3,3,3,3,4,3,3, 11,6,6,6,5,8,8,8,8,8,8,8,8,8,8,8
  );

  utf8s: array [0..107] of Byte = (
    // The second part is a transition table that maps a combination
    // of a state of the automaton and a character class to a state.
     0,12,24,36,60,96,84,12,12,12,48,72, 12,12,12,12,12,12,12,12,12,12,12,12,
    12, 0,12,12,12,12,12, 0,12, 0,12,12, 12,24,12,12,12,12,12,24,12,24,12,12,
    12,12,12,12,12,12,12,24,12,12,12,12, 12,24,12,12,12,12,12,12,12,24,12,12,
    12,12,12,12,12,12,12,36,12,36,12,12, 12,36,12,12,12,12,12,36,12,36,12,12,
    12,36,12,12,12,12,12,12,12,12,12,12
  );
var
  I: Integer;
  P: PByte;
  Utf8State: Cardinal;
begin
  Utf8State := UTF8_ACCEPT;
  P := PByte(Bytes);
  for I := 0 to ByteCount - 1 do
  begin
    Utf8State := utf8s[Utf8State + utf8d[P^]];
    if Utf8State = UTF8_REJECT then begin
      Result := False;
      Exit;
    end;
    Inc(P);
  end;
  Result := Utf8State = UTF8_ACCEPT;
end;
{$ENDIF}

function nxGetSafeUTF8Length(aData: PByte; aDesiredLength, aMaxLength: TnxMemSize): TnxMemSize;
var
  B     : Byte;
  lData : PnxByteArray absolute aData;
begin
  Result := aDesiredLength;

  // Check if we're at a clean boundary already
  if (Result = 0) or (Result >= aMaxLength) then
    Exit;

  // Check the byte at our desired split point
  B := lData[Result];

  // If next byte is ASCII or start of sequence, we're good
  if (B and $C0) <> $80 then
    Exit;

  // We're in the middle of a multi-byte sequence, backtrack
  while (Result > 0) do begin
    Dec(Result);
    B := lData[Result];

    // Found start of multi-byte sequence
    if (B and $C0) <> $80 then
      Exit;  // Split here, before this sequence
  end;
end;

initialization
  {$IFDEF NX_PUBLICBETA}
  {$I PublicBeta\nxPublicBeta1.inc}
  {$ENDIF}

  LoadGetFileInformationByHandleEx;

  GetLocaleFormatSettings(LOCALE_INVARIANT, nxInvariantFormatSettings);

  if (Win32Platform >= VER_PLATFORM_WIN32_NT) and (Win32MajorVersion >= 5) then begin
    sGlobalNamePrefix := 'Global\';
    sLocalNamePrefix := 'Local\';
  end;

  {$IFDEF CPUX86}
  _nxFillChar := nxllFastFillChar.nxFillChar;
  {$ENDIF}
  InitProcs;
  InitDefaultUserCodePage;
  _ServiceStillBusy := nil;
finalization
  FreeFormatSettingList;
  nxFreeAndNil(_CollationList);
  nxFreeAndNil(_CollationListPadlock);
  nxFreeAndNil(_CodePageList);
  nxFreeAndNil(_CodePageListPadlock);
  nxFreeAndNil(_FormatSettingListPadlock);
end.


