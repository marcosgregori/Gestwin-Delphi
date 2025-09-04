
unit cxExtControlsStrs;

{$I cxVer.inc}

interface

resourcestring
  dxSBAR_CP_ADDREPEATBUTTON = 'Add &RepeatButton';

implementation

uses
  dxCore;

procedure AddExtControlsResourceStringNames(AProduct: TdxProductResourceStrings);

  procedure InternalAdd(const AResourceStringName: string; AAdress: Pointer);
  begin
    AProduct.Add(AResourceStringName, AAdress);
  end;

begin
  InternalAdd('dxSBAR_CP_ADDREPEATBUTTON', @dxSBAR_CP_ADDREPEATBUTTON);
end;

initialization
  dxResourceStringsRepository.RegisterProduct('ExtControls', @AddExtControlsResourceStringNames);

finalization
  dxResourceStringsRepository.UnRegisterProduct('ExtControls');

end.
