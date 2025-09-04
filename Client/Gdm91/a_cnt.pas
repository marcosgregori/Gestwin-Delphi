unit a_cnt;

interface

uses Forms, ComCtrls, AppForms, StdCtrls, Buttons, Mask, Controls,
  Classes, ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxMemo, cxDBEdit, cxCheckBox, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxPC, cxControls, cxContainer, cxEdit, cxTextEdit,

  Gim90Fields, cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLabel, cxGroupBox, cxPCdxBarPopupMenu,
  dxBarBuiltInMenu;

type
  TmntCntForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    ContactoTable: TnxeTable;
    ActividadTable: TnxeTable;
    ProveedorExternoTable: TnxeTable;
    dataPanel: TgxEditPanel;
    PageControl1: TcxPageControl;
    TabSheet1: TcxTabSheet;
    NombreCtrl: TcxDBTextEdit;
    DomicilioCtrl: TcxDBTextEdit;
    LocalidadCtrl: TcxDBTextEdit;
    CodigoActividadCtrl: TcxDBTextEdit;
    TelefonoCtrl: TcxDBTextEdit;
    FaxCtrl: TcxDBTextEdit;
    TabSheet2: TcxTabSheet;
    PersonaContacto1Ctrl: TcxDBTextEdit;
    Cargo1Ctrl: TcxDBTextEdit;
    CodigoPaisCtrl: TcxDBTextEdit;
    CodigoProvinciaCtrl: TcxDBTextEdit;
    CodigoPostalCtrl: TcxDBTextEdit;
    TabSheet3: TcxTabSheet;
    NotasCtrl: TcxDBMemo;
    Movil1Ctrl: TcxDBTextEdit;
    EMail1Ctrl: TcxDBTextEdit;
    PersonaContacto2Ctrl: TcxDBTextEdit;
    Cargo2Ctrl: TcxDBTextEdit;
    Movil2Ctrl: TcxDBTextEdit;
    EMail2Ctrl: TcxDBTextEdit;
    TabSheet4: TcxTabSheet;
    PrimerContactoCtrl: TcxDBDateEdit;
    ProximoContactoCtrl: TcxDBDateEdit;
    UltimoContactoCtrl: TcxDBDateEdit;
    InteresadoCtrl: TcxDBCheckBox;
    informatizadoCtrl: TcxDBCheckBox;
    ProveedorExternoCtrl: TcxDBTextEdit;
    PaginaWebCtrl: TcxDBTextEdit;
    DataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    DescActividadLabel: TcxLabel;
    Label8: TcxLabel;
    Label12: TcxLabel;
    Label13: TcxLabel;
    Label4: TcxLabel;
    descPaisLabel: TcxLabel;
    Label15: TcxLabel;
    DescCPLabel: TcxLabel;
    Label6: TcxLabel;
    Label5: TcxLabel;
    Label16: TcxLabel;
    Label17: TcxLabel;
    Label18: TcxLabel;
    Label19: TcxLabel;
    Label21: TcxLabel;
    Label22: TcxLabel;
    Label7: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label11: TcxLabel;
    proveedorLabel: TcxLabel;
    Label23: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    procedure FormManagerReportRequest;
    procedure FormManagerLabelsRequest;
    procedure CodigoPaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoPaisCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoPaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
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
    procedure CodigoActividadCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure informatizadoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ProveedorExternoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ProveedorExternoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ProveedorExternoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerInitializeForm;
    procedure CodigoProvinciaCtrlPropertiesEditValueChanged(Sender: TObject);
  private
    ContactoFields : TContactoFields;
  public

  end;

var mntCntForm: TmntCntForm = nil;

procedure mntContactos( keyValues : array of const );

implementation

{$R *.DFM}

uses   Gdm00Dm,

       dm_pai,
       dm_prv,
       dm_cop,
       dm_pex,

       b_msg,

       a_prv,
       a_pai,
       a_act,
       a_pex,
       a_cop,

       cx_pai,
       cx_cnt,
       cx_act,
       cx_prv,
       cx_pex,
       cx_cop,

       l_cnt,
       e_cnt;

procedure mntContactos( keyValues : array of const );
begin
     CreateEditForm( TmntCntForm, MntCntForm, keyValues );
end;

procedure TmntCntForm.CodigoActividadCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntActividades( [ Sender.EditingValue ] );
end;

procedure TmntCntForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaContactos( Sender, qgsLinked );
end;

procedure TmntCntForm.CodigoPaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntPaises( [ Sender.EditingValue ] );
end;

procedure TmntCntForm.CodigoPaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With CodigoPaisCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := CodigoEspaña;
end;

procedure TmntCntForm.CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TmntCntForm.CodigoPaisCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntCntForm.CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With ContactoFields do
       MntCodigosPostales( [ CodigoPais.Value, CodigoProvincia.Value, Sender.EditingValue ] );
end;

procedure TmntCntForm.CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With ContactoFields do
       ConsultaCodigosPostales( CodigoPais.Value, CodigoProvincia.Value, Sender );
end;

procedure TmntCntForm.CodigoPostalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( ContactoFields.CodigoPais.Value, ContactoFields.CodigoProvincia.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntCntForm.CodigoProvinciaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With ContactoFields do
       MntProvincias( [ CodigoPais.Value, Sender.EditingValue ] );
end;

procedure TmntCntForm.CodigoProvinciaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   CodigoProvinciaCtrl.Editing
     then CodigoPostalCtrl.PostEditValue( '' );     
end;

procedure TmntCntForm.CodigoProvinciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( ContactoFields.CodigoPais.Value, Sender );
end;

procedure TmntCntForm.CodigoProvinciaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( ContactoFields.CodigoPais.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntCntForm.FormManagerReportRequest;
begin
     ListadoContactos;
end;

procedure TmntCntForm.informatizadoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With ProveedorExternoCtrl do
       If   Assigned( ContactoFields )
       then begin
            Enabled := ContactoFields.Informatizado.Value;
            If   Editing  and not Enabled
            then Clear;
            end;
end;

procedure TmntCntForm.ProveedorExternoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedoresExternos( [ Sender.EditingValue ] );
end;

procedure TmntCntForm.ProveedorExternoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedoresExternos( Sender );
end;

procedure TmntCntForm.ProveedorExternoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ProveedorExterno.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntCntForm.FormManagerInitializeForm;
begin
     ContactoFields := TContactoFields.Create( ContactoTable );
end;

procedure TmntCntForm.FormManagerLabelsRequest;
begin
     EtiquetasContactos( ContactoFields.Codigo.Value );
end;

end.
