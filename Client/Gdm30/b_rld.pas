unit b_rld;

interface

uses StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
     cxEdit, DB, cxDBData, nxdb, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
     cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
     DBCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,

     cxCalendar, dxSkinsCore, dxSkinsDefaultPainters,
     dxSkinscxPCPainter, cxContainer, cxGroupBox, cxLookAndFeels, cxNavigator,
     cxRichEdit, dxDateRanges, dxScrollbarAnnotations, cxLabel, dxUIAClasses,

     AppContainer,
     DataManager,
     EnterpriseDataAccess,
     AppForms,
     GridTableViewController,

     Gim10Fields,
     Gim30Fields,

     dmi_mov;

type
  TUpdateSelectionEvent = procedure( LineList : TList ) of object;

  TBrwRlvForm = class(TgxForm)
    FormManager: TgxFormManager;
    MovimientoTable: TnxeTable;
    MovimientoDataSource: TDataSource;
    LineaMovimientoTable: TnxeTable;
    LineaMovimientoDataSource: TDataSource;
    DataPanel: TgxEditPanel;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
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
    TableViewCodigoAlmacen: TcxGridDBColumn;
    LineaMovimientoTableImporteNeto: TBCDField;
    LineaMovimientoTableImporteDescuento: TBCDField;
    LineaMovimientoTableImporteBruto: TBCDField;
    LineaMovimientoTableEjercicio: TSmallintField;
    LineaMovimientoTableNroOperacion: TIntegerField;
    LineaMovimientoTableNroLinea: TSmallintField;
    LineaMovimientoTableTipoMovimientoOrigen: TSmallintField;
    LineaMovimientoTableEjercicioOrigen: TSmallintField;
    LineaMovimientoTableNroOperacionOrigen: TIntegerField;
    LineaMovimientoTableNroRegistroOrigen: TIntegerField;
    LineaMovimientoTableUIDArticulo: TGuidField;
    LineaMovimientoTableCodigoArticulo: TWideStringField;
    LineaMovimientoTableCodigoClaseA: TWideStringField;
    LineaMovimientoTableCodigoClaseB: TWideStringField;
    LineaMovimientoTableCodigoClaseC: TWideStringField;
    LineaMovimientoTableLoteFabricacion: TWideStringField;
    LineaMovimientoTableNumeroSerie: TWideStringField;
    LineaMovimientoTableDescripcion: TWideStringField;
    LineaMovimientoTableCodigoAlmacen: TWideStringField;
    LineaMovimientoTableUbicacion: TWideStringField;
    LineaMovimientoTableCantidad: TBCDField;
    LineaMovimientoTableCantidadProcesada: TBCDField;
    LineaMovimientoTablePrecioDivisa: TBCDField;
    LineaMovimientoTableRecargo: TBCDField;
    LineaMovimientoTablePuntoVerde: TBCDField;
    LineaMovimientoTableDescuento: TBCDField;
    LineaMovimientoTableNroCajas: TBCDField;
    LineaMovimientoTableLargo: TBCDField;
    LineaMovimientoTableAncho: TBCDField;
    LineaMovimientoTableAlto: TBCDField;
    LineaMovimientoTableNoCalcularMargen: TBooleanField;
    LineaMovimientoTableAnotacion: TWideMemoField;
    LineaMovimientoTableCantidadAjustada: TBCDField;
    TableViewUbicacion: TcxGridDBColumn;
    TableViewNroCajas: TcxGridDBColumn;
    TableViewLargo: TcxGridDBColumn;
    TableViewAncho: TcxGridDBColumn;
    TableViewAlto: TcxGridDBColumn;
    TableViewRecargo: TcxGridDBColumn;
    LineaMovimientoTableTextoDocumento: TWideStringField;
    TableViewTextoDocumento: TcxGridDBColumn;
    LineaMovimientoTableFecha: TDateField;
    TableViewManager: TGridTableViewController;
    LineaMovimientoTableAsignacionOrigen: TSmallintField;
    LineaMovimientoTableNroPagina: TSmallintField;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    CloseButton: TgBitBtn;
    LineaMovimientoTableNroRegistro: TUnsignedAutoIncField;
    LineaMovimientoTableBultos: TBCDField;
    LineaMovimientoTableTipoLinea: TWideStringField;
    LineaMovimientoTableOferta: TBooleanField;
    LineaMovimientoTableTara: TBCDField;
    LineaMovimientoTablePeso: TBCDField;
    LineaMovimientoTableCodigoTipoIVA: TSmallintField;
    LineaMovimientoTableCuotaIVA: TBCDField;
    LineaMovimientoTableCuotaRE: TBCDField;
    LineaMovimientoTablePrecioIVA: TBCDField;
    LineaMovimientoTableImporteTotal: TBCDField;
    LineaMovimientoTablePrecio: TFloatField;
    LineaMovimientoTablePesoEnvase: TBCDField;
    LineaMovimientoTableProcesada: TBooleanField;
    LineaMovimientoTableParametros: TWordField;
    LineaMovimientoTableFechaAplicacion: TDateField;
    LineaMovimientoTableFechaCaducidad: TDateField;
    LineaMovimientoTableCampoLibre1: TWideStringField;
    LineaMovimientoTableCampoLibre2: TWideStringField;
    LineaMovimientoTableCampoLibre3: TDateField;
    LineaMovimientoTableCampoLibre4: TBCDField;
    LineaMovimientoTableImporteRecargo: TBCDField;
    LineaMovimientoTablePorcentajeRecargo: TBCDField;
    LineaMovimientoTableCampoLibre5: TWideStringField;
    GridTableViewPanel: TGridTableViewPanel;
    GridTableViewPanelLabel1: TGridTableViewPanelLabel;
    AltoPanelLabel: TGridTableViewPanelLabel;
    LineaMovimientoTableContribucionRAP: TBCDField;
    procedure LineaMovimientoTableCalcFields(DataSet: TDataSet);
    procedure FormManagerInitializeForm;
    procedure TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure LineaMovimientoTableFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TableViewCustomDrawGroupCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableCellViewInfo;
      var ADone: Boolean);
  private
  protected

  public

    class var
    TipoMovimiento : TTipoMovimiento;
    Ejercicio : SmallInt;
    Serie : String;
    NroOperacion,
    NroDocumento,
    NroRegistroLinea : LongInt;

    MovimientoFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;

    NroOperacionActual : LongInt;
  end;


