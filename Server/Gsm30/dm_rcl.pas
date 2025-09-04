unit dm_rcl;

interface

uses
  Windows, Messages, SysUtils, Classes,
  DB, nxdb,

  LibUtils,
  DataManager,
  ServerDataModule,

  Gim10Fields,
  Gim30Fields,

  dm_iva;

type
  TAcumuladoCliente = record
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

  TRelacionesClienteModule = class( TServerDataModule )
    DmClienteDatEconTable: TnxeTable;
    DmConsumosClienteTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

  public

    DmConsumosClienteFields : TConsumosClienteFields;
    DmClienteDatEconFields : TClienteDatEconFields;

    procedure AltaDatosEconomicos( Ejercicio : SmallInt; CodigoCliente : String; ClienteDatEconTable : TnxeTable = nil );
    procedure CalculaAcumulados( ClienteDatEconFields : TClienteDatEconFields; AcumuladoClienteFields : TAcumuladoClienteFields; MesInicial, MesFinal : SmallInt ); overload;
    procedure CalculaAcumulados( ClienteDatEconFields : TClienteDatEconFields; var AcumuladoCliente : TAcumuladoCliente; MesInicial, MesFinal : SmallInt ); overload;

    procedure ActualizaPendiente( Ejercicio : SmallInt; CodigoCliente : String; importe : Decimal );
    procedure SuprimeReferencias( ClienteFields : TClienteFields );

    procedure CompruebaCredito( ClienteFields : TClienteFields );
    procedure CompruebaRiesgo( ClienteFields : TClienteFields );
    procedure ObtenRiesgoTotal( ClienteFields : TClienteFields; var Riesgo : Decimal; var PendienteFacturar : Decimal ); overload;
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses EnterpriseData,
     SessionData,
     AppManager,

     f_sec,

     dm_ban;

{$R *.DFM}

resourceString
     RsMsg1 = 'Este cliente ha superado el CRÉDITO establecido.';
     RsMsg2 = 'El cliente de código [%s] ha sido dado de baja.';
     RsMsg3 = 'No existe ninguna ficha de cliente o deudor cuya subcuenta sea la %s.';
     RsMsg4 = 'Este cliente ha superado el Riesgo LÍMITE establecido.';
     RsMsg5 = 'La ficha de este cliente consta como BLOQUEADA y no puede ser usada.';

procedure TRelacionesClienteModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmClienteDatEconFields := TClienteDatEconFields.Create( DmClienteDatEconTable );
     DmConsumosClienteFields := TConsumosClienteFields.Create( DmConsumosClienteTable );
end;

procedure TRelacionesClienteModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm30.RelacionesClienteModule := nil
end;

procedure TRelacionesClienteModule.AltaDatosEconomicos( Ejercicio            : SmallInt;
                                                        CodigoCliente        : String;
                                                        ClienteDatEconTable : TnxeTable = nil );
begin
    with DmClienteDatEconTable do
      begin
      Append;
      DmClienteDatEconFields.Ejercicio.Value := Ejercicio;
      DmClienteDatEconFields.Codigo.Value := CodigoCliente;
      Post;
      If   Assigned( ClienteDatEconTable )
      then ClienteDatEconTable.GotoCurrent( DmClienteDatEconTable );
      end;
end;

procedure TRelacionesClienteModule.CalculaAcumulados( ClienteDatEconFields   : TClienteDatEconFields;
                                                      AcumuladoClienteFields : TAcumuladoClienteFields;
                                                      MesInicial,
                                                      MesFinal               : SmallInt );
var  SecuenciaMes : TSecuenciaMes;

