unit a_rut;

interface

uses Grids, StdCtrls, Buttons, Mask, Controls, Forms,
     Classes, ExtCtrls,

     AppContainer,
     ComCtrls,
     Tabs, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,
  cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, DB, nxdb,
  DataManager, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  cxCurrencyEdit, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxNavigator, dxDateRanges,
  AppForms, GridTableViewController, dxScrollbarAnnotations, dxUIAClasses;

type
  TMntRutForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    Panel1: TcxGroupBox;
    DescripcionCtrl: TcxDBTextEdit;
    GridTableViewController: TGridTableViewController;
    RutaTable: TnxeTable;
    RutaDataSource: TDataSource;
    LineaRutaTable: TnxeTable;
    LineaRutaDataSource: TDataSource;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    RutaTableCodigo: TWideStringField;
    RutaTableDescripcion: TWideStringField;
    LineaRutaTableCodigoRuta: TWideStringField;
    LineaRutaTableCodigoCliente: TWideStringField;
    GridViewCodigoCliente: TcxGridDBColumn;
    GridViewNombre: TcxGridDBColumn;
    LineaRutaTableNombre: TWideStringField;
    LineaRutaTableNroOrden: TSmallintField;
    capCodigoLabel: TcxLabel;
    descCodigoLabel: TcxLabel;
    descProcesoLabel: TcxLabel;
    Label1: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure RutaTableUpdateState(DataSet: TDataSet);
    procedure LineaRutaTableCalcFields(DataSet: TDataSet);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoClientePropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoClientePropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoClientePropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);

  private
  public

  end;

var MntRutForm: TMntRutForm = nil;

procedure MntRutas( keyValues : array of const );

implementation

{$R *.DFM}

uses   Windows,
       SysUtils,
       Variants,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gim10Fields,
       Gim30Fields,
       Gdm30Frm,

       dm_rut,
       dm_cli,

       b_msg,

       a_cli,

       cx_rut,
       cx_cli,

       l_rut;

resourceString
    RsMsg1  = '';

procedure MntRutas( KeyValues : array of const );
begin
     CreateEditForm( TMntRutForm, MntRutForm, KeyValues, TGds30Frm.VentasSection );
end;

procedure TMntRutForm.FormManagerReportRequest;
begin
     ListadoRutas;
end;

procedure TMntRutForm.GridViewCodigoClientePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TMntRutForm.GridViewCodigoClientePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TMntRutForm.GridViewCodigoClientePropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntRutForm.LineaRutaTableCalcFields(DataSet: TDataSet);
begin
     LineaRutaTableNombre.Value := Cliente.Descripcion( LineaRutaTableCodigoCliente.Value, False );
end;

procedure TMntRutForm.RutaTableUpdateState(DataSet: TDataSet);
begin
     LineaRutaDataSource.Enabled := RutaTable.State<>dsSetKey;
end;

procedure TMntRutForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRutas( Sender, qgsLinked );
end;

function TMntRutForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.AcVEFicheros.Value;
end;

procedure TMntRutForm.FormManagerInitializeForm;
begin
     SetFieldRange( LineaRutaTableNroOrden );
end;

end.
