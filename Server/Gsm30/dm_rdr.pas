
unit dm_rdr;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,
  AppManager,
  DataManager,
  ServerDataModule,
  LibUtils,
  SessionIntf,

  Spring,

  Gim10Fields,
  Gim30Fields,

  dmi_rdr;

type

   TReconstruccionResultadosService = class( TSessionModule, IReconstruccionResultadosService )
     private

     protected

     procedure AssignSession( const SessionID : Integer ); override;

     procedure Reconstruccion( EjercicioInicial, EjercicioFinal : SmallInt; RevisarEstadoTablas, ReasignarNrosRegistro, RecalcularLineas : Boolean; RecalcularFacturados : Boolean = False; RecalcularCosteFacturas : Boolean = False );
     function RecalculaFactura( CodigoCliente, Serie : String; NroFactura : LongInt ) : Boolean;
     end;

   TReasignacionNroRegistroEvent = procedure( NroRegistroAnterior, NroRegistroActual : LongWord ) of object;

   TReconstruccionResultadosModule = class(TServerDataModule)
    FacturaVentasTable: TnxeTable;
    FacturaComprasTable: TnxeTable;
    MovimientoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    MovimientoAuxTable: TnxeTable;
    LineaMovimientoAuxTable: TnxeTable;
    GrupoLineaMovimientoTable: TnxeTable;
    ArticuloTable: TnxeTable;
    LineaMovimientoAux1Table: TnxeTable;
    StockTable: TnxeTable;
    FacturaTable: TnxeTable;
    AsientoTable: TnxeTable;
    FacturaComercialTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private
    ArticuloFields : TArticuloFields;
    MovimientoFields : TMovimientoFields;
    GrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;
    MovimientoAuxFields : TMovimientoFields;
    LineaMovimientoAuxFields : TLineaMovimientoFields;
    LineaMovimientoAux1Fields : TLineaMovimientoFields;
    FacturaComprasFields : TFacturaComprasFields;
    FacturaVentasFields : TFacturaVentasFields;
    AsientoFields : TAsientoFields;
    FacturaFields,
    FacturaComercialFields : TFacturaFields;
    StockFields : TStockFields;
    EnvaseFields : TClaseFields;
    ProveedorFields : TProveedorFields;
    ClienteFields : TClienteFields;
    SerieFacturacionFields : TSerieFacturacionFields;
    TiposIVAFields : TTiposIVAFields;

    NetoMovimiento : Decimal;

    FRevisarEstadoTablas,
    FReasignarNrosRegistro : Boolean;

    FEjercicioInicial,
    FEjercicioFinal : SmallInt;
    FRecalcularLineas,
    FRecalcularFacturados,
    FRecalcularCosteFacturas : Boolean;
    FOnReasignacionNroRegistro : Event< TReasignacionNroRegistroEvent >;
    FUltimoNroOperacionCorregido : LongInt;

    procedure RecalculaImportesLinea;

  public

    procedure Reconstruccion; overload;
    procedure Reconstruccion( EjercicioInicial, EjercicioFinal : SmallInt; RevisarEstadoTablas, ReasignarNrosRegistro, RecalcularLineas : Boolean; RecalcularFacturados : Boolean = False; RecalcularCosteFacturas : Boolean = False ); overload;

    function RecalculaFactura( CodigoCliente, Serie : String; NroFactura : LongInt ) : Boolean;

    procedure RecalculoLineas( EjercicioInicial, EjercicioFinal : SmallInt );

    property OnReasignacionNroRegistro : Event<TReasignacionNroRegistroEvent> read FOnReasignacionNroRegistro write FOnReasignacionNroRegistro;
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses Variants,
     nxllTypes,
     DateUtils,

     nxrdClass,
     nxrbTypes,

     EnterpriseData,
     ServerContainer,
     BaseSessionData,
     SessionData,

     Gim00Fields,

     dmi_cls,
     dmi_art,
     dmi_ast,
     dmi_mov,
     dmi_sto,
     dmi_fac,

     dm_cls,
     dm_sto,
     dm_mov,
     dm_tma,
     dm_art,
     dm_fdc,
     dm_fdv,
     dm_cli,
     dm_pro,
     dm_ven,
     dm_sdf;

{$R *.DFM}

type  TCantidadProcesadaItem = class
        public
        NroRegistro : LongInt;
        Cantidad : Decimal;
        constructor Create( UnNroRegistro : LongInt );
        end;

      TCantidadProcesadaList = class( TList )
        procedure Clear; override;
        function Add( UnNroRegistro : LongInt ) : TCantidadProcesadaItem;
        function Obten( UnNroRegistro : LongInt ) : TCantidadProcesadaItem;
        function  BuscaPorNroRegistro( UnNroRegistro : LongInt ) : TCantidadProcesadaItem;
        end;

resourceString
     RsMsg1  = 'Reconstrucción de resultados.';
     RsMsg2  = 'Actualizando existencias.';
     RsMsg3  = 'Pedido de compras nº %s %d.';
     RsMsg4  = 'Movimiento nº %d.';
     RsMsg5  = 'Actualizando estadisticas.';
     RsMsg6  = 'El proveedor [%s] ha sido dado de baja. La factura %s %d no será procesada.';
     RsMsg7  = 'Factura, albarán : %d, %d.';
     RsMsg11 = 'El proceso se ha interrumpido y no ha podido completarse con éxito.' + #13 +
               'Debe repetirlo si quiere que los datos económicos y de existencias de la aplicación sean correctos';
     RsMsg12 = 'Revisando y reajustando los documentos comerciales';
     RsMsg13 = 'Pedido de ventas nº %d';
     RsMsg14 = '[B]Datos del ejercicio anterior[/B]';
     RsMsg15 = 'Articulo : %s';
     RsMsg16 = '[B]Limpiando datos actuales[/B]';
     RsMsg17 = 'Regularizando cantidades pendientes de servir y recibir';
     RsMsg18 = 'Limpiando cantidades recibidas y servidas';
     RsMsg19 = 'No se ha encontrado el documento origen del %s %s %d (Propietario %s).'#13'Se ha suprimido la relación entre ambos documentos.';
     RsMsg20 = 'Recuperado el movimiento nº %d (lineas huérfanas)';
     RsMsg21 = '[B]Reconstruyendo datos del ejercicio actual[/B]';
     RsMsg22 = 'Líneas huérfanas recuperadas';
     RsMsg23 = 'Realizando la reasignación de números de registro';
     RsMsg24 = '[Color=Navy][B]Ejercicio %d[/B][/Color]';
     RsMsg25 = 'Revisando el contenido de las líneas de movimientos';
     RsMsg26 = 'Recálculo de las lineas de movimientos';
     RsMsg27 = 'Ajustando imágenes de los artículos';
     RsMsg28 = 'Se han corregido los vínculos erróneos del movimiento nº %d';
     RsMsg29 = 'Se han ajustado vínculos erróneos en los movimientos durante el proceso de reconstrucción.'#13'Debe repetir de nuevo el proceso para aplicar los cambios realizados';
     RsMsg30 = 'El movimiento %d %d no tiene líneas. Ha sido suprimido';
     RsMsg31 = 'La factura %s %d no tiene albaranes asignados. Ha sido suprimida.';
     RsMsg32 = 'Actualizado el registro contable de factura del asiento %d.';
     RsMsg33 = 'La factura %s %d no tiene albaranes asignados pero ha sido presentada (Veri*factu).';
     RsMsg34 = 'Recurra su soporte técnico para verificar el estado de sus ficheros de datos.';

{ TCantidadProcesadaItem }

constructor TCantidadProcesadaItem.Create( UnNroRegistro : LongInt );
begin
     inherited Create;
     NroRegistro := UnNroRegistro;
     Cantidad := 0.0;
end;

{ TCantidadProcesadaList }

procedure TCantidadProcesadaList.Clear;

var  I : Integer;

begin
     For I := 0 to Count - 1 do
       TCantidadProcesadaItem( Items[ I ] ).Free;
     inherited;
