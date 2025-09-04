
{$IMPORTEDDATA ON}

unit b_msg;

interface

uses
  SysUtils, Windows, Messages, Classes, Consts, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, Menus,
  cxLookAndFeelPainters, cxButtons, cxControls, cxPC, ImgList,
  cxContainer, cxEdit, cxTextEdit, cxMemo, cxLabel, cxGraphics, cxImage, cxLookAndFeels,
  cxGroupBox, dxGDIPlusClasses, cxClasses, dxBevel, dxSkinsCore, dxFormattedLabel,
  cxStyles, Data.DB, dxmdaset, DataManager, cxGridLevel, cxGrid, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  cxImageComboBox, cxGridCustomTableView, cxGridTableView, cxGridCustomView,

  LibUtils,
  AppManager,
  AppContainer,
  AppForms, dxUIAClasses;

type
  TMsgBoxForm = class(TgxForm)
    ButtonPanel: TcxGroupBox;
    YesButton: TgBitBtn;
    NoButton: TgBitBtn;
    AceptarButton: TgBitBtn;
    CancelarButton: TgBitBtn;
    PopupMenu: TPopupMenu;
    CopiarItem: TMenuItem;
    MainPanel: TcxGroupBox;
    IconPanel: TcxGroupBox;
    BoxImage: TcxImage;
    MessagePanel: TcxGroupBox;
    Shape1: TShape;
    MsgLabel: TdxFormattedLabel;
    Panel4: TcxGroupBox;
    DescLabel: TdxFormattedLabel;
    SystemLabel: TdxFormattedLabel;
    procedure AceptarBtnKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure CopiarItemClick(Sender: TObject);

  private

  public

  end;

  MsgBoxException = class( Exception )

    public

    FDescription : String;
    FNotificationType : TNotificationType;

    constructor Create( NotificationType : TNotificationType; Msg, Description : String );

    property Description : String read FDescription;
    end;

procedure ShowException( E : Exception; Component : TComponent = nil );
procedure ShowError( NotificationType : TNotificationType; const MsgStr : String; const DescStr : String );
procedure ShowLastError;

function  ShowNotification( NotificationType   : TNotificationType;
                            Header             : String;
                            Description        : String = '';
                            SystemMessage      : String = '';
                            ForceBoxMsg        : Boolean = False ) : TModalResult;


var   MsgBoxForm      : TMsgBoxForm = nil;

implementation

{$R *.dfm}

uses  ClipBrd,
      MsgFrame,

      nxllException,

      f_prg;

resourceString
  RsMsg1  = 'Se ha producido una excepción.'#13'El sistema ha devuelto el siguiente mensaje.';
  RsMsg2  = 'Mensaje del sistema : ';

var      LastNotificationType : TNotificationType;
         LastMsgStr : String;
         LastDescStr : String;

         ShowingNotification : Boolean = False;

function BoxMsg( NotificationType : TNotificationType;
                 Header           : String = '';
                 Description      : String = '';
                 SystemMessage    : String = '';
                 Severe           : Boolean = False ) : TModalResult;

const  StCaption : array[ 0..6 ] of String = ( 'ADVERTENCIA',
                                               'ATENCION',
                                               'CONFIRMACION',
                                               'ATENCION. CONFIRMACION',
                                               'INFORMACION',
                                               'ERROR',
                                               'EXCEPCION' );

var  CaptionIndex : SmallInt;
     ActiveForm : TForm;
     P : TPoint;
     MsgPart1,
     MsgPart2 : String;
     Sound : Integer;
     PageInx : SmallInt;

