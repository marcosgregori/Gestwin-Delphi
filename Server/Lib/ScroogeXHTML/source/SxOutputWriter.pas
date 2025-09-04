(*
 ------------------------------------------------------------------------------

 ScroogeXHTML 6.4
 RTF to HTML / XHTML converter component for Delphi

 Copyright (c) 1998 - 2013 Michael Justin
 http://www.habarisoft.com/
 ------------------------------------------------------------------------------
*)


unit SxOutputWriter;

interface

uses
  SxInterfaces, SxBase, SxSimpleDomInterfaces, SxTypes,
  Classes;

type
  (**
   * An instance of this class reads the DomDocument and builds the (X)HTML result.
   *)
  TSxOutputWriter = class(TInterfacedObject, ISxOutputWriter)
  private
    FDomDocument: ISimpleDomDocument;
    FEmptyPar: string;
    FConvertEmpty: Boolean;
    FConvertToPlainText: Boolean;
    FLineTag: string;
    FConverter: TSxBase;
    WriterSL: TStrings;

    function GetDomDocument: ISimpleDomDocument;
    procedure SetDomDocument(const Value: ISimpleDomDocument);
    procedure SetConverter(const Value: TSxBase);
    procedure SetConvertToPlainText(const Value: Boolean);

    function Translator: ISxTranslator;

    function GetStringResult: string;

    (**
     * Write method iterates the DomDocument and builds the (X)HTML result into
     * StringResult.
     *)
    procedure WriteHtml;

    (**
     * Write method iterates the DomDocument and builds the text result into
     * StringResult.
     *)
    procedure WritePlainText;

  public
    constructor Create;

    destructor Destroy; override;

    (**
     * Write method iterates the DomDocument and builds the result into
     * StringResult.
     *)
    procedure Write;

    (**
     * \property ConvertEmpty
     *)
    property ConvertEmpty: Boolean read FConvertEmpty write FConvertEmpty;

    (**
     * \property Converter
     *)
    property Converter: TSxBase read FConverter write SetConverter;

    (**
     * \property ConvertToPlainText
     *)
    property ConvertToPlainText: Boolean write SetConvertToPlainText;

    (**
     * \property DomDocument
     *)
    property DomDocument: ISimpleDomDocument read GetDomDocument write
      SetDomDocument;

    (**
     * \property EmptyPar
     *)
    property EmptyPar: string read FEmptyPar write FEmptyPar;

    (**
     * \property LineTag
     *)
    property LineTag: string read FLineTag write FLineTag;

    (**
     * \property StringResult
     *)
    property StringResult: string read GetStringResult;

  end;

implementation

uses
  SxDocumentText, SxDocumentParagraph,
  SysUtils;

const
  LEFT_MARGIN = {$IFNDEF SCROOGE_NO_INDENT}'    '{$ENDIF};

{ TOutputWriter }

constructor TSxOutputWriter.Create;
begin
  inherited;
  WriterSL := TStringList.Create;
end;

destructor TSxOutputWriter.Destroy;
begin
  WriterSL.Clear;
  WriterSL.Free;
  inherited;
end;

function TSxOutputWriter.GetDomDocument: ISimpleDomDocument;
begin
  Result := FDomDocument;
end;

function TSxOutputWriter.GetStringResult: string;
begin
  Result := WriterSL.Text;
end;

procedure TSxOutputWriter.SetConverter(const Value: TSxBase);
begin
  FConverter := Value;
end;

procedure TSxOutputWriter.SetConvertToPlainText(const Value: Boolean);
begin
  FConvertToPlainText := Value;
end;

procedure TSxOutputWriter.SetDomDocument(const Value: ISimpleDomDocument);
begin
  FDomDocument := Value;
end;

function TSxOutputWriter.Translator: ISxTranslator;
begin
  Result := Converter.Translator;
end;

procedure TSxOutputWriter.Write;
begin
  if FConvertToPlainText then
    WritePlainText
  else
    WriteHtml;
end;