end;

function TCantidadProcesadaList.Add( UnNroRegistro : LongInt ) : TCantidadProcesadaItem;
begin
     Result := TCantidadProcesadaItem.Create( UnNroRegistro );
     inherited Add( Result );
end;

function TCantidadProcesadaList.Obten( UnNroRegistro : LongInt ) : TCantidadProcesadaItem;
begin
     Result := BuscaPorNroRegistro( UnNroRegistro );
     If   not Assigned( Result )
     then Result := Add( UnNroRegistro );
end;

function TCantidadProcesadaList.BuscaPorNroRegistro( UnNroRegistro : LongInt ) : TCantidadProcesadaItem;

var  I : Integer;
     CantidadProcesadaItem : TCantidadProcesadaItem;

begin
     Result := nil;
     For I := 0 to Count - 1 do
       begin
       CantidadProcesadaItem := TCantidadProcesadaItem( Items[ I ] );
       If   Assigned( CantidadProcesadaItem )
       then If   CantidadProcesadaItem.NroRegistro=UnNroRegistro
            then begin
                 Result := CantidadProcesadaItem;
                 Break;
                 end;
       end;
end;

//

procedure TReconstruccionResultadosModule.ServerDataModuleCreate(Sender: TObject);
begin
     ArticuloFields := TArticuloFields.Create( ArticuloTable );
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     GrupoLineaMovimientoFields := TGrupoLineaMovimientoFields.Create( GrupoLineaMovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     MovimientoAuxFields := TMovimientoFields.Create( MovimientoAuxTable );
     LineaMovimientoAuxFields := TLineaMovimientoFields.Create( LineaMovimientoAuxTable );
     LineaMovimientoAux1Fields := TLineaMovimientoFields.Create( LineaMovimientoAux1Table );
     FacturaComprasFields := TFacturaComprasFields.Create( FacturaComprasTable );
     FacturaVentasFields := TFacturaVentasFields.Create( FacturaVentasTable );
     StockFields := TStockFields.Create( StockTable );

     AsientoFields := TAsientoFields.Create( AsientoTable );
     FacturaFields := TFacturaFields.Create( FacturaTable );
     FacturaComercialFields := TFacturaFields.Create( FacturaComercialTable );

     EnvaseFields := TClaseFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Self );
     ClienteFields := TClienteFields.Create( Self );
     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );

     // ExecOnCreateComponentProcedures( idRdrModule );

end;

procedure TReconstruccionResultadosModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm30.ReconstruccionResultadosModule := nil
end;

procedure TReconstruccionResultadosModule.Reconstruccion;

var  EjercicioInicial : SmallInt;

begin

     If   MonthOf( Now )<=2
     then EjercicioInicial := SessionDataModule.Ejercicio - 1
     else EjercicioInicial := SessionDataModule.Ejercicio;

     Reconstruccion( EjercicioInicial,
                     SessionDataModule.Ejercicio,
                     { RevisarEstadoTablas } False,
                     { ReasignarNrosRegistro } False,
                     { RecalcularLineas } False );

end;

procedure TReconstruccionResultadosModule.Reconstruccion( EjercicioInicial,
                                                          EjercicioFinal          : SmallInt;
                                                          RevisarEstadoTablas,
                                                          ReasignarNrosRegistro ,
                                                          RecalcularLineas        : Boolean;
                                                          RecalcularFacturados    : Boolean = False;
                                                          RecalcularCosteFacturas : Boolean = False );

var   IsAnInteger,
      Canceled : Boolean;
      IntegerValue : Integer;
      Index  : SmallInt;
      EjercicioActual,
      SaveEjercicio,
      MesCalculo : SmallInt;
      SerieActual : String;
      CosteArticulosFactura : Decimal;
      Bm : TBookmark;
      StockFieldValues : TFieldValuesArray;
      CantidadPendiente,
      CantidadAProcesar,
      CantidadTotal,
      SumaCantidadProcesada : Decimal;
      NroOperacionActual,
      NroOperacionHuerfana : LongInt;
      Procesar : Boolean;
      CantidadProcesadaItem : TCantidadProcesadaItem;
      ListaCantidadesProcesadas : TCantidadProcesadaList;
      FieldValuesArray : TFieldValuesArray;
      AutoIncValue : TnxWord32;
      Hora : TDateTime;
      ErroresRelacion : Integer;
      NroRegistroActual,
      NroRegistro : LongWord;
      ExistenciasArticulo : IExistenciasArticulo;
      TransactionTag : TTransactionTag;
      Cycle : TCycle;

procedure SuprimeVinculoConFactura;
begin
     MovimientoTable.Edit;
     With MovimientoFields do
       begin
       EjercicioFactura.Clear;
       PropietarioFactura.Clear;
       SerieFactura.Clear;
       NroFactura.Clear;
       Facturado.Value := False;
       end;
end;

function CompruebaNroRegistroOrigen( LineaMovimientoFields : TLineaMovimientoFields ) : Boolean;
begin
     Result := False;
     With LineaMovimientoFields do
       begin

       If   ValueIsEmpty( NroRegistroOrigen.Value )
       then With LineaMovimientoAuxTable do
              try
                IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';
                SetRange( [ EjercicioOrigen.Value, NroOperacionOrigen.Value, 0, 1 ], [ EjercicioOrigen.Value, NroOperacionOrigen.Value, MaxSmallInt, MaxSmallInt ] );
                First;
                While not Eof do
                  begin
                  If   ( LineaMovimientoAuxFields.CodigoArticulo.Value=CodigoArticulo.Value ) and
                       ( LineaMovimientoAuxFields.CodigoClaseA.Value=CodigoClaseA.Value ) and
                       ( LineaMovimientoAuxFields.CodigoClaseB.Value=CodigoClaseB.Value ) and
                       ( LineaMovimientoAuxFields.CodigoClaseC.Value=CodigoClaseC.Value )
                  then begin
                       Dataset.Edit;
                       NroRegistroOrigen.Value := LineaMovimientoAuxFields.NroRegistro.Value;
                       Result := True;
                       Break;
                       end;
                  Next;
                  end;
              finally
                CancelRange;
                end;
       end;
end;

