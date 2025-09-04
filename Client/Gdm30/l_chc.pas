unit l_chc;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
  dxmdaset, DataManager, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, cxGraphics, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox;


type
    TRptChcForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
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
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    private

    public

    end;

var
  RptChcForm: TRptChcForm;

procedure ListadoConsumosClientes;


implementation

uses   Gim30Fields,

       dm_cli,
       dm_fdv,
       dm_cls,
       
       cx_cli;

{$R *.DFM}

procedure ListadoConsumosClientes;
begin
     CreateReportForm( TRptChcForm, RptChcForm );
end;

procedure TRptChcForm.InitializeForm;
begin
     DataClienteFinal.Value := HighStrCode;
end;

procedure TRptChcForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptChcForm.ClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptChcForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         FacturaVentas.FijaDecimalesInforme( Report );
         Clase.SetReportTitles( Report, 4 );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

end.


