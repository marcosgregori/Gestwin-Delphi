(*
 ------------------------------------------------------------------------------

 ScroogeXHTML 6.4
 RTF to HTML / XHTML converter component for Delphi

 Copyright (c) 1998 - 2013 Michael Justin
 http://www.habarisoft.com/
 ------------------------------------------------------------------------------
*)

unit SxFormatter;

interface

uses
  SxInterfaces;

type
  (**
   * A text formatter for HTML and XHTML output beautification.
   *)
  TSxFormatter = class(TInterfacedObject, ISxFormatter)
  private
    FIndentLevel: Integer;
    FSpaces: string;
    FNewLine: string;
    procedure SetIndentLevel(const Value: Integer);
    procedure SetSpaces(const Value: string);
    procedure SetNewLine(const Value: string);
    function GetIndentLevel: Integer;
    function GetNewLine: string;
    function GetSpaces: string;

  public
    constructor Create;

   (**
    * Add.
    *)
    function Add(const Text: string): string;
   (**
    * Indent.
    *)
    function Indent(const Text: string): string;
   (**
    * UnIndent.
    *)
    function UnIndent(const Text: string): string;
   (**
    * GetIndent.
    *)
    function GetIndent(const Level: Integer): string; overload;
   (**
    * GetIndent.
    *)
    function GetIndent: string; overload;

    // properties
    property IndentLevel: Integer read GetIndentLevel write SetIndentLevel;
    property NewLine: string read GetNewLine write SetNewLine;
    property Spaces: string read GetSpaces write SetSpaces;
  end;

implementation

uses
  SxTypes;

{ TFormatter }

function TSxFormatter.Add(const Text: string): string;
begin
  Result := getIndent + Text + FNewLine;
end;

constructor TSxFormatter.Create;
begin
  inherited Create;
  FIndentLevel := 0;
  FNewLine := CrLf;
  FSpaces := {$IFNDEF SCROOGE_NO_INDENT}'  '{$ENDIF};
end;

function TSxFormatter.GetIndent(const Level: Integer): string;
var
  I: Integer;
begin
  Result := '';
  for I:=1 to Level do
    Result := Result + FSpaces;
end;

function TSxFormatter.GetIndent: string;
begin
  Result := GetIndent(FIndentLevel)
end;

procedure TSxFormatter.SetIndentLevel(const Value: Integer);
begin
  FIndentLevel := Value;
end;

procedure TSxFormatter.SetNewLine(const Value: string);
begin
  FNewLine := Value;
end;

procedure TSxFormatter.SetSpaces(const Value: string);
begin
  FSpaces := Value;
end;

(**
 * Indent text.
 *)
function TSxFormatter.Indent(const Text: string): string;
begin
  Inc(FIndentLevel);
  Result := Add(Text);
end;

(**
 * Un-Indent text.
 *)
function TSxFormatter.UnIndent(const Text: string): string;
begin
  Dec(FIndentLevel);
  Result := Add(Text);
end;

function TSxFormatter.GetIndentLevel: Integer;
begin
  Result := FIndentLevel;
end;

function TSxFormatter.GetNewLine: string;
begin
  Result := FNewLine;
end;

function TSxFormatter.GetSpaces: string;
begin
  Result := FSpaces;
end;

end.