begin

     FEjercicioInicial := EjercicioInicial;
     FEjercicioFinal := EjercicioFinal;
     FRevisarEstadoTablas := RevisarEstadoTablas;
     FReasignarNrosRegistro := ReasignarNrosRegistro;
     FRecalcularLineas := RecalcularLineas;
     FRecalcularFacturados := RecalcularFacturados;
     FRecalcularCosteFacturas := RecalcularCosteFacturas;

     var UsarTransacciones := FRevisarEstadoTablas or FReasignarNrosRegistro or FRecalcularLineas or FRecalcularFacturados or FRecalcularCosteFacturas;

     try

       Hora := Now;
       Canceled := False;

       SaveEjercicio := SessionDataModule.Ejercicio;

       If   FEjercicioInicial=0
       then begin
            MovimientoTable.First;
            If   MovimientoTable.Eof
            then Exit
            else FEjercicioInicial := MovimientoFields.Ejercicio.Value;
            end;

       If   FEjercicioFinal=MaxSmallInt
       then begin
            MovimientoTable.Last;
            If   MovimientoTable.Bof
            then Exit
            else FEjercicioFinal := MovimientoFields.Ejercicio.Value;
            end;

       ListaCantidadesProcesadas := TCantidadProcesadaList.Create;

       If   UsarTransacciones
       then TransactionTag := SessionDataModule.StartTransaction;

       Cycle.Reset;

       try

         // La reasignación de números de registro se realiza a todo el contenido de la tabla de lineas de movimientos

         If   FReasignarNrosRegistro
         then With LineaMovimientoTable do
                begin
                Canceled := SessionDataModule.SendNotification( ntInformation, RsMsg23 );
                If   not Canceled
                then begin
                     NroRegistro := 1;
                     NroOperacionActual := 0;

                     First;
                     While not Eof do
                       begin
                       NroRegistroActual := LineaMovimientoFields.NroRegistro.Value;
                       With LineaMovimientoAuxTable do
                         begin
                         SetRange( [ NroRegistroActual ] );
                         First;
                         While not Eof do
                           begin
                           try
                             Edit;
                             LineaMovimientoAuxFields.NroRegistroOrigen.Value := NroRegistro;
                             Post;
                           except
                             Cancel;
                             raise;
                             end;
                           Next;
                           end;
                         end;

                       try
                         Edit;
                         LineaMovimientoFields.NroRegistro.Value := NroRegistro;
                         FOnReasignacionNroRegistro.Invoke( NroRegistroActual, NroRegistro );
                         Post;
                       except
                         Cancel;
                         raise;
                         end;

                       Inc( NroRegistro );

                       If   NroOperacionActual<>LineaMovimientoFields.NroOperacion.Value
                       then begin
                            NroOperacionActual := LineaMovimientoFields.NroOperacion.Value;
                            If   Cycle.Filled
                            then Canceled := SessionDataModule.SendNotification( ntRecord, IntToStr( LineaMovimientoFields.Ejercicio.Value ) + ' - ' + IntToStr( NroOperacionActual ) );
                            end;

                       Next;
                       end;

                     LineaMovimientoTable.SetAutoIncValue( NroRegistro );
                     end;
                end;

         If   Canceled
         then Abort;

         For EjercicioActual := FEjercicioInicial to FEjercicioFinal do
           begin

           Canceled := SessionDataModule.SendNotification( ntInformation, Format( RsMsg24, [ EjercicioActual ] ) );

           SessionDataModule.Ejercicio := EjercicioActual;

           Canceled := SessionDataModule.SendNotification( ntInformation, RsMsg16 );

           // Suprime datos del Ejercicio actual

           With EnterpriseDataModule do
             begin

             Canceled := SessionDataModule.SendNotification( ntInformation, 'Consumos de compras' );

             ExecSQLCommand( Format( 'DELETE FROM ConsumoCompras WHERE Ejercicio=%d', [ EjercicioActual ] ) );

             Canceled := SessionDataModule.SendNotification( ntInformation, 'Consumos de ventas' );
             ExecSQLCommand( Format( 'DELETE FROM ConsumoVentas WHERE Ejercicio=%d', [ EjercicioActual ] ) );

             Canceled := SessionDataModule.SendNotification( ntInformation, 'Existencias' );
             ExecSQLCommand( Format( 'DELETE FROM Stock WHERE Ejercicio=%d', [ EjercicioActual ] ) );
             {
             If   Assigned( Self.SessionDataModule.Dm203 )
             then ExecSQLCommand( 'DELETE FROM StockEnvases' );
             }
             Canceled := SessionDataModule.SendNotification( ntInformation, 'Datos económicos de artículos' );
             ExecSQLCommand( Format( 'DELETE FROM ArticuloDatEcon WHERE Ejercicio=%d', [ EjercicioActual ] ) );

             Canceled := SessionDataModule.SendNotification( ntInformation, 'Datos económicos de clientes' );
             ExecSQLCommand( Format( 'DELETE FROM ClienteDatEcon WHERE Ejercicio=%d', [ EjercicioActual ] ) );

             Canceled := SessionDataModule.SendNotification( ntInformation, 'Datos económicos de proveedores' );
             ExecSQLCommand( Format( 'DELETE FROM ProveedorDatEcon WHERE Ejercicio=%d', [ EjercicioActual ] ) );

             Canceled := SessionDataModule.SendNotification( ntInformation, 'Datos económicos de vendedores' );
             ExecSQLCommand( Format( 'DELETE FROM VendedorDatEcon WHERE Ejercicio=%d', [ EjercicioActual ] ) );

             //* 04.12.2006  Corrigiendo un problema con la creación de valores nulos en las claves de algunas tablas

             // Incluyo los ficheros de contabilidad ( que ya están en b_vec) por si el usuario no tiene el módulo contable

             If   FRevisarEstadoTablas
             then begin

                  Canceled := SessionDataModule.SendNotification( ntInformation, 'Revisión del estado de las tablas' );

                  ExecSQLCommand( 'UPDATE Asiento SET Serie='''' WHERE Serie IS NULL' );
                  ExecSQLCommand( 'UPDATE EfectoCobrar SET Serie='''' WHERE Serie IS NULL' );
                  ExecSQLCommand( 'UPDATE MovimientoCaja SET Serie='''' WHERE Serie IS NULL' );
                  ExecSQLCommand( 'UPDATE Existencia SET CentroCoste='''' WHERE CentroCoste IS NULL' );
                  ExecSQLCommand( 'UPDATE Proveedor SET Obsoleto=False WHERE Obsoleto IS NULL' );
                  ExecSQLCommand( 'UPDATE Factura SET TipoFactura=0 WHERE Ejercicio=' + IntToStr( SessionDataModule.Ejercicio ) + ' AND ( TipoFactura<0 OR TipoFactura>11 )' );
                  ExecSQLCommand( 'UPDATE Factura SET RegimenOTrascendencia=0 WHERE Ejercicio=' + IntToStr( SessionDataModule.Ejercicio ) + ' AND ( RegimenOTrascendencia<0 OR RegimenOTrascendencia>16 )' );

                  //  Borrando un registro vacío que se permitía crear hace mucho tiempo

                  ExecSQLCommand( 'DELETE FROM Articulo WHERE Codigo='''' ' );

                  ExecSQLCommand( 'UPDATE Articulo SET Obsoleto=False WHERE Obsoleto IS NULL' );
                  ExecSQLCommand( 'UPDATE Articulo SET EsListaMateriales=False WHERE EsListaMateriales IS NULL' );
                  ExecSQLCommand( 'UPDATE Articulo SET EsListaMateriales=False, Desglosar=False, CalcularPrecios=False WHERE ( SELECT DISTINCT CodigoArticulo FROM ListaMateriales WHERE Articulo.Codigo=ListaMateriales.CodigoArticulo AND ListaMateriales.NroLinea=0 ) IS NULL' );

                  // ExecSQLCommand( 'UPDATE Clase SET NroOrden=0 WHERE NroOrden<0' );

                  ExecSQLCommand( 'UPDATE ListaMateriales SET CodigoClaseA='''' WHERE CodigoClaseA IS NULL' );
                  ExecSQLCommand( 'UPDATE ListaMateriales SET CodigoClaseB='''' WHERE CodigoClaseB IS NULL' );
                  ExecSQLCommand( 'UPDATE ListaMateriales SET CodigoClaseC='''' WHERE CodigoClaseC IS NULL' );

                  ExecSQLCommand( 'UPDATE VentaPeriodica SET Serie='''' WHERE Serie IS NULL' );

                  ExecSQLCommand( 'UPDATE Movimiento SET FechaEmision=NULL WHERE FechaEmision=Date ''1899-12-30'' ' );
                  ExecSQLCommand( 'UPDATE Movimiento SET Facturado=False WHERE Facturado IS NULL' );
                  ExecSQLCommand( 'UPDATE Movimiento SET Traspasado=False WHERE Traspasado IS NULL' );
                  ExecSQLCommand( 'UPDATE LineaMovimiento SET NroPagina=0 WHERE NroPagina IS NULL' );
                  ExecSQLCommand( 'UPDATE LineaMovimiento SET CodigoAlmacen='''' WHERE CodigoAlmacen IS NULL' );

                  ExecSQLCommand( 'DELETE FROM TarifaVentas WHERE ( CantidadMinima IS NULL OR CantidadMinima=0.0 ) AND ( Precio IS NULL OR Precio=0.0 ) ' +
                                  'AND ( Recargo IS NULL OR Recargo=0.0 ) AND ( Descuento IS NULL OR Descuento=0.0 ) AND ' +
                                  '( PrecioParametro1 IS NULL OR PrecioParametro1=0.0 ) AND ( PrecioParametro2 IS NULL OR PrecioParametro2=0.0 ) AND ( PrecioParametro3 IS NULL OR PrecioParametro3=0.0 ) AND ( PrecioParametro4 IS NULL OR PrecioParametro4=0.0 )' );

                  Canceled := SessionDataModule.SendNotification( ntInformation, 'Limpieza de grupos de líneas sin cabecera y tarifas de venta vacías' );

                  //** 29.07.2013  Limpiando los grupos de líneas sin cabecera

                  ExecSQLCommand( Format( 'DELETE FROM GrupoLineaMovimiento WHERE Ejercicio=%d AND NroOperacion IN ( SELECT GrupoLineaMovimiento.NroOperacion FROM GrupoLineaMovimiento ' +
                                          'LEFT JOIN Movimiento ON ( Movimiento.Ejercicio=GrupoLineaMovimiento.Ejercicio AND Movimiento.NroOperacion=GrupoLineaMovimiento.NroOperacion ) ' +
                                          'WHERE GrupoLineaMovimiento.Ejercicio=%d AND Movimiento.NroOperacion IS NULL )', [ EjercicioActual, EjercicioActual ] ) );


                  end;

             end;

           //* Un corrector para verificar lineas de movimientos huerfanos y, de paso, comprobar si las fechas de las líneas coinciden con las de la cabecera y otros procesos de ajuste

           If   FRevisarEstadoTablas or
                FRecalcularLineas or
                FRecalcularFacturados
           then begin

                MovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion';
                LineaMovimientoAuxTable.IndexFieldNames := 'NroRegistro';
                NroOperacionActual := 0;
                ErroresRelacion := 0;

                With LineaMovimientoTable do
                  begin

                  Canceled := SessionDataModule.SendNotification( ntInformation, RsMsg12 );

                  Cycle.Reset;

                  SetRange( [ SessionDataModule.Ejercicio, 1, 0, 1 ], [ SessionDataModule.Ejercicio, MaxLongint, MaxSmallInt, MaxSmallInt ] );
                  First;
                  While not Eof and not Canceled do
                    begin

                    NroOperacionHuerfana := LineaMovimientoFields.NroOperacion.Value;

                    If   NroOperacionHuerfana<>NroOperacionActual
                    then begin

                         If   Cycle.Filled
                         then Canceled := SessionDataModule.SendNotification( ntRecord, IntToStr( LineaMovimientoFields.NroOperacion.Value ) );

                         If   not MovimientoTable.FindKey( [ SessionDataModule.Ejercicio, NroOperacionHuerfana ] )
                         then begin

                              MovimientoTable.Append;

                              MovimientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                              MovimientoFields.TipoMovimiento.Value := tmRecuperado;
                              MovimientoFields.NroOperacion.Value := NroOperacionHuerfana;
                              MovimientoFields.Fecha.Value := LineaMovimientoFields.Fecha.Value;
                              MovimientoFields.DescripcionMovimiento.Value := RsMsg22;

                              MovimientoTable.Post;
                              Canceled := SessionDataModule.SendNotification( ntWarning, Format( RsMsg20, [ MovimientoFields.NroOperacion.Value ] ) );

                              end;

                         SessionDataModule.Dm30.MovimientoModule.CompruebaPrimerNroPagina( MovimientoFields );

                         NroOperacionActual := MovimientoFields.NroOperacion.Value;

                         If   MovimientoFields.TipoMovimiento.Value in [ tmOferta..tmCompra ]
                         then SessionDataModule.Dm10.ProveedorModule.Obten( MovimientoFields.Propietario.Value, ProveedorFields )
                         else If   MovimientoFields.TipoMovimiento.Value in [ tmPresupuesto..tmVenta ]
                              then begin
                                   SessionDataModule.Dm10.ClienteModule.Obten( MovimientoFields.Propietario.Value, '', ClienteFields );
                                   SessionDataModule.Dm10.SerieFacturacionModule.Obten( MovimientoFields.Serie.Value, SerieFacturacionFields );
                                   end;

                         end;


                    With GrupoLineaMovimientoTable do
                      If   not FindKey( [ SessionDataModule.Ejercicio, LineaMovimientoFields.NroOperacion.Value, LineaMovimientoFields.NroPagina.Value ] )
                      then begin
                           Append;
                           With GrupoLineaMovimientoFields do
                             begin
                             Ejercicio.Value := MovimientoFields.Ejercicio.Value;
                             NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                             NroPagina.Value := LineaMovimientoFields.NroPagina.Value;
                             Descripcion.Value := 'Página ' + IntToStr( LineaMovimientoFields.NroPagina.Value + 1 );
                             end;
                           Post;
                           end;

                    If   MovimientoFields.Fecha.Value<>LineaMovimientoFields.Fecha.Value
                    then try
                           LineaMovimientoTable.Edit;
                           LineaMovimientoFields.Fecha.Value := MovimientoFields.Fecha.Value;
                           LineaMovimientoTable.Post;
                         except
                           LineaMovimientoTable.Cancel;
                           raise;
                           end
                    else begin

                         //* 28.05.2010 Intentando corregir un problema con la importación de albaranes desde preventa

                         If   LineaMovimientoFields.TipoMovimientoOrigen.Value=tmConsumos
                         then begin
                              LineaMovimientoAuxTable.SetRange( [ LineaMovimientoFields.NroRegistro.Value ] );
                              If    ( LineaMovimientoFields.NroRegistro.IsNull ) or
                                    ( LineaMovimientoFields.NroRegistro.Value=0 ) or
                                    ( LineaMovimientoAuxTable.RecordCount>1 )
                              then begin

                                   FieldValuesArray := LineaMovimientoTable.GetFieldValues;
                                   LineaMovimientoTable.Delete;

                                   LineaMovimientoAuxTable.Append;
                                   LineaMovimientoAuxTable.SetFieldValues( FieldValuesArray );
                                   LineaMovimientoAuxFields.NroRegistro.Clear;
                                   LineaMovimientoAuxTable.Post;

                                   end;
                              end;

                         end;

                    // Cuando se quieren reasignar el NroRegistro se pone a NULL con un proceso externo (por ejemplo una sentencia SQL) y luego con
                    // este proceso se le asigna un valor nuevo

                    If   LineaMovimientoFields.NroRegistro.Value=0
                    then begin
                         LineaMovimientoTable.Edit;
                         LineaMovimientoTable.GetAutoIncValue( AutoIncValue );
                         Inc( AutoIncValue );
                         LineaMovimientoFields.NroRegistro.Value := AutoIncValue;
                         LineaMovimientoTable.SetAutoIncValue( AutoIncValue );
                         end;

                    // Si se han estado utilizando clases y luego se desactivan se tienen que eliminar de los movimientos para evitar errores de calculo en las existencias

                    try

                      With SessionDataModule.EmpresaFields do
                        begin
                        If   not Articulo_ExisteClase[ tcClaseA ].Value and ( LineaMovimientoFields.CodigoClaseA.Value<>'' )
                        then begin
                             LineaMovimientoTable.Edit;
                             LineaMovimientoFields.CodigoClaseA.Value := '';
                             end;
                        If   not Articulo_ExisteClase[ tcClaseB ].Value and ( LineaMovimientoFields.CodigoClaseB.Value<>'' )
                        then begin
                             LineaMovimientoTable.Edit;
                             LineaMovimientoFields.CodigoClaseB.Value := '';
                             end;
                        If   not Articulo_ExisteClase[ tcClaseC ].Value and ( LineaMovimientoFields.CodigoClaseC.Value<>'' )
                        then begin
                             LineaMovimientoTable.Edit;
                             LineaMovimientoFields.CodigoClaseC.Value := '';
                             end;
                        end;

                      If   FRecalcularLineas and ( FRecalcularFacturados or not MovimientoFields.Facturado.Value )
                      then RecalculaImportesLinea;

                      If   LineaMovimientoTable.State=dsEdit
                      then LineaMovimientoTable.Post;

                    except
                      LineaMovimientoTable.Cancel;
                      raise;
                      end;

                    Next;
                    end;

                  end;

                end;

           If   Canceled
           then Abort;

           Canceled := SessionDataModule.SendNotification( ntInformation, RsMsg14 );

           Cycle.Reset;

           With StockTable do
             try

               SetRange( [ EjercicioActual - 1, '', '', '',  '',  '',  '',  '' ],
                         [ EjercicioActual - 1, HighStrCode, HighStrCode, HighStrCode, HighStrCode, HighStrCode, HighStrCode, HighStrCode ] );

               First;
               While not Eof and not Canceled do
                 begin

                 If   Cycle.Filled    // El exceso de mensajes ralentiza el proceso. Solo lo envio una de cada 30 veces.
                 then Canceled := SessionDataModule.SendNotification( ntRecord, Format( RsMsg15, [ StockFields.CodigoArticulo.Value ] ) );

                 StockFieldValues := GetFieldValues;
                 Bm := GetBookMark;

                 Append;

                 SetFieldValues( StockFieldValues );

                 StockFields.Ejercicio.Value := EjercicioActual;

                 StockFields.PendienteServir[ 0 ].Value := StockFields.PendienteServir[ 1 ].Value;
                 StockFields.PendienteRecibir[ 0 ].Value := StockFields.PendienteRecibir[ 1 ].Value;
                 StockFields.PendienteServir[ 1 ].Value := 0.0;
                 StockFields.PendienteRecibir[ 1 ].Value := 0.0;

                 For Index := 0 to 12 do
                   begin
                   StockFields.MovimientoMes[ Index, 0 ].Value := 0.0;
                   StockFields.MovimientoMes[ Index, 1 ].Value := 0.0;
                   end;

                 If   ArticuloTable.FindKey( [ StockFields.CodigoArticulo.Value ] )
                 then If   ArticuloFields.NoAfectarCoste.Value
                      then begin
                           StockFields.CosteUltEntrada.Clear;
                           StockFields.Coste_Medio.Clear;
                           StockFields.FechaUltEntradaCoste.Clear;
                           end;

                 Post;

                 GotoBookMark( Bm );

                 Next;
                 end;
             finally
               CancelRange;
               end;


           If   Canceled
           then Abort;

           // Reconstrucción de existencias, cantidades pendientes de facturar y consumos

           Canceled := SessionDataModule.SendNotification( ntInformation, RsMsg21 );
           FUltimoNroOperacionCorregido := 0;

           FacturaComprasTable.IndexFieldNames := 'Ejercicio;Proveedor;SerieNroFactura';
           FacturaVentasTable.IndexFieldNames := 'Ejercicio;Serie;NroFactura';

           Cycle.Reset;

           With MovimientoTable do
             try
               IndexFieldNames := 'Ejercicio;NroOperacion';
               SetRange( [ SessionDataModule.Ejercicio, 1 ], [ SessionDataModule.Ejercicio, MaxLongint ] );
               First;
               While not Eof and not Canceled do
                 begin

                 If   Cycle.Filled
                 then Canceled := SessionDataModule.SendNotification( ntRecord, Format( RsMsg4, [ MovimientoFields.NroOperacion.Value ] ) );

                 If   FRevisarEstadoTablas
                 then With MovimientoFields do
                         case TipoMovimiento.Value of
                           tmCompra : If   Facturado.Value
                                      then If   not FacturaComprasTable.FindKey( [ EjercicioFactura.Value, PropietarioFactura.Value, SerieFactura.Value ] )
                                           then SuprimeVinculoConFactura;

                           tmVenta  : If   Facturado.Value
                                      then If   not FacturaVentasTable.FindKey( [ EjercicioFactura.Value, SerieFactura.Value, NroFactura.Value ] )
                                           then SuprimeVinculoConFactura;
                           end;

                 With MovimientoFields do
	                  LineaMovimientoTable.SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallInt, MaxSmallInt ] );

                 // Comprobando si existen cabeceras vacías (sin líneas)

                 If   LineaMovimientoTable.RecordCount=0
                 then begin
                      If   FRevisarEstadoTablas
                      then begin
                           SessionDataModule.SendNotification( ntWarning, Format( RsMsg30, [ MovimientoFields.Ejercicio.Value, MovimientoFields.NroOperacion.Value ] ) );
                           MovimientoTable.Delete;
                           Continue;   // El Delete posiciona el cursor automáticamente en el registro siguiente
                           end;
                      end
                 else begin

                      If   not MovimientoFields.Anulado.Value and
                           not ( MovimientoFields.TipoMovimiento.Value in [ tmOferta, tmPresupuesto ] )
                      then begin

                           NetoMovimiento := 0.0;

                           With LineaMovimientoTable do
                             try
                               First;
                               While not Eof and not Canceled do
                                 begin

                                 With LineaMovimientoFields do
                                   begin

                                   If   FRevisarEstadoTablas and ( Fecha.Value<>MovimientoFields.Fecha.Value )
                                   then begin
                                        Edit;
                                        Fecha.Value := MovimientoFields.Fecha.Value;
                                        end;

                                   case MovimientoFields.TipoMovimiento.Value of
                                     tmPedidoCompra,
                                     tmPedidoVenta  : If   ( MovimientoFields.Situacion.Value<>epProcesado ) and
                                                           not ( LineaMovimientoFields.Procesada.Value )
                                                      then begin

                                                           CantidadTotal := 0.0;
                                                           CantidadAProcesar := 0.0;

                                                           With LineaMovimientoAuxTable do
                                                             begin
                                                             IndexFieldNames := 'NroRegistroOrigen';
                                                             SetRange( [ LineaMovimientoFields.NroRegistro.Value ] );
                                                             First;
                                                             While not Eof do
                                                               begin
                                                               If   LineaMovimientoAuxFields.NroOperacionOrigen.Value=LineaMovimientoFields.NroOperacion.Value
                                                               then If   LineaMovimientoAuxFields.CodigoArticulo.Value=LineaMovimientoFields.CodigoArticulo.Value
                                                                    then begin
                                                                         If   MovimientoAuxTable.FindKey( [ LineaMovimientoAuxFields.Ejercicio.Value, LineaMovimientoAuxFields.NroOperacion.Value ] )
                                                                         then If   MovimientoAuxFields.TipoMovimiento.Value in [ tmCompra, tmVenta ]
                                                                         then begin
                                                                              DecAdd( CantidadTotal, DecSign( LineaMovimientoAuxFields.Cantidad.Value, MovimientoFields.TipoMovimiento.Value=tmPedidoCompra ) );
                                                                              If   YearOf( LineaMovimientoAuxFields.Fecha.Value )=SessionDataModule.Ejercicio
                                                                              then DecAdd( CantidadAProcesar, DecSign( LineaMovimientoAuxFields.Cantidad.Value, MovimientoFields.TipoMovimiento.Value=tmPedidoCompra ) );
                                                                              end;
                                                                         end;
                                                               Next;
                                                               end;

                                                             end;

                                                           // Se han agregado a albaranes una cantidad mayor de la existente en el pedido

                                                           If   CantidadAProcesar>LineaMovimientoFields.Cantidad.Value
                                                           then CantidadAProcesar := LineaMovimientoFields.Cantidad.Value;

                                                           CantidadPendiente := LineaMovimientoFields.Cantidad.Value - CantidadAProcesar;

                                                           If   CantidadPendiente<>0.0
                                                           then SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( MovimientoFields, LineaMovimientoFields, False, CantidadPendiente );

                                                           // Una oportunidad para corregir las cantidades procesadas

                                                           If   FRevisarEstadoTablas and
                                                               	( LineaMovimientoFields.CantidadProcesada.Value<>CantidadTotal ) and
                                                                ( CantidadTotal<=LineaMovimientoFields.Cantidad.Value )
                                                           then begin
                                                                LineaMovimientoTable.Edit;
                                                                LineaMovimientoFields.CantidadProcesada.Value := CantidadTotal;
                                                                end;

                                                        end;

                                     else             begin

                                                      SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( MovimientoFields, LineaMovimientoFields );

                                                      If   ( MovimientoFields.TipoMovimiento.Value in [ tmCompra, tmVenta ] ) and
                                                           ( LineaMovimientoFields.NroRegistroOrigen.Value<>0 )
                                                      then With LineaMovimientoAuxTable do
                                                             begin
                                                             IndexFieldNames := 'NroRegistro';
                                                             If   FindKey( [ LineaMovimientoFields.NroRegistroOrigen.Value ] )
                                                             then If   LineaMovimientoAuxFields.CodigoArticulo.Value=LineaMovimientoFields.CodigoArticulo.Value
                                                                  then begin
                                                                       If   YearOf( LineaMovimientoAuxFields.Fecha.Value )<SessionDataModule.Ejercicio
                                                                       then begin
                                                                            If   MovimientoAuxTable.FindKey( [ LineaMovimientoAuxFields.Ejercicio.Value, LineaMovimientoAuxFields.NroOperacion.Value ] )
                                                                            then If   ( MovimientoAuxFields.TipoMovimiento.Value in [ tmPedidoCompra, tmPedidoVenta ] ) and
                                                                                      ( MovimientoAuxFields.Situacion.Value<>epProcesado ) and
                                                                                    not LineaMovimientoAuxFields.Procesada.Value   //** 09.11.2015 Evitando que se procesen las l�nea regularizadas manualmente
                                                                                 then begin
                                                                                      CantidadAProcesar := DecSign( LineaMovimientoFields.Cantidad.Value, MovimientoFields.TipoMovimiento.Value=tmCompra );

                                                                                      CantidadProcesadaItem := ListaCantidadesProcesadas.Obten( LineaMovimientoFields.NroRegistroOrigen.Value );
                                                                                      If   Assigned( CantidadProcesadaItem )
                                                                                      then If   CantidadProcesadaItem.Cantidad<LineaMovimientoAuxFields.CantidadProcesada.Value
                                                                                           then begin

                                                                                                If    ( CantidadProcesadaItem.Cantidad + CantidadAProcesar ) > LineaMovimientoAuxFields.CantidadProcesada.Value
                                                                                                then begin
                                                                                                     CantidadAProcesar := LineaMovimientoAuxFields.CantidadProcesada.Value - CantidadProcesadaItem.Cantidad;
                                                                                                     CantidadProcesadaItem.Cantidad := LineaMovimientoAuxFields.CantidadProcesada.Value;
                                                                                                     end
                                                                                                else DecAdd( CantidadProcesadaItem.Cantidad, CantidadAProcesar );

                                                                                                If   CantidadAProcesar>0.0
                                                                                                then SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( MovimientoAuxFields, LineaMovimientoAuxFields, True, CantidadAProcesar );
                                                                                                end;


                                                                                      end;
                                                                            end;
                                                                       end
                                                                  else If   FRevisarEstadoTablas and CompruebaNroRegistroOrigen( LineaMovimientoFields )
                                                                       then begin
                                                                            If   FUltimoNroOperacionCorregido<>LineaMovimientoFields.NroOperacion.Value
                                                                            then SessionDataModule.SendNotification( ntWarning, Format( RsMsg28, [ LineaMovimientoFields.NroOperacion.Value ] ) );
                                                                            FUltimoNroOperacionCorregido := LineaMovimientoFields.NroOperacion.Value;
                                                                            end;
                                                             end;

                                                      case MovimientoFields.TipoMovimiento.Value of
                                                        tmCompra : If   MovimientoFields.Facturado.Value
                                                                   then begin

                                                                        //** 23.11.2009 Los consumos deben actualizarse a partir de los albaranes, porque si no se hace as�, los albaranes de ejercicios anteriores se incluyen en la reconstrucci�n

                                                                        If   ( LineaMovimientoFields.CodigoArticulo.Value<>ArticuloManual ) and
                                                                             MovimientoFields.Traspasado.Value
                                                                        then begin
                                                                             SessionDataModule.Dm30.StockAlmacenModule.ActualizaConsumoCompras( tcArticulo,
                                                                                                                                                MovimientoFields.Propietario.Value,
                                                                                                                                                LineaMovimientoFields.CodigoArticulo.Value,
                                                                                                                                                LineaMovimientoFields.CodigoClaseA.Value,
                                                                                                                                                LineaMovimientoFields.CodigoClaseB.Value,
                                                                                                                                                LineaMovimientoFields.CodigoClaseC.Value,
                                                                                                                                                LineaMovimientoFields.Fecha.Value,
                                                                                                                                                LineaMovimientoFields.Cantidad.Value,
                                                                                                                                                LineaMovimientoFields.ImporteNeto.Value,
                                                                                                                                                LineaMovimientoFields.ImporteDescuento.Value );

                                                                             If   ArticuloTable.FindKey( [ LineaMovimientoFields.CodigoArticulo.Value ] )
                                                                             then If   not ValueIsEmpty( ArticuloFields.Familia.Value )
                                                                                  then SessionDataModule.Dm30.StockAlmacenModule.ActualizaConsumoCompras( tcFamilia,
                                                                                                                                                          MovimientoFields.Propietario.Value,
                                                                                                                                                          ArticuloFields.Familia.Value,
                                                                                                                                                          LineaMovimientoFields.CodigoClaseA.Value,
                                                                                                                                                          LineaMovimientoFields.CodigoClaseB.Value,
                                                                                                                                                          LineaMovimientoFields.CodigoClaseC.Value,
                                                                                                                                                          LineaMovimientoFields.Fecha.Value,
                                                                                                                                                          LineaMovimientoFields.Cantidad.Value,
                                                                                                                                                          LineaMovimientoFields.ImporteNeto.Value,
                                                                                                                                                          LineaMovimientoFields.ImporteDescuento.Value );

                                                                             end;

                                                                        end
                                                                   else DecAdd( NetoMovimiento, LineaMovimientoFields.ImporteNeto.Value );

                                                        tmVenta  : If   MovimientoFields.Facturado.Value
                                                                   then begin

                                                                        //** 23.11.2009 Los consumos deben actualizarse a partir de los albaranes, porque si no se hace asÍ, los albaranes de ejercicios anteriores se incluyen en la reconstrucciÓn

                                                                        If   ( LineaMovimientoFields.CodigoArticulo.Value<>ArticuloManual ) and
                                                                             MovimientoFields.Traspasado.Value
                                                                        then begin
                                                                             SessionDataModule.Dm30.StockAlmacenModule.ActualizaConsumoVentas( tcArticulo,
                                                                                                                                               MovimientoFields.Propietario.Value,
                                                                                                                                               LineaMovimientoFields.CodigoArticulo.Value,
                                                                                                                                               LineaMovimientoFields.CodigoClaseA.Value,
                                                                                                                                               LineaMovimientoFields.CodigoClaseB.Value,
                                                                                                                                               LineaMovimientoFields.CodigoClaseC.Value,
                                                                                                                                               LineaMovimientoFields.Fecha.Value,
                                                                                                                                               -LineaMovimientoFields.Cantidad.Value,
                                                                                                                                               LineaMovimientoFields.ImporteNeto.Value,
                                                                                                                                               LineaMovimientoFields.ImporteDescuento.Value );

                                                                             If   ArticuloTable.FindKey( [ LineaMovimientoFields.CodigoArticulo.Value ] )
                                                                             then If   not ValueIsEmpty( ArticuloFields.Familia.Value )
                                                                                  then SessionDataModule.Dm30.StockAlmacenModule.ActualizaConsumoVentas( tcFamilia,
                                                                                                                                                         MovimientoFields.Propietario.Value,
                                                                                                                                                         ArticuloFields.Familia.Value,
                                                                                                                                                         LineaMovimientoFields.CodigoClaseA.Value,
                                                                                                                                                         LineaMovimientoFields.CodigoClaseB.Value,
                                                                                                                                                         LineaMovimientoFields.CodigoClaseC.Value,
                                                                                                                                                         LineaMovimientoFields.Fecha.Value,
                                                                                                                                                         -LineaMovimientoFields.Cantidad.Value,
                                                                                                                                                         LineaMovimientoFields.ImporteNeto.Value,
                                                                                                                                                         LineaMovimientoFields.ImporteDescuento.Value );

                                                                             end;

                                                                        end
                                                                   else DecAdd( NetoMovimiento, LineaMovimientoFields.ImporteNeto.Value );

                                                           end;

                                                       end;
                                     end;

                                   end;

                                 If   Modified
                                 then Post;

                                 Next;
                                 end;

                             finally
                               CancelRange;
                               end;

                           If   ( MovimientoFields.TipoMovimiento.Value=tmVenta ) and
                                not MovimientoFields.Facturado.Value and
                                not MovimientoFields.Anulado.Value and
                                ( NetoMovimiento<>0.0 )
                           then SessionDataModule.Dm30.RelacionesClienteModule.ActualizaPendiente( MovimientoFields.Ejercicio.Value, MovimientoFields.Propietario.Value, NetoMovimiento );

                           If   Modified
                           then Post;

                           end;

                      end;

                 Next;
                 end;

             finally
               CancelRange;
               end;

           If   Canceled
           then Abort;

           // Resultados de compras

           Canceled := SessionDataModule.SendNotification( ntInformation, RsMsg5 );

           With FacturaComprasTable do
             try
               IndexFieldNames := 'Fecha';
               SetRange( [ SessionDataModule.FechaPrimerDiaEjercicio ], [ SessionDataModule.FechaUltimoDiaEjercicio ] );
               First;
               While not Eof and not Canceled do
                 begin
                 If   FacturaComprasFields.Traspasada.Value
                 then SessionDataModule.Dm30.FacturaComprasModule.ActualizaDatosEconomicos( FacturaComprasFields, nil, False, False );
                 Next;
                 end;
             finally
               CancelRange;
               end;

           If   Canceled
           then Abort;

           // Resultados de ventas

           SerieActual := #0;

           MovimientoTable.IndexFieldNames := 'TipoMovimiento;EjercicioFactura;PropietarioFactura;SerieFactura;NroFactura';

           With FacturaVentasTable do
             try

               IndexFieldNames := 'Serie;Fecha;NroFactura';
               SetRange( [ Null, SessionDataModule.FechaPrimerDiaEjercicio, 1 ], [ HighStrCode, SessionDataModule.FechaUltimoDiaEjercicio, MaxLongint ] );
               First;

               While not Eof and not Canceled do
                 begin

                 With FacturaVentasFields do
                   MovimientoTable.SetRange( [ tmVenta, Ejercicio.Value, CodigoCliente.Value, Serie.Value, NroFactura.Value ],
                                             [ tmVenta, Ejercicio.Value, CodigoCliente.Value, Serie.Value, NroFactura.Value ] );

                 MovimientoTable.First;
                 If   MovimientoTable.Eof
                 then begin
                      If   FacturaVentasFields.Huella.IsNull   // No voy a suprimir una factura de ventas presentada, aunque haya perdido los albaranes
                      then begin
                           Canceled := SessionDataModule.SendNotification( ntWarning, Format( RsMsg31, [ FacturaVentasFields.Serie.Value, FacturaVentasFields.NroFactura.Value ] ) );
                           FacturaVentasTable.Delete;
                           end
                      else Canceled := SessionDataModule.SendNotification( ntWarning, Format( RsMsg34, [ FacturaVentasFields.Serie.Value, FacturaVentasFields.NroFactura.Value ] ) );
                      end
                 else begin
                      If   not FacturaVentasFields.Anulada.Value and
                           FacturaVentasFields.Traspasada.Value
                      then begin

                           If   SerieActual<>FacturaVentasFields.Serie.Value
                           then begin
                                SessionDataModule.Dm10.SerieFacturacionModule.Obten( FacturaVentasFields.Serie.Value, SerieFacturacionFields );
                                SerieActual := FacturaVentasFields.Serie.Value;
                                end;

                           //* Intentando reconstruir un coste razonable de los artículos incluídos en la factura

                           If   FRecalcularCosteFacturas or ( ( FacturaVentasFields.CosteArticulos.Value=0.0 ) and ( FacturaVentasFields.BrutoArticulos.Value<>0.0 ) )
                           then begin

                                CosteArticulosFactura := 0.0;

                                With MovimientoTable do
                                  While not Eof do
                                    begin

                                    With LineaMovimientoTable do
                                      begin

                                      With MovimientoFields do
                                        SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallInt, MaxSmallInt ] );

                                      First;
                                      While not Eof do
                                        begin

                                        MesCalculo := MonthOf( MovimientoFields.Fecha.Value );

                                        With LineaMovimientoFields do
                                          If   CodigoArticulo.Value<>ArticuloManual
                                          then begin

                                               ExistenciasArticulo := SessionDataModule.Dm30.StockAlmacenModule.ObtenStock( CodigoArticulo.Value,
                                                                                                                            False,
                                                                                                                            CodigoClaseA.Value,
                                                                                                                            CodigoClaseB.Value,
                                                                                                                            CodigoClaseC.Value,
                                                                                                                            False,
                                                                                                                            LoteFabricacion.Value,
                                                                                                                            False,
                                                                                                                            CodigoAlmacen.Value,
                                                                                                                            False,
                                                                                                                            Ubicacion.Value,
                                                                                                                            True,                  // Obten coste
                                                                                                                            Ejercicio.Value,
                                                                                                                            MesCalculo,
                                                                                                                            MesCalculo );

                                               DecAdd( CosteArticulosFactura, ExistenciasArticulo.Coste * ( -Cantidad.Value ) );
                                               end;

                                        Next;
                                        end;

                                      end;

                                    Next;
                                    end;

                                Edit;
                                FacturaVentasFields.CosteArticulos.Value := CosteArticulosFactura;
                                Post;
                                end;

                           SessionDataModule.Dm30.FacturaVentasModule.ActualizaDatosEconomicos( SerieFacturacionFields, FacturaVentasFields, nil, False, False );
                           end;
                      Next;
                      end;
                 end;

             finally
               MovimientoTable.CancelRange;
               LineaMovimientoTable.CancelRange;
               CancelRange;
               end;

           If   Canceled
           then Abort;

           end;

         If   FUltimoNroOperacionCorregido<>0
         then Canceled := SessionDataModule.SendNotification( ntError, RsMsg29 );

         If   UsarTransacciones
         then TransactionTag.Commit;

       except on E : Exception do
         begin
         If   UsarTransacciones
         then TransactionTag.Rollback;
         SessionDataModule.SendNotification( ntError, RsMsg11 );
         Exit;
         end;
       end;


        SessionDataModule.SendNotification( ntInformation, 'El proceso ha durado  : ' + FormatDateTime( 'HH:MM:SS', Now - Hora ) );

     finally
       ListaCantidadesProcesadas.Free;
       SessionDataModule.Ejercicio := SaveEjercicio;
       end;