procedure TSxOutputWriter.WriteHtml;
var
  I: Integer;
  ParContent: SXText;

  function GetOpenListTags(const Para: ISimpleDomParagraph;
    const ParProps: TParagraphProperties): string;
  var
    P: TParagraphNode;
  begin
    P := TParagraphNode(Para.PreviousSibling);
    if (P = nil) or (not TParagraphProperties(P.Data).Numbered) then
    begin
      if ParProps.NumberingLevel <> NL_BULLET then
        Result := LEFT_MARGIN + Converter.GetOrderedListTag + CrLf
      else
        Result := LEFT_MARGIN + Converter.GetUnOrderedListTag + CrLf
    end
    else
      Result := '';
  end;

  function GetCloseListTags(const Para: ISimpleDomParagraph): string;
  var
    P: TParagraphNode;
  begin
    P := TParagraphNode(Para.NextSibling);
    if (P = nil) or (not TParagraphProperties(P.Data).Numbered) then
    begin
      if TParagraphProperties(Para.Data).NumberingLevel = NL_BULLET then
        Result := LEFT_MARGIN + '</ul>' + CrLf
      else
        Result := LEFT_MARGIN + '</ol>' + CrLf
    end
    else
      Result := '';
  end;

  function GetParOpenTag(const ParProps: TParagraphProperties): string;
  begin
    Result := Translator.GetParagraphStyle(ParProps);
  end;

  function GetParCloseTag: string;
  begin
    // TODO docs Since 4.4. Reason: IE does not like CrLf followed by space
    if Converter.ConvertUsingPrettyIndents then
    begin
      Result := CrLf + LEFT_MARGIN + '</p>' + CrLf;
    end
    else
    begin
      Result := '</p>' + CrLf;
    end
  end;

  function GetListItemStyle(const Alignment: TParagraphAlignment): string;
  var
    CustomStyle: string;
  begin
    case Alignment of
      paRightJustify: Result := 'text-align:right';
      paCenter: Result := 'text-align:center';
      paJustify: Result := 'text-align:justify';
    end;

    CustomStyle := Converter.ElementStyles.Values['li'];

    if CustomStyle <> '' then
    begin
      if Result <> '' then
      begin
        Result := Result + ';';
      end;
      Result := Result + CustomStyle;
    end;

    if Result <> '' then
    begin
      Result := ' style="' + Result + '"';
    end;
  end;

  function GetParaHTML(const Para: ISimpleDomParagraph): SxText;
  var
    I: Integer;
    TextNode: TTextNode;
    ParProps: TParagraphProperties;
    ListItem: string;
    ListItemStyle: string;
  begin
    Result := '';

    for I := 0 to Para.GetCount - 1 do
    begin
      TextNode := TTextNode(Para.Item[I]);
      if TextNode.TextContent <> '' then
        Result := Result + Converter.TextElementToXHTML(TextNode)
    end;

    if Trim(Result) = '' then
      Result := EmptyPar
    else
    begin
      ParProps := Para.Data as TParagraphProperties;
      ListItemStyle := Converter.GetElementStyleParam('li');

      if ParProps.Numbered then
      begin
        ListItem := '<li' + Converter.GetElementClassParam('li');

        if Translator.IsTransitional then
        begin
          case ParProps.Alignment of
            paRightJustify: ListItem := ListItem + ' align="right"';
            paCenter: ListItem := ListItem + ' align="center"';
            paJustify: ListItem := ListItem + ' align="justify"';
          end;
        end
        else
        begin
          // strict
          ListItem := ListItem + GetListItemStyle(ParProps.Alignment);
        end;

        ListItem := ListItem + '>';

        Result := GetOpenListTags(Para, ParProps)
          + {$IFNDEF SCROOGE_NO_INDENT}'      '{$ENDIF} + ListItem + CrLf
          + Translator.GetMargin
          + Result + CrLf
          + {$IFNDEF SCROOGE_NO_INDENT}'      '{$ENDIF} + '</li>' + CrLf
          + GetCloseListTags(Para);

      end
      else
      begin
        Result := GetParOpenTag(ParProps) + Result + GetParCloseTag;
      end;
    end
  end;

begin
  WriterSL.Clear;

  // delete empty paragraphs at document end
  while DomDocument.GetCount > 0 do
  begin
    if GetParaHTML(TParagraphNode(DomDocument.LastChild)) = EmptyPar then
      DomDocument.Remove(DomDocument.LastChild)
    else
      Break;
  end;

  // collect all paragraphs
  for I := 0 to DomDocument.GetCount - 1 do
  begin
    ParContent := GetParaHTML(TParagraphNode(DomDocument.Item[I]));
    if ConvertEmpty and (ParContent = EmptyPar) then
      WriterSL.Add(LEFT_MARGIN + LineTag)
    else
      // remove CrLf
      WriterSL.Add(Copy(ParContent, 1, Length(ParContent) - 2));
  end;

end;

procedure TSxOutputWriter.WritePlainText;
var
  I: Integer;

  function GetPlainText(const Para: ISimpleDomParagraph): string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 0 to Para.GetCount - 1 do
      Result := Result + Para.Item[I].TextContent;
  end;

begin
  WriterSL.Clear;
  for I := 0 to DomDocument.GetCount - 1 do
    WriterSL.Add(GetPlainText(TParagraphNode(DomDocument.Item[I])));
end;

end.

