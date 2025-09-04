unit InfoInstall;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.IniFiles,

  Forms,
  cxLabel,
  cxProgressBar,

  ServiceManager;

type

  TOnDownloadFileEvent = function( FileName : String ) : Boolean of object;

  TInfoModule = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
  private

    DataProgressBar : TcxProgressBar;
    GlobalMessageLabel,
    PercentMessageLabel : TcxLabel;

    procedure DoOnCopyFile( SourceName, TargetName : String; var DoCopy : Boolean );
    function DoOnDownloadLibraryFile( FileName : String ) : Boolean;
    procedure CreateServiceManager;
    function GetServerFileName : String;
    function GetServerInitFileName : String;
    procedure ShowGlobalMessage( Value: String='' );
    procedure ShowPercentMessage( Value : String = '' );

  public

    BackupDirectoryName,
    BackupDirectory : String;

    Updated,
    Processing : Boolean;
    LibraryList,
    DefaultModulesList,
    OptionalModulesList,
    DictionariesList,
    FileList : TStringList;
    DefModules,
    SectionName,
    FileStrDate,
    FilePath,
    FileName,
    ServicePath : String;

    ApplicationNeedsUpdate,
    GdUpdNeedsUpdate,
    DBServerNeedsUpdate : Boolean;

    ServiceManager : TServiceManager;
    ServerServiceInfo : TServiceInfo;
    ServerServiceWasRunning,
    ServerServiceWasStopped : Boolean;

    BetaVersion : Boolean;
    Host : String;
    Port : SmallInt;

    procedure Connect( AUserName : String = '';
                       APassword : String = '';
                       AHost     : String = '';
                       APort     : SmallInt = 0 );
    procedure Disconnect;

    procedure UpdateAppInfo( AppName : String; DownloadHelpFiles : Boolean = True );
    procedure GetFileList( FileList : TStringList; Path : String; Files : String = '*.*'; ClearList : Boolean = True; Attr : Integer = faArchive );
    function CheckDateTimeStrings( DateTimeStr1, DateTimeStr2 : String ) : boolean;

    function Actualizacion( StatusLabel, MessageLabel, PercentLabel : TcxLabel; ProgressBar : TcxProgressBar; DescargarAyudas : Boolean = True; Reiniciar : Boolean = False; CerrarAlFinalizar : Boolean = True ) : Boolean;
    function Descarga( StatusLabel : TcxLabel; ProgressBar : TcxProgressBar; CerrarAlFinalizar : Boolean = False ) : Boolean;

    procedure StopServerService;
    procedure StopServer;
    procedure KillServer;

    function IsServerRunning : Boolean;
  end;

var  InfoModule : TInfoModule = nil;

     GdUpdUpdated : Boolean = False;   // Lo necesito para reiniciar la aplicación si es necesario
     InfoFileName : String;

function Info : TInfoModule;

const FileInfoName = 'Files.ini';
      EmptyStamp = '01/01/1900 00:00:00';

      GdUpdName = 'GdUpd.exe';
      GServerName = 'GServer.exe';
      GServer64Name = 'GServer64.exe';
      GServerInitName = 'GServer.init';
      GServer64InitName = 'GServer64.init';

      // Este array solo se utiliza en la publicación de aplicaciones

      FicherosLibreria : Array of String = [ 'Gd.exe',
                                             'Gw.exe',

                                             GdUpdName,

                                             'GwRestore.exe',
                                             'GwExport.exe',

                                             'MainLib.bpl',
                                             'Reports.bpl',
                                             'DBEngine.bpl',
                                             'ExtControls.bpl',
                                             'ExtControlsEE.bpl',
                                             'ExtControlsNC.bpl',
                                             'ExtControlsCC.bpl',
                                             'ExtControlsPS.bpl',
                                             'ExtControlsRE.bpl',
                                             'GdLib.bpl',
                                             'Security.bpl',
                                             'InetSecurity.bpl',

                                             'IndyCore290.bpl',
                                             'IndyProtocols290.bpl',
                                             'IndySystem290.bpl',

                                             'rtl290.bpl',
                                             'dsnap290.bpl',
                                             'inet290.bpl',
                                             'soaprtl290.bpl',
                                             'dbrtl290.bpl',
                                             'vcl290.bpl',
                                             'vclx290.bpl',
                                             'vcldb290.bpl',
                                             'vclimg290.bpl',
                                             'vclactnband290.bpl',
                                             'vclwinx290.bpl',
                                             'vcledge290.bpl',
                                             'xmlrtl290.bpl',
                                             'vclie290.bpl',
                                             'bindengine290.bpl',

                                             'WebView2Loader.dll' ];

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses  Messages,
      Windows,
      Files,
      LibUtils,

      WindowsServiceManager,

      AppManager,
      SuscriptionConsts,

      RpcInstall;

