{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_cpr;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,
     DataManager,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,

     SessionIntf,

     Gim30Fields,
     Gim40Fields;

type

    TTipoContenedor        = ( cnProductoCorrecto,
                               cnProductoSubcontratista,
                               cnProductoDefectuoso,
                               cnMermaExceso,
                               cnExtraccionesIncorporaciones );

     TTipoContenedorSet = set of TTipoContenedor;

const
     CLSID_ExistenciasContenedor : TGuid = '{158B0D4E-E433-4FD1-A22D-3EBB0995E8E6}';
     CLSID_ContenedorService : TGuid = '{BC839FAB-074F-4C0C-8149-E7B1E2051A3D}';

     cnProductoAcabadoCorrecto      = [ cnProductoCorrecto, cnExtraccionesIncorporaciones ];
     cnProductoAcabadoCorrectoTotal = [ cnProductoCorrecto, cnExtraccionesIncorporaciones, cnProductoSubcontratista ];
     cnProductoAcabado              = [ cnProductoCorrecto, cnExtraccionesIncorporaciones, cnProductoDefectuoso ];
     cnProductoAcabadoTotal         = [ cnProductoCorrecto, cnExtraccionesIncorporaciones, cnProductoDefectuoso, cnProductoSubcontratista ];
     cnProductoContenedorAtipico    = [ cnProductoDefectuoso, cnMermaExceso, cnExtraccionesIncorporaciones ];
     cnProductoRealizado            = [ cnProductoCorrecto, cnProductoDefectuoso ];

type

    IExistenciasContenedor =  interface( InxInvokable )
    ['{FA6C2CDF-28D9-482F-968D-B6DCB48852D8}']

    function GetEntradas: Decimal;
    function GetSaldo: Decimal;
    function GetSalidas: Decimal;
    procedure SetEntradas(const Value: Decimal);
    procedure SetSaldo(const Value: Decimal);
    procedure SetSalidas(const Value: Decimal);

    procedure Clear;
    procedure Add( Existencias : IExistenciasContenedor );

    property Entradas : Decimal read GetEntradas write SetEntradas;
    property Salidas : Decimal read GetSalidas write SetSalidas;
    property Saldo : Decimal read GetSaldo write SetSaldo;
    end;

    TExistenciasContenedor = class(TnxClass, InxRemoteableClass, IExistenciasContenedor)
    private

      FEntradas,
      FSalidas,
      FSaldo : Decimal;

      function GetEntradas: Decimal;
      function GetSaldo: Decimal;
      function GetSalidas: Decimal;
      procedure SetEntradas(const Value: Decimal);
      procedure SetSaldo(const Value: Decimal);
      procedure SetSalidas(const Value: Decimal);

    public

      constructor Create;

      function GetClassID: TnxGuid;
      function LoadFromReader(AReader: InxReader): HRESULT;
      function SaveToWriter(AWriter: InxWriter): HRESULT;

      procedure Clear;
      procedure Add( Existencias : IExistenciasContenedor );

      property Entradas : Decimal read GetEntradas write SetEntradas;
      property Salidas : Decimal read GetSalidas write SetSalidas;
      property Saldo : Decimal read GetSaldo write SetSaldo;
    end;

  { Service }

    IContenedorService = interface( ISessionModule )
     ['{2D47590F-5055-4D4C-8EA7-58DA1CB05149}']

      procedure SuprimeReferenciasOrden( EjercicioLanzamiento : SmallInt; NroOrden : LongInt );
      function ContenidoProceso( EjercicioLanzamiento : SmallInt; NroOrden : LongInt; NroProceso : SmallInt; TipoContenedorSet : TTipoContenedorSet ) : IExistenciasContenedor;
      function ContenidoOrden( EjercicioLanzamiento : SmallInt; NroOrden : LongInt; NroProcesoInicial, NroProcesoFinal : SmallInt; TipoContenedorSet : TTipoContenedorSet ) : IExistenciasContenedor;
      function UnidadesCorrectas( EjercicioLanzamiento : SmallInt; NroOrden : Integer ) : Decimal;
      function UnidadesDefectuosas( EjercicioLanzamiento : SmallInt; NroOrden : Integer ) : Decimal;
      end;

implementation

{ TExistenciasContenedor }

function TExistenciasContenedor.GetClassID: TnxGuid;
begin
     Result := CLSID_ExistenciasContenedor;
end;

function TExistenciasContenedor.GetEntradas: Decimal;
begin
     Result := FEntradas;
end;

function TExistenciasContenedor.GetSaldo: Decimal;
begin
     Result := FSaldo;
end;

function TExistenciasContenedor.GetSalidas: Decimal;
begin
     Result := FSalidas;
end;

procedure TExistenciasContenedor.Clear;
begin
     FEntradas := 0.0;
     FSalidas := 0.0;
     FSaldo := 0.0;
end;

constructor TExistenciasContenedor.Create;
begin
     inherited Create( @CLSID_ExistenciasContenedor, nil, nil, False);
end;

procedure TExistenciasContenedor.Add( Existencias : IExistenciasContenedor );
begin
     FEntradas := FEntradas + Existencias.Entradas;
     FSalidas := FSalidas + Existencias.Salidas;
     FSaldo := FSaldo + Existencias.Saldo;
end;

function TExistenciasContenedor.LoadFromReader( AReader : InxReader ) : HRESULT;
begin
     With AReader do
       begin
       FEntradas := ReadCurrency;
       FSalidas := ReadCurrency;
       FSaldo := ReadCurrency;
       end;
     Result := S_OK;
end;

function TExistenciasContenedor.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     With AWriter do
       begin
       WriteCurrency( FEntradas );
       WriteCurrency( FSalidas );
       WriteCurrency( FSaldo );
       end;
     Result := S_OK;
end;

procedure TExistenciasContenedor.SetEntradas(const Value: Decimal);
begin
     FEntradas := Value;
end;

procedure TExistenciasContenedor.SetSaldo(const Value: Decimal);
begin
     FSaldo := Value;
end;

procedure TExistenciasContenedor.SetSalidas(const Value: Decimal);
begin
     FSalidas := Value;
end;

var ExistenciasContenedorControl : InxClassFactoryControl;

initialization

    nxInvokeRegistry.RegisterInterface( TypeInfo( IExistenciasContenedor ) );
    nxInvokeRegistry.RegisterInterface( TypeInfo( IContenedorService ) );

    TnxClassFactory.RegisterClass( CLSID_ExistenciasContenedor, TExistenciasContenedor, ExistenciasContenedorControl );

end.



