unit a_ban;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxPC, DB, nxdb, DataManager,
  cxMaskEdit, cxSpinEdit, cxCurrencyEdit, dxSkinsCore, dxSkinscxPCPainter,
  cxGraphics, cxLookAndFeels, cxGroupBox, dxSkinsDefaultPainters, cxLabel,
  f_not, cxPCdxBarPopupMenu,

  Gim10Fields, dxBarBuiltInMenu, dxUIAClasses;

type
  TMntBanForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    dataPanel: TgxEditPanel;
    PageControl1: TcxPageControl;
    DatosGeneralesTS: TcxTabSheet;
    AdeudosYAbonosTS: TcxTabSheet;
    SubcuentaCtrl: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    BancoTable: TnxeTable;
    BancoDataSource: TDataSource;
    cxGroupBox1: TcxGroupBox;
    NombreCtrl: TcxDBTextEdit;
    DomicilioCtrl: TcxDBTextEdit;
    LocalidadCtrl: TcxDBTextEdit;
    CodigoPostalCtrl: TcxDBTextEdit;
    CodigoProvinciaCtrl: TcxDBTextEdit;
    cxGroupBox2: TcxGroupBox;
    Subcuenta_RiesgoCtrl: TcxDBTextEdit;
    Subcuenta_InteresesCtrl: TcxDBTextEdit;
    RiesgoCtrl: TcxDBCurrencyEdit;
    cxGroupBox3: TcxGroupBox;
    FormatoCtrl: TcxDBSpinEdit;
    cxGroupBox4: TcxGroupBox;
    DiasCancelacion58Ctrl: TcxDBSpinEdit;
    cxGroupBox5: TcxGroupBox;
    Adeudos_PresentadorCtrl: TcxDBTextEdit;
    Adeudos_NIFCtrl: TcxDBTextEdit;
    cxGroupBox6: TcxGroupBox;
    Shape1: TShape;
    Adeudos_EntidadRecCtrl: TcxDBTextEdit;
    Adeudos_OficinaRecCtrl: TcxDBTextEdit;
    Adeudos_DCDepositoCtrl: TcxDBTextEdit;
    Adeudos_EntidadDepCtrl: TcxDBTextEdit;
    Adeudos_OficinaDepCtrl: TcxDBTextEdit;
    Adeudos_CuentaDepCtrl: TcxDBTextEdit;
    Adeudos_DCAdeudosCtrl: TcxDBTextEdit;
    Adeudos_EntidadAdeCtrl: TcxDBTextEdit;
    Adeudos_OficinaAdeCtrl: TcxDBTextEdit;
    Adeudos_CuentaAdeCtrl: TcxDBTextEdit;
    Adeudos_DCImpagadosCtrl: TcxDBTextEdit;
    Adeudos_EntidadImpCtrl: TcxDBTextEdit;
    Adeudos_OficinaImpCtrl: TcxDBTextEdit;
    Adeudos_CuentaImpCtrl: TcxDBTextEdit;
    cxGroupBox7: TcxGroupBox;
    Adeudos_CodigoINECtrl: TcxDBTextEdit;
    Adeudos_SufijoCICtrl: TcxDBTextEdit;
    Adeudos_CICCtrl: TcxDBTextEdit;
    cxGroupBox8: TcxGroupBox;
    Abonos_CICtrl: TcxDBTextEdit;
    Abonos_DCCICtrl: TcxDBTextEdit;
    Abonos_CICCtrl: TcxDBTextEdit;
    codigoCtrlCaption: TcxLabel;
    Label5: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label20: TcxLabel;
    DescProvinciaLabel: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label26: TcxLabel;
    DescFormatoLabel: TcxLabel;
    Label32: TcxLabel;
    Label11: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    Label15: TcxLabel;
    Label16: TcxLabel;
    Label17: TcxLabel;
    Label18: TcxLabel;
    Label19: TcxLabel;
    Label21: TcxLabel;
    Label22: TcxLabel;
    Label23: TcxLabel;
    Label24: TcxLabel;
    Label25: TcxLabel;
    Label35: TcxLabel;
    Label36: TcxLabel;
    AnotacionesTS: TcxTabSheet;
    AnnotationFrame: TAnnotationFrame;
    DiasCancelacion19Ctrl: TcxDBSpinEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel5: TcxLabel;
    DiasCancelacion32Ctrl: TcxDBSpinEdit;
    DiasCancelacionCtrl: TcxDBSpinEdit;
    cxLabel3: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    cxLabel9: TcxLabel;
    EntidadDep_DCIBANCtrl: TcxTextEdit;
    EntidadAde_DCIBANCtrl: TcxTextEdit;
    EntidadImp_DCIBANCtrl: TcxTextEdit;
    cxLabel4: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure SubcuentaEditRequest(Sender: TcxCustomEdit);
    procedure SubcuentaQueryRequest(Sender: TcxCustomEdit);
    procedure SubcuentaValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure BancoTableNewRecord(DataSet: TDataSet);
    procedure SubcuentaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoProvinciaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Adeudos_EntidadRecCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure Adeudos_OficinaRecCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure SubcuentaCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure Subcuenta_RiesgoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure Subcuenta_InteresesCtrlPropertiesEnter(
      Sender: TcxCustomEdit);
    procedure Adeudos_CodigoINECtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Abonos_DCCICtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Adeudos_EntidadRecCtrllPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure EntidadCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure EntidadCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Adeudos_EntidadDepCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Adeudos_EntidadAdeCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Adeudos_EntidadImpCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Adeudos_DepositoPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Adeudos_AdeudosPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Adeudos_ImpagadosPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Adeudos_DCDepositoCtrlPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    procedure Adeudos_DCAdeudosCtrlPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    procedure Adeudos_DCImpagadosCtrlPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    procedure Adeudos_EntidadDepCtrlPropertiesValuePosted(Sender: TObject);
    procedure Adeudos_EntidadAdeCtrlPropertiesValuePosted(Sender: TObject);
    procedure Adeudos_EntidadImpCtrlPropertiesValuePosted(Sender: TObject);
    procedure CodigoProvinciaCtrlPropertiesEditValueChanged(Sender: TObject);
  private
     BancoFields : TBancoFields;
     DsCuentaFields : TCuentaFields;
  public

  end;

