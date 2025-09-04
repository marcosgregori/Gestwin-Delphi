{$OPTIMIZATION OFF}

unit RegistroX;

interface

uses  SysUtils,
      Classes,

      LibUtils,
      DataManager,
      Gim10Fields,

      nxllComponent,
      nxllTypes,
      nxivTypes,
      nxrdClass,
      nxrbTypes,

      DB,
      SessionIntf;

const
  CLSID_Asiento : TnxGuid = '{ABD6DBE4-43DC-4642-9730-E1C941071208}';

type

  IAsiento = interface( IInvokableRecord )
    ['{228EEB54-56B5-401D-951D-18E403C8D755}']

    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );

    procedure ToDataset( AsientoFields : TAsientoFields );

    function GetEjercicio: SmallInt;
    function GetNroAsiento: Integer;

    procedure SetEjercicio(const Value: SmallInt);
    procedure SetNroAsiento(const Value: Integer);

    function GetAnotacion: Variant;
    function GetFecha: Variant;
    function GetNombre: Variant;
    function GetNroEfecto: Variant;
    function GetNroFactura: Variant;
    function GetOrigen: SmallInt;
    function GetPropietario: Variant;
    function GetSerie: Variant;
    function GetTipoAsiento: SmallInt;
    procedure SetAnotacion(const Value: Variant);
    procedure SetFecha(const Value: Variant);
    procedure SetFechaDocumento(const Value: Variant);
    procedure SetNombre(const Value: Variant);
    procedure SetNroEfecto(const Value: Variant);
    procedure SetNroFactura(const Value: Variant);
    procedure SetNroRegistro(const Value: Variant);
    procedure SetOrigen(const Value: SmallInt);
    procedure SetPropietario(const Value: Variant);
    procedure SetSerie(const Value: Variant);
    procedure SetTipoAsiento(const Value: SmallInt);
    function GetFechaDocumento: Variant;
    function GetNroRegistro: Variant;

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
    property Origen : SmallInt read GetOrigen write SetOrigen;
    property Anotacion : Variant read GetAnotacion write SetAnotacion;
  end;

  TAsiento = class( TnxClass, InxRemoteableClass, IAsiento)
  private

    FState : TDataSetState;

    FEjercicio : SmallInt;
    FNroAsiento : Integer;
    FTipoAsiento : SmallInt;

    FFecha : Variant;
    FSerie : Variant;
    FNroFactura : Variant;
    FNroEfecto : Variant;
    FFechaDocumento : Variant;
    FPropietario : Variant;
    FNroRegistro : Variant;
    FNombre : Variant;
    FOrigen : Variant;
    FAnotacion : Variant;

    function LoadFromReader(aReader: InxReader): HRESULT;
    function SaveToWriter(AWriter: InxWriter): HRESULT;

    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );
    function GetClassID: TnxGuid;

    procedure ToDataset( AsientoFields : TAsientoFields );

    function GetEjercicio: SmallInt;
    procedure SetEjercicio(const Value: SmallInt);
    function GetNroAsiento: Integer;
    procedure SetNroAsiento(const Value: Integer);

    function GetFecha: Variant;
    procedure SetFecha(const Value: Variant);
    //..
    function GetAnotacion: Variant;
    procedure SetAnotacion(const Value: Variant);
  public

    constructor Create;

    class function FromDataset(AsientoFields: TAsientoFields): IAsiento; static;
  end;

implementation

uses  Variants;

{ TAsiento }


constructor TAsiento.Create;
begin
     inherited Create( @CLSID_Asiento, nil, nil, False);
     FState := dsInsert;
end;

class function TAsiento.FromDataset( AsientoFields : TAsientoFields ) : IAsiento;

var  Asiento : IAsiento;

