unit f_pro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls, DB, nxDB, DataManager,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxCheckBox, cxMaskEdit, cxSpinEdit, cxCurrencyEdit,

  AppForms,
  
  Menus, cxLookAndFeelPainters, cxButtons, dxSkinsCore,
  dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox;

type
  TMntProFrame = class(TFrame)
    FacturacionPanel: TcxGroupBox;
    Factura_DtoPPCtrl: TcxDBCurrencyEdit;
    Factura_DtoESCtrl: TcxDBCurrencyEdit;
    Factura_CodigoGrupoCtrl: TcxDBTextEdit;
    Factura_RecFinancCtrl: TcxDBCurrencyEdit;
    datEconButton: TgBitBtn;
    DocumentosButton: TgBitBtn;
    EnviosPanel: TcxGroupBox;
    Envios_NombreCtrl: TcxDBTextEdit;
    Envios_DomicilioCtrl: TcxDBTextEdit;
    Envios_LocalidadCtrl: TcxDBTextEdit;
    Envios_FormaEnvioCtrl: TcxDBTextEdit;
    Envios_CodigoProvCtrl: TcxDBTextEdit;
    Envios_CodigoPostalCtrl: TcxDBTextEdit;
    ConsumosButton: TgBitBtn;
    Label5: TcxLabel;
    Label12: TcxLabel;
    CapGrupoProveedorLabel: TcxLabel;
    DescGrupoProveedorLabel: TcxLabel;
    Label11: TcxLabel;
    Label4: TcxLabel;
    Label34: TcxLabel;
    Label35: TcxLabel;
    NombreEnviosLabel: TcxLabel;
    DomicilioEnviosLabel: TcxLabel;
    LocalidadEnviosLabel: TcxLabel;
    FormaEnvioLabel: TcxLabel;
    cpEnviosLabel: TcxLabel;
    DescProvinciaEnviosLabel: TcxLabel;
    CampoLibre1Panel: TcxGroupBox;
    CampoLibre2Panel: TcxGroupBox;
    campo1Label: TcxLabel;
    CampoLibre1Ctrl: TcxDBTextEdit;
    CampoLibre3Panel: TcxGroupBox;
    CampoLibre4Panel: TcxGroupBox;
    campo2Label: TcxLabel;
    CampoLibre2Ctrl: TcxDBTextEdit;
    campo3Label: TcxLabel;
    CampoLibre3Ctrl: TcxDBTextEdit;
    campo4Label: TcxLabel;
    CampoLibre4Ctrl: TcxDBTextEdit;
    procedure Factura_AgrupacionCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Factura_AgrupacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Factura_AgrupacionCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Envios_CodigoPostalCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Envios_CodigoPostalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Envios_CodigoPostalCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Envios_CodigoProvCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Envios_CodigoProvCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Envios_CodigoProvCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure DatEconButtonClick(Sender: TObject);
    procedure DocumentosButtonClick(Sender: TObject);
    procedure Factura_CtaComprasCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Factura_CtaComprasCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ConsumosButtonClick(Sender: TObject);
  private
  protected
    procedure FormManagerReportRequest;
    procedure FormManagerLabelsRequest;
  end;

var MntProFrame : TMntProFrame;

implementation

uses EnterpriseDataAccess,
     AppManager,

     Gdm00Dm,

     Gim10Fields,
     Gim30Fields,

     Gdm30Frm,

     a_sub,
     a_pro,
     a_prv,
     a_gdp,
     a_cop,

     dm_sub,
     dm_prv,
     dm_cop,
     dm_gdp,

     cx_sub,
     cx_cop,
     cx_prv,
     cx_gdp,
     cx_cdt,

     b_rdp,
     b_rcp,
     b_msg,

     d_pro,
     l_pro,
     e_pro;

{$R *.dfm}

resourceString
     rsMsg1 = '';

procedure SetupFrame;

var Index : SmallInt;

procedure FijaCampoLibre( Index          : SmallInt;
                          CampoLibreCtrl : TcxDBTextEdit );

var  Panel : TcxGroupBox;

begin
     With DataModule00.DmEmpresaFields do
       If   not ValueIsEmpty( Proveedor_CampoLib[ Index ].Value )
       then begin
            Panel := CampoLibreCtrl.Parent as TcxGroupBox;
            Panel.Parent := MntProForm.EnviosTabSheet;
            Panel.Top := MaxSmallint;
            Panel.Align := alTop;
            CampoLibreCtrl.CaptionLabel.EditValue := Proveedor_CampoLib[ Index ].Value;
            CampoLibreCtrl.Properties.Required := Proveedor_CampoLibOblig[ Index ].Value;
            end;
end;

