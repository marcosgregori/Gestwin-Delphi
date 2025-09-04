
unit dm_fac;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Generics.Defaults, Generics.Collections,
  LibUtils,
  DB,
  Nxdb,
  DataManager,

  cxTextEdit,

  Gim00Fields,
  Gim10Fields,

  AsientoIntf,

  dmi_iva,
  dmi_fac,

  dm_pai;

type

  TFacturaModule = class(TDataModule)
    DmFacturaContableTable: TnxeTable;
    DmFacturaComercialTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);

  private

    FacturaService : IFacturaService;

    DsPaisFields : TPaisFields;

  public

    DmFacturaContableFields : TFacturaFields;
    DmFacturaComercialFields : TFacturaFields;

    function ObtenRegistroContableFactura( Tipo,
                                           Ejercicio     : SmallInt;
                                           NroAsiento    : Integer;
                                           FacturaFields : TFacturaFields ) : Boolean;

    function  ObtenRegistroComercialFactura( Tipo,
                                             Ejercicio     : SmallInt;
                                             Propietario,
                                             Serie         : String;
                                             NroRegistro   : Integer;
                                             FacturaFields : TFacturaFields ) : Boolean;

    procedure SuprimeRegistroContableFactura( Tipo         : SmallInt;
                                              NroAsiento  : Integer);

    procedure SuprimeRegistroComercialFactura( Tipo         : SmallInt;
                                               Propietario,
                                               Serie        : String;
                                               NroRegistro  : Integer);

    procedure CompletaRegistroFacturaExpedida( CodigoProvincia        : String;
                                               CodigoPais             : String;
                                               Rectificativa          : Boolean;
                                               Simplificada           : Boolean;
                                               VentasOnline           : Boolean;
                                               FacturaFields          : TFacturaFields );

    procedure CompletaRegistroFacturaRecibida( SubcuentaPropietario,
                                               CodigoPais             : String;
                                               ModeloIVA              : TModeloIVAProveedor;
                                               FacturaFields          : TFacturaFields );


    function SeleccionaRegistrosFrasExpedidas( DiarioTableName        : String;
                                               DeclaracionInformativa : Boolean;
                                               LibrosRegistro         : TLibrosRegistro;
                                               SerieInicial,
                                               SerieFinal             : String;
                                               FechaInicial,
                                               FechaFinal             : TDateTime;
                                               PorTipoIVA             : Boolean = False;
                                               TipoIVA                : SmallInt = 0;
                                               PorTipoRetencion       : Boolean = False;
                                               TipoRetencion          : SmallInt = 0;
                                               SoloTablaResumen       : Boolean = False ) : IAcumuladoFacturacion;

    function SeleccionaRegistrosFrasRecibidas( DiarioTableName        : String;
                                               DeclaracionInformativa : Boolean;
                                               LibrosRegistro         : TLibrosRegistro;
                                               FechaInicial,
                                               FechaFinal             : TDateTime;
                                               PrimerNroOrden         : Integer = 0;
                                               PorTipoIVA             : Boolean = False;
                                               TipoIVA                : SmallInt = 0;
                                               PorTipoRetencion       : Boolean = False;
                                               TipoRetencion          : SmallInt = 0;
                                               SoloTablaResumen       : Boolean = False ) : IAcumuladoFacturacion;

    function ImportePendienteFacturaEmitida(     Ejercicio          : SmallInt;
                                                 Serie              : String;
                                                 NroFactura         : LongInt;
                                             var ImporteEfectos     : Decimal;
                                             var ImportePendiente   : Decimal ) : Boolean;

    function ObtenImportesFacturaEmitida(     Ejercicio     : SmallInt;
                                              Serie         : String;
                                              NroFactura    : Integer;
                                          out Asiento       : IAsiento;
                                          out BaseImponible,
                                              CuotaIVA,
                                              CuotaRE,
                                              ImporteTotal  : Decimal ) : Boolean;

    function ObtenImportesFacturaRecibida(     Ejercicio       : SmallInt;
                                               Propietario,
                                               SerieNroFactura : String;
                                           out Asiento         : IAsiento;
                                           out BaseImponible,
                                               CuotaIVA,
                                               ImporteTotal    : Decimal ) : Boolean;

    function ObtenCodigoAgrupacionDeudor(     Subcuenta           : String;
                                              AgruparPorNIF       : Boolean;
                                          var PropietarioConFicha : Boolean;
                                          var CodigoAgrupacion    : String;
                                              ClienteFields       : TClienteFields  ) : Boolean;

    function ObtenCodigoAgrupacionAcreedor(     Origen              : SmallInt;
                                                Subcuenta           : String;
                                                AgruparPorNIF       : Boolean;
                                            var PropietarioConFicha : Boolean;
                                            var CodigoAgrupacion    : String;
                                                ProveedorFields     : TProveedorFields  ) : Boolean;

    function TextoSerieNroFactura(Serie: String; NroFactura: Integer): String;

    procedure CompruebaRegistroFacturaAsiento( NroAsiento : LongInt );

    function ObtenRelacionOperacionesIntracomunitarias( OperacionesTableName : String;
                                                        Periodicidad         : SmallInt;
                                                        FechaInicial,
                                                        FechaFinal           : TDateTime ) : IAcumuladoOperacionesIntracomunitarias;

    function SerieNroFacturaValidoSII( NroSerieFactura : String ) : String;

  end;

