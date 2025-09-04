unit l_tdr;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Menus, cxLookAndFeelPainters, cxGraphics, ReportManager,
  cxDropDownEdit, cxDBEdit, cxIndexedComboBox, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxCalendar, cxButtons, DB, dxmdaset,
  DataManager, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox;


type
    TRptTdrForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    NroAplicacionCtrl: TcxDBIndexedComboBox;
    gxRangeBox2: TgxRangeBox;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataNroAplicacion: TSmallintField;
    Label2: TcxLabel;
    Label1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    private

    public
    end;

var RptTdrForm: TRptTdrForm;

procedure ListadoTarjetasRegistro;


implementation

uses   DateUtils,

       Gdm00Dm,
       Gdm90Dm;

{$R *.DFM}

procedure ListadoTarjetasRegistro;
begin
     CreateEditForm( TrptTdrForm, RptTdrForm );
end;

procedure TRptTdrForm.InitializeForm;
begin
     DataFechaInicial.Value := IncYear( ApplicationContainer.TodayDate, -5 );
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
end;

procedure TRptTdrForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         SetValueFields( Data );
         SetValue( 'TextoNroAplicacion', NroAplicacionCtrl.Text );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

end.
