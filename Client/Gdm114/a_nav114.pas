unit a_nav114;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,
  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox;

type
  TMntNav114Form = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    NombreCtrl: TcxDBTextEdit;
    NavieraTable: TnxeTable;
    DataSource: TDataSource;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
  private

  protected
    class procedure MntNavierasLink( Sender : TObject );

  public

  end;

var  MntNav114Form: TMntNav114Form = nil;

procedure MntNavieras( KeyValues : array of const );

implementation

{$R *.dfm}

uses   dxBar,

       AppManager,
       EnterpriseDataAccess,
       Gdm114Dm,
       Gdm30Frm,

       dm_nav114,

       cx_nav114,

       l_nav114;

procedure SetupMmtNavieras;
begin
     With Gds30Frm do
       begin
       NavierasItem.Visible := ivAlways;
       NavierasItem.OnClick := TMntNav114Form.MntNavierasLink;
       end;
end;

class procedure TMntNav114Form.MntNavierasLink( Sender : TObject );
begin
     MntNavieras( [] );
end;

procedure MntNavieras( KeyValues : array of const );
begin
     CreateEditForm( TMntNav114Form, MntNav114Form, KeyValues );
end;

procedure TMntNav114Form.FormManagerReportRequest;
begin
     ListadoNavieras;
end;

procedure TMntNav114Form.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaNavieras( Sender, qgsLinked );
end;

initialization
  AddProcedure( imOnEnterpriseAccess, 0, SetupMmtNavieras );

end.
