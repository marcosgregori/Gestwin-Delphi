
unit cx_mco;

interface

uses Forms, AppForms, Classes, Controls,

  LibUtils,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit,

  cxRichEdit, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLookAndFeels, cxLookAndFeelPainters, ImgList,
  cxImageComboBox, QueryForm, cxContainer, cxGroupBox, cxNavigator,

  AppManager,

  dmi_mov, System.ImageList, cxImageList, dxDateRanges,
  dxScrollbarAnnotations;

type
  TCxMcoForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewPropietario: TcxGridDBColumn;
    TableViewSerie: TcxGridDBColumn;
    TableViewNro_Documento: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    TableViewRegistroAuxiliar: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewAuxiliarDescripcion: TcxGridDBColumn;
    QueryEjercicio: TSmallintField;
    QueryTipoMovimiento: TSmallintField;
    QueryNroOperacion: TIntegerField;
    QuerySerie: TWideStringField;
    QueryNroDocumento: TIntegerField;
    QueryFecha: TDateField;
    QueryPropietario: TWideStringField;
    QueryRegistroAuxiliar: TWideStringField;
    QueryNombre: TWideStringField;
    TableViewTextoSituacion: TcxGridDBColumn;
    QuerySituacion: TSmallintField;
    QueryTextoSituacion: TWideStringField;
    QueryAnotacion: TWideMemoField;
    TableViewAnotacion: TcxGridDBColumn;
    QueryTraspasado: TBooleanField;
    QueryFacturado: TBooleanField;
    QueryNoFacturar: TBooleanField;
    QueryRevisado: TBooleanField;
    QueryIndiceImagenSituacion: TSmallintField;
    QueryImporteNeto: TBCDField;
    TableViewImporteNeto: TcxGridDBColumn;
    QuerySerieFactura: TWideStringField;
    TableViewSerieFactura: TcxGridDBColumn;
    DocumentStatesImageList: TcxImageList;
    QueryCampoLibre1: TWideStringField;
    QueryCampoLibre2: TWideStringField;
    TableViewCampoLibre1: TcxGridDBColumn;
    TableViewCampoLibre2: TcxGridDBColumn;
    QueryCampoLibre3: TWideStringField;
    TableViewCampoLibre3: TcxGridDBColumn;
    TableViewEjercicio: TcxGridDBColumn;
    TableViewTipoMovimiento: TcxGridDBColumn;
    TableViewNroOperacion: TcxGridDBColumn;
    TableViewSituacion: TcxGridDBColumn;
    TableViewTraspasado: TcxGridDBColumn;
    TableViewFacturado: TcxGridDBColumn;
    TableViewNoFacturar: TcxGridDBColumn;
    TableViewRevisado: TcxGridDBColumn;
    QueryCampoLibre4: TWideStringField;
    QueryCampoLibre5: TWideStringField;
    TableViewCampoLibre4: TcxGridDBColumn;
    TableViewCampoLibre5: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure QueryFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
    procedure QueryPanelUserSelection;
    procedure QueryPanelAfterReadQueryState;
  private
    ImporteBruto,
    DescuentosArticulos,
    ImporteNeto : Decimal;
  protected
    class var
    TipoMovimiento : TTipoMovimientoCompra;
    Seleccion : TSeleccionDocumento;
    OnUserSelection : TDataEditEvent;
  end;

var  CxMcoForm : array[ tmOferta..tmCompra ] of TCxMcoForm = ( nil, nil, nil );

procedure ConsultaMovimientosCompra( TipoMovimiento  : TTipoMovimientoCompra;
                                     Seleccion       : TSeleccionDocumento;
                                     LockRangeField  : TField;
                                     Edit            : TcxCustomEdit;
                                     InitialState    : TQueryGridInitialState = qgsNormal;
                                     UserSelection   : TDataEditEvent = nil );

implementation

{$R *.dfm}

uses SysUtils,
     DateUtils,

     EnterpriseDataAccess,

     Gdm00Dm,
     Gim00Fields,

     a_mco,

     dm_mov;

resourceString
     RsMsg1   = 'Consulta de %s';

procedure ConsultaMovimientosCompra( TipoMovimiento  : TTipoMovimientoCompra;
                                     Seleccion       : TSeleccionDocumento;
                                     LockRangeField  : TField;
                                     Edit            : TcxCustomEdit;
                                     InitialState    : TQueryGridInitialState = qgsNormal;
                                     UserSelection   : TDataEditEvent = nil );

