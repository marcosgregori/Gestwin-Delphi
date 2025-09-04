unit l_tlf;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
  dxmdaset, DataManager, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox;


type
    TRptTlfForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    CodigoClienteInicialCtrl: TcxDBTextEdit;
    CodigoClienteFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    CodigoFamiliaInicialCtrl: TcxDBTextEdit;
    CodigoFamiliaFinalCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataFamiliaInicial: TWideStringField;
    DataFamiliaFinal: TWideStringField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClienteCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure FamiliaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FamiliaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    private

    public

    end;

var
  RptTlfForm: TRptTlfForm;

procedure ListadoTarifaClienteFamilia;


implementation

uses   Gim00Fields,
       Gim30Fields,

       dm_cls,
       dm_fdv,
       dm_cli,
       dm_fam,

       cx_cli,
       cx_fam;

{$R *.DFM}

procedure ListadoTarifaClienteFamilia;
begin
     CreateReportForm( TRptTlfForm, RptTlfForm );
end;

procedure TRptTlfForm.InitializeForm;
begin
     DataClienteFinal.Value := HighStrCode;
     DataFamiliaFinal.Value := HighStrCode;
end;

procedure TRptTlfForm.FamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TRptTlfForm.FamiliaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Familia.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptTlfForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptTlfForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptTlfForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         FacturaVentas.FijaDecimalesInforme( Report );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

end.


