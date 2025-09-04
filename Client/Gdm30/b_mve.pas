
unit b_mve;

interface

uses StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     cxStyles,
     cxCustomData,
     cxGraphics,
     cxFilter,
     cxData,
     cxDataStorage,
     cxEdit,
     DB,
     cxDBData,
     nxdb,

     cxGridLevel,
     cxClasses,
     cxControls,
     cxGridCustomView,
     cxGridCustomTableView,
     cxGridTableView,
     cxGridDBTableView,
     cxGrid, DBCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,

     cxRichEdit, dxmdaset, cxContainer, cxDBEdit, dxSkinsCore,
     dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, cxLabel,
     cxGroupBox, cxDBLabel, cxTextEdit, cxSplitter, dxDateRanges, dxUIAClasses,
     Generics.Collections, cxNavigator, cxCheckComboBox, dxBevel, dxScrollbarAnnotations,

     DataManager,
     AppContainer,
     AppForms,
     GridTableViewController,

     Gim10Fields,
     Gim30Fields,

     EnterpriseDataAccess,

     dmi_mov,
     dm_mov;

type
  TFilterLineRecordEvent = procedure( LineaMovimientoOrigenFields : TLineaMovimientoFields; var Accept : Boolean ) of object;
  TCalcLineFieldsEvent = procedure( LineaMovimientoOrigenFields : TLineaMovimientoFields ) of object;

  TBoxMveForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    MovimientoOrigenTable: TnxeTable;
    MovimientoOrigenDataSource: TDataSource;
    LineaMovimientoOrigenTable: TnxeTable;
    LineaMovimientoOrigenDataSource: TDataSource;
    LineaMovimientoOrigenTableSeleccionado: TBooleanField;
    DataPanel: TgxEditPanel;
    keyPanel: TcxGroupBox;
    FechaLabel: TcxDBLabel;
    FechaAplicacionLabel: TcxDBLabel;
    LinesGrid: TcxGrid;
    LinesView: TcxGridDBTableView;
    LinesViewSeleccionado: TcxGridDBColumn;
    LinesViewNroLinea: TcxGridDBColumn;
    LinesViewCodigoArticulo: TcxGridDBColumn;
    LinesViewCodigoClaseA: TcxGridDBColumn;
    LinesViewCodigoClaseB: TcxGridDBColumn;
    LinesViewCodigoClaseC: TcxGridDBColumn;
    LinesViewDescripcion: TcxGridDBColumn;
    LinesViewCantidad: TcxGridDBColumn;
    LinesViewPrecio: TcxGridDBColumn;
    LinesViewDescuento: TcxGridDBColumn;
    LinesViewImporteNeto: TcxGridDBColumn;
    LinesViewAnotacion: TcxGridDBColumn;
    LinesViewParametros : TcxGridDBColumn;
    LinesLevel: TcxGridLevel;
    FooterPanel: TcxGroupBox;
    TodoButton: TgBitBtn;
    LinesViewServido: TcxGridDBColumn;
    LinesViewCodigoAlmacen: TcxGridDBColumn;
    LineaMovimientoOrigenTableEjercicio: TSmallintField;
    LineaMovimientoOrigenTableNroOperacion: TIntegerField;
    LineaMovimientoOrigenTableNroLinea: TSmallintField;
    LineaMovimientoOrigenTableFecha: TDateField;
    LineaMovimientoOrigenTableTipoMovimientoOrigen: TSmallintField;
    LineaMovimientoOrigenTableEjercicioOrigen: TSmallintField;
    LineaMovimientoOrigenTableNroOperacionOrigen: TIntegerField;
    LineaMovimientoOrigenTableNroRegistroOrigen: TIntegerField;
    LineaMovimientoOrigenTableUIDArticulo: TGuidField;
    LineaMovimientoOrigenTableCodigoArticulo: TWideStringField;
    LineaMovimientoOrigenTableCodigoClaseA: TWideStringField;
    LineaMovimientoOrigenTableCodigoClaseB: TWideStringField;
    LineaMovimientoOrigenTableCodigoClaseC: TWideStringField;
    LineaMovimientoOrigenTableLoteFabricacion: TWideStringField;
    LineaMovimientoOrigenTableNumeroSerie: TWideStringField;
    LineaMovimientoOrigenTableDescripcion: TWideStringField;
    LineaMovimientoOrigenTableCodigoAlmacen: TWideStringField;
    LineaMovimientoOrigenTableUbicacion: TWideStringField;
    LineaMovimientoOrigenTableCantidad: TBCDField;
    LineaMovimientoOrigenTableCantidadProcesada: TBCDField;
    LineaMovimientoOrigenTablePrecioDivisa: TBCDField;
    LineaMovimientoOrigenTablePrecio: TFloatField;
    LineaMovimientoOrigenTableRecargo: TBCDField;
    LineaMovimientoOrigenTablePuntoVerde: TBCDField;
    LineaMovimientoOrigenTableDescuento: TBCDField;
    LineaMovimientoOrigenTableNroCajas: TBCDField;
    LineaMovimientoOrigenTableLargo: TBCDField;
    LineaMovimientoOrigenTableAncho: TBCDField;
    LineaMovimientoOrigenTableAlto: TBCDField;
    LineaMovimientoOrigenTableNoCalcularMargen: TBooleanField;
    LineaMovimientoOrigenTableAnotacion: TWideMemoField;
    LinesViewManager: TGridTableViewController;
    LineaMovimientoOrigenTableAsignacionOrigen: TSmallintField;
    Data: TgxMemData;
    MemDataSource: TDataSource;
    DataCopiarDatosCabecera: TBooleanField;
    CopiarDatosCabeceraCtrl: TcxDBCheckBox;
    CodigoCtrlCaption: TcxLabel;
    Label10: TcxLabel;
    Label3: TcxLabel;
    Label6: TcxLabel;
    TituloDocumentoLabel: TcxLabel;
    OpcionesGroupBox: TcxGroupBox;
    HintLabel: TcxLabel;
    SerieLabel: TcxDBLabel;
    NroDocumentoLabel: TcxDBLabel;
    PropietarioLabel: TcxDBLabel;
    LineaMovimientoOrigenTableNroPagina: TSmallintField;
    LineaMovimientoOrigenTableNroRegistro: TUnsignedAutoIncField;
    PagesGrid: TcxGrid;
    PagesView: TcxGridDBTableView;
    PagesViewGrupoDocumento: TcxGridDBColumn;
    PagesViewDescripcion: TcxGridDBColumn;
    PagesLevel: TcxGridLevel;
    Splitter: TcxSplitter;
    GrupoLineaMovimientoOrigenTable: TnxeTable;
    GrupoLineaMovimientoOrigenTableSeleccionado: TBooleanField;
    GrupoLineaMovimientoDataSource: TDataSource;
    GrupoLineaMovimientoOrigenTableEjercicio: TSmallintField;
    GrupoLineaMovimientoOrigenTableNroOperacion: TIntegerField;
    GrupoLineaMovimientoOrigenTableNroPagina: TSmallintField;
    GrupoLineaMovimientoOrigenTableCodigoGrupo: TWideStringField;
    GrupoLineaMovimientoOrigenTableDescripcion: TWideStringField;
    GrupoLineaMovimientoOrigenTableAnotacion: TWideMemoField;
    PagesViewSeleccionado: TcxGridDBColumn;
    LinesViewNroRegistro: TcxGridDBColumn;
    PagesViewManager: TGridTableViewController;
    PagesViewNroPagina: TcxGridDBColumn;
    NoVincularDocumentosCtrl: TcxDBCheckBox;
    DataNoVincularDocumentos: TBooleanField;
    LineaMovimientoOrigenTableCantidadCargada: TBCDField;
    LinesViewCantidadCargada: TcxGridDBColumn;
    LineaMovimientoOrigenTableCantidadAjustada: TBCDField;
    LineaMovimientoOrigenTableBultos: TBCDField;
    LineaMovimientoOrigenTableTipoLinea: TWideStringField;
    LineaMovimientoOrigenTableOferta: TBooleanField;
    LineaMovimientoOrigenTableTara: TBCDField;
    LineaMovimientoOrigenTablePeso: TBCDField;
    LineaMovimientoOrigenTableCuotaIVA: TBCDField;
    LineaMovimientoOrigenTableCuotaRE: TBCDField;
    LineaMovimientoOrigenTablePrecioIVA: TBCDField;
    LineaMovimientoOrigenTableImporteTotal: TBCDField;
    LineaMovimientoOrigenTableCodigoTipoIVA: TSmallintField;
    NombreClienteLabel: TcxLabel;
    LineaMovimientoOrigenTableImporteDescuento2: TBCDField;
    LineaMovimientoOrigenTableImporteNeto: TBCDField;
    LineaMovimientoOrigenTableImporteBruto: TBCDField;
    LinesViewUbicacion: TcxGridDBColumn;
    LineaMovimientoOrigenTablePesoEnvase: TBCDField;
    LineaMovimientoOrigenTableParametros: TWordField;
    cxGroupBox2: TcxGroupBox;
    cxGroupBox3: TcxGroupBox;
    SeleccionDestinoGroupBox: TcxGroupBox;
    cxLabel2: TcxLabel;
    PathCtrl: TcxDBTextEdit;
    ExaminarButton: TgBitBtn;
    DataPath: TStringField;
    LineaMovimientoOrigenTableProcesada: TBooleanField;
    LineaMovimientoOrigenTableExistencias: TBCDField;
    LinesViewExistencias: TcxGridDBColumn;
    LineaMovimientoOrigenTableNoAfectarAStock: TBooleanField;
    LinesViewNoAfectarAStock: TcxGridDBColumn;
    LineaMovimientoOrigenTableContribucionRAP: TBCDField;
    procedure LinesViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure LineaMovimientoOrigenTableCalcFields(DataSet: TDataSet);
    procedure FormManagerInitializeForm;
    procedure FormManagerCreateForm;
    procedure FormManagerDestroyForm;
    procedure FormManagerOkButton;
    procedure TodoButtonClick(Sender: TObject);
    procedure LineaMovimientoOrigenTableFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure LinesViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure PagesViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure PagesViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure GrupoLineaMovimientoOrigenTableCalcFields(DataSet: TDataSet);
    procedure NoVincularDocumentosCtrlPropertiesValuePosted(
      Sender: TObject);
    procedure ExaminarButtonClick(Sender: TObject);
  private

    FPrimeraCopia : Boolean;
    FSeleccionDestinoVisible: Boolean;
    FOpcionesDocumentoVisible: Boolean;
    FAvisoStock : Boolean;
    
    procedure AllLines(Select: Boolean);
    function GetLineaMovimientoOrigenFields : TLineaMovimientoFields;
    procedure SetSeleccionDestinoVisible(const Value: Boolean);
    procedure SetOpcionesDocumentoVisible(const Value: Boolean);
    procedure UpdateFooterPanelHeight;

  protected
  class var
    TipoMovimiento  : TTipoMovimiento;
    Ejercicio : SmallInt;
    NroOperacion : LongInt;
    TipoMovimientoDestino : TTipoMovimiento;
    OnFilterRecord : TFilterLineRecordEvent;
    OnCalcFields : TCalcLineFieldsEvent;
    OnUpdateSelection : TUpdateSelectionEvent;
    PermitirCopiar,
    SeleccionarDestino : Boolean;

  public

    MovimientoOrigenFields : TMovimientoFields;
    GrupoLineaMovimientoOrigenFields : TGrupoLineaMovimientoFields;
    FLineaMovimientoOrigenFields : TLineaMovimientoFields;

    DsArticuloFields : TArticuloFields;
    
    PageList,
    LineList : TList<Integer>;

    DocumentosNoVinculados : Boolean;

    property LineaMovimientoOrigenFields : TLineaMovimientoFields read GetLineaMovimientoOrigenFields;
    property OpcionesDocumentoVisible : Boolean read FOpcionesDocumentoVisible write SetOpcionesDocumentoVisible;
    property SeleccionDestinoVisible : Boolean read FSeleccionDestinoVisible write SetSeleccionDestinoVisible;
  end;

