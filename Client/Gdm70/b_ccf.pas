
unit b_ccf;

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

  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox;


type

    TBoxCcfForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Data: TgxMemData;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataAltasPorFabricacion: TBooleanField;
    DataSource: TDataSource;
    gxRangeBox2: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    AltasPorFabricacionCtrl: TcxDBCheckBox;
    Label1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataAlbaranesDeSalida: TBooleanField;
    AlbaranesDeSalidaCtrl: TcxDBCheckBox;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

      procedure ExecuteProcess;

    public

    end;

var BoxCcfForm: TBoxCcfForm = nil;

procedure ProcesaCierreCicloFabricacion;

implementation

uses   DateUtils,
       AppManager,

       EnterpriseDataAccess,

       Gdm70Frm,

       dm_ccf,

       b_pro;

{$R *.DFM}

procedure ProcesaCierreCicloFabricacion;
begin
     CreateEditForm( TBoxCcfForm, BoxCcfForm, TGds70Frm.ProduccionSection, True );
end;

procedure TBoxCcfForm.FechaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error, Sender=FechaInicialCtrl );
end;

procedure TBoxCcfForm.FormManagerInitializeForm;
begin
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataAltasPorFabricacion.Value := True;
     DataAlbaranesDeSalida.Value := True;
end;

procedure TBoxCcfForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxCcfForm.ExecuteProcess;
begin
     CierreCicloFabricacion.Realizar( DataFechaInicial.Value, DataFechaFinal.Value, DataAltasPorFabricacion.Value, DataAlbaranesDeSalida.Value );
end;

end.
