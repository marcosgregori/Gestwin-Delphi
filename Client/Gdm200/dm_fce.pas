unit dm_fce;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls,

  DB, AppForms, nxdb, DataManager,

  SBPDF, SBPDFSecurity, SBX509, SBCustomCertStorage, SBTypes, SBUtils, SBEncoding,
  SBWinCertStorage, SBTSPCommon, SBTSPClient,
  SBConstants,

  XMLIntf,
  XMLDoc,
  XMLDom,
  MSXML,
  MSXMLDom,

  LibUtils,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,
  Gdm200Dm,

  SBXMLCore,
  SBXMLSec,
  SBXMLSig,
  SBXMLAdESIntf,
  SBXMLCharsets,

  ParametrosFacturacionIntf;

type
  TFacturaElectronicaDataModule = class(TDataModule)
    PublicKeyHandler: TElPDFPublicKeySecurityHandler;
    XMLDocument: TXMLDocument;
    DmOrganismoPublicoTable: TnxeTable;
    DmMovimientoTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    DmGrupoLineaMovimientoTable: TnxeTable;
    DmFacturaComprasTable: TnxeTable;
    DmRegistroFacturaElectronicaTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

    CertStorage : TElCustomCertStorage;
    CertificadoCargado : Boolean;
    AlmacenPath,
    AlmacenDocumentosImportadosPath : String;
    FileStream : TFileStream;
    Index : integer;
    Sig : TElPDFSignature;
    // CertFormat : TSBCertFileFormat;

    DmMovimientoFields : TMovimientoFields;
    DmLineaMovimientoFields : TLineaMovimientoFields;
    DmGrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
    DmFacturaComprasFields : TFacturaComprasFields;
    DmRegistroFacturaElectronicaFields : TRegistroFacturaElectronicaFields;

    OficinaContableFields,
    OrganoGestorFields,
    UnidadTramitadoraFields,
    OrganoProponenteFields : TOrganismoPublicoFields;

    DsFacturaFields : TFacturaFields;
    DsProveedorFields : TProveedorFields;
    DsArticuloFields : TArticuloFields;
    DsFormaCobroFields : TFormaCobroFields;

    DsPaisFields : TPaisFields;

    procedure DoXMLSignerFormatElement(Sender: TObject; Element: TElXMLDOMElement; Level: Integer; const Path: string; var StartTagWhitespace, EndTagWhitespace: string);
    procedure CargaCertificadoDefecto;
    procedure DoOnImportacionFacturaEItemClick(Sender: TObject);
    procedure DoOnRegistroFacturaEItemClick(Sender: TObject);

  public

    CertificadoFirmaValido : Boolean;
    CertIndex : Integer;
    Certificate : TElX509Certificate;

    procedure DoOnFirmaFactura( TipoFichero : TTipoFicheroExportacion; var PathFichero : String );
    procedure DoOnLeeFactura( FilePathAndName : String; InsertarLineasSinRegistroArticulo : Boolean = False );

    procedure CreaRegistroFacturaElectronica( Tipo           : TTipoRegistroFacturaElectronica;
                                              Propietario,
                                              Serie          : String;
                                              NroFactura     : Integer;
                                              NIFPropietario : String;
                                              FechaDocumento : TDate;
                                              Importe        : Decimal );

    function ObtenAlmacenDocumentosPath( TipoFichero : TTipoFicheroExportacion ) : String;
    procedure EnviaFacturaPorCorreo( RegistroFacturaElectronicaFields : TRegistroFacturaElectronicaFields );

  end;

function FacturaElectronica : TFacturaElectronicaDataModule;

implementation

uses EnterpriseDataAccess,
     Files,

     AppManager,

     SBXMLAdES,
     SBXMLUtils,
     SBXMLTransform,
     SBXMLDefs,

     dxBar,

     Gdm00Dm,

     Gdm30Frm,

     dmi_iex,
     dmi_ast,
     dmi_fac,
     dmi_mov,

     dm_pga,
     dm_cer,
     dm_fco,
     dm_art,
     dm_rac,
     dm_fdv,
     dm_ast,
     dm_fac,
     dm_efe,
     dm_pro,
     dm_cli,
     dm_pai,
     dm_prv,
     dm_ban,
     dm_iva,
     dm_mov,
     dm_orp,
     dm_fdc,

     a_orp,

     r_fdv,

     b_ife,
     b_rfe,

     b_pro,
     b_msg,
     f_prg;

{$R *.dfm}

resourceString
     RsMsg1  = 'No se ha podido crear o copiar el fichero al almacén de documentos.';
     RsMsg2  = 'Se cancela la generación y firma de documentos.'#13'Verifique que tiene acceso al directorio de documentos [B]%s[/B] y reintente el proceso.';
     RsMsg3  = 'El fichero que se intenta firma está encriptado.';
     RsMsg4  = 'No se puede firmar un documento encriptado.'#13'Fichero :[B]%s[/B]'#13'Se cancela el proceso.';
     RsMsg5  = 'No se ha podido crear o acceder al directorio del almacén de documentos.';
     RsMsg6  = 'La fecha (%s) de la factura %s no es del ejercicio activo.';
     RsMsg7  = 'Cambie de ejercicio y reintente la operación.';
     RsMsg8  = 'El código de artículo %s no existe y no se permiten insertar líneas de artículos sin registro.';
     RsMsg9  = 'Se ha producido un error durante la firma del documento.';
     RsMsg10 = 'Se ha producido un error durante la generación de la factura electrónica.';
     RsMsg11 = 'No se ha podido recuperar la información de la factura rectificada.';
     RsMsg12 = 'Exportando en la carpeta : %s.';
     RsMsg13  = 'Se ha creado el fichero [URL=%s]%s[/URL].';
     RsMsg14 = 'No se ha fijado el N.I.F. del %s.';
     RsMsg15 = 'No ha asignado un certificado de firma válido.';
     RsMsg16 = 'Utilice la ventana de configuración de seguridad en : [B]'#13'   Configuración de la aplicación'#13'      Ficheros'#13'         Configuración de seguridad[/B]'#13' para asignar un certificado de firma.';
     RsMsg17 = 'No se ha podido importar el fichero de factura %s.';
     RsMsg18 = 'Fichero de factura electrónica con una estructura o versión incorrecta.';
     RsMsg19 = 'Creado el albarán %s, del proveedor %s.';
     RsMsg20 = 'Ya existe una factura con el número %s del proveedor %s.';
     RsMsg21 = 'Falta especificar algún dato de la Empresa emisora.';
     RsMsg22 = 'Es necesario que complete los datos de la ficha de la Empresa, como el nombre, domicilio, localidad o código postal, pues son necesarios para la emisión en este formato.';
     RsMsg23 = 'El organismo público de código [%s] no existe.';
     RsMsg24 = 'Financiado por el programa KIT Digital. Plan de Recuperación, Transformación y Resilencia de España "Next Generation EU" IMPORTE SUBVENCIONADO: %s€';
     RsMsg25 = 'No se ha podido crear la factura %s. El albarán generado ha sido eliminado.';
     RsMsg26 = 'No existe ninguna ficha de proveedor o acreedor cuyo N.I.F. sea %s.';
     RsMsg27 = 'No se ha podido recuperar el registro de la factura electrónica.';
     RsMsg28 = 'Revise el registro de facturación de ventas y compruebe que ésta sigue existiendo.';

     RsRazon            = 'Soy el creador del documento.';
     RsPDFFirma         = 'PDF con firma digital';
     RsCamerFactura     = 'CamerFactura XML';
     RsFacturaE         = 'FacturaE V3.2 sin firma';
     RsFacturaEFirma    = 'FacturaE V3.2 con firma';

     RsMotivoDtoRecargo = 'Acordado con el cliente';
     RsEcotasa          = 'EcoTasa';

     // las fuentes son gestionadas por TElPDFSignatureWidgetProps. Deben ser accesibles durante la destrucción del componente.

var  FacturaElectronicaDataModule : TFacturaElectronicaDataModule = nil;

function FacturaElectronica : TFacturaElectronicaDataModule;
begin
     CreateDataModule( TFacturaElectronicaDataModule, FacturaElectronicaDataModule );
     Result := FacturaElectronicaDataModule;
end;

procedure SetupFacturaVentasModule;
begin
     If   ( FacturaElectronica<>nil ) and  // No son variables y no se puede usar Assigned.
          ( FacturaVentas<>nil )
     then begin
          FacturaVentasModule.OnFirmaFactura.Add( FacturaElectronicaDataModule.DoOnFirmaFactura );
          FacturaVentasModule.OnRegistroFacturaElectronicaCreada.Add( FacturaElectronicaDataModule.CreaRegistroFacturaElectronica );
          end;
end;

procedure SetupModule;
begin
     // Aprovecho para fijar el valor de seguridad del módulo

     Configuracion.AñadeModuloOpcional( moFacturaElectronica );
     Configuracion.AñadeModuloOpcional( moReservado );  // Manteniendo la compatibilidad con versiones anteriores (antes, administraciones públicas)
end;

procedure SetupImpresionFacturas;
begin
     If   Assigned( RptFdvForm )
     then With RptFdvForm do
            begin

            With TipoFicheroCtrl.Properties.Items do
              begin
              Add( RsPDFFirma );
              Add( RsCamerFactura );
              Add( RsFacturaE );
              Add( RsFacturaEFirma );
              end;

            DataTipoFichero.Value := 1;  // Si se tiene el módulo de firma digital, la opción por defecto es fichero PDF firmado
            DataEnviarPorCorreo.Value := False;
            end;
end;

procedure TFacturaElectronicaDataModule.DataModuleCreate(Sender: TObject);

var   CertIndex : Integer;
      PalabraPaso : String;
      ErrorCode : Integer;

begin

      If   Configuracion.ParametrosSeguridadRec.AlmacenDocumentos=''
      then AlmacenPath := ApplicationPath
      else AlmacenPath := Configuracion.ParametrosSeguridadRec.AlmacenDocumentos;

      AlmacenPath := AddPathDelim( AddPathDelim( AlmacenPath ) + 'doc_' + CodigoEmpresaActual );

      CreateDirPath( AlmacenPath, RsMsg5 );

      AlmacenDocumentosImportadosPath := AlmacenPath + 'Facturas de compra\' + IntToStr( ApplicationContainer.Ejercicio ) + '\FacturaE\';
      CreateDirPath( AlmacenDocumentosImportadosPath );

      {
      SimpleFont := TElPDFSimpleFont.Create;
      SimpleFont.BaseFont := 'Arial';  // Una fuente siempre disponible en Windows
      }

      XMLDocument.XML.WriteBOM := False;

      OficinaContableFields := TOrganismoPublicoFields.Create( DmOrganismoPublicoTable, True );
      OrganoGestorFields := TOrganismoPublicoFields.Create( DmOrganismoPublicoTable, True );
      UnidadTramitadoraFields := TOrganismoPublicoFields.Create( DmOrganismoPublicoTable, True );
      OrganoProponenteFields := TOrganismoPublicoFields.Create( DmOrganismoPublicoTable, True );

      DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
      DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
      DmGrupoLineaMovimientoFields := TGrupoLineaMovimientoFields.Create( DmGrupoLineaMovimientoTable );
      DmFacturaComprasFields := TFacturaComprasFields.Create( DmFacturaComprasTable );
      DmRegistroFacturaElectronicaFields := TRegistroFacturaElectronicaFields.Create( DmRegistroFacturaElectronicaTable );

      DsFacturaFields := TFacturaFields.Create( Self );
      DsArticuloFields := TArticuloFields.Create( Self );
      DsProveedorFields := TProveedorfields.Create( Self );
      DsFormaCobroFields := TFormaCobroFields.Create( Self );
      DsPaisFields := TPaisFields.Create( Self );

end;

procedure TFacturaElectronicaDataModule.DoOnImportacionFacturaEItemClick( Sender : TObject );
begin
     ImportacionFacturasElectronicas;
end;

procedure TFacturaElectronicaDataModule.DoOnRegistroFacturaEItemClick( Sender : TObject );
begin
     RegistroFacturasElectronicas;
end;

function TFacturaElectronicaDataModule.ObtenAlmacenDocumentosPath( TipoFichero : TTipoFicheroExportacion ) : String;

var  SubdirectorioDocumentos : String;

begin
     case TipoFichero of
       tfePDF           : SubdirectorioDocumentos := 'PDF';
       tfePDFFirma      : SubdirectorioDocumentos := 'PDF Firmado';
       tfeCamerFactura  : SubdirectorioDocumentos := 'CamerFactura';
       tfeFacturaE      : SubdirectorioDocumentos := 'FacturaE';
       tfeFacturaEFirma : SubdirectorioDocumentos := 'FacturaE Firmada';
       else               SubdirectorioDocumentos := 'Archivo';
       end;

     Result := AlmacenPath + 'Facturas de venta\' + IntToStr( ApplicationContainer.Ejercicio ) + '\' + SubdirectorioDocumentos + '\';
     CreateDirPath( Result, RsMsg5 );

end;

procedure TFacturaElectronicaDataModule.DoOnFirmaFactura(     TipoFichero : TTipoFicheroExportacion;
                                                          var PathFichero : String );

var  PathFicheroAlmacen : String;

     PrimeraLinea,
     Success : Boolean;
     FileStream : TFileStream;

     TextoLinea,
     TextoFacturaRectificada,
     TextoTipoPersona,
     TextoTipoResidencia,
     TextoNombre,
     TextoApellido,
     TextoPrimerApellido,
     TextoSegundoApellido,
     TextoISO2Pais,
     TextoISO3Pais,
     TextoNIF,
     TextoVencimiento,
     TextoMotivoDescuento,
     TextoMotivoRecargo : String;

     FechaInicial,
     FechaFinal : TDateTime;

     ImporteBrutoLinea,
     CantidadLinea,
     PrecioLinea : Double;

     I,
     PC : SmallInt;

     RootNode,
     FileHeaderNode,
     BatchNode,
     PartiesNode,
     SellerPartieNode,
     TaxIdentificationNode,
     PartyIdentificationNode,
     LegalEntityNode,
     BuyerPartieNode,
     AdministrativeCentresNode,
     AdministrativeCentreNode,
     AdministrativeCentreAddressNode,
     IndividualNode,
     InvoicesNode,
     InvoiceNode,
     InvoiceHeaderNode,
     CorrectiveNode,
     InvoiceIssueDataNode,
     TaxesOutputsNode,
     TaxNode,
     TaxesWithheldNode,
     InvoiceTotalsNode,
     ItemsNode,
     DiscountsAndRebatesNode,
     PaymentDetailsNode,
     AdditionalDataNode,
     InstallmentNode,
     AccountToBeCreditedNode,
     SignatureNode,

     LineItemPeriodNode,
     SectionNode,
     SubSectionNode,
     SubSection1Node,
     SubSection2Node : IXMLNode;

     IBANCliente : String;
     CodigoEANArticulo,
     CodigoEANComprador : String;

     // AEncoding : TElXMLUTF8Codec;
     XMLDOMDocument : TElXMLDOMDocument;
     XMLSigner : TElXMLSigner;
     XAdESSigner : TElXAdESSigner;
     MemoryStream : TStringStream;
     X509KeyData : TElXMLKeyInfoX509Data;
     SignNode : TElXMLDOMNode;
     Element : TElXMLDOMElement;
     ReferenceList : TElXMLReferenceList;
     Reference : TElXMLReference;
     SignaturePolicyId : TElXMLSignaturePolicyId;
     AnyTypeItem : TElXMLAnyType;
     KeyInfoID,
     FileExt : String;

     CalcularIVA,
     FacturaAdministracion : Boolean;
     OrganismoPublicoFields : TOrganismoPublicoFields;

     Document : TElPDFDocument;
     SimpleFont : TElPDFSimpleFont;

function TipoPersona( NIF : String; Propietario : String ) : String;
begin
     If   NIF=''
     then begin
          ShowNotification( ntStop, Format( RsMsg14, [ Propietario ] ) );
          Abort;
          end
     else If   CharInSet( UpperCase( NIF )[ 1 ], [ '0'..'9', 'M', 'X', 'Y', 'Z' ] )   //** 07.04.2021 Añadidos los DNI's especiales
          then Result := 'F'
          else Result := 'J';
