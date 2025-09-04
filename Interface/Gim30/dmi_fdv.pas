{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_fdv;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,
     DataManager,
     Gim10Fields,
     Gim30Fields,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,
     nxsdTypes,

     SessionIntf,

     FacturaVentasIntf,
     ParametrosFacturacionIntf;

const

     CLSID_BasesyCuotasFactura  : TGuid = '{1D80BEE1-763C-4D47-9B1B-5BF0088FD908}';
     CLSID_FacturaVentasService : TGuid = '{8A3983B1-6167-48F9-B5DC-CB900E639BF5}';

type

    IBasesyCuotasFactura = interface( InxInvokable )
    ['{2003B407-BCB9-44B8-9D97-6CD8CE566440}']

      function GetTasasArray : TTasasArray;
      function GetTotalCuotaIVA : Decimal;
      function GetTotalCuotaRE : Decimal;

      procedure SetTasasArray( const Value : TTasasArray );
      procedure SetTotalCuotaIVA( const Value : Decimal );
      procedure SetTotalCuotaRE( const Value : Decimal );

      property TasasArray : TTasasArray read GetTasasArray write SetTasasArray;
      property TotalCuotaIVA : Decimal read GetTotalCuotaIVA write SetTotalCuotaIVA;
      property TotalCuotaRE : Decimal read GetTotalCuotaRE write SetTotalCuotaRE;
      end;

    TBasesyCuotasFactura = class(TnxClass, InxRemoteableClass, IBasesyCuotasFactura )
      private

        FTasasArray : TTasasArray;
        FTotalCuotaIVA,
        FTotalCuotaRE : Decimal;

        function GetTasasArray : TTasasArray;
        function GetTotalCuotaIVA : Decimal;
        function GetTotalCuotaRE : Decimal;

        procedure SetTasasArray( const Value : TTasasArray );
        procedure SetTotalCuotaIVA( const Value : Decimal );
        procedure SetTotalCuotaRE( const Value : Decimal );

      public

       constructor Create;

       procedure Clear;

       function GetClassID: TnxGuid;
       function LoadFromReader(AReader: InxReader): HRESULT;
       function SaveToWriter(AWriter: InxWriter): HRESULT;

       property TasasArray : TTasasArray read GetTasasArray write SetTasasArray;
       property TotalCuotaIVA : Decimal read GetTotalCuotaIVA write SetTotalCuotaIVA;
       property TotalCuotaRE : Decimal read GetTotalCuotaRE write SetTotalCuotaRE;

      end;

    IFacturaVentasService = interface( ISessionModule )
      ['{1FE85EAD-7E14-4CC4-8682-0BDC3CB3DB70}']

      function RecalculaFactura( FacturaVentas : IFacturaVentas ) : Boolean;
      function GeneraFacturas( ParametrosFacturacion : IParametrosFacturacion; RelacionAlbaranesTableName : String = '' ) : IParametrosFacturacion;
      procedure SuprimeFactura( Serie : String; NroFactura : LongInt );
      // procedure AnulaFactura( Serie : String; NroFactura : LongInt );
      procedure SuprimeRelaciones( FacturaVentas : IFacturaVentas; SuprimeRegistroFactura : Boolean = True );
      procedure CierreCicloFacturacion( SerieInicial, SerieFinal : String; FechaInicial, FechaFinal: TDate; Contabilizar : Boolean );
      procedure RecuperaFacturas( Serie : String; NroFacturaInicial, NroFacturaFinal  : LongInt );
      function ProximoNroFactura( Serie : String; RegistrarValor : Boolean = True ) : LongInt;
      function ProximoNroRegistroPresentacion( RegistrarValor : Boolean = True ) : LongInt;
      function ObtenBasesyCuotasFactura( Ejercicio : SmallInt; CodigoCliente, Serie : String; NroFactura : LongInt; AplicarDtosyPortes : Boolean = False ) : IBasesyCuotasFactura;
      end;

implementation

{ TBasesyCuotasFactura }


constructor TBasesyCuotasFactura.Create;
begin
     inherited Create( @CLSID_BasesyCuotasFactura, nil, nil, False);
end;

procedure TBasesyCuotasFactura.Clear;
begin
     FillChar( FTasasArray, SizeOf( TTasasArray ), #0 );
     FTotalCuotaIVA := 0.0;
     FTotalCuotaRE  := 0.0;
end;

function TBasesyCuotasFactura.GetClassID: TnxGuid;
begin
     Result := CLSID_BasesyCuotasFactura;
end;

function TBasesyCuotasFactura.GetTasasArray: TTasasArray;
begin
     Result := FTasasArray;
end;

function TBasesyCuotasFactura.GetTotalCuotaIVA: Decimal;
begin
     Result := FTotalCuotaIVA;
end;

function TBasesyCuotasFactura.GetTotalCuotaRE: Decimal;
begin
     Result := FTotalCuotaRE;
end;

function TBasesyCuotasFactura.LoadFromReader(AReader: InxReader): HRESULT;
begin
     With AReader do
       begin

       For var Index := 0 to NroMaximoTiposTasas do
         With FTasasArray[ Index ] do
           begin
           TieneBases := ReadBoolean;
           BaseImponible := ReadCurrency;
           BaseNoSujetaDto := ReadCurrency;
           TipoIVA := ReadCurrency;
           TipoRE := ReadCurrency;
           CuotaIVA := ReadCurrency;
           CuotaRE := ReadCurrency;
           Importe := ReadCurrency;
           end;

       FTotalCuotaIVA := ReadCurrency;
       FTotalCuotaRE := ReadCurrency;
       end;
     Result := S_OK;
end;

function TBasesyCuotasFactura.SaveToWriter(AWriter: InxWriter): HRESULT;
begin
      With AWriter do
       begin

        For var Index := 0 to NroMaximoTiposTasas do
         With FTasasArray[ Index ] do
           begin
           WriteBoolean( TieneBases );
           WriteCurrency( BaseImponible );
           WriteCurrency( BaseNoSujetaDto );
           WriteCurrency( TipoIVA );
           WriteCurrency( TipoRE );
           WriteCurrency( CuotaIVA );
           WriteCurrency( CuotaRE );
           WriteCurrency( Importe );
           end;

       WriteCurrency( FTotalCuotaIVA );
       WriteCurrency( FTotalCuotaRE );

       end;
      Result := S_OK;
end;

procedure TBasesyCuotasFactura.SetTasasArray(const Value: TTasasArray);
begin
     FTasasArray := Value;
end;

procedure TBasesyCuotasFactura.SetTotalCuotaIVA(const Value: Decimal);
begin
     FTotalCuotaIVA := Value;
end;

procedure TBasesyCuotasFactura.SetTotalCuotaRE(const Value: Decimal);
begin
     FTotalCuotaRE := Value;
end;

var  BasesyCuotasFacturaControl : InxClassFactoryControl;

initialization

   nxInvokeRegistry.RegisterInterface( TypeInfo( IBasesyCuotasFactura ) );
   nxInvokeRegistry.RegisterInterface( TypeInfo( IFacturaVentasService ) );

   TnxClassFactory.RegisterClass( CLSID_BasesyCuotasFactura, TBasesyCuotasFactura, BasesyCuotasFacturaControl );

end.


