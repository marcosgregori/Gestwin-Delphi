
unit dm_cri116;

interface

uses
  Windows, Messages, SysUtils, Classes,
  LibUtils,
  DB,
  Nxdb,
  DataManager,
  ServerDataModule,
  SessionIntf,

  Gim10Fields,
  Gim30Fields,
  Gim116Fields,

  dmi_mov,
  dmi_cri116;

type

    TCristaleria116Service = class( TSessionModule, ICristaleria116Service )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public

      procedure Inicializa;

    end;

  TCristaleria116Module = class(TServerDataModule)
    MovimientoTable: TnxeTable;
    LineaValoracionManufacturaTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

    MovimientoFields : TMovimientoFields;
    LineaValoracionManufacturaFields : TLineaValoracionManufacturaFields;

    ArticuloFields : TArticuloFields;

    procedure ObtenPrecioVenta(     TipoMovimiento  : TTipoMovimiento;
                                    ClienteFields   : TClienteFields;
                                    ArticuloFields  : TArticuloFields;
                                    CodigoClaseA,
                                    CodigoClaseB,
                                    CodigoClaseC    : String;
                                    Cantidad        : Decimal;
                                var Precio          : Double );

    function ParametroChecked( Value, ParamIndex : SmallInt ) : Boolean;

    procedure CalculaImporteManufactura( LineaMovimientoFields            : TLineaMovimientoFields;
                                         LineaValoracionManufacturaFields : TLineaValoracionManufacturaFields;
                                         ArticuloFields                   : TArticuloFields;
                                         ClienteFields                    : TClienteFields );

    procedure DoCalculaImportes( LineaMovimientoFields : TLineaMovimientoFields;
                                 ArticuloFields        : TArticuloFields );

    procedure DoOnActualizaCamposCalculadosLineaVenta( MovimientoFields       : TMovimientoFields;
                                                       LineaMovimientoFields  : TLineaMovimientoFields;
                                                       ClienteFields          : TClienteFields;
                                                       ArticuloFields         : TArticuloFields;
                                                       SerieFacturacionFields : TSerieFacturacionFields;
                                                       TiposIVAFields         : TTiposIVAFields );


  public

    procedure Inicializa;

    end;


implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses DateUtils,
     Math,

     nxrbTypes,
     nxrdClass,
     nxsdDataDictionaryStrings,

     AppManager,
     EnterpriseData,

     Gim00Fields,

     SessionData,

     Gsm103Dm,

     ParametrosFacturacionIntf,

     dmi_fdv,

     dm_cli,
     dm_mov,
     dm_tma,
     dm_sdf,
     dm_pga,
     dm_art,
     dm_sto,
     dm_fdv;

{$R *.DFM}

resourceString

   RsMsg1 = '';

procedure TCristaleria116Module.ServerDataModuleDestroy(Sender: TObject);
begin
     // De momento no lo utilizo.
     // SessionDataModule.Dm30.ArticuloModule.OnObtenPrecioVenta.Remove( ObtenPrecioVenta );
     SessionDataModule.Dm116.Cristaleria116Module := nil;
end;

procedure TCristaleria116Module.ServerDataModuleCreate(Sender: TObject);
begin

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaValoracionManufacturaFields := TLineaValoracionManufacturaFields.Create( LineaValoracionManufacturaTable );

     ArticuloFields := TArticuloFields.Create( Self );

     // SessionDataModule.Dm30.ArticuloModule.OnObtenPrecioVenta.Add( ObtenPrecioVenta );
end;

procedure TCristaleria116Module.Inicializa;
begin
     SessionDataModule.Dm30.FacturaVentasModule.OnCalculaImportes.Add( DoCalculaImportes );
     SessionDataModule.Dm30.MovimientoModule.OnActualizaCamposCalculadosLineaVenta.Add( DoOnActualizaCamposCalculadosLineaVenta );
end;

function TCristaleria116Module.ParametroChecked( Value, ParamIndex : SmallInt ) : Boolean;
begin
     Result := ( Value and Trunc( Power( 2, ParamIndex ) ) )<>0;
end;

procedure TCristaleria116Module.CalculaImporteManufactura( LineaMovimientoFields            : TLineaMovimientoFields;
                                                           LineaValoracionManufacturaFields : TLineaValoracionManufacturaFields;
                                                           ArticuloFields                   : TArticuloFields;
                                                           ClienteFields                    : TClienteFields );
