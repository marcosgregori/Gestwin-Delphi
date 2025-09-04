unit a_rdi;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  Datamanager, DB, nxdb, cxGraphics, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox;

type
  TmntRdiForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoDivisaCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    DifPositivasCambioCtrl: TcxDBTextEdit;
    DifNegativasCambioCtrl: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    RelacionesDivisaDataSource: TDataSource;
    RelacionesDivisaTable: TnxeTable;
    codigoCtrlCaption: TcxLabel;
    DescCodigoDivisaLabel: TcxLabel;
    Label4: TcxLabel;
    DescDifPositivasLabel: TcxLabel;
    Label2: TcxLabel;
    DescDifNegativasLabel: TcxLabel;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure CodigoDivisaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoDivisaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SubcuentaEditRequest(
      Sender: TcxCustomEdit);
    procedure SubcuentaValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure SubcuentaQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoDivisaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure DifPositivasCambioCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure DifNegativasCambioCtrlPropertiesEnter(Sender: TcxCustomEdit);
  private

  public

  end;

var  mntRdiForm: TmntRdiForm = nil;

procedure MntRelacionesDivisa( keyValues : array of const );

implementation

{$R *.dfm}

uses   EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm10Frm,

       dm_sub,
       dm_cdi,

       a_sub,
       a_cdi,

       cx_cdi,
       cx_sub,

       l_rdi;


procedure MntRelacionesDivisa( keyValues : array of const );
begin
     CreateEditForm( TmntRdiForm, mntRdiForm, KeyValues, TGds10Frm.ContableSection );
end;

procedure TmntRdiForm.FormManagerReportRequest;
begin
     ListadoRelacionesDivisas;
end;

procedure TmntRdiForm.DifNegativasCambioCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With DifNegativasCambioCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '668';
end;

procedure TmntRdiForm.DifPositivasCambioCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With DifPositivasCambioCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '768';
end;

procedure TmntRdiForm.SubcuentaQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True );
end;

procedure TmntRdiForm.SubcuentaValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntRdiForm.SubcuentaEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TmntRdiForm.CodigoDivisaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosDivisa( [ Sender.EditingValue ] );
end;

procedure TmntRdiForm.CodigoDivisaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosDivisa( Sender );
end;

procedure TmntRdiForm.CodigoDivisaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Divisa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

function TmntRdiForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.acLIFicheros.Value;
end;

end.