end;

function TipoResidencia( CodigoPais : String ) : String;
begin
     Result := 'R';
     If   CodigoPais<>CodigoEspaña
     then If   Pais.Obten( CodigoPais, DsPaisFields )
          then If   DsPaisFields.Intracomunitario.Value
               then Result := 'U'
               else Result := 'E';
end;

function QuotedStrComma( Value : String ) : String;
begin
     Result := QuotedStr( Value ) + ',';
end;

procedure ExtraePartesNombre(     TipoPersona     : String;
                                  NombreCompleto  : String;
                              var Nombre          : String;
                              var PrimerApellido  : String;
                              var SegundoApellido : String );

var Apellido : String;

begin
     If   TipoPersona='F'
     then begin

          PC := Pos ( ',', NombreCompleto );

          If   PC<>0 // Hay una coma, entonces el nombre va al final
          then begin
               Nombre := Trim( Copy( NombreCompleto, PC + 1 ) );
               Apellido := Trim( Copy( NombreCompleto, 1, PC - 1 ) );
               end
          else begin
               Nombre := ExtractSubstring( NombreCompleto, ' ' );
               Apellido := Trim( Copy( NombreCompleto, Length( Nombre ) + 1 ) );
               end;

          PrimerApellido := ExtractSubstring( Apellido, ' ' );
          If   PrimerApellido=''
          then SegundoApellido := ''
          else SegundoApellido := Copy( Apellido, Length( PrimerApellido ) + 2 );

          end
     else begin
          Nombre := NombreCompleto;
          PrimerApellido := '';
          SegundoApellido := '';
          end;
end;

function DecimalString( Valor : Decimal; Decimales : SmallInt = 2 ) : String;
begin
     Str( Valor:0:Decimales, Result );
end;

function DoubleString( Valor : Double; Decimales : SmallInt = 2 ) : String;
begin
     Str( Valor:0:Decimales, Result );
end;

function DateString( Value : TDateTime ) : String;
begin
     Result := FormatDateTime( 'YYYY-MM-DD', Value );
end;

function ObtenCodigoTipoVA( Codigo : SmallInt ) : String;
begin
     {
       El rango permitido de códigos en FacturaE empieza en 01, por lo que no puedo utilizar 00 para el exento de I.V.A.

       Como el tipo 0 solo se utiliza cuando el cliente o la serie de facturación están exentos del I.V.A.
       puedo utilizar el tipo 1, puesto que la única base imponible -con las cuotas puestas a cero- está
       en el elemento 1 del array
     }

     If   Codigo=0
     then Codigo := 1;
     Result := StrIntPadded( Codigo, 2 );
end;

procedure CompruebaDatosEmpresa;
begin
     If   ( DataModule00.DmEmpresaFields.Nombre.Value='' ) or
          ( DataModule00.DmEmpresaFields.Domicilio.Value='' ) or
          ( DataModule00.DmEmpresaFields.Localidad.Value='' ) or
          ( DataModule00.DmEmpresaFields.CodigoPais.Value='' ) or
          ( DataModule00.DmEmpresaFields.CodigoProvincia.Value='' ) or
          ( DataModule00.DmEmpresaFields.CodigoPostal.Value='' )
     then begin
          ShowNotification( ntStop, RsMsg21, RsMsg22 );
          Abort;
          end;
end;

function  ObtenOrganismoPublico( Tipo   : SmallInt;
                                 Codigo : String ) : Boolean;
begin
     Result := DmOrganismoPublicoTable.FindKey( [ Tipo, Codigo ] );
     If   not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ) );
          Abort;
          end;
end;

