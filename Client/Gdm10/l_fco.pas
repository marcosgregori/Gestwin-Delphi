unit l_fco;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
  dxmdaset, DataManager, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, dxSkinsCore, cxGraphics, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox;


type
    TRptFcoForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataSource: TDataSource;
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
    procedure CodigoQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

    end;

var
  RptFcoForm: TRptFcoForm;

procedure ListadoFormasCobro;


implementation

uses   EnterpriseDataAccess,

       dm_fco,

       cx_fco;

{$R *.DFM}

procedure ListadoFormasCobro;
begin
     CreateReportForm( TRptFcoForm, RptFcoForm );
end;

procedure TRptFcoForm.InitializeForm;
begin
     DataCodigoInicial.Value := '';
     DataCodigoFinal.Value := HighStrCode;
end;

procedure TRptFcoForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptFcoForm.CodigoValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptFcoForm.CodigoQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

end.

