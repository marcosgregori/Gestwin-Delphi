unit b_bck;

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
  cxPCdxBarPopupMenu, dxBarBuiltInMenu, ZipForge, dxSVGImage, dxUIAClasses;

type
  TBoxBckForm = class(TgxForm)
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
    BackupProgressBar: TcxProgressBar;
    TableProgressBar: TcxProgressBar;
    BackupDatabase: TnxDatabase;
    PassLabel: TcxLabel;
    EmpresaTable: TnxeTable;
    EmpresaTableCodigo: TWideStringField;
    EmpresaTableDataPath: TWideStringField;
    BackupController: TnxBackupController;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxGroupBox2: TcxGroupBox;
    TodoCheckBox: TcxCheckBox;
    DestinoTextEdit: TcxTextEdit;
    ExaminarButton: TgBitBtn;
    EnviarFicherosCheckBox: TcxCheckBox;
    Image1: TcxImage;
    Label9: TcxLabel;
    FicheroLabel: TcxLabel;
    Label2: TcxLabel;
    ProcesoLabel: TcxLabel;
    ZipForge: TZipForge;
    procedure BackupControllerIncludeTable(aSender: TnxBackupController;
      const aTableName: string; var aUseTable: Boolean);
    procedure BackupControllerTableProgress(
      aSender: TnxBackupController; aPercentDone: Integer);
    procedure FormShow(Sender: TObject);
    procedure EnviarFicherosCtrlPropertiesChange(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure AnteriorButtonClick(Sender: TObject);
    procedure ExaminarButtonClick(Sender: TObject);
    procedure SiguienteButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure ZipForgeOverallProgress(Sender: TObject; Progress: Double;
      Operation: TZFProcessOperation; ProgressPhase: TZFProgressPhase;
      var Cancel: Boolean);
    procedure DestinoTextEditPropertiesEnter(Sender: TcxCustomEdit);
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

    ParametrosBackupRec : TParametrosBackupRec;

    procedure DoBackup;
    function DoBackupProgress( ObjectName : String; Percent1, Percent2 : SmallInt ) : Boolean;
    procedure DoOnCopyOneFile( SourceFileName, TargetFileName : String );
  end;

var BoxBckForm: TBoxBckForm;

procedure CopiaSeguridad;
procedure SetupBackupProcess;

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
      RsMsg1  = 'No puede realizar la copia en el directorio de la aplicación.';
      RsMsg2  = 'Seleccione cualquier otra ubicación.';
      RsMsg5  = 'El proceso de copia de seguridad ha finalizado correctamente.';
      RsMsg6  = 'El proceso de copia de seguridad NO ha finalizado correctamente.';
      RsMsg7  = 'Averigue el motivo del error y reintente el proceso lo antes posible.';
      RsMsg8  = '¿Esta seguro de que desea interrumpir el proceso de copia de seguridad de sus ficheros?.';
      RsMsg9  = 'Solo el USUARIO MAESTRO (Código 00) puede realizar el proceso de copia de seguridad.';
      RsMsg10 = 'Si desea realizar la copia de seguridad acceda a la aplicación como Usuario Maestro y reintente el proceso.';
      RsMsg11 = 'Copiando los ficheros globales de la aplicación.';
      RsMsg12 = 'Copiando en la ubicación final.';
      RsMsg13 = 'Copiando los ficheros de la Empresa %s.';
      RsMsg14 = 'Debe indicar una directorio destino de la copia.';
      RsMsg15 = 'El directorio de datos de la Empresa %s no es accesible.';
      RsMsg16 = 'Está realizando la copia desde una localización remota y no se puede acceder a los datos.'#13'Para realizar la copia sitúese en el servidor o haga solo la copia de la Empresa de referencia.';
      RsMsg17 = 'Descargar copia como un fichero comprimido.';
      RsMsg18 = 'Creando el fichero comprimido.';
      RsMsg19 = 'Espere a que el fichero se haya descargado completamente en su equipo antes de seguir.';

const TransactionsFile = 'nxTrans.cfg';

var   ProcessStarted : Boolean = False;

procedure CopiaSeguridad;

var   FormResult       : TModalResult;

begin
     If   ApplicationContainer.TryToCloseAll( False )<>mrOk
     then Exit;

     Application.CreateForm( TBoxBckForm, BoxBckForm );
     If   Assigned( BoxBckForm )
     then try
            try
              FormResult := BoxBckForm.ShowModal;
            except
              end;
          finally
            BoxBckForm.Free;
            end;

end;

procedure TBoxBckForm.ExaminarButtonClick(Sender: TObject);

var  Path : String;

begin
     Path := ApplicationPath;
     If   SelectDirectory( Path )
     then With DestinoTextEdit do
            begin
            Text := Path;
            SetFocus;
            end;
end;

procedure TBoxBckForm.FormShow(Sender: TObject);
begin
     Configuracion.ObtenParametros( ctBackup, '', TParametrosRec( ParametrosBackupRec ) );

     TodoCheckBox.Checked := ParametrosBackupRec.TodasLasEmpresas;
     EnviarFicherosCheckBox.Checked := ParametrosBackupRec.EnviarFicheros;
     DestinoTextEdit.Text := ParametrosBackupRec.PathDestino;

     {
     If   VirtualUIApp
     then begin
          EnviarFicherosCheckBox.Caption := RsMsg17;          
          DestinoTextEdit.Visible := False;
          ExaminarButton.Visible := False;          
          end;
     }
     
end;

procedure TBoxBckForm.BackupControllerIncludeTable(       ASender    : TnxBackupController;
                                                    const ATableName : String;
                                                    var   AUseTable  : Boolean );
begin
     FicheroLabel.Caption := ATableName;
     BackupProgressBar.Position := ASender.ProcessedNoError;
end;

procedure TBoxBckForm.BackupControllerTableProgress(aSender: TnxBackupController; aPercentDone: Integer);
begin
     TableProgressBar.Position := aPercentDone;
     Application.ProcessMessages;
     If   BackupCanceled
     then Abort;
end;

function TBoxBckForm.DoBackupProgress( ObjectName : String;
                                       Percent1,
                                       Percent2   : SmallInt ) : Boolean;
begin
     If   Percent2=0
     then begin
          FicheroLabel.Caption := ObjectName;
          BackupProgressBar.Position := Percent1;
          TableProgressBar.Position  := 0;
          end
     else TableProgressBar.Position := Percent2;
     Application.ProcessMessages;
     Result := BackupCanceled;
end;

procedure TBoxBckForm.DoOnCopyOneFile( SourceFileName,
                                       TargetFileName : String );
begin
     FicheroLabel.Caption := SourceFileName;
     TableProgressBar.Position := TableProgressBar.Position + 1;
     Application.ProcessMessages;
end;

procedure TBoxBckForm.EnviarFicherosCtrlPropertiesChange(Sender: TObject);
begin
     DestinoTextEdit.Enabled := EnviarFicherosCheckBox.Checked;
     ExaminarButton.Enabled := EnviarFicherosCheckBox.Checked;
end;

procedure TBoxBckForm.SiguienteButtonClick(Sender: TObject);
begin
     With PageControl do
       begin

       Case ActivePage.PageIndex of
         0 : begin
             ActivePage := TabSheet2;
             TodoCheckBox.SetFocus;
             end;
         1 : begin
             If   EnviarFicherosCheckBox.Checked and not VirtualUIApp
             then begin
                  If   DestinoTextEdit.Text=''
                  then ShowInputError( DestinoTextEdit, RsMsg14, '' )
                  else If   Pos( ApplicationPath, DestinoTextEdit.Text )<>0  // El Path contiene el directorio de la aplicación
                       then ShowInputError( DestinoTextEdit, RsMsg1, RsMsg2 );
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

procedure TBoxBckForm.ZipForgeOverallProgress(     Sender        : TObject;
                                                   Progress      : Double;
                                                   Operation     : TZFProcessOperation;
                                                   ProgressPhase : TZFProgressPhase;
                                               var Cancel        : Boolean);
begin
     BackupProgressBar.Position := Trunc( Progress );
     Cancel := BackupCanceled;
     Application.ProcessMessages;
end;

procedure TBoxBckForm.DestinoTextEditPropertiesEnter(Sender: TcxCustomEdit);
begin
     If   WebApp and ( DestinoTextEdit.EditingText='' )
     then DestinoTextEdit.EditingText := '\\tsclient\\WebFile';
end;

procedure TBoxBckForm.DoBackup;

var   BackupPath,
      DirectBackupPath : String;
      BackupIndexStr,
      CompressedFileName,
      CompressedFilePath,
      MessageDescription,
      Path : String;
      FileList : TStringList;

procedure DoBackupDatabase( Database : TnxDatabase );
begin
     With BackupController do
       try
         Active := False;
         OriginalDatabase := Database;
         CloneDatabase := BackupDatabase;
         Backup;
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

       NexusRpc.OnProgress := DoBackupProgress;
       CodigoEmpresa := CodigoEmpresaActual;

       try

         // Animate.Active := True;
         ProcesoLabel.Caption := RsMsg11;

         BackupIndexStr := 'Backup\Copia' + GetBackupIndexString;

         Path := BackupIndexStr + '\data';
         DirectBackupPath := AddPathDelim( ApplicationPath ) + Path;
         BackupPath := AddPathDelim( ApplicationDataPath ) + Path;

         CreateDirPath( DirectBackupPath );

         BackupDatabase.Session := DataAccessModule.AppDatabase.Session;
         BackupDatabase.AliasPath := BackupPath;

         DoBackupDatabase( DataAccessModule.AppDatabase );

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

                  DoBackupDatabase( EnterpriseDataModule.UserDatabase );

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

         // Copia en la ubicación final

         If   EnviarFicherosCheckBox.Checked
         then begin

              PassLabel.Caption := '2';
              ProcesoLabel.Caption := RsMsg18;
              FicheroLabel.Caption := '';

              BackupProgressBar.Properties.Max := 100;
              BackupProgressBar.Position := 0;
              TableProgressBar.Position := 0;

              Application.ProcessMessages;

              MessageDescription := '';

              CompressedFileName := 'CDS_Gestwin_' + FormatDateTime( 'dd.mm.yyyy_hh.MM.ss', Now ) + '.zip';
              CompressedFilePath := AddPathDelim( DataAccessModule.DirectTemporalPath ) + CompressedFileName;
              EraseFile( CompressedFilePath, False );  // Por si existe

              ZipForge.FileName := CompressedFilePath;
              ZipForge.BaseDir := AddPathDelim( ApplicationPath ) + BackupIndexStr;

              ZipForge.OpenArchive;

              ZipForge.FileMasks.Clear;
              ZipForge.FileMasks.Add( AddPathDelim( ApplicationPath ) + BackupIndexStr + '\data\*.*' );
              ZipForge.ExclusionMasks.Add( TransactionsFile );

              With EmpresaTable do
                begin
                First;
                While not Eof do
                  begin
                  If   EmpresaTableDataPath.Value=''
                  then begin
                       ZipForge.FileMasks.Add( AddPathDelim( ApplicationPath ) + BackupIndexStr + '\data_' + EmpresaTableCodigo.Value + '\*.*' );
                       ZipForge.FileMasks.Add( AddPathDelim( ApplicationPath ) + BackupIndexStr + '\reports_' + EmpresaTableCodigo.Value + '\*.*' );
                       end;
                  Next;
                  end;
                end;

              ZipForge.AddFiles;

              ZipForge.CloseArchive;

              ProcesoLabel.Caption := RsMsg12;
              Application.ProcessMessages;

              If   BackupCanceled
              then Abort;

              CopyFile( CompressedFilePath, AddPathDelim( DestinoTextEdit.Text ) + CompressedFileName, [ cfNotIfyIfAbsent, cfOverWrite, cfNotifyError ] );

              end;

         // Todo ha ido bien. Ahora puedo guardar los parámetros ...

         ParametrosBackupRec.TodasLasEmpresas := TodoCheckBox.Checked;
         ParametrosBackupRec.EnviarFicheros := EnviarFicherosCheckBox.Checked;
         ParametrosBackupRec.PathDestino := AnsiString( DestinoTextEdit.Text );

         Configuracion.GuardaParametros( ctBackup, '', TParametrosRec( ParametrosBackupRec ) );

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

procedure TBoxBckForm.AnteriorButtonClick(Sender: TObject);
begin
     With PageControl do
       begin
       Case ActivePage.PageIndex of
        1 : ActivePage := TabSheet1;
        2 : ActivePage := TabSheet2;
        end;
       end;
end;

procedure TBoxBckForm.CloseButtonClick(Sender: TObject);
begin
     If   PageControl.ActivePage=TabSheet3
     then If   ShowNotification( ntQuestionWarning, RsMsg8, '' )=mrYes
          then BackupCanceled := True;
end;

procedure SetupBackupProcess;
begin
     ApplicationContainer.OnBackupDatabase := CopiaSeguridad;
end;

procedure TBoxBckForm.PageControlChange(Sender: TObject);

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

initialization
    AddProcedure( imInitialize, 0, SetupBackupProcess, True );
end.
