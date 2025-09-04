
unit b_vec;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask, 

  AppContainer,
  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,

  Gim10Fields, cxGraphics, cxLookAndFeels, cxControls, cxContainer, cxEdit,
  dxSkinsCore, dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxCheckBox,
  cxDBEdit, dxmdaset;

type
  TBoxVecForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    buttonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    RevisarEstadoTablasCtrl: TcxDBCheckBox;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataRevisarRegistrosFacturacion: TBooleanField;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
  private
    procedure ExecuteProcess;
  public
  end;

var BoxVecForm: TBoxVecForm;

procedure VerificaContabilidad;

implementation

{$R *.DFM}

uses   Gdm10Frm,

       dm_vec,

       b_pro;

procedure VerificaContabilidad;
begin
     CreateEditForm( TBoxVecForm, BoxVecForm, TGds10Frm.ContableSection, True );
end;

procedure TBoxVecForm.FormManagerInitializeForm;
begin
     CloseWindowWhenFocusLost := True;
     DataRevisarRegistrosFacturacion.Value := False;
end;

procedure TBoxVecForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxVecForm.ExecuteProcess;
begin
     VerificacionContabilidad.Verificacion( DataRevisarRegistrosFacturacion.Value );
end;

end.
