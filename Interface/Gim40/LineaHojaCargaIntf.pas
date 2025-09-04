{$ALIGN OFF}
{$OPTIMIZATION OFF}

unit LineaHojaCargaIntf;

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
  CLSID_LineaHojaCarga : TnxGuid = '{1038C275-0D6E-4F16-B123-10BA7794AD6E}';

type

  ILineaHojaCarga = interface( IInvokableRecord )
    [ '{CC9A9F69-57BC-4ECA-AF8A-00CE817D1772}' ] 

    procedure ToDataset( LineaHojaCargaFields : TLineaHojaCargaFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
    function GetRemoteCursorID : TnxCursorID;
    procedure SetRemoteCursorID( const Value : TnxCursorID );
    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );

    // Los campos que forman parte de un índice es conveniente que no sean Variants.
    // El resto, sin embargo, pueden ser valores nulos, o el campo no estar definido en el dataset.

    function GetEjercicio : SmallInt;
    function GetNroHoja : Integer;
    function GetNroLinea : SmallInt;
    function GetEjercicioOrigen : Variant;
    function GetNroOperacionOrigen : Variant;
    function GetNroRegistroOrigen : Variant;
    function GetCodigoAlmacen : Variant;
    function GetUbicacion : Variant;
    function GetNroCajas : Variant;
    function GetCargado : Variant;
    function GetEjercicioDestino : Variant;
    function GetNroOperacionDestino : Variant;
    function GetNroRegistroDestino : Variant;
    function GetAnotacion : Variant;

    procedure SetEjercicio( const Value  : SmallInt );
    procedure SetNroHoja( const Value  : Integer );
    procedure SetNroLinea( const Value  : SmallInt );
    procedure SetEjercicioOrigen( const Value  : Variant );
    procedure SetNroOperacionOrigen( const Value  : Variant );
    procedure SetNroRegistroOrigen( const Value  : Variant );
    procedure SetCodigoAlmacen( const Value  : Variant );
    procedure SetUbicacion( const Value  : Variant );
    procedure SetNroCajas( const Value  : Variant );
    procedure SetCargado( const Value  : Variant );
    procedure SetEjercicioDestino( const Value  : Variant );
    procedure SetNroOperacionDestino( const Value  : Variant );
    procedure SetNroRegistroDestino( const Value  : Variant );
    procedure SetAnotacion( const Value  : Variant );
    property RemoteCursorID : TnxCursorID read GetRemoteCursorID write SetRemoteCursorID;
    property State : TDatasetState read GetState write SetState;

    property Ejercicio : SmallInt read GetEjercicio write SetEjercicio;
    property NroHoja : Integer read GetNroHoja write SetNroHoja;
    property NroLinea : SmallInt read GetNroLinea write SetNroLinea;
    property EjercicioOrigen : Variant read GetEjercicioOrigen write SetEjercicioOrigen;
    property NroOperacionOrigen : Variant read GetNroOperacionOrigen write SetNroOperacionOrigen;
    property NroRegistroOrigen : Variant read GetNroRegistroOrigen write SetNroRegistroOrigen;
    property CodigoAlmacen : Variant read GetCodigoAlmacen write SetCodigoAlmacen;
    property Ubicacion : Variant read GetUbicacion write SetUbicacion;
    property NroCajas : Variant read GetNroCajas write SetNroCajas;
    property Cargado : Variant read GetCargado write SetCargado;
    property EjercicioDestino : Variant read GetEjercicioDestino write SetEjercicioDestino;
    property NroOperacionDestino : Variant read GetNroOperacionDestino write SetNroOperacionDestino;
    property NroRegistroDestino : Variant read GetNroRegistroDestino write SetNroRegistroDestino;
    property Anotacion : Variant read GetAnotacion write SetAnotacion;

    end;

   TLineaHojaCarga = class( TnxClass, InxRemoteableClass, ILineaHojaCarga)
     private

     FRemoteCursorID,
     FState : Variant;

     FEjercicio,
     FNroHoja,
     FNroLinea,
     FEjercicioOrigen,
     FNroOperacionOrigen,
     FNroRegistroOrigen,
     FCodigoAlmacen,
     FUbicacion,
     FNroCajas,
     FCargado,
     FEjercicioDestino,
     FNroOperacionDestino,
     FNroRegistroDestino,
     FAnotacion : Variant;

     function GetEjercicio : SmallInt;
     function GetNroHoja : Integer;
     function GetNroLinea : SmallInt;
     function GetEjercicioOrigen : Variant;
     function GetNroOperacionOrigen : Variant;
     function GetNroRegistroOrigen : Variant;
     function GetCodigoAlmacen : Variant;
     function GetUbicacion : Variant;
     function GetNroCajas : Variant;
     function GetCargado : Variant;
     function GetEjercicioDestino : Variant;
     function GetNroOperacionDestino : Variant;
     function GetNroRegistroDestino : Variant;
     function GetAnotacion : Variant;

     procedure SetEjercicio( const Value  : SmallInt );
     procedure SetNroHoja( const Value  : Integer );
     procedure SetNroLinea( const Value  : SmallInt );
     procedure SetEjercicioOrigen( const Value  : Variant );
     procedure SetNroOperacionOrigen( const Value  : Variant );
     procedure SetNroRegistroOrigen( const Value  : Variant );
     procedure SetCodigoAlmacen( const Value  : Variant );
     procedure SetUbicacion( const Value  : Variant );
     procedure SetNroCajas( const Value  : Variant );
     procedure SetCargado( const Value  : Variant );
     procedure SetEjercicioDestino( const Value  : Variant );
     procedure SetNroOperacionDestino( const Value  : Variant );
     procedure SetNroRegistroDestino( const Value  : Variant );
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

     class function FromDataset( LineaHojaCargaFields  : TLineaHojaCargaFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : ILineaHojaCarga;
     procedure ToDataset( LineaHojaCargaFields : TLineaHojaCargaFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );

     end;

implementation

uses  Variants;

{ TLineaHojaCarga }

constructor TLineaHojaCarga.Create;
begin
     inherited Create( @CLSID_LineaHojaCarga, nil, nil, False);
     FState := dsInsert;
end;

class function TLineaHojaCarga.FromDataset( LineaHojaCargaFields : TLineaHojaCargaFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : ILineaHojaCarga;

var   SaveState : TDataSetState;
      ApplyOldValues : Boolean;

begin
      Result := TLineaHojaCarga.Create;

      With Result do
        begin

        RemoteCursorID := LineaHojaCargaFields.GetRemoteCursorID;
        State := LineaHojaCargaFields.Dataset.State;
        SaveState := State;

        ApplyOldValues := OldValues and not ( State in [ dsInsert, dsSetKey ] );
        If   ApplyOldValues
        then LineaHojaCargaFields.IDataset.SetTempState( dsOldValue );

        try

          Ejercicio := GetFieldAsVariant( LineaHojaCargaFields.Ejercicio );
          NroHoja := GetFieldAsVariant( LineaHojaCargaFields.NroHoja );
          NroLinea := GetFieldAsVariant( LineaHojaCargaFields.NroLinea );
          EjercicioOrigen := GetFieldAsVariant( LineaHojaCargaFields.EjercicioOrigen );
          NroOperacionOrigen := GetFieldAsVariant( LineaHojaCargaFields.NroOperacionOrigen );
          NroRegistroOrigen := GetFieldAsVariant( LineaHojaCargaFields.NroRegistroOrigen );
          CodigoAlmacen := GetFieldAsVariant( LineaHojaCargaFields.CodigoAlmacen );
          Ubicacion := GetFieldAsVariant( LineaHojaCargaFields.Ubicacion );
          NroCajas := GetFieldAsVariant( LineaHojaCargaFields.NroCajas );
          Cargado := GetFieldAsVariant( LineaHojaCargaFields.Cargado );
          EjercicioDestino := GetFieldAsVariant( LineaHojaCargaFields.EjercicioDestino );
          NroOperacionDestino := GetFieldAsVariant( LineaHojaCargaFields.NroOperacionDestino );
          NroRegistroDestino := GetFieldAsVariant( LineaHojaCargaFields.NroRegistroDestino );

          If   ReadBlobs
          then Anotacion := GetFieldAsVariant( LineaHojaCargaFields.Anotacion )
          else Anotacion := '';

        finally
          If   ApplyOldValues
          then LineaHojaCargaFields.IDataset.RestoreState( SaveState );
        end;
      end;

end;

procedure TLineaHojaCarga.ToDataset( LineaHojaCargaFields : TLineaHojaCargaFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
begin
     try

       If   not PreserveState
       then LineaHojaCargaFields.SetStateFromInterface( FState );

       LineaHojaCargaFields.Ejercicio.Value := FEjercicio;
       LineaHojaCargaFields.NroHoja.Value := FNroHoja;
       LineaHojaCargaFields.NroLinea.Value := FNroLinea;

       SetFieldAsVariant( LineaHojaCargaFields.EjercicioOrigen, FEjercicioOrigen );
       SetFieldAsVariant( LineaHojaCargaFields.NroOperacionOrigen, FNroOperacionOrigen );
       SetFieldAsVariant( LineaHojaCargaFields.NroRegistroOrigen, FNroRegistroOrigen );
       SetFieldAsVariant( LineaHojaCargaFields.CodigoAlmacen, FCodigoAlmacen );
       SetFieldAsVariant( LineaHojaCargaFields.Ubicacion, FUbicacion );
       SetFieldAsVariant( LineaHojaCargaFields.NroCajas, FNroCajas );
       SetFieldAsVariant( LineaHojaCargaFields.Cargado, FCargado );
       SetFieldAsVariant( LineaHojaCargaFields.EjercicioDestino, FEjercicioDestino );
       SetFieldAsVariant( LineaHojaCargaFields.NroOperacionDestino, FNroOperacionDestino );
       SetFieldAsVariant( LineaHojaCargaFields.NroRegistroDestino, FNroRegistroDestino );

       If   ReadBlobs
       then SetFieldAsVariant( LineaHojaCargaFields.Anotacion, FAnotacion )
       else LineaHojaCargaFields.Anotacion.Clear;


     except
       LineaHojaCargaFields.Dataset.Cancel;
       raise;
       end;

end;

function TLineaHojaCarga.LoadFromReader( AReader : InxReader ) : HRESULT;

var VarFlags : TnxVarFlags;

begin
     nxReadVariant( VarFlags, FRemoteCursorID, AReader );
     nxReadVariant( VarFlags, FState, AReader );

     nxReadVariant( VarFlags, FEjercicio, AReader );
     nxReadVariant( VarFlags, FNroHoja, AReader );
     nxReadVariant( VarFlags, FNroLinea, AReader );
     nxReadVariant( VarFlags, FEjercicioOrigen, AReader );
     nxReadVariant( VarFlags, FNroOperacionOrigen, AReader );
     nxReadVariant( VarFlags, FNroRegistroOrigen, AReader );
     nxReadVariant( VarFlags, FCodigoAlmacen, AReader );
     nxReadVariant( VarFlags, FUbicacion, AReader );
     nxReadVariant( VarFlags, FNroCajas, AReader );
     nxReadVariant( VarFlags, FCargado, AReader );
     nxReadVariant( VarFlags, FEjercicioDestino, AReader );
     nxReadVariant( VarFlags, FNroOperacionDestino, AReader );
     nxReadVariant( VarFlags, FNroRegistroDestino, AReader );
     nxReadVariant( VarFlags, FAnotacion, AReader );

     Result := S_OK;
end;

function TLineaHojaCarga.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     nxWriteVariant( FRemoteCursorID, AWriter );
     nxWriteVariant( FState, AWriter );

     nxWriteVariant( FEjercicio, AWriter );
     nxWriteVariant( FNroHoja, AWriter );
     nxWriteVariant( FNroLinea, AWriter );
     nxWriteVariant( FEjercicioOrigen, AWriter );
     nxWriteVariant( FNroOperacionOrigen, AWriter );
     nxWriteVariant( FNroRegistroOrigen, AWriter );
     nxWriteVariant( FCodigoAlmacen, AWriter );
     nxWriteVariant( FUbicacion, AWriter );
     nxWriteVariant( FNroCajas, AWriter );
     nxWriteVariant( FCargado, AWriter );
     nxWriteVariant( FEjercicioDestino, AWriter );
     nxWriteVariant( FNroOperacionDestino, AWriter );
     nxWriteVariant( FNroRegistroDestino, AWriter );
     nxWriteVariant( FAnotacion, AWriter );
     Result := S_OK;
end;

{ Getters}

function TLineaHojaCarga.GetClassID: TnxGuid;
begin
     Result := CLSID_LineaHojaCarga;
end;

function TLineaHojaCarga.GetRemoteCursorID: TnxCursorID;
begin
     Result := FRemoteCursorID;
end;

function TLineaHojaCarga.GetState: TDataSetState;
begin
     Result := FState;
end;


function TLineaHojaCarga.GetEjercicio : SmallInt;
begin
     Result := FEjercicio;
end;

function TLineaHojaCarga.GetNroHoja : Integer;
begin
     Result := FNroHoja;
end;

function TLineaHojaCarga.GetNroLinea : SmallInt;
begin
     Result := FNroLinea;
end;

function TLineaHojaCarga.GetEjercicioOrigen : Variant;
begin
     Result := FEjercicioOrigen;
end;

function TLineaHojaCarga.GetNroOperacionOrigen : Variant;
begin
     Result := FNroOperacionOrigen;
end;

function TLineaHojaCarga.GetNroRegistroOrigen : Variant;
begin
     Result := FNroRegistroOrigen;
end;

function TLineaHojaCarga.GetCodigoAlmacen : Variant;
begin
     Result := FCodigoAlmacen;
end;

function TLineaHojaCarga.GetUbicacion : Variant;
begin
     Result := FUbicacion;
end;

function TLineaHojaCarga.GetNroCajas : Variant;
begin
     Result := FNroCajas;
end;

function TLineaHojaCarga.GetCargado : Variant;
begin
     Result := FCargado;
end;

function TLineaHojaCarga.GetEjercicioDestino : Variant;
begin
     Result := FEjercicioDestino;
end;

function TLineaHojaCarga.GetNroOperacionDestino : Variant;
begin
     Result := FNroOperacionDestino;
end;

function TLineaHojaCarga.GetNroRegistroDestino : Variant;
begin
     Result := FNroRegistroDestino;
end;

function TLineaHojaCarga.GetAnotacion : Variant;
begin
     Result := FAnotacion;
end;

{ Setters}

procedure TLineaHojaCarga.SetRemoteCursorID( const Value : TnxCursorID );
begin
     FRemoteCursorID := Value;
end;

procedure TLineaHojaCarga.SetState( const Value : TDataSetState );
begin
     FState := Value;
end;


procedure TLineaHojaCarga.SetEjercicio(  const Value : SmallInt );
begin
     FEjercicio := Value;
end;

procedure TLineaHojaCarga.SetNroHoja(  const Value : Integer );
begin
     FNroHoja := Value;
end;

procedure TLineaHojaCarga.SetNroLinea(  const Value : SmallInt );
begin
     FNroLinea := Value;
end;

procedure TLineaHojaCarga.SetEjercicioOrigen(  const Value : Variant );
begin
     FEjercicioOrigen := Value;
end;

procedure TLineaHojaCarga.SetNroOperacionOrigen(  const Value : Variant );
begin
     FNroOperacionOrigen := Value;
end;

procedure TLineaHojaCarga.SetNroRegistroOrigen(  const Value : Variant );
begin
     FNroRegistroOrigen := Value;
end;

procedure TLineaHojaCarga.SetCodigoAlmacen(  const Value : Variant );
begin
     FCodigoAlmacen := Value;
end;

procedure TLineaHojaCarga.SetUbicacion(  const Value : Variant );
begin
     FUbicacion := Value;
end;

procedure TLineaHojaCarga.SetNroCajas(  const Value : Variant );
begin
     FNroCajas := Value;
end;

procedure TLineaHojaCarga.SetCargado(  const Value : Variant );
begin
     FCargado := Value;
end;

procedure TLineaHojaCarga.SetEjercicioDestino(  const Value : Variant );
begin
     FEjercicioDestino := Value;
end;

procedure TLineaHojaCarga.SetNroOperacionDestino(  const Value : Variant );
begin
     FNroOperacionDestino := Value;
end;

procedure TLineaHojaCarga.SetNroRegistroDestino(  const Value : Variant );
begin
     FNroRegistroDestino := Value;
end;

procedure TLineaHojaCarga.SetAnotacion(  const Value : Variant );
begin
     FAnotacion := Value;
end;

var LineaHojaCargaControl : InxClassFactoryControl;

initialization
   nxInvokeRegistry.RegisterInterface( TypeInfo( ILineaHojaCarga ) );

   TnxClassFactory.RegisterClass( CLSID_LineaHojaCarga, TLineaHojaCarga, LineaHojaCargaControl );

end.
