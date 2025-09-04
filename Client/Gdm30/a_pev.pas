
unit a_pev;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, Grids,

  AppContainer,
  Mask,
  ComCtrls,

  Menus,

  cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxTextEdit, cxDBEdit, cxControls, cxContainer, cxEdit, cxCheckBox,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,

  Gim00Fields,
  Gim10Fields,

  cxIndexedComboBox, cxCheckComboBox, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLookAndFeels, cxGroupBox, cxLabel, cxNavigator,
  dxDateRanges, AppForms, GridTableViewController, dxScrollbarAnnotations,
  cxMaskEdit, cxDropDownEdit, cxImageComboBox, System.ImageList,
  Vcl.ImgList, cxImageList, dxUIAClasses;


type
    TMntPevForm = class(TgxForm)
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
    GridViewOpcion1: TcxGridDBColumn;
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

var  MntPevForm : TMntPevForm = nil;

procedure MantenimientoPlantillaVendedor( KeyValues : array of const );


implementation

uses   AppForm,

       EnterpriseDataAccess,

       Gdm30Frm,

       dm_pga,
       dm_ven,
       dm_plg,

       b_msg,

       a_ven,

       cx_ven,
       cx_plg;

{$R *.dfm}

procedure MantenimientoPlantillaVendedor( KeyValues : array of const );
begin
     CreateEditForm( TMntPevForm, MntPevForm, KeyValues, TGds30Frm.ResultadosSection );
end;

procedure TMntPevForm.InitializeForm;
begin
     PlantillaGraficoFields := TPlantillaGraficoFields.Create( PlantillaGraficoTable );

     SetFieldRange( PlantillaGraficoFields.NroOperacion );
     SetFieldRange( LineaPlantillaGraficoTableNroRegistro );

     TipoCtrl.Properties.Images := ApplicationContainer.DiagramImageList;

     PlantillaGraficoTable.SetDefaultRangeValues( [ Ord( pgVendedor ), 1, 0 ], [ Ord( pgVendedor ), PlantillaGraficoFields.NroOperacion.MaxValue, 0 ] );
end;

procedure TMntPevForm.LineaPlantillaGraficoTableApplyMasterRange(DataSet: TDataSet);
begin
     // Tipo;NroOperacion;NroRegistro
     If   LineaPlantillaGraficoTable.Active
     then With PlantillaGraficoFields do
            LineaPlantillaGraficoTable.SetRange( [ Ord( pgVendedor ), NroOperacion.Value, 1 ], [ Ord( pgVendedor ), NroOperacion.Value, MaxSmallint ] );
end;

procedure TMntPevForm.LineaPlantillaGraficoTableNewRecord(DataSet: TDataSet);
begin
     LineaPlantillaGraficoTableOperacion1.Value := 0;
     LineaPlantillaGraficoTableOpcion1.Value := False;
     LineaPlantillaGraficoTableOpcion2.Value := False;
end;

procedure TMntPevForm.NroOperacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPlantillasGrafico( Sender, pgVendedor, qgsLinked );
end;

procedure TMntPevForm.PlantillaGraficoTableSetKey(DataSet: TDataSet);
begin
     With PlantillaGraficoFields do
       begin
       Tipo.Value := Ord( pgVendedor );
       NroRegistro.Value := 0;
       end;
end;

procedure TMntPevForm.PlantillaGraficoTableUpdateState(DataSet: TDataSet);
begin
     LineaPlantillaGraficoDataSource.Enabled := PlantillaGraficoTable.State<>dsSetKey;
end;

procedure TMntPevForm.GridViewCodigo1PropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntVendedores( [ Sender.EditingValue ] );
end;

procedure TMntPevForm.GridViewCodigo1PropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TMntPevForm.GridViewCodigo1PropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPevForm.GridViewCodigo1PropertiesValuePosted(Sender: TObject);
begin
     LineaPlantillaGraficoTableDescripcion.Value := Vendedor.Descripcion( LineaPlantillaGraficoTableCodigo1.Value, False );
end;

end.
