unit b_ins1;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, FileCtrl, ComCtrls,

  f_ins, Mask, DdeMan;

type
  TInstallForm = class(TForm)
    Notebook1: TNotebook;
    Bevel2: TBevel;
    Label1: TLabel;
    Label3: TLabel;
    cancel1Btn: TBitBtn;
    next1Btn: TBitBtn;
    Label2: TLabel;
    Label5: TLabel;
    Bevel4: TBevel;
    Previous3Btn: TBitBtn;
    cancel3Btn: TBitBtn;
    Bevel5: TBevel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    redBtn: TButton;
    tipoInstalacionCtrl: TRadioGroup;
    targetDriveCtrl: TDriveComboBox;
    remoteLabel: TLabel;
    remoteDriveCtrl: TDriveComboBox;
    help3Btn: TBitBtn;
    Bevel6: TBevel;
    procesoCopiaLabel: TLabel;
    Label12: TLabel;
    cancel4Btn: TBitBtn;
    Bevel7: TBevel;
    Label13: TLabel;
    Label14: TLabel;
    previous2Btn: TBitBtn;
    cancel2Btn: TBitBtn;
    help2Btn: TBitBtn;
    Label15: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    SourceLabel: TLabel;
    ProgressBar: TProgressBar;
    Label22: TLabel;
    TargetLabel: TLabel;
    claveActivacionCtrl: TMaskEdit;
    DdeClientConv1: TDdeClientConv;
    processLabel: TLabel;
    nroDiscoLabel: TLabel;
    Button1: TButton;
    Label10: TLabel;
    pathOrigenLabel: TLabel;
    Bevel1: TBevel;
    Label16: TLabel;
    Label24: TLabel;
    Animate1: TAnimate;
    startBtn: TBitBtn;
    next2Btn: TBitBtn;
    demoLabel: TLabel;
    Label11: TLabel;
    nroSerieLabel: TLabel;
    Label17: TLabel;
    numeroRegistroCtrl: TMaskEdit;
    Image2: TImage;
    Shape3: TShape;
    Shape2: TShape;
    Shape1: TShape;
    Label4: TLabel;
    Image1: TImage;
    Label21: TLabel;
    procedure PreviousBtnClick(Sender: TObject);
    procedure nextBtnClick(Sender: TObject);
    procedure cancelBtnClick(Sender: TObject);
    procedure tipoInstalacionCtrlClick(Sender: TObject);
    procedure helpBtnClick(Sender: TObject);
    procedure startBtnClick(Sender: TObject);
    procedure redBtnClick(Sender: TObject);
    procedure targetDriveCtrlChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

    installer             : TInstaller;

    targetDrive,
    remoteDrive           : string;

    errorMsg,
    descErrorMsg          : string;
    errorStatus,
    currentDisk           : smallInt;
    correct,
    alredyRegistered,
    processCanceled       : boolean;
    searchRec             : TSearchRec;
    dataLine,
    macroString,
    sourcePathAndName,
    targetPathAndName,
    targetPath,
    targetName            : string;
    targetDriveNumber     : smallInt;
    warningResult         : TModalResult;
    rgFile,
    regFile               : text;
    startUpInfo           : TStartUpInfo;
    processInformation    : TProcessInformation;
    macroSize,
    cp                    : smallInt;

  public
    { Public declarations }
    constructor create( aOwner : TComponent ); override;
    destructor  destroy;                       override;
  end;

var
  InstallForm: TInstallForm;

implementation

{$R *.DFM}

uses  files,

      b_msg,
      b_pat,

      comun;

