unit a_emp;

interface

uses Forms, AppForms, ExtCtrls, StdCtrls, Buttons, Mask, Controls, Classes, sysUtils,
     Tabs, TabNotBk, ComCtrls, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxMaskEdit,
     DB, nxdb, cxPC, Menus, cxLookAndFeelPainters, cxButtons,

     DataManager, AppContainer, cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters,
     dxSkinscxPCPainter, cxGraphics, cxLookAndFeels, cxGroupBox, cxLabel,
     dxGDIPlusClasses, cxImage, cxSpinEdit, cxTimeEdit, cxCheckGroup, cxDBCheckGroup, cxPCdxBarPopupMenu,

     Gim00Fields, dxBarBuiltInMenu, cxScrollBox, dxUIAClasses,
  cxDropDownEdit, cxIndexedComboBox;

type
  TMntEmpForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    EmpresaTable: TnxeTable;
    DataSource: TDataSource;
    PageControl: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    NombreCtrl: TcxDBTextEdit;
    DomicilioCtrl: TcxDBTextEdit;
    LocalidadCtrl: TcxDBTextEdit;
    codigoPostalCtrl: TcxDBTextEdit;
    NIFCtrl: TcxDBTextEdit;
    TelefonoCtrl: TcxDBTextEdit;
    FaxCtrl: TcxDBTextEdit;
    CodigoProvinciaCtrl: TcxDBTextEdit;
    CodigoPaisCtrl: TcxDBTextEdit;
    cxGroupBox1: TcxGroupBox;
    Label2: TcxLabel;
    Label3: TcxLabel;
    cxGroupBox2: TcxGroupBox;
    DataPathCtrl: TcxDBTextEdit;
    examinarButton: TgBitBtn;
    codigoCtrlCaption: TcxLabel;
    nombreCtrlCaption: TcxLabel;
    DomicilioCtrlCaption: TcxLabel;
    LocalidadCtrlCaption: TcxLabel;
    descProvinciaLabel: TcxLabel;
    TelefonoCtrlCaption: TcxLabel;
    FaxCtrlCaption: TcxLabel;
    CPCtrlCaption: TcxLabel;
    NIFCtrlCaption: TcxLabel;
    Label8: TcxLabel;
    descPaisLabel: TcxLabel;
    DirectorioLabel: TcxLabel;
    cxTabSheet3: TcxTabSheet;
    Image8: TcxImage;
    cxDBCheckGroup1: TcxDBCheckGroup;
    cxGroupBox4: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    gxRangeBox1: TgxRangeBox;
    InicioJornadaLaboralCtrl: TcxDBTimeEdit;
    FinJornadaLaboralCtrl: TcxDBTimeEdit;
    cxGroupBox5: TcxGroupBox;
    cxLabel5: TcxLabel;
    DescNIF: TcxLabel;
    CodigoEANCtrl: TcxDBTextEdit;
    cxLabel4: TcxLabel;
    cxGroupBox6: TcxGroupBox;
    cxImage1: TcxImage;
    cxLabel7: TcxLabel;
    PersonaConQuienRelacionarseCtrl: TcxDBTextEdit;
    cxGroupBox7: TcxGroupBox;
    cxImage2: TcxImage;
    Registro_LibroCtrl: TcxDBTextEdit;
    cxLabel13: TcxLabel;
    cxLabel14: TcxLabel;
    Registro_RegistroMercantilCtrl: TcxDBTextEdit;
    cxLabel15: TcxLabel;
    Registro_HojaCtrl: TcxDBTextEdit;
    cxLabel16: TcxLabel;
    Registro_FolioCtrl: TcxDBTextEdit;
    cxLabel17: TcxLabel;
    Registro_SeccionCtrl: TcxDBTextEdit;
    cxLabel18: TcxLabel;
    Registro_TomoCtrl: TcxDBTextEdit;
    cxLabel19: TcxLabel;
    Registro_OtrosDatosCtrl: TcxDBTextEdit;
    cxLabel8: TcxLabel;
    cxLabel6: TcxLabel;
    cxScrollBox1: TcxScrollBox;
    cxScrollBox2: TcxScrollBox;
    cxScrollBox3: TcxScrollBox;
    cxScrollBox4: TcxScrollBox;
    cxGroupBox8: TcxGroupBox;
    EjercicioPartidoCtrl: TcxCheckBox;
    MesInicialCtrlCaption: TcxLabel;
    descMesLabel: TcxLabel;
    cxLabel3: TcxLabel;
    Contable_MesInicialCtrl: TcxDBIndexedComboBox;
    procedure EmpresaTableNewRecord(DataSet: TDataSet);
    procedure CodigoPaisCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure EmpresaTableBeforePost(DataSet: TDataSet);
    procedure codigoPostalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoPaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoTextEditPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure DataPathCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoProvinciaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure codigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure codigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlEnter(Sender: TObject);
    procedure CodigoProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoPaisCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoTextEditPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EmpresaTableBeforeDelete(DataSet: TDataSet);
    procedure examinarButtonClick(Sender: TObject);
    procedure FormManagerReportRequest;
    procedure EmpresaTableAfterPost(DataSet: TDataSet);
    procedure CodigoProvinciaCtrlPropertiesEditValueChanged(
      Sender: TObject);
    function FormManagerGetAccessLevel: Smallint;
    procedure EjercicioPartidoCtrlPropertiesChange(Sender: TObject);
    procedure EmpresaTableUpdateState(DataSet: TDataSet);
    procedure EmpresaTableGetRecord(DataSet: TDataSet);
    procedure EmpresaTableAfterEdit(DataSet: TDataSet);
    procedure NIFCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerInitializeForm;

  private
    CrearTablas : Boolean;
    EmpresaFields : TEmpresaFields;
    DsUsuarioFields : TUsuarioFields;
  public
    procedure ActualizaControles;
    function  ObtenDirectorioEmpresa : string ;
  end;

