unit b_mpr;

interface

uses Controls, StdCtrls, Buttons, ExtCtrls, Classes, Forms, Messages, windows,

     Graphics, AppForms, ComCtrls, Menus, cxLookAndFeelPainters,
     cxButtons, cxGraphics, cxLookAndFeels, cxControls, cxContainer, cxEdit,
     dxSkinsCore, dxGDIPlusClasses, cxImage, dxSkinsDefaultPainters,

     AppManager,
     AppContainer, cxLabel, cxProgressBar, cxGeometry, dxFramedControl,
  dxPanel, dxUIAClasses;

type
  TmodalProcessForm = class(TgxForm)
    cancelarBtn: TgBitBtn;
    Panel1: TdxPanel;
    ProcessLabel: TcxLabel;
    Bevel1: TBevel;
    ProgressBar: TcxProgressBar;
    Image1: TcxImage;
    HeaderLabel: TcxLabel;
    procedure CancelarBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fOnExcuteProcess   : TSimpleEvent;

    procedure CMStartProcess ( var message : TMessage  );  message CM_STARTPROCESS;

  public

    Cancelled : Boolean;

    procedure AddToProcessMsg( value : string );
    property OnExecuteProcess : TSimpleEvent read fOnExcuteProcess write fOnExcuteProcess;
  end;

var
  ModalProcessForm : TmodalProcessForm = nil;

procedure CreateModalProcessForm( ExecuteProcess : TSimpleEvent;
                                  CanBeCancelled : Boolean = False );
procedure DestroyModalProcessForm;

implementation

{$R *.DFM}

uses SysUtils,
     LibUtils,

     b_msg;

resourceString
     rsMsg1  = '¿Esta seguro de que desea interrumpir el proceso?';

procedure CreateModalProcessForm( ExecuteProcess : TSimpleEvent;
                                  CanBeCancelled : Boolean = False );
begin
     ModalProcessForm := TModalProcessForm.Create( Application.MainForm );
     If   Assigned( ModalProcessForm )
     then With ModalProcessForm do
            begin
            try
              CancelarBtn.Enabled := CanBeCancelled;
              FOnExcuteProcess := ExecuteProcess;
              ShowModal;
            finally
              Free;
              end;
            end;
end;

procedure destroyModalProcessForm;
begin
     If   Assigned( ModalProcessForm )
     then ModalProcessForm.release;
end;

procedure TmodalProcessForm.CancelarBtnClick(Sender: TObject);
begin
     If   ShowNotification( ntQuestionWarning, RsMsg1 )=mrYes
     then cancelled := true;
end;

procedure TmodalProcessForm.CMStartProcess( var message : TMessage  );
begin
     try
       If   Assigned( fOnExcuteProcess )
       then FOnExcuteProcess;
     finally
       If   Cancelled
       then ModalResult := mrCancel
       else ModalResult := mrOk;
      end;
end;

procedure TmodalProcessForm.FormShow(Sender: TObject);
begin
     PostMessage( Handle, CM_STARTPROCESS, 0, 0 );
end;

procedure TmodalProcessForm.AddToProcessMsg( Value : String );
begin
     If   ProcessLabel.Caption<>''
     then begin
          ProcessLabel.caption := ProcessLabel.caption + value;
          Application.ProcessMessages;
          end;
end;

end.

