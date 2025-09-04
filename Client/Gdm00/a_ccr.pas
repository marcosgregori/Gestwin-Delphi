unit a_ccr;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, AppForms, StdCtrls, Buttons, ExtCtrls, Mask,

  AppContainer,
  ComCtrls,
  cxControls,
  cxContainer,
  cxEdit,
  cxTextEdit,
  cxDBEdit,
  DB,
  nxdb,
  DataAccess,
  DataManager,
  dxmdaset,
  Menus,
  cxLookAndFeelPainters,
  cxButtons, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxMaskEdit,
  cxDropDownEdit, cxCheckBox, dxSkinscxPCPainter, cxPC, cxIndexedComboBox,

  cxLookAndFeels, cxLabel, cxGroupBox, dxGDIPlusClasses,
  cxSpinEdit, cxRadioGroup, cxImage, cxMemo, cxPCdxBarPopupMenu,

  dxBarBuiltInMenu, cxScrollBox, cxFontNameComboBox,
  cxDBFontNameComboBox, System.ImageList, Vcl.ImgList, cxImageList,
  cxImageComboBox, cxTrackBar, cxDBTrackBar, cxButtonEdit,

  Gim00Fields, cxGeometry, dxFramedControl, dxPanel, dxUIAClasses;

type

  TOnCheckStoreUser = procedure ( NombreUsuario, Password : String ) of object;

  TMntCcrForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    Panel2: TdxPanel;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    ConfiguracionCorreoTable: TnxeTable;
    DataSource: TDataSource;
    ScrollBox: TcxScrollBox;
    cxGroupBox6: TdxPanel;
    UsuarioCorreoCtrl: TcxDBTextEdit;
    DireccionCorreoCtrl: TcxDBTextEdit;
    Label47: TcxLabel;
    Label48: TcxLabel;
    Label7: TcxLabel;
    FirmaCtrl: TcxDBMemo;
    CrearFirmaButton: TgBitBtn;
    cxLabel8: TcxLabel;
    MensajePruebaButton: TgBitBtn;
    EMailPasswordCtrl: TgxDBPasswordEdit;
    cxGroupBox13: TdxPanel;
    AccesoOAuthPOP3IMAPCtrl: TcxDBCheckBox;
    ClaveSecretaCtrl: TcxDBTextEdit;
    cxLabel11: TcxLabel;
    cxLabel4: TcxLabel;
    IDClienteCtrl: TcxDBTextEdit;
    cxLabel13: TcxLabel;
    ProveedorOAuthCtrl: TcxDBIndexedComboBox;
    cxLabel15: TcxLabel;
    IDInquilinoCtrl: TcxDBTextEdit;
    cxGroupBox14: TdxPanel;
    cxGroupBox5: TdxPanel;
    ServidorPOP3IMAPCtrl: TcxDBTextEdit;
    PuertoPOP3IMAPCtrl: TcxDBSpinEdit;
    ServidorEntranteLabel: TcxLabel;
    Label51: TcxLabel;
    cxLabel10: TcxLabel;
    SeguridadPOP3IMAPCtrl: TcxDBIndexedComboBox;
    cxLabel16: TcxLabel;
    TipoServidorEntranteCtrl: TcxDBIndexedComboBox;
    cxGroupBox4: TdxPanel;
    ServidorSMTPCtrl: TcxDBTextEdit;
    PuertoSMTPCtrl: TcxDBSpinEdit;
    Label45: TcxLabel;
    Label46: TcxLabel;
    SeguridadSMTPCtrl: TcxDBIndexedComboBox;
    cxLabel9: TcxLabel;
    Label2: TcxLabel;
    LabelCtrl6: TcxLabel;
    LabelCtrl1: TcxLabel;
    LabelCtrl5: TcxLabel;
    UsuarioCtrl: TcxDBTextEdit;
    EmpresaCtrl: TcxDBTextEdit;
    ConfiguracionCorreoAuxTable: TnxeTable;
    AccesoOAuthSMTPCtrl: TcxDBCheckBox;
    cxImage2: TcxImage;
    cxLabel6: TcxLabel;
    UsuarioOAuthCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel5: TcxLabel;
    procedure PuertoSMTPCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure PuertoPOP3IMAPCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure CrearFirmaButtonClick(Sender: TObject);
    procedure MensajePruebaButtonClick(Sender: TObject);
    procedure FormManagerInitializeForm;
    procedure EmpresaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure UsuarioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EmpresaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure EmpresaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure UsuarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure UsuarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    function FormManagerCopyCurrentRecord: Boolean;
    procedure SeguridadPOP3IMAPCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure SeguridadSMTPCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure AccesoOAuthPOP3IMAPCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure AccesoOAuthSMTPCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure TipoServidorEntranteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure FormManagerFocusedAreaChanged;
    procedure ConfiguracionCorreoTableNewRecord(DataSet: TDataSet);
  private
    procedure DoOnCopiaRegistro;
    procedure UpdateOAuthState;
    procedure ActualizaSeguridadPOP3IMAP;
    procedure ActualizaSeguridadSMTP;
  public
    ConfiguracionCorreoFields : TConfiguracionCorreoFields;
  end;

