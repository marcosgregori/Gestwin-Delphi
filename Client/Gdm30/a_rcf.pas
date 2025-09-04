unit a_rcf;

interface

uses Grids, StdCtrls, Buttons, Mask, Controls,
  Classes, ExtCtrls, Forms, Tabs,

  AppContainer,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, nxdb,
  DataManager, cxTextEdit, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  cxContainer, cxGroupBox, dxSkinsDefaultPainters, cxNavigator, dxDateRanges,
  AppForms, GridTableViewController, dxScrollbarAnnotations, dxUIAClasses;

type
  TMntRcfForm = class(TgxForm)
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    FamiliaTable: TnxeTable;
    FamiliaDataSource: TDataSource;
    FamiliaTableCodigo: TWideStringField;
    FamiliaTableDescripcion: TWideStringField;
    FamiliaTableCta_Compras: TWideStringField;
    FamiliaTableCta_DevCompras: TWideStringField;
    FamiliaTableCta_Ventas: TWideStringField;
    FamiliaTableCta_DevVentas: TWideStringField;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewCta_Compras: TcxGridDBColumn;
    GridViewCta_DevCompras: TcxGridDBColumn;
    TableViewManager: TGridTableViewController;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure GridViewCuentaPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCta_ComprasPropertiesEnter(Sender: TcxCustomEdit);
    procedure GridViewCta_DevComprasPropertiesEnter(Sender: TcxCustomEdit);
    procedure GridViewCuentaPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewSubcuentaPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private

  public

  end;

var  MntRcfForm: TMntRcfForm = nil;

procedure MntRelacionesFamiliasCompras;

implementation

{$R *.DFM}

uses   SysUtils,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       b_msg,

       dm_sub,

       a_sub,

       cx_sub,

       l_rcf;


procedure MntRelacionesFamiliasCompras;
begin
     CreateEditForm( TMntRcfForm, MntRcfForm, [], TGds30Frm.ComprasSection );
end;

procedure TMntRcfForm.FormManagerReportRequest;
begin
     ListadoRelacionesFamiliasCompras;
end;

procedure TMntRcfForm.GridViewCuentaPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntRcfForm.GridViewCta_ComprasPropertiesEnter(Sender: TcxCustomEdit);
begin
      With GridViewCta_Compras do
       If   ValueIsEmpty( EditValue )
       then EditValue := '600';
end;

procedure TMntRcfForm.GridViewSubcuentaPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntRcfForm.GridViewCta_DevComprasPropertiesEnter(Sender: TcxCustomEdit);
begin
     With GridViewCta_DevCompras do
       If   ValueIsEmpty( EditValue )
       then EditValue := '608';
end;

procedure TMntRcfForm.GridViewCuentaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True, True );  // Sin extractos
end;

function TMntRcfForm.FormManagerGetAccessLevel: SmallInt;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ acCOFicheros.Value, acCORelaciones.Value ] );
end;

end.
