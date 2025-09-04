
unit cx_iva;

interface

uses Forms, AppForms, Classes, Controls,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit,


  dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  cxLookAndFeelPainters, QueryForm, cxContainer, dxSkinsDefaultPainters,
  cxGroupBox, cxNavigator, dxDateRanges, dxScrollbarAnnotations,

  Gim00Fields,

  dmi_iva, dxUIAClasses;

type
  TCxIvaForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigo: TSmallintField;
    QueryDescripcion: TWideStringField;
    QueryIVASoportado: TBCDField;
    QueryCtaSoportado: TWideStringField;
    QueryIVAREpercutido: TBCDField;
    QueryRERepercutido: TBCDField;
    QueryCtaRepercutido: TWideStringField;
    QueryLiquidable: TBooleanField;
    QuerySobreTotal: TBooleanField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewIVASoportado: TcxGridDBColumn;
    TableViewCtaSoportado: TcxGridDBColumn;
    TableViewIVAREpercutido: TcxGridDBColumn;
    TableViewRERepercutido: TcxGridDBColumn;
    TableViewCtaRepercutido: TcxGridDBColumn;
    TableViewLiquidable: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
  protected
    class var
      Seccion : TSeccionIVA;
      Fecha : TDate;
      CodigoPais : String;
  end;

var  CxIvaForm : TCxIvaForm = nil;

procedure ConsultaTiposIVA( Edit         : TcxCustomEdit;
                            Seccion      : TSeccionIVA;
                            Fecha        : TDateTime;
                            CodigoPais   : String = CodigoEspaña;
                            InitialState : TQueryGridInitialState = qgsNormal );

implementation

uses  dm_pai,
      dm_iva;

{$R *.dfm}

procedure ConsultaTiposIVA( Edit         : TcxCustomEdit;
                            Seccion      : TSeccionIVA;
                            Fecha        : TDateTime;
                            CodigoPais   : String = CodigoEspaña;
                            InitialState : TQueryGridInitialState = qgsNormal );
begin
     TcxIvaForm.Seccion := Seccion;
     TcxIvaForm.Fecha := Fecha;
     TcxIvaForm.CodigoPais := CodigoPais;
     CreateQueryForm( TcxIvaForm, CxIvaForm, Edit, InitialState );
end;

procedure TCxIvaForm.FormCreate(Sender: TObject);
begin

     If   CodigoPais<>CodigoEspaña
     then Caption := Caption + ' (' + Pais.Descripcion( CodigoPais ) +')';

     case Seccion of
         siSoportado   : begin
                         TableViewIVAREpercutido.Visible := False;
                         TableViewRERepercutido.Visible := False;
                         TableViewCtaRepercutido.Visible := False;
                         Width := 380;
                         end;
         siRepercutido : begin
                         TableViewIVASoportado.Visible := False;
                         TableViewCtaSoportado.Visible := False;
                         Width := 340;
                         end;
         siAmbos       : Width := 480;
         end;

     Query.Params[ 0 ].Value := Tasa.UltimaFechaAplicacion( Fecha, { Retencion } False, CodigoPais );
     Query.Params[ 1 ].Value := CodigoPais;

end;

end.
