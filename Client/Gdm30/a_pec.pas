
unit a_pec;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, Grids,
  Mask, ComCtrls,Menus,

  cxLookAndFeelPainters, cxButtons, DB, nxdb,
  cxTextEdit, cxDBEdit, cxControls, cxContainer, cxEdit, cxCheckBox,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxIndexedComboBox, cxCheckComboBox, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLookAndFeels, cxGroupBox, cxLabel, cxNavigator,
  dxDateRanges, GridTableViewController, dxScrollbarAnnotations,

  AppContainer,
  AppForms,
  DataManager,

  Gim00Fields,
  Gim10Fields, cxMaskEdit, cxDropDownEdit, cxImageComboBox, dxUIAClasses;


type
    TMntPecForm = class(TgxForm)
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
    procedure FormManagerInitializeForm;
    procedure GridViewCodigo1PropertiesValuePosted(Sender: TObject);

    private

    public
      PlantillaGraficoFields : TPlantillaGraficoFields;
    end;

var  MntPecForm : TMntPecForm = nil;

procedure MantenimientoPlantillaCliente( KeyValues : array of const );


implementation

uses   AppForm,

       EnterpriseDataAccess,

       Gdm30Frm,

       dm_pga,
       dm_cli,
       dm_plg,

       b_msg,

       a_cli,

       cx_cli,
       cx_plg;

{$R *.dfm}

procedure MantenimientoPlantillaCliente( KeyValues : array of const );
begin
     CreateEditForm( TMntPecForm, MntPecForm, KeyValues, TGds30Frm.ResultadosSection );
end;

procedure TMntPecForm.FormManagerInitializeForm;
begin
     PlantillaGraficoFields := TPlantillaGraficoFields.Create( PlantillaGraficoTable );

     SetFieldRange( PlantillaGraficoFields.NroOperacion );
     SetFieldRange( LineaPlantillaGraficoTableNroRegistro );

     TipoCtrl.Properties.Images := ApplicationContainer.DiagramImageList;

     PlantillaGraficoTable.SetDefaultRangeValues( [ Ord( pgCliente ), 1, 0 ], [ Ord( pgCliente ), PlantillaGraficoFields.NroOperacion.MaxValue, 0 ] );
end;

procedure TMntPecForm.LineaPlantillaGraficoTableApplyMasterRange(DataSet: TDataSet);
begin
     // Tipo;NroOperacion;NroRegistro
     If   LineaPlantillaGraficoTable.Active
     then With PlantillaGraficoFields do
            LineaPlantillaGraficoTable.SetRange( [ Ord( pgCliente ), NroOperacion.Value, 1 ], [ Ord( pgCliente ), NroOperacion.Value, MaxSmallint ] );
end;

procedure TMntPecForm.LineaPlantillaGraficoTableNewRecord(DataSet: TDataSet);
begin
     LineaPlantillaGraficoTableOperacion1.Value := 0;
     LineaPlantillaGraficoTableOpcion1.Value := False;
     LineaPlantillaGraficoTableOpcion2.Value := False;
end;

procedure TMntPecForm.NroOperacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPlantillasGrafico( Sender, pgCliente, qgsLinked );
end;

procedure TMntPecForm.PlantillaGraficoTableSetKey(DataSet: TDataSet);
begin
     With PlantillaGraficoFields do
       begin
       Tipo.Value := Ord( pgCliente );
       NroRegistro.Value := 0;
       end;
end;

procedure TMntPecForm.PlantillaGraficoTableUpdateState(DataSet: TDataSet);
begin
     LineaPlantillaGraficoDataSource.Enabled := PlantillaGraficoTable.State<>dsSetKey;
end;

procedure TMntPecForm.GridViewCodigo1PropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TMntPecForm.GridViewCodigo1PropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TMntPecForm.GridViewCodigo1PropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPecForm.GridViewCodigo1PropertiesValuePosted(Sender: TObject);
begin
     LineaPlantillaGraficoTableDescripcion.Value := Cliente.Descripcion( LineaPlantillaGraficoTableCodigo1.Value, False );
end;

end.

