unit a_tde;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,
  cxMaskEdit, cxSpinEdit, dxSkinsCore, dxSkinsDefaultPainters, cxCheckBox,
  cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox, dxUIAClasses;

type
  TMntTdeForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBSpinEdit;
    dataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    TipoEnvaseTable: TnxeTable;
    DataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
  private

  public

  end;

var  MntTdeForm: TMntTdeForm = nil;

procedure MntTiposEnvase( KeyValues : array of const );

implementation

{$R *.dfm}

uses   LibUtils,
       SysUtils,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dm_tde,

       cx_tde,

       b_msg,

       l_tde;

procedure MntTiposEnvase( KeyValues : array of const );
begin
     CreateEditForm( TMntTdeForm, MntTdeForm, KeyValues, TGds30Frm.AlmacenSection );
end;

procedure TMntTdeForm.FormManagerReportRequest;
begin
     ListadoTiposEnvase;
end;

procedure TMntTdeForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposEnvase( Sender, qgsLinked );
end;

function TMntTdeForm.FormManagerGetAccessLevel: Smallint;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ acALFicheros.Value ] );
end;

end.