resourceString
      rsMsg3   = 'Inserte el disquette de instalación número %d en la unidad [%s:].';
      rsMsg4   = 'Pulse <Intro> o haga clic en el botón aceptar cuando este listo.';
      rsMsg5   = 'No ha insertado el disquette solicitado.';
      rsMsg6   = 'El proceso de instalación NO ha finalizado satisfactoriamente.';
      rsMsg7   = 'Debe realizar la instalación de nuevo.';
      rsMsg8   = 'Instalación realizada satisfactoriamente.';
      rsMsg9   = 'Para acceder al programa localice la entrada [Aplicaciones GESTWIN] en el Menu [Inicio][Programas] de Windows.';
      rsMsg10  = 'El fichero %s no se encuentra en el disquete de distribución.';
      rsMsg11  = '¿Desea reintentar la copia de este fichero?. ' + #13 + 'Si se omite la copia de un fichero puede que la instalación no se realice satisfactoriamente.';
      rsMsg12  = 'Se ha producido un error al crear el directorio [%s].';
      rsMsg13  = 'Si está intentando instalar la aplicación en un entorno de red revise sus privilegios. Se cancela el proceso de instalación.';
      rsMsg14  = 'Se ha producido un error al intentar compilar el fichero %s.';
      rsMsg15  = 'Compilando ficheros extensos. Espere un momento por favor ...';
      rsMsg16  = 'Creando accesos directos en la carpeta de aplicaciones de GESTWIN.';
      rsMsg17  = 'No he podido crear el fichero destino %s. Es posible que el fichero esté bloqueado por otra aplicación.';
      rsMsg18  = 'Se ha producido un fallo durante la copia del fichero %s.';
      rsMsg19  = 'Espere mientras se copian los ficheros de la aplicación en la unidad seleccionada.';
      rsMsg20  = 'A continuación el programa de instalación le irá solicitando, uno a uno,  los disquettes de distribución de la aplicación.';
      rsMsg21  = '¿Esta seguro de que desea interrumpir el proceso de instalación?.';
      rsMsg22  = 'No puede instalar la aplicación desde una dirección UNC como %s.';
      rsMsg23  = 'Asigne una letra de unidad al directorio y reintente la operación.';
      rsMsg24  = 'No se ha podido obtener un número de identificación válido.';
      rsMsg25  = 'Si está realizando una instalación CLIENTE asegúrese de que el path remoto al directorio GESTWIN es correcto.';
      rsMsg26  = 'Clave de activación no válida.';
      rsMsg27  = 'Actualizando el registro de Windows ...';
      rsMsg28  = 'Se produjo un error al intentar modificar el registro de Windows.';
      rsMsg29  = 'Error en el fichero de configuración [gwinst.idd].';

constructor TInstallForm.create( aOwner : TComponent );
begin
     inherited create( aOwner );
     installer := TInstaller.create;
end;

destructor TInstallForm.destroy;

procedure eraseFile( fileName : string );

Var  fichero : file;

begin
     assignFile( fichero, fileName );
     erase( fichero );
end;

begin

     installer.free;

     inherited destroy;
end;

procedure TInstallForm.PreviousBtnClick(Sender: TObject);
begin
       case notebook1.pageIndex of
         1 : ;
         2 : ;
         3 : ;
         end;

     noteBook1.pageIndex := noteBook1.pageIndex - 1;
end;

procedure TInstallForm.nextBtnClick(Sender: TObject);

var   protectionRec : TProtectionRec;

begin
     case noteBook1.pageIndex of
        1 : begin

            // Obteniendo el número de serie ...

            targetDrive         := upCase( targetDriveCtrl.drive ) + ':\';
            If   tipoInstalacionCtrl.itemIndex=1
            then remoteDrive    := upCase( remoteDriveCtrl.drive ) + ':\'
            else remoteDrive    := targetDrive;
            targetDriveNumber   := ord( targetDrive[ 1 ] ) - 64;

            With installer do
              readConfigFile( sourceInstallPath );

            With container do
              begin

              If   tipoInstalacionCtrl.itemIndex=1
              then begin
                   applicationPath          := remoteDrive + 'Gestwin\';
                   protectionRec            := getProtectionData( false );
                   spSerialNumber           := protectionRec.serialNumber;
                   spRegNumber              := protectionRec.regNumber;
                   spActivationKey          := protectionRec.activationKey;
                   numeroRegistroCtrl.text  := intToStr( spRegNumber );
                   claveActivacionCtrl.text := intToStr( spActivationKey );
                   end
              else begin
                   applicationPath := targetDrive + 'Gestwin\';
                   spSerialNumber  := getDiskID( targetDrive );
                   end;

              If   container.spSerialNumber=0
              then begin
                   boxMsg( mbStop, rsMsg24, rsMsg25 );
                   abort;
                   end;

              nroSerieLabel.caption := intToStr( spSerialNumber );
              end;

            end;
        2 : begin

            end;
        end;

     noteBook1.pageIndex := noteBook1.pageIndex + 1;
