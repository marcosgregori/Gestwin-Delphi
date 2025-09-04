unit a_rdd;

interface

uses StdCtrls, Buttons, Mask, Controls, ExtCtrls, Classes, Forms,
     Grids, Graphics, Menus,
     cxLookAndFeelPainters, cxButtons, cxControls, cxContainer,
     cxEdit, cxTextEdit, cxDBEdit, cxStyles, cxCustomData, cxGraphics,
     cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses,
     cxGridCustomView, cxGridCustomTableView, cxGridTableView,
     cxGridDBTableView, cxGrid, nxdb, dxSkinsCore, dxSkinscxPCPainter,
     cxLookAndFeels, cxGroupBox, cxLabel, dxSkinsDefaultPainters,
     cxNavigator, cxMaskEdit, cxDropDownEdit, cxCalendar, Generics.Collections,
     dxBar, dxDateRanges, AppForms, GridTableViewController,
     dxUIAClasses, dxScrollbarAnnotations,

     AppContainer,
     DataManager,

     Gim10Fields,
     Gim30Fields,

     dmi_mov;

type
  TBoxRddForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    RutaTable: TnxeTable;
    dataPanel: TgxEditPanel;
    CodigoRutaCtrl: TcxDBTextEdit;
    MovimientoTable: TnxeTable;
    EfectoCobrarTable: TnxeTable;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    RutaDistribucionDataSource: TDataSource;
    LineaRutaDistribucionDataSource: TDataSource;
    TableViewCodigoCliente: TcxGridDBColumn;
    TableViewImporteDeuda: TcxGridDBColumn;
    TableViewImporteCobrado: TcxGridDBColumn;
    TableViewImportePedido: TcxGridDBColumn;
    TableViewNroDocumento1: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewManager: TGridTableViewController;
    CodigoCtrlCaption: TcxLabel;
    DescRutaLabel: TcxLabel;
    ButtonPanel: TgxEditPanel;
    cxLabel1: TcxLabel;
    FechaCtrl: TcxDBDateEdit;
    LineaRutaTable: TnxeTable;
    TableViewNroOrden: TcxGridDBColumn;
    LineaMovimientoTable: TnxeTable;
    LineaRutaDistribucionTable: TnxeTable;
    RutaDistribucionTable: TnxeTable;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    LineaRutaDistribucionTableNroOperacion: TLongWordField;
    LineaRutaDistribucionTableNroOrden: TSmallintField;
    LineaRutaDistribucionTableCodigoCliente: TWideStringField;
    LineaRutaDistribucionTableNroDocumento1: TIntegerField;
    LineaRutaDistribucionTableNroDocumento2: TIntegerField;
    LineaRutaDistribucionTableNroDocumento3: TIntegerField;
    LineaRutaDistribucionTableNroDocumento4: TIntegerField;
    LineaRutaDistribucionTableImporteDeuda: TCurrencyField;
    LineaRutaDistribucionTableImporteCobrado: TCurrencyField;
    LineaRutaDistribucionTableImportePedido: TCurrencyField;
    LineaRutaDistribucionTableNombre: TStringField;
    dxBarManager1: TdxBarManager;
    PopupMenu: TdxBarPopupMenu;
    documentoItem: TdxBarButton;
    FichaItem: TdxBarButton;
    FichaClienteItem: TdxBarButton;
    VerificarItem: TdxBarButton;
    RutaDistribucionTableNroOperacion: TUnsignedAutoIncField;
    RutaDistribucionTableCodigoRuta: TWideStringField;
    RutaDistribucionTableFecha: TDateField;
    procedure FichaItemClick(Sender: TObject);
    procedure documentoItemClick(Sender: TObject);
    procedure FormManagerInitializeForm;
    procedure FormManagerActivateForm;
    procedure LineaRutaDistribucionTableCalcFields(DataSet: TDataSet);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure EfectoCobrarTableAfterOpen(DataSet: TDataSet);
    procedure FichaClienteItemClick(Sender: TObject);
    procedure VerificarItemClick(Sender: TObject);
    procedure TableViewDataControllerSummaryAfterSummary(
      ASender: TcxDataSummary);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerDestroyForm;
    procedure RutaDistribucionTableAfterEdit(DataSet: TDataSet);
    procedure TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure FormManagerPreparedForm;
    function TableViewManagerCanInsertRow: Boolean;
    procedure LineaRutaDistribucionTableApplyMasterRange(DataSet: TDataSet);
  private

    MovimientoFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;
    RutaFields : TRutaFields;
    LineaRutaFields : TLineaRutaFields;
    LineaRutaDistribucionFields : TLineaRutaDistribucionFields;
    EfectoCobrarFields : TEfectoCobrarFields;

    DsClienteFields : TClienteFields;
    DsSerieFacturacionFields : TSerieFacturacionFields;
    DsEquipoMovilFields : TEquipoMovilFields;

    TipoMovimiento : TTipoMovimiento; // Solo por comodidad
    SerieDocumento : String;
    CodigoVendedor : String;

    procedure EditaMovimiento( TipoMovimiento : SmallInt; Serie : String; NroDocumento : LongInt );
    procedure SuprimeReferenciaDocumento;
    function VerificarRelaciones( MuestraInformacion : Boolean = False ) : Boolean;

  public

    LineaRutaDistribucionAuxFields : TLineaRutaDistribucionFields;

    procedure DoInsertaLineasMovimiento( LineList : TList<Integer> = nil );
  end;

