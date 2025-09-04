unit a_tvp;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,
  cxMaskEdit, cxSpinEdit, dxSkinsCore, dxSkinsDefaultPainters, cxCheckBox,
  cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox, dxUIAClasses;

type
  TMntTvpForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBSpinEdit;
    dataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    TipoVentaPeriodicaTable: TnxeTable;
    dataSource: TDataSource;
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

var  MntTvpForm: TMntTvpForm = nil;

procedure MntTiposVentasPeriodicas( KeyValues : array of const );

implementation

{$R *.dfm}

uses   LibUtils,
       SysUtils,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dm_tvp,

       cx_tvp,

       b_msg,

       l_tvp;

procedure MntTiposVentasPeriodicas( KeyValues : array of const );
begin
     CreateEditForm( TMntTvpForm, MntTvpForm, KeyValues, TGds30Frm.VentasSection );
end;

procedure TMntTvpForm.FormManagerReportRequest;
begin
     ListadoTiposVentaPeriodica;
end;

procedure TMntTvpForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposVentasPeriodicas( Sender, False, qgsLinked );
end;

function TMntTvpForm.FormManagerGetAccessLevel: Smallint;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ acALFicheros.Value ] );
end;

end.
