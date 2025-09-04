
unit a_fco;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Datamanager,
  Menus,
  cxLookAndFeelPainters,
  cxButtons, DB, nxdb, cxTextEdit, cxDBEdit, cxControls, cxContainer,
  cxEdit, cxCheckBox, cxGraphics, cxMaskEdit, cxDropDownEdit,
  cxIndexedComboBox, cxSpinEdit, cxCurrencyEdit, cxPC, dxSkinsCore,
  dxSkinsDefaultPainters,

  Gim10Fields, cxLookAndFeels, cxLabel, cxGroupBox, dxUIAClasses;

type
  TMntFcoForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    FormaCobroTable: TnxeTable;
    FormaCobroDataSource: TDataSource;
    DefaultPanel: TcxGroupBox;
    Shape2: TShape;
    DescripcionCtrl: TcxDBTextEdit;
    PlazosCtrl: TcxDBSpinEdit;
    PrimerVencimientoCtrl: TcxDBSpinEdit;
    IntervaloCtrl: TcxDBSpinEdit;
    AceptadoCtrl: TcxDBCheckBox;
    crearRegistroCtrl: TcxDBCheckBox;
    DescuentoPPCtrl: TcxDBCheckBox;
    EmitirCtrl: TcxDBCheckBox;
    RecargoFinancieroCtrl: TcxDBCheckBox;
    TipoDescuentoPPCtrl: TcxDBCurrencyEdit;
    TipoRecargoFinancCtrl: TcxDBCurrencyEdit;
    NoContabilizarCtrl: TcxDBCheckBox;
    DiaCobro1Ctrl: TcxDBSpinEdit;
    DiaCobro2Ctrl: TcxDBSpinEdit;
    Meses30DiasCtrl: TcxDBCheckBox;
    CanalPreferenteCtrl: TcxDBTextEdit;
    TipoDeDocumentoCtrl: TcxDBIndexedComboBox;
    GastosCtrl: TcxComboBox;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    capPrimerVencimientoLabel: TcxLabel;
    capIntervaloLabel: TcxLabel;
    capTipoDocumentoLabel: TcxLabel;
    capGastos: TcxLabel;
    capDtoPPLabel: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label22: TcxLabel;
    Label23: TcxLabel;
    Label33: TcxLabel;
    DescCanalLabel: TcxLabel;
    Shape1: TShape;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure FormaCobroTableNewRecord(DataSet: TDataSet);
    procedure FormaCobroTableBeforePost(DataSet: TDataSet);
    procedure CanalPreferenteCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CanalPreferenteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CanalPreferenteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PlazosCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure TipoDeDocumentoCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure DescuentoPPCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure RecargoFinancieroCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure DiaCobro1CtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FormaCobroTableGetRecord(DataSet: TDataSet);
  private
    FormaCobroFields : TFormaCobroFields;
  public

  end;

var
  MntFcoForm: TMntFcoForm = nil;

procedure mntFormasCobro( keyValues : array of const );

implementation

{$R *.dfm}

uses   SysUtils,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm10Frm,

       dm_sub,

       a_sub,

       cx_fco,
       cx_sub,

       l_fco;

procedure mntFormasCobro( keyValues : array of const );
begin
     CreateEditForm( TmntFcoForm, MntFcoForm, KeyValues, TGds10Frm.CobrosPagosSection );
end;

procedure TMntFcoForm.FormaCobroTableBeforePost(DataSet: TDataSet);
begin
     If   GastosCtrl.ItemIndex=2
     then FormaCobroFields.Gastos.Value := 9
     else FormaCobroFields.Gastos.Value := GastosCtrl.ItemIndex;
end;

procedure TMntFcoForm.FormaCobroTableGetRecord(DataSet: TDataSet);
begin
     If   FormaCobroFields.Gastos.Value=9
     then GastosCtrl.ItemIndex := 2
     else GastosCtrl.ItemIndex := FormaCobroFields.Gastos.Value;
end;

procedure TMntFcoForm.FormaCobroTableNewRecord(DataSet: TDataSet);
begin
     FormaCobroFields.Aceptado.Value := True;
     FormaCobroFields.CrearRegistro.Value := True;
     FormaCobroFields.TipoDeDocumento.Value := 1;
     FormaCobroFields.Gastos.Value := 0;
end;

procedure TMntFcoForm.FormManagerInitializeForm;
begin
     ID := idMntFcoForm;
     FormaCobroFields := TFormaCobroFields.Create( FormaCobroTable );
     SetEditControlsDecimals( [ TipoDescuentoPPCtrl, TipoRecargoFinancCtrl ] );
end;

procedure TMntFcoForm.FormManagerReportRequest;
begin
     ListadoFormasCobro;
end;

procedure TMntFcoForm.PlazosCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With PlazosCtrl do
       begin

       If   Editing and ValueIsEmpty( EditValue )
       then begin
            FormaCobroFields.TipoDeDocumento.Value := 1;
            FormaCobroFields.Gastos.Value := 0;
            FormaCobroFields.Aceptado.Value := False;
            end;

       PrimerVencimientoCtrl.Enabled := EditValue<>0;
       IntervaloCtrl.Enabled := EditValue>1;
       TipoDeDocumentoCtrl.Enabled := EditValue<>0;
       AceptadoCtrl.Enabled := EditValue<>0;
       GastosCtrl.Enabled := EditValue<>0;
       Meses30DiasCtrl.Enabled := EditValue<>0;

       If   Editing
       then ResetTab;
       end;
end;

procedure TMntFcoForm.RecargoFinancieroCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     TipoRecargoFinancCtrl.Enabled := RecargoFinancieroCtrl.Checked;
end;

procedure TMntFcoForm.TipoDeDocumentoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With TipoDeDocumentoCtrl do
       If   Editing and ( EditValue=1 )
       then FormaCobroFields.Emitir.Value := True;
end;

procedure TMntFcoForm.DescuentoPPCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     TipoDescuentoPPCtrl.Enabled := DescuentoPPCtrl.Checked;
end;

procedure TMntFcoForm.DiaCobro1CtrlPropertiesEditValueChanged( Sender: TObject);
begin
     With DiaCobro1Ctrl do
       begin
       If   Editing and ValueIsEmpty( EditValue )
       then FormaCobroFields.DiaCobro2.Value := 0;
       DiaCobro2Ctrl.Enabled := not ValueIsEmpty( EditValue );
       end;
end;

function TMntFcoForm.FormManagerGetAccessLevel: Smallint;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ acVEFicheros.Value, acPCFicheros.Value, acVEFormasCobro.Value ] );
end;

procedure TMntFcoForm.CanalPreferenteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntFcoForm.CanalPreferenteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True );
end;

procedure TMntFcoForm.CanalPreferenteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then CanalPreferenteCtrl.Description := rsgNinguno
     else Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntFcoForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender, qgsLinked );
end;

end.