resourceString
      RsMsg1   = 'El fichero[%s] no existe.';
      RsMsg2   = 'Compruebe que está utilizando la versión adecuada a su aplicación GESTWIN actual.';

      RsMsg3  = 'El proceso de actualización ha finalizado correctamente.';
      RsMsg4  = 'Ahora ya dispone de una versión actualizada de su aplicación GESTWIN.';
      RsMsg5  = 'El proceso de actualización NO HA FINALIZADO CORRECTAMENTE.';
      RsMsg6  = 'Debe volver a realizarlo y finalizarlo con éxito si quiere actualizar su aplicación.';
      RsMsg7  = 'Se ha obtenido correctamente una copia actualizada de los ficheros necesarios. ¿Desea proceder a la actualización de su aplicación Gestwin?';
      RsMsg8  = 'Asegúrese de que nadie este utilizando la aplicación en este momento y de que el servidor de base de datos no se está ejecutando.';

      RsMsg9  = 'Falta un módulo o sección : %s';
      RsMsg10 = 'Uno de los ficheros necesarios para el correcto funcionamiento de su aplicación no está disponible en el servidor.'#13'No se puede completar la actualización de forma automática.'#13'Recurra a su soporte técnico para realizar el proceso.';
      RsMsg11 = 'No se ha podido leer el fichero %s.';
      RsMsg12 = 'Se cancela el proceso de actualización.';
      RsMsg13 = 'Ya dispone de la última versión de todos los ficheros de su aplicación.';
      RsMsg14 = 'No se ha realizado ninguna descarga ni actualización.';

      RsMsg15 = '¿Esta seguro de que desea cancelar la actualizacion de su aplicación?';
      RsMsg16 = 'Puede repetir el proceso más adelante cuando lo  considere oportuno.';

      RsMsg17 = 'Se ha producido un error durante la descarga del fichero.';
      RsMsg18 = 'Ha ocurrido un error durante el proceso de descompresión.';

      RsMsg19 = 'No se han podido verificar los datos de la aplicación en el servidor.';
      RsMsg20 = 'La aplicación que intenta actualizar no está registrada o alguna opción no coincide con el contenido de nuestros registros'#13'Póngase en contacto con nuestro servicio técnico.';

      RsMsg21 = 'No se ha podido copiar el fichero %s.';
      RsMsg22 = 'Compruebe que el fichero no esté siendo utilizado por otra aplicación. (Origen : %s ) ¿Desea reintentar la copia?';

      {
      RsMsg53 = 'El servidor de Gestwin está funcionando como servicio de Windows';
      RsMSg54 = '¿Desea detener el servicio antes de realizar la actualización?';
      }
      RsMsg55  = 'No se ha podido detener el servicio del servidor de GESTWIN.';
      RsMsg56  = 'Si es necesario actualizar el servidor no se podrá realizar el proceso de actualización.';
      RsMsg57  = 'Deteniendo el servidor';
      RsMsg58  = 'Reiniciando el servidor';

function Info : TInfoModule;
begin
     If   not Assigned( InfoModule )
     then InfoModule := TInfoModule.Create( Application );
     Result := InfoModule;
end;

function TInfoModule.CheckDateTimeStrings( DateTimeStr1, DateTimeStr2 : String ) : boolean;
begin
     Result := True;
     try
       Result := ( DateTimeStr1=EmptyStamp ) or
                 ( DateTimeStr2=EmptyStamp ) or
                 ( StrToDateTime( DateTimeStr1 )<StrToDateTime( DateTimeStr2 ) ) or
                 ( ( DateTimeStr1=LowestStrDate ) and ( DateTimeStr2=LowestStrDate ) );
     except
       end;
end;

procedure TInfoModule.GetFileList( FileList  : TStringList;
                                   Path      : String;
                                   Files     : String = '*.*';
                                   ClearList : Boolean = True;
                                   Attr      : Integer = faArchive );

var  Index : SmallInt;
     SearchRec : TSearchRec;
     IoStatus  : Integer;
     FileStrDate : String;

begin
     try
       If   ClearList
       then FileList.Clear;
       Path := AddPathDelim( Path );
       If   System.SysUtils.FindFirst( AddPathDelim( Path ) + Files, Attr, SearchRec )=0
       then repeat
              If   ( SearchRec.ExcludeAttr and Attr )=0
              then If   ( Attr and faDirectory )<>0
                   then FileList.Add( SearchRec.Name )
                   else If SearchRec.Size>0
                        then begin
                             FileStrDate := DateTimeToStr( FileDateToDateTime( FileAge( Path + SearchRec.Name ) ) );
                             FileList.Add( SearchRec.Name + '=' + FileStrDate );
                             end;
            until System.SysUtils.FindNext( SearchRec )<>0;
     finally
       System.SysUtils.FindClose( SearchRec );
       end;
end;

procedure TInfoModule.UpdateAppInfo( AppName           : String;
                                     DownloadHelpFiles : Boolean = True );

var  FileIndex,
     Index : SmallInt;
     LocalInfoFile : TMemIniFile;

procedure WriteFileInfo( FilePath, FileName : String );
begin
     If   FileExists( FilePath + FileName )
     then FileStrDate := DateTimeToStr( FileDateToDateTime( FileAge( FilePath + FileName ) ) )
     else FileStrDate := LowestStrDate;

     LocalInfoFile.WriteString( SectionName, FileName, FileStrDate );
end;

procedure AddSectionPath( SectionName,
                          FilePath     : String );

var  FileIndex : Integer;

begin
     LocalInfoFile.EraseSection( SectionName );
     GetFileList( FileList, FilePath, '*.*' );
     For FileIndex := 0 to FileList.Count - 1 do
       LocalInfoFile.WriteString( SectionName, FileList.Names[ FileIndex ], FileList.ValueFromIndex[ FileIndex ] );
end;

