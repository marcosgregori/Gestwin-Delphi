
unit b_reg;

interface

uses  ComCtrls, StdCtrls, Controls, ExtCtrls, Buttons, Classes, Messages, Forms, Windows,

      AppContainer, Graphics, AppForms, Menus, cxLookAndFeelPainters, cxButtons,
      cxGraphics, cxLookAndFeels, dxGDIPlusClasses, LibUtils,

      AppManager, dxSkinsCore, dxSkinsDefaultPainters, cxControls,
  cxContainer, cxEdit, cxImage, cxGeometry, dxFramedControl, dxPanel;

type
  TregForm = class(TgxForm)
    cancelBtn: TgBitBtn;
    Panel1: TdxPanel;
    infoLabel: TLabel;
    Label1: TLabel;
    Shape1: TShape;
    progressBar: TProgressBar;
    Image1: TcxImage;
    procedure cancelBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private

    fOnExecuteProcess   : TCheckEvent;

    procedure CMStartProcess ( var message : TMessage  );  message CM_STARTPROCESS;

  public
    aborted       : boolean;

    procedure muestraNivel( Porcentaje : byte );
    property OnExecuteProcess : TCheckEvent read fOnExecuteProcess write fOnExecuteProcess;
  end;

var  RegForm : TregForm = nil;

function CreateRegForm( ExecuteProcess : TCheckEvent ) : Integer;

implementation

uses b_msg;

{$R *.dfm}

function CreateRegForm( ExecuteProcess : TCheckEvent ) : Integer;
begin
     Result := -1;
     RegForm := TregForm.Create( Application.MainForm );
     If   Assigned( RegForm )
     then With RegForm do
            try
              FOnExecuteProcess := ExecuteProcess;
              Result := ShowModal;
            finally
              Free;
              end;
end;

procedure TregForm.muestraNivel( Porcentaje : byte );
begin
     If   Porcentaje>100
     then Porcentaje := 100;
     progressBar.position := Porcentaje;
end;

procedure TregForm.CancelBtnClick(Sender: TObject);
begin
     If   ShowNotification( ntQuestionWarning, RsgMsg401 )=mrYes
     then Aborted := True;
end;

procedure TregForm.FormShow(Sender: TObject);
begin
     PostMessage( handle, CM_STARTPROCESS, 0, 0 );
end;

procedure TregForm.CMStartProcess( var message : TMessage  );

var  correct : boolean;

begin

     correct := false;

     try

       If   assigned( fOnExecuteProcess )
       then correct := fOnExecuteProcess;

     finally
     
       If   aborted
       then modalResult := mrAbort
       else If   correct
            then modalResult := mrOk
            else modalResult := mrCancel;

       end;
end;

end.
