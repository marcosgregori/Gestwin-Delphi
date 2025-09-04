unit RPCInstall;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.IniFiles,
  Data.DB,

  cxLabel,
  cxProgressBar,

  LibUtils,

  kbmMWFileClient,
  kbmMWCustomTransport,
  kbmMWClient,
  kbmMWTCPIPIndyClientTransport,
  kbmMWZipStdTransStream,

  ZipForge;

type
  TRpcProcessType = ( ptUpload, ptDownload );

  TRpcInstallModule = class(TDataModule)
    Client: TkbmMWSimpleClient;
    ClientTransport: TkbmMWTCPIPIndyClientTransport;
    UpdateServiceClient: TkbmMWFileClient;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure UpdateServiceClientProgress( Sender : TObject; Pct: Integer; Receiving : Boolean; var Terminate: Boolean);
  private
    function ExpandRemoteFileName( AFileName : String ) : String;
    procedure CreateRemoteDirPath(DirPath: String);

  public

    RemoteDir,
    VersionDir,
    LocalDir,
    BackupDir,

    CurrentDir,

    RemotePath,
    LocalPath : String;

    FileSize,
    CurrentDownloadSize,        // El tamaño descargado hasta ahora
    TotalDownloadSize : Int64;  // El tamaño de todos los ficheros a descargar

    DataProgressBar : TcxProgressBar;
    GlobalMessageLabel,
    PercentMessageLabel : TcxLabel;

    Cancelled : Boolean;
    RpcProcessType : TRpcProcessType;
    ProxyInfoFile : TMemIniFile;

    FileName     : WideString;
    Operation    : TZFProcessOperation;
    NativeError,
    ErrorCode    : Integer;
    ErrorMessage : WideString;

    procedure Setup( ARpcProcessType : TRpcProcessType; AGlobalMessageLabel, APercentMessageLabel : TcxLabel;AProgressBar : TcxProgressBar; ReadConfigFile : Boolean = True; BetaVersion : Boolean = False );
    procedure Connect( TimeOut   : SmallInt = 10;
                       AUserName : String = '';
                       APassword : String = '';
                       AHost     : String = '';
                       APort     : SmallInt = 0 );

    procedure Disconnect;

    function  FixCurrentDir( aDir : String; Uploading : Boolean = False ) : Boolean;

    function  GetFile( AFileName : String ) : Int64;
    procedure PutFile( AFileName : String; CopyFromOriginalSource : Boolean = True );

    {
    procedure ReadProxySettings;
    procedure WriteProxySettings;
    }

    function GetRemoteFileStamp( AFileName : String ) : String;
    function RemoteFileExists( AFileName : String ) : Boolean;
    function RemoteFileSize(AFileName: String; Expand : Boolean = True ): LongInt;
    procedure LockRead(Value: Boolean);

    function GetFileVersion( FilePath : String; IncludeBuild : Boolean = True ) : LongWord;

    procedure RegisterInstallation;
  end;

var  RpcInstallModule: TRpcInstallModule = nil;

const  DefaultBlockSize = 5 * ( 1024 * 1024 );  // Paquetes de 5Mb
       ClientRootPath : String = 'ClientData';
       UpdatesDir : String = 'Updates';
       DownloadsDir : String = 'Downloads';

function  Rpc : TRpcInstallModule;

{ NOTA : No utilizar FastZLib como compresor. No está correctamente implementado }

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses  Forms,
      Files,
      DateUtils,

      AppManager;

{$R *.dfm}

const  ProxySectionName = 'Proxy';

function Rpc : TRpcInstallModule;
begin
     If   not Assigned( RpcInstallModule )
     then RpcInstallModule := TRpcInstallModule.Create( Application );
     Result := RpcInstallModule;
end;

procedure TRpcInstallModule.DataModuleDestroy(Sender: TObject);
begin
     RpcInstallModule := nil;
end;

procedure TRpcInstallModule.Connect( TimeOut   : SmallInt = 10;
                                     AUserName : String = '';
                                     APassword : String = '';
                                     AHost     : String = '';
                                     APort     : SmallInt = 0 );
