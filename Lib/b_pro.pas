unit b_pro;

interface

uses  Windows,
      Messages,
      Classes,
      ImgList,
      ComCtrls,
      Grids,
      Graphics,
      Controls,
      ExtCtrls,
      StdCtrls,
      Buttons,
      Forms,

      AppContainer,
      AppForms,
      Menus,
      cxLookAndFeelPainters,
      cxButtons,

      cxGraphics, cxLookAndFeels, cxControls,
      cxContainer, cxEdit, dxSkinsCore, cxProgressBar, dxBar, dxGDIPlusClasses,
      f_prg, dxSkinsDefaultPainters,

      AppManager, dxUIAClasses;

type

  TProcessForm = class(TgxForm)
    ButtonsPanel: TPanel;
    AceptarButton: TgBitBtn;
    CancelButton: TgBitBtn;
    PrintButton: TgBitBtn;
    ProcessFrame: TProcessFrame;
    procedure AceptarButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

    FProcessCaption : String;
    FOnExecuteProcess,
    FOnCancelProcess : TSimpleEvent;
    FCancelable,
    FAutoClosing : Boolean;

    procedure CMStartProcess ( var message : TMessage );  message CM_STARTPROCESS;

    procedure DoOnStartProgress( MarqueeMode : Boolean = False; MaxValue : LongInt = 100 );
    function DoOnProgress( ObjectName : String = ''; Percent1 : SmallInt = 0; Percent2 : SmallInt = 0 ) : Boolean;
    procedure DoOnEndProgress;

  protected

  public

    procedure FinalizeProcessForm;

    property  OnExecuteProcess : TSimpleEvent read FOnExecuteProcess write FOnExecuteProcess;
    property  OnCancelProcess : TSimpleEvent read FOnCancelProcess write FOnCancelProcess;

  end;

// Solo hay uno activo en un momento determinado

var ProcessForm : TProcessForm = nil;

function CreateProcessForm( ExecuteProcess   : TSimpleEvent;
                            ProcessCaption   : String = '';
                            Cancelable       : Boolean = True;
                            AutoClosing      : Boolean = False;
                            OnCancelProcess  : TSimpleEvent = nil  ) : Boolean;

implementation

uses LibUtils,
     Printers,
     ClipBrd,
     SysUtils,

     NexusRpcData,

     b_msg;


{$R *.dfm}

resourceString
       RsMsg1 = 'Proceso realizado correctamente%s%s';
       RsMsg2 = 'Procesando : ';
       RsMsg3 = 'Proceso cancelado por el usuario.';
       RsMsg4 = 'El proceso NO ha finalizado correctamente.';
       RsMsg5 = 'Información sobre el proceso realizado.';
       RsMsg6 = 'El contenido de la ventana de proceso ha sido enviado a la impresora activa.';
       RsMsg7 = ' Revise, si lo desea, los mensajes generados y pulse [Aceptar].';
       RsMsg8 = ', pero con advertencias.';

function CreateProcessForm( ExecuteProcess   : TSimpleEvent;
                            ProcessCaption   : String = '';
                            Cancelable       : Boolean = True;
                            AutoClosing      : Boolean = False;
                            OnCancelProcess  : TSimpleEvent = nil ) : Boolean;
begin
     Result := False;
     ProcessForm := TProcessForm.Create( Application.MainForm );
     If   Assigned( ProcessForm )
     then With ProcessForm do
            begin
            try
              FOnExecuteProcess := ExecuteProcess;
              FProcessCaption := ProcessCaption;
              FCancelable := Cancelable;
              FAutoclosing := Autoclosing;
              FOnCancelProcess := OnCancelProcess;
              ShowModal;
            finally
              Result := ProcessForm.ProcessFrame.Error;
              Free;
              end;
            end;
end;

procedure TProcessForm.AceptarButtonClick(Sender: TObject);
begin
     If   ProcessFrame.Ended
     then Release;
end;

procedure TProcessForm.FormShow(Sender: TObject);
begin

     If   not FCancelable
     then CancelButton.Enabled := False;

     ButtonsPanel.Visible := not FAutoclosing;

     PostMessage( Handle, CM_STARTPROCESS, 0, 0 );

end;

procedure TProcessForm.FormCreate(Sender: TObject);
begin
     NexusRpc.OnStartProgress := DoOnStartProgress;
     NexusRpc.OnProgress := DoOnProgress;
     NexusRpc.OnEndProgress := DoOnEndProgress;
end;

procedure TProcessForm.FormDestroy(Sender: TObject);
begin
     NexusRpc.OnStartProgress := nil;
     NexusRpc.OnProgress := nil;
     NexusRpc.OnEndProgress := nil;

     ProcessForm := nil;
end;

procedure TProcessForm.CMStartProcess( var message : TMessage );
begin
     try
       BringToFront;
       If   FProcessCaption<>''
       then ProcessFrame.AddMsg( ntHeader, FProcessCaption );
       If   Assigned( FOnExecuteProcess )
       then FOnExecuteProcess;
     except
      end;
     FinalizeProcessForm;
end;

procedure TProcessForm.DoOnEndProgress;
begin
     ProcessFrame.HideProgressBar;
end;

procedure TProcessForm.DoOnStartProgress( MarqueeMode : Boolean = False; MaxValue : Integer = 100 );
begin
     ProcessFrame.ShowProgressBar( MarqueeMode, MaxValue );
end;

function TProcessForm.DoOnProgress( ObjectName : String = '';
                                    Percent1   : SmallInt = 0;
                                    Percent2   : SmallInt = 0 ): Boolean;
begin
     With ProcessFrame do
       begin
       If   MarqueeMode
       then IncProgressBar
       else SetProgressBarPercent( Percent1 );
       Result := Canceled;
       end;
end;

procedure TProcessForm.FinalizeProcessForm;
begin
     try
       If   ProcessFrame.ShutDown
       then Close
       else With ProcessFrame do
              begin

              If   Canceled
              then AddMsg( ntError, RsMsg3 )
              else If   Error
                   then begin
                        If   LastNotificationType<>ntFailed
                        then AddMsg( ntFailed, RsMsg4 );
                        end
                   else begin
                        If   Warning
                        then AddMsg( ntWarning, Format( RsMsg1, [ RsMsg8, RsMsg7 ] ) )
                        else If   LastNotificationType<>ntCorrect
                             then AddMsg( ntCorrect, Format( RsMsg1, [ '.', RsMsg7 ] ) );
                        end;

              If   FAutoClosing and not ( Error or Warning )
              then Close
              else begin
                   ButtonsPanel.Visible := True;
                   MessageBeep( mb_iconExclamation );
                   AceptarButton.Enabled := True;
                   CancelButton.Enabled := False;
                   PrintButton.Enabled := True;
                   ModalResult := mrNone;
                   AceptarButton.SetFocus;
                   Ended := True;
                   BringToFront;
                   end;

              end;

     finally
       ApplicationContainer.ProcessLog( FProcessCaption, ProcessFrame.LogMsg );
       end;
end;

procedure TProcessForm.CancelButtonClick(Sender: TObject);
begin
     If   ProcessFrame.Ended
     then Release
     else If   ShowNotification( ntQuestionWarning, RsgMsg401 )=mrYes
          then begin
               ProcessFrame.Canceled := True;
               CancelButton.Enabled := False;
               If   Assigned( FOnCancelProcess )
               then FOnCancelProcess;
               end;
end;

procedure TProcessForm.PrintButtonClick(Sender: TObject);
begin
     ProcessFrame.Print;
end;

end.
