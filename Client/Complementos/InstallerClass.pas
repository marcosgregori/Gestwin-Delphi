unit InstallerClass;

interface

Uses
  WinAPI.Windows,

  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.IniFiles,
  System.Generics.Collections,
  Data.DB,
  
  System.Rtti,
  System.Bindings.Outputs,
  Data.Bind.Grid,

  AppManager;


type  TInstallOption     = ( opAll,
                             opNone,
                             opClient,
                             opServer );

      TInstallOptionSet  = set of TInstallOption;

      TFileDest          = ( fpSource,
                             fpDistribution,
                             fpTarget );

      TFileComponent = class

      public

         Disk           : Byte;
         PathAndName    : String;
         Overwrite      : Boolean;
         InstallOption  : TInstallOptionSet;
         // FileWinVersion : TWinVersion;
         ServerFile   : Boolean;
         OptionalModule : SmallInt;

         constructor Create( ADisk            : byte;
                             APathAndName     : String;
                             AnOverWrite      : Boolean;
                             AnInstallOption  : TInstallOptionSet;
                             // AWinVersion      : TWinVersion;
                             AServerFile    : Boolean;
                             AnOptionalModule : SmallInt );

         end;

      TInstaller = class

      private
    function ExtractModuleNumber(FileComponent: TFileComponent): String;

      public

        StringBuffer,
        DirectoryBuffer : array[ 0..MAX_PATH ] of Char;
        TemporalDirectory,
        WindowsDirectory,
        SystemDirectory,
        ApplicationDataDirectory : String;
        InfFile : text;

        NumOfDisks,
        DiskNumber : smallInt;
        InfFileName,
        ApplicationName,
        SourceInstallPath,
        SourceDrive,
        Options : String;
        FileList : TList<TFileComponent>;
        CommandList : TStringList;
        // sourceDriveNumber    : smallInt;

        Suscription : Boolean;  // Una instalación de suscripción
        Evaluation : Boolean;   // Una instalación de evaluación (directamente, sin comprobar licencias ni claves de activación)

        LineText : String;
        ParamList : Array[ 0..10 ] of String;

        constructor Create;
        destructor destroy; override;

        procedure GetInfFileName( Path : String = '' );
        procedure ReadConfigFile( Path : String = ''; CheckVersionOnly : Boolean = False );
        function  ExpandPathAndName( FilePath, FileName : String; FileDest : TFileDest ) : String;
        procedure ReadParamList;
        function GetOptionalModulesString( CurrentModuleString : String; OptionalInstallableModules : TModulosOpcionales ) : String;
        function GetOptionalDictionariesString(CurrentModuleString: String; OptionalInstallableModules: TModulosOpcionales): String;
        end;


function BreakUpFile( FileName : String; bits : ShortInt ) : Boolean;
function JoinFile( FileName : String; bits : ShortInt ) : Boolean;
function CreateSystemFolder( FolderName : String; ALocation : Integer ) : Boolean;
procedure AddShellItem( ApplicationName, Arguments, IconName, LinkName, FolderName : String; ALocation : Integer; AsAdministrator : Boolean = False );
procedure RemoveShellLink( LinkName, FolderName : String; ALocation : Integer; NotifyError : Boolean = False );
function BrowseURL(URL: string) : Integer;

implementation

uses   LibUtils,
       ShlObj,
       ActiveX,
       ComObj,
       Registry,
       WinAPI.ShellAPI,

       Files;

resourceString
       RsMsg1  = 'Error de entrada/salida.';
       RsMsg2  = 'No he conseguido abrir el fichero de información de la instalación (%s).';
       RsMsg3  = 'Se ha producido un error al crear el directorio [%s].';
       RsMsg4  = 'Compruebe si la unidad está llena o protegida contra escritura.';
       RsMsg5  = 'Se ha producido un error al intentar segmentar el fichero %s.';
       RsMsg6  = 'Se ha producido un error al leer el fichero de configuración';
       RsMsg7  = 'Se abandona el proceso de instalación';
       RsMsg8  = 'No he conseguido localizar el fichero de información de la instalación.';

function GetSpecialFolder( ALocation  : Integer ) : String;

var PIdl : PItemIDList;
    HPath : PChar;

begin
    Result := '';
    If   Succeeded( SHGetSpecialFolderLocation( 0, ALocation, PIdl ) )
    then begin
         HPath := StrAlloc( Max_Path );
         try
           SHGetPathFromIDList( PIdl, HPath );
           SetLastError( 0 ) ;
           Result := PChar( HPath );
         finally
           StrDispose( HPath ) ;
           end;
         end;