var  FacturaModule: TFacturaModule = nil;

const  SerieNroFacturaCharSet = AlfaNumCharSet +  [ ' ', '-', '_', '/', '.' ];

function  Factura : TFacturaModule;

implementation

uses System.Types,
     DateUtils,
     nxrbTypes,
     nxrdClass,

     Gdm00Dm,

     AppContainer,
     AppManager,
     NexusRpcData,

     FacturaIntf,

     dm_cli,
     dm_pro, SessionDataAccess;

{$R *.DFM}

resourceString
     RsMsg1 = 'No se ha podido marcar el registro de la factura con asiento nº %d como anulada.';
     RsMsg2 = 'Edite el registro y anulela manualmente.';
     RsMsg3 = 'No se ha podido marcar la factura nº %s %d como anulada.';

function Factura : TFacturaModule;
begin
     CreateDataModule( TFacturaModule, FacturaModule );
     Result := FacturaModule;
end;

{ TFacturaModule }

procedure TFacturaModule.ServerDataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_FacturaService, IFacturaService, FacturaService );

     DmFacturaContableFields := TFacturaFields.Create( DmFacturaContableTable );
     DmFacturaComercialFields := TFacturaFields.Create( DmFacturaComercialTable );

     DsPaisFields := TPaisFields.Create( Self );
end;

procedure TFacturaModule.ServerDataModuleDestroy(Sender: TObject);
begin
     FacturaModule := nil;
end;

function TFacturaModule.ImportePendienteFacturaEmitida(     Ejercicio          : SmallInt;
                                                            Serie              : String;
                                                            NroFactura         : LongInt;
                                                        var ImporteEfectos     : Decimal;
                                                        var ImportePendiente   : Decimal ) : Boolean;
begin
     Result := FacturaService.ImportePendienteFacturaEmitida( Ejercicio, Serie, NroFactura, ImporteEfectos, ImportePendiente );
end;

function TFacturaModule.SeleccionaRegistrosFrasExpedidas( DiarioTableName        : String;
                                                          DeclaracionInformativa : Boolean;
                                                          LibrosRegistro         : TLibrosRegistro;
                                                          SerieInicial,
                                                          SerieFinal             : String;
                                                          FechaInicial,
                                                          FechaFinal             : TDateTime;
                                                          PorTipoIVA             : Boolean = False;
                                                          TipoIVA                : SmallInt = 0;
                                                          PorTipoRetencion       : Boolean = False;
                                                          TipoRetencion          : SmallInt = 0;
                                                          SoloTablaResumen       : Boolean = False ) : IAcumuladoFacturacion;
begin
     Result := FacturaService.SeleccionaRegistrosFrasExpedidas( DiarioTableName, DeclaracionInformativa, LibrosRegistro, SerieInicial, SerieFinal, FechaInicial, FechaFinal, PorTipoIVA, TipoIVA, PorTipoRetencion, TipoRetencion, SoloTablaResumen );
end;

function TFacturaModule.SeleccionaRegistrosFrasRecibidas( DiarioTableName        : String;
                                                          DeclaracionInformativa : Boolean;
                                                          LibrosRegistro         : TLibrosRegistro;
                                                          FechaInicial,
                                                          FechaFinal             : TDateTime;
                                                          PrimerNroOrden         : Integer = 0;
                                                          PorTipoIVA             : Boolean = False;
                                                          TipoIVA                : SmallInt = 0;
                                                          PorTipoRetencion       : Boolean = False;
                                                          TipoRetencion          : SmallInt = 0;
                                                          SoloTablaResumen       : Boolean = False ) : IAcumuladoFacturacion;
