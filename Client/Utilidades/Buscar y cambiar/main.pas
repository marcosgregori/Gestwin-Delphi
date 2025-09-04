unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, FileCtrl, Buttons, ComCtrls, ShlObj, cxShellCommon,
  dxSkinsCore, dxSkinsDefaultPainters, cxControls, cxContainer,
  cxShellListView, cxShellTreeView, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxEdit;

type
  TForm1 = class(TForm)
    buscaSubCheckBox: TCheckBox;
    Label2: TLabel;
    searchEdit: TEdit;
    Label3: TLabel;
    changeEdit: TEdit;
    Label4: TLabel;
    TipoFicheroRadio: TRadioGroup;
    Button2: TButton;
    Button3: TButton;
    Bevel1: TBevel;
    Label5: TLabel;
    FicheroLabel: TLabel;
    PathLabel: TLabel;
    Button4: TButton;
    Label1: TLabel;
    Button1: TButton;
    Button5: TButton;
    DirectoryCtrl: TcxShellTreeView;
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DirectoryCtrlChange(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
  public
     searchStrLen,
     changeStrLen,
     diffStrLen     : Integer;
     canceled       : boolean;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

resourceString
     rsMsg1  = 'Proceso finalizado';
     rsMsg2  = 'ATENCION';
     rsMsg3  = 'El comando no se ha ejecutado correctamente.';

procedure TForm1.Button4Click(Sender: TObject);
begin
     WNetConnectionDialog( handle, RESOURCETYPE_DISK );
     DirectoryCtrl.Update;
end;

procedure TForm1.Button2Click(Sender: TObject);

procedure Procesa( NombreFichero : String );


type TChangeRec = record
       OldStr,
       NewStr   : String;
       end;

const LeftSepChar   : set of char = [ ' ', ';', ',', '.', ':', '=', '<', '>', '(', '[', '''' ];
      RightSepChar  : set of char = [ ' ', ';', ',', '.', ':', '=', '<', '>', ')', '(', ']', '''' ];

      {
      NumOfChangeItems = 14;

      ChangeItems : array[ 1..NumOfChangeItems ] of TChangeRec =   ( ( OldStr : 'NroAsiento'; NewStr : 'NroAsiento' ),
                                                                     ( OldStr : 'NroApunte'; NewStr : 'NroApunte' ),
                                                                     ( OldStr : 'NroEfecto'; NewStr : 'NroEfecto' ),
                                                                     ( OldStr : 'CentroCoste'; NewStr : 'CentroCoste' ),
                                                                     ( OldStr : 'TipoAsiento'; NewStr : 'TipoAsiento' ),
                                                                     ( OldStr : 'BaseImponible'; NewStr : 'BaseImponible' ),
                                                                     ( OldStr : 'ImporteTotal'; NewStr : 'ImporteTotal' ),
                                                                     ( OldStr : 'NroRegistro'; NewStr : 'NroRegistro' ),
                                                                     ( OldStr : 'FechaVencimiento'; NewStr : 'FechaVencimiento' ),
                                                                     ( OldStr : 'NroRemesa'; NewStr : 'NroRemesa' ),
                                                                     ( OldStr : 'GrupoFacturacion'; NewStr : 'GrupoFacturacion' ),
                                                                     ( OldStr : 'NroLinea'; NewStr : 'NroLinea' ),
                                                                     ( OldStr : 'NroFactura'; NewStr : 'NroFactura' ),
                                                                     ( OldStr : 'VARCHAR'; NewStr : 'NVARCHAR' ) );
      }


      NumOfChangeItems = 1;
      ChangeItems : array[ 1..NumOfChangeItems ] of TChangeRec =   ( ( OldStr : 'Params = <>'; NewStr : '' ) );

var  FicheroOrigen,
     FicheroDestino       : textFile;
     NombreFicheroDestino : String;
     segmentLength,
     ChangeItemIndex,
     Index                : Integer;
     StrLine,
     StrSourceLine,
     StrDestLine,
     FileExt              : String;
     LeftString,
     RightString          : String;
     LeftSeparator,
     RightSeparator       : char;

function StrSearch( St         : String;
                    Buffer     : PChar;
                    BufferSize : Integer;
                    Index      : Integer ) : Integer;

var  StIndex  : SmallInt;

begin
     result := 0;
     While Index<=BufferSize do
       begin
       StIndex := 1;
       If   St[ StIndex ]=Buffer[ Index ]
       then begin
            inc( StIndex );
            If   StIndex=length( St )
            then begin
                 result := Index - length( St );
                 exit;
                 end;
            end
       else StIndex := 1;
       inc( Index );
       end;
end;

begin
     try

       FileExt   := UpperCase( ExtractFileExt( NombreFichero ) );

       If   ( ( TipoFicheroRadio.ItemIndex=0 ) and ( FileExt<>'.PAS' ) ) or
            ( ( TipoFicheroRadio.ItemIndex=1 ) and ( FileExt<>'.DFM' ) ) or
            ( ( TipoFicheroRadio.ItemIndex=2 ) and ( FileExt<>'.PAS' ) and ( FileExt<>'.DFM' ) and ( FileExt<>'.INC' )  and ( FileExt<>'.FR3' ) )
       then Exit;


       AssignFile( FicheroOrigen, NombreFichero );
       Reset( FicheroOrigen );

       NombreFicheroDestino := '$' + extractFileName( NombreFichero );
       NombreFicheroDestino := extractFilePath( NombreFichero ) + NombreFicheroDestino;

       AssignFile( FicheroDestino, NombreFicheroDestino );
       Rewrite( FicheroDestino );

       FicheroLabel.caption := NombreFichero;
       Application.ProcessMessages;

       repeat

         ReadLn( FicheroOrigen, StrLine );

         {

         StrSourceLine := StrLine;

         ChangeItemIndex := 1;
         repeat

           StrDestLine := '';

           repeat
             Index := Pos( UpperCase( ChangeItems[ ChangeItemIndex ].OldStr ), UpperCase( StrSourceLine ) );
             If   Index=0
             then StrDestLine := StrDestLine + StrSourceLine
             else begin

                  LeftString := copy( StrSourceLine, Index - 1, 1 );
                  If   LeftString=''
                  then LeftSeparator := ':'      // Un separador válido cualquiera
                  else LeftSeparator := LeftString[ 1 ];

                  RightString := copy( StrSourceLine, Index + length( ChangeItems[ ChangeItemIndex ].OldStr ), 1 );
                  If   RightString=''
                  then RightSeparator := ':'
                  else RightSeparator := RightString[ 1 ];

                  SegmentLength := Index + length( ChangeItems[ ChangeItemIndex ].OldStr );

                  If   ( LeftSeparator  in leftSepChar  ) and
                       ( RightSeparator in rightSepChar )
                  then begin
                       StrDestLine := StrDestLine + copy( StrSourceLine, 1, Index - 1 ) + ChangeItems[ ChangeItemIndex ].NewStr;
                       Delete( StrSourceLine, 1, SegmentLength - 1 );
                       end
                  else begin
                       StrDestLine := StrDestLine + copy( StrSourceLine, 1, SegmentLength - 1 );
                       Delete( StrSourceLine, 1, SegmentLength - 1 );
                       end;

                  end;
           until Index=0;
           Inc( ChangeItemIndex );

           StrSourceLine := StrDestLine;

         until ChangeItemIndex>numOfChangeItems;
         }

         StrDestLine := StrLine;

         For Index := 1 to NumOfChangeItems do
           StrDestLine := StringReplace( StrDestLine, ChangeItems[ Index ].OldStr, ChangeItems[ Index ].NewStr, [ rfReplaceAll, rfIgnoreCase ] );

         If   not ( ( Trim( StrLine )<>'' ) and ( Trim( StrDestLine )='' ) )
         then WriteLn( FicheroDestino, StrDestLine );

       until Eof( FicheroOrigen );

     except
       end;

     CloseFile( FicheroDestino );
     CloseFile( FicheroOrigen );

     DeleteFile( NombreFichero );
     RenameFile( NombreFicheroDestino, NombreFichero );

     If   Canceled
     then Abort;
end;

procedure buscaFicheros( path : String );

var   searchRec  : TSearchRec;

begin
     try
       If   findFirst( path + '\*.*', faAnyFile, searchRec )=0
       then repeat

               With searchRec do
                 If   ( attr and faDirectory ) <>0
                 then begin
                      If   ( Name<>'.' ) and
                           ( Name<>'..' ) and
                           ( UpperCase( Name )<>'LIB' ) and
                           ( UpperCase( Name )<>'FPC' ) and
                           BuscaSubCheckBox.Checked
                      then BuscaFicheros( path + '\' + Name );
                      end
                 else { If   ( attr and faArchive )<>0
                      then } procesa( path + '\' + Name );

            until findNext( searchRec )<>0;
     finally
       findClose( searchRec );
       end;
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
     application.messageBox( pChar( rsMsg1 ), pChar( rsMsg2 ), IDOK );
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
     Canceled := True;
     Application.Terminate;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     If   WinExec( PAnsiChar( 'attrib -r ' + PathLabel.Caption + '\*.*' ),   SW_SHOWNORMAL )<32
     then Application.MessageBox( PChar( RsMsg3 ), PChar( RsMsg2 ), IDOK );
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
     If   WinExec( PAnsiChar( 'dconvert -t -i ' + pathLabel.caption + '\*.dfm' ), SW_SHOWNORMAL )<32
     then Application.MessageBox( PChar( RsMsg3 ), PChar( rsMsg2 ), IDOK );
end;

procedure TForm1.DirectoryCtrlChange(Sender: TObject; Node: TTreeNode);
begin
     PathLabel.Caption := DirectoryCtrl.Path;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     // DirectoryComboBox.Directory := 'F:\Source';
end;

end.