end;

constructor TInstaller.Create;
begin

     inherited Create;

     WindowsDirectory := String( GetSpecialFolder( CSIDL_WINDOWS ) );
     SystemDirectory := String( GetSpecialFolder( CSIDL_SYSTEM ) );
     ApplicationDataDirectory := String( GetSpecialFolder( CSIDL_COMMON_APPDATA ) + '\Gestwin\' );

     DirectoryBuffer := '%TEMP%';
     ExpandEnvironmentStrings( DirectoryBuffer, StringBuffer, MAX_PATH );
     TemporalDirectory := StringBuffer;

     Suscription := False;

     // Parametro 1 - La unidad de instalación

     If   ParamStr( 1 )=''
     then begin
          GetDir( 0, SourceInstallPath );
          Evaluation := True;
          end
     else SourceInstallPath := AnsiDequotedStr( ParamStr( 1 ), '"' );

     // Parametro 2 - El fichero de configuración (.idd)

     If   ParamCount>1
     then InfFileName := ParamStr( 2 );

     // Parametro 3 - Opciones de instalación - (guión) seguido de la letra del parámetro

     If   ParamCount>2
     then begin
          Options := UpperCase( ParamStr( 3 ) );
          If   Copy( Options, 1, 1 )='-'
          then Delete( Options, 1, 1 );

          Suscription := Pos( 'S', Options )<>0;

          // Otros parámetros

          //...

          end;

     SourceInstallPath := AddPathDelim( SourceInstallPath );
     SourceDrive := AddPathDelim( ExtractFileDrive( SourceInstallPath ) );
     FileList := TList<TFileComponent>.Create;
     CommandList := TStringList.Create;

end;

destructor TInstaller.Destroy;

var   Index  : Integer;

begin
     With FileList do
       begin
       For Index := 0 to FileList.count - 1 do
         Items[ Index ].Free;
       Free;
       end;

     CommandList.free;
     inherited destroy;
end;

procedure TInstaller.ReadParamList;

var   ParamText  : String;
      ParamIndex : byte;
      Cp         : ShortInt;

begin
     FillChar( ParamList, sizeOf( ParamList ), #0 );
     ParamText  := LineText;
     If   Copy( ParamText, 1, 1 )='&'
     then Delete( ParamText, 1, 1 );
     ParamIndex := 0;
     repeat
       Cp := Pos( ',', ParamText ) - 1;
       If   Cp=-1
       then Cp := Length( ParamText );
       ParamList[ ParamIndex ] := Trim( Copy( ParamText, 1, Cp ) );
       System.Delete( ParamText, 1, Cp + 1 );
       Inc( ParamIndex );
     until ( Length( ParamText )=0 )  or
           ( ParamIndex=11 );
end;

function TInstaller.ExtractModuleNumber( FileComponent : TFileComponent ) : String;

var  ModuleName : String;
     I : SmallInt;

begin
     Result := '';
     ModuleName := FileComponent.PathAndName;
     For I := 0 to Length( ModuleName ) do
       If   ModuleName[ I ] in [ '0'..'9' ]
       then StrAdd( Result, ModuleName[ I ] );
end;

function TInstaller.GetOptionalModulesString( CurrentModuleString        : String;
                                               OptionalInstallableModules : TModulosOpcionales ) : String;

var  I : SmallInt;
     FileComponent : TFileComponent;
     ModuleNumber : String;

begin
     Result := CurrentModuleString;
     With FileList do
       begin
       For I := 0 to FileList.Count - 1 do
         begin
         FileComponent := TFileComponent( Items[ I ] );
         If   Assigned( FileComponent )
         then With FileComponent do

                // Me aseguro de que sea el fichero del modulo (gdmxxx.bpl), podría ser una librería o cualquier otro fichero.

                If   ( OptionalModule<>0 ) and ( Pos( '[APPROOT]GDM2', UpperCase( PathAndName ) )<>0 ) and ( TModuloOpcional( OptionalModule ) in OptionalInstallableModules )
                then begin
                     ModuleNumber := ExtractModuleNumber( FileComponent );
                     If   ( ModuleNumber<>'' ) and ( Pos( ModuleNumber, Result )=0 )
                     then begin
                          If   Result<>''
                          then StrAdd( Result, ',' );
                          StrAdd( Result, ModuleNumber );
                          end;
                     end;
         end;

       end;

end;

function TInstaller.GetOptionalDictionariesString( CurrentModuleString        : String;
                                                    OptionalInstallableModules : TModulosOpcionales ) : String;

var  I : SmallInt;
     FileComponent : TFileComponent;
     ModuleNumber : String;

begin
     Result := CurrentModuleString;
     With FileList do
       begin
       For I := 0 to FileList.Count - 1 do
         begin
         FileComponent := Items[ I ];
         If   Assigned( FileComponent )
         then With FileComponent do

                // Me aseguro de que sea el subdirectorio del modulo opcional (dm2XX)

                If   ( OptionalModule<>0 ) and ( Pos( '[APPROOT]DM2', UpperCase( PathAndName ) )<>0 ) and ( TModuloOpcional( OptionalModule ) in OptionalInstallableModules )
                then begin
                     ModuleNumber := ExtractModuleNumber( FileComponent );
                     If   ( ModuleNumber<>'' ) and ( Pos( ModuleNumber, Result )=0 )
                     then begin
                          If   Result<>''
                          then StrAdd( Result, ',' );
                          StrAdd( Result, ModuleNumber );
                          end;
                     end;
         end;

       end;

end;
procedure TInstaller.GetInfFileName( Path : String = '' );

var  SearchRec : TSearchRec;
     FileName : String;
     PC : SmallInt;

begin

     If   InfFileName=''
     then begin
          If   Path=''
          then Path := SourceInstallPath;
          try
            If   FindFirst( AddPathDelim( Path ) + '*.idd', faArchive, SearchRec )=0
            then InfFileName := Path + SearchRec.Name;
          finally
            System.SysUtils.FindClose( SearchRec );
            end;
          end;

     If   InfFileName=''
     then begin
          ShowNotification( ntStop, RsMsg1, RsMsg8 );
          Abort;
          end;

     FileName := ExtractFileName( InfFileName );
     PC := Pos( '.', FileName );
     If   PC<>0
     then FileName := Copy( FileName, 1, Pred( PC ) );
     ApplicationName := Copy( FileName, 4, MaxInt );

end;

procedure TInstaller.ReadConfigFile( Path             : String = '';
                                     CheckVersionOnly : Boolean = False );

var   OpResult : Integer;
      CommandChar : Char;
      FileComponent : TFileComponent;

      VersionString : String;
      // FileWinVersion : TWinVersion;
      ServerFile,
      Overwrite : Boolean;
      Index : SmallInt;
      IoCheck : Integer;
      InstallOption : TInstallOptionSet;
      OptionalModule : SmallInt;

procedure RemoveCommand;
begin
     Delete( LineText, 1, Length( ParamList[ 0 ] ) + 2 );
end;

begin

     NumOfDisks := 0;
     DiskNumber := 1;

     With FileList do
       begin
       Pack;
       For Index := 0 to FileList.count - 1 do
         TFileComponent( items[ Index ] ).Free;
       Clear;
       end;

     CommandList.Clear;

     GetInfFileName( Path );

     Assign( InfFile, InfFileName, CP_UTF8 );
     Reset( InfFile );
     IoCheck := IoResult;
     If   IoCheck<>0
     then begin
          ShowNotification( ntStop, RsMsg1, Format( RsMsg2, [ InfFileName ] ) );
          Abort;
          end;
          
     try

       try

         While not Eof( InfFile ) do
           begin
           ReadLn( InfFile, LineText );
           If   Length( LineText )>0
           then begin
                CommandChar := LineText[ 1 ];
                case CommandChar of
                  '&' : begin

                        ReadParamList;
                        RemoveCommand;

                        If   UpperCase( ParamList[ 0 ] )='PARAMS'
                        then begin

                             { Se lee el número de aplicación, versión y revisión ... }

                             ProgramNumber := StrToInt( ParamList[ 1 ] );
                             ProgramVersion := StrToInt( ParamList[ 2 ] );
                             ProgramRelease := StrToInt( ParamList[ 3 ] );
                             VersionString := IntToStr( ProgramVersion );
                             If   Length( VersionString )=1
                             then VersionString  := '0' + VersionString;

                             end
                        else If   UpperCase( ParamList[ 0 ] )='JOIN'
                             then begin
                                  LineText := '0,' + LineText;
                                  CommandList.add( LineText );
                                  end
                             else If   UpperCase( ParamList[ 0 ] )='SHELL'
                                  then begin
                                       LineText := '1,' + LineText;
                                       CommandList.Add( LineText );
                                       end
                                  else If   UpperCase( ParamList[ 0 ] )='REG'
                                       then begin
                                            LineText := '2,' + LineText;
                                       CommandList.Add( LineText );
                                       end;
                        end;
                  '#' : begin
                        DiskNumber := StrToInt( Copy( LineText, 2, 1 ) );
                        If   ( DiskNumber<1 ) or
                             ( DiskNumber>9 )
                        then abort;
                        end;

                  ';' : { Es un comentario };

                  else  If   not CheckVersionOnly
                        then begin

                             ReadParamList;

                             Overwrite := UpperCase( ParamList[ 1 ] )='TRUE';
                             ParamList[ 2 ] := UpperCase( ParamList[ 2 ] );
                             ParamList[ 3 ] := UpperCase( ParamList[ 3 ] );

                             InstallOption  := [];

                             If   Pos( 'C', ParamList[ 2 ] )<>0
                             then InstallOption := InstallOption + [ opClient ]
                             else If   Pos( 'S', ParamList[ 2 ] )<>0
                                  then InstallOption := InstallOption + [ opServer ]
                                  else If   Pos( 'N', ParamList[ 2 ] )<>0
                                       then InstallOption := InstallOption + [ opNone ]
                                       else If   Pos( 'A', ParamList[ 2 ] )<>0
                                            then InstallOption := InstallOption + [ opAll ];

                             // FileWinVersion := wvUnknown;
                             ServerFile := False;
                             OptionalModule := 0;

                             If   ParamList[ 3 ]='SF'
                             then ServerFile := True;
                             {
                             else If   ParamList[ 3 ]='2K'
                                  then FileWinVersion := wvWin2000
                                  else If   ParamList[ 3 ]='XP'
                                       then FileWinVersion := wvWinXP
                                       else If   ParamList[ 3 ]='VISTA'
                                            then FileWinVersion := wvWinVista;
                             }

                             If   ParamList[ 4 ]<>''
                             then OptionalModule := StrToInt( ParamList[ 4 ] );

                             FileComponent := TFileComponent.Create( DiskNumber,
                                                                     ParamList[ 0 ],
                                                                     Overwrite,
                                                                     InstallOption,
                                                                     // FileWinVersion,
                                                                     ServerFile,
                                                                     OptionalModule );

                             FileList.Add( FileComponent );
                             end;
                  end;

                end;
           end;

       except on E : Exception do
         begin
         ShowNotification( ntStop, RsMsg6, E.Message );
         Abort;
         end;
       end;

     finally
       Close( InfFile );
       end;

     NumOfDisks := DiskNumber;

end;

function TInstaller.ExpandPathAndName( FilePath,
                                       FileName : String;
                                       FileDest : TFileDest ) : String;

var   Index,
      Pi,
      Pd : smallInt;
      VariableName : String;

const NumOfPaths = 5;
      Paths : array[ 1..NumOfPaths ] of String = ( 'INSTALLATION', 'APPROOT', 'WINDOWS', 'SYSTEM', 'APPDATA' );

begin
     Result := '';
     Pi := Pos( '[', FileName );
     If   Pi=0
     then Result := FilePath + FileName
     else begin
          Pd := Pos( ']', FileName );
          If   Pd<>0
          then begin
               VariableName := UpperCase( Copy( FileName, Pi + 1, Pd - Pi - 1 ) );
               System.Delete( FileName, Pi, Pd - Pi + 1 );
               For Index := 1 to NumOfPaths do
                 If   VariableName=Paths[ Index ]
                 then begin
                      case Index of
                          1 : case FileDest of
                                fpSource,
                                fpDistribution : Result := AddPathDelim( FilePath ) + FileName;
                                fpTarget       : Result := AddPathDelim( TemporalDirectory ) + FileName;
                                end;
                          2 : case FileDest of
                                fpSource       : Result := AddPathDelim( FilePath ) + FileName;
                                fpTarget,
                                fpDistribution : Result := AddPathDelim( FilePath ) + 'Gestwin\' + FileName;
                                end;
                          3 : case FileDest of
                                fpSource,
                                fpDistribution : Result := AddPathDelim( FilePath ) + 'Windows\' + FileName;
                                fpTarget       : Result := AddPathDelim( WindowsDirectory ) + FileName;
                                end;
                          4 : case FileDest of
                                fpSource,
                                fpDistribution : Result := AddPathDelim( FilePath ) + 'Windows\System32\' + FileName;
                                fpTarget       : Result := AddPathDelim( SystemDirectory ) + FileName
                                end;
                          5 : case FileDest of
                                fpSource,
                                fpDistribution : Result := AddPathDelim( FilePath ) + FileName;
                                fpTarget       : Result := AddPathDelim( ApplicationDataDirectory ) + FileName
                                end;
                          end;
                      Break;
                      end;
               end;
          end;
end;

{ TFileComponentList -------------------------------------------------------- }

constructor TFileComponent.Create( ADisk            : byte;
                                   APathAndName     : String;
                                   AnOverWrite      : Boolean;
                                   AnInstallOption  : TInstallOptionSet;
                                   // AWinVersion      : TWinVersion;
                                   AServerFile    : Boolean;
                                   AnOptionalModule : SmallInt );

begin
     inherited Create;
     Disk := ADisk;
     PathAndName := APathAndName;
     Overwrite := AnOverWrite;
     InstallOption := AnInstallOption;
     // FileWinVersion := AWinVersion;
     ServerFile := AServerFile;
     OptionalModule := AnOptionalModule;
end;

function BreakUpFile( FileName : String;
                      Bits     : ShortInt ) : Boolean;

var  sourceFile,
     targetFile       : file;
     pp,
     readBytes,
     writeBytes       : integer;
     buf              : array[ 1..2048 ] of Char;
     Index            : integer;
     FileInfo         : TSearchRec;
     bitNumber        : ShortInt;
     strFileName,
     targetName       : String;
     segmentSize,
     sizeOfSourceFile,
     bytesCount,
     bytesToCopy      : integer;

begin

     Result := false;

     try
       Assign( sourceFile, FileName );
       Reset( sourceFile, 1 );

       sizeOfSourceFile := fileSize( sourceFile );
       segmentSize      := sizeOfSourceFile div bits;
       pp := Pos( '.', FileName );
       If   pp<>0
       then Delete( FileName, pp, 4 );

       For bitNumber := 1 to bits do
         begin
         targetName := FileName + '.' + strIntPadded( bitNumber, 2 );
         Assign( targetFile, targetName );
         rewrite( targetFile, 1 );
         bytesToCopy := segmentSize;
         If   bitNumber=bits
         then bytesToCopy := bytesToCopy + ( sizeOfSourceFile mod bits );
         bytesCount := 0;

         If   bitNumber>1
         then seek( sourceFile, segmentSize * pred( bitNumber ) );

         repeat
           blockRead( sourceFile, buf, sizeOf( buf ), readBytes );
           inc( bytesCount, readBytes );
           If   bytesCount>bytesToCopy
           then dec( readBytes, bytesCount - bytesToCopy );
           blockWrite( targetFile, buf, readBytes, writeBytes );
         until ( readBytes=0 )             or
               ( writeBytes<>readBytes )   or
               ( bytesCount>=bytesToCopy );


         close( targetFile );
         end;

       close( sourceFile );
       Result := True;

     except on e : exception do begin
                                ShowNotification( ntStop, Format( RsMsg5, [ FileName ] ), e.message );
                                Abort;
                                end;
       end;
end;

function JoinFile( FileName : String; bits : ShortInt ) : Boolean;

var  sourceFile,
     targetFile       : file;
     pp,
     readBytes,
     writeBytes       : integer;
     buf              : array[ 1..2048 ] of char;
     Index            : integer;
     fileInfo         : TSearchRec;
     bitNumber        : ShortInt;
     sourceName       : String;
     segmentSize,
     sizeOfSourceFile,
     bytesCount,
     bytesToCopy      : integer;

begin

     Result := false;

     Assign( targetFile, FileName );
     rewrite( targetFile, 1 );
     If   IoResult=0
     then begin

          pp := Pos( '.', FileName );
          If   pp<>0
          then Delete( FileName, pp, 4 );

          For bitNumber := 1 to bits do
            begin
            sourceName := FileName + '.' + strIntPadded( bitNumber, 2 );
            Assign( sourceFile, sourceName );
            Reset( sourceFile, 1 );
            If   IoResult<>0
            then exit;
            repeat
              blockRead( sourceFile, buf, sizeOf( buf ), readBytes );
              blockWrite( targetFile, buf, readBytes, writeBytes );
            until ( readBytes=0 )           or
                  ( writeBytes<>readBytes );

            close( sourceFile );
            If   Ioresult<>0
            then exit;
            erase( sourceFile );
            If   ioResult<>0
            then exit;
            end;
          close( targetFile );
          Result := True;
          end;

end;

function CreateSystemFolder( FolderName : String;
                             ALocation  : Integer ) : Boolean;
var PIdl : PItemIDList;
    HPath : PChar;

begin
    Result := False;
    If   Succeeded( SHGetSpecialFolderLocation( 0, ALocation, PIdl ) )
    then begin
         HPath := StrAlloc( Max_Path );
         SHGetPathFromIDList( PIdl, HPath );
         SetLastError( 0 );
         CreateDirectory( PChar( HPath + '\\' + FolderName ), nil );
         If   ( GetLastError()=0 ) or( GetLastError()=ERROR_ALREADY_EXISTS )
         then Result := True;
         StrDispose( HPath );
         end;
end;

procedure AddShellItem( ApplicationName,
                        Arguments,
                        IconName,
                        LinkName,
                        FolderName        : String;
                        ALocation         : Integer;
                        AsAdministrator   : Boolean = False );

var   IObject : IUnknown;
      ISLink : IShellLink;
      ISLinkDataList : IShellLinkDataList;
      IPFile : IPersistFile;
      PIdl : PItemIDList;
      InFolder : array[0..Max_Path] of Char;
      St,
      CompleteLinkName : WideString;
      PdwFlags : Cardinal;

begin

    IObject := CreateComObject( CLSID_ShellLink );
    ISLink := IObject as IShellLink;
    IPFile := IObject as IPersistFile;
    ISLinkDataList := IObject as IShellLinkDataList;

    With ISLink do
      begin
      SetPath( PChar( ApplicationName ) ) ;
      SetArguments( PChar( Arguments ) );
      SetWorkingDirectory( PChar( ExtractFilePath( ApplicationName ) ) ) ;
      SetIconLocation( PChar( IconName ), 0 );
      SetDescription( PChar( LinkName ) );
      end;

    If   { ( WinVersion>=wvWinVista ) and } AsAdministrator
    then With ISLinkDataList do
           If   GetFlags( PdwFlags )=S_OK
           then If   ( PdwFlags or SLDF_RUNAS_USER )<>0
                then begin
                     PdwFlags := PdwFlags xor SLDF_RUNAS_USER;
                     If   SetFlags( PdwFlags )<>S_OK
                     then Beep;
                     end;

    // Normalmente ALocation = CSIDL_DESKTOPDIRECTORY o CSIDL_PROGRAMS

    SHGetSpecialFolderLocation( 0, ALocation, PIdl );
    SHGetPathFromIDList( PIdl, InFolder );

    If   FolderName=''
    then St := ''
    else St := '\' + FolderName;
    St := St + '\' + LinkName + '.lnk';

    CompleteLinkName := InFolder + St;
    IPFile.Save( PWChar( CompleteLinkName ), False );

end;

procedure RemoveShellLink( LinkName,
                           FolderName  : String;
                           ALocation   : Integer;
                           NotifyError : Boolean = False );

var  St : WideString;
     PIdl : PItemIDList;
     InFolder : array[0..Max_Path] of Char;
     CompleteLinkName : WideString;

begin

     SHGetSpecialFolderLocation( 0, ALocation, PIdl );
     SHGetPathFromIDList( PIdl, InFolder );

     If   FolderName=''
     then St := ''
     else St := '\' + FolderName;
     St := St + '\' + LinkName + '.lnk';

     CompleteLinkName := InFolder + St;

     EraseFile( CompleteLinkName, NotifyError );
end;

{
function BrowseURL(const URL: string) : boolean;

var  Browser : string;

begin
     Result := True;
     Browser := '';
     With TRegistry.Create do
       try
         RootKey := HKEY_CLASSES_ROOT;
         Access := KEY_QUERY_VALUE;
         If   OpenKey( '\htmlfile\shell\open\command', False)
         then Browser := ReadString('') ;
         CloseKey;
       finally
         Free;
         end;

     If   Browser = ''
     then begin
          Result := False;
          Exit;
          end;

     Browser := Copy(Browser, Pos('"', Browser) + 1, Length(Browser)) ;
     Browser := Copy(Browser, 1, Pos('"', Browser) - 1) ;
     ShellExecute(0, 'open', PChar(Browser), PChar(URL), nil, SW_SHOW ) ;
end;
}

function BrowseURL( URL : String ) : Integer;
begin
     If   UpperCase( Copy( URL, 1, 7 ) )<>'HTTP://'
     then URL := 'http://' + URL;
     Result := ShellExecute( 0, 'open', PChar( URL ), nil, nil, SW_SHOW ) ;
end;

end.