begin

     With FacturaVentas do
       begin

       If   TipoFichero in [ tfePDFFirma, tfeFacturaEFirma ]
       then CargaCertificadoDefecto;

       var AlmacenDocumentosPath := ObtenAlmacenDocumentosPath( TipoFichero );

       If   Assigned( ProcessFrame )
       then With ProcessFrame do
              If   not FlagA
              then begin
                   ProcessFrame.AddMsg( ntInformation, Format( RsMsg12, [ AlmacenDocumentosPath ] ) );
                   FlagA := True;
                   end;

       case TipoFichero of

       // PDF ordinario

       tfePDF      : begin
                     PathFicheroAlmacen := AlmacenDocumentosPath + ExtractFileName( PathFichero );
                     If   not CopyFile( PathFichero, PathFicheroAlmacen )
                     then begin
                          ShowNotification( ntError, RsMsg1, Format( RsMsg2, [ AlmacenDocumentosPath ] ) );
                          Abort;
                          end;
                     PathFichero := PathFicheroAlmacen;
                     If   Assigned( ProcessFrame )
                     then ProcessFrame.AddMsg( ntLinkInformation, Format( RsMsg13, [ PathFichero, ExtractFileName( PathFichero ) ] ) );
                     end;

       // PDF con firma digital

       tfePDFFirma : If   CertificadoFirmaValido
                     then begin

                          // Guardando la copia en el almacén de documentos firmados

                          PathFicheroAlmacen := AlmacenDocumentosPath + ExtractFileName( PathFichero );

                          If   not CopyFile( PathFichero, PathFicheroAlmacen )
                          then begin
                               ShowNotification( ntError, RsMsg1, Format( RsMsg2, [ AlmacenDocumentosPath ] ) );
                               Abort;
                               end;

                          try

                            If   Configuracion.ParametrosSeguridadRec.UsarAutoFirma
                            then begin
                                 Certificate := CertStorage.Certificates[ CertIndex ];
                                 var ProcessInformation : TProcessInformation;
                                 var CommandLine := Format( 'autofirmacommandline sign -i "%s" -o "%s" -store windows -alias "%s" -format pades -config "signatureProductionCity=%s\nsignatureProductionProvince=%s\nsignatureProductionPostalCode=%s\nsignatureProductionCountry=%s',
                                                            [ PathFicheroAlmacen,
                                                              PathFicheroAlmacen,
                                                              Certificate.FriendlyName,
                                                              DataModule00.DmEmpresaFields.Localidad.Value,
                                                              Provincia.Descripcion( DataModule00.DmEmpresaFields.CodigoPais.Value,
                                                                                     DataModule00.DmEmpresaFields.CodigoProvincia.Value,
                                                                                     False ),
                                                              DataModule00.DmEmpresaFields.CodigoProvincia.Value + DataModule00.DmEmpresaFields.CodigoPostal.Value,
                                                              Pais.Descripcion( DataModule00.DmEmpresaFields.CodigoPais.Value )
                                                            ] );

                                 StrAdd( CommandLine, '\nsignReason=' + RsRazon );
                                 StrAdd( CommandLine, '\nsignerContact=' + Configuracion.ParametrosSeguridadRec.NombreAutor );

                                 If   Configuracion.ParametrosSeguridadRec.TipoFirma=1  // Firma visible
                                 then StrAdd( CommandLine, '\nsignaturePages=1' +
                                                           '\nsignaturePositionOnPageLowerLeftX=30' +
                                                           '\nsignaturePositionOnPageLowerLeftY=0' +
                                                           '\nsignaturePositionOnPageUpperRightX=400' +
                                                           '\nsignaturePositionOnPageUpperRightY=50' +
                                                           '\nlayer2FontSize=7' +
                                                           '\nlayer2FontColor=gray' );

                                 StrAdd( CommandLine, '"' );

                                 If   not ProcessExecute( ProcessInformation, CommandLine, '', SW_HIDE )
                                 then Certificados.CompruebaErrorAutoFirma( GetLastError );

                                 end
                            else begin

                                 // Abriendo el fichero PDF de la factura

                                 Success := False;
                                 FreeAndNil( Document );
                                 Document := TElPDFDocument.Create( nil );
                                 FileStream := TFileStream.Create( PathFicheroAlmacen, fmOpenReadWrite or fmShareDenyWrite );

                                   try

                                     Document.Open( FileStream );

                                     try

                                       // Comprobando si el documento ya está encriptado

                                       If   Document.Encrypted
                                       then begin
                                            ShowNotification( ntError, RsMsg3, Format( RsMsg4, [ PathFicheroAlmacen ] ) );
                                            Abort;
                                            end;

                                       // Añadiendo la firma y fijando las propiedades del documento

                                       Index := Document.AddSignature;
                                       Sig := Document.Signatures[ Index ];

                                       Sig.WidgetProps.SignerCaption := 'Firmante :';
                                       Sig.WidgetProps.AlgorithmCaption := 'Clave publica :';

                                       PublicKeyHandler.CertStorage := CertStorage;
                                       PublicKeyHandler.CustomName := 'Adobe.PPKMS';

                                       Sig.Handler := PublicKeyHandler;
                                       Sig.AuthorName := Configuracion.ParametrosSeguridadRec.NombreAutor;
                                       Sig.SigningTime := LocalTimeToUTCTime( Now );
                                       Sig.Reason := RsRazon;

                                       // Configurando el tipo de firma

                                       Sig.SignatureType := stDocument;
                                       case Configuracion.ParametrosSeguridadRec.TipoFirma of
                                         0 : Sig.Invisible := True;  // firma de documento invisible
                                         1 : Sig.Invisible := False; // firma visible
                                         2 : begin
                                             Sig.SignatureType := stMDP;
                                             Sig.Invisible := false;
                                             end;
                                         end;

                                       If   not Sig.Invisible
                                       then begin
                                            SimpleFont := TElPDFSimpleFont.Create;
                                            SimpleFont.BaseFont := 'Arial';  // Una fuente siempre disponible en Windows
                                            Sig.WidgetProps.AddFont( SimpleFont );
                                            Sig.WidgetProps.AutoSize := False;
                                            Sig.WidgetProps.AutoStretchBackground := False;
                                            Sig.WidgetProps.AutoFontSize := False;
                                            Sig.WidgetProps.Width := 280;
                                            Sig.WidgetProps.Height := 75;
                                            end;

                                       // Permitiendo guardar el documento
                                       Success := True;

                                     finally
                                       Document.Close( Success );
                                       end;

                                   finally
                                     FreeAndNil( FileStream );
                                     FreeAndNil( Document );
                                     end;

                                 end;

                              PathFichero := PathFicheroAlmacen;

                              If   Assigned( ProcessFrame )
                              then ProcessFrame.AddMsg( ntLinkInformation, Format( RsMsg13, [ PathFichero, ExtractFileName( PathFichero ) ] ) );

                          except on E : Exception do
                            begin
                            ShowException( E );
                            raise;
                            end;
                          end;

                          end
                     else begin
                          ShowNotification( ntStop, RsMsg15, RsMsg16 );
                          Abort;
                          end;

       // CamerFactura en un fichero XML

       tfeCamerFactura :  With XMLDocument, RptCabeceraFields do
                            try

                              PathFicheroAlmacen := AlmacenDocumentosPath + ExtractFileName( PathFichero ) + '.xml';

                              Active := False;
                              XML.Text := '';
                              Active := True;

                              RootNode := AddChild( 'Invoice' );

                              // InvoiceHeader

                              SectionNode := RootNode.AddChild( 'InvoiceHeader' );
                              With SectionNode do
                                begin

                                TextoTipoPersona := TipoPersona( DmClienteFields.NIF.Value, 'cliente' );
                                TextoTipoResidencia := TipoResidencia( DmClienteFields.CodigoPais.Value );

                                If   TextoTipoResidencia='R'
                                then TextoISO2Pais := 'ES'
                                else TextoISO2Pais := DsPaisFields.CodigoISO2.Value;

                                ExtraePartesNombre( TextoTipoPersona, DmClienteFields.Nombre.Value, TextoNombre, TextoPrimerApellido, TextoSegundoApellido );

                                AddChild( 'InvoiceSeriesCode' ).Text := Serie.Value;
                                AddChild( 'InvoiceNumber' ).Text := IntToStr( NroDocumento.Value );
                                AddChild( 'InvoiceDate' ).Text := DateString( FechaDocumento.Value );

                                If   DmSerieFacturacionFields.FacturasRectificativas.Value
                                then begin
                                     If  Factura.ObtenRegistroComercialFactura( tfFacturaVentas, Ejercicio.Value, '', Serie.Value, NroDocumento.Value, DsFacturaFields )
                                     then begin

                                          DataModule00.PeriodoEjercicio( DsFacturaFields.EjercicioFraRectificada.Value, FechaInicial, FechaFinal );

                                          AddChild( 'InvoiceClass' ).Text := 'OR';
                                          AddChild( 'CorrectedInvoiceNumber' ).Text := IntToStr( DsFacturaFields.NroFacturaRectificada.Value );
                                          AddChild( 'CorrectedInvoiceSeriesCode' ).Text := DsFacturaFields.SerieFraRectificada.Value;
                                          AddChild( 'CorrectionReasonCode' ).Text := StrIntPadded( DsFacturaFields.Razon.Value, 2 );
                                          AddChild( 'CorrectionTaxStartDate' ).Text := DateString( FechaInicial );
                                          AddChild( 'CorrectionTaxEndDate' ).Text := DateString( FechaFinal );
                                          AddChild( 'CorrectionMethod' ).Text := StrIntPadded( DsFacturaFields.Metodo.Value, 2 );

                                          end
                                     else raise Exception.Create( RsMsg11 );

                                     end
                                else AddChild( 'InvoiceClass' ).Text := 'OO';

                                AddChild( 'TotalGrossAmount' ).Text := DecimalString( NetoArticulos.Value );
                                AddChild( 'TotalGrossAmountBeforeTaxes' ).Text := DecimalString( ImporteNeto.Value );
                                AddChild( 'TotalTaxOutputs' ).Text := DecimalString( TotalCuotaIVA.Value + TotalCuotaRE.Value );
                                AddChild( 'TotalTaxesWithheld' ).Text := DecimalString( ImporteRetencion.Value );
                                AddChild( 'InvoiceTotal' ).Text := DecimalString( TotalImporte.Value );

                                // Forma de pago

                                If   DmClienteFields.Cobro_CodigoEntidad.Value=''
                                then IBANCliente := ''
                                else IBANCliente := TextoISO2Pais { + '00' } + DmClienteFields.Cobro_CodigoEntidad.Value + DmClienteFields.Cobro_CodigoSucursal.Value + DmClienteFields.Cobro_DC.Value + DmClienteFields.Cobro_Cuenta.Value;

                                FormaCobro.Obten( DmClienteFields.Cobro_FormaCobro.Value, DsFormaCobroFields );

                                SubSectionNode := SectionNode.AddChild( 'Installments' );
                                For I := 1 to RelacionEfectos.NroEfectos do
                                  begin
                                  SubSection1Node := SubSectionNode.AddChild( 'Installment' );
                                  With SubSection1Node do
                                    begin
                                    AddChild( 'InstallmentDueDate' ).Text := DateString( RelacionEfectos.FechaVencimiento[ I ] );
                                    AddChild( 'InstallmentAmount' ).Text := DecimalString( RelacionEfectos.Importe[ I ] );
                                    AddChild( 'PaymentMeans' ).Text := StrIntPadded( DsFormaCobroFields.CodigoFacturaE.Value, 2 );
                                    If   IBANCliente<>''
                                    then AddChild( 'AccountToBeCredited' ).Text := IBANCliente;
                                    end;
                                  end;

                                // Datos cliente

                                SubSectionNode := SectionNode.AddChild( 'BuyerParty' );
                                With SubSectionNode do
                                  begin
                                  AddChild( 'PersonType' ).Text := TextoTipoPersona;
                                  AddChild( 'ResidenceType' ).Text := TextoTipoResidencia;
                                  AddChild( 'TaxIdentification' ).Text := DmClienteFields.NIF.Value;
                                  AddChild( 'Name' ).Text := TextoNombre;
                                  If   TextoPrimerApellido<>''
                                  then AddChild( 'FirstSurname' ).Text := TextoPrimerApellido;
                                  If   TextoSegundoApellido<>''
                                  then AddChild( 'SecondSurname' ).Text := TextoSegundoApellido;
                                  AddChild( 'Address' ).Text := DmClienteFields.Domicilio.Value;
                                  AddChild( 'Town' ).Text := DmClienteFields.Localidad.Value;
                                  AddChild( 'PostalCode' ).Text := DmClienteFields.CodigoProvincia.Value + DmClienteFields.CodigoPostal.Value;
                                  AddChild( 'Region' ).Text := Provincia.Descripcion( DmClienteFields.CodigoPais.Value, DmClienteFields.CodigoProvincia.Value, False );
                                  AddChild( 'CountryCode' ).Text := TextoISO2Pais;
                                  end;

                                // Contacto cliente

                                SubSectionNode := SectionNode.AddChild( 'Contacts' );
                                SubSection1Node := SubSectionNode.AddChild( 'Contact' );
                                With SubSection1Node do
                                  begin
                                  AddChild( 'Name' ).Text := DmClienteFields.Nombre.Value;
                                  AddChild( 'Telephone' ).Text := DmClienteFields.Telefono.Value;
                                  AddChild( 'Email' ).Text := DmClienteFields.EMail.Value;
                                  If   DmClienteFields.Fax.Value<>''
                                  then AddChild( 'Fax' ).Text := DmClienteFields.Fax.Value;
                                  end;

                                // Departamento (es opcional)

                                // Contacto departamento (es opcional)

                                // Datos del emisor

                                TextoTipoPersona := TipoPersona( DataModule00.DmEmpresaFields.NIF.Value, 'emisor' );
                                TextoTipoResidencia := TipoResidencia( DataModule00.DmEmpresaFields.CodigoPais.Value );
                                If   TextoTipoResidencia='R'
                                then TextoISO2Pais := 'ES'
                                else TextoISO2Pais := DsPaisFields.CodigoISO2.Value;

                                ExtraePartesNombre( TextoTipoPersona, DataModule00.DmEmpresaFields.Nombre.Value, TextoNombre, TextoPrimerApellido, TextoSegundoApellido );

                                SubSectionNode := SectionNode.AddChild( 'SellerParty' );
                                With SubSectionNode do
                                  begin
                                  AddChild( 'PersonType' ).Text := TextoTipoPersona;
                                  AddChild( 'ResidenceType' ).Text := TextoTipoResidencia;
                                  AddChild( 'TaxIdentification' ).Text := DataModule00.DmEmpresaFields.NIF.Value;
                                  AddChild( 'Name' ).Text := TextoNombre;
                                  If   TextoPrimerApellido<>''
                                  then AddChild( 'FirstSurname' ).Text := TextoPrimerApellido;
                                  If   TextoSegundoApellido<>''
                                  then AddChild( 'SecondSurname' ).Text := TextoSegundoApellido;
                                  AddChild( 'Address' ).Text := DataModule00.DmEmpresaFields.Domicilio.Value;
                                  AddChild( 'Town' ).Text := DataModule00.DmEmpresaFields.CodigoProvincia.Value + DataModule00.DmEmpresaFields.CodigoPostal.Value;
                                  AddChild( 'PostalCode' ).Text := DataModule00.DmEmpresaFields.Localidad.Value;
                                  AddChild( 'Region' ).Text := Provincia.Descripcion( DataModule00.DmEmpresaFields.CodigoPais.Value, DataModule00.DmEmpresaFields.CodigoProvincia.Value, False );
                                  AddChild( 'CountryCode' ).Text := TextoISO2Pais;
                                  end;

                                end;

                              // InvoiceLines

                              SectionNode := RootNode.AddChild( 'InvoiceLines' );

                              With RptLineasTable, RptLineasFields do
                                begin
                                IndexFieldNames := 'NroOperacion;NroPagina;NroLinea';
                                SetRange( [ RptCabeceraFields.NroOperacion.Value, 0, 1 ], [ RptCabeceraFields.NroOperacion.Value, 0, MaxSmallint ] );
                                First;
                                While not Eof do
                                  begin

                                  If   UnidadesPrecio.Value>1
                                  then begin
                                       If   Cantidad.Value<>0.0
                                       then begin
                                            ImporteBrutoLinea := ImporteBruto.Value;
                                            CantidadLinea := Cantidad.Value;
                                            PrecioLinea := ImporteBrutoLinea / CantidadLinea;
                                            end
                                       else PrecioLinea := 0.0;
                                       end
                                  else PrecioLinea := Precio.Value;

                                  If   Descuento.Value=0.0
                                  then TextoMotivoDescuento := ''
                                  else TextoMotivoDescuento := RsMotivoDtoRecargo;

                                  If   Recargo.Value=0.0
                                  then TextoMotivoRecargo := ''
                                  else TextoMotivoRecargo := RsMotivoDtoRecargo;

                                  SubSectionNode := SectionNode.AddChild( 'InvoiceLine' );
                                  With SubSectionNode do
                                    begin
                                    If   CodigoArticulo.Value<>''
                                    then AddChild( 'IssuerTransactionReference' ).Text := CodigoArticulo.Value;
                                    AddChild( 'ItemDescription' ).Text := Descripcion.Value;
                                    AddChild( 'Quantity' ).Text := DecimalString( Cantidad.Value, DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value );
                                    AddChild( 'UnitPriceWithoutTax' ).Text := DoubleString( PrecioLinea, DataModule00.DmEmpresaFields.Ventas_DecPrecio.Value );
                                    AddChild( 'TotalCost' ).Text := DecimalString( ImporteBruto.Value, DecimalesMoneda );
                                    AddChild( 'GrossAmountBeforeTaxes' ).Text := DecimalString( ImporteNeto.Value, DecimalesMoneda );

                                    // Descuento

                                    If   ImporteDescuento.Value<>0.0
                                    then begin
                                         SubSection1Node := SubSectionNode.AddChild( 'Discounts' );

                                         SubSection2Node := SubSection1Node.AddChild( 'Discount' );
                                         With SubSection2Node do
                                           begin
                                           AddChild( 'DiscountReason' ).Text := TextoMotivoDescuento;
                                           AddChild( 'DiscountAmount' ).Text := DecimalString( ImporteDescuento.Value, DecimalesMoneda );
                                           end;

                                         end;

                                    // Recargo

                                    If   Recargo.Value<>0.0
                                    then begin
                                         SubSection1Node := SubSectionNode.AddChild( 'Charges' );

                                         SubSection2Node := SubSection1Node.AddChild( 'Charge' );
                                         With SubSection2Node do
                                           begin
                                           AddChild( 'ChargeReason' ).Text := TextoMotivoRecargo;
                                           AddChild( 'ChargeAmount' ).Text := DecimalString( Recargo.Value, DecimalesMoneda );
                                           end;

                                         end;

                                    SubSection1Node := SubSectionNode.AddChild( 'TaxOutput' );
                                    With SubSection1Node do
                                      begin
                                      AddChild( 'TaxTypeCode' ).Text := '01';  // IVA
                                      AddChild( 'TaxRate' ).Text := DecimalString( TipoIVA.Value, 2 );
                                      AddChild( 'TaxAmount' ).Text := DecimalString( CuotaIVA.Value, DecimalesMoneda );
                                      end;

                                    end;

                                  PrimeraLinea := False;

                                  Next;
                                  end;

                                end;

                              XMLDocument.SaveToFile( PathFicheroAlmacen );

                              PathFichero := PathFicheroAlmacen;

                              If   Assigned( ProcessFrame )
                              then ProcessFrame.AddMsg( ntLinkInformation, Format( RsMsg13, [ PathFichero, ExtractFileName( PathFichero ) ] ) );

                            except on E : Exception do begin
                                                       ShowNotification( ntError, RsMsg10, 'Error : ' + E.Message );
                                                       raise;
                                                       end;
                              end;
       // FacturaE V3.2

       tfeFacturaE,
       tfeFacturaEFirma  : begin

                           If   ( TipoFichero=tfeFacturaEFirma ) and not CertificadoFirmaValido
                           then begin
                                ShowNotification( ntStop, RsMsg15, RsMsg16 );
                                Abort;
                                end;

                           CompruebaDatosEmpresa;

                           With XMLDocument do
                             try

                               FacturaAdministracion := RptCabeceraFields.OrganismoPublico.Value<>'';

                               If   TipoFichero=tfeFacturaEFirma
                               then FileExt := '.xsig'
                               else FileExt := '.xml';

                               PathFicheroAlmacen := AlmacenDocumentosPath + ExtractFileName( PathFichero ) + FileExt;

                               Active := False;
                               XML.Clear;
                               Active := True;

                               RootNode := AddChild( 'fe:Facturae' );
                               RootNode.Attributes[ 'xmlns:ds' ] := 'http://www.w3.org/2000/09/xmldsig#';
                               RootNode.Attributes[ 'xmlns:fe' ] := 'http://www.facturae.es/Facturae/2009/v3.2/Facturae';
                               RootNode.Attributes[ 'xmlns:namespace3' ] := 'http://www.w3.org/2000/09/xmldsig#';

                               FileHeaderNode := RootNode.AddChild( 'FileHeader', '' );
                               FileHeaderNode.AddChild( 'SchemaVersion' ).Text := '3.2';
                               FileHeaderNode.AddChild( 'Modality' ).Text := 'I';
                               FileHeaderNode.AddChild( 'InvoiceIssuerType' ).Text := 'EM';

                               BatchNode := FileHeaderNode.AddChild( 'Batch' );
                               BatchNode.AddChild( 'BatchIdentifier' ).Text := StrIntPadded( RptCabeceraFields.NroDocumento.Value, 10 ) + RptCabeceraFields.Serie.Value;
                               BatchNode.AddChild( 'InvoicesCount' ).Text := '1';
                               BatchNode.AddChild( 'TotalInvoicesAmount' ).AddChild( 'TotalAmount' ).Text := DecimalString( RptCabeceraFields.TotalImporte.Value );
                               BatchNode.AddChild( 'TotalOutstandingAmount' ).AddChild( 'TotalAmount' ).Text := DecimalString( RptCabeceraFields.TotalImporte.Value );
                               BatchNode.AddChild( 'TotalExecutableAmount' ).AddChild( 'TotalAmount' ).Text := DecimalString( RptCabeceraFields.TotalImporte.Value );
                               BatchNode.AddChild( 'InvoiceCurrencyCode' ).Text := 'EUR';

                               PartiesNode := RootNode.AddChild( 'Parties', '' );
                               SellerPartieNode := PartiesNode.AddChild( 'SellerParty' );                         // 2.1

                               TextoTipoPersona := TipoPersona( DataModule00.DmEmpresaFields.NIF.Value, 'emisor' );
                               TextoTipoResidencia := TipoResidencia( DataModule00.DmEmpresaFields.CodigoPais.Value );
                               TextoNIF := DataModule00.DmEmpresaFields.NIF.Value;

                               If   FacturaAdministracion
                               then begin

                                    If   ObtenOrganismoPublico( topUnidadTramitadora, RptCabeceraFields.OrganismoPublico.Value )
                                    then begin
                                         UnidadTramitadoraFields.Update;
                                         If   ObtenOrganismoPublico( topOrganoGestor, UnidadTramitadoraFields.CodigoCentro.Value )
                                         then begin
                                              OrganoGestorFields.Update;
                                              If   ObtenOrganismoPublico( topOficinaContable, OrganoGestorFields.CodigoCentro.Value )
                                              then OficinaContableFields.Update;
                                              end;
                                         end;

                                    If   RptCabeceraFields.OrganoProponente.Value<>''   // Es opcional
                                    then If   ObtenOrganismoPublico( topOrganoProponente, RptCabeceraFields.OrganoProponente.Value )
                                         then OrganoProponenteFields.Update;

                                    end;

                               If   TextoTipoResidencia='R'
                               then begin
                                    TextoISO3Pais := 'ESP';
                                    If   not ( FacturaAdministracion and not OficinaContableFields.CodigoPaisEnNIF.Value  ) //* 15.09.2016 Por lo visto ahora algunas administraciones no admiten el NIF precedido del código del país
                                    then TextoNIF := 'ES' + TextoNIF;
                                    end
                               else TextoISO3Pais := DsPaisFields.CodigoISO3.Value;

                               TaxIdentificationNode := SellerPartieNode.AddChild( 'TaxIdentification' );                                // 2.1.1
                               TaxIdentificationNode.AddChild( 'PersonTypeCode' ).Text := TextoTipoPersona;                              // 2.1.1.1   F = Física, J=Jurídica
                               TaxIdentificationNode.AddChild( 'ResidenceTypeCode' ).Text := TextoTipoResidencia;                        // 2.1.1.2   E=Extranjero, R=Residente, U=Residente en la unión Europea
                               TaxIdentificationNode.AddChild( 'TaxIdentificationNumber' ).Text := TextoNIF;                             // 2.1.1.3

                               ExtraePartesNombre( TextoTipoPersona, DataModule00.DmEmpresaFields.Nombre.Value, TextoNombre, TextoPrimerApellido, TextoSegundoApellido );

                               // Añadir el codigo EAN del emisor

                               If   DataModule00.DmEmpresaFields.CodigoEAN.Value<>''
                               then begin

                                    AdministrativeCentresNode := SellerPartieNode.AddChild( 'AdministrativeCentres' );                        // 2.1.3
                                    AdministrativeCentreNode := AdministrativeCentresNode.AddChild( 'AdministrativeCentre' );                 // 2.1.3.1

                                    AdministrativeCentreNode.AddChild( 'CentreCode' ).Text := '00';                                           // 2.1.3.1.1 Un código fijo y único (no hay centros de emisión)
                                    AdministrativeCentreNode.AddChild( 'RoleTypeCode' ).Text := '01';                                         // 2.1.3.1.2 Receptor
                                    AdministrativeCentreNode.AddChild( 'Name' ).Text := TextoNombre;                                          // 2.1.3.1.3
                                    AdministrativeCentreNode.AddChild( 'FirstSurname' ).Text := TextoPrimerApellido;                          // 2.1.3.1.4
                                    AdministrativeCentreNode.AddChild( 'SecondSurname' ).Text := TextoSegundoApellido;                        // 2.1.3.1.5
                                                                                                                                              // 2.1.3.1.6
                                    SectionNode := AdministrativeCentreNode.AddChild( 'AddressInSpain' );                                     // 2.1.3.1.6.1
                                    SectionNode.AddChild( 'Address' ).Text := DataModule00.DmEmpresaFields.Domicilio.Value;
                                    SectionNode.AddChild( 'PostCode' ).Text := DataModule00.DmEmpresaFields.CodigoProvincia.Value + DataModule00.DmEmpresaFields.CodigoPostal.Value;
                                    SectionNode.AddChild( 'Town' ).Text := DataModule00.DmEmpresaFields.Localidad.Value;
                                    SectionNode.AddChild( 'Province' ).Text := Provincia.Descripcion( DataModule00.DmEmpresaFields.CodigoPais.Value, DataModule00.DmEmpresaFields.CodigoProvincia.Value, False );
                                    SectionNode.AddChild( 'CountryCode' ).Text := TextoISO3Pais;

                                    AdministrativeCentreNode.AddChild( 'PhysicalGLN' ).Text := DataModule00.DmEmpresaFields.CodigoEAN.Value;  // 2.1.3.1.8
                                    end;

                               // Emisor

                               If   TextoTipoPersona='J'
                               then begin

                                    LegalEntityNode := SellerPartieNode.AddChild( 'LegalEntity' );                                         // 2.1.4.1

                                    LegalEntityNode.AddChild( 'CorporateName' ).Text := DataModule00.DmEmpresaFields.Nombre.Value;
                                    LegalEntityNode.AddChild( 'TradeName' ).Text := 'Comp';                                               // 2.1.4.1.2

                                    SectionNode := LegalEntityNode.AddChild( 'RegistrationData' );                                            // 2.1.4.1.3
                                    SectionNode.AddChild( 'Book' ).Text := DataModule00.DmEmpresaFields.Registro_Libro.Value;
                                    SectionNode.AddChild( 'RegisterOfCompaniesLocation' ).Text := DataModule00.DmEmpresaFields.Registro_RegistroMercantil.Value;
                                    SectionNode.AddChild( 'Sheet' ).Text := DataModule00.DmEmpresaFields.Registro_Hoja.Value;
                                    SectionNode.AddChild( 'Folio' ).Text := DataModule00.DmEmpresaFields.Registro_Folio.Value;
                                    SectionNode.AddChild( 'Section' ).Text := DataModule00.DmEmpresaFields.Registro_Seccion.Value;
                                    SectionNode.AddChild( 'Volume' ).Text := DataModule00.DmEmpresaFields.Registro_Tomo.Value;
                                    SectionNode.AddChild( 'AdditionalRegistrationData' ).Text := DataModule00.DmEmpresaFields.Registro_OtrosDatos.Value;

                                    SectionNode := LegalEntityNode.AddChild( 'AddressInSpain' );
                                    SectionNode.AddChild( 'Address' ).Text := DataModule00.DmEmpresaFields.Domicilio.Value;
                                    SectionNode.AddChild( 'PostCode' ).Text := DataModule00.DmEmpresaFields.CodigoProvincia.Value + DataModule00.DmEmpresaFields.CodigoPostal.Value;
                                    SectionNode.AddChild( 'Town' ).Text := DataModule00.DmEmpresaFields.Localidad.Value;
                                    SectionNode.AddChild( 'Province' ).Text := Provincia.Descripcion( DataModule00.DmEmpresaFields.CodigoPais.Value, DataModule00.DmEmpresaFields.CodigoProvincia.Value, False );
                                    SectionNode.AddChild( 'CountryCode' ).Text := TextoISO3Pais;

                                    SectionNode := LegalEntityNode.AddChild( 'ContactDetails' );
                                    SectionNode.AddChild( 'Telephone' ).Text := DataModule00.DmEmpresaFields.Telefono.Value;
                                    SectionNode.AddChild( 'TeleFax' ).Text := DataModule00.DmEmpresaFields.Fax.Value;
                                    SectionNode.AddChild( 'WebAddress' ).Text := '';                // Pendiente
                                    SectionNode.AddChild( 'ElectronicMail' ).Text := '';
                                    SectionNode.AddChild( 'ContactPersons' ).Text := '';
                                    {
                                    SectionNode.AddChild( 'CnoCnae' ).Text := '';
                                    SectionNode.AddChild( 'INETownCode' ).Text := '';
                                    }
                                    SectionNode.AddChild( 'AdditionalContactDetails' ).Text := '';


                                    end
                               else begin

                                    IndividualNode := SellerPartieNode.AddChild( 'Individual' );
                                    IndividualNode.AddChild( 'Name' ).Text := TextoNombre;
                                    IndividualNode.AddChild( 'FirstSurname' ).Text := TextoPrimerApellido;

                                    SectionNode := IndividualNode.AddChild( 'AddressInSpain' );
                                    SectionNode.AddChild( 'Address' ).Text := DataModule00.DmEmpresaFields.Domicilio.Value;
                                    SectionNode.AddChild( 'PostCode' ).Text := DataModule00.DmEmpresaFields.CodigoProvincia.Value + DataModule00.DmEmpresaFields.CodigoPostal.Value;
                                    SectionNode.AddChild( 'Town' ).Text := DataModule00.DmEmpresaFields.Localidad.Value;
                                    SectionNode.AddChild( 'Province' ).Text := Provincia.Descripcion( DataModule00.DmEmpresaFields.CodigoPais.Value, DataModule00.DmEmpresaFields.CodigoProvincia.Value, False );
                                    SectionNode.AddChild( 'CountryCode' ).Text := TextoISO3Pais;

                                    SectionNode := IndividualNode.AddChild( 'ContactDetails' );
                                    SectionNode.AddChild( 'Telephone' ).Text := DataModule00.DmEmpresaFields.Telefono.Value;
                                    SectionNode.AddChild( 'TeleFax' ).Text := DataModule00.DmEmpresaFields.Fax.Value;

                                    end;

                               TextoTipoPersona := TipoPersona( DmClienteFields.NIF.Value, 'cliente' );
                               TextoTipoResidencia := TipoResidencia( DmClienteFields.CodigoPais.Value );

                               TextoNIF := DmClienteFields.NIF.Value;

                               If   TextoTipoResidencia='R'
                               then begin
                                    TextoISO3Pais := 'ESP';
                                    TextoISO2Pais := 'ES';
                                    If   not ( FacturaAdministracion and not OficinaContableFields.CodigoPaisEnNIF.Value  )   //* 15.09.2016 Ver anterior
                                    then TextoNIF := 'ES' + TextoNIF;
                                    end
                               else With DsPaisFields do
                                      begin
                                      TextoISO3Pais := CodigoISO3.Value;
                                      TextoISO2Pais := CodigoISO2.Value;
                                      end;

                               // Si existe registro auxiliar se considera éste un departamento del comprador y se busca el código EAN
                               // en la ficha el registro, si no existe, se utiliza en última instancia el de la ficha del cliente

                               CodigoEANComprador := '';
                               If   RptCabeceraFields.CodigoRegAuxiliar.Value<>''
                               then If   AuxiliarCliente.Obten( RptCabeceraFields.CodigoPropietario.Value, RptCabeceraFields.CodigoRegAuxiliar.Value )
                                    then CodigoEANComprador := AuxiliarCliente.AuxiliarClienteFields.CodigoEAN.Value;
                               If   CodigoEANComprador=''
                               then CodigoEANComprador := DmClienteFields.Factura_CodigoEAN.Value;

                               BuyerPartieNode := PartiesNode.AddChild( 'BuyerParty' );                                                    // 2.2
                               TaxIdentificationNode := BuyerPartieNode.AddChild( 'TaxIdentification' );                                   // 2.2.1
                               TaxIdentificationNode.AddChild( 'PersonTypeCode' ).Text := TextoTipoPersona;                                // F = Física, J=Jurídica
                               TaxIdentificationNode.AddChild( 'ResidenceTypeCode' ).Text := TextoTipoResidencia;                          // E=Extranjero, R=Residente, U=Residente en la unión Europea
                               TaxIdentificationNode.AddChild( 'TaxIdentificationNumber' ).Text := TextoNIF;

                               If   FacturaAdministracion
                               then begin

                                    AdministrativeCentresNode := BuyerPartieNode.AddChild( 'AdministrativeCentres' );                        // 2.2.3

                                    For I := topOficinaContable to topOrganoProponente do
                                      If   not ( ( I=topOrganoProponente ) and ( RptCabeceraFields.OrganoProponente.Value='' ) )
                                      then begin

                                           case I of
                                             topOficinaContable   : OrganismoPublicoFields := OficinaContableFields;
                                             topOrganoGestor      : OrganismoPublicoFields := OrganoGestorFields;
                                             topUnidadTramitadora : OrganismoPublicoFields := UnidadTramitadoraFields;
                                             topOrganoProponente  : OrganismoPublicoFields := OrganoProponenteFields;
                                             end;

                                           AdministrativeCentreNode := AdministrativeCentresNode.AddChild( 'AdministrativeCentre' );                 // 2.2.3.1

                                           AdministrativeCentreNode.AddChild( 'CentreCode' ).Text := OrganismoPublicoFields.Codigo.Value;            // 2.2.3.1.1
                                           AdministrativeCentreNode.AddChild( 'RoleTypeCode' ).Text := StrIntPadded( I + 1, 2 );                     // 2.2.3.1.2
                                           AdministrativeCentreNode.AddChild( 'Name' ).Text := Copy( OrganismoPublicoFields.Nombre.Value, 1, 40 );   // 2.2.3.1.3

                                           SectionNode := AdministrativeCentreNode.AddChild( 'AddressInSpain' );                                     // 2.2.3.1.6.1

                                           SectionNode.AddChild( 'Address' ).Text := OrganismoPublicoFields.Domicilio.Value;                         // 2.2.3.1.6.1.1
                                           SectionNode.AddChild( 'PostCode' ).Text := OrganismoPublicoFields.CodigoProvincia.Value + OrganismoPublicoFields.CodigoPostal.Value;
                                           SectionNode.AddChild( 'Town' ).Text := OrganismoPublicoFields.Localidad.Value;
                                           SectionNode.AddChild( 'Province' ).Text := Provincia.Descripcion( OrganismoPublicoFields.CodigoPais.Value, OrganismoPublicoFields.CodigoProvincia.Value, False );
                                           SectionNode.AddChild( 'CountryCode' ).Text := Pais.CodigoISO3( OrganismoPublicoFields.CodigoPais.Value, True );
                                           end;

                                    end
                               else If   CodigoEANComprador<>''
                                    then begin

                                         AdministrativeCentresNode := BuyerPartieNode.AddChild( 'AdministrativeCentres' );                      // 2.2.3
                                         AdministrativeCentreNode := AdministrativeCentresNode.AddChild( 'AdministrativeCentre' );              // 2.2.3.1

                                         AdministrativeCentreNode.AddChild( 'CentreCode' ).Text := '1';                                        // 2.2.3.1.1

                                         {
                                         AdministrativeCentreNode.AddChild( 'Name' ).Text := '';             // Usar contactos de la ficha?
                                         AdministrativeCentreNode.AddChild( 'FirstSurname' ).Text := '';
                                         AdministrativeCentreNode.AddChild( 'SecondSurname' ).Text := '';
                                         }

                                         SectionNode := AdministrativeCentreNode.AddChild( 'AddressInSpain' );                                                             // 2.2.3.1.6.1
                                         SectionNode.AddChild( 'Address' ).Text := DmClienteFields.Domicilio.Value;                                                   // 2.2.3.1.6.1.1
                                         SectionNode.AddChild( 'PostCode' ).Text := DmClienteFields.CodigoProvincia.Value + DmClienteFields.CodigoPostal.Value;
                                         SectionNode.AddChild( 'Town' ).Text := DmClienteFields.Localidad.Value;
                                         SectionNode.AddChild( 'Province' ).Text := Provincia.Descripcion( DmClienteFields.CodigoPais.Value, DmClienteFields.CodigoProvincia.Value, False );
                                         SectionNode.AddChild( 'CountryCode' ).Text := TextoISO3Pais;

                                         AdministrativeCentreNode.AddChild( 'PhysicalGLN' ).Text := CodigoEANComprador;                                                    // 2.2.3.1.8

                                         {
                                         SubSectionNode := SectionNode.AddChild( 'OverseasAddress' );
                                         SubSectionNode.AddChild( 'Address' ).Text := DmClienteFields.Domicilio.Value;
                                         SubSectionNode.AddChild( 'PostCodeAndTown' ).Text := DmClienteFields.CodigoProvincia.Value + DmClienteFields.CodigoPostal.Value + ' ' + DmClienteFields.Localidad.Value;
                                         SubSectionNode.AddChild( 'Province' ).Text := Provincia.Descripcion( DmClienteFields.CodigoPais.Value, DmClienteFields.CodigoProvincia.Value, False );
                                         SubSectionNode.AddChild( 'CountryCode' ).Text := TextoISO3Pais;

                                         SubSectionNode := SectionNode.AddChild( 'CentreDescription' );
                                         }

                                         end;

                               // Persona física o jurídica

                               If   TextoTipoPersona='J'
                               then begin

                                    LegalEntityNode := BuyerPartieNode.AddChild( 'LegalEntity' );                                         // 2.2.4.1

                                    LegalEntityNode.AddChild( 'CorporateName' ).Text := DmClienteFields.Nombre.Value;                     // 2.2.4.1.1

                                    If   DmClienteFields.CodigoPais.Value=CodigoEspaña
                                    then begin
                                         SectionNode := LegalEntityNode.AddChild( 'AddressInSpain' );                                         // 2.2.4.1.4.1
                                         SectionNode.AddChild( 'Address' ).Text := DmClienteFields.Domicilio.Value;                           // 2.2.4.1.4.1.1
                                         SectionNode.AddChild( 'PostCode' ).Text := DmClienteFields.CodigoProvincia.Value + DmClienteFields.CodigoPostal.Value;
                                         SectionNode.AddChild( 'Town' ).Text := DmClienteFields.Localidad.Value;
                                         SectionNode.AddChild( 'Province' ).Text := Provincia.Descripcion( DmClienteFields.CodigoPais.Value, DmClienteFields.CodigoProvincia.Value, False );
                                         SectionNode.AddChild( 'CountryCode' ).Text := TextoISO3Pais;
                                         end
                                    else begin
                                         SectionNode := LegalEntityNode.AddChild( 'OverseasAddress' );
                                         SectionNode.AddChild( 'Address' ).Text := DmClienteFields.Domicilio.Value;
                                         SectionNode.AddChild( 'PostCodeAndTown' ).Text := DmClienteFields.CodigoProvincia.Value + DmClienteFields.CodigoPostal.Value + ' ' + DmClienteFields.Localidad.Value;
                                         SectionNode.AddChild( 'Province' ).Text := Provincia.Descripcion( DmClienteFields.CodigoPais.Value, DmClienteFields.CodigoProvincia.Value, False );
                                         SectionNode.AddChild( 'CountryCode' ).Text := TextoISO3Pais;
                                         end;

                                    end
                               else begin

                                    ExtraePartesNombre( TextoTipoPersona, DmClienteFields.Nombre.Value, TextoNombre, TextoPrimerApellido, TextoSegundoApellido );

                                    IndividualNode := BuyerPartieNode.AddChild( 'Individual' );                                           // 2.2.4.2
                                    IndividualNode.AddChild( 'Name' ).Text := TextoNombre;                                                // 2.2.4.2.1
                                    IndividualNode.AddChild( 'FirstSurname' ).Text := TextoPrimerApellido;                                // 2.2.4.2.2

                                    If   DmClienteFields.CodigoPais.Value=CodigoEspaña
                                    then begin
                                         SectionNode := IndividualNode.AddChild( 'AddressInSpain' );
                                         SectionNode.AddChild( 'Address' ).Text := DmClienteFields.Domicilio.Value;
                                         SectionNode.AddChild( 'PostCode' ).Text := DmClienteFields.CodigoProvincia.Value + DmClienteFields.CodigoPostal.Value;
                                         SectionNode.AddChild( 'Town' ).Text := DmClienteFields.Localidad.Value;
                                         SectionNode.AddChild( 'Province' ).Text := Provincia.Descripcion( DmClienteFields.CodigoPais.Value, DmClienteFields.CodigoProvincia.Value, False );
                                         SectionNode.AddChild( 'CountryCode' ).Text := TextoISO3Pais;
                                         end
                                    else begin
                                         SectionNode := IndividualNode.AddChild( 'OverseasAddress' );
                                         SectionNode.AddChild( 'Address' ).Text := DmClienteFields.Domicilio.Value;
                                         SectionNode.AddChild( 'PostCodeAndTown' ).Text := DmClienteFields.CodigoProvincia.Value + DmClienteFields.CodigoPostal.Value + ' ' + DmClienteFields.Localidad.Value;
                                         SectionNode.AddChild( 'Province' ).Text := Provincia.Descripcion( DmClienteFields.CodigoPais.Value, DmClienteFields.CodigoProvincia.Value, False );
                                         SectionNode.AddChild( 'CountryCode' ).Text := TextoISO3Pais;
                                         end;

                                    SectionNode := IndividualNode.AddChild( 'ContactDetails' );
                                    SectionNode.AddChild( 'Telephone' ).Text := DmClienteFields.Telefono.Value;
                                    SectionNode.AddChild( 'TeleFax' ).Text := DmClienteFields.Fax.Value;

                                    end;

                               InvoicesNode := RootNode.AddChild( 'Invoices', '' );
                               InvoiceNode := InvoicesNode.AddChild( 'Invoice' );

                               // InvoiceHeader

                               InvoiceHeaderNode := InvoiceNode.AddChild( 'InvoiceHeader' );
                               With InvoiceHeaderNode do
                                 begin

                                 AddChild( 'InvoiceNumber' ).Text := IntToStr( RptCabeceraFields.NroDocumento.Value );
                                 AddChild( 'InvoiceSeriesCode' ).Text := RptCabeceraFields.Serie.Value;
                                 AddChild( 'InvoiceDocumentType' ).Text := 'FC';   // Factura completa

                                 If   DmSerieFacturacionFields.FacturasRectificativas.Value
                                 then begin

                                      If  Factura.ObtenRegistroComercialFactura( tfFacturaVentas, RptCabeceraFields.Ejercicio.Value, '', RptCabeceraFields.Serie.Value, RptCabeceraFields.NroDocumento.Value, DsFacturaFields )
                                      then begin

                                           DataModule00.PeriodoEjercicio( DsFacturaFields.EjercicioFraRectificada.Value, FechaInicial, FechaFinal );

                                           AddChild( 'InvoiceClass' ).Text := 'OR';
                                           CorrectiveNode := AddChild( 'Corrective' );
                                           CorrectiveNode.AddChild( 'InvoiceNumber' ).Text := IntToStr( DsFacturaFields.NroFacturaRectificada.Value );
                                           CorrectiveNode.AddChild( 'InvoiceSeriesCode' ).Text := DsFacturaFields.SerieFraRectificada.Value;
                                           CorrectiveNode.AddChild( 'ReasonCode' ).Text := StrIntPadded( DsFacturaFields.Razon.Value, 2 );
                                           CorrectiveNode.AddChild( 'ReasonDescription' ).Text := Tasa.TextoRazonRectificacion( DsFacturaFields.Razon.Value );
                                           SectionNode := CorrectiveNode.AddChild( 'TaxPeriod' );
                                           SectionNode.AddChild( 'StartDate' ).Text := DateString( FechaInicial );
                                           SectionNode.AddChild( 'EndDate' ).Text := DateString( FechaFinal );
                                           CorrectiveNode.AddChild( 'CorrectionMethod' ).Text := StrIntPadded( DsFacturaFields.Metodo.Value, 2 );
                                           CorrectiveNode.AddChild( 'CorrectionMethodDescription' ).Text := Tasa.TextoMetodoRectificacion( DsFacturaFields.Metodo .Value );
                                           end
                                      else raise Exception.Create( RsMsg11 );

                                      end
                                 else If   RptCabeceraFields.ServicioPrestadoTemporalmente.Value
                                      then AddChild( 'InvoiceClass' ).Text := 'OC'
                                      else AddChild( 'InvoiceClass' ).Text := 'OO';

                                 end;

                               // InvoiceIssueData

                               InvoiceIssueDataNode := InvoiceNode.AddChild( 'InvoiceIssueData' );                                           // 3.1.2
                               With InvoiceIssueDataNode do
                                 begin
                                 AddChild( 'IssueDate' ).Text := DateString( RptCabeceraFields.FechaDocumento.Value );                       // 3.1.2.1
                                                                                                                                             // 3.1.2.3
                                 SectionNode := AddChild( 'PlaceOfIssue' );
                                 SectionNode.Addchild( 'PostCode' ).Text := DataModule00.DmEmpresaFields.CodigoProvincia.Value + DataModule00.DmEmpresaFields.CodigoPostal.Value;
                                 SectionNode.Addchild( 'PlaceOfIssueDescription' ).Text := DataModule00.DmEmpresaFields.Localidad.Value;

                                 If   RptCabeceraFields.ServicioPrestadoTemporalmente.Value
                                 then begin
                                      SectionNode := AddChild( 'InvoicingPeriod' );                                                              // 3.1.2.4
                                      SectionNode.Addchild( 'StartDate' ).Text := DateString( RptCabeceraFields.InicioPeriodoFacturacion.Value );
                                      SectionNode.Addchild( 'EndDate' ).Text := DateString( RptCabeceraFields.FinPeriodoFacturacion.Value );
                                      end;

                                 AddChild( 'InvoiceCurrencyCode' ).Text := 'EUR';
                                 AddChild( 'TaxCurrencyCode' ).Text := 'EUR';
                                 AddChild( 'LanguageName' ).Text := 'es';

                                 end;

                               // TaxesOutputs

                               TaxesOutputsNode := InvoiceNode.AddChild( 'TaxesOutputs' );

                               With TaxesOutputsNode do
                                 For I := 1 to 6 do
                                   If   RptCabeceraFields.BaseImponible[ I ].Value<>0.0
                                   then begin
                                        TaxNode := AddChild( 'Tax' );
                                        TaxNode.AddChild( 'TaxTypeCode' ).Text := '01';   // IVA
                                        TaxNode.AddChild( 'TaxRate' ).Text := DecimalString( RptCabeceraFields.TipoIVA[ I ].Value );
                                        TaxNode.AddChild( 'TaxableBase' ).AddChild( 'TotalAmount' ).Text := DecimalString( RptCabeceraFields.BaseImponible[ I ].Value );
                                        TaxNode.AddChild( 'TaxAmount' ).AddChild( 'TotalAmount' ).Text := DecimalString( RptCabeceraFields.CuotaIVA[ I ].Value );
                                        TaxNode.AddChild( 'EquivalenceSurcharge' ).Text := DecimalString( RptCabeceraFields.TipoRE[ I ].Value );
                                        TaxNode.AddChild( 'EquivalenceSurchargeAmount' ).AddChild( 'TotalAmount' ).Text := DecimalString( RptCabeceraFields.CuotaRE[ I ].Value );
                                        end;

                               // TaxesWithheld : retenciones

                               If   RptCabeceraFields.ImporteRetencion.Value<>0.0
                               then begin
                                    TaxesWithheldNode := InvoiceNode.AddChild( 'TaxesWithheld' );
                                    With TaxesWithheldNode do
                                      begin
                                      TaxNode := AddChild( 'Tax' );
                                      TaxNode.AddChild( 'TaxTypeCode' ).Text := '04';   // IRPF / Retenciones?
                                      TaxNode.AddChild( 'TaxRate' ).Text := DecimalString( RptCabeceraFields.PorcentajeRetencion.Value );
                                      TaxNode.AddChild( 'TaxableBase' ).AddChild( 'TotalAmount' ).Text := DecimalString( RptCabeceraFields.BaseCalculoRetencion.Value );
                                      TaxNode.AddChild( 'TaxAmount' ).AddChild( 'TotalAmount' ).Text := DecimalString( -RptCabeceraFields.ImporteRetencion.Value );
                                      end;
                                    end;

                               // InvoiceTotals

                               InvoiceTotalsNode := InvoiceNode.AddChild( 'InvoiceTotals' );
                               With InvoiceTotalsNode do
                                 begin
                                 AddChild( 'TotalGrossAmount' ).Text := DecimalString( RptCabeceraFields.NetoArticulos.Value );

                                 If   ( RptCabeceraFields.ImporteDtoPP.Value<>0.0 ) or ( RptCabeceraFields.ImporteDtoES.Value<>0.0 )
                                 then SectionNode := AddChild( 'GeneralDiscounts' );

                                 If   RptCabeceraFields.ImporteDtoPP.Value<>0.0
                                 then begin
                                      SubSectionNode := SectionNode.AddChild( 'Discount');
                                      SubSectionNode.AddChild( 'DiscountReason' ).Text := 'Descuento por pronto pago';
                                      // SubSectionNode.AddChild( 'DiscountRate' ).Text := DecimalString( DescuentoPP.Value, 4 );
                                      SubSectionNode.AddChild( 'DiscountAmount' ).Text := DecimalString( RptCabeceraFields.ImporteDtoPP.Value, 6 );
                                      end;

                                 If   RptCabeceraFields.ImporteDtoES.Value<>0.0
                                 then begin
                                      SubSectionNode := SectionNode.AddChild( 'Discount');
                                      SubSectionNode.AddChild( 'DiscountReason' ).Text := 'Descuento comercial';
                                      // SubSectionNode.AddChild( 'DiscountRate' ).Text := DecimalString( DescuentoES.Value, 4 );
                                      SubSectionNode.AddChild( 'DiscountAmount' ).Text := DecimalString( RptCabeceraFields.ImporteDtoES.Value, 6 );
                                      end;

                                 If   RptCabeceraFields.RecargoFinanciero.Value<>0.0
                                 then begin
                                      SectionNode := AddChild( 'GeneralSurcharges' );
                                      SubSectionNode := SectionNode.AddChild( 'Charge');
                                      SubSectionNode.AddChild( 'ChargeReason' ).Text := 'Recargo financiero';
                                      SubSectionNode.AddChild( 'ChargeAmount' ).Text := DecimalString( RptCabeceraFields.RecargoFinanciero.Value, 6 );
                                      end;

                                 If   RptCabeceraFields.Portes.Value<>0.0
                                 then begin
                                      SectionNode := AddChild( 'GeneralSurcharges' );
                                      SubSectionNode := SectionNode.AddChild( 'Charge');
                                      SubSectionNode.AddChild( 'ChargeReason' ).Text := 'Portes';
                                      SubSectionNode.AddChild( 'ChargeAmount' ).Text := DecimalString( RptCabeceraFields.Portes.Value, 6 );
                                      end;

                                 AddChild( 'TotalGeneralDiscounts' ).Text := DecimalString( RptCabeceraFields.DescuentoPropietario.Value );
                                 AddChild( 'TotalGeneralSurcharges' ).Text := DecimalString( RptCabeceraFields.RecargoFinanciero.Value + RptCabeceraFields.Portes.Value + RptCabeceraFields.TotalEcotasa.Value );
                                 AddChild( 'TotalGrossAmountBeforeTaxes' ).Text := DecimalString( RptCabeceraFields.ImporteNeto.Value );
                                 AddChild( 'TotalTaxOutputs' ).Text := DecimalString( RptCabeceraFields.TotalCuotaIVA.Value + RptCabeceraFields.TotalCuotaRE.Value );
                                 AddChild( 'TotalTaxesWithheld' ).Text := DecimalString( -RptCabeceraFields.ImporteRetencion.Value );
                                 AddChild( 'InvoiceTotal' ).Text := DecimalString( RptCabeceraFields.TotalImporte.Value );
                                 AddChild( 'TotalOutstandingAmount' ).Text := DecimalString( RptCabeceraFields.TotalImporte.Value );
                                 AddChild( 'TotalExecutableAmount' ).Text := DecimalString( RptCabeceraFields.TotalImporte.Value );
                                 end;

                               // Items

                               PrimeraLinea := True;

                               ItemsNode := InvoiceNode.AddChild( 'Items' );                                                                                // 3.1.6
                               With ItemsNode, RptLineasFields do
                                 begin
                                 RptLineasTable.IndexFieldNames := 'NroOperacion;NroPagina;NroLinea';
                                 RptLineasTable.SetRange( [ RptCabeceraFields.NroOperacion.Value, 0, 1 ], [ RptCabeceraFields.NroOperacion.Value, 0, MaxSmallint ] );
                                 RptLineasTable.First;
                                 While not RptLineasTable.Eof do
                                   begin

                                   SectionNode := AddChild( 'InvoiceLine' );
                                   With SectionNode do
                                     begin

                                     // 3.1.6.1.5. ReceiverContractReference  Referencia del contrato del Receptor.

                                     If   FacturaAdministracion and
                                          ( RptCabeceraFields.NumeroContrato.Value<>'' ) { and
                                          PrimeraLinea }
                                     then AddChild( 'ReceiverContractReference' ).Text := RptCabeceraFields.NumeroContrato.Value;

                                     // 3.1.6.1.7. ReceiverTransactionReference Referencia de la Operación, Número de Pedido, Contrato, etc. del Receptor.

                                     If   RptCabeceraFields.ReferenciaOperacion.Value<>''
                                     then AddChild( 'ReceiverTransactionReference' ).Text := RptCabeceraFields.ReferenciaOperacion.Value                      // 3.1.6.1.7
                                     else If   TipoMovimientoOrigen.Value=tmPedidoVenta   // Recuperando el pedido origen (si existe )
                                          then If   DmMovimientoTable.FindKey( [ EjercicioOrigen.Value, NroOperacionOrigen.Value ] )  // Son la tabla y los campos del módulo FacturaVentasModule
                                               then If   DmMovimientoFields.NroDocumentoPropietario.Value<>''
                                                    then begin
                                                         AddChild( 'ReceiverTransactionReference' ).Text := DmMovimientoFields.NroDocumentoPropietario.Value; // 3.1.6.1.7
                                                         AddChild( 'ReceiverTransactionDate' ).Text := DateString( DmMovimientoFields.Fecha.Value );          // 3.1.6.1.8
                                                         end;

                                     // 3.1.6.1.9. FileReference Referencia del expediente.

                                     If   FacturaAdministracion and
                                          ( RptCabeceraFields.NumeroExpediente.Value<>'' ) { and
                                          PrimeraLinea }
                                     then AddChild( 'FileReference' ).Text := RptCabeceraFields.NumeroExpediente.Value;

                                     // Este calculo se introduce para ajustar el precio unitario cuando las unidades por precio son mayores de 1
                                     // No es aconsejable realizar el cálculo del precio unitario dividiendo el precio por las unidades por precio por los problemas de redondeo

                                     If   UnidadesPrecio.Value>1
                                     then begin
                                          If   Cantidad.Value<>0.0
                                          then begin
                                               ImporteBrutoLinea := ImporteBruto.Value;
                                               CantidadLinea := Cantidad.Value;
                                               PrecioLinea := ImporteBrutoLinea / CantidadLinea;
                                               end
                                          else PrecioLinea := 0.0;
                                          end
                                     else PrecioLinea := Precio.Value;

                                     SubSectionNode := AddChild( 'DeliveryNotesReferences' ).AddChild( 'DeliveryNote' );                                    // 3.1.6.1.12
                                     SubSectionNode.AddChild( 'DeliveryNoteNumber' ).Text := SerieDocumento.Value + IntToStr( NroDocumento.Value );         // 3.1.6.1.12.1.1   El albarán
                                     SubSectionNode.AddChild( 'DeliveryNoteDate' ).Text := DateString( RptCabeceraFields.FechaDocumento.Value );            // 3.1.6.1.12.1.2

                                     AddChild( 'ItemDescription' ).Text := Descripcion.Value;                                                               // 3.1.6.1.13
                                     AddChild( 'Quantity' ).Text := DecimalString( Cantidad.Value, DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value ); // 3.1.6.1.14
                                     AddChild( 'UnitPriceWithoutTax' ).Text := DoubleString( PrecioLinea, 6 );                                              // 3.1.6.1.16
                                     // Nuestro ImporteBruto ya incluye los recargos y la ecotasa, por lo que hay que quitarlo
                                     var ImporteBrutoFace := ImporteBruto.Value - Recargo.Value - ImportePuntoVerde.Value;
                                     AddChild( 'TotalCost' ).Text := DecimalString( ImporteBrutoFace, 6 );                                                  // 3.1.6.1.17

                                     // Descuento

                                     If   ImporteDescuento.Value<>0.0
                                     then begin
                                          SubSectionNode := AddChild( 'DiscountsAndRebates' );
                                          SubSection1Node := SubSectionNode.AddChild( 'Discount' );
                                          With SubSection1Node do
                                            begin
                                            AddChild( 'DiscountReason' ).Text := RsMotivoDtoRecargo;
                                            AddChild( 'DiscountRate' ).Text := DecimalString( Descuento.Value, 4 );
                                            AddChild( 'DiscountAmount' ).Text := DecimalString( ImporteDescuento.Value, 6 );
                                            end;
                                          end;

                                     If   ( Recargo.Value<>0.0 ) or
                                          ( ImportePuntoVerde.Value<>0.0 )
                                     then SubSectionNode := AddChild( 'Charges' );

                                     // Recargo

                                     If   Recargo.Value<>0.0
                                     then begin
                                          SubSection1Node := SubSectionNode.AddChild( 'Charge' );
                                          With SubSection1Node do
                                            begin
                                            AddChild( 'ChargeReason' ).Text := RsMotivoDtoRecargo;
                                            AddChild( 'ChargeAmount' ).Text := DecimalString( Recargo.Value, 6 );
                                            end;
                                          end;

                                     // Ecotasa

                                     If   ImportePuntoVerde.Value<>0.0
                                     then begin
                                          SubSection2Node := SubSectionNode.AddChild( 'Charge' );
                                          With SubSection2Node do
                                            begin
                                            AddChild( 'ChargeReason' ).Text := RsEcotasa;
                                            AddChild( 'ChargeAmount' ).Text := DecimalString( ImportePuntoVerde.Value, 6 );
                                            end;
                                          end;

                                     AddChild( 'GrossAmount' ).Text := DecimalString( ImporteNeto.Value, 6 );                                                // 3.1.6.1.20

                                     SubSectionNode := AddChild( 'TaxesOutputs' ).AddChild( 'Tax' );
                                     With SubSectionNode do
                                       begin
                                       AddChild( 'TaxTypeCode' ).Text := '01';   // IVA
                                       AddChild( 'TaxRate' ).Text := DecimalString( TipoIVA.Value, 2 );
                                       AddChild( 'TaxableBase' ).AddChild( 'TotalAmount' ).Text := DecimalString( Redondea( ImporteNeto.Value ) );           // Redondeado para que no se queje el FACe
                                       AddChild( 'TaxAmount' ).AddChild( 'TotalAmount' ).Text := DecimalString( CuotaIVA.Value );
                                       end;
                                                                                                                                                            // 3.1.6.1.23
                                     If   RptCabeceraFields.Subvencionada.Value
                                     then begin
                                          LineItemPeriodNode := AddChild( 'LineItemPeriod' );
                                          LineItemPeriodNode.AddChild( 'StartDate' ).Text := DateString( RptCabeceraFields.Fecha1.Value );                   // 3.1.6.1.23.1
                                          LineItemPeriodNode.AddChild( 'EndDate' ).Text := DateString( IncMonth( RptCabeceraFields.Fecha1.Value, 12 ) );     // 3.1.6.1.23.2
                                          end;

                                     CodigoEANArticulo := CodigoArticulo.Value;

                                     If   Articulo.Obten( CodigoArticulo.Value, DsArticuloFields )
                                     then If   DsArticuloFields.CodigoBarras.Value<>''
                                          then CodigoEANArticulo := DsArticuloFields.CodigoBarras.Value;

                                     AddChild( 'ArticleCode' ).Text := CodigoEANArticulo;

                                     end;

                                   PrimeraLinea := False;

                                   RptLineasTable.Next;
                                   end;

                                 end;

                               // PaymentDetails

                               If   RelacionEfectos.NroEfectos>0
                               then begin
                                    PaymentDetailsNode := InvoiceNode.AddChild( 'PaymentDetails' );
                                    With PaymentDetailsNode do
                                      begin

                                      If   DmClienteFields.Cobro_CodigoEntidad.Value=''
                                      then IBANCliente := ''
                                      else begin
                                           IBANCliente := TextoISO2Pais + '00' + DmClienteFields.Cobro_CodigoEntidad.Value + DmClienteFields.Cobro_CodigoSucursal.Value + DmClienteFields.Cobro_DC.Value + DmClienteFields.Cobro_Cuenta.Value;
                                           CalculaDCIBAN( IBANCliente );
                                           end;

                                      FormaCobro.Obten( DmClienteFields.Cobro_FormaCobro.Value, DsFormaCobroFields );

                                      For I := 1 to RelacionEfectos.NroEfectos do
                                        begin
                                        InstallmentNode := AddChild( 'Installment' );
                                        With InstallmentNode do
                                          begin
                                          AddChild( 'InstallmentDueDate' ).Text := DateString( RelacionEfectos.FechaVencimiento[ I ] );
                                          AddChild( 'InstallmentAmount' ).Text := DecimalString( RelacionEfectos.Importe[ I ] );
                                          AddChild( 'PaymentMeans' ).Text := StrIntPadded( DsFormaCobroFields.CodigoFacturaE.Value, 2 );
                                          If   IBANCliente<>''
                                          then begin
                                               AccountToBeCreditedNode := AddChild( 'AccountToBeCredited' );
                                               AccountToBeCreditedNode.AddChild( 'IBAN' ).Text := IBANCliente;
                                               AccountToBeCreditedNode.AddChild( 'BankCode' ).Text := DmClienteFields.Cobro_CodigoEntidad.Value;
                                               AccountToBeCreditedNode.AddChild( 'BranchCode' ).Text := DmClienteFields.Cobro_CodigoSucursal.Value;
                                               end;
                                          end;

                                        end;

                                      end;

                                    end;

                                // AdditionalData

                                If   RptCabeceraFields.Subvencionada.Value
                                then begin
                                     AdditionalDataNode := InvoiceNode.AddChild( 'AdditionalData' );             // 3.1.9
                                     AdditionalDataNode.AddChild( 'InvoiceAdditionalInformation' ).Text := Format( RsMsg24, [ DecimalString( RptCabeceraFields.ImporteSubvencion.Value ) ] );
                                     end;

                                XMLDOMDocument := TElXMLDOMDocument.Create;
                                MemoryStream := TStringStream.Create( '', TEncoding.UTF8 );

                                try

                                  XMLDocument.SaveToStream( MemoryStream );
                                  MemoryStream.Position := 0;
                                  XMLDOMDocument.LoadFromStream( MemoryStream );

                                  XMLDOMDocument.Version := '1.0';

                                  // <?xml version="1.0" encoding="UTF-8"?>

                                  { Versión de la documentación de SecureBlackbox para firmar FacturaE

                                  procedure SignFactura(XMLDocument : TElXMLDOMDocument; Cert : TElX509Certificate);
                                  var
                                  Signer : TElXMLSigner;
                                  XAdESSigner: TElXAdESSigner;
                                  X509KeyInfoData: TElXMLKeyInfoX509Data;
                                  DataFormat : TElXMLDataObjectFormat;
                                  Ref : TElXMLReference;
                                  URL : string;
                                  Buf : ByteArray;
                                  k : Integer;
                                  begin
                                  Signer := TElXMLSigner.Create(nil);
                                  XAdESSigner := TElXAdESSigner.Create(nil);
                                  X509KeyInfoData := TElXMLKeyInfoX509Data.Create(false);
                                  try
                                  Signer.XAdESProcessor := XAdESSigner;
                                  Signer.SignatureMethodType := xmtSig;
                                  Signer.SignatureMethod := xsmRSA_SHA1;
                                  Signer.CanonicalizationMethod := xcmCanon;
                                  Signer.IncludeKey := true;

                                  k := Signer.References.Add;
                                  Ref := Signer.References[k];
                                  Ref.DigestMethod := xdmSHA1;
                                  Ref.ID := 'Ref1';
                                  Ref.URI := '';
                                  Ref.URINode := XMLDocument.DocumentElement;
                                  Ref.TransformChain.AddEnvelopedSignatureTransform();

                                  Signer.UpdateReferencesDigest();

                                  k := Signer.References.Add;
                                  Ref := Signer.References[k];
                                  Ref.DigestMethod := xdmSHA1;
                                  Ref.URI := '#Certificate1';

                                  XAdESSigner.XAdESVersion := XAdES_v1_3_2;
                                  XAdESSigner.Included := [xipSignerRole];
                                  XAdESSigner.SigningTime := UTCNow;
                                  XAdESSigner.SignerRole.ClaimedRoles.AddText(XAdESSigner.XAdESVersion, XMLDocument, 'emisor');

                                  URL := 'http://www.facturae.es/politica_de_firma_formato_facturae/politica_de_firma_formato_facturae_v3_1.pdf';
                                  XAdESSigner.PolicyId.SigPolicyId.Identifier := URL;
                                  XAdESSigner.PolicyId.SigPolicyId.IdentifierQualifier := xqtNone;
                                  XAdESSigner.PolicyId.SigPolicyId.Description := 'Política de Firma FacturaE v3.2';
                                  XAdESSigner.PolicyId.SigPolicyHash.DigestMethod := DigestMethodToURI(xdmSHA1);
                                  // uncomment to calculate a digest value or use precalculated value
                                  //Buf := DownloadData(URL);
                                  //XAdESSigner.PolicyId.SigPolicyHash.DigestValue := CalculateDigest(@Buf[0], Length(Buf), xdmSHA1);
                                  XAdESSigner.PolicyId.SigPolicyHash.DigestValue := ConvertFromBase64String('Ohixl6upD6av8N7pEvDABhEL6hM=');

                                  XAdESSigner.SigningCertificates := TElMemoryCertStorage.Create(nil);
                                  XAdESSigner.OwnSigningCertificates := true;
                                  XAdESSigner.SigningCertificates.Add(Cert);

                                  XAdESSigner.Generate(XAdES_EPES);

                                  XAdESSigner.QualifyingProperties.XAdESPrefix := 'etsi';

                                  DataFormat := TElXMLDataObjectFormat.Create(XAdESSigner.XAdESVersion);
                                  DataFormat.Description := 'Factura electrónica';
                                  DataFormat.MimeType := 'text/xml';
                                  DataFormat.ObjectReference := '#Ref1';
                                  XAdESSigner.QualifyingProperties.SignedProperties.SignedDataObjectProperties.DataObjectFormats.Add(DataFormat);

                                  X509KeyInfoData.IncludeKeyValue := true;
                                  X509KeyInfoData.IncludeDataParams := [xkidX509Certificate];
                                  X509KeyInfoData.Certificate := Cert;
                                  Signer.KeyData := X509KeyInfoData;

                                  Signer.GenerateSignature;
                                  Signer.Signature.KeyInfo.ID := 'Certificate1';

                                  Signer.SaveEnveloped(XMLDocument.DocumentElement);
                                  finally
                                  FreeAndNil(X509KeyInfoData);
                                  FreeAndNil(Signer);
                                  FreeAndNil(XAdESSigner);
                                  end;
                                  end;

                                  }

                                  If   TipoFichero=tfeFacturaEFirma
                                  then Certificate := CertStorage.Certificates[ CertIndex ];

                                  If   ( TipoFichero=tfeFacturaEFirma ) and
                                       not Configuracion.ParametrosSeguridadRec.UsarAutoFirma
                                  then begin

                                       X509KeyData := TElXMLKeyInfoX509Data.Create( False );
                                       X509KeyData.Certificate := Certificate;

                                       //* 07.04.2016 Quito el número de serie del certificado porque FACe no es capaz de validar los últimos certificados por la
                                       //             longitud del mismo. En las pruebas que hemos hecho parece no ser necesario incluirlo.

                                       X509KeyData.IncludeDataParams :=  X509KeyData.IncludeDataParams - [ xkidX509IssuerSerial ];

                                       // --

                                       XAdESSigner := TElXAdESSigner.Create( nil );
                                       With XAdESSigner do
                                         begin
                                         Included := [ xipSignerRole ];
                                         SigningCertificates := CertStorage;
                                         XAdESVersion := XAdES_v1_3_2; // XAdES_v1_2_2;
                                         XAdESForm := XAdES_EPES;
                                         end;

                                       // --

                                       XMLSigner := TElXMLSigner.Create( nil );
                                       With XMLSigner do
                                         begin
                                         IncludeKey := True;
                                         SignatureType := xstEnveloped;
                                         CanonicalizationMethod := xcmCanon;
                                         SignatureCompliance := xscDSIG;
                                         SignatureMethodType := xmtSig;
                                         SignatureMethod := xsmRSA_SHA1;
                                         MACMethod := xmmHMAC_SHA1;

                                         KeyData := X509KeyData;
                                         XAdESProcessor := XAdESSigner;
                                         end;

                                       // --

                                       ReferenceList := TElXMLReferenceList.Create;

                                       try

                                         Element := TElXMLDOMElement( XMLDOMDocument.FirstChild );

                                         // Referencia al nodo de la firma

                                         Reference := TElXMLReference.Create;
                                         With Reference do
                                           begin
                                           DigestMethod := xdmSHA1;
                                           URINode := Element;
                                           URI := '';
                                           TransformChain.Add( TElXMLEnvelopedSignatureTransform.Create );
                                           end;

                                         ReferenceList.Add( Reference );

                                         // Referencia a KeyInfo

                                         KeyInfoID := 'Certificate' + IntToStr( 1 + Random( 99999 ) );

                                         Reference := TElXMLReference.Create;
                                         With Reference do
                                           begin
                                           DigestMethod := xdmSHA1;
                                           URINode := Element;
                                           URI := '#' + KeyInfoID;
                                           // Reference.TransformChain.Add( TElXMLEnvelopedSignatureTransform.Create );
                                           end;

                                         ReferenceList.Add( Reference );

                                         XMLSigner.References := ReferenceList;
                                         SignNode := XMLDOMDocument.FirstChild;

                                         // Política de firma

                                         With XAdESSigner do
                                           begin

                                           With PolicyId do
                                             begin


                                             {
                                             If   FacturaAdministracion
                                             then begin
                                                  SigPolicyId.Identifier := 'urn:oid:2.16.724.1.3.1.1.2.1.9';
                                                  SigPolicyId.Description := 'Política de firma electrónica para la Administración General del Estado';
                                                  SigPolicyHash.DigestMethod := 'http://www.w3.org/2000/09/xmldsig#sha1';
                                                  SigPolicyHash.DigestValue := ConvertFromBase64String( 'G7roucf600+f03r/o0bAOQ6WAs0=' );
                                                  // 'https://sede.060.gob.es/politica_de_firma_anexo_1.pdf';
                                                  end
                                             else begin
                                             }
                                                  SigPolicyId.Identifier := 'http://www.facturae.es/politica_de_firma_formato_facturae/politica_de_firma_formato_facturae_v3_1.pdf';
                                                  SigPolicyId.Description := 'facturae31';
                                                  SigPolicyHash.DigestMethod := DigestMethodToURI( xdmSHA1 ); // 'http://www.w3.org/2000/09/xmldsig#sha1';
                                                  SigPolicyHash.DigestValue := ConvertFromBase64String( 'Ohixl6upD6av8N7pEvDABhEL6hM=' );
                                             {
                                                  end;
                                             }

                                             // SigPolicyHash.DigestValue := ConvertFromBase64String( 'xmfh8D/Ec/hHeE1IB4zPd61zHIY=' );
                                             // ToCryptoBinary(BytesOfString(DigestToBinary(X509KeyData.Certificate.GetHashSHA1)));
                                             end;

                                           SignerRole.ClaimedRoles.AddText( XAdES_v1_3_2, XMLDOMDocument, 'supplier' );
                                           SigningTime := LocalTimeToUTCTime( Now );
                                           Generate;
                                           QualifyingProperties.XAdESPrefix := 'etsi';
                                           end;

                                         // ..

                                         With XMLSigner do
                                           begin
                                           UpdateReferencesDigest;
                                           GenerateSignature;
                                           Signature.SignaturePrefix := 'ds';
                                           Signature.KeyInfo.ID := KeyInfoID;
                                           end;

                                         SignNode := XMLDOMDocument.FirstChild;

                                         XMLSigner.Save( SignNode );

                                       finally
                                         X509KeyData.Free;
                                         ReferenceList.Free;
                                         SignaturePolicyId.Free;
                                         XMLSigner.Free;
                                         XAdESSigner.Free;
                                         end;

                                       end;

                                  MemoryStream.Clear;

                                  XMLDOMDocument.SaveToStream( MemoryStream ); // , xcmNone, AEncoding );

                                  MemoryStream.SaveToFile( PathFicheroAlmacen );

                                  If   ( TipoFichero=tfeFacturaEFirma ) and
                                       Configuracion.ParametrosSeguridadRec.UsarAutoFirma
                                  then begin
                                       var ProcessInformation : TProcessInformation;
                                       var CommandLine := Format( 'autofirmacommandline sign -i "%s" -o "%s" -store windows -alias "%s" -format facturae -config "signatureProductionCity=%s\nsignatureProductionProvince=%s\nsignatureProductionPostalCode=%s\nsignatureProductionCountry=%s"',
                                                                  [ PathFicheroAlmacen,
                                                                    PathFicheroAlmacen,
                                                                    Certificate.FriendlyName,
                                                                    DataModule00.DmEmpresaFields.Localidad.Value,
                                                                    Provincia.Descripcion( DataModule00.DmEmpresaFields.CodigoPais.Value,
                                                                                           DataModule00.DmEmpresaFields.CodigoProvincia.Value,
                                                                                           False ),
                                                                    DataModule00.DmEmpresaFields.CodigoProvincia.Value + DataModule00.DmEmpresaFields.CodigoPostal.Value,
                                                                    Pais.Descripcion( DataModule00.DmEmpresaFields.CodigoPais.Value )
                                                                  ] );
                                       If   not ProcessExecute( ProcessInformation, CommandLine, '', SW_HIDE )
                                       then Certificados.CompruebaErrorAutoFirma( GetLastError );

                                       end;



                                     finally
                                       MemoryStream.Free;
                                       XMLDOMDocument.Free;
                                       end;

                               PathFichero := PathFicheroAlmacen;

                               If   Assigned( ProcessFrame )
                               then ProcessFrame.AddMsg( ntLinkInformation, Format( RsMsg13, [ PathFichero, ExtractFileName( PathFichero ) ] ) );

                             except on E : Exception do
                               begin
                               ShowException( E );
                               // ShowNotification( ntError, RsMsg10, 'Error : ' + E.Message );
                               raise;
                               end;
                             end;

                           end;

         end;

       end;
