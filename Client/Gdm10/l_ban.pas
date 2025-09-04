unit l_ban;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset, DataManager,
  ReportManager, cxGraphics, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox;


type
    TRptBanForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    report: TgxReportManager;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataSource: TDataSource;
    gxRangeBox1: TgxRangeBox;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

    end;

var RptBanForm : TRptBanForm = nil;

procedure ListadoBancos;


implementation

uses   EnterpriseDataAccess,

       dm_ban,

       cx_ban;

{$R *.DFM}

procedure ListadoBancos;
begin
     CreateReportForm( TrptBanForm, RptBanForm );
end;

procedure TRptBanForm.initializeForm;
begin
     DataCodigoInicial.Value := '572000000';
     DataCodigoFinal.Value   := '572999999';
end;

procedure TRptBanForm.CodigoValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Banco.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptBanForm.CodigoQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaBancos( Sender );
end;

procedure TRptBanForm.FormManagerOkButton;
begin
     Report.Launch;
end;

end.
