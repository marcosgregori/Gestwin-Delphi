unit a_gdc;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,
  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox, dxUIAClasses;

type
  TMntGdcForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    GrupoClienteTable: TnxeTable;
    DataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    CapTarifaLabel: TcxLabel;
    CodigoTarifaCtrl: TcxDBTextEdit;
    DescTarifaLabel: TcxLabel;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure Factura_TarifaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Factura_TarifaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Factura_TarifaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerInitializeForm;
  private

  public

  end;

var  MntGdcForm: TMntGdcForm = nil;

procedure MntGruposCliente( KeyValues : array of const );

implementation

{$R *.dfm}

uses   EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dm_gdc,
       dm_cdt,

       a_cdt,

       cx_gdc,
       cx_cdt,

       l_gdc;

procedure MntGruposCliente( KeyValues : array of const );
begin
     CreateEditForm( TMntGdcForm, MntGdcForm, KeyValues, TGds30Frm.VentasSection );
end;

procedure TMntGdcForm.FormManagerReportRequest;
begin
     ListadoGruposClientes;
end;

procedure TMntGdcForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender, qgsLinked );
end;

procedure TMntGdcForm.Factura_TarifaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosTarifa( [ Sender.EditingValue ] );
end;

procedure TMntGdcForm.Factura_TarifaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosTarifa( Sender );
end;

procedure TMntGdcForm.Factura_TarifaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoTarifa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

function TMntGdcForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.AcVEFicheros.Value;
end;

procedure TMntGdcForm.FormManagerInitializeForm;
begin
     CodigoTarifaCtrl.Enabled := DataModule00.DmEmpresaFields.Cliente_TarCodigo.Value;
end;

end.


