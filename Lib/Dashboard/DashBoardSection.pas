unit DashBoardSection;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,

  Generics.Collections,

  cxPC,

  DataManager,
  LibUtils,

  AppContainer;

type

   IDashboardWidget= interface
     procedure ShowHints( Value : Boolean );
     end;

  TDashBoardSectionFrame = class(TFrame)
  private

    FWidgetFrameList : TList<IDashboardWidget>;

  protected

  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure DoArrangeComponents; virtual; abstract;
    procedure DoOnChangeDescriptionsVisibility( Show : Boolean ); virtual; abstract;
    procedure DoOnActivate; virtual; abstract;
    procedure DoOnReadWindowParams; virtual; abstract;
    function  DoOnSaveWindowParams( ValueList : TStringList ) : Boolean; virtual; abstract;

    procedure AddWidget( AWidget : IDashboardWidget );
    procedure RemoveWidget( AWidget : IDashboardWidget );

    procedure ShowHints( Value : Boolean );

    procedure Setup; virtual; abstract;
    procedure UpdateData; virtual; abstract;
    procedure PreviousMonth; virtual; abstract;
    procedure NextMonth; virtual; abstract;
    procedure UpdateButtonsState; virtual; abstract;

    property WidgetFrameList : TList<IDashboardWidget> read FWidgetFrameList;

  end;

var  DashBoardSectionFrame : TDashBoardSectionFrame = nil;

procedure AddDashboardWidget( Owner : TComponent; Widget : IDashboardWidget );

implementation

{$R *.dfm}

uses

    System.UITypes,
    dxBarStrs,

    AppManager,

    DateUtils,

    SessionDataAccess,

    Dashboard;

procedure AddDashboardWidget( Owner : TComponent; Widget : IDashboardWidget );
begin
     If   Owner is TDashBoardSectionFrame
     then TDashBoardSectionFrame( Owner ).AddWidget( Widget );
end;

{ TDashBoardSectionFrame }

constructor TDashBoardSectionFrame.Create(AOwner: TComponent);
begin
     FWidgetFrameList := TList<IDashboardWidget>.Create;
     inherited;
     If   Assigned( DashboardForm )
     then DashboardForm.AddDashboardSectionFrame( Self )
end;

destructor TDashBoardSectionFrame.Destroy;
begin
     If   Assigned( DashboardForm )
     then DashboardForm.RemoveDashboardSectionFrame( Self );
     FreeAndNil( FWidgetFrameList );
     inherited;
end;

procedure TDashBoardSectionFrame.AddWidget(AWidget: IDashboardWidget );
begin
     FWidgetFrameList.Add( AWidget );
end;

procedure TDashBoardSectionFrame.RemoveWidget( AWidget: IDashboardWidget );
begin
     WidgetFrameList.Remove( AWidget );
end;

procedure TDashBoardSectionFrame.ShowHints(Value: Boolean);
begin
     For var WidgetFrame in FWidgetFrameList do
       WidgetFrame.ShowHints( Value );
end;

initialization


end.
