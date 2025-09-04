unit l_fpa;

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
    TRptFpaForm = class(TgxForm)
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
  RptFpaForm: TRptFpaForm;

procedure ListadoFormasPago;


implementation

uses   EnterpriseDataAccess,

       dm_fpa,

       cx_fpa;

{$R *.DFM}

procedure ListadoFormasPago;
begin
     CreateReportForm( TrptFpaForm, RptFpaForm );
end;

procedure TRptFpaForm.initializeForm;
begin
     DataCodigoInicial.Value := '';
     DataCodigoFinal.Value := highStrCode;
end;

procedure TRptFpaForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptFpaForm.CodigoValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaPago.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptFpaForm.CodigoQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasPago( Sender );
end;

end.
