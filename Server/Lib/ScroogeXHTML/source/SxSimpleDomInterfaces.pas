(*
 ------------------------------------------------------------------------------

 ScroogeXHTML 6.4
 RTF to HTML / XHTML converter component for Delphi

 Copyright (c) 1998 - 2013 Michael Justin
 http://www.habarisoft.com/
 ------------------------------------------------------------------------------
*)


unit SxSimpleDomInterfaces;

interface

uses
  SxDocumentNode, SxTypes;

type
  (**
   * \interface ISimpleDomDocument
   * DOM document methods
   *)
  ISimpleDomDocument = interface(ISimpleDomNode)
    (**
     * Add a string
     *)
    procedure AddEncoded(const S: SXText);
    (**
     * Add a paragraph
     *)
    procedure AddPar;
  end;

  (**
   * \interface ISimpleDomParagraph
   * DOM paragraph methods
   *)
  ISimpleDomParagraph = interface(ISimpleDomNode)
    (**
     * Add a new empty text node
     *)
    procedure AddText;
    (**
     * Set paragraph properties
     *)
    procedure SetParProperties(const PP: TParagraphProperties);
  end;

  (**
   * \interface ISimpleDomTextNode
   * DOM textnode methods
   *)
  ISimpleDomTextNode = interface(ISimpleDomNode)
    (**
     * Set text properties
     *)
    procedure SetTextProperties(const CharProps: TCharacterProperties);
    (**
     * Get the Encoded value
     *)
    function GetEncoded: Boolean;
    (**
     * Set the Encoded value
     *)
    procedure SetEncoded(const Value: Boolean);

    // properties
    property Encoded: Boolean read GetEncoded write SetEncoded;
  end;

implementation

end.