var BoxMveForm: TBoxMveForm = nil;

procedure SeleccionaLineasDocumentoVenta( TipoMovimiento        : TTipoMovimiento;
                                          Ejercicio             : SmallInt;
                                          NroOperacion          : LongInt;
                                          TipoMovimientoDestino : TTipoMovimiento;
                                          OnUpdateSelection     : TUpdateSelectionEvent  = nil;

                                          OnFilterRecord        : TFilterLineRecordEvent = nil;
                                          OnCalcFields          : TCalcLineFieldsEvent = nil;
                                          PermitirCopiar        : Boolean = True;
                                          SeleccionarDestino    : Boolean = False );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       AppManager,
       Variants,

       Gdm00Dm,
       Gdm30Dm,
       Gim00Fields,

       dm_cls,
       dm_cli,
       dm_art,
       dm_fdv,
       dm_reg,
       dm_sto,

       a_mve,

       b_msg,
       b_dir;

resourceString
       RsMsg1 = 'Selección de líneas de %s';
const
       ncrPathSeleccionLineasDocumentoVenta = 'PathSeleccionLineasDocumentoVenta';

procedure SeleccionaLineasDocumentoVenta( TipoMovimiento                    : TTipoMovimiento;
                                          Ejercicio                         : SmallInt;
                                          NroOperacion                      : LongInt;
                                          TipoMovimientoDestino             : TTipoMovimiento;
                                          OnUpdateSelection                 : TUpdateSelectionEvent  = nil;

                                          OnFilterRecord                    : TFilterLineRecordEvent = nil;
                                          OnCalcFields                      : TCalcLineFieldsEvent = nil;
                                          PermitirCopiar                    : Boolean = True;
                                          SeleccionarDestino                : Boolean = False );
