unit a_tcc;

interface

uses StdCtrls, Buttons, Mask, Controls,
  Classes, ExtCtrls, Forms, Tabs,

  AppContainer,

  ComCtrls,
  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxmdaset, cxCurrencyEdit,

  Gim30Fields, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxNavigator, dxDateRanges,
  AppForms, GridTableViewController, dxScrollbarAnnotations, dxUIAClasses;

type
  TMntTccForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoProveedorCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    TarifaClaseTable: TnxeTable;
    CodigoClaseACtrl: TcxDBTextEdit;
    CodigoClaseBCtrl: TcxDBTextEdit;
    CodigoArticuloCtrl: TcxDBTextEdit;
    TarifaClaseQuery: TnxeQuery;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    TarifaDataSource: TDataSource;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoProveedor: TWideStringField;
    DataCodigoArticulo: TWideStringField;
    DataCodigoClaseA: TWideStringField;
    DataCodigoClaseB: TWideStringField;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewPrecio: TcxGridDBColumn;
    GridViewDescuento: TcxGridDBColumn;
    TarifaClaseCachedDataset: TnxeCachedDataSet;
    Label2: TcxLabel;
    DescCodigoProveedorLabel: TcxLabel;
    CapClaseALabel: TcxLabel;
    CapClaseBLabel: TcxLabel;
    DescClaseALabel: TcxLabel;
    DescClaseBLabel: TcxLabel;
    Label4: TcxLabel;
    DescArticuloLabel: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    TarifaClaseCachedDatasetNroClase: TSmallintField;
    TarifaClaseCachedDatasetCodigo: TWideStringField;
    TarifaClaseCachedDatasetDescripcion: TWideStringField;
    TarifaClaseCachedDatasetPeso: TBCDField;
    TarifaClaseCachedDatasetCapacidad: TBCDField;
    TarifaClaseCachedDatasetTipo: TSmallintField;
    TarifaClaseCachedDatasetPrecio: TFloatField;
    TarifaClaseCachedDatasetDescuento: TBCDField;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    procedure FormManagerFocusedAreaChanged;
    function FormManagerGetAccessLevel: SmallInt;
    procedure CodigoProveedorCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoArticuloCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoClaseACtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseACtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoClaseBCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseBCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TarifaClaseCachedDatasetBeforePost(DataSet: TDataSet);
    procedure TarifaClaseCachedDatasetBeforeEdit(DataSet: TDataSet);
    procedure CodigoClaseACtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoClaseBCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
  private

  public

    TarifaClaseFields : TTarifaClaseFields;

    ExisteTarifa : Boolean;
    NroClaseActiva : SmallInt;

  end;

var
  MntTccForm: TMntTccForm = nil;

procedure MntTarifasClaseCompras;

implementation

{$R *.DFM}

uses   sysUtils,

       Gdm00Dm,
       Gim00Fields,
       Gim10Fields,
       Gdm30Frm,

       dmi_art,

       b_msg,

       dm_art,
       dm_pro,
       dm_cls,

       a_pro,
       a_art,
       a_cls,

       cx_art,
       cx_pro,
       cx_cls1,

       l_tcc;

resourceString
    rsMsg1 = 'Todos los proveedores.';

procedure MntTarifasClaseCompras;
begin
     CreateEditForm( TMntTccForm, MntTccForm, [], TGds30Frm.ComprasSection );
end;

procedure TMntTccForm.FormManagerInitializeForm;
begin
     TarifaClaseFields := TTarifaClaseFields.Create( TarifaClaseTable );

     Clase.SetupEditControl( CodigoClaseACtrl, tcClaseA, 0 );
     Clase.SetupEditControl( CodigoClaseBCtrl, tcClaseB, 0 );

     With DataModule00.DmEmpresaFields do
       begin

       CodigoClaseACtrl.Enabled := Articulo_ExisteClase[ tcClaseB ].Value;
       CodigoClaseBCtrl.Enabled := Articulo_ExisteClase[ tcClaseC ].Value;

       SetColumnDecimals( GridViewPrecio, Compras_DecPrecio.Value );
       SetColumnDecimals( GridViewDescuento, Compras_DecDto.Value );
       end;
end;

procedure TMntTccForm.FormManagerReportRequest;
begin
     ListadoTarifaClaseCompras;
end;

procedure TMntTccForm.TarifaClaseCachedDatasetBeforeEdit(DataSet: TDataSet);
begin
     ExisteTarifa := False;
     With TarifaClaseTable do
       case NroClaseActiva of
         tcClaseA : ExisteTarifa := FindKey( [ rtclComprasProveedor, DataCodigoProveedor.Value, DataCodigoArticulo.Value, TarifaClaseCachedDatasetCodigo.Value, '', '' ] );
         tcClaseB : ExisteTarifa := FindKey( [ rtclComprasProveedor, DataCodigoProveedor.Value, DataCodigoArticulo.Value, DataCodigoClaseA.Value, TarifaClaseCachedDatasetCodigo.Value, '' ] );
         tcClaseC : ExisteTarifa := FindKey( [ rtclComprasProveedor, DataCodigoProveedor.Value, DataCodigoArticulo.Value, DataCodigoClaseA.Value, DataCodigoClaseB.Value, TarifaClaseCachedDatasetCodigo.Value ] );
         end;
