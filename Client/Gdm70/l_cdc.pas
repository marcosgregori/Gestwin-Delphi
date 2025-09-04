unit l_cdc;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset,

  AppContainer,
  ReportManager,
  DataManager, cxMaskEdit, cxSpinEdit, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, cxLabel, cxGroupBox;

type
    TRptCdcForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBSpinEdit;
    CodigoFinalCtrl: TcxDBSpinEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoInicial: TSmallintField;
    DataCodigoFinal: TSmallintField;
    gxRangeBox1: TgxRangeBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    private

    public

    end;

var RptCdcForm: TRptCdcForm = nil;

procedure ListadoCodigosCoste;


implementation

uses   dm_cdc,

       cx_cdc;

{$R *.DFM}

procedure ListadoCodigosCoste;
begin
     CreateReportForm( TRptCdcForm, RptCdcForm );
end;

procedure TRptCdcForm.InitializeForm;
begin
     DataCodigoInicial.Value := 1;
     DataCodigoFinal.Value := 99;
end;

procedure TRptCdcForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosCoste( Sender );
end;

procedure TRptCdcForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         Start;
       except on E : exception do
         Cancel( E );
         end;
end;

procedure TRptCdcForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoCoste.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

end.
