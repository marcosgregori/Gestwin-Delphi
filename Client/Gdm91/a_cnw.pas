unit a_cnw;

interface

uses Forms, ComCtrls, AppForms, StdCtrls, Buttons, Mask, Controls,
  Classes, ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxMemo, cxDBEdit, cxCheckBox, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxPC, cxControls, cxContainer, cxEdit, cxTextEdit,

  cxGraphics, cxIndexedComboBox, cxRichEdit, cxDBRichEdit,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels,
  cxLabel, cxGroupBox, cxPCdxBarPopupMenu, dxBarBuiltInMenu,

  Gim90Fields, dxUIAClasses;

type
  TMntCnWForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    ContactoWebTable: TnxeTable;
    dataPanel: TgxEditPanel;
    DataSource: TDataSource;
    PageControl1: TcxPageControl;
    TabSheet1: TcxTabSheet;
    DomicilioCtrl: TcxDBTextEdit;
    LocalidadCtrl: TcxDBTextEdit;
    TelefonoCtrl: TcxDBTextEdit;
    EMailCtrl: TcxDBTextEdit;
    CodigoProvinciaCtrl: TcxDBTextEdit;
    CodigoPostalCtrl: TcxDBTextEdit;
    PrimerContactoCtrl: TcxDBDateEdit;
    EmpresaCtrl: TcxDBTextEdit;
    DistribuidorCtrl: TcxDBCheckBox;
    PersonaContactoCtrl: TcxDBTextEdit;
    CargoCtrl: TcxDBTextEdit;
    TabSheet4: TcxTabSheet;
    InteresadoContableCtrl: TcxDBCheckBox;
    CopiaEvaluacionCtrl: TcxDBCheckBox;
    AplicacionEvaluacionCtrl: TcxDBIndexedComboBox;
    TabSheet3: TcxTabSheet;
    cxTabSheet1: TcxTabSheet;
    InteresadoComercialCtrl: TcxDBCheckBox;
    InteresadoContableComercialCtrl: TcxDBCheckBox;
    InteresadoTPVCtrl: TcxDBCheckBox;
    InteresadoPreventaCtrl: TcxDBCheckBox;
    FechaEnvioEvaluacionCtrl: TcxDBDateEdit;
    EnviarBtn2: TgBitBtn;
    FechaEnvioRecordatorioCtrl: TcxDBDateEdit;
    EnviarBtn3: TgBitBtn;
    FechaEnvioOfertaCtrl: TcxDBDateEdit;
    EnviarBtn4: TgBitBtn;
    FechaCompraCtrl: TcxDBDateEdit;
    CodigoGestionCtrl: TcxDBTextEdit;
    NotasCtrl: TcxDBRichEdit;
    AnotacionButton: TgBitBtn;
    ComentariosCtrl: TcxDBRichEdit;
    ComentariosBtn: TgBitBtn;
    Panel1: TcxGroupBox;
    NombreCtrl: TcxDBTextEdit;
    codigoCtrlCaption: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label12: TcxLabel;
    Label13: TcxLabel;
    Label15: TcxLabel;
    DescCPLabel: TcxLabel;
    Label7: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label9: TcxLabel;
    Label8: TcxLabel;
    Label10: TcxLabel;
    Label11: TcxLabel;
    Label14: TcxLabel;
    Label16: TcxLabel;
    Label17: TcxLabel;
    Label18: TcxLabel;
    Label19: TcxLabel;
    Label21: TcxLabel;
    Label20: TcxLabel;
    NombreLabel: TcxLabel;
    Label1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    FechaEnvioDemoVirtualUICtrl: TcxDBDateEdit;
    EnviarBtn1: TgBitBtn;
    cxLabel1: TcxLabel;
    procedure FormManagerReportRequest;
    procedure FormManagerLabelsRequest;
    procedure CodigoProvinciaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerInitializeForm;
    procedure CodigoGestionCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoGestionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoGestionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure DistribuidorCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ContactoWebTableNewRecord(DataSet: TDataSet);
    procedure AnotacionButtonClick(Sender: TObject);
    procedure ComentariosBtnClick(Sender: TObject);
    procedure EnviarBtn2Click(Sender: TObject);
    procedure ContactoWebTableUpdateState(DataSet: TDataSet);
    procedure CopiaEvaluacionCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure EnviarBtn3Click(Sender: TObject);
    procedure EnviarBtn4Click(Sender: TObject);
    procedure CodigoProvinciaCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure EnviarBtn1Click(Sender: TObject);
  private
    ContactoWebFields : TContactoWebFields;

    procedure ActualizaEstadoBotones;
    function ObtenNombreAplicacion( Value : SmallInt ) : String;
  public

  end;

var  MntCnWForm: TMntCnWForm = nil;

procedure MntContactosWeb( keyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       EnterpriseDataAccess,

       Gdm00Dm,

       dm_pai,
       dm_prv,
       dm_cop,
       dm_cli,
       dm_iex,
       dm_cnw,

       b_msg,
       bx_not,

       a_prv,
       a_cop,
       a_cli,

       cx_pai,
       cx_cnw,
       cx_prv,
       cx_cop,
       cx_cli,

       l_cnw,
       e_cnw;

procedure MntContactosWeb( keyValues : array of const );
begin
     CreateEditForm( TMntCnwForm, MntCnwForm, keyValues );
end;

procedure TMntCnWForm.AnotacionButtonClick(Sender: TObject);
begin
     MntAnotacion( ContactoWebFields.Notas );
end;

procedure TMntCnWForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaContactosWeb( Sender, qgsLinked );
end;

procedure TMntCnWForm.CodigoGestionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] ) ;
end;