var MntCcrForm : TMntCcrForm = nil;

procedure MntConfiguracionCorreo( KeyValues : array of const );

implementation

{$R *.DFM}

uses   nxllUtils,

       LibUtils,

       AppManager,

       Gdm00Dm,
       Gdm00Frm,

       dm_reg,
       dm_pga,
       dm_emp,
       dm_usr,
       dm_iex,

       a_emp,
       a_usr,

       cx_usr,
       cx_emp,

       b_uee,
       b_cda,
       b_msg,
       b_ccr;

resourceString
       RsMsg1 = 'Ya existe un registro con este código de empresa y usuario.';
       RsMsg2 = '¿Desea actualizar el contenido del mismo?';
       RsMsg3 = 'Servidor %s';

procedure MntConfiguracionCorreo( KeyValues : array of const );
begin
     CreateEditForm( TMntCcrForm, MntCcrForm, KeyValues );
end;

function TMntCcrForm.FormManagerCopyCurrentRecord: Boolean;
begin
     CopiaConfiguracionCorreo( DoOnCopiaRegistro );
     // Devolver False indica que el proceso se ha pospuesto al abrir una ventana no modal y, por lo tanto, no se deben realizar las operaciones asociadas a una copia directa
     Result := False;
end;

procedure TMntCcrForm.FormManagerFocusedAreaChanged;
begin
     If   FormManager.DataAreaFocused
     then If   ValueIsEmpty( EmpresaCtrl.EditValue ) and
               ValueIsEmpty( UsuarioCtrl.EditValue )
          then EmpresaCtrl.DoEditing;  // Forzando la activación del modo SetKey
end;

procedure TMntCcrForm.FormManagerInitializeForm;
begin
     ConfiguracionCorreoFields := TConfiguracionCorreoFields.Create( ConfiguracioNCorreoTable );
end;

procedure TMntCcrForm.PuertoPOP3IMAPCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     SetEditValueIfEmpty( PuertoPOP3IMAPCtrl, 110 );
end;

procedure TMntCcrForm.PuertoSMTPCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     SetEditValueIfEmpty( PuertoSMTPCtrl, 25 );
end;

procedure TMntCcrForm.SeguridadPOP3IMAPCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   SeguridadPOP3IMAPCtrl.Editing
     then ActualizaSeguridadPOP3IMAP;
end;

procedure TMntCcrForm.ActualizaSeguridadPOP3IMAP;
begin
     case SeguridadPOP3IMAPCtrl.ItemIndex of
          0 : ConfiguracionCorreoFields.PuertoPOP3IMAP.Value := 110;
       1, 2 : If   TipoServidorEntranteCtrl.ItemIndex=0  // POP3
              then ConfiguracionCorreoFields.PuertoPOP3IMAP.Value := 995
              else ConfiguracionCorreoFields.PuertoPOP3IMAP.Value := 993;
       end;
end;

procedure TMntCcrForm.SeguridadSMTPCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   SeguridadSMTPCtrl.Editing
     then ActualizaSeguridadSMTP;
end;

procedure TMntCcrForm.ActualizaSeguridadSMTP;
begin
     case SeguridadSMTPCtrl.ItemIndex of
       0 : ConfiguracionCorreoFields.PuertoSMTP.Value := 25;
       1 : ConfiguracionCorreoFields.PuertoSMTP.Value := 465;
       2 : ConfiguracionCorreoFields.PuertoSMTP.Value := 587;
       end;
end;

procedure TMntCcrForm.TipoServidorEntranteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ServidorEntranteLabel.Caption := Format( RsMsg3, [ TipoServidorEntranteCtrl.Text ] );
     UpdateOAuthState;  // Un punto para actualizar el estado de los componentes durante la validación de la ficha
end;

procedure TMntCcrForm.UsuarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntUsuarios( [ Sender.EditingValue ] );
end;

procedure TMntCcrForm.UsuarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUsuarios( Sender );
end;

