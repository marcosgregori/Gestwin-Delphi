
unit a_tdt;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,

  AppContainer,
  ExtCtrls, Menus, cxLookAndFeelPainters, DB, nxdb, DataManager,
  cxCheckBox, cxDBEdit, cxButtons, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxGroupBox, cxRadioGroup, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, cxLabel;

type
  TMntTdtForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyScreen: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    DataScreen: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    TipoTareaTable: TnxeTable;
    UrgenteCtrl: TcxDBCheckBox;
    DataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var  MntTdtForm: TMntTdtForm = nil;

procedure MntTiposTarea( KeyValues : array of const );

implementation

{$R *.DFM}

uses   gdm90Dm,

       b_msg,

       cx_tdt;

procedure MntTiposTarea( KeyValues : array of const );
begin
     CreateEditForm( TMntTdtForm, MntTdtForm, KeyValues );
end;

procedure TMntTdtForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposTarea( Sender, qgsLinked );
end;

end.
