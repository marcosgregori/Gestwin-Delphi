unit l_tvp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxMaskEdit, cxSpinEdit, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox;


type
    TRptTvpForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBSpinEdit;
    CodigoFinalCtrl: TcxDBSpinEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    gxRangeBox1: TgxRangeBox;
    DataCodigoInicial: TSmallintField;
    DataCodigoFinal: TSmallintField;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    private

    public

    end;

var RptTvpForm: TRptTvpForm = nil;

procedure ListadoTiposVentaPeriodica;


implementation

uses   dm_tvp,

       cx_tvp;

{$R *.DFM}

procedure ListadoTiposVentaPeriodica;
begin
     CreateReportForm( TRptTvpForm, RptTvpForm );
end;

procedure TRptTvpForm.initializeForm;
begin
     DataCodigoInicial.Value := 1;
     DataCodigoFinal.Value := 99;
end;

procedure TRptTvpForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     TipoVentaPeriodica.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptTvpForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TRptTvpForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposVentasPeriodicas( Sender );
end;

end.
