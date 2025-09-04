unit l_rut;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
  dxmdaset, DataManager, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox;


type
    TRptRutForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    RutaInicialCtrl: TcxDBTextEdit;
    RutaFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataRutaInicial: TWideStringField;
    DataRutaFinal: TWideStringField;
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
    procedure RutaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure RutaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    private

    public

    end;

var
  RptRutForm: TRptRutForm;

procedure ListadoRutas;


implementation

uses   Gim00Fields,
       Gim30Fields,

       dm_rut,

       cx_rut;

{$R *.DFM}

procedure ListadoRutas;
begin
     CreateReportForm( TRptRutForm, RptRutForm );
end;

procedure TRptRutForm.InitializeForm;
begin
     DataRutaFinal.Value := HighStrCode;
end;

procedure TRptRutForm.RutaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRutas( Sender );
end;

procedure TRptRutForm.RutaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Ruta.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptRutForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

end.


