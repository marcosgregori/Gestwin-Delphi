
unit a_rvv;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox, dxUIAClasses;

type
  TMntRvvForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    CuentaVentasCtrl: TcxDBTextEdit;
    CuentaDevolucionesCtrl: TcxDBTextEdit;
    CuentaDescuentoCtrl: TcxDBTextEdit;
    CuentaRecargoCtrl: TcxDBTextEdit;
    CuentaPortesCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCuentaVentas: TWideStringField;
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
    procedure CuentaVentasCtrlPropertiesEnter(Sender: TcxCustomEdit);
  private

  public

  end;

var  MntRvvForm: TMntRvvForm = nil;

procedure MntRelacionesVentas;

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

procedure MntRelacionesVentas;
begin
     CreateEditForm( TMntRvvForm, MntRvvForm, [], TGds30Frm.VentasSection );
end;

procedure TMntRvvForm.FormManagerInitializeForm;
begin
     With Tasa do
       begin
       DataCuentaVentas.Value := ObtenRelacion( srVentas );
       DataCuentaDevoluciones.Value := ObtenRelacion( srDevolucionesVentas );
       DataCuentaDescuento.Value := ObtenRelacion( srDescuentoPC );
       DataCuentaRecargo.Value := ObtenRelacion( srRecargoFinancieroVentas );
       DataCuentaPortes.Value := ObtenRelacion( srPortesVentas );
       end;
end;

procedure TMntRvvForm.CuentaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntRvvForm.CuentaDescuentoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     Sender.SetEditValueIfEmpty( '706' );
end;

procedure TMntRvvForm.CuentaDevolucionesCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     Sender.SetEditValueIfEmpty( '708' );
end;

procedure TMntRvvForm.CuentaCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender );
end;

procedure TMntRvvForm.CuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntRvvForm.CuentaPortesCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     Sender.SetEditValueIfEmpty( '759' );
end;

procedure TMntRvvForm.CuentaRecargoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     Sender.SetEditValueIfEmpty( '76213' );
end;

procedure TMntRvvForm.CuentaVentasCtrlPropertiesEnter( Sender: TcxCustomEdit);
begin
     Sender.SetEditValueIfEmpty( '700' );
end;

procedure TMntRvvForm.FormManagerOkButton;
begin
     With Tasa do
       begin
       GuardaRelacion( srVentas, DataCuentaVentas.Value );
       GuardaRelacion( srDevolucionesVentas, DataCuentaDevoluciones.Value );
       GuardaRelacion( srDescuentoPC, DataCuentaDescuento.Value );
       GuardaRelacion( srRecargofinancieroVentas, DataCuentaRecargo.Value );
       GuardaRelacion( srPortesVentas, DataCuentaPortes.Value );
       end;
end;

function TMntRvvForm.FormManagerGetAccessLevel: Smallint;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ acCOFicheros.Value, acCORelaciones.Value ] );
end;

end.


