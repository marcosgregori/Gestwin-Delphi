
unit cx_arr;

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

  cxImage, cxRichEdit, DataManager, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels,
  cxLookAndFeelPainters, QueryForm, cxContainer, cxGroupBox, cxNavigator,

  Gim10Fields,
  Gim30Fields, dxDateRanges,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations;

type
  TcxArrForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryDescripcion: TWideStringField;
    QueryPrecioIVA: TBCDField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewPrecio_Venta: TcxGridDBColumn;
    TableViewPrecioIVA: TcxGridDBColumn;
    QueryTipoIVA: TSmallintField;
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
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure QueryPanelColumnsSetup;
    procedure QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
    procedure QueryPanelUserSelection;
    procedure QueryPanelSQLSetup;
  private
    ImagenVisible,
    AnotacionVisible : Boolean;
    TiposIVAFields : TTiposIVAFields;
  public
    class var 
      CodigoArticulo : String;
      Tipo : SmallInt;
      
  end;

var  cxArrForm : TcxArrForm = nil;

procedure ConsultaArticulosRelacionados( Tipo   : SmallInt;
                                         Edit   : TcxCustomEdit;
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
    RsMsg3  = 'Consulta de artículos relacionados';
    RsMsg4  = 'Consulta de artículos alternativos o equivalentes';
        
procedure ConsultaArticulosRelacionados( Tipo   : SmallInt;    // 0 = Relacionados, 1 = Equivalentes o alternativos
                                         Edit   : TcxCustomEdit;
                                         InitialState : TQueryGridInitialState = qgsNormal );
begin
     TcxArrForm.CodigoArticulo := Edit.EditingValue;
     TcxArrForm.Tipo := Tipo;
     CreateQueryForm( TcxArrForm, cxArrForm, Edit, InitialState );
end;

procedure TcxArrForm.FormCreate(Sender: TObject);

var  DecCantidad : SmallInt;

begin

     If   Tipo=0
     then Caption := RsMsg3
     else Caption := RsMsg4;
     
     TiposIVAFields := TTiposIVAFields.Create( Self );

     With DataModule00.DmEmpresaFields do
       begin
           
       DecCantidad := Ventas_DecCantidad.Value;

       SetColumnDecimals( TableViewUnidadesPorCaja, DecCantidad );       
       SetColumnDecimals( TableViewPrecio_Venta, Ventas_DecPrecio.Value );
       SetColumnDecimals( TableViewPrecioIVA, Ventas_DecPrecio.Value );

       If   Articulo_CamposLibres.Value
       then begin
            If   Articulo_CampoLibre[ 1 ].Value<>''
            then TableViewCampoLibre1.Caption := Articulo_CampoLibre[ 1 ].Value;
            If   Articulo_CampoLibre[ 2 ].Value<>''
            then TableViewCampoLibre2.Caption := Articulo_CampoLibre[ 2 ].Value;
            If   Articulo_CampoLibre[ 3 ].Value<>''
            then TableViewCampoLibre3.Caption := Articulo_CampoLibre[ 3 ].Value;
            If   Articulo_CampoLibre[ 4 ].Value<>''
            then TableViewCampoLibre4.Caption := Articulo_CampoLibre[ 4 ].Value;
            //..
            If   Articulo_CampoLibre[ 9 ].Value<>''
            then TableViewCampoLibre9.Caption := Articulo_CampoLibre[ 9 ].Value;
            If   Articulo_CampoLibre[ 10 ].Value<>''
            then TableViewCampoLibre10.Caption := Articulo_CampoLibre[ 10 ].Value;
            end
       else begin
            QueryCampoLibre1.Visible := False;
            QueryCampoLibre2.Visible := False;
            QueryCampoLibre3.Visible := False;
            QueryCampoLibre4.Visible := False;
            QueryCampoLibre9.Visible := False;
            QueryCampoLibre10.Visible := False;
            end;

       end;
end;

procedure TcxArrForm.QueryCalcFields(DataSet: TDataSet);
begin
     If   TableViewPrecioIVA.Visible
     then begin
          Tasa.TipoIVA( ApplicationContainer.TodayDate, QueryTipoIVA.Value, TiposIVAFields );
          QueryPrecioIVA.Value := QueryPrecio_Venta.Value  + ( ( QueryPrecio_Venta.Value  * TiposIVAFields.IVARepercutido.Value ) / 100.0 );
          end;
end;

procedure TcxArrForm.QueryPanelColumnsSetup;
begin
     With TableViewDescripcion do
       If   TableViewImagen.Visible
       then Width := 200
       else Width := 300;
end;

procedure TcxArrForm.QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
begin
     If   ( AnotacionVisible<>TableView.Preview.Visible ) or ( ImagenVisible<>TableViewImagen.Visible )
     then begin
          ShowNotification( ntInformation, RsMsg1, RsMsg2 );
          QueryPanel.SaveQueryState;
          Release;
          Abort;
          end
     else TableView.DataController.RefreshExternalData;  // Sobre todo por TableViewPrecioIVA
end;

procedure TcxArrForm.QueryPanelSQLSetup;

var  SQLText : String;

begin

     SQLText := 'SELECT Articulo.Codigo, Articulo.Descripcion, Articulo.CodigoBarras, Articulo.Familia, Articulo.CodigoProveedor, Articulo.Precio_Venta, Articulo.TipoIVA, Articulo.CampoLibre1, ' +
                'Articulo.CampoLibre2, Articulo.CampoLibre3, Articulo.CampoLibre4, Articulo.CampoLibre9, Articulo.CampoLibre10, Articulo.UnidadesPorCaja '; 

     // Un intento de minimizar la carga de la consulta

     AnotacionVisible := TableView.Preview.Visible;
     If   AnotacionVisible
     then StrAdd( SQLText, ', Articulo.Anotacion' )
     else FreeAndNil( QueryAnotacion );

     ImagenVisible := TableViewImagen.Visible;
     If   ImagenVisible
     then StrAdd( SQLText, ', Articulo.Imagen' )
     else FreeAndNil( QueryImagen );

     StrAdd( SQLText, ' FROM  ArticulosRelacionados, Articulo ' );
     StrAdd( SQLText, ' WHERE ArticulosRelacionados.CodigoArticuloRelacionado=Articulo.Codigo AND NOT Articulo.Obsoleto AND ArticulosRelacionados.Tipo=' + IntToStr( Tipo ) + ' AND ArticulosRelacionados.Codigo= ' + QuotedStr( CodigoArticulo ) + ' ' );
     StrAdd( SQLText, ' ORDER BY Articulo.Codigo' );

     Query.SQL.Text := SQLText;
     
end;

procedure TcxArrForm.QueryPanelUserSelection;
begin
     MntArticulos( [ QueryCodigo.Value ] );
end;

end.


