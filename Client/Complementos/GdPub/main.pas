unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons,

  ComCtrls,
  ExtCtrls,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IniFiles,
  Menus,
  dxGDIPlusClasses, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, cxImage,
  cxButtons, cxProgressBar, cxLabel, cxGroupBox, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, dxUIAClasses,

  ZipForge;

type
  TMainForm = class(TForm)
    Panel4: TcxGroupBox;
    ActualizarAyudasCtrl: TCheckBox;
    VersionBetaCtrl: TCheckBox;
    Image3: TcxImage;
    Label2: TcxLabel;
    fileNameLabel: TcxLabel;
    Label3: TcxLabel;
    AppLabel: TcxLabel;
    CaptionPanel: TcxGroupBox;
    Shape4: TShape;
    cxLabel1: TcxLabel;
    Image1: TcxImage;
    ActualizarButton: TcxButton;
    CancelarButton: TcxButton;
    cxGroupBox1: TcxGroupBox;
    PercentLabel: TcxLabel;
    ProgressBar: TcxProgressBar;
    ServidorCtrl: TcxComboBox;
    cxLabel2: TcxLabel;
    MainPanel: TcxGroupBox;
    Panel3: TcxGroupBox;
    procedure CancelButtonClick(Sender: TObject);
    procedure ActualizarButtonClick(Sender: TObject);
    procedure CaptionPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private

    Processing : Boolean;

    LocalInfoFile,
    RemoteInfoFile {,
    GlobalInfoFile } : TMemIniFile;

  protected
    procedure DoOnProgress( Sender: TObject; FileName: TZFString; Progress: double; Operation: TZFProcessOperation; ProgressPhase: TZFProgressPhase; var Cancel: boolean);
  public
    procedure PublishApp( UpdateHelp : Boolean = False );
    procedure Actualizacion;
  end;

var
  MainForm: TMainForm;

implementation

uses   Files,
       ZLib,
       LibUtils,

       AppManager,
       InfoInstall,
       RpcInstall,

       MessageBox;

{$R *.DFM}

resourceString

     RsMsg1  = '¿Esta seguro de que desea cancelar el proceso de actualización?';
     RsMsg2  = 'Si no realiza el proceso de actualización no podrá acceder a la aplicación.';
     RsMsg3  = 'El proceso de actualización ha finalizado correctamente.';
     RsMsg5  = 'El proceso de actualización NO ha finalizado correctamente.';
     RsMsg6  = 'Debe volver a realizarlo y finalizarlo con éxito si quiere utilizar su aplicación.';

const MainAppModule = 'GdLib.bpl';


(*
function TForm1.getFileVersion( fileName : String ) : TVersionInfo;

const  infoNum  = 10;
       infoStr  : array[ 1..infoNum ] of String = ( 'CompanyName',
                                                    'FileDescription',
                                                    'FileVersion',
                                                    'InternalName',
                                                    'LegalCopyright',
                                                    'LegalTradeMarks',
                                                    'OriginalFileName',
                                                    'ProductName',
                                                    'ProductVersion',
                                                    'Comments' );
type  charArray  = array of wideChar;

var   s          : String;
      n,
      len,
      i          : DWORD;
      buf        : pChar;
      value      : pChar;
      stringList : TStringList;

const strFileVersion : wideString = 'FileVersion';

begin
     result.value := 0;
     try
       n := getFileVersionInfoSize( pChar( fileName ), n );
       If   n>0
       then try
              stringList := TStringList.Create;
              buf        := allocMem( n );
              getFileVersionInfo( pChar( fileName ), 0, n, buf );
              For i := 1 to InfoNum do
                If   verQueryValue( buf, pChar( strFileVersion ), pointer( value ), len )
                then begin
                     extractStringList( value, stringList, '.' );
                     result.majorVersion := strToInt( stringList.Strings[ 0 ] );
                     result.minorVersion := strToInt( stringList.Strings[ 1 ] );
                     result.release      := strToInt( stringList.Strings[ 2 ] );
                     result.build        := strToInt( stringList.Strings[ 3 ] );
                     end;
            finally
              freeMem( buf, n );
              stringList.free;
              end;
     except
       end;
end;
*)

procedure TMainForm.ActualizarButtonClick(Sender: TObject);
begin
     Actualizacion;
end;

procedure TMainForm.CancelButtonClick(Sender: TObject);
begin
     If   Processing and not Rpc.Cancelled
     then begin
          If   ShowNotification( ntQuestionWarning, RsMsg1, RsMsg2 )<>mrYes
          then Exit;
          Rpc.Cancelled := True;
          end;
     Application.Terminate;
end;

