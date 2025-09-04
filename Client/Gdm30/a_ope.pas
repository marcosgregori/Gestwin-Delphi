unit a_ope;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxCheckBox, dxSkinsCore,
  dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox,

  Gim30Fields, dxUIAClasses;

type
  TMntOpeForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    OperarioTable: TnxeTable;
    DataSource: TDataSource;
    DataPanel: TgxEditPanel;
    NombreCtrl: TcxDBTextEdit;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    cxGroupBox3: TcxGroupBox;
    cxGroupBox1: TcxGroupBox;
    Campo1Label: TcxLabel;
    Campo1Ctrl: TcxDBTextEdit;
    cxGroupBox2: TcxGroupBox;
    Campo2Label: TcxLabel;
    Campo2Ctrl: TcxDBTextEdit;
    cxGroupBox4: TcxGroupBox;
    Campo3Label: TcxLabel;
    Campo3Ctrl: TcxDBTextEdit;
    cxGroupBox5: TcxGroupBox;
    Campo4Label: TcxLabel;
    Campo4Ctrl: TcxDBTextEdit;
    cxGroupBox6: TcxGroupBox;
    Campo5Label: TcxLabel;
    Campo5Ctrl: TcxDBTextEdit;
    cxGroupBox7: TcxGroupBox;
    Campo6Label: TcxLabel;
    Campo6Ctrl: TcxDBTextEdit;
    cxGroupBox8: TcxGroupBox;
    Campo7Label: TcxLabel;
    Campo7Ctrl: TcxDBTextEdit;
    cxGroupBox9: TcxGroupBox;
    Campo8Label: TcxLabel;
    Campo8Ctrl: TcxDBTextEdit;
    cxGroupBox10: TcxGroupBox;
    Campo9Label: TcxLabel;
    Campo9Ctrl: TcxDBDateEdit;
    cxGroupBox11: TcxGroupBox;
    Campo10Label: TcxLabel;
    Campo10Ctrl: TcxDBDateEdit;
    DireccionGroupBox: TcxGroupBox;
    LocalidadCtrl: TcxDBTextEdit;
    TelefonoCtrl: TcxDBTextEdit;
    FaxCtrl: TcxDBTextEdit;
    CodigoProvinciaCtrl: TcxDBTextEdit;
    CodigoPostalCtrl: TcxDBTextEdit;
    PaisCtrl: TcxDBTextEdit;
    MovilCtrl: TcxDBTextEdit;
    capLocalidadLabel: TcxLabel;
    capProvinciaLabel: TcxLabel;
    DescCPLabel: TcxLabel;
    capFaxLabel: TcxLabel;
    Label8: TcxLabel;
    DescPaisLabel: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label10: TcxLabel;
    EMailCtrl: TcxDBTextEdit;
    capTelefonoLabel: TcxLabel;
    NIFCtrl: TcxDBTextEdit;
    DescNIF: TcxLabel;
    EnviarCorreoBtn: TgBitBtn;
    cxLabel1: TcxLabel;
    ClienteCtrl: TcxDBTextEdit;
    Label9: TcxLabel;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure FormManagerInitializeForm;
    procedure NIFCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure PaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure PaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure PaisCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
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
    procedure EnviarCorreoBtnClick(Sender: TObject);
    procedure ClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private
     OperarioFields : TOperarioFields;
  public

  end;

var  MntOpeForm: TMntOpeForm = nil;

procedure MntOperarios( KeyValues : array of const );

implementation

{$R *.dfm}

uses   System.SysUtils,
       LibUtils,
       Variants,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dm_ope,
       dm_pai,
       dm_prv,
       dm_cop,
       dm_cli,
       dm_ddc,

       cx_ope,
       cx_pai,
       cx_prv,
       cx_cop,
       cx_cli,

       l_ope,

       a_pai,
       a_prv,
       a_cop,
       a_cli,

       b_msg;

procedure MntOperarios( KeyValues : array of const );
begin
     CreateEditForm( TMntOpeForm, MntOpeForm, KeyValues, TGds30Frm.AlmacenSection );
end;

procedure TMntOpeForm.FormManagerReportRequest;
begin
     ListadoOperarios;
end;

procedure TMntOpeForm.NIFCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.ValidaNIF( OperarioFields.CodigoPais.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntOpeForm.PaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntPaises( [ Sender.EditingValue ] );
end;

procedure TMntOpeForm.PaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With PaisCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := CodigoEspaña;
end;

procedure TMntOpeForm.PaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TMntOpeForm.PaisCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntOpeForm.ClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TMntOpeForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TMntOpeForm.ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then ClienteCtrl.Description := RsgMsgTodos
     else Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntOpeForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOperarios( Sender, ClienteCtrl.EditValue, qgsLinked );
end;

procedure TMntOpeForm.CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosPostales( [ OperarioFields.CodigoPais.Value, OperarioFields.CodigoProvincia.Value, Sender.EditingValue ] );
end;

procedure TMntOpeForm.CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( OperarioFields.CodigoPais.Value, OperarioFields.CodigoProvincia.Value, Sender );
end;

procedure TMntOpeForm.CodigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( OperarioFields.CodigoPais.Value, OperarioFields.CodigoProvincia.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntOpeForm.CodigoProvinciaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProvincias( [ OperarioFields.CodigoPais.Value, Sender.Editingvalue ] );
end;

procedure TMntOpeForm.CodigoProvinciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( OperarioFields.CodigoPais.Value, Sender );
end;

procedure TMntOpeForm.CodigoProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( OperarioFields.CodigoPais.Value, Sender, DisplayValue, ErrorText, Error );
     If   Sender.ModifiedAfterEnter
     then CodigoPostalCtrl.EditValue := '';
end;

procedure TMntOpeForm.EnviarCorreoBtnClick(Sender: TObject);
begin
     DireccionCorreo.Redacta( OperarioFields.EMail.Value );
end;

function TMntOpeForm.FormManagerGetAccessLevel: Smallint;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ AcALFicheros.Value ] );
end;

procedure TMntOpeForm.FormManagerInitializeForm;

var  Index : SmallInt;
     Exists : Boolean;
     EditControl,
     LabelControl : TcxCustomEdit;

begin

     OperarioFields := TOperarioFields.Create( OperarioTable );

     Caption := NombreOperarios( { Capital } True, { Plural } True );

     With DataModule00.DmEmpresaFields do
       begin

       SetupPanelableCtrl( LocalidadCtrl, Ventas_MostrarDireccionOperarios.Value, True );
       // Si no deshabilito el resto de los controles se validará su contenido
       SetGroupBoxControlsEnabled( DireccionGroupBox, Ventas_MostrarDireccionOperarios.Value );

       With DataModule00.DmEmpresaFields do
         For Index := 1 to 10 do
           begin
           Exists := not ValueIsEmpty( Ventas_CampoOperarios[ Index ].Value );
           EditControl :=  GetEditControlByName( Self, 'Campo' + IntToStr( Index ) + 'Ctrl' );
           LabelControl := GetEditControlByName( Self, 'Campo' + IntToStr( Index ) + 'Label' );
           If   Assigned( EditControl ) and Assigned( LabelControl )
           then begin
                SetupPanelableCtrl( EditControl, Exists, True );
                TcxLabel( LabelControl ).Caption := Ventas_CampoOperarios[ Index ].Value;
                end;
           end;

       end;
end;

end.
