unit l_cco;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox;


type
    TrptCCoForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
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

var RptCcoForm: TrptCCoForm = nil;

procedure ListadoCentrosCoste;


implementation

uses   dm_cco,
       cx_cco;

{$R *.DFM}

procedure ListadoCentrosCoste;
begin
     CreateReportForm( TrptCcoForm, RptCcoForm );
end;

procedure TrptCCoForm.initializeForm;
begin
     DataCodigoInicial.Value := '';
     DataCodigoFinal.Value := HighStrCode;
end;

procedure TrptCCoForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TrptCCoForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TrptCCoForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

end.
