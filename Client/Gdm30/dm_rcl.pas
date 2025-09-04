unit dm_rcl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  DB, nxdb, DataManager,

  LibUtils,
  AppForms,

  Gim10Fields,
  Gim30Fields,

  dm_cli;

type  TAcumuladoCliente = record
        TotalImporteCoste,
        TotalImporteVentas,
        TotalImporteDescuentos : Decimal;
        end;

      TAcumuladoClienteFields = class( TnxeDatasetFields )
        public
        TotalImporteCoste,
        TotalImporteDescuentos,
        TotalImporteVentas,
        DescuentosSobreVentas,
        MargenMedio : TBCDField;
        end;

type
  TRelacionesClienteModule = class( TDataModule )
    DmClienteDatEconTable: TnxeTable;
    DmConsumosClienteTable: TnxeTable;
    procedure RelacionesClienteModuleCreate(Sender: TObject);
    procedure RelacionesClienteModuleDestroy(Sender: TObject);

  private

    FConsumosClienteFields : TConsumosClienteFields;
    FClienteDatEconFields : TClienteDatEconFields;

  public

    procedure AltaDatosEconomicos( Ejercicio : SmallInt; CodigoCliente : String; ClienteDatEconTable : TnxeTable );
    procedure CalculaAcumulados( ClienteDatEconFields : TClienteDatEconFields; AcumuladoClienteFields : TAcumuladoClienteFields; MesInicial, MesFinal : SmallInt ); overload;
    procedure CalculaAcumulados( ClienteDatEconFields : TClienteDatEconFields; var AcumuladoCliente : TAcumuladoCliente; MesInicial, MesFinal : SmallInt ); overload;

    procedure ActualizaPendiente( CodigoCliente : String; importe : Decimal );
    procedure SuprimeReferencias( ClienteFields : TClienteFields );

    procedure CompruebaCredito( ClienteFields : TClienteFields );
    procedure CompruebaRiesgo( ClienteFields : TClienteFields );
    procedure ObtenRiesgoTotal( ClienteFields : TClienteFields; var Riesgo : Decimal; var PendienteFacturar : Decimal ); overload;

    property ConsumosClienteFields : TConsumosClienteFields read FConsumosClienteFields;
    property ClienteDatEconFields : TClienteDatEconFields read FClienteDatEconFields;

  end;

var RelacionesClienteModule: TRelacionesClienteModule = nil;

function RelacionesCliente : TRelacionesClienteModule;

implementation

uses AppManager,
     EnterpriseDataAccess,
     AppContainer,

     Gim00Fields,

     dm_sec,
     dm_sub,
     dm_sal,
     dm_ecc,

     b_msg,
     b_pro;

{$R *.DFM}

resourceString
     rsMsg1 = 'Este cliente ha superado el CRÉDITO establecido.';
     rsMsg2 = 'El cliente de código [%s] ha sido dado de baja.';
     rsMsg3 = 'No existe ninguna ficha de cliente o deudor cuya subcuenta sea la %s.';
     rsMsg4 = 'Este cliente ha superado el Riesgo LÍMITE establecido.';
     rsMsg5 = 'La ficha de este cliente consta como BLOQUEADA y no puede ser usada.';

function RelacionesCliente : TRelacionesClienteModule;
begin
     CreateDataModule( TRelacionesClienteModule, RelacionesClienteModule );
     Result := RelacionesClienteModule;
end;

procedure TRelacionesClienteModule.RelacionesClienteModuleCreate(Sender: TObject);
begin
     FClienteDatEconFields := TClienteDatEconFields.Create( DmClienteDatEconTable );
     FConsumosClienteFields := TConsumosClienteFields.Create( DmConsumosClienteTable );
end;

procedure TRelacionesClienteModule.RelacionesClienteModuleDestroy(Sender: TObject);
begin
     RelacionesClienteModule := nil;
end;

procedure TRelacionesClienteModule.AltaDatosEconomicos( Ejercicio            : SmallInt;
                                                        CodigoCliente        : String;
                                                        ClienteDatEconTable : TnxeTable );
begin
    with DmClienteDatEconTable do
      begin
      Append;
      FClienteDatEconFields.Ejercicio.Value := Ejercicio;
      FClienteDatEconFields.Codigo.Value := CodigoCliente;
      Post;
      If   Assigned( ClienteDatEconTable )
      then ClienteDatEconTable.GotoCurrent( DmClienteDatEconTable );
      end;
end;

