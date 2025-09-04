
unit b_cop;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, FileCtrl, ComCtrls,

  Mask, Menus, cxLookAndFeelPainters, cxButtons, ShlObj,
  cxShellCommon, cxControls, cxContainer, cxShellTreeView, cxGraphics,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCheckBox, dxSkinsCore,
  dxSkinsDefaultPainters,
  cxLookAndFeels, cxShellControls, cxTreeView, dxGDIPlusClasses, cxImage,
  cxLabel, cxGroupBox, cxProgressBar,

  ZipForge,
  InfoInstall,
  InstallerClass, dxUIAClasses;


type
  TInstallForm = class(TForm)
    Label6: TcxLabel;
    FileNameLabel: TcxLabel;
    InformationDirLabel: TcxLabel;
    Label9: TcxLabel;
    AppNameCtrl: TcxComboBox;
    Label11: TcxLabel;
    ProgressBar: TcxProgressBar;
    PublicarButton: TcxButton;
    CancelarButton: TcxButton;
    CaptionPanel: TcxGroupBox;
    Shape4: TShape;
    cxLabel1: TcxLabel;
    Image1: TcxImage;
    cxLabel2: TcxLabel;
    DestinoBtn: TcxButton;
    TargetDirLabel: TcxLabel;
    OpenDialog: TFileOpenDialog;
    MainPanel: TcxGroupBox;
    Panel3: TcxGroupBox;
    procedure FormCreate(Sender: TObject);
    procedure AppNameCtrlPropertiesChange(Sender: TObject);
    procedure DestinoBtnClick(Sender: TObject);
    procedure CancelarButtonClick(Sender: TObject);
    procedure PublicarButtonClick(Sender: TObject);
    procedure CaptionPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private

    Installer : TInstaller;
    StartUpInfo : TProcessInformation;
    FirstDirectory,
    Working,
    ProcessCanceled : Boolean;
    SourceFileDate,
    TargetFileDate : TDateTime;

    procedure DoOnProgress(     Sender        : TObject;
                                FileName      : TZFString;
                                Progress      : double;
                                Operation     : TZFProcessOperation;
                                ProgressPhase : TZFProgressPhase;
                            var Cancel        : boolean );
    procedure SetTargetBaseDir(Value: String);

  public

    // currentDisk           : SmallInt;
    bacthFileOpened,
    compressFiles,
    Correct : boolean;
    SearchRec : TSearchRec;
    SourceDrive : string;
    TargetBaseDir : string;

    zBufferString         : array[ 0..128 ] of char;

    BufferString,
    macroString,
    TargetCompletePath,
    SourcePathAndName,
    TargetPathAndName,
    SourcePath,
    TargetPath,
    TargetName,
    SourceName,
    SourceExt,
    CurrentRemoteDir      : string;

    fileComponent         : TFileComponent;
    sourceFile            : file;
    fileSize              : integer;

    batchFile             : Text;

    lastItemIndex         : SmallInt;

    processHandle,
    exitCode              : DWORD;


    constructor create( aOwner : TComponent ); override;
    destructor  destroy;                       override;

    procedure CheckIDD;
    procedure SetApplicationName;
    procedure ProcessApplication;
    procedure Publica;
  end;

var InstallForm: TInstallForm = nil;

implementation

{$R *.DFM}

uses  DateUtils,
      LibUtils,
      Files,

      AppManager,

      MessageBox;

const LowestStrDate  = '01/01/1600 00:00:00';
      ServerPath = 'D:\Soporte\Distribucion\Version 11.0';
      LocalPath  = 'F:\Desktop\Distribucion';

resourceString
      RsMsg1   = 'El fichero [%s] no se encuentra en la unidad destino.';
      RsMsg3   = 'Se ha producido un error leyendo el fichero de configuración.';
      RsMsg4   = 'Inserte el disquette de distribución número %d en la unidad %s.';
      RsMsg5   = 'Pulse <Intro> o haga clic en el botón aceptar cuando este listo.';
      RsMsg6   = 'Se ha producido un error al acceder a la unidad de disco.';
      RsMsg7   = 'El proceso de copia NO ha finalizado satisfactoriamente.';
      RsMsg8   = 'Debe realizarlo de nuevo.';
      RsMsg9   = 'Copia realizada satisfactoriamente.';
      RsMsg10  = '¿Esta seguro de que desea cancelar el proceso?';
      RsMsg11  = 'Se ha producido un error mientras se copiaba el fichero %s.';
      RsMsg12  = 'Pulse <Intro> o haga click en  el botón [Aceptar] para reintenta la copia.';
      RsMsg15  = 'El fichero de distribución [%s] no existe.';
      RsMsg17  = 'Comprimiendo ...';
      RsMsg18  = 'El fichero [%s] no existe, y por lo tanto no puede ser copiado.';
      RsMsg19  = 'Verificando la existencia de los ficheros ...';
      RsMsg20  = 'Segmentando el fichero [%s] ...';
      RsMsg21  = 'Error de E/S nº : %d.';

