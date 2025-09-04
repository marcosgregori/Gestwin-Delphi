(*
 ------------------------------------------------------------------------------

 ScroogeXHTML 6.4
 RTF to HTML / XHTML converter component for Delphi

 Copyright (c) 1998 - 2013 Michael Justin
 http://www.habarisoft.com/
 ------------------------------------------------------------------------------
*)


unit SxMemoryPictureAdapter;

interface

uses
  SxInterfaces, SxEmbeddedPicture,
  Classes;

type
  (**
   * In-memory picture adapter.
   *
   *)
  TMemoryPictureAdapter = class(TInterfacedObject, IPictureAdapter)
  private
    Pics: TStrings;
    Current: TEmbeddedPicture;
    FConverter: IPictureConverter;
    FBase: string;
  public
    constructor Create;
    destructor Destroy; override;

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

implementation

uses
  SxTypes,
  SysUtils;

{ TMemoryPictureAdapter }

procedure TMemoryPictureAdapter.addPicture;
begin
  Current := TEmbeddedPicture.Create;
end;

procedure TMemoryPictureAdapter.beforeConvert;
var
  I: Integer;
begin
  for I := 0 to Pics.Count - 1 do
    Pics.Objects[I].Free;

  Pics.Clear;
end;

constructor TMemoryPictureAdapter.Create;
begin
  Pics := TStringList.Create;
end;

destructor TMemoryPictureAdapter.Destroy;
var
  I: Integer;
begin
  for I := 0 to Pics.Count - 1 do
    Pics.Objects[I].Free;

  Pics.Free;
  inherited;
end;

procedure TMemoryPictureAdapter.finalizePicture;
var
  Key: string;
  Ext: string;
begin
  Current.complete;

  if Assigned(FConverter) then
  begin
    FConverter.Convert(Current);
  end;

  case Current.PictureFormat of
    psJPEG: Ext := 'jpg';
    psPNG: Ext := 'png';
  else
    Ext := 'unknown';
  end;

  Key := 'image' + IntToStr(Pics.Count + 1) + '.' + Ext;

  Current.PictureUrl := FBase + Key;

  Pics.AddObject(Key, Current)
end;

function TMemoryPictureAdapter.getCurrentPicture: TEmbeddedPicture;
begin
  Result := Current;
end;

function TMemoryPictureAdapter.getPictureHTML: string;
begin
  Result := Current.getPictureHTML;
end;

function TMemoryPictureAdapter.getPictures: TStrings;
begin
  Result := Pics;
end;

procedure TMemoryPictureAdapter.SetBase(const ABase: string);
begin
  FBase := ABase;
end;

procedure TMemoryPictureAdapter.SetConverter(
  const AConverter: IPictureConverter);
begin
  FConverter := AConverter;
end;

end.

