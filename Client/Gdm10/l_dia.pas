
unit l_dia;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, Mask,ComCtrls,

  Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  cxSpinEdit, cxDBEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxControls, cxContainer, cxEdit, cxCheckBox,
  dxSkinsCore, cxGraphics, cxLookAndFeels, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox,

  AppContainer,
  AppForms,
  DataManager,
  ReportManager,

  Gim00Fields,
  Gim10Fields,

  dm_sal,

  dmi_sal;

type
    TrptDiaForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    RayadoModernoCtrl: TcxDBCheckBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    PrimeraPaginaCtrl: TcxDBSpinEdit;
    IncluirAnotacionesCtrl: TcxDBCheckBox;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataPrimeraPagina: TSmallintField;
    DataMostrarAnotaciones: TBooleanField;
    DataRayadoModerno: TBooleanField;
    gxRangeBox1: TgxRangeBox;
    Label4: TcxLabel;
    Label1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ReportSetReportName;
    procedure ReportBeforeStart;
    procedure RayadoModernoCtrlPropertiesChange(Sender: TObject);
    private
      SumasySaldos : ISumasySaldos;
    protected

    public

    end;

var rptDiaForm : TrptDiaForm = nil;

procedure DiarioContable;


implementation

uses   dm_pga,
       dm_ast,
       dm_tas,
       dm_sub,

       b_msg;

{$R *.DFM}

procedure DiarioContable;
begin
     CreateReportForm( TrptDiaForm, RptDiaForm );
end;

procedure TrptDiaForm.InitializeForm;
begin
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataPrimeraPagina.Value := 1;
end;

procedure TrptDiaForm.RayadoModernoCtrlPropertiesChange(Sender: TObject);
begin
     Report.UpdateReportName;
end;

procedure TrptDiaForm.ReportBeforeStart;
begin
     With Report do
       begin
       SetSQLExpression( SQLFormat( SQLSet.GetSQLText( 'Diario' ), [ DataFechaInicial, DataFechaFinal ] ) );
       SetValue( RsDebeInicial, SumasySaldos.DebeAcumulado  );
       SetValue( RsHaberInicial, SumasySaldos.HaberAcumulado );
       end;
end;

procedure TrptDiaForm.ReportSetReportName;
begin
     If   DataRayadoModerno.Value
     then Report.FileName := 'dm10\l_dia2'
     else Report.FileName := 'dm10\l_dia1';
end;

procedure TrptDiaForm.FormManagerOkButton;
begin
     If   Saldos.Sumas( DataFechaInicial.Value, SumasySaldos )
     then Report.Launch;
end;

end.