begin
     TCxMcoForm.TipoMovimiento := TipoMovimiento;
     TCxMcoForm.Seleccion := Seleccion;
     TCxMcoForm.OnUserSelection := UserSelection;
     CreateQueryForm( TCxMcoForm, CxMcoForm[ TipoMovimiento ], LockRangeField, Edit, InitialState, dsFrom30DaysAgo );
end;

procedure TCxMcoForm.FormCreate(Sender: TObject);
begin

     Caption := Format( RsMsg1, [ Movimiento.TextoTipoMovimiento( TipoMovimiento ) ] );

     Query.SQL.Add( SQLFormat( ' WHERE TipoMovimiento=%d ', [ TipoMovimiento ] ) );

     TableViewTextoSituacion.Visible := TipoMovimiento=tmPedidoCompra;

     Query.SQL.Add( ' ORDER BY Fecha, NroDocumento' );

     TableViewSerieFactura.Visible := TipoMovimiento=tmCompra;
     SetColumnDecimals( TableViewImporteNeto );

     var ListaCampos := [ TableViewCampoLibre1, TableViewCampoLibre2, TableViewCampoLibre3, TableViewCampoLibre4, TableViewCampoLibre5 ];

     With DataModule00.DmEmpresaFields do
       For var Inx := 1 to 5 do
         If   not Compras_CamposLibres.Value or ( Compras_CampoLibre[ Inx ].Value='' )
         then ListaCampos[ Inx - 1 ].VisibleForCustomization := False
         else ListaCampos[ Inx - 1 ].Caption := Compras_CampoLibre[ Inx ].Value;
            
     QueryPanel.OnDataSelected := OnUserSelection;
end;

procedure TCxMcoForm.QueryCalcFields(DataSet: TDataSet);
begin
     case Self.TipoMovimiento of
       tmOferta       : If   QueryRevisado.Value
                        then begin
                             QueryIndiceImagenSituacion.Value := 2;
                             QueryTextoSituacion.Value := 'Revisado';
                             end
                        else begin
                             QueryIndiceImagenSituacion.Value := 1;
                             QueryTextoSituacion.Value := 'Pendiente de revisión';
                             end;
       tmPedidoCompra : begin
                        QueryTextoSituacion.Value := Movimiento.TextoSituacionPedido( tmPedidoCompra, QuerySituacion.Value );
                        case QuerySituacion.Value of
                          epPendiente             : QueryIndiceImagenSituacion.Value := 0;
                          epParcialmenteProcesado : QueryIndiceImagenSituacion.Value := 1;
                          epProcesado             : QueryIndiceImagenSituacion.Value := 2;
                          end;
                        end;
       tmCompra       : If   QueryTraspasado.Value
                       then begin
                            QueryIndiceImagenSituacion.Value := 2;
                            QueryTextoSituacion.Value := 'Contabilizado';
                            end
                       else If   QueryFacturado.Value
                            then begin
                                 QueryIndiceImagenSituacion.Value := 1;
                                 QueryTextoSituacion.Value := 'Facturado';
                                 end
                            else begin
                                 If   QueryNofacturar.Value
                                 then QueryTextoSituacion.Value := 'No facturable'
                                 else QueryTextoSituacion.Value := 'Pendiente de facturar';
                                 QueryIndiceImagenSituacion.Value := 0;
                                 end;
     end;

     If   TableViewImporteNeto.Visible
     then begin
          Movimiento.ObtenImporteMovimiento( QueryEjercicio.Value,
                                             QueryNroOperacion.Value,
                                             ImporteBruto,
                                             DescuentosArticulos,
                                             ImporteNeto );
          QueryImporteNeto.Value := ImporteNeto;
          end;

end;

procedure TCxMcoForm.QueryFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
     If   TipoMovimiento=tmPedidoCompra
     then case Seleccion of
            sdTodos      : Accept := True;
            sdPendientes : Accept := QuerySituacion.Value in [ 0, 1 ];
            sdProcesados : Accept := QuerySituacion.Value=2;
            end
     else Accept := True;
end;

procedure TCxMcoForm.QueryPanelAfterReadQueryState;
begin
     TableViewNombre.Visible := not QueryPanel.LockRange;
end;

procedure TCxMcoForm.QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
begin
     If   Column=TableViewImporteNeto
     then Query.RefreshQuery;
end;

procedure TCxMcoForm.QueryPanelUserSelection;
begin
     MntMovimientosCompra(  [ TipoMovimiento, QueryEjercicio.Value, QueryPropietario.Value, QuerySerie.Value, QueryNroDocumento.Value ] );
end;

end.
