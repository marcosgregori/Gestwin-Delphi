{$ALIGN OFF}
{$OPTIMIZATION OFF}

unit LineaMovimientoIntf;

{ Este fichero ha sido generado automáticamente desde la utilidad de creación de interfaces
  de Gestwin (Gestión de tareas->Procesos->Exportacion a ficheros). }

interface

uses  SysUtils,
      Classes,

      LibUtils,
      DataManager,

      nxllComponent,
      nxllTypes,
      nxivTypes,
      nxrdClass,
      nxrbTypes,
      nxsdTypes,
      nxrbVariantFiler,

      DB,
      SessionIntf,

      Gim30Fields;

const
  CLSID_LineaMovimiento : TnxGuid = '{A0BCCB0D-9480-478F-9F40-C664A4EABB17}';

type

  ILineaMovimiento = interface( IInvokableRecord )
    [ '{5455E498-C166-4F6E-9622-4E44BD0B7890}' ] 

    procedure ToDataset( LineaMovimientoFields : TLineaMovimientoFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
    function GetRemoteCursorID : TnxCursorID;
    procedure SetRemoteCursorID( const Value : TnxCursorID );
    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );

    // Los campos que forman parte de un índice es conveniente que no sean Variants.
    // El resto, sin embargo, pueden ser valores nulos, o el campo no estar definido en el dataset.

    function GetEjercicio : SmallInt;
    function GetNroOperacion : Integer;
    function GetNroPagina : SmallInt;
    function GetNroLinea : SmallInt;
    function GetFecha : Variant;
    function GetFechaAplicacion : Variant;
    function GetFechaCaducidad : Variant;
    function GetNroRegistro : Variant;
    function GetAsignacionOrigen : Variant;
    function GetTipoMovimientoOrigen : Variant;
    function GetEjercicioOrigen : Variant;
    function GetNroOperacionOrigen : Variant;
    function GetNroRegistroOrigen : Variant;
    function GetUIDArticulo : Variant;
    function GetCodigoArticulo : Variant;
    function GetCodigoClaseA : Variant;
    function GetCodigoClaseB : Variant;
    function GetCodigoClaseC : Variant;
    function GetLoteFabricacion : Variant;
    function GetNumeroSerie : Variant;
    function GetCampoLibre1 : Variant;
    function GetCampoLibre2 : Variant;
    function GetCampoLibre3 : Variant;
    function GetCampoLibre4 : Variant;
    function GetCampoLibre5 : Variant;
    function GetDescripcion : Variant;
    function GetCodigoAlmacen : Variant;
    function GetUbicacion : Variant;
    function GetCantidad : Variant;
    function GetCantidadAjustada : Variant;
    function GetCantidadProcesada : Variant;
    function GetProcesada : Variant;
    function GetPrecioDivisa : Variant;
    function GetPrecio : Variant;
    function GetRecargo : Variant;
    function GetPuntoVerde : Variant;
    function GetContribucionRAP : Variant;
    function GetDescuento : Variant;
    function GetNroCajas : Variant;
    function GetLargo : Variant;
    function GetAncho : Variant;
    function GetAlto : Variant;
    function GetBultos : Variant;
    function GetImporteRecargo : Variant;
    function GetPorcentajeRecargo : Variant;
    function GetNoCalcularMargen : Variant;
    function GetTipoLinea : Variant;
    function GetOferta : Variant;
    function GetPesoEnvase : Variant;
    function GetTara : Variant;
    function GetPeso : Variant;
    function GetImporteBruto : Variant;
    function GetImporteDescuento : Variant;
    function GetImporteNeto : Variant;
    function GetCodigoTipoIVA : Variant;
    function GetCuotaIVA : Variant;
    function GetCuotaRE : Variant;
    function GetPrecioIVA : Variant;
    function GetImporteTotal : Variant;
    function GetParametros : Variant;
    function GetAnotacion : Variant;

    procedure SetEjercicio( const Value  : SmallInt );
    procedure SetNroOperacion( const Value  : Integer );
    procedure SetNroPagina( const Value  : SmallInt );
    procedure SetNroLinea( const Value  : SmallInt );
    procedure SetFecha( const Value  : Variant );
    procedure SetFechaAplicacion( const Value  : Variant );
    procedure SetFechaCaducidad( const Value  : Variant );
    procedure SetNroRegistro( const Value  : Variant );
    procedure SetAsignacionOrigen( const Value  : Variant );
    procedure SetTipoMovimientoOrigen( const Value  : Variant );
    procedure SetEjercicioOrigen( const Value  : Variant );
    procedure SetNroOperacionOrigen( const Value  : Variant );
    procedure SetNroRegistroOrigen( const Value  : Variant );
    procedure SetUIDArticulo( const Value  : Variant );
    procedure SetCodigoArticulo( const Value  : Variant );
    procedure SetCodigoClaseA( const Value  : Variant );
    procedure SetCodigoClaseB( const Value  : Variant );
    procedure SetCodigoClaseC( const Value  : Variant );
    procedure SetLoteFabricacion( const Value  : Variant );
    procedure SetNumeroSerie( const Value  : Variant );
    procedure SetCampoLibre1( const Value  : Variant );
    procedure SetCampoLibre2( const Value  : Variant );
    procedure SetCampoLibre3( const Value  : Variant );
    procedure SetCampoLibre4( const Value  : Variant );
    procedure SetCampoLibre5( const Value  : Variant );
    procedure SetDescripcion( const Value  : Variant );
    procedure SetCodigoAlmacen( const Value : Variant );
    procedure SetUbicacion( const Value : Variant );
    procedure SetCantidad( const Value : Variant );
    procedure SetCantidadAjustada( const Value : Variant );
    procedure SetCantidadProcesada( const Value : Variant );
    procedure SetProcesada( const Value : Variant );
    procedure SetPrecioDivisa( const Value : Variant );
    procedure SetPrecio( const Value : Variant );
    procedure SetRecargo( const Value : Variant );
    procedure SetPuntoVerde( const Value : Variant );
    procedure SetContribucionRAP( const Value : Variant );
    procedure SetDescuento( const Value : Variant );
    procedure SetNroCajas( const Value : Variant );
    procedure SetLargo( const Value : Variant );
    procedure SetAncho( const Value : Variant );
    procedure SetAlto( const Value : Variant );
    procedure SetBultos( const Value : Variant );
    procedure SetImporteRecargo( const Value : Variant );
    procedure SetPorcentajeRecargo( const Value : Variant );
    procedure SetNoCalcularMargen( const Value : Variant );
    procedure SetTipoLinea( const Value : Variant );
    procedure SetOferta( const Value : Variant );
    procedure SetPesoEnvase( const Value : Variant );
    procedure SetTara( const Value : Variant );
    procedure SetPeso( const Value : Variant );
    procedure SetImporteBruto( const Value : Variant );
    procedure SetImporteDescuento( const Value : Variant );
    procedure SetImporteNeto( const Value : Variant );
    procedure SetCodigoTipoIVA( const Value : Variant );
    procedure SetCuotaIVA( const Value : Variant );
    procedure SetCuotaRE( const Value : Variant );
    procedure SetPrecioIVA( const Value : Variant );
    procedure SetImporteTotal( const Value : Variant );
    procedure SetParametros( const Value : Variant );
    procedure SetAnotacion( const Value : Variant );
    property RemoteCursorID : TnxCursorID read GetRemoteCursorID write SetRemoteCursorID;
    property State : TDatasetState read GetState write SetState;

    property Ejercicio : SmallInt read GetEjercicio write SetEjercicio;
    property NroOperacion : Integer read GetNroOperacion write SetNroOperacion;
    property NroPagina : SmallInt read GetNroPagina write SetNroPagina;
    property NroLinea : SmallInt read GetNroLinea write SetNroLinea;
    property Fecha : Variant read GetFecha write SetFecha;
    property FechaAplicacion : Variant read GetFechaAplicacion write SetFechaAplicacion;
    property FechaCaducidad : Variant read GetFechaCaducidad write SetFechaCaducidad;
    property NroRegistro : Variant read GetNroRegistro write SetNroRegistro;
    property AsignacionOrigen : Variant read GetAsignacionOrigen write SetAsignacionOrigen;
    property TipoMovimientoOrigen : Variant read GetTipoMovimientoOrigen write SetTipoMovimientoOrigen;
    property EjercicioOrigen : Variant read GetEjercicioOrigen write SetEjercicioOrigen;
    property NroOperacionOrigen : Variant read GetNroOperacionOrigen write SetNroOperacionOrigen;
    property NroRegistroOrigen : Variant read GetNroRegistroOrigen write SetNroRegistroOrigen;
    property UIDArticulo : Variant read GetUIDArticulo write SetUIDArticulo;
    property CodigoArticulo : Variant read GetCodigoArticulo write SetCodigoArticulo;
    property CodigoClaseA : Variant read GetCodigoClaseA write SetCodigoClaseA;
    property CodigoClaseB : Variant read GetCodigoClaseB write SetCodigoClaseB;
    property CodigoClaseC : Variant read GetCodigoClaseC write SetCodigoClaseC;
    property LoteFabricacion : Variant read GetLoteFabricacion write SetLoteFabricacion;
    property NumeroSerie : Variant read GetNumeroSerie write SetNumeroSerie;
    property CampoLibre1 : Variant read GetCampoLibre1 write SetCampoLibre1;
    property CampoLibre2 : Variant read GetCampoLibre2 write SetCampoLibre2;
    property CampoLibre3 : Variant read GetCampoLibre3 write SetCampoLibre3;
    property CampoLibre4 : Variant read GetCampoLibre4 write SetCampoLibre4;
    property CampoLibre5 : Variant read GetCampoLibre5 write SetCampoLibre5;
    property Descripcion : Variant read GetDescripcion write SetDescripcion;
    property CodigoAlmacen : Variant read GetCodigoAlmacen write SetCodigoAlmacen;
    property Ubicacion : Variant read GetUbicacion write SetUbicacion;
    property Cantidad : Variant read GetCantidad write SetCantidad;
    property CantidadAjustada : Variant read GetCantidadAjustada write SetCantidadAjustada;
    property CantidadProcesada : Variant read GetCantidadProcesada write SetCantidadProcesada;
    property Procesada : Variant read GetProcesada write SetProcesada;
    property PrecioDivisa : Variant read GetPrecioDivisa write SetPrecioDivisa;
    property Precio : Variant read GetPrecio write SetPrecio;
    property Recargo : Variant read GetRecargo write SetRecargo;
    property PuntoVerde : Variant read GetPuntoVerde write SetPuntoVerde;
    property ContribucionRAP : Variant read GetContribucionRAP write SetContribucionRAP;
    property Descuento : Variant read GetDescuento write SetDescuento;
    property NroCajas : Variant read GetNroCajas write SetNroCajas;
    property Largo : Variant read GetLargo write SetLargo;
    property Ancho : Variant read GetAncho write SetAncho;
    property Alto : Variant read GetAlto write SetAlto;
    property Bultos : Variant read GetBultos write SetBultos;
    property ImporteRecargo : Variant read GetImporteRecargo write SetImporteRecargo;
    property PorcentajeRecargo : Variant read GetPorcentajeRecargo write SetPorcentajeRecargo;
    property NoCalcularMargen : Variant read GetNoCalcularMargen write SetNoCalcularMargen;
    property TipoLinea : Variant read GetTipoLinea write SetTipoLinea;
    property Oferta : Variant read GetOferta write SetOferta;
    property PesoEnvase : Variant read GetPesoEnvase write SetPesoEnvase;
    property Tara : Variant read GetTara write SetTara;
    property Peso : Variant read GetPeso write SetPeso;
    property ImporteBruto : Variant read GetImporteBruto write SetImporteBruto;
    property ImporteDescuento : Variant read GetImporteDescuento write SetImporteDescuento;
    property ImporteNeto : Variant read GetImporteNeto write SetImporteNeto;
    property CodigoTipoIVA : Variant read GetCodigoTipoIVA write SetCodigoTipoIVA;
    property CuotaIVA : Variant read GetCuotaIVA write SetCuotaIVA;
    property CuotaRE : Variant read GetCuotaRE write SetCuotaRE;
    property PrecioIVA : Variant read GetPrecioIVA write SetPrecioIVA;
    property ImporteTotal : Variant read GetImporteTotal write SetImporteTotal;
    property Parametros : Variant read GetParametros write SetParametros;
    property Anotacion : Variant read GetAnotacion write SetAnotacion;

    end;

   TLineaMovimiento = class( TnxClass, InxRemoteableClass, ILineaMovimiento)
     private

     FRemoteCursorID,
     FState : Variant;

     FEjercicio,
     FNroOperacion,
     FNroPagina,
     FNroLinea,
     FFecha,
     FFechaAplicacion,
     FFechaCaducidad,
     FNroRegistro,
     FAsignacionOrigen,
     FTipoMovimientoOrigen,
     FEjercicioOrigen,
     FNroOperacionOrigen,
     FNroRegistroOrigen,
     FUIDArticulo,
     FCodigoArticulo,
     FCodigoClaseA,
     FCodigoClaseB,
     FCodigoClaseC,
     FLoteFabricacion,
     FNumeroSerie,
     FCampoLibre1,
     FCampoLibre2,
     FCampoLibre3,
     FCampoLibre4,
     FCampoLibre5,
     FDescripcion,
     FCodigoAlmacen,
     FUbicacion,
     FCantidad,
     FCantidadAjustada,
     FCantidadProcesada,
     FProcesada,
     FPrecioDivisa,
     FPrecio,
     FRecargo,
     FPuntoVerde,
     FContribucionRAP,
     FDescuento,
     FNroCajas,
     FLargo,
     FAncho,
     FAlto,
     FBultos,
     FImporteRecargo,
     FPorcentajeRecargo,
     FNoCalcularMargen,
     FTipoLinea,
     FOferta,
     FPesoEnvase,
     FTara,
     FPeso,
     FImporteBruto,
     FImporteDescuento,
     FImporteNeto,
     FCodigoTipoIVA,
     FCuotaIVA,
     FCuotaRE,
     FPrecioIVA,
     FImporteTotal,
     FParametros,
     FAnotacion : Variant;

     function GetEjercicio : SmallInt;
     function GetNroOperacion : Integer;
     function GetNroPagina : SmallInt;
     function GetNroLinea : SmallInt;
     function GetFecha : Variant;
     function GetFechaAplicacion : Variant;
     function GetFechaCaducidad : Variant;
     function GetNroRegistro : Variant;
     function GetAsignacionOrigen : Variant;
     function GetTipoMovimientoOrigen : Variant;
     function GetEjercicioOrigen : Variant;
     function GetNroOperacionOrigen : Variant;
     function GetNroRegistroOrigen : Variant;
     function GetUIDArticulo : Variant;
     function GetCodigoArticulo : Variant;
     function GetCodigoClaseA : Variant;
     function GetCodigoClaseB : Variant;
     function GetCodigoClaseC : Variant;
     function GetLoteFabricacion : Variant;
     function GetNumeroSerie : Variant;
     function GetCampoLibre1 : Variant;
     function GetCampoLibre2 : Variant;
     function GetCampoLibre3 : Variant;
     function GetCampoLibre4 : Variant;
     function GetCampoLibre5 : Variant;
     function GetDescripcion : Variant;
     function GetCodigoAlmacen : Variant;
     function GetUbicacion : Variant;
     function GetCantidad : Variant;
     function GetCantidadAjustada : Variant;
     function GetCantidadProcesada : Variant;
     function GetProcesada : Variant;
     function GetPrecioDivisa : Variant;
     function GetPrecio : Variant;
     function GetRecargo : Variant;
     function GetPuntoVerde : Variant;
     function GetContribucionRAP : Variant;
     function GetDescuento : Variant;
     function GetNroCajas : Variant;
     function GetLargo : Variant;
     function GetAncho : Variant;
     function GetAlto : Variant;
     function GetBultos : Variant;
     function GetImporteRecargo : Variant;
     function GetPorcentajeRecargo : Variant;
     function GetNoCalcularMargen : Variant;
     function GetTipoLinea : Variant;
     function GetOferta : Variant;
     function GetPesoEnvase : Variant;
     function GetTara : Variant;
     function GetPeso : Variant;
     function GetImporteBruto : Variant;
     function GetImporteDescuento : Variant;
     function GetImporteNeto : Variant;
     function GetCodigoTipoIVA : Variant;
     function GetCuotaIVA : Variant;
     function GetCuotaRE : Variant;
     function GetPrecioIVA : Variant;
     function GetImporteTotal : Variant;
     function GetParametros : Variant;
     function GetAnotacion : Variant;

     procedure SetEjercicio( const Value : SmallInt );
     procedure SetNroOperacion( const Value : Integer );
     procedure SetNroPagina( const Value : SmallInt );
     procedure SetNroLinea( const Value : SmallInt );
     procedure SetFecha( const Value : Variant );
     procedure SetFechaAplicacion( const Value : Variant );
     procedure SetFechaCaducidad( const Value : Variant );
     procedure SetNroRegistro( const Value : Variant );
     procedure SetAsignacionOrigen( const Value : Variant );
     procedure SetTipoMovimientoOrigen( const Value : Variant );
     procedure SetEjercicioOrigen( const Value : Variant );
     procedure SetNroOperacionOrigen( const Value : Variant );
     procedure SetNroRegistroOrigen( const Value : Variant );
     procedure SetUIDArticulo( const Value : Variant );
     procedure SetCodigoArticulo( const Value : Variant );
     procedure SetCodigoClaseA( const Value : Variant );
     procedure SetCodigoClaseB( const Value : Variant );
     procedure SetCodigoClaseC( const Value : Variant );
     procedure SetLoteFabricacion( const Value : Variant );
     procedure SetNumeroSerie( const Value : Variant );
     procedure SetCampoLibre1( const Value : Variant );
     procedure SetCampoLibre2( const Value : Variant );
     procedure SetCampoLibre3( const Value : Variant );
     procedure SetCampoLibre4( const Value : Variant );
     procedure SetCampoLibre5( const Value : Variant );
     procedure SetDescripcion( const Value : Variant );
     procedure SetCodigoAlmacen( const Value : Variant );
     procedure SetUbicacion( const Value : Variant );
     procedure SetCantidad( const Value : Variant );
     procedure SetCantidadAjustada( const Value : Variant );
     procedure SetCantidadProcesada( const Value : Variant );
     procedure SetProcesada( const Value : Variant );
     procedure SetPrecioDivisa( const Value : Variant );
     procedure SetPrecio( const Value : Variant );
     procedure SetRecargo( const Value : Variant );
     procedure SetPuntoVerde( const Value : Variant );
     procedure SetContribucionRAP( const Value : Variant );
     procedure SetDescuento( const Value : Variant );
     procedure SetNroCajas( const Value : Variant );
     procedure SetLargo( const Value : Variant );
     procedure SetAncho( const Value : Variant );
     procedure SetAlto( const Value : Variant );
     procedure SetBultos( const Value : Variant );
     procedure SetImporteRecargo( const Value : Variant );
     procedure SetPorcentajeRecargo( const Value : Variant );
     procedure SetNoCalcularMargen( const Value : Variant );
     procedure SetTipoLinea( const Value : Variant );
     procedure SetOferta( const Value : Variant );
     procedure SetPesoEnvase( const Value : Variant );
     procedure SetTara( const Value : Variant );
     procedure SetPeso( const Value : Variant );
     procedure SetImporteBruto( const Value : Variant );
     procedure SetImporteDescuento( const Value : Variant );
     procedure SetImporteNeto( const Value : Variant );
     procedure SetCodigoTipoIVA( const Value : Variant );
     procedure SetCuotaIVA( const Value : Variant );
     procedure SetCuotaRE( const Value : Variant );
     procedure SetPrecioIVA( const Value : Variant );
     procedure SetImporteTotal( const Value : Variant );
     procedure SetParametros( const Value : Variant );
     procedure SetAnotacion( const Value : Variant );

     function LoadFromReader( AReader : InxReader ) : HRESULT;
     function SaveToWriter( AWriter : InxWriter ) : HRESULT;

     function GetRemoteCursorID : TnxCursorID;
     procedure SetRemoteCursorID( const Value : TnxCursorID );
     function GetState : TDataSetState;
     procedure SetState( const Value : TDataSetState );
     function GetClassID : TnxGuid;

     public

     constructor Create; reintroduce;

     class function FromDataset( LineaMovimientoFields  : TLineaMovimientoFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : ILineaMovimiento;
     procedure ToDataset( LineaMovimientoFields : TLineaMovimientoFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );

     end;

implementation

uses  Variants;

{ TLineaMovimiento }

constructor TLineaMovimiento.Create;
begin
     inherited Create( @CLSID_LineaMovimiento, nil, nil, False);
     FState := dsInsert;
end;

class function TLineaMovimiento.FromDataset( LineaMovimientoFields : TLineaMovimientoFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : ILineaMovimiento;

var   SaveState : TDataSetState;
      ApplyOldValues : Boolean;

begin
      Result := TLineaMovimiento.Create;

      With Result do
        begin

        RemoteCursorID := LineaMovimientoFields.GetRemoteCursorID;
        State := LineaMovimientoFields.Dataset.State;
        SaveState := State;

        ApplyOldValues := OldValues and not ( State in [ dsInsert, dsSetKey ] );
        If   ApplyOldValues
        then LineaMovimientoFields.IDataset.SetTempState( dsOldValue );

        try

          Ejercicio := GetFieldAsVariant( LineaMovimientoFields.Ejercicio );
          NroOperacion := GetFieldAsVariant( LineaMovimientoFields.NroOperacion );
          NroPagina := GetFieldAsVariant( LineaMovimientoFields.NroPagina );
          NroLinea := GetFieldAsVariant( LineaMovimientoFields.NroLinea );
          Fecha := GetFieldAsVariant( LineaMovimientoFields.Fecha );
          FechaAplicacion := GetFieldAsVariant( LineaMovimientoFields.FechaAplicacion );
          FechaCaducidad := GetFieldAsVariant( LineaMovimientoFields.FechaCaducidad );
          NroRegistro := GetFieldAsVariant( LineaMovimientoFields.NroRegistro );
          AsignacionOrigen := GetFieldAsVariant( LineaMovimientoFields.AsignacionOrigen );
          TipoMovimientoOrigen := GetFieldAsVariant( LineaMovimientoFields.TipoMovimientoOrigen );
          EjercicioOrigen := GetFieldAsVariant( LineaMovimientoFields.EjercicioOrigen );
          NroOperacionOrigen := GetFieldAsVariant( LineaMovimientoFields.NroOperacionOrigen );
          NroRegistroOrigen := GetFieldAsVariant( LineaMovimientoFields.NroRegistroOrigen );
          UIDArticulo := GetFieldAsVariant( LineaMovimientoFields.UIDArticulo );
          CodigoArticulo := GetFieldAsVariant( LineaMovimientoFields.CodigoArticulo );
          CodigoClaseA := GetFieldAsVariant( LineaMovimientoFields.CodigoClaseA );
          CodigoClaseB := GetFieldAsVariant( LineaMovimientoFields.CodigoClaseB );
          CodigoClaseC := GetFieldAsVariant( LineaMovimientoFields.CodigoClaseC );
          LoteFabricacion := GetFieldAsVariant( LineaMovimientoFields.LoteFabricacion );
          NumeroSerie := GetFieldAsVariant( LineaMovimientoFields.NumeroSerie );
          CampoLibre1 := GetFieldAsVariant( LineaMovimientoFields.CampoLibre1 );
          CampoLibre2 := GetFieldAsVariant( LineaMovimientoFields.CampoLibre2 );
          CampoLibre3 := GetFieldAsVariant( LineaMovimientoFields.CampoLibre3 );
          CampoLibre4 := GetFieldAsVariant( LineaMovimientoFields.CampoLibre4 );
          CampoLibre5 := GetFieldAsVariant( LineaMovimientoFields.CampoLibre5 );
          Descripcion := GetFieldAsVariant( LineaMovimientoFields.Descripcion );
          CodigoAlmacen := GetFieldAsVariant( LineaMovimientoFields.CodigoAlmacen );
          Ubicacion := GetFieldAsVariant( LineaMovimientoFields.Ubicacion );
          Cantidad := GetFieldAsVariant( LineaMovimientoFields.Cantidad );
          CantidadAjustada := GetFieldAsVariant( LineaMovimientoFields.CantidadAjustada );
          CantidadProcesada := GetFieldAsVariant( LineaMovimientoFields.CantidadProcesada );
          Procesada := GetFieldAsVariant( LineaMovimientoFields.Procesada );
          PrecioDivisa := GetFieldAsVariant( LineaMovimientoFields.PrecioDivisa );
          Precio := GetFieldAsVariant( LineaMovimientoFields.Precio );
          Recargo := GetFieldAsVariant( LineaMovimientoFields.Recargo );
          PuntoVerde := GetFieldAsVariant( LineaMovimientoFields.PuntoVerde );
          ContribucionRAP := GetFieldAsVariant( LineaMovimientoFields.ContribucionRAP );
          Descuento := GetFieldAsVariant( LineaMovimientoFields.Descuento );
          NroCajas := GetFieldAsVariant( LineaMovimientoFields.NroCajas );
          Largo := GetFieldAsVariant( LineaMovimientoFields.Largo );
          Ancho := GetFieldAsVariant( LineaMovimientoFields.Ancho );
          Alto := GetFieldAsVariant( LineaMovimientoFields.Alto );
          Bultos := GetFieldAsVariant( LineaMovimientoFields.Bultos );
          ImporteRecargo := GetFieldAsVariant( LineaMovimientoFields.ImporteRecargo );
          PorcentajeRecargo := GetFieldAsVariant( LineaMovimientoFields.PorcentajeRecargo );
          NoCalcularMargen := GetFieldAsVariant( LineaMovimientoFields.NoCalcularMargen );
          TipoLinea := GetFieldAsVariant( LineaMovimientoFields.TipoLinea );
          Oferta := GetFieldAsVariant( LineaMovimientoFields.Oferta );
          PesoEnvase := GetFieldAsVariant( LineaMovimientoFields.PesoEnvase );
          Tara := GetFieldAsVariant( LineaMovimientoFields.Tara );
          Peso := GetFieldAsVariant( LineaMovimientoFields.Peso );
          ImporteBruto := GetFieldAsVariant( LineaMovimientoFields.ImporteBruto );
          ImporteDescuento := GetFieldAsVariant( LineaMovimientoFields.ImporteDescuento );
          ImporteNeto := GetFieldAsVariant( LineaMovimientoFields.ImporteNeto );
          CodigoTipoIVA := GetFieldAsVariant( LineaMovimientoFields.CodigoTipoIVA );
          CuotaIVA := GetFieldAsVariant( LineaMovimientoFields.CuotaIVA );
          CuotaRE := GetFieldAsVariant( LineaMovimientoFields.CuotaRE );
          PrecioIVA := GetFieldAsVariant( LineaMovimientoFields.PrecioIVA );
          ImporteTotal := GetFieldAsVariant( LineaMovimientoFields.ImporteTotal );
          Parametros := GetFieldAsVariant( LineaMovimientoFields.Parametros );

          If   ReadBlobs
          then Anotacion := GetFieldAsVariant( LineaMovimientoFields.Anotacion )
          else Anotacion := '';


        finally
          If   ApplyOldValues
          then LineaMovimientoFields.IDataset.RestoreState( SaveState );
        end;
      end;

end;

procedure TLineaMovimiento.ToDataset( LineaMovimientoFields : TLineaMovimientoFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
begin
     try

       If   not PreserveState
       then LineaMovimientoFields.SetStateFromInterface( FState );

       LineaMovimientoFields.Ejercicio.Value := FEjercicio;
       LineaMovimientoFields.NroOperacion.Value := FNroOperacion;
       LineaMovimientoFields.NroPagina.Value := FNroPagina;
       LineaMovimientoFields.NroLinea.Value := FNroLinea;

       If   VarToStr( FUIDArticulo )=''
       then FUIDArticulo := GetGuid.ToString;

       SetFieldAsVariant( LineaMovimientoFields.Fecha, FFecha );
       SetFieldAsVariant( LineaMovimientoFields.FechaAplicacion, FFechaAplicacion );
       SetFieldAsVariant( LineaMovimientoFields.FechaCaducidad, FFechaCaducidad );
       SetFieldAsVariant( LineaMovimientoFields.NroRegistro, FNroRegistro );
       SetFieldAsVariant( LineaMovimientoFields.AsignacionOrigen, FAsignacionOrigen );
       SetFieldAsVariant( LineaMovimientoFields.TipoMovimientoOrigen, FTipoMovimientoOrigen );
       SetFieldAsVariant( LineaMovimientoFields.EjercicioOrigen, FEjercicioOrigen );
       SetFieldAsVariant( LineaMovimientoFields.NroOperacionOrigen, FNroOperacionOrigen );
       SetFieldAsVariant( LineaMovimientoFields.NroRegistroOrigen, FNroRegistroOrigen );
       SetFieldAsVariant( LineaMovimientoFields.UIDArticulo, FUIDArticulo );
       SetFieldAsVariant( LineaMovimientoFields.CodigoArticulo, FCodigoArticulo );
       SetFieldAsVariant( LineaMovimientoFields.CodigoClaseA, FCodigoClaseA );
       SetFieldAsVariant( LineaMovimientoFields.CodigoClaseB, FCodigoClaseB );
       SetFieldAsVariant( LineaMovimientoFields.CodigoClaseC, FCodigoClaseC );
       SetFieldAsVariant( LineaMovimientoFields.LoteFabricacion, FLoteFabricacion );
       SetFieldAsVariant( LineaMovimientoFields.NumeroSerie, FNumeroSerie );
       SetFieldAsVariant( LineaMovimientoFields.CampoLibre1, FCampoLibre1 );
       SetFieldAsVariant( LineaMovimientoFields.CampoLibre2, FCampoLibre2 );
       SetFieldAsVariant( LineaMovimientoFields.CampoLibre3, FCampoLibre3 );
       SetFieldAsVariant( LineaMovimientoFields.CampoLibre4, FCampoLibre4 );
       SetFieldAsVariant( LineaMovimientoFields.CampoLibre5, FCampoLibre5 );
       SetFieldAsVariant( LineaMovimientoFields.Descripcion, FDescripcion );
       SetFieldAsVariant( LineaMovimientoFields.CodigoAlmacen, FCodigoAlmacen );
       SetFieldAsVariant( LineaMovimientoFields.Ubicacion, FUbicacion );
       SetFieldAsVariant( LineaMovimientoFields.Cantidad, FCantidad );
       SetFieldAsVariant( LineaMovimientoFields.CantidadAjustada, FCantidadAjustada );
       SetFieldAsVariant( LineaMovimientoFields.CantidadProcesada, FCantidadProcesada );
       SetFieldAsVariant( LineaMovimientoFields.Procesada, FProcesada );
       SetFieldAsVariant( LineaMovimientoFields.PrecioDivisa, FPrecioDivisa );
       SetFieldAsVariant( LineaMovimientoFields.Precio, FPrecio );
       SetFieldAsVariant( LineaMovimientoFields.Recargo, FRecargo );
       SetFieldAsVariant( LineaMovimientoFields.PuntoVerde, FPuntoVerde );
       SetFieldAsVariant( LineaMovimientoFields.ContribucionRAP, FContribucionRAP );
       SetFieldAsVariant( LineaMovimientoFields.Descuento, FDescuento );
       SetFieldAsVariant( LineaMovimientoFields.NroCajas, FNroCajas );
       SetFieldAsVariant( LineaMovimientoFields.Largo, FLargo );
       SetFieldAsVariant( LineaMovimientoFields.Ancho, FAncho );
       SetFieldAsVariant( LineaMovimientoFields.Alto, FAlto );
       SetFieldAsVariant( LineaMovimientoFields.Bultos, FBultos );
       SetFieldAsVariant( LineaMovimientoFields.ImporteRecargo, FImporteRecargo );
       SetFieldAsVariant( LineaMovimientoFields.PorcentajeRecargo, FPorcentajeRecargo );
       SetFieldAsVariant( LineaMovimientoFields.NoCalcularMargen, FNoCalcularMargen );
       SetFieldAsVariant( LineaMovimientoFields.TipoLinea, FTipoLinea );
       SetFieldAsVariant( LineaMovimientoFields.Oferta, FOferta );
       SetFieldAsVariant( LineaMovimientoFields.PesoEnvase, FPesoEnvase );
       SetFieldAsVariant( LineaMovimientoFields.Tara, FTara );
       SetFieldAsVariant( LineaMovimientoFields.Peso, FPeso );
       SetFieldAsVariant( LineaMovimientoFields.ImporteBruto, FImporteBruto );
       SetFieldAsVariant( LineaMovimientoFields.ImporteDescuento, FImporteDescuento );
       SetFieldAsVariant( LineaMovimientoFields.ImporteNeto, FImporteNeto );
       SetFieldAsVariant( LineaMovimientoFields.CodigoTipoIVA, FCodigoTipoIVA );
       SetFieldAsVariant( LineaMovimientoFields.CuotaIVA, FCuotaIVA );
       SetFieldAsVariant( LineaMovimientoFields.CuotaRE, FCuotaRE );
       SetFieldAsVariant( LineaMovimientoFields.PrecioIVA, FPrecioIVA );
       SetFieldAsVariant( LineaMovimientoFields.ImporteTotal, FImporteTotal );
       SetFieldAsVariant( LineaMovimientoFields.Parametros, FParametros );

       If   ReadBlobs
       then SetFieldAsVariant( LineaMovimientoFields.Anotacion, FAnotacion )
       else LineaMovimientoFields.Anotacion.Clear;

     except
       LineaMovimientoFields.Dataset.Cancel;
       raise;
       end;

end;

function TLineaMovimiento.LoadFromReader( AReader : InxReader ) : HRESULT;

var VarFlags : TnxVarFlags;

begin
     nxReadVariant( VarFlags, FRemoteCursorID, AReader );
     nxReadVariant( VarFlags, FState, AReader );

     nxReadVariant( VarFlags, FEjercicio, AReader );
     nxReadVariant( VarFlags, FNroOperacion, AReader );
     nxReadVariant( VarFlags, FNroPagina, AReader );
     nxReadVariant( VarFlags, FNroLinea, AReader );
     nxReadVariant( VarFlags, FFecha, AReader );
     nxReadVariant( VarFlags, FFechaAplicacion, AReader );
     nxReadVariant( VarFlags, FFechaCaducidad, AReader );
     nxReadVariant( VarFlags, FNroRegistro, AReader );
     nxReadVariant( VarFlags, FAsignacionOrigen, AReader );
     nxReadVariant( VarFlags, FTipoMovimientoOrigen, AReader );
     nxReadVariant( VarFlags, FEjercicioOrigen, AReader );
     nxReadVariant( VarFlags, FNroOperacionOrigen, AReader );
     nxReadVariant( VarFlags, FNroRegistroOrigen, AReader );
     nxReadVariant( VarFlags, FUIDArticulo, AReader );
     nxReadVariant( VarFlags, FCodigoArticulo, AReader );
     nxReadVariant( VarFlags, FCodigoClaseA, AReader );
     nxReadVariant( VarFlags, FCodigoClaseB, AReader );
     nxReadVariant( VarFlags, FCodigoClaseC, AReader );
     nxReadVariant( VarFlags, FLoteFabricacion, AReader );
     nxReadVariant( VarFlags, FNumeroSerie, AReader );
     nxReadVariant( VarFlags, FCampoLibre1, AReader );
     nxReadVariant( VarFlags, FCampoLibre2, AReader );
     nxReadVariant( VarFlags, FCampoLibre3, AReader );
     nxReadVariant( VarFlags, FCampoLibre4, AReader );
     nxReadVariant( VarFlags, FCampoLibre5, AReader );
     nxReadVariant( VarFlags, FDescripcion, AReader );
     nxReadVariant( VarFlags, FCodigoAlmacen, AReader );
     nxReadVariant( VarFlags, FUbicacion, AReader );
     nxReadVariant( VarFlags, FCantidad, AReader );
     nxReadVariant( VarFlags, FCantidadAjustada, AReader );
     nxReadVariant( VarFlags, FCantidadProcesada, AReader );
     nxReadVariant( VarFlags, FProcesada, AReader );
     nxReadVariant( VarFlags, FPrecioDivisa, AReader );
     nxReadVariant( VarFlags, FPrecio, AReader );
     nxReadVariant( VarFlags, FRecargo, AReader );
     nxReadVariant( VarFlags, FPuntoVerde, AReader );
     nxReadVariant( VarFlags, FContribucionRAP, AReader );
     nxReadVariant( VarFlags, FDescuento, AReader );
     nxReadVariant( VarFlags, FNroCajas, AReader );
     nxReadVariant( VarFlags, FLargo, AReader );
     nxReadVariant( VarFlags, FAncho, AReader );
     nxReadVariant( VarFlags, FAlto, AReader );
     nxReadVariant( VarFlags, FBultos, AReader );
     nxReadVariant( VarFlags, FImporteRecargo, AReader );
     nxReadVariant( VarFlags, FPorcentajeRecargo, AReader );
     nxReadVariant( VarFlags, FNoCalcularMargen, AReader );
     nxReadVariant( VarFlags, FTipoLinea, AReader );
     nxReadVariant( VarFlags, FOferta, AReader );
     nxReadVariant( VarFlags, FPesoEnvase, AReader );
     nxReadVariant( VarFlags, FTara, AReader );
     nxReadVariant( VarFlags, FPeso, AReader );
     nxReadVariant( VarFlags, FImporteBruto, AReader );
     nxReadVariant( VarFlags, FImporteDescuento, AReader );
     nxReadVariant( VarFlags, FImporteNeto, AReader );
     nxReadVariant( VarFlags, FCodigoTipoIVA, AReader );
     nxReadVariant( VarFlags, FCuotaIVA, AReader );
     nxReadVariant( VarFlags, FCuotaRE, AReader );
     nxReadVariant( VarFlags, FPrecioIVA, AReader );
     nxReadVariant( VarFlags, FImporteTotal, AReader );
     nxReadVariant( VarFlags, FParametros, AReader );
     nxReadVariant( VarFlags, FAnotacion, AReader );

     Result := S_OK;
end;

function TLineaMovimiento.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     nxWriteVariant( FRemoteCursorID, AWriter );
     nxWriteVariant( FState, AWriter );

     nxWriteVariant( FEjercicio, AWriter );
     nxWriteVariant( FNroOperacion, AWriter );
     nxWriteVariant( FNroPagina, AWriter );
     nxWriteVariant( FNroLinea, AWriter );
     nxWriteVariant( FFecha, AWriter );
     nxWriteVariant( FFechaAplicacion, AWriter );
     nxWriteVariant( FFechaCaducidad, AWriter );
     nxWriteVariant( FNroRegistro, AWriter );
     nxWriteVariant( FAsignacionOrigen, AWriter );
     nxWriteVariant( FTipoMovimientoOrigen, AWriter );
     nxWriteVariant( FEjercicioOrigen, AWriter );
     nxWriteVariant( FNroOperacionOrigen, AWriter );
     nxWriteVariant( FNroRegistroOrigen, AWriter );
     nxWriteVariant( FUIDArticulo, AWriter );
     nxWriteVariant( FCodigoArticulo, AWriter );
     nxWriteVariant( FCodigoClaseA, AWriter );
     nxWriteVariant( FCodigoClaseB, AWriter );
     nxWriteVariant( FCodigoClaseC, AWriter );
     nxWriteVariant( FLoteFabricacion, AWriter );
     nxWriteVariant( FNumeroSerie, AWriter );
     nxWriteVariant( FCampoLibre1, AWriter );
     nxWriteVariant( FCampoLibre2, AWriter );
     nxWriteVariant( FCampoLibre3, AWriter );
     nxWriteVariant( FCampoLibre4, AWriter );
     nxWriteVariant( FCampoLibre5, AWriter );
     nxWriteVariant( FDescripcion, AWriter );
     nxWriteVariant( FCodigoAlmacen, AWriter );
     nxWriteVariant( FUbicacion, AWriter );
     nxWriteVariant( FCantidad, AWriter );
     nxWriteVariant( FCantidadAjustada, AWriter );
     nxWriteVariant( FCantidadProcesada, AWriter );
     nxWriteVariant( FProcesada, AWriter );
     nxWriteVariant( FPrecioDivisa, AWriter );
     nxWriteVariant( FPrecio, AWriter );
     nxWriteVariant( FRecargo, AWriter );
     nxWriteVariant( FPuntoVerde, AWriter );
     nxWriteVariant( FContribucionRAP, AWriter );
     nxWriteVariant( FDescuento, AWriter );
     nxWriteVariant( FNroCajas, AWriter );
     nxWriteVariant( FLargo, AWriter );
     nxWriteVariant( FAncho, AWriter );
     nxWriteVariant( FAlto, AWriter );
     nxWriteVariant( FBultos, AWriter );
     nxWriteVariant( FImporteRecargo, AWriter );
     nxWriteVariant( FPorcentajeRecargo, AWriter );
     nxWriteVariant( FNoCalcularMargen, AWriter );
     nxWriteVariant( FTipoLinea, AWriter );
     nxWriteVariant( FOferta, AWriter );
     nxWriteVariant( FPesoEnvase, AWriter );
     nxWriteVariant( FTara, AWriter );
     nxWriteVariant( FPeso, AWriter );
     nxWriteVariant( FImporteBruto, AWriter );
     nxWriteVariant( FImporteDescuento, AWriter );
     nxWriteVariant( FImporteNeto, AWriter );
     nxWriteVariant( FCodigoTipoIVA, AWriter );
     nxWriteVariant( FCuotaIVA, AWriter );
     nxWriteVariant( FCuotaRE, AWriter );
     nxWriteVariant( FPrecioIVA, AWriter );
     nxWriteVariant( FImporteTotal, AWriter );
     nxWriteVariant( FParametros, AWriter );
     nxWriteVariant( FAnotacion, AWriter );
     Result := S_OK;
end;

{ Getters}

function TLineaMovimiento.GetClassID: TnxGuid;
begin
     Result := CLSID_LineaMovimiento;
end;

function TLineaMovimiento.GetRemoteCursorID: TnxCursorID;
begin
     Result := FRemoteCursorID;
end;

function TLineaMovimiento.GetState: TDataSetState;
begin
     Result := FState;
end;


function TLineaMovimiento.GetEjercicio : SmallInt;
begin
     Result := FEjercicio;
end;

function TLineaMovimiento.GetNroOperacion : Integer;
begin
     Result := FNroOperacion;
end;

function TLineaMovimiento.GetNroPagina : SmallInt;
begin
     Result := FNroPagina;
end;

function TLineaMovimiento.GetNroLinea : SmallInt;
begin
     Result := FNroLinea;
end;

function TLineaMovimiento.GetFecha : Variant;
begin
     Result := FFecha;
end;

function TLineaMovimiento.GetFechaAplicacion : Variant;
begin
     Result := FFechaAplicacion;
end;

function TLineaMovimiento.GetFechaCaducidad : Variant;
begin
     Result := FFechaCaducidad;
end;

function TLineaMovimiento.GetNroRegistro : Variant;
begin
     Result := FNroRegistro;
end;

function TLineaMovimiento.GetAsignacionOrigen : Variant;
begin
     Result := FAsignacionOrigen;
end;

function TLineaMovimiento.GetTipoMovimientoOrigen : Variant;
begin
     Result := FTipoMovimientoOrigen;
end;

function TLineaMovimiento.GetEjercicioOrigen : Variant;
begin
     Result := FEjercicioOrigen;
end;

function TLineaMovimiento.GetNroOperacionOrigen : Variant;
begin
     Result := FNroOperacionOrigen;
end;

function TLineaMovimiento.GetNroRegistroOrigen : Variant;
begin
     Result := FNroRegistroOrigen;
end;

function TLineaMovimiento.GetUIDArticulo : Variant;
begin
     Result := FUIDArticulo;
end;

function TLineaMovimiento.GetCodigoArticulo : Variant;
begin
     Result := FCodigoArticulo;
end;

function TLineaMovimiento.GetCodigoClaseA : Variant;
begin
     Result := FCodigoClaseA;
end;

function TLineaMovimiento.GetCodigoClaseB : Variant;
begin
     Result := FCodigoClaseB;
end;

function TLineaMovimiento.GetCodigoClaseC : Variant;
begin
     Result := FCodigoClaseC;
end;

function TLineaMovimiento.GetLoteFabricacion : Variant;
begin
     Result := FLoteFabricacion;
end;

function TLineaMovimiento.GetNumeroSerie : Variant;
begin
     Result := FNumeroSerie;
end;

function TLineaMovimiento.GetCampoLibre1 : Variant;
begin
     Result := FCampoLibre1;
end;

function TLineaMovimiento.GetCampoLibre2 : Variant;
begin
     Result := FCampoLibre2;
end;

function TLineaMovimiento.GetCampoLibre3 : Variant;
begin
     Result := FCampoLibre3;
end;

function TLineaMovimiento.GetCampoLibre4 : Variant;
begin
     Result := FCampoLibre4;
end;

function TLineaMovimiento.GetCampoLibre5 : Variant;
begin
     Result := FCampoLibre5;
end;

function TLineaMovimiento.GetDescripcion : Variant;
begin
     Result := FDescripcion;
end;

function TLineaMovimiento.GetCodigoAlmacen : Variant;
begin
     Result := FCodigoAlmacen;
end;

function TLineaMovimiento.GetUbicacion : Variant;
begin
     Result := FUbicacion;
end;

function TLineaMovimiento.GetCantidad : Variant;
begin
     Result := FCantidad;
end;

function TLineaMovimiento.GetCantidadAjustada : Variant;
begin
     Result := FCantidadAjustada;
end;

function TLineaMovimiento.GetCantidadProcesada : Variant;
begin
     Result := FCantidadProcesada;
end;

function TLineaMovimiento.GetProcesada : Variant;
begin
     Result := FProcesada;
end;

function TLineaMovimiento.GetPrecioDivisa : Variant;
begin
     Result := FPrecioDivisa;
end;

function TLineaMovimiento.GetPrecio : Variant;
begin
     Result := FPrecio;
end;

function TLineaMovimiento.GetRecargo : Variant;
begin
     Result := FRecargo;
end;

function TLineaMovimiento.GetPuntoVerde : Variant;
begin
     Result := FPuntoVerde;
end;

function TLineaMovimiento.GetContribucionRAP : Variant;
begin
     Result := FContribucionRAP;
end;

function TLineaMovimiento.GetDescuento : Variant;
begin
     Result := FDescuento;
end;

function TLineaMovimiento.GetNroCajas : Variant;
begin
     Result := FNroCajas;
end;

function TLineaMovimiento.GetLargo : Variant;
begin
     Result := FLargo;
end;

function TLineaMovimiento.GetAncho : Variant;
begin
     Result := FAncho;
end;

function TLineaMovimiento.GetAlto : Variant;
begin
     Result := FAlto;
end;

function TLineaMovimiento.GetBultos : Variant;
begin
     Result := FBultos;
end;

function TLineaMovimiento.GetImporteRecargo : Variant;
begin
     Result := FImporteRecargo;
end;

function TLineaMovimiento.GetPorcentajeRecargo : Variant;
begin
     Result := FPorcentajeRecargo;
end;

function TLineaMovimiento.GetNoCalcularMargen : Variant;
begin
     Result := FNoCalcularMargen;
end;

function TLineaMovimiento.GetTipoLinea : Variant;
begin
     Result := FTipoLinea;
end;

function TLineaMovimiento.GetOferta : Variant;
begin
     Result := FOferta;
end;

function TLineaMovimiento.GetPesoEnvase : Variant;
begin
     Result := FPesoEnvase;
end;

function TLineaMovimiento.GetTara : Variant;
begin
     Result := FTara;
end;

function TLineaMovimiento.GetPeso : Variant;
begin
     Result := FPeso;
end;

function TLineaMovimiento.GetImporteBruto : Variant;
begin
     Result := FImporteBruto;
end;

function TLineaMovimiento.GetImporteDescuento : Variant;
begin
     Result := FImporteDescuento;
end;

function TLineaMovimiento.GetImporteNeto : Variant;
begin
     Result := FImporteNeto;
end;

function TLineaMovimiento.GetCodigoTipoIVA : Variant;
begin
     Result := FCodigoTipoIVA;
end;

function TLineaMovimiento.GetCuotaIVA : Variant;
begin
     Result := FCuotaIVA;
end;

function TLineaMovimiento.GetCuotaRE : Variant;
begin
     Result := FCuotaRE;
end;

function TLineaMovimiento.GetPrecioIVA : Variant;
begin
     Result := FPrecioIVA;
end;

function TLineaMovimiento.GetImporteTotal : Variant;
begin
     Result := FImporteTotal;
end;

function TLineaMovimiento.GetParametros : Variant;
begin
     Result := FParametros;
end;

function TLineaMovimiento.GetAnotacion : Variant;
begin
     Result := FAnotacion;
end;

{ Setters}

procedure TLineaMovimiento.SetRemoteCursorID( const Value : TnxCursorID );
begin
     FRemoteCursorID := Value;
end;

procedure TLineaMovimiento.SetState( const Value : TDataSetState );
begin
     FState := Value;
end;


procedure TLineaMovimiento.SetEjercicio(  const Value : SmallInt );
begin
     FEjercicio := Value;
end;

procedure TLineaMovimiento.SetNroOperacion(  const Value : Integer );
begin
     FNroOperacion := Value;
end;

procedure TLineaMovimiento.SetNroPagina(  const Value : SmallInt );
begin
     FNroPagina := Value;
end;

procedure TLineaMovimiento.SetNroLinea(  const Value : SmallInt );
begin
     FNroLinea := Value;
end;

procedure TLineaMovimiento.SetFecha(  const Value : Variant );
begin
     FFecha := Value;
end;

procedure TLineaMovimiento.SetFechaAplicacion(  const Value : Variant );
begin
     FFechaAplicacion := Value;
end;

procedure TLineaMovimiento.SetFechaCaducidad(  const Value : Variant );
begin
     FFechaCaducidad := Value;
end;

procedure TLineaMovimiento.SetNroRegistro(  const Value : Variant );
begin
     FNroRegistro := Value;
end;

procedure TLineaMovimiento.SetAsignacionOrigen(  const Value : Variant );
begin
     FAsignacionOrigen := Value;
end;

procedure TLineaMovimiento.SetTipoMovimientoOrigen(  const Value : Variant );
begin
     FTipoMovimientoOrigen := Value;
end;

procedure TLineaMovimiento.SetEjercicioOrigen(  const Value : Variant );
begin
     FEjercicioOrigen := Value;
end;

procedure TLineaMovimiento.SetNroOperacionOrigen(  const Value : Variant );
begin
     FNroOperacionOrigen := Value;
end;

procedure TLineaMovimiento.SetNroRegistroOrigen(  const Value : Variant );
begin
     FNroRegistroOrigen := Value;
end;

procedure TLineaMovimiento.SetUIDArticulo(  const Value : Variant );
begin
     FUIDArticulo := Value;
end;

procedure TLineaMovimiento.SetCodigoArticulo(  const Value : Variant );
begin
     FCodigoArticulo := Value;
end;

procedure TLineaMovimiento.SetCodigoClaseA(  const Value : Variant );
begin
     FCodigoClaseA := Value;
end;

procedure TLineaMovimiento.SetCodigoClaseB(  const Value : Variant );
begin
     FCodigoClaseB := Value;
end;

procedure TLineaMovimiento.SetCodigoClaseC(  const Value : Variant );
begin
     FCodigoClaseC := Value;
end;

procedure TLineaMovimiento.SetLoteFabricacion(  const Value : Variant );
begin
     FLoteFabricacion := Value;
end;

procedure TLineaMovimiento.SetNumeroSerie(  const Value : Variant );
begin
     FNumeroSerie := Value;
end;

procedure TLineaMovimiento.SetCampoLibre1(  const Value : Variant );
begin
     FCampoLibre1 := Value;
end;

procedure TLineaMovimiento.SetCampoLibre2(  const Value : Variant );
begin
     FCampoLibre2 := Value;
end;

procedure TLineaMovimiento.SetCampoLibre3(  const Value : Variant );
begin
     FCampoLibre3 := Value;
end;

procedure TLineaMovimiento.SetCampoLibre4(  const Value : Variant );
begin
     FCampoLibre4 := Value;
end;

procedure TLineaMovimiento.SetCampoLibre5(  const Value : Variant );
begin
     FCampoLibre5 := Value;
end;

procedure TLineaMovimiento.SetDescripcion(  const Value : Variant );
begin
     FDescripcion := Value;
end;

procedure TLineaMovimiento.SetCodigoAlmacen(  const Value : Variant );
begin
     FCodigoAlmacen := Value;
end;

procedure TLineaMovimiento.SetUbicacion(  const Value : Variant );
begin
     FUbicacion := Value;
end;

procedure TLineaMovimiento.SetCantidad(  const Value : Variant );
begin
     FCantidad := Value;
end;

procedure TLineaMovimiento.SetCantidadAjustada(  const Value : Variant );
begin
     FCantidadAjustada := Value;
end;

procedure TLineaMovimiento.SetCantidadProcesada(  const Value : Variant );
begin
     FCantidadProcesada := Value;
end;

procedure TLineaMovimiento.SetProcesada(  const Value : Variant );
begin
     FProcesada := Value;
end;

procedure TLineaMovimiento.SetPrecioDivisa(  const Value : Variant );
begin
     FPrecioDivisa := Value;
end;

procedure TLineaMovimiento.SetPrecio(  const Value : Variant );
begin
     FPrecio := Value;
end;

procedure TLineaMovimiento.SetRecargo(  const Value : Variant );
begin
     FRecargo := Value;
end;

procedure TLineaMovimiento.SetPuntoVerde(  const Value : Variant );
begin
     FPuntoVerde := Value;
end;

procedure TLineaMovimiento.SetContribucionRAP(  const Value : Variant );
begin
     FContribucionRAP := Value;
end;

procedure TLineaMovimiento.SetDescuento(  const Value : Variant );
begin
     FDescuento := Value;
end;

procedure TLineaMovimiento.SetNroCajas(  const Value : Variant );
begin
     FNroCajas := Value;
end;

procedure TLineaMovimiento.SetLargo(  const Value : Variant );
begin
     FLargo := Value;
end;

procedure TLineaMovimiento.SetAncho(  const Value : Variant );
begin
     FAncho := Value;
end;

procedure TLineaMovimiento.SetAlto(  const Value : Variant );
begin
     FAlto := Value;
end;

procedure TLineaMovimiento.SetBultos(  const Value : Variant );
begin
     FBultos := Value;
end;

procedure TLineaMovimiento.SetImporteRecargo(  const Value : Variant );
begin
     FImporteRecargo := Value;
end;

procedure TLineaMovimiento.SetPorcentajeRecargo(  const Value : Variant );
begin
     FPorcentajeRecargo := Value;
end;

procedure TLineaMovimiento.SetNoCalcularMargen(  const Value : Variant );
begin
     FNoCalcularMargen := Value;
end;

procedure TLineaMovimiento.SetTipoLinea(  const Value : Variant );
begin
     FTipoLinea := Value;
end;

procedure TLineaMovimiento.SetOferta(  const Value : Variant );
begin
     FOferta := Value;
end;

procedure TLineaMovimiento.SetPesoEnvase(  const Value : Variant );
begin
     FPesoEnvase := Value;
end;

procedure TLineaMovimiento.SetTara(  const Value : Variant );
begin
     FTara := Value;
end;

procedure TLineaMovimiento.SetPeso(  const Value : Variant );
begin
     FPeso := Value;
end;

procedure TLineaMovimiento.SetImporteBruto(  const Value : Variant );
begin
     FImporteBruto := Value;
end;

procedure TLineaMovimiento.SetImporteDescuento(  const Value : Variant );
begin
     FImporteDescuento := Value;
end;

procedure TLineaMovimiento.SetImporteNeto(  const Value : Variant );
begin
     FImporteNeto := Value;
end;

procedure TLineaMovimiento.SetCodigoTipoIVA(  const Value : Variant );
begin
     FCodigoTipoIVA := Value;
end;

procedure TLineaMovimiento.SetCuotaIVA(  const Value : Variant );
begin
     FCuotaIVA := Value;
end;

procedure TLineaMovimiento.SetCuotaRE(  const Value : Variant );
begin
     FCuotaRE := Value;
end;

procedure TLineaMovimiento.SetPrecioIVA(  const Value : Variant );
begin
     FPrecioIVA := Value;
end;

procedure TLineaMovimiento.SetImporteTotal(  const Value : Variant );
begin
     FImporteTotal := Value;
end;

procedure TLineaMovimiento.SetParametros(  const Value : Variant );
begin
     FParametros := Value;
end;

procedure TLineaMovimiento.SetAnotacion(  const Value : Variant );
begin
     FAnotacion := Value;
end;

var LineaMovimientoControl : InxClassFactoryControl;

initialization
   nxInvokeRegistry.RegisterInterface( TypeInfo( ILineaMovimiento ) );

   TnxClassFactory.RegisterClass( CLSID_LineaMovimiento, TLineaMovimiento, LineaMovimientoControl );

end.
