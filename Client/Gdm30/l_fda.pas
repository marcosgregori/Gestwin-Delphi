
unit l_fda;

interface

uses Windows, AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,

     ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
     nxdb, DataManager, cxCheckBox, cxDBEdit, cxSpinEdit, cxMaskEdit,
     cxDropDownEdit, cxCalendar, cxControls, cxContainer, cxEdit, cxTextEdit,
     cxGroupBox, cxRadioGroup, dxmdaset,

     dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
     cxLookAndFeels, cxLabel,

     Gim10Fields,
     Gim30Fields, dxUIAClasses;


type
    TRptFdaForm = class(TgxForm)
    FormManager: TgxFormManager;
    MovimientoTable: TnxeTable;
    Report: TgxReportManager;
    DataPanel: TgxEditPanel;
    ArticuloInicialCtrl: TcxDBTextEdit;
    ArticuloFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    LineaMovimientoTable: TnxeTable;
    TipoMovimientoCtrl: TcxDBSpinEdit;
    SoloConStockCtrl: TcxDBCheckBox;
    MostrarPrecioNetoCtrl: TcxDBCheckBox;
    CodigoClaseACtrl: TcxDBTextEdit;
    CodigoClaseBCtrl: TcxDBTextEdit;
    CodigoClaseCCtrl: TcxDBTextEdit;
    LoteCtrl: TcxDBTextEdit;
    CodigoPropietarioCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSeleccionAlmacen: TSmallintField;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    DataAlmacen: TWideStringField;
    DataSource: TDataSource;
    SeleccionAlmacenCtrl: TcxDBRadioGroup;
    AlmacenCtrl: TcxDBTextEdit;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataTipoMovimiento: TSmallintField;
    DataCodigoPropietario: TWideStringField;
    DataCodigoClaseA: TWideStringField;
    DataCodigoClaseB: TWideStringField;
    DataCodigoClaseC: TWideStringField;
    DataLote: TWideStringField;
    DataSoloConStock: TBooleanField;
    DataMostrarPrecioNeto: TBooleanField;
    SoloAfectanExistenciasCtrl: TcxDBCheckBox;
    DataSoloAfectanExistencias: TBooleanField;
    DataSoloTiposMovimientoStock: TBooleanField;
    SoloTiposMovimientoStockCtrl: TcxDBCheckBox;
    Label3: TcxLabel;
    Label6: TcxLabel;
    Label2: TcxLabel;
    Label8: TcxLabel;
    capClaseALabel: TcxLabel;
    capClaseBLabel: TcxLabel;
    descClaseALabel: TcxLabel;
    descClaseBLabel: TcxLabel;
    capClaseCLabel: TcxLabel;
    descClaseCLabel: TcxLabel;
    Label5: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label1: TcxLabel;
    DescAlmacenLabel: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TipoMovimientoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TipoMovimientoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SeleccionAlmacenCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure CodigoClaseCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoPropietarioCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoPropietarioCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure LoteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    private

    public

      MovimientoFields : TMovimientoFields;
      LineaMovimientoFields : TLineaMovimientoFields;
      SerieFacturacionFields : TSerieFacturacionFields;
      ArticuloFields : TArticuloFields;

      ReportFichaArticuloTable : TnxeTable;
      ReportFichaArticuloFields : TReportFichaArticuloFields;

      Procesar : Boolean;
      SerieFacturacionActual : String;
      CodigoArticuloActual : String;

    end;

var
  RptFdaForm: TRptFdaForm = nil;

procedure ListadoFichasArticulos;

implementation

uses   SysUtils,
       LibUtils,

       Gdm00Dm,
       Gim00Fields,

       dmi_mov,
       dmi_sto,

       dm_art,
       dm_alm,
       dm_sto,
       dm_tma,
       dm_cli,
       dm_cls,
       dm_pro,
       dm_fdc,
       dm_fdv,
       dm_mov,
       dm_sdf,

       b_msg,

       cx_cls1,
       cx_art,
       cx_alm,
       cx_tma,
       cx_pro,
       cx_cli;

