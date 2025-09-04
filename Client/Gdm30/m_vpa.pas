unit m_vpa;

interface

uses
  SysUtils, Classes,

  DataManager,
  AppContainer,
  DB,
  nxDB,

  Gim30Fields,
  SQLSet,
  QueryGrid;

type
  TVpaQueryModule = class(TPersistentQueryModule)
    SQLSet: TgxSQLSet;
    procedure PersistentQueryModuleUpdate(Sender: TObject);
    procedure PersistentQueryModuleInitialize(Sender: TObject);
  private

    ArticuloFields : TArticuloFields;

  protected

  public

    VentasPeriodicasArticuloFields : TConsultaMovimientoFields;

    SQLText : String;

    Valorar,
    LineasSinCodificar : Boolean;
    Periodicidad,
    SeleccionSerie,
    MesPagoInicial,
    MesPagoFinal : SmallInt;
    Serie,
    ArticuloInicial,
    ArticuloFinal,
    ClienteInicial,
    ClienteFinal : String;
    Agrupar : SmallInt;

  end;

function VistaVentasPeriodicasArticulo( ParamsDataset : TgxMemData ) : TVpaQueryModule;

implementation

uses  LibUtils,
      ReportManager,

      dmi_mov,

      dm_art,
      dm_sto,
      dm_fdv;

{$R *.dfm}

function VistaVentasPeriodicasArticulo( ParamsDataset : TgxMemData ) : TVpaQueryModule;

var  VpaQueryModule : TVpaQueryModule;

begin
     VpaQueryModule := nil;
     CreatePersistentQueryModule( TVpaQueryModule, VpaQueryModule, ParamsDataset );
     Result := VpaQueryModule;
end;

procedure TVpaQueryModule.PersistentQueryModuleInitialize(Sender: TObject);

var  SQLSeleccion : String;

begin

     ArticuloFields := TArticuloFields.Create( Self );

     Valorar := ParamValues[ 'Valorar' ];
     SeleccionSerie := ParamValues[ 'SeleccionSerie' ];
     Serie := ParamValues[ 'Serie' ];
     Periodicidad := ParamValues[ 'Periodicidad' ];
     MesPagoInicial := ParamValues[ 'MesPagoInicial' ];
     MesPagoFinal := ParamValues[ 'MesPagoFinal' ];
     ArticuloInicial := ParamValues[ 'ArticuloInicial' ];
     ArticuloFinal := ParamValues[ 'ArticuloFinal' ];
     ClienteInicial := ParamValues[ 'ClienteInicial' ];
     ClienteFinal := ParamValues[ 'ClienteFinal' ];
     Agrupar := ParamValues[ 'Agrupar' ];
     LineasSinCodificar := ParamValues[ 'LineasSinCodificar' ];

     SQLText := SQLSet.GetSQLText;
     SQLSeleccion := '';

     If   SeleccionSerie<>0
     then SQLAddCondition( SQLSeleccion, 'Serie=? ', [ Serie ] ) ;

     If   Periodicidad<>0   // Todas
     then SQLAddCondition( SQLSeleccion, 'Periodicidad=? ', [ Periodicidad - 1 ] );

     If   Periodicidad<>4  // Mensual
     then SQLAddCondition( SQLSeleccion, 'MesPago BETWEEN ? AND ? ', [ MesPagoInicial, MesPagoFinal ] );

     SQLAddCondition( SQLSeleccion, ' LineaVentaPeriodica.CodigoArticulo BETWEEN ? AND ? ', [ ArticuloInicial, ArticuloFinal ] );
     SQLAddCondition( SQLSeleccion, ' CodigoCliente BETWEEN ? AND ? ', [ ClienteInicial, ClienteFinal ] );

     If   not LineasSinCodificar
     then SQLAddCondition( SQLSeleccion, 'LineaVentaPeriodica.CodigoArticulo<>? ', [ '.' ] );

     SetSQLVar( SQLText, 'Seleccion', SQLSeleccion );

     StrAdd( SQLText, ' ORDER BY ' );
     If   Agrupar=0
     then StrAdd( SQLText, ' CodigoCliente, ' );
     StrAdd( SQLText, 'CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, NroFicha, NroRegistro ' );

end;

procedure TVpaQueryModule.PersistentQueryModuleUpdate(Sender: TObject);

var  PrecioLinea : Double;
     PuntoVerdeLinea,
     RecargoLinea,
     DescuentoLinea : Decimal;
     EsUnaOferta : Boolean;

begin

     try

       CreateQueryTable( 'VentasPeriodicasArticulo', SQLText, [], QueryTable );

       If   Valorar
       then begin

            ApplicationContainer.StartProgression( QueryTable.RecordCount );

            With QueryTable do
              begin
                VentasPeriodicasArticuloFields := TConsultaMovimientoFields.Create( QueryTable );
                First;
                While not Eof do
                  begin
                  Edit;
                  With VentasPeriodicasArticuloFields do
                    begin

                    Articulo.Obten( CodigoArticulo.Value, ArticuloFields );

                    PrecioLinea := Precio.Value;
                    PuntoVerdeLinea := 0.0;
                    DescuentoLinea := Descuento.Value;
                    RecargoLinea := 0.0;
                    EsUnaOferta := False;

                    Articulo.ObtenPrecioyDtoVenta( tmVenta,
                                                   Propietario.Value,
                                                   CodigoArticulo.Value,
                                                   CodigoClaseA.Value,
                                                   CodigoClaseB.Value,
                                                   CodigoClaseC.Value,
                                                   Cantidad.Value,
                                                   PrecioLinea,
                                                   PuntoVerdeLinea,
                                                   RecargoLinea,
                                                   DescuentoLinea,
                                                   EsUnaOferta,
                                                   '',
                                                   False,
                                                   ApplicationContainer.TodayDate );

                    If   Precio.Value=0.0
                    then Precio.Value := PrecioLinea;

                    If   Descuento.Value=0.0
                    then Descuento.Value := DescuentoLinea;

                    FacturaVentas.CalculaImportes( Cantidad,
                                                   ArticuloFields.UnidadesPrecioVenta,
                                                   Precio,
                                                   PuntoVerde,
                                                   ContribucionRAP,
                                                   Recargo,
                                                   Descuento,
                                                   ImporteBruto,
                                                   ImporteDescuento,
                                                   ImporteNeto );

                    Post;
                    Next;
                    end;
                  ApplicationContainer.ShowProgression;
                  end;
                end;
              end;

     finally
       ApplicationContainer.EndProgression;
       end;

end;

end.