var BoxRddForm: TBoxRddForm = nil;

procedure MntRutasDistribucion( values : array of const );

implementation

{$R *.DFM}

uses   Variants,
       SysUtils,
       Files,
       DateUtils,
       LibUtils,
       AppManager,

       DataAccess,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm60Frm,

       dm_pga,
       dm_art,
       dm_cli,
       dm_tma,
       dm_rut,
       dm_eqm,
       dm_ven,
       dm_rde,
       dm_sdf,
       dm_gdc,
       dm_fco,
       dm_fde,
       dm_mov,

       a_mve,
       a_rut,
       a_cli,
       a_pg60,

       b_msg,
       b_chc,
       b_rdc,
       b_cdd,

       cx_rut;

resourceString
     RsMsg1  = 'Pedido de venta';
     RsMsg2  = 'Albarán de venta';
     RsMsg3  = 'No se han cargado los datos desde el equipo principal.';
     RsMsg4  = 'Utilice la ventana de carga para obtener los datos de trabajo.';
     RsMsg5  = 'Relaciones de la ruta verificadas.';
     RsMsg6  = 'No se ha encontrado el %s nº %s %d.';
     RsMsg7  = 'Se ha suprimido la referencia al mismo.'#13'Esto no es necesariamente un error, puesto que los documentos incluidos en la ruta pueden ser suprimidos de forma manual por el usuario.';

procedure CompruebaDatos;
begin
     If   ( EquipoMovil.DmEquipoMovilTable.RecordCount=0 ) or ( Ruta.DmRutaTable.RecordCount=0 )
     then begin
          ShowNotification( ntStop, RsMsg3, RsMsg4 );
          CargaDatos;
          Abort;
          end;
end;

procedure MntRutasDistribucion( Values : array of const );
begin
     CompruebaParametros;
     CompruebaDatos;
     CreateEditForm( TboxRddForm, BoxRddForm, TGds60Frm.PreventaSection );
end;

procedure TBoxRddForm.DocumentoItemClick(Sender: TObject);

var  AHandled : Boolean;

begin
     AHandled := False;
     TableViewManagerUserSelection( nil, AHandled );
end;

procedure TBoxRddForm.CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntRutas( [ Sender.EditingValue ] );
end;

procedure TBoxRddForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRutas( Sender );
end;

procedure TBoxRddForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Ruta.Valida( Sender, DisplayValue, ErrorTExt, Error );
end;

procedure TBoxRddForm.LineaRutaDistribucionTableApplyMasterRange(DataSet: TDataSet);
begin
     If   LineaRutaDistribucionTable.Active
     then LineaRutaDistribucionTable.SetRange( [ RutaDistribucionTableNroOperacion.Value, 1 ], [ RutaDistribucionTableNroOperacion.Value, MaxSmallint ] );
end;

procedure TBoxRddForm.LineaRutaDistribucionTableCalcFields(DataSet: TDataSet);

var  Deuda,
     Cobrado,
     ImporteBruto,
     DescuentosArticulo,
     ImporteNeto : Decimal;