begin
     try

        LibraryList := TStringList.Create;
        DefaultModulesList := TStringList.create;
        OptionalModulesList := TStringList.create;
        DictionariesList := TStringList.create;

        FileList := TStringList.create;

        AppShortName := AppName;

        ReadIniFile;

        InfoFileName := ApplicationPath + 'gd_' + AppShortName + '.ini';
        LocalInfoFile := TMemIniFile.Create( InfoFileName );

        // Procesando las librerías principales

        SectionName := 'Libreria';
        LocalInfoFile.EraseSection( SectionName );
        FilePath := ApplicationPath;
        GetFileList( LibraryList, FilePath, '*.*' );

        For Index := 0 to High( FicherosLibreria ) do
          WriteFileInfo( ApplicationPath, FicherosLibreria[ Index ] );

        If   ProgramNumber=0  // Ficheros de actualización no vinculados a una aplicación en concreto
        then begin
             WriteFileInfo( ApplicationPath, GServerName );
             WriteFileInfo( ApplicationPath, GServerInitName );
             WriteFileInfo( ApplicationPath, GServer64Name );
             WriteFileInfo( ApplicationPath, GServer64InitName );
             end
        else begin
             WriteFileInfo( ApplicationPath, GetServerFileName );
             WriteFileInfo( ApplicationPath, GetServerInitFileName );
             end;

        // Procesando los módulos principales de la aplicación

        SectionName :='Modulos';
        LocalInfoFile.EraseSection( SectionName );

        DefModules := StrRemoveChars( DefaultModules, [ '*' ] );  // Quito los indicadores de módulo no inicializable
        ExtractStringList( DefModules, DefaultModulesList );

        For Index := 0 to DefaultModulesList.Count - 1 do
          WriteFileInfo( ApplicationPath, 'gdm' + DefaultModulesList.Strings[ Index ] + '.bpl' );

        // Reports y estructura de balances

        For Index := -1 to DefaultModulesList.Count - 1 do
          begin
          If   Index=-1
          then begin
               FilePath := ApplicationPath + 'reports';
               SectionName := 'RptDm';
               end
          else begin
               FilePath := ApplicationPath + 'reports\dm' + DefaultModulesList.Strings[ Index ];
               SectionName := 'RptDm' + DefaultModulesList.Strings[ Index ];
               end;
          LocalInfoFile.EraseSection( SectionName );
          GetFileList( FileList, FilePath, '*.fr3' );
          GetFileList( FileList, FilePath, '*.rcf', False );
          For FileIndex := 0 to FileList.Count - 1 do
            LocalInfoFile.WriteString( SectionName, FileList.names[ FileIndex ] ,FileList.ValueFromIndex[ FileIndex ] );
          end;

        // Ayudas

         If   DownloadHelpFiles
         then For Index := 0 to DefaultModulesList.Count - 1 do
                AddSectionPath( 'HelpDm' + DefaultModulesList.Strings[ Index ], ApplicationPath + 'Ayuda\hs' + DefaultModulesList.Strings[ Index ] );

        // Módulos opcionales

        SectionName := 'Opciones';
        LocalInfoFile.EraseSection( SectionName );
        ExtractStringList( OptionalModules, OptionalModulesList );

        For Index := 0 to OptionalModulesList.Count - 1 do
          WriteFileInfo( ApplicationPath, 'gdm' + OptionalModulesList.Strings[ Index ] + '.bpl' );

        // Diccionarios 

        DictionariesList := TStringList.create;
        ExtractStringList( Dictionaries, DictionariesList );
     
        For Index := 0 to DictionariesList.Count - 1 do
          begin
          FilePath := ApplicationPath + 'dm' + DictionariesList.Strings[ Index ];
          SectionName := 'Dm' + DictionariesList.Strings[ Index ];
          LocalInfoFile.EraseSection( SectionName );
          GetFileList( FileList, FilePath, '*.nx1' );
          For FileIndex := 0 to FileList.Count - 1 do
            If   Copy( FileList.names[ FileIndex ], 1, 1 )<>'$'
            then LocalInfoFile.WriteString( SectionName, FileList.Names[ FileIndex ] ,FileList.ValueFromIndex[ FileIndex ] );
          end;

        // WebAdmin (Administración remota del servidor)

        AddSectionPath( 'WebAdmin', ApplicationPath + 'ServerData\Admin' );
        AddSectionPath( 'WebAdminAssets', ApplicationPath + 'ServerData\Admin\assets' );
        AddSectionPath( 'WebAdminCss', ApplicationPath + 'ServerData\Admin\css' );
        AddSectionPath( 'WebAdminFonts', ApplicationPath + 'ServerData\Admin\fonts' );
        AddSectionPath( 'WebAdminImg', ApplicationPath + 'ServerData\Admin\img' );
        AddSectionPath( 'WebAdminImgIcons', ApplicationPath + 'ServerData\Admin\img\icons' );
        AddSectionPath( 'WebAdminJs', ApplicationPath + 'ServerData\Admin\js' );

        LocalInfoFile.UpdateFile;

     finally
       FileList.Free;
       OptionalModulesList.Free;
       DefaultModulesList.Free;
       DictionariesList.Free;
       LibraryList.Free;
       LocalInfoFile.Free;
       end;
end;

procedure TInfoModule.CreateServiceManager;
begin
     ServiceManager := TServiceManager.Create;
     ServiceManager.Active := True;
     try
       ServerServiceInfo := ServiceManager.ServiceByName[ DefaultServiceName ];
     except
       ServerServiceInfo := nil;
       end;
