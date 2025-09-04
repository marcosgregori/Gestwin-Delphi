unit a_mat;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Grids, Menus, cxLookAndFeelPainters, cxGraphics, DB, nxdb,
  DataManager, cxMaskEdit, cxDropDownEdit, cxDBEdit, cxIndexedComboBox,
  cxCurrencyEdit, cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxLookAndFeels, dxSkinsCore, cxLabel, cxGroupBox, dxSkinsDefaultPainters;

type
  TMntMatForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    MaquinaTipoTable: TnxeTable;
    dataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    CosteHoraCtrl: TcxDBCurrencyEdit;
    MetodoAsignacionCtrl: TcxDBIndexedComboBox;
    MaquinaTipoDataSource: TDataSource;
    MaquinaTipoTableCodigo: TWideStringField;
    MaquinaTipoTableDescripcion: TWideStringField;
    MaquinaTipoTableCosteHora: TBCDField;
    MaquinaTipoTableMetodoAsignacion: TSmallintField;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    capAsignacionLabel: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    procedure FormManagerReportRequest;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerInitializeForm;
    procedure MaquinaTipoTableNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MntMatForm: TMntMatForm = nil;

procedure MntMaquinasTipo( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Gdm40Dm,
       Gdm40Frm,

       b_msg,

       cx_mat,

       l_mat;

procedure MntMaquinasTipo( KeyValues : array of const );
begin
     CreateEditForm( TmntMatForm, mntMatForm, KeyValues, Gds40Frm.PrevisionSection );
end;

procedure TMntMatForm.FormManagerInitializeForm;
begin
     SetEditControlDecimals( CosteHoraCtrl );
end;

procedure TMntMatForm.FormManagerReportRequest;
begin
     ListadoMaquinasTipo;
end;

procedure TMntMatForm.MaquinaTipoTableNewRecord(DataSet: TDataSet);
begin
     MaquinaTipoTableMetodoAsignacion.Value := 0;
end;

procedure TMntMatForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMaquinasTipo( Sender, qgsLinked );
end;

end.