end;

procedure TReconstruccionResultadosModule.RecalculaImportesLinea;
begin

     // Utilizo la función del módulo y no la tabla porque en caso de no existir ésta devuelve el artículo genérico

     SessionDataModule.Dm30.ArticuloModule.Obten( LineaMovimientoFields.CodigoArticulo.Value, ArticuloFields );

     LineaMovimientoTable.Edit;

     If   MovimientoFields.TipoMovimiento.Value in [ tmOferta..tmCompra ]
     then SessionDataModule.Dm30.FacturaComprasModule.CalculaImportesIVA( LineaMovimientoFields,
                                                                          ProveedorFields,
                                                                          ArticuloFields,
                                                                          TiposIVAFields )
     else If   MovimientoFields.TipoMovimiento.Value in [ tmPresupuesto..tmVenta ]
          then SessionDataModule.Dm30.FacturaVentasModule.CalculaImportesIVA( LineaMovimientoFields,
                                                                              ClienteFields,
                                                                              ArticuloFields,
                                                                              SerieFacturacionFields,
                                                                              TiposIVAFields,
                                                                              MovimientoFields.IVAIncluido.Value )
          else SessionDataModule.Dm30.FacturaComprasModule.CalculaImportes( LineaMovimientoFields, ArticuloFields );

