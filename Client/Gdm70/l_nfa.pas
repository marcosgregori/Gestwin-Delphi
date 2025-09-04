
unit l_nfa;

interface

uses AppForms, StdCtrls, Mask, Controls, Buttons, Classes,
  ExtCtrls, Forms,

  AppContainer,  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, dxSkinsCore,
  dxSkinsDefaultPainters, DB, nxdb, DataManager, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxDBEdit, dxmdaset,

  cxMaskEdit, cxDropDownEdit, cxCalendar, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox, cxCheckBox, cxIndexedComboBox,

  Gim30Fields,
  Gim70Fields;

type
    TRptNfaForm = class(TgxForm)
    Panel1: TgxEditPanel;
    CodigoInicialCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    ArticuloTable: TnxeTable;
    CodigoFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    RelacionMaterialesTable: TnxeTable;
    OperacionTable: TnxeTable;
    MovimientoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    RelacionOperacionesTable: TnxeTable;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox1: TgxRangeBox;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataBuscarPrecioValido: TBooleanField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    Label1: TcxLabel;
    FechaLabel: TcxLabel;
    Label2: TcxLabel;
    Label7: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataExistenciasVirtuales: TBooleanField;
    ExistenciasVirtualesCtrl: TcxDBCheckBox;
    AgruparPorProveedorCtrl: TcxDBCheckBox;
    DataAgruparPorProveedor: TBooleanField;
    SeleccionCtrl: TcxDBIndexedComboBox;
    cxLabel3: TcxLabel;
    DataSeleccion: TSmallintField;
    OrdenFabricacionTable: TnxeTable;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SeleccionCtrlPropertiesChange(Sender: TObject);
    private

    public
    type

    TNecesidadesFuturasFields = class( TnxeDatasetFields)
     public
       CodigoComponente : TWideStringField;
       Descripcion : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       CodigoOperacion : TWideStringField;
       DescripcionOperacion : TWideStringField;
       CodigoProveedor : TWideStringField;
       NombreProveedor : TWideStringField;
       NroPedido : TIntegerField;
       NroOrdenFabricacion: TIntegerField;
       Fecha : TDateField;
       Proceso : TSmallIntField;
       Pendiente : TBCDField;
       PendienteTotal : TBCDField;
       Existencias : TBCDField;
     end;

    var
    RelacionMaterialesFields : TRelacionMaterialesFields;
    RelacionOperacionesFields : TRelacionOperacionesFields;
    ArticuloFields : TArticuloFields;
    OperacionFields : TOperacionFields;
    MovimientoFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;
    OrdenFabricacionFields : TOrdenFabricacionFields;

    NecesidadesFuturasTable : TnxeTable;


    NecesidadesFuturasFields : TNecesidadesFuturasFields;
    end;

var

  RptNfaForm: TRptNfaForm = nil;

procedure ListadoNecesidadesFuturas;


implementation

uses   SysUtils,
       LibUtils,

       AppManager,

       Gim00Fields,

       dmi_mov,
       dmi_sto,
       dmi_odf,

       dm_pga,
       dm_art,
       dm_fdc,
       dm_fdv,
       dm_cls,
       dm_sto,
       dm_pro,
       dm_lmp,

       cx_art,
       cx_alm,

       b_msg;

{$R *.DFM}

resourceString
     RsMsg1 = 'No he conseguido recupera la relación de operaciones.';
     RsMsg2 = 'El registro del artículo %s, proceso %d, no existe.';
     RsMsg3 = 'Fecha de %s';

procedure ListadoNecesidadesFuturas;
begin
     CreateReportForm( TRptNfaForm, RptNfaForm );
end;

procedure TRptNfaForm.InitializeForm;
begin

     RelacionMaterialesFields := TRelacionMaterialesFields.Create( RelacionMaterialesTable );
     RelacionOperacionesFields := TRelacionOperacionesFields.Create( RelacionOperacionesTable );
     ArticuloFields := TArticuloFields.Create( ArticuloTable );
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     OperacionFields := TOperacionFields.Create( OperacionTable );
     OrdenFabricacionFields := TOrdenFabricacionFields.Create(  OrdenFabricacionTable );

     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataCodigoFinal.Value := HighStrCode;
