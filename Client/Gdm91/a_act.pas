
unit a_act;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,

  AppContainer,

  ExtCtrls, Menus, cxLookAndFeelPainters, DB, nxdb, DataManager, cxButtons,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxGraphics,
  cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel, cxGroupBox;

type
  TMntActForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyScreen: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    DataScreen: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    ActividadTable: TnxeTable;
    Panel3: TPanel;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    DataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
  private

  public

  end;

var MntActForm: TMntActForm = nil;

procedure MntActividades( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Gdm90Dm,

       b_msg,

       cx_act;

procedure MntActividades( KeyValues : array of const );
begin
     CreateEditForm( TMntActForm, MntActForm, KeyValues );
end;

procedure TMntActForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaActividades( Sender, qgsLinked );
end;

end.