procedure TMntCnWForm.CodigoGestionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TMntCnWForm.CodigoGestionCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCnWForm.CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With ContactoWebFields do
       MntCodigosPostales( [ CodigoEspaña, CodigoProvincia.Value, Sender.EditingValue ] );
end;

procedure TMntCnWForm.CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With ContactoWebFields do
       ConsultaCodigosPostales( CodigoEspaña, CodigoProvincia.Value, Sender );
end;

procedure TMntCnWForm.CodigoPostalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( CodigoEspaña, ContactoWebFields.CodigoProvincia.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCnWForm.CodigoProvinciaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With ContactoWebFields do
       MntProvincias( [ CodigoEspaña, Sender.EditingValue ] );
end;

procedure TMntCnWForm.CodigoProvinciaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   CodigoProvinciaCtrl.Editing
     then CodigoPostalCtrl.PostEditValue( '' );    
end;

procedure TMntCnWForm.CodigoProvinciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( CodigoEspaña, Sender );
end;

procedure TMntCnWForm.CodigoProvinciaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( CodigoEspaña, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCnWForm.ContactoWebTableNewRecord(DataSet: TDataSet);
begin
     ContactoWebFields.PrimerContacto.Value := ApplicationContainer.TodayDate;
end;

procedure TMntCnWForm.ContactoWebTableUpdateState(DataSet: TDataSet);
begin
     ActualizaEstadoBotones;
end;

procedure TMntCnWForm.ActualizaEstadoBotones;
begin
     EnviarBtn1.Enabled := ( ContactoWebTable.State in [ dsBrowse, dsEdit ] ) and ( CopiaEvaluacionCtrl.Checked ) and not ValueIsEmpty( EMailCtrl.EditValue );
     EnviarBtn2.Enabled := EnviarBtn1.Enabled;
     EnviarBtn3.Enabled := EnviarBtn1.Enabled;
     EnviarBtn4.Enabled := EnviarBtn1.Enabled;
end;

procedure TMntCnWForm.CopiaEvaluacionCtrlPropertiesEditValueChanged( Sender: TObject);
begin
     AplicacionEvaluacionCtrl.Enabled := CopiaEvaluacionCtrl.Checked;
     ActualizaEstadoBotones;
end;

procedure TMntCnWForm.DistribuidorCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     PersonaContactoCtrl.Enabled := DistribuidorCtrl.Checked;
     CargoCtrl.Enabled := DistribuidorCtrl.Checked;
end;

procedure TMntCnWForm.FormManagerReportRequest;
begin
     ListadoContactosWeb;
end;

function TMntCnWForm.ObtenNombreAplicacion( Value : SmallInt ) : String;
begin
     case Value of
       0 : Result := 'Contable';
       1 : Result := 'Comercial';
       2 : Result := 'ContableComercial';
       3 : Result := 'TPV';
       4 : Result := 'Preventa';
       end
end;

procedure TMntCnWForm.EnviarBtn1Click(Sender: TObject);
begin
     try
       Enabled := False;
       If   ContactoWeb.EnviaCorreo( ContactoWebFields,
                                     'DemoVirtualUI',
                                     'GESTWIN %s - Solicitud de prueba de GESTWIN Virtual UI',
                                     rmSoporte )
       then begin
            ContactoWebFields.FechaEnvioDemoVirtualUI.Value := ApplicationContainer.TodayDate;
            ContactoWebTable.Post;
            end;
     finally
       Enabled := True;
       FormManager.SelectFirstKeyControl;
     end;

end;

procedure TMntCnWForm.EnviarBtn2Click(Sender: TObject);
begin
     try
       Enabled := False;
       If   ContactoWeb.EnviaCorreo( ContactoWebFields,
                                     'CopiaEvaluacion',
                                     'GESTWIN %s - Solicitud de copia de evaluación',
                                     rmSoporte )
       then begin
            ContactoWebFields.FechaEnvioEvaluacion.Value := ApplicationContainer.TodayDate;
            ContactoWebTable.Post;
            end;
     finally
       Enabled := True;
       FormManager.SelectFirstKeyControl;
     end;

end;


procedure TMntCnWForm.EnviarBtn3Click(Sender: TObject);
begin
     try
       Enabled := False;
       If   ContactoWeb.EnviaCorreo( ContactoWebFields,
                                     'Recordatorio',
                                     'GESTWIN %s - Recordatorio',
                                     rmSoporte )
       then begin
            ContactoWebFields.FechaEnvioRecordatorio.Value := ApplicationContainer.TodayDate;
            ContactoWebTable.Post;
            end;
     finally
       Enabled := True;
       FormManager.SelectFirstKeyControl;
     end;
end;

procedure TMntCnWForm.EnviarBtn4Click(Sender: TObject);
begin
     try
       Enabled := False;
       If   ContactoWeb.EnviaCorreo( ContactoWebFields,
                                     'Oferta',
                                     'GESTWIN %s - Oferta',
                                     rmVentas )
       then begin
            ContactoWebFields.FechaEnvioOferta.Value := ApplicationContainer.TodayDate;
            ContactoWebTable.Post;
            end;
     finally
       Enabled := True;
       FormManager.SelectFirstKeyControl;
     end;
end;

procedure TMntCnWForm.ComentariosBtnClick(Sender: TObject);
begin
     MntAnotacion( ContactoWebFields.Comentarios );
end;

procedure TMntCnWForm.FormManagerInitializeForm;
begin
     ContactoWebFields := TContactoWebFields.Create( ContactoWebTable );
end;

procedure TMntCnWForm.FormManagerLabelsRequest;
begin
     EtiquetasContactosWeb( ContactoWebFields.Codigo.Value );
end;

end.
