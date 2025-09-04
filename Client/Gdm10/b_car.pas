unit b_car;

interface

uses
  Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  mask, Menus, cxLookAndFeelPainters, cxButtons, cxSpinEdit, cxDBEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, DB, dxmdaset, DataManager, nxdb,

  Gim10Fields, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox;


type
    TBoxCarForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    FechaCtrl: TcxDBDateEdit;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    MesesAntiguedadCtrl: TcxDBSpinEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataFecha: TDateField;
    DataMesesAntiguedad: TSmallintField;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label5: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxGroupBox2: TcxGroupBox;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    procedure ExecuteProcess;

    public

    end;

var  BoxCarForm: TBoxCarForm;

procedure CancelacionAutomaticaRemesas;


implementation

uses   SysUtils,
       DateUtils,
       EnterpriseDataAccess,
       AppManager,

       Gim00Fields,
       Gdm10Frm,

       dm_ban,
       dm_rem,

       b_msg,
       b_pro,

       dm_ast,
       f_prg;

{$R *.DFM}


procedure CancelacionAutomaticaRemesas;
begin
     CreateEditForm( TBoxCarForm, BoxCarForm, TGds10Frm.CobrosPagosSection, True );
end;

procedure TBoxCarForm.initializeForm;
begin
     DataFecha.Value := ApplicationContainer.TodayDate;
     DataMesesAntiguedad.Value := 6;
end;

procedure TBoxCarForm.FechaCtrlPropertiesValidate( Sender : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean );
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TBoxCarForm.FormManagerOkButton;
begin
     Enabled := False;
     CreateProcessForm( ExecuteProcess, Caption );
end;


procedure TBoxCarForm.ExecuteProcess;
begin
     Remesa.CancelacionAutomatica( DataFecha.Value, DataMesesAntiguedad.Value );
end;

end.
