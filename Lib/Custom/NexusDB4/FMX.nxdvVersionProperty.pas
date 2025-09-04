{##############################################################################}
{# NexusDB: nxdvVersionProperty.pas 4.1301                                   #}
{# Copyright (c) Nexus Database 2003-2017                                     #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: Component Version Property Editor                                 #}
{##############################################################################}

{$I nxDefine.inc}

unit FMX.nxdvVersionProperty;

interface

uses
  SysUtils,
  Classes,
  FMX.Controls,
  DesignIntf,
  DesignEditors;

type
  TnxVersionProperty = class(TStringProperty)
    public
      function GetAttributes: TPropertyAttributes; override;
      procedure Edit; override;
  end;

implementation

uses
  FMX.Forms,
  nxllConst,
  FMX.nxpvAboutFrm;

{===TnxVersionProperty=========================================================}
function TnxVersionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;
{------------------------------------------------------------------------------}
procedure TnxVersionProperty.Edit;
var
  AboutBox : TnxAboutFrm;
begin
  AboutBox := TnxAboutFrm.Create(Application);
  try
    AboutBox.Caption := 'About NexusDB Components';
    AboutBox.ProgramName.Text := 'NexusDB ' + IntToStr(nxVersionNumber div 10000) +
      '.' + Copy(Format('%0.4f %s', [Frac(nxVersionNumber / 10000.0), nxSpecialString]), 3, 255);
    AboutBox.ShowModal;
  finally
    AboutBox.Free;
  end;
end;
{==============================================================================}

initialization
  {$IFDEF NX_PUBLICBETA}
  {$I PublicBeta\nxPublicBeta1.inc}
  {$ENDIF}
end.
