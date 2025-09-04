(*
 ------------------------------------------------------------------------------

 ScroogeXHTML 6.4
 RTF to HTML / XHTML converter component for Delphi

 Copyright (c) 1998 - 2013 Michael Justin
 http://www.habarisoft.com/
 ------------------------------------------------------------------------------
*)

 
(**
 * Main ScroogeXHTML component unit
 *)
unit ScroogeXHTML;

interface

uses
  SxMain, SxTypes,
  SysUtils,
  Classes // TStrings
{$IFNDEF CONSOLE}
{$IFNDEF FPC}
{$IFNDEF FMX}
  , Comctrls// TRichEdit
{$ENDIF}
{$ENDIF}
{$ENDIF};

type
  (**
   * This class implements the high-level converter methods
   * #ConvertRTFFile and #RichEditToHTML. The third conversion method,
   * TSxBase#Convert, is defined in the superclass.
   *)
  TCustomScrooge = class(TSxMain)
  public
    (**
    * Convert a RTF file to a HTML file.
    *
    * To write an application which can convert a RTF file to a HTML/XHTML file,
    * \li drop a ScroogeXHTML component on the form
    * \li add a button to the form and enter the following code for the OnClick event:
    * \verbatim
      var
       RTFFile, XHTMLFile: string;
      begin
        RTFFile := 'c:\windows\desktop\test.rtf';
        XHTMLFile := 'c:\windows\desktop\test.html';
        ScroogeXHTML1.ConvertRTFFile(RTFFile, XHTMLFile);
      end;
      \endverbatim
      \arg RTFFilename The name of the input RTF file
      \arg HTMLFilename The name of the output HTML/XHTML file
    *)
    procedure ConvertRTFFile(const RTFFilename, HTMLFilename: TFileName);

    (**
     * Convert a RTF file to a HTML string.
     * \arg RTFFilename The name of the input RTF file
     *)
    function ConvertRTF(const RTFfilename: TFileName): UTF8String;

    (** Convert the RichEdit RTF code to HTML/XHTML.
     * \arg Source The TRichEdit control instance.
     *)
{$IFNDEF CONSOLE}
{$IFNDEF FPC}
{$IFNDEF FMX}
    function RichEditToHTML(const Source: TRichedit): UTF8String;
{$ENDIF}
{$ENDIF}
{$ENDIF}

  end;

  (**
   * This class adds no properties or methods, it only defines the component name
   *)
  TBTScroogeXHTML = class(TCustomScrooge)

  end;

implementation

function LoadBytesFromStream(const AStream: TStream): RawByteString;
var
  Size: Int64;
begin
  Size := AStream.Size;

  if (Size < 0) or (Size > MaxInt) then
    raise Exception.Create('Stream size error');

  SetLength(Result, Size);
  AStream.ReadBuffer(Pointer(Result)^, Size);
end;

procedure TCustomScrooge.ConvertRTFFile(const RTFFilename, HTMLFilename:
  TFileName);
var
  HTMLContent: TBytes;
  S: TStream;
begin
  HTMLContent := ToBytes(ConvertRTF(RTFFilename));

  S := TFileStream.Create(HTMLFilename, fmCreate);
  try
    S.Write(HTMLContent[0], Length(HTMLContent));
  finally
    S.Free;
  end;
end;

function TCustomScrooge.ConvertRTF(const RTFfilename: TFileName): UTF8String;
var
  RTFContent: RawByteString;
  S: TStream;
begin
  S := TFileStream.Create(RTFfilename, fmOpenRead);
  try
    RTFContent := LoadBytesFromStream(S);
    Result := Convert(RTFContent);
  finally
    S.Free;
  end;
end;

{$IFNDEF CONSOLE}
{$IFNDEF FPC}
{$IFNDEF FMX}
function TCustomScrooge.RichEditToHTML(const Source: TRichedit): UTF8String;
var
  MS: TMemoryStream;
  RTFContent: RawByteString;
begin
  MS := TMemoryStream.Create;
  try
    MS.Seek(0, soBeginning);
    Source.Lines.SaveToStream(MS);
    MS.Seek(0, soBeginning);

    RTFContent := LoadBytesFromStream(MS);

    Result := Convert(RTFContent);
  finally
    MS.Free;
  end;
end;
{$ENDIF}
{$ENDIF}
{$ENDIF}

end.

