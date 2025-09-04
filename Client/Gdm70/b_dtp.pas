
unit b_dtp;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms, ComCtrls, DB,
     Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
     cxMaskEdit, cxDropDownEdit, cxDBEdit, cxCheckBox, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxPC, dxmdaset, cxCalendar,
     cxIndexedComboBox, cxGroupBox, cxRadioGroup, cxSpinEdit, dxSkinsCore,
     dxSkinscxPCPainter, cxLookAndFeels, dxSkinsDefaultPainters, cxLabel,
     cxPCdxBarPopupMenu, dxBarBuiltInMenu, nxdb, cxStyles, cxCustomData,
     cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
     cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
     cxGridCustomView, cxGrid, EditSelector, sqlset, cxIntegerEdit, dxUIAClasses,

     AppContainer,
     DataManager,
     ReportManager,
     PDFViewer,

     Gim70Fields,

     dmi_mov;


type

    TBoxDtpForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataNroOrdenInicial: TIntegerField;
    DataNroOrdenFinal: TIntegerField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    Panel1: TcxGroupBox;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataNroPedidoInicial: TIntegerField;
    DataNroPedidoFinal: TIntegerField;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxGroupBox3: TcxGroupBox;
    PageControl: TcxPageControl;
    NroOrdenTabSheet: TcxTabSheet;
    NroOrdenRangeBox: TgxRangeBox;
    NroOrdenInicialCtrl: TcxDBTextEdit;
    NroOrdenFinalCtrl: TcxDBTextEdit;
    Label9: TcxLabel;
    NroPedidoTabSheet: TcxTabSheet;
    NroPedidoRangeBox: TgxRangeBox;
    NroPedidoInicialCtrl: TcxDBTextEdit;
    NroPedidoFinalCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    FechaTabSheet: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    Label6: TcxLabel;
    Label5: TcxLabel;
    DiagramaTareasTable: TnxeTable;
    EstadoOrdenCtrl: TcxDBIndexedComboBox;
    cxLabel3: TcxLabel;
    DataEstadoOrden: TSmallintField;
    NroOrdenSelectionTable: TnxeTable;
    NroOrdenSelectionTableNroRegistro: TSmallintField;
    NroOrdenSelectionTableDescripcion: TStringField;
    NroOrdenSelectionDataSource: TDataSource;
    NroOrdenGridViewRepository: TcxGridViewRepository;
    NroOrdenSelectionView: TcxGridDBTableView;
    NroOrdenSelectionViewDescripcion: TcxGridDBColumn;
    NroPedidoSelectionTable: TnxeTable;
    SmallintField1: TSmallintField;
    NroPedidoSelectionTableDescripcion: TStringField;
    NroPedidoSelectionDataSource: TDataSource;
    NroPedidoGridViewRepository: TcxGridViewRepository;
    NroPedidoSelectionView: TcxGridDBTableView;
    NroOrdenSelectionTableNroOrden: TLongWordField;
    NroPedidoSelectionTableNroPedido: TLongWordField;
    NroOrdenSelectionViewNroOrden: TcxGridDBColumn;
    NroPedidoSelectionViewNroPedido: TcxGridDBColumn;
    NroPedidoSelectionViewDescripcion: TcxGridDBColumn;
    NroOrdenEditSelector: TgxEditSelector;
    NroPedidoEditSelector: TgxEditSelector;
    SQLSet: TgxSQLSet;
    DescNroOrdenInicialLabel: TcxLabel;
    DescNroOrdenFinalLabel: TcxLabel;
    DescNroPedidoInicialLabel: TcxLabel;
    DescNroPedidoFinalLabel: TcxLabel;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure NroOrdenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure NroPedidoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure NroOrdenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroPedidoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroOrdenSelectionViewNroOrdenPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure NroPedidoSelectionViewNroPedidoPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    private

      FTipoMovimiento : TTipoMovimiento;
      FSerie : String;
      PDFViewerForm : TPDFViewerForm;

    protected
    class var
      NroOrden : LongInt;

    public

    end;

