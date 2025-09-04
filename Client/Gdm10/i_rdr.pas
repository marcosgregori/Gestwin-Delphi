
unit i_rdr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask,

  LibUtils,
  ReportManager,
  Spring,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset, DataManager,
  cxMCListBox, cxCheckBox, cxMaskEdit, cxDropDownEdit, cxCalendar, nxdb,

  Gim10Fields, cxSpinEdit, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxDBData, cxLookupEdit, cxDBLookupEdit,
  cxDBExtLookupComboBox, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxNavigator,
  Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc, cxIndexedComboBox,
  AppContainer, dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  TRptRdrForm = class(TgxForm)
    buttonPanel: TgxEditPanel;
    RemesaTable: TnxeTable;
    FormManager: TgxFormManager;
    EfectoCobrarTable: TnxeTable;
    FormaCobroTable: TnxeTable;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataNroRemesa: TIntegerField;
    DataFechaCargo: TDateField;
    DataSoporteMagnetico: TBooleanField;
    DataPath: TWideStringField;
    DataFormato: TSmallintField;
    DataSource: TDataSource;
    DataPanel: TgxEditPanel;
    NroRemesaCtrl: TcxDBTextEdit;
    FechaCargoCtrl: TcxDBDateEdit;
    SoporteMagneticoCtrl: TcxDBCheckBox;
    FormatoCtrl: TcxDBTextEdit;
    DataNroOrden: TSmallintField;
    DataEfectosFisicos: TBooleanField;
    DataAmpliarConceptos: TBooleanField;
    Report: TgxReportManager;
    Label6: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    formatoLabel: TcxLabel;
    SoporteMagneticoGroupBox: TcxGroupBox;
    NroOrdenCtrl: TcxDBSpinEdit;
    EfectosFisicosCtrl: TcxDBCheckBox;
    AmpliarConceptosCtrl: TcxDBCheckBox;
    PathCtrl: TcxDBTextEdit;
    ExaminarButton: TgBitBtn;
    Label1: TcxLabel;
    Label3: TcxLabel;
    XMLDocument: TXMLDocument;
    cxLabel1: TcxLabel;
    CicloPresentacionCtrl: TcxDBIndexedComboBox;
    DataCicloPresentacion: TSmallintField;
    cxLabel2: TcxLabel;
    ReglaCtrl: TcxDBIndexedComboBox;
    DataRegla: TSmallintField;
    FinanciadaCtrl: TcxDBCheckBox;
    DataFinanciada: TBooleanField;
    ALaVistaCtrl: TcxDBCheckBox;
    DataALaVista: TBooleanField;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure examinarButtonClick(Sender: TObject);
    procedure ReportSelectPrinter;
    procedure NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure NroRemesaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PathCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ReportSetReportName;
    procedure TipoOperacionCtrlClick(Sender: TObject);
    procedure FormManagerPreparedForm;
    procedure TipoOrdenCtrlPropertiesValuePosted(Sender: TObject);
    procedure DataTipoOrdenChange(Sender: TField);
    procedure EstadoPropertiesEditValueChanged(
      Sender: TObject);
    procedure ReportBeforeStart;

  private

    DocumentoFields : TDocumentoFields;
    RemesaFields : TRemesaFields;
    FormaCobroFields : TFormaCobroFields;
    BancoFields : TBancoFields;

    FOnAmpliacionConcepto : Event<TAmpliacionEvent>;

    DocumentoTable : TnxeTable;

    NombreFichero : String;
    Fichero : Text;
    TextoImporte,
    TextoSumaImporte,
    TextoContador1,
    TextoContador2,
    TextoContador3 : String;
    TextoAceptado : String;
    TextoFechaLibramiento : String[ 6 ];
    ImporteTotal,
    ImporteTotalLote : Decimal;
    IOStatus : SmallInt;
    TextoEfectosFisicos : AnsiChar;
    CodigoOrden : SmallInt;

    DocumentNode,
    RootNode,
    GroupHeaderNode,
    NumberOfTransactionsNode,
    ControlSumNode,
    InitiatingPartyNode,
    IdentificationNode,
    PrivateIdentificationNode,
    OtherNode,
    CreditorSchemeIdentificationNode,
    OrganisationIdentificationNode,
    PaymentInformationNode,
    PaymentTypeInformationNode,
    NumberOfTransactionsBatchNode,
    ControlSumBatchNode,
    ServiceLevelNode,
    LocalInstrumentNode,
    CreditorNode,
    PostalAddressNode,
    CreditorAccountNode,
    CreditorAgentNode,
    DirectDebitTransactionInformationNode,
    PaymentIdentificationNode,
    InstructedAmountNode,
    DirectDebitTransactionNode,
    MandateRelatedInformationNode,
    DebtorAgentNode,
    DebtorNode,
    DebtorAccountNode,
    RemittanceInformationNode : IXMLNode;

    procedure ActualizaEstado;
    procedure SeleccionaRegistros;

  public

    EfectoCobrarFields : TEfectoCobrarFields;
    ClienteFields : TClienteFields;

    StCodigoRegistro : String;
    CodigoOrdenante,
    CodigoPresentador,
    IdentificadorFichero,
    IdentificadorAcreedor,
    PaisAcreedor,
    IBANAcreedor,
    PaisDeudor,
    IBANDeudor,
    BICAcreedor,
    TextoReglaPresentacion,
    ReferenciaMandato,
    ReferenciaAdeudo,
    TextoCicloMandato,
    TextoConcepto : String;
    FechaMandato : TDate;
    NroRegistros,
    NroEfectos,
    NroEfectosLote : LongInt;
    FechaVencimientoActual : TDate;
    CicloMandato : SmallInt;
    BICDeudor,
    CodigoINE,
    CodigoDC : String;
    LoteAbierto : Boolean;

    procedure WriteInFile( st : String );
    procedure ExecuteProcess;
    property OnAmpliacionConcepto : Event<TAmpliacionEvent> read FOnAmpliacionConcepto write FOnAmpliacionConcepto;
  end;

