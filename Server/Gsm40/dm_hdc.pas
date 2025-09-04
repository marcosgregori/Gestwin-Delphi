
unit dm_hdc;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,
  DataManager,
  ServerDataModule,
  SessionIntf,

  LibUtils,
  SQLSet,

  Gim10Fields,
  Gim30Fields,
  Gim40Fields,

  dmi_hdc,

  HojaCargaIntf,
  LineaHojaCargaIntf;

type

  THojaCargaService = class( TSessionModule, IHojaCargaService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    procedure Inicializa;
    function ObtenCantidadCargada( NroRegistro : LongInt ) : Decimal;
    function ProximoNroHoja( Ejercicio : SmallInt = 0 ) : LongInt;
    procedure GenerarAlbaranes( Ejercicio : SmallInt; NroHoja : LongInt; SerieAlbaran : String = ''; FechaInicial : TDateTime = 0; FechaFinal : TDateTime = 0 );
    procedure ReubicarArticulos( Ejercicio : SmallInt; NroHoja: LongInt; AlmacenDestino : String; UbicacionDestino : String; FechaInicial : TDateTime = 0; FechaFinal : TDateTime = 0 );
    function RevisaVinculos( Ejercicio : SmallInt; NroHoja : LongInt ) : Boolean;
    end;

   THojaCargaModule = class(TServerDataModule)
    DmLineaMovimientoTable: TnxeTable;
    DmMovimientoTable: TnxeTable;
    DmLineaHojaCargaTable: TnxeTable;
    DmHojaCargaTable: TnxeTable;
    HojaCargaQuery: TnxeQuery;
    HojaCargaQueryEjercicio: TSmallintField;
    HojaCargaQueryNroHoja: TIntegerField;
    HojaCargaQueryProcesado: TBooleanField;
    HojaCargaQueryCodigoTransportista: TWideStringField;
    HojaCargaQueryCodigoVendedor: TWideStringField;
    HojaCargaQueryGrupoFacturacion: TWideStringField;
    HojaCargaQueryCodigoFormaCobro: TWideStringField;
    HojaCargaQueryNroLinea: TSmallintField;
    HojaCargaQueryEjercicioOrigen: TSmallintField;
    HojaCargaQueryNroOperacionOrigen: TIntegerField;
    HojaCargaQueryNroRegistroOrigen: TIntegerField;
    HojaCargaQueryNroOperacionReubicacion: TIntegerField;
    HojaCargaQueryNroRegistro: TLongWordField;
    HojaCargaQueryCodigoAlmacen: TWideStringField;
    HojaCargaQueryCargado: TBCDField;
    HojaCargaQueryNroOperacionDestino: TIntegerField;
    HojaCargaQueryAnotacion: TWideMemoField;
    HojaCargaQueryFecha: TDateField;
    HojaCargaQueryPropietario: TWideStringField;
    HojaCargaQueryCodigoArticulo: TWideStringField;
    HojaCargaQueryCodigoClaseA: TWideStringField;
    HojaCargaQueryCodigoClaseB: TWideStringField;
    HojaCargaQueryCodigoClaseC: TWideStringField;
    HojaCargaQueryUIDArticulo: TGuidField;
    HojaCargaQueryNumeroSerie: TWideStringField;
    HojaCargaQueryLoteFabricacion: TWideStringField;
    HojaCargaQueryDescripcion: TWideStringField;
    HojaCargaQueryEjercicioDestino: TSmallintField;
    HojaCargaQueryNroRegistroDestino: TIntegerField;
    HojaCargaQueryUbicacion: TWideStringField;
    HojaCargaQueryNroCajas: TBCDField;
    HojaCargaQueryDescuento: TBCDField;
    HojaCargaQueryPrecio: TFloatField;
    SQLSet: TgxSQLSet;
    DmHojaCargaAuxTable: TnxeTable;
    DmLineaHojaCargaOrigenTable: TnxeTable;
    DmLineaMovimientoAuxTable: TnxeTable;
    DmMovimientoAuxTable: TnxeTable;
    DmLineaHojaCargaRegistroOrigenTable: TnxeTable;
    DmLineaHojaCargaRegistroDestinoTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private
    Ejercicio : SmallInt;
    NroHoja : LongInt;
    SerieAlbaran : String;
    FechaInicial,
    FechaFinal : TDateTime;
    AlmacenDestino,
    UbicacionDestino : String;
    EjercicioNroHojaActual : SmallInt;
    NroHojaActual : Integer;
    NroRegistroActual : SmallInt;
    ClienteActual,
    CodigoVendedorActual,
    CodigoGrupoFacturacionActual,
    CodigoFormaCobroActual : String;
    FechaActual : TDateTime;

    procedure DoOnReasignacionNroRegistro( NroRegistroAnterior, NroRegistroActual: LongWord);
    procedure DoBeforeDeleteLineaMovimiento( MovimientoFields : TMovimientoFields; LineaMovimientoFields : TLineaMovimientoFields );


  public
    DmHojaCargaFields,
    DmHojaCargaAuxFields : THojaCargaFields;
    DmLineaHojaCargaOrigenFields,
    DmLineaHojaCargaFields : TLineaHojaCargaFields;
    DmMovimientoFields,
    DmMovimientoActualFields,
    DmMovimientoAuxFields : TMovimientoFields;
    DmLineaMovimientoFields,
    DmLineaMovimientoAuxFields : TLineaMovimientoFields;
    DmLineaHojaCargaRegistroOrigenFields,
    DmLineaHojaCargaRegistroDestinoFields : TLineaHojaCargaFields;
    ClienteFields : TClienteFields;
    SerieFacturacionFields : TSerieFacturacionFields;
    ArticuloFields : TArticuloFields;
    TiposIVAFields : TTiposIVAFields;

    procedure Inicializa;

    function ObtenLineaPorNroRegistroOrigen( NroRegistro : LongInt ) : Boolean;
    function ObtenLineaPorNroRegistroDestino( NroRegistro : LongInt ) : Boolean;
    function ObtenLineaPorNroLinea( Ejercicio : SmallInt; NroHoja : LongInt; NroLinea : SmallInt ) : Boolean;
    function ObtenCantidadCargada( NroRegistro : LongInt ) : Decimal;

    function ProximoNroHoja( Ejercicio : SmallInt = 0 ) : LongInt;
    procedure GenerarAlbaranes( Ejercicio : SmallInt; NroHoja : LongInt; SerieAlbaran : String = ''; FechaInicial : TDateTime = 0; FechaFinal : TDateTime = 0 );
    procedure ReubicarArticulos( Ejercicio : SmallInt; NroHoja: LongInt; AlmacenDestino : String; UbicacionDestino : String; FechaInicial : TDateTime = 0; FechaFinal : TDateTime = 0 );

    function RevisaVinculos( Ejercicio : SmallInt; NroHoja : LongInt ) : Boolean;
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses AppManager,
     SessionData,
     EnterpriseData,

     nxrdClass,
     nxrbTypes,
     nxllTypes,
     nxllBDE,
     nxsdServerEngine,

     Gim00Fields,

     dmi_cnd,
     dmi_mov,
     dmi_sto,

     dm_pde4,
     dm_cnd,
     dm_rdr,
     dm_mov;

{$R *.DFM}

resourceString

  RsMsg1   = 'Generación de albaranes de salida';
  RsMsg2   = 'Hoja de carga nº %d';
  RsMsg3   = 'El proceso ha finalizado satisfactoriamente.';
  RsMsg4   = 'Reubicación de material.';
  RsMsg5   = 'Reubicación del material de la hoja de carga nº %d.';
  RsMsg6   = 'La hoja de carga nº %d ha generado el movimiento de almacén nº %d.';
  RsMsg7   = ' Albarán de venta : %s %d.';
  RsMsg8   = 'El artículo %s ha sido dado de baja';
  RsMsg9   = 'El pedido nº %d ha sido dado de baja';
  RsMsg10  = 'La línea de pedido con el nº de registro %d ha sido dado de baja';
  RsMsg11  = ' y, por lo tanto, no puede generarse la salida correspondiente en el albarán.';
  RsMsg12  = 'No se ha encontrado el movimiento de reubicación asignado a ésta hoja de carga.';
  RsMsg13  = '¿Desea desvincular éste documento de la hoja de carga?';
  RsMsg14  = 'No he podido releer la línea de la hoja de carga original.';
  RsMsg15  = 'No he conseguido localizar la línea del pedido origen.';
  RsMsg16  = 'El pedido nº %d está siendo editado.';
  RsMsg17  = 'Es necesario modificar el pedido origen y, por lo tanto, debe estar libre. Desbloquee el registro y reintente la operación.';
  RsMsg18  = 'No consigo localizar el pedido nº %d.';
  RsMsg19  = 'No se ha localizado el movimiento de reubicación de la línea %d.';
  RsMsg20  = 'Esta línea ha sido incluída en una hoja de carga.';
  RsMsg21  = 'Si desea suprimir la línea localice primero el registro de la hoja de carga nº %d y delo de baja.';

procedure THojaCargaModule.ServerDataModuleCreate(Sender: TObject);

var ReconstruccionResultadosModule : TReconstruccionResultadosModule;

begin

    DmHojaCargaFields := THojaCargaFields.Create( DmHojaCargaTable );
    DmHojaCargaAuxFields := THojaCargaFields.Create( DmHojaCargaAuxTable );
    DmLineaHojaCargaOrigenFields := TLineaHojaCargaFields.Create( DmLineaHojaCargaOrigenTable );
    DmLineaHojaCargaFields := TLineaHojaCargaFields.Create( DmLineaHojaCargaTable );
    DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
    DmMovimientoActualFields := TMovimientoFields.Create( DmMovimientoTable, True );
    DmMovimientoAuxFields := TMovimientoFields.Create( DmMovimientoAuxTable );
    DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
    DmLineaMovimientoAuxFields := TLineaMovimientoFields.Create( DmLineaMovimientoAuxTable );
    DmLineaHojaCargaRegistroOrigenFields := TLineaHojaCargaFields.Create( DmLineaHojaCargaRegistroOrigenTable );
    DmLineaHojaCargaRegistroDestinoFields := TLineaHojaCargaFields.Create( DmLineaHojaCargaRegistroDestinoTable );

    ClienteFields := TClienteFields.Create( Self );
    SerieFacturacionFields := TSerieFacturacionFields.Create( Self );
    ArticuloFields := TArticuloFields.Create( Self );
    TiposIVAFields := TTiposIVAFields.Create( Self );

    SessionDataModule.Dm30.ReconstruccionResultadosModule.OnReasignacionNroRegistro.Add( DoOnReasignacionNroRegistro );
    SessionDataModule.Dm30.MovimientoModule.BeforeDeleteLineaMovimiento.Add( DoBeforeDeleteLineaMovimiento );

end;

procedure THojaCargaModule.ServerDataModuleDestroy(Sender: TObject);
begin
     If   SessionDataModule.Dm30.IsReconstruccionResultadosModuleAssigned
     then SessionDataModule.Dm30.ReconstruccionResultadosModule.OnReasignacionNroRegistro.Remove( DoOnReasignacionNroRegistro );

     SessionDataModule.Dm30.TipoMovAlmacenModule := nil;
end;

procedure THojaCargaModule.DoOnReasignacionNroRegistro( NroRegistroAnterior, NroRegistroActual: LongWord);
begin

     // Este proceso reasigna nuevos números de registro de acuerdo con el reajuste realizado por el proceso de reconstrucción de resultados
     // por lo que ya está incluido en una transacción global

     With DmLineaHojaCargaRegistroOrigenTable do
       try
         SetRange( [ NroRegistroAnterior ] );
         First;
         While not Eof do
           begin
           try
             Edit;
             DmLineaHojaCargaRegistroOrigenFields.NroRegistroOrigen.Value := NroRegistroActual;
             Post;
           except
             Cancel;
             raise;
             end;
           Next;
           end;

       finally
         CancelRange;
         end;

     With DmLineaHojaCargaRegistroDestinoTable do
       try
         SetRange( [ NroRegistroAnterior ] );
         First;
         While not Eof do
           begin
           try
             Edit;
             DmLineaHojaCargaRegistroDestinoFields.NroRegistroDestino.Value := NroRegistroActual;
             Post;
           except
             Cancel;
             raise;
             end;
           Next;
           end;

       finally
         CancelRange;
         end;

end;

procedure THojaCargaModule.DoBeforeDeleteLineaMovimiento( MovimientoFields      : TMovimientoFields;
                                                          LineaMovimientoFields : TLineaMovimientoFields );
begin
     case MovimientoFields.TipoMovimiento.Value of

         tmPedidoVenta :
           If   ObtenLineaPorNroRegistroOrigen( LineaMovimientoFields.NroRegistro.Value )
           then begin
                SessionDataModule.SendNotification( ntStop, RsMsg20, Format( RsMsg21, [ DmLineaHojaCargaFields.NroHoja.Value ] ) );
                Abort;
                end;

         tmVenta :
           If   ObtenLineaPorNroRegistroDestino( LineaMovimientoFields.NroRegistro.Value )
           then begin

                try
                  DmLineaHojaCargaTable.Edit;
                  DmLineaHojaCargaFields.EjercicioDestino.Clear;
                  DmLineaHojaCargaFields.NroOperacionDestino.Clear;
                  DmLineaHojaCargaFields.NroRegistroDestino.Clear;

                  DmLineaHojaCargaTable.Post;
                except
                  DmLineaHojaCargaTable.Cancel;
                  raise;
                  end;

                RevisaVinculos( DmLineaHojaCargaFields.Ejercicio.Value, DmLineaHojaCargaFields.NroHoja.Value );

                end;

         // Repongo la ubicación original de la línea. Aunque esta línea es la que contiene el almacén y ubicación originales,
         // es la línea siguiente la que tiene registrada la línea de hoja de carga origen.

         tmReubicacionCarga :
           If   LineaMovimientoFields.TipoMovimientoOrigen.Value=tmPedidoVenta
           then If   DmLineaMovimientoTable.FindGreater( [ LineaMovimientoFields.Ejercicio.Value,
                                                           LineaMovimientoFields.NroOperacion.Value,
                                                           LineaMovimientoFields.NroPagina.Value,
                                                           LineaMovimientoFields.NroLinea.Value ] )
                then If   DmLineaMovimientoFields.TipoMovimientoOrigen.Value=tmHojaCarga
                     then If   ObtenLineaPorNroLinea( DmLineaMovimientoFields.EjercicioOrigen.Value,
                                                      DmLineaMovimientoFields.NroOperacionOrigen.Value,
                                                      DmLineaMovimientoFields.NroRegistroOrigen.Value )  // En este caso es el número de línea (ver dm_hdc.ReubicarArticulos )
                          then try
                                 DmLineaHojaCargaTable.Edit;
                                 DmLineaHojaCargaFields.CodigoAlmacen.Value := LineaMovimientoFields.CodigoAlmacen.Value;
                                 DmLineaHojaCargaFields.Ubicacion.Value := LineaMovimientoFields.Ubicacion.Value;
                                 DmLineaHojaCargaTable.Post;
                               except
                                 DmLineaHojaCargaTable.Cancel;
                                 raise;
                                 end;

         end;
end;

procedure THojaCargaModule.Inicializa;
begin
     // Tan solo carga el módulo
end;

function THojaCargaModule.ObtenLineaPorNroRegistroOrigen( NroRegistro : LongInt ) : Boolean;
begin
     With DmLineaHojaCargaTable do
       begin
       IndexFieldNames := 'NroRegistroOrigen';
       Result := FindKey( [ NroRegistro ] );
       end;
end;

function THojaCargaModule.ObtenLineaPorNroRegistroDestino( NroRegistro : LongInt ) : Boolean;
begin
     With DmLineaHojaCargaTable do
       begin
       IndexFieldNames := 'NroRegistroDestino';
       Result := FindKey( [ NroRegistro ] );
       end;
end;

function THojaCargaModule.ObtenLineaPorNroLinea( Ejercicio : SmallInt;
                                                 NroHoja   : LongInt;
                                                 NroLinea  : SmallInt ) : Boolean;
begin
     With DmLineaHojaCargaTable do
       begin
       IndexFieldNames := 'Ejercicio;NroHoja;NroLinea';
       Result := FindKey( [ Ejercicio, NroHoja, NroLinea ] );
       end;
end;

function THojaCargaModule.ObtenCantidadCargada( NroRegistro : LongInt ) : Decimal;
begin
     Result  := 0.0;
     With DmLineaHojaCargaOrigenTable do
       try
         SetRange( [ NroRegistro ] );
         First;
         While not Eof do
           begin
           Result := Result + DmLineaHojaCargaOrigenFields.Cargado.Value;
           Next;
           end;
       finally
         CancelRange;
         end;
end;

function THojaCargaModule.RevisaVinculos( Ejercicio : SmallInt;
                                          NroHoja   : LongInt ) : Boolean;

var  ExisteDocumentoDestino : Boolean;

begin

     ExisteDocumentoDestino := False;

     With DmLineaHojaCargaTable do
       try
         IndexFieldNames := 'Ejercicio;NroHoja;NroLinea';
         DmLineaHojaCargaTable.SetRange( [ Ejercicio, NroHoja ] );
         First;
         While not Eof do
           begin
           If   DmLineaHojaCargaFields.NroOperacionDestino.Value<>0
           then If   DmMovimientoTable.FindKey( [ DmLineaHojaCargaFields.EjercicioDestino.Value, DmLineaHojaCargaFields.NroOperacionDestino.Value ] )
                then ExisteDocumentoDestino := True
                else try
                       Edit;
                       DmLineaHojaCargaFields.EjercicioDestino.Clear;
                       DmLineaHojaCargaFields.NroOperacionDestino.Clear;
                       DmLineaHojaCargaFields.NroRegistroDestino.Clear;
                       Post;
                     except
                       Cancel;
                       raise;
                       end;
           Next;
           end;

       finally
         CancelRange;
         end;

     If   not ExisteDocumentoDestino
     then If   DmHojaCargaTable.FindKey( [ DmLineaHojaCargaFields.Ejercicio.Value, DmLineaHojaCargaFields.NroHoja.Value ] )
          then try
                 DmHojaCargaTable.Edit;
                 DmHojaCargaFields.Procesado.Value := False;
                 DmHojaCargaTable.Post;
               except
                 DmHojaCargaTable.Cancel;
                 raise;
                 end;

     Result := ExisteDocumentoDestino;
end;

function THojaCargaModule.ProximoNroHoja( Ejercicio : SmallInt = 0 ) : LongInt;

var  ResetCounter : Boolean;
     ValorActual : LongInt;
     Count : SmallInt;

begin

     ValorActual := 0;
     Count := 0;
     ResetCounter := False;

     If   Ejercicio=0
     then Ejercicio := SessionDataModule.Ejercicio;

     With DmHojaCargaAuxTable do
       begin

       IndexFieldNames := 'Ejercicio;NroHoja';

       repeat

         If   SessionDataModule.Dm00.ContadoresModule.CompruebaContador( cnNroHojaCarga ) or ResetCounter
         then If   FindEqualLast( [ Ejercicio ] )
              then ValorActual := DmHojaCargaAuxFields.NroHoja.Value + 1
              else ValorActual := 1;

         ValorActual := SessionDataModule.Dm00.ContadoresModule.Incrementa( cnNroHojaCarga, SessionDataModule.Ejercicio, '', ValorActual, 1 );
         ResetCounter := FindKey( [ Ejercicio, ValorActual ] );
         
         Inc( Count );

       until not ResetCounter or ( Count=10 );
       end;

     Result := ValorActual;
end;

procedure THojaCargaModule.GenerarAlbaranes( Ejercicio     : SmallInt;
                                             NroHoja       : LongInt;
                                             SerieAlbaran  : String = '';
                                             FechaInicial  : TDateTime = 0;
                                             FechaFinal    : TDateTime = 0 );
var  SQLText,
     SQLSeleccion : String;

procedure ProcesaLineaHojaCarga;

var  Encontrado : Boolean;
     ExistenciasArticulo : IExistenciasArticulo;

begin

     If   ( ClienteActual<>HojaCargaQueryPropietario.Value ) or
          ( FechaActual<>HojaCargaQueryFecha.Value ) or
          ( CodigoVendedorActual<>HojaCargaQueryCodigoVendedor.Value ) or
          ( CodigoGrupoFacturacionActual<>HojaCargaQueryGrupoFacturacion.Value ) or
          ( CodigoFormaCobroActual<>HojaCargaQueryCodigoFormaCobro.Value )
     then begin

          With DmMovimientoFields do
            try

              DmMovimientoTable.Append;

              Ejercicio.Value := SessionDataModule.Ejercicio;
              NroOperacion.Value  := SessionDataModule.Dm30.MovimientoModule.ProximaOperacion;
              TipoMovimiento.Value := tmVenta;
              Fecha.Value := SessionDataModule.FechaHoy; // HojaCargaQueryFecha.Value;
              If   SerieAlbaran=''
              then Serie.Value := SessionDataModule.Dm40.ConfiguracionAprovisionamientoModule.ParametrosAprovisionamientoRec.SerieAlbaranesSalida
              else Serie.Value := SerieAlbaran;
              NroDocumento.Value := SessionDataModule.Dm30.MovimientoModule.ProximoDocumento( DmMovimientoFields );
              DescripcionMovimiento.Value := Format( RsMsg2, [ DmHojaCargaFields.NroHoja.Value ] );
              Propietario.Value := HojaCargaQueryPropietario.Value;

              CodigoTransportista.Value := HojaCargaQueryCodigoTransportista.Value;
              CodigoVendedor.Value := HojaCargaQueryCodigoVendedor.Value;
              GrupoFacturacion.Value := HojaCargaQueryGrupoFacturacion.Value;
              CodigoFormaCobro.Value := HojaCargaQueryCodigoFormaCobro.Value;
              Origen.Value := omHojaCarga;

              DmMovimientoActualFields.Update;

              SessionDataModule.SendNotification( ntInformation, Format( RsMsg6 + RsMsg7, [ HojaCargaQueryNroHoja.Value, NroOperacion.Value, Serie.Value, NroDocumento.Value ] ) );

              SessionDataModule.Dm30.MovimientoModule.CompruebaPrimerNroPagina( DmMovimientoFields );

              SessionDataModule.Dm10.SerieFacturacionModule.Obten( Serie.Value, SerieFacturacionFields );
              SessionDataModule.Dm10.ClienteModule.Obten( Propietario.Value, '', ClienteFields );

              If   DmMovimientoAuxTable.FindKey( [ HojaCargaQueryEjercicioOrigen.Value, HojaCargaQueryNroOperacionOrigen.Value ] )
              then If   DmMovimientoAuxFields.TipoMovimiento.Value=tmPedidoventa // Por si acaso
                   then begin
                        RegistroAuxiliar.Value := DmMovimientoAuxFields.RegistroAuxiliar.Value;
                        For var Index := 1 to 5 do
                          CampoLibre[ Index ].Value := DmMovimientoAuxFields.CampoLibre[ Index ].Value;
                        end;

              DmMovimientoTable.Post;
              NroRegistroActual := 1;

            except
              DmMovimientoTable.Cancel;
              raise;
              end;

          ClienteActual := HojaCargaQueryPropietario.Value;
          FechaActual := HojaCargaQueryFecha.Value;
          CodigoVendedorActual := HojaCargaQueryCodigoVendedor.Value;
          CodigoGrupoFacturacionActual := HojaCargaQueryGrupoFacturacion.Value;
          CodigoFormaCobroActual := HojaCargaQueryCodigoFormaCobro.Value;

          end;

         With DmLineaMovimientoFields do
           begin

           try

             DmLineaMovimientoTable.Append;

             Ejercicio.Value := DmMovimientoActualFields.Ejercicio.Value;
             NroOperacion.Value := DmMovimientoActualFields.NroOperacion.Value;
             NroPagina.Value := 0;
             NroLinea.Value := NroRegistroActual;
             Fecha.Value := DmMovimientoActualFields.Fecha.Value;

             If   HojaCargaQueryNroOperacionReubicacion.Value=0
             then begin
                  TipoMovimientoOrigen.Value := tmPedidoVenta;
                  EjercicioOrigen.Value := HojaCargaQueryEjercicioOrigen.Value;
                  NroOperacionOrigen.Value := HojaCargaQueryNroOperacionOrigen.Value;
                  NroRegistroOrigen.Value := HojaCargaQueryNroRegistroOrigen.Value;
                  end  // TipoMovimientoOrigen;EjercicioOrigen;NroOperacionOrigen
             else With DmLineaMovimientoAuxTable do
                    try

                      // Solo hay disponible un índice y no incluye el NroRegistroOrigen, aunque en este caso se hace un uso especial del mismo
                      // como número de línea de la hoja de carga. Por lo tanto, hay que buscarlo.

                      Encontrado := False;
                      SetRange( [ tmHojaCarga, HojaCargaQueryEjercicio.Value, HojaCargaQueryNroHoja.Value ] );
                      First;
                      While not Eof and not Encontrado do
                        begin
                        If   DmLineaMovimientoAuxFields.NroRegistroOrigen.Value=HojaCargaQueryNroLinea.Value
                        then Encontrado := True
                        else Next;
                        end;

                      If   Encontrado
                      then begin
                           TipoMovimientoOrigen.Value := tmReubicacionCarga;
                           EjercicioOrigen.Value := DmLineaMovimientoAuxFields.Ejercicio.Value;
                           NroOperacionOrigen.Value := DmLineaMovimientoAuxFields.NroOperacion.Value;
                           NroRegistroOrigen.Value := DmLineaMovimientoAuxFields.NroRegistro.Value;
                           end
                      else begin
                           SessionDataModule.SendNotification( ntStop, Format( RsMsg19, [ HojaCargaQueryNroLinea.Value ] ) );
                           Abort;
                           end;

                    finally
                      CancelRange;
                      end;

             CodigoArticulo.Value := HojaCargaQueryCodigoArticulo.Value;

             SessionDataModule.Dm30.ArticuloModule.Obten( CodigoArticulo.Value, ArticuloFields );

             UIDArticulo.Value := HojaCargaQueryUIDArticulo.Value;

             CodigoClaseA.Value := HojaCargaQueryCodigoClaseA.Value;
             CodigoClaseB.Value := HojaCargaQueryCodigoClaseB.Value;
             CodigoClaseC.Value := HojaCargaQueryCodigoClaseC.Value;
             LoteFabricacion.Value := HojaCargaQueryLoteFabricacion.Value;
             Descripcion.Value := HojaCargaQueryDescripcion.Value;
             CodigoAlmacen.Value := HojaCargaQueryCodigoAlmacen.Value;
             Ubicacion.Value := HojaCargaQueryUbicacion.Value;
             Cantidad.Value := -HojaCargaQueryCargado.Value;
             CantidadAjustada.Value := HojaCargaQueryCargado.Value;

             If   SessionDataModule.EmpresaFields.Articulo_Cajas.Value and
                  ( ArticuloFields.UnidadesPorCaja.Value<>0.0 ) and
                  ( HojaCargaQueryNroCajas.Value=0 )
             then NroCajas.Value := Redondea( HojaCargaQueryCargado.Value / ArticuloFields.UnidadesPorCaja.Value, SessionDataModule.EmpresaFields.Ventas_DecCajas.Value )
             else NroCajas.Value := HojaCargaQueryNroCajas.Value;

             case SessionDataModule.Dm40.ConfiguracionAprovisionamientoModule.ParametrosAprovisionamientoRec.MetodoCalculoMargen of
               0 : Precio.Value := HojaCargaQueryPrecio.Value;
               1 : With SessionDataModule.Dm30.StockAlmacenModule do
                     begin
                     ExistenciasArticulo := ObtenStock( CodigoArticulo.Value, False, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, False, LoteFabricacion.Value, False, CodigoAlmacen.Value, True, '', True, SessionDataModule.Ejercicio, 0, 12 );
                     Precio.Value := ExistenciasArticulo.Coste + ( ( ExistenciasArticulo.Coste * SessionDataModule.Dm40.ConfiguracionAprovisionamientoModule.ParametrosAprovisionamientoRec.MargenPorcentualVenta ) / 100.0 );
                     end;
               2 : Precio.Value := ArticuloFields.Precio_Venta.Value;
               end;

             Descuento.Value := HojaCargaQueryDescuento.Value;

             If   TipoMovimientoOrigen.Value=tmPedidoVenta
             then SessionDataModule.Dm30.MovimientoModule.RegularizaLineaPedido( DmMovimientoActualFields, DmLineaMovimientoFields, False );

             SessionDataModule.Dm30.FacturaVentasModule.CalculaImportesIVA( DmLineaMovimientoFields, ClienteFields, ArticuloFields, SerieFacturacionFields, TiposIVAFields, DmMovimientoActualFields.IVAIncluido.Value );

             SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoActualFields, DmLineaMovimientoFields, False );

             DmLineaMovimientoTable.Post;

           except
             DmLineaMovimientoTable.Cancel;
             raise;
             end;

           // Hay que volver a leer la linea del movimiento para obtener el valor de NroRegistro

           DmLineaHojaCargaTable.IndexFieldNames := 'Ejercicio;NroHoja;NroLinea';
           If   DmLineaMovimientoTable.FindKey( [ Ejercicio.Value, NroOperacion.Value, NroPagina.Value, NroLinea.Value ] ) and
                DmLineaHojaCargaTable.FindKey( [ HojaCargaQueryEjercicio.Value, HojaCargaQueryNroHoja.Value, HojaCargaQueryNroLinea.Value ] )
           then With DmLineaHojaCargaTable do
                  try
                    Edit;
                    DmLineaHojaCargaFields.EjercicioDestino.Value := DmMovimientoActualFields.Ejercicio.Value;
                    DmLineaHojaCargaFields.NroOperacionDestino.Value := DmMovimientoActualFields.NroOperacion.Value;
                    DmLineaHojaCargaFields.NroRegistroDestino.Value := NroRegistro.Value;
                    Post;
                  except
                    Cancel;
                    raise;
                    end;


           Inc( NroRegistroActual );
           end;
