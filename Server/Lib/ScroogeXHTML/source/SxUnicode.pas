(*
 ------------------------------------------------------------------------------

 ScroogeXHTML 6.4
 RTF to HTML / XHTML converter component for Delphi

 Copyright (c) 1998 - 2013 Michael Justin
 http://www.habarisoft.com/
 ------------------------------------------------------------------------------
*)


unit SxUnicode;

interface

uses
  SxTypes, // TCharset
  SxInterfaces;

const
  // character sets
  ANSI_CHARSET = 0;
  DEFAULT_CHARSET = 1;
  SYMBOL_CHARSET = 2;
  SHIFTJIS_CHARSET = $80;
  HANGEUL_CHARSET = 129;
  GB2312_CHARSET = 134;
  CHINESEBIG5_CHARSET = 136;
  OEM_CHARSET = 255;
  JOHAB_CHARSET = 130;
  HEBREW_CHARSET = 177;
  ARABIC_CHARSET = 178;
  GREEK_CHARSET = 161;
  TURKISH_CHARSET = 162;
  VIETNAMESE_CHARSET = 163;
  THAI_CHARSET = 222;
  EASTEUROPE_CHARSET = 238;
  RUSSIAN_CHARSET = 204;
  MAC_CHARSET = 77;
  BALTIC_CHARSET = 186;

  // CP = code page values
  // LC = locale values for Linux

  CP_THAI = 874;
  LC_THAI = 'th_TH.TIS-620';

  CP_EASTEUROPE = 1250;
  LC_EASTEUROPE = '?';

  CP_RUSSIAN = 1251;
  LC_RUSSIAN = 'CP1251'; // or ru_RU.CP1251 ?

  CP_ANSI = 1252;
  LC_ANSI = '?'; // ISO-8859-1 ?

  CP_GREEK = 1253;
  LC_GREEK = 'greek'; // or el_GR.ISO-8859-7 ?

  CP_TURKISH = 1254;
  LC_TURKISH = 'turkish'; // ?

  CP_HEBREW = 1255;
  LC_HEBREW = 'CP1255'; // or he_IL.ISO-8859-8 ?

  CP_ARABIC = 1256;
  LC_ARABIC = 'ar_EG.CP1256'; // or 'CP1256' ?

  CP_BALTIC = 1257;
  LC_BALTIC = 'CP1257'; // ?

  CP_VIETNAMESE = 1258;
  LC_VIETNAMESE = 'vi_VN';

type

  (**
   * Unicode converter class.
   *)
  TUnicodeConverter = class(TInterfacedObject, IUnicodeConverter)
{$IFNDEF DOXYGEN_SKIP}
  private
    FCharSet: TCharSet;
    FCodePage: TCodePage;
    FDBCS: Boolean;

    dbcsNibble: shortint;
    dbcsString: AnsiString;

    function GetCharSet: TCharSet;
    procedure SetCharSet(const Value: TCharSet);

    function IsDBCS: Boolean;
    procedure SetDBCS(const Value: Boolean);

    function IntCharToUnicode(const s: AnsiString): SXText;

{$ENDIF}

  public
    constructor Create;

    (**
     * Convert a character to a WideChar character.
     *)
    function CharToUnicode(const C: AnsiChar): SXText;

    (**
     * \property CharSet
     *
     * The Charset property contains the current text node's character set.
     *)
    property CharSet: TCharSet read GetCharSet write SetCharSet;

    (**
     * \property DBCS
     *
     * The DBCS property indicates a double byte character set.
     *)
    property DBCS: Boolean read IsDBCS write SetDBCS;

  end;

function SymbolToUnicode(const A: string): SXText;

function CharsetToCodepage(const c: TCharset): Integer;

implementation

uses
  SxPlatform,
  SysUtils;