var BrwRlvForm: TBrwRlvForm = nil;

procedure RelacionLineasDocumento( TipoMovimiento : TTipoMovimiento;
                                   Ejercicio      : SmallInt;
                                   NroOperacion   : LongInt;
                                   Serie          : String;
                                   NroDocumento   : LongInt ); overload;

procedure RelacionLineasDocumento( NroRegistroLinea : LongInt ); overload;

implementation

{$R *.DFM}

uses   SysUtils,
       Math,
       Variants,

       LibUtils,

       Gdm00Dm,
       Gim00Fields,

       dm_cls,
       dm_pro,
       dm_cli,
       dm_art,
       dm_mov,
       dm_fdv,

       a_mov,

       b_msg;

resourceString
       RsMsg1 = 'el registro de la línea seleccionada.';

procedure RelacionLineasDocumento( TipoMovimiento : TTipoMovimiento;
                                   Ejercicio      : SmallInt;
                                   NroOperacion   : LongInt;
                                   Serie          : String;
                                   NroDocumento   : LongInt );
begin

     TBrwRlvForm.TipoMovimiento := TipoMovimiento;
     TBrwRlvForm.Ejercicio := Ejercicio;
     TBrwRlvForm.Serie := Serie;
     TBrwRlvForm.NroOperacion := NroOperacion;
     TBrwRlvForm.NroDocumento := NroDocumento;
     TBrwRlvForm.NroRegistroLinea := 0;
     CreateEditForm( TBrwRlvForm, BrwRlvForm );
end;

procedure RelacionLineasDocumento( NroRegistroLinea : LongInt );
begin
     TBrwRlvForm.NroRegistroLinea := NroRegistroLinea;
     CreateEditForm( TBrwRlvForm, BrwRlvForm );
end;

