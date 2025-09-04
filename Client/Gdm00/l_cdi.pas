unit l_cdi;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxLabel,
  cxGroupBox;


type
    TrptCdiForm = class(TgxForm)
    ButtonsPanel: TgxEditPanel;
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Report: TgxReportManager;
    MemData: TgxMemData;
    MemDataCodigoInicial: TWideStringField;
    MemDataCodigoFinal: TWideStringField;
    DataSource: TDataSource;
    gxRangeBox1: TgxRangeBox;
    Label1: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure MemDataAfterInsert(DataSet: TDataSet);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure FormManagerOkButton;
    private

    public

    end;

var
  rptCdiForm: TrptCdiForm = nil;

procedure ListadoCodigosDivisa;


implementation

uses   Gdm00Dm,

       dm_cdi,

       cx_cdi;

{$R *.DFM}

procedure ListadoCodigosDivisa;
begin
     CreateReportForm( TrptCdiForm, RptCdiForm );
end;

procedure TrptCdiForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TrptCdiForm.MemDataAfterInsert(DataSet: TDataSet);
begin
     MemDataCodigoFinal.Value := HighStrCode;
end;

procedure TrptCdiForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosDivisa( Sender );
end;

procedure TrptCdiForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Divisa.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

end.
