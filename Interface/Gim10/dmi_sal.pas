{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_sal;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,
     DataManager,
     Gim10Fields,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,
     nxsdTypes,

     SessionIntf,

     ApunteIntf;

const

     CLSID_SaldosService : TGuid = '{A1E03D6F-1724-4A91-933E-E80378683DF7}';
     CLSID_SumasySaldos : TGuid = '{29C7B9C3-A9AD-4356-917C-1F02F4004AE6}';

     PeriodoInicial = 0;
     PeriodoFinal = 14;

type

    ISumasySaldos =  interface( InxInvokable )
    ['{69EC0883-EDBE-4343-ADDA-806F6E9A3C66}']

    function GetEjercicio : SmallInt;
    function GetDebe( Index : SmallInt ) : Decimal;
    function GetHaber( Index : SmallInt ) : Decimal;
    function GetSaldoInicial : Decimal;
    function GetSumaDebeInicial : Decimal;
    function GetSumaHaberInicial : Decimal;
    function GetSaldo : Decimal;
    function GetSumaDebe : Decimal;
    function GetSumaHaber : Decimal;
    function GetDebeAcumulado: Decimal;
    function GetHaberAcumulado : Decimal;

    procedure SetEjercicio( const Value : SmallInt );
    procedure SetDebe( Index : SmallInt; const Value : Decimal );
    procedure SetHaber( Index : SmallInt; const Value : Decimal );
    procedure SetSaldoInicial( const Value : Decimal );
    procedure SetSumaDebeInicial( const Value : Decimal );
    procedure SetSumaHaberInicial( const Value : Decimal );
    procedure SetSaldo( const Value : Decimal );
    procedure SetSumaDebe( const Value : Decimal );
    procedure SetSumaHaber( const Value : Decimal );
    procedure SetDebeAcumulado( const Value : Decimal );
    procedure SetHaberAcumulado( const Value : Decimal );

    procedure Clear;
    procedure Add( SumasySaldos : ISumasySaldos );

    property Ejercicio : SmallInt read GetEjercicio write SetEjercicio;

    property Debe[ Index : SmallInt ] : Decimal read GetDebe write SetDebe;
    property Haber[ Index : SmallInt ] : Decimal read GetHaber write SetHaber;

    property SaldoInicial : Decimal read GetSaldoInicial write SetSaldoInicial;
    property SumaDebeInicial : Decimal read GetSumaDebeInicial write SetSumaDebeInicial;
    property SumaHaberInicial : Decimal read GetSumaHaberInicial write SetSumaHaberInicial;
    property Saldo : Decimal read GetSaldo write SetSaldo;
    property SumaDebe : Decimal read GetSumaDebe write SetSumaDebe;
    property SumaHaber : Decimal read GetSumaHaber write SetSumaHaber;
    property DebeAcumulado : Decimal read GetDebeAcumulado write SetDebeAcumulado;
    property HaberAcumulado : Decimal read GetHaberAcumulado write SetHaberAcumulado;
  end;

  TSaldoPeriodo = array[ PeriodoInicial..PeriodoFinal ] of Decimal;

  TSumasySaldos = class(TnxClass, InxRemoteableClass, ISumasySaldos)
  private

    FEjercicio : SmallInt;

    FDebe,
    FHaber : TSaldoPeriodo;

    FSaldoInicial,
    FSumaDebeInicial,
    FSumaHaberInicial,
    FSaldo,
    FSumaDebe,
    FSumaHaber,
    FDebeAcumulado,
    FHaberAcumulado : Decimal;

    function GetEjercicio : SmallInt;
    function GetDebe( Index : SmallInt ) : Decimal;
    function GetHaber( Index : SmallInt ) : Decimal;
    function GetSaldoInicial : Decimal;
    function GetSumaDebeInicial : Decimal;
    function GetSumaHaberInicial : Decimal;
    function GetSaldo : Decimal;
    function GetSumaDebe : Decimal;
    function GetSumaHaber : Decimal;
    function GetDebeAcumulado: Decimal;
    function GetHaberAcumulado : Decimal;

    procedure SetEjercicio( const Value : SmallInt );
    procedure SetDebe( Index : SmallInt; const Value : Decimal );
    procedure SetHaber( Index : SmallInt; const Value : Decimal );
    procedure SetSaldoInicial( const Value : Decimal );
    procedure SetSumaDebeInicial( const Value : Decimal );
    procedure SetSumaHaberInicial( const Value : Decimal );
    procedure SetSaldo( const Value : Decimal );
    procedure SetSumaDebe( const Value : Decimal );
    procedure SetSumaHaber( const Value : Decimal );
    procedure SetDebeAcumulado( const Value : Decimal );
    procedure SetHaberAcumulado( const Value : Decimal );

    function LoadFromReader(aReader: InxReader): HRESULT;
    function SaveToWriter(AWriter: InxWriter): HRESULT;
    function GetClassID: TnxGuid;

  public

    constructor Create( Ejercicio : SmallInt = 0 );

    procedure Clear;
    procedure Add( SumasySaldos : ISumasySaldos );

    property Ejercicio : SmallInt read GetEjercicio write SetEjercicio;

    property Debe[ Index : SmallInt ] : Decimal read GetDebe write SetDebe;
    property Haber[ Index : SmallInt ] : Decimal read GetHaber write SetHaber;
  end;

  ISaldosService = interface( ISessionModule )
    [ '{FFF07D08-19B2-4E8B-9B9F-54E8FC50DBAD}' ]

    {
    procedure ActualizaSaldos( SaldosCursorID : TnxCursorID;
                               TipoAsiento    : SmallInt;
                               Apunte         : IApunte;
                               Deducir        : Boolean = False );
    }

    function  SaldoPeriodo( SubCuenta     : String;
                            CentroCoste   : String;
                            TodosLosCC    : Boolean;
                            Ejercicio,
                            MesInicial,
                            MesFinal      : SmallInt;
                            Apertura      : Boolean = False ) : ISumasySaldos;

    function  SaldoFecha ( Cuenta      : String;
                           CentroCoste : String;
                           TodosLosCC  : Boolean;
                           Fecha       : TDateTime;
                           NroAsiento  : Integer = 0;
                           NroApunte   : SmallInt = 0;
                           Incluido    : Boolean  = False ) : ISumasySaldos;

    function MesAsientoApertura( Ejercicio : SmallInt ) : SmallInt;

    function SaldoApertura( Cuenta      : String;
                            CentroCoste : String;
                            TodosLosCC  : Boolean;
                            Ejercicio   : SmallInt;
                            SoloAsiento : Boolean = False ) : ISumasySaldos;


    function  Cuadra( Ejercicio : Word; PeriodoInicial : Byte = 0; PeriodoFinal : Byte = 14 ) : Boolean;

    function  Sumas( FechaInicial : TDateTime ) : ISumasySaldos;

    procedure ReconstruyeSaldos( Ejercicio,
                                 EjercicioInicial,
                                 EjercicioFinal        : SmallInt;
                                 ComprobarCuadre       : Boolean;
                                 LimpiarSaldosApertura : Boolean = True  );
    end;

implementation

uses  Variants;

{ TSumasySaldos }

function TSumasySaldos.GetClassID: TnxGuid;
begin
     Result := CLSID_SumasySaldos;
end;

function TSumasySaldos.GetDebe( Index : SmallInt ): Decimal;
begin
     Result := FDebe[ Index ];
end;

function TSumasySaldos.GetDebeAcumulado: Decimal;
begin
     Result := FDebeAcumulado;
end;

function TSumasySaldos.GetEjercicio: SmallInt;
begin
     Result := FEjercicio;
end;

function TSumasySaldos.GetHaber( Index : SmallInt ) : Decimal;
begin
     Result := FHaber[ Index ];
end;

function TSumasySaldos.GetHaberAcumulado: Decimal;
begin
     Result := FHaberAcumulado;
end;

function TSumasySaldos.GetSaldo: Decimal;
begin
     Result := FSaldo;
end;

function TSumasySaldos.GetSaldoInicial: Decimal;
begin
     Result := FSaldoInicial;
end;

function TSumasySaldos.GetSumaDebe: Decimal;
begin
     Result := FSumaDebe;
end;

function TSumasySaldos.GetSumaDebeInicial: Decimal;
begin
     Result := FSumaDebeInicial;
end;

function TSumasySaldos.GetSumaHaber: Decimal;
begin
     Result := FSumaHaber;
end;

function TSumasySaldos.GetSumaHaberInicial: Decimal;
begin
     Result := FSumaHaberInicial;
end;

procedure TSumasySaldos.SetDebe( Index : SmallInt; const Value: Decimal );
begin
     FDebe[ Index ] := Value;
end;

procedure TSumasySaldos.SetDebeAcumulado(const Value: Decimal);
begin
     FDebeAcumulado := Value;
end;

procedure TSumasySaldos.SetEjercicio(const Value: SmallInt);
begin
     FEjercicio := Value;
end;

procedure TSumasySaldos.SetHaber( Index : SmallInt;  const Value: Decimal );
begin
     FHaber[ Index ] := Value;
end;

procedure TSumasySaldos.SetHaberAcumulado(const Value: Decimal);
begin
     FHaberAcumulado := Value;
end;

procedure TSumasySaldos.SetSaldo(const Value: Decimal);
begin
     FSaldo := Value;
end;

procedure TSumasySaldos.SetSaldoInicial(const Value: Decimal);
begin
     FSaldoInicial := Value;
end;

procedure TSumasySaldos.SetSumaDebe(const Value: Decimal);
begin
     FSumaDebe := Value;
end;

procedure TSumasySaldos.SetSumaDebeInicial(const Value: Decimal);
begin
     FSumaDebeInicial := Value;
end;

procedure TSumasySaldos.SetSumaHaber(const Value: Decimal);
begin
     FSumaHaber := Value;
end;

procedure TSumasySaldos.SetSumaHaberInicial(const Value: Decimal);
begin
     FSumaHaberInicial := Value;
end;

procedure TSumasySaldos.Clear;

var  I : SmallInt;

begin
     Ejercicio := 0;
     For I := PeriodoInicial to PeriodoFinal do
       begin
       FDebe[ I ] := 0.0;
       FHaber[ I ] := 0.0;
       end;
     FSaldoInicial := 0.0;
     FSumaDebeInicial := 0.0;
     FSumaHaberInicial := 0.0;
     FSaldo := 0.0;
     FSumaDebe := 0.0;
     FSumaHaber := 0.0;
     FDebeAcumulado := 0.0;
     FHaberAcumulado := 0.0;
end;

constructor TSumasySaldos.Create( Ejercicio : SmallInt = 0 );
begin
     inherited Create( @CLSID_SumasySaldos, nil, nil, False);
     FEjercicio := Ejercicio;
end;

procedure TSumasySaldos.Add( SumasySaldos : ISumasySaldos );

var  I : SmallInt;

begin
     For I := PeriodoInicial to PeriodoFinal do
       begin
       FDebe[ I ] := FDebe[ I ] + SumasySaldos.Debe[ I ];
       FHaber[ I ] := FHaber[ I ] + SumasySaldos.Haber[ I ];
       end;
     FSaldoInicial := FSaldoInicial + SumasySaldos.SaldoInicial;
     FSumaDebeInicial := FSumaDebeInicial + SumasySaldos.SumaDebeInicial;
     FSumaHaberInicial := FSumaHaberInicial + SumasySaldos.SumaHaberInicial;
     FSaldo := FSaldo + SumasySaldos.Saldo;
     FSumaDebe := FSumaDebe + SumasySaldos.SumaDebe;
     FSumaHaber := FSumaHaber + SumasySaldos.SumaHaber;
     FDebeAcumulado := FDebeAcumulado + SumasySaldos.DebeAcumulado;
     FHaberAcumulado := FHaberAcumulado + SumasySaldos.HaberAcumulado;
end;

function TSumasySaldos.LoadFromReader( AReader : InxReader ) : HRESULT;

var  I : SmallInt;

begin
     With AReader do
       begin

       FEjercicio := ReadInteger;

       For I := PeriodoInicial to PeriodoFinal do
         begin
         FDebe[ I ] := ReadCurrency;
         FHaber[ I ] := ReadCurrency;
         end;

       FSaldoInicial := ReadCurrency;
       FSumaDebeInicial := ReadCurrency;
       FSumaHaberInicial := ReadCurrency;
       FSaldo := ReadCurrency;
       FSumaDebe := ReadCurrency;
       FSumaHaber := ReadCurrency;
       FDebeAcumulado := ReadCurrency;
       FHaberAcumulado := ReadCurrency;

       end;
     Result := S_OK;
end;

function TSumasySaldos.SaveToWriter( AWriter : InxWriter) : HRESULT;


var  I : SmallInt;

begin
     With AWriter do
       begin

       WriteInteger( FEjercicio );

       For I := PeriodoInicial to PeriodoFinal do
         begin
         WriteCurrency( FDebe[ I ] );
         WriteCurrency( FHaber[ I ] );
         end;

       WriteCurrency( FSaldoInicial );
       WriteCurrency( FSumaDebeInicial );
       WriteCurrency( FSumaHaberInicial );
       WriteCurrency( FSaldo );
       WriteCurrency( FSumaDebe );
       WriteCurrency( FSumaHaber );
       WriteCurrency( FDebeAcumulado );
       WriteCurrency( FHaberAcumulado );
       end;
     Result := S_OK;
end;

var SumasySaldosControl,
    ApunteControl : InxClassFactoryControl;

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( ISaldosService ) );
     nxInvokeRegistry.RegisterInterface( TypeInfo( ISumasySaldos ) );

     TnxClassFactory.RegisterClass( CLSID_SumasySaldos, TSumasySaldos, SumasySaldosControl );

end.