end;

procedure TRptNfaForm.SeleccionCtrlPropertiesChange(Sender: TObject);

const Documento : Array of String = [ 'pedido', 'lanzamiento' ];

begin
     If   SeleccionCtrl.ItemIndex>=0
     then FechaLabel.Caption := Format( RsMsg3, [ Documento[ SeleccionCtrl.ItemIndex ] ] );
end;

procedure TRptNfaForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TRptNfaForm.CodigoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptNfaForm.FormManagerOkButton;

var  NivelActual : SmallInt;

procedure DesglosaArticulo( FechaOperacion  : TDate;
                            _CodigoArticulo : String;
                            _CodigoClaseA   : String;
                            _CodigoClaseB   : String;
                            _CodigoClaseC   : String;
                            _ArticuloRaiz   : Boolean;
                            _Cantidad,
                            _CantidadPadre  : Decimal );

var  Bm : TBookMark;
     SavedRangeStart,
     SavedRangeEnd : Pointer;
     ExistenciasArticulo : IExistenciasArticulo;
     TieneComponentes : Boolean;

begin

     With RelacionMaterialesTable do
       begin

       SetRange( [ _CodigoArticulo, _CodigoClaseA, _CodigoClaseB, _CodigoClaseC, 1, 1 ],
                 [ _CodigoArticulo, _CodigoClaseA, _CodigoClaseB, _CodigoClaseC, MaxSmallint, MaxSmallint ] );
       First;
       While not Eof do
         begin

         If   ( ( AnsiCompareStr( RelacionMaterialesFields.CodigoComponente.Value, DataCodigoInicial.Value )>=0 ) and
                ( AnsiCompareStr( RelacionMaterialesFields.CodigoComponente.Value, DataCodigoFinal.Value )<=0 ) )
         then begin

              With RelacionMaterialesFields do
                begin
                ArticuloTable.FindKey( [ CodigoComponente.Value ] );
                TieneComponentes := ListaMaterialesProcesos.TieneRelacion( CodigoComponente.Value, ClaseAComponente.Value, ClaseBComponente.Value, ClaseCComponente.Value );
                If   RelacionOperacionesTable.FindKey( [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, Proceso.Value ] )
                then OperacionTable.FindKey( [ RelacionOperacionesFields.CodigoOperacion.Value ] )
                else begin
                     ShowNotification( ntStop, RsMsg1, Format( RsMsg2, [ PadIf( [ CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value ], '.' ), Proceso.Value ] ) );
                     Abort;
                     end;
                end;

              With NecesidadesFuturasTable, NecesidadesFuturasFields do
                begin

                Append;

                Codigocomponente.Value := RelacionMaterialesFields.CodigoComponente.Value;
                Fecha.Value := FechaOperacion;
                Descripcion.Value := ArticuloFields.Descripcion.Value;
                CodigoClaseA.Value := RelacionMaterialesFields.ClaseAComponente.Value;
                CodigoClaseB.Value := RelacionMaterialesFields.ClaseBComponente.Value;
                CodigoClaseC.Value := RelacionMaterialesFields.ClaseCComponente.Value;
                CodigoOperacion.Value := RelacionOperacionesFields.CodigoOperacion.Value;
                DescripcionOperacion.Value := OperacionFields.Descripcion.Value;
                CodigoProveedor.Value := ArticuloFields.CodigoProveedor.Value;
                If   CodigoProveedor.Value<>''
                then NombreProveedor.Value := Proveedor.Descripcion( CodigoProveedor.Value );

                If   DataSeleccion.Value=0
                then begin
                     NroPedido.Value := MovimientoFields.NroDocumento.Value;
                     Pendiente.Value := LineaMovimientoFields.Cantidad.Value - LineaMovimientoFields.CantidadProcesada.Value;
                     PendienteTotal.Value := RelacionMaterialesFields.Cantidad.Value * Pendiente.Value;
                     end
                else begin
                     NroOrdenFabricacion.Value := OrdenFabricacionFields.NroOrden.Value;
                     PendienteTotal.Value := RelacionMaterialesFields.Cantidad.Value * OrdenFabricacionFields.UnidadesAFabricar.Value;
                     end;

                Proceso.Value := RelacionMaterialesFields.Proceso.Value;
                ExistenciasArticulo := StockAlmacen.ObtenStockFecha( RelacionMaterialesFields.CodigoComponente.Value,
                                                                     False,
                                                                     RelacionMaterialesFields.ClaseAComponente.Value,
                                                                     RelacionMaterialesFields.ClaseBComponente.Value,
                                                                     RelacionMaterialesFields.ClaseCComponente.Value,
                                                                     True,
                                                                     '',
                                                                     True,  // Todos los almacenes
                                                                     '',    // OperacionFields.AlmacenComponentes
                                                                     True,  // Todas las ubicaciones
                                                                     '',
                                                                     FechaOperacion,
                                                                     0,
                                                                     0,
                                                                     0 );

                Existencias.Value := ExistenciasArticulo.SumaExistencias.Saldo;

                If   DataExistenciasVirtuales.Value
                then Existencias.Value := Existencias.Value + ExistenciasArticulo.SumaExistencias.PendienteRecibir - ExistenciasArticulo.SumaExistencias.PendienteServir;

                Post;

                ApplicationContainer.ShowProgression;

                end;

              If   TieneComponentes
              then begin
                   Bm := GetBookMark;
                   SaveRange( SavedRangeStart, SavedRangeEnd );
                   try
                     Inc( NivelActual );
                     With RelacionMaterialesFields do
                       DesglosaArticulo( FechaOperacion, CodigoComponente.Value, ClaseAComponente.Value, ClaseBComponente.Value, ClaseCComponente.Value, False, Cantidad.Value * _Cantidad, Cantidad.Value * _CantidadPadre );
                     Dec( NivelActual );
                   finally
                     RestoreRange( SavedRangeStart, SavedRangeEnd );
                     GotoBookMark( Bm );
                     end;
                   end;

              end;

         Next;
         end;

       end;  // RelacionMaterialesTable
