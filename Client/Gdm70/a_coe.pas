unit a_coe;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Grids, Menus, cxLookAndFeelPainters, cxGraphics, DB, nxdb,
  DataManager, cxMaskEdit, cxDropDownEdit, cxDBEdit, cxIndexedComboBox,
  cxCurrencyEdit, cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxLookAndFeels, dxSkinsCore, cxLabel, cxGroupBox, dxSkinsDefaultPainters,

  cxSpinEdit, cxDurationEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,

  LibUtils,
  Gim70Fields, dxDateRanges, AppForms, GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations, dxUIAClasses;

type
  TMntCoeForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoSubcontratistaCtrl: TcxDBTextEdit;
    CosteOperacExternasTable: TnxeTable;
    dataPanel: TgxEditPanel;
    CosteOperacExternasDataSource: TDataSource;
    SubcontratistaCtrlCaption: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    CosteOperacExternasGridTable: TnxeTable;
    CosteOperacExternasGridDataSource: TDataSource;
    CosteOperacExternasGridTableCodigoSubcontratista: TWideStringField;
    CosteOperacExternasGridTableCodigoOperacion: TWideStringField;
    CosteOperacExternasGridTableNroRegistro: TSmallintField;
    CosteOperacExternasGridTableCodigoArticulo: TWideStringField;
    CosteOperacExternasGridTableCodigoClaseA: TWideStringField;
    CosteOperacExternasGridTableCodigoClaseB: TWideStringField;
    CosteOperacExternasGridTableCodigoClaseC: TWideStringField;
    CosteOperacExternasGridTableCosteUnitario: TBCDField;
    CodigoOperacionCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    DescOperacionLabel: TcxLabel;
    DescSubcontratistaLabel: TcxLabel;
    CosteOperacExternasGridTableDescripcion: TWideStringField;
    TarifasPanel: TcxGroupBox;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    TableViewCodigoArticulo: TcxGridDBColumn;
    TableViewCodigoClaseA: TcxGridDBColumn;
    TableViewCodigoClaseB: TcxGridDBColumn;
    TableViewCodigoClaseC: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewCosteUnitario: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    GridTableViewController: TGridTableViewController;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure CosteOperacExternasTableNewRecord(DataSet: TDataSet);
    procedure CosteOperacExternasTableUpdateState(DataSet: TDataSet);
    procedure CosteOperacExternasGridTableCalcFields(DataSet: TDataSet);
    procedure CodigoSubcontratistaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TableViewCodigoArticuloPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TableViewCodigoArticuloPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure TableViewCodigoArticuloPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure TableViewCodigoClaseAPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure TableViewCodigoClaseBPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure TableViewCodigoClaseCPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure TableViewCodigoClasePropertiesEditRequest(Sender: TcxCustomEdit);
    procedure TableViewCodigoClasePropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoOperacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoOperacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoOperacionCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoSubcontratistaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoSubcontratistaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CosteOperacExternasGridTableApplyMasterRange(DataSet: TDataSet);
  private
    CosteOperacExternasFields : TCosteOperacExternasFields;

  public
  end;

var
  MntCoeForm: TMntCoeForm = nil;

procedure MntCosteOperacExternas( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Gdm70Dm,
       Gdm70Frm,

       Gim30Fields,

       b_msg,

       dm_pro,
       dm_opc,
       dm_art,
       dm_cls,
       dm_tur,

       a_pro,
       a_art,
       a_opc,
       a_cls,
       a_opt,
       a_tur,

       cx_pro,
       cx_opc,
       cx_art,
       cx_cls1,
       cx_tur;

       {
       l_coe;
       }

procedure MntCosteOperacExternas( KeyValues : array of const );
begin
     CreateEditForm( TMntCoeForm, MntCoeForm, KeyValues, Gds70Frm.ProduccionSection );
end;

procedure TMntCoeForm.CodigoOperacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntOperaciones( [ Sender.EditingValue ] );
end;

procedure TMntCoeForm.CodigoOperacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOperaciones( topExterna, Sender );
end;

procedure TMntCoeForm.CodigoOperacionCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Operacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCoeForm.CodigoSubcontratistaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TMntCoeForm.CodigoSubcontratistaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TMntCoeForm.CodigoSubcontratistaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCoeForm.CosteOperacExternasGridTableApplyMasterRange(DataSet: TDataSet);
begin
     // CodigoSubcontratista;CodigoOperacion;NroRegistro
     If   CosteOperacExternasGridTable.Active
     then With CosteOperacExternasFields do
            CosteOperacExternasGridTable.SetRange( [ CodigoSubcontratista.Value, CodigoOperacion, 1 ],
                                                   [ CodigoSubcontratista.Value, CodigoOperacion, MaxSmallint ] );
end;

procedure TMntCoeForm.CosteOperacExternasGridTableCalcFields(DataSet: TDataSet);
begin
     CosteOperacExternasGridTableDescripcion.Value := Articulo.Descripcion( CosteOperacExternasGridTableCodigoArticulo.Value, False );
end;

procedure TMntCoeForm.FormManagerInitializeForm;
begin
     CosteOperacExternasFields := TCosteOperacExternasFields.Create( CosteOperacExternasTable );

     CosteOperacExternasTable.SetDefaultRangeValues( [ '', '', 0 ], [ HighStrCode, HighStrCode, 0 ] );

     SetFieldRange( CosteOperacExternasGridTableNroRegistro );

     Clase.SetupGridColumns( TableViewCodigoClaseA, TableViewCodigoClaseB, TableViewCodigoClaseC, 4 );
     SetColumnDecimals( TableViewCosteUnitario );
end;

procedure TMntCoeForm.FormManagerReportRequest;
begin
     // ListadoCosteOperacExternas;
end;

procedure TMntCoeForm.TableViewCodigoArticuloPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntCoeForm.TableViewCodigoArticuloPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TMntCoeForm.TableViewCodigoArticuloPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCoeForm.TableViewCodigoClasePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( TableView.Controller.FocusedColumn.Tag ), Sender.EditingValue ] );
end;

procedure TMntCoeForm.TableViewCodigoClasePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( TNroClase( TableView.Controller.FocusedColumn.Tag ), Sender );
end;

procedure TMntCoeForm.TableViewCodigoClaseAPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     // Hay una validación distinta para cada clase porque durante la validación del registro completo (Post) no hay FocusedColumn

     Clase.Valida( tcClaseA, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCoeForm.TableViewCodigoClaseBPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseB, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCoeForm.TableViewCodigoClaseCPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseC, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCoeForm.CosteOperacExternasTableNewRecord(DataSet: TDataSet);
begin
     //..
end;

procedure TMntCoeForm.CosteOperacExternasTableUpdateState(DataSet: TDataSet);
begin
     CosteOperacExternasGridDataSource.Enabled := CosteOperacExternasTable.State<>dsSetKey;
end;

end.
