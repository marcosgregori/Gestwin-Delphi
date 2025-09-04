unit l_tla;

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
    TRptTlaForm = class(TgxForm)
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
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    private

    public

    end;

var
  RptTlaForm: TRptTlaForm;

procedure ListadoTarifaClienteArticulo;


implementation

uses   Gim00Fields,
       Gim30Fields,
       Gdm00Dm,

       dm_cls,
       dm_fdv,
       dm_cli,
       dm_art,

       cx_cli,
       cx_art;

{$R *.DFM}

procedure ListadoTarifaClienteArticulo;
begin
     CreateReportForm( TRptTlaForm, RptTlaForm );
end;

procedure TRptTlaForm.InitializeForm;
begin
     DataClienteFinal.Value := HighStrCode;
     DataArticuloFinal.Value := HighStrCode;
end;

procedure TRptTlaForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scCompras, False, Sender );
end;

procedure TRptTlaForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptTlaForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptTlaForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptTlaForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;

         FacturaVentas.FijaDecimalesInforme( Report );

         With DataModule00.DmEmpresaFields do
           begin
           SetValue( RsRecargos, Ventas_Recargos.Value );
           If   not ValueIsEmpty( Ventas_NombreRecargos.Value )
           then SetValue( RsNombreRecargos, Ventas_NombreRecargos.Value );
           end;

         Start;
       except on E : Exception do Cancel( E );
         end;
end;

end.


