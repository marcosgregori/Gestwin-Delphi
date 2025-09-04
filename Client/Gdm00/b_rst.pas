unit b_rst;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,

  DataManager,
  ComCtrls,
  AppContainer,
  AppForms,
  cxPC,
  cxControls,
  Menus,
  cxLookAndFeelPainters,
  cxButtons,
  cxTextEdit,
  cxLabel,
  cxContainer,
  cxEdit,
  cxCheckBox,
  cxProgressBar,
  nxllComponent,
  nxdb,
  DB,

  nxdbBackupController,

  Gim00Fields, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxGraphics, cxLookAndFeels, dxGDIPlusClasses, cxGroupBox, GIFImg, cxImage,
  cxPCdxBarPopupMenu, dxBarBuiltInMenu, ZipForge, dxSVGImage;

type
  TBoxRstForm = class(TgxForm)
    Panel1: TgxEditPanel;
    Panel2: TgxEditPanel;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet3: TcxTabSheet;
    Panel3: TcxGroupBox;
    SiguienteButton: TgBitBtn;
    CloseButton: TgBitBtn;
    TabSheet2: TcxTabSheet;
    AnteriorButton: TgBitBtn;
    RestoreProgressBar: TcxProgressBar;
    TableProgressBar: TcxProgressBar;
    BackupDatabase: TnxDatabase;
    PassLabel: TcxLabel;
    EmpresaTable: TnxeTable;
    EmpresaTableCodigo: TWideStringField;
    EmpresaTableDataPath: TWideStringField;
    BackupController: TnxBackupController;
    cxGroupBox1: TcxGroupBox;
    cxLabel2: TcxLabel;
    cxGroupBox2: TcxGroupBox;
    RestaurarDatosGlobalesCtrl: TcxCheckBox;
    OrigenCtrl: TcxTextEdit;
    ExaminarButton: TgBitBtn;
    Image1: TcxImage;
    Label9: TcxLabel;
    FicheroLabel: TcxLabel;
    Label2: TcxLabel;
    ProcesoLabel: TcxLabel;
    ZipForge: TZipForge;
    cxGroupBox3: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxLabel3: TcxLabel;
    procedure BackupControllerIncludeTable(aSender: TnxBackupController;
      const aTableName: string; var aUseTable: Boolean);
    procedure BackupControllerTableProgress(
      aSender: TnxBackupController; aPercentDone: Integer);
    procedure FormShow(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure AnteriorButtonClick(Sender: TObject);
    procedure ExaminarButtonClick(Sender: TObject);
    procedure SiguienteButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure ZipForgeOverallProgress(Sender: TObject; Progress: Double;
      Operation: TZFProcessOperation; ProgressPhase: TZFProgressPhase;
      var Cancel: Boolean);
    procedure OrigenCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure ZipForgeProcessFileFailure(Sender: TObject;
      FileName: TZFString; Operation: TZFProcessOperation; NativeError,
      ErrorCode: Integer; ErrorMessage: TZFString; var Action: TZFAction);

  private

  public

    Dictionary : TnxeDatabaseDictionary;

    NroEmpresas,
    Index : Word;
    Correct : Boolean;
    CodigoEmpresa : String;
    BackupCanceled : Boolean;
    GlobalTableCount,
    EnterpriseTableCount : Integer;

    FZipProcessFail : Boolean;
    FZipProcessErrorMessage : String;

    ParametrosBackupRec : TParametrosBackupRec;

    procedure DoBackup;
    function DoRestoreProgress( ObjectName : String; Percent1, Percent2 : SmallInt ) : Boolean;
    procedure DoOnCopyOneFile( SourceFileName, TargetFileName : String );
  end;

var BoxRstForm: TBoxRstForm;

procedure ResturarCopiaSeguridad;

implementation

{$R *.dfm}

uses  Files,
      LibUtils,
      AppManager,
      DataAccess,
      EnterpriseDataAccess,
      NexusRpcData,

      dmi_cnd,
      
      dm_pga,
      dm_cnd,
      dm_iex,

      b_msg,
      b_dir;

resourceString
      RsMsg1  = 'No se ha podido crear el directorio %s.';
      RsMsg2  = 'Extrayendo las tablas del fichero comprimido.';
      RsMsg3  = 'Debe especificar un fichero de copia válido.';

const TransactionsFile = 'nxTrans.cfg';

var   ProcessStarted : Boolean = False;

procedure ResturarCopiaSeguridad;

var   FormResult       : TModalResult;

begin
     If   ApplicationContainer.TryToCloseAll( False )<>mrOk
     then Exit;

     Application.CreateForm( TBoxRstForm, BoxRstForm );
     If   Assigned( BoxRstForm )
     then try
            try
              FormResult := BoxRstForm.ShowModal;
            except
              end;
          finally
            BoxRstForm.Free;
            end;

end;

procedure TBoxRstForm.ExaminarButtonClick(Sender: TObject);

var  Path : String;

begin
     With ApplicationForms.OpenFileDialog do
       begin
       Filter := '*.zip';
       If   Execute
       then begin
            OrigenCtrl.Text := FileName;
            OrigenCtrl.SetFocus;
            end;
       end;
end;

procedure TBoxRstForm.FormShow(Sender: TObject);
begin
     //
end;

procedure TBoxRstForm.BackupControllerIncludeTable(       ASender    : TnxBackupController;
                                                    const ATableName : String;
                                                    var   AUseTable  : Boolean );
begin
     FicheroLabel.Caption := ATableName;
     RestoreProgressBar.Position := ASender.ProcessedNoError;
end;

procedure TBoxRstForm.BackupControllerTableProgress(aSender: TnxBackupController; aPercentDone: Integer);
begin
     TableProgressBar.Position := aPercentDone;
     Application.ProcessMessages;
     If   BackupCanceled
     then Abort;
end;

function TBoxRstForm.DoRestoreProgress( ObjectName : String;
                                       Percent1,
                                       Percent2   : SmallInt ) : Boolean;
begin
     If   Percent2=0
     then begin
          FicheroLabel.Caption := ObjectName;
          RestoreProgressBar.Position := Percent1;
          TableProgressBar.Position  := 0;
          end
     else TableProgressBar.Position := Percent2;
     Application.ProcessMessages;
     Result := BackupCanceled;
end;

procedure TBoxRstForm.DoOnCopyOneFile( SourceFileName,
                                       TargetFileName : String );
begin
     FicheroLabel.Caption := SourceFileName;
     TableProgressBar.Position := TableProgressBar.Position + 1;
     Application.ProcessMessages;
end;

procedure TBoxRstForm.SiguienteButtonClick(Sender: TObject);
begin
     With PageControl do
       begin

       Case ActivePage.PageIndex of
         0 : begin
             ActivePage := TabSheet2;
             RestaurarDatosGlobalesCtrl.SetFocus;
             end;
         1 : begin
             If   not OrigenCtrl.IsEditValidated
             then begin
                  ShowNotification( ntStop, RsMsg3 );
                  Abort;
                  end;
             ActivePage := TabSheet3;
             CloseButton.GlyphBitmap := gmCancel;
             CloseButton.Caption := '&Cancelar';
             CloseButton.Invalidate;
             Application.ProcessMessages;
             DoBackup;
             end;
         end;

       end;
end;

procedure TBoxRstForm.ZipForgeOverallProgress(     Sender        : TObject;
                                                   Progress      : Double;
                                                   Operation     : TZFProcessOperation;
                                                   ProgressPhase : TZFProgressPhase;
                                               var Cancel        : Boolean);
begin
     RestoreProgressBar.Position := Trunc( Progress );
     Cancel := BackupCanceled;
     Application.ProcessMessages;
end;

procedure TBoxRstForm.ZipForgeProcessFileFailure(     Sender       : TObject;
                                                      FileName     : TZFString;
                                                      Operation    : TZFProcessOperation;
                                                      NativeError,
                                                      ErrorCode    : Integer;
                                                      ErrorMessage : TZFString;
                                                  var Action       : TZFAction );
begin
     FZipProcessFail := True;
     FZipProcessErrorMessage := ErrorMessage;
     Action := fxaAbort;
end;

procedure TBoxRstForm.OrigenCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     If   WebApp and ( OrigenCtrl.EditingText='' )
     then OrigenCtrl.EditingText := '\\tsclient\\WebFile';
end;

procedure TBoxRstForm.DoBackup;

var   BackupPath,
      DirectBackupPath : String;
      BackupIndexStr,
      CompressedFileName,
      CompressedFilePath,
      MessageDescription,
      Path : String;
      FileList : TStringList;

procedure DoRestoreDatabase( Database : TnxDatabase );
begin
     With BackupController do
       try
         Active := False;
         OriginalDatabase := Database;
         CloneDatabase := BackupDatabase;
         Restore;
       finally
         Active := False;
         BackupDatabase.Active := False;
         end;
end;

function GetBackupIndexString : String;
begin
     Result := IntToStr( Contadores.Incrementa( cnBackupIndex, 0, '', 0, 1, ApplicationContainer.NumOfInternalCopies ) );
end;

begin

     ProcessStarted := True;
     FileList := TStringList.Create;

     try

       NexusRpc.OnProgress := DoRestoreProgress;
       CodigoEmpresa := CodigoEmpresaActual;

       try

         // Animate.Active := True;
         ProcesoLabel.Caption := RsMsg11;

         // Extrayendo la base de datos del fichero comprimido

         PassLabel.Caption := '1';
         ProcesoLabel.Caption := RsMsg2;
         FicheroLabel.Caption := '';

         RestoreProgressBar.Properties.Max := 100;
         RestoreProgressBar.Position := 0;
         TableProgressBar.Position := 0;

         Application.ProcessMessages;

         MessageDescription := '';
         {
         CompressedFileName := 'CDS_Gestwin_' + FormatDateTime( 'dd.mm.yyyy_hh.MM.ss', Now ) + '.zip';
         CompressedFilePath := AddPathDelim( DataAccessModule.DirectTemporalPath ) + CompressedFileName;
         }
         CompressedFilePath := OrigenCtrl.Text;

         var TargetFilePath :=  AddPathDelim( DataAccessModule.DirectTemporalPath ) + ExtractFileName( CompressedFilePath );
         If   CheckDirectory( TargetFilePath, { Create } True )
         then begin

              FZipProcessFail := False;
              With ZipForge do
                begin
                FileName := CompressedFilePath;
                BaseDir := TargetFilePath;
                OpenArchive;
                try
                  FileMasks.Clear;
                  FileMasks.Add( '*' );
                  ZipForge.ExtractFiles;
                finally
                  CloseArchive;
                  end;
                end;

              If   FZipProcessFail
              then begin
                   ShowNotification( ntStop, FZipProcessErrorMessage );
                   Abort;
                   end;

              end
         else begin
              ShowNotification( ntStop, Format( RsMsg1, [ TargetFilePath ] ) );
              Abort;
              end;

         (*

         // ----------------

         BackupIndexStr := 'Backup\Copia' + GetBackupIndexString;

         Path := BackupIndexStr + '\data';
         DirectBackupPath := AddPathDelim( ApplicationPath ) + Path;
         BackupPath := AddPathDelim( ApplicationDataPath ) + Path;

         CreateDirPath( DirectBackupPath );

         BackupDatabase.Session := DataAccessModule.AppDatabase.Session;
         BackupDatabase.AliasPath := BackupPath;

         DoRestoreDatabase( DataAccessModule.AppDatabase );

         GlobalTableCount := FileList.Count;

         With EmpresaTable do
           begin

           If   TodoCheckBox.Checked
           then SetRange( [ '' ], [ HighStrCode ] )
           else SetRange( [ CodigoEmpresaActual ], [ CodigoEmpresaActual ] );

           NroEmpresas := 1;

           First;
           While not Eof do
             begin

             ProcesoLabel.Caption := Format( RsMsg13, [ EmpresaTableCodigo.Value ] );;

             EnterpriseDataModule.CloseUserDatabases;

             If   ( EmpresaTableDataPath.Value<>'' ) and ( DataAccessMode=dmRemote )
             then ShowNotification( ntWarning, Format( RsMsg15, [ EmpresaTableCodigo.Value ] ), RsMsg16 )
             else begin

                  EnterpriseDataModule.SetUserDataPath( EmpresaTableCodigo.Value );

                  Path := BackupIndexStr + '\data_' + EmpresaTableCodigo.Value;
                  DirectBackupPath := AddPathDelim( ApplicationPath ) + Path;
                  BackupPath := AddPathDelim( ApplicationDataPath ) + Path;

                  CreateDirPath( DirectBackupPath );

                  BackupDatabase.Session := EnterpriseDataModule.UserDatabase.Session;
                  BackupDatabase.AliasPath := BackupPath;

                  DoRestoreDatabase( EnterpriseDataModule.UserDatabase );

                  // Reports

                  DirectBackupPath := AddPathDelim( ApplicationPath ) + BackupIndexStr + '\reports_' + EmpresaTableCodigo.Value;
                  CreateDirPath( DirectBackupPath );
                  CopyDirectory( AddPathDelim( ApplicationPath ) + 'reports_' + EmpresaTableCodigo.Value,
                                 DirectBackupPath,
                                 [ cfNotIfyIfAbsent, cfOverWrite, cfNotifyError ] );

                  EnterpriseTableCount := FileList.Count;  // Se coge el último

                  Inc( NroEmpresas );
                  end;

             Next;
             end;

           end;

         If   BackupCanceled
         then Abort;
         *)


         ShowNotification( ntInformation, RsMsg5, MessageDescription );

         EraseFile( CompressedFileName, False );

       except on E : Exception do
         begin
         If   BackupCanceled
         then ShowNotification( ntWarning, RsMsg6, '' )
         else ShowNotification( ntWarning, RsMsg6, E.Message + HTMLCR + RsMsg7 );
         end;
       end;

     finally
       FileList.Free;
       NexusRpc.OnProgress := nil;
       CodigoEmpresaActual := CodigoEmpresa;
       DataAccessModule.CloseInactiveMainSessionResources;
       Close;
       end;
end;

procedure TBoxRstForm.AnteriorButtonClick(Sender: TObject);
begin
     With PageControl do
       begin
       Case ActivePage.PageIndex of
        1 : ActivePage := TabSheet1;
        2 : ActivePage := TabSheet2;
        end;
       end;
end;

procedure TBoxRstForm.CloseButtonClick(Sender: TObject);
begin
     If   PageControl.ActivePage=TabSheet3
     then If   ShowNotification( ntQuestionWarning, RsMsg8, '' )=mrYes
          then BackupCanceled := True;
end;

procedure TBoxRstForm.PageControlChange(Sender: TObject);

var  FocusedControl : TWinControl;

begin
     FocusedControl := ActiveControl;
     try
       PageControl.SetFocus;
       AnteriorButton.Enabled  := PageControl.ActivePage.PageIndex=1;
       SiguienteButton.Enabled := PageControl.ActivePage.PageIndex<>2;
     finally
       With FocusedControl do
         If   Enabled
         then SetFocus
         else CloseButton.SetFocus;
       end;
end;

end.
