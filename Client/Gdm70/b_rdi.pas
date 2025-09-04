
unit b_rdi;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  LibUtils,
  AppContainer,
  Mask,
  Menus,
  cxLookAndFeelPainters,
  cxButtons,
  DB,
  nxdb,
  DataManager, cxCheckBox, cxDBEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, dxmdaset,

  dm_sal, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox;


type

    TBoxRdiForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    private

      procedure ExecuteProcess;

    public

    end;

var BoxRdiForm: TBoxRdiForm = nil;

procedure ReconstruccionDatosProduccion;

implementation

uses   DateUtils,
       AppManager,

       Gdm70Frm,

       dm_rdip,

       b_pro;

{$R *.DFM}

procedure ReconstruccionDatosProduccion;
begin
     CreateEditForm( TBoxRdiForm, BoxRdiForm, TGds70Frm.ProduccionSection, True );
end;

procedure TBoxRdiForm.FormManagerInitializeForm;
begin
     //..
end;

procedure TBoxRdiForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxRdiForm.ExecuteProcess;

begin
     ReconstruccionDatosInternos.Reconstruccion;
end;

end.
