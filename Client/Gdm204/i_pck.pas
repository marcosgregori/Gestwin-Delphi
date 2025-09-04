
unit i_pck;

interface

uses StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,

     ComCtrls,

     Grids,
     Datamanager,
     ReportManager,
     EnterpriseDataAccess, DB, nxdb, Menus, cxLookAndFeelPainters, cxButtons,
  dxmdaset, cxPC, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxGroupBox, cxRadioGroup,
  cxSpinEdit, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  dxDateRanges, AppForms, GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  cxLookAndFeels, cxLabel, cxIndexedComboBox, dxBarBuiltInMenu,

  cxPCdxBarPopupMenu, cxNavigator,

  Gim30Fields,
  Gim204Fields,

  Gdm204Dm,

  dm_mov, dxScrollbarAnnotations, dxUIAClasses;


type
    TFrmPckForm = class(TgxForm)
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    Report: TgxReportManager;
    MovimientoTable: TnxeTable;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataFormato: TSmallintField;
    DataPropietario: TWideStringField;
    DataSerie: TWideStringField;
    DataNroDocumentoInicial: TIntegerField;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataNroDocumentoFinal: TIntegerField;
    BottomPanel: TcxGroupBox;
    FormatoCtrl: TcxDBSpinEdit;
    PackingListQuery: TnxeQuery;
    GridDataSource: TDataSource;
    ClientPanel: TcxGroupBox;
    Label8: TcxLabel;
    FormatoLabel: TcxLabel;
    TopPanel: TcxGroupBox;
    SelectionPanel: TcxGroupBox;
    Label5: TcxLabel;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    gxRangeBox3: TgxRangeBox;
    DocumentoLabel: TcxLabel;
    NroDocumentoInicialCtrl: TcxDBTextEdit;
    NroDocumentoFinalCtrl: TcxDBTextEdit;
    TabSheet2: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    Label4: TcxLabel;
    Label7: TcxLabel;
    Label6: TcxLabel;
    Label11: TcxLabel;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    SeriePanel: TcxGroupBox;
    Label1: TcxLabel;
    Label2: TcxLabel;
    SerieFacturacionCtrl: TcxDBTextEdit;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    GridTableViewController1: TGridTableViewController;
    PackingListQueryEjercicio: TSmallintField;
    PackingListQueryNroOperacion: TIntegerField;
    PackingListQueryNroPalets: TSmallintField;
    PackingListQueryTipoContenedor: TSmallintField;
    PackingListQueryNroContenedor: TWideStringField;
    PackingListQueryNroPrecinto: TWideStringField;
    GridViewEjercicio: TcxGridDBColumn;
    GridViewNroOperacion: TcxGridDBColumn;
    GridViewNroPalets: TcxGridDBColumn;
    GridViewTipoContenedor: TcxGridDBColumn;
    GridViewNroContenedor: TcxGridDBColumn;
    GridViewNroPrecinto: TcxGridDBColumn;
    GridViewNroDocumento: TcxGridDBColumn;
    PackingListQueryNroDocumento: TIntegerField;
    PackingListTable: TnxeTable;
    PackingListQuerySeleccionNroOperacion: TIntegerField;
    PackingListQuerySeleccionEjercicio: TSmallintField;
    GridData: TnxeTable;
    GridDataEjercicio: TSmallintField;
    GridDataNroOperacion: TIntegerField;
    GridDataNroDocumento: TIntegerField;
    GridDataNroPalets: TSmallintField;
    GridDataTipoContenedor: TSmallintField;
    GridDataNroContenedor: TWideStringField;
    GridDataNroPrecinto: TWideStringField;
    GridDataNroLinea: TSmallintField;
    procedure ReportSetReportName;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ReportSelectPrinter;
    procedure NroDocumentoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerPreparedForm;
    procedure GridViewCodigoPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieFacturacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieFacturacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TopPanelExit(Sender: TObject);
    procedure ContenedorCtrlPropertiesValuePosted(Sender: TObject);
    procedure GridDataBeforePost(DataSet: TDataSet);
    private
      procedure ActualizaRejilla;
    protected
    class var
      Serie : String;
      NroDocumento : LongInt;

    public

      MovimientoFields : TMovimientoFields;
      PackingListFields : TPackingListFields;

    end;

