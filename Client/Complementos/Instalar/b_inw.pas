
unit b_inw;

interface

uses Forms, Classes, Controls, StdCtrls, ComCtrls, messages, Windows, sysutils,
  ExtCtrls, ZipForge;

type
  TChargeForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    ProgressBar: TProgressBar;
    Shape1: TShape;
    procedure FormCreate(Sender: TObject);
  private

    procedure WMInitiate( var message : TMessage ); message WM_USER;

    procedure ExpandProgress( Sender: TObject; Progress: double; Operation: TZFProcessOperation; ProgressPhase: TZFProgressPhase; var Cancel: boolean);
  public

    PathOrigen,
    PathDestino,
    ExecString : String;
    StartUpInfo : TStartUpInfo;
    ProcessInformation  : TProcessInformation;
    Error : LongInt;

    procedure DoCopyFile( SourceName, TargetName : String );
  end;

var   ChargeForm: TChargeForm;

implementation

{$R *.DFM}

procedure TChargeForm.ExpandProgress(     Sender        : TObject;
                                          Progress      : Double;
                                          Operation     : TZFProcessOperation;
                                          ProgressPhase : TZFProgressPhase;
                                      var Cancel        : Boolean );
begin
     ProgressBar.Position := Trunc( Progress );
end;

procedure TChargeForm.WMInitiate( var message : TMessage );

var  SearchRec   : TSearchRec;
     InfFileName : String;
     ApplicationName : String;
     Archiver : TZipForge;
     Compressed : Boolean;

function EraseFile( FileName : String ) : Boolean;

Var  Fichero : File;
     FileInfo : TSearchRec;
     ErrorStatus : SmallInt;

procedure EraseOneFile( FileName : String );
begin
     System.Assign( Fichero, FileName );
     Erase( Fichero );
     ErrorStatus := IOResult;
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

procedure EraseDirectory( Path        : String;
                          RemoveDir   : Boolean = True );

var  SearchRec : TSearchRec;
     IoStatus : Integer;

begin
     EraseFile( IncludeTrailingPathDelimiter( Path ) + '*.*' );
     try
       If   SysUtils.FindFirst( IncludeTrailingPathDelimiter( Path ) + '*.*', faDirectory, SearchRec )=0
       then repeat
              If   ( SearchRec.Name<>'.' ) and ( SearchRec.Name<>'..' ) and
                   ( ( SearchRec.Attr and faDirectory )>0 )
              then EraseDirectory( IncludeTrailingPathDelimiter( Path ) + SearchRec.Name );
            until SysUtils.FindNext( SearchRec )<>0;
     finally
       SysUtils.FindClose( SearchRec );
       If   RemoveDir
       then begin
            RmDir( Path );
            IoStatus := IOResult;  
            end;
       end;
end;

begin

     Application.ProcessMessages;

     If   DirectoryExists( PathDestino )
     then EraseDirectory( PathDestino );

     try
       MkDir( PathDestino );
     except
       Application.MessageBox( PChar( 'No he conseguido crear el directorio temporal ' + PathDestino ), 'ATENCION', MB_ICONEXCLAMATION or MB_OK );
       Application.Terminate;
       end;

     try

       try

         ApplicationName := ExtractFileName( ParamStr( 0 ) );
         If   UpperCase( ApplicationName )='INSTALAR.EXE'
         then begin
              DoCopyFile( PathOrigen + 'GWINST.EXE', PathDestino + 'GWINST.EXE' );
              ProgressBar.Position := 50;
              Compressed := False;
              end
         else begin   // Se está ejecutando desde un archivo comprimido
              Archiver := TZipForge.Create( Self );
              With Archiver do
                try
                  Options.OverwriteMode := omAlways;
                  FileName := PathOrigen + ApplicationName;
                  BaseDir := PathDestino;
                  Archiver.OnOverallProgress := ExpandProgress;
                  OpenArchive( fmOpenRead + fmShareDenyNone );
                  Archiver.ExtractFiles( '*.*' );
                  CloseArchive;
                finally
                  Archiver.Free;
                  end;

              PathOrigen := PathDestino;
              Compressed := True;
              end;

         InfFileName := 'gd_contable.idd';  // Es tan solo la opción por defecto

         try
           If   FindFirst( PathOrigen + '*.idd', faArchive, SearchRec )=0
           then InfFileName := SearchRec.Name;
         finally
           FindClose( SearchRec );
           end;

         If   not Compressed
         then begin
              DoCopyFile( PathOrigen + InfFileName, PathDestino + InfFileName );
              ProgressBar.Position := 75;
              end;

         ExecString := PathDestino + 'GWINST.EXE';
         CreateProcess( nil,
                        PChar( ExecString + ' "' + PathOrigen + '" ' + InfFileName + #0 ),
                        nil,
                        nil,
                        False,
                        0,
                        nil,
                        PChar( PathDestino ),
                        StartUpInfo,
                        ProcessInformation );

         ProgressBar.Position := 100;

       except Application.MessageBox( 'SE CANCELA EL PROCESO DE INSTALACION.' + #13 +
                                      'Si el error persiste consulte a su proveedor', 'Error', MB_ICONSTOP or MB_OK );
         end;
     finally
       Application.Terminate;
       end;

end;

procedure TChargeForm.DoCopyFile( SourceName, TargetName : String );

var   Correct : BOOL;

procedure CopyError;
begin
     Error := GetLastError;
     Application.MessageBox( PChar( 'No he conseguido cargar el fichero ' + SourceName + '.' + #13 + 'Error nº ' + IntToStr( Error ) + '.' ),
                             'ATENCION',
                             MB_ICONEXCLAMATION or MB_OK );
     Abort;
end;

begin
     Correct := Windows.DeleteFile( PChar( TargetName ) );
     If   Windows.CopyFile( PChar( SourceName ), PChar( TargetName ), False )
     then SetFileAttributes( PChar( TargetName ), FILE_ATTRIBUTE_NORMAL );
end;

procedure TChargeForm.FormCreate(Sender: TObject);

var   StrC : array[ 0..MAX_PATH ] of Char;

begin
     PathOrigen := ExtractFilePath( ParamStr( 0 ) );
     GetTempPath( MAX_PATH, StrC );
     PathDestino := IncludeTrailingPathDelimiter( StrC ) + '$gwinst\';
     PostMessage( Handle, WM_USER, 0, 0 );
end;

end.