var  RptRdrForm : TRptRdrForm = nil;

const  VersionCuadernoSEPA19 = '19143';

procedure EmisionRecibosRemesa( NroRemesa : LongInt );

implementation

{$R *.dfm}

uses   Files,
       FileCtrl,
       
       AppManager,

       EnterpriseDataAccess,
       Gim00Fields,
       Gdm00Dm,
       Gdm10Dm,

       dm_emp,
       dm_pai,
       dm_iex,
       dm_cli,
       dm_prv,
       dm_ine,
       dm_ban,
       dm_ecc,
       dm_enf,
       dm_rem,

       b_dir,
       b_pro,
       b_msg,

       a_imp,

       cx_rem,
       cx_imp,
       f_prg;

resourceString
       RsMsg1   = 'Emisión de recibos en soporte magnético.';
       RsMsg2  = 'Se ha creado el fichero [URL=%0:s]%0:s[/URL].';
       RsMsg3   = 'Se ha producido un error al intentar crear el fichero destino.';
       RsMsg4   = 'El codigo IBAN/C.C.C. del cliente %s - %s no es válido.';
       RsMsg5   = 'El fichero generado podría no ser aceptado.'#13'¿Desea cancelar el proceso?';
       RsMsg6   = 'Se ha interrumpido el proceso de grabación de recibos.';
       RsMsg7   = 'Revise los mensajes de error, corrija las incidencias y reintente el proceso.';
       // RsMsg8   = 'El proceso se ha realizado satisfactoriamente.';
       RsMsg9   = 'No ha introducido el N.I.F. en la ficha de la empresa.';
       RsMsg10  = 'Utilice el mantenimiento de empresas para asignar un N.I.F. válido';
       RsMsg11  = 'No se ha podido guardar el tipo de orden en el registro de la remesa.';
       RsMsg12  = 'Es posible que el registro esté siendo editado por otro usuario.';
       RsMsg13  = 'No se ha podido obtener el BIC de la entidad de código [%s, %s].';
       RsMsg14  = 'Aparece en la ficha del cliente %s, %s.';
       RsMsg15  = 'Este dato es obligatorio consignarlo en el fichero. Se cancela el proceso.';
       RsMsg16  = 'El ciclo de presentación del cliente %s, %s no coincide con el del adeudo.';
       RsMsg17  = 'La fecha de vencimiento del efecto %s %d - %d es posterior a la fecha de cargo.';
       RsMsg18  = 'Las remesas a la vista deben contener solo efectos ya vencidos.';

procedure EmisionRecibosRemesa( NroRemesa : LongInt );
begin
     CreateReportForm( TRptRdrForm, rptRdrForm, [ NroRemesa ] );
end;

procedure TRptRdrForm.FormManagerInitializeForm;
begin
     ID := idRptRdrForm;

     CloseWindowWhenFocusLost := True;

     RemesaFields := TRemesaFields.Create( RemesaTable );
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     FormaCobroFields := TFormaCobroFields.Create( FormaCobroTable );
     BancoFields := TBancoFields.Create( Self );
     ClienteFields := TClienteFields.Create( Self );

     DataNroRemesa.Value := FormValues[ 0 ];
     DataFechaCargo.Value := ApplicationContainer.TodayDate;
     DataSoporteMagnetico.Value  := True;
     DataPath.Value := ApplicationExportsPath;
     DataNroOrden.Value := 1;

end;

