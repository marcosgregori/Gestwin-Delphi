unit a_dcf;

interface

uses
    Grids, StdCtrls, Buttons, Mask, Controls, Forms,
    Classes, ExtCtrls, Menus, cxLookAndFeelPainters, cxButtons,
    cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxStyles,
    cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, DB, cxDBData,
    cxGridLevel, cxGridCustomTableView, cxGridTableView, cxClasses,
    cxGridCustomView, cxGridDBTableView, cxGrid, nxdb, DataManager,
    cxCurrencyEdit, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters,
    dxSkinscxPCPainter, cxLabel, cxGroupBox, cxNavigator, dxDateRanges,

    AppContainer,
    AppForms,
    GridTableViewController, dxScrollbarAnnotations;

type
  TMntDcfForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyScreen: TgxEditPanel;
    SubcuentaCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridTableView1: TcxGridTableView;
    GridTableView1Column1: TcxGridColumn;
    GridTableView1Column2: TcxGridColumn;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    BancoTable: TnxeTable;
    BancoDataSource: TDataSource;
    BancoTableSubcuenta: TWideStringField;
    BancoTableNombre: TWideStringField;
    DisponibilidadDataSource: TDataSource;
    DisponibilidadTable: TnxeTable;
    DisponibilidadTableCodigo: TWideStringField;
    DisponibilidadTableNroRegistro: TSmallintField;
    DisponibilidadTableSubcuenta: TWideStringField;
    DisponibilidadTableLimite: TBCDField;
    GridViewSubcuenta: TcxGridDBColumn;
    GridViewLimite: TcxGridDBColumn;
    DisponibilidadTableDescripcion: TWideStringField;
    GridViewDescripcion: TcxGridDBColumn;
    codigoCtrlCaption: TcxLabel;
    DescripcionLabel: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewSubcuentaPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewSubcuentaPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewSubcuentaPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewSubcuentaPropertiesEnter(Sender: TcxCustomEdit);
    procedure DisponibilidadTableCalcFields(DataSet: TDataSet);
    procedure SubcuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SubcuentaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);

  private

  public

  end;

var
  MntDcfForm: TMntDcfForm = nil;

procedure MntDisponibilidad( KeyValues : array of const );

implementation

{$R *.dfm}

uses   EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm10Frm,

       dm_sub,
       dm_ban,
       
       b_msg,

       a_sub,
       a_ban,

       cx_sub,
       cx_ban,

       l_dcf;

procedure MntDisponibilidad( KeyValues : array of const );
begin
     CreateEditForm( TMntDcfForm, MntDcfForm, KeyValues, TGds10Frm.CobrosPagosSection );
end;

procedure TMntDcfForm.FormManagerInitializeForm;
begin
     SetColumnDecimals( GridViewLimite );
end;

procedure TMntDcfForm.GridViewSubcuentaPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntDcfForm.GridViewSubcuentaPropertiesEnter(Sender: TcxCustomEdit);
begin
     With GridViewSubcuenta do
       If   ValueIsEmpty( EditValue )
       then EditValue := '57';
end;

procedure TMntDcfForm.GridViewSubcuentaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True );
end;

procedure TMntDcfForm.GridViewSubcuentaPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntDcfForm.SubcuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntBancos( [ Sender.EditingValue ] );
end;

procedure TMntDcfForm.SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaBancos( Sender, qgsLinked );
end;

procedure TMntDcfForm.SubcuentaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Banco.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntDcfForm.FormManagerReportRequest;
begin
     ListadoDisponibilidad;
end;

function TMntDcfForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.acPCFicheros.Value;
end;

procedure TMntDcfForm.DisponibilidadTableCalcFields(DataSet: TDataSet);
begin
     DisponibilidadTableDescripcion.value := Cuenta.Descripcion( DisponibilidadTableSubcuenta.value, False, False );
end;

end.
