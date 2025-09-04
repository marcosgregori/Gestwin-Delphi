
unit cx_ubi;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, dxSkinsCore, dxSkinscxPCPainter,
  DataManager, QueryForm, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer,
  dxSkinsDefaultPainters,
  cxGroupBox,
  cxNavigator,

  dm_ubi, dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  TcxUbiForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewCodigo: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    QueryCodigo: TWideStringField;
    QueryDescripcion: TWideStringField;
    QueryCodigoAlmacen: TWideStringField;
    QueryUbicacionDeCarga: TBooleanField;
    TableViewUbicacionDeCarga: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure TableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
  protected
    class var
    CodigoAlmacen : String;
    TipoUbicacion : TTipoUbicacion;
  end;

var  cxUbiForm : TcxUbiForm = nil;

procedure ConsultaUbicaciones( CodigoAlmacen : String;
                               TipoUbicacion : TTipoUbicacion;
                               Edit          : TcxCustomEdit;
                               InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses  Graphics,
      SysUtils,

      LibUtils;

procedure ConsultaUbicaciones( CodigoAlmacen : String;
                               TipoUbicacion : TTipoUbicacion;
                               Edit          : TcxCustomEdit;
                               InitialState : TQueryGridInitialState = qgsNormal );
begin
     TcxUbiForm.CodigoAlmacen := CodigoAlmacen;
     TcxUbiForm.TipoUbicacion := TipoUbicacion;
     CreateQueryForm( TcxUbiForm, cxUbiForm, Edit, InitialState );
end;

procedure TcxUbiForm.FormCreate(Sender: TObject);

var  QueryText : String;

begin

     QueryText := 'SELECT * FROM Ubicacion WHERE CodigoAlmacen=' + QuotedStr( CodigoAlmacen );

     case TipoUbicacion of
       ubNormal  : StrAdd( QueryText, ' AND NOT UbicacionDeCarga ' );
       ubCarga   : StrAdd( QueryText, ' AND UbicacionDeCarga ' );
       ubTodas   : ;
     end;

     StrAdd( QueryText, ' ORDER BY CodigoAlmacen, Codigo' );

     Query.SQL.Text := QueryText;

end;

procedure TcxUbiForm.TableViewCustomDrawCell(      Sender: TcxCustomGridTableView;
                                                   ACanvas: TcxCanvas;
                                                   AViewInfo: TcxGridTableDataCellViewInfo;
                                               var ADone: Boolean);
begin
     If   not AViewInfo.Selected and ( TipoUbicacion<>ubCarga )
     then If   VarToBoolean( AViewInfo.GridRecord.Values[ TableViewUbicacionDeCarga.Index ] )
          then ACanvas.Font.Color := clGray;
end;

end.