end;

procedure TFacturaElectronicaDataModule.CreaRegistroFacturaElectronica( Tipo           : TTipoRegistroFacturaElectronica;
                                                                        Propietario,
                                                                        Serie          : String;
                                                                        NroFactura     : Integer;
                                                                        NIFPropietario : String;
                                                                        FechaDocumento : TDate;
                                                                        Importe        : Decimal );
begin
     // Tipo;Ejercicio;Propietario;Serie;NroFactura

     DmRegistroFacturaElectronicaTable.IndexFieldNames := 'Tipo;Ejercicio;Propietario;Serie;NroFactura';

     If   DmRegistroFacturaElectronicaTable.FindKey( [ Ord( Tipo ), ApplicationContainer.Ejercicio, Propietario, Serie, NroFactura ] )
     then DmRegistroFacturaElectronicaTable.Edit
     else DmRegistroFacturaElectronicaTable.Append;

     DmRegistroFacturaElectronicaFields.Tipo.Value := Ord( Tipo );
     DmRegistroFacturaElectronicaFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
     DmRegistroFacturaElectronicaFields.Propietario.Value := Propietario;
     DmRegistroFacturaElectronicaFields.Serie.Value := Serie;
     DmRegistroFacturaElectronicaFields.NroFactura.Value := NroFactura;
     DmRegistroFacturaElectronicaFields.NIFPropietario.Value := NIFPropietario;
     DmRegistroFacturaElectronicaFields.Fecha.Value := FechaDocumento;
     DmRegistroFacturaElectronicaFields.Importe.Value := Importe;
     DmRegistroFacturaElectronicaFields.CodigoUsuario.Value := CodigoUsuarioActual;
     DmRegistroFacturaElectronicaFields.FechaRegistro.Value := Now;

     DmRegistroFacturaElectronicaTable.Post;