end;

procedure TInfoModule.ShowGlobalMessage( Value : String = '' );
begin
     If   Assigned( GlobalMessageLabel )
     then GlobalMessageLabel.Caption := Value;
     Application.ProcessMessages;
end;

procedure TInfoModule.ShowPercentMessage( Value : String = '' );
begin
     If   Assigned( PercentMessageLabel )
     then PercentMessageLabel.Caption := Value;
     Application.ProcessMessages;
end;

function TInfoModule.IsServerRunning : Boolean;
begin
     Result := ProcessExists( GetServerFileName );
end;

procedure TInfoModule.StopServer;
begin
     If   IsServerRunning
     then KillProcess( GetServerFileName );
end;

procedure TInfoModule.StopServerService;

var  Error : Boolean;
     ServerWndHandle : HWND;
     RetryCount : SmallInt;

procedure WaitUntilClosed( MaxRetryCount : SmallInt = 10 );
begin
     RetryCount := 0;
     repeat
       Delay( 2000 );
       Inc( RetryCount );
       Error := IsServerRunning;
     until not Error or ( RetryCount>MaxRetryCount );
end;

begin
     Error := False;
     ShowGlobalMessage( RsMsg57 );

     // La llamada ServiceStop ya no provoca una excepción si se produce un error. En última instancia se suprimirá el proceso y punto.

     ServerServiceInfo.ServiceStop( { Wait } True );

     If   ServerServiceInfo.State<>ssStopped
     then Error := True
     else WaitUntilClosed;

     If   Error
     then begin
          StopServer;   // Un ultimo intento de terminar con todo
          WaitUntilClosed( 5 );
          end;

     ServerServiceWasStopped := not IsServerRunning;
     If   not ServerServiceWasStopped
     then ShowNotification( ntWarning, RsMsg55, RsMsg56 );

end;

procedure TInfoModule.DataModuleDestroy(Sender: TObject);
begin
     InfoModule := nil;
     ServiceManager.Free;
end;

procedure TInfoModule.Connect( AUserName : String;
                               APassword : String;
                               AHost     : String;
                               APort     : SmallInt );
begin
     Rpc.Connect( 30, AUserName, APassword, AHost, APort );
end;

procedure TInfoModule.Disconnect;
begin
     Rpc.UpdateServiceClient.Disconnect;
end;

function TInfoModule.GetServerFileName : String;
begin
     If   Sp64BitsServer
     then Result := GServer64Name
     else Result := GServerName;
end;

function TInfoModule.GetServerInitFileName : String;
begin
     If   Sp64BitsServer
     then Result := GServer64InitName
     else Result := GServerInitName;
end;

function TInfoModule.DoOnDownloadLibraryFile( FileName : String ) : Boolean;
begin
     Result := True;
     If   ( FileName=GServerName ) or ( FileName=GServer64Name )
     then begin
          DBServerNeedsUpdate := True;
          If   ProgramNumber<>0  // Ficheros de actualización no vinculados a una aplicación en concreto
          then If   ( ( FileName=GServerName ) and Sp64BitsServer ) or
                    ( ( FileName=GServer64Name ) and not Sp64BitsServer )
               then Result := False;
          end;

end;

procedure TInfoModule.KillServer;
begin
     If   Assigned( ServerServiceInfo ) and
          ServerServiceWasRunning
     then StopServerService
     else StopServer;
end;

function TInfoModule.Actualizacion( StatusLabel,
                                    MessageLabel,
                                    PercentLabel      : TcxLabel;
                                    ProgressBar       : TcxProgressBar;
                                    DescargarAyudas   : Boolean = True;
                                    Reiniciar         : Boolean = False;
                                    CerrarAlFinalizar : Boolean = True ) : Boolean;

var  FileList : TStringList;
     Index : SmallInt;
     FileName,
     DirName : String;

     EraseFileList,
     LocalFileValues,
     RemoteFileValues,

     DirList : TStringList;

     HighFileIndex,
     FileIndex : LongInt;

     LocalInfoFile,
     RemoteInfoFile : TMemIniFile;

     Op,
     BackupDirIndex : SmallInt;
     ADirAge,
     BackupDirFileAge : Integer;

procedure UpdateApp( DescargarAyudas : Boolean );

var  Index : SmallInt;
     DownloadFiles : Boolean;

function GetFilesInfo( SectionName        : String;
                       FileList           : TStringList = nil;
                       DownloadFiles      : Boolean = False;
                       OnDownloadFile     : TOnDownloadFileEvent = nil ) : Boolean;

var   Index,
      FileIndex : Integer;
      FilePath,
      LocalValue,
      RemoteValue,
      LocalFileName,
      RemoteFileName,
      ModuleName : String;
      RemoteFileSize : Int64;
      Download : Boolean;

