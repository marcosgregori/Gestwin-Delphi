unit l_pai;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,

  ReportManager,
  Menus,
  cxLookAndFeelPainters,
  cxButtons,
  DB,
  dxmdaset,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxLabel,
  cxGroupBox;


type
    TrptPaiForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    gxRangeBox1: TgxRangeBox;
    Label1: TcxLabel;
    Label4: TcxLabel;
    Label3: TcxLabel;
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

var
  rptPaiForm : TrptPaiForm;

procedure ListadoPaises;


implementation

uses   cx_pai,

       dm_pai;

{$R *.DFM}

procedure ListadoPaises;
begin
     CreateReportForm( TRptPaiForm, RptPaiForm );
end;

procedure TrptPaiForm.initializeForm;
begin
     DataCodigoInicial.Value := '';
     DataCodigoFinal.Value   := HighStrCode;
end;

procedure TrptPaiForm.CodigoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TrptPaiForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TrptPaiForm.FormManagerOkButton;
begin
     Report.Launch;
end;

end.