end;

procedure TFacturaElectronicaDataModule.DoOnLeeFactura( FilePathAndName                   : String;
                                                        InsertarLineasSinRegistroArticulo : Boolean = False );

type TTaxRecord = record
       TaxRate,
       TaxableBaseAmount,
       TaxAmount,
			 EquivalenceSurcharge,
			 EquivalenceSurchargeAmount : Decimal;
       end;

     TTaxesArray = array of TTaxRecord;

const VersionFacturaE = '3.3';

var   TaxesOutputArray,
      TaxesWithheldArray : TTaxesArray;

      EsUnAcreedor : Boolean;

procedure ReadTaxIdentification(     PartyNode               : IXMLNode;
                                 var PersonTypeCode          : String;
                                 var ResidenceTypeCode       : String;
                                 var TaxIdentificationNumber : String );
begin
     var TaxIdentificationNode := PartyNode.ChildNodes.FindNode( 'TaxIdentification' );

     PersonTypeCode := TaxIdentificationNode.ChildValues [ 'PersonTypeCode' ];
     ResidenceTypeCode := TaxIdentificationNode.ChildValues [ 'ResidenceTypeCode' ];
     TaxIdentificationNumber := TaxIdentificationNode.ChildValues [ 'TaxIdentificationNumber' ];
