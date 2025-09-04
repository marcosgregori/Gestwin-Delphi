(*
 ------------------------------------------------------------------------------

 ScroogeXHTML 6.4
 RTF to HTML / XHTML converter component for Delphi

 Copyright (c) 1998 - 2013 Michael Justin
 http://www.habarisoft.com/
 ------------------------------------------------------------------------------
*)


unit SxMain;

interface

uses
  SxBase, SxTypes;

type
  (**
   * Main conversion class.
   *)
  TSxMain = class(TSxBase)
  private
    (** The main conversion function *)
    function DoConvert(const RTF: RawByteString): UTF8String;

  public
    (** Convert RTF to HTML / XHTML. *)
    function Convert(const RTF: RawByteString): UTF8String;

    (** Build the tags before the HTML body code *)
    function GetLeadingHTMLTags: string;

    (** Build the tags after the HTML body code *)
    function GetTrailingHTMLTags: string;

  end;

implementation

uses
  SxWriter, SxReader, SxPlatform, SxInterfaces, SxOutputWriter,
  Classes, SysUtils;

function TSxMain.DoConvert(const RTF: RawByteString): UTF8String;
var
  OW: TSxOutputWriter;
  ScroogeReader: ISxReader;
  ScroogeWriter: ISxWriter;
  // SB: TStringBuilder;
begin
  Log(logDebug, 'TCustomScrooge.DoConvert ' + IntToStr(Ord(LogLevel)));

  AbortConversion := False;

  // is it a valid RTF file?
  if Copy(RTF, 1, 5) <> '{\rtf' then
  begin
    result := '';
    Log(logError, 'No RTF header found');
    exit;
  end;

  // create a writer instance
  ScroogeWriter := TSxWriter.Create(Self);
  try
    // set the par open tag
    Translator.SetParOpen(GetParOpen + GetElementClassParam('p'),
      GetElementStyle('p'));

    // set the font size scale
    Translator.SetFontSizeScale(self.FontSizeScale);

    // create a reader instance
    ScroogeReader := TSxReader.Create(Self, ScroogeWriter);
    try
      ScroogeReader.ConvertRTFToHTML(RTF);

      OW := TSxOutputWriter.Create;
      try
        OW.Converter := Self;
        OW.DomDocument := ScroogeWriter.DomDocument;
        OW.ConvertEmpty := ConvertEmptyParagraphs and Translator.IsTransitional;
        OW.EmptyPar := GetEmptyParagraph;
        OW.LineTag := GetLineBreakTag;
        OW.ConvertToPlainText := ConvertToPlainText;

        try
          OW.Write;
        except
          on E: Exception do
          begin
            Log(logError, E.Message);
            // TODO raise exception
            // raise
          end;
        end;

        if OptionsHead.AddOuterHTML and not ConvertToPlainText then
        begin
          Result := UTF8Encode(GetLeadingHTMLTags
            + OW.StringResult
            + GetTrailingHTMLTags);
        end
        else
        begin
          Result := UTF8Encode(OW.StringResult);
        end;

      finally
        OW.Free;
      end;

    except
      // reader exception
      on E: Exception do
      begin
        Log(logError, E.Message);
        // TODO raise exception
        // raise
      end;
    end;

  except
    // writer exception
    on E: Exception do
    begin
      Log(logError, E.Message);
      // TODO raise exception
      // raise
    end;
  end;
end;

function TSxMain.Convert(const RTF: RawByteString): UTF8String;
begin
  if Assigned(OnBeforeConvert) then
    OnBeforeConvert(Self);

  Result := DoConvert(RTF);

  if Assigned(OnAfterConvert) then
    OnAfterConvert(Self);
end;

