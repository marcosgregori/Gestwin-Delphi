
unit b_tbf;

interface

uses Controls, StdCtrls, Buttons, ExtCtrls, Classes, Forms, Messages, windows,

     AppContainer, Graphics, AppForms, Menus, cxLookAndFeelPainters, cxButtons,
  cxGraphics, cxControls, cxLookAndFeels, cxContainer, cxEdit, dxSkinsCore,
  cxGroupBox, dxGDIPlusClasses, cxImage, dxSkinsDefaultPainters,
  dxUIAClasses;

type
  TTabletaFirmaForm = class(TgxForm)
    Image1: TcxImage;
    Shape1: TShape;
    TabletImage: TImage;
    procedure TabletImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDeactivate(Sender: TObject);
  private
  public
  end;

var  TabletaFirmaForm : TTabletaFirmaForm = nil;

procedure CreateTabletaFirmaForm;
function DestroyTabletaFirmaForm( CheckClose : Boolean = True ) : Boolean;

implementation

{$R *.dfm}

uses   LibUtils,
       AppManager,

       b_msg,

       dm_tbf;

resourceString
       RsMsg1 = 'Parece que hay un trazo de firma en la tableta.';
       RsMsg2 = '¿Está seguro de que desea cerrar la ventana de firma?';

procedure CreateTabletaFirmaForm;
begin
     TabletaFirmaForm := TTabletaFirmaForm.Create( Application.MainForm );
     If   Assigned( TabletaFirmaForm )
     then TabletaFirmaForm.Show;
end;

function DestroyTabletaFirmaForm( CheckClose : Boolean = True ) : Boolean;

var CanClose : Boolean;

begin
     CanClose := True;
     If   Assigned( TabletaFirmaForm )
     then begin
          If   CheckClose
          then TabletaFirmaForm.FormCloseQuery( nil, CanClose );
          If   CanClose
          then TabletaFirmaForm.Release;
          end;
     Result := CanClose;
end;

procedure TTabletaFirmaForm.FormKeyDown( Sender : TObject; var Key : Word; Shift : TShiftState);
begin
     If   Key=VK_ESCAPE
     then Close;
end;

procedure TTabletaFirmaForm.FormDeactivate(Sender: TObject);
begin
     Release;
end;

procedure TTabletaFirmaForm.FormClose( Sender : TObject; var Action: TCloseAction);
begin
     Action := caFree;
end;

procedure TTabletaFirmaForm.FormDestroy(Sender: TObject);
begin
     TabletaFirmaForm := nil;
end;

procedure TTabletaFirmaForm.FormCloseQuery( Sender : TObject; var CanClose : Boolean );
begin
     If   TabletaFirmaDataModule.PenData.Count>10
     then CanClose := ShowNotification( ntQuestionWarning, RsMsg1, RsMsg2 )=mrYes
end;

procedure TTabletaFirmaForm.TabletImageMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

var  I : SmallInt;
     pt : TPoint;

begin
     pt := Point( X, Y );
     For I := 0 to 2 do
       If   TabletaFirmaDataModule.Buttons[ I ].Bounds.Contains( pt )
       then begin
            TabletaFirmaDataModule.Buttons[ I ].DoOnClick;
            Break;
            end;
end;

end.