begin
     SecuenciaMes := TSecuenciaMes.Create( SessionDataModule );
     With ClienteDatEconFields, AcumuladoClienteFields do
       try

         TotalImporteCoste.Value := 0.0;
         TotalImporteDescuentos.Value := 0.0;
         TotalImporteVentas.Value := 0.0;

         SecuenciaMes.Reset( MesInicial, MesFinal );
         With SecuenciaMes do
           repeat
             TotalImporteCoste.Value := TotalImporteCoste.Value + Coste[ MesActual ].Value;
             TotalImporteVentas.Value := TotalImporteVentas.Value + Ventas[ MesActual ].Value;
             TotalImporteDescuentos.Value := TotalImporteDescuentos.Value + Descuentos[ MesActual ].Value;
           until UltimoMes;

       finally
         SecuenciaMes.Free;
         end;
end;

procedure TRelacionesClienteModule.CalculaAcumulados(     ClienteDatEconFields : TClienteDatEconFields;
                                            var AcumuladoCliente     : TAcumuladoCliente;
                                                MesInicial,
                                                MesFinal             : SmallInt );
var  SecuenciaMes : TSecuenciaMes;

begin
     SecuenciaMes := TSecuenciaMes.Create( SessionDataModule );
     With ClienteDatEconFields, AcumuladoCliente do
       try

         TotalImporteCoste := 0.0;
         TotalImporteDescuentos := 0.0;
         TotalImporteVentas := 0.0;

         SecuenciaMes.reset( MesInicial, MesFinal );
         With SecuenciaMes do
           repeat
             DecAdd( TotalImporteCoste, Coste[ MesActual ].Value );
             DecAdd( TotalImporteVentas, Ventas[ MesActual ].Value );
             DecAdd( TotalImporteDescuentos, Descuentos[ MesActual ].Value );
           until UltimoMes;

       finally
         SecuenciaMes.Free;
       end;
end;

procedure TRelacionesClienteModule.ActualizaPendiente( Ejercicio     : SmallInt;
                                                       CodigoCliente : String;
                                                       Importe       : Decimal );
begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmClienteDatEconTable ] );

     try
       If   not DmClienteDatEconTable.FindKey( [ Ejercicio, CodigoCliente ] )
       then AltaDatosEconomicos( Ejercicio, CodigoCliente ); // Utiliza la misma tabla : DmClienteDatEconTable

       try
         DmClienteDatEconTable.Edit;
         DmClienteDatEconFields.Pendiente.Value := DmClienteDatEconFields.Pendiente.Value + Importe;
         DmClienteDatEconTable.Post;
       except
         DmClienteDatEconTable.Cancel;
         raise;
         end;

       TransactionTag.Commit;

     except
       TransactionTag.Rollback;
       raise;
       end;
end;

procedure TRelacionesClienteModule.SuprimeReferencias( ClienteFields : TClienteFields );
begin
     SuprimeReferencias( ClienteFields );
     With DmClienteDatEconTable do
       If   FindKey( [ SessionDataModule.Ejercicio, ClienteFields.Codigo.Value ] )
       then Delete;
end;

procedure TRelacionesClienteModule.CompruebaCredito( ClienteFields : TClienteFields );
begin
     If   ClienteFields.Factura_Credito.Value<>0.0
     then With DmClienteDatEconTable do
            If   FindKey( [ SessionDataModule.Ejercicio, ClienteFields.Codigo.Value ] )
            then If   DmClienteDatEconFields.Pendiente.Value>ClienteFields.Factura_Credito.Value
                 then SessionDataModule.SendNotification( ntWarning, RsMsg1 );
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
     Riesgo := SessionDataModule.Dm10.EfectoCobrarModule.ObtenRiesgoCliente( SessionDataModule.Ejercicio,
                                                                             ClienteFields.Subcuenta.Value,
                                                                             Cargos,
                                                                             EnCartera,
                                                                             Descontado,
                                                                             Impagados );
     PendienteFacturar := 0.0;
     With DmClienteDatEconTable do
       If   FindKey( [ SessionDataModule.Ejercicio, ClienteFields.Codigo.Value ] )
       then PendienteFacturar := DmClienteDatEconFields.Pendiente.Value;
end;

end.
