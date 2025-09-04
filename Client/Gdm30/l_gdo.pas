unit l_gdo;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  dxSkinsCore, cxGraphics, cxLookAndFeels, cxGroupBox, dxSkinsDefaultPainters,
  cxLabel;


type
    TRptGdoForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    Label1: TcxLabel;
    Label3: TcxLabel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataSource: TDataSource;
    Label4: TcxLabel;
    gxRangeBox1: TgxRangeBox;
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

var RptGdoForm: TRptGdoForm = nil;

procedure ListadoGruposDocumento;


implementation

uses   dm_gdo,
       cx_gdo;

{$R *.DFM}

procedure ListadoGruposDocumento;
begin
     CreateReportForm( TRptGdoForm, RptGdoForm );
end;

procedure TRptGdoForm.initializeForm;
begin
     DataCodigoInicial.Value := '';
     DataCodigoFinal.Value := HighStrCode;
end;

procedure TRptGdoForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoDocumento.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptGdoForm.FormManagerOkButton;
begin
     Enabled := False;
     With Report do
       try
         Load;
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptGdoForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposDocumento( Sender );
end;

end.