procedure TRptRdrForm.SeleccionaRegistros;
begin

     ApplicationContainer.StartProgression( 100 );

     With EfectoCobrarTable do
       begin

       SetRange( [ ApplicationContainer.Ejercicio, DataNroRemesa.Value ],
                 [ ApplicationContainer.Ejercicio, DataNroRemesa.Value ] );

       First;
       While not Eof  do
         begin

         ApplicationContainer.ShowProgression;

         FormaCobroTable.FindKey( [ EfectoCobrarFields.FormaDePago.Value ] );

         Cliente.Obten( EfectoCobrarFields.CodigoCliente.Value, EfectoCobrarFields.SubcuentaCliente.Value, ClienteFields, True );
         Cliente.ObtenCodigosPaisBICeIBAN( ClienteFields, PaisDeudor, BICDeudor, IBANDeudor );

         If   FormaCobroFields.Emitir.Value
         then With DocumentoFields do
                begin

                DocumentoTable.Append;

                Ejercicio.Value := EfectoCobrarFields.Ejercicio.Value;
                Serie.Value := EfectoCobrarFields.Serie.Value;
                NroFactura.Value := EfectoCobrarFields.NroFactura.Value;
                NroEfecto.Value := EfectoCobrarFields.NroEfecto.Value;
                Importe.Value := EfectoCobrarFields.Importe.Value;
                FechaVencimiento.Value := EfectoCobrarFields.FechaVencimiento.Value;
                FechaFactura.Value := EfectoCobrarFields.FechaLibramiento.Value;
                FechaCargo.Value := DataFechaCargo.Value;
                CodigoEntidad.Value := ClienteFields.Cobro_CodigoEntidad.Value;
                Entidad.Value := ClienteFields.Cobro_Entidad.Value;
                CodigoSucursal.Value := ClienteFields.Cobro_CodigoSucursal.Value;
                Sucursal.Value := ClienteFields.Cobro_Sucursal.Value;
                DC.Value := ClienteFields.Cobro_DC.Value;
                CuentaCorriente.Value := ClienteFields.Cobro_Cuenta.Value;
                BIC.Value := BICDeudor;
                IBAN.Value := IBANDeudor;
                Codigo.Value := ClienteFields.Codigo.Value;
                Nombre.Value := ClienteFields.Cobro_Nombre.Value;
                Domicilio.Value := ClienteFields.Cobro_Domicilio.Value;
                Localidad.Value := ClienteFields.Cobro_Localidad.Value;
                CodigoPostal.Value := ClienteFields.Cobro_CodigoProv.Value + ClienteFields.Cobro_CodigoPostal.Value;
                Provincia.Value := dm_prv.provincia.descripcion( ClienteFields.CodigoPais.Value, ClienteFields.Cobro_CodigoProv.Value, False );
                NIF.Value := ClienteFields.NIF.Value;
                CodigoSubcuenta.Value := ClienteFields.Subcuenta.Value;
                ImporteCifra.Value := Cifra( EfectoCobrarFields.Importe.Value );
                Concepto.Value := EfectoCobrarFields.Concepto.Value;
                FormaDePago.Value := FormaCobroFields.Descripcion.Value;
                NroRemesa.Value := EfectoCobrarFields.NroRemesa.Value;

                DocumentoTable.Post;
                end;

         Next;
         end;

       end;

     ApplicationContainer.EndProgression;

end;

procedure TRptRdrForm.FormManagerOkButton;
begin

     If   DataModule00.DmEmpresaFields.NIF.Value=''
     then begin
          ShowNotification( ntStop, RsMsg9, RsMsg10 );
          Abort;
          end;

     If   DataSoporteMagnetico.Value
     then CreateProcessForm( ExecuteProcess, caption )
     else Report.Launch;

end;

procedure TRptRdrForm.FormManagerPreparedForm;
begin
     ActualizaEstado;
end;

procedure TRptRdrForm.NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRemesas( Sender, srTodas );
end;

procedure TRptRdrForm.NroRemesaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateRelation( Sender, RemesaTable, [ ApplicationContainer.Ejercicio, DisplayValue ], DisplayValue, ErrorText, Error );
end;

procedure TRptRdrForm.PathCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   PathCtrl.UserValidateAction or FormManager.ValidatingFormData
     then If   DisplayValue<>''
          then If   not SysUtils.DirectoryExists( DisplayValue )
               then begin
                    Error := True;
                    ErrorText := JoinMessage( rsgMsg394, rsgMsg395 );
                    end;
end;

procedure TRptRdrForm.DataTipoOrdenChange(Sender: TField);
begin
     ActualizaEstado;
end;

procedure TRptRdrForm.EstadoPropertiesEditValueChanged(Sender: TObject);
begin
     ActualizaEstado;
end;

procedure TRptRdrForm.examinarButtonClick(Sender: TObject);
begin
     SelectDirectory( DataPath );
end;

procedure TRptRdrForm.WriteInFile( st : String );
begin
     If   IoStatus=0
     then begin
          WriteLn( Fichero, st );
          IoStatus := IoResult;
          If   IoStatus<>0
          then IoCheck( IoStatus );
          end;
