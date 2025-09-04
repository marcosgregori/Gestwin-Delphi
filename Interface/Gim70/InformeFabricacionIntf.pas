{$ALIGN OFF}
{$OPTIMIZATION OFF}

unit InformeFabricacionIntf;

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
  CLSID_InformeFabricacion : TnxGuid = '{58DBF14F-27D0-4342-8080-8D53632C6A28}';

type

  IInformeFabricacion = interface( IInvokableRecord )
    [ '{04143496-F792-4849-9364-36A4FF5186B9}' ] 

    procedure ToDataset( InformeFabricacionFields : TInformeFabricacionFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
    function GetRemoteCursorID : TnxCursorID;
    procedure SetRemoteCursorID( const Value : TnxCursorID );
    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );

    // Los campos que forman parte de un índice es conveniente que no sean Variants.
    // El resto, sin embargo, pueden ser valores nulos, o el campo no estar definido en el dataset.

    function GetEjercicio : Variant;
    function GetNroOrden : Variant;
    function GetNroProceso : Variant;
    function GetFecha : Variant;
    function GetTurno : Variant;
    function GetCorrectas : Variant;
    function GetDefectuosas : Variant;
    function GetMermaExceso : Variant;
    function GetIncorpExtraidas : Variant;
    function GetCodigoDefecto : Variant;
    function GetIncExtClaseA : Variant;
    function GetIncExtClaseB : Variant;
    function GetIncExtClaseC : Variant;
    function GetHoraInicio : Variant;
    function GetHoraFinalizacion : Variant;
    function GetPreparacion : Variant;
    function GetFabricacion : Variant;
    function GetCodigoIncidencia : Variant;
    function GetObservaciones : Variant;

    procedure SetEjercicio( const Value  : Variant );
    procedure SetNroOrden( const Value  : Variant );
    procedure SetNroProceso( const Value  : Variant );
    procedure SetFecha( const Value  : Variant );
    procedure SetTurno( const Value  : Variant );
    procedure SetCorrectas( const Value  : Variant );
    procedure SetDefectuosas( const Value  : Variant );
    procedure SetMermaExceso( const Value  : Variant );
    procedure SetIncorpExtraidas( const Value  : Variant );
    procedure SetCodigoDefecto( const Value  : Variant );
    procedure SetIncExtClaseA( const Value  : Variant );
    procedure SetIncExtClaseB( const Value  : Variant );
    procedure SetIncExtClaseC( const Value  : Variant );
    procedure SetHoraInicio( const Value  : Variant );
    procedure SetHoraFinalizacion( const Value  : Variant );
    procedure SetPreparacion( const Value  : Variant );
    procedure SetFabricacion( const Value  : Variant );
    procedure SetCodigoIncidencia( const Value  : Variant );
    procedure SetObservaciones( const Value  : Variant );
    property RemoteCursorID : TnxCursorID read GetRemoteCursorID write SetRemoteCursorID;
    property State : TDatasetState read GetState write SetState;

    property Ejercicio : Variant read GetEjercicio write SetEjercicio;
    property NroOrden : Variant read GetNroOrden write SetNroOrden;
    property NroProceso : Variant read GetNroProceso write SetNroProceso;
    property Fecha : Variant read GetFecha write SetFecha;
    property Turno : Variant read GetTurno write SetTurno;
    property Correctas : Variant read GetCorrectas write SetCorrectas;
    property Defectuosas : Variant read GetDefectuosas write SetDefectuosas;
    property MermaExceso : Variant read GetMermaExceso write SetMermaExceso;
    property IncorpExtraidas : Variant read GetIncorpExtraidas write SetIncorpExtraidas;
    property CodigoDefecto : Variant read GetCodigoDefecto write SetCodigoDefecto;
    property IncExtClaseA : Variant read GetIncExtClaseA write SetIncExtClaseA;
    property IncExtClaseB : Variant read GetIncExtClaseB write SetIncExtClaseB;
    property IncExtClaseC : Variant read GetIncExtClaseC write SetIncExtClaseC;
    property HoraInicio : Variant read GetHoraInicio write SetHoraInicio;
    property HoraFinalizacion : Variant read GetHoraFinalizacion write SetHoraFinalizacion;
    property Preparacion : Variant read GetPreparacion write SetPreparacion;
    property Fabricacion : Variant read GetFabricacion write SetFabricacion;
    property CodigoIncidencia : Variant read GetCodigoIncidencia write SetCodigoIncidencia;
    property Observaciones : Variant read GetObservaciones write SetObservaciones;

    end;

   TInformeFabricacion = class( TnxClass, InxRemoteableClass, IInformeFabricacion)
     private

     FRemoteCursorID,
     FState : Variant;

     FEjercicio,
     FNroOrden,
     FNroProceso,
     FFecha,
     FTurno,
     FCorrectas,
     FDefectuosas,
     FMermaExceso,
     FIncorpExtraidas,
     FCodigoDefecto,
     FIncExtClaseA,
     FIncExtClaseB,
     FIncExtClaseC,
     FHoraInicio,
     FHoraFinalizacion,
     FPreparacion,
     FFabricacion,
     FCodigoIncidencia,
     FObservaciones : Variant;

     function GetEjercicio : Variant;
     function GetNroOrden : Variant;
     function GetNroProceso : Variant;
     function GetFecha : Variant;
     function GetTurno : Variant;
     function GetCorrectas : Variant;
     function GetDefectuosas : Variant;
     function GetMermaExceso : Variant;
     function GetIncorpExtraidas : Variant;
     function GetCodigoDefecto : Variant;
     function GetIncExtClaseA : Variant;
     function GetIncExtClaseB : Variant;
     function GetIncExtClaseC : Variant;
     function GetHoraInicio : Variant;
     function GetHoraFinalizacion : Variant;
     function GetPreparacion : Variant;
     function GetFabricacion : Variant;
     function GetCodigoIncidencia : Variant;
     function GetObservaciones : Variant;

     procedure SetEjercicio( const Value  : Variant );
     procedure SetNroOrden( const Value  : Variant );
     procedure SetNroProceso( const Value  : Variant );
     procedure SetFecha( const Value  : Variant );
     procedure SetTurno( const Value  : Variant );
     procedure SetCorrectas( const Value  : Variant );
     procedure SetDefectuosas( const Value  : Variant );
     procedure SetMermaExceso( const Value  : Variant );
     procedure SetIncorpExtraidas( const Value  : Variant );
     procedure SetCodigoDefecto( const Value  : Variant );
     procedure SetIncExtClaseA( const Value  : Variant );
     procedure SetIncExtClaseB( const Value  : Variant );
     procedure SetIncExtClaseC( const Value  : Variant );
     procedure SetHoraInicio( const Value  : Variant );
     procedure SetHoraFinalizacion( const Value  : Variant );
     procedure SetPreparacion( const Value  : Variant );
     procedure SetFabricacion( const Value  : Variant );
     procedure SetCodigoIncidencia( const Value  : Variant );
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

     class function FromDataset( InformeFabricacionFields  : TInformeFabricacionFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IInformeFabricacion;
     procedure ToDataset( InformeFabricacionFields : TInformeFabricacionFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );

     end;

implementation

uses  Variants;

{ TInformeFabricacion }

constructor TInformeFabricacion.Create;
begin
     inherited Create( @CLSID_InformeFabricacion, nil, nil, False);
     FState := dsInsert;
end;

class function TInformeFabricacion.FromDataset( InformeFabricacionFields : TInformeFabricacionFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IInformeFabricacion;

var   SaveState : TDataSetState;
      ApplyOldValues : Boolean;

begin
      Result := TInformeFabricacion.Create;

      With Result do
        begin

        RemoteCursorID := InformeFabricacionFields.GetRemoteCursorID;
        State := InformeFabricacionFields.Dataset.State;
        SaveState := State;

        ApplyOldValues := OldValues and not ( State in [ dsInsert, dsSetKey ] );
        If   ApplyOldValues
        then InformeFabricacionFields.IDataset.SetTempState( dsOldValue );

        try

          Ejercicio := GetFieldAsVariant( InformeFabricacionFields.Ejercicio );
          NroOrden := GetFieldAsVariant( InformeFabricacionFields.NroOrden );
          NroProceso := GetFieldAsVariant( InformeFabricacionFields.NroProceso );
          Fecha := GetFieldAsVariant( InformeFabricacionFields.Fecha );
          Turno := GetFieldAsVariant( InformeFabricacionFields.Turno );
          Correctas := GetFieldAsVariant( InformeFabricacionFields.Correctas );
          Defectuosas := GetFieldAsVariant( InformeFabricacionFields.Defectuosas );
          MermaExceso := GetFieldAsVariant( InformeFabricacionFields.MermaExceso );
          IncorpExtraidas := GetFieldAsVariant( InformeFabricacionFields.IncorpExtraidas );
          CodigoDefecto := GetFieldAsVariant( InformeFabricacionFields.CodigoDefecto );
          IncExtClaseA := GetFieldAsVariant( InformeFabricacionFields.IncExtClaseA );
          IncExtClaseB := GetFieldAsVariant( InformeFabricacionFields.IncExtClaseB );
          IncExtClaseC := GetFieldAsVariant( InformeFabricacionFields.IncExtClaseC );
          HoraInicio := GetFieldAsVariant( InformeFabricacionFields.HoraInicio );
          HoraFinalizacion := GetFieldAsVariant( InformeFabricacionFields.HoraFinalizacion );
          Preparacion := GetFieldAsVariant( InformeFabricacionFields.Preparacion );
          Fabricacion := GetFieldAsVariant( InformeFabricacionFields.Fabricacion );
          CodigoIncidencia := GetFieldAsVariant( InformeFabricacionFields.CodigoIncidencia );

          If   ReadBlobs
          then Observaciones := GetFieldAsVariant( InformeFabricacionFields.Observaciones )
          else Observaciones := '';

        finally
          If   ApplyOldValues
          then InformeFabricacionFields.IDataset.RestoreState( SaveState );
        end;
      end;

end;

procedure TInformeFabricacion.ToDataset( InformeFabricacionFields : TInformeFabricacionFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
begin
     try

       If   not PreserveState
       then InformeFabricacionFields.SetStateFromInterface( FState );


       SetFieldAsVariant( InformeFabricacionFields.Ejercicio, FEjercicio );
       SetFieldAsVariant( InformeFabricacionFields.NroOrden, FNroOrden );
       SetFieldAsVariant( InformeFabricacionFields.NroProceso, FNroProceso );
       SetFieldAsVariant( InformeFabricacionFields.Fecha, FFecha );
       SetFieldAsVariant( InformeFabricacionFields.Turno, FTurno );
       SetFieldAsVariant( InformeFabricacionFields.Correctas, FCorrectas );
       SetFieldAsVariant( InformeFabricacionFields.Defectuosas, FDefectuosas );
       SetFieldAsVariant( InformeFabricacionFields.MermaExceso, FMermaExceso );
       SetFieldAsVariant( InformeFabricacionFields.IncorpExtraidas, FIncorpExtraidas );
       SetFieldAsVariant( InformeFabricacionFields.CodigoDefecto, FCodigoDefecto );
       SetFieldAsVariant( InformeFabricacionFields.IncExtClaseA, FIncExtClaseA );
       SetFieldAsVariant( InformeFabricacionFields.IncExtClaseB, FIncExtClaseB );
       SetFieldAsVariant( InformeFabricacionFields.IncExtClaseC, FIncExtClaseC );
       SetFieldAsVariant( InformeFabricacionFields.HoraInicio, FHoraInicio );
       SetFieldAsVariant( InformeFabricacionFields.HoraFinalizacion, FHoraFinalizacion );
       SetFieldAsVariant( InformeFabricacionFields.Preparacion, FPreparacion );
       SetFieldAsVariant( InformeFabricacionFields.Fabricacion, FFabricacion );
       SetFieldAsVariant( InformeFabricacionFields.CodigoIncidencia, FCodigoIncidencia );

       If   ReadBlobs
       then SetFieldAsVariant( InformeFabricacionFields.Observaciones, FObservaciones )
       else InformeFabricacionFields.Observaciones.Clear;

     except
       InformeFabricacionFields.Dataset.Cancel;
       raise;
       end;

end;

function TInformeFabricacion.LoadFromReader( AReader : InxReader ) : HRESULT;

var VarFlags : TnxVarFlags;

begin
     nxReadVariant( VarFlags, FRemoteCursorID, AReader );
     nxReadVariant( VarFlags, FState, AReader );

     nxReadVariant( VarFlags, FEjercicio, AReader );
     nxReadVariant( VarFlags, FNroOrden, AReader );
     nxReadVariant( VarFlags, FNroProceso, AReader );
     nxReadVariant( VarFlags, FFecha, AReader );
     nxReadVariant( VarFlags, FTurno, AReader );
     nxReadVariant( VarFlags, FCorrectas, AReader );
     nxReadVariant( VarFlags, FDefectuosas, AReader );
     nxReadVariant( VarFlags, FMermaExceso, AReader );
     nxReadVariant( VarFlags, FIncorpExtraidas, AReader );
     nxReadVariant( VarFlags, FCodigoDefecto, AReader );
     nxReadVariant( VarFlags, FIncExtClaseA, AReader );
     nxReadVariant( VarFlags, FIncExtClaseB, AReader );
     nxReadVariant( VarFlags, FIncExtClaseC, AReader );
     nxReadVariant( VarFlags, FHoraInicio, AReader );
     nxReadVariant( VarFlags, FHoraFinalizacion, AReader );
     nxReadVariant( VarFlags, FPreparacion, AReader );
     nxReadVariant( VarFlags, FFabricacion, AReader );
     nxReadVariant( VarFlags, FCodigoIncidencia, AReader );
     nxReadVariant( VarFlags, FObservaciones, AReader );

     Result := S_OK;
end;

function TInformeFabricacion.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     nxWriteVariant( FRemoteCursorID, AWriter );
     nxWriteVariant( FState, AWriter );

     nxWriteVariant( FEjercicio, AWriter );
     nxWriteVariant( FNroOrden, AWriter );
     nxWriteVariant( FNroProceso, AWriter );
     nxWriteVariant( FFecha, AWriter );
     nxWriteVariant( FTurno, AWriter );
     nxWriteVariant( FCorrectas, AWriter );
     nxWriteVariant( FDefectuosas, AWriter );
     nxWriteVariant( FMermaExceso, AWriter );
     nxWriteVariant( FIncorpExtraidas, AWriter );
     nxWriteVariant( FCodigoDefecto, AWriter );
     nxWriteVariant( FIncExtClaseA, AWriter );
     nxWriteVariant( FIncExtClaseB, AWriter );
     nxWriteVariant( FIncExtClaseC, AWriter );
     nxWriteVariant( FHoraInicio, AWriter );
     nxWriteVariant( FHoraFinalizacion, AWriter );
     nxWriteVariant( FPreparacion, AWriter );
     nxWriteVariant( FFabricacion, AWriter );
     nxWriteVariant( FCodigoIncidencia, AWriter );
     nxWriteVariant( FObservaciones, AWriter );
     Result := S_OK;
end;

{ Getters}

function TInformeFabricacion.GetClassID: TnxGuid;
begin
     Result := CLSID_InformeFabricacion;
end;

function TInformeFabricacion.GetRemoteCursorID: TnxCursorID;
begin
     Result := FRemoteCursorID;
end;

function TInformeFabricacion.GetState: TDataSetState;
begin
     Result := FState;
end;


function TInformeFabricacion.GetEjercicio : Variant;
begin
     Result := FEjercicio;
end;

function TInformeFabricacion.GetNroOrden : Variant;
begin
     Result := FNroOrden;
end;

function TInformeFabricacion.GetNroProceso : Variant;
begin
     Result := FNroProceso;
end;

function TInformeFabricacion.GetFecha : Variant;
begin
     Result := FFecha;
end;

function TInformeFabricacion.GetTurno : Variant;
begin
     Result := FTurno;
end;

function TInformeFabricacion.GetCorrectas : Variant;
begin
     Result := FCorrectas;
end;

function TInformeFabricacion.GetDefectuosas : Variant;
begin
     Result := FDefectuosas;
end;

function TInformeFabricacion.GetMermaExceso : Variant;
begin
     Result := FMermaExceso;
end;

function TInformeFabricacion.GetIncorpExtraidas : Variant;
begin
     Result := FIncorpExtraidas;
end;

function TInformeFabricacion.GetCodigoDefecto : Variant;
begin
     Result := FCodigoDefecto;
end;

function TInformeFabricacion.GetIncExtClaseA : Variant;
begin
     Result := FIncExtClaseA;
end;

function TInformeFabricacion.GetIncExtClaseB : Variant;
begin
     Result := FIncExtClaseB;
end;

function TInformeFabricacion.GetIncExtClaseC : Variant;
begin
     Result := FIncExtClaseC;
end;

function TInformeFabricacion.GetHoraInicio : Variant;
begin
     Result := FHoraInicio;
end;

function TInformeFabricacion.GetHoraFinalizacion : Variant;
begin
     Result := FHoraFinalizacion;
end;

function TInformeFabricacion.GetPreparacion : Variant;
begin
     Result := FPreparacion;
end;

function TInformeFabricacion.GetFabricacion : Variant;
begin
     Result := FFabricacion;
end;

function TInformeFabricacion.GetCodigoIncidencia : Variant;
begin
     Result := FCodigoIncidencia;
end;

function TInformeFabricacion.GetObservaciones : Variant;
begin
     Result := FObservaciones;
end;

{ Setters}

procedure TInformeFabricacion.SetRemoteCursorID( const Value : TnxCursorID );
begin
     FRemoteCursorID := Value;
end;

procedure TInformeFabricacion.SetState( const Value : TDataSetState );
begin
     FState := Value;
end;


procedure TInformeFabricacion.SetEjercicio(  const Value : Variant );
begin
     FEjercicio := Value;
end;

procedure TInformeFabricacion.SetNroOrden(  const Value : Variant );
begin
     FNroOrden := Value;
end;

procedure TInformeFabricacion.SetNroProceso(  const Value : Variant );
begin
     FNroProceso := Value;
end;

procedure TInformeFabricacion.SetFecha(  const Value : Variant );
begin
     FFecha := Value;
end;

procedure TInformeFabricacion.SetTurno(  const Value : Variant );
begin
     FTurno := Value;
end;

procedure TInformeFabricacion.SetCorrectas(  const Value : Variant );
begin
     FCorrectas := Value;
end;

procedure TInformeFabricacion.SetDefectuosas(  const Value : Variant );
begin
     FDefectuosas := Value;
end;

procedure TInformeFabricacion.SetMermaExceso(  const Value : Variant );
begin
     FMermaExceso := Value;
end;

procedure TInformeFabricacion.SetIncorpExtraidas(  const Value : Variant );
begin
     FIncorpExtraidas := Value;
end;

procedure TInformeFabricacion.SetCodigoDefecto(  const Value : Variant );
begin
     FCodigoDefecto := Value;
end;

procedure TInformeFabricacion.SetIncExtClaseA(  const Value : Variant );
begin
     FIncExtClaseA := Value;
end;

procedure TInformeFabricacion.SetIncExtClaseB(  const Value : Variant );
begin
     FIncExtClaseB := Value;
end;

procedure TInformeFabricacion.SetIncExtClaseC(  const Value : Variant );
begin
     FIncExtClaseC := Value;
end;

procedure TInformeFabricacion.SetHoraInicio(  const Value : Variant );
begin
     FHoraInicio := Value;
end;

procedure TInformeFabricacion.SetHoraFinalizacion(  const Value : Variant );
begin
     FHoraFinalizacion := Value;
end;

procedure TInformeFabricacion.SetPreparacion(  const Value : Variant );
begin
     FPreparacion := Value;
end;

procedure TInformeFabricacion.SetFabricacion(  const Value : Variant );
begin
     FFabricacion := Value;
end;

procedure TInformeFabricacion.SetCodigoIncidencia(  const Value : Variant );
begin
     FCodigoIncidencia := Value;
end;

procedure TInformeFabricacion.SetObservaciones(  const Value : Variant );
begin
     FObservaciones := Value;
end;

var InformeFabricacionControl : InxClassFactoryControl;

initialization
   nxInvokeRegistry.RegisterInterface( TypeInfo( IInformeFabricacion ) );

   TnxClassFactory.RegisterClass( CLSID_InformeFabricacion, TInformeFabricacion, InformeFabricacionControl );

end.
