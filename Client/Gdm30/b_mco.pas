unit b_mco;

interface

uses StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics, Generics.Collections,

     AppContainer,

     Gim10Fields,
     Gim30Fields,

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
     DataManager,
     EnterpriseDataAccess,
     cxGridLevel,
     cxClasses,
     cxControls,
     cxGridCustomView,
     cxGridCustomTableView,
     cxGridTableView,
     cxGridDBTableView,
     cxGrid, DBCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,

     cxRichEdit, cxContainer, cxDBEdit, dxmdaset, dxSkinsCore,
     dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, cxLabel,
     cxGroupBox, cxDBLabel, cxNavigator, dxBevel, dxDateRanges,

     dmi_mov,

     dm_mov,

     AppForms,
     GridTableViewController, dxScrollbarAnnotations, dxUIAClasses;

type
  TBoxMcoForm = class(TgxForm)
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
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    TableViewSeleccionado: TcxGridDBColumn;
    TableViewNroLinea: TcxGridDBColumn;
    TableViewCodigoArticulo: TcxGridDBColumn;
    TableViewCodigoClaseA: TcxGridDBColumn;
    TableViewCodigoClaseB: TcxGridDBColumn;
    TableViewCodigoClaseC: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewCantidad: TcxGridDBColumn;
    TableViewPrecio: TcxGridDBColumn;
    TableViewDescuento: TcxGridDBColumn;
    TableViewImporteNeto: TcxGridDBColumn;
    TableViewAnotacion: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    Panel2: TcxGroupBox;
    BitBtn1: TgBitBtn;
    TableViewRecibido: TcxGridDBColumn;
    TableViewCodigoAlmacen: TcxGridDBColumn;
    LineaMovimientoOrigenTableImporteNeto: TBCDField;
    LineaMovimientoOrigenTableImporteDescuento: TBCDField;
    LineaMovimientoOrigenTableImporteBruto: TBCDField;
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
    TableViewManager: TGridTableViewController;
    LineaMovimientoOrigenTableAsignacionOrigen: TSmallintField;
    MemDataSource: TDataSource;
    Data: TgxMemData;
    DataCopiarDatosCabecera: TBooleanField;
    CopiarDatosCabeceraCtrl: TcxDBCheckBox;
    codigoCtrlCaption: TcxLabel;
    Label10: TcxLabel;
    Label3: TcxLabel;
    Label6: TcxLabel;
    TituloDocumentoLabel: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    HintLabel: TcxLabel;
    TableViewNroRegistro: TcxGridDBColumn;
    SerieLabel: TcxDBLabel;
    FechaLabel: TcxDBLabel;
    PropietarioLabel: TcxDBLabel;
    FechaAplicacionLabel: TcxDBLabel;
    LineaMovimientoOrigenTableNroPagina: TSmallintField;
    LineaMovimientoOrigenTableNroRegistro: TUnsignedAutoIncField;
    DataNoVincularDocumentos: TBooleanField;
    NoVincularDocumentosCtrl: TcxDBCheckBox;
    LineaMovimientoOrigenTableBultos: TBCDField;
    LineaMovimientoOrigenTableTipoLinea: TWideStringField;
    LineaMovimientoOrigenTableCantidadAjustada: TBCDField;
    LineaMovimientoOrigenTableOferta: TBooleanField;
    LineaMovimientoOrigenTableTara: TBCDField;
    LineaMovimientoOrigenTablePeso: TBCDField;
    LineaMovimientoOrigenTableCodigoTipoIVA: TSmallintField;
    LineaMovimientoOrigenTableCuotaIVA: TBCDField;
    LineaMovimientoOrigenTableCuotaRE: TBCDField;
    LineaMovimientoOrigenTablePrecioIVA: TBCDField;
    LineaMovimientoOrigenTableImporteTotal: TBCDField;
    NombreProveedorLabel: TcxLabel;
    TableViewUbicacion: TcxGridDBColumn;
    LineaMovimientoOrigenTablePesoEnvase: TBCDField;
    LineaMovimientoOrigenTableProcesada: TBooleanField;
    LineaMovimientoOrigenTableParametros: TWordField;
    LineaMovimientoOrigenTableFechaAplicacion: TDateField;
    LineaMovimientoOrigenTableContribucionRAP: TBCDField;
    procedure TableViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure LineaMovimientoOrigenTableCalcFields(DataSet: TDataSet);
    procedure FormManagerInitializeForm;
    procedure FormManagerCreateForm;
    procedure FormManagerDestroyForm;
    procedure FormManagerOkButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure LineaMovimientoOrigenTableFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure NoVincularDocumentosCtrlPropertiesValuePosted(
      Sender: TObject);
  private

    function GetLineaMovimientoOrigenFields : TLineaMovimientoFields;
  protected
  class var
    TipoMovimiento  : TTipoMovimiento;
    Ejercicio : SmallInt;
    NroOperacion : LongInt;
    TipoMovimientoDestino : TTipoMovimiento;
    OnUpdateSelection : TUpdateSelectionEvent;

  public

    MovimientoOrigenFields : TMovimientoFields;
    FLineaMovimientoOrigenFields : TLineaMovimientoFields;

    LineList : TList<Integer>;

    property LineaMovimientoOrigenFields : TLineaMovimientoFields read GetLineaMovimientoOrigenFields;
  end;

