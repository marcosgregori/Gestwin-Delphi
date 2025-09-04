unit a_rvf;

interface

uses Grids, StdCtrls, Buttons, Mask, Controls,
  Classes, ExtCtrls, Forms, Tabs,

  AppContainer,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, nxdb,
  DataManager, cxTextEdit, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLookAndFeels, cxContainer, cxGroupBox, cxNavigator, dxDateRanges,
  AppForms, GridTableViewController, dxScrollbarAnnotations, dxUIAClasses;

type
  TMntRvfForm = class(TgxForm)
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
    GridViewCta_Ventas: TcxGridDBColumn;
    GridViewCta_DevVentas: TcxGridDBColumn;
    TableViewManager: TGridTableViewController;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure GridViewCuentaPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCta_VentasPropertiesEnter(Sender: TcxCustomEdit);
    procedure GridViewCta_DevVentasPropertiesEnter(Sender: TcxCustomEdit);
    procedure GridViewCuentaPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewSubcuentaPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private

  public

  end;

var  MntRvfForm: TMntRvfForm = nil;

procedure MntRelacionesFamiliasVentas;

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

       l_rvf;


procedure MntRelacionesFamiliasVentas;
begin
     CreateEditForm( TMntRvfForm, MntRvfForm, [], TGds30Frm.VentasSection );
end;

procedure TMntRvfForm.FormManagerReportRequest;
begin
     ListadoRelacionesFamiliasVentas;
end;

procedure TMntRvfForm.GridViewCuentaPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntRvfForm.GridViewCta_VentasPropertiesEnter(Sender: TcxCustomEdit);
begin
      With GridViewCta_Ventas do
       If   ValueIsEmpty( EditValue )
       then EditValue := '700';
end;

procedure TMntRvfForm.GridViewSubcuentaPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntRvfForm.GridViewCta_DevVentasPropertiesEnter(Sender: TcxCustomEdit);
begin
     With GridViewCta_DevVentas do
       If   ValueIsEmpty( EditValue )
       then EditValue := '708';
end;

procedure TMntRvfForm.GridViewCuentaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True, True );  // Sin extractos
end;

function TMntRvfForm.FormManagerGetAccessLevel: SmallInt;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ acVEFicheros.Value, acVERelaciones.Value ] );
end;

end.
