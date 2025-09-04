{$ALIGN OFF}
{$OPTIMIZATION OFF}

unit AsientoIntf;

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

      Gim10Fields;

const
  CLSID_Asiento : TnxGuid = '{E75B47C2-E099-4566-9052-5E93395A6ED9}';

type

  IAsiento = interface( IInvokableRecord )
    [ '{C9A3D92D-6588-42EF-BB32-84F966C09585}' ] 

    procedure ToDataset( AsientoFields : TAsientoFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
    function GetRemoteCursorID : TnxCursorID;
    procedure SetRemoteCursorID( const Value : TnxCursorID );
    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );

    // Los campos que forman parte de un índice es conveniente que no sean Variants.
    // El resto, sin embargo, pueden ser valores nulos, o el campo no estar definido en el dataset.

    function GetEjercicio : SmallInt;
    function GetNroAsiento : Integer;
    function GetFecha : Variant;
    function GetTipoAsiento : SmallInt;
    function GetSerie : Variant;
    function GetNroFactura : Variant;
    function GetNroEfecto : Variant;
    function GetFechaDocumento : Variant;
    function GetPropietario : Variant;
    function GetNroRegistro : Variant;
    function GetNombre : Variant;
    function GetOrigen : Variant;
    function GetCreado : Variant;
    function GetBloqueado : Variant;
    function GetMotivoBloqueo : Variant;
    function GetUsuario : Variant;
    function GetAnotacion : Variant;

    procedure SetEjercicio( const Value  : SmallInt );
    procedure SetNroAsiento( const Value  : Integer );
    procedure SetFecha( const Value  : Variant );
    procedure SetTipoAsiento( const Value  : SmallInt );
    procedure SetSerie( const Value  : Variant );
    procedure SetNroFactura( const Value  : Variant );
    procedure SetNroEfecto( const Value  : Variant );
    procedure SetFechaDocumento( const Value  : Variant );
    procedure SetPropietario( const Value  : Variant );
    procedure SetNroRegistro( const Value  : Variant );
    procedure SetNombre( const Value  : Variant );
    procedure SetOrigen( const Value  : Variant );
    procedure SetCreado( const Value  : Variant );
    procedure SetBloqueado( const Value  : Variant );
    procedure SetMotivoBloqueo( const Value  : Variant );
    procedure SetUsuario( const Value  : Variant );
    procedure SetAnotacion( const Value  : Variant );
    property RemoteCursorID : TnxCursorID read GetRemoteCursorID write SetRemoteCursorID;
    property State : TDatasetState read GetState write SetState;

    property Ejercicio : SmallInt read GetEjercicio write SetEjercicio;
    property NroAsiento : Integer read GetNroAsiento write SetNroAsiento;
    property Fecha : Variant read GetFecha write SetFecha;
    property TipoAsiento : SmallInt read GetTipoAsiento write SetTipoAsiento;
    property Serie : Variant read GetSerie write SetSerie;
    property NroFactura : Variant read GetNroFactura write SetNroFactura;
    property NroEfecto : Variant read GetNroEfecto write SetNroEfecto;
    property FechaDocumento : Variant read GetFechaDocumento write SetFechaDocumento;
    property Propietario : Variant read GetPropietario write SetPropietario;
    property NroRegistro : Variant read GetNroRegistro write SetNroRegistro;
    property Nombre : Variant read GetNombre write SetNombre;
    property Origen : Variant read GetOrigen write SetOrigen;
    property Creado : Variant read GetCreado write SetCreado;
    property Bloqueado : Variant read GetBloqueado write SetBloqueado;
    property MotivoBloqueo : Variant read GetMotivoBloqueo write SetMotivoBloqueo;
    property Usuario : Variant read GetUsuario write SetUsuario;
    property Anotacion : Variant read GetAnotacion write SetAnotacion;

    end;

   TAsiento = class( TnxClass, InxRemoteableClass, IAsiento)
     private

     FRemoteCursorID,
     FState : Variant;

     FEjercicio,
     FNroAsiento,
     FFecha,
     FTipoAsiento,
     FSerie,
     FNroFactura,
     FNroEfecto,
     FFechaDocumento,
     FPropietario,
     FNroRegistro,
     FNombre,
     FOrigen,
     FCreado,
     FBloqueado,
     FMotivoBloqueo,
     FUsuario,
     FAnotacion : Variant;

     function GetEjercicio : SmallInt;
     function GetNroAsiento : Integer;
     function GetFecha : Variant;
     function GetTipoAsiento : SmallInt;
     function GetSerie : Variant;
     function GetNroFactura : Variant;
     function GetNroEfecto : Variant;
     function GetFechaDocumento : Variant;
     function GetPropietario : Variant;
     function GetNroRegistro : Variant;
     function GetNombre : Variant;
     function GetOrigen : Variant;
     function GetCreado : Variant;
     function GetBloqueado : Variant;
     function GetMotivoBloqueo : Variant;
     function GetUsuario : Variant;
     function GetAnotacion : Variant;

     procedure SetEjercicio( const Value  : SmallInt );
     procedure SetNroAsiento( const Value  : Integer );
     procedure SetFecha( const Value  : Variant );
     procedure SetTipoAsiento( const Value  : SmallInt );
     procedure SetSerie( const Value  : Variant );
     procedure SetNroFactura( const Value  : Variant );
     procedure SetNroEfecto( const Value  : Variant );
     procedure SetFechaDocumento( const Value  : Variant );
     procedure SetPropietario( const Value  : Variant );
     procedure SetNroRegistro( const Value  : Variant );
     procedure SetNombre( const Value  : Variant );
     procedure SetOrigen( const Value  : Variant );
     procedure SetCreado( const Value  : Variant );
     procedure SetBloqueado( const Value  : Variant );
     procedure SetMotivoBloqueo( const Value  : Variant );
     procedure SetUsuario( const Value  : Variant );
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

     class function FromDataset( AsientoFields  : TAsientoFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IAsiento;
     procedure ToDataset( AsientoFields : TAsientoFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );

     end;

implementation

uses  Variants;

{ TAsiento }

constructor TAsiento.Create;
begin
     inherited Create( @CLSID_Asiento, nil, nil, False);
     FState := dsInsert;
end;

class function TAsiento.FromDataset( AsientoFields : TAsientoFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IAsiento;

var   SaveState : TDataSetState;
      ApplyOldValues : Boolean;

begin
      Result := TAsiento.Create;

      With Result do
        begin

        RemoteCursorID := AsientoFields.GetRemoteCursorID;
        State := AsientoFields.Dataset.State;
        SaveState := State;

        ApplyOldValues := OldValues and not ( State in [ dsInsert, dsSetKey ] );
        If   ApplyOldValues
        then AsientoFields.IDataset.SetTempState( dsOldValue );

        try

          Ejercicio := GetFieldAsVariant( AsientoFields.Ejercicio );
          NroAsiento := GetFieldAsVariant( AsientoFields.NroAsiento );
          Fecha := GetFieldAsVariant( AsientoFields.Fecha );
          TipoAsiento := GetFieldAsVariant( AsientoFields.TipoAsiento );
          Serie := GetFieldAsVariant( AsientoFields.Serie );
          NroFactura := GetFieldAsVariant( AsientoFields.NroFactura );
          NroEfecto := GetFieldAsVariant( AsientoFields.NroEfecto );
          FechaDocumento := GetFieldAsVariant( AsientoFields.FechaDocumento );
          Propietario := GetFieldAsVariant( AsientoFields.Propietario );
          NroRegistro := GetFieldAsVariant( AsientoFields.NroRegistro );
          Nombre := GetFieldAsVariant( AsientoFields.Nombre );
          Origen := GetFieldAsVariant( AsientoFields.Origen );
          Creado := GetFieldAsVariant( AsientoFields.Creado );
          Bloqueado := GetFieldAsVariant( AsientoFields.Bloqueado );
          Usuario := GetFieldAsVariant( AsientoFields.Usuario );

          If   ReadBlobs
          then begin
               MotivoBloqueo := GetFieldAsVariant( AsientoFields.MotivoBloqueo );
               Anotacion := GetFieldAsVariant( AsientoFields.Anotacion );
               end
          else begin
               MotivoBloqueo := '';
               Anotacion := '';
               end;

        finally
          If   ApplyOldValues
          then AsientoFields.IDataset.RestoreState( SaveState );
        end;
      end;

end;

procedure TAsiento.ToDataset( AsientoFields : TAsientoFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
begin
     try

       If   not PreserveState
       then AsientoFields.SetStateFromInterface( FState );

       AsientoFields.Ejercicio.Value := FEjercicio;
       AsientoFields.NroAsiento.Value := FNroAsiento;

       SetFieldAsVariant( AsientoFields.Fecha, FFecha );
       SetFieldAsVariant( AsientoFields.TipoAsiento, FTipoAsiento );
       SetFieldAsVariant( AsientoFields.Serie, FSerie );
       SetFieldAsVariant( AsientoFields.NroFactura, FNroFactura );
       SetFieldAsVariant( AsientoFields.NroEfecto, FNroEfecto );
       SetFieldAsVariant( AsientoFields.FechaDocumento, FFechaDocumento );
       SetFieldAsVariant( AsientoFields.Propietario, FPropietario );
       SetFieldAsVariant( AsientoFields.NroRegistro, FNroRegistro );
       SetFieldAsVariant( AsientoFields.Nombre, FNombre );
       SetFieldAsVariant( AsientoFields.Origen, FOrigen );
       SetFieldAsVariant( AsientoFields.Creado, FCreado );
       SetFieldAsVariant( AsientoFields.Bloqueado, FBloqueado );
       SetFieldAsVariant( AsientoFields.Usuario, FUsuario );

       If   ReadBlobs
       then begin
            SetFieldAsVariant( AsientoFields.MotivoBloqueo, FMotivoBloqueo );
            SetFieldAsVariant( AsientoFields.Anotacion, FAnotacion );
            end
       else begin
            AsientoFields.MotivoBloqueo.Clear;
            AsientoFields.Anotacion.Clear;
            end;;

     except
       AsientoFields.Dataset.Cancel;
       raise;
       end;

end;

function TAsiento.LoadFromReader( AReader : InxReader ) : HRESULT;

var VarFlags : TnxVarFlags;

begin
     nxReadVariant( VarFlags, FRemoteCursorID, AReader );
     nxReadVariant( VarFlags, FState, AReader );

     nxReadVariant( VarFlags, FEjercicio, AReader );
     nxReadVariant( VarFlags, FNroAsiento, AReader );
     nxReadVariant( VarFlags, FFecha, AReader );
     nxReadVariant( VarFlags, FTipoAsiento, AReader );
     nxReadVariant( VarFlags, FSerie, AReader );
     nxReadVariant( VarFlags, FNroFactura, AReader );
     nxReadVariant( VarFlags, FNroEfecto, AReader );
     nxReadVariant( VarFlags, FFechaDocumento, AReader );
     nxReadVariant( VarFlags, FPropietario, AReader );
     nxReadVariant( VarFlags, FNroRegistro, AReader );
     nxReadVariant( VarFlags, FNombre, AReader );
     nxReadVariant( VarFlags, FOrigen, AReader );
     nxReadVariant( VarFlags, FCreado, AReader );
     nxReadVariant( VarFlags, FBloqueado, AReader );
     nxReadVariant( VarFlags, FMotivoBloqueo, AReader );
     nxReadVariant( VarFlags, FUsuario, AReader );
     nxReadVariant( VarFlags, FAnotacion, AReader );

     Result := S_OK;
end;

function TAsiento.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     nxWriteVariant( FRemoteCursorID, AWriter );
     nxWriteVariant( FState, AWriter );

     nxWriteVariant( FEjercicio, AWriter );
     nxWriteVariant( FNroAsiento, AWriter );
     nxWriteVariant( FFecha, AWriter );
     nxWriteVariant( FTipoAsiento, AWriter );
     nxWriteVariant( FSerie, AWriter );
     nxWriteVariant( FNroFactura, AWriter );
     nxWriteVariant( FNroEfecto, AWriter );
     nxWriteVariant( FFechaDocumento, AWriter );
     nxWriteVariant( FPropietario, AWriter );
     nxWriteVariant( FNroRegistro, AWriter );
     nxWriteVariant( FNombre, AWriter );
     nxWriteVariant( FOrigen, AWriter );
     nxWriteVariant( FCreado, AWriter );
     nxWriteVariant( FBloqueado, AWriter );
     nxWriteVariant( FMotivoBloqueo, AWriter );
     nxWriteVariant( FUsuario, AWriter );
     nxWriteVariant( FAnotacion, AWriter );
     Result := S_OK;
end;

{ Getters}

function TAsiento.GetClassID: TnxGuid;
begin
     Result := CLSID_Asiento;
end;

function TAsiento.GetRemoteCursorID: TnxCursorID;
begin
     Result := FRemoteCursorID;
end;

function TAsiento.GetState: TDataSetState;
begin
     Result := FState;
end;


function TAsiento.GetEjercicio : SmallInt;
begin
     Result := FEjercicio;
end;

function TAsiento.GetNroAsiento : Integer;
begin
     Result := FNroAsiento;
end;

function TAsiento.GetFecha : Variant;
begin
     Result := FFecha;
end;

function TAsiento.GetTipoAsiento : SmallInt;
begin
     Result := FTipoAsiento;
end;

function TAsiento.GetSerie : Variant;
begin
     Result := FSerie;
end;

function TAsiento.GetNroFactura : Variant;
begin
     Result := FNroFactura;
end;

function TAsiento.GetNroEfecto : Variant;
begin
     Result := FNroEfecto;
end;

function TAsiento.GetFechaDocumento : Variant;
begin
     Result := FFechaDocumento;
end;

function TAsiento.GetPropietario : Variant;
begin
     Result := FPropietario;
end;

function TAsiento.GetNroRegistro : Variant;
begin
     Result := FNroRegistro;
end;

function TAsiento.GetNombre : Variant;
begin
     Result := FNombre;
end;

function TAsiento.GetOrigen : Variant;
begin
     Result := FOrigen;
end;

function TAsiento.GetCreado : Variant;
begin
     Result := FCreado;
end;

function TAsiento.GetBloqueado : Variant;
begin
     Result := FBloqueado;
end;

function TAsiento.GetMotivoBloqueo : Variant;
begin
     Result := FMotivoBloqueo;
end;

function TAsiento.GetUsuario : Variant;
begin
     Result := FUsuario;
end;

function TAsiento.GetAnotacion : Variant;
begin
     Result := FAnotacion;
end;

{ Setters}

procedure TAsiento.SetRemoteCursorID( const Value : TnxCursorID );
begin
     FRemoteCursorID := Value;
end;

procedure TAsiento.SetState( const Value : TDataSetState );
begin
     FState := Value;
end;


procedure TAsiento.SetEjercicio(  const Value : SmallInt );
begin
     FEjercicio := Value;
end;

procedure TAsiento.SetNroAsiento(  const Value : Integer );
begin
     FNroAsiento := Value;
end;

procedure TAsiento.SetFecha(  const Value : Variant );
begin
     FFecha := Value;
end;

procedure TAsiento.SetTipoAsiento(  const Value : SmallInt );
begin
     FTipoAsiento := Value;
end;

procedure TAsiento.SetSerie(  const Value : Variant );
begin
     FSerie := Value;
end;

procedure TAsiento.SetNroFactura(  const Value : Variant );
begin
     FNroFactura := Value;
end;

procedure TAsiento.SetNroEfecto(  const Value : Variant );
begin
     FNroEfecto := Value;
end;

procedure TAsiento.SetFechaDocumento(  const Value : Variant );
begin
     FFechaDocumento := Value;
end;

procedure TAsiento.SetPropietario(  const Value : Variant );
begin
     FPropietario := Value;
end;

procedure TAsiento.SetNroRegistro(  const Value : Variant );
begin
     FNroRegistro := Value;
end;

procedure TAsiento.SetNombre(  const Value : Variant );
begin
     FNombre := Value;
end;

procedure TAsiento.SetOrigen(  const Value : Variant );
begin
     FOrigen := Value;
end;

procedure TAsiento.SetCreado(  const Value : Variant );
begin
     FCreado := Value;
end;

procedure TAsiento.SetBloqueado(  const Value : Variant );
begin
     FBloqueado := Value;
end;

procedure TAsiento.SetMotivoBloqueo(  const Value : Variant );
begin
     FMotivoBloqueo := Value;
end;

procedure TAsiento.SetUsuario(  const Value : Variant );
begin
     FUsuario := Value;
end;

procedure TAsiento.SetAnotacion(  const Value : Variant );
begin
     FAnotacion := Value;
end;

var AsientoControl : InxClassFactoryControl;

initialization
   nxInvokeRegistry.RegisterInterface( TypeInfo( IAsiento ) );

   TnxClassFactory.RegisterClass( CLSID_Asiento, TAsiento, AsientoControl );

end.