begin
     Asiento := TAsiento.Create;

     With Asiento do
       begin

       State := AsientoFields.Dataset.State;

       Ejercicio := AsientoFields.Ejercicio.Value;
       NroAsiento := AsientoFields.NroAsiento.Value;
       Fecha := AsientoFields.Fecha.Value;
       TipoAsiento := AsientoFields.TipoAsiento.Value;

       Serie := GetAsVariant( AsientoFields.Serie );
       NroFactura := GetAsVariant( AsientoFields.NroFactura );
       NroEfecto := GetAsVariant( AsientoFields.NroEfecto );
       FechaDocumento := GetAsVariant( AsientoFields.FechaDocumento );
       Propietario := GetAsVariant( AsientoFields.Propietario );
       NroRegistro := GetAsVariant( AsientoFields.NroRegistro );
       Nombre := GetAsVariant( AsientoFields.Nombre );
       Origen := GetAsVariant( AsientoFields.Origen );
       Anotacion := GetAsVariant( AsientoFields.Anotacion );
       end;

     Result := Asiento;
end;

function TAsiento.GetState: TDataSetState;
begin
     Result := FState;
end;

procedure TAsiento.SetState(const Value: TDataSetState);
begin
     FState := Value;
end;

function TAsiento.GetClassID: TnxGuid;
begin
     Result := CLSID_Asiento;
end;

procedure TAsiento.ToDataset(AsientoFields: TAsientoFields);
begin
     try

       If   FState=dsEdit
       then AsientoFields.Dataset.Edit
       else begin
            AsientoFields.Dataset.Append;
            AsientoFields.Ejercicio.Value := FEjercicio;
            AsientoFields.NroAsiento.Value := FNroAsiento;
            end;

       AsientoFields.Fecha.Value := FFecha;
       AsientoFields.TipoAsiento.Value := FTipoAsiento;

       SetAsVariant( AsientoFields.Serie, FSerie );
       SetAsVariant( AsientoFields.NroFactura, FNroFactura );
       SetAsVariant( AsientoFields.NroEfecto, FNroEfecto );
       SetAsVariant( AsientoFields.FechaDocumento, FFechaDocumento );
       SetAsVariant( AsientoFields.Propietario, FPropietario );
       SetAsVariant( AsientoFields.NroRegistro, FNroRegistro );
       SetAsVariant( AsientoFields.Nombre, FNombre );
       SetAsVariant( AsientoFields.Origen, FOrigen );
       SetAsVariant( AsientoFields.Anotacion, FAnotacion );

     except
       AsientoFields.Dataset.Cancel;
       raise;
       end;

end;

function TAsiento.LoadFromReader( AReader : InxReader ) : HRESULT;
begin
     With AReader do
       begin
       FState := TDatasetState( ReadInteger );
       FEjercicio := ReadInteger;
       FNroAsiento := ReadInteger;

       FFecha := ReadVariant;
       FTipoAsiento := ReadVariant;
       FSerie := ReadVariant;
       FNroFactura := ReadVariant;
       FNroEfecto := ReadVariant;
       FFechaDocumento := ReadVariant;
       FPropietario := ReadVariant;
       FNroRegistro := ReadVariant;
       FNombre := ReadVariant;
       FOrigen := ReadVariant;
       FAnotacion := ReadVariant;
       end;
end;

function TAsiento.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     With AWriter do
       begin
       WriteInteger( Ord( FState ) );
       WriteInteger( FEjercicio );
       WriteInteger( FNroAsiento );

       WriteVariant( FFecha );
       WriteVariant( FTipoAsiento );
       WriteVariant( FSerie );
       WriteVariant( FNroFactura );
       WriteVariant( FNroEfecto );
       WriteVariant( FFechaDocumento );
       WriteVariant( FPropietario );
       WriteVariant( FNroRegistro );
       WriteVariant( FNombre );
       WriteVariant( FOrigen );
       WriteVariant( FAnotacion );
       end;
end;

var Control : InxClassFactoryControl;

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IAsiento ) );

     TnxClassFactory.RegisterClass( CLSID_Asiento, TAsiento, Control );

end.


