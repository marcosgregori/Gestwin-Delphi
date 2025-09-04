unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls,

  IniFiles,

  Menus,

  dxGDIPlusClasses,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxImage,
  cxGroupBox,
  cxProgressBar,
  cxButtons,
  cxCheckBox,
  cxLabel,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit, dxUIAClasses;

type
  TMainForm = class(TForm)
    MainPanel: TcxGroupBox;
    Panel3: TcxGroupBox;
    Panel4: TcxGroupBox;
    FileNameLabel: TcxLabel;
    Label1: TcxLabel;
    Label4: TcxLabel;
    Image4: TcxImage;
    ReiniciarCtrl: TcxCheckBox;
	   ActualizarAyudasCtrl: TcxCheckBox;
    VersionBetaCtrl: TcxCheckBox;
    CaptionPanel: TcxGroupBox;
    Image1: TcxImage;
    Label2: TcxLabel;
    Shape4: TShape;
    CancelarButton: TcxButton;
    ActualizarButton: TcxButton;
    VersionLabel: TcxLabel;
    Shape1: TShape;
    GlobalProcessLabel: TcxLabel;
    ServidorCtrl: TcxComboBox;
    cxGroupBox1: TcxGroupBox;
    PercentLabel: TcxLabel;
    ProgressBar: TcxProgressBar;
    procedure cancelarButtonClick(Sender: TObject);
    procedure ActualizarButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CaptionPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
     procedure WMRestarting( var message : TMessage ); message WM_USER;

  protected
  public
  end;

var
  MainForm: TMainForm;

implementation

uses   Files,
       ZLib,
       LibUtils,

       AppManager,
       InfoInstall,
       RpcInstall,

       MessageBox;

{$R *.DFM}

resourceString
     RsMsg1  = '¿Esta seguro de que desea cancelar el proceso de actualización?';
     RsMsg2  = 'Puede cancelar el proceso sin afectar al estado actual de la aplicación.'#13'Su versión actual de GESTWIN no será modificada.';
     RsMsg3  = 'Esta es una versión de evaluación de GESTWIN';
     RsMsg4  = 'Las versiones de evaluación no son actualizables.'#13'Si desea disponer de una versión actualizada deberá instalar una nueva copia de la aplicación.';
     RsMsg11 = 'No se puede ejecutar la actualización de aplicaciones sobre una dirección remota.';
     RsMsg12 = 'Debe realizar el proceso de actualización desde el servidor en el que está instalado GESTWIN.';


procedure TMainForm.CancelarButtonClick(Sender: TObject);
begin
     If   Info.Processing and not Rpc.Cancelled
     then begin
          If   ShowNotification( ntQuestionWarning, RsMsg1, RsMsg2 )=mrYes
          then Rpc.Cancelled := True;
          end
     else Application.Terminate;
end;

procedure TMainForm.CaptionPanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

const sc_DragMove = $F012;

begin
     ReleaseCapture;
     Perform( wm_SysCommand, sc_DragMove, 0 );
end;

procedure TMainForm.ActualizarButtonClick(Sender: TObject);
begin

     try

       Info.BetaVersion := BetaVersion and VersionBetaCtrl.Checked;
       If   DeveloperVersion
       then begin
            Info.Host := ServidorCtrl.EditValue;
            Info.Port := 80 + ServidorCtrl.ItemIndex;   // 80, 81, u 82
            end;

       CancelarButton.SetFocus;
       ActualizarButton.Enabled := False;
       ActualizarAyudasCtrl.Enabled := False;
       ReiniciarCtrl.Enabled := False;
       VersionBetaCtrl.Enabled := False;
       ServidorCtrl.Enabled := False;

       Info.Actualizacion( FileNameLabel, GlobalProcessLabel, PercentLabel, ProgressBar, ActualizarAyudasCtrl.Checked, ReiniciarCtrl.Checked );

     finally
       ActualizarButton.Enabled := True;
       ReiniciarCtrl.Enabled := True;
	      ActualizarAyudasCtrl.Enabled := True;
       VersionBetaCtrl.Enabled := True;
       ServidorCtrl.Enabled := True;
       end;

end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
     try

       ReadIniFile;

       CheckProtection( True, False );

       If   not SpEvaluation
       then With ProtectionRec do
              begin
              var VersionText := 'Versión : ' + IntToStr( ProgramVersion ) { + '.' +
                                                IntToStr( ProgramRelease ) } ;
              If   Sp64BitsServer
              then StrAdd( VersionText, ' ( 64bit )' );
              StrAdd( VersionText, '. Registro : ' + IntToStr( SpRegNumber )  + '.' );
              VersionLabel.Caption := VersionText;
              end;

       ServidorCtrl.ItemIndex := 0;

     except
       Application.Terminate;
       end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);

var   ProcessInformation : TProcessInformation;
      CommandLine : String;

begin
     // Si se ha actualizado GdUpd es necesario volver a ejecutar la aplicación para aplicar los cambios

     If   ( ModalResult=mrOk ) and GdUpdUpdated
     then begin
          CommandLine := 'gdupd.exe ' + AppShortName + ' -E';
          ProcessExecute( ProcessInformation, CommandLine, ApplicationPath, SW_SHOWNORMAL )
          end;

end;

procedure TMainForm.FormShow(Sender: TObject);

var  Dt  : Integer;

begin
     Dt := GetDriveType( PChar( Copy( ApplicationPath, 1, 3 ) ) );   // No se admiten paths UNC
     If   ( Dt=DRIVE_Remote ) or
          ( Dt=0 )                   // No se ha podido determinar
     then begin
          ShowNotification( ntStop, RsMsg11, RsMsg12 );
          Application.Terminate;
          end;

     VersionBetaCtrl.Visible := BetaVersion;
     ServidorCtrl.Visible := DeveloperVersion;

     If   Restarting
     then PostMessage( Handle, WM_USER, 0, 0 );

end;

procedure TMainForm.WMRestarting(var message: TMessage);
begin
     ActualizarButtonClick( nil );
end;

end.