begin

     If   not LineaRutaDistribucionDataSource.Enabled
     then Exit;

     Deuda := 0.0;
     Cobrado := 0.0;

     If   Assigned( DsClienteFields ) and
          Cliente.Obten( LineaRutaDistribucionTableCodigoCliente.Value, '', DsClienteFields )
     then begin

          // Si se utiliza este mantenimiento en una gestión normal el tiempo de respuesta es enorme, pero
          // en la preventa solo se pasan los efectos pendientes del cliente.

          With EfectoCobrarTable do
            begin
            SetRange( [ DsClienteFields.Subcuenta.Value, LowestDateTime ], [ DsClienteFields.Subcuenta.Value, HighestDateTime ] );
            First;
            While not Eof do
              begin

              // En preventa no hay gestión de remesas. Si un efecto tiene fecha de cobro está cobrado

              With EfectoCobrarFields do
                If   ValueIsEmpty( EfectoCobrarFields.FechaCobro.Value )
                then DecAdd( Deuda, Importe.Value )
                else DecAdd( Cobrado, ImporteCobrado.Value );

              Next;
              end;

            end;

          LineaRutaDistribucionTableNombre.Value := DsClienteFields.Envios_Nombre.Value;
          LineaRutaDistribucionTableImporteDeuda.Value := Deuda;
          LineaRutaDistribucionTableImporteCobrado.Value := Cobrado;

          If   not ValueIsEmpty( LineaRutaDistribucionTableNroDocumento1.Value )
          then begin
               Movimiento.ObtenImporteMovimiento( TipoMovimiento, ApplicationContainer.Ejercicio, SerieDocumento, LineaRutaDistribucionTableNroDocumento1.Value, ImporteBruto, DescuentosArticulo, ImporteNeto );
               LineaRutaDistribucionTableImportePedido.Value := ImporteNeto;
               end;

          end;

end;

procedure TBoxRddForm.RutaDistribucionTableAfterEdit(DataSet: TDataSet);
begin
     If   not LineaRutaDistribucionTable.FindKey( [ RutaDistribucionTableNroOperacion.Value ] )
     then With LineaRutaTable do
            try
              LineaRutaDistribucionTable.DisableControls;
              LineaRutaDistribucionDataSource.Enabled := False;
              SetRange( [ RutaDistribucionTableCodigoRuta.Value ] );
              First;
              While not Eof do
                begin

                LineaRutaDistribucionTable.Append;

                LineaRutaDistribucionFields.NroOperacion.Value := RutaDistribucionTableNroOperacion.Value;
                LineaRutaDistribucionFields.NroOrden.Value := LineaRutaFields.NroOrden.Value;
                LineaRutaDistribucionFields.CodigoCliente.Value := LineaRutaFields.CodigoCliente.Value;

                LineaRutaDistribucionTable.Post;

                Next;
                end;
            finally
              VerificarRelaciones;
              LineaRutaDistribucionTable.EnableControls;
              LineaRutaDistribucionDataSource.Enabled := True;
              LineaRutaDistribucionTable.First;
              end;
end;

procedure TBoxRddForm.SuprimeReferenciaDocumento;
begin
     With LineaRutaDistribucionTable do
        If   FindKey( [ LineaRutaDistribucionTableNroOperacion.Value, LineaRutaDistribucionTableNroOrden.Value ] )
        then begin
             Edit;
             LineaRutaDistribucionFields.NroDocumento1.Clear;
             Post;
             end;
end;

procedure TBoxRddForm.TableViewDataControllerSummaryAfterSummary(ASender: TcxDataSummary);
begin
     //.. Necesario para el cálculo
end;

function TBoxRddForm.TableViewManagerCanInsertRow: Boolean;
begin
     Result := LineaRutaDistribucionTable.ControlsDisabled;
end;

procedure TBoxRddForm.TableViewManagerUserSelection( Sender: TObject; var AHandled : Boolean);
begin
     If   ValueIsEmpty( LineaRutaDistribucionTableNroDocumento1.Value )
     then begin
          If   ParametrosPreventaRec.SeleccionConsumos
          then SeleccionaConsumosCliente( LineaRutaDistribucionTableCodigoCliente.Value, DoInsertaLineasMovimiento )
          else DoInsertaLineasMovimiento;
          end
     else EditaMovimiento( TipoMovimiento, SerieDocumento, LineaRutaDistribucionTableNroDocumento1.Value );
end;

procedure TBoxRddForm.EditaMovimiento( TipoMovimiento : SmallInt;
                                       Serie          : String;
                                       NroDocumento   : LongInt );
begin
     MntMovimientosVenta( [ TipoMovimiento, ApplicationContainer.Ejercicio, Serie, NroDocumento ] );
     If   Assigned( MntMveForm[ TipoMovimiento ] )
     then With MntMveForm[ TipoMovimiento ] do
            begin
            GotoPreviousOnClose := True;
            Grid.SetFocus;
            end;
end;