var  BoxDtpForm: TBoxDtpForm = nil;

procedure DiagramaTareasPendientes( NroOrden : LongInt );


implementation

uses   SysUtils,
       Variants,
       DateUtils,
       LibUtils,
       nxsdDataDictionaryStrings,

       EnterpriseDataAccess,
       SessionDataAccess,

       dxGanttControlTasks,

       Gantt,

       Gim00Fields,

       dmi_odf,

       dm_mov,
       dm_odf,

       a_pde7,

       b_msg,

       cx_odf,
       cx_mve;

{$R *.DFM}

type TDiagramaTareasFields = class( TnxeDatasetFields)
     public
       EstadoOrden,
       Ejercicio  : TSmallIntField;
       NroOrdenFabricacion : TIntegerField;
       NroProceso,
       Segmento : TSmallIntField;
       CodigoMaquina : TWideStringField;
       Fecha,
       FechaLanzamiento : TDateField;
       Turno,
       NroOrdenEntrada,
       Prioridad : TSmallIntField;
       HoraInicio : TTimeField;
       Tiempo : TLongWordField;
       Cantidad : TCurrencyField;
       Realizado : TBooleanField;
     end;

procedure DiagramaTareasPendientes( NroOrden : LongInt );
begin
     TBoxDtpForm.NroOrden := NroOrden;
     CreateReportForm( TBoxDtpForm, BoxDtpForm );
end;

procedure TBoxDtpForm.InitializeForm;
begin

     If   NroOrden=0
     then begin
          DataNroOrdenInicial.Value := 1;
          DataNroOrdenFinal.Value := 9999999;
          end
     else begin
          DataNroOrdenInicial.Value := NroOrden;
          DataNroOrdenFinal.Value := NroOrden;
          end;

     DataNroPedidoFinal.Value := 9999999;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;

end;

procedure TBoxDtpForm.FormManagerOkButton;

var  DiagramaTareasFields : TDiagramaTareasFields;
     EstadoOrdenFabricacion : TEstadoOrdenFabricacion;

function ObtenConsultaSQL : String;

var   SQLString,
      SQLSeleccion,
      SQLOrdenacion : String;

begin

     SQLString := SQLSet.GetSQLText;

     case PageControl.ActivePageIndex of
       0 : begin
           StrAdd( SQLSeleccion, SQLFormat( 'SecuenciaAsignacion.Ejercicio=%d AND ', [ ApplicationContainer.Ejercicio ] ) + NroOrdenEditSelector.GetSQLSelection( 'NroOrdenFabricacion' ) );
           SQLOrdenacion := 'NroOrdenFabricacion, SecuenciaAsignacion.NroProceso, Segmento';
           end;
       {
       1 : begin
           StrAdd( SQLSeleccion, SQLFormat( 'OrdenFabricacion.Ejercicio=%d AND ', [ ApplicationContainer.Ejercicio ] ) + NroPedidoEditSelector.GetSQLSelection( 'OrdenFabricacion.NroPedido' ) );
           SQLOrdenacion := 'OrdenFabricacion.NroPedido, OrdenFabricacion.NroOrden, NroProceso';
           end;
       }
       2 : begin
           StrAdd( SQLSeleccion, SQLFormat( 'FechaLanzamiento BETWEEN %s AND %s', [ DataFechaInicial, DataFechaFinal ] ) );
           SQLOrdenacion := 'SecuenciaAsignacion.FechaLanzamiento, NroOrdenFabricacion, SecuenciaAsignacion.NroProceso, Segmento';
           end;
       end;

       SetSQLVar( SQLString, 'Seleccion', SQLSeleccion );
       SetSQLVar( SQLString, 'Ordenacion', SQLOrdenacion );

       Result := SQLString;

end;