begin

     Screen.Cursor := crDefault;
     Result := mrIgnore;

     If   Application.Terminated
     then Exit;

     If   not ShowingNotification
     then try

            ShowingNotification := True;

            MsgBoxForm := nil;

            try

              If   ApplicationInitialized
              then try

                     Application.CreateForm( TMsgBoxForm, MsgBoxForm );

                     With MsgBoxForm do
                       begin

                       // Me aseguro un fondo destacable y legible en todas las pieles

                       If   Assigned( ApplicationContainer.AppSkinPainter )
                       then begin
                            MsgLabel.Style.TextColor := ApplicationContainer.AppSkinPainter.DefaultEditorTextColor( { AIsDisabled } False );
                            DescLabel.Style.TextColor := MsgLabel.Style.TextColor;
                            MessagePanel.Style.Color := ApplicationContainer.AppSkinPainter.DefaultEditorBackgroundColor( { AIsDisabled } False );
                            IconPanel.Style.Color := MessagePanel.Style.Color;
                            MainPanel.Style.Color := MessagePanel.Style.Color;
                            end;

                       CaptionIndex := 0;

                       case NotificationType of
                          ntWarning           : CaptionIndex := 0;
                          ntStop              : CaptionIndex := 1;
                          ntQuestion,
                          ntAcceptCancel      : CaptionIndex := 2;
                          ntQuestionWarning   : CaptionIndex := 3;
                          ntInformation,
                          ntHeaderInformation : CaptionIndex := 4;
                          ntError             : CaptionIndex := 5;
                          ntExceptionError,
                          ntAbort             : CaptionIndex := 6;
                          end;

                       YesButton.Visible := NotificationType in [ ntQuestion, ntQuestionWarning ];
                       NoButton.Visible := NotificationType in [ ntQuestion, ntQuestionWarning ];
                       AceptarButton.Visible := NotificationType in [ ntWarning, ntStop, ntInformation, ntError, ntExceptionError, ntAbort, ntAcceptCancel ];
                       CancelarButton.Visible := NotificationType in [ ntAcceptCancel ];

                       If   ( CaptionIndex=2 ) and Severe
                       then YesButton.TabOrder := 0;

                       If   CaptionIndex<5
                       then PageInx := CaptionIndex
                       else PageInx := 5;
                       Caption := StCaption[ CaptionIndex ];

                       BoxImage.Picture := ApplicationForms.NotificationImageCollection.Items[ PageInx ].Picture;
                       BoxImage.Update;

                       ActiveControl := FindNextControl( ButtonPanel, True, True, False );

                       // En algunas ocasiones (sobre todo en las excepciones) no puedo pasar una descripción del error
                       // De este modo puedo utilizar JoinMessage y pasar en Header ambos mensajes

                       If   Description=''
                       then If   SplitMessage( Header, MsgPart1, MsgPart2 )
                            then begin
                                 Header := MsgPart1;
                                 Description := MsgPart2;
                                 end;

                       MsgLabel.Caption := Header;

                       DescLabel.Caption := Description;

                       If   SystemMessage<>''
                       then begin
                            SystemLabel.Visible := True;
                            If   Severe
                            then SystemLabel.Caption := '[Color=#E8E8FF]' + SystemMessage + '[/Color]'
                            else SystemLabel.Caption := '[Color=Gray]' + RsMsg2 + SystemMessage + '[/Color]';
                            end;

                       case NotificationType of
                         ntError            : Sound := mb_iconExclamation;
                         ntExceptionError,
                         ntQuestionWarning,
                         ntWarning          : Sound := mb_iconExclamation;
                         ntStop             : Sound := mb_iconHand;
                         ntQuestion         : Sound := mb_iconQuestion;
                         else                 Sound := mb_iconExclamation;
                         end;

                       MessageBeep( Sound );

                       Result := ShowModal;
                       end;

                   finally
                     FreeAndNil( MsgBoxForm );
                     end

              else begin
                   MessageBeep( mb_IconExclamation );
                   Windows.MessageBox( 0, PChar( RemoveHTMLTags( Header + #13 + Description ) ), PChar( StCaption[ 1 ] ), mb_Ok );
                   end;

            except
              Result := mrCancel;
              end;

          finally
            ShowingNotification := False;
            end;
end;

function ShowNotification( NotificationType : TNotificationType;
                           Header           : String;
                           Description      : String = '';
                           SystemMessage    : String = '';
                           ForceBoxMsg      : Boolean = False ) : TModalResult;
begin
     Result := mrIgnore;
     If   Assigned( ProcessFrame ) and
          not ( csDestroying in ProcessFrame.Owner.ComponentState ) and
          not ( NotificationType in [ ntQuestion, ntQuestionWarning, ntAcceptCancel ] ) and
          not ForceBoxMsg
     then begin
          ProcessFrame.AddMsg( NotificationType, Header, True );
          If   Description<>''
          then ProcessFrame.AddMsg( NotificationType, Description, True );
          end
     else Result := BoxMsg( NotificationType, Header, Description, SystemMessage );
end;

procedure ShowException( E         : Exception;
                         Component : TComponent = nil );

var   Parent : TComponent ;
      Pcn,
      ExceptionMessage : String;

begin
     If   not ( E is EAbort )
     then begin
          If   Assigned( Component )
          then begin
               Parent := Component.GetParentComponent;
               If   Assigned( Parent )
               then Pcn := ' : ( ' + Parent.Name + ' / ' + Parent.ClassType.ClassName + ' )'
               else Pcn := '';
               ExceptionMessage := StrRemoveChars( E.Message, [ #0..#31 ] ) + '. [ ' + Component.Name + ' / ' + Component.ClassType.ClassName + Pcn + ' ]';
               end
          else ExceptionMessage := E.Message;

          If   ( E is EnxBaseException ) and ExceptionMessage.Contains( '[EAbort]' )
          then Exit;

          If   Assigned( Component ) and IsDesignTime
          then ExceptionMessage := ExceptionMessage + #13 + E.StackTrace;

          ShowNotification( ntExceptionError, RsMsg1, ExceptionMessage );
          end;

     If   Assigned( ApplicationContainer.OnSetHintCaption )
     then ApplicationContainer.OnSetHintCaption( nil, '' );
end;

procedure ShowError(       NotificationType : TNotificationType;
                     const MsgStr      : String;
                     const DescStr     : String );
begin
     LastNotificationType := NotificationType;
     LastMsgStr := MsgStr;
     LastDescStr := DescStr;
     PostMessage( Application.MainForm.Handle, CM_ERRORNOTIFICATION, 2, 0 );
end;

procedure ShowLastError;
begin
     ShowNotification( LastNotificationType, LastMsgStr, LastDescStr );
end;

procedure TMsgBoxForm.aceptarBtnKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
     If   Key=27
     then ModalResult := mrCancel;
end;

procedure TMsgBoxForm.CopiarItemClick(Sender: TObject);
begin
     Clipboard.AsText := DescLabel.Caption;
end;

{ MsgBoxException }

constructor MsgBoxException.Create( NotificationType: TNotificationType; Msg, Description: String);
begin
     inherited Create( Msg );
     FNotificationType := NotificationType;
     FDescription := Description;
end;

initialization

   OnShowException := ShowException;
   OnShowHintMessage := ShowHintMsg;
   OnShowNotification := ShowNotification;


end.

