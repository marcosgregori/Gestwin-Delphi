unit l_tca;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, cxDBEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, DB, dxmdaset, DataManager, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, cxLabel, cxGroupBox,

  Gim00Fields;


type
    TrptTcaForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    CodigoDivisaCtrl: TcxDBTextEdit;
    MemData: TgxMemData;
    MemDataCodigoDivisa: TWideStringField;
    DataSource: TDataSource;
    MemDataFechaInicial: TDateField;
    MemDataFechaFinal: TDateField;
    gxRangeBox1: TgxRangeBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure CodigoDivisaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoDivisaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure MemDataAfterInsert(DataSet: TDataSet);
    procedure FormManagerOkButton;
    procedure ReportBeforeStart;
    procedure FormManagerInitializeForm;
    private

      DsDivisaFields : TDivisaFields;

    public

    end;

var
  rptTcaForm: TrptTcaForm = nil;

procedure listadoTiposCambio;


implementation

uses   LibUtils,

       Gdm00Dm,

       dm_cdi,

       cx_cdi;

{$R *.DFM}

procedure listadoTiposCambio;
begin
     CreateReportForm( TrptTcaForm, rptTcaForm );
end;

procedure TrptTcaForm.FormManagerInitializeForm;
begin
     DsDivisaFields := TDivisaFields.Create( Self );
end;

procedure TrptTcaForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TrptTcaForm.MemDataAfterInsert(DataSet: TDataSet);
begin
     MemDataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     MemDataFechaFinal.Value := ApplicationContainer.TodayDate;
end;

procedure TrptTcaForm.ReportBeforeStart;
begin
     Report.SetMemoFormat( 'TipoCambio', '%2.' + IntToStr( LibUtils.Decimales( DsDivisaFields.PrecisionRedondeo.Value ) ) + 'n' );
end;

procedure TrptTcaForm.CodigoDivisaCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaCodigosDivisa( Sender );
end;

procedure TrptTcaForm.CodigoDivisaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Divisa.Valida( Sender, DisplayValue, ErrorText, Error, DsDivisaFields );
end;

end.