procedure TBoxRddForm.VerificarItemClick(Sender: TObject);
begin
     VerificarRelaciones( True );
end;

function TBoxRddForm.VerificarRelaciones( MuestraInformacion : Boolean = False ) : Boolean;

var  RecordFound : Boolean;

begin
     Result := False;
     With LineaRutaDistribucionTable do
       try
         DisableControls;
         First;
         While not Eof do
           begin
           If   LineaRutaDistribucionTableNroDocumento1.Value<>0
           then begin
                RecordFound := MovimientoTable.FindKey( [ TipoMovimiento, ApplicationContainer.Ejercicio, SerieDocumento, LineaRutaDistribucionTableNroDocumento1.Value ] );
                If   not RecordFound or ( MovimientoFields.Propietario.Value<>LineaRutaDistribucionTableCodigoCliente.Value )
                then begin
                     If   MuestraInformacion
                     then ShowNotification( ntWarning, Format( RsMsg6, [ Movimiento.TextoTipoMovimiento( TipoMovimiento, False ), SerieDocumento, LineaRutaDistribucionTableNroDocumento1.Value ] ), RsMsg7 );
                     SuprimeReferenciaDocumento;
                     Result := True;
                     end;
                end;
           Next;
           end;
         If   MuestraInformacion
         then ShowNotification( ntInformation, RsMsg5 );
       finally
         EnableControls;
         end;
end;

procedure TBoxRddForm.DoInsertaLineasMovimiento( LineList : TList<Integer> = nil );

var  NroDocumento : LongInt;

begin

     If   LineaRutaDistribucionTableNroDocumento1.Value=0
     then begin

          MovimientoTable.Append;

          MovimientoFields.TipoMovimiento.Value := TipoMovimiento;
          MovimientoFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
          MovimientoFields.Serie.Value := SerieDocumento;
          MovimientoFields.Propietario.Value := LineaRutaDistribucionTableCodigoCliente.Value;
          MovimientoFields.NroOperacion.Value := Movimiento.ProximaOperacion;
          MovimientoFields.NroDocumento.Value := Movimiento.ProximoDocumento( MovimientoFields );
          MovimientoFields.Fecha.Value := RutaDistribucionTableFecha.Value;
          If   TipoMovimiento=tmPedidoVenta
          then MovimientoFields.FechaAplicacion.Value := IncDay( RutaDistribucionTableFecha.Value, 1 );
          MovimientoFields.CodigoVendedor.Value := CodigoVendedor;

          With DataModule00.DmEmpresaFields do
            begin

            Cliente.Obten( LineaRutaDistribucionTableCodigoCliente.Value, '', DsClienteFields );

            If   Cliente_GruposFac.Value
            then If   GrupoCliente.Obten( DsClienteFields.Factura_Agrupacion.Value )
                 then MovimientoFields.GrupoFacturacion.Value := DsClienteFields.Factura_Agrupacion.Value;

            If   ( TipoMovimiento=tmPedidoVenta ) and
                 Ventas_PagosPedido.Value
            then If   FormaCobro.Obten( DsClienteFields.Cobro_FormaCobro.Value )
                 then MovimientoFields.CodigoFormaCobro.Value := DsClienteFields.Cobro_FormaCobro.Value;

            If   Ventas_FormaEnvio.Value
            then If   FormaEnvio.Obten( DsClienteFields.Envios_CodigoFormaEnvio.Value )
                 then MovimientoFields.FormaEnvio.Value := DsClienteFields.Envios_CodigoFormaEnvio.Value;

            end;

          MovimientoTable.Post;

          Movimiento.CompruebaPrimerNroPagina( MovimientoFields );

          SerieFacturacion.Obten( SerieDocumento, DsSerieFacturacionFields );

          Movimiento.InsertaLineasConsumo( MovimientoFields, LineaMovimientoFields, DsClienteFields, DsSerieFacturacionFields, LineList );

          With LineaRutaDistribucionTable do
            If   FindKey( [ LineaRutaDistribucionTableNroOperacion.Value, LineaRutaDistribucionTableNroOrden.Value ] )
            then begin
                 Edit;
                 LineaRutaDistribucionFields.NroDocumento1.Value := MovimientoFields.NroDocumento.Value;
                 Post;
                 end;

          NroDocumento := MovimientoFields.NroDocumento.Value;

          end
     else NroDocumento := LineaRutaDistribucionFields.NroDocumento1.Value;

     EditaMovimiento( TipoMovimiento, SerieDocumento, NroDocumento );

     // Ahora es un buen momento para comprobar si el cliente tiene algún aviso, porque la asignación anterior no provoca
     // la aparición del mensaje, al no ser el usuario el que ha validado el campo

     Cliente.MuestraAviso;

