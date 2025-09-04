
unit cx_rdp;

interface

uses Forms, Classes, Controls,

  AppContainer, AppForms,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit, dxSkinsCore,
  dxSkinscxPCPainter, cxLookAndFeels, cxLookAndFeelPainters, QueryForm,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator, cxImageComboBox,
  Vcl.ImgList, System.ImageList, dxDateRanges, dxScrollbarAnnotations,
  cxImageList;

type
  TSeleccionRemesas = ( srpTodas, srpPendientes, srpPagadas );

  TCxRdpForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryNroRemesa: TIntegerField;
    QueryFecha: TDateField;
    QueryImporte: TBCDField;
    QueryNombre: TWideStringField;
    TableViewNroRemesa: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    TableViewCodigoEntidad: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewImporte: TcxGridDBColumn;
    TableViewEstado: TcxGridDBColumn;
    TableViewImagenEstado: TcxGridDBColumn;
    TableViewTextoEstado: TcxGridDBColumn;
    QueryEstado: TSmallintField;
    QueryFechaPago: TDateField;
    TableViewFechaPago: TcxGridDBColumn;
    QueryEjercicio: TSmallintField;
    QueryIndiceImagenEstado: TSmallintField;
    QueryTextoEstado: TWideStringField;
    DocumentStatesImageList: TcxImageList;
    QuerySubcuentaEntidad: TWideStringField;
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

var  CxRdpForm : TCxRdpForm = nil;

procedure ConsultaRemesasPago( Edit             : TcxCustomEdit;
                               SeleccionRemesas : TSeleccionRemesas;
                               InitialState : TQueryGridInitialState = qgsNormal );


implementation

{$R *.dfm}

uses LibUtils,
     Variants,
     EnterpriseDataAccess,

     a_rdp,

     dm_sub,
     dm_rdp;

resourceString
      rsMsg1 = 'pendientes';
      rsMsg2 = 'pagadas';

procedure ConsultaRemesasPago( Edit             : TcxCustomEdit;
                               SeleccionRemesas : TSeleccionRemesas;
                               InitialState : TQueryGridInitialState = qgsNormal );
begin
     TCxRdpForm.SeleccionRemesas := SeleccionRemesas;
     CreateQueryForm( TCxRdpForm, CxRdpForm, Edit, InitialState, dsFrom30DaysAgo );
end;

procedure TCxRdpForm.FormCreate(Sender: TObject);
begin

      Seleccion := SeleccionRemesas;

      SetColumnDecimals( TableViewImporte, DecimalesMoneda );

     case SeleccionRemesas of
       srpTodas        : TableViewFechaPago.Visible := True;
       srpPendientes   : Caption := Caption + rsMsg1;
       srpPagadas      : Caption := Caption + rsMsg2;
       end;

end;

procedure TCxRdpForm.QueryCalcFields(DataSet: TDataSet);

var  Importe : Decimal;

begin
     Importe  := RemesaPago.ImporteRemesa( QueryEjercicio.Value, QueryNroRemesa.Value );
     QueryImporte.Value := Importe;

     // Imagenes : 0 = Rojo, 1 = Verde

    case QueryEstado.Value of
       erpPendiente  : begin
                       QueryIndiceImagenEstado.Value := 0;
                       QueryTextoEstado.Value := 'Pendiente';
                       end;
       erpPagada     : begin
                       QueryIndiceImagenEstado.Value := 1;
                       QueryTextoEstado.Value := 'Pagada';
                       end;
       end;
end;

procedure TCxRdpForm.QueryFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
     case Seleccion of
       srpTodas       : Accept := True;
       srpPendientes  : Accept := QueryEstado.Value=erpPendiente;
       srpPagadas     : Accept := QueryEstado.Value=erpPagada;
       end;
end;

procedure TCxRdpForm.QueryPanelUserSelection;
begin
     MntRemesasPago( [ QueryEjercicio.Value, QueryNroremesa.Value ] );
end;

end.
