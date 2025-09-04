(*
 ------------------------------------------------------------------------------

 ScroogeXHTML 6.4
 RTF to HTML / XHTML converter component for Delphi

 Copyright (c) 1998 - 2013 Michael Justin
 http://www.habarisoft.com/
 ------------------------------------------------------------------------------
*)

unit SxEmbeddedPicture;

interface

uses
  SxTypes,
  SysUtils,
  Classes;

type
  (**
   * Embedded picture.
   *)
  TEmbeddedPicture = class(TObject)
  private
    FOriginalWidth: Cardinal;
    FOriginalHeight: Cardinal;
    FPictureUrl: string;
    FScaleX: Cardinal;
    FScaleY: Cardinal;
    FWGoalTwips: Cardinal;
    FHGoalTwips: Cardinal;
    FPictureFormat: TPictureSource;
    FMappingMode: TMappingMode;

    Data: TMemoryStream;

    function getHGoalPx: Cardinal;
    function getWGoalPx: Cardinal;

  public
    constructor Create;
    destructor Destroy; override;

    (**
     * For conversion: overwrite data with stream.
     *)
    procedure setData(const AStream: TStream);

    (**
     * Picture data as memory stream.
     *)
    function Stream: TMemoryStream;

    (**
     * Height.
     *)
    function getHResult: Cardinal;

    (**
     * Width.
     *)
    function getWResult: Cardinal;

    (**
     * HTML code (img tag).
     *)
    function getPictureHTML: string;

    (**
     * Picture has been read completely from RTF.
     *)
    procedure complete;

    (**
     * Write a Byte from RTF picture data.
     *)
    procedure write(const s: Byte);

    // properties
    property MappingMode: TMappingMode read FMappingMode write FMappingMode;

    property PictureFormat: TPictureSource read FPictureFormat write
      FPictureFormat;

    property PictureUrl: string read FPictureUrl write FPictureUrl;

    property ScaleX: Cardinal read FScaleX write FScaleX;
    property ScaleY: Cardinal read FScaleY write FScaleY;

    property WGoalPx: Cardinal read GetWGoalPx;
    property HGoalPx: Cardinal read GetHGoalPx;

    property OriginalWidth: Cardinal read FOriginalWidth write FOriginalWidth;
    property OriginalHeight: Cardinal read FOriginalHeight write
      FOriginalHeight;

    property HGoalTwips: Cardinal read FHGoalTwips write FHGoalTwips;
    property WGoalTwips: Cardinal read FWGoalTwips write FWGoalTwips;

  end;

implementation

uses
  Math;

{ TEmbeddedPicture }

procedure TEmbeddedPicture.complete;
begin
   Data.Seek(0, soBeginning);
end;

constructor TEmbeddedPicture.Create;
begin
  Data := TMemoryStream.Create;
end;

destructor TEmbeddedPicture.Destroy;
begin
  Data.Free;
  inherited;
end;

function TEmbeddedPicture.getHGoalPx: Cardinal;
begin
  Result := Ceil(FHGoalTwips / 15);
end;

function TEmbeddedPicture.getWGoalPx: Cardinal;
begin
  Result := Ceil(FWGoalTwips / 15);
end;

function TEmbeddedPicture.getHResult: Cardinal;
begin
  if (ScaleY <> 0) then
    Result := Trunc(ScaleY * HGoalPx / 100)
  else
    Result := HGoalPx;
end;

function TEmbeddedPicture.getPictureHTML: string;
begin
  Result := '<img src="' + PictureUrl
    + '" height="' + IntToStr(getHResult)
    + '" width="' + IntToStr(getWResult) + '" alt="picture"/>';
end;

function TEmbeddedPicture.getWResult: Cardinal;
begin
  if (ScaleX <> 0) then
    Result := Trunc(ScaleX * WGoalPx / 100)
  else
    Result := WGoalPx;
end;

procedure TEmbeddedPicture.setData(const AStream: TStream);
begin
  Data.Clear;
  Data.LoadFromStream(AStream);
end;

function TEmbeddedPicture.Stream: TMemoryStream;
begin
  Result := Data;
end;

procedure TEmbeddedPicture.write(const s: Byte);
begin
  Data.Write(S, 1)
end;

end.

