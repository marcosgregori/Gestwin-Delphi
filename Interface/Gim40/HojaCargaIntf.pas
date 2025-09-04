{$ALIGN OFF}
{$OPTIMIZATION OFF}

unit HojaCargaIntf;

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

      Gim40Fields;

const
  CLSID_HojaCarga : TnxGuid = '{3B09696E-BFDA-4604-ADBB-8B1EF17AA151}';

type

  IHojaCarga = interface( IInvokableRecord )
    [ '{5CAFAF16-E182-4CA8-9678-E939802BA0E6}' ] 

    procedure ToDataset( HojaCargaFields : THojaCargaFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
    function GetRemoteCursorID : TnxCursorID;
    procedure SetRemoteCursorID( const Value : TnxCursorID );
    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );

    // Los campos que forman parte de un índice es conveniente que no sean Variants.
    // El resto, sin embargo, pueden ser valores nulos, o el campo no estar definido en el dataset.

    function GetEjercicio : SmallInt;
    function GetNroHoja : Integer;
    function GetFecha : Variant;
    function GetCodigoTransportista : Variant;
    function GetEjercicioReubicacion : Variant;
    function GetNroOperacionReubicacion : Variant;
    function GetNoProcesar : Variant;
    function GetProcesado : Variant;
    function GetAnotacion : Variant;

    procedure SetEjercicio( const Value  : SmallInt );
    procedure SetNroHoja( const Value  : Integer );
    procedure SetFecha( const Value  : Variant );
    procedure SetCodigoTransportista( const Value  : Variant );
    procedure SetEjercicioReubicacion( const Value  : Variant );
    procedure SetNroOperacionReubicacion( const Value  : Variant );
    procedure SetNoProcesar( const Value  : Variant );
    procedure SetProcesado( const Value  : Variant );
    procedure SetAnotacion( const Value  : Variant );
    property RemoteCursorID : TnxCursorID read GetRemoteCursorID write SetRemoteCursorID;
    property State : TDatasetState read GetState write SetState;

    property Ejercicio : SmallInt read GetEjercicio write SetEjercicio;
    property NroHoja : Integer read GetNroHoja write SetNroHoja;
    property Fecha : Variant read GetFecha write SetFecha;
    property CodigoTransportista : Variant read GetCodigoTransportista write SetCodigoTransportista;
    property EjercicioReubicacion : Variant read GetEjercicioReubicacion write SetEjercicioReubicacion;
    property NroOperacionReubicacion : Variant read GetNroOperacionReubicacion write SetNroOperacionReubicacion;
    property NoProcesar : Variant read GetNoProcesar write SetNoProcesar;
    property Procesado : Variant read GetProcesado write SetProcesado;
    property Anotacion : Variant read GetAnotacion write SetAnotacion;

    end;

   THojaCarga = class( TnxClass, InxRemoteableClass, IHojaCarga)
     private

     FRemoteCursorID,
     FState : Variant;

     FEjercicio,
     FNroHoja,
     FFecha,
     FCodigoTransportista,
     FEjercicioReubicacion,
     FNroOperacionReubicacion,
     FNoProcesar,
     FProcesado,
     FAnotacion : Variant;

     function GetEjercicio : SmallInt;
     function GetNroHoja : Integer;
     function GetFecha : Variant;
     function GetCodigoTransportista : Variant;
     function GetEjercicioReubicacion : Variant;
     function GetNroOperacionReubicacion : Variant;
     function GetNoProcesar : Variant;
     function GetProcesado : Variant;
     function GetAnotacion : Variant;

     procedure SetEjercicio( const Value  : SmallInt );
     procedure SetNroHoja( const Value  : Integer );
     procedure SetFecha( const Value  : Variant );
     procedure SetCodigoTransportista( const Value  : Variant );
     procedure SetEjercicioReubicacion( const Value  : Variant );
     procedure SetNroOperacionReubicacion( const Value  : Variant );
     procedure SetNoProcesar( const Value  : Variant );
     procedure SetProcesado( const Value  : Variant );
     procedure SetAnotacion( const Value  : Variant );

     function LoadFromReader( AReader : InxReader ) : HRESULT;
     function SaveToWriter( AWriter : InxWriter ) : HRESULT;

     function GetRemoteCursorID : TnxCursorID;
     procedure SetRemoteCursorID( const Value : TnxCursorID );
     function GetState : TDataSetState;
     procedure SetState( const Value : TDataSetState );
     function GetClassID : TnxGuid;

     public

     constructor Create; reintroduce;

     class function FromDataset( HojaCargaFields  : THojaCargaFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IHojaCarga;
     procedure ToDataset( HojaCargaFields : THojaCargaFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );

     end;

implementation

uses  Variants;

{ THojaCarga }

constructor THojaCarga.Create;
begin
     inherited Create( @CLSID_HojaCarga, nil, nil, False);
     FState := dsInsert;
end;

class function THojaCarga.FromDataset( HojaCargaFields : THojaCargaFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IHojaCarga;

var   SaveState : TDataSetState;
      ApplyOldValues : Boolean;

begin
      Result := THojaCarga.Create;

      With Result do
        begin

        RemoteCursorID := HojaCargaFields.GetRemoteCursorID;
        State := HojaCargaFields.Dataset.State;
        SaveState := State;

        ApplyOldValues := OldValues and not ( State in [ dsInsert, dsSetKey ] );
        If   ApplyOldValues
        then HojaCargaFields.IDataset.SetTempState( dsOldValue );

        try

          Ejercicio := GetFieldAsVariant( HojaCargaFields.Ejercicio );
          NroHoja := GetFieldAsVariant( HojaCargaFields.NroHoja );
          Fecha := GetFieldAsVariant( HojaCargaFields.Fecha );
          CodigoTransportista := GetFieldAsVariant( HojaCargaFields.CodigoTransportista );
          EjercicioReubicacion := GetFieldAsVariant( HojaCargaFields.EjercicioReubicacion );
          NroOperacionReubicacion := GetFieldAsVariant( HojaCargaFields.NroOperacionReubicacion );
          NoProcesar := GetFieldAsVariant( HojaCargaFields.NoProcesar );
          Procesado := GetFieldAsVariant( HojaCargaFields.Procesado );

          If   ReadBlobs
          then Anotacion := GetFieldAsVariant( HojaCargaFields.Anotacion )
          else Anotacion := '';


        finally
          If   ApplyOldValues
          then HojaCargaFields.IDataset.RestoreState( SaveState );
        end;
      end;

end;

procedure THojaCarga.ToDataset( HojaCargaFields : THojaCargaFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
begin
     try

       If   not PreserveState
       then HojaCargaFields.SetStateFromInterface( FState );

       HojaCargaFields.Ejercicio.Value := FEjercicio;
       HojaCargaFields.NroHoja.Value := FNroHoja;

       SetFieldAsVariant( HojaCargaFields.Fecha, FFecha );
       SetFieldAsVariant( HojaCargaFields.CodigoTransportista, FCodigoTransportista );
       SetFieldAsVariant( HojaCargaFields.EjercicioReubicacion, FEjercicioReubicacion );
       SetFieldAsVariant( HojaCargaFields.NroOperacionReubicacion, FNroOperacionReubicacion );
       SetFieldAsVariant( HojaCargaFields.NoProcesar, FNoProcesar );
       SetFieldAsVariant( HojaCargaFields.Procesado, FProcesado );

       If   ReadBlobs
       then SetFieldAsVariant( HojaCargaFields.Anotacion, FAnotacion )
       else HojaCargaFields.Anotacion.Clear;

     except
       HojaCargaFields.Dataset.Cancel;
       raise;
       end;

end;

function THojaCarga.LoadFromReader( AReader : InxReader ) : HRESULT;

var VarFlags : TnxVarFlags;

begin
     nxReadVariant( VarFlags, FRemoteCursorID, AReader );
     nxReadVariant( VarFlags, FState, AReader );

     nxReadVariant( VarFlags, FEjercicio, AReader );
     nxReadVariant( VarFlags, FNroHoja, AReader );
     nxReadVariant( VarFlags, FFecha, AReader );
     nxReadVariant( VarFlags, FCodigoTransportista, AReader );
     nxReadVariant( VarFlags, FEjercicioReubicacion, AReader );
     nxReadVariant( VarFlags, FNroOperacionReubicacion, AReader );
     nxReadVariant( VarFlags, FNoProcesar, AReader );
     nxReadVariant( VarFlags, FProcesado, AReader );
     nxReadVariant( VarFlags, FAnotacion, AReader );

     Result := S_OK;
end;

function THojaCarga.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     nxWriteVariant( FRemoteCursorID, AWriter );
     nxWriteVariant( FState, AWriter );

     nxWriteVariant( FEjercicio, AWriter );
     nxWriteVariant( FNroHoja, AWriter );
     nxWriteVariant( FFecha, AWriter );
     nxWriteVariant( FCodigoTransportista, AWriter );
     nxWriteVariant( FEjercicioReubicacion, AWriter );
     nxWriteVariant( FNroOperacionReubicacion, AWriter );
     nxWriteVariant( FNoProcesar, AWriter );
     nxWriteVariant( FProcesado, AWriter );
     nxWriteVariant( FAnotacion, AWriter );
     Result := S_OK;
end;

{ Getters}

function THojaCarga.GetClassID: TnxGuid;
begin
     Result := CLSID_HojaCarga;
end;

function THojaCarga.GetRemoteCursorID: TnxCursorID;
begin
     Result := FRemoteCursorID;
end;

function THojaCarga.GetState: TDataSetState;
begin
     Result := FState;
end;


function THojaCarga.GetEjercicio : SmallInt;
begin
     Result := FEjercicio;
end;

function THojaCarga.GetNroHoja : Integer;
begin
     Result := FNroHoja;
end;

function THojaCarga.GetFecha : Variant;
begin
     Result := FFecha;
end;

function THojaCarga.GetCodigoTransportista : Variant;
begin
     Result := FCodigoTransportista;
end;

function THojaCarga.GetEjercicioReubicacion : Variant;
begin
     Result := FEjercicioReubicacion;
end;

function THojaCarga.GetNroOperacionReubicacion : Variant;
begin
     Result := FNroOperacionReubicacion;
end;

function THojaCarga.GetNoProcesar : Variant;
begin
     Result := FNoProcesar;
end;

function THojaCarga.GetProcesado : Variant;
begin
     Result := FProcesado;
end;

function THojaCarga.GetAnotacion : Variant;
begin
     Result := FAnotacion;
end;

{ Setters}

procedure THojaCarga.SetRemoteCursorID( const Value : TnxCursorID );
begin
     FRemoteCursorID := Value;
end;

procedure THojaCarga.SetState( const Value : TDataSetState );
begin
     FState := Value;
end;


procedure THojaCarga.SetEjercicio(  const Value : SmallInt );
begin
     FEjercicio := Value;
end;

procedure THojaCarga.SetNroHoja(  const Value : Integer );
begin
     FNroHoja := Value;
end;

procedure THojaCarga.SetFecha(  const Value : Variant );
begin
     FFecha := Value;
end;

procedure THojaCarga.SetCodigoTransportista(  const Value : Variant );
begin
     FCodigoTransportista := Value;
end;

procedure THojaCarga.SetEjercicioReubicacion(  const Value : Variant );
begin
     FEjercicioReubicacion := Value;
end;

procedure THojaCarga.SetNroOperacionReubicacion(  const Value : Variant );
begin
     FNroOperacionReubicacion := Value;
end;

procedure THojaCarga.SetNoProcesar(  const Value : Variant );
begin
     FNoProcesar := Value;
end;

procedure THojaCarga.SetProcesado(  const Value : Variant );
begin
     FProcesado := Value;
end;

procedure THojaCarga.SetAnotacion(  const Value : Variant );
begin
     FAnotacion := Value;
end;

var HojaCargaControl : InxClassFactoryControl;

initialization
   nxInvokeRegistry.RegisterInterface( TypeInfo( IHojaCarga ) );

   TnxClassFactory.RegisterClass( CLSID_HojaCarga, THojaCarga, HojaCargaControl );

end.
