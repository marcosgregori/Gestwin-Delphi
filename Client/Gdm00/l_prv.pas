unit l_prv;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  ReportManager,
  cxLookAndFeelPainters,
  cxButtons,
  DB,
  dxmdaset,
  DataManager,
  cxControls,
  cxContainer,
  cxEdit,
  cxTextEdit,
  cxDBEdit,
  Menus, cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters,
  cxLabel, cxGroupBox;


type
    TrptPrvForm = class(TgxForm)
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
    Label4: TcxLabel;
    Label3: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption;var Error: Boolean);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    private

    public

    end;

var
  rptPrvForm : TrptPrvForm;

procedure listadoProvincias;


implementation

uses   cx_pai,
       dm_pai;

{$R *.DFM}

procedure ListadoProvincias;
begin
     CreateReportForm( TRptPrvForm, rptPrvForm );
end;

procedure TrptPrvForm.initializeForm;
begin
     DataCodigoInicial.Value := '';
     DataCodigoFinal.Value   := highStrCode;
end;

procedure TrptPrvForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TrptPrvForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TrptPrvForm.FormManagerOkButton;
begin
     Report.Launch;
end;

end.
