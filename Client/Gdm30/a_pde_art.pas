
unit a_pde_art;

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
  dxUIAClasses;

type
  TBoxPdeArtForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    PageControl: TcxPageControl;
    ArticulosTS: TcxTabSheet;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    EmpresaTable: TnxeTable;
    DataSource: TDataSource;
    cxGroupBox5: TcxGroupBox;
    Articulo_ClaseACtrl: TcxDBCheckBox;
    Articulo_NombreClase1Ctrl: TcxDBTextEdit;
    Articulo_NombreClase2Ctrl: TcxDBTextEdit;
    Articulo_ClaseBCtrl: TcxDBCheckBox;
    Articulo_NombreClase3Ctrl: TcxDBTextEdit;
    Articulo_ClaseCCtrl: TcxDBCheckBox;
    CamposLibresArticuloGroupBox: TcxGroupBox;
    Articulo_CampoLibre1Ctrl: TcxDBTextEdit;
    Articulo_CampoLibre2Ctrl: TcxDBTextEdit;
    Articulo_CampoLibre3Ctrl: TcxDBTextEdit;
    Articulo_CampoLibre4Ctrl: TcxDBTextEdit;
    Articulo_CampoLib1ObligCtrl: TcxDBCheckBox;
    Articulo_CampoLib2ObligCtrl: TcxDBCheckBox;
    Articulo_CampoLib3ObligCtrl: TcxDBCheckBox;
    Articulo_CampoLib4ObligCtrl: TcxDBCheckBox;
    Articulo_CampoLibre5Ctrl: TcxDBTextEdit;
    Articulo_CampoLib5ObligCtrl: TcxDBCheckBox;
    Articulo_CampoLibre6Ctrl: TcxDBTextEdit;
    Articulo_CampoLib6ObligCtrl: TcxDBCheckBox;
    Articulo_CampoLibre7Ctrl: TcxDBTextEdit;
    Articulo_CampoLib7ObligCtrl: TcxDBCheckBox;
    Articulo_CampoLibre8Ctrl: TcxDBTextEdit;
    Articulo_CampoLib8ObligCtrl: TcxDBCheckBox;
    Articulo_CampoLibre9Ctrl: TcxDBTextEdit;
    Articulo_CampoLib9ObligCtrl: TcxDBCheckBox;
    Label50: TcxLabel;
    Label51: TcxLabel;
    Label52: TcxLabel;
    Label53: TcxLabel;
    Label29: TcxLabel;
    Label31: TcxLabel;
    Label33: TcxLabel;
    Label34: TcxLabel;
    Label35: TcxLabel;
    cxLabel6: TcxLabel;
    Articulo_EnvaseCtrl: TcxDBIndexedComboBox;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    Articulo_TipoEnvaseCtrl: TcxDBIndexedComboBox;
    Articulo_CampoLibre10Ctrl: TcxDBTextEdit;
    Articulo_CampoLib10ObligCtrl: TcxDBCheckBox;
    Articulo_CampoLibre11Ctrl: TcxDBTextEdit;
    Articulo_CampoLib11ObligCtrl: TcxDBCheckBox;
    Articulo_CampoLibre12Ctrl: TcxDBTextEdit;
    Articulo_CampoLib12ObligCtrl: TcxDBCheckBox;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    cxLabel11: TcxLabel;
    cxLabel12: TcxLabel;
    cxLabel13: TcxLabel;
    cxLabel14: TcxLabel;
    cxLabel15: TcxLabel;
    cxLabel16: TcxLabel;
    cxLabel17: TcxLabel;
    cxLabel18: TcxLabel;
    cxLabel19: TcxLabel;
    cxLabel20: TcxLabel;
    cxLabel21: TcxLabel;
    cxLabel22: TcxLabel;
    cxLabel23: TcxLabel;
    Articulo_PermitirModificarPesoCtrl: TcxDBCheckBox;
    Articulo_CampoLibre13Ctrl: TcxDBTextEdit;
    cxDBCheckBox1: TcxDBCheckBox;
    cxLabel48: TcxLabel;
    cxLabel50: TcxLabel;
    Articulo_CampoLibre14Ctrl: TcxDBTextEdit;
    cxDBCheckBox2: TcxDBCheckBox;
    cxLabel49: TcxLabel;
    cxLabel51: TcxLabel;
    Articulo_CampoLibre15Ctrl: TcxDBTextEdit;
    cxDBCheckBox3: TcxDBCheckBox;
    cxLabel52: TcxLabel;
    cxLabel53: TcxLabel;
    cxGroupBox10: TcxGroupBox;
    CajasCtrl: TcxDBCheckBox;
    PalletsCtrl: TcxDBCheckBox;
    BultosCtrl: TcxDBCheckBox;
    Articulo_SoloCodificadosCtrl: TcxDBCheckBox;
    Articulo_MargenSobrePrecioCompraCtrl: TcxDBCheckBox;
    Articulo_EditarMedidasCtrl: TcxDBCheckBox;
    Articulo_DtosCompraEnMargenesCtrl: TcxDBCheckBox;
    Articulo_StockMinMaxPorAlmacenCtrl: TcxDBCheckBox;
    Articulo_TarifaClaseCtrl: TcxDBCheckBox;
    Articulo_PuntoVerdeCtrl: TcxDBCheckBox;
    Articulo_PreciosIVACtrl: TcxDBCheckBox;
    Articulo_UnidadesPorPrecioCtrl: TcxDBCheckBox;
    Articulo_CamposLibCtrl: TcxDBCheckBox;
    ArticulosRelacionadosCtrl: TcxDBCheckBox;
    ClasesTS: TcxTabSheet;
    CamposLibresTS: TcxTabSheet;
    Articulo_CampoLibre16Ctrl: TcxDBTextEdit;
    cxDBCheckBox4: TcxDBCheckBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    Articulo_ContenedorCtrl: TcxComboBox;
    cxLabel4: TcxLabel;
    Articulo_TipoContenedorCtrl: TcxDBIndexedComboBox;
    ContribucionRAPCtrl: TcxDBCheckBox;
    cxDBCheckBox5: TcxDBCheckBox;
    procedure Articulo_CamposLibCtrlPropertiesChange(Sender: TObject);
    procedure Articulo_PreciosIVACtrlPropertiesChange(Sender: TObject);
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure FormManagerDestroyForm;
    procedure Articulo_ClaseCCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure Articulo_ClaseBCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure Articulo_ClaseACtrlPropertiesEditValueChanged(Sender: TObject);
    procedure Articulo_ClaseCtrlPropertiesValuePosted(Sender: TObject);
    procedure FormManagerPreparedForm;
    procedure Articulo_EnvaseCtrlPropertiesValuePosted(Sender: TObject);
  private
    FEmpresaFields : TEmpresaFields;
    function GetEmpresaFields : TEmpresaFields;
    procedure ActualizaEnvases;
    procedure ActualizaContenedores;
  protected
    class procedure ConfiguracionArticulos( Sender : TObject);
  public
    property EmpresaFields : TEmpresaFields read GetEmpresaFields;
  end;

