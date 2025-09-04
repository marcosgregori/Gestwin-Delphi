unit a_enf;

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
  cxLookAndFeels, cxGroupBox,

  Gim00Fields;

type
  TMntEnfForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyScreen: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    EntidadFinancieraTable: TnxeTable;
    DataSource: TDataSource;
    NombreTextEdit: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    codigoCtrlCaption: TcxLabel;
    Label2: TcxLabel;
    Label1: TcxLabel;
    BICCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    SucursalCtrl: TcxDBTextEdit;
    cxLabel2: TcxLabel;
    LocalidadCtrl: TcxDBTextEdit;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;

  private
     EntidadFinancieraFields : TEntidadFinancieraFields;
  public
  end;

var MntEnfForm: TMntEnfForm = nil;

procedure MntEntidadesFinancieras( keyValues : array of const );

implementation

{$R *.dfm}

uses   Gdm00Frm,

       b_msg,

       cx_enf,

       l_enf;

procedure MntEntidadesFinancieras( KeyValues : array of const );
begin
     CreateEditForm( TMntEnfForm, MntEnfForm, KeyValues );
end;

procedure TMntEnfForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEntidadesFinancieras( Sender, qgsLinked );
end;

procedure TMntEnfForm.FormManagerInitializeForm;
begin
     EntidadFinancieraFields := TEntidadFinancieraFields.Create( EntidadFinancieraTable );
     EntidadFinancieraFields.BIC.ValidChars := [ 'A'..'Z', '0'..'9' ];
end;

procedure TMntEnfForm.FormManagerReportRequest;
begin
     ListadoEntidadesFinancieras;
end;

end.
