unit dm_iex;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxCheckListBox,

  ExtCtrls,
  CheckLst,

  DB,
  nxdb,
  Generics.Collections,

  ZipForge,

  clCertificate,
  clCertificateStore,

  DateUtils,
  LibUtils,
  dxmdaset,
  AppManager,

  cxMemo,

  clOAuth,
  clSmtp,
  clImap4,
  clTcpClient,
  clTcpClientTls,
  clTcpCommandClient,
  clMC,
  clPop3,
  clMailMessage,
  clHttpRequest,
  clSimpleHttpServer,
  clTcpClientSsh,
  clSFtp,
  clFtp,

  AppContainer,
  DataManager,
  AppForms,

  Gim00Fields,

  dmi_iex, dxCore, dxCoreClasses, dxRichEdit.NativeApi, dxRichEdit.Types,
  dxRichEdit.PlainText, dxRichEdit.DocumentServer;

type
  TExportImportModule = class(TDataModule)
    DmDireccionCorreoTable: TnxeTable;
    ZipForge: TZipForge;
    DmCorreoTable: TnxeTable;
    CorreoEntranteDataset: TgxMemData;
    CorreoEntranteDatasetAsunto: TStringField;
    CorreoEntranteDatasetRemitente: TStringField;
    CorreoEntranteDatasetFecha: TDateField;
    CorreoEntranteDatasetIndice: TIntegerField;
    CorreoEntranteDatasetSeleccionado: TBooleanField;
    CorreoEntranteDatasetHora: TTimeField;
    CorreoEntranteDatasetParametros: TMemoField;
    CorreoEntranteDatasetDestinatario: TWideStringField;
    CorreoEntranteDatasetIndiceClase: TSmallintField;
    OutgoingMailMessage: TclMailMessage;
    Pop3: TclPop3;
    Imap4: TclImap4;
    Smtp: TclSmtp;
    OAuth: TclOAuth;
    DmConfiguracionCorreoTable: TnxeTable;
    IncomingMailMessage: TclMailMessage;
    HttpRequest: TclHttpRequest;
    SimpleHttpServer: TclSimpleHttpServer;
    FtpClient: TclFtp;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure ZipForgeOverallProgress(Sender: TObject; Progress: Double;
      Operation: TZFProcessOperation; ProgressPhase: TZFProgressPhase;
      var Cancel: Boolean);
    procedure POP3MessageLine(Sender: TObject; const Info: string);
    procedure SMTPProgress(Sender: TObject; Total, Current: Int64;
      var Cancel: Boolean);
    procedure POP3Error(Sender: TObject; ErrorCode: Integer; Fatal,
      Remote: Boolean);
    procedure IncomingMailMessageSaveAttachment(Sender: TObject; ABody: TclAttachmentBody; var AFileName: string; var AData: TStream; var Handled: Boolean);
    procedure OAuthLaunchBrowser(Sender: TObject; const AUrl: string; var Handled: Boolean);
    procedure FtpClientProgress(Sender: TObject; ABytesProceed, ATotalBytes: Int64);
    procedure ZipForgeProcessFileFailure(Sender: TObject;
      FileName: TZFString; Operation: TZFProcessOperation; NativeError,
      ErrorCode: Integer; ErrorMessage: TZFString; var Action: TZFAction);
    procedure SmtpVerifyServer(Sender: TObject;
      ACertificate: TclCertificate; const AStatusText: string;
      AStatusCode: Integer; var AVerified: Boolean);
    procedure Pop3VerifyServer(Sender: TObject;
      ACertificate: TclCertificate; const AStatusText: string;
      AStatusCode: Integer; var AVerified: Boolean);
    procedure Imap4VerifyServer(Sender: TObject;
      ACertificate: TclCertificate; const AStatusText: string;
      AStatusCode: Integer; var AVerified: Boolean);

  private

    DmDireccionCorreoFields : TDireccionCorreoFields;
    DmCorreoFields : TCorreoFields;
    DmConfiguracionCorreoFields : TConfiguracionCorreoFields;

    EsUnPaqueteDeDatos : Boolean;
    PaqueteAProcesar : TTipoDatosExportados;
    FechaPaqueteAProcesar : TDate;

    NombreRemitente : String;

    DoOnAcceptMessage : TSimpleEvent;
    CurrentMailMsgIndex : SmallInt;
    Counter : SmallInt;

    IncomingMailControl : TclCustomMail;

    FTPFileSize : Cardinal;  // Tamaño del fichero actuamente procesado (put o get)
    FTPFileName : String;
    FTPProgressInitialized : Boolean;

    FZipProcessFail : Boolean;
    FZipProcessErrorMessage : String;

    ExportDirPath,
    ImportDirPath,
    ExportPathAndName,
    ImportPathAndName,

    SourceFileName,
    TargetPath,
    TargetFileName,
    TargetPathAndName,
    CompressedFileName : String;

    LastPercent : SmallInt;

    procedure SetupOAuth2( Protocol : SmallInt );
    function GettLastSMTPError : String;
    procedure DoOnCancelOAuth;

  public

    FileBackupInfo : file of TBackupInfo;
    BackupInfo : TBackupInfo;
    FileNameBackupInfo : String;
    RecordProcessed : Boolean;
    HeaderList : TStringList;
    RefreshToken : String;

    FConfiguracionCorreoSuministrada : Boolean;

    procedure GetMailConfiguration;

    function  ASCFormat( St : String ) : String;
    function  ASCText( Valor : String ) : String;
    function  ASCDate( Valor : TDateTime ) : String;
    function  ASCDouble( Valor : double; decimales : byte ) : String;
    function  ASCInt( Valor : LongInt ) : String;
    function  ASCBoolean( Valor : Boolean ) : TStrBool;

    procedure DateASC( St : String; var Day : Word; var Month : Word; var Year : Word ); overload;
    function  DateASC( St : String ) : TDateTime; overload;
    function  DecimalASC( St : String ) : Decimal;
    function  LongIntASC( St : String ) : LongInt;
    function  IntegerASC( St : String ) : SmallInt;
    function  ByteASC( St : String ) : Byte;
    function  BooleanASC( St : String ) : Boolean;

    procedure ExtraeParametros( StLinea : String; ListaParametros : TStringList; Separador : Char = ','; ComprobarCadenas : Boolean = True );

    procedure AbreFicheroExterno( Table : TnxeTable; Exportar : Boolean );
    procedure AbreFicherosExternos( Tables : array of TnxeTable; Exportar : Boolean );

    procedure AbreFicheroTextoExterno( var ATextFile : Text; AFileName : String; Exportar  : Boolean );
    procedure CompruebaDisco( Path : String; EspacioLibre  : LongInt; Importacion : Boolean );
    // procedure copiaFicheroExterno( pathOrigen, nombreFichero : String; Formato : TFormatoFichero );
    function  SetBackupInfo( Path : String; TipoDatos : TTipoDatosExportados; Escritura : Boolean ) : Boolean;
    // function  copyAndInsertRecOrd( sourceCursor, targetCursor : TgCursor; doCopyBlobs  : Boolean = True  ) : Boolean;
    procedure CleanExportDir;
    procedure CleanImportDir;

    function  ProcessCanceled : Boolean;
    // function  GetStringList( StringArray : TStringArray ) : TStringList;
    function  GetStringArray( StringList : TStringList ) : TStringArray;

    // procedure CheckHostAndUserName;

    procedure SetupSMTP;
    procedure SetupPOP3IMAP;

    procedure SMTPInitDataPacket( TipoDatos             : TTipoDatosExportados;
                                  DireccionCorreoFields : TDireccionCorreoFields;
                                  Attachments           : TStringArray = [];
                                  CheckRecords          : Boolean = False;
                                  Fecha                 : TDateTime = 0 ); overload;

    procedure SMTPInit( TipoDatos          : TTipoDatosExportados;
                        DestinatariosArray : TStringArray;
                        Subject,
                        Content            : String;
                        Attachments        : TStringArray = [];
                        TipoContenido      : String = '';
                        SubTipoContenido   : String = '' ); overload;

    function  SMTPCompressFiles( SourceTableNameList : TStringArray; TargetTableNameList : TStringArray; SourceDir : String = '' ) : String;
    procedure SMTPAttach( FileName : String; DisplayName : String = '' );
    procedure SMTPSend;

    procedure POP3Init( TipoDatos : TTipoDatosExportados; Fecha : TDateTime; OnAcceptMessage : TSimpleEvent );
    // procedure POP3ShowActivity( initialize : Boolean = False );

    function  CompressFile( AFileName : String; DeleteSource : Boolean = False ) : String;
    function  DecompressFile( CompressedFile : String; DeleteSource : Boolean = True ) : String;

    procedure FTPInit;
    function  FTPGetFile( SourceFile, TargetFile : String {; Compressed : Boolean = False } ) : Integer;
    procedure FTPPutFile( SourceFile, TargetFile : String {; Compressed : Boolean = False } );
    function  FTPGetFileSize( AFileName : String {; Compressed  : Boolean = False } ) : Int64;
    function  FTPFileExists( AFileName : String {;  Compressed : Boolean = False } ) : Boolean;
    procedure FTPCreateDirPath( DirPath : String; PathDelim : Char = '/' );

    procedure CompressAndCopyFiles( TableNameList : TStringArray; SourcePath, TargetPath : String; CheckRecords : Boolean  = False );
    function  DeCompressAndCopyFiles( ArchivePath : String; TableNameList : TStringArray; CopyToDataPath : Boolean = False ) : TStringArray;
    procedure DeCompressFiles( ArchivePath : String; TableNameList : TStringArray );
    procedure CheckRecordProcessed;

    function ExportRecordToText( SourceTable : TnxeTable; CharSeparator : Char = ','; ConvertRTFToHTML : Boolean = False ) : String;
    function  ImportRecordFromText( var SourceFile : Text; TargetTable : TnxeTable; CheckRecordIRTProcedure : TCheckRecordIRTProcedure = nil ) : Boolean;

    procedure CargaRelacionFicheros( Tipo : SmallInt; CheckListBox : TcxCheckListBox; var ParametrosRec : TParametrosLWRec );
    procedure GuardaRelacionFicheros( Tipo : SmallInt; CheckListBox  : TcxCheckListBox; var ParametrosRec : TParametrosLWRec );
    function  ObtenRelacionFicheros( CheckListBox : TcxCheckListBox; FileList : TStringList; AddExtension  : Boolean = False ) : Boolean;

    procedure CreaFirma( MemoCtrl : TcxCustomMemo; Nombre : String; DireccionCorreo : String = ''; Empresa : String = '' );

    function EnviaMensajePrueba( ConfiguracionCorreoTable : TnxTable ) : Boolean;
    function EnviaInformePorCorreo( NombreDestinatario, EMailDestinatario, Asunto, Texto : String; FicherosAdjuntos : TStringList = nil; Confirmar : Boolean = False ) : Boolean;

  end;

var  ExportImportModule : TExportImportModule = nil;

function ExportImport : TExportImportModule;
function DescripcionTipoDatosExportados( Tipo : SmallInt ): String;