var  FrmPckForm: TFrmPckForm = nil;

procedure ImpresionPackingList( Serie        : String;
                                NroDocumento : LongInt );

implementation

uses   SysUtils,
       LibUtils,

       Gdm00Dm,

       dmi_mov,

       dm_ine,
       dm_cli,
       dm_cdt,
       dm_tma,
       dm_art,
       dm_cls,
       dm_iva,
       dm_sdf,
       dm_fdv,

       a_imp,

       b_msg,

       cx_cli,
       cx_art,
       cx_imp,
       cx_sdf,
       cx_mve;

{$R *.DFM}

procedure ImpresionPackingList( Serie          : String;
                                NroDocumento   : LongInt );
begin
     TFrmPckForm.Serie := Serie;
     TFrmPckForm.NroDocumento := NroDocumento;
     CreateEditForm( TFrmPckForm, FrmPckForm );
end;

procedure TFrmPckForm.InitializeForm;
begin

     MovimientoFields  := TMovimientoFields.Create( MovimientoTable );
     PackingListFields := TPackingListFields.Create( PackingListTable );

     DataSerie.Value := Serie;
     DataNroDocumentoInicial.Value := NroDocumento;
     DataNroDocumentoFinal.Value := NroDocumento;
     DataCodigoFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;

end;

procedure TFrmPckForm.NroDocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMovimientosVenta( tmVenta, sdTodos, DataSerie, Sender );
end;

procedure TFrmPckForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impPackingList ), Sender.EditingValue ] );
end;

procedure TFrmPckForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impPackingList, Sender );
end;

procedure TFrmPckForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impPackingList, Sender, DisplayValue, ErrorText, Error );
end;

procedure TFrmPckForm.FormManagerOkButton;
begin

     With Movimiento, ParametrosInforme do
       begin

       LimpiaParametrosInforme;

       Impreso := True;
       Report := Self.Report;

       DirectamenteAImpresora := True;
       RelacionDocumentos := True;
       TablaRelacionDocumentos := GridData.TableName;   // Es una tabla temporal en memoria

       TipoMovimiento := tmVenta;
       Serie := DataSerie.Value;

       case PageControl.ActivePageIndex of
         0 : begin
             SeleccionNroDocumento := True;
             NroDocumentoInicial := DataNroDocumentoInicial.Value;
             NroDocumentoFinal := DataNroDocumentoFinal.Value;
             end;
         1 : begin
             SeleccionFecha := True;
             FechaInicial := DataFechaInicial.Value;
             FechaFinal := DataFechaFinal.Value;
             SeleccionPropietario := 2;
             PropietarioInicial := DataCodigoInicial.Value;
             PropietarioFinal := DataCodigoFinal.Value;
             end;
         end;

       Formato := DataFormato.Value;
       end;

     Movimiento.InformeMovimientos;
end;

procedure TFrmPckForm.FormManagerPreparedForm;
begin
     ActualizaRejilla;
end;

procedure TFrmPckForm.GridDataBeforePost(DataSet: TDataSet);
begin
     With PackingListTable do
       If   not GridData.ControlsDisabled
       then With PackingListFields do
              begin
              If   FindKey( [ GridDataEjercicio.Value, GridDataNroOperacion.Value ] )
              then Edit
              else begin
                   Append;
                   Ejercicio.Value := GridDataEjercicio.Value;
                   NroOperacion.Value := GridDataNroOperacion.Value;
                   end;
              NroPalets.Value := GridDataNroPalets.Value;
              TipoContenedor.Value := GridDataTipoContenedor.Value;
              NroContenedor.Value := GridDataNroContenedor.Value;
              NroPrecinto.Value := GridDataNroPrecinto.Value;
              Post;
              end;