begin
     With LineaValoracionManufacturaFields do
       begin

       MetrosLineales.Value := ( ( SuperficieLargo.Value * Largo.Value ) + ( SuperficieAncho.Value * Corto.Value ) ) / 100.0;

       If   ParametroChecked( LineaMovimientoFields.Parametros.Value, pinCantoPulido )
       then SubtotalCantos.Value := MetrosLineales.Value * PrecioParametro[ ppCantos ].Value
       else SubtotalCantos.Value := 0.0;

       If   ParametroChecked( LineaMovimientoFields.Parametros.Value, pinTaladro )
       then SubtotalTaladro.Value := ( ( CantidadParametro[ ppTaladros ].Value * PrecioParametro[ ppTaladros ].Value ) +
                                       ( CantidadParametro[ ppEscots ].Value * PrecioParametro[ ppEscots ].Value ) +
                                       ( CantidadParametro[ ppPuntas ].Value * PrecioParametro[ ppPuntas ].Value ) )
       else SubtotalTaladro.Value := 0.0;

       MetrosCuadrados.Value := ( EmbalajeLargo.Value * EmbalajeAncho.Value ) / 10000.0;  // El largo y ancho se introducen en cm

       If   ParametroChecked( LineaMovimientoFields.Parametros.Value, pinEmbalaje )
       then SubtotalEmbalaje.Value := MetrosCuadrados.Value * PrecioParametro[ ppEmbalaje ].Value
       else SubtotalEmbalaje.Value := 0.0;

       // El campo Alto es el número de piezas

       TotalManufactura.Value := Redondea( LineaMovimientoFields.Alto.Value *
                                           ( SubtotalCantos.Value + SubtotalTaladro.Value + SubtotalEmbalaje.Value +
                                           ( CantidadParametro[ ppVarios].Value * PrecioParametro[ ppVarios ].Value ) ) );

       Incremento.Value := Redondea( ( ( LineaMovimientoFields.ImporteBruto.Value + TotalManufactura.Value ) * PorcentajeIncremento.Value ) / 100.0 );

       // El importe neto de la línea se calcula cuando se guarda, en DoCalculaImportes

       ImporteNeto.Value := LineaMovimientoFields.ImporteBruto.Value -
                            LineaMovimientoFields.ImporteDescuento.Value +
                            TotalManufactura.Value +  // ImporteRecargo
                            Incremento.Value;

       end;

end;

procedure TCristaleria116Module.DoCalculaImportes( LineaMovimientoFields : TLineaMovimientoFields;
                                                   ArticuloFields        : TArticuloFields );
begin
     var Incremento := Redondea( ( ( LineaMovimientoFields.ImporteBruto.Value + LineaMovimientoFields.ImporteRecargo.Value ) * LineaMovimientoFields.PorcentajeRecargo.Value ) / 100.0 );

     LineaMovimientoFields.ImporteNeto.Value := LineaMovimientoFields.ImporteBruto.Value -
                                                LineaMovimientoFields.ImporteDescuento.Value +
                                                LineaMovimientoFields.ImporteRecargo.Value +  // TotalManufactura
                                                Incremento;
end;

procedure TCristaleria116Module.DoOnActualizaCamposCalculadosLineaVenta( MovimientoFields       : TMovimientoFields;
                                                                         LineaMovimientoFields  : TLineaMovimientoFields;
                                                                         ClienteFields          : TClienteFields;
                                                                         ArticuloFields         : TArticuloFields;
                                                                         SerieFacturacionFields : TSerieFacturacionFields;
                                                                         TiposIVAFields         : TTiposIVAFields );
begin

       If   MovimientoFields.TipoMovimiento.Value=tmPedidoVenta
       then If   LineaValoracionManufacturaTable.FindKey( [ LineaMovimientoFields.NroRegistro.Value ] )
            then try

                   LineaValoracionManufacturaTable.Edit;
                   CalculaImporteManufactura( LineaMovimientoFields, LineaValoracionManufacturaFields, ArticuloFields, ClienteFields );
                   LineaValoracionManufacturaTable.Post;

                   LineaMovimientoFields.Cantidad.Value := SessionDataModule.Dm30.MovimientoModule.CalculoEspecial( scventas,
                                                                                                                    LineaValoracionManufacturaFields.SuperficieLargo.Value,
                                                                                                                    LineaValoracionManufacturaFields.SuperficieAncho.Value,
                                                                                                                    LineaMovimientoFields.Alto.Value );

                   LineaMovimientoFields.CantidadAjustada.Value := LineaMovimientoFields.Cantidad.Value;

                   LineaMovimientoFields.ImporteRecargo.Value := LineaValoracionManufacturaFields.Totalmanufactura.Value;
                   LineaMovimientoFields.PorcentajeRecargo.Value := LineaValoracionManufacturaFields.PorcentajeIncremento.Value;

                 finally
                   LineaValoracionManufacturaTable.Cancel;
                   end;
end;

procedure TCristaleria116Module.ObtenPrecioVenta(     TipoMovimiento  : TTipoMovimiento;
                                                      ClienteFields   : TClienteFields;
                                                      ArticuloFields  : TArticuloFields;
                                                      CodigoClaseA,
                                                      CodigoClaseB,
                                                      CodigoClaseC    : String;
                                                      Cantidad        : Decimal;
                                                  var Precio          : Double );
begin
     // De momento nada
end;

{ TCristaleria116Service }

procedure TCristaleria116Service.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TCristaleria116Service.Inicializa;
begin
     SessionDataModule.Dm116.Cristaleria116Module.Inicializa;
end;

var Cristaleria116Control : InxClassFactoryControl;

initialization
    TnxClassFactory.RegisterClass( CLSID_Cristaleria116Service, TCristaleria116Service, Cristaleria116Control );

end.
