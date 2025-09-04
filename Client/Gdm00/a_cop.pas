
unit a_cop;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask,
  Controls, Classes, ExtCtrls, Tabs, DB, nxDB,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  Menus, cxLookAndFeelPainters, cxButtons, cxMemo, dxSkinsCore, cxGraphics,
  cxLookAndFeels, dxSkinsDefaultPainters, cxLabel, cxGroupBox, dxCore,
  dxCoreClasses, dxGDIPlusAPI, dxGDIPlusClasses,

  AppContainer,
  DataManager,
  DataAccess,

  Gim00Fields;

type
  TMntCopForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoProvinciaCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    CodigoCtrl: TcxDBTextEdit;
    DataSource: TDataSource;
    CodigoPostalTable: TnxeTable;
    CodigoPaisCtrl: TcxDBTextEdit;
    NombreCtrl: TcxDBMemo;
    codigoCtrlCaption: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label1: TcxLabel;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoProvinciaTextEditPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoProvinciaTextEditPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProvinciaTextEditPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPaisTextEditPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoPaisTextEditPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoPaisTextEditPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;

  private
    CodigoPostalFields : TCodigoPostalFields;
  public
  end;

var  MntCopForm: TMntCopForm;

procedure MntCodigosPostales( keyValues : array of const );

implementation

{$R *.DFM}

uses   Gdm00Frm,

       a_pai,
       a_prv,

       dm_pai,
       dm_prv,
       dm_cop,

       cx_pai,
       cx_cop,
       cx_prv,

       l_cop;

procedure MntCodigosPostales( keyValues : array of const );
begin
     CreateEditForm( TMntCopForm, MntCopForm, KeyValues );
end;

procedure TMntCopForm.FormManagerInitializeForm;
begin
     CodigoPostalFields := TCodigoPostalFields.Create( CodigoPostalTable );
end;

procedure TMntCopForm.FormManagerReportRequest;
begin
     ListadoCodigosPostales;
end;

procedure TMntCopForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( CodigoPostalFields.CodigoPais.Value, CodigoPostalFields.CodigoProvincia.Value, Sender, qgsLinked );
end;

procedure TMntCopForm.CodigoPaisTextEditPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntPaises( [ Sender.EditingValue ] );
end;

procedure TMntCopForm.CodigoPaisTextEditPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TMntCopForm.CodigoPaisTextEditPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
     If  not Error
     then CodigoPostal.SetupCPControl( DisplayValue, [ CodigoProvinciaCtrl ], [ CodigoCtrl ] );
end;

procedure TMntCopForm.CodigoProvinciaTextEditPropertiesEditRequest( Sender: TcxCustomEdit );
begin
     MntProvincias( [ CodigoPaisCtrl.EditValue, CodigoProvinciaCtrl.EditValue ] );
end;

procedure TMntCopForm.CodigoProvinciaTextEditPropertiesQueryRequest( Sender: TcxCustomEdit );
begin
     ConsultaProvincias( CodigoPaisCtrl.EditValue, Sender );
end;

procedure TMntCopForm.CodigoProvinciaTextEditPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean );
begin
     Provincia.Valida( CodigoPaisCtrl.EditValue, CodigoProvinciaCtrl, DisplayValue, ErrorText, Error );
end;

end.
