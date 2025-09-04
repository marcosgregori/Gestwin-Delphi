
unit cx_fdv;

interface

uses Forms, AppForms, Classes, Controls,

  AppManager,
  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit, cxCheckBox,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels,
  cxLookAndFeelPainters, QueryForm, cxContainer, cxGroupBox, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, dxUIAClasses;

type
  TCxFdvForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QuerySerie: TWideStringField;
    QueryNroFactura: TIntegerField;
    QueryFecha: TDateField;
    QueryCodigoCliente: TWideStringField;
    QueryNombre: TWideStringField;
    TableViewSerie: TcxGridDBColumn;
    TableViewNroFactura: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    TableViewCodigoCliente: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    QueryTotalFactura: TBCDField;
    QueryTraspasada: TBooleanField;
    TableViewImporte: TcxGridDBColumn;
    TableViewTraspasada: TcxGridDBColumn;
    QueryEjercicio: TSmallintField;
    QueryAuxiliarDescripcion: TWideStringField;
    QueryRegistroAuxiliar: TWideStringField;
    TableViewRegistroAuxiliar: TcxGridDBColumn;
    TableViewAuxiliarDescripcion: TcxGridDBColumn;
    QueryNetoFactura: TBCDField;
    TableViewNetoFactura: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure QueryPanelUserSelection;
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure QueryPanelFormReport;
  private
  public
    class var
    OnUserSelection : TDataEditEvent;
  end;

var  CxFdvForm : TCxFdvForm = nil;

procedure ConsultaFacturasVenta( LockRangeField : TField;
                                 Edit           : TcxCustomEdit;
                                 InitialState   : TQueryGridInitialState = qgsNormal;
                                 UserSelection  : TDataEditEvent = nil );

implementation

{$R *.dfm}

uses SysUtils,
     LibUtils,

     EnterpriseDataAccess,

     Gdm00Dm,
     Gim00Fields,

     dm_rac,

     a_fdv,

     r_fdv;

procedure ConsultaFacturasVenta( LockRangeField : TField;
                                 Edit           : TcxCustomEdit;
                                 InitialState   : TQueryGridInitialState = qgsNormal;
                                 UserSelection  : TDataEditEvent = nil );
begin
     TCxFdvForm.OnUserSelection := UserSelection;
     CreateQueryForm( TcxFdvForm, CxFdvForm, LockRangeField, Edit, InitialState, dsFrom30DaysAgo );
end;

procedure TCxFdvForm.FormCreate(Sender: TObject);

var  SQLText : String;

begin

     SQLText := 'SELECT Ejercicio, Serie, NroFactura, Fecha, CodigoCliente, RegistroAuxiliar, NetoFactura, TotalFactura, Traspasada, Cliente.Nombre FROM FacturaVentas, Cliente ' +
                'WHERE FacturaVentas.CodigoCliente=Cliente.Codigo AND NOT Anulada';
     StrAdd( SQLText,' ORDER BY Fecha, Serie, NroFactura' );

     Query.SQL.Text := SQLText;

     If   DataModule00.DmEmpresaFields.Cliente_RegAuxiliar.Value
     then begin

          With TableViewRegistroAuxiliar do
            begin
            Caption := NombreAuxiliarCliente( True );
            HeaderHint := Caption;
            Visible := True;
            end;

          With TableViewAuxiliarDescripcion do
            begin
            Caption := DataModule00.DmEmpresaFields.Cliente_CampoAux[ 1 ].Value;
            HeaderHint := Caption;
            Visible := True;
            end;

          end;

     SetColumnDecimals( TableViewImporte );
     QueryPanel.OnDataSelected := OnUserSelection;
end;

procedure TCxFdvForm.QueryCalcFields(DataSet: TDataSet);
begin
     If   DataModule00.DmEmpresaFields.Cliente_RegAuxiliar.Value and not ValueIsEmpty( QueryRegistroAuxiliar.Value )
     then QueryAuxiliarDescripcion.Value := AuxiliarCliente.Descripcion( QueryCodigoCliente.Value, QueryRegistroAuxiliar.Value, True );
end;

procedure TCxFdvForm.QueryPanelFormReport;
begin
     ImpresionFacturasVenta( QueryEjercicio.Value,
                             QuerySerie.Value,
                             QueryNroFactura.Value,
                             QueryNroFactura.Value,
                             { Impreso } True );
end;

procedure TCxFdvForm.QueryPanelUserSelection;
begin
     MntFacturasVenta( [ QueryEjercicio.Value, QuerySerie.Value, QueryNroFactura.Value ] );
end;

end.