begin

     Result := False;
     FilePath := AddPathDelim( Rpc.LocalPath ) + FileInfoName; // AddPathDelim( Rpc.UpdatePath ) + FileInfoName;
     EraseFile( FilePath, False );

     Rpc.GetFile( FileInfoName );

     try

       RemoteInfoFile := TMemIniFile.Create( FilePath );
       RemoteFileValues := TStringList.Create;
       RemoteInfoFile.ReadSectionValues( SectionName, RemoteFileValues );

       LocalInfoFile.ReadSectionValues( SectionName, LocalFileValues );

       // Si hay algun fichero que ya no existe en la distribución lo añado a la lista de ficheros a borrar

       For Index := 0 to LocalFileValues.Count - 1 do
         begin
         LocalFileName := LocalFileValues.Names[ Index ];
         If   RemoteFileValues.IndexOfName( LocalFileName )=-1
         then EraseFileList.Add( AddPAthDelim( Rpc.CurrentDir ) + LocalFileName );
         end;

       For Index := 0 to RemoteFileValues.Count - 1 do
         begin

         RemoteFileName := RemoteFileValues.Names[ Index ];

         If   LocalFileValues.IndexOfName( RemoteFileName )=-1
         then begin
              If   Assigned( FileList )
              then If   not FileList.Find( RemoteFileName, FileIndex )
                   then Continue;
              LocalValue := LowestStrDate;
              end
         else LocalValue := LocalFileValues.Values[ RemoteFileName ];

         RemoteValue := RemoteFileValues.ValueFromIndex[ Index ];

         If   ( RemoteValue='' ) or Info.CheckDateTimeStrings( LocalValue, RemoteValue )
         then begin

              If   Assigned( OnDownloadFile )
              then Download := OnDownloadFile( RemoteFileName )
              else Download := True;

              If   Download
              then If   DownloadFiles
                   then begin

                        {$IFDEF DEBUG}
                        StatusLabel.Caption := RemoteFileName;
                        Application.ProcessMessages;
                        {$ENDIF}

                        RemoteFileSize := Rpc.GetFile( RemoteFileName );

                        If   RemoteFileSize=0
                        then begin
                             If   not Rpc.Cancelled
                             then ShowNotification( ntStop, Format( RsMsg11, [ RemoteFileName ] ), RsMsg10 );
                             Abort;
                             end
                        else begin
                             Inc( Rpc.CurrentDownloadSize, RemoteFileSize );
                             LocalInfoFile.WriteString( SectionName, RemoteFileName, RemoteValue );
                             {
                             If   Assigned( DataProgressBar )
                             then begin
                                  DataProgressBar.Value := Rpc.CurrentDownloadSize;
                                  Application.ProcessMessages;
                                  end;
                             }
                             Updated := True;
                             If   Rpc.Cancelled
                             then Abort;
                             end;

                        end
                   else begin
                        RemoteFileSize := Rpc.RemoteFileSize( RemoteFileName );
                        If   RemoteFileSize>0
                        then begin
                             Inc( Rpc.TotalDownloadSize, RemoteFileSize );
                             ApplicationNeedsUpdate := True;
                             If   RemoteFileName=GdUpdName
                             then GdUpdNeedsUpdate := True;
                             end
                        else begin
                             ShowNotification( ntStop, Format( RsMsg11, [ RemoteFileName ] ), RsMsg10 );
                             Abort;
                             end;
                        end;
              end;

         end;

     finally
       RemoteFileValues.Free;
       RemoteInfoFile.Free;
       end;
end;

