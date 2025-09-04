unit b_cda;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons,

  nxllTypes,
  nxllUtils,

  AppContainer,
  AppForms, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, dxSkinsCore, dxSkinsDefaultPainters,

  Gim00Fields, cxLabel, cxGraphics, cxLookAndFeels, dxGDIPlusClasses, cxImage,
  cxGroupBox;

type
  TcontrolAccesosForm = class(TgxForm)
    ButtonsPAnel: TgxEditPanel;
    Panel2: TgxEditPanel;
    PasswordEdit: TcxTextEdit;
    Image1: TcxImage;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    UserNameLabel: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    CodigoCtrl: TcxTextEdit;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private

  protected
  class var
    UsuarioFields : TUsuarioFields;
  public

    constructor Create( Owner : TComponent; UsuarioFields : TUsuarioFields ); reintroduce;

  end;

var ControlAccesosForm: TcontrolAccesosForm = nil;

function CheckPassword( UsuarioFields : TUsuarioFields; out PalabraPaso : String ) : Boolean;

implementation

{$R *.DFM}

uses   LibUtils,
       AppManager,

       b_msg;

constructor TControlAccesosForm.Create( Owner         : TComponent;
                                        UsuarioFields : TUsuarioFields );
begin
     TControlAccesosForm.UsuarioFields := UsuarioFields;
     inherited Create( Owner );
end;

function CheckPassword(     UsuarioFields : TUsuarioFields;
                        out PalabraPaso   : String ) : Boolean;
begin
     Result := False;
     ControlAccesosForm := TControlAccesosForm.Create( Application.MainForm, UsuarioFields );
     try
       Result := ControlAccesosForm.ShowModal=mrOk;
       PalabraPaso := ControlAccesosForm.PasswordEdit.Text;
     finally
       ControlAccesosForm.Free;
       end;
end;

procedure TcontrolAccesosForm.FormCloseQuery(     Sender   : TObject;
                                              var CanClose : Boolean);
begin
     If   ( ModalResult=mrOk ) and ( UsuarioFields.Password.Value<>nxCalcShStrELFHash( AnsiString( PasswordEdit.Text ) ) )
     then begin
          ShowNotification( ntStop, RsgMsg399, RsgMsg400 );
          PasswordEdit.SetFocus;
          CanClose := False;
          end;
end;

procedure TcontrolAccesosForm.FormShow(Sender: TObject);
begin
     With UsuarioFields do
       begin
       CodigoCtrl.Text := Codigo.Value;
       UserNameLabel.Caption := Nombre.Value;
       end;
end;

end.
