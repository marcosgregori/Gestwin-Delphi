
unit r_odf;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms, ComCtrls, DB,
     Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
     cxMaskEdit, cxDropDownEdit, cxDBEdit, cxCheckBox, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxPC, dxmdaset, cxCalendar,
     cxIndexedComboBox,

     cxGroupBox, cxRadioGroup, cxSpinEdit, dxSkinsCore,
     dxSkinscxPCPainter, cxLookAndFeels, dxSkinsDefaultPainters, cxLabel,
     cxPCdxBarPopupMenu, dxBarBuiltInMenu, nxdb,
     EditSelector, cxStyles, cxCustomData, cxFilter, cxData,
     cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
     cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
     cxClasses, cxGridCustomView, cxGrid,

     AppContainer,
     DataManager,
     ReportManager,
     PDFViewer,

     Gim70Fields,

     dmi_mov;


type

    TRptOdfForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataNroOrdenInicial: TIntegerField;
    DataNroOrdenFinal: TIntegerField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataMostrarTareas: TBooleanField;
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
    gxRangeBox2: TgxRangeBox;
    NroOrdenInicialCtrl: TcxDBTextEdit;
    NroOrdenFinalCtrl: TcxDBTextEdit;
    Label9: TcxLabel;
    NroPedidoTabSheet: TcxTabSheet;
    gxRangeBox3: TgxRangeBox;
    NroPedidoInicialCtrl: TcxDBTextEdit;
    NroPedidoFinalCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    FechaTabSheet: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    Label6: TcxLabel;
    Label5: TcxLabel;
    MostrarTareasCtrl: TcxDBCheckBox;
    Consulta: TnxeQuery;
    DataImprimir: TSmallintField;
    cxLabel2: TcxLabel;
    ImprimirCtrl: TcxDBIndexedComboBox;
    EstadoOrdenCtrl: TcxDBIndexedComboBox;
    cxLabel3: TcxLabel;
    DataEstadoOrden: TSmallintField;
    SerieVentasPanel: TcxGroupBox;
    SerieRangeBox: TgxRangeBox;
    SerieInicialCtrl: TcxDBTextEdit;
    SerieFinalCtrl: TcxDBTextEdit;
    cxLabel6: TcxLabel;
    SerieEditSelector: TgxEditSelector;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    NroPedidoPanel: TcxGroupBox;
    GridViewRepository: TcxGridViewRepository;
    SeriesFacturacionTableView: TcxGridDBTableView;
    SeriesFacturacionTableViewCodigo: TcxGridDBColumn;
    SeriesFacturacionTableViewDescripcion: TcxGridDBColumn;
    SeriesFacturacionDataSource: TDataSource;
    SeriesFacturacionTable: TnxeTable;
    SeriesFacturacionTableNroRegistro: TSmallintField;
    SeriesFacturacionTableCodigo: TStringField;
    SeriesFacturacionTableDescripcion: TStringField;
    DataSerieInicial: TStringField;
    DataSerieFinal: TStringField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure NroOrdenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerPreparedForm;
    procedure NroPedidoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ReportSetReportName;
    procedure SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private
      FTipoMovimiento : TTipoMovimiento;
      FSerie : String;
      PDFViewerForm : TPDFViewerForm;
    procedure DoOnPrintDocuments;

    protected
    class var
      NroOrden : LongInt;
      Impreso : Boolean;

    public

    end;

var  RptOdfForm: TRptOdfForm = nil;

procedure InformeOrdenesFabricacion( NroOrden : LongInt; Impreso : Boolean = False );


implementation

uses   SysUtils,
       Variants,
       DateUtils,
       LibUtils,
       nxsdDataDictionaryStrings,

       EnterpriseDataAccess,

       Gim00Fields,

       dmi_odf,

       dm_fdv,
       dm_cls,
       dm_lmp,
       dm_odf,
       dm_sdf,
       dm_mov,

       a_pde7,
       a_sdf,
       b_msg,

       cx_sdf,
       cx_odf,
       cx_mve;

{$R *.DFM}

type TSeleccionDocumentosFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       Tipo : TSmallIntField;
       NroOrden : TIntegerField;
       CodigoArticulo : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       Documento : TWideStringField;
     end;

procedure InformeOrdenesFabricacion( NroOrden : LongInt; Impreso : Boolean = False );
begin
     TRptOdfForm.NroOrden := NroOrden;
     TRptOdfForm.Impreso := Impreso;
     CreateReportForm( TRptOdfForm, RptOdfForm );
end;

procedure TRptOdfForm.InitializeForm;
begin

     SetupPanelableCtrl( SerieInicialCtrl, Movimiento.SeriesEnDocumentosVenta( tmPedidoVenta ), True );
     SetupPanelableCtrl( MostrarTareasCtrl, not Impreso, { AdjustFormHeight } True );
     SetupPanelableCtrl( ImprimirCtrl, Impreso, True );

     If   NroOrden=0
     then begin
          DataNroOrdenInicial.Value := 1;
          DataNroOrdenFinal.Value := 9999999;
          end
     else begin
          DataNroOrdenInicial.Value := NroOrden;
          DataNroOrdenFinal.Value := NroOrden;
          end;

     DataNroPedidoInicial.Value := 1;
     DataNroPedidoFinal.Value := 9999999;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;

     MostrarTareasCtrl.Enabled := not Impreso;

end;

procedure TRptOdfForm.DoOnPrintDocuments;

var  DocumentoPath : String;

begin
     //
end;

procedure TRptOdfForm.FormManagerOkButton;

var  OrdenFabricacionTable : TnxeTable;
     SeleccionDocumentosFields : TSeleccionDocumentosFields;
     OrdenFabricacionFields : TOrdenFabricacionFields;
     RelacionDocumentoList : TStringList;
     EstadoOrdenFabricacion : TEstadoOrdenFabricacion;

function ObtenConsultaSQL( Documentos : Boolean = False ) : String;

var   SQLString,
      SQLSeleccion,
      SQLOrdenacion : String;

begin

     If   Documentos
     then SQLString := Report.SQLSet.GetSQLText( 'Documentos' )
     else If   Impreso
          then SQLString := Report.SQLSet.GetSQLText( 'Impreso' )
          else SQLString := Report.SQLSet.GetSQLText( 'Listado' );

     case PageControl.ActivePageIndex of
       0 : begin
           StrAdd( SQLSeleccion, SQLFormat( 'OrdenFabricacion.Ejercicio=%d AND OrdenFabricacion.NroOrden BETWEEN %s AND %s', [ ApplicationContainer.Ejercicio, DataNroOrdenInicial, DataNroOrdenFinal ] ) );
           SQLOrdenacion := 'OrdenFabricacion.NroOrden, NroProceso';
           end;
       1 : begin
           StrAdd( SQLSeleccion, SQLFormat( 'OrdenFabricacion.Ejercicio=%d AND OrdenFabricacion.NroPedido BETWEEN %s AND %s', [ ApplicationContainer.Ejercicio, DataNroPedidoInicial, DataNroPedidoFinal ] ) );
           If   SerieVentasPanel.Visible
           then StrAdd( SQLSeleccion, ' AND ' + SerieEditSelector.GetSQLSelection( 'OrdenFabricacion.SeriePedido' ) );
           SQLOrdenacion := 'OrdenFabricacion.NroPedido, OrdenFabricacion.NroOrden, NroProceso';
           end;
       2 : begin
           StrAdd( SQLSeleccion, SQLFormat( 'OrdenFabricacion.FechaLanzamiento BETWEEN %s AND %s', [ DataFechaInicial, DataFechaFinal ] ) );
           SQLOrdenacion := 'OrdenFabricacion.FechaLanzamiento, OrdenFabricacion.NroOrden, NroProceso';
           end;
       end;

     If   Impreso and not Documentos
     then StrAdd( SQLOrdenacion, ', NroRegistro' );

     SetSQLVar( SQLString, 'Seleccion', SQLSeleccion );
     SetSQLVar( SQLString, 'Ordenacion', SQLOrdenacion );

     Result := SQLString;

