unit B_dir;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, FileCtrl, ExtCtrls, AppContainer, AppForms,
  ComCtrls, ShlObj, cxShellCommon, cxControls, cxContainer, cxShellTreeView,
  Menus, cxLookAndFeelPainters, cxButtons,

  DB, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxEdit, cxLabel, cxGroupBox, cxShellControls, cxTreeView, cxGeometry,
  dxFramedControl, dxPanel;

type
  TDirectoryForm = class(TgxForm)
    Panel1: TPanel;
    Panel2: TgxEditPanel;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Button1: TgBitBtn;
    ShellTreeView: TcxShellTreeView;
    cxGroupBox1: TcxGroupBox;
    PathLabel: TcxLabel;
    procedure ShellTreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var  DirectoryForm: TDirectoryForm;

function SelectDirectory( var Path : String ) : Boolean; overload;
function SelectDirectory( Field : TStringField ) : Boolean; overload;

implementation

{$R *.dfm}

function SelectDirectory( var Path : string ) : Boolean;
begin
     Result := False;
     DirectoryForm := TDirectoryForm.Create( Application.MainForm );
     If   Assigned( DirectoryForm )
     then try
            DirectoryForm.ShellTreeView.Path := Path;
            If   DirectoryForm.ShowModal=mrOk
            then begin
                 Path := DirectoryForm.PathLabel.Caption;
                 Result := True;
                 end;
          finally
            DirectoryForm.Free;
            end;
end;

function SelectDirectory( Field : TStringField ) : Boolean;

var  Path : String;

begin
     Result := False;
     Path := Field.AsString;
     If   SelectDirectory( Path )
     then With Field do
            begin
            AsString := Path;
            Result := True;
            FocusControl;
            end;
end;

procedure TDirectoryForm.Button1Click(Sender: TObject);
begin
     WNetConnectionDialog( handle, RESOURCETYPE_DISK );
     ShellTreeView.UpdateContent;
end;


procedure TDirectoryForm.ShellTreeViewChange(Sender: TObject;Node: TTreeNode);
begin
     PathLabel.Caption := ShellTreeView.Path;
end;

end.

