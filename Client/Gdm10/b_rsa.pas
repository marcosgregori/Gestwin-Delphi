
unit b_rsa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, 


  Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxCheckBox, cxDBEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxSpinEdit,

  AppContainer,
  AppForms, dxSkinsCore, cxGraphics, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, dxUIAClasses;

type
  TBoxRsaForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    buttonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    ComprobarSaldosCtrl: TcxDBCheckBox;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataComprobarCuadre: TBooleanField;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxDBCheckBox1: TcxDBCheckBox;
    DataLimpiarSaldosApertura: TBooleanField;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;

  private
    procedure ExecuteProcess;

  public

  end;

var BoxRsaForm : TBoxRsaForm = nil;

procedure ReconstruccionSaldos;

implementation

{$R *.DFM}

uses   Gdm10Frm,

       dm_sal,

       b_msg,
       b_pro;

procedure ReconstruccionSaldos;
begin
     CreateEditForm( TBoxRsaForm, BoxRsaForm, TGds10Frm.ContableSection, True );
end;

procedure TBoxRsaForm.FormManagerInitializeForm;
begin
     DataComprobarCuadre.Value := False;
     DataLimpiarSaldosApertura.Value := Saldos.MesAsientoApertura( ApplicationContainer.Ejercicio )<>0;
end;

procedure TBoxRsaForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxRsaForm.ExecuteProcess;
begin
     Saldos.ReconstruyeSaldos( ApplicationContainer.Ejercicio, ApplicationContainer.Ejercicio, DataComprobarCuadre.Value, DataLimpiarSaldosApertura.Value );
end;

end.