end;

procedure ReadOverseasAddress(     RootNode        : IXMLNode;
                                   AdressNodeName  : String;
                               var Address         : String;
                               var PostCodeAndTown : String;
                               var Province        : String;
                               var CountryCode     : String );
begin

      var OverseasAddressNode := RootNode.ChildNodes.FindNode( AdressNodeName );

      Address := OverseasAddressNode.ChildValues [ 'Address' ];
						PostCodeAndTown := OverseasAddressNode.ChildValues [ 'PostCodeAndTown' ];
						Province := OverseasAddressNode.ChildValues [ 'Province' ];
						CountryCode := OverseasAddressNode.ChildValues [ 'CountryCode' ];

end;

procedure ReadInvoice( InvoicesNode : IXMLNode );

function GetTaxTotalAmount( ATaxNode : IXMLNode;
                            NodeName : String ) : Decimal;
begin
     var AmountNode := ATaxNode.ChildNodes.FindNode( NodeName );
     If   Assigned( AmountNode )
     then Result := StrToExtended( AmountNode.ChildValues[ 'TotalAmount' ] )
     else Result := 0.0;
end;

function GetDecimalValue( ARootNode : IXMLNode;
                          ANodeName : String ) : Decimal;
begin
     var ValueNode := ARootNode.ChildNodes.FindNode( ANodeName );
     If   Assigned( ValueNode )
     then Result := StrToExtended( ValueNode.NodeValue )
     else Result := 0.0;
