
unit a_pde_cli;

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
  cxDataControllerConditionalFormattingRulesManagerDialog, cxHeader;

type
  TBoxPdeCliForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    PageControl: TcxPageControl;
    ClientesTS: TcxTabSheet;
    Cliente_GruposFacCtrl: TcxDBCheckBox;
    Cliente_RegAuxiliarCtrl: TcxDBCheckBox;
    Cliente_ReferenciasCtrl: TcxDBCheckBox;
    Cliente_VenPeriodicaCtrl: TcxDBCheckBox;
    Cliente_TarCodigoCtrl: TcxDBCheckBox;
    Cliente_TarConsumoCtrl: TcxDBCheckBox;
    Cliente_CamposLibresCtrl: TcxDBCheckBox;
    Cliente_CanalSerieCtrl: TcxDBCheckBox;
    Cliente_DtosTarifasCtrl: TcxDBCheckBox;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    EmpresaTable: TnxeTable;
    DataSource: TDataSource;
    Cliente_NombreRegAuxiliarCtrl: TcxDBTextEdit;
    cxGroupBox7: TcxGroupBox;
    Cliente_CampoLibre1Ctrl: TcxDBTextEdit;
    Cliente_CampoLibre2Ctrl: TcxDBTextEdit;
    Cliente_CampoLibre3Ctrl: TcxDBTextEdit;
    Cliente_CampoLibre4Ctrl: TcxDBTextEdit;
    Cliente_CampoLib1ObligCtrl: TcxDBCheckBox;
    Cliente_CampoLib2ObligCtrl: TcxDBCheckBox;
    Cliente_CampoLib3ObligCtrl: TcxDBCheckBox;
    Cliente_CampoLib4ObligCtrl: TcxDBCheckBox;
    cxGroupBox8: TcxGroupBox;
    Cliente_CampoAux1Ctrl: TcxDBTextEdit;
    Cliente_CampoAux2Ctrl: TcxDBTextEdit;
    Cliente_CampoAux3Ctrl: TcxDBTextEdit;
    Cliente_CampoAux4Ctrl: TcxDBTextEdit;
    Cliente_CampoAux5Ctrl: TcxDBTextEdit;
    Cliente_CampoAux6Ctrl: TcxDBTextEdit;
    Cliente_CampoAux7Ctrl: TcxDBTextEdit;
    Cliente_CampoAux8Ctrl: TcxDBTextEdit;
    Label47: TcxLabel;
    Label9: TcxLabel;
    Label14: TcxLabel;
    Label17: TcxLabel;
    Label18: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label20: TcxLabel;
    Label21: TcxLabel;
    Label22: TcxLabel;
    Label23: TcxLabel;
    Label24: TcxLabel;
    Label25: TcxLabel;
    Cliente_CampoAux9Ctrl: TcxDBTextEdit;
    Cliente_CampoAux10Ctrl: TcxDBTextEdit;
    cxLabel34: TcxLabel;
    cxLabel35: TcxLabel;
    cxLabel38: TcxLabel;
    cxLabel39: TcxLabel;
    cxLabel40: TcxLabel;
    cxLabel41: TcxLabel;
    cxLabel42: TcxLabel;
    Cliente_TarCantidadMinimaCtrl: TcxDBCheckBox;
    CamposLibresTS: TcxTabSheet;
    RegistroAuxiliarTS: TcxTabSheet;
    LocalizacionCtrl: TcxDBCheckBox;
    cxLabel1: TcxLabel;
    Cliente_DireccionAuxiliarCtrl: TcxDBCheckBox;
    procedure Cliente_CamposLibresCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure Cliente_RegAuxiliarCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure FormManagerDestroyForm;
    procedure Cliente_TarCodigoCtrlPropertiesChange(Sender: TObject);
  private
    FEmpresaFields : TEmpresaFields;
    FCampoAuxCtrlArray : TcxCustomEditArray;
    function GetEmpresaFields : TEmpresaFields;
  protected
    class procedure ConfiguracionClientes( Sender : TObject);
  public
    property EmpresaFields : TEmpresaFields read GetEmpresaFields;
  end;

var
  BoxPdeCliForm: TBoxPdeCliForm = nil;


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
       Gim30Fields,

       dmi_pga,

       dm_emp,
       dm_pga,
       dm_alm,
       dm_sdf,
       dm_cls,
       dm_reg,

       b_upd,
       b_msg,
       b_dir,

       a_alm,
       a_sdf,

       cx_emp,
       cx_sdf,
       cx_alm;