end;

procedure SeleccionRegistros;
begin
     OrdenFabricacionTable := Report.CreateQueryTable( 'Consulta', ObtenConsultaSQL );
     OrdenFabricacionFields := TOrdenFabricacionFields.Create( OrdenFabricacionTable );

     With OrdenFabricacionTable do
       begin
       First;
       While not Eof do
         begin

         With OrdenFabricacionFields do
           EstadoOrdenFabricacion := OrdenFabricacion.Estado( Ejercicio.Value, Tipo.Value, NroOrden.Value );

         If   ( DataEstadoOrden.Value<>0 ) and ( Ord( EstadoOrdenFabricacion )<>DataEstadoOrden.Value - 1 ) // El primero es la opción Todas
         then Delete
         else begin
              Edit;
              OrdenFabricacionFields.EstadoOrden.Value := Ord( EstadoOrdenFabricacion );
              Post;
              Next;
              end;
         end;

       end;
end;

procedure FijaParametrosInforme;
begin
     With Report do
       begin
       SetValue( rsSeleccion, PageControl.ActivePageIndex );
       Clase.SetReportTitles( Report, 4 );
       FacturaVentas.FijaDecimalesInforme( Report );
       SetNumberVarFormat( FmtDecComponentes, ParametrosProduccionRec.DecimalesComponentes );
       end;
end;

begin

     try
       If   Impreso
       then begin
            If   DataImprimir.Value in [ 0, 1 ]
            then begin
                 Report.Load;
                 Report.SetSQLExpression( ObtenConsultaSQL );
                 FijaParametrosInforme;
                 Report.Start;
                 end;
            end
       else begin
            Report.Load;
            SeleccionRegistros;
            FijaParametrosInforme;
            Report.Start;
            end;

     except on E : Exception do
       begin
       Report.Cancel( E );
       Exit;
       end;
     end;

     If   Impreso and ( DataImprimir.Value in [ 0, 2 ] )
     then begin
          RelacionDocumentoList := TStringList.Create;
          try
            Consulta.Close;
            Consulta.SQL.Text := ObtenConsultaSQL( True );
            Consulta.Open;
            SeleccionDocumentosFields := TSeleccionDocumentosFields.Create( Consulta );
            With Consulta do
              begin
              First;
              While not Eof do
                begin
                var Incluir := True;
                If   DataEstadoOrden.Value<>0
                then begin
                     With SeleccionDocumentosFields do
                       EstadoOrdenFabricacion := OrdenFabricacion.Estado( Ejercicio.Value, Tipo.Value, NroOrden.Value );
                     Incluir := Ord( EstadoOrdenFabricacion )=DataEstadoOrden.Value - 1;
                     end;
                If   Incluir and ( SeleccionDocumentosFields.Documento.Value<>'' )
                then RelacionDocumentoList.Add( SeleccionDocumentosFields.Documento.Value );
                Next;
                end;
              end;

            If   RelacionDocumentoList.Count>0
            then PDFViewerForm := VistaFicheroPDF( RelacionDocumentoList );

            {
            If   Assigned( PDFViewerForm )
            then PDFViewerForm.OnPrintDocuments := DoOnPrintDocuments;
            }

          finally
            Consulta.Close;
            RelacionDocumentoList.Free;
            end;

          end;

end;

procedure TRptOdfForm.FormManagerPreparedForm;
begin
     If   NroOrden=0
     then PageControl.ActivePageIndex := 2;
end;

procedure TRptOdfForm.NroOrdenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOrdenesFabricacion( ApplicationContainer.Ejercicio, Sender );
end;

procedure TRptOdfForm.NroPedidoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMovimientosVenta( tmPedidoventa, sdTodos, nil, Sender );
end;

procedure TRptOdfForm.ReportSetReportName;
begin
     If   Impreso
     then Report.FileName := 'fodf'
     else Report.FileName := 'dm70\l_odf'
end;

procedure TRptOdfForm.SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] );
end;

procedure TRptOdfForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TRptOdfForm.SerieCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, nil, { IsInfoControl } True );
end;

end.

