unit a_pex;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,

  AppContainer,

  ExtCtrls, Menus, cxLookAndFeelPainters, cxButtons,

  Gdm90Dm, DB, nxdb, DataManager, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxDBEdit, cxGraphics, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox;

type
  TMntPexForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyScreen: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    DataScreen: TgxEditPanel;
    NombreCtrl: TcxDBTextEdit;
    DomicilioCtrl: TcxDBTextEdit;
    LocalidadCtrl: TcxDBTextEdit;
    ProveedorExternoTable: TnxeTable;
    DataSource: TDataSource;
    PaisCtrl: TcxDBTextEdit;
    CodigoProvinciaCtrl: TcxDBTextEdit;
    CodigoPostalCtrl: TcxDBTextEdit;
    ProveedorExternoTableCodigo: TWideStringField;
    ProveedorExternoTableNombre: TWideStringField;
    ProveedorExternoTableDomicilio: TWideStringField;
    ProveedorExternoTableLocalidad: TWideStringField;
    ProveedorExternoTableCodigoPais: TWideStringField;
    ProveedorExternoTableCodigoProvincia: TWideStringField;
    ProveedorExternoTableCodigoPostal: TWideStringField;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label8: TcxLabel;
    DescPaisLabel: TcxLabel;
    Label4: TcxLabel;
    DescCPLabel: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    procedure PaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure PaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure PaisCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoProvinciaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesEditValueChanged(Sender: TObject);
  private

  public

  end;

var  MntPexForm: TMntPexForm = nil;

procedure MntProveedoresExternos( KeyValues : array of const );

implementation

{$R *.DFM}

uses   EnterpriseDataAccess,


       dm_pai,
       dm_prv,
       dm_cop,
       
       b_msg,

       a_pai,
       a_prv,
       a_cop,

       cx_pai,
       cx_prv,
       cx_cop,
       cx_pex;

procedure MntProveedoresExternos( KeyValues : array of const );
begin
     CreateEditForm( TMntPexForm, MntPexForm, KeyValues );
end;

procedure TMntPexForm.CodigoCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaProveedoresExternos( Sender );
end;

procedure TMntPexForm.CodigoPostalCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntCodigosPostales( [ ProveedorExternoTableCodigoPais.Value, ProveedorExternoTableCodigoProvincia.Value, Sender.EditingValue ] );
end;

procedure TMntPexForm.CodigoPostalCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( ProveedorExternoTableCodigoPais.Value, ProveedorExternoTableCodigoProvincia.Value, Sender );
end;

procedure TMntPexForm.CodigoPostalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( ProveedorExternoTableCodigoPais.Value, ProveedorExternoTableCodigoProvincia.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPexForm.CodigoProvinciaCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntProvincias( [ ProveedorExternoTableCodigoPais.Value, Sender.EditingValue ] );
end;

procedure TMntPexForm.CodigoProvinciaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   CodigoProvinciaCtrl.Editing
     then CodigoPostalCtrl.PostEditValue( '' );    
end;

procedure TMntPexForm.CodigoProvinciaCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaProvincias( ProveedorExternoTableCodigoPais.Value, Sender );
end;

procedure TMntPexForm.CodigoProvinciaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( ProveedorExternoTableCodigoPais.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPexForm.PaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntPaises( [ Sender.EditingValue ] );
end;

procedure TMntPexForm.PaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TMntPexForm.PaisCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
end;

end.
