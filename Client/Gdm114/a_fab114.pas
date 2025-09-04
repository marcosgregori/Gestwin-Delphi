unit a_fab114;

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

  Gim114Fields,
  
  Gdm114Dm, 

  dxBarBuiltInMenu;

type
  TMntFab114Form = class(TgxForm)
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
    Panel3: TcxGroupBox;
    DataSource: TDataSource;
    FabricaTable: TnxeTable;
    TAnnotationFrame1: TAnnotationFrame;
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
    EnviarCorreoBtn: TgBitBtn;
    Label1: TcxLabel;
    cxLabel1: TcxLabel;
    CodigoArticuloCtrl: TcxDBTextEdit;
    cxLabel2: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    procedure FabricaTableNewRecord(DataSet: TDataSet);
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
    procedure AnotacionButtonClick(Sender: TObject);
    procedure PaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure EnviarCorreoBtnClick(Sender: TObject);
    procedure CodigoArticuloCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private
    FabricaFields : TFabricaFields;
  protected
    class procedure MntFabricasLink( Sender : TObject );
  public

  end;

var  MntFab114Form: TMntFab114Form = nil;

procedure MntFabricas( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim30Fields,
       Gdm30Frm,

       dm_ddc,
       dm_fab114,
       dm_prv,
       dm_pai,
       dm_cop,
       dm_art,

       a_pai,
       a_prv,
       a_cop,
       a_art,

       bx_not,

       cx_fab114,
       cx_pai,
       cx_prv,
       cx_cop,
       cx_art,

       l_fab114;

class procedure TMntFab114Form.MntFabricasLink( Sender : TObject );
begin
     MntFabricas( [] );
end;

procedure MntFabricas( KeyValues : array of const );
begin
     CreateEditForm( TmntFab114Form, MntFab114Form, KeyValues );
end;

procedure TMntFab114Form.FormManagerInitializeForm;
begin
     FabricaFields := TFabricaFields.Create( FabricaTable );
end;

procedure TMntFab114Form.FabricaTableNewRecord(DataSet: TDataSet);
begin
     FabricaFields.CodigoPais.Value := CodigoEspaña;
end;

procedure TMntFab114Form.AnotacionButtonClick(Sender: TObject);
begin
     MntAnotacion( FabricaFields.Anotacion );
end;

procedure TMntFab114Form.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntFab114Form.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scCompras, False, Sender );
end;

procedure TMntFab114Form.CodigoArticuloCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                               var DisplayValue : Variant;
                                                               var ErrorText    : TCaption;
                                                               var Error        : Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntFab114Form.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFabricas( Sender, qgsLinked );
end;

procedure TMntFab114Form.CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosPostales( [ FabricaFields.CodigoPais.Value, FabricaFields.CodigoProvincia.Value, Sender.EditingValue ] );
end;

procedure TMntFab114Form.CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( FabricaFields.CodigoPais.Value, FabricaFields.CodigoProvincia.Value, Sender );
end;

procedure TMntFab114Form.CodigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( FabricaFields.CodigoPais.Value, FabricaFields.CodigoProvincia.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntFab114Form.CodigoProvinciaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProvincias( [ FabricaFields.CodigoPais.Value, Sender.Editingvalue ] );
end;

procedure TMntFab114Form.CodigoProvinciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( FabricaFields.CodigoPais.Value, Sender );
end;

procedure TMntFab114Form.CodigoProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( FabricaFields.CodigoPais.Value, Sender, DisplayValue, ErrorText, Error );
     If   Sender.ModifiedAfterEnter
     then CodigoPostalCtrl.EditValue := '';
end;

procedure TMntFab114Form.EnviarCorreoBtnClick(Sender: TObject);
begin
     DireccionCorreo.Redacta( FabricaFields.EMail.Value );
end;

procedure TMntFab114Form.FormManagerReportRequest;
begin
     ListadoFabricas;
end;

procedure TMntFab114Form.PaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntPaises( [ Sender.EditingValue ] );
end;

procedure TMntFab114Form.PaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With PaisCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := CodigoEspaña;
end;

procedure TMntFab114Form.PaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TMntFab114Form.PaisCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure InitializeModule;
begin
     With Gds30Frm do
       begin
       FabricasItem.Visible := ivAlways;
       FabricasItem.OnClick := TMntFab114Form.MntFabricasLink;
       end;
end;


initialization
  AddProcedure( imOnEnterpriseAccess, 0, InitializeModule );

end.
