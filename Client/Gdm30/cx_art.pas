
unit cx_art;

interface

uses Forms, AppForms, Classes, Controls, Grids, Graphics,

  AppContainer,
  EnterpriseDataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, cxCurrencyEdit,

  cxImage, cxRichEdit, DataManager, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels,
  cxLookAndFeelPainters, QueryForm, cxContainer, cxGroupBox, cxNavigator, dxDateRanges,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxScrollbarAnnotations, cxCheckBox,

  Gim10Fields,
  Gim30Fields, dxUIAClasses;

type
  TcxArtForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryDescripcion: TWideStringField;
    QueryPrecio_Compra: TFloatField;
    QueryPrecioVentaIVA: TBCDField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewPrecio_Compra: TcxGridDBColumn;
    TableViewPrecio_Venta: TcxGridDBColumn;
    QueryTipoIVA: TSmallintField;
    QueryObsoleto: TBooleanField;
    TableViewObsoleto: TcxGridDBColumn;
    TableViewAnotacion: TcxGridDBColumn;
    QueryAnotacion: TWideMemoField;
    QueryImagen: TGraphicField;
    TableViewImagen: TcxGridDBColumn;
    TableViewTipoIVA: TcxGridDBColumn;
    QueryCampoLibre1: TWideStringField;
    QueryCampoLibre2: TWideStringField;
    QueryCampoLibre3: TWideStringField;
    QueryCampoLibre4: TWideStringField;
    TableViewCampoLibre1: TcxGridDBColumn;
    TableViewCampoLibre2: TcxGridDBColumn;
    TableViewCampoLibre3: TcxGridDBColumn;
    TableViewCampoLibre4: TcxGridDBColumn;
    TableViewUnidadesPorCaja: TcxGridDBColumn;
    QueryUnidadesPorCaja: TBCDField;
    QueryCodigoBarras: TWideStringField;
    TableViewCodigoBarras: TcxGridDBColumn;
    QueryFamilia: TWideStringField;
    TableViewFamilia: TcxGridDBColumn;
    QueryPrecio_Venta: TFloatField;
    QueryCodigoProveedor: TWideStringField;
    QueryCampoLibre9: TBooleanField;
    TableViewCodigoProveedor: TcxGridDBColumn;
    TableViewCampoLibre9: TcxGridDBColumn;
    QueryCampoLibre10: TIntegerField;
    TableViewCampoLibre10: TcxGridDBColumn;
    ArticuloTable: TnxeTable;
    ArticuloTableCodigo: TWideStringField;
    ArticuloTableDescripcion: TWideStringField;
    ArticuloTableCodigoBarras: TWideStringField;
    ArticuloTableCodigoProveedor: TWideStringField;
    ArticuloTableFamilia: TWideStringField;
    ArticuloTablePrecio_Venta: TFloatField;
    ArticuloTablePrecio_Compra: TFloatField;
    ArticuloTableTipoIVA: TSmallintField;
    ArticuloTablePrecioVentaIVA: TBCDField;
    ArticuloTableObsoleto: TBooleanField;
    ArticuloTableCampoLibre1: TWideStringField;
    ArticuloTableCampoLibre2: TWideStringField;
    ArticuloTableCampoLibre3: TWideStringField;
    ArticuloTableCampoLibre4: TWideStringField;
    ArticuloTableCampoLibre9: TBooleanField;
    ArticuloTableCampoLibre10: TIntegerField;
    ArticuloTableUnidadesPorCaja: TBCDField;
    ArticuloTableAnotacion: TWideMemoField;
    ArticuloTableImagen: TGraphicField;
    ArticuloTablePrecioCompraIVA: TBCDField;
    QueryPrecioCompraIVA: TBCDField;
    TableViewPrecioCompraIVA: TcxGridDBColumn;
    TableViewPrecioVentaIVA: TcxGridDBColumn;
    ArticuloTableVisibleTienda: TBooleanField;
    TableViewVisibleTienda: TcxGridDBColumn;
    QueryVisibleTienda: TBooleanField;
    QueryCampoLibre5: TBCDField;
    QueryCampoLibre6: TBCDField;
    QueryCampoLibre7: TBCDField;
    QueryCampoLibre8: TBCDField;
    TableViewCampoLibre5: TcxGridDBColumn;
    TableViewCampoLibre6: TcxGridDBColumn;
    TableViewCampoLibre7: TcxGridDBColumn;
    TableViewCampoLibre8: TcxGridDBColumn;
    QueryCampoLibre11: TIntegerField;
    QueryCampoLibre12: TIntegerField;
    QueryCampoLibre13: TWideStringField;
    QueryCampoLibre14: TWideStringField;
    QueryCampoLibre15: TWideMemoField;
    QueryCampoLibre16: TWideMemoField;
    TableViewCampoLibre11: TcxGridDBColumn;
    TableViewCampoLibre12: TcxGridDBColumn;
    TableViewCampoLibre13: TcxGridDBColumn;
    TableViewCampoLibre14: TcxGridDBColumn;
    TableViewCampoLibre15: TcxGridDBColumn;
    TableViewCampoLibre16: TcxGridDBColumn;
    ArticuloTableCampoLibre5: TBCDField;
    ArticuloTableCampoLibre6: TBCDField;
    ArticuloTableCampoLibre7: TBCDField;
    ArticuloTableCampoLibre8: TBCDField;
    ArticuloTableCampoLibre11: TIntegerField;
    ArticuloTableCampoLibre12: TIntegerField;
    ArticuloTableCampoLibre13: TWideStringField;
    ArticuloTableCampoLibre14: TWideStringField;
    ArticuloTableCampoLibre15: TWideMemoField;
    ArticuloTableCampoLibre16: TWideMemoField;
    QueryMargenComercial: TBCDField;
    TableViewMargenComercial: TcxGridDBColumn;
    ArticuloTableMargenComercial: TBCDField;
    QueryUnidadesPorPallet: TBCDField;
    TableViewUnidadesPorPallet: TcxGridDBColumn;
    ArticuloTableUnidadesPorPallet: TBCDField;
    procedure TableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure QueryPanelColumnsSetup;
    procedure QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
    procedure QueryPanelUserSelection;
    procedure QueryPanelSQLSetup;
    procedure ArticuloTableFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure ArticuloTableCalcFields(DataSet: TDataSet);
  private
    ImagenVisible,
    AnotacionVisible : Boolean;
    TiposIVAFields : TTiposIVAFields;
    CampoLibreColumnArray : array of TcxGridDBColumn;
  public
    class var Seccion : TSeccionComercial;
    class var IncluirObsoletos : Boolean;
  end;

