unit GestwinWhiteSkin;

{$I cxVer.inc}

interface

uses
  Classes, dxCore, dxCoreGraphics, dxGDIPlusApi, cxLookAndFeelPainters, dxSkinsCore, dxSkinsLookAndFeelPainter;


type

  { TdxSkinGestwinWhiteSkinPainter }

  TdxSkinGestwinWhiteSkinPainter = class(TdxSkinLookAndFeelPainter)
  public
    function LookAndFeelName: string; override;
  end;

implementation

{$R GestwinWhiteSkin.res}

const
  SkinsCount = 1;
  SkinNames: array[0..SkinsCount - 1] of string = (
    'GestwinWhiteSkin'
  );
  SkinPainters: array[0..SkinsCount - 1] of TdxSkinLookAndFeelPainterClass = (
    TdxSkinGestwinWhiteSkinPainter
  );


{ TdxSkinGestwinWhiteSkinPainter }

function TdxSkinGestwinWhiteSkinPainter.LookAndFeelName: string;
begin
  Result := 'GestwinWhiteSkin';
end;

//

procedure RegisterPainters;
var
  I: Integer;
begin
  if CheckGdiPlus then
  begin
    for I := 0 to SkinsCount - 1 do
      cxLookAndFeelPaintersManager.Register(SkinPainters[I].Create(SkinNames[I], HInstance));
  end;
end;

procedure UnregisterPainters;
var
  I: Integer;
begin
  if cxLookAndFeelPaintersManager <> nil then
  begin
    for I := 0 to SkinsCount - 1 do
      cxLookAndFeelPaintersManager.Unregister(SkinNames[I]);
  end;
end;

{$IFNDEF DXSKINDYNAMICLOADING}
initialization
  dxUnitsLoader.AddUnit(SysInit.HInstance, '', RegisterPainters, UnregisterPainters);
finalization
  dxUnitsLoader.RemoveUnit(SysInit.HInstance, '', UnregisterPainters);
{$ENDIF}
end.
end.
