
unit b_rtp;

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

    TBoxRtpForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    Label1: TcxLabel;
    FechaInicialCtrl: TcxDBDateEdit;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataFechaInicial: TDateField;
    cxGroupBox2: TcxGroupBox;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    private

      procedure ExecuteProcess;

    public

    end;

var BoxRtpForm: TBoxRtpForm = nil;

procedure ReajusteTareasPendientes;

implementation

uses   DateUtils,
       AppManager,

       Gdm70Frm,

       dm_odf,

       b_pro;

{$R *.DFM}

procedure ReajusteTareasPendientes;
begin
     CreateEditForm( TBoxRtpForm, BoxRtpForm, TGds70Frm.ProduccionSection, True );
end;

procedure TBoxRtpForm.FormManagerInitializeForm;
begin
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
end;

procedure TBoxRtpForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxRtpForm.ExecuteProcess;

begin
     OrdenFabricacion.ReajustaTareas( DataFechaInicial.Value );
end;

end.
