
unit i_rrp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask, ComCtrls,

  LibUtils,
  Spring,
  Menus, cxLookAndFeelPainters, cxButtons,

  cxControls, cxContainer, cxListView, cxCheckBox, cxDBEdit,
  cxEdit, cxTextEdit, DB, nxdb, DataManager, dxmdaset, ReportManager,

  Gim10Fields, cxListBox, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  cxTreeView, cxMCListBox, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxIndexedComboBox, dxSkinsCore, dxSkinsDefaultPainters, cxLookAndFeels,
  cxLabel, cxGroupBox, cxLookupEdit, cxDBLookupEdit, cxDBExtLookupComboBox,
  cxNavigator, Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc, AppContainer,
  dxDateRanges, dxScrollbarAnnotations, dxUIAClasses, cxRadioGroup,
  dxBarBuiltInMenu, cxPC;

type
  TRptRrpForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    ButtonPanel: TgxEditPanel;
    RemesaPagoTable: TnxeTable;
    FormManager: TgxFormManager;
    EfectoPagarTable: TnxeTable;
    FormaPagoTable: TnxeTable;
    NroRemesaCtrl: TcxDBTextEdit;
    FechaEmisionCtrl: TcxDBDateEdit;
    SoporteMagneticoCtrl: TcxDBCheckBox;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataNroRemesa: TIntegerField;
    DataFechaEmision: TDateField;
    DataSoporteMagnetico: TBooleanField;
    DataPath: TWideStringField;
    DataTipoOrden: TSmallintField;
    DataFormato: TSmallintField;
    Report: TgxReportManager;
    DataConceptoOrden: TSmallintField;
    EfectoPagarQuery: TnxeQuery;
    Label4: TcxLabel;
    Label6: TcxLabel;
    SoporteMagneticoGroupBox: TcxGroupBox;
    PathCtrl: TcxDBTextEdit;
    ExaminarButton: TgBitBtn;
    ConceptoOrdenCtrl: TcxDBIndexedComboBox;
    Label3: TcxLabel;
    TipoOrdenLabel: TcxLabel;
    Label1: TcxLabel;
    XMLDocument: TXMLDocument;
    TipoOrdenCtrl: TcxDBIndexedComboBox;
    CaptionTipoFicheroLabel: TcxLabel;
    TipoFicheroCtrl: TcxDBRadioGroup;
    DataFormaPago: TSmallintField;
    cxGroupBox2: TcxGroupBox;
    FormatoCtrl: TcxDBTextEdit;
    formatoLabel: TcxLabel;
    Label5: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ModalidadCtrl: TcxDBRadioGroup;
    DataModalidad: TSmallintField;
    OpcionesPC: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    cxTabSheet3: TcxTabSheet;
    procedure DataTipoOrdenChange(Sender: TField);
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure NroRemesaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SoporteMagneticoCtrlPropertiesChange(Sender: TObject);
    procedure PathCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ReportSetReportName;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure ExaminarButtonClick(Sender: TObject);
    procedure ReportSelectPrinter;
    procedure TipoOrdenCtrlPropertiesValuePosted(Sender: TObject);
    procedure ReportBeforeStart;
    procedure TipoOrdenCtrlPropertiesEditValueChanged(Sender: TObject);

  private

    DocumentoFields : TDocumentoFields;

    DocumentoTable : TnxeTable;

    Fichero : Text;
    FTipoOrden,
    FCodigoOrden : SmallInt;

    FOnObtenNombreFichero : Event<TGetStringEvent>;
    FOnEmisionOrden : Event<TQueryEvent>;

    DocumentNode,
    RootNode,
    GroupHeaderNode,
    NumberOfTransactionsNode,
    ControlSumNode,
    InitiatingPartyNode,
    IdentificationNode,
    RmtInfNode,
    PrivateIdentificationNode,
    OtherNode,
    DebtorSchemeIdentificationNode,
    OrganisationIdentificationNode,
    PaymentInformationNode,
    PaymentTypeInformationNode,
    ServiceLevelNode,
    CategoryPurposeNode,
    // LocalInstrumentNode,
    CreditorNode,
    PostalAddressNode,
    CreditorAccountNode,
    CreditorAgentNode,
    CreditTransferTransactionInformationNode,
    PaymentIdentificationNode,
    CtgyPurpNode,
    AmountNode,
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

    RemesaPagoFields : TRemesaPagoFields;
    EfectoPagarFields,
    EfectoPagarQueryFields : TEfectoPagarFields;
    FormaPagoFields : TFormaPagoFields;
    BancoFields : TBancoFields;
    ProveedorFields : TProveedorFields;

    NroTotalRegistros,
    NroEfectos : SmallInt;

    IOStatus : SmallInt;

    // Variables utilizadas en ExecProcess. Están situadas aquí para que puedan ser utilizadas desde el evento OnEmisionOrden

    ProveedorActual,
    TextoSigno,
    TextoImporte,
    TextoSumaImporte,
    TextoContador1,
    TextoContador2,
    TextoGastos,
    TextoConcepto,
    TextoNumeroPago,
    TextoReferencia,
    CodigoOrdenante,
    CodigoBeneficiario,
    CodigoOperacion,
    TextoViaPublica,
    TextoNumero,

    PaisOrdenante,
    IdentificadorOrdenante,
    MetodoPago,
    TextoCodigoEntidad,
    TextoCodigoSucursal,
    TextoCuentaCorriente,
    TextoCodigoDC,

    IdentificadorMensaje,
    IBANOrdenante,
    IBANBeneficiario,
    BICOrdenante,
    CabeceraBeneficiario,
    PaisBeneficiario,
    BICBeneficiario,
    NombreFichero,
    ReferenciaAdeudo : String;

    ImporteTotal,
    ImportePago : Decimal;
    FechaPagoActual : TDateTime;
    NroRegistrosPago : SmallInt;

    Bm : TBookmark;
    ProcesoPorDefecto : Boolean;

    procedure ExecuteProcess;

    property TipoOrden : SmallInt read FTipoOrden write FTipoOrden;
    property CodigoOrden : SmallInt read FCodigoOrden write FCodigoOrden;

    property OnObtenNombreFichero : Event<TGetStringEvent> read FOnObtenNombreFichero write FOnObtenNombreFichero;
    property OnEmisionOrden : Event<TQueryEvent> read FOnEmisionOrden write FOnEmisionOrden;
  end;

var RptRrpForm: TRptRrpForm = nil;

