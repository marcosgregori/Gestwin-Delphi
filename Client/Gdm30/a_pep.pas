
unit a_pep;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, Grids,
  Mask, ComCtrls, Menus,

  cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxTextEdit, cxDBEdit, cxControls, cxContainer, cxEdit, cxCheckBox,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxIndexedComboBox, cxCheckComboBox, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLookAndFeels, cxLabel, cxGroupBox, cxNavigator,
  dxDateRanges, AppForms, GridTableViewController, dxScrollbarAnnotations,

  AppContainer,

  Gim00Fields,
  Gim10Fields, cxMaskEdit, cxDropDownEdit, cxImageComboBox, dxUIAClasses;


type
    TMntPepForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    PlantillaGraficoTable: TnxeTable;
    LineaPlantillaGraficoTable: TnxeTable;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    keyPanel: TgxEditPanel;
    NroOperacionCtrl: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    DescripcionCtrl: TcxDBTextEdit;
    TableViewManager: TGridTableViewController;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    PlantillaGraficoDataSource: TDataSource;
    LineaPlantillaGraficoDataSource: TDataSource;
    GridViewEjercicio: TcxGridDBColumn;
    GridViewCodigo1: TcxGridDBColumn;
    GridViewOperacion1: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    LineaPlantillaGraficoTableTipo: TSmallintField;
    LineaPlantillaGraficoTableNroOperacion: TIntegerField;
    LineaPlantillaGraficoTableNroRegistro: TSmallintField;
    LineaPlantillaGraficoTableDescripcion: TWideStringField;
    LineaPlantillaGraficoTableEjercicio: TSmallintField;
    LineaPlantillaGraficoTableCodigo1: TWideStringField;
    LineaPlantillaGraficoTableCodigo2: TWideStringField;
    LineaPlantillaGraficoTableCodigo3: TWideStringField;
    LineaPlantillaGraficoTableCodigo4: TWideStringField;
    LineaPlantillaGraficoTableCodigo5: TWideStringField;
    LineaPlantillaGraficoTableCodigo6: TWideStringField;
    LineaPlantillaGraficoTableCodigo7: TWideStringField;
    LineaPlantillaGraficoTableCodigo8: TWideStringField;
    LineaPlantillaGraficoTableOperacion1: TSmallintField;
    LineaPlantillaGraficoTableOperacion2: TSmallintField;
    LineaPlantillaGraficoTableOperacion3: TSmallintField;
    LineaPlantillaGraficoTableOpcion1: TBooleanField;
    LineaPlantillaGraficoTableOpcion2: TBooleanField;
    LineaPlantillaGraficoTableOpcion3: TBooleanField;
    LineaPlantillaGraficoTableGrafico: TWideMemoField;
    Label11: TcxLabel;
    Label1: TcxLabel;
    TipoCtrl: TcxDBImageComboBox;
    cxLabel1: TcxLabel;
    procedure InitializeForm;
    procedure PlantillaGraficoTableSetKey(DataSet: TDataSet);
    procedure GridViewCodigo1PropertiesEditRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigo1PropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigo1PropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroOperacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure LineaPlantillaGraficoTableNewRecord(DataSet: TDataSet);
    procedure PlantillaGraficoTableUpdateState(DataSet: TDataSet);
    procedure LineaPlantillaGraficoTableApplyMasterRange(DataSet: TDataSet);
    procedure GridViewCodigo1PropertiesValuePosted(Sender: TObject);

    private

    public
      PlantillaGraficoFields : TPlantillaGraficoFields;
    end;

var  MntPepForm : TMntPepForm = nil;

procedure MantenimientoPlantillaProveedor( KeyValues : array of const );


implementation

uses   AppForm,

       EnterpriseDataAccess,

       Gdm30Frm,

       dm_pga,
       dm_pro,
       dm_plg,

       b_msg,

       a_pro,

       cx_pro,
       cx_plg;

{$R *.dfm}

procedure MantenimientoPlantillaProveedor( KeyValues : array of const );
begin
     CreateEditForm( TMntPepForm, MntPepForm, KeyValues, TGds30Frm.ResultadosSection );
end;

procedure TMntPepForm.InitializeForm;
begin
     PlantillaGraficoFields := TPlantillaGraficoFields.Create( PlantillaGraficoTable );

     SetFieldRange( PlantillaGraficoFields.NroOperacion );
     SetFieldRange( LineaPlantillaGraficoTableNroRegistro );

     TipoCtrl.Properties.Images := ApplicationContainer.DiagramImageList;

     PlantillaGraficoTable.SetDefaultRangeValues( [ Ord( pgProveedor ), 1, 0 ], [ Ord( pgProveedor ), PlantillaGraficoFields.NroOperacion.MaxValue, 0 ] );
end;

procedure TMntPepForm.LineaPlantillaGraficoTableApplyMasterRange(DataSet: TDataSet);
begin
     // Tipo;NroOperacion;NroRegistro
     If   LineaPlantillaGraficoTable.Active
     then With PlantillaGraficoFields do
            LineaPlantillaGraficoTable.SetRange( [ Ord( pgProveedor ), NroOperacion.Value, 1 ], [ Ord( pgProveedor ), NroOperacion.Value, MaxSmallint ] );
end;

procedure TMntPepForm.LineaPlantillaGraficoTableNewRecord(DataSet: TDataSet);
begin
     LineaPlantillaGraficoTableOperacion1.Value := 0;
     LineaPlantillaGraficoTableOpcion1.Value := False;
     LineaPlantillaGraficoTableOpcion2.Value := False;
end;

procedure TMntPepForm.NroOperacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPlantillasGrafico( Sender, pgProveedor, qgsLinked );
end;

procedure TMntPepForm.PlantillaGraficoTableSetKey(DataSet: TDataSet);
begin
     With PlantillaGraficoFields do
       begin
       Tipo.Value := Ord( pgProveedor );
       NroRegistro.Value := 0;
       end;
end;

procedure TMntPepForm.PlantillaGraficoTableUpdateState(DataSet: TDataSet);
begin
     LineaPlantillaGraficoDataSource.Enabled := PlantillaGraficoTable.State<>dsSetKey;
end;

procedure TMntPepForm.GridViewCodigo1PropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TMntPepForm.GridViewCodigo1PropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TMntPepForm.GridViewCodigo1PropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPepForm.GridViewCodigo1PropertiesValuePosted(Sender: TObject);
begin
     LineaPlantillaGraficoTableDescripcion.Value := Proveedor.Descripcion( LineaPlantillaGraficoTableCodigo1.Value, False );
end;

end.