function TSxMain.GetLeadingHTMLTags: string;
var
  SL: TStrings;
  I: Integer;
  LangAttribute: string;

  procedure Add(const S: string);
  begin
    SL.Add(Formatter.Add(S));
  end;

  procedure Indent(const S: string);
  begin
    SL.Add(Formatter.Indent(S));
  end;

  procedure UnIndent(const S: string);
  begin
    SL.Add(Formatter.UnIndent(S));
  end;

  procedure AddMeta(const metaName, content: string);
  begin
    if content <> '' then
      Add('<meta name="' + metaName + '" content="' + content
        + '"' + GetCloseEmptyElement);
  end;

  procedure AddMetaHTTP(const httpEquivalent, content: string);
  begin
    if content <> '' then
      Add('<meta http-equiv="' + httpEquivalent +
        '" content="' + content + '"' + GetCloseEmptyElement);
  end;

  function GetDefaultFontStyleDefinition: string;
  begin
    result := 'BODY {';
    if OptionsOptimize.DefaultFontName <> '' then
      result := result + 'font-family:' + OptionsOptimize.DefaultFontName + ';';
    if OptionsOptimize.DefaultFontSize > 0 then
      result := result + Translator.GetFontSizeStyle(OptionsOptimize.DefaultFontSize);
    if OptionsOptimize.DefaultFontColor <> '' then
      result := result + 'color:' + OptionsOptimize.DefaultFontColor + ';';
    result := result + ' }';
  end;

begin
  SL := TStringList.Create;

  Formatter.IndentLevel := 0;
  Formatter.NewLine := '';

  try
    if IncludeXMLDeclaration and Translator.IsXml then
      Add(XML_DECLARATION);

    if IncludeDocType or Translator.IsDocTypeRequired then
      Add(Translator.GetDocType);

    Add(Translator.GetRootElement);
    Indent('<head>');
    Indent('<title>');
    Indent(OptionsHead.DocumentTitle);
    UnIndent('</title>');

    AddMetaHTTP('content-type', OptionsHead.MetaContentType);

    AddMeta('author', OptionsHead.MetaAuthor);

    if moMetaDate in OptionsHead.MetaOptions then
      AddMeta('date', GetUTCDateTime);

    AddMeta('description', OptionsHead.MetaDescription);

    if moMetaGenerator in OptionsHead.MetaOptions then
      AddMeta('generator', ClassName + ' ' + Self.Version);

    AddMeta('keywords', OptionsHead.MetaKeywords);

    for i := 0 to OptionsHead.MetaTags.count - 1 do
      AddMeta(OptionsHead.MetaTags.names[i], OptionsHead.MetaTags.Values[OptionsHead.MetaTags.names[i]]);

    for i := 0 to OptionsHead.HeadTags.count - 1 do
      Add(OptionsHead.HeadTags[i]);

    if OptionsHead.StyleSheetLink <> '' then
      Add('<link rel="stylesheet" type="text/css" href="' +
        OptionsHead.StyleSheetLink + '"' + GetCloseEmptyElement);

    if (OptionsHead.StyleSheetInclude.Count > 0) or OptionsOptimize.IncludeDefaultFontStyle then
    begin
      if Translator.SupportsElement('style') then
      begin
        Add('<style type="text/css">');
        Add('<!--');
        Formatter.IndentLevel := Formatter.IndentLevel + 1;
        if OptionsOptimize.IncludeDefaultFontStyle then
          Add(GetDefaultFontStyleDefinition);
        for i := 0 to OptionsHead.StyleSheetInclude.Count - 1 do
          Add(OptionsHead.StyleSheetInclude[i]);
{$IFDEF SX_DEBUG}
        if isDebugging then
        begin
          Add('tt {font-family : monospace;font-size : 10pt;}');
          Add('tt.black {color : Black;}');
          Add('tt.blue {color : Blue;}');
          Add('tt.red {color : Red;}');
          Add('tt.green {color : Green;}');
          Add('tt.yellow {color : Yellow;}');
          Add('tt.gray {color : Gray;}');
        end;
{$ENDIF}
        Indent('-->');
        Formatter.IndentLevel := Formatter.IndentLevel - 1;
        UnIndent('</style>');
      end;
    end;

    // lang / xml:lang
    if ConvertLanguage then
      if DefaultLanguage <> '' then
        LangAttribute := Translator.BuildLangAttribute(DefaultLanguage);

    UnIndent('</head>');
    Add('<body' + LangAttribute + '>');

    Result := SL.Text;
  finally
    SL.Free;
  end;
end;

function TSxMain.GetTrailingHTMLTags: string;
begin
  Result := {$IFNDEF SCROOGE_NO_INDENT}'  '{$ENDIF} + '</body>' + CrLf + '</html>'
end;

end.