end;

procedure TReconstruccionResultadosModule.RecalculoLineas( EjercicioInicial,
                                                           EjercicioFinal    : SmallInt );

var   Index,
      EjercicioActual,
      SaveEjercicio : SmallInt;
      SerieActual : String;
      NroOperacionActual : LongInt;
      NroRegistroActual,
      NroRegistro : LongWord;
      Canceled : Boolean;

begin

   try

     Canceled := False;
     SaveEjercicio := SessionDataModule.Ejercicio;

     If   EjercicioInicial=0
     then begin
          MovimientoTable.First;
          If   MovimientoTable.Eof
          then Exit
          else EjercicioInicial := MovimientoFields.Ejercicio.Value;
          end;

     If   EjercicioFinal=MaxSmallInt
     then begin
          MovimientoTable.Last;
          If   MovimientoTable.Bof
          then Exit
          else EjercicioFinal := MovimientoFields.Ejercicio.Value;
          end;


     var TransactionTag := SessionDataModule.StartTransaction;

     try

       MovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion';
       LineaMovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';
       LineaMovimientoAuxTable.IndexFieldNames := 'NroRegistro';
       NroRegistroActual := 0;
       NroOperacionActual := 0;

       With LineaMovimientoTable do
         begin

         Canceled := SessionDataModule.SendNotification( ntInformation, RsMsg25 );

         SetRange( [ EjercicioInicial, 1, 0, 1 ], [ EjercicioFinal, MaxLongint, MaxSmallInt, MaxSmallInt ] );

         SessionDataModule.SendProgress( '', RecordCount, 0 );  // Inicialización : en este caso se envía el valor máximo

         First;
         While not Eof do
           begin

           // No me queda más remedio que realizar una recuperación de la cabecera

           If   LineaMovimientoFields.NroOperacion.Value<>NroOperacionActual
           then begin

                If   not MovimientoTable.FindKey( [ LineaMovimientoFields.Ejercicio.Value, LineaMovimientoFields.NroOperacion.Value ] )
                then begin

                     MovimientoTable.Append;

                     MovimientoFields.Ejercicio.Value := LineaMovimientoFields.Ejercicio.Value;
                     MovimientoFields.TipoMovimiento.Value := tmEntrada;
                     MovimientoFields.NroOperacion.Value := LineaMovimientoFields.NroOperacion.Value;
                     MovimientoFields.Fecha.Value := LineaMovimientoFields.Fecha.Value;

                     MovimientoTable.Post;
                     end;

                SessionDataModule.Ejercicio := SessionDataModule.EjercicioFecha( MovimientoFields.Fecha.Value );

                NroOperacionActual := MovimientoFields.NroOperacion.Value;

                If   MovimientoFields.TipoMovimiento.Value in [ tmOferta..tmCompra ]
                then SessionDataModule.Dm10.ProveedorModule.Obten( MovimientoFields.Propietario.Value, '', ProveedorFields )
                else If   MovimientoFields.TipoMovimiento.Value in [ tmPresupuesto..tmVenta ]
                     then begin
                          SessionDataModule.Dm10.ClienteModule.Obten( MovimientoFields.Propietario.Value, '', ClienteFields );
                          SessionDataModule.Dm10.SerieFacturacionModule.Obten( MovimientoFields.Serie.Value, SerieFacturacionFields );
                          end;

                end;

           RecalculaImportesLinea;

           LineaMovimientoTable.Post;

           SessionDataModule.SendProgress( '', RecordCount, NroRegistroActual );

           Inc( NroRegistroActual );

           Next;
           end;

         end;

     TransactionTag.Commit;

     except on E : exception do
       begin
       TransactionTag.Rollback;
       SessionDataModule.SendNotification( ntError, RsMsg11 );
       end;
     end;

   finally
     SessionDataModule.Ejercicio := SaveEjercicio;
     end;