end;

procedure TInstallForm.cancelBtnClick(Sender: TObject);
begin
     processCanceled := boxMsg( mbQuestion, rsMsg21, '' )=mrYes;
     If   processCanceled
     then If   noteBook1.pageIndex=3
          then abort
          else application.terminate;
end;

procedure TInstallForm.tipoInstalacionCtrlClick(Sender: TObject);
begin
     redBtn.enabled          := tipoInstalacionCtrl.itemIndex<>0;
     remoteLabel.enabled     := tipoInstalacionCtrl.itemIndex=1;
     remoteDriveCtrl.enabled := tipoInstalacionCtrl.itemIndex=1;
end;

procedure TInstallForm.helpBtnClick(Sender: TObject);
begin
     { Ayuda }
end;

procedure TInstallForm.startBtnClick(Sender: TObject);

var   index  : smallInt;
      st1,
      st2    : string;

procedure makeDirectory( dirPath : string );

var   IOError : integer;

begin
     mkDir( dirPath );
     IOError := IOResult;
     If   ( IoError<>0   ) and
          ( IoError<>183 ) { El directorio ya existe }
     then begin
          boxMsg( mbWarning, format( rsMsg12, [ dirPath ] ), rsMsg13 );
          processCanceled := true;
          end;
end;

function strParamCount( var str : string ) : byte;

var   index : smallInt;

begin
     result := 0;
     For index := length( str ) downto 1 do
       If   str[ index ]='%'
       then inc( result );
end;