begin

     DataProgressBar := ProgressBar;
     GlobalMessageLabel := MessageLabel;
     PercentMessageLabel := PercentLabel;

     Rpc.Setup( ptUpload, GlobalMessageLabel, PercentMessageLabel, ProgressBar, True, BetaVersion );

     If   Assigned( DataProgressBar )
     then begin
          DataProgressBar.Position := 0;
          DataProgressBar.Visible := True;
          end;

     Application.ProcessMessages;

     // Borro los ficheros de anteriores intentos

     EraseDirectory( Rpc.LocalDir + Rpc.VersionDir );

     // Actualizo todos los ficheros que han cambiado

     try

       FileList := TStringList.Create;
       LibraryList := TStringList.Create;
       DefaultModulesList := TStringList.Create;
       OptionalModulesList := TStringList.Create;
       DictionariesList := TStringList.Create;

       ApplicationNeedsUpdate := False;
       GdUpdNeedsUpdate := False;

       Rpc.TotalDownloadSize := 0;

       // Primero extraigo las listas de ficheros y compruebo si es necesario actualizar

       For DownloadFiles := False to True do
         begin

         If   DownloadFiles
         then begin
              If   ApplicationNeedsUpdate
              then begin
                   Rpc.CurrentDownloadSize := 0;
                   StatusLabel.Caption := 'Descargando ...';
                   DataProgressBar.Enabled := True;
                   Application.ProcessMessages;
                   If   Assigned( DataProgressBar )
                   then begin
                        With DataProgressBar do
                          begin
                          // Max := Rpc.TotalDownloadSize;
                          Position := 0;
                          Visible := True;
                          end;
                        Application.ProcessMessages;
                        end;
                   end
              else begin
                   ShowNotification( ntInformation, RsMsg13, RsMsg14 );
                   Exit;
                   end;
              end
         else begin
              StatusLabel.Caption := 'Comprobando si es necesario actualizar ...';
              DataProgressBar.Enabled := False;
              Application.ProcessMessages;
              end;

         DBServerNeedsUpdate := False;

         Rpc.FixCurrentDir( '' );

         GetFilesInfo( 'Libreria', LibraryList, DownloadFiles, DoOnDownloadLibraryFile );

         // En la comprobación inicial de la librería se ha visto que GdUpd necesita ser actualizado. Se hace antes que nada.

         If   not DownloadFiles and GdUpdNeedsUpdate
         then begin

              StatusLabel.Caption := 'Descargando una nueva versión del actualizador.';
              Application.ProcessMessages;

              GdUpdUpdated := False;

              If   Rpc.GetFile( GdUpdName )>0
              then begin

                   { Si estoy actualizando la propia aplicación de actualización (GdUpd.exe) no puedo copiar sobre ella porque está siendo bloqueada
                     por el Sistema. La solución es renombrarla (se puede aunque esté bloqueada) y entonces copiar sobre el nombre original }

                   EraseFile( ApplicationPath + '_' + GdUpdName, { NotIfyError } False );   // Por si existe de un intento anterior
                   RenameFile( ApplicationPath + GdUpdName, ApplicationPath + '_' + GdUpdName );

                   If   CopyFile( AddPathDelim( Rpc.LocalDir + Rpc.VersionDir ) + GdUpdName, ApplicationPath + GdUpdName, [ cfOverWrite, cfNotifyError ] )
                   then GdUpdUpdated := True;

                   end;

              If   not GdUpdUpdated
              then ShowNotification( ntError, Format( RsMsg11, [ GdUpdName ] ), RsMsg12 );

              Exit;
              end;

         // Hay que reconstruir la lista porque se ha alterado en el paso previo

         ExtractStringList( DefModules, DefaultModulesList, { ClearList } True );

         Rpc.FixCurrentDir( AddPathDelim( 'reports' ) );

         GetFilesInfo( 'RptDm', nil, DownloadFiles );

         For Index := 0 to DefaultModulesList.Count - 1 do
           If   Rpc.FixCurrentDir( AddPathDelim( 'reports\dm' + DefaultModulesList.Strings[ Index ] ) )
           then GetFilesInfo( 'RptDm' + DefaultModulesList.Strings[ Index ], nil, DownloadFiles );

         If   DescargarAyudas
         then begin
              Rpc.FixCurrentDir( AddPathDelim( 'ayuda' ) );
              For Index := 0 to DefaultModulesList.Count - 1 do
                If   Rpc.FixCurrentDir( AddPathDelim( 'ayuda\hs' + DefaultModulesList.Strings[ Index ] ) )
                then GetFilesInfo( 'HelpDm' + DefaultModulesList.Strings[ Index ], nil, DownloadFiles );
              end;

         Rpc.FixCurrentDir( '' );

         Application.ProcessMessages;

         If   not DownloadFiles
         then For Index := 0 to DefaultModulesList.Count - 1 do
                DefaultModulesList.Strings[ Index ] := 'gdm' + DefaultModulesList.Strings[ Index ]  + '.bpl';

         GetFilesInfo( 'Modulos', DefaultModulesList, DownloadFiles );

         If   not DownloadFiles
         then begin
              ExtractStringList( OptionalModules, OptionalModulesList );
              For Index := 0 to OptionalModulesList.Count - 1 do
                OptionalModulesList.Strings[ Index ] := 'gdm' + OptionalModulesList.Strings[ Index ] + '.bpl';
              end;

         GetFilesInfo( 'Opciones', OptionalModulesList, DownloadFiles );

         If   not DownloadFiles
         then ExtractStringList( Dictionaries, DictionariesList );

         For Index := 0 to DictionariesList.Count - 1 do
           If   Rpc.FixCurrentDir( AddPathDelim( 'dm' + DictionariesList.Strings[ Index ] ) )
           then GetFilesInfo( 'Dm' + DictionariesList.Strings[ Index ], nil, DownloadFiles );

         Application.ProcessMessages;

         // WebAdmin

         Rpc.FixCurrentDir( AddPathDelim( 'ServerData\Admin' ), True );
         GetFilesInfo( 'WebAdmin', nil, DownloadFiles );

         Rpc.FixCurrentDir( AddPathDelim( 'ServerData\Admin\assets' ), True );
         GetFilesInfo( 'WebAdminAssets', nil, DownloadFiles );

         Rpc.FixCurrentDir( AddPathDelim( 'ServerData\Admin\fonts' ), True );
         GetFilesInfo( 'WebAdminFonts', nil, DownloadFiles );

         Rpc.FixCurrentDir( AddPathDelim( 'ServerData\Admin\css' ), True );
         GetFilesInfo( 'WebAdminCss', nil, DownloadFiles );

         Rpc.FixCurrentDir( AddPathDelim( 'ServerData\Admin\img' ), True );
         GetFilesInfo( 'WebAdminImg', nil, DownloadFiles );

         Rpc.FixCurrentDir( AddPathDelim( 'ServerData\Admin\img\icons' ), True );
         GetFilesInfo( 'WebAdminImgIcons', nil, DownloadFiles );

         Rpc.FixCurrentDir( AddPathDelim( 'ServerData\Admin\js' ), True );
         GetFilesInfo( 'WebAdminJs', nil, DownloadFiles );

         end;

     finally
       FileList.Free;
       OptionalModulesList.Free;
       LibraryList.Free;
       DefaultModulesList.Free;
       DictionariesList.Free;
       end;

end;

