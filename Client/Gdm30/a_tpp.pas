unit a_tpp;

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

  Gim30Fields, cxCheckBox, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLabel, cxGroupBox, cxNavigator, dxDateRanges,

  AppForms,
  GridTableViewController, dxScrollbarAnnotations, dxUIAClasses;

type
  TMntTppForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoProveedorCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    TarifaComprasTable: TnxeTable;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    TarifaComprasQuery: TnxeQuery;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    TarifaDataSource: TDataSource;
    Data: TgxMemData;
    DataSource: TDataSource;
    TarifaComprasCachedDataset: TnxeCachedDataSet;
    Panel1: TcxGroupBox;
    ArticuloInicialCtrl: TcxDBTextEdit;
    gxRangeBox1: TgxRangeBox;
    ArticuloFinalCtrl: TcxDBTextEdit;
    SoloTarifaCtrl: TcxDBCheckBox;
    ProveedorTable: TnxeTable;
    ProveedorTableCodigo: TWideStringField;
    ProveedorTableNombre: TWideStringField;
    ProveedorDataSource: TDataSource;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    DataSoloTarifa: TBooleanField;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewReferencia: TcxGridDBColumn;
    GridViewPrecio: TcxGridDBColumn;
    GridViewDescuento: TcxGridDBColumn;
    TarifaComprasAuxTable: TnxeTable;
    Label2: TcxLabel;
    DescCodigoProveedorLabel: TcxLabel;
    claseActivaLabel: TcxLabel;
    Label4: TcxLabel;
    Label1: TcxLabel;
    Label3: TcxLabel;
    TarifaComprasCachedDatasetCodigo: TWideStringField;
    TarifaComprasCachedDatasetDescripcion: TWideStringField;
    TarifaComprasCachedDatasetReferencia: TWideStringField;
    TarifaComprasCachedDatasetDescuento: TBCDField;
    TarifaComprasCachedDatasetPrecio: TFloatField;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
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
    procedure TarifaComprasCachedDatasetBeforePost(DataSet: TDataSet);
    procedure TarifaComprasCachedDatasetBeforeEdit(DataSet: TDataSet);
    function FormManagerCopyCurrentRecord: Boolean;
    procedure ProveedorTableGetRecord(DataSet: TDataSet);
    procedure ProveedorTableAfterScroll(DataSet: TDataSet);
    procedure SoloTarifaCtrlPropertiesChange(Sender: TObject);
    procedure RangeValuePosted(Sender: TObject);
  private

  public

    TarifaComprasFields,
    TarifaComprasAuxFields : TTarifaComprasFields;

    ExisteTarifa : Boolean;
    SQLString : String;
    FProveedorTableChanged : Boolean;

    procedure UpdateQuery;
    procedure DoCopiaTarifa;
  end;

var
  MntTppForm: TMntTppForm = nil;

procedure MntTarifasProveedor( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       b_msg,
       b_ctp,

       dm_art,
       dm_pro,

       a_pro,
       a_art,

       cx_art,
       cx_pro,

       l_tpp;

procedure MntTarifasProveedor( KeyValues : array of const );
begin
     CreateEditForm( TMntTppForm, MntTppForm, KeyValues, TGds30Frm.ComprasSection );
end;

procedure TMntTppForm.FormManagerInitializeForm;
begin
     TarifaComprasFields := TTarifaComprasFields.Create( TarifaComprasTable );
     TarifaComprasAuxFields := TTarifaComprasFields.Create( TarifaComprasAuxTable );

     With DataModule00.DmEmpresaFields do
       begin
       SetColumnDecimals( GridViewPrecio, Compras_DecPrecio.Value );
       SetColumnDecimals( GridViewDescuento, Compras_DecDto.Value );
       end;

     SQLString := TarifaComprasQuery.SQL.Text;

     With Data do
       begin
       Open;
       Append;
       end;

     DataArticuloFinal.Value := HighStrCode;
     DataSoloTarifa.Value := True;
end;

procedure TMntTppForm.FormManagerReportRequest;
begin
     ListadoTarifaCompras;
end;

procedure TMntTppForm.ProveedorTableAfterScroll(DataSet: TDataSet);
begin
     UpdateQuery;
end;

procedure TMntTppForm.ProveedorTableGetRecord(DataSet: TDataSet);
begin
     FProveedorTableChanged := True;
     DataSoloTarifa.Value := True;
end;

procedure TMntTppForm.SoloTarifaCtrlPropertiesChange(Sender: TObject);
begin
     UpdateQuery;
end;

procedure TMntTppForm.TarifaComprasCachedDatasetBeforeEdit(DataSet: TDataSet);
begin
     ExisteTarifa := TarifaComprasTable.FindKey( [ rtcProveedorArticulo, ProveedorTableCodigo.Value, TarifaComprasCachedDatasetCodigo.Value ] );
end;

procedure TMntTppForm.TarifaComprasCachedDatasetBeforePost(DataSet: TDataSet);
begin
     If   ValueIsEmpty( TarifaComprasCachedDatasetReferencia.Value ) and
          ValueIsEmpty( TarifaComprasCachedDatasetPrecio.Value ) and
          ValueIsEmpty( TarifaComprasCachedDatasetDescuento.Value )
     then begin
          If   ExisteTarifa
          then TarifaComprasTable.Delete;
          end
     else With TarifaComprasFields do
            begin

            With TarifaComprasTable do
              If   ExisteTarifa
              then Edit
              else Append;

            Tipo.Value := rtcProveedorArticulo;
            CodigoProveedor.Value := ProveedorTableCodigo.Value;
            CodigoArticulo.Value := TarifaComprasCachedDatasetCodigo.Value;
            Referencia.Value := TarifaComprasCachedDatasetReferencia.Value;
            Precio.Value := TarifaComprasCachedDatasetPrecio.Value;
            Descuento.Value := TarifaComprasCachedDatasetDescuento.Value;

            TarifaComprasTable.Post;
            end;
end;

procedure TMntTppForm.RangeValuePosted(Sender: TObject);
begin
     UpdateQuery;
end;

procedure TMntTppForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntTppForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scCompras, False, Sender );
end;

