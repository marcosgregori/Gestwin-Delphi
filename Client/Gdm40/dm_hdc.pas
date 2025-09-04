unit dm_hdc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,

  LibUtils,
  AppContainer,
  AppForms,

  Datamanager,
  DB,
  nxdb,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,
  Gim40Fields,

  Gdm40Dm,

  dmi_hdc;

type
  THojaCargaModule = class(TDataModule)
    DmMovimientoTable: TnxeTable;
    DmLineaHojaCargaTable: TnxeTable;
    procedure HojaCargaModuleDestroy(Sender: TObject);
    procedure HojaCargaModuleCreate(Sender: TObject);

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
    CodigoVendedorActual,
    CodigoGrupoFacturacionActual,
    CodigoFormaCobroActual : String;
    FechaActual : TDateTime;

    HojaCargaService : IHojaCargaService;

  public

    DmLineaHojaCargaFields : TLineaHojaCargaFields;

    ArticuloFields : TArticuloFields;

    function ObtenCantidadCargada( NroRegistro : LongInt ) : Decimal;
    function ObtenLineaPorNroRegistroOrigen( NroRegistro : LongInt ) : Boolean;
    function ObtenLineaPorNroRegistroDestino( NroRegistro: Integer): Boolean;
    function ObtenLineaPorNroLinea(Ejercicio: SmallInt; NroHoja: Integer; NroLinea: SmallInt): Boolean;

    function ProximoNroHoja( Ejercicio : SmallInt = 0 ) : LongInt;
    function InsertaLinea( HojaCargaFields : THojaCargaFields; LineaMovimientoOrigenFields: TLineaMovimientoFields; var NumeroLinea : SmallInt ) : Decimal;
    procedure GenerarAlbaranes( Ejercicio : SmallInt; NroHoja : LongInt; SerieAlbaran : String = ''; FechaInicial : TDateTime = 0; FechaFinal : TDateTime = 0 );
    procedure ReubicarArticulos( Ejercicio : SmallInt; NroHoja: LongInt; AlmacenDestino : String; UbicacionDestino : String; FechaInicial : TDateTime = 0; FechaFinal : TDateTime = 0 );

    procedure CompruebaMovimientoReubicacion( HojaCargaFields: THojaCargaFields );
    function RevisaVinculos( LineaHojaCargaFields : TLineaHojaCargaFields ) : Boolean;

  end;

var HojaCargaModule : THojaCargaModule = nil;

function  HojaCarga : THojaCargaModule;

implementation

uses EnterpriseDataAccess,
     AppManager,
     NexusRpcData,

     Gdm00Dm,

     HojaCargaIntf,
     LineaHojaCargaIntf,

     a_pde4,
     a_hdc,

     dmi_mov,

     dm_sdf,
     dm_art,
     dm_cli,
     dm_mov,
     dm_sto,
     dm_pga,
     dm_tma,
     dm_cnd,
     dm_fdv,

     b_pro,
     b_msg,

     f_prg;

{$R *.DFM}

resourceString

  // RsMsg1   = 'Generación de albaranes de salida';
  RsMsg2   = 'Hoja de carga nº %d';
  RsMsg3   = 'El proceso ha finalizado satisfactoriamente.';
  // RsMsg4   = 'Reubicación de material.';
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

function HojaCarga : THojaCargaModule;
begin
     CreateDataModule( THojaCargaModule, HojaCargaModule );
     Result := HojaCargaModule;
end;

procedure THojaCargaModule.HojaCargaModuleDestroy(Sender: TObject);
begin
     HojaCargaModule := nil;
end;

procedure THojaCargaModule.HojaCargaModuleCreate(Sender: TObject);
begin

     NexusRpc.CreateRemoteInstance( CLSID_HojaCargaService, IHojaCargaService, HojaCargaService );

     DmLineaHojaCargaFields := TLineaHojaCargaFields.Create( DmLineaHojaCargaTable );

     ArticuloFields := TArticuloFields.Create( Self );

     HojaCargaService.Inicializa; // Inicializando el módulo en el servidor
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
     Result := HojaCargaService.ObtenCantidadCargada( NroRegistro );
end;

function THojaCargaModule.RevisaVinculos( LineaHojaCargaFields : TLineaHojaCargaFields ) : Boolean;
begin
     With LineaHojaCargaFields do
       Result := HojaCargaService.RevisaVinculos( Ejercicio.Value, NroHoja.Value );
end;

