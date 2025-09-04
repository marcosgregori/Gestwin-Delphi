unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, FileCtrl;

type
  TForm1 = class(TForm)
    buscaSubCheckBox: TCheckBox;
    Button2: TButton;
    Button3: TButton;
    Bevel1: TBevel;
    Label5: TLabel;
    ficheroLabel: TLabel;
    DriveComboBox: TDriveComboBox;
    DirectoryListBox: TDirectoryListBox;
    pathLabel: TLabel;
    Bevel2: TBevel;
    Button4: TButton;
    Label1: TLabel;
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
     searchStrLen,
     changeStrLen,
     diffStrLen     : integer;
     canceled       : boolean;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

resourceString
     rsMsg1  = 'Proceso finalizado';
     rsMsg2  = 'ATENCION';

procedure TForm1.Button4Click(Sender: TObject);
begin
     WNetConnectionDialog( handle, RESOURCETYPE_DISK );
     driveComboBox.update;
end;

procedure TForm1.Button2Click(Sender: TObject);

procedure procesa( nombreFichero : string );


type TChangeRec = record
       wordString  : string;

       end;

const leftSepChar   : set of char = [ ' ', ';', ',', '.', ':', '=', '<', '>', '(', '[' ];
      rightSepChar  : set of char = [ ' ', ';', ',', '.', ':', '=', '<', '>', ')', '(', ']' ];




      numOfReservedWords = 2;

      changeItems : array[ 1..numOfReservedWords ] of TChangeRec = ( 'type',
                                                                      );

var  ficheroOrigen,
     ficheroDestino       : textFile;
     nombreFicheroDestino : string;
     segmentLength,
     changeItemIndex,
     index                : integer;
     strLine,
     strSourceLine,
     strDestLine,
     fileExt              : string;
     leftString,
     rightString          : string;
     leftSeparator,
     rightSeparator       : char;

function strSearch( st         : string;
                    buffer     : pChar;
                    bufferSize : integer;
                    index      : integer ) : integer;

var  stIndex  : smallInt;

begin
     result := 0;
     While index<=bufferSize do
       begin
       stIndex := 1;
       If   st[ stIndex ]=buffer[ index ]
       then begin
            inc( stIndex );
            If   stIndex=length( st )
            then begin
                 result := index - length( st );
                 exit;
                 end;
            end
       else stIndex := 1;
       inc( index );
       end;
end;

begin
     try

       fileExt   := upperCase( extractFileExt( nombreFichero ) );

       If   ( ( tipoFicheroRadio.itemIndex=0 ) and ( fileExt<>'.PAS' ) )                            or
            ( ( tipoFicheroRadio.itemIndex=1 ) and ( fileExt<>'.DFM' ) )                            or
            ( ( tipoFicheroRadio.itemIndex=2 ) and ( fileExt<>'.PAS' ) and ( fileExt<>'.DFM' ) )
       then exit;


       assignFile( ficheroOrigen, nombreFichero );
       reset( ficheroOrigen );

       nombreFicheroDestino := '$' + extractFileName( nombreFichero );
       nombreFicheroDestino := extractFilePath( nombreFichero ) + nombreFicheroDestino;

       assignFile( ficheroDestino, nombreFicheroDestino );
       rewrite( ficheroDestino );

       ficheroLabel.caption := nombreFichero;
       application.processMessages;

       repeat

         readLn( ficheroOrigen, strLine );
         strSourceLine   := strLine;

         changeItemIndex := 1;
         repeat

           strDestLine := '';

           repeat
             index := pos( upperCase( changeItems[ changeItemIndex ].oldStr ), upperCase( strSourceLine ) );
             If   index=0
             then strDestLine := strDestLine + strSourceLine
             else begin

                  leftString := copy( strSourceLine, index - 1, 1 );
                  If   leftString=''
                  then leftSeparator := ':'      // Un separador válido cualquiera
                  else leftSeparator := leftString[ 1 ];

                  rightString := copy( strSourceLine, index + length( changeItems[ changeItemIndex ].oldStr ), 1 );
                  If   rightString=''
                  then rightSeparator := ':'
                  else rightSeparator := RightString[ 1 ];

                  segmentLength := index + length( changeItems[ changeItemIndex ].oldStr );

                  If   ( leftSeparator  in leftSepChar  ) and
                       ( rightSeparator in rightSepChar )
                  then begin
                       strDestLine := strDestLine + copy( strSourceLine, 1, index - 1 ) + changeItems[ changeItemIndex ].newStr;
                       delete( strSourceLine, 1, segmentLength - 1 );
                       end
                  else begin
                       strDestLine := strDestLine + copy( strSourceLine, 1, segmentLength - 1 );
                       delete( strSourceLine, 1, segmentLength - 1 );
                       end;

                  end;
           until index=0;
           inc( changeItemIndex );

           strSourceLine   := strDestLine;

         until changeItemIndex>numOfReservedWords;

         writeLn( ficheroDestino, strDestLine );
       until eof( ficheroOrigen );

     except
       end;

     closeFile( ficheroDestino );
     closeFile( ficheroOrigen );

     deleteFile( nombreFichero );
     renameFile( nombreFicheroDestino, nombreFichero );

     If   canceled
     then abort;
end;

procedure buscaFicheros( path : string );

var   searchRec  : TSearchRec;

begin
     try
       If   findFirst( path + '\*.*', faArchive, searchRec )=0
       then repeat

               With searchRec do
                 If   attr=faDirectory
                 then begin
                      If   buscaSubCheckBox.checked
                      then buscaFicheros( path + '\' + name );
                      end
                 else If   ( attr=0 )         or
                           ( attr=faArchive )
                      then procesa( path + '\' + name );

            until findNext( searchRec )<>0;
     finally
       findClose( searchRec );
       end;
     application.messageBox( pChar( rsMsg1 ), pChar( rsMsg2 ), IDOK );
end;

begin
     canceled     := false;
     {
     searchStrLen := length( searchEdit.text );
     changeStrLen := length( changeEdit.text );
     diffStrLen   := changeStrLen - searchStrLen;

     If   ( searchStrLen<>0 ) and
          ( changeStrLen<>0 )
     then

     }

     // chdir( pathLabel.caption );

     buscaFicheros( pathLabel.caption );
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
     canceled := true;
     application.terminate;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     winExec( pChar( 'attrib -r '     + pathLabel.caption + '\*.*' ),   SW_SHOWNORMAL );
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
     winExec( pChar( 'G:\Borland\Delphi6\Bin\convert -t -i ' + pathLabel.caption + '\*.dfm' ), SW_SHOWNORMAL );
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     DirectoryListBox.directory := 'F:\Source\Importado'; 
end;

end.