{$R *.DFM}

procedure ListadoFichasArticulos;
begin
     CreateReportForm( TRptFdaForm, RptFdaForm );
end;

procedure TRptFdaForm.InitializeForm;
begin
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     ArticuloFields := TArticuloFields.Create( Self );

     Clase.SetupEditControls( CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl );

     LoteCtrl.Enabled := DataModule00.DmEmpresaFields.Stock_LotesProductos.Value;

     DataSeleccionAlmacen.Value := 0;
     DataSoloTiposMovimientoStock.Value := True;
     DataArticuloFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;

end;

procedure TRptFdaForm.LoteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     With LoteCtrl do
       If   ValueIsEmpty( DisplayValue )
       then Description := RsgMsgTodos
       else Description := '';
end;

procedure TRptFdaForm.SeleccionAlmacenCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     AlmacenCtrl.Enabled := DataSeleccionAlmacen.Value=1;
end;

procedure TRptFdaForm.TipoMovimientoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposMovimientoAlmacen( Sender );
end;

procedure TRptFdaForm.TipoMovimientoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  DataValue : SmallInt;

begin
     DataValue := VarToSmallInt( DisplayValue );

     If   DataValue=0
     then TipoMovimientoCtrl.Description := RsgMsgTodos
     else TipoMovAlmacen.Valida( Sender, DisplayValue, ErrorText, Error );

     With CodigoPropietarioCtrl do
       begin
       Enabled := DataValue in [ tmOferta..tmVenta ];
       If   not Enabled
       then Clear;
       end;

     SoloTiposMovimientoStockCtrl.Enabled := DataValue=0;

     If   TipoMovimientoCtrl.Editing
     then ResetTab;
end;

procedure TRptFdaForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var   CodigoAlmacenInicial,
      CodigoAlmacenFinal : String;
      ExistenciasArticulo : IExistenciasArticulo;

