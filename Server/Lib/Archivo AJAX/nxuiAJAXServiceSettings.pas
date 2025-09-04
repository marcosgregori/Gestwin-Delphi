{ Versión VCL -- No actualizar desde la versión VCL ---}
unit nxuiAJAXServiceSettings;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  VCL.Types, VCL.Graphics, VCL.Controls, VCL.Forms, VCL.Dialogs, VCL.StdCtrls,
  System.Actions, VCL.ActnList, VCL.Objects,
  VCL.TMSBaseControl, VCL.TMSBitmap, StyleModule,

  nxAJAXServiceSettings,
  VCL.Controls.Presentation,
  nxuiBaseSettingsForm, VCL.Edit, VCL.EditBox, VCL.SpinBox;

type
  TnxAJAXServiceSettingsSettings = class(TnxBaseSettingsFrame)
    clbActive: TCheckBox;
    udPort: TSpinBox;
    Label1: TLabel;
    edIPs: TEdit;
    Label3: TLabel;
    procedure ControlChange(Sender: TObject);
  private
    function GetAJAXServiceSettings : TnxAJAXServiceSettings;
    procedure UpdateControlsState;
  protected
    procedure DoRefresh; override;
  public
    procedure DoApply; override;
    property Settings : TnxAJAXServiceSettings read GetAJAXServiceSettings;
  end;

var
  nxAJAXServiceSettingsSettings: TnxAJAXServiceSettingsSettings;

implementation

{$R *.VCL}
{$R *.Windows.VCL MSWINDOWS}

uses ServerContainer;

procedure TnxAJAXServiceSettingsSettings.ControlChange(Sender: TObject);
begin
     inherited;
     Changed := True;
     If   not bsfRefreshing
     then UpdateControlsState;
end;

procedure TnxAJAXServiceSettingsSettings.DoApply;
begin
     Settings.ServiceEnabled := clbActive.IsChecked;
     Settings.Port := Trunc( udPort.Value );
     Settings.InternalAddresses := edIPs.Text;

     With ServerContainerModule do
       UpdateServerBindings( ssAJAX, True );

     inherited;
end;

procedure TnxAJAXServiceSettingsSettings.DoRefresh;
begin
     inherited;
     clbActive.IsChecked := Settings.ServiceEnabled;
     udPort.Value := Settings.Port;
     edIPs.Text := Settings.InternalAddresses;
     UpdateControlsState;
end;

procedure TnxAJAXServiceSettingsSettings.UpdateControlsState;
begin
     Label3.Enabled := not clbActive.IsChecked;
     udPort.Enabled := not clbActive.IsChecked;
     edIPs.Enabled := not clbActive.IsChecked;
end;

function TnxAJAXServiceSettingsSettings.GetAJAXServiceSettings: TnxAJAXServiceSettings;
begin
     Result := TnxAJAXServiceSettings( nxObject );
end;

initialization
     RegisterClass(TnxAJAXServiceSettingsSettings);

end.