end;

procedure TBoxRddForm.EfectoCobrarTableAfterOpen(DataSet: TDataSet);
begin
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
end;

procedure TBoxRddForm.FormManagerInitializeForm;
begin

     LineaRutaDistribucionDataSource.Enabled := False;  // Por si acaso

      MovimientoFields := TMovimientoFields.Create( MovimientoTable );
      LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
      RutaFields := TRutaFields.Create( RutaTable );
      LineaRutaFields := TLineaRutaFields.Create( LineaRutaTable );
      LineaRutaDistribucionFields := TLineaRutaDistribucionFields.Create( LineaRutaDistribucionTable );

      DsClienteFields := TClienteFields.Create( Self );
      DsSerieFacturacionFields := TSerieFacturacionFields.Create( Self );
      DsEquipoMovilFields := TEquipoMovilFields.Create( Self );

      SetColumnsDecimals( [ TableViewImporteDeuda, TableViewImporteCobrado, TableViewImportePedido ] );

      case ParametrosPreventaRec.DocumentoTrabajo of
        0 : TipoMovimiento := tmPedidoVenta;
        1 : TipoMovimiento := tmVenta;
        end;

      If   Movimiento.SeriesEnDocumentosVenta( TipoMovimiento )
      then SerieDocumento := DataModule00.DmEmpresaFields.Ventas_SerieDefecto.Value;

      If   EquipoMovil.Obten( ParametrosPreventaRec.CodigoEquipoMovil, DsEquipoMovilFields, True )
      then begin
           CodigoVendedor := DsEquipoMovilFields.CodigoVendedor.Value;
           If   CodigoVendedor<>''
           then Vendedor.Obten( CodigoVendedor, True );  // Simple comprobación
           end;

      case ParametrosPreventaRec.DocumentoTrabajo of
        0 :  begin
             DocumentoItem.Caption := RsMsg1;
             TableViewNroDocumento1.Caption := RsMsg1;
             end;
        1 :  begin
             DocumentoItem.caption := RsMsg2;
             TableViewNroDocumento1.Caption := RsMsg2;
             end;
        end;

      With TableView.DataController.Summary do
         begin
         FooterSummaryItems[ 0 ].Format := FloatDisplayFormat( DecimalesMoneda, True );
         FooterSummaryItems[ 1 ].Format := FloatDisplayFormat( DecimalesMoneda, True );
         FooterSummaryItems[ 2 ].Format := FloatDisplayFormat( DecimalesMoneda, True );
         end;

end;

procedure TBoxRddForm.FormManagerPreparedForm;
begin
     //* 01.04.2014  He vuelto a poner la creación automática de la ruta del día por aclamación popular
     RutaTable.First;
     If   not RutaTable.Eof
     then begin
          FechaCtrl.PostEditValue( ApplicationContainer.TodayDate );
          CodigoRutaCtrl.PostEditValue( RutaFields.Codigo.Value );
          FormManager.SelectFirstDataControl;
          end;
     // var EnableDataset := RutaDistribucionTable.State<>dsSetKey;
     LineaRutaDistribucionTableApplyMasterRange( nil );
     LineaRutaDistribucionDataSource.Enabled := True;
end;

procedure TBoxRddForm.FormManagerActivateForm;

var  Bm : TBookMark;

begin
     With LineaRutaDistribucionTable do
       If   Active
       then begin
            Bm := GetBookmark;
            VerificarRelaciones;
            GotoBookmark( Bm );
            end;
end;

procedure TBoxRddForm.FormManagerDestroyForm;
begin
     If   Assigned( MntMveForm[ TipoMovimiento ] )
     then MntMveForm[ TipoMovimiento ].GotoPreviousOnClose := False;
end;

procedure TBoxRddForm.FechaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TBoxRddForm.FichaClienteItemClick(Sender: TObject);
begin
     MntClientes( [ TableViewCodigoCliente.EditValue ] );
end;

procedure TBoxRddForm.FichaItemClick(Sender: TObject);
begin
     RelacionDocumentosClientes( [ TableViewCodigoCliente.EditValue ] );
     If   Assigned( BrwRdcForm )
     then With BrwRdcForm do
            begin
            PageControl.ActivePage := EfectosTS;
            SoloPendientesCtrl.Checked := True;  // Solo los documentos pendientes
            end;
end;

end.

