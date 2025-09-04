unit b_odp;

interface

uses Windows, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Graphics,Menus,
     cxLookAndFeelPainters, cxButtons, cxCheckBox, cxDBEdit,
    cxControls, cxContainer, cxEdit, cxTextEdit, cxStyles, cxCustomData,
    cxGraphics, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel,
    cxGridCustomTableView, cxGridTableView, cxClasses, cxGridCustomView,
    cxGridDBTableView, cxGrid,

    nxdb, DataManager, cxMaskEdit, cxDropDownEdit, cxCalendar, dxScrollbarAnnotations,
    cxCurrencyEdit, dxmdaset, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
    cxGroupBox, cxLookAndFeels, cxLabel, cxScrollBox, cxNavigator, cxIntegerEdit, dxBar, dxDateRanges,

    AppContainer,
    AppForms,
    GridTableViewController,

    Gim10Fields,
    Gim30Fields,

    dmi_mov,
    dm_fdv;

type
  TBoxOdpForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    MovimientoTable: TnxeTable;
    MovimientoDataSource: TDataSource;
    OrdenFabricacionQuery: TnxeQuery;
    LineaMovimientoDataSource: TDataSource;
    TableViewManager: TGridTableViewController;
    NroDocumentoCaptionLabel: TcxLabel;
    EstadoLabel: TcxLabel;
    cxLabel1: TcxLabel;
    EjercicioCtrl: TcxDBTextEdit;
    OrdenFabricacionQueryEjercicio: TSmallintField;
    OrdenFabricacionQueryTipo: TSmallintField;
    OrdenFabricacionQueryNroOrden: TIntegerField;
    OrdenFabricacionQueryEjercicioPedido: TSmallintField;
    OrdenFabricacionQuerySeriePedido: TWideStringField;
    OrdenFabricacionQueryNroPedido: TIntegerField;
    OrdenFabricacionQueryEjercicioLanzamiento: TSmallintField;
    OrdenFabricacionQueryNroOperacionLanzamiento: TIntegerField;
    OrdenFabricacionQueryCodigoArticulo: TWideStringField;
    OrdenFabricacionQueryCodigoClaseA: TWideStringField;
    OrdenFabricacionQueryCodigoClaseB: TWideStringField;
    OrdenFabricacionQueryCodigoClaseC: TWideStringField;
    OrdenFabricacionQueryLote: TWideStringField;
    OrdenFabricacionQueryUnidadesAFabricar: TBCDField;
    OrdenFabricacionQueryFechaLanzamiento: TDateField;
    OrdenFabricacionQueryPrioridad: TSmallintField;
    OrdenFabricacionQueryNroOrdenVinculada: TIntegerField;
    OrdenFabricacionQueryAprovisionamiento: TBooleanField;
    OrdenFabricacionQueryCerrado: TBooleanField;
    OrdenFabricacionQueryCargas: TIntegerField;
    OrdenFabricacionQuerymDispFabricacion1: TIntegerField;
    OrdenFabricacionQuerymFabricacion: TIntegerField;
    OrdenFabricacionQuerymFabricDefectuosa: TIntegerField;
    OrdenFabricacionQuerymExtraidoIncorporado: TIntegerField;
    GridViewEjercicio: TcxGridDBColumn;
    GridViewNroOrden: TcxGridDBColumn;
    GridViewCodigoArticulo: TcxGridDBColumn;
    GridViewCodigoClaseA: TcxGridDBColumn;
    GridViewCodigoClaseB: TcxGridDBColumn;
    GridViewCodigoClaseC: TcxGridDBColumn;
    GridViewLote: TcxGridDBColumn;
    GridViewUnidadesAFabricar: TcxGridDBColumn;
    GridViewFechaLanzamiento: TcxGridDBColumn;
    GridViewNroOrdenVinculada: TcxGridDBColumn;
    OrdenFabricacionQueryDescripcion: TWideStringField;
    GridViewDescripcion: TcxGridDBColumn;
    DescPedidoLabel: TcxLabel;
    dxBarManager1: TdxBarManager;
    PopupMenu: TdxBarPopupMenu;
    EditarDocItem: TdxBarButton;
    Panel1: TcxGroupBox;
    SerieCtrl: TcxDBTextEdit;
    SeparadorSerieLabel: TcxLabel;
    NroDocumentoCtrl: TcxDBIntegerEdit;
    LockRangeButton: TgxLockRangeButton;
    procedure FormManagerInitializeForm;
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure MovimientoTableSetKey(DataSet: TDataSet);
    procedure OrdenFabricacionQueryCalcFields(DataSet: TDataSet);
    procedure MovimientoTableRecordChanged(DataSet: TDataSet);
    procedure MovimientoTableUpdateState(DataSet: TDataSet);
    procedure FormManagerShowForm;
    procedure GridViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure NroDocumentoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure OrdenFabricacionQueryBeforeOpen(DataSet: TDataSet);
    procedure NroDocumentoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure EditarDocItemClick(Sender: TObject);
  private

  public

    MovimientoFields : TMovimientoFields;

    end;

var  BoxOdpForm : TBoxOdpForm = nil;

function ConsultaOrdenesPedido( Values : array of const ) : TBoxOdpForm;

implementation

{$R *.DFM}

uses   Variants,
       SysUtils,
       DateUtils,
       LibUtils,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Dm,
       Gim00Fields,

       dmi_odf,

       dm_cls,
       dm_sdf,
       dm_cli,
       dm_mov,

       a_sdf,
       a_odf,
       a_mve,

       cx_sdf,
       cx_mve;

function ConsultaOrdenesPedido( Values : array of const ) : TBoxOdpForm;
begin
     CreateEditForm( TBoxOdpForm, BoxOdpForm, Values );
     Result := BoxOdpForm;
