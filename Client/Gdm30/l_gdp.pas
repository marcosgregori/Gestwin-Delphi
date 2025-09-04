unit l_gdp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  dxSkinsCore, cxGraphics, cxLookAndFeels, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox;


type
    TRptGdpForm = class(TgxForm)
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

var RptGdpForm: TRptGdpForm = nil;

procedure ListadoGruposProveedores;


implementation

uses   dm_gdp,
       cx_gdp;

{$R *.DFM}

procedure ListadoGruposProveedores;
begin
     CreateReportForm( TrptGdpForm, RptGdpForm );
end;

procedure TRptGdpForm.initializeForm;
begin
     DataCodigoInicial.Value := '';
     DataCodigoFinal.Value := HighStrCode;
end;

procedure TRptGdpForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoProveedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptGdpForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptGdpForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposProveedores( Sender );
end;

end.
