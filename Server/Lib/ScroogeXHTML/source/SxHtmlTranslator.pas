(*
 ------------------------------------------------------------------------------

 ScroogeXHTML 6.4
 RTF to HTML / XHTML converter component for Delphi

 Copyright (c) 1998 - 2013 Michael Justin
 http://www.habarisoft.com/
 ------------------------------------------------------------------------------
*)


unit SxHtmlTranslator;

interface

uses
  SxCustomTranslator, SxTypes;

const
  DOCTYPE_HTML_32 = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">';
  DOCTYPE_HTML_401_TRANSITIONAL =
    '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">';
  DOCTYPE_HTML_401_STRICT =
    '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">';
  DOCTYPE_HTML_50 = '<!DOCTYPE html>';

  HTML_OPEN = '<html>';

type

  (**
   * Generic HTML translator.
   *)
  THTMLTranslator = class(TCustomTranslator)
    (** Returns the document root element. *)
    function GetRootElement: string; override;

    (** Returns ">" *)
    function GetCloseEmptyElement: string; override;

    (** Returns text with formatting CSS/HTML tags *)
    function FormatElement(const Text: SxText; const CP: TCharacterProperties):
      SxText; override;

    (**
     * Returns False because no subclasses are XML based.
     *)
    function IsXml: Boolean; override;

  end;

  (**
   * Translator for HTML 3 / Flex
   *)
  THTML3FlexTranslator = class(THTMLTranslator)
    function GetDocType: string; override;
    class function GetDocTypeName: string; override;
    function GetParagraphStyle(const pp: TParagraphProperties): string;
      override;
    function IsTransitional: Boolean; override;
    function GetCharacterStyles(const Text: SxText; const CP:
      TCharacterProperties): SxText; override;
  end;

  (**
   * Translator for HTML 4.01 Transitional
   *)
  THTML401TransitionalTranslator = class(THTMLTranslator)
    function GetDocType: string; override;
    class function GetDocTypeName: string; override;
    function GetParagraphStyle(const pp: TParagraphProperties): string;
      override;
    function IsTransitional: boolean; override;
  end;

  (**
   * Translator for HTML 4.01 Strict
   *
   *
   *
   *)
  THTML401StrictTranslator = class(THTMLTranslator)
    function GetDocType: string; override;
    class function GetDocTypeName: string; override;
    function GetParagraphStyle(const pp: TParagraphProperties): string;
      override;
    function IsTransitional: boolean; override;
    function SupportsElement(const elementName: string): Boolean; override;
    function SupportsParameter(const elementName, paramName: string):
      Boolean; override;
  end;

  (**
   * Translator for HTML5
   *
   *
   *)
  THTML50Translator = class(THTMLTranslator)
    function GetDocType: string; override;
    class function GetDocTypeName: string; override;
    function GetParagraphStyle(const pp: TParagraphProperties): string;
      override;
    function IsTransitional: boolean; override;
    function SupportsElement(const elementName: string): Boolean; override;
  end;

implementation

uses
  SysUtils;

{ THTMLTranslator }

function THTMLTranslator.GetCloseEmptyElement: string;
begin
  result := '>';
end;

function THTMLTranslator.GetRootElement: string;
begin
  result := HTML_OPEN;
end;

function THTMLTranslator.FormatElement(const Text: SxText;
  const CP: TCharacterProperties): SxText;
begin
  Result := GetCharacterStyles(Text, CP);
end;

function THTMLTranslator.IsXml: Boolean;
begin
  Result := False;
end;

{ THTML3FlexTranslator }

function THTML3FlexTranslator.GetCharacterStyles(const Text: SxText;
  const CP: TCharacterProperties): SxText;
var
  FontStyleCSS: string;
begin
  Result := Text;

  // supported in Transitional doctypes
  if CP.IsBold then
    Result := '<b>' + Result + '</b>';
  if CP.IsItalic then
    Result := '<i>' + Result + '</i>';
  if CP.IsUnderline then
    Result := '<u>' + Result + '</u>';
  if CP.IsStrike then
    Result := '<strike>' + Result + '</strike>';
  if (CP.VerticalAlignment = vaSub) then
    Result := '<sub>' + Result + '</sub>';
  if (CP.VerticalAlignment = vaSuper) then
    Result := '<sup>' + Result + '</sup>';

  // only include the font name is not the default font
  if (CP.FontName <> '') then
    FontStyleCSS := FontStyleCSS + ' face="' + CP.FontName + '"';
  // only include the color if it is not the default color
  if (CP.FontColor <> '') then
    FontStyleCSS := FontStyleCSS + ' color="' + CP.FontColor + '"';
  if (CP.FontSize <> 0) then
    FontStyleCSS := FontStyleCSS + ' size="' + IntToStr(CP.Fontsize) + '"';

  if FontStyleCSS <> '' then
    Result := '<font' + FontStyleCSS + '>' + Result + '</font>';
