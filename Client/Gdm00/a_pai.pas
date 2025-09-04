unit a_pai;

interface

uses Grids, StdCtrls, Buttons, Mask, Controls, Forms, Classes, ExtCtrls,

     AppContainer,
     DataAccess,
     DB, nxdb,
     DataManager,
     cxStyles,
     cxCustomData,
     cxGraphics,
     cxFilter,
     cxData,
     cxDataStorage,
     cxEdit,
     cxDBData,
     cxGridLevel,
     cxClasses,
     cxControls,
     cxGridCustomView,
     cxGridCustomTableView,
     cxGridTableView,
     cxGridDBTableView,
     cxGrid,
     cxContainer,
     cxTextEdit,
     cxDBEdit,
     cxLabel,
     cxDBLabel,

     AppForms,
     Menus,
     cxLookAndFeelPainters,
     cxButtons, dxSkinsCore, dxSkinsDefaultPainters, cxCheckBox,
  cxLookAndFeels, cxGroupBox;

type
  TmntPaiForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyScreen: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    PaisTable: TnxeTable;
    DataSource: TDataSource;
    NombreTextEdit: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    PaisTableCodigo: TWideStringField;
    PaisTableNombre: TWideStringField;
    PaisTableCodigoISO2: TWideStringField;
    CodigoISO2Ctrl: TcxDBTextEdit;
    PaisTableIntracomunitario: TBooleanField;
    IntracomunitarioCtrl: TcxDBCheckBox;
    codigoCtrlCaption: TcxLabel;
    Label2: TcxLabel;
    Label1: TcxLabel;
    CodigoISO3Ctrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    PaisTableCodigoISO3: TWideStringField;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;

  private
  public
  end;

var
  mntPaiForm: TmntPaiForm = nil;

procedure MntPaises( keyValues : array of const );

implementation

{$R *.dfm}

uses   Gdm00Frm,

       b_msg,

       cx_pai,

       l_pai;

procedure MntPaises( KeyValues : array of const );
begin
     CreateEditForm( TMntPaiForm, MntPaiForm, KeyValues );
end;

procedure TmntPaiForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender, qgsLinked );
end;

procedure TmntPaiForm.FormManagerInitializeForm;
begin
     PaisTableCodigoISO2.ValidChars := [ 'A'..'Z', 'a'..'z' ];
     PaisTableCodigoISO3.ValidChars := [ 'A'..'Z', 'a'..'z' ];
end;

procedure TmntPaiForm.FormManagerReportRequest;
begin
     ListadoPaises;
end;

end.
