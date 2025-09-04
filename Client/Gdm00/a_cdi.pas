unit a_cdi;

interface

uses Forms,
  AppForms,
  StdCtrls,
  Buttons,
  Mask,
  Controls,
  Classes,
  ExtCtrls,
  AppContainer,
  Menus,
  cxLookAndFeelPainters,               
  cxButtons,
  cxGraphics,
  cxCheckBox,
  cxDBEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxControls,
  cxContainer,
  cxEdit,
  cxTextEdit,
  DB,
  nxdb,
  DataManager,
  cxCalc, cxCurrencyEdit, cxIndexedComboBox, dxSkinsCore, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, dxUIAClasses;

type
  TMntCdiForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager:TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    precisionCtrl: TcxDBComboBox;
    CambioFijoCtrl: TcxDBCheckBox;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    DivisaTable: TnxeTable;
    DataSource: TDataSource;
    DivisaTableCodigo: TWideStringField;
    DivisaTableDescripcion: TWideStringField;
    DivisaTablePrecisionRedondeo: TFloatField;
    DivisaTableCambioFijo: TBooleanField;
    DivisaTableTipoCambio: TFloatField;
    TipoCambioCtrl:  TcxDBCurrencyEdit;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    procedure FormManagerCreateForm;
    procedure precisionCtrlPropertiesChange(Sender: TObject);
    procedure CambioFijoCtrlPropertiesChange(Sender: TObject);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure DivisaTableNewRecord(DataSet: TDataSet);
    procedure FormManagerReportRequest;
  private

  public

  end;

var MntCdiForm: TMntCdiForm = nil;

procedure MntCodigosDivisa(keyValues: array of const);

implementation

{$R *.DFM}

uses  SysUtils,
      LibUtils,
      DataAccess,

      Gdm00Dm,
      Gdm00Frm,

      cx_cdi,

      l_cdi;

procedure MntCodigosDivisa(keyValues: array of const);
begin
  CreateEditForm(TMntCdiForm, MntCdiForm, KeyValues );
end;

procedure TMntCdiForm.FormManagerCreateForm;
begin
     With PrecisionCtrl.Properties do
       begin
       DisplayFormat := '###0.####';
       EditFormat := DisplayFormat;
       end;
end;

procedure TMntCdiForm.FormManagerReportRequest;
begin
     ListadoCodigosDivisa;
end;

procedure TMntCdiForm.precisionCtrlPropertiesChange(Sender: TObject);
begin
     With TipoCambioCtrl.Properties do
       begin
       DecimalPlaces := LibUtils.Decimales( DivisaTablePrecisionRedondeo.Value );
       DisplayFormat := FloatDisplayFormat( DecimalPlaces );
       TipoCambioCtrl.ValidateEdit( False );
       end;
end;

procedure TMntCdiForm.CambioFijoCtrlPropertiesChange(Sender: TObject);
begin
     TipoCambioCtrl.Enabled := CambioFijoCtrl.Checked;
end;

procedure TMntCdiForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosDivisa(Sender, qgsLinked );
end;

procedure TMntCdiForm.DivisaTableNewRecord(DataSet: TDataSet);
begin
     DivisaTablePrecisionRedondeo.Value := 1;
     DivisaTableCambioFijo.Value := False;
end;

end.
