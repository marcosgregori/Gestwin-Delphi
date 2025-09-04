unit a_rgc;

interface

uses Grids, StdCtrls, Buttons, Mask, Controls,
  Classes, ExtCtrls, Forms, Tabs,

  AppContainer,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, nxdb,
  DataManager, cxTextEdit, cxLookAndFeels, cxContainer,
  dxSkinsCore, dxSkinscxPCPainter, cxGroupBox, dxSkinsDefaultPainters,
  cxNavigator, dxDateRanges, AppForms, GridTableViewController,
  dxScrollbarAnnotations, dxUIAClasses;

type
  TMntRgcForm = class(TgxForm)
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    GrupoClienteTable: TnxeTable;
    FamiliaDataSource: TDataSource;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewCtaVentas: TcxGridDBColumn;
    GridViewCtaDevVentas: TcxGridDBColumn;
    TableViewManager: TGridTableViewController;
    GrupoClienteTableCodigo: TWideStringField;
    GrupoClienteTableDescripcion: TWideStringField;
    GrupoClienteTableCtaVentas: TWideStringField;
    GrupoClienteTableCtaDevVentas: TWideStringField;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure GridViewCuentaPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCtaVentasPropertiesEnter(Sender: TcxCustomEdit);
    procedure GridViewCtaDevVentasPropertiesEnter(Sender: TcxCustomEdit);
    procedure GridViewCuentaPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewSubcuentaPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private

  public

  end;

var  MntRgcForm: TMntRgcForm = nil;

procedure MntRelacionesGruposClientes;

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

       l_rgc;


procedure MntRelacionesGruposClientes;
begin
     CreateEditForm( TMntRgcForm, MntRgcForm, [], TGds30Frm.VentasSection );
end;

procedure TMntRgcForm.FormManagerReportRequest;
begin
     ListadoRelacionesGruposCliente;
end;

procedure TMntRgcForm.GridViewCuentaPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntRgcForm.GridViewCtaVentasPropertiesEnter(Sender: TcxCustomEdit);
begin
      With GridViewCtaVentas do
       If   ValueIsEmpty( EditValue )
       then EditValue := '700';
end;

procedure TMntRgcForm.GridViewSubcuentaPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntRgcForm.GridViewCtaDevVentasPropertiesEnter(Sender: TcxCustomEdit);
begin
     With GridViewCtaDevVentas do
       If   ValueIsEmpty( EditValue )
       then EditValue := '708';
end;

procedure TMntRgcForm.GridViewCuentaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True, True );  // Sin extractos
end;

function TMntRgcForm.FormManagerGetAccessLevel: SmallInt;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ acVEFicheros.Value, acVERelaciones.Value ] );
end;

end.