end;


procedure SeleccionaRegistros;

var   Index : SmallInt;
      ExistenciasArticulo : IExistenciasArticulo;

begin
     If   DataSeleccion.Value=0
     then With MovimientoTable do
            begin
            SetRange( [ tmPedidoVenta, DataFechaInicial.Value ], [ tmPedidoVenta, DataFechaFinal.Value ] );
            ApplicationContainer.StartProgression( RecordCount );
            First;
            While not Eof do
              begin

              With LineaMovimientoTable do
                begin

                NivelActual := 1;

                With MovimientoFields do
                  SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

                First;
                While not Eof do
                  begin

                  // NO hace falta comprobar si es nulo o no existe relación. No lo encontrará y punto.

                  With LineaMovimientoFields do
                    DesglosaArticulo( Fecha.Value, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, True, Cantidad.Value, 1 );

                  Next;
                  end;

                end; // LineaMovimientoTable

              Next;
              end;

            end   // MovimientoTable
     else With OrdenFabricacionTable do
            begin
            SetRange( [ DataFechaInicial.Value, '' ], [ DataFechaFinal.Value, HighStrCode ] );
            ApplicationContainer.StartProgression( RecordCount );
            First;
            While not Eof do
              begin
              NivelActual := 1;
              With OrdenFabricacionFields do
                DesglosaArticulo( FechaLanzamiento.Value, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, True, UnidadesAFabricar.Value, 1 );
              Next;
              end;
            end;


     ApplicationContainer.endProgression;

end;

begin
     With Report do
       begin

       try
         Load;

         NecesidadesFuturasTable := Report.CreateEmptyTable( 'NecesidadesFuturas' );
         NecesidadesFuturasFields := TNecesidadesFuturasFields.Create( NecesidadesFuturasTable );

         SeleccionaRegistros;

         FacturaCompras.FijaDecimalesInforme( Report );
         FacturaVentas.FijaDecimalesInforme( Report );

         If   DataAgruparPorProveedor.Value
         then NecesidadesFuturasTable.IndexFieldNames := 'CodigoProveedor;CodigoComponente;Fecha'
         else NecesidadesFuturasTable.IndexFieldNames := 'CodigoComponente;Fecha';

         Start;
       except on E : Exception do Cancel( E );
         end;

       end;
end;

end.