end;

function THTML3FlexTranslator.GetDocType: string;
begin
  Result := DOCTYPE_HTML_32;
end;

class function THTML3FlexTranslator.GetDocTypeName: string;
begin
  Result := 'HTML 3.2/Flex';
end;

function THTML3FlexTranslator.GetParagraphStyle(
  const pp: TParagraphProperties): string;
begin
  Result := GetParagraph(GetIndentAndDirectionStyle(pp));
end;

function THTML3FlexTranslator.IsTransitional: Boolean;
begin
  Result := False;
end;

{ THTML401TransitionalTranslator }

function THTML401TransitionalTranslator.GetDocType: string;
begin
  Result := DOCTYPE_HTML_401_TRANSITIONAL;
end;

class function THTML401TransitionalTranslator.GetDocTypeName: string;
begin
  Result := 'HTML 4.01 Transitional';
end;

function THTML401TransitionalTranslator.GetParagraphStyle(
  const pp: TParagraphProperties): string;
var
  indent: string;
begin
  indent := GetIndentAndDirectionStyle(pp);
  case pp.Alignment of
    paRightJustify: result := getParagraph(indent, ' align="right"');
    paCenter: result := getParagraph(indent, ' align="center"');
    paJustify: result := getParagraph(indent, ' align="justify"');
  else
    result := getParagraph(indent);
  end
end;

function THTML401TransitionalTranslator.IsTransitional: boolean;
begin
  Result := True;
end;

{ THTML401StrictTranslator }

function THTML401StrictTranslator.GetDocType: string;
begin
  Result := DOCTYPE_HTML_401_STRICT;
end;

class function THTML401StrictTranslator.GetDocTypeName: string;
begin
  Result := 'HTML 4.01 Strict';
end;

function THTML401StrictTranslator.GetParagraphStyle(
  const pp: TParagraphProperties): string;
var
  indentAndDirection: string;
begin
  indentAndDirection := GetIndentAndDirectionStyle(pp);
  case pp.Alignment of
    paRightJustify: result := getParagraph('text-align:right;' +
        indentAndDirection);
    paCenter: result := getParagraph('text-align:center;' + indentAndDirection);
    paJustify: result := getParagraph('text-align:justify;' +
        indentAndDirection);
  else
    result := getParagraph(indentAndDirection);
  end
end;

function THTML401StrictTranslator.IsTransitional: boolean;
begin
  Result := False;
end;

function THTML401StrictTranslator.SupportsElement(const
  elementName: string): Boolean;
begin
  result := elementName <> 'br';
end;

function THTML401StrictTranslator.SupportsParameter(
  const elementName: string; const paramName: string): Boolean;
begin
  if (elementName = 'a') and (paramName = 'target') then
    result := false
  else
    result := true;
end;

{ THTML50TransitionalTranslator }

function THTML50Translator.GetDocType: string;
begin
  Result := DOCTYPE_HTML_50;
end;

class function THTML50Translator.GetDocTypeName: string;
begin
  Result := 'HTML5';
end;

function THTML50Translator.GetParagraphStyle(
  const pp: TParagraphProperties): string;
var
  indentAndDirection: string;
begin
  indentAndDirection := GetIndentAndDirectionStyle(pp);
  case pp.Alignment of
    paRightJustify: result := getParagraph('text-align:right;' +
        indentAndDirection);
    paCenter: result := getParagraph('text-align:center;' + indentAndDirection);
    paJustify: result := getParagraph('text-align:justify;' +
        indentAndDirection);
  else
    result := getParagraph(indentAndDirection);
  end
end;

function THTML50Translator.IsTransitional: boolean;
begin
  Result := False;
end;

function THTML50Translator.SupportsElement(
  const elementName: string): Boolean;
begin
  Result := True;
end;

end.

