
unit ct_mve;

interface

uses Forms, AppForms, Classes, Controls,

  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit,
  cxRichEdit, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLookAndFeels, cxLookAndFeelPainters,
  cxImageComboBox, ImgList, QueryForm, cxContainer, cxGroupBox, cxNavigator,
  System.ImageList, cxImageList, dxDateRanges, dxScrollbarAnnotations,
  cxLabel, cxCalendar,

  LibUtils,
  AppManager,
  dmi_mov, TouchQueryForm;

type
  TCxMveForm = class(TgxForm)
    QueryPanel: TTouchQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewNro_Documento: TcxGridDBColumn;
    QueryImporteNeto: TBCDField;
    TableViewImporteNeto: TcxGridDBColumn;
    DocumentStatesImageList: TcxImageList;
    BottomPanel: TcxGroupBox;
    cxLabel1: TcxLabel;
    QueryCreado: TDateTimeField;
    QueryNroDocumento: TIntegerField;
    TableViewCreado: TcxGridDBColumn;
    QueryEjercicio: TSmallintField;
    QueryNroOperacion: TIntegerField;
    QueryFecha: TDateField;
    TableViewFecha: TcxGridDBColumn;
    QueryTipoMovimiento: TSmallintField;
    QuerySerie: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
  private
    ImporteBruto,
    DescuentosArticulos,
    ImporteNeto : Decimal;
  protected
    class var
    TipoMovimiento : TTipoMovimientoVenta;
    Serie : String;
    CodigoCliente : String;
    FechaInicial : TDateTime;
    FechaFinal : TDateTime;
    Seleccion : TSeleccionDocumento;
    TodasLasSeries : Boolean;
    OnUserSelection : TDataEditEvent;
  end;

var  CxMveForm : array[ tmPresupuesto..tmVenta ] of TCxMveForm = ( nil, nil, nil );

procedure ConsultaMovimientosVenta( TipoMovimiento  : TTipoMovimientoVenta;
                                    Serie           : String = '';
                                    CodigoCliente   : String = '';
                                    Seleccion       : TSeleccionDocumento = sdTodos;
                                    Edit            : TcxCustomEdit = nil;
                                    InitialState : TQueryGridInitialState = qgsNormal;
                                    UserSelection   : TDataEditEvent = nil;
                                    Restricted      : Boolean = False );

implementation

{$R *.dfm}

uses SysUtils,
     DateUtils,

     EnterpriseDataAccess,

     Gdm00Dm,
     Gim00Fields,

     dm_cli,
     dm_mov,
     dm_rac,
     dm_sdf;

resourceString
     RsMsg1   = 'Consulta de %s';
     RsMsg2   = ' del cliente %s.';
     RsMsg3   = ' (Serie %s)';
     RsMsg4   = ' (Serie genérica)';

procedure ConsultaMovimientosVenta( TipoMovimiento  : TTipoMovimientoVenta;
                                    Serie           : String = '';
                                    CodigoCliente   : String = '';
                                    Seleccion       : TSeleccionDocumento = sdTodos;
                                    Edit            : TcxCustomEdit = nil;
                                    InitialState    : TQueryGridInitialState = qgsNormal;
                                    UserSelection   : TDataEditEvent = nil;
                                    Restricted      : Boolean = False );
begin

     TCxMveForm.TodasLasSeries := False;

     If   Restricted
     then Serie := SerieFacturacion.ObtenSeriePorDefecto
     else If   ShiftKey
          then begin
               TCxMveForm.TodasLasSeries := True;
               CodigoCliente := '';
               end;

     TCxMveForm.TipoMovimiento := TipoMovimiento;
     TCxMveForm.Serie := Serie;
     TCxMveForm.CodigoCliente := CodigoCliente;
     TCxMveForm.Seleccion := Seleccion;
     TCxMveForm.OnUserSelection := UserSelection;

     CreateTouchQueryForm( TCxMveForm, CxMveForm[ TipoMovimiento ], Edit, qgsLinked, dsFromOneYearAgo );

end;

procedure TCxMveForm.FormCreate(Sender: TObject);
begin

     Caption := Format( RsMsg1, [ Movimiento.TextoTipoMovimiento( TipoMovimiento ) ] );

     Query.SQL.Add( SQLFormat( ' WHERE TipoMovimiento=%d ', [ TipoMovimiento ] ) );

     If   CodigoCliente<>''
     then begin
          Caption := Caption + Format( RsMsg2, [ CodigoCliente ] );
          Query.SQL.Add( SQLFormat( ' AND Propietario=%s', [ QuotedStr( CodigoCliente ) ] ) );
          {
          TableViewPropietario.Visible := False;
          TableViewNombre.Visible := False;
          }
          end;

     If   not TodasLasSeries and Movimiento.SeriesEnDocumentosVenta( TipoMovimiento )
     then begin
          If   Serie=''
          then Caption := Caption + RsMsg4
          else Caption := Caption + Format( RsMsg3, [ Serie ] );
          Query.SQL.Add( SQLFormat( ' AND Serie=%s', [ QuotedStr( Serie ) ] ) );
          end;

     Query.SQL.Add( ' ORDER BY Creado DESC, NroDocumento' );

     SetColumnDecimals( TableViewImporteNeto );

     QueryPanel.OnDataSelected := OnUserSelection;

end;

procedure TCxMveForm.QueryCalcFields(DataSet: TDataSet);
begin
     // Imagenes : 0 = Rojo, 1 = Amarillo y 2 = Verde

     Movimiento.ObtenImporteMovimiento( QueryEjercicio.Value,
                                        QueryNroOperacion.Value,
                                        ImporteBruto,
                                        DescuentosArticulos,
                                        ImporteNeto );

     QueryImporteNeto.Value := -ImporteNeto;

end;

end.