begin
     TBoxMveForm.TipoMovimiento := TipoMovimiento;
     TBoxMveForm.Ejercicio := Ejercicio;
     TBoxMveForm.NroOperacion := NroOperacion;
     TBoxMveForm.TipoMovimientoDestino := TipoMovimientoDestino;
     TBoxMveForm.OnFilterRecord := OnFilterRecord;
     TBoxMveForm.OnCalcFields := OnCalcFields;
     TBoxMveForm.OnUpdateSelection := OnUpdateSelection;
     TBoxMveForm.PermitirCopiar := PermitirCopiar;
     TBoxMveForm.SeleccionarDestino := SeleccionarDestino;
     CreateEditForm( TBoxMveForm, BoxMveForm );
end;

procedure TBoxMveForm.FormManagerInitializeForm;
begin

     Caption := Format( RsMsg1, [ Movimiento.TextoTipoMovimiento( TipoMovimiento ) ] );
     TituloDocumentoLabel.Caption := Movimiento.TextoTituloMovimiento( TipoMovimiento );
     If   Assigned( ApplicationContainer.AppSkinPainter )
     then TituloDocumentoLabel.Style.TextColor := ApplicationContainer.AppSkinPainter.DefaultEditorTextColor( True );

     Clase.SetupGridColumns( LinesViewCodigoClaseA, LinesViewCodigoClaseB, LinesViewCodigoClaseC );

     With DataModule00.DmEmpresaFields do
       begin

       FAvisoStock := ( TipoMovimientoDestino in [ tmVenta, tmHojaCarga ] ) and Stock_AvisoStock.Value;
       
       SetColumnsDecimals( [ LinesViewCantidad, LinesViewCantidadCargada, LinesViewServido ], Ventas_DecCantidad.Value );
       SetColumnDecimals( LinesViewExistencias, Ventas_DecCantidad.Value, True );
       SetColumnDecimals( LinesViewPrecio, Ventas_DecPrecio.Value );
       SetColumnDecimals( LinesViewDescuento, Ventas_DecDto.Value );
       SetColumnDecimals( LinesViewImporteNeto );

       LinesViewCodigoAlmacen.Visible:= Stock_MultiAlmacen.Value;
       LinesViewUbicacion.Visible:= Stock_Ubicaciones.Value;
       LinesViewExistencias.Visible := FAvisoStock;
       
       PagesGrid.Visible := DataModule00.PartidasPresupuestarias and Assigned( GrupoLineaMovimientoOrigenTable );
       Splitter.Visible := PagesGrid.Visible;

       end;

     SetOpcionesDocumentoVisible( TipoMovimientoDestino<>tmNoDefinido );
     SetSeleccionDestinoVisible( SeleccionarDestino );

     With MovimientoOrigenTable do
       If   not FindKey( [ Ejercicio, NroOperacion] )
       then begin
            ShowNotification( ntError, RsgMsg308, RsgMsg361 );
            Abort;
            end;

     DsArticuloFields := TArticuloFields.Create( Self );

     MovimientoOrigenFields := TMovimientoFields.Create( MovimientoOrigenTable );
     If   Assigned( GrupoLineaMovimientoOrigenTable )
     then GrupoLineaMovimientoOrigenFields := TGrupoLineaMovimientoFields.Create( GrupoLineaMovimientoOrigenTable );

     // Si es un pedido y ya se ha exportado, más vale no copiar los datos de la cabecera, no sea que, por ejemplo, se anoten las entregas a cuenta 2 veces
     
     CopiarDatosCabeceraCtrl.Enabled := ( TipoMovimientoDestino in [ tmPedidoCompra, tmPresupuesto..tmVenta ] ) and not ( ( TipoMovimientoDestino=tmVenta ) and ( MovimientoOrigenFields.TipoMovimiento.Value=tmPedidoVenta ) and ( MovimientoOrigenFields.Situacion.Value<>epPendiente ) );
     NoVincularDocumentosCtrl.Enabled := PermitirCopiar;

     If   not PagesGrid.Visible
     then GrupoLineaMovimientoOrigenTable.First;

     With Data do
       begin
       Active := True;
       Append;
       Edit;
       end;

     If   SeleccionarDestino
     then DataPath.Value := Registro.ObtenValorUsuario( ncrPathSeleccionLineasDocumentoVenta );

     NombreClienteLabel.Caption := Cliente.Descripcion( MovimientoOrigenFields.Propietario.Value );
     LinesGrid.Hint := SeleccioneLasLineasHintMsg;
     HintLabel.Caption := RemoveHintTags( SeleccioneLasLineasHintMsg );

     If   Movimiento.ModuloHojasDePedido
     then DataCopiarDatosCabecera.Value := True;