end;

function GetDateValue( ARootNode : IXMLNode;
                       ANodeName : String ) : TDate;
begin
     var ValueNode := ARootNode.ChildNodes.FindNode( ANodeName );
     If   Assigned( ValueNode )
     then Result := StrToDate( ValueNode.NodeValue, dfSQL )
     else Result := 0;
end;

procedure ReadTaxRecord(     ATaxNode   : IXMLNode;
                         var ATaxRecord : TTaxRecord );
begin
     With ATaxRecord do
       begin
       TaxRate := StrToExtended( ATaxNode.ChildValues[ 'TaxRate' ] );
       TaxableBaseAmount := GetTaxTotalAmount( ATaxNode, 'TaxableBase' );
       TaxAmount := GetTaxTotalAmount( ATaxNode, 'TaxAmount' );
       EquivalenceSurcharge := GetDecimalValue( ATaxNode, 'EquivalenceSurcharge' );
       EquivalenceSurchargeAmount := GetTaxTotalAmount( ATaxNode, 'EquivalenceSurchargeAmount' );
       end;
end;

procedure ReadTaxes(     ARootNode   : IXMLNode;
                         ANodeName   : String;
                     var ATaxesArray : TTaxesArray );
begin
     var TaxesNode := ARootNode.ChildNodes.FindNode( ANodeName );
     If   Assigned( TaxesNode )
     then begin
          var TaxNodesCount := TaxesNode.ChildNodes.Count;
          SetLength( ATaxesArray, TaxNodesCount );
          For var TaxIndex := 0 to TaxNodesCount - 1 do
             begin
             var TaxNode := TaxesNode.ChildNodes.Get( TaxIndex );
             If   Assigned( TaxNode )
             then ReadTaxRecord( TaxNode, ATaxesArray[ TaxIndex ] );
             end;
          end
     else ATaxesArray := [];
end;

begin

     var InvoiceNode := InvoicesNode.ChildNodes.FindNode( 'Invoice' );

     var InvoiceHeaderNode := InvoiceNode.ChildNodes.FindNode( 'InvoiceHeader' );

     var InvoiceNumber := StrToInt( InvoiceHeaderNode.ChildValues [ 'InvoiceNumber' ] );
     var InvoiceSeriesCode:= InvoiceHeaderNode.ChildValues [ 'InvoiceSeriesCode' ];
     var InvoiceDocumentType := InvoiceHeaderNode.ChildValues [ 'InvoiceDocumentType' ];
     var InvoiceClass := InvoiceHeaderNode.ChildValues [ 'InvoiceClass' ];

     var InvoiceIssueDataNode := InvoiceNode.ChildNodes.FindNode( 'InvoiceIssueData' );

     var IssueDate : TDate := GetDateValue( InvoiceIssueDataNode, 'IssueDate' );
     var OperationDate : TDate := GetDateValue(  InvoiceIssueDataNode, 'OperationDate' );
     //..
     var InvoiceCurrencyCode := InvoiceIssueDataNode.ChildValues [ 'InvoiceCurrencyCode' ];

     var SerieNroFactura := IntToStr( InvoiceNumber );
     If   not VarIsNull( InvoiceSeriesCode )
     then SerieNroFactura := VarToStr( InvoiceSeriesCode ) + SerieNroFactura;

     If   not EjercicioActual( IssueDate )
     then begin
          ShowNotification( ntStop, Format( RsMsg6, [ StrFormatDate( IssueDate ), SerieNroFactura ] ) );
          Abort;
          end;

     ReadTaxes( InvoiceNode, 'TaxesOutputs', TaxesOutputArray );
     ReadTaxes( InvoiceNode, 'TaxesWithheld', TaxesWithheldArray );

     // Invoice totals

     var InvoiceTotalsNode := InvoiceNode.ChildNodes.FindNode( 'InvoiceTotals' );

       var TotalGrossAmount := GetDecimalValue( InvoiceTotalsNode, 'TotalGrossAmount' );
       var TotalGeneralDiscounts := GetDecimalValue( InvoiceTotalsNode, 'TotalGeneralDiscounts' );
       var TotalGeneralSurcharges := GetDecimalValue( InvoiceTotalsNode, 'TotalGeneralSurcharges' );
       var TotalGrossAmountBeforeTaxes := GetDecimalValue( InvoiceTotalsNode, 'TotalGrossAmountBeforeTaxes' );
       var TotalTaxOutputs := GetDecimalValue( InvoiceTotalsNode, 'TotalTaxOutputs' );
       var TotalTaxesWithheld := GetDecimalValue( InvoiceTotalsNode, 'TotalTaxesWithheld' );
       var InvoiceTotal := GetDecimalValue( InvoiceTotalsNode, 'InvoiceTotal' );
       var TotalOutstandingAmount := GetDecimalValue( InvoiceTotalsNode, 'TotalOutstandingAmount' );
       var TotalExecutableAmount := GetDecimalValue( InvoiceTotalsNode, 'TotalExecutableAmount' );

     // Compruebo que no exista la factura

     // Ejercicio;Proveedor;SerieNroFactura

     If   DmFacturaComprasTable.FindKey( [ ApplicationContainer.Ejercicio, DsProveedorFields.Codigo.Value, SerieNroFactura ] )
     then begin
          ShowNotification( ntStop, Format( RsMsg20, [ SerieNroFactura, DsProveedorFields.Codigo.Value + ', ' + DsProveedorFields.Nombre.Value ] ) );
          Abort;
          end;

     EnterpriseDataModule.StartTransaction( [ DmMovimientoTable,
                                              DmGrupoLineaMovimientoTable,
                                              DmLineaMovimientoTable ],
                                              { Notify } False );

                                              // Añadir el resto de tablas afectadas

     try

       // Creo la cabecera

       DmMovimientoTable.Append;

       DmMovimientoFields.TipoMovimiento.Value := tmCompra;
       DmMovimientoFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
       DmMovimientoFields.Serie.Value := InvoiceSeriesCode;
       DmMovimientoFields.Propietario.Value := DsProveedorFields.Codigo.Value;
       DmMovimientoFields.Fecha.Value := IssueDate;
       DmMovimientoFields.NroDocumento.Value := Movimiento.ProximoDocumento( DmMovimientoFields );
       DmMovimientoFields.NroOperacion.Value := Movimiento.ProximaOperacion;
       DmMovimientoFields.Origen.Value := omFacturaElectronica;

       DmMovimientoTable.Post;

       // Empieza el tratamiento de las líneas

       var NroLineaActual := 1;
       var ItemsNode := InvoiceNode.ChildNodes.FindNode( 'Items' );

       var ItemsCount := ItemsNode.ChildNodes.Count;

       For var ItemIndex := 0 to ItemsCount - 1 do
          begin

          var ItemNode := ItemsNode.ChildNodes.Get( ItemIndex );
          If   Assigned( ItemNode )
          then begin

               var IssuerContractReference := ItemNode.ChildValues [ 'IssuerContractReference' ];
               var IssuerContractDate : TDate := GetDateValue( ItemNode, 'IssuerContractDate'  );
               var IssuerTransactionReference := ItemNode.ChildValues [ 'IssuerTransactionReference' ];
               var IssuerTransactionDate : TDate := GetDateValue( ItemNode, 'IssuerTransactionDate' );
               var ReceiverContractReference := ItemNode.ChildValues [ 'ReceiverContractReference' ];
               var ReceiverContractDate : TDate := GetDateValue( ItemNode, 'ReceiverContractDate' );
               var ReceiverTransactionReference := ItemNode.ChildValues [ 'ReceiverTransactionReference' ];
               var ReceiverTransactionDate : TDate := GetDateValue( ItemNode, 'ReceiverTransactionDate' );
               var FileReference := ItemNode.ChildValues [ 'FileReference' ];
               var FileDate : TDate := GetDateValue( ItemNode, 'FileDate' );
               var SequenceNumber := GetDecimalValue( ItemNode, 'SequenceNumber' );

               {
               <DeliveryNotesReferences>
               <DeliveryNote>
               <DeliveryNoteNumber>132413842</DeliveryNoteNumber>
               <DeliveryNoteDate>2010-03-10</DeliveryNoteDate>
               </DeliveryNote>
               <DeliveryNote>
               <DeliveryNoteNumber>987673211</DeliveryNoteNumber>
               <DeliveryNoteDate>2010-03-09</DeliveryNoteDate>
               </DeliveryNote>
               </DeliveryNotesReferences>
               }

               var ItemDescription := ItemNode.ChildValues [ 'ItemDescription' ];
               var Quantity := GetDecimalValue( ItemNode, 'Quantity' );
               var UnitOfMeasure := ItemNode.ChildValues [ 'UnitOfMeasure' ];
               var UnitPriceWithoutTax := GetDecimalValue( ItemNode, 'UnitPriceWithoutTax' );
               var TotalCost := GetDecimalValue( ItemNode, 'TotalCost' );

               var DiscountReason : String := '';
               var DiscountRate : Decimal := 0.0;
               var DiscountAmount : Decimal := 0.0;

               // No se contempla (de momento) que exista más de un descuento

               var DiscountsAndRebatesNode := ItemNode.ChildNodes.FindNode( 'DiscountsAndRebates' );
               If   Assigned( DiscountsAndRebatesNode )
               then begin

                    var DiscountNode := DiscountsAndRebatesNode.ChildNodes.FindNode( 'Discount' );

                    DiscountReason := DiscountNode.ChildValues [ 'DiscountReason' ];
                    DiscountRate := GetDecimalValue( DiscountNode, 'DiscountRate' );
                    DiscountAmount := GetDecimalValue( DiscountNode, 'DiscountAmount' );

                    end;

               var ChargeReason : String := '';
               var ChargeAmount : Decimal := 0.0;

               // Puede haber más de un recargo, en concreto ecotasas. De momento no se contempla.

               var ChargesAndRebatesNode := ItemNode.ChildNodes.FindNode( 'Charges' );
               If   Assigned( ChargesAndRebatesNode )
               then begin

                    var ChargeNode := ChargesAndRebatesNode.ChildNodes.FindNode( 'Charge' );

                    ChargeReason := ChargeNode.ChildValues [ 'ChargeReason' ];
                    ChargeAmount := GetDecimalValue( ChargeNode, 'ChargeAmount' );

                    end;

               var GrossAmount := GetDecimalValue( ItemNode, 'GrossAmount' );

               var TaxesItemtArray : TTaxesArray;

               ReadTaxes( ItemNode, 'TaxesOutputs', TaxesItemtArray );

               var ArticleCode := ItemNode.ChildValues [ 'ArticleCode' ];

               // --> Creación del registro de línea

               var CodigoArticulo := Articulo.ReferenciaProveedor( DsProveedorFields.Codigo.Value, ArticleCode, { CodigoInterno } False );
               If   not Articulo.Obten( CodigoArticulo, DsArticuloFields )
               then If   InsertarLineasSinRegistroArticulo
                    then Articulo.CreaArticuloManual( CodigoArticulo, DsArticuloFields )
                    else begin
                         ShowNotification( ntStop, Format( RsMsg8, [ CodigoArticulo ] ) );
                         Abort;
                         end;

               DmLineaMovimientoTable.Append;

               DmLineaMovimientoFields.Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
               DmLineaMovimientoFields.Fecha.Value := DmMovimientoFields.Fecha.Value;
               DmLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
               DmLineaMovimientoFields.NroLinea.Value := NroLineaActual;

               DmLineaMovimientoFields.CodigoArticulo.Value := CodigoArticulo;
               DmLineaMovimientoFields.Descripcion.Value := ItemDescription;
               DmLineaMovimientoFields.Cantidad.Value := Quantity;
               DmLineaMovimientoFields.Precio.Value := UnitPriceWithoutTax;
               DmLineaMovimientoFields.ImporteBruto.Value := TotalCost;
               DmLineaMovimientoFields.Descuento.Value := DiscountRate;
               // DmLineaMovimientoFields.ImporteDescuento.Value := DiscountAmount;    // Comprobar si ambos descuentos son excluyentes
               DmLineaMovimientoFields.ImporteNeto.Value := GrossAmount;

               DmLineaMovimientoTable.Post;

               Inc( NroLineaActual );
               end;

          end;

       // ShowNotification( ntInformation, Format( RsMsg19, [ DmMovimientoFields.Serie.Value + ' ' + DmMovimientoFields.NroDocumento.AsString, DsProveedorFields.Codigo.Value + ', ' + DsProveedorFields.Nombre.Value ] ) );

       EnterpriseDataModule.Commit;

       CreaRegistroFacturaElectronica( rfeFacturaRecibida,
                                       DmFacturaComprasFields.Proveedor.Value,
                                       DmFacturaComprasFields.SerieNroFactura.Value,
                                       0,
                                       DsProveedorFields.NIF.Value,
                                       DmFacturaComprasFields.Fecha.Value,
                                       DmFacturaComprasFields.TotalFactura.Value );

     except on E : Exception do
       begin
       EnterpriseDataModule.RollBack;
       raise;
       end
     end;

     try

       var  ParametrosFacturacion : IParametrosFacturacion := TParametrosFacturacion.Create;

       With ParametrosFacturacion do
         begin
         UnaSolaFactura := True;
         TipoSeleccion := tsDocumento;   // Solo el albaran actual
         Serie := SerieNroFactura;       // Será la de la factura
         PropietarioInicial := DsProveedorFields.Codigo.Value;
         PropietarioFinal := PropietarioInicial;
         SerieInicial := DmMovimientoFields.Serie.Value;
         SerieFinal := SerieInicial;
         NroDocumentoInicial := DmMovimientoFields.NroDocumento.Value;
         NroDocumentoFinal := NroDocumentoInicial;
         FechaFacturacion := ApplicationContainer.TodayDate;
         end;

       FacturaCompras.GeneraFacturas( ParametrosFacturacion );

    except on E : Exception do
      begin
      Movimiento.SuprimeMovimiento( DmMovimientoFields );
      ShowNotification( ntExceptionError, RsMsg25 );
      raise;
      end;

    end;