end;

procedure AlbaranesDeSalida;

procedure MarcaHojaCarga( Ejercicio : SmallInt;
                          NroHoja   : Integer );
begin
     If   DmHojaCargaTable.FindKey( [ Ejercicio, NroHoja ] )
     then With DmHojaCargaTable do
            try
              Edit;
              DmHojaCargaFields.Procesado.Value := True;
              Post;
            except
              Cancel;
              raise;
              end;
end;

begin

     EjercicioNroHojaActual := 0;
     NroHojaActual := 0;
     NroRegistroActual := 1;
     ClienteActual := '';
     FechaActual := 0;

     DmLineaHojaCargaTable.IndexFieldNames := 'Ejercicio;NroHoja;NroLinea';

     With HojaCargaQuery do
       try

         If   NroHoja=0
         then SQLSeleccion := SQLVarsFormat( ' HojaCarga.Fecha BETWEEN ? AND ? ', [ FechaInicial, FechaFinal ] )
         else SQLSeleccion := SQLVarsFormat( ' HojaCarga.Ejercicio=? AND HojaCarga.NroHoja=?' , [ Ejercicio, NroHoja ] );

         SQLText := SQLSet.GetSQLText;
         SetSQLVar( SQLText, 'Seleccion', SQLSeleccion );
         SQL.Text := SQLText;

         Open;
         First;
         While not Eof do
           begin

           SessionDataModule.SendNotification( ntRecord, Format( RsMsg2, [ HojaCargaQueryNroHoja.Value ] ) );

           If   ( HojaCargaQueryEjercicio.Value<>EjercicioNroHojaActual ) or ( HojaCargaQueryNroHoja.Value<>NroHojaActual )
           then begin
                EjercicioNroHojaActual := HojaCargaQueryEjercicio.Value;
                NroHojaActual := HojaCargaQueryNroHoja.Value;
                MarcaHojaCarga( EjercicioNroHojaActual, NroHojaActual );
                end;

           If   HojaCargaQueryNroRegistroDestino.Value=0
           then ProcesaLineaHojaCarga;

           Next;
           end;

       finally
         Close;
         end;

