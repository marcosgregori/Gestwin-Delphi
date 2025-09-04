unit a_ven;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
     ExtCtrls, ComCtrls,

     AppContainer,
     Menus, cxLookAndFeelPainters, cxButtons, cxCurrencyEdit,
     cxDBEdit, cxPC, cxControls, cxContainer, cxEdit, cxTextEdit, DB, nxdb,
     DataManager, cxMemo, cxCheckBox, cxMaskEdit, cxSpinEdit, cxRichEdit,
     cxDBRichEdit,

     Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxGraphics, cxLookAndFeels, f_not, cxLabel, cxGroupBox,
  cxPCdxBarPopupMenu, dxSkinsdxBarPainter, dxBar, dxBarExtItems, cxClasses,
  Vcl.Dialogs, Vcl.Graphics, frxDesgnCtrls, dxBarBuiltInMenu, dxUIAClasses;

type
  TMntVenForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    Panel4: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    DatEconButton: TgBitBtn;
    PageControl1: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    Panel3: TcxGroupBox;
    DataSource: TDataSource;
    VendedorTable: TnxeTable;
    cxTabSheet1: TcxTabSheet;
    Panel7: TcxGroupBox;
    BloqueadoCtrl: TcxDBCheckBox;
    TAnnotationFrame1: TAnnotationFrame;
    AnnotationFrame1: TAnnotationFrame;
    codigoCtrlCaption: TcxLabel;
    DomicilioCtrl: TcxDBTextEdit;
    LocalidadCtrl: TcxDBTextEdit;
    TelefonoCtrl: TcxDBTextEdit;
    FaxCtrl: TcxDBTextEdit;
    CodigoProvinciaCtrl: TcxDBTextEdit;
    CodigoPostalCtrl: TcxDBTextEdit;
    PaisCtrl: TcxDBTextEdit;
    MovilCtrl: TcxDBTextEdit;
    capDomicilioLabel: TcxLabel;
    capLocalidadLabel: TcxLabel;
    capProvinciaLabel: TcxLabel;
    DescCPLabel: TcxLabel;
    capFaxLabel: TcxLabel;
    Label8: TcxLabel;
    DescPaisLabel: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label10: TcxLabel;
    EMailCtrl: TcxDBTextEdit;
    NombreCtrl: TcxDBTextEdit;
    capTelefonoLabel: TcxLabel;
    NIFCtrl: TcxDBTextEdit;
    TipoIVACtrl: TcxDBSpinEdit;
    Factura_TipoRetCtrl: TcxDBSpinEdit;
    DescTipoFijoLabel: TcxLabel;
    capTipoFijoLabel: TcxLabel;
    DescRetencionLabel: TcxLabel;
    capRetencionLabel: TcxLabel;
    ComisionCtrl: TcxDBCurrencyEdit;
    capComisionLabel: TcxLabel;
    PorcentajeLabel: TcxLabel;
    DescNIF: TcxLabel;
    EnviarCorreoBtn: TgBitBtn;
    Label1: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure VendedorTableNewRecord(DataSet: TDataSet);
    procedure VendedorTableBeforeDelete(DataSet: TDataSet);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure datEconButtonClick(Sender: TObject);
    procedure CodigoPostalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure PaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure PaisCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Factura_TipoFijoIVACtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Factura_TipoFijoIVACtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Factura_TipoFijoIVACtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Factura_TipoRetCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Factura_TipoRetCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Factura_TipoRetCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NIFCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure EnviarCorreoBtnClick(Sender: TObject);
  private
    VendedorFields : TVendedorFields;
  public

  end;

var  MntVenForm: TMntVenForm = nil;

