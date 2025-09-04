unit a_tra;

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
  cxPCdxBarPopupMenu, dxBarBuiltInMenu, dxUIAClasses;

type
  TMntTraForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    Panel4: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    PageControl1: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    panel1: TcxGroupBox;
    NombreCtrl: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    DomicilioCtrl: TcxDBTextEdit;
    LocalidadCtrl: TcxDBTextEdit;
    TelefonoCtrl: TcxDBTextEdit;
    FaxCtrl: TcxDBTextEdit;
    CodigoProvinciaCtrl: TcxDBTextEdit;
    CodigoPostalCtrl: TcxDBTextEdit;
    DataSource: TDataSource;
    TransportistaTable: TnxeTable;
    PaisCtrl: TcxDBTextEdit;
    MovilCtrl: TcxDBTextEdit;
    NIFCtrl: TcxDBTextEdit;
    TAnnotationFrame1: TAnnotationFrame;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    capDomicilioLabel: TcxLabel;
    capLocalidadLabel: TcxLabel;
    capTelefonoLabel: TcxLabel;
    capProvinciaLabel: TcxLabel;
    DescCPLabel: TcxLabel;
    capFaxLabel: TcxLabel;
    Label8: TcxLabel;
    DescPaisLabel: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    EMailCtrl: TcxDBTextEdit;
    Label10: TcxLabel;
    cxLabel1: TcxLabel;
    MatriculaCtrl: TcxDBTextEdit;
    DescNIF: TcxLabel;
    EnviarCorreoBtn: TgBitBtn;
    cxLabel2: TcxLabel;
    SemiremolqueCtrl: TcxDBTextEdit;
    cxLabel3: TcxLabel;
    CodigoProveedorCtrl: TcxDBTextEdit;
    cxLabel4: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure TransportistaTableNewRecord(DataSet: TDataSet);
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
    procedure NIFCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure AnotacionButtonClick(Sender: TObject);
    procedure PaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure EnviarCorreoBtnClick(Sender: TObject);
    procedure CodigoProveedorCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private
    TransportistaFields : TTransportistaFields;
  public

  end;

var  MntTraForm: TMntTraForm = nil;

procedure MntTransportistas( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dm_ddc,
       dm_tra,
       dm_prv,
       dm_pai,
       dm_cop,
       dm_pro,

       a_pai,
       a_prv,
       a_cop,
       a_pro,

       bx_not,

       cx_tra,
       cx_pai,
       cx_prv,
       cx_cop,
       cx_pro,

       l_tra;

resourceString
       RsMsg1 = 'Factor de comisión';

procedure MntTransportistas( KeyValues : array of const );
begin
     CreateEditForm( TMntTraForm, MntTraForm, KeyValues, TGds30Frm.AlmacenSection );
end;

procedure TMntTraForm.FormManagerInitializeForm;
begin
     TransportistaFields := TTransportistaFields.Create( TransportistaTable );
end;

procedure TMntTraForm.TransportistaTableNewRecord(DataSet: TDataSet);
begin
     TransportistaFields.CodigoPais.Value := CodigoEspaña;
end;

procedure TMntTraForm.AnotacionButtonClick(Sender: TObject);
begin
     MntAnotacion( TransportistaFields.Anotacion );
end;

procedure TMntTraForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTransportistas( Sender, qgsLinked );
end;

procedure TMntTraForm.CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosPostales( [ TransportistaFields.CodigoPais.Value, TransportistaFields.CodigoProvincia.Value, Sender.EditingValue ] );
end;

procedure TMntTraForm.CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( TransportistaFields.CodigoPais.Value, TransportistaFields.CodigoProvincia.Value, Sender );
end;

procedure TMntTraForm.CodigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( TransportistaFields.CodigoPais.Value, TransportistaFields.CodigoProvincia.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTraForm.CodigoProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TMntTraForm.CodigoProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TMntTraForm.CodigoProveedorCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                             var DisplayValue : Variant;
                                                             var ErrorText    : TCaption;
                                                             var Error        : Boolean );
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTraForm.CodigoProvinciaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProvincias( [ TransportistaFields.CodigoPais.Value, Sender.Editingvalue ] );
end;

procedure TMntTraForm.CodigoProvinciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( TransportistaFields.CodigoPais.Value, Sender );
end;

procedure TMntTraForm.CodigoProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( TransportistaFields.CodigoPais.Value, Sender, DisplayValue, ErrorText, Error );
     If   Sender.ModifiedAfterEnter
     then CodigoPostalCtrl.EditValue := '';
end;

procedure TMntTraForm.EnviarCorreoBtnClick(Sender: TObject);
begin
     DireccionCorreo.Redacta( TransportistaFields.EMail.Value );
end;

procedure TMntTraForm.FormManagerReportRequest;
begin
     ListadoTransportistas;
end;

procedure TMntTraForm.NIFCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.ValidaNIF( TransportistaFields.CodigoPais.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTraForm.PaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntPaises( [ Sender.EditingValue ] );
end;

procedure TMntTraForm.PaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With PaisCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := CodigoEspaña;
end;

procedure TMntTraForm.PaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TMntTraForm.PaisCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error
     then CodigoPostal.SetupCPControl( DisplayValue, [ CodigoProvinciaCtrl ], [ CodigoPostalCtrl ] );
end;

function TMntTraForm.FormManagerGetAccessLevel: Smallint;
begin
    Result := DataModule00.DmUsuarioFields.acALFicheros.Value;
end;

end.
