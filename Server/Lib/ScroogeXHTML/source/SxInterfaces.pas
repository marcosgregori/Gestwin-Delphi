(*
 ------------------------------------------------------------------------------

 ScroogeXHTML 6.4
 RTF to HTML / XHTML converter component for Delphi

 Copyright (c) 1998 - 2013 Michael Justin
 http://www.habarisoft.com/
 ------------------------------------------------------------------------------
*)

unit SxInterfaces;

interface

uses
  SxOptions, SxSimpleDomInterfaces, SxTypes, SxEmbeddedPicture,
  SysUtils, Classes;

type
  (**
   * \interface ISxReader
   * RTF reader methods
   *)
  ISxReader = interface
    (**
     * Convert the given RTF input.
     *)
    procedure ConvertRTFToHTML(const RTFsource: RawByteString);
  end;

  (**
   * \interface ISxOutputWriter
   * HTML OutputWriter methods
   *)
  ISxOutputWriter = interface
    (**
     * placeholder
     *)
    function GetDomDocument: ISimpleDomDocument;

    (**
     * placeholder
     *)
    procedure SetDomDocument(const Value: ISimpleDomDocument);

    (**
     * placeholder
     *)
    procedure SetConvertToPlainText(const Value: Boolean);

    (**
     * placeholder
     *)
    procedure Write;

    // properties
    property DomDocument: ISimpleDomDocument read GetDomDocument write
      SetDomDocument;

    property ConvertToPlainText: Boolean write SetConvertToPlainText;
  end;

  IWriterOptions = interface
{$IFDEF SX_DEBUG}
    function IsDebugging: Boolean;
{$ENDIF}
  end;

  ISxWriterOptions = interface
    function GetConvertLanguage: Boolean;
    function GetDefaultLanguage: string;
    function GetFontConversionOptions: TFontConversionOptions;
    function GetOptionsOptimize: TSxOptionsOptimize;
    function GetTabString: string;
{$IFDEF SX_DEBUG}
    function IsDebugging: Boolean;
{$ENDIF}
    property ConvertLanguage: Boolean read GetConvertLanguage;
    property DefaultLanguage: string read GetDefaultLanguage;
    property FontConversionOptions: TFontConversionOptions read
      GetFontConversionOptions;
    property OptionsOptimize: TSxOptionsOptimize read GetOptionsOptimize;
    property TabString: string read GetTabString;
  end;

  (**
   * \interface ISxWriter
   * placeholder
   *)
  ISxWriter = interface

    (**
     * placeholder
     *)
    function CloneCharacterProperties: TCharacterProperties;

    (**
     * placeholder
     *)
    procedure SetCharacterProperties(const Value: TCharacterProperties);

    (**
     * placeholder
     *)
    function CloneParagraphProperties: TParagraphProperties;

    (**
     * placeholder
     *)
    procedure SetParagraphProperties(const Value: TParagraphProperties);

    (**
     * placeholder
     *)
    procedure ResetCharacterAttributes;

    (**
     * placeholder
     *)
    procedure StoreTextProperties;