const  topTransferenciasChequesSEPA = 0;
       topPagosDomiciliados = 1;
	      topFormatoUnicoConfirming = 2;

procedure EmisionDocumentosRemesaPago( NroRemesa : LongInt );

implementation

{$R *.DFM}

uses   Variants,
       Files,
       FileCtrl,
       
       AppManager,
       EnterpriseDataAccess,

       Gim00Fields,
       Gdm00Dm,
       Gdm10Dm,

       dm_emp,
       dm_iex,
       dm_pro,
       dm_pai,
       dm_prv,
       dm_ine,
       dm_ban,
       dm_cnd,
       dm_rdp,
       dm_enf,
       dm_fpa,

       a_imp,

       b_dir,
       b_pro,
       b_msg,

       cx_rdp,
       cx_imp,
       f_prg;

resourceString
       RsMsg1   = 'Emisión de efectos en soporte magnético.';
       RsMsg2   = 'Se ha creado el fichero [URL=%0:s]%0:s[/URL].';
       RsMsg3   = 'Se ha producido un error al intentar crear el fichero destino.';
       RsMsg4   = 'El codigo IBAN/C.C.C. del proveedor %s - %s no es válido.';
       RsMsg5   = 'No se puede emitir una orden de transferencia o un pago domiciliado con un IBAN/C.C.C. incorrecto.'#13'Revise los datos bancarios de su proveedor y reintente el proceso.'#13'Se cancela el proceso.';
       RsMsg6   = 'Ha ocurrido una excepción durante el proceso de grabación de efectos.';
       RsMsg7   = 'Averigüe la causa del error y reintente el proceso.';
       // RsMsg8   = 'El proceso se ha realizado satisfactoriamente.';
       RsMsg9   = 'Esta norma necesita todos los datos sobre su Domicilio social.';
       RsMsg10  = 'Utilice el mantenimiento de empresas para asignar un domicilio, localidad, codigo postal y N.I.F. válidos a su empresa.';
       RsMsg11  = 'El importe total de la suma de los efectos del proveedor %s, %s debería ser positivo.';
       RsMsg12  = 'No se ha podido guardar el tipo de orden en el registro de la remesa.';
       RsMsg13  = 'Es posible que el registro esté siendo editado por otro usuario.';
       RsMsg14  = 'No se ha podido obtener el BIC de la entidad de código [%s]. Aparece en la ficha del proveedor %s, %s.';
       RsMsg15  = 'Este dato es obligatorio consignarlo en el fichero. Se cancela el proceso.';
       RsMsg16  = 'Debe indicar el código de cliente proporcionado por la entidad de confirming en la ficha de la entidad financiera.';
       RsMsg17  = 'Cuentas financieras -> Adeudos y abonos -> Documentos de pago -> Códigos de identificación';

const  VersionCuadernoSEPA34 = '34145';

procedure EmisionDocumentosRemesaPago( NroRemesa : LongInt );
begin
     CreateReportForm( TRptRrpForm, rptRrpForm, [ NroRemesa ] );
end;

procedure TRptRrpForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impDocumentoPago ), Sender.EditingValue ] );
end;

procedure TRptRrpForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impDocumentoPago, Sender );
end;

procedure TRptRrpForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.valida( impDocumentoPago, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptRrpForm.FormManagerInitializeForm;
begin

     ID := idRptRrpForm;

     BancoFields := TBancoFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Self );

     CloseWindowWhenFocusLost := True;

     RemesaPagoFields := TRemesaPagoFields.Create( RemesaPagoTable );
     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );
     FormaPagoFields := TFormaPagoFields.Create( FormaPagoTable );

     DataNroRemesa.Value := FormValues[ 0 ];
     DataFechaEmision.Value := ApplicationContainer.TodayDate;
     DataSoporteMagnetico.Value := True;
     DataPath.Value := ApplicationExportsPath;
     DataTipoOrden.Value := topTransferenciasChequesSEPA;
     DataFormaPago.Value := 0;
     DataConceptoOrden.Value := 2;
     DataModalidad.Value := 1;

end;

procedure TRptRrpForm.PathCtrlPropertiesValidate( Sender : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean );
begin
     If   PathCtrl.UserValidateAction or FormManager.ValidatingFormData
     then If   DisplayValue<>''
          then If   not Sysutils.DirectoryExists( DisplayValue )
               then begin
                    Error := True;
                    ErrorText := JoinMessage( RsgMsg394, RsgMsg395 );
                    end;
end;

procedure TRptRrpForm.SeleccionaRegistros;

var  TextoCodigoDC : String;

begin

     With EfectoPagarTable do
       begin

       SetRange( [ ApplicationContainer.Ejercicio, DataNroRemesa.Value ], [ ApplicationContainer.Ejercicio, DataNroRemesa.Value ] );

       ApplicationContainer.StartProgression( RecordCount );

       First;
       While not Eof  do
         begin

         ApplicationContainer.ShowProgression;

         Proveedor.Obten( EfectoPagarFields.CodigoProveedor.Value, EfectoPagarFields.SubcuentaProveedor.Value, ProveedorFields, True );
         FormaPagoTable.FindKey( [ EfectoPagarFields.FormaDePago.Value ] );
              
         If   FormaPagoFields.Emitir.Value
         then With DocumentoFields do
                begin

                DocumentoTable.Append;

                If   ValueIsEmpty( ProveedorFields.Pago_DC.Value )
                then TextoCodigoDC := ObtenDC( ProveedorFields.Pago_CodigoEntidad.Value +  ProveedorFields.Pago_CodigoSucursal.Value ) + ObtenDC( ProveedorFields.Pago_CuentaCorriente.Value )
                else TextoCodigoDC := ProveedorFields.Pago_DC.Value;

                Ejercicio.Value         := EfectoPagarFields.Ejercicio.Value;
                Serie.Value             := EfectoPagarFields.Serie.Value;
                NroFactura.Value        := EfectoPagarFields.NroFactura.Value;
                NroEfecto.Value         := EfectoPagarFields.NroEfecto.Value;
                Importe.Value           := EfectoPagarFields.Importe.Value;
                FechaVencimiento.Value  := EfectoPagarFields.FechaVencimiento.Value;
                FechaFactura.Value      := EfectoPagarFields.FechaLibramiento.Value;
                FechaCargo.Value        := DataFechaEmision.Value;
                CodigoEntidad.Value     := ProveedorFields.Pago_CodigoEntidad.Value;
                Entidad.Value           := ProveedorFields.Pago_Entidad.Value;
                CodigoSucursal.Value    := ProveedorFields.Pago_CodigoSucursal.Value;
                Sucursal.Value          := ProveedorFields.Pago_Sucursal.Value;
                DC.Value                := TextoCodigoDC;
                CuentaCorriente.Value   := ProveedorFields.Pago_CuentaCorriente.Value;
                Codigo.Value            := ProveedorFields.Codigo.Value;
                Nombre.Value            := ProveedorFields.Pago_Nombre.Value;
                Domicilio.Value         := ProveedorFields.Pago_Domicilio.Value;
                Localidad.Value         := ProveedorFields.Pago_Localidad.Value;
                CodigoPostal.Value      := ProveedorFields.Pago_CodigoProv.Value + ProveedorFields.Pago_CodigoPostal.Value;
                Provincia.Value         := dm_prv.Provincia.Descripcion( ProveedorFields.CodigoPais.Value, ProveedorFields.Pago_CodigoProv.Value, False );
                NIF.Value               := ProveedorFields.NIF.Value;
                CodigoSubcuenta.Value   := ProveedorFields.Subcuenta.Value;
                ImporteCifra.Value      := Cifra( EfectoPagarFields.Importe.Value );
                Concepto.Value          := EfectoPagarFields.Concepto.Value;
                FormaDePago.Value       := FormaPagoFields.Descripcion.Value;
                NroRemesa.Value         := EfectoPagarFields.NroRemesa.Value;

                DocumentoTable.Post;
                end;

         Next;
         end;

       end;

     ApplicationContainer.EndProgression;