end;

begin
     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmHojaCargaTable, DmLineaHojaCargaTable, DmMovimientoTable, DmLineaMovimientoTable ] );
     try
       AlbaranesDeSalida;
       TransactionTag.Commit;
       SessionDataModule.SendNotification( ntInformation, RsMsg3 );
     except on e : exception do
       begin
       TransactionTag.Rollback;
       SessionDataModule.SendNotification( ntError, ExceptionMessage( E ) );
       SessionDataModule.SendNotification( ntError, RsProcesoInterrumpido );
       end;
     end;
end;

// Reubicación del material de la hoja de carga ---------------------------------

procedure THojaCargaModule.ReubicarArticulos( Ejercicio        : SmallInt;
                                              NroHoja          : LongInt;
                                              AlmacenDestino   : String;
                                              UbicacionDestino : String;
                                              FechaInicial     : TDateTime = 0;
                                              FechaFinal       : TDateTime = 0 );
var  SQLText,
     SQLSeleccion : String;
     LineaMovimientoFieldValuesArray : TFieldValuesArray;

procedure ProcesaLineaHojaCarga;

var  CantidadReubicada : Decimal;
     ExistenciasArticulo : IExistenciasArticulo;

begin

    If   ( HojaCargaQueryEjercicio.Value<>EjercicioNroHojaActual ) or
         ( HojaCargaQueryNroHoja.Value<>NroHojaActual )
    then begin

         // Compruebo que el pedido origen esté libre porque necesito editarlo

         With DmMovimientoTable do
           If   FindKey( [ HojaCargaQueryEjercicioOrigen.Value, HojaCargaQueryNroOperacionOrigen.Value ] )
           then try
                  Edit;
                  Cancel;
                except on E : EDatabaseError do begin
                  SessionDataModule.SendNotification( ntStop, Format( RsMsg16, [ DmMovimientoFields.NroDocumento.Value ] ), RsMsg17 );
                  Abort;
                  end
                else raise;
                end
           else begin
                SessionDataModule.SendNotification( ntStop, Format( RsMsg18, [ DmMovimientoFields.NroDocumento.Value ] ) );
                Abort;
                end;

         With DmMovimientoFields do
           try

             DmMovimientoTable.Append;

             Ejercicio.Value := SessionDataModule.Ejercicio;
             NroOperacion.Value  := SessionDataModule.Dm30.MovimientoModule.ProximaOperacion;
             TipoMovimiento.Value := tmReubicacionCarga;
             Fecha.Value := SessionDataModule.FechaHoy; // HojaCargaQueryFecha.Value;
             If   SerieAlbaran=''
             then Serie.Value := SessionDataModule.Dm40.ConfiguracionAprovisionamientoModule.ParametrosAprovisionamientoRec.SerieAlbaranesSalida
             else Serie.Value := SerieAlbaran;
             NroDocumento.Value := SessionDataModule.Dm30.MovimientoModule.ProximoDocumento( DmMovimientoFields );
             DescripcionMovimiento.Value := Format( RsMsg2, [ HojaCargaQueryNroHoja.Value ] );
             Propietario.Value := HojaCargaQueryPropietario.Value;

             DmMovimientoActualFields.Update;

             SessionDataModule.SendNotification( ntInformation, Format( RsMsg6, [ HojaCargaQueryNroHoja.Value, NroOperacion.Value ] ) );

             SessionDataModule.Dm30.MovimientoModule.CompruebaPrimerNroPagina( DmMovimientoFields );

             If   DmHojaCargaTable.FindKey( [ HojaCargaQueryEjercicio.Value, HojaCargaQueryNroHoja.Value ] )
             then With DmHojaCargaTable do
                    try
                      Edit;
                      DmHojaCargaFields.EjercicioReubicacion.Value := Ejercicio.Value;
                      DmHojaCargaFields.NroOperacionReubicacion.Value := NroOperacion.Value;
                      Post;
                    except
                      Cancel;
                      raise;
                      end;

             SessionDataModule.Dm10.SerieFacturacionModule.Obten( Serie.Value, SerieFacturacionFields );
             SessionDataModule.Dm10.ClienteModule.Obten( Propietario.Value, '', ClienteFields );

             DmMovimientoTable.Post;
             NroRegistroActual := 1;

           except
             DmMovimientoTable.Cancel;
             raise;
             end;

         EjercicioNroHojaActual := HojaCargaQueryEjercicio.Value;
         NroHojaActual := HojaCargaQueryNroHoja.Value;
         end;

    With DmLineaMovimientoFields do
      begin

      try

        DmLineaMovimientoTable.Append;

        Ejercicio.Value := DmMovimientoActualFields.Ejercicio.Value;
        NroOperacion.Value := DmMovimientoActualFields.NroOperacion.Value;
        NroPagina.Value := 0;
        NroLinea.Value := NroRegistroActual;
        Fecha.Value := DmMovimientoActualFields.Fecha.Value;

        { El movimiento de salida desde la ubicación original se comporta como un albaran de salida de material
          a efectos de las cantidades pendientes de servir }

        TipoMovimientoOrigen.Value := tmPedidoVenta;
        EjercicioOrigen.Value := HojaCargaQueryEjercicioOrigen.Value;   // Se refiere al pedido que se utilizó para crear la carga
        NroOperacionOrigen.Value := HojaCargaQueryNroOperacionOrigen.Value;
        NroRegistroOrigen.Value := HojaCargaQueryNroRegistroOrigen.Value;

        CodigoArticulo.Value := HojaCargaQueryCodigoArticulo.Value;

        SessionDataModule.Dm30.ArticuloModule.Obten( CodigoArticulo.Value, ArticuloFields );

        UIDArticulo.Value := HojaCargaQueryUIDArticulo.Value;

        CodigoClaseA.Value := HojaCargaQueryCodigoClaseA.Value;
        CodigoClaseB.Value := HojaCargaQueryCodigoClaseB.Value;
        CodigoClaseC.Value := HojaCargaQueryCodigoClaseC.Value;
        LoteFabricacion.Value := HojaCargaQueryLoteFabricacion.Value;
        Descripcion.Value := HojaCargaQueryDescripcion.Value;
        CodigoAlmacen.Value := HojaCargaQueryCodigoAlmacen.Value;
        Ubicacion.Value := HojaCargaQueryUbicacion.Value;
        Cantidad.Value := -HojaCargaQueryCargado.Value;
        CantidadAjustada.Value := HojaCargaQueryCargado.Value;

        If   SessionDataModule.EmpresaFields.Articulo_Cajas.Value and ( ArticuloFields.UnidadesPorCaja.Value<>0.0 ) and ( HojaCargaQueryNroCajas.Value=0 )
        then NroCajas.Value := Redondea( Cantidad.Value / ArticuloFields.UnidadesPorCaja.Value, SessionDataModule.EmpresaFields.Ventas_DecCajas.Value )
        else NroCajas.Value := HojaCargaQueryNroCajas.Value;

        case SessionDataModule.Dm40.ConfiguracionAprovisionamientoModule.ParametrosAprovisionamientoRec.MetodoCalculoMargen of
          0 : Precio.Value := HojaCargaQueryPrecio.Value;
          1 : With SessionDataModule.Dm30.StockAlmacenModule do
                begin
                ExistenciasArticulo := ObtenStock( CodigoArticulo.Value, False, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, False, LoteFabricacion.Value, False, CodigoAlmacen.Value, True, '', True, SessionDataModule.Ejercicio, 0, 12 );
                Precio.Value := ExistenciasArticulo.Coste + ( ( ExistenciasArticulo.Coste * SessionDataModule.Dm40.ConfiguracionAprovisionamientoModule.ParametrosAprovisionamientoRec.MargenPorcentualVenta ) / 100.0 );
                end;
          2 : Precio.Value := ArticuloFields.Precio_Venta.Value;
          end;

        Descuento.Value := HojaCargaQueryDescuento.Value;

        SessionDataModule.Dm30.FacturaVentasModule.CalculaImportesIVA( DmLineaMovimientoFields, ClienteFields, ArticuloFields, SerieFacturacionFields, TiposIVAFields, DmMovimientoActualFields.IVAIncluido.Value );

        SessionDataModule.Dm30.MovimientoModule.RegularizaLineaPedido( DmMovimientoFields, DmLineaMovimientoFields, False );
        SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoActualFields, DmLineaMovimientoFields, False );

        LineaMovimientoFieldValuesArray := DmLineaMovimientoTable.GetFieldValues;

        DmLineaMovimientoTable.Post;

      except
        DmLineaMovimientoTable.Cancel;
        raise;
        end;

      Inc( NroRegistroActual );

      // Ahora la entrada en la nueva ubicación

      try

        DmLineaMovimientoTable.Append;

        DmLineaMovimientoTable.SetFieldValues( LineaMovimientoFieldValuesArray );

        NroLinea.Value := NroRegistroActual;
        CodigoAlmacen.Value := AlmacenDestino;
        Ubicacion.Value := UbicacionDestino;
        Cantidad.Value := -Cantidad.Value;

        { Necesito identificar el origen para reajustar la hoja de carga cuando el usuario borra este movimiento,
          a pesar de que las hojas de carga no son movimientos de almacén }

        TipoMovimientoOrigen.Value := tmHojaCarga;
        EjercicioOrigen.Value := HojaCargaQueryEjercicio.Value;
        NroOperacionOrigen.Value := HojaCargaQueryNroHoja.Value;
        NroRegistroOrigen.Value := HojaCargaQueryNroLinea.Value;

        CantidadReubicada := Cantidad.Value;

        SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoActualFields, DmLineaMovimientoFields, False );

        DmLineaMovimientoTable.Post;

      except
        DmLineaMovimientoTable.Cancel;
        raise;
        end;

      // Cambio la ubicación original de la hoja de carga para que al generar los albaranes de salida se haga desde la nueva ubicación

      Inc( NroRegistroActual );

      With DmLineaHojaCargaTable do
        begin
        IndexFieldNames := 'Ejercicio;NroHoja;NroLinea';
        If   FindKey( [ HojaCargaQueryEjercicio.Value, HojaCargaQueryNroHoja.Value, HojaCargaQueryNroLinea.Value ] )
        then try
               Edit;
               DmLineaHojaCargaFields.CodigoAlmacen.Value := AlmacenDestino;
               DmLineaHojaCargaFields.Ubicacion.Value := UbicacionDestino;
               Post;
             except
               Cancel;
               raise;
               end
        else begin
             SessionDataModule.SendNotification( ntStop, RsMsg14 );
             Abort;
             end;
        end;

      end;
