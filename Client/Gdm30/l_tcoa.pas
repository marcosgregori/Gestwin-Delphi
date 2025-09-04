unit l_tcoa;

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
    TRptTcoaForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    CodigoClienteInicialCtrl: TcxDBTextEdit;
    CodigoClienteFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    CodigoArticuloInicialCtrl: TcxDBTextEdit;
    CodigoArticuloFinalCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
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
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(
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
  RptTcoaForm: TRptTcoaForm;

procedure ListadoTablaComisionArticulo;


implementation

uses   Gim00Fields,
       Gim30Fields,

       dm_cls,
       dm_fdv,
       dm_ven,
       dm_cli,
       dm_art,

       cx_ven,
       cx_cli,
       cx_art;

{$R *.DFM}

procedure ListadoTablaComisionArticulo;
begin
     CreateReportForm( TRptTcoaForm, RptTcoaForm );
end;

procedure TRptTcoaForm.InitializeForm;
begin
     DataVendedorFinal.Value := HighStrCode;
     DataClienteFinal.Value := HighStrCode;
     DataArticuloFinal.Value := HighStrCode;
end;

procedure TRptTcoaForm.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TRptTcoaForm.VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptTcoaForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TRptTcoaForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptTcoaForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptTcoaForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptTcoaForm.FormManagerOkButton;
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


