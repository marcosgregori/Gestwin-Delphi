unit a_tlm;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxCheckBox, dxSkinsCore,
  dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox,
  dxUIAClasses;

type
  TMntTlmForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    TipoLineaMovimientoTable: TnxeTable;
    DataSource: TDataSource;
    DataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
  private

  public

  end;

var  MntTlmForm: TMntTlmForm = nil;

procedure MntTiposLineaMovimiento( KeyValues : array of const );

implementation

{$R *.dfm}

uses   LibUtils,
       Variants,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dm_tlm,

       cx_tlm,

       l_tlm,

       b_msg;

procedure MntTiposLineaMovimiento( KeyValues : array of const );
begin
     CreateEditForm( TMntTlmForm, MntTlmForm, KeyValues, TGds30Frm.AlmacenSection );
end;

procedure TMntTlmForm.FormManagerReportRequest;
begin
     ListadoTiposLineaMovimiento;
end;

procedure TMntTlmForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposLineaMovimiento( Sender, qgsLinked );
end;

function TMntTlmForm.FormManagerGetAccessLevel: Smallint;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ AcALFicheros.Value ] );
end;

end.