procedure MntVendedores( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dmi_iva,

       dm_ddc,
       dm_ven,
       dm_prv,
       dm_pai,
       dm_cop,
       dm_iva,

       a_pai,
       a_prv,
       a_cop,
       a_iva,
       a_ret,

       bx_not,

       cx_ven,
       cx_pai,
       cx_prv,
       cx_cop,
       cx_iva,
       cx_ret,

       l_ven,
       d_ven;

resourceString
       RsMsg1 = 'Factor de comisión';

procedure MntVendedores( KeyValues : array of const );
begin
     CreateEditForm( TmntVenForm, MntVenForm, KeyValues, TGds30Frm.VentasSection );
end;

procedure TMntVenForm.FormManagerInitializeForm;
begin
     VendedorFields := TVendedorFields.Create( VendedorTable );
     If   not DataModule00.DmEmpresaFields.Vendedor_ComPorCli.Value
     then begin
          CapComisionLabel.Caption := RsMsg1;
          PorcentajeLabel.Visible := False;
          end;
     SetEditControlDecimals( ComisionCtrl, 2 );
     DatEconButton.Enabled := DataModule00.DmUsuarioFields.acRE.Value=1;
end;

procedure TMntVenForm.VendedorTableBeforeDelete(DataSet: TDataSet);
begin
     Vendedor.SuprimeReferencias( VendedorFields.Codigo.Value );
end;

procedure TMntVenForm.VendedorTableNewRecord(DataSet: TDataSet);
begin
     VendedorFields.CodigoPais.Value := CodigoEspaña;
     If   not DataModule00.DmEmpresaFields.Vendedor_ComPorCli.Value
     then VendedorFields.Comision.Value := 1;   // es el factor de comisión
end;

procedure TMntVenForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender, qgsLinked );
end;

procedure TMntVenForm.CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosPostales( [ VendedorFields.CodigoPais.Value, VendedorFields.CodigoProvincia.Value, Sender.EditingValue ] );
end;

procedure TMntVenForm.CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( VendedorFields.CodigoPais.Value, VendedorFields.CodigoProvincia.Value, Sender );
end;

procedure TMntVenForm.CodigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( VendedorFields.CodigoPais.Value, VendedorFields.CodigoProvincia.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntVenForm.CodigoProvinciaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProvincias( [ VendedorFields.CodigoPais.Value, Sender.Editingvalue ] );
end;

procedure TMntVenForm.CodigoProvinciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( VendedorFields.CodigoPais.Value, Sender );
end;

procedure TMntVenForm.CodigoProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( VendedorFields.CodigoPais.Value, Sender, DisplayValue, ErrorText, Error );
     If   Sender.ModifiedAfterEnter
     then CodigoPostalCtrl.EditValue := '';
end;

procedure TMntVenForm.datEconButtonClick(Sender: TObject);
begin
     VendedorTable.Cancel;
     DatosEconomicosVendedores( [ VendedorFields.Codigo.Value ] );
end;

procedure TMntVenForm.EnviarCorreoBtnClick(Sender: TObject);
begin
     DireccionCorreo.Redacta( VendedorFields.EMail.Value );
end;

procedure TMntVenForm.FormManagerReportRequest;
begin
     ListadoVendedores;
end;

procedure TMntVenForm.NIFCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.ValidaNIF( VendedorFields.CodigoPais.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntVenForm.PaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntPaises( [ Sender.EditingValue ] );
end;

procedure TMntVenForm.PaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With PaisCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := CodigoEspaña;
end;

procedure TMntVenForm.PaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TMntVenForm.PaisCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error
     then CodigoPostal.SetupCPControl( DisplayValue, [ CodigoProvinciaCtrl ], [ CodigoPostalCtrl ] );
end;

procedure TMntVenForm.Factura_TipoFijoIVACtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTiposIVA( True );
end;

procedure TMntVenForm.Factura_TipoFijoIVACtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposIVA( Sender, siSoportado, ApplicationContainer.TodayDate );
end;

procedure TMntVenForm.Factura_TipoFijoIVACtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Tasa.ValidaTasa( Sender, DisplayValue, ErrorText, Error, siSoportado, ApplicationContainer.TodayDate );
end;

procedure TMntVenForm.Factura_TipoRetCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntRetenciones( True );
end;

procedure TMntVenForm.Factura_TipoRetCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRetenciones( ApplicationContainer.TodayDate, Sender );
end;

procedure TMntVenForm.Factura_TipoRetCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Tasa.ValidaRetencion( ApplicationContainer.TodayDate, Sender, DisplayValue, ErrorText, Error );
end;

function TMntVenForm.FormManagerGetAccessLevel: Smallint;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ acVEFicheros.Value, acVEVendedores.Value ] );
end;

end.