procedure TMntCcrForm.UsuarioCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     With Sender do
       If   DisplayValue=''
       then Description := RsgCualquiera
       else Usuario.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCcrForm.UpdateOAuthState;
begin

     var OAuthEnabled := AccesoOAuthPOP3IMAPCtrl.Checked or AccesoOAuthSMTPCtrl.Checked;
     var EMailEnabled := not AccesoOAuthPOP3IMAPCtrl.Checked or not AccesoOAuthSMTPCtrl.Checked;

     ProveedorOAuthCtrl.Enabled := OAuthEnabled;
     IDClienteCtrl.Enabled := OAuthEnabled;
     IDInquilinoCtrl.Enabled := OAuthEnabled and ( ProveedorOAuthCtrl.ItemIndex=1 );
     ClaveSecretaCtrl.Enabled := OAuthEnabled;
     UsuarioCorreoCtrl.Enabled := EMailEnabled;
     EMailPasswordCtrl.Enabled := EMailEnabled;
     SeguridadPOP3IMAPCtrl.Enabled := not AccesoOAuthPOP3IMAPCtrl.Checked;
     SeguridadSMTPCtrl.Enabled := not AccesoOAuthSMTPCtrl.Checked;
end;

procedure TMntCcrForm.AccesoOAuthPOP3IMAPCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   AccesoOAuthPOP3IMAPCtrl.Editing and AccesoOAuthPOP3IMAPCtrl.Checked
     then begin
          SeguridadPOP3IMAPCtrl.EditValue := 2;  // STARTTLS
          ActualizaSeguridadPOP3IMAP;
          end;
     UpdateOAuthState;
end;

procedure TMntCcrForm.AccesoOAuthSMTPCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   AccesoOAuthSMTPCtrl.Editing and AccesoOAuthSMTPCtrl.Checked
     then begin
          SeguridadSMTPCtrl.EditValue := 2;      // STARTTLS
          ActualizaSeguridadSMTP;
          end;
     UpdateOAuthState;
end;

procedure TMntCcrForm.ConfiguracionCorreoTableNewRecord(DataSet: TDataSet);
begin
     With ConfiguracionCorreoFields do
       begin
       SeguridadPOP3IMAP.Value := 0;
       SeguridadSMTP.Value := 0;
       end;
end;

procedure TMntCcrForm.CrearFirmaButtonClick(Sender: TObject);
begin
     With DataModule00.DmEmpresaFields do
       ExportImport.CreaFirma( FirmaCtrl, Nombre.Value, ConfiguracionCorreoFields.Direccion.Value );
end;

procedure TMntCcrForm.EmpresaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntEmpresas( [ Sender.EditingValue ] );
end;

procedure TMntCcrForm.EmpresaCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaEmpresas( Sender );
end;

procedure TMntCcrForm.EmpresaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean );
begin
    With Sender do
       If   DisplayValue=''
       then Description := RsgCualquiera
       else Empresa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCcrForm.MensajePruebaButtonClick(Sender: TObject);
begin
     If   ConfiguracionCorreoTable.Modified
     then ConfiguracionCorreoTable.PostAndEdit;
     If   ExportImport.EnviaMensajePrueba( ConfiguracionCorreoTable )
     then ShowNotification( ntInformation, RsMensajeEnviadoCorrectamente );
end;

procedure TMntCcrForm.DoOnCopiaRegistro;

var  CodigoEmpresa,
     CodigoUsuario : String;

begin

     CodigoEmpresa := BoxCcrForm.DataCodigoEmpresa.Value;
     CodigoUsuario := BoxCcrForm.DataCodigoUsuario.Value;

     try

       ConfiguracionCorreoTable.DisableControls;

       If   ConfiguracionCorreoAuxTable.FindKey( [ CodigoEmpresa, CodigoUsuario ] )
       then begin
            If   ShowNotification( ntQuestionWarning, RsMsg1, RsMsg2 )=mrYes
            then begin
                 var FieldValues := ConfiguracionCorreoAuxTable.GetFieldValues;
                 ConfiguracionCorreoTable.SetFieldValues( FieldValues );
                 ConfiguracionCorreoTable.SetIndexValues( FieldValuesArray( [ CodigoEmpresa, CodigoUsuario ] ) );
                 end;
            end
       else ConfiguracionCorreoTable.CloneRecord( [ CodigoEmpresa, CodigoUsuario ] );

       ConfiguracionCorreoTable.FindKey( [ CodigoEmpresa, CodigoUsuario ] );

     finally
       ConfiguracionCorreoTable.EnableControls;
       ConfiguracionCorreoTable.Cancel;
       FormManager.SelectFirstKeyControl;
       end;

end;

initialization

end.
