(*
 ------------------------------------------------------------------------------

 ScroogeXHTML 6.4
 RTF to HTML / XHTML converter component for Delphi

 Copyright (c) 1998 - 2013 Michael Justin
 http://www.habarisoft.com/
 ------------------------------------------------------------------------------
*)


(** Component option subcomponents. *)
unit SxOptions;

interface

uses
  SxTypes,
  Classes;

type
  (**
   * Base class for property subcomponent.
   *)
  TSxOptions = class(TComponent)
  public
    (**
     * Constructor.
     *)
    constructor Create(AOwner: TComponent); override;

  end;

  (**
   * Properties for Html HEAD section
   *)
  TSxOptionsHead = class(TSxOptions)
  private
    FAddOuterHTML: Boolean;
    FDocumentTitle: string;
    FHeadTags: TStrings;
    FMetaAuthor: string;
    FMetaContentType: string;
    FMetaDescription: string;
    FMetaKeywords: string;
    FMetaOptions: TMetaOptions;
    FMetaTags: TStrings;
    FStyleSheetInclude: TStrings;
    FStyleSheetLink: string;
    procedure SetHeadTags(const Value: TStrings);
    procedure SetMetaTags(const Value: TStrings);
    procedure SetStyleSheetInclude(const Value: TStrings);
  public
    (**
     * Constructor.
     *)
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published

    (**
     * Set this property to True to include the surrounding tags for the HTML
     * header and the body in the output document
     *)
    property AddOuterHTML: Boolean read FAddOuterHTML write FAddOuterHTML;

    (**
     * The document title which will be displayed in the window title of the browser.
     *)
    property DocumentTitle: string read FDocumentTitle write FDocumentTitle;

    (**
     * List of additional tags for the head section.
     *)
    property HeadTags: TStrings read FHeadTags write SetHeadTags;

    (**
     * This property may be used to specify the document author.
     * It will add a META-element to the HEAD section.
     *)
    property MetaAuthor: string read FMetaAuthor write FMetaAuthor;

    (**
     * This property may be used to specify a character encoding for the
     * document.
     * It will add a META-element to the HEAD section.
     * Default: "text/html;charset=UTF-8"
     *)
    property MetaContentType: string read FMetaContentType write
      FMetaContentType;

    (**
     * This property may be used to specify a document description.
     * It will add a META-element to the HEAD section.
     *)
    property MetaDescription: string read FMetaDescription write
      FMetaDescription;

    (**
     * This property may be used to specify keywords for the document.
     * It will add a META-element to the HEAD section.
     *)
    property MetaKeywords: string read FMetaKeywords write FMetaKeywords;

    (**
     * A set of options which enable or disable additional meta tags.
     * \li moMetaDate include tag with UTC date and time.
     * \li moMetaGenerator include tag with generator name.
     *)
    property MetaOptions: TMetaOptions read FMetaOptions write FMetaOptions;

    (**
    * List of additional meta tags which can be used for a document description.
    *)
    property MetaTags: TStrings read FMetaTags write SetMetaTags;

    (**
     * Style sheet definitions which will be added in the HEAD
     * section HTML document.
     * Default: empty.
     *)
    property StyleSheetInclude: TStrings read FStyleSheetInclude write
      SetStyleSheetInclude;

    (**
     * URL of a file which contains external CSS style sheet definitions.
     * Default: empty.
     * \n
     * Example:
     * If this property has the value "scrooge.css", the following line will be inserted in the HTML header section:
     * \code <link href="scrooge.css" rel="stylesheet" type="text/css"> \endcode
     *)
    property StyleSheetLink: string read FStyleSheetLink write
      FStyleSheetLink;

  end;

  (**
   * Properties for optimization.
   *)
  TSxOptionsOptimize = class(TSxOptions)
  private
    FIncludeDefaultFontStyle: Boolean;
    FDefaultFontColor: string;
    FDefaultFontName: string;
    FDefaultFontSize: Integer;
    procedure SetDefaultFontColor(const Value: string);
    procedure SetDefaultFontName(const Value: string);
    procedure SetDefaultFontSize(const Value: Integer);
  public
    (**
     * Constructor.
     *)
    constructor Create(AOwner: TComponent); override;

  published

    (**
     * Use this property to optimize the HTML code generation.
     * \sa DefaultFontName
     * \sa DefaultFontSize
     * \sa IncludeDefaultFontStyle
     *)
    property DefaultFontColor: string read FDefaultFontColor write
      SetDefaultFontColor;

    (**
     * Use this property to optimize the HTML code generation.
     * \sa DefaultFontColor
     * \sa DefaultFontSize
     * \sa IncludeDefaultFontStyle
     *)
    property DefaultFontName: string read FDefaultFontName write
      SetDefaultFontName;

    (**
     * Use this property to optimize the HTML code generation.
     * \sa DefaultFontColor
     * \sa DefaultFontName
     * \sa IncludeDefaultFontStyle
     *)
    property DefaultFontSize: Integer read FDefaultFontSize write
      SetDefaultFontSize;

    (**
     * Use this property to optimize the HTML code generation.
     * \sa DefaultFontColor
     * \sa DefaultFontName
     * \sa DefaultFontSize
     *)
    property IncludeDefaultFontStyle: Boolean read FIncludeDefaultFontStyle write
      FIncludeDefaultFontStyle;

  end;

implementation

constructor TSxOptions.Create(AOwner: TComponent);
begin
  inherited;

  SetSubComponent(True);
  Name := ClassName;
end;

{ TSxOptionsOptimize }

constructor TSxOptionsOptimize.Create(AOwner: TComponent);
begin
  inherited;
  DefaultFontColor := DEFAULT_FONT_COLOR;
  DefaultFontName := DEFAULT_FONT_NAME;
  DefaultFontSize := DEFAULT_FONT_SIZE;
end;

procedure TSxOptionsOptimize.SetDefaultFontColor(const Value: string);
begin
  FDefaultFontColor := Value;
end;

procedure TSxOptionsOptimize.SetDefaultFontName(const Value: string);
begin
  FDefaultFontName := Value;
end;

procedure TSxOptionsOptimize.SetDefaultFontSize(const Value: Integer);
begin
  FDefaultFontSize := Value;
end;

{ TSxOptionsHead }

constructor TSxOptionsHead.Create(AOwner: TComponent);
begin
  inherited;
  FAddOuterHTML := True;
  FDocumentTitle := 'Untitled document';
  FHeadTags := TStringlist.Create;
  FMetaContentType := ContentTypeUTF_8;
  FMetaTags := TStringlist.Create;
  FMetaOptions := [moMetaGenerator];
  FStyleSheetInclude := TStringlist.Create;
end;

destructor TSxOptionsHead.Destroy;
begin
  FHeadTags.Clear;
  FHeadTags.Free;

  FMetaTags.Clear;
  FMetaTags.Free;

  FStyleSheetInclude.Clear;
  FStyleSheetInclude.Free;

  inherited;
end;

procedure TSxOptionsHead.SetHeadTags(const Value: TStrings);
begin
  FHeadTags.Assign(Value);
end;

procedure TSxOptionsHead.SetMetaTags(const Value: TStrings);
begin
  FMetaTags.Assign(Value);
end;

procedure TSxOptionsHead.SetStyleSheetInclude(const Value: TStrings);
begin
  FStyleSheetInclude := Value;
end;

end.