begin
     try

       try

       { Creo el directorio \GESTWIN }

       If   tipoInstalacionCtrl.itemIndex<>1
       then createDirPath( removeBackSlash( container.applicationPath ) );

       container.demo := true;
       st1            := trim( numeroRegistroCtrl.text );
       st2            := trim( claveActivacionCtrl.text );
       If   ( st1<>'' ) or
            ( st2<>'' )
       then try
              container.spRegNumber     := strToInt( st1 );
              container.spActivationKey := strToInt( st2 );
              If   ( container.spRegNumber=0 )                                                  or
                   ( container.spActivationKey<>makeActivationKey( container.spSerialNumber ) )
              then abort;
              writeProtectionData( tipoInstalacionCtrl.itemIndex=1 );
              container.demo := false;
            except
              boxMsg( mbStop, rsMsg26, '' );
              abort;
              end;

     noteBook1.pageIndex := 3;

     demoLabel.visible   := container.demo and ( container.programVersion>=9 );
     currentDisk         := 0;
     processCanceled     := false;

     // empieza la copia de ficheros 

     With installer, fileList do
       begin

       If   numOfDisks=1
       then procesoCopiaLabel.caption := rsMsg19
       else procesoCopiaLabel.caption := rsMsg20;

       index := 0;
       While ( index<count )     and
             not processCanceled do
          With TFileComponent( items[ index ] ) do
            begin

            If   ( numOfDisks<>1 )     and
                 ( currentDisk<>disk )
            then begin

                 nroDiscoLabel.caption := intToStr( disk );

                 If   disk<>1
                 then repeat
                        correct := false;
                        If   boxMsg( mbWarning, format( rsMsg3, [ disk, sourceInstallPath ] ), rsMsg4 )=mrOk
                        then begin
                             application.processMessages;
                             If   findFirst( sourceInstallPath + 'DISK' + intToStr( disk ),
                                             faArchive,
                                             searchRec )=0
                             then correct := true
                             else boxMsg( mbStop, rsMsg5, '' );
                             end
                        else processCanceled := true;
                       until correct         or
                             processCanceled;
                 currentDisk := disk;
                 end;

            application.processMessages;

            If   not processCanceled                                                                           and
                 ( ( opAll in installOption )                                                or
                   ( ( opLocal in installOption )  and ( tipoInstalacionCtrl.itemIndex=0 ) ) or
                   ( ( opClient in installOption ) and ( tipoInstalacionCtrl.itemIndex=1 ) ) or
                   ( ( opServer in installOption ) and ( tipoInstalacionCtrl.itemIndex=2 ) ) ) and

                 ( ( windowsOS=osBoth ) or ( windowsOS=currentWindowsOS ) )
            then begin

                 targetPathAndName := expandPathAndName( targetDrive, pathAndName, true );

                 targetPath := extractFilePath( targetPathAndName );
                 If   targetPath[ length( targetPath ) ]='\'
                 then system.delete( targetPath, length( targetPath ), 1 );

                 targetName := extractFileName( targetPathAndName );

                 createDirPath( targetPath );

                 sourcePathAndName    := expandPathAndName( sourceInstallPath, pathAndName, false );

                 sourceLabel.caption  := sourcePathAndName;
                 targetLabel.caption  := targetPathAndName;
                 progressBar.position := ( index * 100 ) div ( count - 1 );
                 application.processMessages;

                 If   not processCanceled
                 then repeat
                        If   directoryExists( sourcePathAndName )
                        then begin
                             copyDirectory( sourcePathAndName, targetPathAndName );
                             correct := true;
                             end
                        else begin
                             // correct := copyFile( sourcePathAndName, targetPathAndName, false, overWrite );
                             correct := copyCompressedFile( sourcePathAndName, targetPathAndName, errorStatus, overWrite );
                             If   not correct
                             then begin
                                  case errorStatus of
                                    lzErrorOpeningSource : begin
                                                           errorMsg     := format( rsMsg10, [ sourcePathAndName ] );
                                                           descErrorMsg := rsMsg11;
                                                           end;
                                    lzErrorOpeningTarget : begin
                                                           errorMsg     := format( rsMsg17, [ targetPathAndName ] );
                                                           descErrorMsg := rsMsg11;
                                                           end;
                                    lzErrorCopyingFile   : begin
                                                           errorMsg     := format( rsMsg18, [ sourcePathAndName ] );
                                                           descErrorMsg := rsMsg11;
                                                           end;
                                    end;
                                  warningResult   := boxMsg( mbQuestionWarning, errorMsg, descErrorMsg );
                                  // warningResult   := boxMsg( mbQuestionWarning, format( rsMsg10, [ sourcePathAndName ] ), rsMsg11 );
                                  processCanceled := warningResult=mrCancel;
                                  correct         := warningResult=mrNo;
                                  end;
                             end;
                      until processCanceled or
                            correct;

                 end;

            inc( index );
            end;
       end;

     If   processCanceled
     then abort
     else begin

          progressBar.position := 100;
          processLabel.caption := rsMsg15;
          application.processMessages;
          With installer, commandList do
            For index := 0 to count - 1 do
              begin
              If   copy( strings[ index ], 1 ,1 )='0'  { Es un comando JOIN }
              then begin
                   lineText := copy( strings[ index ], 3, length( strings[ index ] ) );
                   readParamList;
                   expandPathAndName( targetDrive, paramList[ 0 ], true );
                   If   not joinFile( paramList[ 0 ], strToInt( paramList[ 1 ] ) )
                   then begin
                        boxMsg( mbStop, format( rsMsg14, [ paramList[ 0 ] ] ), rsMsg6 );
                        abort;
                        end;
                   end;
              end;

          // Actualizando el registro

          processLabel.caption := rsMsg27;
          application.processMessages;

          {$I+}

          try

            assignFile( rgFile, installer.temporalDirectory + '\Gestwin9.rg' );
            reset( rgFile );
            assignFile( regFile, installer.temporalDirectory + '\Gestwin9.reg' );
            rewrite( regFile );

            readLn( rgFile, dataLine );
            While not eof( rgFile ) do
              begin
              cp := pos( '%', dataLine );
              If   cp<>0
              then begin

                   index       := cp + 1;
                   macroSize   := 0;
                   macroString := '';
                   While ( dataLine[ index ]<>'%' )    and
                         ( index<=length( dataLine ) ) do
                     begin
                     inc( index );
                     inc( macroSize );
                     end;
                   macroString := upperCase( copy( dataLine, cp + 1, macroSize ) );
                   If   macroString='GESTWINDIR'
                   then macroString := container.applicationPath
                   else If   macroString='WINDOWSDIR'
                        then macroString := installer.windowsDirectory;

                   index := 1;
                   While index<=length( macroString ) do
                     If   macroString[ index ]='\'
                     then begin
                          insert( '\', macroString, index );
                          index := index + 2;
                          end
                     else inc( index );

                   delete( dataLine, cp, macroSize + 2 );
                   insert( macroString, dataLine, cp );

                   end;

              writeLn( regFile, dataLine );
              readLn( rgFile, dataLine );
              end;

            closeFile( rgFile );
            closeFile( regFile );


           fillChar( startupInfo, sizeOf( startupInfo ), #0 );

           startUpInfo.dwFlags     := STARTF_USESHOWWINDOW;
           startUpInfo.wShowWindow := SW_HIDE;

           fillChar( processInformation, sizeOf( processInformation ), #0 );

           macroString  := 'regEdit.exe /s ' + addBackSlash( installer.temporalDirectory ) + 'GESTWIN9.REG';
           correct      := createProcess( nil,
                                          pChar( macroString ),
                                          nil,
                                          nil,
                                          true,
                                          0,
                                          nil,
                                          nil,
                                          startupInfo,
                                          processInformation );

          except
            boxMsg( mbStop, rsMsg28, '' );
            abort;
            end;

          {$I-}

          processLabel.caption := rsMsg16;
          application.processMessages;
          With DDEClientConv1 do
            If   setLink( 'PROGMAN', 'PROGMAN' )
            then With installer, commandList do
                   For index := 0 to count - 1 do
                     begin
                     If   copy( strings[ index ], 1 ,1 )='1'  { Es una macro DDE }
                     then begin
                          macroString := copy( strings[ index ], 3, length(strings[ index ] ) );
                          case strParamCount( macroString ) of
                            0 : ;
                            1 : macroString := format( macroString, [ targetDrive ] );
                            2 : case tipoInstalacionCtrl.itemIndex of
                                  0, 2 : macroString := format( macroString, [ targetDrive, targetDrive ] );
                                     1 : macroString := format( macroString, [ remoteDrive, remoteDrive ] );
                                  end;
                            end;
                          executeMacro( pChar( macroString ), false );
                          end;
                     end;

          delay( 1000 );

          processLabel.caption :='';
          boxMsg( mbInformation, rsMsg8, rsMsg9 );
          end;

       except
         boxMsg( mbStop, rsMsg6, rsMsg7 );
         end;

    finally
      application.terminate;
      end;
end;

procedure TInstallForm.redBtnClick(Sender: TObject);
begin
     WNetConnectionDialog( handle, RESOURCETYPE_DISK );
end;

procedure TInstallForm.targetDriveCtrlChange(Sender: TObject);
begin
     remoteDriveCtrl.drive := targetDriveCtrl.drive;
end;

procedure TInstallForm.Button1Click(Sender: TObject);
begin
     pathOrigenForm := TPathOrigenForm.create( self, installer );
     If   assigned( pathOrigenForm )
     then pathOrigenForm.showModal;
end;

procedure TInstallForm.FormPaint(Sender: TObject);
begin
     pathOrigenLabel.caption := installer.sourceInstallPath;
end;

procedure TInstallForm.FormShow(Sender: TObject);
begin
     With installer do
       If   pos( '\\', sourceInstallPath )<>0
       then begin
            boxMsg( mbStop, format( rsMsg22, [ sourceInstallPath ] ), rsMsg23 );
            application.terminate;
            end;
end;

end.