var  MntEmpForm : TMntEmpForm = nil;

procedure MntEmpresas( KeyValues : array of const );

implementation

{$R *.dfm}

uses   Windows,
       DataAccess,
       EnterpriseDataAccess,
       NexusRpcData,

       Files,
       LibUtils,
       
       AppManager,

       Gdm00Frm,

       dm_pai,
       dm_prv,
       dm_usr,
       dm_emp,
       dm_cop,
       dm_pga,

       a_prv,
       a_pai,
       a_cop,

       cx_emp,
       cx_prv,
       cx_pai,
       cx_cop,

       b_cda,
       b_uee,
       b_msg,
       b_dir,

       l_emp;

resourceString
       RsMsg1   = 'No consigo localizar este servidor de datos.';
       RsMsg2   = 'Recuerde que el nombre debe ser del tipo <nombre del servidor>@<direccion IP> como, por ejemplo, gestwin@192.168.0.1.';

var  CodigoUsuarioActivo : String;

procedure MntEmpresas( KeyValues : array of const );

var  PalabraPaso : String;

begin

     If   Assigned( BoxUeeForm )  // Se está llamando desde b_uee
     then begin
          Usuario.CompruebaPalabraPaso( '00', PalabraPaso );
          CodigoUsuarioActivo := BoxUeeForm.DataCodigoUsuario.Value;
          end
     else CodigoUsuarioActivo := CodigoUsuarioActual;

     CreateEditForm( TMntEmpForm, MntEmpForm, KeyValues );
end;

function TMntEmpForm.ObtenDirectorioEmpresa : String ;
begin
     Result := EnterpriseDataModule.AddDataDirectory( ApplicationPath, EmpresaFields.Codigo.Value );
end;

procedure TMntEmpForm.ExaminarButtonClick(Sender: TObject);

var  Path : String;

begin
     Path := ApplicationPath;
     If   SelectDirectory( Path )
     then With EmpresaFields.DataPath do
            begin
            AsString := Path;
            FocusControl;
            end;
end;

function TMntEmpForm.FormManagerGetAccessLevel: Smallint;
begin
     If   CodigoUsuarioActivo='00'  // Usuario maestro
     then Result := 1
     else Result := 0;  // Sin acceso
end;

procedure TMntEmpForm.FormManagerInitializeForm;
begin
     EmpresaFields := TEmpresaFields.Create( EmpresaTable );

     DsUsuarioFields := TUsuarioFields.Create( Self );
end;

procedure TMntEmpForm.FormManagerReportRequest;
begin
     ListadoEmpresas;
end;

