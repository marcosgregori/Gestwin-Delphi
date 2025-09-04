(*
 ------------------------------------------------------------------------------

 ScroogeXHTML 6.4
 RTF to HTML / XHTML converter component for Delphi

 Copyright (c) 1998 - 2013 Michael Justin
 http://www.habarisoft.com/
 ------------------------------------------------------------------------------
*)


unit SxCustomTranslator;

interface

uses
  SxInterfaces,
  SxTypes;

const
  HTML_SPECIAL_ENTITTY_QUOT = '&quot;';
  HTML_SPECIAL_ENTITTY_AMP = '&amp;';
  HTML_SPECIAL_ENTITTY_LT = '&lt;';
  HTML_SPECIAL_ENTITTY_GT = '&gt;';

  (** left margin *)
  LEFT_MARGIN = {$IFNDEF SCROOGE_NO_INDENT}'      '{$ENDIF};

  (** scales the left indent of a paragraph *)
  INDENT_RATIO = 15;

  (** scales the font size conversion from point to 'em' *)
  EM_FACTOR = 12;

  (** number of significant places for 'em' font size *)
  EM_SIGNIFICANT = 2;

  (** scales the font size conversion from point to 'ex' *)
  EX_FACTOR = 14;

  (** number of significant places for 'ex' font size *)
  EX_SIGNIFICANT = 2;

  (** scales the font size conversion from point to '%' *)
  PERCENT_FACTOR = 0.12;

  (** number of significant places for '%' font size *)
  PERCENT_SIGNIFICANT = 3;

type
  (**
   * Abstract translator class.
   *)
  TCustomTranslator = class(TInterfacedObject, ISxTranslator)
  private
    ParOpen: string;
    ParStyle: string;
    FFontSizeScale: TFontSizeScale;

    function GetMarginStyle(const Twips: Integer): string;

  public
    (** Returns lang attribute *)
    function BuildLangAttribute(const Language: string): string;

    (** Returns carriage return / line feed and margin *)
    function IndentCrLf: string;

    (** Returns a CSS style for the given font size. *)
    function GetFontSizeStyle(const Pt: Integer): string;

    (** Returns a sequence of spaces (the left margin). *)
    function GetMargin: string;

    (** Encode Unicode string using UTF-8 *)
    function Encode(const S: SXText): SXText; virtual;

    (**
     * Returns the HTML / XHTML document root element.
     * \par
     * \li for HTML, this is \verbatim <html> \endverbatim
     * \li for XHTML, this is \verbatim <html xmlns="http://www.w3.org/1999/xhtml"> \endverbatim
     *)
    function GetRootElement: string; virtual; abstract;

    (** Returns the correct closing bracket for an empty element.
     * \par
     * Example:
     * \li in HTML, the linebreak element is \verbatim <br> \endverbatim
     * \li in XHTML, the linebreak element is \verbatim <br /> \endverbatim
     * \note
     * \li For HTML, the function returns \verbatim ">" \endverbatim
     * \li For XHTML, the function returns \verbatim " />" \endverbatim
     *)
    function GetCloseEmptyElement: string; virtual; abstract;

    (** Returns text with formatting CSS/HTML/XHTML tags *)
    function FormatElement(const Text: SxText; const CP: TCharacterProperties):
      SxText; virtual; abstract;

    (**
     * Get the DOCTYPE definition.
     *)
    function GetDocType: string; virtual; abstract;

    (**
     * Get the name of the doctype.
     *)
    class function GetDocTypeName: string; virtual; abstract;

    (** returns the start tag for a paragraph element *)
    function GetParagraph(const AdditionalStyle: string; const
      AdditionalParams: string = ''): string;

    (**
     * Converts the paragraph properties to a style definition.
     *)
    function GetParagraphStyle(const PP: TParagraphProperties): string;
      virtual; abstract;

    (**
     * Setter for the 'paragraph open' tag.
     *)
    procedure SetParOpen(const TagAndClass: string; const DefaultStyle:
      string);

    (**
     * Get style parameter. Add the given style.
     *)
    function GetStyleParam(const AdditionalStyle: string): string;

    (**
     * Returns True if the element is supported by the current doctype.
     *)
    function SupportsElement(const ElementName: string): Boolean; virtual;

    (**
     * Returns True if the element supports the given parameter.
     *)
    function SupportsParameter(const ElementName, ParamName: string):
      Boolean; virtual;

    (**
     * Returns a indent and direction style for the paragraph.
     *)
    function GetIndentAndDirectionStyle(const PP: TParagraphProperties):
      string;

    (**
     * Returns text with styles applied for the given character properties.
     *)
    function GetCharacterStyles(const Text: SxText; const CP:
      TCharacterProperties): SxText; dynamic;

    (**
     * Returns True if the document type is a transitional version.
     *)
    function IsTransitional: boolean; virtual; abstract;

    (**
     * Returns True if a DOCTYPE declaration is required (see XHTML 1.1).
     *)
    function IsDocTypeRequired: Boolean; dynamic;

    (**
     * Returns True if it is an XML based Translator.
     *)
    function IsXml: Boolean; virtual; abstract;

    (**
     * Setter for the font size scale.
     *)
    procedure SetFontSizeScale(const FSS: TFontSizeScale);

  end;

