unit l_tde;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxMaskEdit, cxSpinEdit, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox;


type
    TRptTdeForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBSpinEdit;
    CodigoFinalCtrl: TcxDBSpinEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    gxRangeBox1: TgxRangeBox;
    DataCodigoInicial: TSmallintField;
    DataCodigoFinal: TSmallintField;
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

var RptTdeForm: TRptTdeForm = nil;

procedure ListadoTiposEnvase;


implementation

uses   dm_tde,
       cx_tde;

{$R *.DFM}

procedure ListadoTiposEnvase;
begin
     CreateReportForm( TrptTdeForm, RptTdeForm );
end;

procedure TRptTdeForm.initializeForm;
begin
     DataCodigoInicial.Value := 1;
     DataCodigoFinal.Value := 99;
end;

procedure TRptTdeForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     TipoEnvase.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptTdeForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptTdeForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposEnvase( Sender );
end;

end.
