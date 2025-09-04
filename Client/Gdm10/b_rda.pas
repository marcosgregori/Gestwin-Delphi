
unit b_rda;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask,

  AppContainer,
  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset, DataManager,
  nxdb,

  Gim10Fields, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox;

type
  TBoxRdaForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    buttonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    PrimerNumeroAsientoCtrl: TcxDBTextEdit;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataPrimerNumeroAsiento: TSmallintField;
    DataSource: TDataSource;
    Label2: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;

  private

  public

    procedure ExecuteProcess;
  end;

var BoxRdaForm: TBoxRdaForm = nil;

procedure RenumeraAsientos;

implementation

{$R *.dfm}

uses   DateUtils,
       AppManager,

       Gdm10Frm,

       dm_rda,

       b_pro;

procedure RenumeraAsientos;
begin
     CreateEditForm( TBoxRdaForm, BoxRdaForm, TGds10Frm.ContableSection, True );
end;

procedure TBoxRdaForm.FormManagerInitializeForm;
begin
     CloseWindowWhenFocusLost := True;
     DataPrimerNumeroAsiento.Value := 2;
end;

procedure TBoxRdaForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxRdaForm.ExecuteProcess;
begin
     RenumeracionAsientos.EjecutaProceso( DataPrimerNumeroAsiento.Value );
end;


end.