end;

procedure TBoxMveForm.ExaminarButtonClick(Sender: TObject);
begin
     SelectDirectory( DataPath );
end;

procedure TBoxMveForm.FormManagerCreateForm;
begin
     LineList := TList<Integer>.Create;
     PageList := TList<Integer>.Create;
end;

procedure TBoxMveForm.FormManagerDestroyForm;
begin
     PageList.Free;
     LineList.Free;
end;

procedure TBoxMveForm.FormManagerOkButton;

var  Index : SmallInt;
     LineArray : TLongIntArray;

begin
     try
       LineaMovimientoOrigenTable.DisableControls;
       try

         If   LineList.Count>0
         then begin
              SetLength( LineArray, LineList.Count );
                For Index := 0 to LineList.Count - 1 do
                  LineArray[ Index ] := LineList[ Index ];
              If   Assigned( OnUpdateSelection )
              then OnUpdateSelection( MovimientoOrigenFields, DataCopiarDatosCabecera.Value, DataNoVincularDocumentos.Value, LineArray );
              If   SeleccionarDestino
              then Registro.GuardaValorUsuario( ncrPathSeleccionLineasDocumentoVenta, DataPath.Value );
              end;
       finally
         LineaMovimientoOrigenTable.EnableControls;
         end;

     except on E : Exception do
       ShowException( E, Self );
     end;
