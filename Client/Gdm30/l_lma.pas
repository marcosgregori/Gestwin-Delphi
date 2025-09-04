
unit l_lma;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,
  cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, DB, ReportManager,
  dxmdaset, DataManager, cxGraphics, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox;


type
    TRptLmaForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    PreciosCompraCtrl: TcxDBCheckBox;
    PreciosVentaCtrl: TcxDBCheckBox;
    Data: TgxMemData;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataPreciosCompra: TBooleanField;
    DataPreciosVenta: TBooleanField;
    gxRangeBox2: TgxRangeBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

    end;

var
  RptLmaForm: TRptLmaForm;

procedure ListadoListasMateriales;


implementation

uses   Gim00Fields,

       dm_cls,
       dm_fdc,
       dm_fdv,
       dm_lma,

       cx_lma;

{$R *.DFM}

procedure ListadoListasMateriales;
begin
     CreateReportForm( TrptLmaForm, RptLmaForm );
end;

procedure TRptLmaForm.InitializeForm;
begin
     DataCodigoFinal.Value := HighStrCode;
     DataPreciosCompra.Value := True;
     DataPreciosVenta.Value := True;
end;

procedure TRptLmaForm.CodigoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ListaMateriales.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptLmaForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         FacturaCompras.FijaDecimalesInforme( Report );
         FacturaVentas.FijaDecimalesInforme( Report );
         Clase.SetReportTitles( Report, 4 );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptLmaForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaListasMateriales( Sender );
end;

end.