var
  BoxPdeArtForm: TBoxPdeArtForm = nil;

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
       dm_iva,

       b_upd,
       b_msg,
       b_dir,

       a_alm,
       a_sdf,

       cx_emp,
       cx_sdf,
       cx_alm;

resourceString
       RsMsg1  = 'Nombre [%s]';
       RsMsg4  = 'Cajas';
       RsMsg5  = 'Alto';

       RsNinguno  = '<Ninguno>';

class procedure TBoxPdeArtForm.ConfiguracionArticulos( Sender : TObject);
begin
     CreateEditForm( TBoxPdeArtForm, BoxPdeArtForm, Gds00Frm.ConfigurationSection, True );
end;

procedure TBoxPdeArtForm.FormManagerInitializeForm;

var  Index : SmallInt;
     ExisteModuloTPV : Boolean;

begin

     CloseWindowWhenFocusLost := True;

     With EmpresaTable do
       If   FindKey( [ CodigoEmpresaActual ] )
       then Edit
       else Abort;

     ExisteModuloTPV := ApplicationContainer.IsModuleActive( [ 20 ] );

     With Articulo_PreciosIVACtrl do
       begin
       If   not ExisteModuloTPV and EmpresaFields.Articulo_PreciosIVA.Value
       then EmpresaFields.Articulo_PreciosIVA.Clear;
       Visible := ExisteModuloTPV;  // Solo en el T.P.V.
       end;

     ContribucionRAPCtrl.Visible := DataModule00.Envases;