end;

procedure TRptRdrForm.ExecuteProcess;

var  Sufijo,
     CodigoDC : String;
     FechaCobro : TDate;

function DatosCCCClienteCorrectos( Obligatorio : Boolean = True ) : Boolean;

var  NotificationType : TNotificationType;

function EsNumerico( St : String ) : Boolean;

Var  LoEs  : Boolean;
     Index : SmallInt;

begin
     LoEs := True;
     For Index := 1 to Length( St ) do
       If   not ( St[ Index ] in [ '0'..'9' ] )
       then LoEs := False;
     EsNumerico := LoEs;
end;

begin
     With ClienteFields do
       begin

       If   CodigoPais.Value='011'
       then Result :=  not( ValueIsEmpty( Cobro_CodigoEntidad.Value ) or
                            ValueIsEmpty( Cobro_CodigoSucursal.Value ) or
                            ValueIsEmpty( Cobro_Cuenta.Value ) or
                            ( not EsNumerico( Cobro_CodigoEntidad.Value ) )  or
                            ( not EsNumerico( Cobro_CodigoSucursal.Value ) ) or
                            ( not EsNumerico( Cobro_Cuenta.Value ) ) )
       else Result := not ( ValueIsEmpty( Cobro_BIC.Value ) or
                            ValueIsEmpty( Cobro_IBAN.Value ) );

       If   not Result
       then begin
            If   Obligatorio
            then NotificationType := ntError
            else NotificationType := ntWarning;
            ProcessFrame.AddMsg( NotificationType, Format( RsMsg4, [ Codigo.Value, Nombre.Value ] ) );
            If   Obligatorio
            then Abort;
            end;

       end;
end;

procedure CalculaCodigoDC;
begin
     With ClienteFields do
       If   ValueIsEmpty( Cobro_DC.Value )     // se calculan los 2 dígitos del DC a partir de los códigos conocidos
       then CodigoDC := ObtenDC( ClienteFields.Cobro_CodigoEntidad.Value + ClienteFields.Cobro_CodigoSucursal.Value ) +
                        ObtenDC( ClienteFields.Cobro_Cuenta.Value )
       else CodigoDC := ClienteFields.Cobro_DC.Value;
end;

procedure CompruebaFechasVencimiento;
begin
     With EfectoCobrarTable do
       begin
       With RemesaFields do
         SetRange( [ Ejercicio.Value, NroRemesa.Value ] );
       First;
       While not Eof do
         begin
         If   EfectoCobrarFields.FechaVencimiento.Value>DataFechaCargo.Value
         then begin
              With EfectoCobrarFields do
                ShowNotification( ntStop, Format( RsMsg17, [ Serie.Value, NroFactura.Value, NroEfecto.Value] ), RsMsg18 );
              Abort;
              end;
         Next;
         end;
       end;
end;

procedure CierraLote;
begin
     If   LoteAbierto
     then begin
          NumberOfTransactionsBatchNode.Text := IntToStr( NroEfectosLote );
          ControlSumBatchNode.Text := StrDecimal( ImporteTotalLote );
          end;

     NroEfectosLote := 0;
     ImporteTotalLote := 0.0;

end;

