unit a_tur;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,
  Grids, Menus, cxLookAndFeelPainters, DB, nxdb, DataManager,
  cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxCurrencyEdit, cxGraphics, cxLookAndFeels, dxSkinsCore, cxLabel,
  cxGroupBox, dxSkinsDefaultPainters, cxMaskEdit, cxSpinEdit, cxTimeEdit;

type
  TMntTurForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    NroTurnoCtrl: TcxDBSpinEdit;
    TurnoTable: TnxeTable;
    dataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    TurnoDataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    Inicio1Ctrl: TcxDBTimeEdit;
    Fin1Ctrl: TcxDBTimeEdit;
    Inicio2Ctrl: TcxDBTimeEdit;
    Fin2Ctrl: TcxDBTimeEdit;
    cxLabel4: TcxLabel;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
  private

  public

  end;

var
  MntTurForm: TMntTurForm = nil;

procedure MntTurnos( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Gdm70Dm,
       Gdm70Frm,

       b_msg,

       cx_tur,

       l_tur;

procedure MntTurnos( KeyValues : array of const );
begin
     CreateEditForm( TMntTurForm, MntTurForm, KeyValues, Gds70Frm.ProduccionSection );
end;

procedure TMntTurForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTurnos( Sender, qgsLinked );
end;

procedure TMntTurForm.FormManagerInitializeForm;
begin
     //..
end;

procedure TMntTurForm.FormManagerReportRequest;
begin
     ListadoTurnos;
end;

end.
