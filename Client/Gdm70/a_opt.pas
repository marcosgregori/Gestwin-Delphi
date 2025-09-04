unit a_opt;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,
  Grids, Menus, cxLookAndFeelPainters, DB, nxdb, DataManager,
  cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxCurrencyEdit, cxGraphics, cxLookAndFeels, dxSkinsCore, cxLabel,
  cxGroupBox, dxSkinsDefaultPainters;

type
  TMntOptForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    OperarioTipoTable: TnxeTable;
    dataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    CosteHoraCtrl: TcxDBCurrencyEdit;
    OperarioTipoDataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MntOptForm: TMntOptForm = nil;

procedure MntOperariosTipo( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Gdm40Dm,
       Gdm40Frm,

       b_msg,

       cx_opt,

       l_opt;

procedure MntOperariosTipo( KeyValues : array of const );
begin
     CreateEditForm( TMntOptForm, MntOptForm, KeyValues, Gds40Frm.PrevisionSection );
end;

procedure TMntOptForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOperariosTipo( Sender, qgsLinked );
end;

procedure TMntOptForm.FormManagerInitializeForm;
begin
     SetEditControlDecimals( CosteHoraCtrl );
end;

procedure TMntOptForm.FormManagerReportRequest;
begin
     ListadoOperariosTipo;
end;

end.