procedure TRelacionesClienteModule.CalculaAcumulados( ClienteDatEconFields   : TClienteDatEconFields;
                                                      AcumuladoClienteFields : TAcumuladoClienteFields;
                                                      MesInicial,
                                                      MesFinal               : SmallInt );
begin
     With ClienteDatEconFields, AcumuladoClienteFields do
       begin

       TotalImporteCoste.Value := 0.0;
       TotalImporteDescuentos.Value := 0.0;
       TotalImporteVentas.Value := 0.0;

       SecuenciaMes.Reset( MesInicial, MesFinal );
       With SecuenciaMes do
         repeat
           TotalImporteCoste.Value := TotalImporteCoste.Value + Coste[ FMesActual ].Value;
           TotalImporteVentas.Value := TotalImporteVentas.Value + Ventas[ FMesActual ].Value;
           TotalImporteDescuentos.Value := TotalImporteDescuentos.Value + Descuentos[ FMesActual ].Value;
         until FinSecuencia;

       end;
end;

procedure TRelacionesClienteModule.CalculaAcumulados(     ClienteDatEconFields : TClienteDatEconFields;
                                                      var AcumuladoCliente     : TAcumuladoCliente;
                                                          MesInicial,
                                                          MesFinal             : SmallInt );
begin
     With ClienteDatEconFields, AcumuladoCliente do
       begin

       TotalImporteCoste := 0.0;
       TotalImporteDescuentos := 0.0;
       TotalImporteVentas := 0.0;

       SecuenciaMes.Reset( MesInicial, MesFinal );
       With SecuenciaMes do
         repeat
           DecAdd( TotalImporteCoste, Coste[ FMesActual ].Value );
           DecAdd( TotalImporteVentas, Ventas[ FMesActual ].Value );
           DecAdd( TotalImporteDescuentos, Descuentos[ FMesActual ].Value );
         until FinSecuencia;

       end;
end;

procedure TRelacionesClienteModule.ActualizaPendiente( CodigoCliente : String;
                                                       Importe       : Decimal );
begin
     With DmClienteDatEconTable do
       try
         If   not FindKey( [ ApplicationContainer.Ejercicio, CodigoCliente ] )
         then AltaDatosEconomicos( ApplicationContainer.Ejercicio, CodigoCliente, DmClienteDatEconTable );
         Edit;
         FClienteDatEconFields.Pendiente.Value := FClienteDatEconFields.Pendiente.Value + Importe;
         Post;
       except
         Cancel;
         raise;
         end;
end;

procedure TRelacionesClienteModule.SuprimeReferencias( ClienteFields : TClienteFields );
begin
     Cliente.SuprimeReferencias( ClienteFields );
     With DmClienteDatEconTable do
       If   FindKey( [ ApplicationContainer.Ejercicio, ClienteFields.Codigo.Value ] )
       then Delete;
end;

procedure TRelacionesClienteModule.CompruebaCredito( ClienteFields : TClienteFields );
begin
     If   ClienteFields.Factura_Credito.Value<>0.0
     then With DmClienteDatEconTable do
            If   FindKey( [ ApplicationContainer.Ejercicio, ClienteFields.Codigo.Value ] )
            then If   FClienteDatEconFields.Pendiente.Value>ClienteFields.Factura_Credito.Value
                 then ShowNotification( ntWarning, RsMsg1, ''  );
end;

procedure TRelacionesClienteModule.CompruebaRiesgo( ClienteFields : TClienteFields );

var   Riesgo,
      PendienteFacturar : Decimal;

begin
     If   ClienteFields.Cobro_RiesgoLimite.Value<>0.0
     then begin
          ObtenRiesgoTotal( ClienteFields, Riesgo, PendienteFacturar );
          If   Riesgo>=ClienteFields.Cobro_RiesgoLimite.Value
          then ShowNotification( ntWarning, rsMsg4, '' );
          end;
end;

procedure TRelacionesClienteModule.ObtenRiesgoTotal(     ClienteFields     : TClienteFields;
                                                     var Riesgo            : Decimal;
                                                     var PendienteFacturar : Decimal );

var  Cargos,
     EnCartera,
     Descontado,
     Impagados : Decimal;

begin
     Riesgo := EfectoCobrar.ObtenRiesgoCliente( ClienteFields.Subcuenta.Value, Cargos, EnCartera, Descontado, Impagados );
     PendienteFacturar := 0.0;
     With DmClienteDatEconTable do
       If   FindKey( [ ApplicationContainer.Ejercicio, ClienteFields.Codigo.Value ] )
       then PendienteFacturar := FClienteDatEconFields.Pendiente.Value;
end;

end.
