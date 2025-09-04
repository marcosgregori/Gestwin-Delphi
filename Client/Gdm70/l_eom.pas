unit l_eom;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxGraphics, cxLookAndFeels, dxSkinsCore, cxLabel, cxGroupBox,
  dxSkinsDefaultPainters, cxSpinEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar;


type
    TRptEomForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    MaquinaInicialCtrl: TcxDBTextEdit;
    MaquinaFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataMaquinaInicial: TWideStringField;
    DataMaquinaFinal: TWideStringField;
    DataSource: TDataSource;
    gxRangeBox1: TgxRangeBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataTurnoInicial: TSmallintField;
    DataTurnoFinal: TSmallintField;
    gxRangeBox2: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    Label6: TcxLabel;
    gxRangeBox3: TgxRangeBox;
    TurnoInicialCtrl: TcxDBSpinEdit;
    TurnoFinalCtrl: TcxDBSpinEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure TurnoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TurnoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ReportSetReportName;
    private
      class var Impreso : Boolean;
    public

    end;

var RptEomForm: TRptEomForm = nil;

procedure ListadoEntradaOrdenesEnMaquinas( Impreso : Boolean = False );

implementation

uses   dm_maq,
       dm_tur,

       cx_tur,
       cx_maq;

{$R *.DFM}

resourceString
       RsMsg1 = 'Impresión de partes de fabricación';

procedure ListadoEntradaOrdenesEnMaquinas( Impreso : Boolean = False );
begin
     TRptEomForm.Impreso := Impreso;
     CreateReportForm( TRptEomForm, RptEomForm );
end;

procedure TRptEomForm.InitializeForm;
begin

     If   Impreso
     then Caption := RsMsg1;

     DataMaquinaInicial.Value := '';
     DataMaquinaFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataTurnoInicial.Value := 1;
     DataTurnoFinal.Value := 99;
end;

procedure TRptEomForm.ReportSetReportName;
begin
     If   Impreso
     then Report.FileName := 'dm70\i_eom'
     else Report.FileName := 'dm70\l_eom';
end;

procedure TRptEomForm.TurnoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTurnos( Sender );
end;

procedure TRptEomForm.TurnoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Turno.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptEomForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Maquina.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptEomForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TRptEomForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMaquinas( Sender );
end;

end.
