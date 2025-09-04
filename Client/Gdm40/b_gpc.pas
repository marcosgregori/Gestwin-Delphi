
unit b_gpc;

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
     cxGroupBox, cxDBLabel, cxTextEdit, cxSplitter,
     cxMaskEdit, cxDropDownEdit, cxCalendar, cxIntegerEdit,dxDateRanges,
     Generics.Collections, cxNavigator, cxCheckComboBox, dxBevel,

     DataManager,
     AppContainer,
     LibUtils,

     Gim10Fields,
     Gim30Fields,

     EnterpriseDataAccess,
     AppForms,
     GridTableViewController,

     dmi_mov,
     dm_mov, dxScrollbarAnnotations, dxUIAClasses;

type

  TSelectOperation = ( soCheck, soUncheck, soSwitch );
  TCheckSelect = reference to function( var Select : TSelectOperation ) : Boolean;

  TBoxGpcForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    LineaMovimientoQuery: TnxeQuery;
    LineaMovimientoDataSource: TDataSource;
    LineaMovimientoQuerySeleccionLinea: TBooleanField;
    DataPanel: TgxEditPanel;
    LinesGrid: TcxGrid;
    LinesView: TcxGridDBTableView;
    LinesViewSeleccionLinea: TcxGridDBColumn;
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
    LinesLevel: TcxGridLevel;
    FooterPanel: TcxGroupBox;
    LinesViewServido: TcxGridDBColumn;
    LinesViewCodigoAlmacen: TcxGridDBColumn;
    LineaMovimientoQueryEjercicio: TSmallintField;
    LineaMovimientoQueryNroOperacion: TIntegerField;
    LineaMovimientoQueryNroLinea: TSmallintField;
    LineaMovimientoQueryFecha: TDateField;
    LineaMovimientoQueryCodigoArticulo: TWideStringField;
    LineaMovimientoQueryCodigoClaseA: TWideStringField;
    LineaMovimientoQueryCodigoClaseB: TWideStringField;
    LineaMovimientoQueryCodigoClaseC: TWideStringField;
    LineaMovimientoQueryLoteFabricacion: TWideStringField;
    LineaMovimientoQueryNumeroSerie: TWideStringField;
    LineaMovimientoQueryDescripcion: TWideStringField;
    LineaMovimientoQueryCodigoAlmacen: TWideStringField;
    LineaMovimientoQueryUbicacion: TWideStringField;
    LineaMovimientoQueryCantidad: TBCDField;
    LineaMovimientoQueryCantidadProcesada: TBCDField;
    LineaMovimientoQueryPrecioDivisa: TBCDField;
    LineaMovimientoQueryPrecio: TFloatField;
    LineaMovimientoQueryRecargo: TBCDField;
    LineaMovimientoQueryPuntoVerde: TBCDField;
    LineaMovimientoQueryDescuento: TBCDField;
    LineaMovimientoQueryAnotacion: TWideMemoField;
    LinesViewManager: TGridTableViewController;
    Data: TgxMemData;
    DataSource: TDataSource;
    LinesViewNroRegistro: TcxGridDBColumn;
    LineaMovimientoQueryCantidadCargada: TBCDField;
    LinesViewCantidadCargada: TcxGridDBColumn;
    LineaMovimientoQueryCantidadAjustada: TBCDField;
    LineaMovimientoQueryImporteNeto: TBCDField;
    LinesViewUbicacion: TcxGridDBColumn;
    LineaMovimientoQueryProcesada: TBooleanField;
    HintLabel: TcxLabel;
    TodoButton: TgBitBtn;
    DataCodigoProveedor: TStringField;
    DataFechaEntrega: TBooleanField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    LineaMovimientoTable: TnxeTable;
    MovimientoTable: TnxeTable;
    LineaMovimientoQueryFechaAplicacion: TDateField;
    LineaMovimientoQueryNroRegistro: TLongWordField;
    LineaMovimientoQueryCabeceraPedido: TStringField;
    LinesViewCabeceraPedido: TcxGridDBColumn;
    LineaMovimientoQuerySerie: TWideStringField;
    LineaMovimientoQueryNroDocumento: TIntegerField;
    DataSerie: TStringField;
    DataFecha: TDateField;
    LinesViewEjercicio: TcxGridDBColumn;
    LineaMovimientoQueryCodigoProveedor: TWideStringField;
    LineaMovimientoQueryCabeceraProveedor: TStringField;
    LineaMovimientoQuerySeleccionProveedor: TBooleanField;
    LineaMovimientoQuerySeleccionPedido: TBooleanField;
    LinesViewCabeceraProveedor: TcxGridDBColumn;
    LineaMovimientoQueryPropietario: TWideStringField;
    KeyPanel: TgxEditPanel;
    Label3: TcxLabel;
    CodigoProveedorCtrl: TcxDBTextEdit;
    Label16: TcxLabel;
    NroDocumentoCaptionLabel: TcxLabel;
    SerieCtrl: TcxDBTextEdit;
    cxLabel2: TcxLabel;
    FechaCtrl: TcxDBDateEdit;
    cxGroupBox1: TcxGroupBox;
    Label6: TcxLabel;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    cxLabel1: TcxLabel;
    IncluirIVACtrl: TcxDBCheckBox;
    cxGroupBox2: TcxGroupBox;
    procedure LinesViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure LineaMovimientoQueryCalcFields(DataSet: TDataSet);
    procedure FormManagerInitializeForm;
    procedure FormManagerCreateForm;
    procedure FormManagerDestroyForm;
    procedure FormManagerOkButton;
    procedure TodoButtonClick(Sender: TObject);
    procedure LineaMovimientoQueryFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure LinesViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure CodigoProveedorCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure LinesViewCabeceraProveedorGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure LinesViewCabeceraPedidoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure FormManagerFocusedAreaChanged;
  private

    FAllSelected,
    FChangingDataArea : Boolean;
    
    FSeleccionadas : Integer;

    procedure UpdateSelection;
    procedure SelectLines( SelectFunction : TCheckSelect );
    procedure DoOnListNotity( Sender: TObject; const Item: Integer; Action: TCollectionNotification );
    procedure DoProcesoGeneracionPedidos;
    procedure DisableDataGrid;
    procedure ReiniciaSeleccion;

  protected

  
  public

    MovimientoFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;

    LineList : TList<Integer>;

  end;

