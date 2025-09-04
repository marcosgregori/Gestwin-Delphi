
unit a_pde_con;

interface

uses

  Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls, ComCtrls, Menus, DB,

  cxLookAndFeelPainters, cxButtons, cxTextEdit, cxDBEdit, cxContainer, cxEdit, cxCheckBox, cxPC, cxControls,
  cxGraphics, cxMaskEdit, cxDropDownEdit,cxIndexedComboBox, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxLookAndFeels, cxGroupBox, cxLabel, cxPCdxBarPopupMenu, cxSpinEdit, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, dxmdaset, cxNavigator, dxBarBuiltInMenu, cxScrollBox, dxDateRanges,

  nxdb,

  AppContainer,
  DataManager,

  Gdm00Dm,
  Gim00Fields, AppForms, GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxHeader,
  dxGDIPlusClasses, cxImage, dxUIAClasses, cxGeometry, dxFramedControl,
  dxPanel;

type
  TBoxPdeConForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    PageControl: TcxPageControl;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    EmpresaTable: TnxeTable;
    DataSource: TDataSource;
    GestionContableTS: TcxTabSheet;
    cxGroupBox1: TcxGroupBox;
    Contable_CtrosCosteCtrl: TcxDBCheckBox;
    Contable_NroRegAstosCtrl: TcxDBCheckBox;
    Contable_NoUsarExistenciasCtrl: TcxDBCheckBox;
    cxGroupBox2: TcxGroupBox;
    Contable_RetencionesCtrl: TcxDBCheckBox;
    Contable_BloqueoTrimCtrl: TcxDBCheckBox;
    Contable_NroRegistroCtrl: TcxDBCheckBox;
    cxGroupBox3: TcxGroupBox;
    Contable_DesglosarCtasCobrosCtrl: TcxDBCheckBox;
    Contable_DivisasCtrl: TcxDBCheckBox;
    Label46: TcxLabel;
    RegimenEspecialCriterioCajaCtrl: TcxDBCheckBox;
    Contable_SIICtrl: TcxDBCheckBox;
    cxGroupBox6: TcxGroupBox;
    Inmovilizado_CampoLibre1Ctrl: TcxDBTextEdit;
    Inmovilizado_CampoLibre2Ctrl: TcxDBTextEdit;
    Inmovilizado_CampoLibre3Ctrl: TcxDBTextEdit;
    Inmovilizado_CampoLibre4Ctrl: TcxDBTextEdit;
    Inmovilizado_CampoLibOblig1Ctrl: TcxDBCheckBox;
    Inmovilizado_CampoLibOblig2Ctrl: TcxDBCheckBox;
    Inmovilizado_CampoLibOblig3Ctrl: TcxDBCheckBox;
    Inmovilizado_CampoLibOblig4Ctrl: TcxDBCheckBox;
    cxLabel62: TcxLabel;
    cxLabel63: TcxLabel;
    cxLabel64: TcxLabel;
    cxLabel65: TcxLabel;
    Inmovilizado_CamposLibresCtrl: TcxDBCheckBox;
    LibrosIVATS: TcxTabSheet;
    PrevisionTS: TcxTabSheet;
    InmovilizadoTS: TcxTabSheet;
    Image1: TcxImage;
    VentasOnlineIntracomunitariasCtrl: TcxDBCheckBox;
    EntornoPruebasSIICtrl: TcxDBCheckBox;
    dxPanel1: TcxGroupBox;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure FormManagerDestroyForm;
    procedure Inmovilizado_CamposLibresCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure Contable_EntornoRealSIICtrlPropertiesChange(Sender: TObject);
    procedure EntornoPruebasSIICtrlPropertiesValuePosted(Sender: TObject);
  private
    FEmpresaFields : TEmpresaFields;
    function GetEmpresaFields : TEmpresaFields;
  protected
    class procedure ConfiguracionContable( Sender : TObject);
  public
    property EmpresaFields : TEmpresaFields read GetEmpresaFields;
  end;

var
  BoxPdeConForm: TBoxPdeConForm = nil;

implementation

{$R *.DFM}

uses   SysUtils,
       DateUtils,
       LibUtils,

       dxBar,

       AppManager,
       EnterpriseDataAccess,
       SessionDataAccess,

       Gdm00Frm,

       dmi_pga,

       dm_emp,
       dm_pga,
       dm_sdf,
       dm_reg,
       dm_iva,

       b_upd,
       b_msg,
       b_dir,

       cx_emp,
       cx_sdf;

