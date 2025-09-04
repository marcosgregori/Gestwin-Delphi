unit l_rdi;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, ReportManager, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, cxGraphics, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox;


type
    TRptRdiForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    report: TgxReportManager;
    gxRangeBox1: TgxRangeBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label2: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoDivisaQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoFinalCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

    end;

var RptRdiForm: TRptRdiForm;

procedure ListadoRelacionesDivisas;


implementation

uses   Gim00Fields,

       dm_cdi,

       cx_cdi;

{$R *.DFM}

procedure ListadoRelacionesDivisas;
begin
     CreateReportForm( TRptRdiForm, RptRdiForm );
end;

procedure TRptRdiForm.initializeForm;
begin
     DataCodigoFinal.Value := HighStrCode;
end;

procedure TRptRdiForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptRdiForm.CodigoFinalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Divisa.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptRdiForm.CodigoDivisaQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosDivisa( Sender );
end;

end.