begin

     With ProcessFrame do
       begin

       AddMsg( ntInformation, RsMsg1 );

       try

         Banco.Obten( RemesaFields.SubcuentaEntidad.Value, BancoFields, True );

         ExportImport.CompruebaDisco( DataPath.Value, 0, False );

         If   DataAmpliarConceptos.Value and FOnAmpliacionConcepto.CanInvoke
         then FOnAmpliacionConcepto.Invoke( amInitialize );

         IOStatus := 0;

         With BancoFields do
           begin
           If   Adeudos_SufijoCI.Value=''
           then Sufijo := '000'
           else Sufijo := LeftPad( Adeudos_SufijoCI.Value, 3 );
           CodigoOrdenante   := RightPad( DataModule00.DmEmpresaFields.NIF.Value, 9 ) + Sufijo;
           CodigoPresentador := RightPad( Adeudos_NIF.Value, 9 ) + Sufijo;
           end;

         CodigoOrden := 0;

         If   DataFinanciada.Value
         then CodigoOrden := 1
         else If   DataALaVista.Value
              then begin
                   CompruebaFechasVencimiento;
                   CodigoOrden := 2;
                   end;

         NombreFichero := AddPathDelim( DataPath.Value ) + 'SEPA1914_'  + IntToStr( DataNroRemesa.Value ) + '.xml';

         If   DataAmpliarConceptos.Value and FOnAmpliacionConcepto.CanInvoke
         then FOnAmpliacionConcepto.Invoke( amInitialize );

         With DataModule00 do
           begin
                
           XMLDocument.Active := False;
           XMLDocument.XML.Clear;
           XMLDocument.Active := True;

           XMLDocument.Encoding := 'UTF-8';

           NroEfectos := 0;
           ImporteTotal := 0.0;
           LoteAbierto := False;

           // PREAAAAMMDDHHMMSSmmmmm

           If   DataFinanciada.Value
           then IdentificadorFichero := 'FSDD'
           else IdentificadorFichero := '';
           StrAdd( IdentificadorFichero, 'PRE' + FormatDateTime( 'yyyymmddhhnnss00zzz', Now ) );

           PaisAcreedor := Pais.CodigoISO2( DmEmpresaFields.CodigoPais.Value );
           IdentificadorAcreedor := IdentificadorAT02( PaisAcreedor, DmEmpresaFields.NIF.Value, BancoFields.Adeudos_SufijoCI.Value );
           IBANAcreedor := PaisAcreedor +
                           '00' +
                           BancoFields.Adeudos_EntidadDep.Value +
                           BancoFields.Adeudos_OficinaDep.Value +
                           BancoFields.Adeudos_DCDeposito.Value +
                           BancoFields.Adeudos_CuentaDep.Value;

           CalculaDCIBAN( IBANAcreedor );

           BICAcreedor := EntidadFinanciera.ObtenBIC( BancoFields.Adeudos_EntidadDep.Value, BancoFields.Adeudos_OficinaDep.Value );
           If   BICAcreedor=''
           then begin
                ShowNotification( ntStop, Format( RsMsg13, [ BancoFields.Adeudos_EntidadDep.Value, BancoFields.Adeudos_OficinaDep.Value ] ), RsMsg15 );
                Abort;
                end;

           DocumentNode := XMLDocument.AddChild( 'Document', 'urn:iso:std:iso:20022:tech:xsd:pain.008.001.02' );
           DocumentNode.DeclareNamespace( 'xsi' , 'http://www.w3.org/2001/XMLSchema-instance' );

           XMLDocument.DocumentElement := DocumentNode;

           RootNode := DocumentNode.AddChild( 'CstmrDrctDbtInitn' );

           // Cabecera del acreedor

           GroupHeaderNode := RootNode.AddChild( 'GrpHdr' );
           GroupHeaderNode.AddChild( 'MsgId' ).Text := IdentificadorFichero;                             // Identificación del mensaje
           GroupHeaderNode.AddChild( 'CreDtTm' ).Text := FormatDateTime( 'yyyy-mm-dd"T"hh:nn:ss', Now ); // Fecha y hora de creación
           NumberOfTransactionsNode := GroupHeaderNode.AddChild( 'NbOfTxs' );                            // Número de operaciones. El valor se fija al final
           ControlSumNode := GroupHeaderNode.AddChild( 'CtrlSum' );                                      // Control de suma. Idem.

           {
           Parte iniciadora -InitgPty
             Nombre
             Identificación
               Persona jurídica
                 BICoBEI
                 Otra
                   Identificación - Id
                   Nombre del esquema
                     Código
                     Propietario
                   Emisor
               Persona física
                 Fecha y lugar de nacimiento
                   Fecha de nacimiento
                   Ciudad de nacimiento
                 Otra
                   Identificación
                     Nombre del esquema
                       Código
                       Propietario
                     Emisor
           }

           InitiatingPartyNode := GroupHeaderNode.AddChild( 'InitgPty' );                                // Parte iniciadora (opto por el acreedor, en lugar del presentador)
           InitiatingPartyNode.AddChild( 'Nm' ).Text := DmEmpresaFields.Nombre.Value;                    // Nombre
           IdentificationNode := InitiatingPartyNode.AddChild( 'Id' );                                   // Identificación
           OrganisationIdentificationNode := IdentificationNode.AddChild( 'OrgId' );                     // Persona jurídica
           OtherNode := OrganisationIdentificationNode.AddChild( 'Othr' );
           OtherNode.AddChild( 'Id' ).Text := IdentificadorAcreedor;                                     // Identificación
           ( OtherNode.AddChild( 'SchmeNm' ) ).AddChild( 'Prtry' ).Text := 'SEPA';

           // Información del pago

           Case DataRegla.Value of
             0 : TextoReglaPresentacion := 'COR1';
             1 : TextoReglaPresentacion := 'CORE';
             2 : TextoReglaPresentacion := 'B2B';
             end;

           Case DataCicloPresentacion.Value of
             0 : TextoCicloMandato := 'RCUR';
             1 : TextoCicloMandato := 'FRST';
             2 : TextoCicloMandato := 'FNAL';
             end;

           With EfectoCobrarTable do
             begin

             With RemesaFields do
               SetRange( [ Ejercicio.Value, NroRemesa.Value ] );   // Está también ordenado por fecha de vencimiento (tercer campo del índice)

             First;
             While  ( IoStatus=0 )  and not Eof do
               begin

               Cliente.Obten( EfectoCobrarFields.CodigoCliente.Value, EfectoCobrarFields.SubcuentaCliente.Value, ClienteFields, True );

               AddMsg( ntInformation, EfectoCobrarFields.SubcuentaCliente.Value + ', ' + ClienteFields.Nombre.Value + '. ' +
                                      EfectoCobrarFields.Serie.Value + ' ' + StrInt( EfectoCobrarFields.NroFactura.Value ) + '  ' + StrInt( EfectoCobrarFields.NroEfecto.Value ) );

               If   DatosCCCClienteCorrectos
               then begin

                    PaisDeudor := Pais.CodigoISO2( ClienteFields.CodigoPais.Value );

                    If   ClienteFields.CodigoPais.Value='011'
                    then begin

                         IBANDeudor := PaisDeudor +
                                       '00' +
                                       ClienteFields.Cobro_CodigoEntidad.Value +
                                       ClienteFields.Cobro_CodigoSucursal.Value +
                                       ClienteFields.Cobro_DC.Value +
                                       ClienteFields.Cobro_Cuenta.Value;

                         CalculaDCIBAN( IBANDeudor );

                         BICDeudor := EntidadFinanciera.ObtenBIC( ClienteFields.Cobro_CodigoEntidad.Value, ClienteFields.Cobro_CodigoSucursal.Value );
                         If   IBANDeudor=''
                         then begin
                              With ClienteFields do
                                ShowNotification( ntStop, Format( RsMsg13, [ Cobro_CodigoEntidad.Value, Cobro_CodigoSucursal.Value ] ) + Format( RsMsg14, [ Codigo.Value, Nombre.Value ] ), RsMsg15 );
                              Abort;
                              end;

                         end
                    else begin
                         BICDeudor := ClienteFields.Cobro_BIC.Value;
                         IBANDeudor:= ClienteFields.Cobro_IBAN.Value;
                         end;

                    end;

               //...

               If   ( NroEfectos=0 ) or
                    ( ( FechaVencimientoActual<>EfectoCobrarFields.FechaVencimiento.Value ) and not DataALaVista.Value )
               then begin

                    CierraLote;

                    LoteAbierto := True;

                    FechaVencimientoActual := EfectoCobrarFields.FechaVencimiento.Value;

                    PaymentInformationNode := RootNode.AddChild( 'PmtInf' );

                    PaymentInformationNode.AddChild( 'PmtInfId' ).Text := IdentificadorFichero + '-' +
                                                                          StrIntPadded( NroEfectos + 1, 4 );        // Identificación de la información del pago

                    PaymentInformationNode.AddChild( 'PmtMtd' ).Text := 'DD';                                       // Método de pago
                    NumberOfTransactionsBatchNode := PaymentInformationNode.AddChild( 'NbOfTxs' );                  // Número de operaciones. El valor se fija al final
                    ControlSumBatchNode := PaymentInformationNode.AddChild( 'CtrlSum' );                            // Control de suma. Idem.
                    PaymentTypeInformationNode :=  PaymentInformationNode.AddChild( 'PmtTpInf' );                   // Información del tipo de pago

                    ServiceLevelNode := PaymentTypeInformationNode.AddChild( 'SvcLvl' );                            // Nivel de servicio
                    ServiceLevelNode.AddChild('Cd').Text := 'SEPA';                                                 // Código
                    LocalInstrumentNode := PaymentTypeInformationNode.AddChild( 'LclInstrm' );                      // Instrumento local
                    LocalInstrumentNode.AddChild( 'Cd' ).Text := TextoReglaPresentacion;                            // Código (CORE, COR1, B2B)
                    PaymentTypeInformationNode.AddChild( 'SeqTp' ).Text := TextoCicloMandato;                       // Tipo de secuencia

                    If   DataALaVista.Value
                    then FechaCobro := DataFechaCargo.Value
                    else FechaCobro := EfectoCobrarFields.FechaVencimiento.Value;

                    PaymentInformationNode.AddChild( 'ReqdColltnDt' ).Text := StrDate( FechaCobro );                // Fecha de cobro

                    CreditorNode :=  PaymentInformationNode.AddChild( 'Cdtr' );                                     // Acreedor
                    CreditorNode.AddChild( 'Nm' ).Text := StrToUNIFI( DmEmpresaFields.Nombre.Value );               // Nombre
                    PostalAddressNode := CreditorNode.AddChild( 'PstlAdr' );                                        // Dirección postal
                    PostalAddressNode.AddChild( 'Ctry' ).Text := PaisAcreedor;                                      // Pais
                    PostalAddressNode.AddChild( 'AdrLine' ).Text := StrToUNIFI( DmEmpresaFields.Domicilio.Value );  // Dirección de texto libre
                    PostalAddressNode.AddChild( 'AdrLine' ).Text := StrToUNIFI( DmEmpresaFields.CodigoProvincia.Value +
                                                                                DmEmpresaFields.CodigoPostal.Value + ' ' +
                                                                                DmEmpresaFields.Localidad.Value + ' ' +
                                                                                Provincia.Descripcion( DmEmpresaFields.CodigoPais.Value,
                                                                                                       DmEmpresaFields.CodigoProvincia.Value,
                                                                                                       False ) );

                    CreditorAccountNode :=  PaymentInformationNode.AddChild( 'CdtrAcct' );                           // Cuenta del acreedor
                    IdentificationNode := CreditorAccountNode.AddChild( 'Id' );                                      // Identificación
                    IdentificationNode.AddChild( 'IBAN' ).Text := IBANAcreedor;                                      // IBAN
                    CreditorAgentNode :=  PaymentInformationNode.AddChild( 'CdtrAgt' );                              // Entidad del acreedor
                    IdentificationNode := CreditorAgentNode.AddChild( 'FinInstnId' );                                // Identificación
                    IdentificationNode.AddChild( 'BIC' ).Text := BICAcreedor;                                        // BIC

                    CreditorSchemeIdentificationNode :=  PaymentInformationNode.AddChild( 'CdtrSchmeId' );           // Identificación del acreedor
                    IdentificationNode := CreditorSchemeIdentificationNode.AddChild( 'Id' );                         // Identificación
                    PrivateIdentificationNode := IdentificationNode.AddChild( 'PrvtId' );                            // Identificación privada
                    OtherNode := PrivateIdentificationNode.AddChild( 'Othr' );                                       // Otra
                    OtherNode.AddChild( 'Id' ).Text := IdentificadorAcreedor;                                        // Identificación
                    ( OtherNode.AddChild( 'SchmeNm' ) ).AddChild( 'Prtry' ).Text := 'SEPA';

                    end;

               // ...

               ReferenciaAdeudo := EfectoCobrarFields.Ejercicio.AsString + '-' +                             // 2014
                                   Trim( EfectoCobrarFields.Serie.Value + ' ' ) +                            // SS
                                   LeftPad( EfectoCobrarFields.NroFactura.AsString, 8 ) + '-' +              // 00000023
                                   LeftPad( EfectoCobrarFields.NroEfecto.AsString, 2 ) + '-' +               // 01
                                   StrFormatDate( EfectoCobrarFields.FechaVencimiento.Value, dfCompact );    // 010114


               // Mantengo el anterior código de referencia de la Norma CSB19 durante la migración

               If   ClienteFields.Cobro_ReferenciaMandato.Value=''
               then begin
                    ReferenciaMandato := EfectoCobrarFields.SubcuentaCliente.Value;
                    FechaMandato := EncodeDate( 2009, 10, 31 );
                    CicloMandato := cmRecurrente;
                    end
               else begin
                    ReferenciaMandato := ClienteFields.Cobro_ReferenciaMandato.Value;
                    FechaMandato := ClienteFields.Cobro_FechaMandato.Value;
                    CicloMandato := ClienteFields.Cobro_CicloMandato.Value;
                    end;

               If   CicloMandato<>DataCicloPresentacion.Value
               then begin
                    ShowNotification( ntStop, Format( RsMsg16, [ ClienteFields.Codigo.Value, ClienteFields.Nombre.Value ] ) );
                    Abort;
                    end;

               DirectDebitTransactionInformationNode :=  PaymentInformationNode.AddChild( 'DrctDbtTxInf' );                                                  // Información de la operación de adeudo directo
               PaymentIdentificationNode := DirectDebitTransactionInformationNode.AddChild( 'PmtId' );                                                       // Identificación del pago
               PaymentIdentificationNode.AddChild( 'EndToEndId' ).Text := ReferenciaAdeudo;                                                                  // Identificación de extremo a extremo
               InstructedAmountNode := DirectDebitTransactionInformationNode.AddChild( 'InstdAmt' );                                                         // Importe ordenado
               InstructedAmountNode.Text := StrDecimal( EfectoCobrarFields.Importe.Value );
               InstructedAmountNode.Attributes[ 'Ccy' ] := 'EUR';

               DirectDebitTransactionNode := DirectDebitTransactionInformationNode.Addchild( 'DrctDbtTx' );                                                  // Operación de adeudo directo
               MandateRelatedInformationNode := DirectDebitTransactionNode.AddChild( 'MndtRltdInf' );                                                        // Información del mandato
               MandateRelatedInformationNode.AddChild( 'MndtId' ).Text := ReferenciaMandato;                                                                 // Identificación del mandato
               MandateRelatedInformationNode.AddChild( 'DtOfSgntr' ).Text := StrDate( FechaMandato );                                                        // Fecha de firma del manadato
               MandateRelatedInformationNode.AddChild( 'AmdmntInd' ).Text := 'false';                                                                        // Indicador de modificación

               DebtorAgentNode := DirectDebitTransactionInformationNode.AddChild( 'DbtrAgt' );                                                               // Entidad del deudor
               IdentificationNode := DebtorAgentNode.AddChild( 'FinInstnId' );                                                                               // Identificación
               IdentificationNode.AddChild( 'BIC' ).Text := BICDeudor;
                                                                                                   // BIC
               DebtorNode := DirectDebitTransactionInformationNode.AddChild( 'Dbtr' );                                                                       // Deudor
               DebtorNode.AddChild( 'Nm' ).Text := StrToUNIFI( ClienteFields.Nombre.Value );                  // Nombre
               PostalAddressNode := DebtorNode.AddChild( 'PstlAdr' );                                         // Dirección postal
               PostalAddressNode.AddChild( 'Ctry' ).Text := PaisDeudor;                                       // Pais
               PostalAddressNode.AddChild( 'AdrLine' ).Text := StrToUNIFI( ClienteFields.Domicilio.Value );   // Dirección de texto libre
               PostalAddressNode.AddChild( 'AdrLine' ).Text := StrToUNIFI( ClienteFields.CodigoProvincia.Value +
                                                                           ClienteFields.CodigoPostal.Value + ' ' +
                                                                           ClienteFields.Localidad.Value + ' ' +
                                                                           Provincia.Descripcion( ClienteFields.CodigoPais.Value,
                                                                                                  ClienteFields.CodigoProvincia.Value,
                                                                                                  False ) );

               DebtorAccountNode :=  DirectDebitTransactionInformationNode.AddChild( 'DbtrAcct' );                      // Cuenta del deudor
               IdentificationNode := DebtorAccountNode.AddChild( 'Id' );                                                // Identificación
               IdentificationNode.AddChild( 'IBAN' ).Text := IBANDeudor;                                                // IBAN

               RemittanceInformationNode := DirectDebitTransactionInformationNode.AddChild( 'RmtInf' );                 // Concepto

               If   DataAmpliarConceptos.Value and FOnAmpliacionConcepto.CanInvoke
               then TextoConcepto := FOnAmpliacionConcepto.Invoke( amUpdateRecord )
               else TextoConcepto := StrToUNIFI( EfectoCobrarFields.Concepto.Value );

               TextoConcepto := Copy( TextoConcepto, 1, 140 );  // Como máximo 140 caracteres

               RemittanceInformationNode.AddChild( 'Ustrd' ).Text := StrToUNIFI( TextoConcepto );                        // No estructurado

               DecAdd( ImporteTotal, EfectoCobrarFields.Importe.Value );
               DecAdd( ImporteTotalLote, EfectoCobrarFields.Importe.Value );

               Inc( NroEfectos );
               Inc( NroEfectosLote );

               Next;
               end;

             CierraLote;

             NumberOfTransactionsNode.Text := IntToStr( NroEfectos );
             ControlSumNode.Text := StrDecimal( ImporteTotal );

             XMLDocument.SaveToFile( NombreFichero );

             AddMsg( ntLinkInformation, Format( RsMsg2, [ NombreFichero ] ) );
             end;

           end;

          //* 08.04.2011  Guardo el último código de orden utilizado con esta remesa

          With RemesaTable do
            try
              Edit;
              RemesaFields.CodigoOrden.Value := CodigoOrden;
              Post;
            except
              Cancel;
              ShowNotification( ntWarning, RsMsg11, RsMsg12 );
              end;

       except
         ShowNotification( ntExceptionError, RsMsg6 + HTMLCR + RsMsg7 );
         end;

       end;
