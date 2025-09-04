unit l_cop;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,

  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset,
  DataManager, cxGraphics, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox;


type
    TrptCopForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataSource: TDataSource;
    CodigoPaisCtrl: TcxDBTextEdit;
    DataCodigoPais: TWideStringField;
    gxRangeBox1: TgxRangeBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPaisCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoFinalCtrlRequestQuery(Sender: TObject);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    private

    public

    end;

var
  rptCopForm : TrptCopForm;

procedure ListadoCodigosPostales;


implementation

uses   cx_pai,
       cx_prv,

       dm_pai,
       dm_prv;

{$R *.DFM}

procedure ListadoCodigosPostales;
begin
     CreateReportForm( TRptCopForm, RptCopForm );
end;

procedure TrptCopForm.initializeForm;
begin
     DataCodigoPais.Value    := CodigoEspaña;
     DataCodigoInicial.Value := '';
     DataCodigoFinal.Value   := HighStrCode;
end;

procedure TrptCopForm.CodigoFinalCtrlRequestQuery(Sender: TObject);
begin
     ConsultaProvincias( DataCodigoPais.Value, CodigoFinalCtrl );
end;

procedure TrptCopForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( CodigoPaisCtrl.EditValue, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TrptCopForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( DataCodigoPais.Value, Sender );
end;

procedure TrptCopForm.CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( CodigoPaisCtrl );
end;

procedure TrptCopForm.CodigoPaisCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TrptCopForm.FormManagerOkButton;
begin
     Report.Launch;
end;

end.

