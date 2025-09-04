unit l_cnw;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
  dxmdaset, DataManager, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxPC,
  cxControls, cxCheckBox, cxGraphics, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLabel, cxGroupBox,
  cxPCdxBarPopupMenu, dxBarBuiltInMenu;

                                                                                                  
type
    TRptCnwForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    OrdenarCtrl: TcxDBCheckBox;
    TodosLosDatosCtrl: TcxDBCheckBox;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    ContactoInicialCtrl: TcxDBTextEdit;
    ContactoFinalCtrl: TcxDBTextEdit;
    TabSheet3: TcxTabSheet;
    CodigoPostalInicialCtrl: TcxDBTextEdit;
    CodigoPostalFinalCtrl: TcxDBTextEdit;
    ProvinciaInicialCtrl: TcxDBTextEdit;
    ProvinciaFinalCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataContactoInicial: TWideStringField;
    DataContactoFinal: TWideStringField;
    DataOrdenar: TBooleanField;
    DataTodosLosDatos: TBooleanField;
    DataCodigoPostalInicial: TWideStringField;
    DataCodigoPostalFinal: TWideStringField;
    DataProvinciaInicial: TWideStringField;
    DataProvinciaFinal: TWideStringField;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox4: TgxRangeBox;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label2: TcxLabel;
    Label6: TcxLabel;
    Label1: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ContactoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ContactoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ProvinciaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalInicialCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalFinalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalFinalCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoPostalInicialCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
    private

    public

    end;

var RptCnwForm : TRptCnwForm = nil;

procedure ListadoContactosWeb;


implementation

uses   dm_prv,
       dm_cop,
       dm_cnw,
       dm_pai,

       cx_cnw,
       cx_prv,
       cx_cop;

{$R *.DFM}


procedure ListadoContactosWeb;
begin
     CreateReportForm( TRptCnwForm, RptCnwForm );
end;

procedure TRptCnwForm.InitializeForm;
begin
     DataContactoFinal.Value := HighStrCode;
     DataProvinciaFinal.Value := HighStrCode;
     DataCodigoPostalFinal.Value := HighStrCode;
     DataOrdenar.Value := False;
     DataTodosLosDatos.Value := False;
end;

procedure TRptCnwForm.ProvinciaCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaProvincias( CodigoEspaña, Sender );
end;

procedure TRptCnwForm.ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( CodigoEspaña, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCnwForm.ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaFinalCtrl.Editing
     then CodigoPostalFinalCtrl.PostEditValue( '' );
end;

procedure TRptCnwForm.ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaInicialCtrl.Editing
     then CodigoPostalInicialCtrl.PostEditValue( '' );
end;

procedure TRptCnwForm.ContactoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaContactosWeb( Sender );
end;

procedure TRptCnwForm.ContactoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ContactoWeb.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCnwForm.CodigoPostalFinalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( CodigoEspaña, DataProvinciaFinal.Value, Sender );
end;

procedure TRptCnwForm.CodigoPostalFinalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( CodigoEspaña, DataProvinciaFinal.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptCnwForm.CodigoPostalInicialCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( CodigoEspaña, DataProvinciaInicial.Value, Sender );
end;

procedure TRptCnwForm.CodigoPostalInicialCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( CodigoEspaña, DataProvinciaInicial.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptCnwForm.FormManagerOkButton;
begin
     Enabled := False;
     With Report do
       try
         Load;
         SetValue( RsSeleccion, PageControl.ActivePageIndex );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

end.