end;

var   SellerPersonTypeCode,
      SellerResidenceTypeCode,
      SellerTaxIdentificationNumber,

      BuyerPersonTypeCode,
      BuyerResidenceTypeCode,
      BuyerTaxIdentificationNumber,

      OverseasAddress,
      OverseasPostCodeAndTown,
      OverseasProvince,
      OverseasCountryCode : String;

begin

     XMLDocument.LoadFromFile( FilePathAndName );
     var RootNode := XMLDocument.ChildNodes.FindNode( 'fe:Facturae' );
     If   Assigned( RootNode )
     then try
            var FileHeaderNode := RootNode.ChildNodes.FindNode( 'FileHeader' );
            If   Assigned( FileHeaderNode )
            then begin
                 If   ( FileHeaderNode.ChildNodes.Nodes[ 'SchemaVersion' ].NodeValue<>VersionFacturaE ) or
                      ( FileHeaderNode.ChildNodes.Nodes[ 'Modality' ].NodeValue<>'I' ) or
                      ( FileHeaderNode.ChildNodes.Nodes[ 'InvoiceIssuerType' ].NodeValue<>'EM' )
                 then begin
                      var BatchNode := FileHeaderNode.ChildNodes.FindNode( 'Batch' );
                      If   Assigned( BatchNode )
                      then begin
                           var NroFacturas := BatchNode.ChildNodes.Nodes[ 'InvoicesCount' ].NodeValue;
                           // var TotalOutstandingAmountNode := BatchNode.ChildNodes.FindNode( 'TotalOutstandingAmount' );
                           If   NroFacturas>0
                           then begin

                                var PartiesNode := RootNode.ChildNodes.FindNode( 'Parties' );

                                If   Assigned( PartiesNode )
                                then begin

                                     var SellerPartyNode := PartiesNode.ChildNodes.FindNode( 'SellerParty' );
                                     var BuyerPartyNode := PartiesNode.ChildNodes.FindNode( 'BuyerParty' );

                                     // A partir de aquí las secciones obligatorias espero que estén definidas (deben estarlo) y no compruebo si existen.
                                     // En caso de estar mal la estructura del registrro de factura se producirá una excepción y punto.

                                     // SellerParty

                                       ReadTaxIdentification(  SellerPartyNode, SellerPersonTypeCode, SellerResidenceTypeCode, SellerTaxIdentificationNumber );

                                       var LegalEntityNode := SellerPartyNode.ChildNodes.FindNode( 'LegalEntity' );

                                         var CorporateName := LegalEntityNode.ChildValues [ 'CorporateName' ];
                                         var TradeName := LegalEntityNode.ChildValues [ 'TradeName' ];

                                       // RegistrationData

                                       // AddressInSpain

                                       var AddressInSpainNode := LegalEntityNode.ChildNodes.FindNode( 'AddressInSpain' );

                                         var Address := AddressInSpainNode.ChildValues [ 'Address' ];
                                         var PostCode := AddressInSpainNode.ChildValues [ 'PostCode' ];
                                         var Town := AddressInSpainNode.ChildValues [ 'Town' ];
                                         var Province := AddressInSpainNode.ChildValues [ 'Province' ];
                                         var CountryCode := AddressInSpainNode.ChildValues [ 'CountryCode' ];

                                       // ContactDetails

                                       var ContactDetailsNode := LegalEntityNode.ChildNodes.FindNode( 'ContactDetails' );

                                         var Telephone := ContactDetailsNode.ChildValues [ 'Telephone' ];
                                         var TeleFax := ContactDetailsNode.ChildValues [ 'TeleFax' ];
                                         var WebAddress := ContactDetailsNode.ChildValues [ 'WebAddress' ];
                                         var ElectronicMail := ContactDetailsNode.ChildValues [ 'ElectronicMail' ];
                                         var ContactPersons := ContactDetailsNode.ChildValues [ 'ContactPersons' ];
                                         var CnoCnae := ContactDetailsNode.ChildValues [ 'CnoCnae' ];
                                         var INETownCode := ContactDetailsNode.ChildValues [ 'INETownCode' ];
                                         var AdditionalContactDetails := ContactDetailsNode.ChildValues [ 'AdditionalContactDetails' ];

                                     // ---> Procesar los datos del vendedor

                                     If   not Proveedor.ObtenPorNIF( SellerTaxIdentificationNumber, DsProveedorFields, { NotificaSiNoExiste } False )
                                     then begin
                                          var NIF := SellerTaxIdentificationNumber;
                                          If   NIF.Length=11
                                          then begin
                                               NIF := Copy( NIF, 3, 9 );
                                               Proveedor.ObtenPorNIF( NIF, DsProveedorFields, { NotificaSiNoExiste } True )
                                               end
                                          else begin
                                               ShowNotification( ntStop, Format( RsMsg26, [ NIF ] ) );
                                               Abort;
                                               end;
                                          end;

                                     { Hay que diferenciar entre acreedor y proveedor.
                                       En el primer caso se creará solo el registro de IVA correspondiente (que es también el asiento) y si se trata de un proveedor
                                       se crearán el albarán y la factura. De momento no se contabilizan automáticamente.
                                     }

                                     EsUnAcreedor := Copy( DsProveedorFields.Subcuenta.Value, 1, 2 )='41';

                                     // BuyerParty

                                       ReadTaxIdentification(  BuyerPartyNode, BuyerPersonTypeCode, BuyerResidenceTypeCode, BuyerTaxIdentificationNumber );

                                       var AdministrativeCentresNode := BuyerPartyNode.ChildNodes.FindNode( 'AdministrativeCentres' );
                                       If   Assigned( AdministrativeCentresNode )
                                       then begin

                                            var AdministrativeCentreNode := AdministrativeCentresNode.ChildNodes.FindNode( 'AdministrativeCentre' );

                                               var CentreCode := AdministrativeCentreNode.ChildValues [ 'CentreCode' ];
                                               var RoleTypeCode := AdministrativeCentreNode.ChildValues [ 'RoleTypeCode' ];
                                               var Name := AdministrativeCentreNode.ChildValues [ 'Name' ];
                                               var FirstSurname := AdministrativeCentreNode.ChildValues [ 'FirstSurname' ];

                                               ReadOverseasAddress( AdministrativeCentreNode,
                                                                    'OverseasAddress',
                                                                    OverseasAddress,
                                                                    OverseasPostCodeAndTown,
                                                                    OverseasProvince,
                                                                    OverseasCountryCode );

                                               var CentreDescription := AdministrativeCentreNode.ChildValues [ 'CentreDescription' ];

                                               end;

                                       var IndividualNode := BuyerPartyNode.ChildNodes.FindNode( 'Individual' );
                                       If   Assigned( IndividualNode )
                                       then begin
                                            var Name := IndividualNode.ChildValues [ 'Name' ];
					                                       var FirstSurname := IndividualNode.ChildValues [ 'FirstSurname' ];

                                            // Etc..

                                            end;

                                     var InvoicesNode := RootNode.ChildNodes.FindNode( 'Invoices' );

                                     For var NroFactura : SmallInt := 1 to NroFacturas do
                                       ReadInvoice( InvoicesNode );

                                         {
                                         <PaymentDetails>
                                           <Installment>
                                            <InstallmentDueDate>2010-03-10</InstallmentDueDate>
                                            <InstallmentAmount>25.00</InstallmentAmount>
                                            <PaymentMeans>19</PaymentMeans>
                                            <AccountToBeCredited>
                                             <IBAN>4322 3432 22 1341234212</IBAN>
                                             <BankCode>4322</BankCode>
                                             <BranchCode>3432</BranchCode>
                                             <OverseasBranchAddress>
                                              <Address>Juncal 1423 8 Z</Address>
                                              <PostCodeAndTown>01115 Capital Federal</PostCodeAndTown>
                                              <Province>Buenos Aires</Province>
                                              <CountryCode>ARG</CountryCode>
                                             </OverseasBranchAddress>
                                            </AccountToBeCredited>
                                            <PaymentReconciliationReference>12223
                                            </PaymentReconciliationReference>
                                            <AccountToBeDebited>
                                             <IBAN>1234 4312 22 33212341212314</IBAN>
                                             <BankCode>1234</BankCode>
                                             <BranchCode>4312</BranchCode>
                                            </AccountToBeDebited>
                                            <DebitReconciliationReference>12223</DebitReconciliationReference>
                                           </Installment>
                                          </PaymentDetails>
                                         }

                                     // Traslado el fichero a la carpeta de documentos y suprimo el fichero original
                                     // de la carpeta de importación

                                     If   CopyFile( FilePathAndName, AlmacenDocumentosImportadosPath + ExtractFileName( FilePathAndName ) )
                                     then DeleteFile( FilePathAndName );

                                     end;

                                Exit;
                                end;
                           end;
                      end;
                 end;

              ShowNotification( ntStop, RsMsg18 );
              Abort;

            except on E : Exception do
              begin
              // Gestionar la excepción
              var DescripcionError := '';
              If   not ( E is EAbort )
              then DescripcionError := E.Message;
              ShowNotification( ntWarning, Format( RsMsg17, [ FilePathAndName ] ), DescripcionError );
              end;
            end;


end;

procedure TFacturaElectronicaDataModule.DoXMLSignerFormatElement(       Sender              : TObject;
                                                                        Element             : TElXMLDOMElement;
                                                                        Level               : Integer;
                                                                  const Path                : String;
                                                                  var   StartTagWhitespace,
                                                                        EndTagWhitespace    : String );
begin
     //..
end;

procedure TFacturaElectronicaDataModule.EnviaFacturaPorCorreo( RegistroFacturaElectronicaFields : TRegistroFacturaElectronicaFields );

var  TipoFichero : TTipoFicheroExportacion;
     ExtensionFichero,
     ExportFileName : String;

begin

     With RegistroFacturaElectronicaFields do
       begin

       If   Firmada
       then begin
            TipoFichero := tfeFacturaEFirma;
            ExtensionFichero := 'xsig';
            end
       else begin
            TipoFichero := tfeFacturaE;
            ExtensionFichero := 'xml';
            end;

       ExportFileName := ObtenAlmacenDocumentosPath( TipoFichero ) + 'fv' + IntToStr( ApplicationContainer.Ejercicio ) + '_' + Serie.Value + '_' + IntToStr( NroFactura.Value ) + '.' + ExtensionFichero;

       With FacturaVentas do
         If   DmFacturaVentasTable.FindKey( [ Ejercicio.Value, Serie.Value, NroFactura.Value ] ) and
              DmClienteTable.FindKey( [ Propietario.Value ] )
         then EnviaFacturaPorCorreo( tdFacturaXML, ExportFileName )
         else ShowNotification( ntError, RsMsg27, RsMsg28 );

       end;
end;

procedure TFacturaElectronicaDataModule.CargaCertificadoDefecto;

var  PalabraPasoDecodificada : String;

begin
     If   not CertificadoCargado
     then begin
          With Configuracion.ParametrosSeguridadRec do
            begin
            PalabraPasoDecodificada := Base64DecodeString( PalabraPaso );
            CertStorage := Certificados.CargaCertificadoSB( CertificadoSistema, TipoAcceso, HashCertificado, Fichero, PalabraPasoDecodificada, CertIndex );
            CertificadoFirmaValido := CertIndex>=0;
            end;
          CertificadoCargado := True;  // Independientemente de que sea o no válido, se ha intentado cargar el certificado
          end;
end;

procedure TFacturaElectronicaDataModule.DataModuleDestroy(Sender: TObject);
begin
     FacturaElectronicaDataModule := nil;
end;

procedure InitializeModule;
begin
  
     FacturaElectronica;

     If   Assigned( Gds30Frm )
     then With Gds30Frm do
            begin

            OrganismosPublicosItem.Visible := ivAlways;
            OrganismosPublicosItem.OnClick := TMntOrpForm.EdicionOrganismoPublico;

            ImportacionFacturaEItem.Visible := ivAlways;
            ImportacionFacturaEItem.OnClick := FacturaElectronica.DoOnImportacionFacturaEItemClick;

            RegistroFacturaEItem.Visible := ivAlways;
            RegistroFacturaEItem.OnClick := FacturaElectronica.DoOnRegistroFacturaEItemClick;

            end;

end;

initialization

   AddProcedure( imStartup, 0, SetupModule );
   AddProcedure( imOnEnterpriseAccess, 0, InitializeModule );

   AddProcedure( imOnCreateComponent, idFacturaVentasModule, SetupFacturaVentasModule );
   AddProcedure( imOnCreateComponent, idFrpFdvForm, SetupImpresionFacturas );

end.
