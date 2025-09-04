
unit cx_ecc;

interface

uses Forms, AppForms, Classes, Controls,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit, Menus,
  dxSkinsCore, dxSkinscxPCPainter, cxCheckBox, cxLookAndFeels,
  cxLookAndFeelPainters, QueryForm, cxContainer, dxSkinsDefaultPainters,
  cxGroupBox, cxNavigator,

  Gim10Fields, dxDateRanges, dxScrollbarAnnotations;

type
  TSituacionEfecto = ( seTodos, sePendientes, seRemesados, seNoCancelados );  // Remesados y pendientes de cancelar

  TcxEccForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewFechaVencimiento: TcxGridDBColumn;
    TableViewSerie: TcxGridDBColumn;
    TableViewNroFactura: TcxGridDBColumn;
    TableViewNroEfecto: TcxGridDBColumn;
    TableViewCliente: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewImporte: TcxGridDBColumn;
    TableViewFechaCobro: TcxGridDBColumn;
    TableViewCancelado: TcxGridDBColumn;
    QueryEjercicio: TSmallintField;
    QueryFechaVencimiento: TDateField;
    QueryFechaCobro: TDateField;
    QuerySerie: TWideStringField;
    QueryNroFactura: TIntegerField;
    QueryNroEfecto: TSmallintField;
    QueryCliente: TWideStringField;
    QueryDescripcion: TWideStringField;
    QueryImporte: TBCDField;
    QueryNroRemesa: TIntegerField;
    QueryCancelado: TBooleanField;
    TableViewEjercicio: TcxGridDBColumn;
    TableViewNroRemesa: TcxGridDBColumn;
    QueryEntidad: TWideStringField;
    QueryImpagado: TBooleanField;
    procedure FormCreate(Sender: TObject);
    procedure QueryFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure queryPanelUserSelection;
  private
    RemesaFields : TRemesaFields;
    Situacion : TSituacionEfecto;

  protected
    class var
    SituacionEfecto : TSituacionEfecto;
  end;

var  cxEccForm : TcxEccForm = nil;

procedure ConsultaEfectosCobrar( LockRangeField  : TField;
                                 Edit            : TcxCustomEdit;
                                 SituacionEfecto : TSituacionEfecto;
                                 InitialState    : TQueryGridInitialState = qgsNormal );


implementation

{$R *.dfm}

uses SysUtils,
     LibUtils,
     Variants,
     EnterpriseDataAccess,

     a_ecc,
     a_ace,

     dm_pga,
     dm_sub,
     dm_rem;

resourceString
      RsMsg1 = 'pendientes';
      RsMsg2 = 'remesados';
      RsMsg3 = 'pendientes de cancelar';
      RsMsg4 = ' de la serie ';

procedure ConsultaEfectosCobrar( LockRangeField  : TField;
                                 Edit            : TcxCustomEdit;
                                 SituacionEfecto : TSituacionEfecto;
                                 InitialState    : TQueryGridInitialState = qgsNormal );
begin
     If   ShiftKey
     then TcxEccForm.SituacionEfecto := seTodos
     else TcxEccForm.SituacionEfecto := SituacionEfecto;
     CreateQueryForm( TcxEccForm, CxEccForm, LockRangeField, Edit, InitialState, dsFromOneYearAgo );
end;

procedure TcxEccForm.FormCreate(Sender: TObject);
begin

     RemesaFields := TRemesaFields.Create( Self );

     Situacion := SituacionEfecto;

     SetColumnDecimals( TableViewImporte, DecimalesMoneda );

     case SituacionEfecto of
       seTodos        : TableViewFechaCobro.Visible := True;
       sePendientes   : Caption := Caption + RsMsg1;
       seRemesados    : begin
                        Caption := Caption + RsMsg2;
                        TableViewNroRemesa.Visible := True;
                        end;
       seNoCancelados : begin
                        Caption := Caption + RsMsg3;
                        TableViewNroRemesa.Visible := True;
                        end;
       end;

end;

procedure TcxEccForm.QueryFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
     case Situacion of
       seTodos        : Accept := True;
       sePendientes   : Accept := ValueIsEmpty( QueryFechaCobro.Value ) and ValueIsEmpty( QueryNroRemesa.Value );
       seRemesados    : Accept := not ValueIsEmpty( QueryNroRemesa.Value );
       seNoCancelados : If   not ValueIsEmpty( QueryNroRemesa.Value )
                        then If   Remesa.Obten( QueryEjercicio.Value, QueryNroRemesa.Value, RemesaFields )
                             then Accept := ( RemesaFields.Estado.Value=erDescontada ) and ( not QueryCancelado.Value );
       end;
end;

procedure TcxEccForm.queryPanelUserSelection;
begin
     If   Situacion=sePendientes
     then MntAnotacionCobroEfectos( [ QueryEjercicio.Value, QuerySerie.Value, QueryNroFactura.Value, QueryNroEfecto.Value ] )
     else MntEfectosCobrar( [ QueryEjercicio.Value, QuerySerie.Value, QueryNroFactura.Value, QueryNroEfecto.Value ] );
end;

end.