constructor TInstallForm.create( aOwner : TComponent );
begin
     inherited Create( aOwner );
     Installer := TInstaller.Create;
end;

procedure TInstallForm.DestinoBtnClick(Sender: TObject);
begin
     OpenDialog.DefaultFolder := TargetDirLabel.Caption;
     If   OpenDialog.Execute
     then SetTargetBaseDir( AddPathDelim( OpenDialog.FileName ) );
end;

destructor TInstallForm.destroy;
begin

     Installer.Free;

     inherited Destroy;
end;

procedure TInstallForm.AppNameCtrlPropertiesChange(Sender: TObject);
begin
     CheckIDD;
end;
procedure TInstallForm.CancelarButtonClick(Sender: TObject);
begin
     If   Working
     then begin
          If   ShowNotification( ntQuestion, RsMsg10, '' )=mrYes
          then ProcessCanceled := True;
          end
     else Application.Terminate;
end;

procedure TInstallForm.CaptionPanelMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

const sc_DragMove = $F012;

begin
     ReleaseCapture;
     Perform( wm_SysCommand, sc_DragMove, 0 );
end;

procedure TInstallForm.PublicarButtonClick(Sender: TObject);

var  Index : SmallInt;

begin
     try

       CancelarButton.SetFocus;
       PublicarButton.Enabled := False;
       AppNameCtrl.Enabled := False;

       If   AppNameCtrl.ItemIndex=0  // Todas las aplicaciones
       then try
              For Index := 1 to AppNameCtrl.Properties.Items.Count - 1 do
                begin

                AppNameCtrl.ItemIndex := Index;
                TargetPath := Trim( AddPathDelim( AddPathDelim( TargetBaseDir ) + IntToStr( Index ) + '. Gestwin ' + AppNameCtrl.Text ) );
                ProcessApplication;

                If   ProcessCanceled
                then Break;

                end;

            finally
              AppNameCtrl.ItemIndex := 0;
            end
       else begin
            TargetPath := TargetBaseDir;
            ProcessApplication;
            end;

       If   ProcessCanceled
       then ShowNotification( ntStop, RsMsg7, RsMsg8 )
       else ShowNotification( ntInformation, RsMsg9, '' );

     finally
       AppNameCtrl.Enabled := True;
       PublicarButton.Enabled := True;
       end;
end;


procedure TInstallForm.SetTargetBaseDir( Value : String );
begin
     TargetDirLabel.Caption := Value;
     TargetBaseDir := Value;
end;

procedure TInstallForm.SetApplicationName;
begin
     If   AppNameCtrl.ItemIndex>=0
     then begin
          AppShortName := AppNameCtrl.Properties.Items[ AppNameCtrl.ItemIndex ];
          Installer.InfFileName := Installer.SourceInstallPath + 'gd_' + AppShortName + '.idd';
          end
     else Installer.InfFileName := '';
end;

procedure TInstallForm.ProcessApplication;

var   Index : SmallInt;
      ioStatus : Integer;

function strParamCount( var str : string ) : byte;

var   Index : SmallInt;

begin
     Result := 0;
     For Index := Length( str ) downto 0 do
       If   str[ Index ]='%'
       then inc( Result );
end;

