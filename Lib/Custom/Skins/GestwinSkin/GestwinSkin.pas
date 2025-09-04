unit GestwinSkin;

{$I cxVer.inc}

interface

uses
  Classes, dxCore, dxCoreGraphics, dxGDIPlusApi, cxLookAndFeelPainters, dxSkinsCore, dxSkinsLookAndFeelPainter;


type

  { TdxSkinGestwinPainter }

  TdxSkinGestwinPainter = class(TdxAdvancedSkinLookAndFeelPainter)
  public
    function LookAndFeelName: string; override;
  end;

implementation

{$R GestwinSkin.res}

const
  SkinsCount = 1;
  SkinNames: array[0..SkinsCount - 1] of string = (
    'Gestwin'
  );
  SkinPainters: array[0..SkinsCount - 1] of TdxSkinLookAndFeelPainterClass = (
    TdxSkinGestwinPainter
  );


{ TdxSkinGestwinPainter }

function TdxSkinGestwinPainter.LookAndFeelName: string;
begin
  Result := 'Gestwin';
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