const
  SymbolMap: array[0..57] of WideChar = (
    #$0391, //	# GREEK CAPITAL LETTER ALPHA
    #$0392, //	# GREEK CAPITAL LETTER BETA
    #$03A7, //	# GREEK CAPITAL LETTER CHI
    #$0394, //	# GREEK CAPITAL LETTER DELTA
    #$0395, //	# GREEK CAPITAL LETTER EPSILON
    #$03A6, //	# GREEK CAPITAL LETTER PHI
    #$0393, //	# GREEK CAPITAL LETTER GAMMA
    #$0397, //	# GREEK CAPITAL LETTER ETA
    #$0399, //	# GREEK CAPITAL LETTER IOTA
    #$03D1, //	# GREEK THETA SYMBOL
    #$039A, //	# GREEK CAPITAL LETTER KAPPA
    #$039B, //	# GREEK CAPITAL LETTER LAMDA
    #$039C, //	# GREEK CAPITAL LETTER MU
    #$039D, //	# GREEK CAPITAL LETTER NU
    #$039F, //	# GREEK CAPITAL LETTER OMICRON
    #$03A0, //	# GREEK CAPITAL LETTER PI
    #$0398, //	# GREEK CAPITAL LETTER THETA
    #$03A1, //	# GREEK CAPITAL LETTER RHO
    #$03A3, //	# GREEK CAPITAL LETTER SIGMA
    #$03A4, //	# GREEK CAPITAL LETTER TAU
    #$03A5, //	# GREEK CAPITAL LETTER UPSILON
    #$03C2, //	# GREEK SMALL LETTER FINAL SIGMA
    #$03A9, //	# GREEK CAPITAL LETTER OMEGA
    #$039E, //	# GREEK CAPITAL LETTER XI
    #$03A8, //	# GREEK CAPITAL LETTER PSI
    #$0396, //	# GREEK CAPITAL LETTER ZETA
    '*', '*', '*', '*', '*', '*',
    #$03B1, //	# GREEK SMALL LETTER ALPHA
    #$03B2, //	# GREEK SMALL LETTER BETA
    #$03C7, //	# GREEK SMALL LETTER CHI
    #$03B4, //	# GREEK SMALL LETTER DELTA
    #$03B5, //	# GREEK SMALL LETTER EPSILON
    #$03C6, //	# GREEK SMALL LETTER PHI
    #$03B3, //	# GREEK SMALL LETTER GAMMA
    #$03B7, //	# GREEK SMALL LETTER ETA
    #$03B9, //	# GREEK SMALL LETTER IOTA
    #$03D5, //	# GREEK PHI SYMBOL
    #$03BA, //	# GREEK SMALL LETTER KAPPA
    #$03BB, //	# GREEK SMALL LETTER LAMDA
    #$03BC, //	# GREEK SMALL LETTER MU
    #$03BD, //	# GREEK SMALL LETTER NU
    #$03BF, //	# GREEK SMALL LETTER OMICRON
    #$03C0, //	# GREEK SMALL LETTER PI
    #$03B8, //	# GREEK SMALL LETTER THETA
    #$03C1, //	# GREEK SMALL LETTER RHO
    #$03C3, //	# GREEK SMALL LETTER SIGMA
    #$03C4, //	# GREEK SMALL LETTER TAU
    #$03C5, //	# GREEK SMALL LETTER UPSILON
    #$03D6, //	# GREEK PI SYMBOL
    #$03C9, //	# GREEK SMALL LETTER OMEGA
    #$03BE, //	# GREEK SMALL LETTER XI
    #$03C8, //	# GREEK SMALL LETTER PSI
    #$03B6 //	# GREEK SMALL LETTER ZETA
    );

function SymbolToUnicode(const A: string): SXText;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(A) do
  begin
    if (Ord(A[I]) >= 65) and (Ord(A[I]) <= 122) then
    begin
      Result := Result + SymbolMap[Ord(A[I]) - 65]
    end
    else
      Result := Result + WideChar(A[I]);
  end
end;

function CharsetToCodepage;
begin
  case c of
    SYMBOL_CHARSET: result := 0;
    THAI_CHARSET: result := CP_THAI;
    SHIFTJIS_CHARSET: result := 932; // Japanese
    GB2312_CHARSET: result := 936; // Simplified Chinese
    HANGEUL_CHARSET: result := 949; // Korean
    CHINESEBIG5_CHARSET: result := 950; // Traditional Chinese
    EASTEUROPE_CHARSET: result := CP_EASTEUROPE;
    RUSSIAN_CHARSET: result := CP_RUSSIAN;
    ANSI_CHARSET: result := CP_ANSI;
    GREEK_CHARSET: result := CP_GREEK;
    TURKISH_CHARSET: result := CP_TURKISH;
    HEBREW_CHARSET: result := CP_HEBREW;
    ARABIC_CHARSET: result := CP_ARABIC;
    BALTIC_CHARSET: result := CP_BALTIC;
    VIETNAMESE_CHARSET: result := CP_VIETNAMESE;
  else
    {#todo3 use ansicpg }
    result := CP_ANSI
  end;
end;

function TUnicodeConverter.IntCharToUnicode(const S: AnsiString): SXText;
begin
  if FCodePage = 0 then
    // SYMBOL
    Result := SXText(S)
  else
  begin
    Result := StringToSXTextEx(S, FCodePage);
    if Result = '' then
      Result := '?';
  end
end;

{ TUnicodeConverter }

constructor TUnicodeConverter.Create;
begin
  inherited;
  dbcsNibble := 2;
end;

function TUnicodeConverter.GetCharSet: TCharSet;
begin
  result := FCharSet;
end;

function TUnicodeConverter.isDBCS: boolean;
begin
  result := FDBCS;
end;

procedure TUnicodeConverter.SetCharSet(const Value: TCharSet);
begin
  if Value <> CharSet then
  begin
    FCharSet := Value;
    FCodePage := CharsetToCodepage(FCharSet);
    // check if it is a double-byte character set
    FDBCS := FCharSet in [SHIFTJIS_CHARSET, GB2312_CHARSET, HANGEUL_CHARSET,
      CHINESEBIG5_CHARSET];
    if isDBCS then
    begin
      dbcsNibble := 2;
      dbcsString := '';
    end;
  end;
end;

procedure TUnicodeConverter.SetDBCS(const Value: boolean);
begin
  FDBCS := Value;
end;

function TUnicodeConverter.CharToUnicode(const C: AnsiChar): SXText;
begin
  if IsDBCS then
  begin
    if (DbcsNibble = 2) and (C < #$80) then
    begin
      Result := WideChar(C);
    end
    else
    begin
      // S := IntToHex(Integer(C), 2);
      DbcsString := DbcsString + C;
      Dec(DbcsNibble);
      if DbcsNibble = 0 then
      begin
        Result := IntCharToUnicode(DbcsString);
        DbcsNibble := 2;
        DbcsString := '';
      end
      else
        Result := '';
    end
  end
  else
  begin
    if C < #$80 then
      Result := WideChar(C)
    else
      Result := IntCharToUnicode(C);
  end;
end;

end.

