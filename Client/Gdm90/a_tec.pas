
unit a_tec;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,

  AppContainer,

  ExtCtrls, Menus, cxLookAndFeelPainters, DB, nxdb, DataManager, cxButtons,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxGraphics,
  cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel, cxGroupBox;

type
  TMntTecForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyScreen: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    DataScreen: TgxEditPanel;
    NombreCtrl: TcxDBTextEdit;
    TecnicoTable: TnxeTable;
    TelefonoMovilCtrl: TcxDBTextEdit;
    DataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
  private

  public

  end;

var MntTecForm: TMntTecForm = nil;

procedure MntTecnicos( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Gdm90Dm,

       b_msg,

       cx_tec;

procedure MntTecnicos( KeyValues : array of const );
begin
     CreateEditForm( TMntTecForm, MntTecForm, KeyValues );
end;

procedure TMntTecForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTecnicos( Sender, qgsLinked );
end;

end.