begin

   { empieza la copia de ficheros }

   Working := True;
   PublicarButton.Enabled := False;
   FirstDirectory := True;

   try

     // currentDisk         := 0;
     ProcessCanceled := False;

     SourcePath := Installer.SourceInstallPath; // UpperCase( informationDirLabel.Caption ) + '\';
     SourceDrive := Copy( SourcePath, 1, 3 ); // UpCase( InformationDriveCtrl.drive ) + ':\';

     SetApplicationName;

     If   not FileExists( Installer.InfFileName )
     then begin
          ShowNotification( ntWarning, Format( RsMsg15, [ Installer.InfFileName ] ), '' );
          Exit;
          end;

     With Installer do
       begin

       ReadConfigFile( SourcePath );

       FileNameLabel.Caption  := RsMsg19;

       For Index := 0 to FileList.Count - 1 do
         begin
         FileComponent := FileList.Items[ Index ];
         BufferString  := ExpandPathAndName( SourcePath, FileComponent.PathAndName, fpSource );

         FileNameLabel.Caption := BufferString;
         Application.ProcessMessages;

         If   not FileExists( BufferString )
         then If   not DirectoryExists( BufferString )
              then begin
                   ShowNotification( ntStop, Format( RsMsg18, [ BufferString ] ), '' );
                   Abort;
                   end;

         end;

       FileNameLabel.Caption := '';
       CurrentRemoteDir := '';
       Application.ProcessMessages;

       Index := 0;

       While ( Index<FileList.Count ) and not ProcessCanceled do
          With TFileComponent( FileList.Items[ Index ] ) do
            begin

            If   not ProcessCanceled
            then begin

                 Correct := True;
                 SourcePathAndName := ExpandPathAndName( SourcePath, PathAndName, fpSource );
                 TargetPathAndName := ExpandPathAndName( TargetPath, PathAndName, fpDistribution );

                 TargetCompletePath := RemovePathDelim( ExtractFilePath( TargetPathAndName ) );

                 TargetName := ExtractFileName( TargetPathAndName );
                 SourceName := ExtractFileName( SourcePathAndName );

                 SourceExt := ExtractFileExt( SourcePathAndName );

                 If   TargetCompletePath<>CurrentRemoteDir
                 then begin
                      If   FirstDirectory
                      then begin
                           If   not ( ( AppNameCtrl.ItemIndex=0 ) and ( TargetCompletePath=TargetBaseDir ) )   // Evito borrar por error el directorio de distribución
                           then EraseDirectory( TargetCompletePath, False );
                           FirstDirectory := False;
                           end;
                      CreateDirPath( TargetCompletePath );
                      CurrentRemoteDir := TargetCompletePath;
                      end;

                 FileNameLabel.Caption := ExtractFileName( RemovePathDelim( SourcePathAndName ) );
                 Application.ProcessMessages;

                 If   not ProcessCanceled
                 then repeat

                        If   SourceName=''   // es un directorio
                        then CopyDirectory( SourcePathAndName, TargetPathAndName, [ 'nxTrans.cfg' ], [ cfOverwrite, cfNotifyError ] )
                        else Correct := CopyFile( SourcePathAndName, TargetPathAndName, [ cfOverwrite, cfNotifyError ] );

                        If   not Correct
                        then ProcessCanceled := ShowNotification( ntQuestionWarning, Format( RsMsg11, [ SourcePathAndName ] ), RsMsg12 )<>mrOk;

                      until ProcessCanceled or Correct;

                 end;

            Inc( Index );
            end;

       end;

     If   not ProcessCanceled and Correct
     then Publica;

   finally

     Working := False;
     PublicarButton.Enabled := True;

     FileNameLabel.Caption  := '';
     Application.ProcessMessages;

     end;
end;

procedure TInstallForm.Publica;

var  LocalTargetDirectory,
     TargetZipFileName,
     TargetExeFileName : String;
     ZipForge : TZipForge;

begin
     ProgressBar.Visible := True;
     ZipForge := TZipForge.Create( Self );
     With ZipForge do
       try

         OnFileProgress := DoOnProgress;

         TargetZipFileName := TemporalDataPath + 'GESTWIN' + AppShortName + '.zip';
         TargetExeFileName := TemporalDataPath + 'GESTWIN' + AppShortName + '.exe';

         CompressionLevel := clMax;

         FileName := TargetZipFileName;
         EraseFile( TargetZipFileName );
         OpenArchive;

         FileNameLabel.Caption := TargetPath;
         Application.ProcessMessages;

         FileMasks.Clear;
         FileMasks.Add( '*.*' );
         ExclusionMasks.Clear;
         // ExclusionMasks.Add( 'instalar.exe' );

         BaseDir := TargetPath;
         AddFiles;

         CloseArchive;

         SFXStub := 'instalar.exe';

         MakeSFX( TargetExeFileName );

         CopyFile( TargetExeFileName, AddPathDelim( TargetBaseDir ) + ExtractFileName( TargetExeFileName ) );

         EraseFile( TargetZipFileName );  // Borro los ficheros temporales de trabajo
         EraseFile( TargetExeFileName );
       finally
         FileNameLabel.Caption := '';
         ProgressBar.Position := 0;
         ProgressBar.Visible := False;
         ZipForge.Free;
         end;
end;

procedure TInstallForm.DoOnProgress(     Sender        : TObject;
                                         FileName      : TZFString;
                                         Progress      : double;
                                         Operation     : TZFProcessOperation;
                                         ProgressPhase : TZFProgressPhase;
                                     var Cancel        : boolean );
begin
     FileNameLabel.Caption := ExtractFileName( FileName );
     ProgressBar.Position := Trunc( Progress );
     Application.ProcessMessages;
     Cancel := ProcessCanceled;
end;


procedure TInstallForm.CheckIDD;

var   Exists : boolean;

begin
     With InformationDirLabel do
       begin
       If   AppNameCtrl.ItemIndex=0
       then begin
            Exists := True;
            Caption := 'Todos';
            end
       else begin
            SetApplicationName;
            Caption := Installer.InfFileName;
            Exists := FileExists( Installer.InfFileName );
            end;

       If   Exists
       then Font.Color := clGreen
       else Font.Color := clRed;
       PublicarButton.Enabled := Exists;
       end;
end;

procedure TInstallForm.FormCreate(Sender: TObject);

begin
     if   DirectoryExists( ServerPath )
     then SetTargetBaseDir( ServerPath )
     else SetTargetBaseDir( LocalPath );

     CheckIDD;
end;



end.