var BoxGpcForm: TBoxGpcForm = nil;

procedure GeneracionPedidosCompra;

implementation

{$R *.DFM}

uses   SysUtils,
       AppManager,
       Variants,

       Gdm00Dm,
       Gdm30Dm,
       Gim00Fields,

       dm_cls,
       dm_cli,
       dm_art,
       dm_pro,
       dm_fdv,
       dm_reg,

       a_pro,
       a_mco,

       cx_pro,

       b_msg,
       b_pro,

       f_prg;

resourceString
       RsMsg1  = 'No hay ningun registro que cumpla las condiciones impuestas.';
       RsMsg2  = 'Cambie el criterio de selección y reintente el proceso.';
       RsMsg3  = 'No ha seleccionado ninguna línea.';
       RsMsg4  = 'Generación de pedidos de compra';
       RsMsg5  = 'Creado el pedido nº %s %d del proveedor %s, %s.';
       RsMsg7  = 'Ha modificado la relación de registros';
       RsMsg8  = '¿Está seguro de que desea volver a generar la lista?';

procedure GeneracionPedidosCompra;
begin
     CreateEditForm( TBoxGpcForm, BoxGpcForm );
end;

procedure TBoxGpcForm.FormManagerInitializeForm;
begin

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );

     Clase.SetupGridColumns( LinesViewCodigoClaseA, LinesViewCodigoClaseB, LinesViewCodigoClaseC );

     With DataModule00.DmEmpresaFields do
       begin

       SetColumnsDecimals( [ LinesViewCantidad, LinesViewCantidadCargada, LinesViewServido ], Ventas_DecCantidad.Value );
       SetColumnDecimals( LinesViewPrecio, Ventas_DecPrecio.Value );
       SetColumnDecimals( LinesViewDescuento, Ventas_DecDto.Value );
       SetColumnDecimals( LinesViewImporteNeto );

       LinesViewCodigoAlmacen.Visible:= Stock_MultiAlmacen.Value;
       LinesViewUbicacion.Visible:= Stock_Ubicaciones.Value;

       end;

     LinesGrid.Hint := SeleccioneLasLineasHintMsg;
     HintLabel.Caption := RemoveHintTags( SeleccioneLasLineasHintMsg );

     DataFecha.Value := ApplicationContainer.TodayDate;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;