var  cxArtForm : TcxArtForm = nil;

procedure ConsultaArticulos( Seccion          : TSeccionComercial;
                             IncluirObsoletos : Boolean;
                             Edit             : TcxCustomEdit;
                             InitialState : TQueryGridInitialState = qgsNormal );

implementation

uses SysUtils,
     LibUtils,
     Variants,
     AppManager,

     Gdm00Dm,
     Gim00Fields,

     b_msg,

     a_art,

     dm_iva;

{$R *.dfm}

resourceString
    RsMsg1  = 'Hay que cerrar la ventana para aplicar los cambios.';
    RsMsg2  = 'Vuelva a pulsar [F4] para acceder a la ventana de consulta.';

procedure ConsultaArticulos( Seccion          : TSeccionComercial;
                             IncluirObsoletos : Boolean;
                             Edit             : TcxCustomEdit;
                             InitialState : TQueryGridInitialState = qgsNormal );
begin
     TcxArtForm.Seccion := Seccion;
     TcxArtForm.IncluirObsoletos := IncluirObsoletos;
     CreateQueryForm( TcxArtForm, cxArtForm, Edit, InitialState );
end;

procedure TcxArtForm.ArticuloTableFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
     Accept := IncluirObsoletos or not ArticuloTableObsoleto.Value;
end;

procedure TcxArtForm.FormCreate(Sender: TObject);

var   DecCantidad : SmallInt;

procedure SetupCampoLibre( CampoLibre : TWideStringField;
                           Column     : TcxGridDBColumn );
begin
     Column.VisibleForCustomization := DataModule00.DmEmpresaFields.Articulo_CamposLibres.Value and ( CampoLibre.Value<>'' );
     If   Column.VisibleForCustomization
     then Column.Caption := CampoLibre.Value;
end;

begin

     TiposIVAFields := TTiposIVAFields.Create( Self );

     With DataModule00.DmEmpresaFields do
       begin

       TableViewPrecio_Venta.Visible := Seccion=scVentas;
       TableViewPrecio_Compra.Visible := ( Seccion=scCompras ) and not DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value;
       TableViewPrecio_Compra.VisibleForCustomization := not DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value;
       TableViewPrecioCompraIVA.Visible := ( Seccion=scCompras ) and not DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value;
       TableViewPrecioCompraIVA.VisibleForCustomization := not DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value;

       If   Seccion=scCompras
       then DecCantidad := Compras_DecCantidad.Value
       else DecCantidad := Ventas_DecCantidad.Value;

       SetColumnsDecimals( [ TableViewUnidadesPorCaja, TableViewUnidadesPorPallet ], DecCantidad );
       SetColumnsDecimals( [ TableViewPrecio_Compra ], Compras_DecPrecio.Value );
       SetColumnsDecimals( [ TableViewPrecio_Venta ], Ventas_DecPrecio.Value );
       SetColumnsDecimals( [ TableViewPrecioCompraIVA, TableViewPrecioVentaIVA ] );
       SetColumnDecimals( TableViewMargencomercial, 2 );

       CampoLibreColumnArray := [ TableViewCampoLibre1,  TableViewCampoLibre2,  TableViewCampoLibre3,  TableViewCampoLibre4,
                                  TableViewCampoLibre5,  TableViewCampoLibre6,  TableViewCampoLibre7,  TableViewCampoLibre8,
                                  TableViewCampoLibre9,  TableViewCampoLibre10, TableViewCampoLibre11, TableViewCampoLibre12,
                                  TableViewCampoLibre13, TableViewCampoLibre14, TableViewCampoLibre15, TableViewCampoLibre16 ];

       With DataModule00.DmEmpresaFields do
         For var Index : SmallInt := 1 to High( Articulo_CampoLibre ) do
           SetupCampoLibre( Articulo_CampoLibre[  Index ], CampoLibreColumnArray[ Index - 1 ] );

       end;

       SetColumnsDecimals( [ TableViewCampoLibre5, TableViewCampoLibre6, TableViewCampoLibre7, TableViewCampoLibre8 ], 4 );

