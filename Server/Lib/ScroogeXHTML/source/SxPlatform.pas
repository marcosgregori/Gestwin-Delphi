(*
 ------------------------------------------------------------------------------

 ScroogeXHTML 6.4
 RTF to HTML / XHTML converter component for Delphi

 Copyright (c) 1998 - 2013 Michael Justin
 http://www.habarisoft.com/
 ------------------------------------------------------------------------------
*)


unit SxPlatform;

interface

uses
  SxTypes,
  SysUtils {$IFDEF LINUX}, DateUtils {$ELSE}, Windows {$ENDIF};

function StringToSXTextEx(const S: AnsiString; const CodePage: Word):
  SXText;

function GetUTCDateTime: string;

implementation

function TwoDigits(const S: Word): string;
begin
  Result := Format('%2.2d', [S]);
end;

function StringToSXTextEx(const S: AnsiString; const CodePage: Word):
  SXText;
var
  InputLength,
    OutputLength: Integer;
  Tmp: WideString;

begin
  {$IFDEF LINUX}
  // mbtowc();
  {$ELSE}
  InputLength := Length(S);

  OutputLength := MultiByteToWideChar(CodePage, 0, PAnsiChar(S), InputLength, nil,
    0);

  SetLength(Tmp, OutputLength);

  MultiByteToWideChar(CodePage, 0, PAnsiChar(S), InputLength, PWideChar(Tmp),
    OutputLength);

  Result := Tmp;
  {$ENDIF}
end;

// see http://community.borland.com/article/0,1410,16157,00.html
// "Getting the time and date in Universal Time"

function GetUTCDateTime: string;
var
  ST: TSYSTEMTIME;
begin
  {$IFDEF LINUX}
  Result := DateTimeToStr(0);
  {$ELSE}
  GetSystemTime(ST);
  result := IntToStr(ST.wYear) + '-' +
    TwoDigits(ST.wmonth) + '-' +
    TwoDigits(ST.wDay) + '-' + 'T' +
    TwoDigits(ST.wHour) + ':' +
    TwoDigits(ST.wMinute) + ':' +
    TwoDigits(ST.wSecond) + '+00:00'
  {$ENDIF}
end;

end.
