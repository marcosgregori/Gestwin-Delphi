
unit a_pde_pro;

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
  TBoxPdeProForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    PageControl: TcxPageControl;
    ProveedoresTS: TcxTabSheet;
    Proveedor_CampLibreCtrl: TcxDBCheckBox;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    EmpresaTable: TnxeTable;
    DataSource: TDataSource;
    Proveedor_Grupos: TcxDBCheckBox;
    cxGroupBox9: TcxGroupBox;
    Proveedor_CampoLib1Ctrl: TcxDBTextEdit;
    Proveedor_CampoLib2Ctrl: TcxDBTextEdit;
    Proveedor_CampoLib3Ctrl: TcxDBTextEdit;
    Proveedor_CampoLib4Ctrl: TcxDBTextEdit;
    Proveedor_CampoLib1ObligCtrl: TcxDBCheckBox;
    Proveedor_CampoLib2ObligCtrl: TcxDBCheckBox;
    Proveedor_CampoLib3ObligCtrl: TcxDBCheckBox;
    Proveedor_CampoLib4ObligCtrl: TcxDBCheckBox;
    Label1: TcxLabel;
    Label4: TcxLabel;
    Label15: TcxLabel;
    Label26: TcxLabel;
    Proveedor_RegAuxiliarCtrl: TcxDBCheckBox;
    Proveedor_NombreRegAuxiliarCtrl: TcxDBTextEdit;
    cxGroupBox14: TcxGroupBox;
    Proveedor_CampoAux1Ctrl: TcxDBTextEdit;
    Proveedor_CampoAux2Ctrl: TcxDBTextEdit;
    Proveedor_CampoAux3Ctrl: TcxDBTextEdit;
    Proveedor_CampoAux4Ctrl: TcxDBTextEdit;
    Proveedor_CampoAux5Ctrl: TcxDBTextEdit;
    Proveedor_CampoAux6Ctrl: TcxDBTextEdit;
    Proveedor_CampoAux7Ctrl: TcxDBTextEdit;
    Proveedor_CampoAux8Ctrl: TcxDBTextEdit;
    cxLabel24: TcxLabel;
    cxLabel25: TcxLabel;
    cxLabel26: TcxLabel;
    cxLabel27: TcxLabel;
    cxLabel28: TcxLabel;
    cxLabel29: TcxLabel;
    cxLabel30: TcxLabel;
    cxLabel31: TcxLabel;
    cxLabel32: TcxLabel;
    Proveedor_CampoAux9Ctrl: TcxDBTextEdit;
    Proveedor_CampoAux10Ctrl: TcxDBTextEdit;
    cxLabel36: TcxLabel;
    cxLabel37: TcxLabel;
    cxLabel43: TcxLabel;
    cxLabel44: TcxLabel;
    cxLabel45: TcxLabel;
    cxLabel46: TcxLabel;
    cxLabel47: TcxLabel;
    CamposLibresTS: TcxTabSheet;
    RegistroAuxiliarTS: TcxTabSheet;
    cxLabel38: TcxLabel;
    procedure Proveedor_CampLibreCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure FormManagerDestroyForm;
    procedure Proveedor_RegAuxiliarCtrlPropertiesEditValueChanged(
      Sender: TObject);
  private
    FEmpresaFields : TEmpresaFields;
    FCampoAuxCtrlArray : TcxCustomEditArray;
    function GetEmpresaFields : TEmpresaFields;
  protected
    class procedure ConfiguracionProveedores( Sender : TObject);
  public
    property EmpresaFields : TEmpresaFields read GetEmpresaFields;
  end;

var
  BoxPdeProForm: TBoxPdeProForm = nil;

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

       cx_emp;

resourceString
       RsNinguno  = '<Ninguno>';

       RsMsg1 = 'Debe indicar, al menos, el nombre de un campo del registro auxiliar.';
       RsMsg2 = 'Si no lo desea utilizar desmarque la opción "Usar registro auxiliar".';

class procedure TBoxPdeProForm.ConfiguracionProveedores( Sender : TObject);
begin
     CreateEditForm( TBoxPdeProForm, BoxPdeProForm, Gds00Frm.ConfigurationSection, True );
end;

procedure TBoxPdeProForm.FormManagerInitializeForm;
begin

     CloseWindowWhenFocusLost := True;

     FCampoAuxCtrlArray := GetCustomEditCtrlArray( Self, 'Proveedor_CampoAux', 1, 10 );

     With EmpresaTable do
       If   FindKey( [ CodigoEmpresaActual ] )
       then Edit
       else Abort;
end;

function TBoxPdeProForm.GetEmpresaFields : TEmpresaFields;
begin
     If   not Assigned( FEmpresaFields )
     then FEmpresaFields := TEmpresaFields.Create( EmpresaTable );
     Result := FEmpresaFields;
end;

procedure TBoxPdeProForm.FormManagerOkButton;
begin
     If   EmpresaFields.Proveedor_RegAuxiliar.Value
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

procedure TBoxPdeProForm.Proveedor_CampLibreCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     Proveedor_CampoLib1Ctrl.Enabled := Proveedor_CampLibreCtrl.Checked;
     Proveedor_CampoLib2Ctrl.Enabled := Proveedor_CampLibreCtrl.Checked;
     Proveedor_CampoLib3Ctrl.Enabled := Proveedor_CampLibreCtrl.Checked;
     Proveedor_CampoLib4Ctrl.Enabled := Proveedor_CampLibreCtrl.Checked;

     Proveedor_CampoLib1ObligCtrl.Enabled := Proveedor_CampLibreCtrl.Checked;
     Proveedor_CampoLib2ObligCtrl.Enabled := Proveedor_CampLibreCtrl.Checked;
     Proveedor_CampoLib3ObligCtrl.Enabled := Proveedor_CampLibreCtrl.Checked;
     Proveedor_CampoLib4ObligCtrl.Enabled := Proveedor_CampLibreCtrl.Checked;
end;

procedure TBoxPdeProForm.Proveedor_RegAuxiliarCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     Proveedor_NombreRegAuxiliarCtrl.Enabled := Proveedor_RegAuxiliarCtrl.Checked;
     For var CampoAuxCtrl in FCampoAuxCtrlArray do
        CampoAuxCtrl.Enabled := Proveedor_RegAuxiliarCtrl.Checked;
end;

procedure TBoxPdeProForm.FormManagerDestroyForm;
begin
     EmpresaTable.Cancel;
end;

procedure SetupUnit;
begin
     If   ProgramNumber in [ pnDesarrollo, pnComercial, pnContableComercial ]
     then If   Assigned( Gds00Frm )
          then With Gds00Frm do
                 begin
                 ConfiguracionProveedoresItem.Visible := ivAlways;
                 ConfiguracionProveedoresItem.OnClick := TBoxPdeProForm.ConfiguracionProveedores;
                 end;
end;

initialization

     AddProcedure( imStartUp, 0, SetupUnit );
end.