begin
     If   Assigned( MntProForm )
     then begin
          MntProFrame := TMntProFrame.Create( MntProForm );

          With MntProFrame do
            begin

            MntProForm.AppSection := TGds30Frm.ComprasSection;
            MntProForm.HelpFile := 'hs30';

            // Colocando los paneles y botones en su posición dentro de la ventana de edición

            With MntProForm.EnviosTabSheet do
              begin
              TabVisible := True;
              Visible := True;
              end;

            With EnviosPanel do
              begin
              Parent := MntProForm.EnviosTabSheet;
              Align := alTop;
              end;

            If   DataModule00.DmEmpresaFields.Proveedor_CampLibre.Value
            then begin
                 FijaCampoLibre( 1, CampoLibre1Ctrl );
                 FijaCampoLibre( 2, CampoLibre2Ctrl );
                 FijaCampoLibre( 3, CampoLibre3Ctrl );
                 FijaCampoLibre( 4, CampoLibre4Ctrl );
                 end;

            FacturacionPanel.Parent := MntProForm.FacturacionTabSheet;
            FacturacionPanel.Top := ScaledToCurrent( 200 );
            FacturacionPanel.Align := alTop;

            AddPanelButton( MntProForm.ButtonsContainerPanel, DocumentosButton );
            AddPanelButton( MntProForm.ButtonsContainerPanel, ConsumosButton );
            AddPanelButton( MntProForm.ButtonsContainerPanel, DatEconButton );

            // Inicializando los componentes

            With DataModule00.DmEmpresaFields do
              begin
              Factura_CodigoGrupoCtrl.Enabled := Proveedor_Grupos.Value;
              SetEditControlsDecimals( [ Factura_DtoPPCtrl, Factura_DtoESCtrl, Factura_RecFinancCtrl ], 2 );
              end;

            // Para el ajuste de los codigos postales

            MntProForm.Envios_CodigoProvCtrl := Envios_CodigoProvCtrl;
            MntProForm.Envios_CodigoPostalCtrl := Envios_CodigoPostalCtrl;

            MntProForm.FormManager.OnLabelsRequest := FormManagerLabelsRequest;
            MntProForm.FormManager.OnReportRequest := FormManagerReportRequest;
            end;

          ExecComponentProcedures( idMntProFrame, imOnCreateComponent );

          end;
end;

procedure TMntProFrame.Factura_AgrupacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntGruposProveedores( [ Sender.EditingValue ] );
end;

procedure TMntProFrame.Factura_AgrupacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposProveedores( Sender );
end;

procedure TMntProFrame.Factura_AgrupacionCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoProveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntProFrame.Factura_CtaComprasCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntProFrame.Factura_CtaComprasCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender );
end;

procedure TMntProFrame.ConsumosButtonClick(Sender: TObject);
begin
     RelacionConsumoProveedores( [ MntProForm.ProveedorFields.Codigo.value ] );
end;

procedure TMntProFrame.DatEconButtonClick(Sender: TObject);
begin
     MntProForm.ProveedorTable.Cancel;
     DatosEconomicosProveedores( [ MntProForm.ProveedorFields.Codigo.value ] );
end;

procedure TMntProFrame.DocumentosButtonClick(Sender: TObject);
begin
     MntProForm.ProveedorTable.Cancel;
     RelacionDocumentosProveedores( [ MntProForm.ProveedorFields.Codigo.Value ] );
end;

procedure TMntProFrame.Envios_CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With MntProForm do
       MntCodigosPostales( [ ProveedorFields.CodigoPais.Value, ProveedorFields.Envios_CodigoProv.Value, Sender.EditingValue ] );
end;

procedure TMntProFrame.Envios_CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With MntProForm do
       ConsultaCodigosPostales( ProveedorFields.CodigoPais.Value, ProveedorFields.Envios_CodigoProv.Value, Sender );
end;

procedure TMntProFrame.Envios_CodigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     With MntProForm do
       CodigoPostal.Valida( ProveedorFields.CodigoPais.Value, ProveedorFields.Envios_CodigoProv.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntProFrame.Envios_CodigoProvCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntProvincias( [ MntProForm.ProveedorFields.CodigoPais.Value, Sender.EditingValue ] );
end;

procedure TMntProFrame.Envios_CodigoProvCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With MntProForm do
       ConsultaProvincias( ProveedorFields.CodigoPais.Value, Sender );
end;

procedure TMntProFrame.Envios_CodigoProvCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     With MntProForm do
       Provincia.Valida( ProveedorFields.CodigoPais.Value, Sender, DisplayValue, ErrorText, Error );
     If   Sender.ModifiedAfterEnter
     then Envios_CodigoPostalCtrl.EditValue := '';
end;

procedure TmntProFrame.FormManagerReportRequest;
begin
     ListadoProveedores;
end;

procedure TmntProFrame.FormManagerLabelsRequest;
begin
     EtiquetasProveedores( MntProForm.ProveedorFields.Codigo.Value );
end;

initialization
  AddProcedure( imOnCreateComponent, idMntProForm, SetupFrame );

end.