const     BackupInfoFileName = 'backup.inf';
          BackupFileName     = 'backup.dat';

          DefaultReadTimeout = 30000;
          CodigoInicioParametros = '#PGS';
          CodigoFinParametros = '#PGE';

          // Parámetros utilizados en el envío de paquetes por correo (evito los caracteres especiales)

          RsCodigoEmpresa = 'Codigo Empresa';
          RsNombreEmpresa = 'Nombre Empresa';
          RsTipoDeDatos = 'Tipo de datos';
          RsFormato = 'Formato';
          RsSituacion  = 'Situacion';
          RsTodasLasSeries = 'Todas las series';
          RsSerie = 'Serie';
          RsNroFactura = 'Nro. factura';
          RsNroDocumento = 'Nro. documento';
          RsFecha = 'Fecha';
          RsFechaFactura = 'Fecha factura';
          RsFechaInicial = 'Fecha inicial';
          RsFechaFinal = 'Fecha final';
          RsCodigoPropietario = 'Codigo propietario';
          RsNombrePropietario = 'Nombre propietario';
          RsCodigoCliente = 'Codigo cliente';
          RsNombreCliente = 'Nombre cliente';
          RsCodigoClienteInicial = 'Codigo cliente inicial';
          RsCodigoClienteFinal = 'Codigo cliente final';
          RsMantenerReferenciasAPedidos = 'Mantener ref. a pedidos';
          RsCodigoProveedorInicial = 'Codigo proveedor inicial';
          RsCodigoProveedorFinal = 'Codigo proveedor final';
          RsTipoMovimiento = 'Tipo de movimiento';
          RsTodosLosTipos = 'Todos los tipos de mov.';
          RsValorarInventarios = 'Valorar inventarios';
          RsValoracionInventario = 'Valoracion inventario';
          RsNroOperacionInicial = 'Nro. operacion inicial';
          RsNroOperacionFinal = 'Nro. operacion final';
          RsNroAsientoInicial = 'Nro. asiento inicial';
          RsNroAsientoFinal = 'Nro. asiento final';
          RsCodigoArticuloInicial = 'Codigo Articulo inicial';
          RsCodigoArticuloFinal = 'Codigo Articulo final';

          RsAccesoOAuth = 'Acceso OAuth a GMail';
          RsMensajeCorreoPrueba = 'Prueba de correo';
          RsMensajeEnviadoCorrectamente = 'Mensaje de correo enviado correctamente.';

          DireccionCorreoDesarrollo = 'piñana@winstation.net';

implementation

uses Winapi.ShellAPI,

     Files,
     IniFiles,
     FileCtrl,

     ProcID,
     DataAccess,
     EnterpriseDataAccess,
     SessionDataAccess,
     TextConvert,

     nxllBde,
     nxsdConst,
     nxsdTypes,
     nxllUtils,
     cxProgressBar,

     frxExportMail,

     clSspiTls,

     cxRichEdit,

     clUtils,
     clTranslator,

     dmi_pga,

     Gdm00Dm,

     dm_reg,
     dm_pga,
     dm_cnd,

     b_msg,
     b_mail,
     b_pro,

     f_prg;

{$R *.dfm}

resourceString
      //
      RsMsg1   = 'Copiando los datos en %s.';
      RsMsg2   = 'Compruebe si tiene acceso al directorio destino y revise sus derechos de acceso.';
      RsMsg3   = 'Coloque un disquete formateado en la unidad %s:';
      RsMsg4   = 'Cuando esté preparado pulse [Intro] o haga clic en el botón [Aceptar].';
      RsMsg5   = 'La unidad %s: no está preparada.';
      RsMsg6   = 'Se cancela el proceso.';
      RsMsg7   = 'Espacio insuficiente en el disco.';
      RsMsg8   = 'Esta copia fue realizada el %s por el usuario %s, %s.' + #13 + 'Pertenece a la empresa %s, ejercicio %d.';
      RsMsg9   = 'No ha sido recuperada nunca.';
      RsMsg10  = 'Ha sido recuperada %d veces.';
      RsMsg11  = 'Indique si desea realizar el proceso de copia.';
      RsMsg12  = 'Coloque el disquete con los datos a importar en la unidad %s:.';
      RsMsg13  = 'El Path (directorio) %s no existe o no es accesible.';
      RsMsg14  = 'Este en un mensaje interno de GESTWIN.';
      RsMsg15  = 'NO MODIFIQUE NINGUN DATO DEL MISMO';
      RsMsg16  = 'Hacerlo puede suponer la incapacidad de';
      RsMsg17  = 'leer este mensaje desde la aplicación.';
      RsMsg18  = 'GESTWIN %.2d.%1d';    // Se utiliza también como firma
      RsMsg19  = 'GESTWIN %.2d.%1d (%.2d-%s,%s-%s)';
      RsMsg20  = ' %s. De : %s. ';
      RsMsg21  = 'No hay ningún mensaje pendiente en el buzón de correos.';
      RsMsg22  = 'Leyendo mensajes de correo.';
      RsMsg23  = 'La versión de los datos exportados no coincide con la versión actual del programa.';
      RsMsg24  = 'El tipo de los datos exportados no coincide con los que pretende importar.';
      RsMsg25  = 'Comprimiendo los datos.';
      RsMsg26  = 'Leyendo los datos desde %s.';
      RsMsg27  = 'Enviando los datos por correo a %s.';
      RsMsg28  = 'Descomprimiendo los datos.';
      RsMsg29  = 'El fichero %s no será incluído porque no existe.';
      RsMsg31  = 'No se ha seleccionado ningún registro para exportar.';
      RsMsg32  = 'No se ha podido crear o abrir el fichero de texto %s.';
      RsMsg33  = 'El número de campos de la tabla %s no es el esperado.';
      RsMsg34  = 'Para poder utilizar el correo debe configurarlo previamente.';
      RsMsg35  = 'Utilice la ventana de "Parámetros generales" en la sección "Configuración de la aplicación" o su ficha de usuario.';
      RsMsg36  = 'Debe especificar un Path o Directorio.';
      RsMsg37  = 'Extrayendo los ficheros en %s.';
      RsMsg38  = 'Un saludo,';
      RsMsg39  = 'No se ha podido iniciar la conexión de correo.';
      RsMsg40  = 'Revise su configuración de correo en la ficha de parámetros generales de la aplicación o en su ficha de usuario.';
      RsMsg41  = 'Se ha producido un error al enviar el mensaje de correo.';
      RsMsg42  = 'Abriendo y compactando las tablas ...';
      RsMsg43  = 'Error del servidor SMTP nº %d.';
      RsMsg44  = 'Mensaje de error del servidor de correo : ';
      RsMsg45  = 'Leyendo la cabecera del mensaje nº : ';
      RsMsg46  = '¿Desea suprimir del buzón el mensaje que acaba de importar?';
      RsMsg47  = 'Si deja el mensaje en el buzón podrá utilizarlo más adelante para repetir el proceso de importación en otra Empresa o desde otro equipo.' +
                 #13'[B]IMPORTANTE[/B] : no todos los servidores de correo permiten conservar una copia del mensaje una vez leído. Si es así no podrá volver a leerlo en el futuro aunque indique lo contrario.';
      RsMsg48  = 'El fichero [%s] no existe.';
      RsMsg50  = 'No se ha podido obtener el certificado del almacén del sistema.';
      RsMsg51  = 'Verifique su configuración de seguridad.';
      // RsMsg7  = 'no se ha podido cargar el certificado.';
      // RsMsg8  = 'Fichero : [B]%s[/B]. Compruebe que el fichero del certificado es accesible y/o verifique su configuración de seguridad.';

      RsMsg52 = 'No se ha podido cargar el certificado.';
      RsMsg53 = 'Error nº %d.';
      RsMsg54 = 'El certificado no es válido.';
      RsMsg55 = 'Revise, por si es ese el origen del problema, la palabra de paso o la fecha de caducidad del mismo.';

function ExportImport : TExportImportModule;
begin
     CreateDataModule( TExportImportModule, ExportImportModule );
     Result := ExportImportModule;
end;

procedure TExportImportModule.DataModuleCreate(Sender: TObject);
begin

     DmDireccionCorreoFields := TDireccionCorreoFields.Create( DmDireccionCorreoTable );
     DmCorreoFields := TCorreoFields.Create( DmCorreoTable );
     DmConfiguracionCorreoFields := TConfiguracionCorreoFields.Create( DmConfiguracionCorreoTable );

     // setCompression( ctHuffmanOnly, 6 );
     HeaderList := TStringList.Create;
     HeaderList.NameValueSeparator := ':';                 // Compatible con TIdHeaderList
     EnviaInformePorCorreoEvent := EnviaInformePorCorreo;  // Los envíos de correo del generador de informes
     IncomingMailControl := POP3;                          // Un valor por defecto
end;

procedure TExportImportModule.DataModuleDestroy(Sender: TObject);
begin
     HeaderList.Free;
     EnviaInformePorCorreoEvent := nil;
     ExportImportModule := nil;
end;

function TExportImportModule.ASCText( Valor : String ) : String;

var  Index  : Byte;

begin
     For Index :=  1 to Length( Valor ) do
       If   Valor[ Index ]=','
       then Valor[ Index ] := '.';

     Result := ',"' + Valor + '"';
end;

function  TExportImportModule.ASCDate( Valor : TDateTime ) : String;
begin
     Result := ',' + StrFormatDate( Valor, dfDefault2 );
end;

function TExportImportModule.ASCFormat( St : String ) : String;
begin
     Delete( St, 1, 1 );
     Result := St;
end;

function TExportImportModule.ASCDouble( Valor     : Double;
                                        Decimales : Byte ) : String;

Var  St : String;

begin
     Str( Valor:0:Decimales, St );
     Result := ',' + St;
end;

function TExportImportModule.ASCInt( valor : LongInt ) : String;

Var  St : String;

begin
     Str( Valor:0, St );
     Result := ',' + St;
end;


function TExportImportModule.ASCBoolean( valor : Boolean ) : TStrBool;
begin
     If   Valor
     then Result := ',True'
     else Result := ',False';

end;

procedure TExportImportModule.CleanExportDir;
begin
     DataAccessModule.CloseInactiveLocalSessionResources;
     EraseDirectory( SessionDataModule.GetExportDirectory, False );
     RecordProcessed := False;
end;

procedure TExportImportModule.CleanImportDir;
begin
     DataAccessModule.CloseInactiveLocalSessionResources;
     EraseDirectory( SessionDataModule.GetImportDirectory, False );
     RecordProcessed := False;
end;

procedure TExportImportModule.AbreFicheroExterno( Table    : TnxeTable;
                                                  Exportar : Boolean );
begin
     If   Assigned( Table )
     then With Table do
            try
              If   Exportar
              then begin
                   Database := SessionDataModule.ExportsDatabase;

                   //** 08.02.2010  Si se ha producido un error en una exportación anterior la tabla puede existir

                   Database.DeleteTable( Table.TableName, '' );
                   end
              else begin
                   Database := SessionDataModule.ImportsDatabase;

                   //** 14.10.2011 Debido al cambio (version 3.09 de NexusDB) en el tratamiento de las tablas de códigos (NLS), mejor compactar siempre las tablas antes de importarlas

                   DataAccessModule.PackTable( Database, TableName );
                   end;

              Open;

            except

              end;