end;

procedure Reubicacion;
begin

     EjercicioNroHojaActual := 0;
     NroHojaActual := 0;
     NroRegistroActual := 1;
     ClienteActual := '';
     FechaActual := 0;

     DmLineaHojaCargaTable.IndexFieldNames := 'Ejercicio;NroHoja;NroLinea';

     With HojaCargaQuery do
       try

         If   NroHoja=0
         then SQLSeleccion := SQLVarsFormat( ' HojaCarga.Fecha BETWEEN ? AND ? ', [ FechaInicial, FechaFinal ] )
         else SQLSeleccion := SQLVarsFormat( ' HojaCarga.Ejercicio=? AND HojaCarga.NroHoja=?' , [ Ejercicio, NroHoja ] );

         SQLText := SQLSet.GetSQLText;

         SetSQLVar( SQLText, 'Seleccion', SQLSeleccion );

         SQL.Text := SQLText;

         Open;
         First;
         While not Eof do
           begin

           SessionDataModule.SendNotification( ntRecord, Format( RsMsg2, [ HojaCargaQueryNroHoja.Value ] ) );

           FechaActual := HojaCargaQueryFecha.Value;

           If   HojaCargaQueryNroOperacionReubicacion.Value=0
           then ProcesaLineaHojaCarga;

           Next;
           end;

       finally
         Close;
         end;

