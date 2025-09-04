(*
 ------------------------------------------------------------------------------

 ScroogeXHTML 6.4
 RTF to HTML / XHTML converter component for Delphi

 Copyright (c) 1998 - 2013 Michael Justin
 http://www.habarisoft.com/
 ------------------------------------------------------------------------------
*)


unit SxPictureConverterWMF;

interface

uses
  SxEmbeddedPicture,
  SxInterfaces;

type
  (**
   * Picture Converter example implementation.
   *)
  TPictureConverterWMF = class(TInterfacedObject, IPictureConverter)
  public
    (**
     * Convert raw picture data.
     *)
    procedure Convert(const APicture: TEmbeddedPicture);
  end;

implementation

uses
  SxTypes,
  PngImage, Graphics, Windows, Classes;

type
  TMetafileHeader = packed record
    Key: Longint;
    Handle: SmallInt;
    Box: TSmallRect;
    Inch: Word;
    Reserved: Longint;
    CheckSum: Word;
  end;

function ComputeChecksum(var WMF: TMetafileHeader): Word;
begin
  Result := 0;
  Result := Result xor Word(WMF.Key);
  Result := Result xor HiWord(WMF.Key);
  Result := Result xor Word(WMF.Handle);
  Result := Result xor Word(WMF.Box.Left);
  Result := Result xor Word(WMF.Box.Top);
  Result := Result xor Word(WMF.Box.Right);
  Result := Result xor Word(WMF.Box.Bottom);
  Result := Result xor WMF.Inch;
  Result := Result xor Word(WMF.Reserved);
  Result := Result xor HiWord(WMF.Reserved);
end;

procedure WriteHeader(const ADataStream: TStream; const APicture: TEmbeddedPicture);
var
  Header: TMetafileHeader;
begin
  Header.Key := Integer($9AC6CDD7);
  Header.Box.Left := 0;
  Header.Box.Top := 0;
  Header.Inch := 96;
  Header.Box.Right := APicture.WGoalPx + 1;
  Header.Box.Bottom := APicture.HGoalPx + 1;
  Header.CheckSum := ComputeChecksum(Header);

  ADataStream.Write(Header, SizeOf(Header));
end;

{ TPictureConverterWMF }

procedure TPictureConverterWMF.Convert(const APicture: TEmbeddedPicture);
var
  MF: TMetafile;
  PngImg: TPngImage;
  DataStream: TStream;
  PngStream: TStream;
begin
  if (APicture.PictureFormat <> psWMF) or (APicture.MappingMode <>
    MM_ANISOTROPIC) then
    Exit;

  APicture.PictureFormat := psPNG;

  DataStream := TMemoryStream.Create;
  try
    WriteHeader(DataStream, APicture);

    DataStream.CopyFrom(APicture.Stream, APicture.Stream.Size);
    DataStream.Seek(0, soBeginning);

    MF := TMetafile.Create;
    try
      MF.LoadFromStream(DataStream);
      PngImg := TPngImage.CreateBlank(COLOR_RGB, 8, MF.Width - 1, MF.Height - 1);
      try
        PngImg.Canvas.Draw(0, 0, MF);

        PngStream := TMemoryStream.Create;
        try
          PngImg.SaveToStream(PngStream);
          APicture.setData(PngStream);
        finally
          PngStream.Free;
        end;

      finally
        PngImg.Free;
      end;
    finally
      MF.Free;
    end;
  finally
    DataStream.Free;
  end;
end;

end.