var  MntBanForm: TMntBanForm = nil;

procedure MntBancos( KeyValues : array of const );

implementation

{$R *.dfm}

uses   LibUtils,
       Variants,
       SysUtils,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm10Frm,

       dm_sub,
       dm_prv,
       dm_ban,
       dm_ine,
       dm_cop,
       dm_pai,
       dm_enf,

       a_sub,
       a_prv,
       a_imp,
       a_cop,
       a_enf,

       cx_imp,
       cx_sub,
       cx_prv,
       cx_ban,
       cx_cop,
       cx_enf,

       l_ban;

resourceString
       RsMsg1   = 'Debe introducir subcuentas incluídas en el grupo 5 - Cuentas financieras.';
       RsMsg2   = 'Para poder crear una ficha de entidad financiera debe existir la subcuenta correspondiente.';
       RsMsg3   = 'Utilice la tecla [F3] para acceder al mantenimiento de subcuentas y darla de alta.';
       RsMsg4   = 'La longitud del código INE debe ser necesariamente de 9 dígitos';
       RsMsg5   = 'El formato es PPMMMCCSS donde P=Provincia, M=Municipio, C=Entidad colectiva y S=Entidad singular.';
       RsMsg6   = 'El dígito de control del código de identificación no es correcto.';
       RsMsg7   = 'Si no conoce el valor del dígito de control introduzca un asterisco (*) para que la aplicación lo calcule.';


procedure MntBancos( KeyValues : array of const );
begin
     CreateEditForm( TmntBanForm, mntBanForm, KeyValues, TGds10Frm.CobrosPagosSection );
end;

procedure TMntBanForm.FormManagerInitializeForm;
begin
     BancoFields := TBancoFields.Create( BancoTable );
     DsCuentaFields := TCuentaFields.Create( Self );

     SetEditControlDecimals( RiesgoCtrl );
     BancoFields.Abonos_CI.ValidChars := NumericCharSet;
     // Abonos_CICtrl.Properties.ValidChars := NumericCharSet;
end;

procedure TMntBanForm.FormManagerReportRequest;
begin
     ListadoBancos;
end;

procedure TMntBanForm.SubcuentaQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True );
end;

procedure TMntBanForm.SubcuentaValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntBanForm.Subcuenta_InteresesCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With Subcuenta_InteresesCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '6653' + Copy( SubcuentaCtrl.EditValue, 5, 5 );
end;

procedure TMntBanForm.Subcuenta_RiesgoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With Subcuenta_RiesgoCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '5208' + Copy( SubcuentaCtrl.EditValue, 5, 5 );
end;

procedure TMntBanForm.SubcuentaCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With SubcuentaCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '572';
end;

procedure TMntBanForm.SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaBancos( Sender, qgsLinked );
end;