begin

     If   AUserName=''
     then AUserName := 'gwuser';
     If   APassword=''
     then APassword := 'gdA2076_b2';
     If   AHost=''
     then AHost := 'gestwinupdate.es';
     If   APort=0
     then APort := 80;

     With ClientTransport do
       begin
       ConnectTimeout := TimeOut * 2;
       RequestTimeOut := TimeOut;
       Host := AHost;
       Port := APort;
       end;

     With UpdateServiceClient do
       begin
       UserName := AUserName;
       Password := APassword;
       BlockSize := DefaultBlockSize;
       KeepPartialFileOnCancel := False;
       Connect;
       end;
end;

procedure TRpcInstallModule.Disconnect;
begin
     UpdateServiceClient.Disconnect;
end;

function TRpcInstallModule.ExpandRemoteFileName( AFileName : String ) : String;
begin
     Result := RemotePath + AFileName;
end;

function TRpcInstallModule.RemoteFileExists( AFileName  : String ) : Boolean;
begin
     Result := RemoteFileSize( AFilename )>0;
end;

function TRpcInstallModule.RemoteFileSize( AFileName  : String;
                                           Expand     : Boolean = True ) : LongInt;

var  FileStatus : TkbmMWFileStatus;

begin
     If   Expand
     then AFileName := ExpandRemoteFileName( AFileName );
     try
        With UpdateServiceClient do
          Result := Request( FileService, '', 'GetFileSize', [ AFileName ] );
     except
       Result := 0;
     end;
end;

function TRpcInstallModule.GetRemoteFileStamp( AFileName  : String ) : String;

var  TargetFile : String;
     FileStatus : TkbmMWFileStatus;

begin
     TargetFile := ExpandRemoteFileName( AFileName );
     Result := LowestStrDate;
     try
       With UpdateServiceClient do
          Result := Request( FileService, '', 'GetFileStamp', [ TargetFile ] );
     except
       end;
end;

// El path es desde el directorio remoto raiz

function TRpcInstallModule.GetFile( AFileName : String ) : Int64;

var  SourceFile,
     TargetFile : String;

begin

     CurrentDir := AddPathDelim( CurrentDir );
     SourceFile := RemotePath + AFileName;
     TargetFile := LocalPath + AFileName;

     FileSize := RemoteFileSize( SourceFile, False );
     If   FileSize>0
     then UpdateServiceClient.GetFile( TargetFile, SourceFile );
     Result := FileSize;

     {
     If   Assigned( DataProgressBar )
     then DataProgressBar.Value := 0;
     }
end;

procedure TRpcInstallModule.PutFile( AFileName              : String;
                                     CopyFromOriginalSource : Boolean = True );

var  OriginalSourceFile,
     SourceFile,
     TargetFile : String;

begin

     SourceFile := LocalPath + AFileName;
     TargetFile := RemotePath + AFileName;

     If   ( RpcProcessType=ptUpload ) and CopyFromOriginalSource
     then begin
          OriginalSourceFile := AddPathDelim( ApplicationPath + CurrentDir ) + AFileName;
          CopyFile( OriginalSourceFile, SourceFile );
          end;

     FileSize := GetFileSize( SourceFile );
     UpdateServiceClient.PutFile( SourceFile, TargetFile );

     {
     If   Assigned( DataProgressBar )
     then DataProgressBar.Value := 0;
     }
end;

// Este procedimiento se limita a registrar la instalación de una aplicación en el servidor a efectos informativos
// Si no se puede realizar porque no existe conectividad, o por cualquier otra causa, no afecta a la instalación

procedure TRpcInstallModule.RegisterInstallation;
begin
     With UpdateServiceClient, ProtectionRec do
       Request( FileService, '', 'Install', [ SerialNumber, ActivationKey, RegNumber, ProgramNumber, ProgramVersion, ProgramRelease, ServerConnections ] );
end;

procedure TRpcInstallModule.LockRead( Value : Boolean );
begin
     With UpdateServiceClient, ProtectionRec do
       Request( FileService, '', 'LockRead', [ Value ] );
end;

procedure TRpcInstallModule.DataModuleCreate(Sender: TObject);
begin
     RpcProcessType := ptUpload;  // por defecto
end;