begin
     With LineaMovimientoTable do
       begin

       If   DataSeleccionAlmacen.Value=0
       then begin
            CodigoAlmacenInicial := '';
            CodigoAlmacenFinal := HighStrCode;
            end
       else begin
            CodigoAlmacenInicial := DataAlmacen.Value;
            CodigoAlmacenFinal := DataAlmacen.Value;
            end;

       SetRange( [ DataArticuloInicial.Value, DataFechaInicial.Value, 1, 0, 1 ], [ DataArticuloFinal.Value, DataFechaFinal.Value, MaxLongint, MaxSmallint, MaxSmallint ] );
       try

         ApplicationContainer.StartProgression( RecordCount );

         Procesar := False;
         SerieFacturacionActual := #0;
         CodigoArticuloActual := #0;

         First;
         While not Eof do
           begin

           If   ( LineaMovimientoFields.CodigoArticulo.Value<>ArticuloManual ) and
                ( LineaMovimientoFields.CodigoAlmacen.Value>=CodigoAlmacenInicial ) and
                ( LineaMovimientoFields.CodigoAlmacen.Value<=CodigoAlmacenFinal )
           then begin

                If   CodigoArticuloActual<>LineaMovimientoFields.CodigoArticulo.Value
                then begin
                     Articulo.Obten( LineaMovimientoFields.CodigoArticulo.Value, ArticuloFields );
                     Procesar := not( DataSoloAfectanExistencias.Value and ArticuloFields.NoAfectarStock.Value );
                     If   Procesar and DataSoloConStock.Value
                     then begin
                          ExistenciasArticulo := StockAlmacen.ObtenStock( LineaMovimientoFields.CodigoArticulo.Value,
                                                                          False,
                                                                          LineaMovimientoFields.CodigoClaseA.Value,
                                                                          LineaMovimientoFields.CodigoClaseB.Value,
                                                                          LineaMovimientoFields.CodigoClaseC.Value,
                                                                          True,
                                                                          '',
                                                                          DataSeleccionAlmacen.Value=0,
                                                                          DataAlmacen.Value,
                                                                          True,
                                                                          '',
                                                                          False,
                                                                          ApplicationContainer.Ejercicio,
                                                                          0,
                                                                          ApplicationContainer.NroMesFinal );
                          If   Assigned( ExistenciasArticulo )
                          then Procesar := ExistenciasArticulo.SumaExistencias.Saldo>0.0;
                          end;
                     CodigoArticuloActual := LineaMovimientoFields.CodigoArticulo.Value;
                     end;

                If   Procesar
                then begin

                     If   MovimientoTable.FindKey( [ LineaMovimientoFields.Ejercicio.Value, LineaMovimientoFields.NroOperacion.Value ] )
                     then begin

                          // Aunque no esté agrupado por serie hay un ahorro de proceso, puesto que suelen ser de la misma serie

                          If   SerieFacturacionActual<>MovimientoFields.Serie.Value
                          then begin
                               SerieFacturacion.Obten( MovimientoFields.Serie.Value, SerieFacturacionFields );
                               SerieFacturacionActual := MovimientoFields.Serie.Value;
                               end;

                          If   ( ( DataTipoMovimiento.Value=0 ) or ( DataTipoMovimiento.Value=MovimientoFields.TipoMovimiento.Value ) ) and
                               ( not( ( DataTipoMovimiento.Value=0 ) and DataSoloTiposMovimientoStock.Value and ( MovimientoFields.TipoMovimiento.Value in [ tmOferta, tmPedidoCompra, tmPresupuesto, tmPedidoVenta ] ) ) ) and
                               ( not DataSoloAfectanExistencias.Value or SerieFacturacionFields.Afectar_Stock.Value ) and
                               ( ( DataCodigoPropietario.Value='' ) or ( DataCodigoPropietario.Value=MovimientoFields.Propietario.Value ) ) and
                               ( ( DataCodigoClaseA.Value='' ) or ( DataCodigoClaseA.Value=LineaMovimientoFields.CodigoClaseA.Value ) ) and
                               ( ( DataCodigoClaseB.Value='' ) or ( DataCodigoClaseB.Value=LineaMovimientoFields.CodigoClaseB.Value ) ) and
                               ( ( DataCodigoClaseC.Value='' ) or ( DataCodigoClaseC.Value=LineaMovimientoFields.CodigoClaseC.Value ) ) and
                               ( ( DataLote.Value='' ) or ( DataLote.Value=LineaMovimientoFields.LoteFabricacion.Value ) )
                          then begin

                               With LineaMovimientoFields do
                                 ExistenciasArticulo := StockAlmacen.ObtenStockFecha ( CodigoArticulo.Value,
                                                                                       True,
                                                                                       CodigoClaseA.Value,
                                                                                       CodigoClaseB.Value,
                                                                                       CodigoClaseC.Value,
                                                                                       LoteFabricacion.Value='',
                                                                                       LoteFabricacion.Value,
                                                                                       DataSeleccionAlmacen.Value=0,
                                                                                       CodigoAlmacen.Value,
                                                                                       True,
                                                                                       '', // Ubicacion.Value,
                                                                                       Fecha.Value,
                                                                                       NroOperacion.Value,
                                                                                       NroPagina.Value,
                                                                                       NroLinea.Value );

                               With ReportFichaArticuloFields do
                                 begin

                                 ReportFichaArticuloTable.Append;

                                 CodigoArticulo.Value := LineaMovimientoFields.CodigoArticulo.Value;
                                 Serie.Value := MovimientoFields.Serie.Value;
                                 NroDocumento.Value := MovimientoFields.NroDocumento.Value;
                                 Fecha.Value := MovimientoFields.Fecha.Value;
                                 CodigoPropietario.Value := MovimientoFields.Propietario.Value;

                                 case MovimientoFields.TipoMovimiento.Value of
                                   tmOferta..tmCompra     : Nombre.Value := Proveedor.Descripcion( MovimientoFields.Propietario.Value, False );
                                   tmPresupuesto..tmVenta : Nombre.Value := Cliente.Descripcion( MovimientoFields.Propietario.Value, False );
                                   else                     Nombre.Value := MovimientoFields.DescripcionMovimiento.Value;
                                   end;

                                 Descripcion.Value := Articulo.Descripcion( CodigoArticulo.Value, True );
                                 TipoMovimiento.Value := MovimientoFields.TipoMovimiento.Value;
                                 NroLinea.Value  := LineaMovimientoFields.NroLinea.Value;
                                 NroRegistro.Value := LineaMovimientoFields.NroRegistro.Value;
                                 Ejercicio.Value := MovimientoFields.Ejercicio.Value;

                                 DescripcionTipoMovimiento.Value := TipoMovAlmacen.Descripcion( MovimientoFields.TipoMovimiento.Value, True );
                                 CodigoClaseA.Value := LineaMovimientoFields.CodigoClaseA.Value;
                                 CodigoClaseB.Value := LineaMovimientoFields.CodigoClaseB.Value;
                                 CodigoClaseC.Value := LineaMovimientoFields.CodigoClaseC.Value;
                                 LoteFabricacion.Value := LineaMovimientoFields.LoteFabricacion.Value;
                                 CodigoAlmacen.Value := LineaMovimientoFields.CodigoAlmacen.Value;
                                 Ubicacion.Value := LineaMovimientoFields.Ubicacion.Value;

                                 If   LineaMovimientoFields.Cantidad.Value>0.0
                                 then Entradas.Value := LineaMovimientoFields.Cantidad.Value
                                 else Salidas.Value := Abs( LineaMovimientoFields.Cantidad.Value );

                                 Precio.Value := LineaMovimientoFields.Precio.Value;
                                 Descuento.Value := LineaMovimientoFields.Descuento.Value;
                                 Existencias.Value := ExistenciasArticulo.SumaExistencias.Saldo;
                                 PrecioNeto.Value := Precio.Value - ( ( Precio.Value * Descuento.Value ) / 100.0 );

                                 ReportFichaArticuloTable.Post;

                                 end;

                               end;
                          end;

                     end;
                end;
           ApplicationContainer.ShowProgression;
           Next;
           end;

         finally
           ApplicationContainer.EndProgression;
           end;

       end;