end;

procedure TBoxOdpForm.EditarDocItemClick(Sender: TObject);
begin
     MntOrdenesFabricacion( [ OrdenFabricacionQueryEjercicio.Value, moOrden, OrdenFabricacionQueryNroOrden.Value ] );
end;

procedure TBoxOdpForm.FormManagerInitializeForm;

var  Serie : String;
     NroPedido : LongInt;

begin

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );

     Clase.SetupGridColumns( GridViewCodigoClaseA, GridViewCodigoClaseB, GridViewCodigoClaseC, 4 );

     With DataModule00.DmEmpresaFields do
       begin

       If   not Movimiento.SeriesEnDocumentosVenta( tmPedidoVenta )
       then begin
            SerieCtrl.Visible := False;
            SeparadorSerieLabel.Visible := False;
            LockRangeButton.Visible := False;
            end;

       SetColumnDecimals( GridViewUnidadesAFabricar, Compras_DecCantidad.Value );
       end;

     MovimientoTable.SetDefaultRangeValues( [ tmPedidoVenta, ApplicationContainer.Ejercicio ], [ tmPedidoVenta, ApplicationContainer.Ejercicio ] );
     SetFieldRange( MovimientoFields.NroDocumento );

     {
     If   High( FormValues )=1
     then begin
          Serie := FormValues[ 0 ];
          NroPedido := FormValues[ 1 ];
          MovimientoTable.FindKey( [ tmPedidoVenta, ApplicationContainer.Ejercicio, Serie, NroPedido ] );
          end;
      }
end;

procedure TBoxOdpForm.GridViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                  ACanvas   : TcxCanvas;
                                                  AViewInfo : TcxGridTableDataCellViewInfo;
                                              var ADone     : Boolean);
begin
     {
     If   not AViewInfo.Selected
     then With AViewInfo.GridRecord do
            If   VarToBoolean( Values[ GridViewNoCalcularMargen.Index ] )
            then ACanvas.Brush.Color := clRowHighlight;
     }
end;

procedure TBoxOdpForm.FormManagerShowForm;
begin
     If   Length( FormValues )=1
     then CleanFormValues;
end;

procedure TBoxOdpForm.OrdenFabricacionQueryBeforeOpen(DataSet: TDataSet);



begin
     { Si se asigna el valor de los parámetros en el componente PedidoVentasQuery.Params el enlace no funciona, y
       si no se asignan, los valores nulos (cuando no hay ningún documento), provocan un error al intentar comparar con NULL.
       La solución es dejar que se produzca el error, que es silencioso (o, en un futuro, modificar el sistema de asignación para que utilice IS NULL en lugar de =NULL)
       }
end;

procedure TBoxOdpForm.OrdenFabricacionQueryCalcFields(DataSet: TDataSet);
begin

     If   Assigned( MovimientoFields )
     then begin


          end;
end;

procedure TBoxOdpForm.LockRangeButtonLockRange( var KeyValues: TFieldValuesArray);
begin
     With MovimientoTable do
       begin
       // KeyValues : TipoMovimiento;Ejercicio;Serie;NroDocumento
       KeyValues[ 0 ] := tmPedidoVenta;
       KeyValues[ 1 ] := ApplicationContainer.Ejercicio;
       If   not LockRangeButton.Down
       then KeyValues[ 2 ] := UnAssigned; // Serie
       KeyValues[ 3 ] := UnAssigned;
       end;
end;

procedure TBoxOdpForm.MovimientoTableRecordChanged(DataSet: TDataSet);
begin
     Movimiento.EstadoDocumento( MovimientoFields, EstadoLabel );
     If   ValueIsEmpty( MovimientoFields.NroOperacion.Value )
     then DescPedidoLabel.Caption := ''
     else DescPedidoLabel.Caption := 'de fecha ' + StrFormatDate( MovimientoFields.Fecha.Value ) + ', cliente ' +
                                      MovimientoFields.Propietario.Value + ' - ' + Cliente.Descripcion( MovimientoFields.Propietario.Value );
end;

procedure TBoxOdpForm.MovimientoTableSetKey(DataSet: TDataSet);
begin

     MovimientoFields.TipoMovimiento.Value := tmPedidoVenta;
     MovimientoFields.Ejercicio.Value := ApplicationContainer.Ejercicio;

     If   not Movimiento.SeriesEnDocumentosVenta( tmPedidoVenta ) // tmPedidoVenta in [ tmPresupuesto, tmPedidoVenta ]
     then MovimientoFields.Serie.Value := ''
     else If   LockRangeButton.SettingDefaultRange
          then begin
               SerieFacturacion.FijaSeriePorDefecto( MovimientoFields.Serie );
               If   DataModule00.DmUsuarioFields.Ventas_RestringirSerie.Value
               then LockRangeButton.Enabled := False;
               end;

end;

procedure TBoxOdpForm.MovimientoTableUpdateState(DataSet: TDataSet);
begin
     LineaMovimientoDataSource.Enabled := MovimientoTable.State<>dsSetKey;
end;

procedure TBoxOdpForm.NroDocumentoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With MovimientoFields do
       MntMovimientosVenta( [ TipoMovimiento.Value, Ejercicio.Value, Serie.Value, NroDocumento.Value ] );
end;

procedure TBoxOdpForm.NroDocumentoCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     With MovimientoFields do
       ConsultaMovimientosVenta( tmPedidoVenta, sdTodos, Serie, Sender, qgsLinked );
end;

procedure TBoxOdpForm.SerieCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] );
end;

procedure TBoxOdpForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxOdpForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxOdpForm.TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     EditarDocItemClick( nil );
end;

end.

