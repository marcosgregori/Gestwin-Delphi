unit a_inc;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,
  Grids, Menus, cxLookAndFeelPainters, DB, nxdb, DataManager,
  cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxCurrencyEdit, cxGraphics, cxLookAndFeels, dxSkinsCore, cxLabel,
  cxGroupBox, dxSkinsDefaultPainters, cxMaskEdit, cxSpinEdit, cxTimeEdit;

type
  TMntIncForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBSpinEdit;
    IncidenciaTable: TnxeTable;
    dataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    IncidenciaDataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    IncidenciaTableCodigo: TSmallintField;
    IncidenciaTableDescripcion: TWideStringField;
    procedure FormManagerReportRequest;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
  private

  public

  end;

var
  MntIncForm: TMntIncForm = nil;

procedure MntIncidencias( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Gdm70Dm,
       Gdm70Frm,

       dm_cls,

       a_cls,

       cx_inc,
       cx_cls1,

       b_msg,

       l_inc;

procedure MntIncidencias( KeyValues : array of const );
begin
     CreateEditForm( TMntIncForm, MntIncForm, KeyValues, Gds70Frm.ProduccionSection );
end;

procedure TMntIncForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaIncidencias( Sender, qgsLinked );
end;

procedure TMntIncForm.FormManagerReportRequest;
begin
     ListadoIncidencias;
end;

end.