end;

function TBoxPdeArtForm.GetEmpresaFields : TEmpresaFields;
begin
     If   not Assigned( FEmpresaFields )
     then FEmpresaFields := TEmpresaFields.Create( EmpresaTable );
     Result := FEmpresaFields;
end;

procedure TBoxPdeArtForm.FormManagerOkButton;
begin

     // En el combo de envases están todas las clases disponibles

     EmpresaFields.Articulo_Contenedor.Value := Articulo_EnvaseCtrl.Properties.Items.IndexOf( Articulo_ContenedorCtrl.Text );

     EmpresaTable.Post;
     DataModule00.DmEmpresaTable.GotoCurrent( EmpresaTable );
     FormManager.CloseWindow := True;
     Gds00Frm.ConfigurationSection.UpdateMainMenu;
end;

procedure TBoxPdeArtForm.FormManagerPreparedForm;
begin
     ActualizaEnvases;
     ActualizaContenedores;
end;

procedure TBoxPdeArtForm.FormManagerDestroyForm;
begin
     EmpresaTable.Cancel;
end;

procedure TBoxPdeArtForm.Articulo_CamposLibCtrlPropertiesChange(Sender: TObject);
begin
     SetGroupBoxControlsEnabled( CamposLibresArticuloGroupBox, Articulo_CamposLibCtrl.Checked, True );
end;

procedure TBoxPdeArtForm.ActualizaEnvases;
begin
     With Articulo_EnvaseCtrl.Properties do
       begin

       Items.Clear;
       Items.Add( RsNinguno );
       If   Articulo_ClaseACtrl.Checked
       then Items.Add( Articulo_NombreClase1Ctrl.Text );
       If   Articulo_ClaseBCtrl.Checked
       then Items.Add( Articulo_NombreClase2Ctrl.Text );
       If   Articulo_ClaseCCtrl.Checked
       then Items.Add( Articulo_NombreClase3Ctrl.Text );

       If   ( EmpresaTable.State=dsEdit ) and ( EmpresaFields.Articulo_Envase.Value>=Items.Count )
       then EmpresaFields.Articulo_Envase.Value := 0;

       Articulo_EnvaseCtrl.Enabled := DataModule00.Envases and CajasCtrl.Checked and ( Items.Count>1 );

       Articulo_TipoEnvaseCtrl.Enabled := Articulo_EnvaseCtrl.Enabled;
       Articulo_PermitirModificarPesoCtrl.Enabled := Articulo_TipoEnvaseCtrl.Enabled;
       end;

end;