implementation

uses
  SysUtils, Math;

{ TCustomTranslator }

function TCustomTranslator.Encode(const S: SXText): SXText;
var
  I: Integer;
  C: WideChar;
begin
  Result := '';
  for I := 1 to Length(S) do
  begin
    C := S[I];
    case C of
      '>': Result := Result + HTML_SPECIAL_ENTITTY_GT;
      '<': Result := Result + HTML_SPECIAL_ENTITTY_LT;
      '&': Result := Result + HTML_SPECIAL_ENTITTY_AMP;
      '"': Result := Result + HTML_SPECIAL_ENTITTY_QUOT;
    else
      begin
        Result := Result + C;
      end;
    end;
  end;
end;

function TCustomTranslator.IndentCrLf: string;
begin
  Result := CrLf + getMargin;
end;

function TCustomTranslator.GetMargin: string;
begin
  Result := LEFT_MARGIN;
end;

function TCustomTranslator.GetParagraph(const AdditionalStyle: string;
  const AdditionalParams: string = ''): string;
begin
  Result := {$IFNDEF SCROOGE_NO_INDENT}'    '{$ENDIF}
    + parOpen + additionalParams + getStyleParam(additionalStyle)
    + '>' + CrLf + GetMargin;
end;

procedure TCustomTranslator.SetParOpen(const TagAndClass, DefaultStyle:
  string);
begin
  parOpen := TagAndClass;
  parStyle := DefaultStyle;
end;

function TCustomTranslator.SupportsElement(const ElementName: string):
  Boolean;
begin
  Result := True;
end;

function TCustomTranslator.GetStyleParam(const AdditionalStyle: string): string;
begin
  Result := parStyle;
  if AdditionalStyle <> '' then
  begin
    if Result <> '' then
      Result := Result + ';';
    Result := Result + AdditionalStyle;
  end;
  if Result <> '' then
    Result := ' style="' + Result + '"';
end;

function TCustomTranslator.GetFontSizeStyle(const Pt: Integer): string;
var
  DecimalSeparator: Char;
begin
  {$IF Declared(FormatSettings)}
  DecimalSeparator := FormatSettings.DecimalSeparator;
  {$ELSE}
  DecimalSeparator := DecimalSeparator;
  {$IFEND}
  case FFontSizeScale of
    // use absolute size in "point" (pt)
    fsPoint: Result := 'font-size:' + IntToStr(pt) + 'pt;';
    // use relative size in "em"
    fsEM: Result := 'font-size:' +
        StringReplace(Format('%.' + IntToStr(EM_SIGNIFICANT) + 'g',
        [Ceil(EM_FACTOR * pt / EM_FACTOR) / EM_FACTOR]),
        DecimalSeparator, '.', []) + 'em;';
    // use relative size in "ex"
    fsEX: Result := 'font-size:' +
        StringReplace(Format('%.' + IntToStr(EX_SIGNIFICANT) + 'g',
        [Ceil(EX_FACTOR * pt / EX_FACTOR) / EM_FACTOR]),
        DecimalSeparator, '.', []) + 'ex;';
    // use relative size in "percent" (%)
    fsPercent: Result := 'font-size:' +
        StringReplace(Format('%.' + IntToStr(PERCENT_SIGNIFICANT) + 'g',
        [Ceil(PERCENT_FACTOR * pt / PERCENT_FACTOR) / PERCENT_FACTOR]),
        DecimalSeparator, '.', []) + '%;';
  end;
end;

function TwipsToPix(const Twips: Integer): Integer;
begin
  if twips < 0 then
    Result := Floor(twips / INDENT_RATIO)
  else
    Result := Ceil(twips / INDENT_RATIO);
end;