var BoxMcoForm: TBoxMcoForm = nil;

procedure SeleccionaLineasDocumentoCompra( TipoMovimiento         : TTipoMovimiento;
                                           Ejercicio              : SmallInt;
                                           NroOperacion           : LongInt;
                                           TipoMovimientoDestino  : TTipoMovimiento;                                           
                                           OnUpdateSelection      : TUpdateSelectionEvent  = nil );

implementation

{$R *.DFM}

uses   Variants,

       SysUtils,
       LibUtils,
       AppManager,

       Gdm00Dm,
       Gim00Fields,

       dm_cls,
       dm_pro,
       dm_art,
       dm_fdc,

       a_mco,

       b_msg;

resourceString
       RsMsg1 = 'Selección de líneas de %s';

procedure SeleccionaLineasDocumentoCompra( TipoMovimiento        : TTipoMovimiento;
                                           Ejercicio             : SmallInt;
                                           NroOperacion          : LongInt;
                                           TipoMovimientoDestino : TTipoMovimiento;
                                           OnUpdateSelection     : TUpdateSelectionEvent = nil );
begin
     TBoxmcoForm.TipoMovimiento := TipoMovimiento;
     TBoxmcoForm.Ejercicio := Ejercicio;
     TBoxmcoForm.NroOperacion := NroOperacion;
     TBoxmcoForm.TipoMovimientoDestino := TipoMovimientoDestino;
     TBoxmcoForm.OnUpdateSelection := OnUpdateSelection;
     CreateEditForm( TBoxMcoForm, BoxMcoForm );
end;

procedure TBoxMcoForm.FormManagerInitializeForm;
begin

     Caption := Format( RsMsg1, [ Movimiento.TextoTipoMovimiento( TipoMovimiento ) ] );
     TituloDocumentoLabel.Caption := Movimiento.TextoTituloMovimiento( TipoMovimiento );
     If   Assigned( ApplicationContainer.AppSkinPainter )
     then TituloDocumentoLabel.Style.TextColor := ApplicationContainer.AppSkinPainter.DefaultEditorTextColor( True );

     Clase.SetupGridColumns( TableViewCodigoClaseA, TableViewCodigoClaseB, TableViewCodigoClaseC );

     With DataModule00.DmEmpresaFields do
       begin
       SetColumnDecimals( TableViewCantidad, Compras_DecCantidad.Value );
       SetColumnDecimals( TableViewRecibido, Compras_DecCantidad.Value );
       SetColumnDecimals( TableViewPrecio, Compras_DecPrecio.Value );
       SetColumnDecimals( TableViewDescuento, Compras_DecDto.Value );
       SetColumnDecimals( TableViewImporteNeto );

       TableViewCodigoAlmacen.Visible:= Stock_MultiAlmacen.Value;
       TableViewUbicacion.Visible:= Stock_Ubicaciones.Value;
       end;

     With MovimientoOrigenTable do
       If   not FindKey( [ Ejercicio, NroOperacion] )
       then begin
            ShowNotification( ntError, RsgMsg308, RsgMsg361 );
            Abort;
            end;

     MovimientoOrigenFields := TMovimientoFields.Create( MovimientoOrigenTable );

     CopiarDatosCabeceraCtrl.Enabled := TipoMovimientoDestino in [ tmOferta..tmCompra ];

     With Data do
       begin
       Active := True;
       Append;
       Edit;
       end;

     NombreProveedorLabel.Caption := Proveedor.Descripcion( MovimientoOrigenFields.Propietario.Value );
     Grid.Hint := SeleccioneLasLineasHintMsg;
     HintLabel.Caption := RemoveHintTags( SeleccioneLasLineasHintMsg );

