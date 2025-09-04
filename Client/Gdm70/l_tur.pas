unit l_tur;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox, cxMaskEdit, cxSpinEdit;


type
    TRptTurForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBSpinEdit;
    CodigoFinalCtrl: TcxDBSpinEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    gxRangeBox1: TgxRangeBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataNroTurnoInicial: TSmallintField;
    DataNroTurnoFinal: TSmallintField;
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

var RptTurForm: TRptTurForm = nil;

procedure ListadoTurnos;


implementation

uses   dm_tur,
       cx_tur;

{$R *.DFM}

procedure ListadoTurnos;
begin
     CreateReportForm( TRptTurForm, RptTurForm );
end;

procedure TRptTurForm.initializeForm;
begin
     DataNroTurnoInicial.Value := 1;
     DataNroTurnoFinal.Value := 99;
end;

procedure TRptTurForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Turno.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptTurForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         SetValueFields( Data );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptTurForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTurnos( Sender );
end;

end.
