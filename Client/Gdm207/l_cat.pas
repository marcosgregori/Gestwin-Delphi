unit l_cat;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset,

  AppContainer,
  ReportManager,
  DataManager, cxMaskEdit, cxSpinEdit, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, cxLabel, cxGroupBox;

type
    TRptCatForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoInicial: TStringField;
    DataCodigoFinal: TStringField;
    gxRangeBox1: TgxRangeBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    procedure CodigoCtrlQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoCtrlValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    private

    public

    end;

var RptCatForm: TRptCatForm = nil;

procedure ListadoCategorias;


implementation

uses   dm_cat,
       cx_cat;

{$R *.DFM}

procedure ListadoCategorias;
begin
     CreateReportForm( TRptCatForm, RptCatForm );
end;

procedure TRptCatForm.initializeForm;
begin
     DataCodigoFinal.Value := HighStrCode;
end;

procedure TRptCatForm.CodigoCtrlQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCategorias( Sender );
end;

procedure TRptCatForm.FormManagerOkButton;
begin
     Enabled := False;
     With Report do
       try
         Load;
         Start;
       except on E : Exception do
         Cancel( E );
         end;
end;

procedure TRptCatForm.CodigoCtrlValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Categoria.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

end.
