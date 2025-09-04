unit a_fam;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxDBData, cxCurrencyEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  cxPC, dxSkinsCore, dxSkinscxPCPainter,

  Gim30Fields, cxLookAndFeels, dxSkinsDefaultPainters, cxLabel, cxGroupBox,
  cxNavigator, dxDateRanges, AppForms, GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations, dxUIAClasses;

type
  TMntFamForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    FamiliaTable: TnxeTable;
    FamiliaDataSource: TDataSource;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    TarifaData: TDataSource;
    TarifaCachedDataset: TnxeCachedDataSet;
    TarifaCachedDatasetCodigo: TWideStringField;
    TarifaCachedDatasetDescripcion: TWideStringField;
    TarifaCachedDatasetTipo: TSmallintField;
    TarifaCachedDatasetCodigoTarifa: TWideStringField;
    TarifaCachedDatasetCodigoArticulo: TWideStringField;
    TarifaCachedDatasetReferencia: TWideStringField;
    TarifaCachedDatasetRecargo: TBCDField;
    TarifaCachedDatasetDescuento: TBCDField;
    TarifaQuery: TnxeQuery;
    TarifaQueryCodigo: TWideStringField;
    TarifaQueryDescripcion: TWideStringField;
    TarifaQueryTipo: TSmallintField;
    TarifaQueryCodigoTarifa: TWideStringField;
    TarifaQueryCodigoArticulo: TWideStringField;
    TarifaQueryReferencia: TWideStringField;
    TarifaQueryRecargo: TBCDField;
    TarifaQueryDescuento: TBCDField;
    TarifaVentasTable: TnxeTable;
    codigoCtrlCaption: TcxLabel;
    DescripcionCtrl: TcxDBTextEdit;
    Label1: TcxLabel;
    TarifasPanel: TcxGroupBox;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    TableViewCodigo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewDescuento: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    GridTableViewController: TGridTableViewController;
    Panel1: TcxGroupBox;
    cxLabel1: TcxLabel;
    TarifaQueryPrecio: TFloatField;
    TarifaCachedDatasetPrecio: TFloatField;
    cxGroupBox1: TcxGroupBox;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure TarifaCachedDatasetBeforePost(DataSet: TDataSet);
    procedure TarifaQueryAfterOpen(DataSet: TDataSet);
    procedure FormManagerInitializeForm;
  private
    TarifaVentasFields : TTarifaVentasFields;
    FamiliaFields : TFamiliaFields;
    ExisteTarifaVenta : Boolean;
  public

  end;

var  MntFamForm: TMntFamForm = nil;

procedure MntFamilias( KeyValues : array of const );

implementation

{$R *.dfm}

uses   EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dm_fam,
       dm_art,

       cx_fam,

       l_fam;

procedure MntFamilias( KeyValues : array of const );
begin
     CreateEditForm( TMntFamForm, MntFamForm, KeyValues, TGds30Frm.AlmacenSection );
end;

procedure TMntFamForm.FormManagerReportRequest;
begin
     ListadoFamilias;
end;

procedure TMntFamForm.TarifaCachedDatasetBeforePost(DataSet: TDataSet);
begin
     With TarifaVentasTable, TarifaVentasFields do
       begin
       If   not FindKey( [ FamiliaFields.Codigo.Value, rtvTarifaFamilia, TarifaCachedDatasetCodigo.Value ] )
       then begin
            Append;
            Tipo.Value := rtvTarifaFamilia;
            CodigoTarifa.Value := TarifaCachedDatasetCodigo.Value;
            CodigoArticulo.Value := FamiliaFields.Codigo.Value;
            end
       else Edit;
       Precio.Value := TarifaCachedDatasetPrecio.Value;
       Recargo.Value := TarifaCachedDatasetRecargo.Value;
       Descuento .Value := TarifaCachedDatasetDescuento.Value;
       Post;
       end;
end;

procedure TMntFamForm.TarifaQueryAfterOpen(DataSet: TDataSet);
begin
     With TarifaCachedDataset do
       begin
       Close;
       Open;
       end;
end;

procedure TMntFamForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender, qgsLinked );
end;

function TMntFamForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.acALFicheros.Value;
end;

procedure TMntFamForm.FormManagerInitializeForm;
begin
     FamiliaFields := TFamiliaFields.Create( FamiliaTable );
     TarifaVentasFields := TTarifaVentasFields.Create( TarifaVentasTable );

     // Tarifas

     With DataModule00.DmEmpresaFields do
       If   not Cliente_TarCodigo.Value
       then begin
            TarifasPanel.Visible := False;
            Height := 160;
            Width := 380;
            end
       else SetColumnDecimals( TableViewDescuento, Ventas_DecDto.Value );
end;

end.

