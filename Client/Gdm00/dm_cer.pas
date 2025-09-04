unit dm_cer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxCheckListBox,

  ExtCtrls,
  CheckLst,

  DB,
  nxdb,
  Generics.Collections,

  ZipForge,

  SBCertValidator,
  SBConstants,
  SBTypes,

  SBUtils,
  SBSSLConstants,
  SBPublicKeyCrypto,
  SBTSPCommon,
  SBCustomCertStorage,
  SBX509,
  SBWinCertStorage,

  clCertificateStore,
  clSoapSecurity,
  clCertificate,
  clEncoder,

  dxX509Certificate,

  AppContainer,
  DataManager,
  AppForms,

  Gim00Fields;


type
  TCertificadosModule = class(TDataModule)
    WinCertStorage: TElWinCertStorage;
    MemoryCertStorage: TElMemoryCertStorage;
    CertificateStore: TclCertificateStore;
    Encoder: TclEncoder;
    UserCertificateStore: TclCertificateStore;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);

  private

    FCertificadoUsuario : TclCertificate;
    FCertStorage : TElCustomCertStorage;

    function ObtenThumbPrint( HashCertificado : TMessageDigest160 ) : String;

  public

    // SecureBlackbox

    function CargaCertificadoSB(     CertificadoSistema : Boolean;
                                     TipoAccesso        : TTipoAccesoCertificadoSistema;
                                     HashCertificado    : TMessageDigest160;
                                     Fichero            : String;
                                     PalabraPaso        : String;
                                 var CertIndex          : Integer ) : TElCustomCertStorage; overload;

    // CleverComponents

    function CargaCertificado( CertificadoSistema : Boolean; TipoAccesso : TTipoAccesoCertificadoSistema; ThumbPrint : string; Fichero : String; PalabraPaso : String {; Instalar : Boolean = False } ) : TclCertificate; overload;
    function CargaCertificado{ ( Instalar : Boolean = False ) } : TclCertificate; overload;
    function CertificadoValido( Certificado : TclCertificate ) : Boolean;
    function ImportaCertificado( Fichero, PalabraPaso : String ) : Boolean;
    function InstalaCertificado( TipoAccesso : TTipoAccesoCertificadoSistema; Fichero : String; PalabraPaso : String ) : String;
    procedure CompruebaCertificadoUsuario;
    procedure CompruebaErrorAutoFirma( Error : DWORD );

    property CertStorage : TElCustomCertStorage read FCertStorage;
    property CertificadoUsuario : TclCertificate read FCertificadoUsuario;

  end;

var  CertificadosModule : TCertificadosModule = nil;

function Certificados : TCertificadosModule;

implementation

uses Winapi.ShellAPI,

     LibUtils,
     AppManager,

     SBCryptoProvManager,
     SBStrUtils,

     clUtils,

     Gdm00Dm,

     dm_pga,

     f_prg;

{$R *.dfm}

resourceString
      RsMsg50 = 'No se ha podido obtener el certificado del almacén del sistema.';
      RsMsg51 = 'Verifique su configuración de seguridad.';
      RsMsg52 = 'No se ha podido cargar el certificado.';
      RsMsg53 = 'Error nº %d.';
      RsMsg54 = 'El certificado no es válido.';
      RsMsg55 = 'Revise, por si es ese el origen del problema, el tipo de certificado, la palabra de paso o la fecha de caducidad del mismo.';
      RsMsg56 = 'No se ha podido instalar el certificado.';
      RsMsg57 = 'El certificado no puede ser usado para firmar documentos.';

      RsAutofirmaNoInstalada = 'La aplicación AutoFirma no está instalada o no es accesible.';
      RsErrorUsoAutoFirma = 'Ha ocurrido un error al intentar realizar la firma con la aplicación Autofirma.';
      RsInstaleAutofirma = 'Acceda al mantenimiento de la configuración de seguridad y utilice el botón de descarga para obtener y re/instalar la aplicación.';


const
     DefaultCertStoreName = 'MY';
     GestwinCertStoreName = 'Gestwin';

function Certificados : TCertificadosModule;
begin
     CreateDataModule( TCertificadosModule, CertificadosModule );
     Result := CertificadosModule;
end;

procedure TCertificadosModule.DataModuleCreate(Sender: TObject);
begin
     // CertificateStore y UserCertificateStore permanecen abiertos durante toda la sesión

     CertificateStore.Open( DefaultCertStoreName );

     // UserCertificateStore contiene los certificados cargados desde ficheros.
     // Como no se instalan, el store estará siempre vacío al inicio.

     UserCertificateStore.Open( GestwinCertStoreName );

     FCertificadoUsuario := CargaCertificado;
end;

procedure TCertificadosModule.DataModuleDestroy(Sender: TObject);
begin

     UserCertificateStore.Close;
     CertificateStore.Close;

     CertificadosModule := nil;
end;

