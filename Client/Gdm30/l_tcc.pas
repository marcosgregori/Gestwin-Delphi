unit l_tcc;

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
    TRptTccForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    CodigoProveedorInicialCtrl: TcxDBTextEdit;
    CodigoProveedorFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    CodigoArticuloInicialCtrl: TcxDBTextEdit;
    CodigoArticuloFinalCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
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
    procedure CodigoProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesValidate(
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
  RptTccForm: TRptTccForm;

procedure ListadoTarifaClaseCompras;


implementation

uses   Gim30Fields,

       dm_cls,
       dm_fdc,
       dm_pro,
       dm_art,

       cx_pro,
       cx_art;

{$R *.DFM}

procedure ListadoTarifaClaseCompras;
begin
     CreateReportForm( TRptTccForm, RptTccForm );
end;

procedure TRptTccForm.initializeForm;
begin
     DataProveedorFinal.Value := HighStrCode;
     DataArticuloFinal.Value := HighStrCode;
end;

procedure TRptTccForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scCompras, False, Sender );
end;

procedure TRptTccForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptTccForm.CodigoProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TRptTccForm.CodigoProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptTccForm.FormManagerOkButton;
begin
     With Report do
       try
         Load;
         FacturaCompras.FijaDecimalesInforme( Report );
         Clase.SetReportTitles( Report, 4 );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

end.


