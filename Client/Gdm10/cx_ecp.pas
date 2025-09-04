
unit cx_ecp;

interface

uses Forms, AppForms, Classes, Controls,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit, Menus,

  Gim10Fields, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  cxLookAndFeelPainters, QueryForm, cxContainer, dxSkinsDefaultPainters,
  cxGroupBox, cxNavigator,

  AppManager, cxTextEdit, cxIntegerEdit, dxDateRanges,
  dxScrollbarAnnotations;

type
  TSituacionEfecto = ( seTodos, sePendientes, seRemesados );

  TCxEcpForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewFechaVencimiento: TcxGridDBColumn;
    TableViewNroEfecto: TcxGridDBColumn;
    TableViewSubcuentaProveedor: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewImporte: TcxGridDBColumn;
    TableViewEjercicio: TcxGridDBColumn;
    TableViewNroRemesa: TcxGridDBColumn;
    QueryEjercicio: TSmallintField;
    QueryFechaVencimiento: TDateField;
    QueryFechaPago: TDateField;
    QueryNroFactura: TIntegerField;
    QueryNroEfecto: TSmallintField;
    QueryProveedor: TWideStringField;
    QueryDescripcion: TWideStringField;
    QueryEntidad: TWideStringField;
    QueryImporte: TBCDField;
    QueryNroRemesa: TIntegerField;
    TableViewFechaPago: TcxGridDBColumn;
    QuerySerie: TWideStringField;
    QuerySerieNroFactura: TWideStringField;
    TableViewSerieNroFactura: TcxGridDBColumn;
    TableViewNroFactura: TcxGridDBColumn;
    TableViewSerie: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure QueryFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure QueryPanelUserSelection;
    procedure TableViewSerieNroFacturaGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure QueryPanelAfterReadQueryState;
  private
    Situacion : TSituacionEfecto;
  public
    class var
    SituacionEfecto : TSituacionEfecto;
    OnUSerSelection :TDataEditEvent;
  end;

var  CxEcpForm : TCxEcpForm = nil;

procedure ConsultaEfectosPagar( LockRangeField  : TField;
                                Edit            : TcxCustomEdit;
                                SituacionEfecto : TSituacionEfecto;
                                UserSelection   : TDataEditEvent = nil;
                                InitialState    : TQueryGridInitialState = qgsNormal );


implementation

{$R *.dfm}

uses SysUtils,
     Variants,
     DateUtils,
     LibUtils,
     EnterpriseDataAccess,

     a_ecp,
     a_ape,

     dm_pga,
     dm_sub,
     dm_fac,
     dm_rem;

resourceString
      RsMsg1 = 'pendientes ';
      RsMsg2 = 'remesados ';

procedure ConsultaEfectosPagar( LockRangeField  : TField;
                                Edit            : TcxCustomEdit;
                                SituacionEfecto : TSituacionEfecto;
                                UserSelection   : TDataEditEvent = nil;
                                InitialState    : TQueryGridInitialState = qgsNormal );

begin
     If   ShiftKey
     then TCxEcpForm.SituacionEfecto := seTodos
     else TCxEcpForm.SituacionEfecto := SituacionEfecto;
     TCxEcpForm.OnUserSelection := UserSelection;
     CreateQueryForm( TCxEcpForm, CxEcpForm, LockRangeField, Edit, InitialState, dsFromOneYearAgo );
end;

procedure TCxEcpForm.FormCreate(Sender: TObject);
begin

     Situacion := SituacionEfecto;

     SetColumnDecimals( TableViewImporte, DecimalesMoneda );

     case SituacionEfecto of
       seTodos        : TableViewFechaPago.Visible := True;
       sePendientes   : Caption := Caption + RsMsg1;
       seRemesados    : begin
                        Caption := Caption + RsMsg2;
                        TableViewNroRemesa.Visible := True;
                        end;
       end;

     QueryPanel.OnDataSelected := OnUserSelection;
end;

procedure TCxEcpForm.QueryCalcFields(DataSet: TDataSet);
begin
     QuerySerieNroFactura.Value := Factura.TextoSerieNroFactura( QuerySerie.Value, QueryNroFactura.Value );
end;

procedure TCxEcpForm.QueryFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
     case Situacion of
       seTodos      : Accept := True;
       sePendientes : Accept := ValueIsEmpty( QueryFechaPago.Value, varDate ) and ValueIsEmpty( QueryNroRemesa.Value );
       seRemesados  : Accept := not ValueIsEmpty( QueryNroRemesa.Value );
       end;
end;

procedure TCxEcpForm.QueryPanelAfterReadQueryState;
begin
     TableViewDescripcion.Visible := not QueryPanel.LockRange;
end;

procedure TCxEcpForm.QueryPanelUserSelection;
begin
     If   Situacion=sePendientes
     then MntAnotacionPagoEfectos( [ QueryEjercicio.Value, QueryProveedor.Value, QuerySerie.Value, QueryNroFactura.Value, QueryNroEfecto.Value ] )
     else MntEfectosPagar( [ QueryEjercicio.Value, QueryProveedor.Value, QuerySerie.Value, QueryNroFactura.Value, QueryNroEfecto.Value ] );
end;

procedure TCxEcpForm.TableViewSerieNroFacturaGetProperties(     Sender      : TcxCustomGridTableItem;
                                                                ARecord     : TcxCustomGridRecord;
                                                            var AProperties : TcxCustomEditProperties );
begin
     If   ValueIsEmpty( ARecord.Values[ TableViewNroFactura.Index ] )
     then AProperties := TableViewSerieNroFactura.Properties
     else AProperties := TableViewNroFactura.Properties;
end;

end.