end;

procedure TExportImportModule.AbreFicherosExternos( Tables   : array of TnxeTable;
                                                    Exportar : Boolean );
var  Index : SmallInt;

begin
     If   Assigned( ProcessFrame )
     then ProcessFrame.AddMsg( ntInformation, RsMsg42 );
     For Index := 0 to High( Tables ) do
       AbreFicheroExterno( Tables[ Index ], Exportar );
end;

procedure TExportImportModule.AbreFicheroTextoExterno( var ATextFile : Text;
                                                           AFileName : String;
                                                           Exportar  : Boolean );
var  R : Integer;

begin
     {$IOCHECKS OFF}
     AssignFile( ATextFile, AFileName );
     If   Exportar
     then Rewrite( ATextFile )
     else Reset( ATextFile );
     R := IoResult;
     If   R<>0
     then begin
          ShowNotification( ntError, Format( RsMsg32, [ AFileName ] ), RsMsg2 );
          Abort;
          end;
     {$IOCHECKS ON}
end;

procedure TExportImportModule.CompruebaDisco( Path          : String;
                                              EspacioLibre  : LongInt;
                                              Importacion   : Boolean );

Var  Espacio : LongInt;
     Unidad : Char;
     Diskette : Boolean;
     Drive : Byte;
     Msg : String;

begin

     If   Path=''
     then begin
          ShowNotification( ntStop, RsMsg36, RsMsg6 );
          Abort;
          end
     else begin

          Unidad := UpCase( Path[ 1 ] );
          Diskette := CharInSet( Unidad, [ 'A', 'B' ] );

          If   Diskette
          then begin

               If   Importacion
               then Msg := RsMsg12
               else Msg := RsMsg3;
               If   ShowNotification( ntAcceptCancel, Format( Msg, [ Unidad ] ), RsMsg4 )<>mrOk
               then Abort;

               If   Unidad='A'
               then Drive := 1
               else Drive := 2;
               Espacio  := DiskFree( Drive );
               If   Espacio=-1
               then begin
                    ShowNotification( ntStop, Format( RsMsg5, [ Unidad ] ), RsMsg6 );
                    Abort;
                    end
               else If   not ( ( EspacioLibre=0 ) or ( Espacio>EspacioLibre ) )
                    then begin
                         ShowNotification( ntStop, RsMsg7, RsMsg6 );
                         Abort;
                         end;
               end
          else If   not SysUtils.DirectoryExists( Path )
               then begin
                    ShowNotification( ntStop, Format( RsMsg13, [ Path ] ), '' );
                    Abort;
                    end;
          end;
end;

{$I-}

function TExportImportModule.SetBackupInfo( Path      : String;
                                            TipoDatos : TTipoDatosExportados;
                                            Escritura : Boolean ) : Boolean;

Var   St : String;
      Outcome : SmallInt;

begin
     Result := False;
     FileNameBackupInfo := AddPathDelim( Path ) + BackupInfoFileName;
     AssignFile( FileBackupInfo, FileNameBackupInfo );
     IoCheck( IOResult );
     If   Escritura
     then begin
          rewrite( FileBackupInfo );
          Outcome := IoResult;
          If   Outcome=0
          then begin

               BackupInfo.Empresa := CodigoEmpresaActual;
               BackupInfo.Ejercicio := ApplicationContainer.Ejercicio;
               BackupInfo.Usuario := CodigousuarioActual;
               BackupInfo.Nombre := DataModule00.DmUsuarioFields.Nombre.Value;
               BackupInfo.Fecha := ApplicationContainer.TodayDate;
               BackupInfo.Recuperado := 0;
               BackupInfo.Version := ProgramVersion;
               BackupInfo.Release := ProgramRelease;
               BackupInfo.TipoDatos := TipoDatos;

               Write( FileBackupInfo, BackupInfo );
               IoCheck( IoResult );
               Close( FileBackupInfo );
               IoCheck( IOResult );
               Result := True;

               end;
          end
     else begin
          FileMode := fmOpenReadWrite;
          Reset( FileBackupInfo );
          Outcome := IOResult;
          If   Outcome=0
          then begin

               try

                 Read( FileBackupInfo, BackupInfo );
                 IoCheck( ioResult );

                 If   ( ProgramVersion<>BackupInfo.Version ) or
                      ( ProgramRelease<>BackupInfo.Release )
                 then begin
                      ShowNotification( ntStop, RsMsg23, '' );
                      Abort;
                      end
                 else If   TipoDatos<>BackupInfo.TipoDatos
                      then begin
                           ShowNotification( ntStop, RsMsg24, '' );
                           Abort;
                           end;

                 St := Format( RsMsg8, [ StrFormatDate( BackupInfo.Fecha, dfDetailed ),
                                         BackupInfo.Usuario,
                                         BackupInfo.Nombre,
                                         BackupInfo.Empresa,
                                         BackupInfo.Ejercicio ] );

                 If   BackupInfo.recuperado=0
                 then St := St + #13 + RsMsg9
                 else St := St + #13 + Format( RsMsg10, [ BackupInfo.recuperado ] );

                 If   ShowNotification( ntQuestion, RsMsg11, St )=mrYes
                 then begin
                      inc( BackupInfo.recuperado );
                      seek( FileBackupInfo, 0 );
                      write( FileBackupInfo, BackupInfo );
                      IoCheck( ioResult );
                      Result := True;
                      end;

               finally
                 Close( FileBackupInfo );
                 IoCheck( ioResult );
                 end;

               end
          else Result := True;    // igual es válido ...

          end;

end;

{$I+}

procedure TExportImportModule.ExtraeParametros( StLinea          : String;
                                                ListaParametros  : TStringList;
                                                Separador        : Char = ',';
                                                ComprobarCadenas : Boolean = True );

Var  Pc,
     Ps,
     XLen  : SmallInt;
     Qc    : Char;
     ColumnValue : String;