end;

function TBoxMveForm.GetLineaMovimientoOrigenFields: TLineaMovimientoFields;
begin
     If   not Assigned( FLineaMovimientoOrigenFields )
     then FLineaMovimientoOrigenFields := TLineaMovimientoFields.Create( LineaMovimientoOrigenTable );
     Result := FLineaMovimientoOrigenFields;
end;

procedure TBoxMveForm.GrupoLineaMovimientoOrigenTableCalcFields(DataSet: TDataSet);
begin
     If   Assigned( PageList )
     then GrupoLineaMovimientoOrigenTableSeleccionado.Value := PageList.Contains( GrupoLineaMovimientoOrigenTableNroPagina.Value );
end;

procedure TBoxMveForm.AllLines( Select : Boolean);

var  Index : Integer;
     NroRegistro : Integer;

begin

     With LineaMovimientoOrigenTable do
       try
         DisableControls;
         First;
         While not Eof do
           begin
           NroRegistro := LineaMovimientoOrigenTableNroRegistro.Value;
           If   Select
           then begin
                If   not LineList.Contains( NroRegistro )
                then LineList.Add(NroRegistro );
                end
           else LineList.Remove( NroRegistro );

           Next;
           end;
       finally
         EnableControls;
         Refresh;
         GrupoLineaMovimientoOrigenTable.Refresh;
       end;

     If   CopiarDatosCabeceraCtrl.Enabled
     then DataCopiarDatosCabecera.Value := True;

