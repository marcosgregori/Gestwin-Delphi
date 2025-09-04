unit l_tcof;

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
    TRptTcofForm = class(TgxForm)
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
    DataVendedorInicial: TWideStringField;
    DataVendedorFinal: TWideStringField;
    gxRangeBox3: TgxRangeBox;
    VendedorInicialCtrl: TcxDBTextEdit;
    VendedorFinalCtrl: TcxDBTextEdit;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
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
    procedure CodigoFamiliaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoFamiliaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure VendedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

    end;

var
  RptTcofForm: TRptTcofForm;

procedure ListadoTablaComisionFamilia;


implementation

uses   Gim00Fields,
       Gim30Fields,

       dm_cls,
       dm_fdv,
       dm_ven,
       dm_cli,
       dm_fam,

       cx_ven,
       cx_cli,
       cx_fam;

{$R *.DFM}

procedure ListadoTablaComisionFamilia;
begin
     CreateReportForm( TRptTcofForm, RptTcofForm );
end;

procedure TRptTcofForm.InitializeForm;
begin
     DataVendedorFinal.Value := HighStrCode;
     DataClienteFinal.Value := HighStrCode;
     DataFamiliaFinal.Value := HighStrCode;
end;

procedure TRptTcofForm.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TRptTcofForm.VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptTcofForm.CodigoFamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TRptTcofForm.CodigoFamiliaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Familia.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptTcofForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptTcofForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptTcofForm.FormManagerOkButton;
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


