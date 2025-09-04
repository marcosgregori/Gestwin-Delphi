unit b_gaa;

interface

uses
  Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  LibUtils,
  Mask,

  Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxDBEdit, nxdb,

  Gim10Fields,

  dm_sal, dxSkinsCore, cxGraphics, cxLookAndFeels, dxSkinsDefaultPainters,
  cxLabel, cxGroupBox, 
  
  AppContainer, dxUIAClasses;


type
    TboxGaaForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    FechaCtrl: TcxDBDateEdit;
    InmovilizadoTable: TnxeTable;
    LineaInmovilizadoTable: TnxeTable;
    AsientoTable: TnxeTable;
    ApunteTable: TnxeTable;
    SaldosTable: TnxeTable;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataFecha: TDateField;
    Label1: TcxLabel;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    private

    procedure ExecuteProcess;

    public

    end;

var BoxGaaForm: TBoxGaaForm = nil;

procedure GeneraAsientosAmortizacion;


implementation

uses   SysUtils,
       DateUtils,

       AppManager,

       Gdm10Frm,

       dm_gaa,

       b_pro;

{$R *.DFM}

procedure GeneraAsientosAmortizacion;
begin
     CreateEditForm( TBoxGaaForm, BoxGaaForm, TGds10Frm.InmovilizadoSection, True );
end;

procedure TBoxGaaForm.InitializeForm;
begin
     DataFecha.Value := ApplicationContainer.TodayDate;
end;

procedure TBoxGaaForm.FechaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TBoxGaaForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxGaaForm.ExecuteProcess;
begin
     GeneracionAmortizaciones.EjecutaProceso( DataFecha.Value );
end;

end.