end;

procedure TBoxMveForm.TodoButtonClick(Sender: TObject);

var  NroPagina : SmallInt;

begin
     If   Assigned( PagesView.Controller.FocusedRecord )
     then begin
          NroPagina := PagesView.Controller.FocusedRecord.Values[ PagesViewNroPagina.Index ];
          With PageList do
            If   not Contains( NroPagina )
            then Add( NroPagina );
          end;

     AllLines( True );
end;

procedure TBoxMveForm.LineaMovimientoOrigenTableCalcFields( DataSet : TDataSet );
begin
     If   Assigned( LineaMovimientoOrigenFields ) and
          Assigned( DsArticuloFields )
     then begin

          If   Assigned( LineList )
          then LineaMovimientoOrigenTableSeleccionado.Value := LineList.Contains( LineaMovimientoOrigenTableNroRegistro.Value );

          LineaMovimientoOrigenTableNoAfectarAstock.Value := False;

          If   LineaMovimientoOrigenTableCodigoArticulo.Value<>ArticuloManual
          then If   Articulo.Obten( LineaMovimientoOrigenTableCodigoArticulo.Value, DsArticuloFields )
               then begin
                    LineaMovimientoOrigenTableNoAfectarAStock.Value := DsArticuloFields.NoAfectarStock.Value;
                    If   FAvisoStock
                    then With LineaMovimientoOrigenFields do
                           LineaMovimientoOrigenTableExistencias.Value := StockAlmacen.ObtenStock( CodigoArticulo.Value,
                                                                                                   not DataModule00.DmEmpresaFields.Articulo_ExisteClase[ tcClaseA ].Value,
                                                                                                   CodigoClaseA.Value,
                                                                                                   CodigoClaseB.Value,
                                                                                                   CodigoClaseC.Value,
                                                                                                   ( LoteFabricacion.Value='' ) or not DataModule00.DmEmpresaFields.Stock_LotesProductos.Value,
                                                                                                   LoteFabricacion.Value,
                                                                                                   not DataModule00.DmEmpresaFields.Stock_MultiAlmacen.Value,
                                                                                                   CodigoAlmacen.Value,
                                                                                                   not DataModule00.DmEmpresaFields.Stock_Ubicaciones.Value,
                                                                                                   Ubicacion.Value,
                                                                                                   False,
                                                                                                   ApplicationContainer.Ejercicio,
                                                                                                   0,
                                                                                                   12 ).SumaExistencias.Saldo;
                     end;

          If   Assigned( OnCalcFields )
          then OnCalcFields( LineaMovimientoOrigenFields );
          end;
end;

procedure TBoxMveForm.LineaMovimientoOrigenTableFilterRecord(     DataSet : TDataSet;
                                                              var Accept  : Boolean );
begin
     If    ( ( TipoMovimiento=tmPedidoVenta ) and ( TipoMovimientoDestino=tmVenta ) ) and not DataNoVincularDocumentos.Value
     then Accept := ( LineaMovimientoOrigenFields.Cantidad.Value<=0.0 ) or  // Los articulos nulos (codigo '.') se tratan como cualquier otro artículo cuando ya se han entregada total o parcialmente
                    ( not LineaMovimientoOrigenTableProcesada.Value and ( ( LineaMovimientoOrigenTableCantidad.Value - LineaMovimientoOrigenTableCantidadProcesada.Value )>0.0 ) )
     else Accept := True;

     If   Assigned( OnFilterRecord )
     then OnFilterRecord( LineaMovimientoOrigenFields, Accept );
