
unit Main;

interface

uses
  WinAPI.Windows,

  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.IniFiles,
  Data.DB,

  ZipForge,

  nxdb, DataManager, SxBase, SxMain, ScroogeXHTML,
  nxsdServerEngine, nxsrServerEngine, nxllComponent, Vcl.Dialogs, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, cxButtons, dxGDIPlusClasses, cxImage, cxLabel, cxGroupBox,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCheckBox, cxProgressBar,

  Gim00Fields, dxSkinsCore, nxdbBackupController,
  nxreRemoteServerEngine, nxllTransport, nxptBasePooledTransport,
  nxtwWinsockTransport, dxUIAClasses;

type
  TMainForm = class(TForm)
    Label5: TcxLabel;
    MessageLabel: TcxLabel;
    ApplicationPanel: TcxGroupBox;
    DesktopPanel: TcxGroupBox;
    CaptionPanel: TcxGroupBox;
    Shape4: TShape;
    cxLabel1: TcxLabel;
    Image1: TcxImage;
    DestinoBtn: TcxButton;
    RecuperarButton: TcxButton;
    CancelarButton: TcxButton;
    OpenDialog: TFileOpenDialog;
    DirectorioCopiasCtrl: TcxTextEdit;
    cxLabel2: TcxLabel;
    SessionSource: TnxSession;
    DatabaseSource: TnxDatabase;
    BackupController: TnxBackupController;
    SessionTarget: TnxSession;
    DatabaseTarget: TnxDatabase;
    SourceServerEngine: TnxServerEngine;
    TargetServerEngine: TnxServerEngine;
    ZipForge: TZipForge;
    cxLabel3: TcxLabel;
    NombreFicheroLabel: TcxLabel;
    ProgressPanel: TcxGroupBox;
    PercentLabel: TcxLabel;
    ProgressBar: TcxProgressBar;
    cxLabel4: TcxLabel;
    TablaLabel: TcxLabel;
    FicherosComprimidosCtrl: TcxCheckBox;
    procedure CancelarButtonClick(Sender: TObject);
    procedure RecuperarButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CaptionPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DestinoBtnClick(Sender: TObject);
    procedure DirectorioCopiasCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ZipForgeFileProgress(Sender: TObject; FileName: TZFString;
      Progress: Double; Operation: TZFProcessOperation;
      ProgressPhase: TZFProgressPhase; var Cancel: Boolean);
    procedure BackupControllerTableProgress(aSender: TnxBackupController;
      aPercentDone: Integer);
    procedure BackupControllerAfterTableOpen(aSender: TnxBackupController;
      aTable: TnxTable; aIsSource: Boolean);
  private
    procedure GetTableList( Directorio : String; TableList : TStrings );

  public

    Working,
    ProcessCanceled : Boolean;
    RecordNumber : LongInt;
    CurrentTable : String;

    EmpresaFields : TEmpresaFields;

    constructor Create( aOwner : TComponent ); override;
    destructor  Destroy;                       override;

    procedure ExecuteProcess;
    procedure CleanError;

  end;

var MainForm: TMainForm = nil;

implementation

{$R *.DFM}

uses  WinAPI.Messages,
      DateUtils,
      Files,
      LibUtils,

      nxsdTypes,
      nxsdDataDictionary,
      nxseAllEngines,
      nxPatchPPL,

      AppManager,

      MessageBox;

resourceString
      RsMsg1  = 'Debe seleccionar el directorio de las copias.';
      RsMsg2  = 'Descomprimiendo el fichero.';
      RsMsg3  = 'Creando la estructura de la base de datos';
      RsMsg4  = 'Proceso interrumpido. Los datos pueden no ser válidos.';
      RsMsg7  = 'Proceso cancelado por el usuario.';
      RsMsg8  = 'El proceso no ha finalizado satisfactoriamente.'#13'Si desea utilizar los datos, debe realizarlo de nuevo.';
      RsMsg9  = 'Copia realizada satisfactoriamente.';
      RsMsg10 = '¿Esta seguro de que desea cancelar el proceso?';

constructor TMainForm.Create( aOwner : TComponent );
begin
     inherited Create( aOwner );
end;

procedure TMainForm.DestinoBtnClick(Sender: TObject);
begin
     try
       CleanError;
       OpenDialog.DefaultFolder := DirectorioCopiasCtrl.Text;
       If   OpenDialog.Execute
       then DirectorioCopiasCtrl.Text := AddPathDelim( OpenDialog.FileName );
       DirectorioCopiasCtrl.ValidateEdit;
       DirectorioCopiasCtrl.SetFocus;
     finally
       DirectorioCopiasCtrl.ModifiedAfterEnter := True;
       end;
end;

destructor TMainForm.Destroy;
begin
     inherited Destroy;
end;

procedure TMainForm.DirectorioCopiasCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not DirectoryExists( DisplayValue )
     then begin
          Error := True;
          ErrorText := 'El directorio no existe';
          end;
     RecuperarButton.Enabled := not Error;
     CleanError;
end;

procedure TMainForm.CleanError;
begin
    TablaLabel.Style.TextColor := TColors.Cornflowerblue;
    TablaLabel.Caption := '';
    Application.ProcessMessages;
end;

procedure TMainForm.GetTableList( Directorio : String; TableList : TStrings );

var   Index : SmallInt;

