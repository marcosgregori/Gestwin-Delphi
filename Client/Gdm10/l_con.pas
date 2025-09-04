unit l_con;

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
    TrptConForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBSpinEdit;
    CodigoFinalCtrl: TcxDBSpinEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoInicial: TSmallintField;
    DataCodigoFinal: TSmallintField;
    gxRangeBox1: TgxRangeBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    private

    public

    end;

var RptConForm: TrptConForm = nil;

procedure ListadoConceptosApunte;


implementation

uses   dm_con,
       cx_con;

{$R *.DFM}

procedure ListadoConceptosApunte;
begin
     CreateReportForm( TrptConForm, RptConForm );
end;

procedure TrptConForm.initializeForm;
begin
     DataCodigoInicial.Value := 1;
     DataCodigoFinal.Value := 99;
end;

procedure TrptConForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaConceptosApunte( Sender );
end;

procedure TrptConForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TrptConForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     ConceptoApunte.Valida( Sender, DisplayValue, ErrorText, Error, True ); 
end;

end.