begin

     try

       CreateServiceManager;

       If   Assigned( ServerServiceInfo )
       then begin
            ServerServiceInfo.Live := True;

            // Compruebo que el servicio del servidor se esté ejecutando desde el mismo directorio de instalación
            // Si no es así no es necesario detener el servicio para realizarla.

            // BinaryPath = 'F:\V11.0\Gestwin\GServer.exe /ServiceName:GestwinServerV1'

            ServicePath := ServerServiceInfo.BinaryPath;
            Op := Pos( '/', ServicePath );
            If   Op>1
            then ServicePath := Copy( ServicePath, 1, Op - 1 );
            ServicePath :=ExtractFilePath( ServicePath );
            ServerServiceWasRunning := ( ServerServiceInfo.State=ssRunning ) and ( UpperCase( ServicePath )=UpperCase( ApplicationPath ) );
            end;

       // Si se quiere reiniciar la instalación, suprimo todos los bpls, exes y logs existentes antes de actualizar

       If   Reiniciar
       then begin
            KillServer;

            // En caso de que no se pueda borrar algún fichero se notifica, para que se cierren los procesos activos y se reintente la operación

            EraseFile( ApplicationPath + '*.bpl' );
            EraseFile( ApplicationPath + 'gd.exe' );
            EraseFile( ApplicationPath + 'gserver*.exe' );
            EraseFile( ApplicationPath + '*.log' );

            EraseDirectories( ApplicationPath + 'dm*' );
            end;

       // Aprovecho para eliminar algún fichero antiguo de Gdupd.exe (estará renombrado como _GdUpd.exe)

       EraseFile( ApplicationPath + '_' + GdUpdName, { NotIfyError } False );

       // Primero actualizo la información de versiones Local

       Result := False;
       Processing := True;

       StatusLabel.Style.TextColor := TAlphaColorRec.Steelblue;

       Info.UpdateAppInfo( AppShortName );

       InfoFileName := 'gd_' + AppShortName + '.ini';
       LocalInfoFile := TMemIniFile.Create( ApplicationPath + InfoFileName );
       LocalFileValues := TStringList.Create;
       EraseFileList := TStringList.Create;

       If   not DeveloperVersion
       then begin
            Host := '';
            Port := 0;
            end;

       Updated := False;

       try

         try

           Connect( '', '', Host, Port );

           With Rpc.UpdateServiceClient, ProtectionRec do
             If   Request( FileService, '', 'Upgrade', [ SerialNumber, ActivationKey, RegNumber, ProgramNumber, ProgramVersion, ProgramRelease, ServerConnections ] )<>CCL_CORRECTA
             then begin
                  ShowNotification( ntStop, RsMsg19, RsMsg20 );
                  // Application.Terminate;
                  Abort;
                  end;

           UpdateApp( DescargarAyudas );;

         finally
           Disconnect;
           end;

         If   Rpc.Cancelled
         then ShowNotification( ntExceptionError, RsMsg5, RsMsg6 )
         else If   Updated
              then begin

                   repeat

                     If   ShowNotification( ntQuestionWarning, RsMsg7, RsMsg8 )=mrYes
                     then begin

                          If   DBServerNeedsUpdate
                          then KillServer;

                          ShowGlobalMessage;

                          try

                            Rpc.CurrentDownloadSize := 0;
                            If   Assigned( DataProgressBar )
                            then DataProgressBar.Position := 0;
                            StatusLabel.Caption := 'Actualizando la aplicación ...';
                            Application.ProcessMessages;

                            DirList := TStringList.Create;
                            BackupDirectory := Rpc.LocalDir + 'Backup';

                            GetFileList( DirList, AddPathDelim( BackupDirectory ), 'UB*', True, faDirectory );

                            With DirList do
                              begin

                              // No permito que hayan más de 9 copias de seguridad

                              If   Count>9
                              then EraseDirectory( AddPathDelim( BackupDirectory ) + Strings[ 2 ] );

                              BackupDirectoryName := 'UB' + FormatDateTime( 'yyyy-mm-dd HHMMSS', Now );
                              end;


                          finally
                            DirList.Free;
                            end;

                          BackupDirectory := AddPathDelim( BackupDirectory ) + BackupDirectoryName;
                          CreateDirPath( BackupDirectory );

                          // Copio el fichero actual de información. Debe restaurarse junto con los ficheros si el usuario utiliza la opción de restauración.

                          CopyFile( InfoFileName, AddPathDelim( BackupDirectory ) + ExtractFileName( InfoFileName ) );

                          CopyDirectory( Rpc.LocalDir + Rpc.VersionDir, ApplicationPath, [ cfNotIfyIfAbsent, cfOverWrite ], DoOnCopyFile );

                          LocalInfoFile.UpdateFile;

                          StatusLabel.Caption := 'Finalizado';
                          Application.ProcessMessages;

                          // Aprovecho para borrar el directorio AdminRoot, que ya no es necesario, y los ficheros que ya no se distribuyen

                          EraseDirectory( ApplicationPath + 'AdminRoot' );

                          For Index := 0 to EraseFileList.Count - 1 do
                            begin
                            FileName := EraseFileList.Strings[ Index ];
                            EraseFile( ApplicationPath + FileName, { NotifyError } False );
                            end;

                          If   not GdUpdUpdated  // Se va a ejecutar de nuevo, no hace falta mostrar el mensaje
                          then ShowNotification( ntInformation, RsMsg3, RsMsg4 );

                          Result := True;
                          end;

                   until Rpc.Cancelled or Result or ( ShowNotification( ntQuestionWarning, RsMsg15, RsMsg16 )=mrYes );
                   end;

              // else ShowNotification( mbInformation, RsMsg13, RsMsg14 );

            If   Assigned( ServerServiceInfo ) and
                 ServerServiceWasStopped
            then begin
                 ShowGlobalMessage( RsMsg58 );
                 ServerServiceInfo.ServiceStart( { Wait } True );
                 ShowGlobalMessage;
                 end;

         except on e : Exception  do
           If   not Rpc.Cancelled
           then begin
                If   not ( E is EAbort )
                then ShowNotification( ntExceptionError, E.Message );
                ShowNotification( ntStop, RsMsg5, RsMsg6 );
                end;
         end;

     finally

       LocalFileValues.Free;
       LocalInfoFile.Free;
       EraseFileList.Free;

       Processing := False;

       If   CerrarAlFinalizar
       then Application.Terminate;

       end;
