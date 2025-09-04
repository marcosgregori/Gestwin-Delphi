unit f_dsb_prb;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxProgressBar, cxLabel, cxGroupBox,

  DashboardSection, dxSkinsCore;

type
  TDashboardProgressLineFrame = class(TFrame, IDashboardWidget)
    BackPanel: TcxGroupBox;
    TitleLabel: TcxLabel;
    ProgressBar: TcxProgressBar;
    DescriptionLabel: TcxLabel;
    ValuePanel: TcxGroupBox;
    ValueLabel: TcxLabel;
    ValueDescriptionLabel: TcxLabel;
  private
    FDashboardSectionFrame : TDashboardSectionFrame;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateFrameHeight;
    procedure ShowHints( Value : Boolean );
  end;

implementation

{$R *.dfm}

{ TDashboardProgressLineFrame }

constructor TDashboardProgressLineFrame.Create(AOwner: TComponent);
begin
     inherited;
     AddDashboardWidget( AOwner, Self );
end;

destructor TDashboardProgressLineFrame.Destroy;
begin
     //..
     inherited;
end;

procedure TDashboardProgressLineFrame.ShowHints( Value : Boolean );
begin
     DescriptionLabel.Visible := Value;
     UpdateFrameHeight;
end;

procedure TDashboardProgressLineFrame.UpdateFrameHeight;
begin
     Height := TitleLabel.Height + ValuePanel.Height + ProgressBar.Height + 4;
     If   DescriptionLabel.Visible
     then Height := Height + DescriptionLabel.Height;
end;

end.