function TCustomTranslator.GetMarginStyle(const Twips: Integer): string;
begin
  Result := IntToStr(TwipsToPix(twips)) + 'px;';
end;

function TCustomTranslator.GetIndentAndDirectionStyle(const
  PP: TParagraphProperties): string;
begin
  Result := '';
  if pp.leftindent <> 0 then
    Result := Result + 'margin-left:' + GetMarginStyle(pp.leftindent);
  if pp.rightindent <> 0 then
    Result := Result + 'margin-right:' + GetMarginStyle(pp.rightindent);
  if pp.firstindent <> 0 then
    Result := Result + 'text-indent:' + GetMarginStyle(pp.firstindent);
  // add text direction
  if pp.Direction = diRTL then
    Result := Result + 'direction:rtl;'
end;

function TCustomTranslator.GetCharacterStyles(const Text: SxText; const CP:
  TCharacterProperties): SxText;
var
  FontStyleCSS, CSS: string;
  Lang: string;
begin
  Result := Text;
  if IsTransitional then
    with CP do
    begin
      // supported in Transitional doctypes
      if IsBold then
        Result := '<b>' + Result + '</b>';
      if IsItalic then
        Result := '<i>' + Result + '</i>';
      if IsUnderline then
        Result := '<u>' + Result + '</u>';
      if IsStrike then
        Result := '<strike>' + Result + '</strike>';
      if (VerticalAlignment = vaSub) then
        Result := '<sub>' + Result + '</sub>';
      if (VerticalAlignment = vaSuper) then
        Result := '<sup>' + Result + '</sup>';
    end
  else
  begin
    // not supported in Transitional doctypes
    with CP do
    begin
      FontStyleCSS := '';
      if IsBold then
        FontStyleCSS := FontStyleCSS + 'font-weight:bold;';
      if IsItalic then
        FontStyleCSS := FontStyleCSS + 'font-style:italic;';
      if IsUnderline then
        FontStyleCSS := FontStyleCSS + 'text-decoration:underline;';
      if IsStrike then
        FontStyleCSS := FontStyleCSS + 'text-decoration:line-through;';
      if (VerticalAlignment = vaSub) then
        FontStyleCSS := FontStyleCSS + 'vertical-align:sub;';
      if (VerticalAlignment = vaSuper) then
        FontStyleCSS := FontStyleCSS + 'vertical-align:super;';
    end // with
  end;

  // supported in Strict and Transitional
  // only include the font name is not the default font
  if (CP.FontName <> '') then
    FontStyleCSS := FontStyleCSS + 'font-family:' + CP.fontName + ';';
  // only include the color if it is not the default color
  if (CP.FontColor <> '') then
    FontStyleCSS := FontStyleCSS + 'color:' + CP.Fontcolor + ';';
  // only include the background color if it is not empty
  if (CP.Fontbgcolor <> '') then
    FontStyleCSS := FontStyleCSS + 'background-color:' + CP.Fontbgcolor + ';';
  // only include the highlight color if it is not empty
  if (CP.Fonthlcolor <> '') then
    FontStyleCSS := FontStyleCSS + 'background-color:' + CP.Fonthlcolor + ';';
  // only include the size if it is not the default size
  if (CP.FontSize <> 0) then
    FontStyleCSS := FontStyleCSS + GetFontSizeStyle(CP.Fontsize);
  // left-to-right text
  if (CP.Direction = diRTL) then
    FontStyleCSS := FontStyleCSS + 'direction:rtl;';

  if (FontStyleCSS <> '') then
    CSS := ' style=' + IndentCrLf + '"' + FontStyleCSS + '"';

  if CP.Language <> '' then
    Lang := BuildLangAttribute(CP.Language);

  if (CSS <> '') or (Lang <> '') then
    Result := '<span' + CSS + Lang + '>' + Result + '</span>';
end;

function TCustomTranslator.SupportsParameter(const ElementName: string;
  const ParamName: string): Boolean;
begin
  Result := True;
end;

procedure TCustomTranslator.SetFontSizeScale(const FSS: TFontSizeScale);
begin
  FFontSizeScale := FSS;
end;

function TCustomTranslator.BuildLangAttribute(const Language: string): string;
begin
  Result := '';
  if (Language <> '') then
  begin
    if SupportsParameter('', 'lang') then
      Result := ' lang="' + Language + '"';
    if IsXml then
      Result := ' xml:lang="' + Language + '"' + Result;
  end;
end;

function TCustomTranslator.IsDocTypeRequired: Boolean;
begin
  Result := False;
end;

end.

