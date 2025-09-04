unit MsgFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, AppContainer, dxGDIPlusClasses,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, cxImage, dxSkinsDefaultPainters,
  cxGroupBox, dxFormattedLabel,

  AppManager;

type
  TMessageFrame = class(TFrame)
    Panel6: TPanel;
    IconImage: TcxImage;
    BackPanel: TPanel;
    MsgLabel: TdxFormattedLabel;
    Shape1: TShape;
    DescLabel: TdxFormattedLabel;
    procedure FrameClick(Sender: TObject);
  private
  protected
  public
  end;

function MessageFrame : TMessageFrame;

procedure ShowHintMsg( MsgStr : String; DescStr : String; Control : TWinControl = nil; NotificationType : TNotificationType = ntExceptionError );

var   HintKeyPressed  : Boolean = False;

const MinHintFrameHeight = 112;

implementation

uses   dxDPIAwareUtils,

       AppForms;

{$R *.dfm}

var  FMessageFrame : TMessageFrame = nil;

     MessageTimerHandle : Word = 0;
     InitialCursorPos : TPoint;
     TimerCount : Integer;

function MessageFrame : TMessageFrame;
begin
     If   not Assigned( FMessageFrame )
     then If   Assigned( Application.MainForm )
          then FMessageFrame := TMessageFrame.Create( Application.MainForm );
     Result := FMessageFrame;
end;

procedure KillMessageTimer;
begin
     If   MessageTimerHandle<>0
     then begin
          KillTimer( 0, MessageTimerHandle );
          MessageTimerHandle := 0;
          end;
end;

procedure MessageTimerProc( Wnd: HWnd; Msg, TimerID, SysTime : Longint ); stdcall;

var  MousePos : TPoint;

begin
     MousePos := Mouse.CursorPos;

     If   ( TimerCount<=40 ) and
          ( ( MousePos.X<>InitialCursorPos.X ) or ( MousePos.Y<>InitialCursorPos.Y ) )
     then TimerCount := 40;

     If   HintKeyPressed or ( TimerCount>50 )
     then begin
          KillMessageTimer;
          FreeAndNil( FMessageFrame );
          end;

     Inc( TimerCount );
end;

procedure StartMessageTimer;
begin
     InitialCursorPos := Mouse.CursorPos;
     HintKeyPressed := False;
     TimerCount := 0;
     KillMessageTimer;
     MessageTimerHandle := SetTimer( 0, 0, 100, @MessageTimerProc );
     If   MessageTimerHandle=0
     then FreeAndNil( FMessageFrame );
end;

procedure ShowHintMsg( MsgStr           : String;
                       DescStr          : String;
                       Control          : TWinControl = nil;
                       NotificationType : TNotificationType = ntExceptionError );

var  Cp, Cpf : TPoint;
     IconIndex : SmallInt;

begin
     KillMessageTimer;
     FreeAndNil( FMessageFrame );
     If   Assigned( Application.MainForm )  and
          Assigned( Screen.ActiveForm ) and
          not ( fsModal in Screen.ActiveForm.FormState )  // Si se abre una ventana modal no se puede mostrar el frame correctamente
     then With MessageFrame do
            begin

            Height := 400;

            DescStr := StringReplace( DescStr, '|', #13, [ rfReplaceAll ] );

            case NotificationType of
              ntWarning          : IconIndex := 0;
              ntStop             : IconIndex := 1;
              ntQuestion,
              ntAcceptCancel     : IconIndex := 2;
              ntQuestionWarning  : IconIndex := 3;
              ntInformation      : IconIndex := 4;
              ntCorrect          : IconIndex := 6;
              else                 IconIndex := 5;    // Antes ya era la opción por defecto
              end;

            IconImage.Picture := ApplicationForms.NotificationImageCollection.Items[ IconIndex ].Picture;

            With MsgLabel do
             begin

             If   NotificationType in [ ntStop, ntError, ntExceptionError ]
             then Font.Color := $00004DEA
             else Font.Color := clHotLight;

             end;

            MsgLabel.Caption := MsgStr;
            DescLabel.Caption := DescStr;


            If   not Assigned( Control )
            then If   Assigned( Application.MainForm.ActiveMDIChild )
                 then If   Application.MainForm.ActiveMDIChild.ActiveControl is TcxCustomEdit
                      then Control := Application.MainForm.ActiveMDIChild.ActiveControl;

            With MessageFrame do
              begin

              Parent := Application.MainForm;

              Height := MsgLabel.Height + DescLabel.Height + ScaledToCurrent( 32 );
              If   Height<MinHintFrameHeight
              then Height := MinHintFrameHeight;

              If   SystemScaled or ApplicationScaled
              then begin
                   ChangeScale( AppScaleDPI, dxDefaultDPI );
                   Invalidate;
                   end;
              
              (*

              Cp.X := ( Application.MainForm.Width div 2 ) - ( MessageFrame.Width div 2 );
              Cp.Y := GetDesktopTop;

              If   Assigned( Control ) and Control.HasParent
              then begin
                   Cpf := Point( 0, 0 );  // Control.Width + 2
                   Cpf := Control.ClientToScreen( Cpf );
                   Cpf.X := Cpf.X + Control.Width + 6;
                   Cpf.Y := Cpf.Y - Control.Height;
                   Cpf := Application.MainForm.ScreenToClient( Cpf );
                   If   ( Cpf.X + MessageFrame.Width<Application.MainForm.Width ) and
                        ( Cpf.Y + MessageFrame.Height<Application.MainForm.Height - GetDesktopTop { ApplicationContainer.GetMainPanelsHeight }  )
                   then Cp := Cpf;
                   end;
              *)

              Left := ( Application.MainForm.Width div 2 ) - ( MessageFrame.Width div 2 );
              Top := GetDesktopTop;

              MessageFrame.BringToFront;
              Visible := True;
              end;

            MessageBeep( mb_iconAsterisk );
            StartMessageTimer;
            end
     else ShowNotification( ntExceptionError, MsgStr, DescStr );

end;

procedure TMessageFrame.FrameClick(Sender: TObject);
begin
     TimerCount := 51;
end;

end.
