
unit cx_rem;

interface

uses Forms, AppForms, Classes, Controls,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit, dxSkinsCore,
  dxSkinscxPCPainter, cxLookAndFeels, cxLookAndFeelPainters, QueryForm,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator, Vcl.ImgList,
  cxImageComboBox, dxDateRanges, System.ImageList, cxImageList,
  dxScrollbarAnnotations;

type
  TSeleccionRemesas = ( srTodas, srPendientes, srAceptadas, srDescontadas, srCobradas, srCanceladas );

  TCxRemForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewNroRemesa: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    TableViewCodigoEntidad: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewImporte: TcxGridDBColumn;
    TableViewFechaCobro: TcxGridDBColumn;
    TableViewEstado: TcxGridDBColumn;
    TableViewImagenEstado: TcxGridDBColumn;
    TableViewTextoEstado: TcxGridDBColumn;
    QueryEjercicio: TSmallintField;
    QueryNroRemesa: TIntegerField;
    QueryFecha: TDateField;
    QueryEntidad: TWideStringField;
    QueryNombre: TWideStringField;
    QueryEstado: TSmallintField;
    QueryFechaCobro: TDateField;
    QueryImporte: TBCDField;
    QueryIndiceImagenEstado: TSmallintField;
    QueryTextoEstado: TWideStringField;
    DocumentStatesImageList: TcxImageList;
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure QueryFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure QueryPanelUserSelection;
  private
    Seleccion : TSeleccionRemesas;
  protected
    class var
    SeleccionRemesas : TSeleccionRemesas;
  end;

var  CxRemForm : TCxRemForm = nil;

procedure ConsultaRemesas( Edit             : TcxCustomEdit;
                           SeleccionRemesas : TSeleccionRemesas;
                           InitialState : TQueryGridInitialState = qgsNormal );


implementation

{$R *.dfm}

uses LibUtils,
     Variants,
     EnterpriseDataAccess,

     a_rem,

     dm_sub,
     dm_rem;

resourceString
      RsMsg1   = 'pendientes de descuento o cobro.';
      RsMsg2   = 'cobradas.';
      RsMsg3   = 'aceptadas.';
      RsMsg4   = 'descontadas.';
      RsMsg5   = 'canceladas.';

procedure ConsultaRemesas( Edit             : TcxCustomEdit;
                           SeleccionRemesas : TSeleccionRemesas;
                           InitialState : TQueryGridInitialState = qgsNormal );
begin
     If   ShiftKey
     then SeleccionRemesas := srTodas;
     TCxRemForm.SeleccionRemesas := SeleccionRemesas;
     CreateQueryForm( TCxRemForm, CxRemForm, Edit, InitialState, dsFrom30DaysAgo );
end;

procedure TCxRemForm.FormCreate(Sender: TObject);
begin
      Seleccion := SeleccionRemesas;

      SetColumnDecimals( TableViewImporte, DecimalesMoneda );

     case SeleccionRemesas of
       srTodas        : TableViewFechaCobro.Visible := True;
       srPendientes   : Caption := Caption + RsMsg1;
       srCobradas     : Caption := Caption + RsMsg2;
       srAceptadas    : Caption := Caption + RsMsg3;
       srDescontadas  : Caption := Caption + RsMsg4;
       srCanceladas   : Caption := Caption + RsMsg5;
       end;

end;

procedure TCxRemForm.QueryCalcFields(DataSet: TDataSet);

var  Importe,
     ImporteImpagados,
     ImporteCancelados : Decimal;

begin
     Remesa.ImporteRemesa( QueryEjercicio.Value, QueryNroRemesa.Value, Importe, ImporteImpagados, ImporteCancelados );
     QueryImporte.Value := Importe;

    // Imagenes : 0 = Rojo, 1 = Amarillo y 2 = Verde

    case QueryEstado.Value of
       erPendiente  : begin
                      QueryIndiceImagenEstado.Value := 0;
                      QueryTextoEstado.Value := 'Pendiente';
                      end;

       erAceptada,
       erDescontada : begin
                      QueryIndiceImagenEstado.Value := 1;
                      If   QueryEstado.Value=erAceptada
                      then QueryTextoEstado.Value := 'Aceptada'
                      else QueryTextoEstado.Value := 'Descontada';
                      end;

       erCobrada,
       erCancelada : begin
                      QueryIndiceImagenEstado.Value := 2;
                      If   QueryEstado.Value=erCobrada
                      then QueryTextoEstado.Value := 'Cobrada'
                      else QueryTextoEstado.Value := 'Cancelada';
                      end;
       end;

end;

procedure TCxRemForm.QueryFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
     case Seleccion of
       srTodas       : Accept := True;
       srPendientes  : Accept := QueryEstado.Value=erPendiente;
       srCobradas    : Accept := QueryEstado.Value=erCobrada;
       srAceptadas   : Accept := QueryEstado.Value=erAceptada;
       srDescontadas : Accept := QueryEstado.Value=erDescontada;
       srCanceladas  : Accept := QueryEstado.Value=erCancelada;
       end;
end;

procedure TCxRemForm.QueryPanelUserSelection;
begin
     MntRemesas( [ QueryEjercicio.Value, QueryNroRemesa.Value ] );
end;

end.
