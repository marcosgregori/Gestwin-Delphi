
unit a_rcc;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox, dxUIAClasses;

type
  TMntRccForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    CuentaComprasCtrl: TcxDBTextEdit;
    CuentaDevolucionesCtrl: TcxDBTextEdit;
    CuentaDescuentoCtrl: TcxDBTextEdit;
    CuentaRecargoCtrl: TcxDBTextEdit;
    CuentaPortesCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCuentaCompras: TWideStringField;
    DataCuentaDevoluciones: TWideStringField;
    DataCuentaDescuento: TWideStringField;
    DataCuentaRecargo: TWideStringField;
    DataCuentaPortes: TWideStringField;
    Label4: TcxLabel;
    Label10: TcxLabel;
    Label2: TcxLabel;
    Label11: TcxLabel;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    function FormManagerGetAccessLevel: Smallint;
    procedure CuentaComprasCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure CuentaDevolucionesCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure CuentaDescuentoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure CuentaRecargoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure CuentaPortesCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure CuentaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CuentaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
  private

  public

  end;

var  MntRccForm: TMntRccForm = nil;

procedure MntRelacionesCompras;

implementation

{$R *.DFM}

uses   SysUtils,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dmi_iva,

       dm_sub,
       dm_iva,

       a_sub,

       cx_sub;

resourceString
       rsMsg1  = '';

procedure MntRelacionesCompras;
begin
     CreateEditForm( TMntRccForm, MntRccForm, [], TGds30Frm.ComprasSection );
end;

procedure TMntRccForm.FormManagerInitializeForm;
begin
     With Tasa do
       begin
       DataCuentaCompras.Value := ObtenRelacion( srCompras );
       DataCuentaDevoluciones.Value := ObtenRelacion( srDevolucionesCompras );
       DataCuentaDescuento.Value := ObtenRelacion( srDescuentoPP );
       DataCuentaRecargo.Value := ObtenRelacion( srRecargofinancieroCompras );
       DataCuentaPortes.Value := ObtenRelacion( srPortesCompras );
       end;
end;

procedure TMntRccForm.CuentaComprasCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     Sender.SetEditValueIfEmpty( '600' );
end;

procedure TMntRccForm.CuentaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntRccForm.CuentaDescuentoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     Sender.SetEditValueIfEmpty( '606' );
end;

procedure TMntRccForm.CuentaDevolucionesCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     Sender.SetEditValueIfEmpty( '608' );
end;

procedure TMntRccForm.CuentaCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender );
end;

procedure TMntRccForm.CuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntRccForm.CuentaPortesCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     Sender.SetEditValueIfEmpty( '624' );
end;

procedure TMntRccForm.CuentaRecargoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     Sender.SetEditValueIfEmpty( '6624' );
end;

procedure TMntRccForm.FormManagerOkButton;
begin
     With Tasa do
       begin
       GuardaRelacion( srCompras, DataCuentaCompras.Value );
       GuardaRelacion( srDevolucionesCompras, DataCuentaDevoluciones.Value );
       GuardaRelacion( srDescuentoPP, DataCuentaDescuento.Value );
       GuardaRelacion( srRecargofinancieroCompras, DataCuentaRecargo.Value );
       GuardaRelacion( srPortesCompras, DataCuentaPortes.Value );
       end;
end;

function TMntRccForm.FormManagerGetAccessLevel: Smallint;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ acCOFicheros.Value, acCORelaciones.Value ] );
end;

end.