end;

procedure TRptRrpForm.FormManagerOkButton;
begin

     With DataModule00.DmEmpresaFields do
       If   ( Localidad.Value='' )       or
            ( Domicilio.Value='' )       or
            ( CodigoProvincia.Value='' ) or
            ( CodigoPostal.Value='' )    or
            ( NIF.Value='' )
       then begin
            ShowNotification( ntWarning, RsMsg9, RsMsg10 );
            Abort;
            end;

     If   DataSoporteMagnetico.Value
     then CreateProcessForm( ExecuteProcess, RsMsg1 )
     else Report.Launch;

end;

procedure TRptRrpForm.NroRemesaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRemesasPago( Sender, srpTodas );
end;

procedure TRptRrpForm.NroRemesaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateRelation( Sender, RemesaPagoTable, [ ApplicationContainer.Ejercicio, DisplayValue ], DisplayValue, ErrorText, Error );
end;

procedure TRptRrpForm.DataTipoOrdenChange(Sender: TField);
begin
     TipoOrdenCtrl.ItemIndex := DataTipoOrden.Value;
     ActualizaEstado;
end;

procedure TRptRrpForm.ExaminarButtonClick(Sender: TObject);
begin
     SelectDirectory( DataPath );
end;

procedure TRptRrpForm.ExecuteProcess;

function DatosCCCProveedorCorrectos( Obligatorio : Boolean = True ) : Boolean;

function EsNumerico( St : String ) : Boolean;

Var  LoEs  : Boolean;
     Index : SmallInt;

begin
     LoEs := True;
     For Index := 1 to length( St ) do
       If   not ( CharInSet( St[ Index ], [ '0'..'9' ] ) )
       then LoEs := False;
     EsNumerico := LoEs;
end;

begin
     With ProveedorFields do
       begin

       If   CodigoPais.Value='011'
       then Result := not ( ValueIsEmpty( Pago_CodigoEntidad.Value ) or
                            ValueIsEmpty( Pago_CodigoSucursal.Value ) or
                            ValueIsEmpty( Pago_CuentaCorriente.Value ) or
                            ( not EsNumerico( Pago_CodigoEntidad.Value ) )  or
                            ( not EsNumerico( Pago_CodigoSucursal.Value ) ) or
                            ( not EsNumerico( Pago_CuentaCorriente.Value ) ) )
       else Result := not ( ValueIsEmpty( Pago_BIC.Value ) or
                            ValueIsEmpty( Pago_IBAN.Value ) );

       If   not Result and
            Obligatorio
       then begin
            With ProcessFrame do
              begin
              AddMsg( ntError, Format( RsMsg4, [ Codigo.Value, Nombre.Value ] ) );
              AddMsg( ntError, RsMsg5 );
              end;
            Abort;
            end;

       end;
end;

procedure ExtraeViayNumero(     Domicilio  : String;
                            var ViaPublica : String;
                            var Numero     : String );
var  Index  : SmallInt;

begin
     Index := Length( Domicilio );
     While ( Index>0 ) and ( CharInSet( Domicilio[ Index ], [ '0'..'9' ] ) ) do
       Dec( Index );
     Numero := Trim( Copy( Domicilio, Index + 1, MaxInt ) );
     While ( Index>0 ) and ( CharInSet( Domicilio[ Index ], [ ',','.','/',' ' ] ) ) do
       Dec( Index );
     ViaPublica := Trim( Copy( Domicilio, 1, Index ) );
end;

function TextoImporteConfirming( Valor : Decimal ) : String;
begin
     var StValor := StrDecimal( Valor );
     StValor := StringReplace( StValor, '.', '', [ rfReplaceAll ] );
     StValor := StringReplace( StValor, ',', '', [ rfReplaceAll ] );
     StValor := StringReplace( StValor, '-', '', [ rfReplaceAll ] );
     Result := LeftPad( StValor, 15 );
end;

procedure WriteInFile( St      : String;
                       NewLine : Boolean = True );
begin
     If   IoStatus=0
     then begin
          If   NewLine
          then WriteLn( Fichero, St )
          else Write( Fichero, St );
          IoStatus := IoResult;
          If   IoStatus<>0
          then IoCheck( IoStatus );
          Inc( NroTotalRegistros );
          end;
end;