procedure TMainForm.CaptionPanelMouseDown(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

const sc_DragMove = $F012;

begin
     ReleaseCapture;
     Perform( wm_SysCommand, sc_DragMove, 0 );
end;

procedure TMainForm.PublishApp( UpdateHelp : Boolean = False );

var  SearchRec        : TSearchRec;
     DictionariesList,
     DefaultModulesList,
     OptionalModulesList,
     LocalFileValues  : TStringList;
     Index            : smallInt;
     dirName,
     InfoFileName     : String;

function HasFiles( SectionName : String = '' ) : Boolean;
begin
     LocalInfoFile.ReadSectionValues( SectionName, LocalFileValues );
     Result := LocalFileValues.Count>0;
end;

procedure PublishFiles( SectionName : String = '' );

var   Index : smallInt;
      RemoteFileValues : TStringList;
      FilePath,
      FileName,
      // GlobalValue,
      LocalValue,
      RemoteValue : String;
      RemoteValueExists : boolean;
      Processed : Boolean;

begin

     FilePath := AddPathDelim( Rpc.LocalPath ) + FileInfoName; // AddPathDelim( Rpc.UpdatePath ) + FileInfoName;
     EraseFile( FilePath, False );

     FileNameLabel.Caption := FileInfoName;
     Application.ProcessMessages;

     // El motivo de leer el fichero de información remoto es porque se puede llamar a PublishApp desde varios puntos de la aplicación sobre el
     // mismo directorio remoto, por lo que hay que respetar las actualizaciones existentes.

     Rpc.GetFile( FileInfoName );

     try

       RemoteInfoFile := TMemIniFile.Create( FilePath );
       RemoteFileValues := TStringList.Create;
       RemoteInfoFile.ReadSectionValues( SectionName, RemoteFileValues );

       LocalInfoFile.ReadSectionValues( SectionName, LocalFileValues );

       Processed := False;

       For Index := 0 to LocalFileValues.Count - 1 do
         begin

         FileName := LocalFileValues.Names[ Index ];
         FileNameLabel.Caption := FileName;
         Application.ProcessMessages;

         LocalValue := LocalFileValues.ValueFromIndex[ Index ];
         RemoteValueExists := RemoteInfoFile.ValueExists( SectionName, FileName );

         If   RemoteValueExists
         then RemoteValue := RemoteInfoFile.ReadString( SectionName, FileName, RemoteValue )
         else RemoteValue := Rpc.GetRemoteFileStamp( FileName );

         If   ( RemoteValue='' ) or Info.CheckDateTimeStrings( RemoteValue, LocalValue )
         then begin

              If   Info.CheckDateTimeStrings( RemoteValue, LocalValue )
              then begin
                   Rpc.PutFile( FileName );
                   Processed := True;
                   end;

              If   Rpc.Cancelled
              then Abort;
              end;

         If   LocalValue=EmptyStamp
         then LocalValue := GetFileAgeStamp( Rpc.LocalPath + FileName );

         RemoteInfoFile.WriteString( SectionName, FileName, LocalValue );
         end;

         RemoteInfoFile.UpdateFile;
         Rpc.PutFile( FileInfoName, False );

         LocalFileValues.Clear;

     finally
       RemoteInfoFile.Free;
       RemoteFileValues.Free;
       end;
end;

begin

     try

       Processing := True;

       InfoFileName := 'gd_' + AppShortName + '.ini';

       Rpc.Setup( ptUpload, nil, PercentLabel, ProgressBar, True, BetaVersion );

       Rpc.FixCurrentDir( '', True );

       Rpc.LockRead( True );

       // Publico todos los ficheros que han cambiado

       try

         LocalInfoFile := TMemIniFile.Create( ApplicationPath + InfoFileName );
         LocalFileValues := TStringList.Create;

         // Primero las librerías, módulos y opciones

         PublishFiles( 'Libreria' );
         PublishFiles( 'Modulos' );
         PublishFiles( 'Opciones' );

         // Diccionarios y reports

         DictionariesList := TStringList.Create;
         ExtractStringList( Dictionaries, DictionariesList );

         // Diccionarios

         For Index := 0 to DictionariesList.Count - 1 do
           If   Rpc.FixCurrentDir( AddPathDelim( 'dm' + DictionariesList.Strings[ Index ] ), True )
           then PublishFiles( 'Dm' + DictionariesList.Strings[ Index ] );

         DefaultModulesList := TStringList.Create;
         ExtractStringList( DefaultModules, DefaultModulesList );

         OptionalModulesList := TStringList.Create;
         ExtractStringList( OptionalModules, OptionalModulesList );

         // Reports

         If   Rpc.FixCurrentDir( AddPathDelim( 'reports' ), True )
         then PublishFiles( 'RptDm' );

         For Index := 0 to DefaultModulesList.Count - 1 do
           If   Rpc.FixCurrentDir( AddPathDelim( 'reports\dm' + DefaultModulesList.Strings[ Index ] ), True )
           then PublishFiles( 'RptDm' + DefaultModulesList.Strings[ Index ] );

         For Index := 0 to OptionalModulesList.Count - 1 do
           begin
           var SectionName := 'RptDm' + OptionalModulesList.Strings[ Index ];
           If   HasFiles( SectionName )
           then If   Rpc.FixCurrentDir( AddPathDelim( 'reports\dm' + OptionalModulesList.Strings[ Index ] ), True )
                then PublishFiles( SectionName );
           end;

         // Ayudas

         If   UpdateHelp
         then begin

              If   Rpc.FixCurrentDir( AddPathDelim( 'ayuda' ), True )
              then PublishFiles( 'HelpDm' );

              For Index := 0 to DefaultModulesList.Count - 1 do
                If   Rpc.FixCurrentDir( AddPathDelim( 'ayuda\hs' + DefaultModulesList.Strings[ Index ] ), True )
                then PublishFiles( 'HelpDm' + DefaultModulesList.Strings[ Index ] );

              end;

         // AdminRoot

         If   Rpc.FixCurrentDir( AddPathDelim( 'ServerData\Admin' ), True )
         then begin
              PublishFiles( 'WebAdmin' );
              If   Rpc.FixCurrentDir( AddPathDelim( 'ServerData\Admin\assets' ), True )
              then PublishFiles( 'WebAdminAssets' );
              If   Rpc.FixCurrentDir( AddPathDelim( 'ServerData\Admin\css' ), True )
              then PublishFiles( 'WebAdminCss' );
              If   Rpc.FixCurrentDir( AddPathDelim( 'ServerData\Admin\fonts' ), True )
              then PublishFiles( 'WebAdminFonts' );
              If   Rpc.FixCurrentDir( AddPathDelim( 'ServerData\Admin\img' ), True )
              then PublishFiles( 'WebAdminImg' );
              If   Rpc.FixCurrentDir( AddPathDelim( 'ServerData\Admin\img\icons' ), True )
              then PublishFiles( 'WebAdminImgIcons' );
              If   Rpc.FixCurrentDir( AddPathDelim( 'ServerData\Admin\js' ), True )
              then PublishFiles( 'WebAdminJs' );
              end;

         FileNameLabel.Caption := InfoFileName;
         Application.ProcessMessages;

       finally
         DictionariesList.Free;
         DefaultModulesList.Free;
         OptionalModulesList.Free;
         LocalFileValues.Free;
         LocalInfoFile.Free;

         FileNameLabel.Caption := '';
         ProgressBar.Position := 0;
         end;

     finally
       Processing := False;
       Rpc.LockRead( False );
       end;

end;

procedure TMainForm.Actualizacion;

var   FileList : TStringList;
      AHost : String;
      APort,
      Index : SmallInt;

const MaxAppNumber = 8;
      AppList   : array[ 0..MaxAppNumber ] of String = ( 'Contable',
                                                         'Comercial',
                                                         'ContableComercial',
                                                         'TPV',
                                                         'Prevision',
                                                         'Produccion',
                                                         'GestionInterna',
                                                         'Preventa',
                                                         'Modulos' );

begin
     try

       CancelarButton.Caption := '&Cancelar';
       CancelarButton.SetFocus;

       BetaVersion := VersionBetaCtrl.Checked;

       ActualizarButton.Enabled := False;
       ActualizarAyudasCtrl.Enabled := False;
       VersionBetaCtrl.Enabled := False;

       ServidorCtrl.Enabled := False;

       If   ParamCount=2
       then begin
            AHost := ParamStr( 1 );
            APort := StrToInt( ParamStr( 2 ) );
            end
       else begin
            AHost := '';
            APort := 0;
            end;

       // Primero actualizo la información de versiones local

       try

         For Index := 0 to MaxAppNumber do
           begin

           AppLabel.Caption := AppList[ Index ];
           Application.ProcessMessages;

           Info.UpdateAppInfo( AppList[ Index ], True );

           try

             AHost := ServidorCtrl.EditText;
             APort := 80 + ServidorCtrl.ItemIndex;   // 80, 81, u 82

             Info.Connect( 'gwadmin', 'gaBc42_AA', AHost, APort );

             PublishApp( ActualizarAyudasCtrl.Checked  );

           finally
             Rpc.UpdateServiceClient.Disconnect;
             end;

           If   Rpc.Cancelled
           then Break;

           end;

         If   Rpc.Cancelled
         then ShowNotification( ntExceptionError, RsMsg5, RsMsg6 )
         else ShowNotification( ntInformation, RsMsg3 );

       except on e : Exception  do ShowNotification( ntExceptionError, E.Message );
         end;

     finally
       ActualizarAyudasCtrl.Enabled := True;
       VersionBetaCtrl.Enabled := True;
       ActualizarButton.Enabled := True;

       ServidorCtrl.Enabled := True;

       CancelarButton.Caption :=  '&Cerrar';
       end;

end;

procedure TMainForm.DoOnProgress(     Sender        : TObject;
                                      FileName      : TZFString;
                                      Progress      : double;
                                      Operation     : TZFProcessOperation;
                                      ProgressPhase : TZFProgressPhase;
                                  var Cancel        : boolean );
begin
     var Percent := Trunc( Progress );
     FileNameLabel.Caption := ExtractFileName( FileName );
     ProgressBar.Position := Percent;
     PercentLabel.Caption := Format( '%d%%', [ Percent ] );
     Application.ProcessMessages;
     Cancel := Rpc.Cancelled;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
     ServidorCtrl.ItemIndex := 0;
     FicherosLibreria := FicherosLibreria + [ GServerName, GServerInitName, GServer64Name, GServer64InitName ];
end;

end.


