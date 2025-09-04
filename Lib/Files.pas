
unit Files;

{$I-}

interface

uses   Windows,
       Classes,
       FileCtrl,
       SysUtils;

type   TCopyFileOption = ( cfNotIfyIfAbsent, cfOverWrite, cfNotifyError, cfCheckDate );

       TCopyFileOptions = set of TCopyFileOption;

       TCopyFileEvent = procedure( SourceName, TargetName : String; var DoCopy : Boolean ) of object;
       TOnEraseFileEvent = procedure( FileName : String ) of object;

       TFileInfo = class( TObject )
         Path,
         Name : String;
         Size : Int64;
         TimeStamp: TDateTime;
         end;

function  EraseFile( FileName : String; NotifyError : Boolean = True; OnEraseFile : TOnEraseFileEvent = nil ) : Boolean;
procedure EraseListOfFiles( FilePath : String; ListOfFileNames : array of String; NotifyError : Boolean = True );
function  RenameFile( OldName, NewName: String ) : Boolean;
function  CopyFile( Source, Target : String; CopyFileOptions : TCopyFileOptions = [ cfNotIfyIfAbsent, cfOverWrite, cfNotifyError ]; OnCopyOneFile : TCopyFileEvent = nil ) : Boolean; overload;
function  CopyFile( Source, Target : String; ExcludeList : array of String; CopyFileOptions : TCopyFileOptions = [ cfNotIfyIfAbsent, cfOverWrite, cfNotifyError ]; OnCopyOneFile : TCopyFileEvent = nil ) : Boolean; overload;
procedure CopyDirectory( SourcePath, TargetPath : String; CopyFileOptions : TCopyFileOptions = [ cfNotIfyIfAbsent, cfOverWrite, cfNotifyError ]; OnCopyOneFile : TCopyFileEvent = nil ); overload;
procedure CopyDirectory( SourcePath, TargetPath : String; ExcludeList : array of String; CopyFileOptions : TCopyFileOptions = [ cfNotIfyIfAbsent, cfOverWrite, cfNotifyError ]; OnCopyOneFile : TCopyFileEvent = nil ); overload;
procedure EraseDirectory( Path : String; RemoveDir : Boolean = True; OnEraseDirectory : TOnEraseFileEvent = nil );
procedure RenameDirectory( OldName, NewName : String );
function  EraseDirectories( Path : String; RemoveDir : Boolean = True; OnEraseDirectory : TOnEraseFileEvent = nil ) : Boolean;
function  GetFileSize( const Filename: String ) : Int64;
function  IsValidFileName( var FFileName : String; WithExtension : Boolean ) : Boolean;
function  IsFileAccesible( FileName : String ) : Boolean;
procedure ReadLine( var Fichero : Text; var St : String );
function  IoErrorMessage( ErrorNum : SmallInt ) : String;
procedure IoCheck( ErrorNum : SmallInt );
function  CheckDirectory( DirName : String; Create : Boolean ) : Boolean;
function  AddPathDelim( Path : String; PathDelim : Char = '\' ) : String;
function  RemovePathDelim( Path : String; PathDelim : Char = '\' ) : String;
function  CopyCompressedFile( SName, TName : String; var ErrorStatus : SmallInt; Overwrite : Boolean ) : Boolean;
procedure CreateDirPath( DirPath : String; ErrorMessage : String = '' );
procedure CheckDirPath( DirPath : String );
procedure GrantAllAccessToDirectory( Path : String );
function  ExtractLastDirectory( Path : String; AddDelim : Boolean = True ) : String;
function  ExtractFileNameDelim( const FileName  : String; PathDelim : Char ) : String;
function  GetFileAgeStamp( FileName : String ) : String;
procedure GetFileList( PathName, FileName : String; List : TStrings; Recursive : Boolean = False; RemoveExtension : Boolean = False; AddFileInfo : Boolean = False; Attr : Integer = faAnyFile - faDirectory );
function  ExistsLogicalDrive( Drive : String ) : Boolean;
function  GetTemporalFileName( TemporalDataPath, Prefix : String ) : String;
function  CreateNewTemporalFileName( BaseFilename : String; Ext : String ) : String;

function OpenFolderAndSelectFile( const FileName : String ) : Boolean;
procedure OpenFolder( const Directory : String );


const  LZErrorOpeningSource = 1;
       lzErrorOpeningTarget = 2;
       LZErrorCopyingFile   = 3;

var    lastIOError : SmallInt = 0;

implementation

uses   Winapi.AclAPI,
       Winapi.AccCtrl,
	      LZExpand,
       ShellAPI,
       ShlObj,
       LibUtils,
       AppManager,

       Controls,
       Forms;

reSourceString
       RsMsg1  = 'No se puede borrar el fichero %s.';
       RsMsg2  = 'No se puede renombrar el fichero %s como %s.';
       RsMsg3  = 'Error número %d.';
       RsMsg4  = 'Error de Entrada/Salida.';
       RsMsg5  = 'Revise sus  soportes de datos : espacio libre en disco, estado, etc..';
       RsMsg6  = 'No se encuentra el fichero ';
       RsMsg7  = 'El fichero no ha podido ser copiado porque no existe.';
       RsMsg8  = 'Ruta : %s';
       RsMsg9  = 'Se ha producido un error durante la copia del fichero.';
       RsMsg10 = 'Compruebe que la unidad destino no esté llena o protegida contra escritura y que el fichero no esté siendo usado por alguna aplicación.'#13'Fichero origen : %s.'#13'Fichero destino : %s.'#13''#13'<strong>¿Desea reintentar la copia del fichero?</strong>';
       RsMsg11 = 'No se ha podido crear el directorio %s.';
       RsMsg12 = 'Se ha producido una excepción.';
       RsMsg13 = 'El directorio indicado no existe o no es accesible.';

function IoErrorMessage( ErrorNum : SmallInt ) : String;

type   ErrorRec = packed record
         ID   : SmallInt;
         Desc : String;
         end;

var    St          : String;
       Index       : SmallInt;

const  MaxErrorRec = 12;

       StError     : array[ 0..MaxErrorRec ] of ErrorRec = ( ( ID :   2 ; Desc : 'Fichero no encontrado.'                   ),
                                                             ( ID :   3 ; Desc : 'Path (camino al directorio) inexistente.' ),
                                                             ( ID :   4 ; Desc : 'Demasiados ficheros abiertos.'            ),
                                                             ( ID :   5 ; Desc : 'Acceso al fichero denegado.'              ),
                                                             ( ID :  15 ; Desc : 'Número de unidad no válido.'              ),

                                                             ( ID : 100 ; Desc : 'Error de lectura en disco.'               ),
                                                             ( ID : 101 ; Desc : 'Error de escritura en disco.'             ),
                                                             ( ID : 102 ; Desc : 'Fichero no asignado.'                     ),
                                                             ( ID : 103 ; Desc : 'Fichero no abierto.'                      ),
                                                             ( ID : 104 ; Desc : 'Fichero no abierto para escritura.'       ),
                                                             ( ID : 105 ; Desc : 'Fichero no abierto para lectura.'         ),
                                                             ( ID : 106 ; Desc : 'Formato numérico no válido.'              ),
                                                             ( ID : 112 ; Desc : 'Disco lleno.'                             ) );


begin
     St := '';

     For Index := 0 to MaxErrorRec do
       If   StError[ Index ].ID=ErrorNum
       then begin
            St := StError[ Index ].Desc;
            Break;
            end;

     If   St=''
     then St := Format( RsMsg3, [ ErrorNum ] );

     Result := St;
end;

procedure IoCheck( ErrorNum : SmallInt );
begin
     lastIOError := ErrorNum;
     If   ErrorNum<>0
     then begin
          ShowNotification( ntStop, RsMsg4 + #13 + IoErrorMessage( ErrorNum ), RsMsg5 );
          Abort;
          end;
end;

function EraseFile( FileName    : String;
                    NotifyError : Boolean = True;
                    OnEraseFile : TOnEraseFileEvent = nil ) : Boolean;

Var  Fichero : File;
     FileInfo : TSearchRec;
     ErrorStatus : SmallInt;

procedure EraseOneFile( FileName : String );
begin
     If   Assigned( OnEraseFile )
     then OnEraseFile( FileName );
     Assign( Fichero, FileName );
     Erase( Fichero );
     ErrorStatus := IOResult;
     If   ( ErrorStatus<>0 ) and ( ErrorStatus<>2 ) and NotifyError
     then begin
          ShowNotification( ntStop, RsMsg12, Format( RsMsg1, [ FileName ] ), IoErrorMessage( ErrorStatus ) );
          Abort;
          end;
     Result := ErrorStatus=0;
end;

begin
     If   ( Pos( '*', FileName )<>0 ) or ( Pos( '?', FileName )<>0 )
     then begin
          try
            If   SysUtils.FindFirst( FileName, faArchive, FileInfo )=0
            then begin
                 FileName := ExtractFilePath( FileName );
                 repeat
                   If   ( ( FileInfo.Attr and faDirectory )=0 ) and
                        ( FileInfo.size>0 )
                   then EraseOneFile( FileName + FileInfo.Name );
                 until SysUtils.findNext( FileInfo )<>0;
                 end;
          finally
            SysUtils.FindClose( FileInfo );
            end;
          end
     else EraseOneFile( FileName );
end;

procedure EraseListOfFiles( FilePath        : String;
                            ListOfFileNames : array of String;
                            NotifyError     : Boolean = True );

var  Index : SmallInt;

begin
     For Index := 0 to High( ListOfFileNames ) do
       EraseFile( AddPathDelim( FilePath ) + ListOfFileNames[ Index ], NotifyError );
end;

function RenameFile( OldName, NewName : String ) : Boolean;

Var  Fichero : File;
     Outcome : Integer;

begin
     Assign( Fichero, OldName );
     Rename( Fichero, NewName );
     Outcome := IOResult;
     Result  := Outcome=0;
     If   Outcome<>0
     then ShowNotification( ntStop, RsMsg12, Format( RsMsg2, [ OldName, NewName ] ), IoErrorMessage( Outcome ) );
end;

function CopyFile( Source,
                   Target          : String;
                   CopyFileOptions : TCopyFileOptions = [ cfNotIfyIfAbsent, cfOverWrite, cfNotifyError ];
                   OnCopyOneFile   : TCopyFileEvent = nil ) : Boolean;
begin
     Result := CopyFile( Source, Target, [], CopyFileOptions, OnCopyOneFile );
end;

function CopyFile( Source,
                   Target          : String;
                   ExcludeList     : array of String;
                   CopyFileOptions : TCopyFileOptions = [ cfNotIfyIfAbsent, cfOverWrite, cfNotifyError ];
                   OnCopyOneFile   : TCopyFileEvent = nil ) : Boolean;

{   Si Source contiene WildCards entonces Target es el Path de destino.
    En caso contrario Source y Target son los nombres de los ficheros
    origen y destino
}

Var  Correct,
     FileAbsent,
     WildCards : Boolean;
     FileInfo : TSearchRec;
     SourceFileDate,
     TargetFileDate : TDateTime;

procedure CopyOneFile( SourceName, TargetName : String );

var  I : SmallInt;
     SourceFileName : String;
	 DoCopy : Boolean;
     ErrorCode : DWORD;
     ErrorMsg : String;

begin

     If   not ( cfOverWrite in CopyFileOptions )
     then If   FileExists( TargetName )
          then Exit;

     If   not FileExists( SourceName )
     then If   cfNotIfyIfAbsent in CopyFileOptions
          then begin
               ShowNotification( ntStop, RsMsg6 + SourceName, RsMsg7 );
               Abort;
               end
          else begin
               FileAbsent := True;
               Exit;
               end;

     If   cfCheckDate in CopyFileOptions
     then If   FileAge( SourceName, SourceFileDate )
          then begin
               If   not FileAge( TargetName, TargetFileDate )
               then TargetFileDate := 0;
               If   TargetFileDate>=SourceFileDate
               then Exit;
               end
          else Exit;

     If   High( ExcludeList )>=0
     then begin
          SourceFileName := ExtractFileName( SourceName );
          For I := 0 to High( ExcludeList ) do
            If   UpperCase( ExcludeList[ I ] )=UpperCase( SourceFileName )
            then Exit;
          end;

     DoCopy := True;

     If   Assigned( OnCopyOneFile )
     then OnCopyOneFile( SourceName, TargetName, DoCopy );

     If   DoCopy
     then Correct := Windows.CopyFile( PChar( SourceName ), PChar( TargetName ), not ( cfOverwrite in CopyFileOptions ) )
     else Correct := True;   // La copia se ha realizado en el evento

     If   Correct
     then Correct := SetFileAttributes( PChar( TargetName ), FILE_ATTRIBUTE_NORMAL )
     else begin
          ErrorCode := GetLastError;
          ErrorMsg := SysErrorMessage( ErrorCode );
          end;

     Application.ProcessMessages;

     If   not Correct and ( cfNotifyError in CopyFileOptions )
     then If   not ServerApplication and ( ShowNotification( ntQuestionWarning, RsMsg9, Format( RsMsg10, [ SourceName, TargetName ] ), ErrorMsg )=mrYes )
          then CopyOneFile( SourceName, TargetName )
          else Abort;
end;

begin
     Correct := True;
     FileAbsent := False;
     WildCards := ( Pos( '*', Source )<>0 ) or ( Pos( '?', Source )<>0 );

     If   WildCards
     then begin
          try
            If   SysUtils.FindFirst( Source, faArchive, FileInfo )=0
            then begin
                 Source := ExtractFilePath( Source );
                 Target := AddPathDelim( Target );
                 repeat
                   If   ( ( FileInfo.Attr and faDirectory )=0 ) and ( FileInfo.size>0 )
                   then CopyOneFile( Source + FileInfo.Name, Target + FileInfo.Name );
                 until SysUtils.FindNext( FileInfo )<>0;
                 end;
          finally
            SysUtils.FindClose( FileInfo );
            end;
          end
     else CopyOneFile( Source, Target );

     {
     If   not Correct and ( cfNotifyError in CopyFileOptions )
     then begin
          ShowNotification( ntStop, RsMsg9, RsMsg10 );
          Abort;
          end;
     }

     Result := Correct and not FileAbsent;
end;

function IsFileAccesible( FileName : String ) : Boolean;

Var  Fichero : File;
     IOError : Integer;

begin
     Assign( Fichero, FileName );
     Reset( Fichero );
     IOError := IOResult;
     Result  := ( IOError=0 ) or ( IOError=2 );
     If   IOError=0
     then Close( Fichero );
end;

function GetFileSize( const Filename: String ) : Int64;

var  Info : TWin32FileAttributeData;

begin
     Result := -1;
     If   GetFileAttributesEx( PWideChar( FileName ), GetFileExInfoStandard, @Info )
     then Result := Info.nFileSizeLow or ( Info.nFileSizeHigh shl 32 );
end;


function  IsValidFileName ( var FFileName     : String;
                                WithExtension : Boolean ) : Boolean;

Var   Correct : Boolean;
      Index,
      FnLen : SmallInt;

const CharSet : set of AnsiChar = [ 'a'..'z', 'A'..'Z', '0'..'9', '-', '_', '(', ')' ];

begin
     Correct := True;
     Index := 1;
     FnLen := Length( FFileName );
     while Correct and ( Index<=FnLen ) do
       begin
       If   ( WithExtension and not CharInSet( FFileName[ Index ], CharSet + [ '.' ] ) ) or
            ( not WithExtension and not CharInSet( FFileName[ Index ], CharSet ) )
       then Correct  := False
       else If   FFileName[ Index ]='.'
            then If   Index<FnLen - 3
                 then Correct  := False;
       Inc( Index );
       end;
     IsValidFileName := Correct;
end;

procedure ReadLine( var Fichero : Text;
                    var St      : String );

var   Index : SmallInt;

begin
     ReadLn( Fichero, St );
     For Index := 1 to Length( St ) do
       If   Ord( St[ Index ] )<32
       then St[ Index ] := #32;
end;

procedure CopyDirectory( SourcePath,
                         TargetPath      : String;
                         CopyFileOptions : TCopyFileOptions = [ cfNotIfyIfAbsent, cfOverWrite, cfNotifyError ];
                         OnCopyOneFile   : TCopyFileEvent = nil );
begin
     CopyDirectory( SourcePath, TargetPath, [], CopyFileOptions, OnCopyOneFile );
end;

procedure CopyDirectory( SourcePath,
                         TargetPath      : String;
                         ExcludeList     : array of String;
                         CopyFileOptions : TCopyFileOptions = [ cfNotIfyIfAbsent, cfOverWrite, cfNotifyError ];
                         OnCopyOneFile   : TCopyFileEvent = nil );

Var  SearchRec   : TSearchRec;

begin

     CreateDirPath( RemovePathDelim( TargetPath ) );
     CopyFile( AddPathDelim( SourcePath ) + '*.*', AddPathDelim( TargetPath ), ExcludeList, CopyFileOptions, OnCopyOneFile );

     try
       If   SysUtils.FindFirst( AddPathDelim( SourcePath ) + '*.*', faDirectory, SearchRec )=0
       then repeat
              If   ( SearchRec.Name<>'.' ) and ( SearchRec.Name<>'..' ) and ( ( SearchRec.Attr and faDirectory )>0 )
              then CopyDirectory( AddPathDelim( SourcePath ) + SearchRec.Name, AddPathDelim( TargetPath ) + SearchRec.Name, ExcludeList, CopyFileOptions, OnCopyOneFile );
            until SysUtils.FindNext( SearchRec )<>0;
     finally
       SysUtils.FindClose( SearchRec );
       end;
end;

procedure EraseDirectory( Path             : String;
                          RemoveDir        : Boolean = True;
                          OnEraseDirectory : TOnEraseFileEvent = nil );

var  SearchRec : TSearchRec;
     IoStatus : Integer;

begin
     EraseFile( AddPathDelim( Path ) + '*.*', False, OnEraseDirectory );
     try
       If   SysUtils.FindFirst( AddPathDelim( Path ) + '*.*', faDirectory, SearchRec )=0
       then repeat
              If   ( SearchRec.Name<>'.' ) and ( SearchRec.Name<>'..' ) and
                   ( ( SearchRec.Attr and faDirectory )>0 )
              then EraseDirectory( AddPathDelim( Path ) + SearchRec.Name );
            until SysUtils.FindNext( SearchRec )<>0;
     finally
       SysUtils.FindClose( SearchRec );
       If   RemoveDir
       then begin
            RmDir( Path );
            IoStatus := IOResult;  // Me limito a leerlo, sin ninguna comprobacion posterior, porque en algunos casos
                                   // me ha parecido observar que la variable IoStatus puede permanecer inalterada si a
                                   // continuación se realiza una función con éxito (?)
            end;
       end;
end;

procedure RenameDirectory( OldName, NewName : String );

var ShellInfo: TSHFileOpStruct;

begin
   ShellInfo.Wnd   := 0;
   ShellInfo.wFunc := FO_RENAME;
   ShellInfo.pFrom := PChar( OldName );
   ShellInfo.pTo   := PChar(NewName );

   SHFileOperation( ShellInfo );

end;

function EraseDirectories( Path             : String;
                           RemoveDir        : Boolean = True;
                           OnEraseDirectory : TOnEraseFileEvent = nil ) : Boolean;

Var  FileInfo : TSearchRec;

begin
     If   ( Pos( '*', Path )<>0 ) or ( Pos( '?', Path )<>0 )
     then begin
          try
            If   SysUtils.FindFirst( Path, faDirectory, FileInfo )=0
            then begin
                 Path := ExtractFilePath( RemovePathDelim( Path ) );
                 repeat
                   EraseDirectory( Path + FileInfo.Name );
                 until SysUtils.FindNext( FileInfo )<>0;
                 end;
          finally
            SysUtils.FindClose( FileInfo );
            end;
          end
     else EraseDirectory( Path );
end;

function CheckDirectory( DirName : String; Create : Boolean ) : Boolean;
begin
     Result := DirectoryExists( DirName );
     If   not Result and Create
     then begin
          MkDir( DirName );
          Result := IOResult=0;
          end;
end;

function AddPathDelim( Path      : String;
                       PathDelim : Char = '\' ) : String;
begin
     If   ( Path<>'' ) and ( Copy( Path, Length( Path ), 1 )<>PathDelim )
     then Result := Path + PathDelim
     else Result := Path;
end;

function RemovePathDelim( Path      : String;
                          PathDelim : Char = '\' ) : String;
begin
     If   Copy( Path, Length( Path ), 1 )=PathDelim
     then Result := Copy( Path, 1, Length( Path ) - 1 )
     else Result := Path;
end;

function CopyCompressedFile(     SName,
                                 TName       : String;
                             var ErrorStatus : SmallInt;
                                 Overwrite   : Boolean ) : Boolean;

var   SourceName,
      TargetName : array[ 0..MAX_PATH ] of Char;
      SourceBuff,
      TargetBuff    : TOFStruct;
      SourceHandle,
      TargetHandle  : SmallInt;

begin
     ErrorStatus := 0;
     Result := False;   // por defecto ... error!!
     StrPLCopy( SourceName, SName, MAX_PATH );
     StrPLCopy( TargetName, TName, MAX_PATH );

     If   not Overwrite
     then If   FileExists( TargetName )
          then begin
               Result := True;
               Exit;
               end;

     TargetHandle := LZOpenFile( TargetName, TargetBuff, of_create );
     If   TargetHandle>=0
     then begin
          SourceHandle := LZOpenFile( SourceName, SourceBuff, of_read );
          If   SourceHandle>=0
          then begin
               If   LZCopy( SourceHandle, TargetHandle )>0
               then Result := True
               else ErrorStatus := LZErrorCopyingFile;
               LZClose( SourceHandle );
               end
          else ErrorStatus := LZErrorOpeningSource;
          LZClose( TargetHandle );
          end
     else If   Overwrite
          then ErrorStatus := LZErrorOpeningTarget
          else Result := True;

end;

procedure CheckDirPath( DirPath : String );
begin
     DirPath := ExtractFilePath( DirPath );  // Por si lleva incluido el fichero
     If   not DirectoryExists( DirPath )
     then CreateDirPath( DirPath );
end;

procedure CreateDirPath( DirPath      : String;
                         ErrorMessage : String = '' );

var   Offset,
      Sp : SmallInt;
      PathSegment : String;
      FirstSegment,
      LastSegment : Boolean;
      SearchRec : TSearchRec;

begin
     DirPath := RemovePathDelim( DirPath );
     If   Length( DirPath )>3
     then begin
          FirstSegment := True;
          Offset := 4;
          repeat
            Sp := Pos( '\', Copy( DirPath, Offset, 255 ) );
            If   Sp<>0
            then begin
                 PathSegment := Copy( DirPath, 1, Offset + Sp - 2 );
                 Offset := Offset + Sp;
                 LastSegment := False;
                 end
            else begin
                 PathSegment := DirPath;
                 LastSegment := True;
                 end;

            If   not ( ( Copy( PathSegment, 1, 2 )='\\' ) and FirstSegment ) // Evitando el nombre del equipo en paths UNC
            then try
                   If   SysUtils.FindFirst( PathSegment + '\*', faDirectory + faSysFile + faHidden, SearchRec )<>0
                   then begin
                        If   not DirectoryExists( PathSegment )
                        then begin
                             MkDir( PathSegment );
                             If   IOResult<>0
                             then begin                             
                                  ShowNotification( ntWarning, IfThen( ErrorMessage='', RsMsg8, ErrorMessage ), Format( RsMsg11, [ PathSegment ] ) );
                                  Abort;
                                  end;
                             end;
                        end;
                 finally
                   SysUtils.FindClose( SearchRec );
                   end;
            FirstSegment := False;
          until LastSegment;
          end;
end;

procedure GrantAllAccessToDirectory( Path : String );

var   pNewDacl,
      pOldDacl : PACl;
      pSD : PSecurityDescriptor;
      EA : EXPLICIT_ACCESS;
      R : DWORD;
begin
     try
       pOldDacl := AllocMem( SizeOf( _ACL ) );
       try
         R := GetNamedSecurityInfo( PChar( Path ), SE_FILE_OBJECT, DACL_SECURITY_INFORMATION, nil, nil, @pOldDacl, nil, @pSD );
         If   R=ERROR_SUCCESS
         then begin
              LocalFree( pSD );
              BuildExplicitAccessWithName( @EA, PChar( 'Users' ), GENERIC_ALL, GRANT_ACCESS, SUB_CONTAINERS_AND_OBJECTS_INHERIT );
              R := SetEntriesInAcl( 1, @EA, pOldDacl, pNewDacl );
              If   R=ERROR_SUCCESS
              then begin
                   SetNamedSecurityInfo( PChar( Path ), SE_FILE_OBJECT, DACL_SECURITY_INFORMATION, nil, nil, pNewDacl, nil );
                   LocalFree( pNewDacl );
                   end;
              end;
       finally
         LocalFree( pOldDacl );
         end;
     except on E : Exception do
       ShowNotification( ntWarning, E.Message );
     end;
end;

// Una variante de la función de SysUtils que permite cambiar el PathDelim

function ExtractFileNameDelim( const FileName  : String;
                                     PathDelim : Char ) : String;
var  I : Integer;

begin
     I := FileName.LastDelimiter( PathDelim );
     If   I >= 0
     then Result := Copy( FileName, I + 2 )
     else Result := FileName;
end;

// Extrae el nombre del último directorio contenido en el Path

function ExtractLastDirectory( Path     : String;
                               AddDelim : Boolean = True ) : String;

var  Index  : SmallInt;

begin
     Result := Path;
     Path := RemovePathDelim( Path );
     For Index := Length( Path ) downto 1 do
       If   CharInSet( Path[ Index ], [ '\', ':' ] )
       then begin
            Result := Copy( Path, Index + 1, Length( Path ) );
            Break;
            end;
     If   AddDelim
     then Result := AddPathDelim( Result );
end;

function GetFileAgeStamp( FileName : String ) : String;

var  FileDate : TDateTime;
{
     Fad : TWin32FileAttributeData;
     SystemTime,
     LocalTime : TSystemTime;
}
begin
     
     If   FileAge( FileName, FileDate )
     then Result := DateTimeToStr( FileDate, DateTimeFormatSettings )
     else Result := LowestStrDate;
     {
     Result := LowestStrDate;
     If   GetFileAttributesEx( PChar( FileName ), GetFileExInfoStandard, @Fad )
     then If   FileTimeToSystemTime( Fad.ftCreationTime, SystemTime )
          then If   SystemTimeToTzSpecificLocalTime(nil, SystemTime, LocalTime)
               then Result :=  DateTimeToStr( SystemTimeToDateTime( LocalTime ) );
      }
end;

procedure GetFileList( PathName,
                       FileName        : String;
                       List            : TStrings;                       
                       Recursive       : Boolean = False;
                       RemoveExtension : Boolean = False;
                       AddFileInfo     : Boolean = False;
					                  Attr            : Integer = faAnyFile - faDirectory );


procedure FileSearch( const SearchPathName,
                            SearchFileName : String );

var SearchRec : TSearchRec;
    FileInfo : TFileInfo;
    FileName,
    Path : String;

begin
     Path := IncludeTrailingBackslash( SearchPathName );
     If   FindFirst( Path + SearchFileName, Attr, SearchRec )=0
     then try
            repeat
              FileName := SearchRec.Name;
              If   RemoveExtension
              then FileName := ExtractFileNameWithoutExtension( FileName );
              If   AddFileInfo
              then begin
                   FileInfo := TFileInfo.Create;
                   FileInfo.Path := Path;
                   FileInfo.Name := FileName;
                   FileInfo.Size := SearchRec.Size;
                   FileInfo.TimeStamp := SearchRec.TimeStamp;
                   List.AddObject( SearchRec.Name, FileInfo );
                   end
              else List.Add( FileName );
            until FindNext( SearchRec )<>0;
          finally
            FindClose( SearchRec );
            end;

     If   Recursive and ( FindFirst( Path + '*.*', faDirectory, SearchRec )=0 )
     then try
            repeat
              If   ( (SearchRec.Attr and faDirectory )<>0 ) and ( SearchRec.Name<>'.' ) and ( SearchRec.Name<>'..' )
              then FileSearch( Path + SearchRec.Name, SearchFileName );
            until FindNext( SearchRec )<>0;
          finally
            FindClose( SearchRec );
            end;
end;

begin
     If   List is TStringList
     then TStringList( List ).OwnsObjects := True;
     List.Clear;
     FileSearch( PathName, FileName );
end;

function ExistsLogicalDrive( Drive : String ) : Boolean;

var  SDrive : String;
     CDrive : Char;
     LD : DWORD;

begin
     SDrive := ExtractFileDrive( Drive );
     If   SDrive=''
     then Result := False
     else begin
          LD := GetLogicalDrives;
          CDrive := UpCase( SDrive[ 1 ] );
          If   CharInSet( CDrive, [ 'A'..'Z' ] )
          then Result := ( LD and ( 1 Shl ( Ord( CDrive ) - Ord( 'A' ) ) ) )<>0
          else Result := False;
          end;
end;

function GetTemporalFileName( TemporalDataPath, Prefix : String ) : String;

var  StrTmpDataPath : array[ 0..MAX_PATH ] of Char;
     StrPrefix : array[ 0..3 ] of Char;
     StrFileName : array[ 0..MAX_PATH ] of Char;

begin
     Result := '';
     StrPCopy( @StrTmpDataPath, TemporalDataPath );
     StrPCopy( @StrPrefix, Prefix );
     If   GetTempFileName( @StrTmpDataPath, @StrPrefix, 0, @StrFileName )<>0
     then Result := StrFileName;
end;

function CreateNewTemporalFileName( BaseFilename : String;
                                    Ext          : String ) : String;

var  DocIndex : Integer;
     FileName : String;
     FileNameFound : Boolean;

begin
     DocIndex := Random( 99999 );
     FileNameFound := False;
     BaseFileName := TemporalDataPath + BaseFilename;

     repeat
       Filename := BaseFilename + IntToStr( DocIndex ) + Ext;
       If   FileExists( Filename )
       then DocIndex := Random( 99999 )
       else FileNameFound := True;
     until FileNameFound;

     Result := Filename;
end;

function OpenFolderAndSelectFile( const FileName : String ) : Boolean;

var  IIDL: PItemIDList;

begin
     Result := False;
     IIDL := ILCreateFromPath( PChar( FileName ) );
     If   Assigned( IIDL )
     then try
            Result := SHOpenFolderAndSelectItems( IIDL, 0, nil, 0 )=S_OK;
          finally
            ILFree( IIDL );
            end;
end;

procedure OpenFolder( const Directory : String );
begin
     If   ShellExecute( Application.Handle, PChar( 'explore' ), PChar( Directory ), nil, nil, SW_SHOWNORMAL )<=32
     then ShowNotification( ntWarning, RsMsg13 );
end;

end.