procedure SeleccionRegistros;
begin

     CreateQueryIntoTable( ObtenConsultaSQL, DiagramaTareasTable, tsClientSide );

     DiagramaTareasFields := TDiagramaTareasFields.Create( DiagramaTareasTable );

     With DiagramaTareasTable do
       begin
       First;
       While not Eof do
         begin

         With DiagramaTareasFields do
           EstadoOrdenFabricacion := OrdenFabricacion.Estado( Ejercicio.Value, moOrden, NroOrdenFabricacion.Value );

         If   ( DataEstadoOrden.Value<>0 ) and ( Ord( EstadoOrdenFabricacion )<>DataEstadoOrden.Value - 1 ) // El primero es la opción Todas
         then Delete
         else begin
              Edit;
              DiagramaTareasFields.EstadoOrden.Value := Ord( EstadoOrdenFabricacion );
              Post;
              Next;
              end;

         end;

       end;

end;

var  ADate: TDateTime;
     ATask: TdxGanttControlTask;
     ATaskCollection: TdxGanttControlTasks;

     NroOrdenActual,
     I: Integer;

begin

     SeleccionRegistros;
     Gantt.DiagramaGantt;

     ATaskCollection := CurrenTGanttForm.GanttControl.DataModel.Tasks;
     NroOrdenActual := 0;

     With DiagramaTareasTable do
      begin
      First;
      While not Eof do
        begin

        If   DiagramaTareasFields.NroOrdenFabricacion.Value<>NroOrdenActual
        then begin
             NroOrdenActual := DiagramaTareasFields.NroOrdenFabricacion.Value;
             I := 1;
             ATask := ATaskCollection.Append;

             ATask.Manual := False;
             ATask.OutlineLevel := 1;
             ATask.Name := 'Orden nº ' + IntToStr( DiagramaTareasFields.NroOrdenFabricacion.Value );
             end;

        ATask := ATaskCollection.Append;

        ATask.Manual := False;
        ATask.OutlineLevel := 2;
        ATask.Start := DiagramaTareasFields.Fecha.Value + DiagramaTareasFields.HoraInicio.Value;
        ATask.Finish := IncSecond( ATask.Start, DiagramaTareasFields.Tiempo.Value );
        ATask.Name := IntToStr( DiagramaTareasFields.NroProceso.Value ) + ', ' + IntToStr( DiagramaTareasFields.Segmento.Value ) + ', ' +DiagramaTareasFields.Codigomaquina.Value;
        // ATask.Duration :=

        If   I>1
        then ATask.PredecessorLinks.Append.PredecessorUID := ATaskCollection[ ATaskCollection.Count - 2 ].UID;

        Inc( I );

        Next;
        end;

      end;

end;

procedure TBoxDtpForm.NroOrdenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOrdenesFabricacion( ApplicationContainer.Ejercicio, Sender );
end;

procedure TBoxDtpForm.NroOrdenCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     OrdenFabricacion.Valida( ApplicationContainer.Ejercicio, moOrden, Sender, DisplayValue, ErrorText, Error, { IsInfoControl } True );
end;

procedure TBoxDtpForm.NroOrdenSelectionViewNroOrdenPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     var Descripcion := OrdenFabricacion.Valida( ApplicationContainer.Ejercicio, moOrden, Sender, DisplayValue, ErrorText, Error, { IsInfoControl } False, { ShowFullDescription } True );
     If   not Error and NroOrdenSelectionTable.Editing
     then NroOrdenSelectionTableDescripcion.Value := Descripcion;
end;

procedure TBoxDtpForm.NroPedidoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMovimientosVenta( tmPedidoventa, sdTodos, nil, Sender );
end;

procedure TBoxDtpForm.NroPedidoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Movimiento.Valida( Sender, tmPedidoVenta, ApplicationContainer.Ejercicio, '', VarToInteger( DisplayValue ), ErrorText, Error, { IsInfoControl } True );
end;

procedure TBoxDtpForm.NroPedidoSelectionViewNroPedidoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     var Descripcion := Movimiento.Valida( Sender, tmPedidoVenta, ApplicationContainer.Ejercicio, '', VarToInteger( DisplayValue ), ErrorText, Error, { IsInfoControl } False );
     If   not Error and NroPedidoSelectionTable.Editing
     then NroPedidoSelectionTableDescripcion.Value := Descripcion;
end;

end.