begin
     Result := FacturaService.SeleccionaRegistrosFrasRecibidas( DiarioTableName, DeclaracionInformativa, LibrosRegistro, FechaInicial, FechaFinal, PrimerNroOrden, PorTipoIVA, TipoIVA, PorTipoRetencion, TipoRetencion, SoloTablaResumen );
end;

function TFacturaModule.ObtenRelacionOperacionesIntracomunitarias( OperacionesTableName : String;
                                                                   Periodicidad         : SmallInt;
                                                                   FechaInicial,
                                                                   FechaFinal           : TDateTime ) : IAcumuladoOperacionesIntracomunitarias;
begin
     Result := FacturaService.ObtenRelacionOperacionesIntracomunitarias( OperacionesTableName, Periodicidad, FechaInicial, FechaFinal );
end;

function TFacturaModule.ObtenImportesFacturaEmitida(     Ejercicio     : SmallInt;
                                                         Serie         : String;
                                                         NroFactura    : Integer;
                                                     out Asiento       : IAsiento;
                                                     out BaseImponible,
                                                         CuotaIVA,
                                                         CuotaRE,
                                                         ImporteTotal  : Decimal ) : Boolean;
begin
     Result := FacturaService.ObtenImportesFacturaEmitida( Ejercicio, Serie, NroFactura, Asiento, BaseImponible, CuotaIVA, CuotaRE, ImporteTotal );
end;

function TFacturaModule.ObtenImportesFacturaRecibida(     Ejercicio        : SmallInt;
                                                          Propietario,
                                                          SerieNroFactura  : String;
                                                      out Asiento          : IAsiento;
                                                      out BaseImponible,
                                                          CuotaIVA,
                                                          ImporteTotal     : Decimal ) : Boolean;
begin
     Result := FacturaService.ObtenImportesFacturaRecibida( Ejercicio, Propietario, SerieNroFactura, Asiento, BaseImponible, CuotaIVA, ImporteTotal );
end;

function TFacturaModule.ObtenCodigoAgrupacionDeudor(     Subcuenta           : String;
                                                         AgruparPorNIF       : Boolean;
                                                     var PropietarioConFicha : Boolean;
                                                     var CodigoAgrupacion    : String;
                                                         ClienteFields       : TClienteFields  ) : Boolean;
begin
     Result := True;
     PropietarioConFicha := Cliente.ObtenPorSubcuenta( Subcuenta, ClienteFields );
     If   AgruparPorNIF
     then begin
          If   PropietarioConFicha and ( ClienteFields.NIF.Value<>'' )
          then CodigoAgrupacion := ClienteFields.NIF.Value
          else Result := False;
          end
     else CodigoAgrupacion := Subcuenta;
end;

function TFacturaModule.SerieNroFacturaValidoSII( NroSerieFactura : String): String;

var  Se : Boolean;

begin
     Se := False;
     NroSerieFactura := Trim( NroSerieFactura );
     // Solo se permite un espacio embebido
     var Inx := 1;
     While Inx<=Length( NroSerieFactura ) do
       begin
       If   NroSerieFactura[ Inx ]=' '
       then If   Se
            then begin
                 Delete( NroSerieFactura, Inx, 1 );
                 Continue;
                 end
            else Se := True;
       Inc( Inx );
       end;
     Result := NroSerieFactura;
end;

function TFacturaModule.ObtenCodigoAgrupacionAcreedor(     Origen              : SmallInt;
                                                           Subcuenta           : String;
                                                           AgruparPorNIF       : Boolean;
                                                       var PropietarioConFicha : Boolean;
                                                       var CodigoAgrupacion    : String;
                                                           ProveedorFields     : TProveedorFields  ) : Boolean;
begin
     Result := True;
     PropietarioConFicha := Proveedor.ObtenPorSubcuenta( Subcuenta, ProveedorFields );
     If   AgruparPorNIF
     then begin
          If   PropietarioConFicha and ( ProveedorFields.NIF.Value<>'' )
          then CodigoAgrupacion := ProveedorFields.NIF.Value
          else Result := False;
          end
     else CodigoAgrupacion := Subcuenta;

     CodigoAgrupacion := CodigoAgrupacion + IntToStr( Origen );

end;

function TFacturaModule.ObtenRegistroContableFactura( Tipo,
                                                      Ejercicio     : SmallInt;
                                                      NroAsiento    : Integer;
                                                      FacturaFields : TFacturaFields ) : Boolean;
