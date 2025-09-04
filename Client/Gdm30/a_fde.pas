unit a_fde;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxCheckBox, dxSkinsCore,
  dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox,
  cxRadioGroup, cxCurrencyEdit, dxUIAClasses,

  Gim30Fields;

type
  TMntFdeForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    FormaEnvioTable: TnxeTable;
    DataSource: TDataSource;
    DataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    PortesLabel: TcxLabel;
    ImporteCtrl: TcxDBCurrencyEdit;
    PortesCtrl: TcxDBRadioGroup;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure PortesCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FormManagerInitializeForm;
    procedure FormaEnvioTableNewRecord(DataSet: TDataSet);
  private
    FormaEnvioFields : TFormaEnvioFields;
  public

  end;

var  MntFdeForm: TMntFdeForm = nil;

procedure MntFormasEnvio( KeyValues : array of const );

implementation

{$R *.dfm}

uses   LibUtils,
       Variants,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dm_fde,

       cx_fde,

       l_fde,

       b_msg;


procedure MntFormasEnvio( KeyValues : array of const );
begin
     CreateEditForm( TMntFdeForm, MntFdeForm, KeyValues, TGds30Frm.VentasSection );
end;

procedure TMntFdeForm.FormManagerReportRequest;
begin
     ListadoFormasEnvio;
end;

procedure TMntFdeForm.PortesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ImporteCtrl.Enabled := PortesCtrl.ItemIndex=1;
end;

procedure TMntFdeForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasEnvio( Sender, qgsLinked );
end;

procedure TMntFdeForm.FormaEnvioTableNewRecord(DataSet: TDataSet);
begin
     FormaEnvioFields.Portes.Value := 0;
end;

function TMntFdeForm.FormManagerGetAccessLevel: Smallint;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ AcALFicheros.Value, AcALAlmacenes.Value ] );
end;

procedure TMntFdeForm.FormManagerInitializeForm;
begin
     FormaEnvioFields := TFormaEnvioFields.Create( FormaEnvioTable );
     SetEditControlDecimals( ImporteCtrl );
end;

end.