{$IFDEF SX_DEBUG}

    (**
     * placeholder
     *)
    procedure Debug(const s: string); overload;

    (**
     * placeholder
     *)
    procedure Debug(const Color: string; const Ch: AnsiChar); overload;

    (**
     * placeholder
     *)
    procedure Debug(const color, s: string); overload;
{$ENDIF}

    (**
     * placeholder
     *)
    procedure SetAlignment(const Value: TParagraphAlignment);

    (**
     * placeholder
     *)
    function GetDocCharset: TCharset;

    (**
     * placeholder
     *)
    procedure SetDocCharset(const Value: TCharset);

    (**
     * placeholder
     *)
    function GetIsNumbered: Boolean;

    (**
     * placeholder
     *)
    procedure SetIsNumbered(const Value: Boolean);

    (**
     * placeholder
     *)
    procedure SetNumberingLevel(const Value: TNumberingLevel);

    (**
     * placeholder
     *)
    function GetNumberingLevel: TNumberingLevel;

    (**
     * placeholder
     *)
    procedure SetNumberingStyle(const Value: Boolean);

    (**
     * placeholder
     *)
    function GetNumberingStyle: Boolean;

    (**
     * placeholder
     *)
    procedure SetDefaultFontName(const Value: string);

    (**
     * placeholder
     *)
    function GetDefaultFontName: string;

    (**
     * placeholder
     *)
    procedure SetFontColor(const Value: string);

    (**
     * placeholder
     *)
    procedure SetFontBGColor(const Value: string);

    (**
     * placeholder
     *)
    procedure SetFontHLColor(const Value: string);

    (**
     * placeholder
     *)
    procedure SetFontCharSet(const Value: TCharSet);

    (**
     * placeholder
     *)
    procedure SetFontStyle(const Value: TFontstyles);

    (**
     * placeholder
     *)
    function GetFontStyle: TFontstyles;

    (**
     * placeholder
     *)
    procedure SetFontSize(const Value: Integer);

    (**
     * placeholder
     *)
    function GetHidden: Boolean;

    (**
     * placeholder
     *)
    procedure SetHidden(const Value: Boolean);

    (**
     * placeholder
     *)
    procedure SetSuperscript(const Value: Boolean);

    (**
     * placeholder
     *)
    function GetSubscript: boolean;

    (**
     * placeholder
     *)
    procedure SetSubscript(const Value: boolean);

    (**
     * placeholder
     *)
    function GetSuperscript: boolean;

    (**
     * placeholder
     *)
    procedure SetLanguage(const Value: string);

    (**
     * placeholder
     *)
    procedure SetLeftIndent(const Value: Integer);

    (**
     * placeholder
     *)
    procedure SetRightIndent(const Value: Integer);

    (**
     * placeholder
     *)
    procedure SetFirstIndent(const Value: Integer);

    (**
     * placeholder
     *)
    function GetDomDocument: ISimpleDomDocument;

    (**
     * placeholder
     *)
    procedure SetFontName(const Value: string);

    (**
     * placeholder
     *)
    procedure SetDirection(const Value: TDirection);

    (**
     * placeholder
     *)
    procedure SetParDirection(const Value: TDirection);

    (**
     * placeholder
     *)
    procedure AddChar(const Ch: AnsiChar);

    (**
     * placeholder
     *)
    procedure ResetParagraphAttributes;

    // Properties
    property Alignment: TParagraphAlignment write SetAlignment;
    property DefaultFontName: string read GetDefaultFontName write
      SetDefaultFontName;
    property Direction: TDirection write SetDirection;
    property DocCharset: TCharset read GetDocCharset write SetDocCharset;
    property DomDocument: ISimpleDomDocument read GetDomDocument;
    property FirstIndent: Integer write SetFirstIndent;
    property FontBGColor: string write SetFontBGColor;
    property FontCharSet: TCharset write SetFontCharSet;
    property FontColor: string write SetFontColor;
    property FontHLColor: string write SetFontHLColor;
    property FontName: string write SetFontName;
    property FontStyle: TFontstyles read GetFontStyle write SetFontStyle;
    property FontSize: Integer write SetFontSize;
    property IsHidden: Boolean read GetHidden write SetHidden;
    property IsNumbered: Boolean read GetIsNumbered write SetIsNumbered;
    property Language: string write SetLanguage;
    property LeftIndent: Integer write SetLeftIndent;
    property NumberingLevel: TNumberingLevel read GetNumberingLevel write
      SetNumberingLevel;
    property NumberingStyle: Boolean read GetNumberingStyle write
      SetNumberingStyle;
    property ParDirection: TDirection write SetParDirection;
    property RightIndent: Integer write SetRightIndent;
    property Subscript: boolean read GetSubscript write SetSubscript;
    property Superscript: boolean read GetSuperscript write SetSuperscript;

  end;

  (**
   * \interface IUnicodeConverter
   * Interface for Unicode converter.
   *)
  IUnicodeConverter = interface
    (**
     * Get the CharSet value.
     *)
    function GetCharSet: TCharSet;

    (**
     * Set the CharSet value.
     *)
    procedure SetCharSet(const Value: TCharSet);

    (**
     * Get the DBCS value.
     *)
    function IsDBCS: Boolean;

    (**
     * Set the DBCS value.
     *)
    procedure SetDBCS(const Value: Boolean);

    (**
     * Convert a character to a WideChar character.
     *)
    function CharToUnicode(const C: AnsiChar): SXText;

    // properties
    (**
     * The Charset property contains the current text node's character set.
     *)
    property CharSet: TCharSet read GetCharSet write SetCharSet;

    (**
     * The DBCS property indicates a double byte character set.
     *)
    property DBCS: Boolean read IsDBCS write SetDBCS;
  end;

  (**
   * \interface ISxTranslator
   * Interface for Translator
   *)
  ISxTranslator = interface
    (**
     * placeholder
     *)
    function BuildLangAttribute(const Language: string): string;

    (**
     * placeholder
     *)
    function Encode(const S: SXText): SXText;

    (**
     * placeholder
     *)

    function FormatElement(const Text: SxText; const CP: TCharacterProperties):
      SxText;

    (**
     * placeholder
     *)
    function GetCloseEmptyElement: string;

    (**
     * placeholder
     *)
    function GetDocType: string;

    (**
     * placeholder
     *)
    function GetFontSizeStyle(const PT: Integer): string;

    (**
     * placeholder
     *)
    function GetMargin: string;

    (**
     * placeholder
     *)
    function GetParagraph(const AdditionalStyle: string; const
      AdditionalParams: string = ''): string;

    (**
     * placeholder
     *)
    function GetParagraphStyle(const PP: TParagraphProperties): string;

    (**
     * placeholder
     *)
    function GetRootElement: string;

    (**
     * placeholder
     *)
    function GetStyleParam(const AdditionalStyle: string): string;

    (**
     * placeholder
     *)
    function IsTransitional: Boolean;

    (**
     * placeholder
     *)
    function IsXml: Boolean;

    (**
     * placeholder
     *)
    function IsDocTypeRequired: Boolean;

    (**
     * placeholder
     *)
    procedure SetFontSizeScale(const FSS: TFontSizeScale);

    (**
     * placeholder
     *)
    procedure SetParOpen(const TagAndClass: string; const DefaultStyle:
      string);

    (**
     * placeholder
     *)
    function SupportsElement(const ElementName: string): Boolean;

    (**
     * placeholder
     *)
    function SupportsParameter(const ElementName, ParamName: string):
      Boolean;
  end;

  (**
   * \interface IPictureConverter
   * Defines methods for image conversion.
   *)
  IPictureConverter = interface
    (**
     * Convert raw picture data.
     *)
    procedure Convert(const APicture: TEmbeddedPicture);
  end;

  (**
   * \interface IPictureAdapter
   * Defines methods for image extraction.
   *)
  IPictureAdapter = interface

   (**
   * The converter will call this method before it starts to convert the
   * RTF code.
   *
   * It can be used for initialization of the PictureAdapter implementation.
   *
   *)
    procedure beforeConvert;

    (**
     * The converter will call this method every time when it encounters an
     * embedded picture in the RTF code.
     *)
    procedure addPicture;

    (**
       * For internal use only.
       *
       *)
    function getCurrentPicture: TEmbeddedPicture;

    (**
     * The converter will call this method every time when it reaches the end
     * of an embedded picture.
     *
     * After calling this method, the converter will invoke the #getPictureHTML
     * method to build and add the HTML code to the output document.
     *
     *)
    procedure finalizePicture;

    (**
     * This function returns the HTML code for the embedded picture.
     *
     * @return
     *)
    function getPictureHTML: string;

    (**
     * Return the map of the pictures in the current document.
     *
     * @return
     *)
    function getPictures: TStrings;

    (**
     * Set the picture converter.
     *)
    procedure SetConverter(const AConverter: IPictureConverter);

    (**
     * The base URL.
     *)
    procedure SetBase(const ABase: string);
  end;

  (** event called for a detected hyperlink }
  TValidateErrorEvent = procedure(Sender: TObject;
    const ErrorMessage: SXText) of object;

  (**
   * \interface ISxFormatter
   * placeholder
   *)
  ISxFormatter = interface

    (**
     * placeholder
     *)
    procedure SetIndentLevel(const Value: Integer);

    (**
     * placeholder
     *)
    procedure SetSpaces(const Value: string);

    (**
     * placeholder
     *)
    procedure SetNewLine(const Value: string);

    (**
     * placeholder
     *)
    function GetIndentLevel: Integer;

    (**
     * placeholder
     *)
    function GetNewLine: string;

    (**
     * placeholder
     *)
    function GetSpaces: string;

    (**
     * placeholder
     *)
    function Add(const Text: string): string;

    (**
     * placeholder
     *)
    function Indent(const Text: string): string;

    (**
     * placeholder
     *)
    function UnIndent(const Text: string): string;

    (**
     * placeholder
     *)
    function GetIndent(const Level: Integer): string; overload;

    (**
     * placeholder
     *)
    function GetIndent: string; overload;

    // properties
    property IndentLevel: Integer read GetIndentLevel write SetIndentLevel;
    property NewLine: string read GetNewLine write SetNewLine;
    property Spaces: string read GetSpaces write SetSpaces;
  end;

implementation

end.

