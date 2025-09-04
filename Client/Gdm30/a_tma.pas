unit a_tma;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,
  cxMaskEdit, cxSpinEdit, dxSkinsCore, dxSkinsDefaultPainters, cxCheckBox,
  cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox, dxUIAClasses;

type
  TMntTmaForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBSpinEdit;
    dataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    TipoMovAlmacenTable: TnxeTable;
    dataSource: TDataSource;
    NoAfectarCosteCtrl: TcxDBCheckBox;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure FormManagerInitializeForm;
  private

  public

  end;

var  MntTmaForm: TMntTmaForm = nil;

procedure MntTiposMovimientoAlmacen( KeyValues : array of const );

implementation

{$R *.dfm}

uses   LibUtils,
       SysUtils,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dm_tma,

       cx_tma,

       b_msg,

       l_tma;

resourceString
       RsMsg1  = 'Solo los tipos de movimiento definidos por el usuario son modificables.';
       RsMsg2  = 'Los números de tipo de movimiento de usuario estan comprendidos entre %d y 99.';

procedure MntTiposMovimientoAlmacen( KeyValues : array of const );
begin
     TipoMovAlmacen;   //* 19.01.2005  Solo para forzar la creación de los tipos predefinidos
     CreateEditForm( TMntTmaForm, MntTmaForm, KeyValues, TGds30Frm.AlmacenSection );
end;

procedure TMntTmaForm.FormManagerReportRequest;
begin
     ListadoTiposMovimientoAlmacen;
end;

procedure TMntTmaForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposMovimientoAlmacen( Sender, False, True, qgsLinked );
end;

function TMntTmaForm.FormManagerGetAccessLevel: Smallint;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ acALFicheros.Value, acALTiposMovimiento.Value ] );
end;

procedure TMntTmaForm.FormManagerInitializeForm;
begin
     TipoMovAlmacenTable.SetDefaultRangeValues( [ tmUltimoPredefinido + 1 ] , [ 999 ] );
end;

end.
