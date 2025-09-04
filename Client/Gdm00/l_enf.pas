unit l_enf;

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
    TRptEnfForm = class(TgxForm)
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
  RptEnfForm : TRptEnfForm;

procedure ListadoEntidadesFinancieras;


implementation

uses   cx_enf,

       dm_enf;

{$R *.DFM}

procedure ListadoEntidadesFinancieras;
begin
     CreateReportForm( TRptEnfForm, RptEnfForm );
end;

procedure TRptEnfForm.initializeForm;
begin
     DataCodigoInicial.Value := '';
     DataCodigoFinal.Value := HighStrCode;
end;

procedure TRptEnfForm.CodigoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     EntidadFinanciera.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptEnfForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEntidadesFinancieras( Sender );
end;

procedure TRptEnfForm.FormManagerOkButton;
begin
     Report.Launch;
end;

end.
