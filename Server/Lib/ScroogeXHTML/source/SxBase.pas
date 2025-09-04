(*
 ------------------------------------------------------------------------------

 ScroogeXHTML 6.4
 RTF to HTML / XHTML converter component for Delphi

 Copyright (c) 1998 - 2013 Michael Justin
 http://www.habarisoft.com/
 ------------------------------------------------------------------------------
*)


unit SxBase;

interface

uses
  SxSimpleDomInterfaces,
  SxInterfaces,
  SxTypes,
  SxOptions,
  Sysutils, // IntToStr / StringReplace / Format
  Classes; // TComponent

const
  (** the component version *)
  VersionString = '6.4';

type
  (** event called for a detected hyperlink *)
  THyperlinkEvent = procedure(Sender: TObject;
    var linkText: SXText) of object;

  (** event called before and after Unicode encoding *)
  TEncodingEvent = procedure(Sender: TObject; const
    TextElement: ISimpleDomTextNode) of object;

  (** event called to log internal informations *)
  TLogEvent = procedure(Sender: TObject;
    const logLevel: TLogLevel;
    const logText: string) of object;

  (** event called to visualize conversion progress *)
  TProgressEvent = procedure(Sender: TObject;
    const Position: Integer;
    var allowContinue: boolean) of object;

  (** event called to substitute font names *)
  TReplaceFontEvent = procedure(Sender: TObject;
    var FontName: string) of object;

  (**
   * The base class for ScroogeXHTML.
   *
   * \ingroup Core Components
   *)
  TSxBase = class(TComponent, ISxWriterOptions)
  private
    FAbortConversion: Boolean;
    FConvertEmptyParagraphs: Boolean;
    FConvertHyperlinks: Boolean;
    FConvertIndent: Boolean;
    FConvertLanguage: Boolean;
    FConvertPictures: Boolean;
    FConvertSpaces: Boolean;
    FConvertToPlainText: Boolean;
    FDebugMode: Boolean;
    FDefaultLanguage: string;
    FDocumentType: TDocumentType;
    FFontConversionOptions: TFontConversionOptions;
    FFormatter: ISxFormatter;
    FHyperlinkList: TStrings;
    FHyperlinkOptions: THyperlinkOptions;
    FIncludeDocType: Boolean;
    FIncludeXMLDeclaration: Boolean;
    FLogLevel: TLogLevel;
    FOnAfterConvert: TNotifyEvent;
    FOnAfterEncode: TEncodingEvent;
    FOnBeforeConvert: TNotifyEvent;
    FOnBeforeEncode: TEncodingEvent;
    FOnHyperlink: THyperlinkEvent;
    FOnLog: TLogEvent;
    FOnProgress: TProgressEvent;
    FOnReplaceFont: TReplaceFontEvent;
    FPictureAdapter: IPictureAdapter;
    FTranslator: ISxTranslator;
    FTabString: string;
    FElementClasses: TStrings;
    FElementStyles: TStrings;
    FFontSizeScale: TFontSizeScale;
    FOptionsHead: TSxOptionsHead;
    FOptionsOptimize: TSxOptionsOptimize;
    FReplaceFonts: TStrings;
    FRtfEnd: Boolean;
    FConvertUsingPrettyIndents: Boolean;

    function GetVersion: string;
    procedure SetVersion(const Value: string);
    procedure SetDocumentType(const Value: TDocumentType);
    procedure SetAbortConversion(const Value: Boolean);

    procedure SetHyperlinkList(Value: TStrings);
    procedure SetReplaceFonts(Value: TStrings);

    procedure SetOptionsHead(const Value: TSxOptionsHead);
    procedure SetOptionsOptimize(const Value: TSxOptionsOptimize);
    (*
    procedure SetHeadTags(Value: TStrings);
    procedure SetMetaTags(Value: TStrings);
    procedure SetStyleSheetInclude(Value: TStrings);
    function GetDefaultFontColor: string;
    procedure SetDefaultFontColor(const Value: string);
    function GetDefaultFontName: string;
    function GetDefaultFontSize: Integer;
    procedure SetDefaultFontName(const Value: string);
    procedure SetDefaultFontSize(const Value: Integer);
    function GetIncludeDefaultFontStyle: Boolean;
    procedure SetIncludeDefaultFontStyle(const Value: Boolean);
    function GetAddOuterHTML: Boolean;
    procedure SetAddOuterHTML(const Value: Boolean);
    function GetMetaTags: TStrings;
    function GetDocumentTitle: string;
    procedure SetDocumentTitle(const Value: string);
    function GetHeadTags: TStrings;
    function GetStyleSheetInclude: TStrings;
    function GetStyleSheetLink: string;
    procedure SetStyleSheetLink(const Value: string);
    function GetMetaAuthor: string;
    procedure SetMetaAuthor(const Value: string);
    function GetMetaContentType: string;
    procedure SetMetaContentType(const Value: string);
    function GetMetaDescription: string;
    procedure SetMetaDescription(const Value: string);
    function GetMetaKeywords: string;
    procedure SetMetaKeywords(const Value: string);
    function GetMetaOptions: TMetaOptions;
    procedure SetMetaOptions(const Value: TMetaOptions);
    *)

    function GetTabString: string;
    function GetOptionsOptimize: TSxOptionsOptimize;
    function GetFontConversionOptions: TFontConversionOptions;
    function GetConvertLanguage: Boolean;
    function GetDefaultLanguage: string;
    procedure SetDebugMode(const Value: Boolean);
    function GetPictureAdapter: IPictureAdapter;
    procedure SetConvertUsingPrettyIndents(const Value: Boolean);

  public
    (** create a new TSxBase instance *)
    constructor Create(AOwner: TComponent); override;

   (**
    * Destroy TSxBase instance.
    *)
    destructor Destroy; override;

    (**
     * Checks properties for invalid settings.
     * Will throw an Exception to indicate bad values.
     *)
    procedure VerifySettings;

    (** check if we are in debug mode *)
{$IFDEF SX_DEBUG}
    function IsDebugging: Boolean;
{$ENDIF}

    (** returns ' /&gt;' or '&gt;' depending on DOCTYPE  *)
    function GetCloseEmptyElement: string;

    (** returns an empty paragraph *)
    function GetEmptyParagraph: string;

    (** returns the opening tag for a paragraph without "&gt;" *)
    function GetParOpen: string;

    (** get the opening tag for an ordered list *)
    function GetOrderedListTag: string;

    (** get the opening tag for an unordered list *)
    function GetUnorderedListTag: string;

    (** returns the class parameter for the given element *)
    function GetElementClassParam(const ElementName: string): string;

    (** returns the style="..." parameter for the given element *)
    function GetElementStyleParam(const ElementName: string): string;

    (** returns the CSS style for the given element *)
    function GetElementStyle(const ElementName: string): string;

    (** returns the line break element *)
    function GetLineBreakTag: string;

    (** call the log event handler and pass the log level and message *)
    procedure Log(const alogLevel: TLogLevel; const logText: SXText);

    (** replace a font name *)
    procedure ReplaceFont(var FontName: string);

    (** replace a hyperlink *)
    procedure ReplaceHyperlink(const TextElement: ISimpleDomTextNode);

    (** convert a text element to HTML / XHTML.
     * This function receives a block of text and its attributes, packaged in
     * a ISimpleDomTextNode object. It will then
     * \li call #OnBeforeEncode (with the text block as parameter)
     * \li if IncludeDefaultFontStyle: clear the default font properties
     * \li do special processing for the 'Symbol' font
     * \li use the TCustomTranslator#encode method to convert the text to UTF-8
     * \li if #ConvertHyperlinks: search and process a hyperlink
     * \li if #ConvertSpaces: replace '  ' with \&nbsp;
     * \li call #OnAfterEncode
     * \li call TCustomTranslator#formatElement
     *)
    function TextElementToXHTML(const TextElement: ISimpleDomTextNode):
      SxText;

    (**
     * \name TSxBase public properties
     * These properties are not visible in the Object Inspector, except OptionsHead and OptionsOptimize.
     *)
    //@{
        (** set this property to True to abort the conversion *)
    property AbortConversion: Boolean read FAbortConversion write
      SetAbortConversion default false;

    (**
     * \property Formatter
     * The formatter
     *)
    property Formatter: ISxFormatter read FFormatter;

    (**
     * The picture adapter.
     *)
    property PictureAdapter: IPictureAdapter read GetPictureAdapter write
      FPictureAdapter;

    (**
     * True -> end of document or conversion aborted
     *)
    property RtfEnd: Boolean read FRtfEnd write FRtfEnd;

    (**
     * The HTML / XHTML Translator.
     *
     * \note To change the Translator, please use the #DocumentType property. *)
    property Translator: ISxTranslator read FTranslator;
    //@)

  published
    (** \name TSxBase published properties
     * These properties are visible in the Object Inspector.
     *)
    //@{
    (**
     * Set this property to True to replace empty paragraphs
     * (where the opening &lt;p&gt; tag is followed by the closing &lt;/p&gt; tag)
     * by a line break tag (&lt;br /&gt;).
     * Default: <em>false</em>
     *)
    property ConvertEmptyParagraphs: Boolean read FConvertEmptyParagraphs write
      FConvertEmptyParagraphs;

    (**
     * Set this property to True to activate hyperlink support.
     * Default: <em>false</em>
     *
     * \note
     * Hyperlinks are detected only if they use formatted blue and underlined in the source document
     * \n
     * If the OnHyperlink event handler is assigned,
     * only the event handler will be executed,
     * and all options defined in the property HyperlinkOptions have no effect.
     *
     *)
    property ConvertHyperlinks: Boolean read FConvertHyperlinks write
      FConvertHyperlinks;

    (**
     * Set this property to True if You want to activate support for left and
     * right paragraph indent. Default: <em>false</em>
     * \note
     * the right indent in the output document is relative to the browser window,
     * if you change the browser window size, the text area will adjust its size
     *)
    property ConvertIndent: Boolean read FConvertIndent write FConvertIndent;

    (**
     * Activates support for language conversion.
     *)
    property ConvertLanguage: Boolean read GetConvertLanguage write
      FConvertLanguage;

    (**
     * Activates support for picture conversion.
     *)
    property ConvertPictures: Boolean read FConvertPictures write
      FConvertPictures;

    (**
     * If two or more spaces are found in sequence, they will be converted to &amp;nbsp;
     *)
    property ConvertSpaces: Boolean read FConvertSpaces write FConvertSpaces;

    (**
     * Convert to plain text.
     *)
    property ConvertToPlainText: Boolean read FConvertToPlainText write
      FConvertToPlainText;

    (**
     * ScroogeXHTML generates output documents with 'pretty printed' formatting
     * by default. Some web browsers however have problems with line breaks
     * between html tags, which cause rendering errors. To provide support for
     * more web browsers, the ConvertUsingPrettyIndents property should be set
     * to false.
     * Default: <em>True</em> for backward compatibility
     * \since 4.4
     *)
    property ConvertUsingPrettyIndents: Boolean read FConvertUsingPrettyIndents write SetConvertUsingPrettyIndents;

    (**
    * In debug mode, the HTML code includes all elements of the RTF document
    * (RTF tokens, control characters...).
    * \li Unknown RTF tokens are red
    * \li Known RTF tokens are green
    * \li Font names and other unprinted text is silver
    * \li Document groups are blue
    * \li Document text is black
    * \note
    * The Debug mode builds very large HTML files.
    *)
    property DebugMode: Boolean read FDebugMode write SetDebugMode;

    (**
     * Use this property to set the default language of the document.
     *)
    property DefaultLanguage: string read GetDefaultLanguage write
      FDefaultLanguage;

    (**
     * The document type. For the selected document type, the component will
     * instantiate an object which implements the ISxTranslator interface
     * and assign it to the public #Translator property.
     * \note
     * Depending on the document type, some HTML/XHTML elements or parameters
     * are not supported.
     *
     *)
    property DocumentType: TDocumentType read FDocumentType write
      SetDocumentType;

    (**
     * A list of name-value pairs which defines the class="..." parameter for
     * the elements 'p', 'br', 'ol', 'ul' and 'li'.
     *)
    property ElementClasses: TStrings read FElementClasses;

    (**
     * A list of name-value pairs which defines the style="..." parameter for
     * the elements 'p', 'br', 'ol', 'ul' and 'li'.
     *)
    property ElementStyles: TStrings read FElementStyles;

    (**
     * Set these options to control which character properties are converted.
     * \li opFontSize enables conversion of font sizes. Default: <em>enabled</em>.
     * \li opFontName enables conversion of font names. See also TCustomScrooge#ReplaceFonts . Default: <em>enabled</em>.
     * \li opFontStyle enables conversion of font styles (bold, italic, underlined, strikeout). Default: <em>enabled</em>.
     * \li opFontColor enables conversion of font colors. Default: <em>enabled</em>
     * \li opFontBGColor enables conversion of background font colors. Default: <em>enabled</em>.
     * \li opFontHLColor enables conversion of highlight font colors. Default: <em>disabled</em>.
     *)
    property FontConversionOptions: TFontConversionOptions read
      GetFontConversionOptions write FFontConversionOptions;

    (**
     * Use this option to set the font size scale. The following units are supported:
     * \li point (pt)
     * \li em
     * \li ex
     * \li percent
     * \note Point is an absolute size scale, all others are relative scales.
     *)
    property FontSizeScale: TFontSizeScale read FFontSizeScale write
      FFontSizeScale;

    (**
     * In this list of name value pairs, the visible link text for all known
     * target addresses is associated with an URL.
     * \note
     * \li HyperlinkList works only with link text if it is formatted blue and underlined.
     * \li #ConvertHyperlinks and #HyperlinkOptions hoUseHyperlinkList option
     * have to be enabled
     *)
    property HyperlinkList: TStrings read FHyperlinkList write SetHyperlinkList;

    (**
     *  This property controls additional options for the hyperlink conversion.
     * \li hoOpenInNewBrowser the target page will be opened in a new browser
     *     window.
     *     This option works only in HTML/XHTML Transitional mode,
     *     the Strict mode does not support the target-parameter.
     *     Default: false
     * \li hoReplaceEMailLinks e-mail links will be replaced
     *     by a 'mailto:' - link.  Default: false
     * \li hoUseHyperlinkList the HyperlinkList will used.
     *     Default: false
     * \li hoRequireHTTP the link will be replaced even if the link text does
     *     not start with 'http:'
     * \note if the #OnHyperlink event handler is assigned to a custom method,
     * all settings of the #HyperlinkOptions property will have no effect.
     * \note The ConvertHyperlink property has to be set to True.
     *)
    property HyperlinkOptions: THyperlinkOptions read FHyperlinkOptions write
      FHyperlinkOptions;

    (**
     * Include DOCTYPE at the beginning of the document.
     * Default: True.
     * \note
     * Some HTML browsers check this element, and use the information in it to
     * verify the document code.
     * \note
     * XHTML 1.1 will always be generated with DOCTYPE.
     *)
    property IncludeDocType: Boolean read FIncludeDocType write FIncludeDocType;

    (**
     * Includes the XML declaration line at the beginning of the document.
     * Default: True
     * \verbatim
     * <?xml version="1.0"?> \endverbatim
     * \note
     * the default encodig for documents which use this declaration is UTF-8
     *)
    property IncludeXMLDeclaration: Boolean read FIncludeXMLDeclaration write
      FIncludeXMLDeclaration;

    (**
     * This property can be used to control the detail level of the logging procedure.
     * Default: logInfo
     *)
    property LogLevel: TLogLevel read FLogLevel write FLogLevel;

    (**
     * \property ReplaceFonts
     * Font names which will be replaced.
     *)
    property ReplaceFonts: TStrings read FReplaceFonts write SetReplaceFonts;

    (**
     * the HTML representation of a TAB charcter
     *)
    property TabString: string read GetTabString write FTabString;

    (**
     * the ScroogeXHTML version
     *)
    property Version: string read GetVersion write SetVersion stored false;

    property OptionsHead: TSxOptionsHead read FOptionsHead write SetOptionsHead;

    property OptionsOptimize: TSxOptionsOptimize read GetOptionsOptimize write
      SetOptionsOptimize;

    //@)

    (** \name TSxBase events *)
    //@{
    (**
     *  This event handler will be called after the conversion.
     *)
    property OnAfterConvert: TNotifyEvent read FOnAfterConvert write
      FOnAfterConvert;

    (**
     * Event handler which will be called after the encoding
     *)
    property OnAfterEncode: TEncodingEvent read FOnAfterEncode write
      FOnAfterEncode;

    (**
     * Event handler which will be called before the conversion
     *)
    property OnBeforeConvert: TNotifyEvent read FOnBeforeConvert write
      FOnBeforeConvert;

    (**
     * Event handler which will be called before the encoding
     *)
    property OnBeforeEncode: TEncodingEvent read FOnBeforeEncode write
      FOnBeforeEncode;

    (**
     * This event handler will be called if a hyperlink is detected.
     * It can be used to modify the hyperlink text.
     * \note if the #OnHyperlink event handler is assigned to a custom method,
     * all settings of the #HyperlinkOptions property will have no effect.
     * \note The ConvertHyperlink property has to be set to True.
     *)
    property OnHyperlink: THyperlinkEvent read FOnHyperlink write FOnHyperlink;

    (**
     * Event handler for log messages
     * \sa #LogLevel
     *)
    property OnLog: TLogEvent read FOnLog write FOnLog;

    (**
     * This event is called periodically during the conversion.
     * It can be used to display the conversion progress.
     * \par
     * Example:
     * \code
      procedure TfrmMain.converterProgress(Sender: TObject;
        const Position: Integer; var continue: Boolean);
      begin
        Label1.Caption := IntToStr(Position)+'%';
        Application.ProcessMessages;
      end;
      \endcode
     *)
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;

    (**
     * This event handler can be used to define a font substition.
     *)
    property OnReplaceFont: TReplaceFontEvent read FOnReplaceFont write
      FOnReplaceFont;

    //@}

  end;

implementation

uses
  SxFormatter, SxUnicode, SxHtmlTranslator, SxXhtmlTranslator;

{------------------------------------------------------------------------------
    Procedure: TSxBase.Create
  Description: create an instance of Scrooge
       Author: Michael Justin
 Date created: 2001-06-14
Date modified: 2002-07-20
      Purpose: do not use 'if csDesigning in ComponentState'
 Known Issues:
 ------------------------------------------------------------------------------}

constructor TSxBase.Create(AOwner: TComponent);
begin
  inherited;

  FFontConversionOptions := [opFontStyle, opFontSize, opFontName, opFontColor,
    opFontBGColor];
  FFormatter := TSxFormatter.Create;
  FHyperlinkList := TStringlist.Create;
  FDocumentType := dtXHTML_10_Strict;
  FIncludeDocType := True;
  FIncludeXMLDeclaration := True;
  FLogLevel := logInfo;
  FTabString := DEFAULT_TAB_STRING;
  FTranslator := TXHTML10StrictTranslator.Create;
  FElementClasses := TStringlist.Create;
  FElementStyles := TStringlist.Create;

  FOptionsHead := TSxOptionsHead.Create(Self);
  FOptionsOptimize := TSxOptionsOptimize.Create(Self);

  FConvertUsingPrettyIndents := True;

  FReplaceFonts := TStringlist.Create;
  FReplaceFonts.Add('Arial=Arial,Helvetica,sans-serif');
  FReplaceFonts.Add('Courier=Courier,monospace');
  FReplaceFonts.Add('Symbol=Symbol');
  FReplaceFonts.Add('Times=Times,serif');
end;

destructor TSxBase.Destroy;
begin
  FHyperlinkList.Clear;
  FHyperlinkList.Free;

  FElementClasses.Clear;
  FElementClasses.Free;

  FElementStyles.Clear;
  FElementStyles.Free;

  FOptionsHead.Free;
  FOptionsOptimize.Free;

  FReplaceFonts.Clear;
  FReplaceFonts.Free;

  inherited;
end;

procedure TSxBase.SetAbortConversion(const Value: Boolean);
begin
  FAbortConversion := Value;
  if Value then
    RtfEnd := True;
end;

{$IFDEF SX_DEBUG}
function TSxBase.IsDebugging: Boolean;
begin
  Result := FDebugMode;
end;
{$ENDIF}

function TSxBase.GetVersion;
begin
  result := VersionString;
end;

procedure TSxBase.SetVersion(const Value: string);
begin
  // nothing to do
end;

procedure TSxBase.SetHyperlinkList(Value: TStrings);
begin
  FHyperlinkList.Assign(Value);
end;

procedure TSxBase.Log(const alogLevel: TLogLevel; const logText:
  SXText);
begin
  if Assigned(FOnLog) and (Ord(alogLevel) >= Ord(FLogLevel)) then
  begin
    FOnlog(Self, alogLevel, logText);
  end;
end;

procedure TSxBase.ReplaceHyperlink(const TextElement:
  ISimpleDomTextNode);
var
  TargetParam: string;
  LinkText: SXText;

  function ReplaceLinkUsingList: Boolean;
  var
    LinkURL: string;
  begin
    Result := False;
    // is the option set to True?
    if not (hoUseHyperlinkList in FHyperlinkOptions) then
      exit;
    // look up the URL for this hyperlink
    LinkURL := FHyperlinkList.Values[LinkText];
    // if we found one
    if LinkURL <> '' then
    begin
      // we can convert the text to a hyperlink here
      Result := True;
      // include hyperlink
      LinkText := '<a href="' + LinkURL + '"' + TargetParam + '>' + LinkText +
        '</a>';
    end
    else
    begin
      Log(logWarning, 'Unknown hyperlink text: "' + LinkText + '"');
    end
  end;

  procedure ReplaceBySimpleLink;
  begin
    if (hoReplaceEMailLinks in FHyperlinkOptions) and (Pos('@', linkText) > 1)
      then
      linkText := '<a href="mailto:' + linkText + '">' + linkText + '</a>'
    else if (Pos(SXText('http:'), linkText) = 1) or not (hoRequireHTTP in
      FHyperlinkOptions) then
      linkText := '<a href="' + linkText + '"' + TargetParam + '>' + linkText +
        '</a>';
  end;

begin

  LinkText := textElement.TextContent;

  if Assigned(FOnHyperlink) then
    // use the user-defined event handler
    FOnHyperlink(Self, LinkText)
  else
  begin
    // open a new browser window?
    if (hoOpenInNewBrowser in FHyperlinkOptions) and
      Translator.SupportsParameter('a', 'target') then
      targetParam := ' target="_blank"'
    else
      targetParam := '';

    // if the link text is not in the hyperlink list,
    if not ReplaceLinkUsingList then
      // create a simple link
      ReplaceBySimpleLink;

  end;

  textElement.TextContent := linkText;
end;

function TSxBase.TextElementToXHTML(const TextElement: ISimpleDomTextNode): SxText;
var
  Attributes: TCharacterProperties;
begin
  // before encoding event handler
  if Assigned(OnBeforeEncode) then
    OnBeforeEncode(Self, TextElement);

  Attributes := TCharacterProperties(TextElement.Data);
  // clear default font properties
  if OptionsOptimize.IncludeDefaultFontStyle then
  begin
    if Attributes.FontName = OptionsOptimize.DefaultFontName then
      Attributes.FontName := '';
    if Attributes.FontColor = OptionsOptimize.DefaultFontColor then
      Attributes.FontColor := '';
    if Attributes.FontSize = OptionsOptimize.DefaultFontSize then
      Attributes.FontSize := 0;
  end;

  // replace symbol
  if Attributes.FontName = 'Symbol' then
  begin
    Attributes.FontName := '';
    TextElement.TextContent := SymbolToUnicode(TextElement.TextContent)
  end;

  // Encode
  if not TextElement.Encoded then
  begin
    TextElement.TextContent := Translator.Encode(TextElement.TextContent);
    TextElement.Encoded := True;
  end;

  // call the hyperlink event handler
  if ConvertHyperlinks and (Attributes.IsUnderline) and (Attributes.FontColor =
    dcBlue) then
  begin
    // call the replace hyperlink event handler or use the default
    ReplaceHyperlink(TextElement);
    // reset the formatting to support CSS definitions
    Attributes.Underline := False;
    Attributes.FontColor := '';
  end;

  // replace '  ' with &nbsp;
  if ConvertSpaces then
  begin
    while Pos(SXText('  '), TextElement.TextContent) > 0 do
      TextElement.TextContent := StringReplace(TextElement.TextContent, '  ',
        '&nbsp;&nbsp;', []);
  end;

  // after encoding event handler
  if Assigned(OnAfterEncode) then
    OnAfterEncode(Self, TextElement);

  // convert text to XHTML
  Result := Translator.FormatElement(TextElement.TextContent, Attributes);

end;

procedure TSxBase.SetDocumentType(const Value: TDocumentType);
begin
  if (FDocumentType <> Value) then
  begin
    FDocumentType := Value;
    case FDocumentType of
      dtHTML3Flex:
        FTranslator := THTML3FlexTranslator.Create;
      dtHTML_401_Transitional:
        FTranslator := THTML401TransitionalTranslator.Create;
      dtHTML_401_Strict:
        FTranslator := THTML401StrictTranslator.Create;
      dtHTML_50:
        FTranslator := THTML50Translator.Create;
      dtXHTML_10_Transitional:
        FTranslator := TXHTML10TransitionalTranslator.Create;
      dtXHTML_10_Strict:
        FTranslator := TXHTML10StrictTranslator.Create;
      dtXHTML_Basic_10:
        FTranslator := TXHTMLBasic10Translator.Create;
      dtXHTML_MP_10:
        FTranslator := TXHTMLMobileProfile10Translator.Create;
      dtXHTML_11:
        FTranslator := TXHTML11Translator.Create;
    end;
  end;
end;

function TSxBase.GetCloseEmptyElement: string;
begin
  result := Translator.GetCloseEmptyElement;
end;

function TSxBase.GetEmptyParagraph: string;
begin
  Result := {$IFNDEF SCROOGE_NO_INDENT}'    '{$ENDIF}
    + GetParOpen + GetElementClassParam('p')
    + GetElementStyleParam('p') + '>' + CrLf
    + {$IFNDEF SCROOGE_NO_INDENT}'    '{$ENDIF}
    + '</p>' + CrLf;
end;

function TSxBase.GetParOpen: string;
begin
  result := '<p';
end;

function TSxBase.GetOrderedListTag: string;
begin
  Result := '<ol' + GetElementClassParam('ol') + GetElementStyleParam('ol') + '>'
end;

function TSxBase.GetUnorderedListTag: string;
begin
  Result := '<ul' + GetElementClassParam('ul') + GetElementStyleParam('ul') + '>'
end;

function TSxBase.GetElementStyle(const ElementName: string):
  string;
begin
  Result := ElementStyles.Values[ElementName];
end;

function TSxBase.GetElementClassParam(const ElementName: string): string;
begin
  Result := ElementClasses.Values[ElementName];
  if Result <> '' then
    Result := ' class="' + Result + '"'
end;

function TSxBase.GetElementStyleParam(const ElementName: string): string;
begin
  Result := ElementStyles.Values[ElementName];
  if Result <> '' then
    Result := ' style="' + Result + '"'
end;

procedure TSxBase.ReplaceFont(var Fontname: string);
var
  I: Integer;
begin
  if Assigned(OnReplaceFont) then
    OnReplaceFont(Self, Fontname)
  else if FReplaceFonts.Count > 0 then
  begin
    for I := 0 to FReplaceFonts.Count - 1 do
    begin
      if Pos(FReplaceFonts.Names[I], Fontname) = 1 then
      begin
        Fontname := FReplaceFonts.Values[FReplaceFonts.Names[i]];
      end
    end
  end
end;

function TSxBase.GetLineBreakTag: string;
begin
  Result := '<br' + GetElementClassParam('br') + GetElementStyleParam('br')
    + Translator.GetCloseEmptyElement;
end;

procedure TSxBase.SetOptionsOptimize(const Value: TSxOptionsOptimize);
begin
  FOptionsOptimize := Value;
end;

function TSxBase.GetOptionsOptimize: TSxOptionsOptimize;
begin
  Result := FOptionsOptimize;
end;

procedure TSxBase.SetOptionsHead(
  const Value: TSxOptionsHead);
begin
  FOptionsHead := Value;
end;

procedure TSxBase.SetConvertUsingPrettyIndents(const Value: Boolean);
begin
  FConvertUsingPrettyIndents := Value;
end;

procedure TSxBase.SetReplaceFonts(Value: TStrings);
begin
  FReplaceFonts.Assign(Value);
end;

function TSxBase.GetTabString: string;
begin
  Result := FTabString;
end;

procedure TSxBase.VerifySettings;
begin
  // hoOpenInNewBrowser allowed?
  if (hoOpenInNewBrowser in FHyperlinkOptions) and
    not Translator.SupportsParameter('a', 'target') then
    raise
      Exception.Create('VerifySettings: hoOpenInNewBrowser is not supported for this document type');

  // Styleheets allowed?
  if ((OptionsHead.StyleSheetInclude.Count > 0) or OptionsOptimize.IncludeDefaultFontStyle)
    and not Translator.SupportsElement('style') then
    raise
      Exception.Create('VerifySettings: style sheets are not supported for this document type');
end;

function TSxBase.GetFontConversionOptions: TFontConversionOptions;
begin
  Result := FFontConversionOptions;
end;

function TSxBase.GetConvertLanguage: Boolean;
begin
  Result := FConvertLanguage;
end;

function TSxBase.GetDefaultLanguage: string;
begin
  Result := FDefaultLanguage;
end;

function TSxBase.GetPictureAdapter: IPictureAdapter;
begin
  if ConvertPictures and not Assigned(FPictureAdapter) then
    raise Exception.Create('Property TSxBase.PictureAdapter is not assigned');
  Result := FPictureAdapter;
end;

procedure TSxBase.SetDebugMode(const Value: Boolean);
begin
{$IFNDEF SX_DEBUG}
  if Value then
    raise Exception.Create('Please compile with symbol SX_DEBUG first');
{$ENDIF}
  FDebugMode := Value;
end;

end.

