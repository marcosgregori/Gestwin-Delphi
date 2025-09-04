unit a_orp;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
     ExtCtrls, ComCtrls,

     AppContainer,
     Menus, cxLookAndFeelPainters, cxButtons, cxCurrencyEdit,
     cxDBEdit, cxPC, cxControls, cxContainer, cxEdit, cxTextEdit, DB, nxdb,
     DataManager, cxMemo, cxCheckBox, cxMaskEdit, cxSpinEdit, cxRichEdit,
     cxDBRichEdit,

     dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
     cxGraphics, cxLookAndFeels, f_not, cxLabel, cxGroupBox,
     cxPCdxBarPopupMenu, dxSkinsdxBarPainter, dxBar, dxBarExtItems, cxClasses,
     Vcl.Dialogs, Vcl.Graphics, frxDesgnCtrls,

     cxDropDownEdit, cxIndexedComboBox,

     Gim30Fields, dxUIAClasses;

type
  TMntOrpForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    Panel4: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    DataSource: TDataSource;
    OrganismoPublicoTable: TnxeTable;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    NombreCtrl: TcxDBTextEdit;
    DomicilioCtrl: TcxDBTextEdit;
    LocalidadCtrl: TcxDBTextEdit;
    capDomicilioLabel: TcxLabel;
    capLocalidadLabel: TcxLabel;
    CodigoProvinciaCtrl: TcxDBTextEdit;
    CodigoPostalCtrl: TcxDBTextEdit;
    PaisCtrl: TcxDBTextEdit;
    capProvinciaLabel: TcxLabel;
    DescCPLabel: TcxLabel;
    Label8: TcxLabel;
    DescPaisLabel: TcxLabel;
    cxLabel1: TcxLabel;
    TipoCtrl: TcxDBIndexedComboBox;
    CodigoCentroCtrl: TcxDBTextEdit;
    CodigoCentroLabel: TcxLabel;
    cxLabel3: TcxLabel;
    CodigoPaisEnNIFCtrl: TcxDBCheckBox;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    procedure OrganismoPublicoTableNewRecord(DataSet: TDataSet);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
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
    procedure PaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure TipoCtrlPropertiesChange(Sender: TObject);
    procedure CodigoCentroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCentroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure OrganismoPublicoTableGetRecord(DataSet: TDataSet);
  private
    OrganismoPublicoFields : TOrganismoPublicoFields;

  public
    class procedure EdicionOrganismoPublico(Sender: TObject);
  end;

var  MntOrpForm: TMntOrpForm = nil;

procedure MntOrganismoPublico( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       EnterpriseDataAccess,
       AppManager,

       Gdm30Frm,

       dm_ddc,
       dm_prv,
       dm_pai,
       dm_cop,
       dm_pga,
       dm_orp,

       a_pai,
       a_prv,
       a_cop,

       bx_not,

       cx_orp,
       cx_pai,
       cx_prv,
       cx_cop,

       l_orp;

resourceString
       RsMsg1 = '';

const  DescripcionCentro : Array [ 0..2 ] of String = ( 'Oficina contable', 'Órgano gestor', 'Unidad tramitadora' );

procedure MntOrganismoPublico( KeyValues : array of const );
begin
     CreateEditForm( TMntOrpForm, MntOrpForm, KeyValues, TGds30Frm.VentasSection );
end;

procedure TMntOrpForm.FormManagerInitializeForm;
begin
     OrganismoPublicoFields := TOrganismoPublicoFields.Create( OrganismoPublicoTable );
end;

procedure TMntOrpForm.OrganismoPublicoTableGetRecord(DataSet: TDataSet);
begin
     CodigoPaisEnNIFCtrl.Enabled := OrganismoPublicoFields.Tipo.Value=topOficinaContable;
end;

procedure TMntOrpForm.OrganismoPublicoTableNewRecord(DataSet: TDataSet);
begin
     OrganismoPublicoFields.CodigoPais.Value := CodigoEspaña;
end;

procedure TMntOrpForm.CodigoCentroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOrganismosPublicos( OrganismoPublicoFields.Tipo.Value - 1, Sender );
end;

procedure TMntOrpForm.CodigoCentroCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     OrganismoPublico.Valida( OrganismoPublicoFields.Tipo.Value - 1, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntOrpForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOrganismosPublicos( OrganismoPublicoFields.Tipo.Value, Sender, qgsLinked );
end;

procedure TMntOrpForm.CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosPostales( [ OrganismoPublicoFields.CodigoPais.Value, OrganismoPublicoFields.CodigoProvincia.Value, Sender.EditingValue ] );
end;

procedure TMntOrpForm.CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( OrganismoPublicoFields.CodigoPais.Value, OrganismoPublicoFields.CodigoProvincia.Value, Sender );
end;

procedure TMntOrpForm.CodigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( OrganismoPublicoFields.CodigoPais.Value, OrganismoPublicoFields.CodigoProvincia.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntOrpForm.CodigoProvinciaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProvincias( [ OrganismoPublicoFields.CodigoPais.Value, Sender.Editingvalue ] );
end;

procedure TMntOrpForm.CodigoProvinciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( OrganismoPublicoFields.CodigoPais.Value, Sender );
end;

procedure TMntOrpForm.CodigoProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( OrganismoPublicoFields.CodigoPais.Value, Sender, DisplayValue, ErrorText, Error );
     If   Sender.ModifiedAfterEnter
     then CodigoPostalCtrl.EditValue := '';
end;

procedure TMntOrpForm.FormManagerReportRequest;
begin
     ListadoOrganismosPublicos;
end;

procedure TMntOrpForm.PaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntPaises( [ Sender.EditingValue ] );
end;

procedure TMntOrpForm.PaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With PaisCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := CodigoEspaña;
end;

procedure TMntOrpForm.PaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TMntOrpForm.PaisCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntOrpForm.TipoCtrlPropertiesChange(Sender: TObject);

var  IndicarCentro : Boolean;

begin
     IndicarCentro := TipoCtrl.ItemIndex in [ topOrganoGestor, topUnidadTramitadora ];
     If   IndicarCentro
     then CodigoCentroLabel.Caption := DescripcionCentro[ TipoCtrl.ItemIndex - 1 ];
     CodigoCentroCtrl.Enabled := IndicarCentro;
end;

class procedure TMntOrpForm.EdicionOrganismoPublico( Sender : TObject );
begin
     MntOrganismoPublico( [] );
end;


end.