begin

     ListaParametros.Clear;

     StLinea := TrimRight( StLinea );

     While Length( StLinea )>0 do
       begin

       Qc := StLinea[ 1 ];
       If   ComprobarCadenas and CharInSet( Qc, [ '"', '''' ] )
       then begin
            Delete( StLinea, 1, 1 );
            Ps := Pos( Qc, StLinea );
            If   Ps<>0
            then Delete( StLinea, Ps, 1 );
            Pc := Pos( Separador, StLinea, Ps );
            end
       else Pc := Pos( Separador, StLinea );

       If   Pc=0
       then XLen := Length( StLinea )
       else XLen := Pred( Pc );

       ColumnValue := Trim( Copy( StLinea, 1, XLen ) );
       ListaParametros.Add( ColumnValue );
       Delete( StLinea, 1, XLen + 1 );

       If   ( Pc<>0 ) and ( Length( StLinea )=0 ) // Aunque el último parámetro esté vacío debe insertarse
       then ListaParametros.Add( '' );

       end;
end;

procedure TExportImportModule.DateASC(     St    : String;
                                       var Day   : Word;
                                       var Month : Word;
                                       var Year  : Word );

function GetNextValue( Check : Boolean ) : SmallInt;

Var   Slash  : byte;
      St1    : String;
      Value  : SmallInt;


begin
     Slash := Pos( '/', St );
     If   Slash=0
     then Slash := Length( St )
     else dec( Slash );

     Value := 0;
     St1 := Copy( St, 1, Slash );
     try
       Value := StrToInt( St1 );
     except
       end;

     If   Check
     then If   ( Value<1 ) or ( Value>31 )
          then Value := 0;
     Delete( St, 1, succ( Slash ) );

     Result := Value;
end;

begin
     If   St=''
     then begin
          Day := 0;
          Month := 0;
          Year := 0;
          end
     else begin
     Day := GetNextValue( True  );
     Month := GetNextValue( True  );
     Year := GetNextValue( False );
     If   ( Year<>0 ) and ( Year<100 )
     then If   Year>50
          then Inc( Year, 1900 )
          else Inc( Year, 2000 );
          end;
end;

function TExportImportModule.DateASC( St : String ) : TDateTime;

var   Day,
      Month,
      Year  : Word;

begin
     DateASC( St, Day, Month, Year );
     If   Day=0  // Fechas nulas '00/00/00'  o ''
     then Result := 0
     else Result := EncodeDate( Year, Month, Day );
end;

function  TExportImportModule.DecimalASC( St : String ) : Decimal;

Var   Value : Double;
      Pc    : SmallInt;
      code  : LongInt;

begin
     try

       //* 24.04.2002 Sustituyo las comas por puntos decimales

       Pc := Pos( ',', St );
       If   Pc<>0
       then St[ Pc ] := '.';

       Val( St, Value, Code );
     except
       Value := 0.0;
       end;
     Result := Value;
end;

function  TExportImportModule.LongIntASC  ( St : String ) : LongInt;

var   Value : LongInt;

begin
     try
       Value := StrToInt( St );
     except
       Value := 0;
       end;
     Result := Value;
end;


procedure TExportImportModule.IncomingMailMessageSaveAttachment(     Sender    : TObject;
                                                                     ABody     : TclAttachmentBody;
                                                                 var AFileName : string;
                                                                 var AData     : TStream;
                                                                 var Handled   : Boolean );
begin
     AData := TFileStream.Create( ImportDirPath + AFileName, fmCreate);
     Handled := True;
end;

function  TExportImportModule.IntegerASC  ( St : String ) : SmallInt;

var   Value : SmallInt;

begin
     try
       Value := StrToInt( St );
     except
       Value := 0;
       end;
     Result := Value;
end;

function  TExportImportModule.ByteASC( St : String ) : Byte;

Var   Value : Byte;

begin
     try
       Value := StrToInt( St );
     except
       Value := 0;
       end;
     Result := Value;
end;

function TExportImportModule.BooleanASC( St : String ) : Boolean;
begin
     If   UpperCase( St )='TRUE'
     then BooleanASC := True
     else BooleanASC := False;
end;

function TExportImportModule.ProcessCanceled : Boolean;
begin
     If   Assigned( ProcessFrame )
     then Result := ProcessFrame.Canceled or ProcessFrame.Error
     else Result := False;
end;

procedure TExportImportModule.SMTPInitDataPacket( TipoDatos             : TTipoDatosExportados;
                                                  DireccionCorreoFields : TDireccionCorreoFields;
                                                  Attachments           : TStringArray = [];
                                                  CheckRecords          : Boolean = False;
                                                  Fecha                 : TDateTime = 0 );

var  I : SmallInt;
     AttachmentsList : TStringList;

begin

     SetupSMTP;

     If   CheckRecords
     then CheckRecordProcessed;

     If   Assigned( ProcessFrame )
     then With ProcessFrame do
            begin
            AddMsg( ntInformation, Format( RsMsg27, [ DireccionCorreoFields.Nombre.Value ] ) );
            ShowProgressBar( True );
            end;

     EsUnPaqueteDeDatos := True;
     PaqueteAProcesar := TipoDatos;
     If   Fecha=0
     then FechaPaqueteAProcesar := ApplicationContainer.TodayDate
     else FechaPaqueteAProcesar := Fecha;;

     AttachmentsList := TStringList.Create;

     try

       OutgoingMailMessage.CharSet := 'utf-8';

       AttachmentsList.AddStrings( Attachments );

       // GESTWIN 10.1(01-001,01-01/01/2005) XX(AddToSubject)XXX

       OutgoingMailMessage.BuildMessage( RsMsg14 + CR +
                                         StrConst( 40, '-' ) + CR +
                                         RsMsg15 + CR +
                                         StrConst( 40, '-' ) + CR +
                                         RsMsg16 + CR +
                                         RsMsg17 + CR +
                                         CodigoInicioParametros + CR +
                                         HeaderList.Text +
                                         CodigoFinParametros,

                                         '',
                                         nil,
                                         AttachmentsList );

       OutgoingMailMessage.Subject := Format( RsMsg19, [ ProgramVersion,
                                                         ProgramRelease,
                                                         Ord( PaqueteAProcesar ),
                                                         CodigoEmpresaActual,
                                                         CodigoUsuarioActual,
                                                         StrFormatDate( FechaPaqueteAProcesar, dfDefault2 ) ] );

       OutgoingMailMessage.From.Email := DmConfiguracionCorreoFields.Direccion.Value;
       OutgoingMailMessage.From.Name := NombreRemitente;

       {$IFDEF DEBUGAPP} // Evitando algunos envios inapropiados
       OutgoingMailMessage.ToList.Add( DireccionCorreoDesarrollo, '' );
       {$ELSE}
       With DmDireccionCorreoTable do
         begin
         IndexFieldNames := 'Codigo';
         If   DireccionCorreoFields.EsUnGrupo.Value
         then begin
              IndexFieldNames := 'Grupo;Codigo';
              try
                With DireccionCorreoFields do
                  SetRange( [ Codigo.Value, '' ], [ Codigo.Value, HighStrCode ] );
                First;
                While not Eof do
                  begin
                  OutgoingMailMessage.ToList.Add( DmDireccionCorreoFields.EMail.Value, DmDireccionCorreoFields.Nombre.Value );
                  Next;
                  end;
              finally
                CancelRange;
                end;
              end
         else OutgoingMailMessage.ToList.Add( DireccionCorreoFields.EMail.Value, DireccionCorreoFields.Nombre.Value );
         end;
         {$ENDIF}

     finally
       AttachmentsList.Free;
       end;

end;

procedure TExportImportModule.SmtpVerifyServer(       Sender       : TObject;
                                                      ACertificate : TclCertificate;
                                                const AStatusText  : string;
                                                      AStatusCode  : Integer;
                                                var   AVerified    : Boolean );
begin
     AVerified := True;
end;

procedure TExportImportModule.SMTPInit( TipoDatos          : TTipoDatosExportados;
                                        DestinatariosArray : TStringArray;
                                        Subject,
                                        Content            : String;
                                        Attachments        : TStringArray = [];
                                        TipoContenido      : String = '';
                                        SubTipoContenido   : String = '' );

var Inx : SmallInt;
    AttachmentsList : TStringList;

begin

     SetupSMTP;

     AttachmentsList := TStringList.Create;

     try

       If   DmConfiguracionCorreoFields.Firma.Value<>''
       then Content := Content + #13#13 + DmConfiguracionCorreoFields.Firma.Value;

       AttachmentsList.AddStrings( Attachments );

       OutgoingMailMessage.CharSet := 'utf-8';

       OutgoingMailMessage.BuildMessage( '', Content, nil, AttachmentsList );

       If   TipoContenido<>''
       then begin
            OutgoingMailMessage.ContentType := TipoContenido;
            OutgoingMailMessage.ContentSubType := SubTipoContenido;
            end;

       OutgoingMailMessage.Subject := Subject;

       OutgoingMailMessage.From.Name := NombreRemitente;
       OutgoingMailMessage.From.EMail := DmConfiguracionCorreoFields.Direccion.Value;

       // DestinatariosArray  = [ Nombre destinatario1, direccion@destinatario1.com, Nombre destinatario2, direccion@destinatario2.com ... ]

       {$IFDEF DEBUGAPP}
       OutgoingMailMessage.ToList.Add( DireccionCorreoDesarrollo, DestinatariosArray [ 0 ] );
       {$ELSE}
       Inx := Low( DestinatariosArray );
       While Inx < High( DestinatariosArray ) do
         begin
         OutgoingMailMessage.ToList.Add( { Address } DestinatariosArray [ Inx + 1 ], { Alias } DestinatariosArray [ Inx ] );
         Inc( Inx, 2 );
         end;
       {$ENDIF}

       EsUnPaqueteDeDatos := False;
       PaqueteAProcesar := TipoDatos;

     finally
       AttachmentsList.Free;
       end;

end;

procedure TExportImportModule.GetMailConfiguration;
begin
     NombreRemitente := DataModule00.DmEmpresaFields.Nombre.Value;
     If   not FConfiguracionCorreoSuministrada    // Solo aplicable una vez
     then With DmConfiguracionCorreoTable do
            If   FindKey( [ CodigoEmpresaActual, CodigoUsuarioActual ] )
            then NombreRemitente := DataModule00.DmUsuarioFields.Nombre.Value
            else If   not FindKey( [ '', CodigoUsuarioActual ] )
                 then If   not FindKey( [ CodigoEmpresaActual, '' ] )
                      then If   not FindKey( [ '', '' ] )
                           then begin
                                ShowNotification( ntStop, RsMsg34, RsMsg35 );
                                Abort;
                                end;
     FConfiguracionCorreoSuministrada := False;
end;

procedure TExportImportModule.SetupPOP3IMAP;
begin

     GetMailConfiguration;

     If   ( DmConfiguracionCorreoFields.ServidorPOP3IMAP.Value='' ) or ( DmConfiguracionCorreoFields.Usuario.Value='' )
     then begin
          ShowNotification( ntStop, RsMsg34, RsMsg35 );
          Abort;
          end;

     If   DmConfiguracionCorreoFields.TipoServidorCorreoEntrante.Value=mailPOP3
     then IncomingMailControl := POP3
     else IncomingMailControl := IMAP4;

     IncomingMailControl.Close;

     try

       IncomingMailMessage.Clear;

       // CheckHostAndUserName;

       IncomingMailControl.UseSasl := False;

       If   DmConfiguracionCorreoFields.AccesoOAuthPOP3IMAP.Value
       then begin

            SetupOAuth2( mailPOP3 );

            IncomingMailControl.UseTLS := ctImplicit;
            IncomingMailControl.UseSasl := True;

            If   RefreshToken<>''
            then OAuth.Token.AccessToken := RefreshToken;

            IncomingMailControl.UserName := DmConfiguracionCorreoFields.UsuarioOAuth.Value;
            IncomingMailControl.Authorization := OAuth.GetAuthorization;

            end
       else begin
            case DmConfiguracionCorreoFields.SeguridadPOP3IMAP.Value of
                 0 : IncomingMailControl.UseTLS := ctNone;
                 1 : IncomingMailControl.UseTLS := ctImplicit;   // SSL/TLS
                 2 : IncomingMailControl.UseTLS := ctExplicit;   // STARTLS
              else IncomingMailControl.UseTLS := ctAutomatic
              end;
            IncomingMailControl.UserName := DmConfiguracionCorreoFields.Usuario.Value;
            IncomingMailControl.Password := DmConfiguracionCorreoFields.Password.Value;
            end;

       IncomingMailControl.Server := DmConfiguracionCorreoFields.ServidorPOP3IMAP.Value;
       IncomingMailControl.Port := DmConfiguracionCorreoFields.PuertoPOP3IMAP.Value;

       IncomingMailControl.Timeout := DefaultReadTimeout;

       try
         IncomingMailControl.Open;
       except  // Puede que el token ya no sea válido. Volvamos a intentarlo pidiendo la autorización al usuario
         If   DmConfiguracionCorreoFields.AccesoOAuthPOP3IMAP.Value
         then begin
              OAuth.Close;
              IncomingMailControl.Authorization := OAuth.GetAuthorization;
              IncomingMailControl.Open;
              end
         else raise;
         end;

       If   DmConfiguracionCorreoFields.AccesoOAuthPOP3IMAP.Value
       then Registro.GuardaValor( Registro.ClavePadre, ncrRefreshToken, OAuth.Token.AccessToken, { EsunBlob } True );

     except
       IncomingMailControl.Close;
       raise;
       end;

end;

procedure TExportImportModule.SetupOAuth2( Protocol : SmallInt );
begin

     Registro.ClavePadre := Registro.ObtenClaveUsuario( CodigoUsuarioActual );
     Registro.ObtenValor( ncrRefreshToken, RefreshToken, { EsUnBlob } True );

     OAuth.ClientID := DmConfiguracionCorreoFields.IDCliente.Value;
     OAuth.ClientSecret := DmConfiguracionCorreoFields.ClaveSecreta.Value;

     case DmConfiguracionCorreoFields.ProveedorOAuth.Value of

       0 :  // GMail
         begin
         OAuth.AuthURL := 'https://accounts.google.com/o/oauth2/auth';
         OAuth.RedirectURL := 'http://localhost';
         OAuth.Scope := 'https://mail.google.com/';
         OAuth.TokenURL := 'https://accounts.google.com/o/oauth2/token';
         end;

       1 :  // Office365  tenant id : 78efcbe4-485f-41f5-aea3-d779224db6a1
         begin

         var IDInquilino := DmConfiguracionCorreoFields.IDInquilino.Value;
         If   IDInquilino=''
         then IDInquilino := 'common';

         OAuth.AuthURL := 'https://login.microsoftonline.com/' + IDInquilino + '/oauth2/v2.0/authorize';
         OAuth.RedirectURL := { 'https://login.microsoftonline.com/' + IDInquilino + '/oauth2/nativeclient'; // } 'http://localhost';

         case Protocol of
           mailIMAP :
             OAuth.Scope := 'https://graph.microsoft.com/IMAP.AccessAsUser.All';
           mailPOP3 :
             OAuth.Scope := 'https://graph.microsoft.com/POP.AccessAsUser.All';
           mailSMTP :
             OAuth.Scope := 'https://graph.microsoft.com/SMTP.Send';
             end;

         OAuth.TokenURL := 'https://login.microsoftonline.com/' + IDInquilino + '/oauth2/v2.0/token';
         end;

       end;

     If   not Assigned( OAuth.Token )
     then OAuth.SetToken( TclOAuthToken.Create );

end;

procedure TExportImportModule.SetupSMTP;
begin

     // Mantener y reutilizar el socket activo es una mala idea. Windows invalida los que hace algún tiempo que están activos y no se usan.

     SMTP.Close;

     OutgoingMailMessage.Clear;

     try

       GetMailConfiguration;

       If   ( DmConfiguracionCorreoFields.ServidorSMTP.Value='' ) or ( DmConfiguracionCorreoFields.Usuario.Value='' )
        then begin
             ShowNotification( ntStop, RsMsg34, RsMsg35 );
             Abort;
             end;

       SMTP.UseSasl := False;

       If   DmConfiguracionCorreoFields.AccesoOAuthSMTP.Value
       then begin

            SetupOAuth2( mailSMTP );

            SMTP.UseTLS := ctExplicit;
            SMTP.UseSasl := True;

            If   RefreshToken<>''
            then OAuth.Token.AccessToken := RefreshToken;

            SMTP.UserName := DmConfiguracionCorreoFields.UsuarioOAuth.Value;
            SMTP.Authorization := OAuth.GetAuthorization;

            end
       else begin
            case DmConfiguracionCorreoFields.SeguridadSMTP.Value of
              0 : SMTP.UseTLS := ctNone;
              1 : SMTP.UseTLS := ctImplicit;   // SSL/TLS
              2 : SMTP.UseTLS := ctExplicit;   // STARTLS
              end;
            SMTP.UserName := DmConfiguracionCorreoFields.Usuario.Value;
            SMTP.Password := DmConfiguracionCorreoFields.Password.Value;
            end;

       SMTP.Server := DmConfiguracionCorreoFields.ServidorSMTP.Value;
       SMTP.Port := DmConfiguracionCorreoFields.PuertoSMTP.Value;

       SMTP.Timeout := DefaultReadTimeout;

       try
         SMTP.Open;
       except  // Puede que el token ya no sea válido. Volvamos a intentarlo pidiendo la autorización al usuario
         If   DmConfiguracionCorreoFields.AccesoOAuthSMTP.Value
         then begin
              OAuth.Close;
              SMTP.Authorization := OAuth.GetAuthorization;
              SMTP.Open;
              end
         else raise;
         end;

       If   DmConfiguracionCorreoFields.AccesoOAuthSMTP.Value
       then Registro.GuardaValor( Registro.ClavePadre, ncrRefreshToken, OAuth.Token.AccessToken, { EsunBlob } True );

     except
       SMTP.Close;
       raise;
       end;
end;

procedure TExportImportModule.SMTPAttach( FileName    : String;
                                          DisplayName : String = '' );

var  AttachmentBody : TclAttachmentBody;

begin
     AttachmentBody := OutgoingMailMessage.Bodies.AddAttachment( FileName );
     If   Assigned( AttachmentBody )
     then begin
          AttachmentBody.ContentType := 'application/octet-stream';
          AttachmentBody.ContentID := DisplayName;
          end;
end;

// Es responsabilidad de quien llame a esta función el liberar el StringList creado

{
function TExportImportModule.GetStringList( StringArray : TStringArray ) : TStringList;

var  Index : SmallInt;

begin
     If   High( StringArray )=-1  // Esta vacía
     then Result := nil
     else begin
          Result := TStringList.create;
          For Index := 0 to High( StringArray ) do
            Result.Add( StringArray[ Index ] );
          end;
end;
}

function TExportImportModule.GetStringArray( StringList : TStringList ) : TStringArray;

var  Index : SmallInt;

begin
     If   StringList.Count>0
     then begin
          SetLength( Result, StringList.Count );
          For Index := 0 to StringList.Count - 1 do
            Result[ Index ] := StringList[ Index ];
          end
     else Result := nil;
end;


function TExportImportModule.SMTPCompressFiles( SourceTableNameList,
                                                TargetTableNameList : TStringArray;
                                                SourceDir           : String = '' ) : String;   // Devuelve el path al fichero comprimido resultante

var  Index : SmallInt;
     ExistsSourceDir,
     CopyToExportDir,
     CopyFromTargetList : Boolean;
     FinalTargetTableNameList : TStringArray;

procedure SetFileNames( Index : SmallInt );
begin
     If   ExistsSourceDir
     then begin
          SourceFileName := SourceDir + SourceTableNameList[ Index ];
          TargetFileName := ExportDirPath + FinalTargetTableNameList[ Index ];
          end
     else begin
          SourceFileName := SourceTableNameList[ Index ];
          TargetFileName := ExportDirPath + ExtractFileName( FinalTargetTableNameList[ Index ] );
          end;
end;

begin
     If   Assigned( ProcessFrame )
     then ProcessFrame.ShowProgressBar( True );

     ExistsSourceDir := SourceDir<>'';
     ExportDirPath := AddPathDelim( SessionDataModule.GetExportDirectory );
     If   ExistsSourceDir
     then SourceDir := AddPathDelim( SourceDir );
     CopyToExportDir := SourceDir<>ExportDirPath;

     CopyFromTargetList := High( TargetTableNameList )>=0;

     System.SetLength( FinalTargetTableNameList, High( SourceTableNameList ) + 1 );
     For Index := 0 To High( SourceTableNameList ) do
       If   CopyFromTargetList
       then FinalTargetTableNameList[ Index ] := TargetTableNameList[ Index ]
       else FinalTargetTableNameList[ Index ] := SourceTableNameList[ Index ];

     Result := '';

     If   CopyToExportDir
     then begin
          CleanExportDir;
          For Index := 0 to High( SourceTableNameList ) do
            begin
            SetFileNames( Index );
            If   not CopyFile( SourceFileName, TargetFileName, [ cfOverWrite, cfNotifyError ] )
            then If   Assigned( ProcessFrame )
                 then ProcessFrame.AddMsg( ntInformation, Format( RsMsg29, [ SourceFileName ] ) );
            end;
          end;

     With ZipForge do
       begin

       EraseFile( ExportDirPath + BackupFileName );

       FileName := ExportDirPath + BackupFileName;
       OpenArchive;

       FileMasks.Clear;

       For Index := 0 to High( FinalTargetTableNameList ) do
         begin
         SetFileNames( Index );
         If   FileExists( TargetFileName )
         then FileMasks.Add( TargetFileName )
         else begin
              ShowNotification( ntStop, Format( RsMsg48, [ TargetFileName ] ), '' );
              Abort;
              end;
         end;

       AddFiles;

       CloseArchive;

       // Una vez comprimidos se suprimen los ficheros originales

       For Index := 0 to High( FinalTargetTableNameList ) do
         begin
         SetFileNames( Index );
         If   FileExists( TargetFileName )
         then DeleteFile( TargetFileName );
         end;

       end;

     Result := ExportDirPath + BackupFileName;

end;


procedure TExportImportModule.SMTPProgress(      Sender  : TObject; Total,
                                                 Current : Int64;
                                             var Cancel  : Boolean );
begin
     If   Assigned( ProcessFrame )
     then With ProcessFrame do
            begin
            If   ProgressBar.Visible
            then IncProgressBar
            else begin
                 ShowProgressBar;
                 RecordMessage := 'Transfiriendo : ';
                 end;
            Cancel := Canceled;
            end;

     Application.ProcessMessages;
end;

procedure TExportImportModule.SMTPSend;

begin

     try

       If   Assigned( ProcessFrame )
       then ProcessFrame.ShowProgressBar( True );

       SMTP.Send( OutgoingMailMessage );

       DmCorreoTable.Append;
       With DmCorreoFields do
         begin
         CodigoEmpresa.Value := CodigoEmpresaActual;
         CodigoUsuario.Value := CodigoUsuarioActual;
         Carpeta.Value := Ord( ccEnviados );
         Tipo.Value := Ord( PaqueteAProcesar );
         Asunto.Value := OutgoingMailMessage.Subject;
         Remitente.Value := OutgoingMailMessage.From.Email;
         Destinatario.Value := OutgoingMailMessage.ToList.EmailAddresses;
         Fecha.Value := Now;
         Hora.Value := Now;
         Parametros.Value := HeaderList.Text;

         {  De momento no guardo los adjuntos para ahorrar espacio
         If   Assigned( idAttachFile )
         then Adjunto.LoadFromFile( idAttachFile.StoredPathName );
         }
         end;

       DmCorreoTable.Post;

     finally
       SMTP.Close;
       HeaderList.Clear;
       If   Assigned( ProcessFrame )
       then ProcessFrame.HideProgressBar;
       end;
end;

procedure TExportImportModule.POP3Init( TipoDatos       : TTipoDatosExportados;
                                        Fecha           : TDateTime;  // Para que no se compruebe, poner un 0
                                        OnAcceptMessage : TSimpleEvent );

var  MsgCount,
     MsgIndex,
     AttachInx : SmallInt;
     MailSignature : String;
     MessageParams : String;
     MessageList : TObjectList<TclMailMessage>;
     UseIMAPClient : Boolean;
     MailboxesList : TStrings;

function GetMessageParams : String;

var  Cps,
     Cpe,
     I : SmallInt;
     BodyText,
     ParamsStr : String;

begin

     // HeaderList.Clear;

     Result := '';
     BodyText := '';

     // IncomingMailMessage

     {
     If   IncomingMailMessage.IsMultiPartContent
     then begin
          For I := 0 to IncomingMailMessage.MainPart.PartsCount - 1 do
            begin
            MessagePart := MainPart.GetPart( I );
            If   Assigned( MessagePart ) and MessagePart.IsText
            then begin
                 MessagePart.GetText( BodyText );
                 Break;
                 end;
            end;
          end
     else } BodyText := IncomingMailMessage.MessageText.Text;

     // El cuerpo del mensaje está compuesto de una serie de líneas de advertencia para el usuario
     // seguido de una línea con la marca de inicio de parámetros y de los propios parámetros (uno por línea)

     If   BodyText<>''
     then begin
          Cps := Pos( CodigoInicioParametros, BodyText );
          Cpe := Pos( CodigoFinParametros, BodyText );
          If   Cps<>0
          then begin
               If   Cpe=0
               then Cpe := MaxSmallint;  // Los mensajes viejos no tenian marca de fin de parametros
               Result := Copy( BodyText, Cps + 6, Cpe - Cps - 6 );  // Cp + SizeOf( CodigoInicioParametros ) + SizeOf( CR )
               end;
          end;

end;

procedure AddMessage( MsgIndex : Integer );

var  MailSubject,
     St,
     ParameterText : String;
     I,
     CodigoPaquete,
     AddressIndex : SmallInt;

begin

     try

       If   UseIMAPClient
       then IMAP4.RetrieveHeader( MsgIndex, IncomingMailMessage )
       else POP3.RetrieveHeader( MsgIndex, IncomingMailMessage );

       // GESTWIN 10.4 (01-001,01-01/01/2008)

       If   Assigned( IncomingMailMessage ) and ( IncomingMailMessage.Subject<>'' )
       then begin
            MailSubject := Trim( IncomingMailMessage.Subject );
            ProcessFrame.AddMsg( ntRecordInformation, MailSubject  );
            St := Copy( MailSubject, 1, Length( MailSignature ) );
            If   St=MailSignature
            then begin

                 CodigoPaquete := 0;
                 try
                   St := Copy( MailSubject, 15, 2 );
                   CodigoPaquete := StrToInt( St );
                 except
                   end;

                 If   CodigoPaquete=Ord( PaqueteAProcesar )
                 then If   ( Fecha=0 ) or ( FormatDateTime( 'dd/mm/yyyy', Fecha )=Copy( MailSubject, 25, 10 ) )
                      then begin

                           CorreoEntranteDataset.Append;
                           CorreoEntranteDatasetIndice.Value := MsgIndex;
                           CorreoEntranteDatasetAsunto.Value := MailSubject;

                           CorreoEntranteDatasetRemitente.Value := IncomingMailMessage.From.Email;
                           CorreoEntranteDatasetDestinatario.Value := IncomingMailMessage.ToList.EmailAddresses;

                           { Pendiente
                           If   ( ( CorreoEntranteDatasetRemitente.Value='' ) or ( CorreoEntranteDatasetDestinatario.Value='' ) ) and
                                ( OutHeader.MailAddressListCount>0 )
                           then For AddressIndex := 0 to MailAddressListCount - 1 do
                                  begin
                                  MailAddressList := OutHeader.GetMailAddressList( AddressIndex );
                                  If   MailAddressList.Count>0
                                  then begin
                                       MailAddress := MailAddressList.GetAddress( 0 );
                                       If   MailAddressList.FieldName='From'
                                       then CorreoEntranteDatasetRemitente.Value := MailAddress.Address
                                       else If   MailAddressList.FieldName='To'
                                            then CorreoEntranteDatasetDestinatario.Value := MailAddress.Address;
                                     end;
                                end;
                           }


                           CorreoEntranteDatasetFecha.Value := DateOf( IncomingMailMessage.Date );
                           CorreoEntranteDatasetHora.Value := TimeOf( IncomingMailMessage.Date );

                           ParameterText := '';

                           If   UseIMAPClient
                           then IMAP4.RetrieveMessage( MsgIndex, IncomingMailMessage )
                           else POP3.Retrieve( MsgIndex, IncomingMailMessage );

                           CorreoEntranteDatasetIndiceClase.Value := MessageList.Count;
                           CorreoEntranteDatasetParametros.Value := GetMessageParams; // HeaderList.Text;

                           MessageList.Add( IncomingMailMessage );

                           CorreoEntranteDataset.Post;

                           end;

                 end;
            end;

       except on E : Exception do
         begin
         If   not ( E is EAbort )
         then ShowNotification( ntStop, E.Message );
         raise;
         end;
       end;
end;

begin

     DoOnAcceptMessage := OnAcceptMessage;

     MailboxesList := TStringList.Create;

     try

       try

         SetupPOP3IMAP;

         UseIMAPClient := DmConfiguracionCorreoFields.TipoServidorCorreoEntrante.Value=mailIMAP;
         PaqueteAProcesar := TipoDatos;
         ImportDirPath := AddPathDelim( SessionDataModule.GetImportDirectory );
         MailSignature := Format( RsMsg18, [ ProgramVersion, ProgramRelease ] );

         MessageList := TObjectList<TclMailMessage>.Create;
         MessageList.OwnsObjects := False;

         If   UseIMAPClient
         then begin
              IMAP4.SelectMailbox( 'INBOX' );
              MsgCount := IMAP4.CurrentMailBox.ExistsMessages;
              end
         else MsgCount := POP3.MessageCount;

         If   MsgCount=0
         then begin
              ProcessFrame.AddMsg( ntStop, RsMsg21 );
              Exit;
              end;

         If   Assigned( ProcessFrame )
         then With ProcessFrame do
                begin
                AddMsg( ntInformation, RsMsg22 );
                ShowProgressBar( False, MsgCount );
                end;

         // GettingSummary := True;

         With CorreoEntranteDataset do
           begin
           Close;
           Open;
           end;

         CleanImportDir;

         ProcessFrame.RecordMessage := RsMsg45;

         For MsgIndex := 1 to MsgCount do
           begin
           AddMessage( MsgIndex );
           If   Assigned( ProcessFrame )
           then begin
                // ProcessFrame.AddRecordMsg( IntToStr( MsgIndex ) );
                ProcessFrame.IncProgressBar;
                If   ProcessFrame.Canceled
                then Abort;
                end;
           end;

         If   Assigned( ProcessFrame )
         then ProcessFrame.ShowProgressBar( True );

         If   MailBox( TipoDatos, CorreoEntranteDataset )=mrOk
         then With CorreoEntranteDataset do
                begin
                First;
                While not Eof do
                  begin
                  If   CorreoEntranteDatasetSeleccionado.Value
                  then begin

                       If   ProcessCanceled
                       then Abort;

                       If   Assigned( ProcessFrame )
                       then ProcessFrame.ShowProgressBar;

                       If   Active
                       then begin

                            var ItemMailMessage := MessageList.Items[ CorreoEntranteDatasetIndiceClase.Value ];

                            //  Asunto : GESTWIN 09.2 (01-001,01-01/01/2000)

                            {

                            For var PartIndex := 0 to ItemMailMessage.Part.PartsCount - 1 do
                              begin
                              MessagePart := ReceivedMessage.MainPart.GetPart( PartIndex );
                              If   Assigned( MessagePart ) and MessagePart.IsAttachment
                              then begin
                                   ImportPathAndName := ImportDirPath + MessagePart.FileName;
                                   MessagePart.SaveDataToFile( ImportPathAndName );
                                   end;
                              end;

                            }

                            HeaderList.Text := CorreoEntranteDatasetParametros.Value;

                            If   Assigned( DoOnAcceptMessage )
                            then DoOnAcceptMessage;

                            If   not ProcessCanceled
                            then begin

                                 If   ShowNotification( ntQuestion, RsMsg46, RsMsg47 )=mrYes
                                 then If   UseIMAPClient
                                      then IMAP4.DeleteMessage( CorreoEntranteDatasetIndice.Value )
                                      else POP3.Delete( CorreoEntranteDatasetIndice.Value );

                                 DmCorreoTable.Append;
                                 With DmCorreoFields do
                                   begin
                                   CodigoEmpresa.Value := CodigoEmpresaActual;
                                   CodigoUsuario.Value := CodigoUsuarioActual;
                                   Carpeta.Value := Ord( ccRecibidos );
                                   Tipo.Value := Ord( TipoDatos );
                                   Asunto.Value := CorreoEntranteDatasetAsunto.Value;
                                   Remitente.Value := CorreoEntranteDatasetRemitente.Value;
                                   Destinatario.Value := CorreoEntranteDatasetDestinatario.Value;
                                   Fecha.Value := CorreoEntranteDatasetFecha.Value;
                                   Hora.Value := CorreoEntranteDatasetHora.Value;
                                   Parametros.Value := CorreoEntranteDatasetParametros.Value;
                                   {
                                   If   Assigned( idAttachFile )
                                   then Adjunto.LoadFromFile( ImportPathAndName );
                                   }
                                   end;
                                 DmCorreoTable.Post;
                                 end;

                            end;

                       end;
                  Next;
                  end;

                end
         else Abort;

       except on E : Exception do
         begin
         If   not ( E is EAbort )
         then ShowNotification( ntStop, E.Message );
         raise;
         end;
       end;

     finally
       MailboxesList.Free;
       MessageList.Free;
       POP3.Close;
       If   Assigned( ProcessFrame )
       then ProcessFrame.HideProgressBar;
       end;

end;

procedure TExportImportModule.CheckRecordProcessed;
begin
     If   Assigned( ProcessFrame )
     then If   not RecordProcessed
          then begin
               ProcessFrame.AddMsg( ntError, RsMsg31 );
               Abort;
               end;
end;

procedure TExportImportModule.CompressAndCopyFiles( TableNameList : TStringArray;
                                                    SourcePath,
                                                    TargetPath   : String;
                                                    CheckRecords : Boolean  = False );

var  Index              : SmallInt;
     TotalSize          : LongInt;
     CopyToExportDir    : Boolean;

begin

     If   Assigned( ProcessFrame ) and  ( High( TableNameList )>=0 )
     then With ProcessFrame do
            try

              If   CheckRecords
              then CheckRecordProcessed;

              AddMsg( ntInformation, RsMsg25 );
              ProgressBar.Properties.Max := High( TableNameList );
              ShowProgressBar;

              ExportDirPath := AddPathDelim( SessionDataModule.GetExportDirectory ); // Para no llamar cada vez a la función

              // Si SourcePath esta vacio supongo que la lista de ficheros contienen Path y FileName

              If   SourcePath<>''
              then SourcePath := AddPathDelim( SourcePath );

              CopyToExportDir := UpperCase( SourcePath )<>UpperCase( ExportDirPath );

              If   CopyToExportDir
              then begin

                   CleanExportDir;

                   // Significa que los ficheros a comprimir y Exportar no están en el directorio de
                   // importación. Por lo tanto, primero se copiaran al mismo.

                   For Index := 0 to High( TableNameList ) do
                     CopyFile( SourcePath + TableNameList[ Index ], ExportDirPath + ExtractFileName( TableNameList[ Index ] ) );

                   SourcePath := ExportDirPath;
                   end;

               With ZipForge do
                 begin

                 EraseFile( ExportDirPath + BackupFileName );

                 FileName := ExportDirPath + BackupFileName;
                 OpenArchive;

                 FileMasks.Clear;

                 For Index := 0 to High( TableNameList ) do
                   FileMasks.Add( SourcePath + ExtractFileName( TableNameList[ Index ] ) );

                 AddFiles;

                 TotalSize := ZipForge.Size;

                 CloseArchive;

                 For Index := 0 to High( TableNameList ) do
                   DeleteFile( SourcePath + ExtractFileName( TableNameList[ Index ] ) );   // Una vez comprimido se suprime el original

                 end;

              HideProgressBar;
              AddMsg( ntInformation, Format( RsMsg1, [ TargetPath ] ) );

              CompruebaDisco( TargetPath, TotalSize, False );

              { If   VirtualUI
              then VirtualUI.DownloadFile( ExportDirPath + BackupFileName )
              else } CopyFile( ExportDirPath + BackupFileName, TargetPath + BackupFileName );

            except on e : Exception do
              begin
              ShowException( E, nil );
              raise;
              end;
            end;

end;

function TExportImportModule.DeCompressAndCopyFiles( ArchivePath    : String;
                                                     TableNameList  : TStringArray;
                                                     CopyToDataPath : Boolean = False ) : TStringArray;

var  Index : SmallInt;
     CopyToImportDir : Boolean;
     ADatabase : TnxDatabase;
     F : TZFArchiveItem;

begin

     If   Assigned( ProcessFrame )
     then With ProcessFrame do
            begin

            AddMsg( ntInformation, Format( RsMsg26, [ ArchivePath ] ) );
            ShowProgressBar;

            ArchivePath := AddPathDelim( ArchivePath );
            ImportDirPath := AddPathDelim( SessionDataModule.GetImportDirectory );
            CopyToImportDir := UpperCase( ArchivePath )<>UpperCase( ImportDirPath );

            If   CopyToImportDir
            then begin
                 CleanImportDir;
                 CopyFile( ArchivePath + BackupFileName, ImportDirPath + BackupFileName );
                 end;

            AddMsg( ntInformation, RsMsg28 );
            ShowProgressBar;

            With ZipForge do
              begin

              FileName := ImportDirPath + BackupFileName;

              If   CopyToDataPath
              then BaseDir := AddPathDelim( EnterpriseDataModule.UserDataPath )
              else BaseDir := ImportDirPath;

              AddMsg( ntInformation, Format( RsMsg37, [ BaseDir ] ) );

              OpenArchive;

              FileMasks.Clear;

              If   High( TableNameList )=-1  // Hay que extraerlos todos
              then FileMasks.Add( '*.*' )
              else For Index := 0 to High( TableNameList ) do
                     begin
                     FileMasks.Add( TableNameList[ Index ] );
                     AddMsg( ntInformation, TableNameList[ Index ] );
                     end;

              // Obtengo una lista de los ficheros que se extraen

              SetLength( Result, FileCount );
              Index := 0;
              If   FindFirst( F )
              then repeat
                     Result[ Index ] := F.FileName;
                     Inc( Index );
                   until not FindNext( F );

              ExtractFiles;

              CloseArchive;
              end;

            end;
end;

procedure TExportImportModule.DeCompressFiles( ArchivePath   : String;
                                               TableNameList : TStringArray );

var  Index : SmallInt;

begin

     With ZipForge do
       begin
       FileName := AddPathDelim( ArchivePath ) + BackupFileName;
       BaseDir := ArchivePath;
       OpenArchive;
       FileMasks.Clear;

       For Index := 0 to High( TableNameList ) do
         FileMasks.Add( TableNameList[ Index ] );

       ExtractFiles;

       CloseArchive;
       end;

end;

procedure TExportImportModule.ZipForgeOverallProgress(     Sender        : TObject;
                                                           Progress      : Double;
                                                           Operation     : TZFProcessOperation;
                                                           ProgressPhase : TZFProgressPhase;
                                                       var Cancel        : Boolean);
begin
     Application.ProcessMessages;
end;


procedure TExportImportModule.ZipForgeProcessFileFailure(     Sender       : TObject;
                                                              FileName     : TZFString;
                                                              Operation    : TZFProcessOperation; NativeError,
                                                              ErrorCode    : Integer;
                                                              ErrorMessage : TZFString;
                                                          var Action       : TZFAction );
begin
     //..
     FZipProcessFail := True;
     FZipProcessErrorMessage := ErrorMessage;
     Action := fxaAbort;
end;

function TExportImportModule.ExportRecordToText( SourceTable      : TnxeTable;
                                                 CharSeparator    : Char = ',';
                                                 ConvertRTFToHTML : Boolean = False ) : String;

var  Index : SmallInt;
     RecordString,
     FieldString : String;
     Field : TField;

begin
     RecordString := '';
     If   Assigned( SourceTable )
     then With SourceTable do
            begin
            For Index:= 0 to FieldCount - 1 do
              begin

              Field := Fields[ Index ];
              FieldString := Field.AsString;

              If   Field.DataType in [ ftWideString, ftWideMemo ]
              then begin
                   If   ConvertRTFToHTML and ( Field.DataType=ftWideMemo )
                   then FieldString := TextConverter.ToPlainText( FieldString );
                   FieldString := StrRemoveChars( FieldString, [ #0, #10, #13 ] );
                   FieldString := StrChangeChar( FieldString, '"', '''' );
                   FieldString := AnsiQuotedStr( FieldString , '"' );
                   end
              else If   Field.DataType in [ ftFloat, ftBCD ]
                   then FieldString := StrChangeChar( FieldString, ',', '.' )
                   else If   Field.DataType=ftBoolean
                        then begin
                             If   Trim( FieldString )=''
                             then FieldString := 'False';
                             end
                        else If   Field.DataType=ftGraphic // No exporto las imágenes en formato texto
                             then FieldString := '';

              If   RecordString<>''
              then RecordString := RecordString + CharSeparator;
              RecordString := RecordString + {  '(' + Field.FieldName + ') ' + } FieldString;

              end;
            Result := RecordString;
            end;
end;

procedure TExportImportModule.Imap4VerifyServer(       Sender       : TObject;
                                                       ACertificate : TclCertificate;
                                                 const AStatusText  : string;
                                                       AStatusCode  : Integer;
                                                 var   AVerified    : Boolean );
begin
     AVerified := True;
end;

function TExportImportModule.ImportRecordFromText(  var SourceFile              : Text;
                                                        TargetTable             : TnxeTable;
                                                        CheckRecordIRTProcedure : TCheckRecordIRTProcedure = nil ) : Boolean;


var  Index : SmallInt;
     RecordString,
     FieldString : String;
     ListaParametros : TStringList;
     Value : String;
     Field : TField;

begin
     Result := False;
     With TargetTable do
       begin
       ListaParametros := TStringList.Create;
       try

         Readln( SourceFile, RecordString );

         ExtraeParametros( RecordString, ListaParametros );

         If   ListaParametros.Count=FieldCount
         then begin

              If   Assigned( CheckRecordIRTProcedure )
              then CheckRecordIRTProcedure( ListaParametros )
              else Append;

              For Index := 0 to FieldCount - 1 do
                begin
                Field := Fields[ Index ];
                Value := ListaParametros.Strings[ Index ];
                If   Field is TGUIDField
                then begin
                     If   Value<>''
                     then TGUIDField( Field ).AsGuid := StringToGuid( Value );
                     end
                else Field.AsString := Value;
                end;

              end
         else begin
              ShowNotification( ntStop, Format( RsMsg33, [ TargetTable.TableName ] ) );
              Abort;
              end;

         Result := True;

       finally
         ListaParametros.Free;
         end;

       end;
end;

procedure TExportImportModule.CargaRelacionFicheros(     Tipo          : SmallInt;
                                                         CheckListBox  : TcxCheckListBox;
                                                     var ParametrosRec : TParametrosLWRec );

var  TableIndex : SmallInt;
     TableName : String;
     ItemIndex : SmallInt;
     NroFichero : LongWOrd;
     CheckListBoxItem  : TcxCheckListBoxItem;
     TableList : TStringList;

function EstaEnLaLista( NroFichero : LongWord ) : Boolean;

var   Index  : SmallInt;

begin
     Result := False;
     For Index := 1 to 128 do
       If   ParametrosRec[ Index ]=0
       then Exit
       else If   ParametrosRec[ Index ]=nroFichero
            then begin
                 Result := True;
                 Exit;
                 end;
end;

begin

     Configuracion.ObtenParametros( Tipo, CodigoEmpresaActual, TParametrosRec( ParametrosRec ) );

     // Uso nxCalcShStrELFHash

     With EnterpriseDataModule.UserDatabase do
       begin
       TableList := TStringList.Create;
       If   Assigned( TableList )
       then try
              CheckListBox.Items.BeginUpdate;
              GetTableNames( TableList );
              With TableList do
                For TableIndex := Count - 1 downto 0 do
                  begin
                  TableName := Strings[ TableIndex ];
                  If   Assigned( GetTableDictionary( TableName ) )   // Solo compruebo si existe el Diccionario
                  then begin
                       CheckListBoxItem := CheckListBox.Items.Add;
                       CheckListBoxItem.Text := TableName;
                       NroFichero := nxCalcShStrELFHash( TableName );
                       CheckListBoxItem.Checked := EstaEnLaLista( NroFichero );
                       end;
                  end;
            finally
              CheckListBox.Items.EndUpdate;
              TableList.Free;
              end;
       end;
end;

procedure TExportImportModule.GuardaRelacionFicheros(     Tipo          : SmallInt;
                                                          CheckListBox  : TcxCheckListBox;
                                                      var ParametrosRec : TParametrosLWRec );
var   Index,
      Counter : SmallInt;
      CheckListBoxItem  : TcxCheckListBoxItem;

begin

     // Guardo los números de fichero que ha seleccionado el usuario para la próxima vez

     FillChar( ParametrosRec, SizeOf( ParametrosRec ), #0 );

     Counter := 1;
     With CheckListBox do
       For Index := 0 to Items.Count - 1 do
         begin
         CheckListBoxItem  := Items[ Index ];
         If   Assigned( CheckListBoxItem )
         then With CheckListBoxItem do
                If   Checked
                then begin
                     ParametrosRec[ Counter ] := nxCalcShStrELFHash( Text );  // TableName
                     Inc( Counter );
                     end;
         end;

     Configuracion.GuardaParametros( Tipo, CodigoEmpresaActual, TParametrosRec( ParametrosRec ) );

end;

procedure TExportImportModule.OAuthLaunchBrowser(Sender: TObject; const AUrl: string; var Handled: Boolean);
begin
     {
     ApplicationContainer.ShowWebForm( AUrl, RsAccesoOAuth );
     Handled := True;
     }
     If   Assigned( ProcessForm )
     then ProcessForm.OnCancelProcess := DoOnCancelOAuth;
     Handled := False;
end;

procedure TExportImportModule.DoOnCancelOAuth;
begin
     SimpleHttpServer.Close;
end;


function TExportImportModule.ObtenRelacionFicheros( CheckListBox  : TcxCheckListBox;
                                                    FileList      : TStringList;
                                                    AddExtension  : Boolean = False ) : Boolean;

var   Index : SmallInt;
      CheckListBoxItem  : TcxCheckListBoxItem;
      TableName : String;

begin
     With CheckListBox do
       For Index := 0 to Items.Count - 1 do
         begin
         CheckListBoxItem  := Items[ Index ];
         If   Assigned( CheckListBoxItem )
         then With CheckListBoxItem do
                If   Checked
                then begin
                     TableName := Text;
                     If   AddExtension
                     then TableName := TableName + '.nx1';
                     FileList.Add( TableName );
                     end;
         end;
     Result := FileList.Count>0;
end;

// FTP

procedure TExportImportModule.FTPInit;
begin

     If   FtpClient.Active
     then FtpClient.Close;  // Por si acaso

     FtpClient.Server := Configuracion.ParametrosGlbRec.HostFTP;
     FtpClient.UserName := Configuracion.ParametrosGlbRec.UsuarioFTP;
     FtpClient.Password := Configuracion.ParametrosGlbRec.PasswordFTP;

     try
       FtpClient.Open;
     except
       FtpClient.Close;
       raise;
       end;

end;

function TExportImportModule.CompressFile( AFileName    : String;
                                           DeleteSource : Boolean = False ) : String;

var  CompressedFileName : String;

begin
     CompressedFileName := AddPathDelim( AFileName, '_' );
     With ZipForge do
       begin
       EraseFile( CompressedFileName );  // Por si existe
       FileName := CompressedFileName;
       OpenArchive;
       FileMasks.Clear;
       FileMasks.Add( AFileName );
       AddFiles;
       CloseArchive;
       If   DeleteSource
       then EraseFile( AFileName );
       Result := CompressedFileName;
       end;
end;

function TExportImportModule.DeCompressFile( CompressedFile : String;
                                             DeleteSource   : Boolean = True ) : String;

var  TargetFileName : String;

begin
     TargetFileName := RemovePathDelim( ExtractFileName( CompressedFile ), '_' );
     FZipProcessFail := False;
     With ZipForge do
       begin
       FileName := CompressedFile;
       BaseDir := ExtractFilePath( CompressedFile );
       OpenArchive;
       try
         FileMasks.Clear;
         FileMasks.Add( TargetFileName );
         ZipForge.ExtractFiles;
       finally
         CloseArchive;
         end;
       end;
     If   FZipProcessFail
     then begin
          ShowNotification( ntStop, FZipProcessErrorMessage );
          Abort;
          end
     else begin
          Result := ExtractFilePath( CompressedFile ) + TargetFileName;
          If   DeleteSource
          then EraseFile( CompressedFile );
          end;
end;

function TExportImportModule.FTPGetFile( SourceFile,
                                         TargetFile  : String{ ;
                                         Compressed  : Boolean = False } ) : Integer;
begin

     {
     If   Compressed
     then begin
          SourceFile := AddPathDelim( SourceFile, '_' );
          TargetFile := AddPathDelim( TargetFile, '_' );
          end;
     }

     FTPProgressInitialized := False;
     FTPFileSize := FtpClient.GetFileSize( SourceFile );
     FTPFileName := ExtractFileNameWithoutExtension( TargetFile );

     FtpClient.GetFile( SourceFile, TargetFile );

     {
     If   Compressed
     then DeCompressFile( TargetFile );
     }

     Result := FTPFileSize;
end;

function  TExportImportModule.FTPGetFileSize( AFileName   : String {;
                                              Compressed  : Boolean = False } ) : Int64;
begin
     {
     If   Compressed
     then AFileName := AddPathDelim( AFileName, '_' );
     }
     Result := FtpClient.GetFileSize( AFileName );
end;

function TExportImportModule.FTPFileExists( AFileName  : String {;
                                            Compressed : Boolean = False } ) : Boolean;
begin
     {
     If   Compressed
     then AFileName := AddPathDelim( AFileName, '_' );
     }
     Result := FtpClient.FileExists( AFileName );
end;

procedure TExportImportModule.FTPCreateDirPath( DirPath   : String;
                                                PathDelim : Char = '/' );

var   Offset,
      Sp : SmallInt;
      PathSegment : String;
      LastSegment : Boolean;
      SearchRec : TSearchRec;

begin
     DirPath := RemovePathDelim( DirPath, PathDelim );
     Offset := 1;
     repeat
       Sp := pos( PathDelim, Copy( DirPath, Offset, 255 ) );
       If   Sp<>0
       then begin
            PathSegment := Copy( DirPath, 1, Offset + Sp - 2 );
            Offset := Offset + Sp;
            lastSegment := False;
            end
       else begin
            PathSegment := DirPath;
            lastSegment := True;
            end;

       try
         If   PathSegment<>''
         then FtpClient.MakeDir( PathSegment );
       except
         // Aunque el error no ocurra porque ya existe el directorio da igual : se producirá un error al intentar utilizarlo.
         end;

     until LastSegment;

end;

procedure TExportImportModule.FTPPutFile( SourceFile,
                                          TargetFile   : String {;
                                          Compressed   : Boolean = False } );

var  FileSize : Cardinal;

begin

     {
     If   Compressed
     then begin

          TargetFile := AddPathDelim( TargetFile, '_' );

          With ZipForge do
            begin
            FileName := AddPathDelim( SourceFile, '_' );
            OpenArchive;
            FileMasks.Clear;
            FileMasks.Add( RemovePathDelim( SourceFile ) );
            AddFiles;
            CloseArchive;
            end;

          SourceFile := ZipForge.FileName;
          end;
     }

     FTPProgressInitialized := False;

     FTPFileSize := GetFileSize( SourceFile );
     FTPFileName := ExtractFileNameWithoutExtension( SourceFile );

     FtpClient.PutFile( SourceFile, TargetFile );

end;


procedure TExportImportModule.FtpClientProgress( Sender         : TObject;
                                                 ABytesProceed,
                                                 ATotalBytes    : Int64);

var  Percent : SmallInt;

begin
     If   Assigned( ProcessFrame )
     then With ProcessFrame do
            begin

            If   not FTPProgressInitialized
            then begin
                 ShowProgressBar;
                 RecordMessage := 'Transfiriendo : ';
                 Application.ProcessMessages;
                 FTPProgressInitialized := True;
                 end;

            If   Assigned( ProgressBar )
            then begin
                 If   ATotalBytes>0
                 then Percent := ( ABytesProceed * 100 ) div ATotalBytes
                 else begin
                      Percent := Trunc( ProgressBar.Position );
                      Inc( Percent );
                      If   Percent>100
                      then Percent := 1;
                      end;
                 If   LastPercent<>Percent
                 then begin
                      LastPercent := Percent;
                      ProgressBar.Position := Percent;
                      AddRecordMsg( FTPFileName + Format( ' ... %d %%', [ Percent ] ) );
                      end;
                 end;

            Application.ProcessMessages;
            If   ProcessFrame.Canceled
            then Abort;
            end;
end;

procedure TExportImportModule.POP3Error( Sender: TObject; ErrorCode: Integer; Fatal, Remote: Boolean );
begin
     If   Assigned( ProcessFrame )
     then ProcessFrame.AddMsg( ntInformation, 'Error : ' + IntToStr( ErrorCode ) + ', Remote : ' + BoolToStr( Remote ) );
     If   ErrorCode=502
     then ErrorCode := 0;
end;

procedure TExportImportModule.POP3MessageLine(Sender: TObject; const Info: string);
begin
     If   Assigned( ProcessFrame )
     then With ProcessFrame do
            begin
            Application.ProcessMessages;
            If   Canceled
            then Abort;
            end;
end;


procedure TExportImportModule.Pop3VerifyServer(       Sender       : TObject;
                                                      ACertificate : TclCertificate;
                                                const AStatusText  : string;
                                                      AStatusCode  : Integer;
                                                var   AVerified    : Boolean );
begin
     AVerified := True;
end;

function TExportImportModule.GettLastSMTPError : String;
begin
     // De momento
     Result := 'Código de error : ' + IntToStr( SMTP.LastResponseCode );
end;

function TExportImportModule.EnviaMensajePrueba( ConfiguracionCorreoTable : TnxTable ) : Boolean;

var  I : SmallInt;
     CurCursor : TCursor;

begin

     Result := False;

     // CurCursor := Screen.Cursor;
     try

       // Screen.Cursor := crHourglass;

       FConfiguracionCorreoSuministrada := True;

       DmConfiguracionCorreoFields.Update( ConfiguracionCorreoTable );

       try
         SMTPInit( tdInforme,
                   [ 'Mensaje de prueba de Gestwin', DmConfiguracionCorreoFields.Direccion.Value ],
                   RsMensajeCorreoPrueba,
                   RsMensajeCorreoPrueba );

       except on E : Exception do
         begin
         ShowNotification( ntStop, RsMsg39, RsMsg40 + HtmlCR + RsMsg44 + E.Message );
         Exit;
         end;
       end;

       try
         SMTPSend;
         Result := True;
       except
         ShowNotification( ntStop, RsMsg41, GettLastSMTPError );
         end;

     finally
       // Screen.Cursor := CurCursor;
       SMTP.Close;
       end;
end;

function TExportImportModule.EnviaInformePorCorreo( NombreDestinatario,
                                                    EMailDestinatario,
                                                    Asunto,
                                                    Texto               : String;
                                                    FicherosAdjuntos    : TStringList = nil;
                                                    Confirmar           : Boolean = False ) : Boolean;

var  I : SmallInt;
     CurCursor : TCursor;
     Attachments : TStringArray;

begin

     Result := False;

     // CurCursor := Screen.Cursor;

     Attachments := [];

     try

       // Screen.Cursor := crHourglass;

       If   Assigned( FicherosAdjuntos )
       then With FicherosAdjuntos do
              For I := 0 to Count - 1 do
                If   Names[ I ]<>''
                then Attachments := Attachments + [ Names[ I ] ]
                else Attachments := Attachments + [ Strings[ I ] ];

       try
         SMTPInit( tdInforme, [ NombreDestinatario, EMailDestinatario ], Asunto, Texto, Attachments );
       except on E : Exception do
         begin
         ShowNotification( ntStop, RsMsg39, RsMsg40 + HtmlCR + RsMsg44 + E.Message );
         Exit;
         end;
       end;

       If   Confirmar
       then OutgoingMailMessage.ReplyTo := OutgoingMailMessage.From.Email;

       try
         SMTPSend;
         Result := True;
       except
         ShowNotification( ntStop, RsMsg41, GettLastSMTPError );
         end;

     finally
       // Screen.Cursor := CurCursor;
       end;
end;

procedure TExportImportModule.CreaFirma( MemoCtrl        : TcxCustomMemo;
                                         Nombre          : String;
                                         DireccionCorreo : String = '';
                                         Empresa         : String = '');
begin
     With MemoCtrl do
       begin
       Clear;
       Lines.Add( '--' );
       Lines.Add( RsMsg38 );
       Lines.Add( '  ' + Nombre );
       If   DireccionCorreo<>''
       then Lines.Add( '  Correo a : ' + DireccionCorreo );
       If   Empresa<>''
       then Lines.Add( '  ' + Empresa );
       end;
end;

function DescripcionTipoDatosExportados( Tipo : SmallInt ): String;
begin
     case Tipo of
      tdCualquiera         : Result := '<Todos>';
      tdFicheroMaestro     : Result := 'Fichero maestro';
      tdAsiento            : Result := 'Asiento';
      tdPedidoCompras      : Result := 'Pedido de compras';
      tdAlbaranCompras     : Result := 'Albaran de compras';
      tdPresupuesto        : Result := 'Presupuesto';
      tdPedidoVentas       : Result := 'Pedido de ventas';
      tdAlbaranVentas      : Result := 'Albaran de ventas';
      tdMovimientoAlmacen  : Result := 'Movimiento de almacén';
      tdPreventa           : Result := 'Preventa';
      tdTareas             : Result := 'Tareas';
      tdFacturaPDF         : Result := 'Factura PDF';
      tdImpresoCliente     : Result := 'Impresos de clientes';
      tdInforme            : Result := 'Informe';
      tdMandato            : Result := 'Mandato';
      tdPresupuestoPDF     : Result := 'Presupuesto PDF';
      tdPedidoVentasPDF    : Result := 'Pedido de ventas PDF';
      tdAlbaranVentasPDF   : Result := 'Albaran de ventas PDF';
      tdArticulo           : Result := 'Articulo';
      tdOfertaPDF          : Result := 'Oferta PDF';
      tdPedidoComprasPDF   : Result := 'Pedido de compras PDF';
      tdAlbaranComprasPDF  : Result := 'Albaran de compras PDF';
      tdOferta             : Result := 'Oferta';
      tdCartaOperacionesClientes
                           : Result := 'Carta operaciones clientes';
      tdFacturaXML         : Result := 'Factura XML';

      tdSuscripcion        : Result := 'Suscripción';
      tdContactoWeb        : Result := 'Contacto Web';

      else                   Result := '<No definido>';
     end;
end;

procedure Initialize;
begin
     ExportImport;
end;

initialization
     AddProcedure( imProcedure, pidCreateExportModule, Initialize );

end.