end;

procedure TBoxMcoForm.FormManagerCreateForm;
begin
     LineList := TList<Integer>.Create;
end;

procedure TBoxMcoForm.FormManagerDestroyForm;
begin
     LineList.Free;
end;

function TBoxMcoForm.GetLineaMovimientoOrigenFields: TLineaMovimientoFields;
begin
     If   not Assigned( FLineaMovimientoOrigenFields )
     then FLineaMovimientoOrigenFields := TLineaMovimientoFields.Create( LineaMovimientoOrigenTable );
     Result := FLineaMovimientoOrigenFields;
end;

procedure TBoxMcoForm.FormManagerOkButton;

var  Index : SmallInt;
     LineArray : TLongIntArray;

begin
     try
       If   LineList.Count>0
       then begin
            SetLength( LineArray, LineList.Count );
            For Index := 0 to LineList.Count - 1 do
              LineArray[ Index ] := LineList[ Index ];
            If   Assigned( OnUpdateSelection )
            then OnUpdateSelection( MovimientoOrigenFields, DataCopiarDatosCabecera.Value, DataNoVincularDocumentos.Value, LineArray );
            end;
     except on E : Exception do ShowException( E, Self );
       end;
end;

procedure TBoxMcoForm.BitBtn1Click(Sender: TObject);

var  NroRegistro,
     Index : Integer;

begin

     With LineaMovimientoOrigenTable do
       try
         DisableControls;
         First;
         While not Eof do
           begin
           NroRegistro := LineaMovimientoOrigenTableNroRegistro.Value;
           If   not LineList.Contains( NroRegistro )
           then LineList.Add( NroRegistro );
           Next;
           end;
       finally
         EnableControls;
         Refresh;
       end;

     If   CopiarDatosCabeceraCtrl.Enabled
     then DataCopiarDatosCabecera.Value := True;
end;

procedure TBoxMcoForm.LineaMovimientoOrigenTableCalcFields(DataSet: TDataSet);
begin
     If   Assigned( LineaMovimientoOrigenFields ) and Assigned( LineList )
     then LineaMovimientoOrigenTableSeleccionado.Value := LineList.Contains( LineaMovimientoOrigenTableNroRegistro.Value );          
end;

procedure TBoxMcoForm.LineaMovimientoOrigenTableFilterRecord( DataSet: TDataSet; var Accept: Boolean);
begin
     If   ( ( TipoMovimiento=tmPedidoCompra ) and ( TipoMovimientoDestino=tmCompra ) ) and not DataNoVincularDocumentos.Value
     then Accept := ( LineaMovimientoOrigenTableCodigoArticulo.Value=ArticuloManual ) or
                    ( LineaMovimientoOrigenFields.Cantidad.Value<=0.0 ) or
                    ( not LineaMovimientoOrigenTableProcesada.Value and ( ( LineaMovimientoOrigenTableCantidad.Value - LineaMovimientoOrigenTableCantidadProcesada.Value )>0.0 ) )
     else Accept := True;
end;

procedure TBoxMcoForm.NoVincularDocumentosCtrlPropertiesValuePosted(Sender: TObject);
begin
     LineaMovimientoOrigenTable.Refresh;
end;

procedure TBoxMcoForm.TableViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                   ACanvas   : TcxCanvas;
                                                   AViewInfo : TcxGridTableDataCellViewInfo;
                                               var ADone     : Boolean);
begin
     If   not AViewInfo.Selected
     then With AViewInfo.GridRecord do
            If   not VarIsNull( Values[ TableViewSeleccionado.Index ] )
            then If   VarToBoolean( Values[ TableViewSeleccionado.Index ] )
                 then ACanvas.Brush.Color := clRowHighlight;
end;

procedure TBoxMcoForm.TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);

var  NroRegistro : Integer;

begin
     NroRegistro := TableView.Controller.FocusedRecord.Values[ TableViewNroRegistro.Index ];
     With LineList do
       begin
       If   Contains( NroRegistro )
       then Remove( NroRegistro )
       else Add( NroRegistro );
       LineaMovimientoOrigenTable.Refresh;
       end;
end;

end.


