unit l_cld;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
  dxmdaset, DataManager, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxPC,
  cxControls, cxCheckBox, dxSkinsCore, dxSkinscxPCPainter, cxGraphics,
  cxLookAndFeels, dxSkinsDefaultPainters, cxLabel, cxGroupBox,
  cxPCdxBarPopupMenu, dxBarBuiltInMenu;

                                                                                                  
type
    TRptCldForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    OrdenarCtrl: TcxDBCheckBox;
    TodosLosDatosCtrl: TcxDBCheckBox;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    TabSheet3: TcxTabSheet;
    CodigoPostalInicialCtrl: TcxDBTextEdit;
    CodigoPostalFinalCtrl: TcxDBTextEdit;
    ProvinciaInicialCtrl: TcxDBTextEdit;
    ProvinciaFinalCtrl: TcxDBTextEdit;
    CodigoPaisCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataOrdenar: TBooleanField;
    DataTodosLosDatos: TBooleanField;
    DataCodigoPostalInicial: TWideStringField;
    DataCodigoPostalFinal: TWideStringField;
    DataProvinciaInicial: TWideStringField;
    DataProvinciaFinal: TWideStringField;
    DataCodigoPais: TWideStringField;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox4: TgxRangeBox;
    DataFormaCobroInicial: TWideStringField;
    DataFormaCobroFinal: TWideStringField;
    cxTabSheet1: TcxTabSheet;
    gxRangeBox5: TgxRangeBox;
    FormaCobroInicialCtrl: TcxDBTextEdit;
    FormaCobroFinalCtrl: TcxDBTextEdit;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label2: TcxLabel;
    Label6: TcxLabel;
    Label1: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    Label17: TcxLabel;
    Label18: TcxLabel;
    Label19: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataIncluirObsoletos: TBooleanField;
    IncluirObsoletosCtrl: TcxDBCheckBox;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
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
    procedure FormaCobroCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormaCobroCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure ReportBeforeStart;
    procedure ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
    private

    public

    end;

var RptCldForm : TRptCldForm = nil;

procedure ListadoClientesDeudores;


implementation

uses   Gim00Fields,

       dm_pai,
       dm_prv,
       dm_cop,
       dm_cli,
       dm_fco,

       cx_cli,
       cx_prv,
       cx_pai,
       cx_cop,
       cx_fco;

{$R *.DFM}

procedure ListadoClientesDeudores;
begin
     CreateReportForm( TRptCldForm, RptCldForm );
end;

procedure TRptCldForm.initializeForm;
begin
     DataClienteFinal.Value := HighStrCode;
     DataCodigoPais.Value := CodigoEspaña;
     DataProvinciaFinal.Value := HighStrCode;
     DataCodigoPostalFinal.Value  := HighStrCode;
     DataFormaCobroFinal.Value := HighStrCode;
     DataOrdenar.Value := False;
     DataTodosLosDatos.Value := False;
end;

procedure TRptCldForm.ProvinciaCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaProvincias( DataCodigoPais.Value, Sender );
end;

procedure TRptCldForm.ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( DataCodigoPais.Value, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCldForm.ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaFinalCtrl.Editing
     then CodigoPostalFinalCtrl.PostEditValue( '' );
end;

procedure TRptCldForm.ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaInicialCtrl.Editing
     then CodigoPostalInicialCtrl.PostEditValue( '' );
end;

procedure TRptCldForm.ReportBeforeStart;

var  Seleccion : SmallInt;

begin
     If   PageControl.ActivePageIndex=2  // Por forma de cobro
     then Seleccion := 4
     else Seleccion := PageControl.ActivePageIndex;
     Report.SetValue( RsSeleccion, Seleccion );
end;

procedure TRptCldForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptCldForm.ClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptCldForm.CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TRptCldForm.CodigoPaisCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptCldForm.CodigoPostalFinalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( DataCodigoPais.Value, DataProvinciaFinal.Value, Sender );
end;

procedure TRptCldForm.CodigoPostalFinalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( DataCodigoPais.Value, DataProvinciaFinal.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptCldForm.CodigoPostalInicialCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( DataCodigoPais.Value, DataProvinciaInicial.Value, Sender );
end;

procedure TRptCldForm.CodigoPostalInicialCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( DataCodigoPais.Value, DataProvinciaInicial.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptCldForm.FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TRptCldForm.FormaCobroCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCldForm.FormManagerOkButton;
begin
     Report.Launch;
end;

end.