function THojaCargaModule.ProximoNroHoja( Ejercicio : SmallInt = 0 ) : LongInt;
begin
     Result := HojaCargaService.ProximoNroHoja( Ejercicio );
end;

function THojaCargaModule.InsertaLinea(     HojaCargaFields             : THojaCargaFields;
                                            LineaMovimientoOrigenFields : TLineaMovimientoFields;
                                        var NumeroLinea                 : SmallInt ) : Decimal;

var   NroOperacion,
      UltimoNroLinea,
      EjercicioDocumentoOrigen,
      CantidadCargada,
      CantidadACargar : Decimal;
      PedidoEnOrigen : Boolean;

begin
     With DmLineaHojaCargaFields do
       begin
       Result := 0.0;
       PedidoEnOrigen := ParametrosAprovisionamientoRec.DocumentoHojaCarga=0;
       CantidadCargada := ObtenCantidadCargada( LineaMovimientoOrigenFields.NroRegistro.Value );
       If   PedidoEnOrigen
       then CantidadACargar := LineaMovimientoOrigenFields.Cantidad.Value - LineaMovimientoOrigenFields.CantidadProcesada.Value - CantidadCargada
       else CantidadACargar := ( -LineaMovimientoOrigenFields.Cantidad.Value ) - CantidadCargada;
       If   CantidadACargar>0.0
       then begin

            Articulo.Obten( LineaMovimientoOrigenFields.CodigoArticulo.Value, ArticuloFields );

            DmLineaHojaCargaTable.Append;

            Ejercicio.Value := HojaCargaFields.Ejercicio.Value;
            NroHoja.Value := HojaCargaFields.NroHoja.Value;
            NroLinea.Value := NumeroLinea;

            EjercicioOrigen.Value := LineaMovimientoOrigenFields.Ejercicio.Value;
            NroOperacionOrigen.Value := LineaMovimientoOrigenFields.NroOperacion.Value;
            NroRegistroOrigen.Value := LineaMovimientoOrigenFields.NroRegistro.Value;

            CodigoAlmacen.Value := LineaMovimientoOrigenFields.CodigoAlmacen.Value;
            Ubicacion.Value := LineaMovimientoOrigenFields.Ubicacion.Value;

            If   DataModule00.DmEmpresaFields.Articulo_Cajas.Value and ( ArticuloFields.UnidadesPorCaja.Value<>0.0 )
            then NroCajas.Value := Redondea( CantidadACargar / ArticuloFields.UnidadesPorCaja.Value, DataModule00.DmEmpresaFields.Ventas_DecCajas.Value );

            Cargado.Value := CantidadACargar;

            DmLineaHojaCargaTable.Post;

            Inc( NumeroLinea );

            Result := CantidadACargar;
            end;
       end;

end;

procedure THojaCargaModule.GenerarAlbaranes( Ejercicio     : SmallInt;
                                             NroHoja       : LongInt;
                                             SerieAlbaran  : String = '';
                                             FechaInicial  : TDateTime = 0;
                                             FechaFinal    : TDateTime = 0 );
begin
     HojaCargaService.GenerarAlbaranes( Ejercicio, NroHoja, SerieAlbaran, FechaInicial, FechaFinal );
end;

// Reubicación del material de la hoja de carga ---------------------------------

procedure THojaCargaModule.ReubicarArticulos( Ejercicio        : SmallInt;
                                              NroHoja          : LongInt;
                                              AlmacenDestino   : String;
                                              UbicacionDestino : String;
                                              FechaInicial     : TDateTime = 0;
                                              FechaFinal       : TDateTime = 0 );
begin
     HojaCargaService.ReubicarArticulos( Ejercicio, NroHoja, AlmacenDestino, UbicacionDestino, FechaInicial, FechaFinal );
end;

// Se supone que la hoja de carga está en modo edición

procedure THojaCargaModule.CompruebaMovimientoReubicacion( HojaCargaFields : THojaCargaFields );
begin
     With HojaCargaFields do
       If   NroOperacionReubicacion.Value<>0
       then begin
            DmMovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion';
            If   not DmMovimientoTable.FindKey( [  EjercicioReubicacion.Value, NroOperacionReubicacion.Value ] )
            then If   ShowNotification( ntQuestionWarning, RsMsg12, RsMsg13 )=mrYes
                 then begin
                      EjercicioReubicacion.Clear;
                      NroOperacionReubicacion.Clear;
                      end;
            end;
end;


end.
