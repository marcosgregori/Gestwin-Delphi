{$ALIGN OFF}
{$OPTIMIZATION OFF}

unit FacturaIntf;

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
  CLSID_Factura : TnxGuid = '{B7DB2BBE-3389-4CA8-9A67-0648754D7727}';

type

  IFactura = interface( IInvokableRecord )
    [ '{C5126A25-BB33-41CB-9247-BCB250029617}' ] 

    procedure ToDataset( FacturaFields : TFacturaFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
    function GetRemoteCursorID : TnxCursorID;
    procedure SetRemoteCursorID( const Value : TnxCursorID );
    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );

    // Los campos que forman parte de un índice es conveniente que no sean Variants.
    // El resto, sin embargo, pueden ser valores nulos, o el campo no estar definido en el dataset.

    function GetTipo : SmallInt;
    function GetEjercicio : SmallInt;
    function GetPropietario : String;
    function GetSerieFactura : String;
    function GetNroRegistro : Integer;
    function GetEjercicioFraRectificada : Variant;
    function GetSerieFraRectificada : Variant;
    function GetNroFacturaRectificada : Variant;
    function GetRazon : Variant;
    function GetMetodo : Variant;
    function GetTipoFactura : Variant;
    function GetRegimenOTrascendencia : Variant;
    function GetTipoFacturaRectificativa : Variant;
    function GetCausaExencion : Variant;
    function GetTipoOperacionIntracomunitaria : Variant;
    function GetSituacionInmueble : Variant;
    function GetReferenciaCatastral : Variant;
    function GetIdentificacionDescripcionBienes : Variant;
    function GetFechaInicioUtilizacion : Variant;
    function GetProrrataAnualDefinitiva : Variant;
    function GetDescripcion : Variant;

    procedure SetTipo( const Value  : SmallInt );
    procedure SetEjercicio( const Value  : SmallInt );
    procedure SetPropietario( const Value  : String );
    procedure SetSerieFactura( const Value  : String );
    procedure SetNroRegistro( const Value  : Integer );
    procedure SetEjercicioFraRectificada( const Value  : Variant );
    procedure SetSerieFraRectificada( const Value  : Variant );
    procedure SetNroFacturaRectificada( const Value  : Variant );
    procedure SetRazon( const Value  : Variant );
    procedure SetMetodo( const Value  : Variant );
    procedure SetTipoFactura( const Value  : Variant );
    procedure SetRegimenOTrascendencia( const Value  : Variant );
    procedure SetTipoFacturaRectificativa( const Value  : Variant );
    procedure SetCausaExencion( const Value  : Variant );
    procedure SetTipoOperacionIntracomunitaria( const Value  : Variant );
    procedure SetSituacionInmueble( const Value  : Variant );
    procedure SetReferenciaCatastral( const Value  : Variant );
    procedure SetIdentificacionDescripcionBienes( const Value  : Variant );
    procedure SetFechaInicioUtilizacion( const Value  : Variant );
    procedure SetProrrataAnualDefinitiva( const Value  : Variant );
    procedure SetDescripcion( const Value  : Variant );
    property RemoteCursorID : TnxCursorID read GetRemoteCursorID write SetRemoteCursorID;
    property State : TDatasetState read GetState write SetState;

    property Tipo : SmallInt read GetTipo write SetTipo;
    property Ejercicio : SmallInt read GetEjercicio write SetEjercicio;
    property Propietario : String read GetPropietario write SetPropietario;
    property SerieFactura : String read GetSerieFactura write SetSerieFactura;
    property NroRegistro : Integer read GetNroRegistro write SetNroRegistro;
    property EjercicioFraRectificada : Variant read GetEjercicioFraRectificada write SetEjercicioFraRectificada;
    property SerieFraRectificada : Variant read GetSerieFraRectificada write SetSerieFraRectificada;
    property NroFacturaRectificada : Variant read GetNroFacturaRectificada write SetNroFacturaRectificada;
    property Razon : Variant read GetRazon write SetRazon;
    property Metodo : Variant read GetMetodo write SetMetodo;
    property TipoFactura : Variant read GetTipoFactura write SetTipoFactura;
    property RegimenOTrascendencia : Variant read GetRegimenOTrascendencia write SetRegimenOTrascendencia;
    property TipoFacturaRectificativa : Variant read GetTipoFacturaRectificativa write SetTipoFacturaRectificativa;
    property CausaExencion : Variant read GetCausaExencion write SetCausaExencion;
    property TipoOperacionIntracomunitaria : Variant read GetTipoOperacionIntracomunitaria write SetTipoOperacionIntracomunitaria;
    property SituacionInmueble : Variant read GetSituacionInmueble write SetSituacionInmueble;
    property ReferenciaCatastral : Variant read GetReferenciaCatastral write SetReferenciaCatastral;
    property IdentificacionDescripcionBienes : Variant read GetIdentificacionDescripcionBienes write SetIdentificacionDescripcionBienes;
    property FechaInicioUtilizacion : Variant read GetFechaInicioUtilizacion write SetFechaInicioUtilizacion;
    property ProrrataAnualDefinitiva : Variant read GetProrrataAnualDefinitiva write SetProrrataAnualDefinitiva;
    property Descripcion : Variant read GetDescripcion write SetDescripcion;

    end;

   TFactura = class( TnxClass, InxRemoteableClass, IFactura)
     private

     FRemoteCursorID,
     FState : Variant;

     FTipo,
     FEjercicio,
     FPropietario,
     FSerieFactura,
     FNroRegistro,
     FEjercicioFraRectificada,
     FSerieFraRectificada,
     FNroFacturaRectificada,
     FRazon,
     FMetodo,
     FTipoFactura,
     FRegimenOTrascendencia,
     FTipoFacturaRectificativa,
     FCausaExencion,
     FTipoOperacionIntracomunitaria,
     FSituacionInmueble,
     FReferenciaCatastral,
     FIdentificacionDescripcionBienes,
     FFechaInicioUtilizacion,
     FProrrataAnualDefinitiva,
     FDescripcion : Variant;

     function GetTipo : SmallInt;
     function GetEjercicio : SmallInt;
     function GetPropietario : String;
     function GetSerieFactura : String;
     function GetNroRegistro : Integer;
     function GetEjercicioFraRectificada : Variant;
     function GetSerieFraRectificada : Variant;
     function GetNroFacturaRectificada : Variant;
     function GetRazon : Variant;
     function GetMetodo : Variant;
     function GetTipoFactura : Variant;
     function GetRegimenOTrascendencia : Variant;
     function GetTipoFacturaRectificativa : Variant;
     function GetCausaExencion : Variant;
     function GetTipoOperacionIntracomunitaria : Variant;
     function GetSituacionInmueble : Variant;
     function GetReferenciaCatastral : Variant;
     function GetIdentificacionDescripcionBienes : Variant;
     function GetFechaInicioUtilizacion : Variant;
     function GetProrrataAnualDefinitiva : Variant;
     function GetDescripcion : Variant;

     procedure SetTipo( const Value  : SmallInt );
     procedure SetEjercicio( const Value  : SmallInt );
     procedure SetPropietario( const Value  : String );
     procedure SetSerieFactura( const Value  : String );
     procedure SetNroRegistro( const Value  : Integer );
     procedure SetEjercicioFraRectificada( const Value  : Variant );
     procedure SetSerieFraRectificada( const Value  : Variant );
     procedure SetNroFacturaRectificada( const Value  : Variant );
     procedure SetRazon( const Value  : Variant );
     procedure SetMetodo( const Value  : Variant );
     procedure SetTipoFactura( const Value  : Variant );
     procedure SetRegimenOTrascendencia( const Value  : Variant );
     procedure SetTipoFacturaRectificativa( const Value  : Variant );
     procedure SetCausaExencion( const Value  : Variant );
     procedure SetTipoOperacionIntracomunitaria( const Value  : Variant );
     procedure SetSituacionInmueble( const Value  : Variant );
     procedure SetReferenciaCatastral( const Value  : Variant );
     procedure SetIdentificacionDescripcionBienes( const Value  : Variant );
     procedure SetFechaInicioUtilizacion( const Value  : Variant );
     procedure SetProrrataAnualDefinitiva( const Value  : Variant );
     procedure SetDescripcion( const Value  : Variant );

     function LoadFromReader( AReader : InxReader ) : HRESULT;
     function SaveToWriter( AWriter : InxWriter ) : HRESULT;

     function GetRemoteCursorID : TnxCursorID;
     procedure SetRemoteCursorID( const Value : TnxCursorID );
     function GetState : TDataSetState;
     procedure SetState( const Value : TDataSetState );
     function GetClassID : TnxGuid;

     public

     constructor Create; reintroduce;

     class function FromDataset( FacturaFields  : TFacturaFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IFactura;
     procedure ToDataset( FacturaFields : TFacturaFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );

     end;

implementation

uses  Variants;

{ TFactura }

constructor TFactura.Create;
begin
     inherited Create( @CLSID_Factura, nil, nil, False);
     FState := dsInsert;
end;

class function TFactura.FromDataset( FacturaFields : TFacturaFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : IFactura;

var   SaveState : TDataSetState;
      ApplyOldValues : Boolean;

begin
      Result := TFactura.Create;

      With Result do
        begin

        RemoteCursorID := FacturaFields.GetRemoteCursorID;
        State := FacturaFields.Dataset.State;
        SaveState := State;

        ApplyOldValues := OldValues and not ( State in [ dsInsert, dsSetKey ] );
        If   ApplyOldValues
        then FacturaFields.IDataset.SetTempState( dsOldValue );

        try

          Tipo := GetFieldAsVariant( FacturaFields.Tipo );
          Ejercicio := GetFieldAsVariant( FacturaFields.Ejercicio );
          Propietario := GetFieldAsVariant( FacturaFields.Propietario );
          SerieFactura := GetFieldAsVariant( FacturaFields.SerieFactura );
          NroRegistro := GetFieldAsVariant( FacturaFields.NroRegistro );
          EjercicioFraRectificada := GetFieldAsVariant( FacturaFields.EjercicioFraRectificada );
          SerieFraRectificada := GetFieldAsVariant( FacturaFields.SerieFraRectificada );
          NroFacturaRectificada := GetFieldAsVariant( FacturaFields.NroFacturaRectificada );
          Razon := GetFieldAsVariant( FacturaFields.Razon );
          Metodo := GetFieldAsVariant( FacturaFields.Metodo );
          TipoFactura := GetFieldAsVariant( FacturaFields.TipoFactura );
          RegimenOTrascendencia := GetFieldAsVariant( FacturaFields.RegimenOTrascendencia );
          TipoFacturaRectificativa := GetFieldAsVariant( FacturaFields.TipoFacturaRectificativa );
          CausaExencion := GetFieldAsVariant( FacturaFields.CausaExencion );
          TipoOperacionIntracomunitaria := GetFieldAsVariant( FacturaFields.TipoOperacionIntracomunitaria );
          SituacionInmueble := GetFieldAsVariant( FacturaFields.SituacionInmueble );
          ReferenciaCatastral := GetFieldAsVariant( FacturaFields.ReferenciaCatastral );
          IdentificacionDescripcionBienes := GetFieldAsVariant( FacturaFields.IdentificacionDescripcionBienes );
          FechaInicioUtilizacion := GetFieldAsVariant( FacturaFields.FechaInicioUtilizacion );
          ProrrataAnualDefinitiva := GetFieldAsVariant( FacturaFields.ProrrataAnualDefinitiva );

          If   ReadBlobs
          then Descripcion := GetFieldAsVariant( FacturaFields.Descripcion )
          else Descripcion := '';


        finally
          If   ApplyOldValues
          then FacturaFields.IDataset.RestoreState( SaveState );
        end;
      end;

end;

procedure TFactura.ToDataset( FacturaFields : TFacturaFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
begin
     try

       If   not PreserveState
       then FacturaFields.SetStateFromInterface( FState );

       FacturaFields.Tipo.Value := FTipo;
       FacturaFields.Ejercicio.Value := FEjercicio;
       FacturaFields.Propietario.Value := FPropietario;
       FacturaFields.SerieFactura.Value := FSerieFactura;
       FacturaFields.NroRegistro.Value := FNroRegistro;

       SetFieldAsVariant( FacturaFields.EjercicioFraRectificada, FEjercicioFraRectificada );
       SetFieldAsVariant( FacturaFields.SerieFraRectificada, FSerieFraRectificada );
       SetFieldAsVariant( FacturaFields.NroFacturaRectificada, FNroFacturaRectificada );
       SetFieldAsVariant( FacturaFields.Razon, FRazon );
       SetFieldAsVariant( FacturaFields.Metodo, FMetodo );
       SetFieldAsVariant( FacturaFields.TipoFactura, FTipoFactura );
       SetFieldAsVariant( FacturaFields.RegimenOTrascendencia, FRegimenOTrascendencia );
       SetFieldAsVariant( FacturaFields.TipoFacturaRectificativa, FTipoFacturaRectificativa );
       SetFieldAsVariant( FacturaFields.CausaExencion, FCausaExencion );
       SetFieldAsVariant( FacturaFields.TipoOperacionIntracomunitaria, FTipoOperacionIntracomunitaria );
       SetFieldAsVariant( FacturaFields.SituacionInmueble, FSituacionInmueble );
       SetFieldAsVariant( FacturaFields.ReferenciaCatastral, FReferenciaCatastral );
       SetFieldAsVariant( FacturaFields.IdentificacionDescripcionBienes, FIdentificacionDescripcionBienes );
       SetFieldAsVariant( FacturaFields.FechaInicioUtilizacion, FFechaInicioUtilizacion );
       SetFieldAsVariant( FacturaFields.ProrrataAnualDefinitiva, FProrrataAnualDefinitiva );

       If   ReadBlobs
       then SetFieldAsVariant( FacturaFields.Descripcion, FDescripcion )
       else FacturaFields.Descripcion.Clear;

     except
       FacturaFields.Dataset.Cancel;
       raise;
       end;

end;

function TFactura.LoadFromReader( AReader : InxReader ) : HRESULT;

var VarFlags : TnxVarFlags;

begin
     nxReadVariant( VarFlags, FRemoteCursorID, AReader );
     nxReadVariant( VarFlags, FState, AReader );

     nxReadVariant( VarFlags, FTipo, AReader );
     nxReadVariant( VarFlags, FEjercicio, AReader );
     nxReadVariant( VarFlags, FPropietario, AReader );
     nxReadVariant( VarFlags, FSerieFactura, AReader );
     nxReadVariant( VarFlags, FNroRegistro, AReader );
     nxReadVariant( VarFlags, FEjercicioFraRectificada, AReader );
     nxReadVariant( VarFlags, FSerieFraRectificada, AReader );
     nxReadVariant( VarFlags, FNroFacturaRectificada, AReader );
     nxReadVariant( VarFlags, FRazon, AReader );
     nxReadVariant( VarFlags, FMetodo, AReader );
     nxReadVariant( VarFlags, FTipoFactura, AReader );
     nxReadVariant( VarFlags, FRegimenOTrascendencia, AReader );
     nxReadVariant( VarFlags, FTipoFacturaRectificativa, AReader );
     nxReadVariant( VarFlags, FCausaExencion, AReader );
     nxReadVariant( VarFlags, FTipoOperacionIntracomunitaria, AReader );
     nxReadVariant( VarFlags, FSituacionInmueble, AReader );
     nxReadVariant( VarFlags, FReferenciaCatastral, AReader );
     nxReadVariant( VarFlags, FIdentificacionDescripcionBienes, AReader );
     nxReadVariant( VarFlags, FFechaInicioUtilizacion, AReader );
     nxReadVariant( VarFlags, FProrrataAnualDefinitiva, AReader );
     nxReadVariant( VarFlags, FDescripcion, AReader );

     Result := S_OK;
end;

function TFactura.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     nxWriteVariant( FRemoteCursorID, AWriter );
     nxWriteVariant( FState, AWriter );

     nxWriteVariant( FTipo, AWriter );
     nxWriteVariant( FEjercicio, AWriter );
     nxWriteVariant( FPropietario, AWriter );
     nxWriteVariant( FSerieFactura, AWriter );
     nxWriteVariant( FNroRegistro, AWriter );
     nxWriteVariant( FEjercicioFraRectificada, AWriter );
     nxWriteVariant( FSerieFraRectificada, AWriter );
     nxWriteVariant( FNroFacturaRectificada, AWriter );
     nxWriteVariant( FRazon, AWriter );
     nxWriteVariant( FMetodo, AWriter );
     nxWriteVariant( FTipoFactura, AWriter );
     nxWriteVariant( FRegimenOTrascendencia, AWriter );
     nxWriteVariant( FTipoFacturaRectificativa, AWriter );
     nxWriteVariant( FCausaExencion, AWriter );
     nxWriteVariant( FTipoOperacionIntracomunitaria, AWriter );
     nxWriteVariant( FSituacionInmueble, AWriter );
     nxWriteVariant( FReferenciaCatastral, AWriter );
     nxWriteVariant( FIdentificacionDescripcionBienes, AWriter );
     nxWriteVariant( FFechaInicioUtilizacion, AWriter );
     nxWriteVariant( FProrrataAnualDefinitiva, AWriter );
     nxWriteVariant( FDescripcion, AWriter );
     Result := S_OK;
end;

{ Getters}

function TFactura.GetClassID: TnxGuid;
begin
     Result := CLSID_Factura;
end;

function TFactura.GetRemoteCursorID: TnxCursorID;
begin
     Result := FRemoteCursorID;
end;

function TFactura.GetState: TDataSetState;
begin
     Result := FState;
end;


function TFactura.GetTipo : SmallInt;
begin
     Result := FTipo;
end;

function TFactura.GetEjercicio : SmallInt;
begin
     Result := FEjercicio;
end;

function TFactura.GetPropietario : String;
begin
     Result := FPropietario;
end;

function TFactura.GetSerieFactura : String;
begin
     Result := FSerieFactura;
end;

function TFactura.GetNroRegistro : Integer;
begin
     Result := FNroRegistro;
end;

function TFactura.GetEjercicioFraRectificada : Variant;
begin
     Result := FEjercicioFraRectificada;
end;

function TFactura.GetSerieFraRectificada : Variant;
begin
     Result := FSerieFraRectificada;
end;

function TFactura.GetNroFacturaRectificada : Variant;
begin
     Result := FNroFacturaRectificada;
end;

function TFactura.GetRazon : Variant;
begin
     Result := FRazon;
end;

function TFactura.GetMetodo : Variant;
begin
     Result := FMetodo;
end;

function TFactura.GetTipoFactura : Variant;
begin
     Result := FTipoFactura;
end;

function TFactura.GetRegimenOTrascendencia : Variant;
begin
     Result := FRegimenOTrascendencia;
end;

function TFactura.GetTipoFacturaRectificativa : Variant;
begin
     Result := FTipoFacturaRectificativa;
end;

function TFactura.GetCausaExencion : Variant;
begin
     Result := FCausaExencion;
end;

function TFactura.GetTipoOperacionIntracomunitaria : Variant;
begin
     Result := FTipoOperacionIntracomunitaria;
end;

function TFactura.GetSituacionInmueble : Variant;
begin
     Result := FSituacionInmueble;
end;

function TFactura.GetReferenciaCatastral : Variant;
begin
     Result := FReferenciaCatastral;
end;

function TFactura.GetIdentificacionDescripcionBienes : Variant;
begin
     Result := FIdentificacionDescripcionBienes;
end;

function TFactura.GetFechaInicioUtilizacion : Variant;
begin
     Result := FFechaInicioUtilizacion;
end;

function TFactura.GetProrrataAnualDefinitiva : Variant;
begin
     Result := FProrrataAnualDefinitiva;
end;

function TFactura.GetDescripcion : Variant;
begin
     Result := FDescripcion;
end;

{ Setters}

procedure TFactura.SetRemoteCursorID( const Value : TnxCursorID );
begin
     FRemoteCursorID := Value;
end;

procedure TFactura.SetState( const Value : TDataSetState );
begin
     FState := Value;
end;


procedure TFactura.SetTipo(  const Value : SmallInt );
begin
     FTipo := Value;
end;

procedure TFactura.SetEjercicio(  const Value : SmallInt );
begin
     FEjercicio := Value;
end;

procedure TFactura.SetPropietario(  const Value : String );
begin
     FPropietario := Value;
end;

procedure TFactura.SetSerieFactura(  const Value : String );
begin
     FSerieFactura := Value;
end;

procedure TFactura.SetNroRegistro(  const Value : Integer );
begin
     FNroRegistro := Value;
end;

procedure TFactura.SetEjercicioFraRectificada(  const Value : Variant );
begin
     FEjercicioFraRectificada := Value;
end;

procedure TFactura.SetSerieFraRectificada(  const Value : Variant );
begin
     FSerieFraRectificada := Value;
end;

procedure TFactura.SetNroFacturaRectificada(  const Value : Variant );
begin
     FNroFacturaRectificada := Value;
end;

procedure TFactura.SetRazon(  const Value : Variant );
begin
     FRazon := Value;
end;

procedure TFactura.SetMetodo(  const Value : Variant );
begin
     FMetodo := Value;
end;

procedure TFactura.SetTipoFactura(  const Value : Variant );
begin
     FTipoFactura := Value;
end;

procedure TFactura.SetRegimenOTrascendencia(  const Value : Variant );
begin
     FRegimenOTrascendencia := Value;
end;

procedure TFactura.SetTipoFacturaRectificativa(  const Value : Variant );
begin
     FTipoFacturaRectificativa := Value;
end;

procedure TFactura.SetCausaExencion(  const Value : Variant );
begin
     FCausaExencion := Value;
end;

procedure TFactura.SetTipoOperacionIntracomunitaria(  const Value : Variant );
begin
     FTipoOperacionIntracomunitaria := Value;
end;

procedure TFactura.SetSituacionInmueble(  const Value : Variant );
begin
     FSituacionInmueble := Value;
end;

procedure TFactura.SetReferenciaCatastral(  const Value : Variant );
begin
     FReferenciaCatastral := Value;
end;

procedure TFactura.SetIdentificacionDescripcionBienes(  const Value : Variant );
begin
     FIdentificacionDescripcionBienes := Value;
end;

procedure TFactura.SetFechaInicioUtilizacion(  const Value : Variant );
begin
     FFechaInicioUtilizacion := Value;
end;

procedure TFactura.SetProrrataAnualDefinitiva(  const Value : Variant );
begin
     FProrrataAnualDefinitiva := Value;
end;

procedure TFactura.SetDescripcion(  const Value : Variant );
begin
     FDescripcion := Value;
end;

var FacturaControl : InxClassFactoryControl;

initialization
   nxInvokeRegistry.RegisterInterface( TypeInfo( IFactura ) );

   TnxClassFactory.RegisterClass( CLSID_Factura, TFactura, FacturaControl );

end.
