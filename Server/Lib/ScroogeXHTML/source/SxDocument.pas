(*
 ------------------------------------------------------------------------------

 ScroogeXHTML 6.4
 RTF to HTML / XHTML converter component for Delphi

 Copyright (c) 1998 - 2013 Michael Justin
 http://www.habarisoft.com/
 ------------------------------------------------------------------------------
*)


(** document object which stores and builds the complete output *)
unit SxDocument;

interface

uses
  SxDocumentNode, SxSimpleDomInterfaces, SxTypes,
  Classes;

type
  (**
   * A class which represents a document.
   *)
  TSimpleDomDocument = class(TSimpleDomNode, ISimpleDomDocument)
  private
    (** add a paragraph *)
    procedure AddPar;

  public
    (** create a new instance of the TSimpleDomDocument class *)
    constructor Create(const AOwner: TSimpleDomNode);

    (** add a string to the document *)
    procedure Add(const S: SXText); overload;

    (** add an encoded string to the document *)
    procedure AddEncoded(const S: SXText);

  end;

implementation

uses
  SxDocumentText, SxDocumentParagraph;

constructor TSimpleDomDocument.Create(const AOwner: TSimpleDomNode);
begin
  inherited Create(nil, etDocument);
  AddPar; // add a starting paragraph
end;

procedure TSimpleDomDocument.Add(const S: SXText);
begin
  TTextNode(TParagraphNode(LastChild).LastChild).Add(S);
end;

procedure TSimpleDomDocument.AddPar;
begin
  Append(TParagraphNode.Create(Self));
end;

procedure TSimpleDomDocument.AddEncoded(const S: SXText);
begin
  TParagraphNode(LastChild).AddText;
  with TTextNode(TParagraphNode(LastChild).LastChild) do
  begin
    Encoded := True;
    Add(S);
  end;
  TParagraphNode(LastChild).AddText;
end;

end.

