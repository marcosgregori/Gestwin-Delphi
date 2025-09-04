(*
 ------------------------------------------------------------------------------

 ScroogeXHTML 6.4
 RTF to HTML / XHTML converter component for Delphi

 Copyright (c) 1998 - 2013 Michael Justin
 http://www.habarisoft.com/
 ------------------------------------------------------------------------------
*)


unit SxDocumentParagraph;

interface

uses
  SxDocumentNode, SxSimpleDomInterfaces, SxTypes,
  Classes;

type
  (**
   * A class which represents a paragraph and which consists of ISimpleDomTextNode objects.
   *)
  TParagraphNode = class(TSimpleDomNode, ISimpleDomParagraph)
  public
    (** Create a new instance of the TParagraphNode class *)
    constructor Create(const AOwner: TSimpleDomNode);

    (** Destructor. *)
    destructor Destroy; override;

    (** Add a element to the paragraph if the current is not empty *)
    procedure AddText;

    (** Set all paragraph properties *)
    procedure SetParProperties(const PP: TParagraphProperties);

  end;

implementation

uses
  SxDocumentText;

constructor TParagraphNode.Create(const AOwner: TSimpleDomNode);
begin
  inherited Create(AOwner, etParagraph);
  Data := TParagraphProperties.Create;
  Append(TTextNode.Create(Self));
end;

procedure TParagraphNode.SetParProperties(const PP: TParagraphProperties);
begin
  TParagraphProperties(Data).CopyFrom(PP);
end;

procedure TParagraphNode.AddText;
begin
  // recycle empty text buffer
  if (LastChild.TextContent <> '') then
    Append(TTextNode.Create(Self));
end;

destructor TParagraphNode.Destroy;
begin

  inherited;
end;

end.

