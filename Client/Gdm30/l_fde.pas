unit l_fde;

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
    TRptFdeForm = class(TgxForm)
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

var RptFdeForm: TRptFdeForm = nil;

procedure ListadoFormasEnvio;


implementation

uses   dm_fde,
       cx_fde;

{$R *.DFM}

procedure ListadoFormasEnvio;
begin
     CreateReportForm( TrptFdeForm, RptFdeForm );
end;

procedure TRptFdeForm.InitializeForm;
begin
     DataCodigoFinal.Value := HighStrCode;
end;

procedure TRptFdeForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaEnvio.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptFdeForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         SetValueFields( Data );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptFdeForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasEnvio( Sender );
end;

end.
