unit l_rvf;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxLabel,
  cxGroupBox;


type
    TRptRvfForm = class(TgxForm)
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

var RptRvfForm: TRptRvfForm = nil;

procedure ListadoRelacionesFamiliasVentas;


implementation

uses   dm_fam,
       cx_fam;

{$R *.DFM}

procedure ListadoRelacionesFamiliasVentas;
begin
     CreateReportForm( TRptRvfForm, RptRvfForm );
end;

procedure TRptRvfForm.initializeForm;
begin
     DataCodigoInicial.Value := '';
     DataCodigoFinal.Value := HighStrCode;
end;

procedure TRptRvfForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Familia.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptRvfForm.FormManagerOkButton;
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

procedure TRptRvfForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

end.