function TCertificadosModule.CertificadoValido( Certificado : TclCertificate ) : Boolean;
begin
     Result := CertificateStore.Verify( Certificado );
end;

function TCertificadosModule.ImportaCertificado( Fichero,
                                                 PalabraPaso       : String ) : Boolean;
begin
     Result := False;

     var FileExt := LowerCase( ExtractFileExt( Fichero ) );
     try
       If   ( FileExt='.pfx' ) or ( FileExt='.p12' )
       then  UserCertificateStore.ImportFromPFX( Fichero, PalabraPaso )
       else If   FileExt='.cer'
            then UserCertificateStore.ImportFromCER( Fichero )
            else If   FileExt='.csr'
                 then UserCertificateStore.ImportSignedCSR( Fichero )
                 else begin
                      ShowNotification( ntError, RsMsg54, RsMsg55 );
                      Exit;
                      end;
       Result := True;
     except on E : Exception do
       ShowNotification( ntError, RsMsg52, E.Message + #13'Fichero : ' + Fichero );
       end;

end;

procedure TCertificadosModule.CompruebaErrorAutoFirma( Error : DWORD );

var  ErrorMessage : String;

begin
     If   Error<>NO_ERROR
     then begin
          If   Error=ERROR_FILE_NOT_FOUND
          then ErrorMessage := RsAutofirmaNoInstalada
          else ErrorMessage := RsErrorUsoAutoFirma;
          If   Assigned( ProcessFrame )  // Solo para poder ponerlo en negrita
          then begin
               ProcessFrame.AddMsg( ntError, ErrorMessage, { LogError } False, { BoldText } True );
               ProcessFrame.AddMsg( ntError, RsInstaleAutofirma );
               end
          else ShowNotification( ntError, ErrorMessage, RsInstaleAutofirma );
          Abort;
          end;
end;

procedure TCertificadosModule.CompruebaCertificadoUsuario;
begin
     If   not Assigned( FCertificadoUsuario ) or not CertificadoValido( FCertificadoUsuario )
     then begin
          ShowNotification( ntError, RsMsg54, RsMsg55 );
          Abort;
          end;
end;

function TCertificadosModule.CargaCertificado{ ( Instalar : Boolean = False ) } : TclCertificate;
begin
     With Configuracion.ParametrosSeguridadRec do
       begin
       var ThumbPrint := ObtenThumbPrint( HashCertificado );
       Result := CargaCertificado( CertificadoSistema, TipoAcceso, ThumbPrint, Fichero, PalabraPaso );
       end;
end;

function TCertificadosModule.CargaCertificado( CertificadoSistema : Boolean;
                                               TipoAccesso        : TTipoAccesoCertificadoSistema;
                                               ThumbPrint         : string;
                                               Fichero            : String;
                                               PalabraPaso        : String {;
                                               Instalar           : Boolean = False } ) : TclCertificate;

var   ErrorCode : DWORD;
      Cert : TclCertificate;

(*
procedure LeeCertificado;
begin
      Cert := CertificateStore.FindByThumbPrint( ThumbPrint, { ARequirePrivateKey } False );
      If   Assigned( Cert )
      then begin
           If   CertificateStore.Verify( Cert )
           then Result := Cert
           else ShowNotification( ntError, RsMsg54, RsMsg55 );
           end
      else ShowNotification( ntError, RsMsg50, RsMsg51 );
end;
*)

begin

     Result := nil;

     If   TipoAccesso=acCurrentUser
     then CertificateStore.StoreLocation := TclCertificateStoreLocation.slCurrentUser
     else CertificateStore.StoreLocation := TclCertificateStoreLocation.slLocalMachine;

     If   CertificadoSistema
     then begin
          Cert := CertificateStore.FindByThumbPrint( ThumbPrint, { ARequirePrivateKey } False );
          If   Assigned( Cert )
          then begin
                If   CertificateStore.Verify( Cert )
                then Result := Cert
                else ShowNotification( ntError, RsMsg54, RsMsg55 );
                end
          else ShowNotification( ntError, RsMsg50, RsMsg51 );
          end
     else If   Fichero<>''
          then {
               If   Instalar
               then begin
                    ThumbPrint := InstalaCertificado( TipoAccesso, Fichero, TclEncoder.Decode( PalabraPaso, cmBase64 ) );
                    LeeCertificado;
                    end
               else }
               begin
               // Se importa en el almacén de la sesión y se crea pero no se instala. Solo necesito el Certificado para su uso inmediato.
               If   ImportaCertificado( Fichero, TclEncoder.Decode( PalabraPaso, cmBase64 ) )
               then With UserCertificateStore do
                      If   Items.Count>0
                      then Result := Items[ Items.Count - 1 ];
               end;

     // CertificateStore y UserCertificateStore no se cierran durante toda la sesión para que puedan usarse

end;

// Devuelve el ThumbPrint del certificado instalado

function TCertificadosModule.InstalaCertificado( TipoAccesso : TTipoAccesoCertificadoSistema;
                                                 Fichero     : String;
                                                 PalabraPaso : String ) : String;

var  ACertificate : TclCertificate;

begin

     Result := '';

     try
       ImportaCertificado( Fichero, PalabraPaso );
       If   UserCertificateStore.Items.Count>0
       then begin
            ACertificate := UserCertificateStore.Items[ UserCertificateStore.Items.Count - 1 ];
            If   Assigned( ACertificate )
            then try
                   CertificateStore.Install( ACertificate );
                   If   CertificateStore.Verify( ACertificate )
                   then begin
                        Result := ACertificate.SubjectKeyIdentifier;
                        Exit;
                        end;
                 except on E : Exception do
                   ShowNotification( ntError, RsMsg56, E.Message );
                   end;
            ShowNotification( ntError, RsMsg54, RsMsg55 );
            end;

       finally

         end;

end;

function TCertificadosModule.ObtenThumbPrint( HashCertificado : TMessageDigest160 ) : String;

var  ByteArrayHash : TclByteArray;

begin
     var HashSize := SizeOf( TMessageDigest160 );
     SetLength( ByteArrayHash, HashSize );
     Move( ( @HashCertificado )^, Pointer( ByteArrayHash )^, HashSize );
     Result := BytesToHex( ByteArrayHash );
end;

function TCertificadosModule.CargaCertificadoSB(      CertificadoSistema : Boolean;
                                                      TipoAccesso        : TTipoAccesoCertificadoSistema;
                                                      HashCertificado    : SBTypes.TMessageDigest160;
                                                      Fichero            : String;
                                                      PalabraPaso        : String;
                                                  var CertIndex          : Integer ) : TElCustomCertStorage;

var   ErrorCode : DWORD;
      Cert : TElX509Certificate;
      {
      NewCert : TclCertificate;
      ByteArrayHash : Array[ 0..19 ] of Byte;
      ByteArrayHash : TclByteArray;
      }

{
function ByteArrayToHexString( const Bin : Array of Byte ) : string;

const HexSymbols = '0123456789ABCDEF';
var   i : integer;

begin
     SetLength( Result, Length( Bin ) * 2 );
     for i :=  0 to Length( Bin ) - 1 do
       begin
       Result[ 2 * i + 1 ] := HexSymbols[ 1 + Bin[ i ] shr 4 ];
       Result[ 2 * i + 2 ] := HexSymbols[ 1 + Bin[ i ] and $0F ];
       end;
end;
}

begin
     Result := nil;
     CertIndex := -1;

     MemoryCertStorage.Clear;

     If   CertificadoSistema
      then begin

           If   TipoAccesso=acCurrentUser
           then WinCertStorage.AccessType := atCurrentUser
           else WinCertStorage.AccessType := atLocalMachine;

           CertIndex := WinCertStorage.FindByHash( HashCertificado );
           If   CertIndex<>-1
           then begin
                Cert := WinCertStorage.Certificates[ CertIndex ];
                If   Cert.IsKeyValid
                then begin


                     (*

                     // Intentado localizar el certificado en el nuevo CertificateStore

                     SetLength( ByteArrayHash, MessageDigest160Size );
                     Move( ( @HashCertificado )^, Pointer( ByteArrayHash )^, MessageDigest160Size );
                     var HexHash := BytesToHex( ByteArrayHash );

                     CertificateStore.Open( 'MY' );

                     // Funcionan los dos métodos, pero el Thumbprint se obtiene directamente del Hash de SecureBlackBox

                     // NewCert := CertificateStore.FindBySerialNo( ByteArrayToHexString( Cert.SerialNumber ), '' { Cert.IssuerName.CommonName } );
                     NewCert := CertificateStore.FindByThumbprint( HexHash );

                     *)

                     MemoryCertStorage.Add( Cert );
                     CertIndex := MemoryCertStorage.CertificateList.Count - 1;
                     Result := MemoryCertStorage;
                     end
                else begin
                     CertIndex := -1;
                     ShowNotification( ntError, RsMsg54, RsMsg55 );
                     end;
                end
            else ShowNotification( ntError, RsMsg50, RsMsg51 );

           end
      else If   Fichero<>''
           then begin
                Cert := TElX509Certificate.Create( nil );
                try
                  ErrorCode := Cert.LoadFromFileAuto( Fichero, PalabraPaso );
                  If   ErrorCode=0
                  then begin
                       If   Cert.IsKeyValid
                       then begin
                            MemoryCertStorage.Add( Cert );
                            CertIndex := MemoryCertStorage.CertificateList.Count - 1;
                            Result := MemoryCertStorage;
                            end
                       else ShowNotification( ntError, RsMsg54, RsMsg55 );
                       end
                  else ShowNotification( ntError, RsMsg52, Format( RsMsg53, [ ErrorCode ] ) );
                finally
                  Cert.Free;
                  end;
                end;

end;

initialization

end.



