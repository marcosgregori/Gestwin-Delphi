unit l_cnt;

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
    TRptCntForm = class(TgxForm)
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
    CodigoPaisCtrl: TcxDBTextEdit;
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
    DataCodigoPais: TWideStringField;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox4: TgxRangeBox;
    cxTabSheet1: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    ActividadInicialCtrl: TcxDBTextEdit;
    ActividadFinalCtrl: TcxDBTextEdit;
    DataActividadInicial: TWideStringField;
    DataActividadFinal: TWideStringField;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label2: TcxLabel;
    Label6: TcxLabel;
    Label1: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label11: TcxLabel;
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
    procedure CodigoPaisCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ActividadPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ActividadCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
    private

    public

    end;

var RptCntForm : TRptCntForm = nil;

procedure ListadoContactos;


implementation

uses   Gdm90Dm,

       dm_pai,
       dm_prv,
       dm_cop,
       dm_cnt,
       dm_act,
       
       cx_cnt,
       cx_prv,
       cx_pai,
       cx_act,
       cx_cop;

{$R *.DFM}


procedure ListadoContactos;
begin
     CreateReportForm( TRptCntForm, RptCntForm );
end;

procedure TRptCntForm.InitializeForm;
begin
     DataContactoFinal.Value := HighStrCode;
     DataCodigoPais.Value := CodigoEspaña;
     DataProvinciaFinal.Value := HighStrCode;
     DataCodigoPostalFinal.Value := HighStrCode;
     DataActividadFinal.Value := HighStrCode;
     DataOrdenar.Value := False;
     DataTodosLosDatos.Value := False;
end;

procedure TRptCntForm.ProvinciaCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaProvincias( DataCodigoPais.Value, Sender );
end;

procedure TRptCntForm.ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( DataCodigoPais.Value, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCntForm.ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaFinalCtrl.Editing
     then CodigoPostalFinalCtrl.PostEditValue( '' );
end;

procedure TRptCntForm.ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaInicialCtrl.Editing
     then CodigoPostalInicialCtrl.PostEditValue( '' );
end;

procedure TRptCntForm.ContactoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaContactos( Sender );
end;

procedure TRptCntForm.ContactoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Contacto.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCntForm.ActividadCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Actividad.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCntForm.ActividadPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaActividades( Sender );
end;

procedure TRptCntForm.CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TRptCntForm.CodigoPaisCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptCntForm.CodigoPostalFinalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( DataCodigoPais.Value, DataProvinciaFinal.Value, Sender );
end;

procedure TRptCntForm.CodigoPostalFinalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( DataCodigoPais.Value, DataProvinciaFinal.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptCntForm.CodigoPostalInicialCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( DataCodigoPais.Value, DataProvinciaInicial.Value, Sender );
end;

procedure TRptCntForm.CodigoPostalInicialCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( DataCodigoPais.Value, DataProvinciaInicial.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptCntForm.FormManagerOkButton;
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