procedure TMntBanForm.SubcuentaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  CodigoSubcuenta : String;

begin
     CodigoSubcuenta := VarToStr( DisplayValue );
     If   Copy( CodigoSubcuenta, 1, 1 )<>'5'
     then begin
          Error := True;
          ErrorText := RsMsg1;
          end
     else begin
          Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, DsCuentaFields );
          If   Error
          then ErrorText := JoinMessage( RsMsg2, RsMsg3 );
          end;
end;

procedure TMntBanForm.SubcuentaEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntBanForm.FormatoCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impDocumentoPago ), Sender.EditingValue ] );
end;

procedure TMntBanForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impDocumentoPago, Sender );
end;

procedure TMntBanForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impDocumentoPago, Sender, DisplayValue, ErrorText, Error );
end;

function TMntBanForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.acPCFicheros.Value;
end;

procedure TMntBanForm.Abonos_DCCICtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  CurrentValue,
     StrDCCI : String;

begin
     With Sender do
       If   Editing
       then begin
            CurrentValue := VarToStr( DisplayValue );
            StrDCCI := CalculaDCCI( VarToStr( Abonos_CICtrl.EditValue ) );
            If   CurrentValue='*'
            then DisplayValue := StrDCCI
            else If   CurrentValue<>StrDCCI
                 then begin
                      Error := True;
                      ErrorText := JoinMessage( RsMsg6, RsMsg7 );
                      end;
            end;
end;

procedure TMntBanForm.Adeudos_CodigoINECtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then If   System.Length( VarToStr( DisplayValue ) )<>9
          then begin
               Error := True;
               ErrorText := JoinMessage( RsMsg4, RsMsg5 );
               end;
end;

procedure TMntBanForm.EntidadCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntEntidadesFinancieras( [ Sender.EditingValue ] );
end;

procedure TMntBanForm.Adeudos_EntidadRecCtrlPropertiesEditValueChanged(Sender: TObject);

var  EntidadValue : String;

begin
     With Adeudos_EntidadRecCtrl do
       If   Editing
       then begin
            EntidadValue := VarToStr( EditValue );
            Adeudos_EntidadDepCtrl.PostValueIfEmpty( EntidadValue );
            Adeudos_EntidadAdeCtrl.PostValueIfEmpty( EntidadValue );
            Adeudos_EntidadImpCtrl.PostValueIfEmpty( EntidadValue );
            end;
end;

procedure TMntBanForm.EntidadCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEntidadesFinancieras( Sender );
end;

procedure TMntBanForm.Adeudos_EntidadAdeCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     EntidadFinanciera.Valida(Sender, DisplayValue, ErrorText, Error );
     If   not Error
     then EntidadFinanciera.CompletaValidacion( DisplayValue, Adeudos_EntidadAdeCtrl, Adeudos_OficinaAdeCtrl, Adeudos_CuentaAdeCtrl, Adeudos_DCAdeudosCtrl );
end;

procedure TMntBanForm.Adeudos_EntidadAdeCtrlPropertiesValuePosted(Sender: TObject);
begin
     With BancoFields do
       begin
       Adeudos_OficinaDep.Clear;
       Adeudos_DCDeposito.Clear;
       Adeudos_CuentaDep.Clear;
       end;
end;

procedure TMntBanForm.Adeudos_EntidadDepCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     EntidadFinanciera.Valida(Sender, DisplayValue, ErrorText, Error );
     If   not Error
     then EntidadFinanciera.CompletaValidacion( DisplayValue, Adeudos_EntidadDepCtrl, Adeudos_OficinaDepCtrl, Adeudos_CuentaDepCtrl, Adeudos_DCDepositoCtrl );
end;

procedure TMntBanForm.Adeudos_EntidadDepCtrlPropertiesValuePosted(Sender: TObject);
begin
     With BancoFields do
       begin
       Adeudos_OficinaAde.Clear;
       Adeudos_DCAdeudos.Clear;
       Adeudos_CuentaAde.Clear;
       end;
end;

procedure TMntBanForm.Adeudos_EntidadImpCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     EntidadFinanciera.Valida(Sender, DisplayValue, ErrorText, Error );
     If   not Error
     then EntidadFinanciera.CompletaValidacion( DisplayValue, Adeudos_EntidadImpCtrl, Adeudos_OficinaImpCtrl, Adeudos_CuentaImpCtrl, Adeudos_DCImpagadosCtrl );
end;