resourceString
       RsNinguno  = '<Ninguno>';

       RsMsg1 = 'Debe indicar, al menos, el nombre de un campo del registro auxiliar.';
       RsMsg2 = 'Si no lo desea utilizar desmarque la opción "Usar registro auxiliar".';

class procedure TBoxPdeCliForm.ConfiguracionClientes( Sender : TObject);
begin
     CreateEditForm( TBoxPdeCliForm, BoxPdeCliForm, Gds00Frm.ConfigurationSection, True );
end;

procedure TBoxPdeCliForm.FormManagerInitializeForm;
begin

     FCampoAuxCtrlArray := GetCustomEditCtrlArray( Self, 'Cliente_CampoAux', 1, 10 );

     CloseWindowWhenFocusLost := True;

     With EmpresaTable do
       If   FindKey( [ CodigoEmpresaActual ] )
       then Edit
       else Abort;
end;

function TBoxPdeCliForm.GetEmpresaFields : TEmpresaFields;
begin
     If   not Assigned( FEmpresaFields )
     then FEmpresaFields := TEmpresaFields.Create( EmpresaTable );
     Result := FEmpresaFields;
end;

procedure TBoxPdeCliForm.FormManagerOkButton;
begin

     If   EmpresaFields.Cliente_RegAuxiliar.Value
     then If   CustomEditCtrlArrayIsEmpty( FCampoAuxCtrlArray )
          then begin
               ShowNotification( ntStop, RsMsg1, RsMsg2 );
               Abort;
               end;

     EmpresaTable.Post;
     DataModule00.DmEmpresaTable.GotoCurrent( EmpresaTable );
     FormManager.CloseWindow := True;
     Gds00Frm.ConfigurationSection.UpdateMainMenu;
end;

procedure TBoxPdeCliForm.FormManagerDestroyForm;
begin
     EmpresaTable.Cancel;
end;

procedure TBoxPdeCliForm.Cliente_CamposLibresCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     Cliente_CampoLibre1Ctrl.Enabled := Cliente_CamposLibresCtrl.Checked;
     Cliente_CampoLibre2Ctrl.Enabled := Cliente_CamposLibresCtrl.Checked;
     Cliente_CampoLibre3Ctrl.Enabled := Cliente_CamposLibresCtrl.Checked;
     Cliente_CampoLibre4Ctrl.Enabled := Cliente_CamposLibresCtrl.Checked;

     Cliente_CampoLib1ObligCtrl.Enabled := Cliente_CamposLibresCtrl.Checked;
     Cliente_CampoLib2ObligCtrl.Enabled := Cliente_CamposLibresCtrl.Checked;
     Cliente_CampoLib3ObligCtrl.Enabled := Cliente_CamposLibresCtrl.Checked;
     Cliente_CampoLib4ObligCtrl.Enabled := Cliente_CamposLibresCtrl.Checked;
end;

procedure TBoxPdeCliForm.Cliente_RegAuxiliarCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     Cliente_NombreRegAuxiliarCtrl.Enabled := Cliente_RegAuxiliarCtrl.Checked;
     Cliente_DireccionAuxiliarCtrl.Enabled := Cliente_RegAuxiliarCtrl.Checked;
     For var CampoAuxCtrl in FCampoAuxCtrlArray do
       CampoAuxCtrl.Enabled := Cliente_RegAuxiliarCtrl.Checked;
end;

procedure TBoxPdeCliForm.Cliente_TarCodigoCtrlPropertiesChange(Sender: TObject);
begin
     Cliente_TarCantidadMinimaCtrl.Enabled := Cliente_TarCodigoCtrl.Checked;
end;

procedure SetupUnit;
begin
     If   ProgramNumber in [ pnDesarrollo, pnTPV, pnComercial, pnContableComercial, pnPreventa ]
     then If   Assigned( Gds00Frm )
          then With Gds00Frm do
                 begin
                 ConfiguracionClientesItem.Visible := ivAlways;
                 ConfiguracionClientesItem.OnClick := TBoxPdeCliForm.ConfiguracionClientes;
                 end;
end;

initialization

     AddProcedure( imStartUp, 0, SetupUnit );
end.

