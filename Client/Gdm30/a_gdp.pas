unit a_gdp;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,
  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxLabel,
  cxGroupBox, dxUIAClasses;

type
  TMntGdpForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    GrupoProveedorTable: TnxeTable;
    dataSource: TDataSource;
    GrupoProveedorTableCodigo: TWideStringField;
    GrupoProveedorTableDescripcion: TWideStringField;
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

var  MntGdpForm: TMntGdpForm = nil;

procedure MntGruposProveedores( KeyValues : array of const );

implementation

{$R *.dfm}

uses   EnterpriseDataAccess,

       Gim00Fields,
       Gdm00Dm,
       Gdm30Frm,

       dm_gdp,

       cx_gdp,

       l_gdp;

procedure MntGruposProveedores( KeyValues : array of const );
begin
     CreateEditForm( TmntGdpForm, MntGdpForm, KeyValues, TGds30Frm.ComprasSection );
end;

procedure TMntGdpForm.FormManagerReportRequest;
begin
     ListadoGruposProveedores;
end;

procedure TMntGdpForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposProveedores( Sender, qgsLinked );
end;

function TMntGdpForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.AcCOFicheros.Value;
end;

end.