procedure TRpcInstallModule.Setup( ARpcProcessType      : TRpcProcessType;
                                   AGlobalMessageLabel,
                                   APercentMessageLabel : TcxLabel;
                                   AProgressBar         : TcxProgressBar;
                                   ReadConfigFile       : Boolean = True;
                                   BetaVersion          : Boolean = False );

var  BetaVersionText : String;
     ProcessDir : String;

begin

     If   ReadConfigFile
     then ReadIniFile;

     VersionDir := 'gd_' + StrInt( ProgramVersion ) + '.' + StrInt( ProgramRelease );

     If   BetaVersion
     then BetaVersionText := '_beta'
     else BetaVersionText := '';

     RpcProcessType := ARpcProcessType;

     case RpcProcessType of
       ptUpload  :
         begin
         RemoteDir := AddPathDelim( UpdatesDir + BetaVersionText );
         LocalDir := AddPathDelim( ApplicationPath + ClientRootPath + '\' + UpdatesDir + BetaVersionText );
         BackupDir := LocalDir + 'backup';
         CreateDirPath( BackupDir );
         end;
       ptDownload :
         begin
         RemoteDir := AddPathDelim( DownloadsDir + BetaVersionText );
         LocalDir := AddPathDelim( ApplicationPath + ClientRootPath + '\' + DownloadsDir + BetaVersionText );
         BackupDir := LocalDir + 'backup';
         CreateDirPath( LocalDir + VersionDir );
         CreateDirPath( BackupDir );
         end;
       end;

     DataProgressBar := AProgressBar;
     GlobalMessageLabel := AGlobalMessageLabel;
     PercentMessageLabel := APercentMessageLabel;
     Cancelled  := False;

     If   Assigned( DataProgressBar )
     then begin
          DataProgressBar.Properties.Min := 0;
          DataProgressBar.Properties.Max := 100;
          DataProgressBar.Visible := True;
          end;

     If   Assigned( GlobalMessageLabel )
     then GlobalMessageLabel.Caption  := 'Descargando';

     If   Assigned( PercentMessageLabel )
     then PercentMessageLabel.Caption := '';

     Application.ProcessMessages;

end;

function TRpcInstallModule.FixCurrentDir( ADir      : String;
                                          Uploading : Boolean = False ) : Boolean;

begin

     Result := False;
     CurrentDir := AddPathDelim( ADir );

     RemotePath := AddPathDelim( AddPathDelim( RemoteDir + VersionDir ) + CurrentDir );
     LocalPath := AddPathDelim( AddPathDelim( LocalDir + VersionDir ) + CurrentDir );

     If   Uploading
     then CreateRemoteDirPath( RemotePath );  // Me aseguro de que exista el directorio de actualización

     CreateDirPath( LocalPath );

     Result := True;

end;

function TRpcInstallModule.GetFileVersion( FilePath     : String;
                                    IncludeBuild : Boolean = True ) : LongWord;
begin
     With UpdateServiceClient do
       Result := Request( FileService, '', 'GetFileVersion', [ FilePath, IncludeBuild ] );
end;

procedure TRpcInstallModule.CreateRemoteDirPath( DirPath : String );
begin
     With UpdateServiceClient do
       Request( FileService, '', 'CreateDirPath', [ DirPath ] );
end;

procedure TRpcInstallModule.UpdateServiceClientProgress(     Sender    : TObject;
                                                             Pct       : Integer;
                                                             Receiving : Boolean;
                                                         var Terminate : Boolean );

var  CurrentSize : Int64;

begin

     If   Assigned( DataProgressBar ) and DataProgressBar.Enabled
     then begin

          If   TotalDownloadSize<>0
          then begin
               CurrentSize := Trunc( CurrentDownloadSize + ( ( FileSize * Pct ) / 100.0 ) );
               Pct := ( CurrentSize * 100 ) div TotalDownloadSize;
               end;

          If   Assigned( PercentMessageLabel )
          then If   ( Pct>0 ) and ( Pct<=100 )
               then PercentMessageLabel.Caption := Format( '%d%%', [ Pct ] )
               else PercentMessageLabel.Caption := '';
          DataProgressBar.Position := Pct;

          end;

     If   Cancelled
     then Terminate := True;

     Application.ProcessMessages;
end;


end.