procedure TBrwRlvForm.FormManagerInitializeForm;
begin

     Id := IdBrwRlvForm;

     Clase.SetupGridColumns( TableViewCodigoClaseA, TableViewCodigoClaseB, TableViewCodigoClaseC );

     With DataModule00.DmEmpresaFields do
       begin

       TableViewCodigoAlmacen.Visible := Stock_MultiAlmacen.Value;
       TableViewUbicacion.Visible := Stock_Ubicaciones.Value;
       TableViewNroCajas.Visible := Articulo_Cajas.Value;
       TableViewLargo.Visible := ( Compras_Cantidades.Value>0 ) or ( Ventas_Cantidades.Value>0 );
       TableViewAncho.Visible := ( Compras_Cantidades.Value>0 ) or ( Ventas_Cantidades.Value>0 );
       TableViewAlto.Visible := ( Compras_Cantidades.Value>1 ) or ( Ventas_Cantidades.Value>1 );
       TableViewRecargo.Visible := Ventas_Recargos.Value;

       SetColumnDecimals( TableViewCantidad, Max( Compras_DecCantidad.Value, Ventas_DecCantidad.Value ) );
       SetColumnsDecimals( [ TableViewPrecio, TableViewRecargo ], Max( Compras_DecPrecio.Value, Ventas_DecPrecio.Value ) );
       SetColumnDecimals( TableViewDescuento, Max( Compras_DecDto.Value, Ventas_DecDto.Value ) );
       SetColumnDecimals( TableViewImporteNeto );
       SetColumnsDecimals( [ TableViewLargo, TableViewAncho, TableViewAlto ], Max( Compras_DecCantidad.Value, Ventas_DecCantidad.Value ) );
       SetColumnDecimals( TableViewNroCajas, Max( Compras_DecCajas.Value, Ventas_DecCajas.Value ) );

       TableViewAlto.Caption := '';
       TableViewNroCajas.Caption := '';
       
       If   not ValueIsEmpty( Compras_NombreCajas.Value )
       then If   Compras_Cantidades.Value=2
            then TableViewAlto.Caption := Compras_NombreCajas.Value
            else TableViewNroCajas.Caption := Compras_NombreCajas.Value;

       If   not ValueIsEmpty( Ventas_NombreCajas.Value )
       then If   Ventas_Cantidades.Value=2
            then TableViewAlto.Caption := IfThen( ( TableViewAlto.Caption='' ) or ( Compras_NombreCajas.Value=Ventas_NombreCajas.Value), '', TableViewAlto.Caption + ' / ' ) + Ventas_NombreCajas.Value
            else TableViewNroCajas.Caption := IfThen( ( TableViewNroCajas.Caption='' ) or ( Compras_NombreCajas.Value=Ventas_NombreCajas.Value ), '', TableViewNroCajas.Caption + ' / ' ) + Ventas_NombreCajas.Value;
            
       end;

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );

     If   NroRegistroLinea=0
     then begin
          Caption := Caption +
                     IfThen( ( Movimiento.ModuloHojasDePedido and ( TipoMovimiento=tmPedidoVenta ) ) or ( TipoMovimiento=tmOferta ), 'la ', 'el ' ) +
                     Movimiento.TextoTipoMovimiento( TipoMovimiento, False ) + ' ' + IfThen( Serie='', '', Serie + ' ' ) + IntToStr( NroDocumento );
          LineaMovimientoTable.IndexFieldNames := 'TipoMovimientoOrigen;EjercicioOrigen;NroOperacionOrigen';
          LineaMovimientoTable.SetRange( [ Ord( TipoMovimiento ), Ejercicio, NroOperacion ] );
          end
     else begin
          Caption := Caption + RsMsg1;
          LineaMovimientoTable.IndexFieldNames := 'NroRegistroOrigen';
          LineaMovimientoTable.SetRange( [ NroRegistroLinea ] );
          end;

     Grid.Hint := AccedaAldocumentoHintMsg;

     NroOperacionActual := 0;
     LineaMovimientoDataSource.Enabled := True;
     TableView.ViewData.Expand( True );

end;

procedure TBrwRlvForm.LineaMovimientoTableCalcFields(DataSet: TDataSet);

var  Found : Boolean;
     TextoDocumento : String;

begin
     If   Assigned( MovimientoFields ) and LineaMovimientoDataSource.Enabled
     then If   MovimientoTable.FindKey( [ LineaMovimientoTableEjercicio.Value, LineaMovimientoTableNroOperacion.Value ] )
          then begin
               TextoDocumento := Movimiento.TextoTipoMovimiento( MovimientoFields.TipoMovimiento.Value, False, True ) + ' : ' + 
                                 IfThen( MovimientoFields.Serie.Value='', '', MovimientoFields.Serie.Value + ' ' ) + 
                                 IntToStr( MovimientoFields.NroDocumento.Value ) +
                                 ' de fecha ' + StrFormatDate( MovimientoFields.Fecha.Value );
               If   MovimientoFields.TipoMovimiento.Value in [ tmOferta..tmCompra ]
               then LineaMovimientoTableTextoDocumento.Value := TextoDocumento + '. Proveedor : ' + MovimientoFields.Propietario.Value + ' , ' +  Proveedor.Descripcion( MovimientoFields.Propietario.Value, True )
               else LineaMovimientoTableTextoDocumento.Value := TextoDocumento + '. Cliente : ' + MovimientoFields.Propietario.Value + ' , ' +  Cliente.Descripcion( MovimientoFields.Propietario.Value, True );
               end;
end;

procedure TBrwRlvForm.LineaMovimientoTableFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
     {
     If   Assigned( MovimientoFields )
     then If   MovimientoTable.FindKey( [ LineaMovimientoTableEjercicio.Value, LineaMovimientoTableNroOperacion.Value ] )
          then Accept := MovimientoFields.TipoMovimiento.Value=tmVenta
          else Accept := False;
     }
end;

procedure TBrwRlvForm.TableViewCustomDrawGroupCell(      Sender    : TcxCustomGridTableView;
                                                         ACanvas   : TcxCanvas;
                                                         AViewInfo : TcxGridTableCellViewInfo;
                                                     var ADone     : Boolean);
begin
     With ACanvas do
       begin
       Brush.Color := cl3DLight; // clBtnShadow;
       Font.Color := clBlack;
       end;
end;

procedure TBrwRlvForm.TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);

var  AGridRecord : TcxCustomGridRecord;

begin
     AGridRecord := TableView.Controller.FocusedRecord;
     If   not VarIsNull( AGridRecord.Values[ TableViewNroLinea.Index ] )
     then MntMovimientosPorNroRegistro( LineaMovimientoFields.NroRegistro.Value, LineaMovimientoFields );
end;

end.