procedure TMntEmpForm.NIFCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.ValidaNIF( EmpresaFields.CodigoPais.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntEmpForm.CodigoTextEditPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var   AFileNameSegment : String;

begin
     AFileNameSegment := DisplayValue;
     If   not IsValidFileName( AFileNameSegment, False )
     then begin
          DisplayValue := AFileNameSegment;
          Error := True;
          ErrorText := JoinMessage( RsgMsg341, RsgMsg342 );
          end;
end;

procedure TMntEmpForm.CodigoCtrlEnter(Sender: TObject);
begin
     With CodigoCtrl do
       If   EditValue=''
       then EditValue := CodigoEspaña;
end;

procedure TMntEmpForm.CodigoTextEditPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEmpresas( Sender, qgsLinked );
end;

procedure TMntEmpForm.DataPathCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   DataPathCtrl.GetUserValidateAction or FormManager.ValidatingFormData
     then If   not ValueIsEmpty( DisplayValue )
          then If   not DirectoryExists( DisplayValue )
               then begin
                    Error := True;
                    ErrorText := JoinMessage( RsgMsg394, RsgMsg395 );
                    end;
end;

procedure TMntEmpForm.CodigoPaisCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntPaises( [ Sender.EditingValue ] );
end;

procedure TMntEmpForm.CodigoPaisCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   CodigoPaisCtrl.Editing
     then begin
          EmpresaFields.CodigoProvincia.Value := '';
          EmpresaFields.CodigoPostal.Value := '';
          CodigoProvinciaCtrl.ValidateEdit( False );
          end;
end;

procedure TMntEmpForm.CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TMntEmpForm.CodigoPaisCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntEmpForm.codigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosPostales( [ CodigoPaisCtrl.EditValue, CodigoProvinciaCtrl.EditValue, Sender.EditingValue ] );
end;

procedure TMntEmpForm.codigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( CodigoPaisCtrl.EditValue, CodigoProvinciaCtrl.EditValue, Sender );
end;

procedure TMntEmpForm.codigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( CodigoPaisCtrl.EditValue, CodigoProvinciaCtrl.EditValue, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntEmpForm.CodigoProvinciaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProvincias( [ EmpresaFields.CodigoPais.Value, Sender.EditingValue ] );
end;

procedure TMntEmpForm.CodigoProvinciaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   CodigoProvinciaCtrl.Editing
     then EmpresaFields.CodigoPostal.Value := '';
end;

procedure TMntEmpForm.CodigoProvinciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( CodigoEspaña, Sender );
end;

procedure TMntEmpForm.CodigoProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption;var Error: Boolean);
begin
     Provincia.Valida( CodigoPaisCtrl.EditValue, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntEmpForm.EjercicioPartidoCtrlPropertiesChange(Sender: TObject);
begin
     ActualizaControles;
end;

procedure TMntEmpForm.ActualizaControles;
begin
     EjercicioPartidoCtrl.Enabled := EmpresaTable.State=dsInsert;
     Contable_MesInicialCtrl.Enabled := ( EmpresaTable.State=dsInsert ) and EjercicioPartidoCtrl.Checked;
end;

procedure TMntEmpForm.EmpresaTableAfterEdit(DataSet: TDataSet);
begin
     Empresa.InicializaRegistroEmpresa( EmpresaFields, True );  // Verifico solo los datos del planificador, porque en versiones anteriores no existían
end;

procedure TMntEmpForm.EmpresaTableAfterPost(DataSet: TDataSet);
begin
     If   CrearTablas
     then NexusRpc.InitializeDatabase( EmpresaFields.Codigo.Value );
end;

procedure TMntEmpForm.EmpresaTableBeforeDelete( DataSet : TDataSet );
begin
     Empresa.SuprimeReferencias( EmpresaFields.Codigo.Value );
     If   ShowNotification( ntQuestionWarning, RsgMsg334 )=mrYes
     then NexusRpc.EraseEnterpriseDatabase( EmpresaFields.Codigo.Value );
end;

procedure TMntEmpForm.EmpresaTableBeforePost(DataSet: TDataSet);
begin
     If   EmpresaFields.DataPath.Value=''
     then If   not Empresa.CompruebaDirectorio( EmpresaFields.Codigo.Value )
          then ShowNotification( ntWarning, RsgMsg335, RsgMsg336 );
     CrearTablas := EmpresaTable.State=dsInsert;
end;

procedure TMntEmpForm.EmpresaTableGetRecord(DataSet: TDataSet);
begin
     EjercicioPartidoCtrl.Checked := EmpresaFields.Contable_MesInicial.Value<>1;
end;

procedure TMntEmpForm.EmpresaTableNewRecord(DataSet: TDataSet);
begin
     Empresa.InicializaRegistroEmpresa( EmpresaFields );
end;

procedure TMntEmpForm.EmpresaTableUpdateState(DataSet: TDataSet);
begin
     ActualizaControles;
end;

end.
