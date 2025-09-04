
unit b_ric;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask,


  Menus, cxLookAndFeelPainters, cxButtons, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxGroupBox,
  cxRadioGroup, DB, dxmdaset, nxdb, dxSkinsCore, cxGraphics, cxLookAndFeels,
  cxLabel, dxSkinsDefaultPainters,

  AppContainer,
  DataManager,

  Gim10Fields;

type
  TBoxRicForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    ButtonsPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    FechaCtrl: TcxDBDateEdit;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataFecha: TDateField;
    InformacionGroupBox: TcxGroupBox;
    RegularizacionCriterioCajaLabel: TcxLabel;
    Label2: TcxLabel;
    cxGroupBox3: TcxGroupBox;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;

  private

  public
    procedure ExecuteProcess;
  end;

var
  BoxRicForm: TBoxRicForm = nil;

procedure RegularizacionIVACC;

implementation

{$R *.dfm}

uses   AppManager,

       Gdm10Frm,

       b_msg,
       b_pro,

       dm_ric,

       f_prg;

procedure RegularizacionIVACC;
begin
     CreateEditForm( TBoxRicForm, BoxRicForm, TGds10Frm.LibrosIVASection, True );
end;

procedure TBoxRicForm.FormManagerInitializeForm;
begin
     DataFecha.Value := ApplicationContainer.LastDayOfYearDate;
end;

procedure TBoxRicForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxRicForm.ExecuteProcess;
begin
     RegularizacionIVA.EjecutaProceso( DataFecha.Value );
end;

end.