end;

begin
     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmHojaCargaTable,
                                                                     DmLineaHojaCargaTable,
                                                                     DmMovimientoTable,
                                                                     DmLineaMovimientoTable ] );
     try
       Reubicacion;
       TransactionTag.Commit;
       SessionDataModule.SendNotification( ntInformation, RsMsg3 );
     except on e : exception do
       begin
       TransactionTag.RollBack;
       If   not ( E is EAbort )
       then SessionDataModule.SendNotification( ntError, ExceptionMessage( E ) );
       SessionDataModule.SendNotification( ntError, RsProcesoInterrumpido );
       end;
     end;
end;

{ THojaCargaService }

procedure THojaCargaService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure THojaCargaService.Inicializa;
begin
     SessionDataModule.Dm40.HojaCargaModule.Inicializa;
end;

function THojaCargaService.ObtenCantidadCargada( NroRegistro : Integer ) : Decimal;
begin
     Result := SessionDataModule.Dm40.HojaCargaModule.ObtenCantidadCargada( NroRegistro );
end;

procedure THojaCargaService.GenerarAlbaranes( Ejercicio     : SmallInt;
                                              NroHoja       : Integer;
                                              SerieAlbaran  : String;
                                              FechaInicial,
                                              FechaFinal    : TDateTime );
begin
     SessionDataModule.Dm40.HojaCargaModule.GenerarAlbaranes( Ejercicio, NroHoja, SerieAlbaran, FechaInicial, FechaFinal  );
end;

function THojaCargaService.ProximoNroHoja( Ejercicio : SmallInt ) : LongInt;
begin
     Result := SessionDataModule.Dm40.HojaCargaModule.ProximoNroHoja( Ejercicio );
end;

procedure THojaCargaService.ReubicarArticulos( Ejercicio        : SmallInt;
                                               NroHoja          : Integer;
                                               AlmacenDestino,
                                               UbicacionDestino : String;
                                               FechaInicial,
                                               FechaFinal       : TDateTime );
begin
     SessionDataModule.Dm40.HojaCargaModule.ReubicarArticulos( Ejercicio, NroHoja, AlmacenDestino, UbicacionDestino, FechaInicial, FechaFinal );
end;

function THojaCargaService.RevisaVinculos( Ejercicio : SmallInt; NroHoja : LongInt ) : Boolean;
begin
     Result := SessionDataModule.Dm40.HojaCargaModule.RevisaVinculos( Ejercicio, NroHoja );
end;

var HojaCargaControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_HojaCargaService, THojaCargaService, HojaCargaControl );

end.

