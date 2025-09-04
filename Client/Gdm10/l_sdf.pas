unit l_sdf;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  dxSkinsCore, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox,
  dxSkinsDefaultPainters;


type
    TRptSdfForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataCodigoInicial: TStringField;
    DataCodigoFinal: TStringField;
    DataSource: TDataSource;
    gxRangeBox1: TgxRangeBox;
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

var RptSdfForm: TRptSdfForm = nil;

procedure ListadoSeriesFacturacion;


implementation

uses   dm_sdf,
       cx_sdf;

{$R *.DFM}

procedure ListadoSeriesFacturacion;
begin
     CreateReportForm( TrptSdfForm, RptSdfForm );
end;

procedure TRptSdfForm.InitializeForm;
begin
     If   ApplicationContainer.IsModuleActive( [ 30 ] )
     then Report.FileName := 'dm30\l_sdf';
     DataCodigoInicial.Value := '';
     DataCodigoFinal.Value := HighStrCode;
end;

procedure TRptSdfForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptSdfForm.FormManagerOkButton;
begin
     Enabled := False;
     With Report do
       try
         Load;
         SetValueFields( Data );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptSdfForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

end.