end;

begin
     Enabled := false;

     With Report do
       begin
       try

         Load;

         ReportFichaArticuloTable := Report.CreateEmptyTable( 'FichaArticulo' );
         ReportFichaArticuloFields := TReportFichaArticuloFields.Create( ReportFichaArticuloTable );

         SeleccionaRegistros;

         FacturaCompras.FijaDecimalesInforme( Report );
         FacturaVentas.FijaDecimalesInforme( Report );

         SetValue( RsNombreAlmacen, DescAlmacenLabel.Caption );

         Clase.SetReportTitles( Report, 4 );

         Start;
       except on E : Exception do Cancel( E );
         end;

       end;

end;

procedure TRptFdaForm.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TRptFdaForm.AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptFdaForm.ArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, True, Sender );
end;

procedure TRptFdaForm.ArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptFdaForm.CodigoClaseCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( TNroClase( Sender.Tag ), True, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptFdaForm.CodigoPropietarioCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     If   DataTipoMovimiento.Value in [ tmOferta..tmCompra ]
     then ConsultaProveedores( Sender )
     else ConsultaClientes( Sender )
end;

procedure TRptFdaForm.CodigoPropietarioCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then CodigoPropietarioCtrl.Description := RsgMsgTodos
     else If   DataTipoMovimiento.Value in [ tmOferta..tmCompra ]
          then Proveedor.Valida( Sender, DisplayValue, ErrorText, Error )
          else Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptFdaForm.CodigoClaseCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( TNroClase( Sender.Tag ), Sender, qgsNormal );
end;

end.
 