end;

procedure TFrmPckForm.GridViewCodigoPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TFrmPckForm.GridViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TFrmPckForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TFrmPckForm.CodigoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TFrmPckForm.ContenedorCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaRejilla;
end;

procedure TFrmPckForm.ReportSelectPrinter;
begin
     Report.ReportPrinter := InformeExterno.Impresora;
end;

procedure TFrmPckForm.ReportSetReportName;
begin
     Report.FileName := InformeExterno.Fichero;
end;

procedure TFrmPckForm.SerieFacturacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TFrmPckForm.SerieFacturacionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TFrmPckForm.TopPanelExit(Sender: TObject);
begin
     If   Data.Modified
     then ActualizaRejilla;
end;

procedure TFrmPckForm.ActualizaRejilla;

var   SQLText : String;
      NroLinea : SmallInt;

begin
     With PackingListQuery do
       try

         GridData.DisableControls;

         // Primero selecciono los movimientos y compruebo que exista el registro de packing list. Si no es así, lo creo sobre la marcha.

         SQLText := 'SELECT PackingList.*, Seleccion.Ejercicio AS SeleccionEjercicio, Seleccion.NroOperacion AS SeleccionNroOperacion, Seleccion.NroDocumento ' +
                    'FROM ( SELECT Ejercicio, NroOperacion, NroDocumento FROM Movimiento WHERE Movimiento.Serie=' + QuotedStr( DataSerie.Value ) + ' AND ';
         case PageControl.ActivePageIndex of
           0 : StrAdd( SQLText, SQLVarsFormat( 'Movimiento.Ejercicio=? AND Movimiento.TipoMovimiento=15 AND Movimiento.NroDocumento BETWEEN ? AND ? ',
                                               [ ApplicationContainer.Ejercicio, DataNroDocumentoInicial.Value, DataNroDocumentoFinal.Value ] ) );
           1 : StrAdd( SQLText, SQLVarsFormat( '( Movimiento.Fecha BETWEEN ? AND ? ) AND ( Movimiento.Propietario BETWEEN ? AND ? ) ',
                                                [ DataFechaInicial.Value, DataFechaFinal.Value,
                                                  DataCodigoInicial.Value, DataCodigoFinal.Value ] ) );
           end;

           StrAdd( SQLText, ' ) AS Seleccion ' +
                            'LEFT JOIN PackingList ON ( PackingList.Ejercicio=Seleccion.Ejercicio AND PackingList.NroOperacion=Seleccion.NroOperacion ) ' +
                            ' ORDER BY SeleccionEjercicio, Seleccion.NroDocumento' );

         SQL.Text := SQLText;
         Open;

         With GridData do
           begin
           Close;
           // CreateTemporalTableName( True );
           Open;
           end;

         NroLinea := 1;

         First;

         While not Eof do
           begin

           GridData.Append;

           GridDataNroLinea.Value := NroLinea;
           GridDataNroDocumento.Value := PackingListQueryNroDocumento.Value;

           If   PackingListQueryNroOperacion.Value=0
           then begin
                GridDataEjercicio.Value := PackingListQuerySeleccionEjercicio.Value;
                GridDataNroOperacion.Value := PackingListQuerySeleccionNroOperacion.Value;
                end
           else begin
                GridDataEjercicio.Value := PackingListQueryEjercicio.Value;
                GridDataNroOperacion.Value := PackingListQueryNroOperacion.Value;
                GridDataNroPalets.Value := PackingListQueryNroPalets.Value;
                GridDataTipoContenedor.Value := PackingListQueryTipoContenedor.Value;
                GridDataNroContenedor.Value := PackingListQueryNroContenedor.Value;
                GridDataNroPrecinto.Value := PackingListQueryNroPrecinto.Value;
                end;

           GridData.Post;

           Inc( NroLinea );

           Next;
           end;

     finally
       GridData.EnableControls;
       end;

end;

end.