end;

function TInfoModule.Descarga( StatusLabel       : TcxLabel;
                               ProgressBar       : TcxProgressBar;
                               CerrarAlFinalizar : Boolean = False ) : Boolean;

var ApplicationFilePath,
    ApplicationDirectory,
    CommandLine,
    ArchiveFileName : String;
    StartUpInfo : TStartUpInfo;
    ProcessInformation : TProcessInformation;
    CloseWindow : Boolean;
    FileSize : Int64;

begin

     ProgressBar.Position := 0;

     With Rpc do
       try

         Processing := True;

         StatusLabel.Style.TextColor := TAlphaColorRec.Steelblue;
         StatusLabel.Caption := 'Conectando...';
         Application.ProcessMessages;

         Connect;

         AppShortName := FicheroAplicacion[ ProgramNumber ];

         StatusLabel.Caption := 'Descargando.';
         Application.ProcessMessages;

         Setup( ptDownload, StatusLabel, PercentMessageLabel, ProgressBar, { ReadConfigFile } False, BetaVersion );  // Ojo, no se ha de leer el IniFile

         FixCurrentDir( '' );

         ArchiveFileName := 'GESTWIN ' + AppShortName + '.exe';
         try
           GetFile( ArchiveFileName );
         except on E : Exception do
           begin
           StatusLabel.Caption := 'Descarga interrumpida.';
           StatusLabel.Style.TextColor := TAlphaColorRec.Coral;
           Application.ProcessMessages;
           If   not Rpc.Cancelled
           then ShowNotification( ntError, RsMsg17, E.Message );
           Exit;
           end;
         end;

         StatusLabel.Style.TextColor := TAlphaColorRec.Darkgreen;
         StatusLabel.Caption := 'Descargado.';
         Application.ProcessMessages;

         StatusLabel.Caption := 'Instalando.';
         Application.ProcessMessages;

         try

           FillChar( ProcessInformation, SizeOf( ProcessInformation ), #0 );
           FillChar( StartupInfo, SizeOf( StartupInfo ), #0 );

           ApplicationDirectory := Rpc.LocalPath + AppShortName;

           ChDir( ApplicationDirectory );

           ApplicationFilePath := ApplicationDirectory + '\gwinst.exe';
           CommandLine := RemovePathDelim( ExtractFilePath( ApplicationFilePath ) ) + ' gd_' + AppShortName + '.idd -S';
           {
           If   SuscripcionPageControl.ActivePageIndex=1
           then CommandLine := CommandLine +'E';  // Versión de evaluación
           }

           StartupInfo.dwFlags := STARTF_USESHOWWINDOW;

           If   not CreateProcess( nil,
                                   PChar( ApplicationFilePath + ' ' + CommandLine ),
                                   nil,
                                   nil,
                                   True,
                                   0,
                                   nil,
                                   PChar( ApplicationDirectory ),
                                   StartupInfo,
                                   ProcessInformation )
           then Abort
           else CloseWindow := True;

         except
           StatusLabel.Style.TextColor := TAlphaColorRec.Coral;
           StatusLabel.Caption := 'Error de ejecución.';
           Application.ProcessMessages;

           ShowNotification( ntStop, RsMsg2, '' );
           Exit;
           end;

       finally
        Processing := False;
        Disconnect;
        If   CerrarAlFinalizar
        then Application.Terminate;
        end;

end;

procedure TInfoModule.DoOnCopyFile( SourceName, TargetName : String; var DoCopy : Boolean );

var TargetFileName,
    Path : String;
    Correct : Boolean;

begin

     Path := AddPathDelim( BackupDirectory ) + Copy( TargetName, Length( ApplicationPath ) + 1, MaxInt );
     CheckDirPath( Path );

     CopyFile( TargetName, Path, [ cfOverWrite, cfNotifyError ] );

     repeat
       Correct := CopyFile( SourceName, TargetName, [ cfOverWrite ] );
       If   not Correct
       then If   ShowNotification( ntQuestionWarning, Format( RsMsg21, [ TargetName ] ), Format( RsMsg22, [ SourceName ] ) )<>mrYes
            then Abort;
     until Correct;

     DoCopy := False;  // Ya se ha realizado la copia, la función no debe repetirla

     Inc( Rpc.CurrentDownloadSize, GetFileSize( TargetName ) );

     If   Assigned( DataProgressBar ) and
          DataProgressBar.Enabled and
          ( Rpc.TotalDownloadSize<>0 )
     then begin
          DataProgressBar.Position := ( Rpc.CurrentDownloadSize * 100 ) / Rpc.TotalDownloadSize;
          Application.ProcessMessages;
          end;

end;


end.