begin
     GetFileList( AddPathDelim( Directorio ), '*.nx1', TableList );
     Index := 0;
     While  Index < TableList.Count do
       If   not ( Upcase( TableList[ Index ][ 1 ] ) in [ 'A'..'Z' ] )
       then TableList.Delete( Index )
       else begin
            TableList[ Index ] := ExtractFileNameWithoutExtension( TableList[ Index ] );
            Inc( Index );
            end;
     TableList.Insert( 0, '<Todas>' );
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
     With Application do
       begin
       OnException := ApplicationManager.DoOnException;
       HintHidePause := 60000;  // Por defecto son 2500 ms
       end;
end;

procedure TMainForm.BackupControllerAfterTableOpen( aSender   : TnxBackupController;
                                                    aTable    : TnxTable;
                                                    aIsSource : Boolean );
begin
     CurrentTable := ATable.TableName;
end;

procedure TMainForm.BackupControllerTableProgress( aSender      : TnxBackupController;
                                                   aPercentDone : Integer );
begin
     ProgressBar.Position := aPercentDone;
     If   CurrentTable<>''
     then TablaLabel.Caption := CurrentTable;
     If   ProcessCanceled
     then Abort;
     Application.ProcessMessages;
end;

procedure TMainForm.CancelarButtonClick(Sender: TObject);
begin
     If   Working
     then begin
          If   ShowNotification( ntQuestion, RsMsg10, '' )=mrYes
          then ProcessCanceled := True;
          end
     else Application.Terminate;
end;

procedure TMainForm.CaptionPanelMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

const sc_DragMove = $F012;

begin
     ReleaseCapture;
     Perform( wm_SysCommand, sc_DragMove, 0 );
end;

procedure TMainForm.RecuperarButtonClick(Sender: TObject);

var  Index : SmallInt;

begin

     If   DirectorioCopiasCtrl.Text=''
     then begin
          ShowNotification( ntStop, RsMsg1 );
          Exit;
          end;

     try

       CancelarButton.SetFocus;
       RecuperarButton.Enabled := False;
       CleanError;
       ProcessCanceled := False;

       ExecuteProcess;

       If   ProcessCanceled
       then ShowNotification( ntStop, RsMsg7, RsMsg8 )
       else ShowNotification( ntInformation, RsMsg9, '' );

     finally
       RecuperarButton.Enabled := True;
       end;
end;

procedure TMainForm.ZipForgeFileProgress(     Sender        : TObject;
                                              FileName      : TZFString;
                                              Progress      : Double;
                                              Operation     : TZFProcessOperation;
                                              ProgressPhase : TZFProgressPhase;
                                          var Cancel        : Boolean );
begin
     Cancel := ProcessCanceled;
end;

procedure TMainForm.ExecuteProcess;

var  FileList : TStringList;
     DatabaseDir : String;

begin

     Working := True;

     try

       try

         FileList := TStringList.Create;

         var PathDirectorioCopias := DirectorioCopiasCtrl.Text;

         If   FicherosComprimidosCtrl.Checked
         then begin

              GetFileList( PathDirectorioCopias, 'data*.zip', FileList, { Recursive } False, { RemoveExtension } False, { AddFileInfo } False,  faArchive );

              For var FileName : String in FileList do
                begin

                NombreFicheroLabel.Caption := FileName;
                TablaLabel.Caption := RsMsg2;
                ProgressBar.Position := 0;
                ProgressPanel.Visible := True;
                CurrentTable := '';

                Application.ProcessMessages;

                ZipForge.FileName := AddPathDelim( PathDirectorioCopias ) + FileName;

                DatabaseDir := AddPathDelim( PathDirectorioCopias ) + ExtractFileNameWithoutExtension( FileName );

                CheckDirectory( DatabaseDir, { Create } True );

                ZipForge.BaseDir := DatabaseDir;

                ZipForge.OpenArchive;
                try
                  ZipForge.FileMasks.Clear;
                  ZipForge.FileMasks.Add( '*.*' );

                  ZipForge.ExtractFiles;

                finally
                  ZipForge.CloseArchive;
                  end;

                If   ProcessCanceled
                then Abort;

                end;

              end;


         If   DirectoryExists( AddPathDelim( PathDirectorioCopias ) + 'data' )
         then FileList.Add( 'data' );

         GetFileList( PathDirectorioCopias, 'data_???', FileList, { Recursive } False, { RemoveExtension } False, { AddFileInfo } False,  faDirectory );

         For var DirName : String in FileList do
           begin

           DatabaseDir := AddPathDelim( PathDirectorioCopias ) + ExtractFileNameWithoutExtension( DirName );

           TablaLabel.Caption := RsMsg3;
           Application.ProcessMessages;

           // Ahora restauro los índices

           CheckDirectory( DatabaseDir + '$', { Create } True );

           DatabaseSource.Close;
           DatabaseTarget.Close;

           DatabaseSource.AliasPath := DatabaseDir + '$';
           DatabaseTarget.AliasPath := DatabaseDir;

           DatabaseSource.Open;
           DatabaseTarget.Open;

           try
             BackupController.Restore;
           finally
             BackupController.Close;
             DatabaseSource.Close;
             DatabaseTarget.Close;
             end;

           SessionSource.CloseInactiveFolders;
           SessionTarget.CloseInactiveFolders;

           EraseDirectory( DatabaseTarget.AliasPath, { RemoveDir } True );
           RenameDirectory( DatabaseDir + '$', DatabaseDir );

           end;

         except on E : Exception do
           begin
           TablaLabel.Caption := RsMsg4;
           TablaLabel.Style.TextColor := TColors.Crimson;
           raise;
           end;
         end;

     finally
       FileList.Free;
       If   not ProcessCanceled
       then begin
            TablaLabel.Caption := '';
            NombreFicheroLabel.Caption := '';
            end;
       ProgressPanel.Visible := False;
       Working := False;
       end;

end;

end.