procedure TBoxPdeArtForm.ActualizaContenedores;
begin
     With Articulo_ContenedorCtrl.Properties do
       begin

       Items.Clear;

       Items.Add( RsNinguno );

       If   Articulo_ClaseACtrl.Checked and ( EmpresaFields.Articulo_Envase.Value<>tcClaseA )
       then Items.Add( Articulo_NombreClase1Ctrl.Text );
       If   Articulo_ClaseBCtrl.Checked and ( EmpresaFields.Articulo_Envase.Value<>tcClaseB )
       then Items.Add( Articulo_NombreClase2Ctrl.Text );
       If   Articulo_ClaseCCtrl.Checked and ( EmpresaFields.Articulo_Envase.Value<>tcClaseC )
       then Items.Add( Articulo_NombreClase3Ctrl.Text );

       If   EmpresaTable.State=dsEdit
       then If   EmpresaFields.Articulo_Contenedor.Value in [ tcClaseA..tcClaseC ]
            then begin
                 var NombreContenedor := EmpresaFields.Articulo_NombreClase[ EmpresaFields.Articulo_Contenedor.Value ].Value;
                 Articulo_ContenedorCtrl.ItemIndex := Articulo_ContenedorCtrl.Properties.Items.IndexOf( NombreContenedor );
                 end
            else Articulo_ContenedorCtrl.ItemIndex := 0;

       Articulo_ContenedorCtrl.Enabled := DataModule00.Envases and ( Items.Count>1 );
       Articulo_TipoContenedorCtrl.Enabled := Articulo_ContenedorCtrl.Enabled;
       end;

end;

procedure TBoxPdeArtForm.Articulo_ClaseACtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   Articulo_ClaseACtrl.Editing
     then If   not EmpresaFields.Articulo_ExisteClase[ tcClaseA ].Value
          then begin
               EmpresaFields.Articulo_ExisteClase[ tcClaseB ].Value := False;
               EmpresaFields.Articulo_TarifaClase.Value := False;
               end;

     Articulo_NombreClase1Ctrl.Enabled := EmpresaFields.Articulo_ExisteClase[ tcClaseA ].Value;
     Articulo_ClaseBCtrl.Enabled := EmpresaFields.Articulo_ExisteClase[ tcClaseA ].Value;
     Articulo_TarifaClaseCtrl.Enabled := EmpresaFields.Articulo_ExisteClase[ tcClaseA ].Value;

     Articulo_ClaseBCtrlPropertiesEditValueChanged( nil );

end;

procedure TBoxPdeArtForm.Articulo_ClaseCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaEnvases;
     ActualizaContenedores;
end;

procedure TBoxPdeArtForm.Articulo_ClaseBCtrlPropertiesEditValueChanged(Sender: TObject);
begin

     If   Articulo_ClaseBCtrl.Editing
     then If   not EmpresaFields.Articulo_ExisteClase[ tcClaseB ].Value
          then EmpresaFields.Articulo_ExisteClase[ tcClaseC ].Value := False;

     Articulo_NombreClase2Ctrl.Enabled := EmpresaFields.Articulo_ExisteClase[ tcClaseB ].Value;
     Articulo_ClaseCCtrl.Enabled := EmpresaFields.Articulo_ExisteClase[ tcClaseB ].Value;

     Articulo_ClaseCCtrlPropertiesEditValueChanged( nil );
end;

procedure TBoxPdeArtForm.Articulo_ClaseCCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     Articulo_NombreClase3Ctrl.Enabled := EmpresaFields.Articulo_ExisteClase[ tcClaseC ].Value;
end;

procedure TBoxPdeArtForm.Articulo_EnvaseCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaContenedores;

     Articulo_ContenedorCtrl.ItemIndex := 0;
end;

procedure TBoxPdeArtForm.Articulo_PreciosIVACtrlPropertiesChange(Sender: TObject);
begin
     With Articulo_PreciosIVACtrl do
       If   Editing
       then begin
            If   Checked
            then EmpresaFields.Ventas_Recargos.Value := False;
            EmpresaFields.Ventas_DocumentosSinIVAIncluido.Value := False;   // Se reinicia siempre
            end;
end;

procedure SetupUnit;
begin
     If   ProgramNumber in [ pnDesarrollo, pnTPV, pnComercial, pnContableComercial, pnPreventa, pnPrevision, pnProduccion ]
     then With Gds00Frm do
            begin
            ConfiguracionArticulosItem.Visible := ivAlways;
            ConfiguracionArticulosItem.OnClick := TBoxPdeArtForm.ConfiguracionArticulos;
            end;
end;

initialization

     AddProcedure( imStartUp, 0, SetupUnit );
end.

