
unit b_afr;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask,
  Controls, Classes, ExtCtrls,

  AppContainer,
  tabs,
  Grids, checklst, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  DataManager, cxGraphics, cxLookAndFeels, cxControls, cxContainer, cxEdit,
  dxSkinsCore, cxLabel, cxGroupBox, dxSkinsDefaultPainters;

type
  TMntAfrForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    Label3: TcxLabel;
    cxGroupBox2: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    procedure FormManagerOkButton;
  private
  public

  end;

var MntAfrForm : TMntAfrForm =nil;

procedure ActualizacionFicherosRemotos;

implementation

{$R *.DFM}

uses   Files,
       nxllUtils,
       nxsdConst,
       sysUtils,
       DataAccess,

       Gdm00Dm,
       Gdm00Frm,

       dm_emp,

       b_msg,
       b_pro;

procedure ActualizacionFicherosRemotos;
begin
     DataModule00.SetupAppParams;
     CreateEditForm( TMntAfrForm, MntAfrForm, nil, True );
end;

procedure TMntAfrForm.FormManagerOkButton;
begin
     Empresa.ActualizaFicherosRemotos;
end;

end.

