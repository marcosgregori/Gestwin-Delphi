{$ALIGN OFF}
{$OPTIMIZATION OFF}

unit OrdenFabricacionIntf;

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

      Gim70Fields;

const
  CLSID_OrdenFabricacion : TnxGuid = '{F14BD1DD-BD3E-4E4E-A5C4-74C6FA701EF4}';

type

  IOrdenFabricacion = interface( IInvokableRecord )
    [ '{7886B1B4-3EA4-4328-B2B2-D6FDB2A10FB2}' ] 

    procedure ToDataset( OrdenFabricacionFields : TOrdenFabricacionFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
    function GetRemoteCursorID : TnxCursorID;
    procedure SetRemoteCursorID( const Value : TnxCursorID );
    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );

    // Los campos que forman parte de un índice es conveniente que no sean Variants.
    // El resto, sin embargo, pueden ser valores nulos, o el campo no estar definido en el dataset.

    function GetEjercicio : SmallInt;
    function GetTipo : SmallInt;
    function GetNroOrden : Integer;
    function GetEjercicioPedido : Variant;
    function GetSeriePedido : Variant;
    function GetNroPedido : Variant;
    function GetEjercicioLanzamiento : Variant;
    function GetNroOperacionLanzamiento : Variant;
    function GetCodigoArticulo : Variant;
    function GetCodigoClaseA : Variant;
    function GetCodigoClaseB : Variant;
    function GetCodigoClaseC : Variant;
    function GetLote : Variant;
    function GetUnidadesAFabricar : Variant;
    function GetFechaLanzamiento : Variant;
    function GetPrioridad : Variant;
    function GetNroOrdenVinculada : Variant;
    function GetAprovisionamiento : Variant;
    function GetCerrado : Variant;
    function GetCargas : Variant;
    function GetmDispFabricacion1 : Variant;
    function GetmFabricacion : Variant;
    function GetmFabricDefectuosa : Variant;
    function GetmExtraidoIncorporado : Variant;
    function GetObservaciones : Variant;

    procedure SetEjercicio( const Value  : SmallInt );
    procedure SetTipo( const Value  : SmallInt );
    procedure SetNroOrden( const Value  : Integer );
    procedure SetEjercicioPedido( const Value  : Variant );
    procedure SetSeriePedido( const Value  : Variant );
    procedure SetNroPedido( const Value  : Variant );
    procedure SetEjercicioLanzamiento( const Value  : Variant );
    procedure SetNroOperacionLanzamiento( const Value  : Variant );
    procedure SetCodigoArticulo( const Value  : Variant );
    procedure SetCodigoClaseA( const Value  : Variant );
    procedure SetCodigoClaseB( const Value  : Variant );
    procedure SetCodigoClaseC( const Value  : Variant );
    procedure SetLote( const Value  : Variant );
    procedure SetUnidadesAFabricar( const Value  : Variant );
    procedure SetFechaLanzamiento( const Value  : Variant );
    procedure SetPrioridad( const Value  : Variant );
    procedure SetNroOrdenVinculada( const Value  : Variant );
    procedure SetAprovisionamiento( const Value  : Variant );
    procedure SetCerrado( const Value  : Variant );
    procedure SetCargas( const Value  : Variant );
    procedure SetmDispFabricacion1( const Value  : Variant );
    procedure SetmFabricacion( const Value  : Variant );
    procedure SetmFabricDefectuosa( const Value  : Variant );
    procedure SetmExtraidoIncorporado( const Value  : Variant );
    procedure SetObservaciones( const Value  : Variant );
    property RemoteCursorID : TnxCursorID read GetRemoteCursorID write SetRemoteCursorID;
    property State : TDatasetState read GetState write SetState;

    property Ejercicio : SmallInt read GetEjercicio write SetEjercicio;
    property Tipo : SmallInt read GetTipo write SetTipo;
    property NroOrden : Integer read GetNroOrden write SetNroOrden;
    property EjercicioPedido : Variant read GetEjercicioPedido write SetEjercicioPedido;
    property SeriePedido : Variant read GetSeriePedido write SetSeriePedido;
    property NroPedido : Variant read GetNroPedido write SetNroPedido;
    property EjercicioLanzamiento : Variant read GetEjercicioLanzamiento write SetEjercicioLanzamiento;
    property NroOperacionLanzamiento : Variant read GetNroOperacionLanzamiento write SetNroOperacionLanzamiento;
    property CodigoArticulo : Variant read GetCodigoArticulo write SetCodigoArticulo;
    property CodigoClaseA : Variant read GetCodigoClaseA write SetCodigoClaseA;
    property CodigoClaseB : Variant read GetCodigoClaseB write SetCodigoClaseB;
    property CodigoClaseC : Variant read GetCodigoClaseC write SetCodigoClaseC;
    property Lote : Variant read GetLote write SetLote;
    property UnidadesAFabricar : Variant read GetUnidadesAFabricar write SetUnidadesAFabricar;
    property FechaLanzamiento : Variant read GetFechaLanzamiento write SetFechaLanzamiento;
    property Prioridad : Variant read GetPrioridad write SetPrioridad;
    property NroOrdenVinculada : Variant read GetNroOrdenVinculada write SetNroOrdenVinculada;
    property Aprovisionamiento : Variant read GetAprovisionamiento write SetAprovisionamiento;
    property Cerrado : Variant read GetCerrado write SetCerrado;
    property Cargas : Variant read GetCargas write SetCargas;
    property mDispFabricacion1 : Variant read GetmDispFabricacion1 write SetmDispFabricacion1;
    property mFabricacion : Variant read GetmFabricacion write SetmFabricacion;
    property mFabricDefectuosa : Variant read GetmFabricDefectuosa write SetmFabricDefectuosa;
    property mExtraidoIncorporado : Variant read GetmExtraidoIncorporado write SetmExtraidoIncorporado;
    property Observaciones : Variant read GetObservaciones write SetObservaciones;

    end;

   TOrdenFabricacion = class( TnxClass, InxRemoteableClass, IOrdenFabricacion)
     private

     FRemoteCursorID,
     FState : Variant;

     FEjercicio,
     FTipo,
     FNroOrden,
     FEjercicioPedido,
     FSeriePedido,
     FNroPedido,
     FEjercicioLanzamiento,
     FNroOperacionLanzamiento,
     FCodigoArticulo,
     FCodigoClaseA,
     FCodigoClaseB,
     FCodigoClaseC,
     FLote,
     FUnidadesAFabricar,
     FFechaLanzamiento,
     FPrioridad,
     FNroOrdenVinculada,
     FAprovisionamiento,
     FCerrado,
     FCargas,
     FmDispFabricacion1,
     FmFabricacion,
     FmFabricDefectuosa,
     FmExtraidoIncorporado,
     FObservaciones : Variant;

     function GetEjercicio : SmallInt;
     function GetTipo : SmallInt;
     function GetNroOrden : Integer;
     function GetEjercicioPedido : Variant;
     function GetSeriePedido : Variant;
     function GetNroPedido : Variant;
     function GetEjercicioLanzamiento : Variant;
     function GetNroOperacionLanzamiento : Variant;
     function GetCodigoArticulo : Variant;
     function GetCodigoClaseA : Variant;
     function GetCodigoClaseB : Variant;
     function GetCodigoClaseC : Variant;
     function GetLote : Variant;
     function GetUnidadesAFabricar : Variant;
     function GetFechaLanzamiento : Variant;
     function GetPrioridad : Variant;
     function GetNroOrdenVinculada : Variant;
     function GetAprovisionamiento : Variant;
     function GetCerrado : Variant;
     function GetCargas : Variant;
     function GetmDispFabricacion1 : Variant;
     function GetmFabricacion : Variant;
     function GetmFabricDefectuosa : Variant;
     function GetmExtraidoIncorporado : Variant;
     function GetObservaciones : Variant;

     procedure SetEjercicio( const Value  : SmallInt );
     procedure SetTipo( const Value  : SmallInt );
     procedure SetNroOrden( const Value  : Integer );
     procedure SetEjercicioPedido( const Value  : Variant );
     procedure SetSeriePedido( const Value  : Variant );
     procedure SetNroPedido( const Value  : Variant );
     procedure SetEjercicioLanzamiento( const Value  : Variant );
     procedure SetNroOperacionLanzamiento( const Value  : Variant );
     procedure SetCodigoArticulo( const Value  : Variant );
     procedure SetCodigoClaseA( const Value  : Variant );
     procedure SetCodigoClaseB( const Value  : Variant );
     procedure SetCodigoClaseC( const Value  : Variant );
     procedure SetLote( const Value  : Variant );
     procedure SetUnidadesAFabricar( const Value  : Variant );
     procedure SetFechaLanzamiento( const Value  : Variant );
     procedure SetPrioridad( const Value  : Variant );
     procedure SetNroOrdenVinculada( const Value  : Variant );
     procedure SetAprovisionamiento( const Value  : Variant );
     procedure SetCerrado( const Value  : Variant );
     procedure SetCargas( const Value  : Variant );
     procedure SetmDispFabricacion1( const Value  : Variant );
     procedure SetmFabricacion( const Value  : Variant );
     procedure SetmFabricDefectuosa( const Value  : Variant );
     procedure SetmExtraidoIncorporado( const Value  : Variant );
     procedure SetObservaciones( const Value  : Variant );

     function LoadFromReader( AReader : InxReader ) : HRESULT;
     function SaveToWriter( AWriter : InxWriter ) : HRESULT;

     function GetRemoteCursorID : TnxCursorID;
     procedure SetRemoteCursorID( const Value : TnxCursorID );
     function GetState : TDataSetState;
     procedure SetState( const Value : TDataSetState );
     function GetClassID : TnxGuid;

     public

     constructor Create; reintroduce;

     class function FromDataset( OrdenFabricacionFields  : TOrdenFabricacionFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IOrdenFabricacion;
     procedure ToDataset( OrdenFabricacionFields : TOrdenFabricacionFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );

     end;

implementation

uses  Variants;

{ TOrdenFabricacion }

constructor TOrdenFabricacion.Create;
begin
     inherited Create( @CLSID_OrdenFabricacion, nil, nil, False);
     FState := dsInsert;
end;

class function TOrdenFabricacion.FromDataset( OrdenFabricacionFields : TOrdenFabricacionFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IOrdenFabricacion;

var   SaveState : TDataSetState;
      ApplyOldValues : Boolean;

begin
      Result := TOrdenFabricacion.Create;

      With Result do
        begin

        RemoteCursorID := OrdenFabricacionFields.GetRemoteCursorID;
        State := OrdenFabricacionFields.Dataset.State;
        SaveState := State;

        ApplyOldValues := OldValues and not ( State in [ dsInsert, dsSetKey ] );
        If   ApplyOldValues
        then OrdenFabricacionFields.IDataset.SetTempState( dsOldValue );

        try

          Ejercicio := GetFieldAsVariant( OrdenFabricacionFields.Ejercicio );
          Tipo := GetFieldAsVariant( OrdenFabricacionFields.Tipo );
          NroOrden := GetFieldAsVariant( OrdenFabricacionFields.NroOrden );
          EjercicioPedido := GetFieldAsVariant( OrdenFabricacionFields.EjercicioPedido );
          SeriePedido := GetFieldAsVariant( OrdenFabricacionFields.SeriePedido );
          NroPedido := GetFieldAsVariant( OrdenFabricacionFields.NroPedido );
          EjercicioLanzamiento := GetFieldAsVariant( OrdenFabricacionFields.EjercicioLanzamiento );
          NroOperacionLanzamiento := GetFieldAsVariant( OrdenFabricacionFields.NroOperacionLanzamiento );
          CodigoArticulo := GetFieldAsVariant( OrdenFabricacionFields.CodigoArticulo );
          CodigoClaseA := GetFieldAsVariant( OrdenFabricacionFields.CodigoClaseA );
          CodigoClaseB := GetFieldAsVariant( OrdenFabricacionFields.CodigoClaseB );
          CodigoClaseC := GetFieldAsVariant( OrdenFabricacionFields.CodigoClaseC );
          Lote := GetFieldAsVariant( OrdenFabricacionFields.Lote );
          UnidadesAFabricar := GetFieldAsVariant( OrdenFabricacionFields.UnidadesAFabricar );
          FechaLanzamiento := GetFieldAsVariant( OrdenFabricacionFields.FechaLanzamiento );
          Prioridad := GetFieldAsVariant( OrdenFabricacionFields.Prioridad );
          NroOrdenVinculada := GetFieldAsVariant( OrdenFabricacionFields.NroOrdenVinculada );
          Aprovisionamiento := GetFieldAsVariant( OrdenFabricacionFields.Aprovisionamiento );
          Cerrado := GetFieldAsVariant( OrdenFabricacionFields.Cerrado );
          Cargas := GetFieldAsVariant( OrdenFabricacionFields.Cargas );
          mDispFabricacion1 := GetFieldAsVariant( OrdenFabricacionFields.mDispFabricacion1 );
          mFabricacion := GetFieldAsVariant( OrdenFabricacionFields.mFabricacion );
          mFabricDefectuosa := GetFieldAsVariant( OrdenFabricacionFields.mFabricDefectuosa );
          mExtraidoIncorporado := GetFieldAsVariant( OrdenFabricacionFields.mExtraidoIncorporado );

          If   ReadBlobs
          then Observaciones := GetFieldAsVariant( OrdenFabricacionFields.Observaciones )
          else Observaciones := '';

        finally
          If   ApplyOldValues
          then OrdenFabricacionFields.IDataset.RestoreState( SaveState );
        end;
      end;

end;

procedure TOrdenFabricacion.ToDataset( OrdenFabricacionFields : TOrdenFabricacionFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
begin
     try

       If   not PreserveState
       then OrdenFabricacionFields.SetStateFromInterface( FState );

       OrdenFabricacionFields.Ejercicio.Value := FEjercicio;
       OrdenFabricacionFields.Tipo.Value := FTipo;
       OrdenFabricacionFields.NroOrden.Value := FNroOrden;

       SetFieldAsVariant( OrdenFabricacionFields.EjercicioPedido, FEjercicioPedido );
       SetFieldAsVariant( OrdenFabricacionFields.SeriePedido, FSeriePedido );
       SetFieldAsVariant( OrdenFabricacionFields.NroPedido, FNroPedido );
       SetFieldAsVariant( OrdenFabricacionFields.EjercicioLanzamiento, FEjercicioLanzamiento );
       SetFieldAsVariant( OrdenFabricacionFields.NroOperacionLanzamiento, FNroOperacionLanzamiento );
       SetFieldAsVariant( OrdenFabricacionFields.CodigoArticulo, FCodigoArticulo );
       SetFieldAsVariant( OrdenFabricacionFields.CodigoClaseA, FCodigoClaseA );
       SetFieldAsVariant( OrdenFabricacionFields.CodigoClaseB, FCodigoClaseB );
       SetFieldAsVariant( OrdenFabricacionFields.CodigoClaseC, FCodigoClaseC );
       SetFieldAsVariant( OrdenFabricacionFields.Lote, FLote );
       SetFieldAsVariant( OrdenFabricacionFields.UnidadesAFabricar, FUnidadesAFabricar );
       SetFieldAsVariant( OrdenFabricacionFields.FechaLanzamiento, FFechaLanzamiento );
       SetFieldAsVariant( OrdenFabricacionFields.Prioridad, FPrioridad );
       SetFieldAsVariant( OrdenFabricacionFields.NroOrdenVinculada, FNroOrdenVinculada );
       SetFieldAsVariant( OrdenFabricacionFields.Aprovisionamiento, FAprovisionamiento );
       SetFieldAsVariant( OrdenFabricacionFields.Cerrado, FCerrado );
       SetFieldAsVariant( OrdenFabricacionFields.Cargas, FCargas );
       SetFieldAsVariant( OrdenFabricacionFields.mDispFabricacion1, FmDispFabricacion1 );
       SetFieldAsVariant( OrdenFabricacionFields.mFabricacion, FmFabricacion );
       SetFieldAsVariant( OrdenFabricacionFields.mFabricDefectuosa, FmFabricDefectuosa );
       SetFieldAsVariant( OrdenFabricacionFields.mExtraidoIncorporado, FmExtraidoIncorporado );

       If   ReadBlobs
       then SetFieldAsVariant( OrdenFabricacionFields.Observaciones, FObservaciones )
       else OrdenFabricacionFields.Observaciones.Clear;


     except
       OrdenFabricacionFields.Dataset.Cancel;
       raise;
       end;

end;

function TOrdenFabricacion.LoadFromReader( AReader : InxReader ) : HRESULT;

var VarFlags : TnxVarFlags;

begin
     nxReadVariant( VarFlags, FRemoteCursorID, AReader );
     nxReadVariant( VarFlags, FState, AReader );

     nxReadVariant( VarFlags, FEjercicio, AReader );
     nxReadVariant( VarFlags, FTipo, AReader );
     nxReadVariant( VarFlags, FNroOrden, AReader );
     nxReadVariant( VarFlags, FEjercicioPedido, AReader );
     nxReadVariant( VarFlags, FSeriePedido, AReader );
     nxReadVariant( VarFlags, FNroPedido, AReader );
     nxReadVariant( VarFlags, FEjercicioLanzamiento, AReader );
     nxReadVariant( VarFlags, FNroOperacionLanzamiento, AReader );
     nxReadVariant( VarFlags, FCodigoArticulo, AReader );
     nxReadVariant( VarFlags, FCodigoClaseA, AReader );
     nxReadVariant( VarFlags, FCodigoClaseB, AReader );
     nxReadVariant( VarFlags, FCodigoClaseC, AReader );
     nxReadVariant( VarFlags, FLote, AReader );
     nxReadVariant( VarFlags, FUnidadesAFabricar, AReader );
     nxReadVariant( VarFlags, FFechaLanzamiento, AReader );
     nxReadVariant( VarFlags, FPrioridad, AReader );
     nxReadVariant( VarFlags, FNroOrdenVinculada, AReader );
     nxReadVariant( VarFlags, FAprovisionamiento, AReader );
     nxReadVariant( VarFlags, FCerrado, AReader );
     nxReadVariant( VarFlags, FCargas, AReader );
     nxReadVariant( VarFlags, FmDispFabricacion1, AReader );
     nxReadVariant( VarFlags, FmFabricacion, AReader );
     nxReadVariant( VarFlags, FmFabricDefectuosa, AReader );
     nxReadVariant( VarFlags, FmExtraidoIncorporado, AReader );
     nxReadVariant( VarFlags, FObservaciones, AReader );

     Result := S_OK;
end;

function TOrdenFabricacion.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     nxWriteVariant( FRemoteCursorID, AWriter );
     nxWriteVariant( FState, AWriter );

     nxWriteVariant( FEjercicio, AWriter );
     nxWriteVariant( FTipo, AWriter );
     nxWriteVariant( FNroOrden, AWriter );
     nxWriteVariant( FEjercicioPedido, AWriter );
     nxWriteVariant( FSeriePedido, AWriter );
     nxWriteVariant( FNroPedido, AWriter );
     nxWriteVariant( FEjercicioLanzamiento, AWriter );
     nxWriteVariant( FNroOperacionLanzamiento, AWriter );
     nxWriteVariant( FCodigoArticulo, AWriter );
     nxWriteVariant( FCodigoClaseA, AWriter );
     nxWriteVariant( FCodigoClaseB, AWriter );
     nxWriteVariant( FCodigoClaseC, AWriter );
     nxWriteVariant( FLote, AWriter );
     nxWriteVariant( FUnidadesAFabricar, AWriter );
     nxWriteVariant( FFechaLanzamiento, AWriter );
     nxWriteVariant( FPrioridad, AWriter );
     nxWriteVariant( FNroOrdenVinculada, AWriter );
     nxWriteVariant( FAprovisionamiento, AWriter );
     nxWriteVariant( FCerrado, AWriter );
     nxWriteVariant( FCargas, AWriter );
     nxWriteVariant( FmDispFabricacion1, AWriter );
     nxWriteVariant( FmFabricacion, AWriter );
     nxWriteVariant( FmFabricDefectuosa, AWriter );
     nxWriteVariant( FmExtraidoIncorporado, AWriter );
     nxWriteVariant( FObservaciones, AWriter );
     Result := S_OK;
end;

{ Getters}

function TOrdenFabricacion.GetClassID: TnxGuid;
begin
     Result := CLSID_OrdenFabricacion;
end;

function TOrdenFabricacion.GetRemoteCursorID: TnxCursorID;
begin
     Result := FRemoteCursorID;
end;

function TOrdenFabricacion.GetState: TDataSetState;
begin
     Result := FState;
end;


function TOrdenFabricacion.GetEjercicio : SmallInt;
begin
     Result := FEjercicio;
end;

function TOrdenFabricacion.GetTipo : SmallInt;
begin
     Result := FTipo;
end;

function TOrdenFabricacion.GetNroOrden : Integer;
begin
     Result := FNroOrden;
end;

function TOrdenFabricacion.GetEjercicioPedido : Variant;
begin
     Result := FEjercicioPedido;
end;

function TOrdenFabricacion.GetSeriePedido : Variant;
begin
     Result := FSeriePedido;
end;

function TOrdenFabricacion.GetNroPedido : Variant;
begin
     Result := FNroPedido;
end;

function TOrdenFabricacion.GetEjercicioLanzamiento : Variant;
begin
     Result := FEjercicioLanzamiento;
end;

function TOrdenFabricacion.GetNroOperacionLanzamiento : Variant;
begin
     Result := FNroOperacionLanzamiento;
end;

function TOrdenFabricacion.GetCodigoArticulo : Variant;
begin
     Result := FCodigoArticulo;
end;

function TOrdenFabricacion.GetCodigoClaseA : Variant;
begin
     Result := FCodigoClaseA;
end;

function TOrdenFabricacion.GetCodigoClaseB : Variant;
begin
     Result := FCodigoClaseB;
end;

function TOrdenFabricacion.GetCodigoClaseC : Variant;
begin
     Result := FCodigoClaseC;
end;

function TOrdenFabricacion.GetLote : Variant;
begin
     Result := FLote;
end;

function TOrdenFabricacion.GetUnidadesAFabricar : Variant;
begin
     Result := FUnidadesAFabricar;
end;

function TOrdenFabricacion.GetFechaLanzamiento : Variant;
begin
     Result := FFechaLanzamiento;
end;

function TOrdenFabricacion.GetPrioridad : Variant;
begin
     Result := FPrioridad;
end;

function TOrdenFabricacion.GetNroOrdenVinculada : Variant;
begin
     Result := FNroOrdenVinculada;
end;

function TOrdenFabricacion.GetAprovisionamiento : Variant;
begin
     Result := FAprovisionamiento;
end;

function TOrdenFabricacion.GetCerrado : Variant;
begin
     Result := FCerrado;
end;

function TOrdenFabricacion.GetCargas : Variant;
begin
     Result := FCargas;
end;

function TOrdenFabricacion.GetmDispFabricacion1 : Variant;
begin
     Result := FmDispFabricacion1;
end;

function TOrdenFabricacion.GetmFabricacion : Variant;
begin
     Result := FmFabricacion;
end;

function TOrdenFabricacion.GetmFabricDefectuosa : Variant;
begin
     Result := FmFabricDefectuosa;
end;

function TOrdenFabricacion.GetmExtraidoIncorporado : Variant;
begin
     Result := FmExtraidoIncorporado;
end;

function TOrdenFabricacion.GetObservaciones : Variant;
begin
     Result := FObservaciones;
end;

{ Setters}

procedure TOrdenFabricacion.SetRemoteCursorID( const Value : TnxCursorID );
begin
     FRemoteCursorID := Value;
end;

procedure TOrdenFabricacion.SetState( const Value : TDataSetState );
begin
     FState := Value;
end;


procedure TOrdenFabricacion.SetEjercicio(  const Value : SmallInt );
begin
     FEjercicio := Value;
end;

procedure TOrdenFabricacion.SetTipo(  const Value : SmallInt );
begin
     FTipo := Value;
end;

procedure TOrdenFabricacion.SetNroOrden(  const Value : Integer );
begin
     FNroOrden := Value;
end;

procedure TOrdenFabricacion.SetEjercicioPedido(  const Value : Variant );
begin
     FEjercicioPedido := Value;
end;

procedure TOrdenFabricacion.SetSeriePedido(  const Value : Variant );
begin
     FSeriePedido := Value;
end;

procedure TOrdenFabricacion.SetNroPedido(  const Value : Variant );
begin
     FNroPedido := Value;
end;

procedure TOrdenFabricacion.SetEjercicioLanzamiento(  const Value : Variant );
begin
     FEjercicioLanzamiento := Value;
end;

procedure TOrdenFabricacion.SetNroOperacionLanzamiento(  const Value : Variant );
begin
     FNroOperacionLanzamiento := Value;
end;

procedure TOrdenFabricacion.SetCodigoArticulo(  const Value : Variant );
begin
     FCodigoArticulo := Value;
end;

procedure TOrdenFabricacion.SetCodigoClaseA(  const Value : Variant );
begin
     FCodigoClaseA := Value;
end;

procedure TOrdenFabricacion.SetCodigoClaseB(  const Value : Variant );
begin
     FCodigoClaseB := Value;
end;

procedure TOrdenFabricacion.SetCodigoClaseC(  const Value : Variant );
begin
     FCodigoClaseC := Value;
end;

procedure TOrdenFabricacion.SetLote(  const Value : Variant );
begin
     FLote := Value;
end;

procedure TOrdenFabricacion.SetUnidadesAFabricar(  const Value : Variant );
begin
     FUnidadesAFabricar := Value;
end;

procedure TOrdenFabricacion.SetFechaLanzamiento(  const Value : Variant );
begin
     FFechaLanzamiento := Value;
end;

procedure TOrdenFabricacion.SetPrioridad(  const Value : Variant );
begin
     FPrioridad := Value;
end;

procedure TOrdenFabricacion.SetNroOrdenVinculada(  const Value : Variant );
begin
     FNroOrdenVinculada := Value;
end;

procedure TOrdenFabricacion.SetAprovisionamiento(  const Value : Variant );
begin
     FAprovisionamiento := Value;
end;

procedure TOrdenFabricacion.SetCerrado(  const Value : Variant );
begin
     FCerrado := Value;
end;

procedure TOrdenFabricacion.SetCargas(  const Value : Variant );
begin
     FCargas := Value;
end;

procedure TOrdenFabricacion.SetmDispFabricacion1(  const Value : Variant );
begin
     FmDispFabricacion1 := Value;
end;

procedure TOrdenFabricacion.SetmFabricacion(  const Value : Variant );
begin
     FmFabricacion := Value;
end;

procedure TOrdenFabricacion.SetmFabricDefectuosa(  const Value : Variant );
begin
     FmFabricDefectuosa := Value;
end;

procedure TOrdenFabricacion.SetmExtraidoIncorporado(  const Value : Variant );
begin
     FmExtraidoIncorporado := Value;
end;

procedure TOrdenFabricacion.SetObservaciones(  const Value : Variant );
begin
     FObservaciones := Value;
end;

var OrdenFabricacionControl : InxClassFactoryControl;

initialization
   nxInvokeRegistry.RegisterInterface( TypeInfo( IOrdenFabricacion ) );

   TnxClassFactory.RegisterClass( CLSID_OrdenFabricacion, TOrdenFabricacion, OrdenFabricacionControl );

end.