begin

     With ProcessFrame do
       begin

       try

         ImporteTotal := 0.0;
         NroTotalRegistros := 0;
         CodigoOrden := 0;

         Banco.Obten( RemesaPagoFields.SubcuentaEntidad.Value, BancoFields, True );

         ExportImport.CompruebaDisco( DataPath.Value, 0, False );

         If   DataTipoOrden.Value=topPagosDomiciliados
         then TipoOrden := 68
         else TipoOrden := 34;

         If   FOnObtenNombreFichero.CanInvoke
         then NombreFichero := FOnObtenNombreFichero.Invoke
         else If   DataTipoOrden.Value=topPagosDomiciliados
              then NombreFichero := AddPathDelim( DataPath.Value ) + 'AEB' + IntToStr( TipoOrden ) + '80_'  + IntToStr( DataNroRemesa.Value )
              else NombreFichero := AddPathDelim( DataPath.Value ) + 'SEPA3414_' + IntToStr( DataNroRemesa.Value ) + '_' + IntToStr( DataTipoOrden.Value ) + '.xml';

         IOStatus := 0;

         case DataTipoOrden.Value of

           topTransferenciasChequesSEPA :

             begin

             XMLDocument.Active := False;
             XMLDocument.XML.Clear;
             XMLDocument.Active := True;

             XMLDocument.Encoding := 'UTF-8';

             PaisOrdenante := Pais.CodigoISO2( DataModule00.DmEmpresaFields.CodigoPais.Value );
             IdentificadorOrdenante := DataModule00.DmEmpresaFields.NIF.Value + LeftPad( BancoFields.Adeudos_SufijoCI.Value, 3 ); // IdentificadorAT02( PaisOrdenante, DmEmpresaFields.NIF.Value, Banco.DmBancoFields.Adeudos_SufijoCI.Value );

             IBANOrdenante := PaisOrdenante +
                              '00' +
                              BancoFields.Adeudos_EntidadDep.Value +
                              BancoFields.Adeudos_OficinaDep.Value +
                              BancoFields.Adeudos_DCDeposito.Value +
                              BancoFields.Adeudos_CuentaDep.Value;

             CalculaDCIBAN( IBANOrdenante );

             BICOrdenante := EntidadFinanciera.ObtenBIC( BancoFields.Adeudos_EntidadDep.Value, BancoFields.Adeudos_OficinaDep.Value );
             If   BICOrdenante=''
             then begin
                  ShowNotification( ntStop, Format( RsMsg13, [ BancoFields.Adeudos_EntidadDep.Value, BancoFields.Adeudos_OficinaDep.Value ] ), RsMsg15 );
                  Abort;
                  end;

             IdentificadorMensaje := 'PRE' + FormatDateTime( 'yyyymmddhhnnss00zzz', Now );

             If   DataFormaPago.Value=0
             then MetodoPago := 'TRF'
             else MetodoPago := 'CHK';

             case DataConceptoOrden.Value of
               0 : TextoConcepto := 'SALA';
               1 : TextoConcepto := 'PENS';
               2 : TextoConcepto := 'OTHR';
               end;

              DocumentNode := XMLDocument.AddChild( 'Document', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03' );
              DocumentNode.DeclareNamespace( 'xsi' , 'http://www.w3.org/2001/XMLSchema-instance' );

              XMLDocument.DocumentElement := DocumentNode;

              RootNode := DocumentNode.AddChild( 'CstmrCdtTrfInitn' );

              // Cabecera

              GroupHeaderNode := RootNode.AddChild( 'GrpHdr' );
              GroupHeaderNode.AddChild( 'MsgId' ).Text := IdentificadorMensaje;                             // Identificación del mensaje
              GroupHeaderNode.AddChild( 'CreDtTm' ).Text := FormatDateTime( 'yyyy-mm-dd"T"hh:nn:ss', Now ); // Fecha y hora de creación
              NumberOfTransactionsNode := GroupHeaderNode.AddChild( 'NbOfTxs' );                            // Número de operaciones. El valor se fija al final
              ControlSumNode := GroupHeaderNode.AddChild( 'CtrlSum' );                                      // Control de suma. Idem.

              InitiatingPartyNode := GroupHeaderNode.AddChild( 'InitgPty' );                                // Parte iniciadora
              InitiatingPartyNode.AddChild( 'Nm' ).Text := DataModule00.DmEmpresaFields.Nombre.Value;       // Nombre
              IdentificationNode := InitiatingPartyNode.AddChild( 'Id' );                                   // Identificación
              OrganisationIdentificationNode := IdentificationNode.AddChild( 'OrgId' );                     // Persona jurídica
              OtherNode := OrganisationIdentificationNode.AddChild( 'Othr' );
              OtherNode.AddChild( 'Id' ).Text := IdentificadorOrdenante;                                    // Identificación

              // Información del pago

              PaymentInformationNode := RootNode.AddChild( 'PmtInf' );

              PaymentInformationNode.AddChild( 'PmtInfId' ).Text := IdentificadorMensaje + '1';             // Identificación de la información del pago
              PaymentInformationNode.AddChild( 'PmtMtd' ).Text := MetodoPago;                               // Método de pago

              {
              If   DataFormaPago.Value=0
              then begin
                   PaymentTypeInformationNode :=  PaymentInformationNode.AddChild( 'PmtTpInf' );              // Información del tipo de pago
                   CategoryPurposeNode := PaymentTypeInformationNode.AddChild( 'CtgyPurp' );                  // Tipo de transferencia
                   CategoryPurposeNode.AddChild( 'Cd' ).Text := TextoConcepto;                                // Código (SALA, PENS)
                   end;
              }

              PaymentInformationNode.AddChild( 'ReqdExctnDt' ).Text := StrDate( DataFechaEmision.Value );     // Fecha de ejecución solicitada

              // Ordenante

              With DataModule00 do
                begin
                DebtorNode :=  PaymentInformationNode.AddChild( 'Dbtr' );                                       // Ordenante
                DebtorNode.AddChild( 'Nm' ).Text := StrToUNIFI( DmEmpresaFields.Nombre.Value );                 // Nombre
                PostalAddressNode := DebtorNode.AddChild( 'PstlAdr' );                                          // Dirección postal
                PostalAddressNode.AddChild( 'Ctry' ).Text := PaisOrdenante;                                     // Pais
                PostalAddressNode.AddChild( 'AdrLine' ).Text := StrToUNIFI( DmEmpresaFields.Domicilio.Value +  ' ' + // Dirección de texto libre
                                                                            DmEmpresaFields.CodigoProvincia.Value +
                                                                            DmEmpresaFields.CodigoPostal.Value + ' ' +
                                                                            DmEmpresaFields.Localidad.Value + ' ' +
                                                                            Provincia.Descripcion( DmEmpresaFields.CodigoPais.Value,
                                                                                                   DmEmpresaFields.CodigoProvincia.Value,
                                                                                                   False ) );
                end;

              IdentificationNode := DebtorNode.AddChild( 'Id' );                                               // Identificación
              OrganisationIdentificationNode := IdentificationNode.AddChild( 'OrgId' );                        // Persona jurídica
              OtherNode := OrganisationIdentificationNode.AddChild( 'Othr' );
              OtherNode.AddChild( 'Id' ).Text := IdentificadorOrdenante;                                       // Identificación

              DebtorAccountNode :=  PaymentInformationNode.AddChild( 'DbtrAcct' );                             // Cuenta del ordenante o deudor
              IdentificationNode := DebtorAccountNode.AddChild( 'Id' );                                        // Identificación
              IdentificationNode.AddChild( 'IBAN' ).Text := IBANOrdenante;                                     // IBAN
              DebtorAccountNode.AddChild( 'Ccy' ).Text := 'EUR';                                               // Divisa o moneda

              DebtorAgentNode :=  PaymentInformationNode.AddChild( 'DbtrAgt' );                                // Entidad del acreedor
              IdentificationNode := DebtorAgentNode.AddChild( 'FinInstnId' );                                  // Identificación
              IdentificationNode.AddChild( 'BIC' ).Text := BICOrdenante;                                       // BIC

              NroEfectos := 0;

              With EfectoPagarTable do
                begin

                With RemesaPagoFields do
                  SetRange( [ Ejercicio.Value, NroRemesa.Value ] );

                First;
                While  ( IoStatus=0 )  and not Eof do
                  begin

                  Proveedor.Obten( EfectoPagarFields.CodigoProveedor.Value, EfectoPagarFields.SubcuentaProveedor.Value, ProveedorFields, True );

                  AddMsg( ntInformation, EfectoPagarFields.SubcuentaProveedor.Value  + ',  ' +
                                     ProveedorFields.Nombre.Value + '. ' +
                                     EfectoPagarFields.Serie.Value + ' / ' + StrInt( EfectoPagarFields.NroEfecto.Value ) );

                  DatosCCCProveedorCorrectos;

                  PaisBeneficiario := Pais.CodigoISO2( ProveedorFields.CodigoPais.Value );

                  If   ProveedorFields.CodigoPais.Value=CodigoEspaña
                  then begin

                       IBANBeneficiario := PaisBeneficiario +
                                           '00' +
                                           ProveedorFields.Pago_CodigoEntidad.Value +
                                           ProveedorFields.Pago_CodigoSucursal.Value +
                                           ProveedorFields.Pago_DC.Value +
                                           ProveedorFields.Pago_CuentaCorriente.Value;

                       CalculaDCIBAN( IBANBeneficiario );

                       BICBeneficiario := EntidadFinanciera.ObtenBIC( ProveedorFields.Pago_CodigoEntidad.Value, ProveedorFields.Pago_CodigoSucursal.Value );
                       If   BICBeneficiario=''
                       then begin
                            With ProveedorFields do
                              ShowNotification( ntStop, Format( RsMsg14, [ Pago_CodigoEntidad.Value, Codigo.Value, Nombre.Value ] ), RsMsg15 );
                            Abort;
                            end;

                       end
                  else begin
                       BICBeneficiario := ProveedorFields.Pago_BIC.Value;
                       IBANBeneficiario := ProveedorFields.Pago_IBAN.Value;
                       end;

                  ReferenciaAdeudo := EfectoPagarFields.Ejercicio.AsString +                                   // 2014
                                      EfectoPagarFields.Serie.Value +                                          // SSSSSSSSSSSS
                                      LeftPad( EfectoPagarFields.NroEfecto.AsString, 2 )  +                    // 01
                                      StrFormatDate( EfectoPagarFields.FechaVencimiento.Value, dfCompact );    // 010114

                  // Información de transferencia individual

                  CreditTransferTransactionInformationNode :=  PaymentInformationNode.AddChild( 'CdtTrfTxInf' );                                                // Información de transferencia individual
                  PaymentIdentificationNode := CreditTransferTransactionInformationNode.AddChild( 'PmtId' );                                                    // Identificación del pago
                  // PaymentIdentificationNode.AddChild( 'InstrId' ).Text := ReferenciaAdeudo;                                                                     // Identificación de la instrucción

                  If   DataFormaPago.Value=0
                  then PaymentIdentificationNode.AddChild( 'EndToEndId' ).Text := ReferenciaAdeudo;                                                             // Identificación de extremo a extremo

                  PaymentTypeInformationNode := CreditTransferTransactionInformationNode.AddChild( 'PmtTpInf' );                                                // Información del tipo de pago
                  ServiceLevelNode := PaymentTypeInformationNode.AddChild( 'SvcLvl' );                                                                          // Nivel se servicio
                  ServiceLevelNode.AddChild( 'Cd' ).Text := 'SEPA';                                                                                             // Código

                  If   DataFormaPago.Value=0
                  then begin
                       CtgyPurpNode := PaymentTypeInformationNode.AddChild( 'CtgyPurp' );                                                                       // Tipo de transferencia
                       CtgyPurpNode.AddChild( 'Cd' ).Text := TextoConcepto;                                                                                     // Código
                       end;

                  AmountNode := CreditTransferTransactionInformationNode.AddChild( 'Amt' );                                                                     // Importe
                  InstructedAmountNode := AmountNode.AddChild( 'InstdAmt' );                                                                                    // Importe ordenado
                  InstructedAmountNode.Text := StrDecimal( EfectoPagarFields.Importe.Value );
                  InstructedAmountNode.Attributes[ 'Ccy' ] := 'EUR';

                  If   DataFormaPago.Value=0
                  then begin
                       // Instrucción para emisión de cheque
                       end;

                  CreditorAgentNode := CreditTransferTransactionInformationNode.AddChild( 'CdtrAgt' );                                                          // Entidad del deudor
                  IdentificationNode := CreditorAgentNode.AddChild( 'FinInstnId' );                                                                             // Identificación
                  IdentificationNode.AddChild( 'BIC' ).Text := BICBeneficiario;

                  CreditorNode := CreditTransferTransactionInformationNode.AddChild( 'Cdtr' );                                                                  // Beneficiario
                  CreditorNode.AddChild( 'Nm' ).Text := StrToUNIFI( ProveedorFields.Nombre.Value );                                                             // Nombre
                  PostalAddressNode := CreditorNode.AddChild( 'PstlAdr' );                                                                                      // Dirección postal
                  PostalAddressNode.AddChild( 'Ctry' ).Text := PaisBeneficiario;                                                                                // Pais
                  PostalAddressNode.AddChild( 'AdrLine' ).Text := StrToUNIFI( ProveedorFields.Domicilio.Value  + ' ' +                                          // Dirección de texto libre
                                                                              ProveedorFields.CodigoProvincia.Value +
                                                                              ProveedorFields.CodigoPostal.Value + ' ' +
                                                                              ProveedorFields.Localidad.Value + ' ' +
                                                                              Provincia.Descripcion( ProveedorFields.CodigoPais.Value,
                                                                                                     ProveedorFields.CodigoProvincia.Value,
                                                                                                     False ) );

                  CreditorAccountNode := CreditTransferTransactionInformationNode.AddChild( 'CdtrAcct' );                                                      // Cuenta del beneficiario
                  IdentificationNode := CreditorAccountNode.AddChild( 'Id' );                                                                                   // Identificación
                  IdentificationNode.AddChild( 'IBAN' ).Text := IBANBeneficiario;                                                                               // IBAN

                  RmtInfNode := CreditTransferTransactionInformationNode.AddChild( 'RmtInf' );                                                                  // Concepto
                  RmtInfNode.AddChild( 'Ustrd' ).Text := StrToUNIFI( EfectoPagarFields.Concepto.Value );                                                        // No estructurado

                  DecAdd( ImporteTotal, EfectoPagarFields.Importe.Value );

                  Inc( NroEfectos );

                  Next;
                  end;

                NumberOfTransactionsNode.Text := IntToStr( NroEfectos );
                ControlSumNode.Text := StrDecimal( ImporteTotal );

                XMLDocument.SaveToFile( NombreFichero );
                end;

              end;

           topPagosDomiciliados :

              begin
              AssignFile( Fichero, NombreFichero );
              Rewrite( Fichero );
              If   IoResult<>0
              then ShowNotification( ntError, RsMsg3, RsgMsg361 )
              else try

                     With BancoFields do
                       begin
                       IBANOrdenante := 'ES00' + Adeudos_EntidadAde.Value + Adeudos_OficinaAde.Value + Adeudos_DCAdeudos.Value + Adeudos_CuentaAde.Value;
                       CalculaDCIBAN( IBANOrdenante );
                       end;

                     CodigoOrdenante := RightPad( DataModule00.DmEmpresaFields.NIF.Value, 9 );
                     CodigoOrden := 59;
                     CodigoOperacion := IntToStr( CodigoOrden );

                     With DataModule00 do
                       begin

                       // Registros de cabecera ordenante

                       WriteInFile( '03' +
                                    CodigoOperacion +
                                    CodigoOrdenante +
                                    LeftPad( BancoFields.Adeudos_SufijoCI.Value, 3 ) +
                                    StrConst( 12 ) +                                          // Libre
                                    '001' +                                                   // Número de dato
                                    StrFormatDate( DataFechaEmision.Value, dfCompact )   +    // Fecha de envío
                                    StrConst( 9 ) +                                           // Libre
                                    IBANOrdenante +
                                    StrConst( 30 ) );

                       // Registros del beneficiario

                       NroEfectos   := 0;
                       With EfectoPagarQuery do
                         try

                           Close;

                           With RemesaPagoFields do
                             SQL.Text := SQLFormat( 'SELECT * FROM EfectoPagar WHERE EjercicioRemesa=%d AND NroRemesa=%d ORDER BY SubcuentaProveedor, FechaVencimiento',
                                                    [ Ejercicio.Value, NroRemesa.Value ] );

                           Open;

                           EfectoPagarQueryFields := TEfectoPagarFields.Create( EfectoPagarQuery );

                           First;
                           While ( IoStatus=0 ) and not Eof do
                             begin

                             AddRecordMsg( EfectoPagarQueryFields.SubcuentaProveedor.Value  + '  ' +
                                           EfectoPagarQueryFields.Serie.Value + '/' +
                                           StrInt( EfectoPagarQueryFields.NroEfecto.Value ) );

                             ProveedorActual := EfectoPagarQueryFields.SubcuentaProveedor.Value;
                             Proveedor.ObtenPorSubcuenta( EfectoPagarQueryFields.SubcuentaProveedor.Value, ProveedorFields, True );

                             // Cabecera de beneficiario y detalle

                             While ( IoStatus=0 ) and not Eof and ( EfectoPagarQueryFields.SubcuentaProveedor.Value=ProveedorActual ) do
                               begin

                               With ProveedorFields do
                                 begin

                                 // Cabecera

                                 CabeceraBeneficiario := '06' +
                                                         CodigoOperacion +
                                                         CodigoOrdenante +
                                                         LeftPad( BancoFields.Adeudos_SufijoCI.Value, 3 ) +
                                                         RightPad( NIF.Value, 12 );

                                 WriteInFile( CabeceraBeneficiario +
                                              '010' +
                                              RightPad( Pago_Nombre.Value, 40 ) +
                                              StrConst( 29 ) );

                                 WriteInFile( CabeceraBeneficiario +
                                              '011' +
                                              RightPad( Pago_Domicilio.Value, 45 ) +
                                              StrConst( 24 ) );

                                 WriteInFile( CabeceraBeneficiario +
                                              '012' +
                                              RightPad( Pago_CodigoProv.Value + Pago_CodigoPostal.Value + Pago_Localidad.Value, 40 ) +
                                              StrConst( 24 ) );

                                 WriteInFile( CabeceraBeneficiario +
                                              '013' +
                                              RightPad( Pago_CodigoProv.Value + Pago_CodigoPostal.Value, 9 ) +
                                              RightPad( Provincia.Descripcion( CodigoPais.Value, Pago_CodigoProv.Value, False ), 30 ) +
                                              RightPad( Pais.Descripcion( CodigoPais.Value, False ), 20 ) +
                                              StrConst( 10 ) );

                                 end;

                               NroRegistrosPago := 0;
                               FechaPagoActual := EfectoPagarQueryFields.FechaVencimiento.Value;
                               ImportePago := 0.0;

                               Bm := GetBookMark;

                               While not Eof and
                                     ( EfectoPagarQueryFields.SubcuentaProveedor.Value=ProveedorActual ) and
                                     ( EfectoPagarQueryFields.FechaVencimiento.Value=FechaPagoActual ) and
                                     ( NroRegistrosPago<29 ) do
                                 begin
                                 DecAdd( ImportePago, EfectoPagarQueryFields.Importe.Value );
                                 Inc( NroRegistrosPago );
                                 Next;
                                 end;

                               If   ImportePago<=0.0
                               then begin
                                    With ProveedorFields do
                                      AddMsg( ntError, Format( RsMsg11, [ Codigo.Value, Nombre.Value ] ) );
                                    Abort;
                                    end;

                               TextoNumeroPago := Banco.ProximoNumeroPago( BancoFields );

                               WriteInFile( CabeceraBeneficiario +
                                            '014' +

                                            TextoNumeroPago +
                                            StrFormatDate( FechaPagoActual, dfCompact2 ) +
                                            FormateaValorNumerico( ImportePago, 12 ) +
                                            '0' +             // Presentación
                                            StrConst( 8 ) +   // Códigos ISO y estadístico (nulos)
                                            StrConst( 32 ) );

                               GotoBookMark( Bm );

                               // Detalle

                               NroRegistrosPago := 0;

                               While ( IoStatus=0 ) and
                                     not Eof and
                                     ( EfectoPagarQueryFields.SubcuentaProveedor.Value=ProveedorActual ) and
                                     ( EfectoPagarQueryFields.FechaVencimiento.Value=FechaPagoActual ) and
                                     ( NroRegistrosPago<29 ) do
                                 begin

                                 If   EfectoPagarQueryFields.Importe.Value<0.0
                                 then TextoSigno := 'D'
                                 else TextoSigno := 'H';

                                 TextoReferencia := RightPad( EfectoPagarQueryFields.Serie.Value, 10 ) +
                                                    StrIntPadded( EfectoPagarQueryFields.NroEfecto.Value, 2 );

                                 WriteInFile( CabeceraBeneficiario +
                                              StrIntPadded( 15 + NroRegistrosPago, 3 )  +

                                              TextoNumeroPago +
                                              TextoReferencia +
                                              StrFormatDate( EfectoPagarQueryFields.FechaLibramiento.Value, dfCompact2 ) +
                                              FormateaValorNumerico( Abs( EfectoPagarQueryFields.Importe.Value ), 12 ) +
                                              TextoSigno +  // D - H
                                              RightPad( EfectoPagarQueryFields.Concepto.Value, 28 ) );

                                 DecAdd( ImporteTotal, EfectoPagarQueryFields.Importe.Value );
                                 Inc( NroEfectos );
                                 Inc( NroRegistrosPago );

                                 Next;
                                 end;
                               end;
                             end;

                         finally
                           Close;
                           end;

                       TextoSumaImporte := FormateaValorNumerico( ImporteTotal, 12 );
                       TextoContador2 := FormateaValorNumerico( NroTotalRegistros + 1, 10, 0 );

                       WriteInFile( '08' +
                                    CodigoOperacion +
                                    CodigoOrdenante +
                                    LeftPad( BancoFields.Adeudos_SufijoCI.Value, 3 ) +
                                    StrConst( 15 ) +
                                    TextoSumaImporte +
                                    TextoContador2 +
                                    StrConst( 47 ),

                                    False );

                       end;

                   finally
                     CloseFile( Fichero );
                     end;

              end;

           topFormatoUnicoConfirming :
             begin

             If   BancoFields.Abonos_CIC.Value=''
             then begin
                  ShowNotification( ntStop, RsMsg16, RsMsg17 );
                  Abort;
                  end;


             If   FOnObtenNombreFichero.CanInvoke
             then NombreFichero := FOnObtenNombreFichero.Invoke
             else NombreFichero := AddPathDelim(dataPath.Value ) + BancoFields.Abonos_CIC.value + '_' + FormatDateTime( 'yyyymmdd_hhnnss', Now ) + '.txt';

             var FicheroTexto := TStringList.Create;

             FicheroTexto.WriteBOM := False;

             try

               // Cabecera

               // Registro 1

               FicheroTexto.Add( '1' +                                                        // Número registro
                                 RightPad( DataModule00.DmEmpresaFields.Nombre.Value, 50 ) +  // Nombre Ordenante
                                 RightPad( DataModule00.DmEmpresaFields.NIF.Value, 15 ) +     // NIF Ordenante
                                 FormatDateTime( 'yyyymmdd', DataFechaEmision.Value ) +       // Fecha proceso
                                 FormatDateTime( 'yyyymmdd', RemesaPagoFields.Fecha.Value ) + // Fecha de remesa
                                 RightPad( BancoFields.Abonos_CIC.Value, 20 ) +               // Código de identificación único de cliente (o número de contrato confirming que el cliente)
                                 RightPad( Banco.IBAN( BancoFields ), 34 ) +                  // Cuenta de Cargo (IBAN)
                                 'EUR' +                                                      // Código de divisa
                                 IntToStr( DataModalidad.Value ) +                            // Estándar/ Pronto Pago / Otros
                                 StrConst( 30 ) +                                             // Referencia/Nombre Fichero
                                 'FU' +                                                       // Tipo formato
                                 StrConst( 77 )                                               // Campo libre
                                 );

               // Registro 2

               With DataModule00 do
                 FicheroTexto.Add( '2' +                                                      // Número registro
                                    RightPad( DmEmpresaFields.Domicilio.Value, 65 ) +          // Domicilio Ordenante
                                    RightPad( DmEmpresaFields.Localidad.Value, 40 ) +          // Poblacion Ordenante
                                    RightPad( DmEmpresaFields.CodigoProvincia.Value +          // Código postal
                                              DmEmpresaFields.CodigoPostal.Value, 10 ) +
                                    StrConst( 133 )                                            // Campo libre
                                    );

               // Detalle

               NroEfectos := 0;

                With EfectoPagarTable do
                  begin

                  With RemesaPagoFields do
                    SetRange( [ Ejercicio.Value, NroRemesa.Value ] );

                  First;
                  While  ( IoStatus=0 )  and not Eof do
                    begin

                    Proveedor.Obten( EfectoPagarFields.CodigoProveedor.Value, EfectoPagarFields.SubcuentaProveedor.Value, ProveedorFields, True );
                    var PaisProveedor := Pais.CodigoISO2( ProveedorFields.CodigoPais.Value );

                    AddMsg( ntInformation, EfectoPagarFields.SubcuentaProveedor.Value  + ',  ' +
                                           ProveedorFields.Nombre.Value + '. ' +
                                           EfectoPagarFields.Serie.Value + ' / ' + StrInt( EfectoPagarFields.NroEfecto.Value ) );

                    // Detalle proveedor

                    // Registro 3

                    FicheroTexto.Add( '3' +                                                     // Número registro
                                      RightPad( ProveedorFields.Nombre.Value, 70 ) +            // Nombre del proveedor
                                      RightPad( ProveedorFields.NIF.Value, 20 ) +               // No de Identificación
                                      RightPad( ProveedorFields.Domicilio.Value, 65 ) +         // Domicilio del proveedor
                                      RightPad( ProveedorFields.Localidad.Value, 40 ) +         // Poblacion del proveedor
                                      RightPad( ProveedorFields.CodigoProvincia.Value +         // Código postal
                                                ProveedorFields.CodigoPostal.Value, 10 ) +
                                      PaisProveedor +                                           // País Proveedor
                                      StrConst( 41 )                                            // Campo libre
                                      );

                    // Registro 4

                    FicheroTexto.Add( '4' +                                                     // Número registro
                                      RightPad( ProveedorFields.EMail.Value, 50 ) +             // Email
                                      StrConst( 50 ) +                                          // Email secundario
                                      RightPad( ProveedorFields.Telefono.Value, 15 ) +          // Telefono
                                      RightPad( ProveedorFields.Fax.Value, 15 ) +               // Fax
                                      StrConst( 118 )                                           // Campo libre
                                      );

                    // Detalle pago

                    IBANBeneficiario := Proveedor.IBAN( ProveedorFields );

                    If   ProveedorFields.CodigoPais.Value=CodigoEspaña
                    then BICBeneficiario := ''
                    else BICBeneficiario := ProveedorFields.Pago_BIC.Value;

                    // Registro 5

                    FicheroTexto.Add( '5' +                                                     // Número registro
                                      IfThen( DataformaPago.Value=0, 'T', 'C' ) +               // Forma de Pago
                                      RightPad( IBANBeneficiario, 34 ) +                        // IBAN
                                      RightPad( BICBeneficiario , 11 ) +                        // BIC
                                      StrConst( 34 ) +                                          // Cuentas Pagos internacionales (sin IBAN)
                                      Pais.CodigoISO2( ProveedorFields.CodigoPais.Value ) +     // Código País Banco
                                      StrConst( 11 ) +                                          // Código ABA
                                      StrConst( 2 ) +                                           // Tipo de proveedor
                                      StrConst( 40 ) +                                          // Por cuenta de
                                      StrConst( 113 )                                           // Campo libre
                                      );

                    // Registro 6

                    FicheroTexto.Add( '6' +                                                                     // Número registro
                                      RightPad( EfectoPagarFields.Serie.Value, 20 ) +                           // Código/Número factura (Se tomarán las 15 últimas posiciones informadas (Código de Factura), por eso está alineado a la derecha)
                                      IfThen( EfectoPagarFields.Importe.Value>=0, '+', '-' ) +                  // Signo
                                      TextoImporteConfirming( EfectoPagarFields.Importe.Value ) +               // Importe factura
                                      FormatDateTime( 'yyyymmdd', EfectoPagarFields.FechaLibramiento.Value ) +  // Fecha de emisión
                                      FormatDateTime( 'yyyymmdd', EfectoPagarFields.FechaVencimiento.Value ) +  // Fecha de vencimiento
                                      StrConst( 8 ) +                                                           // Fecha Prórroga / aplazamiento / cargo
                                      StrConst( 16 ) +                                                          // Referencia de pago
                                      StrConst( 172 )                                                           // Campo libre
                                      );

                    DecAdd( ImporteTotal, EfectoPagarFields.Importe.Value );

                    Inc( NroEfectos );

                    Next;
                    end;

                  end;

               // Registro totales de remesa

               // Registro 7

               FicheroTexto.Add( '7' +                                        // Número registro
                                 StrIntPadded( NroEfectos, 12 ) +             // Total órdenes
                                 TextoImporteConfirming( ImporteTotal ) +     // Total importe
                                 StrConst( 221 )                              // Campo libre
                                 );

               FicheroTexto.SaveToFile( NombreFichero, TEncoding.UTF8 );

             finally
               FreeAndNil( FicheroTexto );
               end;

             end;

           end;

         AddMsg( ntLinkInformation, Format( RsMsg2, [ NombreFichero ] ) );

         //* 08.04.2011  Guardo el último tipo de orden utilizado con esta remesa

          With RemesaPagoTable do
            try
              Edit;
              RemesaPagoFields.TipoOrden.Value := TipoOrden;
              RemesaPagoFields.CodigoOrden.Value := CodigoOrden;
              Post;
            except
              Cancel;
              ShowNotification( ntWarning, RsMsg12, RsMsg13 );
              end;

       except on E : Exception do
         begin
         If   DataTipoOrden.Value=topPagosDomiciliados
         then EraseFile( NombreFichero, False );  // No pienso dejar un fichero incorrecto por ahí
         Error := True;
         If   not ( E is EAbort )
         then ShowNotification( ntError, RsMsg6, RsMsg7 );
         end;
       end;

       end;
end;


procedure TRptRrpForm.ReportBeforeStart;
begin
     DocumentoTable := Report.CreateEmptyTable( 'Documento', DataModule10.SQLSet );
     DocumentoFields := TDocumentoFields.Create( DocumentoTable );
     SeleccionaRegistros;
end;

procedure TRptRrpForm.ReportSelectPrinter;
begin
     Report.ReportPrinter := InformeExterno.Impresora;
end;

procedure TRptRrpForm.ReportSetReportName;
begin
     Report.FileName := InformeExterno.Fichero;
end;

procedure TRptRrpForm.SoporteMagneticoCtrlPropertiesChange(Sender: TObject);
begin
     ActualizaEstado;
end;

procedure TRptRrpForm.ActualizaEstado;
begin
     SetGroupBoxControlsEnabled( SoporteMagneticoGroupBox, SoporteMagneticoCtrl.Checked );
     If   SoporteMagneticoGroupBox.Enabled
     then ConceptoOrdenCtrl.Enabled := DataTipoOrden.Value=topTransferenciasChequesSEPA;
     FormatoCtrl.Enabled := not SoporteMagneticoCtrl.Checked;
end;

procedure TRptRrpForm.TipoOrdenCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     OpcionesPC.ActivePageIndex := DataTipoOrden.Value;
end;

procedure TRptRrpForm.TipoOrdenCtrlPropertiesValuePosted(Sender: TObject);
begin
     DataTipoOrden.Value := TipoOrdenCtrl.ItemIndex;
end;

end.