end;

procedure TBoxMveForm.NoVincularDocumentosCtrlPropertiesValuePosted(Sender: TObject);
begin
     GrupoLineaMovimientoOrigenTable.Refresh;
     LineaMovimientoOrigenTable.Refresh;
end;

procedure TBoxMveForm.PagesViewCustomDrawCell(    Sender    : TcxCustomGridTableView;
                                                  ACanvas   : TcxCanvas;
                                                  AViewInfo : TcxGridTableDataCellViewInfo;
                                              var ADone     : Boolean );
begin
     If   not AViewInfo.Selected
     then With AViewInfo.GridRecord do
            If   not VarIsNull( Values[ PagesViewSeleccionado.Index ] )
            then If   VarToBoolean( Values[ PagesViewSeleccionado.Index ] )
                 then ACanvas.Brush.Color := clRowHighlight;
end;

procedure TBoxMveForm.PagesViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);

var  NroPagina : Integer;

begin
     NroPagina := PagesView.Controller.FocusedRecord.Values[ PagesViewNroPagina.Index ];
     With PageList do
       begin
       If   Contains( NroPagina )
       then Remove( NroPagina )
       else Add( NroPagina );
       GrupoLineaMovimientoOrigenTable.Refresh;
       AllLines( Contains( NroPagina ) );
       end;
end;

procedure TBoxMveForm.SetOpcionesDocumentoVisible(const Value: Boolean);
begin
     FOpcionesDocumentoVisible := Value;
     CopiarDatosCabeceraCtrl.Visible := FOpcionesDocumentoVisible;
     NoVincularDocumentosCtrl.Visible := FOpcionesDocumentoVisible;
     UpdateFooterPanelHeight;
end;

procedure TBoxMveForm.SetSeleccionDestinoVisible(const Value: Boolean);
begin
     FSeleccionDestinoVisible := Value;
     PathCtrl.Enabled := FSeleccionDestinoVisible;   // Si no desactivo el campo se producirá un error de validación al ser obligatorio
     SeleccionDestinoGroupBox.Visible := FSeleccionDestinoVisible;
     UpdateFooterPanelHeight;
end;

procedure TBoxMveForm.UpdateFooterPanelHeight;

var  H : SmallInt;

begin
     H := ScaledToCurrent( 45 );
     If   FOpcionesDocumentoVisible
     then Inc( H, ScaledToCurrent( 24 ) );
     FooterPanel.Height := H;
end;

procedure TBoxMveForm.LinesViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                   ACanvas   : TcxCanvas;
                                                   AViewInfo : TcxGridTableDataCellViewInfo;
                                               var ADone     : Boolean);
begin
     If   not AViewInfo.Selected   // Solo se destaca la celda, por lo que no se oculta el color del resto
     then With AViewInfo.GridRecord do
            If   not VarIsNull( Values[ LinesViewSeleccionado.Index ] )
            then If   VarToBoolean( Values[ LinesViewSeleccionado.Index ] )
                 then ACanvas.Brush.Color := clRowHighlight
                 else If   FAvisoStock and 
                           ( VarToStr( Values[  LinesViewCodigoArticulo.Index ] )<>ArticuloManual ) and
                           not ( VarToBoolean( Values[ LinesViewNoAfectarAStock.Index ] ) ) and
                           ( VarToDecimal( Values[ LinesViewExistencias.Index ] )<VarToDecimal( Values[ LinesViewCantidad.Index ] ) )
                      then ACanvas.Brush.Color := clLightRed;                           
end;

procedure TBoxMveForm.LinesViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);

var  NroRegistro : Integer;

begin
     NroRegistro := LinesView.Controller.FocusedRecord.Values[ LinesViewNroRegistro.Index ];
     With LineList do
       begin
       If   Contains( NroRegistro )
       then Remove( NroRegistro )
       else Add( NroRegistro );
       LineaMovimientoOrigenTable.Refresh;
       end;
end;

end.


