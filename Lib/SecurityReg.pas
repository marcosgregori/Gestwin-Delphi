
unit SecurityReg;

interface

{$I SecBbox.inc}

procedure Register;

implementation

uses Windows,
     Classes,

     SBCertRetriever,
     SBCertValidator,
     SBCRL,
     SBCustomCertStorage,
     SBMessages,
     SBOCSPClient,
     SBPDF,
     SBPDFSecurity,
     SBPGPKeys,
     SBTSPClient,
     SBWinCertStorage,
     SBX509,
     SBXMLAdESIntf,
     SBXMLEnc,
     SBXMLSig;

procedure Register;
begin

     (*
     RegisterComponents( 'PKIBlackbox', [ {$ifdef SB_APPLE_KEYCHAIN} TElAppleCertStorage, {$ENDIF}
                                          TElAttributeCertificate,
                                          TElAttributeCertificateEx,
                                          TElAuthenticodeManager,
                                          TElCryptoCardManager,
                                          TElFileCertificateRetriever,
                                          TElX509CertificateValidator,
                                          TElCertificateRevocationList,
                                          TElFileCertStorage,
                                          TElMemoryCertStorage,
                                          TElCertificateLookup,
                                          TElHTTPCertificateRetriever,
                                          TElHTTPOCSPClient,
                                          TElHTTPTSPClient,
                                          TElJWToken,
                                          TElJWSignature,
                                          TElJWEncryption,
                                          TElLDAPCertificateRetriever,
                                          TElMessageEncryptor,
                                          TElMessageDecryptor,
                                          TElMessageSigner,
                                          TElMessageVerifier,
                                          {$ifndef SB_NO_COMPRESSION}TElMessageCompressor, {$endif}
                                          TElMessageDecompressor,
                                          TElMessageTimestamper,
                                          TElMessageTimestampVerifier,
                                          TElFileOCSPClient,
                                          TElOCSPServer,
                                          TElCertificateRequest,
                                          TElPKCS11CertStorage,
                                          TElPKCS11Manager,
                                          TElSocketTSPClient,
                                          TElFileTSPClient,
                                          TElFileTSPServer,
                                          TElWinCertStorage,
                                          TElX509Certificate,
                                          TElX509CertificateEx ] );

     RegisterComponents( 'ZIPBlackbox', [ {$ifndef SB_ZIPSFX_STUB} TElZipWriter, {$endif}
                                          TElZipReader,
                                          TElZIPSFXStub ] );

     RegisterComponents( 'ASiCBlackbox', [TElASiCContainer]);

     RegisterComponents( 'CloudBlackbox', [ TElAWSS3DataStorage,
                                            TElBoxDataStorage,
                                            TElDefaultDataStorageSecurityHandler,
                                            TElDropboxDataStorage,
                                            TElFileDataStorage,
                                            TElGoogleDriveDataStorage,
                                            TElOneDriveDataStorage,
                                            TElOneDriveDataStorageV1,
                                            TElWinAzureDataStorage ] );

     RegisterComponents( 'HTTPBlackbox', [ TElCookieManager,
                                           TElHTTPSClient,
                                           TElHTTPSServer,
                                           TElOAuth2RedirectReceiver,
                                           TElRESTClient,
                                           TElSimpleOAuth2Client ] );

     RegisterComponents( 'FTPSBlackbox', [ TElFTPSServer,
                                           TElSimpleFTPSClient,
                                           TElSimpleFTPSServer,
                                           TElSimpleSFTPServer ] );

     RegisterComponents( 'SFTPBlackbox', [ TElSftpClient,
                                           TElSFTPServer,
                                           TElSimpleSftpClient
                                           { TElIdSFTPClient } ] );

     RegisterComponents( 'SecureBlackbox', [ TElDNSClient,
                                             TElDNSResolver,
                                             TElSBLicenseManager,
                                             TElPortKnock,
                                             TElSocket ] );

     RegisterComponents( 'SSLBlackbox', [ TElDTLSClient,
                                          TElDTLSServer,
                                          TElDTLSServerFactory,
                                          TElSessionPool,
                                          TElSimpleSSLClient,
                                          TElSSLClient,
                                          TElSSLServer ] );

     RegisterComponents( 'WebDAVBlackbox', [ TElHTTPSWebDAVClient,
                                             TElWebDAVClient,
                                             TElWebDAVServer,
                                             TElWebDAVMemoryLockList ] );

     RegisterComponents( 'MailBlackbox', [ TElIMAPClient,
                                           TElPOP3Client,
                                           TElSMTPClient ] );

     RegisterComponents( 'LDAPBlackbox', [ TElLDAPCertStorage,
                                           TElLDAPSClient,
                                           TElLDAPSKeyserverClient ] );

     RegisterComponents( 'OfficeBlackbox', [ TElOfficeDocument,
                                             TElOfficeOpenXMLStandardEncryptionHandler,
                                             TElOfficeOpenXMLAgileEncryptionHandler,
                                             {$ifndef SB_NO_RC4}
                                             TElOfficeBinaryRC4EncryptionHandler,
                                             TElOfficeBinaryRC4CryptoAPIEncryptionHandler,
                                              {$endif}
                                             TElOfficeBinaryCryptoAPISignatureHandler,
                                             TElOfficeBinaryXMLSignatureHandler,
                                             TElOfficeOpenXMLSignatureHandler,
                                             TElOfficeOpenXPSSignatureHandler,
                                             TElOpenOfficeSignatureHandler ] );

     {$ifndef SB_PGPSFX_STUB}
     RegisterComponents( 'PGPBlackbox', [ TElPGPReader,
                                          TElPGPWriter,
                                          TElPGPKeyring,
                                          TElPGPSFXStub ] );
     {$ENDIF}

     RegisterComponents( 'SAMLBlackbox', [ TElSAMLIdentityProvider,
                                           TElSAMLIDPPasswordMemoryAuthSource,
                                           TElSAMLServiceProvider ] );

     RegisterComponents( 'SSHBlackbox', [ TElSimpleSSHClient,
                                          TElSimpleSSHServer,
                                          TElSSHClient,
                                          TElShellSSHTunnel,
                                          TElCommandSSHTunnel,
                                          TElSubsystemSSHTunnel,
                                          TElX11ForwardSSHTunnel,
                                          TElRemotePortForwardSSHTunnel,
                                          TElLocalPortForwardSSHTunnel,
                                          TElSSHTunnelList,
                                          TElSSHLocalPortForwarding,
                                          TElSSHRemotePortForwarding,
                                          TElSSHForwardingIntercept,
                                          TElSSHMemoryKeyStorage,
                                          TElSSHPKCS11KeyStorage,
                                          TElSSHPublicKeyClient,
                                          TElSSHPublicKeyServer,
                                          TElSSHServer,
                                          TElTerminalInfo,
                                          TElUsers
                                          {
                                          TElIdSSHClient,
                                          TElClientIndySSHIOHandlerSocket,
                                          TElClientIndySSHTransport,
                                          TElIdSSHClientServerIOHandler,
                                          TElIdSSHServerIOHandler,
                                          TElIdSSHConnectionIOHandler
                                          } ] );

     {
     RegisterComponents( 'SolFS', [ TElSolidFileSystemAdapter ] );
     }

     *)

     RegisterComponents( 'PDFBlackbox', [ TElPDFDocument,
                                          TElPDFPasswordSecurityHandler,
                                          TElPDFPublicKeySecurityHandler ]);

     RegisterComponents( 'XMLBlackbox', [ TElXAdESSigner,
                                          TElXAdESVerifier,
                                          TElXMLEncryptor,
                                          TElXMLDecryptor,
                                          TElXMLSigner,
                                          TElXMLVerifier ] );

     RegisterComponents( 'PKIBlackbox', [ TElMemoryCertStorage,
                                          TElWinCertStorage,
                                          TElX509Certificate ] );

     RegisterComponents( 'PDFBlackbox', [ TElPDFDocument ]);

     RegisterComponents( 'XMLBlackbox', [ TElXAdESSigner,
                                          TElXAdESVerifier,
                                          TElXMLSigner,
                                          TElXMLVerifier ] );

end;

initialization

end.