end;


procedure TRptRdrForm.ReportBeforeStart;
begin
     DocumentoTable := Report.CreateEmptyTable( 'Documento', DataModule10.SQLSet );
     DocumentoFields := TDocumentoFields.Create( DocumentoTable );
     SeleccionaRegistros;
end;

procedure TRptRdrForm.ReportSelectPrinter;
begin
     Report.ReportPrinter := InformeExterno.Impresora;
end;

procedure TRptRdrForm.ReportSetReportName;
begin
     Report.FileName := InformeExterno.Fichero;
end;

procedure TRptRdrForm.ActualizaEstado;
begin
     SetGroupBoxControlsEnabled( SoporteMagneticoGroupBox, SoporteMagneticoCtrl.Checked );
     FormatoCtrl.Enabled := not SoporteMagneticoCtrl.Checked;
end;

procedure TRptRdrForm.TipoOperacionCtrlClick(Sender: TObject);
begin
     ActualizaEstado;
end;

procedure TRptRdrForm.TipoOrdenCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaEstado;
end;

procedure TRptRdrForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impDocumentoCobro ), Sender.EditingValue ] );
end;

procedure TRptRdrForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impDocumentoCobro, Sender );
end;

procedure TRptRdrForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impDocumentoCobro, Sender, DisplayValue, ErrorText, Error );
end;

end.

