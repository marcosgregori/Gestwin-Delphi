unit a_cco;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,
  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox;

type
  TmntCCoForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    CentroCosteTable: TnxeTable;
    DataSource: TDataSource;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
  private

  public

  end;

var  MntCCoForm: TmntCCoForm = nil;

procedure MntCentrosCoste( KeyValues : array of const );

implementation

{$R *.dfm}

uses   EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm10Frm,

       dm_cco,

       cx_cco,

       l_cco;

procedure MntCentrosCoste( KeyValues : array of const );
begin
     CreateEditForm( TmntCCoForm, MntCcoForm, KeyValues, TGds10Frm.ContableSection );
end;

procedure TmntCCoForm.FormManagerReportRequest;
begin
     ListadoCentrosCoste;
end;

procedure TmntCCoForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender, qgsLinked );
end;

function TmntCCoForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.AcGCFicheros.Value;
end;

end.
