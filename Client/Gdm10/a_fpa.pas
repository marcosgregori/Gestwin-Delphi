unit a_fpa;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
  cxMaskEdit, cxDropDownEdit, cxDBEdit, cxIndexedComboBox, cxCheckBox,
  cxControls, cxContainer, cxEdit, cxTextEdit, DB, nxdb, cxCurrencyEdit,
  cxSpinEdit, dxSkinsCore, dxSkinsDefaultPainters, cxLookAndFeels, cxLabel,
  cxGroupBox, dxUIAClasses,

  AppContainer,
  AppForms,
  DataManager,

  Gim10Fields;

type
  TMntFpaForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    PlazosCtrl: TcxDBSpinEdit;
    PrimerVencimientoCtrl: TcxDBSpinEdit;
    IntervaloCtrl: TcxDBSpinEdit;
    Bevel1: TShape;
    crearRegistroCtrl: TcxDBCheckBox;
    DescuentoPPCtrl: TcxDBCheckBox;
    EmitirCtrl: TcxDBCheckBox;
    TipoDeDocumentoCtrl: TcxDBIndexedComboBox;
    RecargoFinancieroCtrl: TcxDBCheckBox;
    NoContabilizarCtrl: TcxDBCheckBox;
    TipoDescuentoPPCtrl: TcxDBCurrencyEdit;
    TipoRecargoFinancCtrl: TcxDBCurrencyEdit;
    GastosCtrl: TcxDBIndexedComboBox;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    CanalPreferenteCtrl: TcxDBTextEdit;
    Bevel2: TShape;
    FormaPagoTable: TnxeTable;
    FormaPagoDataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    capPrimerVencimientoLabel: TcxLabel;
    capIntervaloLabel: TcxLabel;
    capTipoDocumentoLabel: TcxLabel;
    capDtoPPLabel: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label33: TcxLabel;
    descCanalLabel: TcxLabel;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure FormaPagoTableNewRecord(DataSet: TDataSet);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure PlazosCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure DescuentoPPCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure RecargoFinancieroCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure TipoDeDocumentoCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure CanalPreferenteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CanalPreferenteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CanalPreferenteCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerInitializeForm;
  private
    FormaPagoFields : TFormaPagoFields;
  public

  end;

var
  MntFpaForm: TMntFpaForm = nil;

procedure MntFormasPago( KeyValues : array of const );

implementation

{$R *.dfm}

uses   SysUtils,
       EnterpriseDataAccess,

       Gim00Fields,
       Gdm00Dm,
       Gdm10Frm,

       dm_sub,
       dm_fpa,

       a_sub,

       cx_fpa,
       cx_sub,

       l_fpa;

procedure mntFormasPago( KeyValues : Array of const );
begin
     CreateEditForm( TMntFpaForm, MntFpaForm, KeyValues, TGds10Frm.CobrosPagosSection );
end;

procedure TMntFpaForm.FormManagerReportRequest;
begin
     ListadoFormasPago;
end;

procedure TMntFpaForm.PlazosCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With PlazosCtrl do
       begin
       PrimerVencimientoCtrl.Enabled := EditValue<>0;
       IntervaloCtrl.Enabled := EditValue>1;
       If   Editing
       then ResetTab;
       end;
end;

procedure TMntFpaForm.RecargoFinancieroCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     TipoRecargoFinancCtrl.Enabled := RecargoFinancieroCtrl.Checked;
end;

procedure TMntFpaForm.TipoDeDocumentoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With TipoDeDocumentoCtrl do
        If   Editing
        then FormaPagoFields.Emitir.Value := ItemIndex=tdRecibo;
end;

procedure TMntFpaForm.FormaPagoTableNewRecord(DataSet: TDataSet);
begin
     FormaPagoFields.CrearRegistro.Value := True;
     FormaPagoFields.TipoDeDocumento.Value := tdRecibo;
     FormaPagoFields.Gastos.Value := 0;
end;

function TMntFpaForm.FormManagerGetAccessLevel: Smallint;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ acCOFicheros.Value, acPCFicheros.Value, acCOFormasPago.Value ] );
end;

procedure TMntFpaForm.FormManagerInitializeForm;
begin
     FormaPagoFields := TFormaPagoFields.Create( FormaPagoTable );
     SetEditControlsDecimals( [ TipoDescuentoPPCtrl, TipoRecargoFinancCtrl ] );
end;

procedure TMntFpaForm.CanalPreferenteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntFpaForm.CanalPreferenteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True );
end;

procedure TMntFpaForm.CanalPreferenteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then CanalPreferenteCtrl.Description := rsgNinguno
     else Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntFpaForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasPago( Sender, qgsLinked );
end;

procedure TMntFpaForm.DescuentoPPCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     TipoDescuentoPPCtrl.Enabled := DescuentoPPCtrl.Checked;
end;

end.