end;

procedure TcxArtForm.ArticuloTableCalcFields(DataSet: TDataSet);
begin
     If   TableViewPrecioCompraIVA.Visible or
          TableViewPrecioVentaIVA.Visible
     then Tasa.TipoIVA( ApplicationContainer.TodayDate, ArticuloTableTipoIVA.Value, TiposIVAFields );
     
     If   TableViewPrecioCompraIVA.Visible 
     then ArticuloTablePrecioCompraIVA.Value := ArticuloTablePrecio_Compra.Value + ( ( ArticuloTablePrecio_Compra.Value * TiposIVAFields.IVASoportado.Value ) / 100.0 );

     If   TableViewPrecioVentaIVA.Visible 
     then ArticuloTablePrecioVentaIVA.Value := ArticuloTablePrecio_Venta.Value  + ( ( ArticuloTablePrecio_Venta.Value  * TiposIVAFields.IVARepercutido.Value ) / 100.0 );

end;

procedure TcxArtForm.QueryCalcFields(DataSet: TDataSet);
begin
     If   TableViewPrecioCompraIVA.Visible or
          TableViewPrecioVentaIVA.Visible 
     then Tasa.TipoIVA( ApplicationContainer.TodayDate, QueryTipoIVA.Value, TiposIVAFields );

     If   TableViewPrecioCompraIVA.Visible 
     then QueryPrecioCompraIVA.Value := QueryPrecio_Compra.Value + ( ( QueryPrecio_Compra.Value * TiposIVAFields.IVASoportado.Value ) / 100.0 );
     
     If   TableViewPrecioVentaIVA.Visible 
     then QueryPrecioVentaIVA.Value := QueryPrecio_Venta.Value  + ( ( QueryPrecio_Venta.Value  * TiposIVAFields.IVARepercutido.Value ) / 100.0 );
          
end;

procedure TcxArtForm.QueryPanelColumnsSetup;
begin
     With TableViewDescripcion do
       If   TableViewImagen.Visible
       then Width := 200
       else Width := 300;
end;

procedure TcxArtForm.QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
begin
     If   ( AnotacionVisible<>TableView.Preview.Visible ) or ( ImagenVisible<>TableViewImagen.Visible )
     then begin
          ShowNotification( ntInformation, RsMsg1, RsMsg2 );
          QueryPanel.SaveQueryState;
          Release;
          Abort;
          end
     else If   TableView.DataController.DataSet.Active
          then TableView.DataController.RefreshExternalData;  // Sobre todo por TableViewPrecioIVA
end;

procedure TcxArtForm.QueryPanelSQLSetup;

var  SQLText : String;

begin

     SQLText := 'SELECT Codigo, Descripcion, CodigoBarras, CodigoProveedor, Familia, Precio_Compra, Precio_Venta, TipoIVA, ' +
                '       Obsoleto, UnidadesPorCaja, UnidadesPorPallet, VisibleTienda, MargenComercial ';

     For var Column : TcxGridDBColumn in CampoLibreColumnArray do
       StrAdd( SQLText, ',' + Column.DataBinding.FieldName );

     // Un intento de minimizar la carga de la consulta

     AnotacionVisible := TableView.Preview.Visible;
     If   AnotacionVisible
     then StrAdd( SQLText, ', Anotacion' )
     else FreeAndNil( QueryAnotacion );

     ImagenVisible := TableViewImagen.Visible;
     If   ImagenVisible
     then StrAdd( SQLText, ', Imagen' )
     else FreeAndNil( QueryImagen );

     StrAdd( SQLText, ' FROM Articulo ' );
     If   not IncluirObsoletos
     then StrAdd( SQLText, ' WHERE NOT Obsoleto ' );
     StrAdd( SQLText, ' ORDER BY Codigo' );

     Query.SQL.Text := SQLText;
end;

procedure TcxArtForm.QueryPanelUserSelection;
begin
     MntArticulos( [ QueryCodigo.Value ] );
end;

procedure TcxArtForm.TableViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     If   not AViewInfo.Selected
     then If   IncluirObsoletos and VarToBoolean( AViewInfo.GridRecord.Values[ TableViewObsoleto.Index ] )
          then ACanvas.Font.Color := clGray;
end;

end.


