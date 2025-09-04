unit a_gdo;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,
  dxSkinsCore, cxGraphics, cxLookAndFeels, cxGroupBox, dxSkinsDefaultPainters, cxLabel,
  dxUIAClasses;

type
  TMntGdoForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    codigoCtrlCaption: TcxLabel;
    dataPanel: TgxEditPanel;
    Label1: TcxLabel;
    DescripcionCtrl: TcxDBTextEdit;
    GrupoDocumentoTable: TnxeTable;
    dataSource: TDataSource;
    GrupoDocumentoTableCodigo: TWideStringField;
    GrupoDocumentoTableDescripcion: TWideStringField;
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

var  MntGdoForm: TMntGdoForm = nil;

procedure MntGruposDocumento( KeyValues : array of const );

implementation

{$R *.dfm}

uses   EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dm_gdo,

       cx_gdo,

       l_gdo;

procedure MntGruposDocumento( KeyValues : array of const );
begin
     CreateEditForm( TMntGdoForm, MntGdoForm, KeyValues, TGds30Frm.VentasSection );
end;

procedure TMntGdoForm.FormManagerReportRequest;
begin
     ListadoGruposDocumento;
end;

procedure TMntGdoForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposDocumento( Sender, qgsLinked );
end;

function TMntGdoForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.AcVEFicheros.Value;
end;

end.