begin
     Result := DmFacturaContableTable.FindKey( [ Tipo, Ejercicio, NroAsiento ] );
     FacturaFields.Update( DmFacturaContableTable );
end;

procedure TFacturaModule.SuprimeRegistroContableFactura( Tipo       : SmallInt;
                                                         NroAsiento : Integer );
begin
     If   DmFacturaContableTable.FindKey( [ Tipo, ApplicationContainer.Ejercicio, NroAsiento ] )
     then DmFacturaContableTable.Delete;
end;

function TFacturaModule.ObtenRegistroComercialFactura( Tipo,
                                                       Ejercicio     : SmallInt;
                                                       Propietario,
                                                       Serie         : String;
                                                       NroRegistro   : Integer;
                                                       FacturaFields : TFacturaFields ) : Boolean;
begin
     Result := DmFacturaComercialTable.FindKey( [ Tipo, Ejercicio, Propietario, Serie, NroRegistro ] );
     FacturaFields.Update( DmFacturaComercialTable );
end;

procedure TFacturaModule.SuprimeRegistroComercialFactura( Tipo         : SmallInt;
                                                          Propietario,
                                                          Serie        : String;
                                                          NroRegistro  : Integer);
begin
     If   DmFacturaComercialTable.FindKey( [ Tipo, ApplicationContainer.Ejercicio, Propietario, Serie, NroRegistro ] )
     then DmFacturaComercialTable.Delete;
end;

procedure TFacturaModule.CompletaRegistroFacturaExpedida( CodigoProvincia        : String;
                                                          CodigoPais             : String;
                                                          Rectificativa          : Boolean;
                                                          Simplificada           : Boolean;
                                                          VentasOnline           : Boolean;
                                                          FacturaFields          : TFacturaFields );

var TipoFactura,
    RegimenOTrascendencia,
    CausaExencion : SmallInt;

begin
     FacturaService.CompletaRegistroFacturaExpedida( CodigoProvincia,
                                                     CodigoPais,
                                                     Rectificativa,
                                                     Simplificada,
                                                     VentasOnline,
                                                     TipoFactura,
                                                     RegimenOTrascendencia,
                                                     CausaExencion );
     FacturaFields.Creado.Value := Now;
     FacturaFields.TipoFactura.Value := TipoFactura;
     FacturaFields.RegimenOTrascendencia.Value := RegimenOTrascendencia;
     FacturaFields.CausaExencion.Value := CausaExencion;
end;

procedure TFacturaModule.CompletaRegistroFacturaRecibida( SubcuentaPropietario,
                                                          CodigoPais            : String;
                                                          ModeloIVA             : TModeloIVAProveedor;
                                                          FacturaFields         : TFacturaFields );

var TipoFactura,
    RegimenOTrascendencia,
    TipoOperacionIntracomunitaria : SmallInt;

begin
     FacturaService.CompletaRegistroFacturaRecibida( SubcuentaPropietario,
                                                     CodigoPais,
                                                     ModeloIVA,
                                                     TipoFactura,
                                                     RegimenOTrascendencia,
                                                     TipoOperacionIntracomunitaria );
     FacturaFields.Creado.Value := Now;
     FacturaFields.TipoFactura.Value := TipoFactura;
     FacturaFields.RegimenOTrascendencia.Value := RegimenOTrascendencia;
     FacturaFields.TipoOperacionIntracomunitaria.Value := TipoOperacionIntracomunitaria;
end;

procedure TFacturaModule.CompruebaRegistroFacturaAsiento( NroAsiento : LongInt );
begin
     If   not DmFacturaContableTable.FindKey( [ tfAsiento, ApplicationContainer.Ejercicio, NroAsiento] )
     then begin
          DmFacturaContableTable.Append;

          DmFacturaContableFields.Tipo.Value := tfAsiento;
          DmFacturaContableFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
          DmFacturaContableFields.Propietario.Value := '';
          DmFacturaContableFields.SerieFactura.Value := '';
          DmFacturaContableFields.NroRegistro.Value := NroAsiento;

          DmFacturaContableTable.Post;
          end;
end;

function TFacturaModule.TextoSerieNroFactura( Serie : String; NroFactura : LongInt ) : String;
begin
     Result := Serie;
     If   NroFactura<>0
     then Result := Result + ' ' + IntToStr( NroFactura );
end;

end.