end;

procedure TBoxGpcForm.UpdateSelection;

var  SeleccionProveedor,
     CampoFecha : String;

begin

     ReiniciaSeleccion;

     With LineaMovimientoQuery do
       begin
       Close;

       If   DataFechaEntrega.Value
       then CampoFecha := 'FechaAplicacion'
       else CampoFecha := 'Fecha';

       If   DataCodigoProveedor.Value=''
       then SeleccionProveedor := ' Articulo.CodigoProveedor<>'''''
       else SeleccionProveedor := ' Articulo.CodigoProveedor=' + QuotedStr( DataCodigoProveedor.Value );

       SQL.Text := 'SELECT LineaMovimiento.*, Movimiento.Serie, Movimiento.NroDocumento, Movimiento.Propietario, Articulo.CodigoProveedor ' +
                   'FROM LineaMovimiento ' +
                   '     LEFT JOIN Movimiento ON ( LineaMovimiento.Ejercicio=Movimiento.Ejercicio AND LineaMovimiento.NroOperacion=Movimiento.NroOperacion ) ' +
                   '     LEFT JOIN Articulo ON ( LineaMovimiento.CodigoArticulo=Articulo.Codigo ) ' +
                   'WHERE ( Movimiento.TipoMovimiento=14 ) AND ' +
                   '      ( LineaMovimiento.' + CampoFecha + ' BETWEEN ' + SQLDateString( DataFechaInicial.Value ) + ' AND ' + SQlDateString( DataFechaFinal.Value )+ ' ) AND ' +
                   '      ( LineaMovimiento.CantidadProcesada=0 ) AND ' +
                   '      ( NOT LineaMovimiento.Procesada ) AND ' +
                   SeleccionProveedor +
                   'ORDER BY Articulo.CodigoProveedor, LineaMovimiento.Fecha, Movimiento.NroDocumento, LineaMovimiento.NroLinea';
       Open;
       If   RecordCount=0
       then begin
            Close;
            ShowNotification( ntWarning, RsMsg1, RsMsg2 );
            FormManager.SelectFirstKeyControl;
            end
       else begin
            LineaMovimientoDataSource.Enabled := True;
            LinesView.ViewData.Expand( True );
            end;
       end;

end;

procedure TBoxGpcForm.CodigoProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TBoxGpcForm.CodigoProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TBoxGpcForm.CodigoProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then CodigoProveedorCtrl.Description := RsgMsgTodos
     else Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxGpcForm.DataSourceDataChange(Sender: TObject; Field: TField);
begin
     LineaMovimientoDataSource.Enabled := False;
     ReiniciaSeleccion;
end;

procedure TBoxGpcForm.DisableDataGrid;
begin
     LineaMovimientoDataSource.Enabled := False;
     ReiniciaSeleccion;     
end;

procedure TBoxGpcForm.FormManagerCreateForm;
begin
     LineList := TList<Integer>.Create;
     LineList.OnNotify := DoOnListNotity;
end;

procedure TBoxGpcForm.FormManagerDestroyForm;
begin
     LineList.Free;
end;

procedure TBoxGpcForm.FormManagerFocusedAreaChanged;
begin
     If   not FChangingDataArea
     then try
            FChangingDataArea := True;
            If   FormManager.DataAreaFocused  
            then UpdateSelection                 
            else If   ( ModalResult=mrNone ) and 
                      ( FSeleccionadas>0 ) and 
                      ( ShowNotification( ntQuestionWarning, RsMsg7, RsMsg8 )<>mrYes )
                 then begin
                      LinesGrid.SetFocus;
                      Abort;
                      end
                 else DisableDataGrid;                      
          finally
            FChangingDataArea := False;            
            end;
            
end;

procedure TBoxGpcForm.FormManagerOkButton;
begin
     CreateProcessForm( DoProcesoGeneracionPedidos, RsMsg4 );
end;

procedure TBoxGpcForm.DoOnListNotity(Sender: TObject; const Item: Integer; Action : TCollectionNotification);
begin
     If   Action = TCollectionNotification.cnAdded
     then Inc( FSeleccionadas )
     else Dec( FSeleccionadas );
     OkButton.Enabled := FSeleccionadas>0;
end;

procedure TBoxGpcForm.DoProcesoGeneracionPedidos;

var  NroDocumentoDestino : LongInt;
     CodigoProveedorActual : String;
     LineasPedidoList : TList< Integer >;

procedure GeneraPedido;

var  Index : SmallInt;
     LineArray : TLongIntArray;

begin
     If   LineasPedidoList.Count<>0
     then begin

          SetLength( LineArray, LineasPedidoList.Count );
          For Index := 0 to LineasPedidoList.Count - 1 do
            LineArray[ Index ] := LineasPedidoList[ Index ];

          NroDocumentoDestino := Movimiento.GeneraPedidoCompra( CodigoProveedorActual,
                                                                DataSerie.Value,
                                                                DataFecha.Value,
                                                                LineArray );

          ProcessFrame.AddMsg( ntInformation, Format( RsMsg5, [ DataSerie.Value, NroDocumentoDestino, CodigoProveedorActual, Proveedor.Descripcion( CodigoProveedorActual ) ] ) );
          ReiniciaSeleccion;
          end;
end;

begin
     try

       LineaMovimientoQuery.DisableControls;

       try

         LineasPedidoList := TList< Integer >.Create;

         If   LineList.Count>0
         then begin

              With LineaMovimientoQuery do
                begin
                First;
                CodigoProveedorActual := LineaMovimientoQueryCodigoProveedor.Value;
                While not Eof do
                  begin

                  If   LineaMovimientoQueryCodigoProveedor.Value<>CodigoProveedorActual
                  then begin
                       GeneraPedido;
                       CodigoProveedorActual := LineaMovimientoQueryCodigoProveedor.Value;
                       end;

                  If   LineList.Contains( LineaMovimientoQueryNroRegistro.Value )
                  then LineasPedidoList.Add( LineaMovimientoQueryNroRegistro.Value );

                  Next;
                  end;

                end;

              GeneraPedido;

              If   NroDocumentoDestino<>0
              then MntMovimientosCompra( [ tmPedidoCompra, ApplicationContainer.Ejercicio, LineaMovimientoQueryCodigoProveedor.Value, DataSerie.Value, NroDocumentoDestino ] );

              end
         else begin
              ShowNotification( ntStop, RsMsg3 );
              Abort;
              end;
       finally
         LineaMovimientoQuery.EnableControls;
         LineasPedidoList.Free;
         end;

     except on E : Exception do
       begin
       ShowException( E, Self );
       raise;
       end;
     end;
end;

procedure TBoxGpcForm.SelectLines( SelectFunction : TCheckSelect );

var  Index : Integer;
     NroRegistro : Integer;
     Bm : TBookmark;
     Select : TSelectOperation;

begin

     With LineaMovimientoQuery do
       try
         DisableControls;
         Bm := GetBookmark;
         First;
         While not Eof do
           begin
           NroRegistro := LineaMovimientoQueryNroRegistro.Value;

           If   SelectFunction( Select )
           then case Select of
                  soCheck      : If   not LineList.Contains( NroRegistro )
                                 then LineList.Add(NroRegistro );
                  soUncheck    : LineList.Remove( NroRegistro );
                  soSwitch     : If   LineList.Contains( NroRegistro )
                                 then LineList.Remove( NroRegistro )
                                 else LineList.Add(NroRegistro );
                  end;
           Next;
           end;
       finally
         EnableControls;
         GotoBookmark( Bm );
         LinesView.DataController.UpdateItems( False );
       end;

end;

procedure TBoxGpcForm.TodoButtonClick(Sender: TObject);
begin
     FAllSelected := not FAllSelected;
     SelectLines( function( var Select : TSelectOperation ) : Boolean
                  begin
                    If   FAllSelected
                    then Select := soCheck
                    else Select := soUncheck;
                    Result := True; // Todas las líneas
                  end );
end;

procedure TBoxGpcForm.LineaMovimientoQueryCalcFields( DataSet : TDataSet );
begin
     If   Assigned( LineList )
     then LineaMovimientoQuerySeleccionLinea.Value := LineList.Contains( LineaMovimientoQueryNroRegistro.Value );

     // El texto de la cabecera determina el orden de las líneas

     LineaMovimientoQueryCabeceraProveedor.Value :=  'Proveedor ' + LineaMovimientoQueryCodigoProveedor.Value + ', ' + Proveedor.Descripcion( LineaMovimientoQueryCodigoProveedor.Value );
     LineaMovimientoQueryCabeceraPedido.Value :=  'Pedido nº ' + StrIntPadded( LineaMovimientoQueryNroDocumento.Value, 10, ' ' ) + ' de fecha ' + StrFormatDate( LineaMovimientoQueryFecha.Value ) + '. Cliente '+ LineaMovimientoQueryPropietario.Value + ', ' + Cliente.Descripcion( LineaMovimientoQueryPropietario.Value );
end;

procedure TBoxGpcForm.LineaMovimientoQueryFilterRecord(     DataSet : TDataSet;
                                                        var Accept  : Boolean );
begin
     Accept := True;
     If   LineaMovimientoTable.FindKey( [ LineaMovimientoQueryNroRegistro.Value ] )
     then If   MovimientoTable.FindKey( [ LineaMovimientoFields.Ejercicio.Value, LineaMovimientoFields.NroOperacion.Value ] )
          then Accept := MovimientoFields.TipoMovimiento.Value<>tmPedidoCompra;
end;

procedure TBoxGpcForm.LinesViewCabeceraPedidoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
     AText := ARecord.Values[ LinesViewCabeceraPedido.Index ];
end;

procedure TBoxGpcForm.LinesViewCabeceraProveedorGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
     AText := ARecord.Values[ LinesViewCabeceraProveedor.Index ];
end;

procedure TBoxGpcForm.LinesViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                   ACanvas   : TcxCanvas;
                                                   AViewInfo : TcxGridTableDataCellViewInfo;
                                               var ADone     : Boolean);
begin
     If   not AViewInfo.Selected
     then With AViewInfo.GridRecord do
            If   not VarIsNull( Values[ LinesViewSeleccionLinea.Index ] )
            then If   VarToBoolean( Values[ LinesViewSeleccionLinea.Index ] )
                 then ACanvas.Brush.Color := clRowHighlight;
end;

procedure TBoxGpcForm.LinesViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);

var  ColumnIndex : SmallInt;
     NroRegistro : Integer;
     LineCaption : String;

begin
     If   LinesView.Controller.FocusedRecord.Expandable
     then begin
          case LinesView.Controller.FocusedRecord.Level of
            0 : ColumnIndex := LinesViewCabeceraProveedor.Index;
            1 : ColumnIndex := LinesViewCabeceraPedido.Index;
            end;
          LineCaption := LinesView.Controller.FocusedRecord.Values[ ColumnIndex ];
          SelectLines( function( var Select : TSelectOperation ) : Boolean
                       begin
                          If   ColumnIndex=LinesViewCabeceraProveedor.Index
                          then Result := LineaMovimientoQueryCabeceraProveedor.Value=LineCaption
                          else Result := LineaMovimientoQueryCabeceraPedido.Value=LineCaption;
                          If   Result
                          then Select := soSwitch;
                       end );
          end
     else begin
          NroRegistro := LinesView.Controller.FocusedRecord.Values[ LinesViewNroRegistro.Index ];
          With LineList do
            begin
            If   Contains( NroRegistro )
            then Remove( NroRegistro )
            else Add( NroRegistro );
            LinesView.DataController.UpdateItems( False );
            end;
          end;
end;

procedure TBoxGpcForm.ReiniciaSeleccion;
begin
     LineList.Clear;
     FSeleccionadas := 0;
     FAllSelected := False;
     If   OkButton.Focused
     then CloseButton.SetFocus;
     OkButton.Enabled := False;
end;

end.


