unit l_inc;

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
    TRptIncForm = class(TgxForm)
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
    DataCodigoInicial: TSmallintField;
    DataCodigoFinal: TSmallintField;
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

var RptIncForm: TRptIncForm = nil;

procedure ListadoIncidencias;


implementation

uses   dm_inc,
       dm_cls,

       cx_inc;

{$R *.DFM}

procedure ListadoIncidencias;
begin
     CreateReportForm( TRptIncForm, RptIncForm );
end;

procedure TRptIncForm.initializeForm;
begin
     DataCodigoInicial.Value := 1;
     DataCodigoFinal.Value := 99;
end;

procedure TRptIncForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Incidencia.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptIncForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         SetValueFields( Data );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptIncForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaIncidencias( Sender );
end;

end.
