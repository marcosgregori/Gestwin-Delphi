unit l_emp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ReportManager,
  DB,
  dxmdaset,
  cxControls,
  cxContainer,
  cxEdit,
  cxTextEdit,
  cxDBEdit, DataManager, Menus, cxLookAndFeelPainters,
  cxButtons, cxGraphics, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox;


type
    TrptEmpForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataSource1: TDataSource;
    gxRangeBox1: TgxRangeBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure DataNewRecord(DataSet: TDataSet);
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerOkButton;
    private

    public

    end;

var
  rptEmpForm : TrptEmpForm;

procedure ListadoEmpresas;


implementation

uses   nxdb,

       gdm00Dm,

       dm_emp,

       cx_emp;

{$R *.DFM}

procedure ListadoEmpresas;
begin
     CreateReportForm( TrptEmpForm, rptEmpForm );
end;

procedure TrptEmpForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEmpresas( Sender );
end;

procedure TrptEmpForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Empresa.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TrptEmpForm.DataNewRecord(DataSet: TDataSet);
begin
     DataCodigoInicial.Value := ZeroStrCode;
     DataCodigoFinal.Value := HighStrCode;
end;

procedure TrptEmpForm.FormManagerOkButton;
begin
     Report.Launch;
end;

end.