end;

function TReconstruccionResultadosModule.RecalculaFactura( CodigoCliente, Serie : String; NroFactura : LongInt ) : Boolean;

var   Index : SmallInt;
      NroOperacionActual : LongInt;
      NroRegistroActual,
      NroRegistro : LongWord;
      Canceled : Boolean;
      TasasArray : TTasasArray;

begin

     Result := False;

     // Ejercicio;Serie;NroFactura

     If   FacturaVentasTable.FindKey( [ SessionDataModule.Ejercicio, Serie, NroFactura ] )
     then begin

          Canceled := False;

          var TransactionTag := SessionDataModule.StartTransaction;

          try

            MovimientoTable.IndexFieldNames := 'TipoMovimiento;EjercicioFactura;PropietarioFactura;SerieFactura;NroFactura';
            LineaMovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';
            LineaMovimientoAuxTable.IndexFieldNames := 'NroRegistro';
            NroRegistroActual := 0;
            NroOperacionActual := 0;

            SessionDataModule.Dm10.ClienteModule.Obten( CodigoCliente, '', ClienteFields );
            SessionDataModule.Dm10.SerieFacturacionModule.Obten( Serie, SerieFacturacionFields );

            MovimientoTable.SetRange( [ tmVenta, SessionDataModule.Ejercicio, CodigoCliente, Serie, NroFactura ] );

            With MovimientoTable do
              begin

              First;
              While not Eof do
                begin

                With LineaMovimientoTable do
                  begin

                  SetRange( [ MovimientoFields.Ejercicio.Value, MovimientoFields.NroOperacion.Value, 0, 1 ],
                            [ MovimientoFields.Ejercicio.Value, MovimientoFields.NroOperacion.Value, MaxSmallInt, MaxSmallInt ] );

                  First;
                  While not Eof do
                    begin
                    RecalculaImportesLinea;
                    LineaMovimientoTable.Post;
                    Inc( NroRegistroActual );
                    Next;
                    end;

                  end;

                Next;
                end;

              end;

            // Recalcular la factura

            FacturaVentasTable.Edit;
            SessionDataModule.Dm30.FacturaVentasModule.RecalculaFactura( FacturaVentasFields, { RecuperaCliente } True, TasasArray );
            FacturaVentasTable.Post;

            TransactionTag.Commit;

            Result := True;

          except on E : exception do
            begin
            TransactionTag.Rollback;
            SessionDataModule.SendNotification( ntError, RsMsg11 );
            end;
          end;

          end;

end;

{ TReconstruccionResultadosService }

procedure TReconstruccionResultadosService.AssignSession( const SessionID : Integer );
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TReconstruccionResultadosService.Reconstruccion( EjercicioInicial, EjercicioFinal : SmallInt; RevisarEstadoTablas, ReasignarNrosRegistro, RecalcularLineas : Boolean; RecalcularFacturados : Boolean = False; RecalcularCosteFacturas : Boolean = False );
begin
     SessionDataModule.Dm30.ReconstruccionResultadosModule.Reconstruccion( EjercicioInicial, EjercicioFinal, RevisarEstadoTablas, ReasignarNrosRegistro, RecalcularLineas, RecalcularFacturados, RecalcularCosteFacturas );
end;

function TReconstruccionResultadosService.RecalculaFactura( CodigoCliente, Serie : String; NroFactura : LongInt ) : Boolean;
begin
    Result := SessionDataModule.Dm30.ReconstruccionResultadosModule.RecalculaFactura( CodigoCliente, Serie, NroFactura );
end;

var ReconstruccionResultadosControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_ReconstruccionResultadosService, TReconstruccionResultadosService, ReconstruccionResultadosControl );

end.

