unit a_rac;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,
  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxLabel,
  cxGroupBox, f_not, cxMemo, cxRichEdit, cxDBRichEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar,

  Gim30Fields, dxUIAClasses;

type
  TMntRacForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    AuxiliarClienteTable: TnxeTable;
    DataSource: TDataSource;
    ClienteCtrl: TcxDBTextEdit;
    codigoCtrlCaption: TcxLabel;
    Label2: TcxLabel;
    DescClienteLabel: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxGroupBox3: TcxGroupBox;
    Campo1Label: TcxLabel;
    Campo1Ctrl: TcxDBTextEdit;
    cxGroupBox4: TcxGroupBox;
    cxGroupBox5: TcxGroupBox;
    cxGroupBox6: TcxGroupBox;
    cxGroupBox7: TcxGroupBox;
    cxGroupBox8: TcxGroupBox;
    cxGroupBox9: TcxGroupBox;
    Campo2Label: TcxLabel;
    Campo2Ctrl: TcxDBTextEdit;
    Campo3Label: TcxLabel;
    Campo3Ctrl: TcxDBTextEdit;
    Campo4Label: TcxLabel;
    Campo4Ctrl: TcxDBTextEdit;
    Campo5Label: TcxLabel;
    Campo5Ctrl: TcxDBTextEdit;
    Campo6Label: TcxLabel;
    Campo6Ctrl: TcxDBTextEdit;
    Campo7Label: TcxLabel;
    Campo7Ctrl: TcxDBTextEdit;
    Campo8Label: TcxLabel;
    Campo8Ctrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    TAnnotationFrame1: TAnnotationFrame;
    CodigoEANGroupBox: TcxGroupBox;
    cxLabel2: TcxLabel;
    CodigoEANCtrl: TcxDBTextEdit;
    cxGroupBox10: TcxGroupBox;
    Campo9Label: TcxLabel;
    Campo9Ctrl: TcxDBDateEdit;
    cxGroupBox11: TcxGroupBox;
    Campo10Label: TcxLabel;
    Campo10Ctrl: TcxDBDateEdit;
    DireccionPanel: TcxGroupBox;
    NombreCtrl: TcxDBTextEdit;
    DomicilioCtrl: TcxDBTextEdit;
    LocalidadCtrl: TcxDBTextEdit;
    PaisCtrl: TcxDBTextEdit;
    CodigoProvinciaCtrl: TcxDBTextEdit;
    CodigoPostalCtrl: TcxDBTextEdit;
    Label19: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    DescPaisLabel: TcxLabel;
    ProvinciaCaptionLabel: TcxLabel;
    DescCPLabel: TcxLabel;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure ClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerInitializeForm;
    procedure PaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure PaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure PaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure PaisCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoProvinciaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesEditValueChanged(
      Sender: TObject);
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
  private
      AuxiliarClienteFields : TAuxiliarClienteFields;
  public

  end;

var  MntRacForm: TMntRacForm = nil;

procedure MntAuxiliarClientes( KeyValues : array of const );

implementation

{$R *.dfm}

uses   SysUtils,
       Variants,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm10Dm,
       Gdm30Dm,
       Gim00Fields,

       Gdm30Frm,

       dm_pai,
       dm_prv,
       dm_cop,
       dm_rac,
       dm_cli,

       a_pai,
       a_prv,
       a_cop,
       a_cli,

       cx_pai,
       cx_prv,
       cx_cop,
       cx_rac,
       cx_cli,

       l_rac;

resourceString
       RsMsg1 = 'Mantenimiento de ';

procedure MntAuxiliarClientes( KeyValues : array of const );
begin
     CreateEditForm( TMntRacForm, MntRacForm, KeyValues, TGds30Frm.VentasSection );
end;

procedure TMntRacForm.FormManagerReportRequest;
begin
     ListadoRegistroAuxiliarClientes;
end;

procedure TMntRacForm.PaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntPaises( [ Sender.EditingValue ] );
end;

procedure TMntRacForm.PaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
      With PaisCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := CodigoEspaña;
end;

procedure TMntRacForm.PaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TMntRacForm.PaisCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error
     then CodigoPostal.SetupCPControl( DisplayValue, [ CodigoProvinciaCtrl ],[ CodigoPostalCtrl ] );
end;

procedure TMntRacForm.ClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TMntRacForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TMntRacForm.ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then ClienteCtrl.Description := RsgMsgTodos
     else Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntRacForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAuxiliarClientes( Sender, ClienteCtrl.EditValue, nil, qgsLinked );
end;

procedure TMntRacForm.CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With AuxiliarClienteFields do
       MntCodigosPostales( [ CodigoPais.Value, CodigoProvincia.Value, Sender.EditingValue ] );
end;

procedure TMntRacForm.CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With AuxiliarClienteFields do
       ConsultaCodigosPostales( CodigoPais.Value, CodigoProvincia.Value, Sender );
end;

procedure TMntRacForm.CodigoPostalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( AuxiliarClienteFields.CodigoPais.Value,
                          AuxiliarClienteFields.CodigoProvincia.Value,
                          Sender,
                          DisplayValue,
                          ErrorText,
                          Error );
end;

procedure TMntRacForm.CodigoProvinciaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProvincias( [ AuxiliarClienteFields.CodigoPais.Value, Sender.EditingValue ] );
end;

procedure TMntRacForm.CodigoProvinciaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   CodigoProvinciaCtrl.Editing
     then CodigoPostalCtrl.PostEditValue( '' );
end;

procedure TMntRacForm.CodigoProvinciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( AuxiliarClienteFields.CodigoPais.Value, Sender );
end;

procedure TMntRacForm.CodigoProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( AuxiliarClienteFields.CodigoPais.Value, Sender, DisplayValue, ErrorText, Error );
end;

function TMntRacForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.AcVEFicheros.Value;
end;

procedure TMntRacForm.FormManagerInitializeForm;

var  Index : SmallInt;
     Exists : Boolean;
     EditControl,
     LabelControl : TObject;
     CustomEdit : TcxCustomEdit;

begin

     Caption := RsMsg1 + NombreAuxiliarCliente( False, True, True );

     AuxiliarClienteFields := TAuxiliarClienteFields.Create( AuxiliarClienteTable );

     With DataModule00.DmEmpresaFields do
       begin

       SetupControlsPanel( DireccionPanel, Cliente_DireccionAuxiliar.Value, { AdjustFormHeight } True );

       For Index := 1 to 10 do
         begin
         Exists := not ValueIsEmpty( Cliente_CampoAux[ Index ].Value );
         EditControl :=  GetEditControlByName( Self, 'Campo' + IntToStr( Index ) + 'Ctrl' );
         LabelControl := GetEditControlByName( Self, 'Campo' + IntToStr( Index ) + 'Label' );
         If   Assigned( EditControl ) and Assigned( LabelControl )
         then begin
              CustomEdit := TcxCustomEdit( EditControl );
              CustomEdit.Enabled := Exists;
              SetupPanelableCtrl( CustomEdit, Exists, { AdjustFormHeight } True );
              TcxLabel( LabelControl ).Caption := Cliente_CampoAux[ Index ].Value;
              end;
         end;

       CodigoEANCtrl.Enabled := DataModule00.FacturaElectronica;
       SetupPanelableCtrl( CodigoEANCtrl, DataModule00.FacturaElectronica );
       end;
end;

end.