end;

procedure TMntTccForm.TarifaClaseCachedDatasetBeforePost(DataSet: TDataSet);
begin
     If   ValueIsEmpty( TarifaClaseCachedDatasetPrecio.Value ) and ValueIsEmpty( TarifaClaseCachedDatasetDescuento.Value )
     then begin
          If   ExisteTarifa
          then TarifaClaseTable.Delete;
          end
     else With TarifaClaseFields do
            begin

            With TarifaClaseTable do
              If   ExisteTarifa
              then Edit
              else Append;

            Seccion.Value := rtclComprasProveedor;
            CodigoPropietario.Value := DataCodigoProveedor.Value;
            CodigoArticulo.Value := DataCodigoArticulo.Value;

            case NroClaseActiva of
              tcClaseA : begin
                         ClaseA.Value := TarifaClaseCachedDatasetCodigo.Value;
                         ClaseB.Value := '';
                         ClaseC.Value := '';
                         end;
              tcClaseB : begin
                         ClaseA.Value := DataCodigoClaseA.Value;
                         ClaseB.Value := TarifaClaseCachedDatasetCodigo.Value;
                         ClaseC.Value := '';
                         end;
              tcClaseC : begin
                         ClaseA.Value := DataCodigoClaseA.Value;
                         ClaseB.Value := DataCodigoClaseB.Value;
                         ClaseC.Value := TarifaClaseCachedDatasetCodigo.Value;
                         end;
              end;

            Precio.Value := TarifaClaseCachedDatasetPrecio.Value;
            Descuento.Value := TarifaClaseCachedDatasetDescuento.Value;

            TarifaClaseTable.Post;
            end;
end;

procedure TMntTccForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntTccForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scCompras, False, Sender );
end;

procedure TMntTccForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTccForm.CodigoClaseACtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ tcClaseA, Sender.EditingValue ] );
end;

procedure TMntTccForm.CodigoClaseACtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( tcClaseA, Sender );
end;

procedure TMntTccForm.CodigoClaseACtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseA, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTccForm.CodigoClaseBCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ tcClaseB, Sender.EditingValue ] );
end;

procedure TMntTccForm.CodigoClaseBCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( tcClaseB, Sender );
end;

procedure TMntTccForm.CodigoClaseBCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseB, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTccForm.CodigoProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TMntTccForm.CodigoProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TMntTccForm.CodigoProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then CodigoProveedorCtrl.Description := RsMsg1
     else Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTccForm.FormManagerFocusedAreaChanged;
begin
     If   FormManager.DataAreaFocused
     then begin

          If   ValueIsEmpty( DataCodigoClaseA.Value )
          then NroClaseActiva := tcClaseA
          else If   ValueIsEmpty( DataCodigoClaseB.Value )
               then NroClaseActiva := tcClaseB
               else NroClaseActiva := tcClaseC;

          With TarifaClaseCachedDataset do
            begin
            Close;
            With TarifaClaseQuery do
              case NroClaseActiva of
                tcClaseA : SQL.Text := SQLFormat( 'SELECT Clase.*, TarifaClase.Precio, TarifaClase.Descuento FROM Clase LEFT JOIN TarifaClase  ON ( Seccion=0 AND CodigoPropietario=%s AND CodigoArticulo=%s AND TarifaClase.ClaseA=Clase.Codigo AND TarifaClase.ClaseB=' + rsEmptyQuotes + ' AND TarifaClase.ClaseC=' + rsEmptyQuotes + ' ) WHERE NroClase=1 ORDER BY Codigo', [ DataCodigoProveedor, DataCodigoArticulo ] );
                tcClaseB : SQL.Text := SQLFormat( 'SELECT Clase.*, TarifaClase.Precio, TarifaClase.Descuento FROM Clase LEFT JOIN TarifaClase  ON ( Seccion=0 AND CodigoPropietario=%s AND CodigoArticulo=%s AND TarifaClase.ClaseA=%s AND TarifaClase.ClaseB=Clase.Codigo AND TarifaClase.ClaseC=' + rsEmptyQuotes + ' ) WHERE NroClase=2 ORDER BY Codigo', [ DataCodigoProveedor, DataCodigoArticulo, DataCodigoClaseA ] );
                tcClaseC : SQL.Text := SQLFormat( 'SELECT Clase.*, TarifaClase.Precio, TarifaClase.Descuento FROM Clase LEFT JOIN TarifaClase  ON ( Seccion=0 AND CodigoPropietario=%s AND CodigoArticulo=%s AND TarifaClase.ClaseA=%s AND TarifaClase.ClaseB=%s ' + 'AND TarifaClase.ClaseC=Clase.Codigo ) WHERE NroClase=3 ORDER BY Codigo', [ DataCodigoProveedor, DataCodigoArticulo, DataCodigoClaseA, DataCodigoClaseB ] );
                end;
            Open;
            end;

          end;
end;

function TMntTccForm.FormManagerGetAccessLevel: SmallInt;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ acCOFicheros.Value, acCOTarifas.Value ] );
end;

end.
