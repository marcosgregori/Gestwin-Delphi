unit l_uda;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,

  Mask, ComCtrls, ReportManager, Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
  cxMaskEdit, cxDropDownEdit, cxDBEdit, cxIndexedComboBox, cxTextEdit, cxPC,
  cxControls, cxContainer, cxEdit, cxCheckBox, DB, dxmdaset, DataManager,

  Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxLookAndFeels, cxLabel, cxGroupBox, cxPCdxBarPopupMenu, dxBarBuiltInMenu;


type
    TRptUdaForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoArticuloInicial: TWideStringField;
    DataCodigoArticuloFinal: TWideStringField;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    gxRangeBox1: TgxRangeBox;
    CodigoArticuloInicialCtrl: TcxDBTextEdit;
    CodigoArticuloFinalCtrl: TcxDBTextEdit;
    Label1: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    gxRangeBox4: TgxRangeBox;
    AlmacenInicialCtrl: TcxDBTextEdit;
    AlmacenFinalCtrl: TcxDBTextEdit;
    Label5: TcxLabel;
    cxLabel1: TcxLabel;
    Label9: TcxLabel;
    DataCodigoAlmacenInicial: TStringField;
    DataCodigoAlmacenFinal: TStringField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoArticuloCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    private

    public

    end;

var
  RptUdaForm: TRptUdaForm;

procedure ListadoUbicacionArticulos;


implementation

uses   EnterpriseDataAccess,

       dm_art,
       dm_alm,
       cx_art,
       cx_alm;

{$R *.DFM}

procedure ListadoUbicacionArticulos;
begin
     CreateReportForm( TrptUdaForm, RptUdaForm );
end;

procedure TRptUdaForm.InitializeForm;
begin
     DataCodigoArticuloFinal.Value := HighStrCode;
     DataCodigoAlmacenFinal.Value := HighStrCode;
end;

procedure TRptUdaForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TRptUdaForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptUdaForm.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TRptUdaForm.AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptUdaForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, True, Sender );
end;

end.