procedure TMntBanForm.Adeudos_EntidadImpCtrlPropertiesValuePosted(Sender: TObject);
begin
     With BancoFields do
       begin
       Adeudos_OficinaImp.Clear;
       Adeudos_DCImpagados.Clear;
       Adeudos_CuentaImp.Clear;
       end;
end;

procedure TMntBanForm.Adeudos_EntidadRecCtrllPropertiesValidate( Sender : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean );
begin
     EntidadFinanciera.Valida(Sender, DisplayValue, ErrorText, Error );
     If   not Error
     then EntidadFinanciera.CompletaValidacion( DisplayValue, Adeudos_EntidadRecCtrl, Adeudos_OficinaRecCtrl );
end;

procedure TMntBanForm.Adeudos_DCAdeudosCtrlPropertiesExtendedFunction( Sender: TcxCustomEdit);
begin
     Banco.GeneraDC( BancoFields.Adeudos_EntidadAde.Value, Adeudos_OficinaAdeCtrl, Adeudos_DCAdeudosCtrl, Adeudos_CuentaAdeCtrl );
end;

procedure TMntBanForm.Adeudos_DCDepositoCtrlPropertiesExtendedFunction( Sender: TcxCustomEdit);
begin
     Banco.GeneraDC( BancoFields.Adeudos_EntidadDep.Value, Adeudos_OficinaDepCtrl, Adeudos_DCDepositoCtrl, Adeudos_CuentaDepCtrl );
end;

procedure TMntBanForm.Adeudos_DCImpagadosCtrlPropertiesExtendedFunction(Sender: TcxCustomEdit);
begin
     Banco.GeneraDC( BancoFields.Adeudos_EntidadImp.Value, Adeudos_OficinaImpCtrl, Adeudos_DCImpagadosCtrl, Adeudos_CuentaImpCtrl );
end;

procedure TMntBanForm.Adeudos_DepositoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Banco.ValidaDC( EntidadDep_DCIBANCtrl, Adeudos_EntidadDepCtrl, Adeudos_OficinaDepCtrl, Adeudos_DCDepositoCtrl, Adeudos_CuentaDepCtrl, DisplayValue, ErrorText, Error );
end;

procedure TMntBanForm.Adeudos_AdeudosPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Banco.ValidaDC( EntidadAde_DCIBANCtrl, Adeudos_EntidadAdeCtrl, Adeudos_OficinaAdeCtrl, Adeudos_DCAdeudosCtrl, Adeudos_CuentaAdeCtrl, DisplayValue, ErrorText, Error );
end;

procedure TMntBanForm.Adeudos_ImpagadosPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Banco.ValidaDC( EntidadImp_DCIBANCtrl, Adeudos_EntidadImpCtrl, Adeudos_OficinaImpCtrl, Adeudos_DCImpagadosCtrl, Adeudos_CuentaImpCtrl, DisplayValue, ErrorText, Error );
end;

procedure TMntBanForm.Adeudos_OficinaRecCtrlPropertiesEditValueChanged( Sender: TObject);

var  OficinaValue : String;

begin
     With Adeudos_OficinaRecCtrl do
       If   Editing
       then begin
            OficinaValue := VarToStr( EditValue );
            Adeudos_OficinaDepCtrl.PostValueIfEmpty( OficinaValue );
            Adeudos_OficinaAdeCtrl.PostValueIfEmpty( OficinaValue );
            Adeudos_OficinaImpCtrl.PostValueIfEmpty( OficinaValue );
            end;
end;

procedure TMntBanForm.BancoTableNewRecord(DataSet: TDataSet);
begin
     BancoFields.Nombre.Value := DsCuentaFields.Descripcion.Value;
     BancoFields.CodigoPais.Value := CodigoEspaña;
end;

procedure TMntBanForm.CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosPostales( [ CodigoEspaña, BancoFields.CodigoProvincia.Value, Sender.EditingValue ] );
end;

procedure TMntBanForm.CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( CodigoEspaña, BancoFields.CodigoProvincia.Value, Sender );
end;

procedure TMntBanForm.CodigoPostalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( CodigoEspaña, BancoFields.CodigoProvincia.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntBanForm.CodigoProvinciaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProvincias( [ CodigoEspaña, Sender.EditingValue ] );
end;

procedure TMntBanForm.CodigoProvinciaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   CodigoProvinciaCtrl.Editing
     then CodigoPostalCtrl.PostEditValue( '' );
end;

procedure TMntBanForm.CodigoProvinciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( CodigoEspaña, Sender );
end;

procedure TMntBanForm.CodigoProvinciaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( CodigoEspaña, Sender, DisplayValue, ErrorText, Error );
end;

end.
