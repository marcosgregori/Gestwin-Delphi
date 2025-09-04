unit GestwinWhiteSkin;

{$I cxVer.inc}

interface

uses
  Classes, dxCore, dxCoreGraphics, dxGDIPlusApi, cxLookAndFeelPainters, dxSkinsCore, dxSkinsLookAndFeelPainter;


type

  { TdxSkinMySkin_MetropolisPainter }

  TdxSkinMySkin_MetropolisPainter = class(TdxAdvancedSkinLookAndFeelPainter)
  public
    function LookAndFeelName: string; override;
  end;

implementation

{$R GestwinWhiteSkin.res}

const
  SkinsCount = 1;
  SkinNames: array[0..SkinsCount - 1] of string = (
    'MySkin_Metropolis'
  );
  SkinPainters: array[0..SkinsCount - 1] of TdxSkinLookAndFeelPainterClass = (
    TdxSkinMySkin_MetropolisPainter
  );


{ TdxSkinMySkin_MetropolisPainter }

function TdxSkinMySkin_MetropolisPainter.LookAndFeelName: string;
begin
  Result := 'MySkin_Metropolis';
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
