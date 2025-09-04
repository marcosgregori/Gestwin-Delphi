unit l_usr;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,

  ReportManager, DB, dxmdaset, DataManager, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxDBEdit, Menus, cxLookAndFeelPainters,
  cxButtons, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox;


type
    TrptUsrForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    DataSource1: TDataSource;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
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
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    private

    public

    end;

var
  rptUsrForm : TrptUsrForm;

procedure ListadoUsuarios;


implementation

uses   dm_usr,

       cx_usr;

{$R *.DFM}

procedure ListadoUsuarios;
begin
     CreateReportForm( TrptUsrForm, rptUsrForm );
end;

procedure TrptUsrForm.initializeForm;
begin
     DataCodigoInicial.Value := ZeroStrCode;
     DataCodigoFinal.Value   := HighStrCode;
end;

procedure TrptUsrForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUsuarios( Sender );
end;

procedure TrptUsrForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Usuario.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TrptUsrForm.FormManagerOkButton;
begin
     Report.Launch;
end;

end.