procedure TMntTppForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TMntTppForm.CodigoProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TMntTppForm.CodigoProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TMntTppForm.CodigoProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

function TMntTppForm.FormManagerCopyCurrentRecord: Boolean;
begin
     CopiaTarifaProveedor( ProveedorTableCodigo.Value, DoCopiaTarifa );
     Result := False;
end;

function TMntTppForm.FormManagerGetAccessLevel: SmallInt;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ acCOFicheros.Value, acCOTarifas.Value ] );
end;

procedure TMntTppForm.UpdateQuery;

const TodosLosArticulosQuery = 'SELECT Articulos.Codigo, Articulos.Descripcion, TarifaCompras.Referencia, TarifaCompras.Precio, TarifaCompras.Descuento ' +
                               'FROM ( SELECT Articulo.Codigo, Articulo.Descripcion ' +
                               '       FROM Articulo ' +
                               '       WHERE Articulo.Codigo BETWEEN :ArticuloInicial AND :ArticuloFinal AND NOT Articulo.Obsoleto ' +
                               '       ORDER BY Codigo ) AS Articulos ' +
                               'LEFT JOIN TarifaCompras ON ( TarifaCompras.Tipo=0 AND TarifaCompras.CodigoProveedor=:CodigoProveedor AND Articulos.Codigo=TarifaCompras.CodigoArticulo )';

      ArticulosConTarifaQuery = 'SELECT Articulo.Codigo, Articulo.Descripcion, TarifaCompras.Referencia, TarifaCompras.Precio, TarifaCompras.Descuento ' +
                                'FROM   TarifaCompras ' +
                                'LEFT JOIN Articulo ON ( Articulo.Codigo=TarifaCompras.CodigoArticulo ) ' +
                                'WHERE  TarifaCompras.Tipo=0 AND TarifaCompras.CodigoProveedor=:CodigoProveedor AND TarifaCompras.CodigoArticulo BETWEEN :ArticuloInicial AND :ArticuloFinal';

begin
     With TarifaComprasCachedDataset do
       If   FormManager.FormInitialized and ( FProveedorTableChanged or Data.Modified )
       then begin
            Close;

            With TarifaComprasQuery do
              begin

              If   SoloTarifaCtrl.Checked
              then SQL.Text := ArticulosConTarifaQuery
              else SQL.Text := TodosLosArticulosQuery;

              Params.ParamByName( 'CodigoProveedor' ).Value := ProveedorTableCodigo.Value;
              Params.ParamByName( 'ArticuloInicial' ).Value := DataArticuloInicial.Value;
              Params.ParamByName( 'ArticuloFinal' ).Value := DataArticuloFinal.Value;

              end;

            Open;

            Data.Modified := False;
            FProveedorTableChanged := False;
            end;
end;


procedure TMntTppForm.DoCopiaTarifa;

var  CodigoProveedorDestino : String;

begin

     With EnterpriseDataModule do
       begin

       try

         StartTransaction( [ TarifaComprasAuxTable ] );

         CodigoProveedorDestino := BoxCtpForm.DataCodigoProveedor.Value;

         With TarifaComprasTable do
           begin
           SetRange( [ rtcProveedorArticulo, ProveedorTableCodigo.Value, '' ], [ rtcProveedorArticulo, ProveedorTableCodigo.Value, HighStrCode ] );
           First;
           While not Eof do
             begin

             If   not ( not BoxCtpForm.DataCopiarReferencias.Value and
                        ValueIsEmpty( TarifaComprasFields.Precio.Value ) and
                        ValueIsEmpty( TarifaComprasFields.Descuento.Value ) )
             then If   not TarifaComprasAuxTable.FindKey( [ rtcProveedorArticulo, CodigoProveedorDestino, TarifaComprasFields.CodigoArticulo ] )
                  then begin

                       TarifaComprasAuxTable.Append;
                       TarifaComprasAuxTable.CopyFields( TarifaComprasTable );

                       TarifaComprasAuxFields.CodigoProveedor.Value := CodigoProveedorDestino;
                       If   not BoxCtpForm.DataCopiarReferencias.Value
                       then TarifaComprasAuxFields.Referencia.Value := '';

                       TarifaComprasAuxTable.Post;
                       end;

             Next;
             end;

           end;

         Commit;

       except
         RollBack;
         ShowNotification( ntStop, RsgMsg428, RsgMsg437 );
         end;

       ProveedorTable.FindKey( [ CodigoProveedorDestino ] );
       FormManager.SelectFirstKeyControl;

       end;

end;

end.

