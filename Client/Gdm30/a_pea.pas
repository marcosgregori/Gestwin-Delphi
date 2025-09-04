
unit a_pea;

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

  dm_sal, cxIndexedComboBox, cxDropDownEdit, cxColorComboBox, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, cxLabel,
  cxGroupBox, cxNavigator, dxDateRanges, AppForms, GridTableViewController,
  dxScrollbarAnnotations, cxMaskEdit, cxImageComboBox, dxUIAClasses,
  cxRadioGroup;


type
    TMntPeaForm = class(TgxForm)
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
    GridViewDescripcion: TcxGridDBColumn;
    GridViewEjercicio: TcxGridDBColumn;
    GridViewCodigo1: TcxGridDBColumn;
    GridViewCodigo2: TcxGridDBColumn;
    GridViewOperacion1: TcxGridDBColumn;
    GridViewCodigo3: TcxGridDBColumn;
    GridViewCodigo4: TcxGridDBColumn;
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
    cxLabel1: TcxLabel;
    TipoCtrl: TcxDBImageComboBox;
    GridViewCodigo5: TcxGridDBColumn;
    GridViewCodigo6: TcxGridDBColumn;
    GridViewCodigo7: TcxGridDBColumn;
    GridViewCodigo8: TcxGridDBColumn;
    DatosCtrl: TcxDBRadioGroup;
    cxLabel2: TcxLabel;
    procedure InitializeForm;
    procedure LineaPlantillaGraficoTableCalcFields(DataSet: TDataSet);
    procedure PlantillaGraficoTableSetKey(DataSet: TDataSet);
    procedure GridViewCodigoPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewClasePropertiesEditRequest(Sender: TcxCustomEdit);
    procedure GridViewClasePropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure NroOperacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure LineaPlantillaGraficoTableNewRecord(DataSet: TDataSet);
    procedure PlantillaGraficoTableUpdateState(DataSet: TDataSet);
    procedure GridViewCodigo2PropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewCodigo3PropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewCodigo4PropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure LineaPlantillaGraficoTableApplyMasterRange(DataSet: TDataSet);
    procedure GridViewCodigo1PropertiesValuePosted(Sender: TObject);

    private

    public
      PlantillaGraficoFields : TPlantillaGraficoFields;
    end;

var  MntPeaForm : TMntPeaForm = nil;

procedure MantenimientoPlantillaArticulo( KeyValues : array of const );


implementation

uses   AppForm,

       EnterpriseDataAccess,

       Gim30Fields,
       Gdm30Frm,

       dm_pga,
       dm_art,
       dm_fam,
       dm_cls,
       dm_plg,

       b_msg,

       a_art,
       a_fam,
       a_cls,

       cx_art,
       cx_fam,
       cx_cls1,
       cx_plg;

{$R *.dfm}

procedure MantenimientoPlantillaArticulo( KeyValues : array of const );
begin
     CreateEditForm( TMntPeaForm, MntPeaForm, KeyValues, TGds30Frm.ResultadosSection );
end;

procedure TMntPeaForm.InitializeForm;
begin
     PlantillaGraficoFields := TPlantillaGraficoFields.Create( PlantillaGraficoTable );

     SetFieldRange( PlantillaGraficoFields.NroOperacion );
     SetFieldRange( LineaPlantillaGraficoTableNroRegistro );

     Clase.SetupGridColumns( GridViewCodigo2, GridViewCodigo3, GridViewCodigo4, 4 );

     TipoCtrl.Properties.Images := ApplicationContainer.DiagramImageList;

     PlantillaGraficoTable.SetDefaultRangeValues( [ Ord( pgArticulo ), 1, 0 ], [ Ord( pgArticulo ), PlantillaGraficoFields.NroOperacion.MaxValue, 0 ] );
end;

procedure TMntPeaForm.LineaPlantillaGraficoTableApplyMasterRange(DataSet: TDataSet);
begin
     // Tipo;NroOperacion;NroRegistro
     If   LineaPlantillaGraficoTable.Active
     then With PlantillaGraficoFields do
            LineaPlantillaGraficoTable.SetRange( [ Ord( pgArticulo ), NroOperacion.Value, 1 ], [ Ord( pgArticulo ), NroOperacion.Value, MaxSmallint ] );
end;

procedure TMntPeaForm.LineaPlantillaGraficoTableCalcFields( DataSet: TDataSet);
begin
     {
     If   LineaPlantillaGraficoTableTipo.Value=Ord( pgArticulo )
     then LineaPlantillaGraficoTableDescripcion.Value := Articulo.Descripcion( LineaPlantillaGraficoTableCodigo1.Value, False );
     }
end;

procedure TMntPeaForm.LineaPlantillaGraficoTableNewRecord(DataSet: TDataSet);
begin
     LineaPlantillaGraficoTableOperacion1.Value := 0;
     LineaPlantillaGraficoTableOpcion1.Value := False;
     LineaPlantillaGraficoTableOpcion2.Value := False;
end;

procedure TMntPeaForm.NroOperacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPlantillasGrafico( Sender, pgArticulo, qgsLinked );
end;

procedure TMntPeaForm.PlantillaGraficoTableSetKey(DataSet: TDataSet);
begin
     With PlantillaGraficoFields do
       begin
       Tipo.Value := Ord( pgArticulo );
       NroRegistro.Value := 0;
       end;
end;

procedure TMntPeaForm.PlantillaGraficoTableUpdateState(DataSet: TDataSet);
begin
     LineaPlantillaGraficoDataSource.Enabled := PlantillaGraficoTable.State<>dsSetKey;
end;

procedure TMntPeaForm.GridViewCodigoPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     If   DatosCtrl.EditValue=0
     then MntArticulos( [ Sender.EditingValue ] )
     else MntFamilias( [ Sender.EditingValue ] );
end;

procedure TMntPeaForm.GridViewCodigoPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DatosCtrl.EditValue=0
     then ConsultaArticulos( scAmbas, False, Sender )
     else ConsultaFamilias( Sender );
end;

procedure TMntPeaForm.GridViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   DatosCtrl.EditValue=0
     then Articulo.Valida( Sender, DisplayValue, ErrorText, Error )
     else Familia.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPeaForm.GridViewCodigo1PropertiesValuePosted(Sender: TObject);
begin
      If   LineaPlantillaGraficoTableDescripcion.Value=''
      then If   DatosCtrl.EditValue=0
           then LineaPlantillaGraficoTableDescripcion.Value := Articulo.Descripcion( LineaPlantillaGraficoTableCodigo1.Value, False )
           else LineaPlantillaGraficoTableDescripcion.Value := Familia.Descripcion( LineaPlantillaGraficoTableCodigo1.Value, False );
end;

procedure TMntPeaForm.GridViewCodigo2PropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseA, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPeaForm.GridViewCodigo3PropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseB, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPeaForm.GridViewCodigo4PropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseC, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPeaForm.GridViewClasePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( GridView.Controller.FocusedColumn.Tag ), Sender.EditingValue ] );
end;

procedure TMntPeaForm.GridViewClasePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( TNroClase( GridView.Controller.FocusedColumn.Tag ), Sender );
end;

end.