resourceString

       RsMsg7 = '¿Está seguro de que desea des-activar el entorno de pruebas del SII?';
       RsMsg8 = 'Si realiza el cambio se suprimirá el registro de presentación actual.'#13'El registro puede reconstruirse desde la opción de sincronización con los datos existentes en la Agencia Tributaria.';

       RsNinguno  = '<Ninguno>';

class procedure TBoxPdeConForm.ConfiguracionContable( Sender : TObject);
begin
     CreateEditForm( TBoxPdeConForm, BoxPdeConForm, Gds00Frm.ConfigurationSection, True );
end;

procedure TBoxPdeConForm.FormManagerInitializeForm;
begin

     CloseWindowWhenFocusLost := True;

     GestionContableTS.TabVisible := ApplicationContainer.IsModuleActive( [ 10 ] );

     With EmpresaTable do
       If   FindKey( [ CodigoEmpresaActual ] )
       then Edit
       else Abort;

     Contable_SIICtrl.Enabled := DataModule00.SuministroInmediatoInformacion;

end;

function TBoxPdeConForm.GetEmpresaFields : TEmpresaFields;
begin
     If   not Assigned( FEmpresaFields )
     then FEmpresaFields := TEmpresaFields.Create( EmpresaTable );
     Result := FEmpresaFields;
end;

procedure TBoxPdeConForm.Inmovilizado_CamposLibresCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     Inmovilizado_CampoLibre1Ctrl.Enabled := Inmovilizado_CamposLibresCtrl.Checked;
     Inmovilizado_CampoLibre2Ctrl.Enabled := Inmovilizado_CamposLibresCtrl.Checked;
     Inmovilizado_CampoLibre3Ctrl.Enabled := Inmovilizado_CamposLibresCtrl.Checked;
     Inmovilizado_CampoLibre4Ctrl.Enabled := Inmovilizado_CamposLibresCtrl.Checked;

     Inmovilizado_CampoLibOblig1Ctrl.Enabled := Inmovilizado_CamposLibresCtrl.Checked;
     Inmovilizado_CampoLibOblig2Ctrl.Enabled := Inmovilizado_CamposLibresCtrl.Checked;
     Inmovilizado_CampoLibOblig3Ctrl.Enabled := Inmovilizado_CamposLibresCtrl.Checked;
     Inmovilizado_CampoLibOblig4Ctrl.Enabled := Inmovilizado_CamposLibresCtrl.Checked;
end;

procedure TBoxPdeConForm.Contable_EntornoRealSIICtrlPropertiesChange(Sender: TObject);
begin
     EntornoPruebasSIICtrl.Enabled := Contable_SIICtrl.Checked;
end;

procedure TBoxPdeConForm.EntornoPruebasSIICtrlPropertiesValuePosted(Sender: TObject);
begin
     If   EmpresaFields.Contable_EntornoPruebasSII.OldValue and not EmpresaFields.Contable_EntornoPruebasSII.Value // Está desactivando el entorno de pruebas
     then If   ShowNotification( ntAcceptCancel, RsMsg7, RsMsg8 )=mrOk
          then EnterpriseDataModule.ExecQuery( 'DELETE FROM RegistroPresentacion WHERE Tipo IN (0, 1)' )
          else EmpresaFields.Contable_EntornoPruebasSII.Value := not EmpresaFields.Contable_EntornoPruebasSII.Value;
end;

procedure TBoxPdeConForm.FormManagerOkButton;
begin
     EmpresaTable.Post;
     DataModule00.DmEmpresaTable.GotoCurrent( EmpresaTable );
     FormManager.CloseWindow := True;
     Gds00Frm.ConfigurationSection.UpdateMainMenu;
end;

procedure TBoxPdeConForm.FormManagerDestroyForm;
begin
     EmpresaTable.Cancel;
end;

procedure SetupUnit;
begin
     If   ProgramNumber in [ pnDesarrollo, pnContable, pnComercial, pnContableComercial ]
     then If   Assigned( Gds00Frm )
          then With Gds00Frm do
                 begin
                 ConfiguracionContableItem.Visible := ivAlways;
                 ConfiguracionContableItem.OnClick := TBoxPdeConForm.ConfiguracionContable;
                 end;
end;

initialization
     AddProcedure( imStartUp, 0, SetupUnit );

end.

