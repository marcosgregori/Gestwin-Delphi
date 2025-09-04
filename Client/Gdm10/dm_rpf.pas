
unit dm_rpf;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Generics.Collections,

  System.Net.HttpClient,
  System.Net.URLClient,

  LibUtils,
  AppContainer,

  AppForms,
  DB,
  nxdb,
  DataManager,
  NexusRpcData,

  cxEdit,
  cxEditRepositoryItems,

  Soap.SOAPHTTPTrans,
  Soap.SOAPDomConv,
  Soap.InvokeRegistry,
  Soap.Rio,
  Soap.SOAPHTTPClient,
  Soap.OPToSOAPDomConv,

  WinInet,

  clCertificate,

  SuministroFactEmitidas,

  Gim00Fields,
  Gim10Fields,

  dmi_ast,
  dmi_rpf;


type

  TOperacionFacturasSII = ( ofAlta, ofModificacion, ofAnulacion, ofConsulta );
  TOperacionFacturasVerifactu = ( ofvAlta, ofvAnulacion );

  TRelacionFacturasPresentacionFields = class( TnxeDatasetFields)
     public
       Seleccionada : TBooleanField;
       Ejercicio: TSmallintField;
       NroAsiento: TIntegerField;
       Fecha: TDateField;
       Serie: TWideStringField;
       NroFactura: TIntegerField;
       Subcuenta: TWideStringField;
       Descripcion: TWideStringField;
       Importe: TBCDField;
       Tipo : TSmallIntField;
       Propietario : TWideStringField;
       ImporteRegistro: TBCDField;
       FechaPresentacion : TDateField;
       HoraPresentacion : TTimeField;
       EstadoRegistro : TWideStringField;
       CodigoErrorRegistro : TIntegerField;
       DescripcionErrorRegistro : TWideStringField;
     end;

  TDesgloseCuotasIVA = class
    BienInversion,
    PrestacionServicios : Boolean;
    BaseImponible,
    TipoImpositivo,
    TipoRecargoEquivalencia,
    CuotaIVA,
    CuotaRE : Decimal;
    end;

  TRegistroPresentacionModule = class(TDataModule)
    RegistroPresentacionTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private

    RegistroPresentacionService : IRegistroPresentacionService;

    AsientoFields : TAsientoFields;
    ApunteFields : TApunteFields;
    RegistroPresentacionFields : TRegistroPresentacionFields;

    FacturaFields : TFacturaFields;
    AsientoFacturaFields : TAsientoFields;
    ClienteFields : TClienteFields;
    ProveedorFields : TProveedorFields;
    TiposIVAFields : TTiposIVAFields;
    PaisFields : TPaisFields;

    EjercicioPresentacion : SmallInt;

    FResponseHeader : TStringList;

  public

    function EstadoPresentacionSii( Estado : SmallInt { EstadoRegistroSiiType } ): TEstadoPresentacionSII;
    function EstadoRegistroSii( Estado : SmallInt { EstadoRegistroSiiType } ) : TEstadoPresentacionSii;

    function SerieNroFactura( Serie : String; NroFactura : LongInt ) : String;
    function ExtraeSerieNroFactura( NumSerieFacturaEmisor : String; var Serie : String; var NroFactura : LongInt ) : Boolean;

    procedure ActualizaRegistroPresentacionSii( TipoRegistro             : TTipoRegistroPresentacion;
                                                Operacion                : TOperacionFacturasSII;
                                                Propietario,
                                                Serie                    : String;
                                                NroFactura               : Integer;
                                                NIFPropietario           : String;
                                                EstadoPresentacion       : TEstadoPresentacionSii;
                                                CodigoErrorRegistro      : Int64;
                                                DescripcionErrorRegistro : String;
                                                ImporteFactura           : Decimal = 0.0;
                                                ImportePresentacion      : Decimal = 0.0;
                                                FechaPresentacion        : TDate = 0;
                                                FechaExpedicionFactura   : TDate = 0;
                                                EstadoCuadre             : SmallInt = 0 { EstadoCuadreType } );

    function ObtenEstadoPresentacionSii( TipoRegistro : TTipoRegistroPresentacion; Propietario, Serie: String; NroFactura: Integer ) : TEstadoPresentacionSii;

    procedure ActualizaRegistroPresentacionVerifactu( Operacion                : TOperacionFacturasVerifactu;
                                                      Serie                    : String;
                                                      NroFactura               : LongInt;

                                                      EstadoRegistro           : TEstadoRegistroVerifactu;
                                                      CodigoErrorRegistro      : Int64;
                                                      DescripcionErrorRegistro : String;

                                                      FechaPresentacion        : TDate = 0 );

    function ObtenEstadoPresentacionVerifactu(     Serie              : String;
                                                   NroFactura         : Integer;
                                               out EstadoPresentacion : TEstadoPresentacionVerifactu;
                                               out Estadoregistro     : TEstadoregistroVerifactu ) : Boolean;

    procedure SuprimeRegistroPresentacionVerifactu( Serie      : String;
                                                    NroFactura : LongInt );  // Un proceso excepcional que solo debe utilizarse si no se ha conseguido presentar finalmente la factura

    function ObtenUltimoNroFacturaVerifactu(     Serie      : String;
                                             out NroFactura : LongInt ) : Boolean;

    function ObtenRegistroPresentacion( TipoRegistro : TTipoRegistroPresentacion; Propietario, Serie : String; NroFactura : LongInt; RegistroPresentacionFields : TRegistroPresentacionFields = nil ) : Boolean;
    procedure SuprimeRegistroPresentacion(TipoRegistro: TTipoRegistroPresentacion; Propietario, Serie: String; NroFactura: Integer);
    procedure MarcaComoModificadoRegistroPresentacion( TipoRegistro : TTipoRegistroPresentacion; Propietario, Serie : String; NroFactura : LongInt );

    procedure AddResponseHeader( AMethod: string; AResponseHeader: TStrings );
    procedure ShowError( E : Exception );

  end;

var RegistroPresentacionModule: TRegistroPresentacionModule = nil;

function  RegistroPresentacion : TRegistroPresentacionModule;

function EntornoVerifactu : Boolean;
function EntornoPruebasVerifactu : Boolean;
function DecimalString(Valor: Decimal; Decimales: SmallInt = 2 ): String;

resourceString

     RpfMsg1  = 'No se ha seleccionado ningún registro.';
     RpfMsg2  = 'Factura nº %s suministrada correctamente.';
     RpfMsg3  = 'Error en la factura nº %s. Descripcion : %s.';
     RpfMsg4  = 'Se ha producido un error';
     RpfMsg5  = 'No se ha podido recuperar la factura original de la rectificativa %s.';
     RpfMsg6  = 'Factura nº %s.';
     RpfMsg7  = 'Debe seleccionar un certificado válido para realizar las operaciones.';
     RpfMsg8  = 'Vaya a la sección de configuración y seleccione uno en la opción "Configuración de seguridad"';
     RpfMsg9  = 'No se ha podido recuperar la ficha del propietario con la subcuenta %s.';
     RpfMsg10 = 'No se ha podido recuperar el registro de la factura del asiento nº %d.';
     RpfMsg11 = 'Las prestaciones de servicios no pueden contener recargo de equivalencia.';
     RpfMsg12 = 'El importe presentado (%f), no coincide con el de la factura (%f).';
     RpfMsg13 = 'La factura recibida %s del acreedor %s (con NIF. %s) consta como presentada, pero no está en los registros de la aplicación.';
     RpfMsg14 = 'Fecha de presentación : %s, importe: %0.2f.';
     RpfMsg15 = 'La factura expedida %s consta como presentada, pero no está en los registros de la aplicación.';
     RpfMsg16 = 'La factura expedida %s consta como presentada, pero está asignada al propietario de NIF %s.';
     RpfMsg17 = 'La factura recibida %s del propietario %s consta como presentada, pero está asignada al propietario de NIF %s.';
     RpfMsg18 = 'No se ha podido identificar la factura %s';
     RpfMsg19 = 'Factura nº %s, del propietario %s con NIF, %s.';
     RpfMsg20 = 'El servidor ha devuelto un error. Se muestra a continuación en el navegador de la aplicación.';
     RpfMsg21 = 'Mensaje de error';
     RpfMsg22 = 'No se ha podido recuperar el asiento nº %d.';
     RpfMsg23 = 'Factura nº %s [B]ANULADA[/B] correctamente.';

implementation

uses Variants,
     Math,
     EnterpriseDataAccess,
     AppManager,
     DateUtils,
     WebBrowser,

     SBWinCrypt,

     Gdm00Dm,

     dmi_fac,

     dm_reg,
     dm_cnd,
     dm_sub,
     dm_pai,
     dm_pga,
     dm_cer,
     dm_iva,
     dm_sdf,
     dm_ast,
     dm_fac,

     dm_cli,
     dm_pro,

     f_prg;

{$R *.DFM}

type
     TTipoDesgloseIVA = ( tdFactura, tdPrestacionServicios, tdEntregas );

var  DecimalFormatSettings,
     TimeStampFormatSettings : TFormatSettings;

function DecimalString( Valor : Decimal; Decimales : SmallInt = 2 ) : String;
begin
     Result := Format( '%.' + IntToStr( Decimales ) + 'f', [ Valor ], DecimalFormatSettings );
end;

function EntornoPruebasVerifactu : Boolean;
begin
     // Cuando entre en vigor se podrá eliminar esta comprobación, porque los usuarios no podrán usar el entorno de pruebas (para evitar disgustos)
     Result := ( not ( DataModule00.SuministroInmediatoInformacion and DataModule00.DmEmpresaFields.Contable_SII.Value ) and ( ( DataModule00.DmEmpresaFields.Ventas_EntornoPruebasVerifactu.Value and ( Now<EncodeDate( 2026, 1, 1 ) ) ) ) );
end;

function EntornoVerifactu : Boolean;
begin
     Result := ( not ( DataModule00.SuministroInmediatoInformacion and DataModule00.DmEmpresaFields.Contable_SII.Value ) and ( EntornoPruebasVerifactu or ( Now>=EncodeDate( 2026, 1, 1 ) ) ) );
end;

{  RegistroPresentacion }

function RegistroPresentacion : TRegistroPresentacionModule;
begin
     CreateDataModule( TRegistroPresentacionModule, RegistroPresentacionModule );
     Result := RegistroPresentacionModule;
end;

procedure TRegistroPresentacionModule.DataModuleCreate(Sender: TObject);
begin

     NexusRpc.CreateRemoteInstance( CLSID_RegistroPresentacionService, IRegistroPresentacionService, RegistroPresentacionService );

     RegistroPresentacionFields := TRegistroPresentacionFields.Create( RegistroPresentacionTable );

     ClienteFields := TClienteFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );
     FacturaFields := TFacturaFields.Create( Self );
     PaisFields := TPaisFields.Create( Self );

     EjercicioPresentacion := YearOf( ApplicationContainer.TodayDate );

     FResponseHeader := TStringList.Create;

end;

procedure TRegistroPresentacionModule.DataModuleDestroy(Sender: TObject);
begin
     FreeAndNil( FResponseHeader );
     RegistroPresentacionModule := nil;
end;

function TRegistroPresentacionModule.SerieNroFactura( Serie      : String;
                                                      NroFactura : LongInt ) : String;
begin
     Result := IntToStr( NroFactura );
     If   Serie<>''
     then Result := Serie + ' ' + Result;
end;

function TRegistroPresentacionModule.ExtraeSerieNroFactura(     NumSerieFacturaEmisor  : String;
                                                            var Serie                  : String;
                                                            var NroFactura             : LongInt ) : Boolean;

var  Pc,
     Pe,
     Ps : SmallInt;

begin
     Result := True;
     Serie := '';
     NroFactura := 0;
     try
       Pc := Pos( '·', NumSerieFacturaEmisor );  // Mantengo la comprobación del antiguo caracter separador
       Pe := Pos( ' ', NumSerieFacturaEmisor );
       Ps := Max( Pc, Pe );
       If   Ps<>0
       then Serie := Copy( NumSerieFacturaEmisor, 1, Ps - 1 );
       NroFactura := StrToInt( Copy( NumSerieFacturaEmisor,  Ps + 1, 12 ) );
     except
       Result := False;
       end;
end;

{  En el Sii no he utilizado el campo EstadoRegistro del registro de presentación
   Eso es algo que hay que corregir, e igualarlo al funcionamiento de Verifactu
}

function TRegistroPresentacionModule.EstadoPresentacionSii( Estado : SmallInt { EstadoRegistroSiiType } ) : TEstadoPresentacionSii;
begin
     { EstadoRegistroSIIType = (Correcta, AceptadaConErrores, Anulada); }

     case Estado of
       { EstadoRegistroSiiType.Correcta } 0 :
         Result := TEstadoPresentacionSII.erpPresentado;
       { EstadoRegistroSiiType.AceptadaConErrores } 1 :
         Result := TEstadoPresentacionSII.erpAceptadoConErrores;
       { EstadoRegistroSiiType.Anulada } 2 :
         Result := TEstadoPresentacionSII.erpAnulado;
       end;
end;

function TRegistroPresentacionModule.EstadoRegistroSii( Estado : SmallInt { EstadoRegistroSiiType } ) : TEstadoPresentacionSii;
begin
     { EstadoRegistroType = (Correcto, AceptadoConErrores, Incorrecto); }

     case Estado of
       { EstadoRegistroType.Correcto } 0 :
         Result := TEstadoPresentacionSII.erpPresentado;
       { EstadoRegistroType.AceptadoConErrores } 1 :
         Result := TEstadoPresentacionSII.erpAceptadoConErrores;
       { EstadoRegistroType.Incorrecto } 2 :
         Result := TEstadoPresentacionSII.erpPendiente;
         end;
end;

procedure TRegistroPresentacionModule.ActualizaRegistroPresentacionSii( TipoRegistro             : TTipoRegistroPresentacion;
                                                                        Operacion                : TOperacionFacturasSII;
                                                                        Propietario,
                                                                        Serie                    : String;
                                                                        NroFactura               : LongInt;
                                                                        NIFPropietario           : String;

                                                                        EstadoPresentacion       : TEstadoPresentacionSii;
                                                                        CodigoErrorRegistro      : Int64;
                                                                        DescripcionErrorRegistro : String;

                                                                        ImporteFactura           : Decimal = 0.0;
                                                                        ImportePresentacion      : Decimal = 0.0;
                                                                        FechaPresentacion        : TDate = 0;
                                                                        FechaExpedicionFactura   : TDate = 0;

                                                                        EstadoCuadre             : SmallInt = 0 );  // EstadoCuadreType._1  = 0
begin
     try

       If   Operacion=ofAlta
       then begin
            RegistroPresentacionTable.IndexFieldNames := 'Tipo;Ejercicio;Propietario;Serie;NroFactura;NroEfecto';

            If   RegistroPresentacionTable.FindKey( [ Ord( TipoRegistro ), ApplicationContainer.Ejercicio, Propietario, Serie, NroFactura ] )
            then RegistroPresentacionTable.Edit
            else RegistroPresentacionTable.Append;
            RegistroPresentacionFields.Propietario.Value := Propietario;
            end
       else begin
            RegistroPresentacionTable.IndexFieldNames := 'Tipo;Ejercicio;NIFPropietario;Serie;NroFactura;NroEfecto';

            If   RegistroPresentacionTable.FindKey( [ Ord( TipoRegistro ), ApplicationContainer.Ejercicio, NIFPropietario, Serie, NroFactura ] )
            then RegistroPresentacionTable.Edit
            else RegistroPresentacionTable.Append;

            If   RegistroPresentacionFields.Propietario.Value=''
            then begin

                 { Un caso especial : el registro de presentación se ha perdido o no tiene asignado el propietario, pero si que hay un registro en el portal de la AEAT
                                      Vamos ha intentar recuperar el código de la subcuenta del propietario para que el registro de presentación pueda enlazarse
                                      con su factura }

                 If   TipoRegistro=rpFacturaRecibida
                 then If   Proveedor.ObtenPorNIF( NIFPropietario, ProveedorFields )
                      then RegistroPresentacionFields.Propietario.Value := ProveedorFields.Subcuenta.Value
                      else begin
                           RegistroPresentacionTable.Cancel;
                           Exit;
                           end;

                 end;
            end;

       RegistroPresentacionFields.Tipo.Value := Ord( TipoRegistro );
       RegistroPresentacionFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
       RegistroPresentacionFields.Serie.Value := Serie;
       RegistroPresentacionFields.NroFactura.Value := NroFactura;
       RegistroPresentacionFields.NroEfecto.Value := NroEfectoRegistroFactura;
       RegistroPresentacionFields.FechaExpedicionFactura.Value := FechaExpedicionFactura;   // Idem
       RegistroPresentacionFields.NIFPropietario.Value := NIFPropietario;

       RegistroPresentacionFields.EstadoPresentacion.Value := Ord( EstadoPresentacion );
       RegistroPresentacionFields.CodigoErrorRegistro.Value := CodigoErrorRegistro;
       RegistroPresentacionFields.DescripcionErrorRegistro.Value := DescripcionErrorRegistro;

       If   Operacion=ofConsulta
       then RegistroPresentacionFields.Contraste.Value := EstadoCuadre;

       If   ImportePresentacion<>0.0
       then begin
            RegistroPresentacionFields.Importe.Value := ImportePresentacion;   // Es el importe obtenido en la consulta. Sirve para cotejar los valores.
            If   ( EstadoPresentacion<>erpAnulado ) and
                 ( ImporteFactura<>0.0 ) and
                 ( ImporteFactura<>ImportePresentacion )
            then begin
                 RegistroPresentacionFields.EstadoPresentacion.Value := Ord( TEstadoPresentacionSii.erpAceptadoConErrores );
                 RegistroPresentacionFields.DescripcionErrorRegistro.Value := Format( RpfMsg12, [ ImportePresentacion, ImporteFactura ] );
                 end;
            end;

       If   FechaPresentacion<>0
       then begin
            RegistroPresentacionFields.FechaPresentacion.Value := DateOf( FechaPresentacion );
            RegistroPresentacionFields.HoraPresentacion.Value := TimeOf( FechaPresentacion );
            end;

       RegistroPresentacionTable.Post;

     except
       RegistroPresentacionTable.Cancel;
       raise;
       end;
end;

procedure TRegistroPresentacionModule.ActualizaRegistroPresentacionVerifactu( Operacion                : TOperacionFacturasVerifactu;
                                                                              Serie                    : String;
                                                                              NroFactura               : LongInt;

                                                                              EstadoRegistro           : TEstadoRegistroVerifactu;
                                                                              CodigoErrorRegistro      : Int64;
                                                                              DescripcionErrorRegistro : String;
                                                                              FechaPresentacion        : TDate = 0 );
begin

     try

       RegistroPresentacionTable.IndexFieldNames := 'Tipo;Ejercicio;Serie;NroFactura;NroEfecto';
       If   RegistroPresentacionTable.FindKey( [ Ord( rpFacturaEmitidaVerifactu ), ApplicationContainer.Ejercicio, Serie, NroFactura ] )
       then RegistroPresentacionTable.Edit
       else RegistroPresentacionTable.Append;

       RegistroPresentacionFields.Tipo.Value := Ord( rpFacturaEmitidaVerifactu );
       RegistroPresentacionFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
       RegistroPresentacionFields.Serie.Value := Serie;
       RegistroPresentacionFields.NroFactura.Value := NroFactura;
       RegistroPresentacionFields.NroEfecto.Value := NroEfectoRegistroFactura;

       // Si ha sido presentada/anulada con errores y el sistema indica que está pendiente porque se ha intentado volver
       // a presentar/anular y no se ha vuelto a aceptar, el estado de presentación debe seguir siendo el mismo, pero
       // el estado del registro pasa a ser AceptadoConErrores

       case Operacion of
         ofvAlta :
           If   EstadoRegistro=ervIncorrecto
           then RegistroPresentacionFields.EstadoPresentacion.Value := Ord( epvPendiente )
           else RegistroPresentacionFields.EstadoPresentacion.Value := Ord( epvPresentado );
         ofvAnulacion :
           RegistroPresentacionFields.EstadoPresentacion.Value := Ord( epvAnulado );
           end;

       RegistroPresentacionFields.EstadoRegistro.Value := Ord( EstadoRegistro );
       RegistroPresentacionFields.CodigoErrorRegistro.Value := CodigoErrorRegistro;
       RegistroPresentacionFields.DescripcionErrorRegistro.Value := DescripcionErrorRegistro;

       If   FechaPresentacion<>0
       then begin
            RegistroPresentacionFields.FechaPresentacion.Value := DateOf( FechaPresentacion );
            RegistroPresentacionFields.HoraPresentacion.Value := TimeOf( FechaPresentacion );
            end;

       RegistroPresentacionTable.Post;

     except
       RegistroPresentacionTable.Cancel;
       raise;
       end;

end;

function TRegistroPresentacionModule.ObtenRegistroPresentacion( TipoRegistro               : TTipoRegistroPresentacion;
                                                                Propietario,
                                                                Serie                      : String;
                                                                NroFactura                 : LongInt;
                                                                RegistroPresentacionFields : TRegistroPresentacionFields = nil ) : Boolean;
begin
     RegistroPresentacionTable.IndexFieldNames := 'Tipo;Ejercicio;Propietario;Serie;NroFactura;NroEfecto';
     Result := RegistroPresentacionTable.FindKey( [ Ord( TipoRegistro ), ApplicationContainer.Ejercicio, Propietario, Serie, NroFactura, NroEfectoRegistroFactura ] );
     If   Assigned( RegistroPresentacionFields )  // Que sea nulo me permite utilizar la funcion internamente (P.E. desde ObtenEstadoPresentacion)
     then RegistroPresentacionFields.Update( RegistroPresentacionTable );
end;

// Se utiliza desde los mantenimientos (Subcuenta del propietario)

function TRegistroPresentacionModule.ObtenEstadoPresentacionSii( TipoRegistro : TTipoRegistroPresentacion;
                                                                 Propietario,
                                                                 Serie        : String;
                                                                 NroFactura   : Integer ) : TEstadoPresentacionSii;
begin
     Result := erpPendiente;
     If   ObtenRegistroPresentacion( TipoRegistro, Propietario, Serie, NroFactura )
     then Result := TEstadoPresentacionSii( RegistroPresentacionFields.EstadoPresentacion.Value );
end;

function TRegistroPresentacionModule.ObtenEstadoPresentacionVerifactu(     Serie              : String;
                                                                           NroFactura         : Integer;
                                                                       out EstadoPresentacion : TEstadoPresentacionVerifactu;
                                                                       out Estadoregistro     : TEstadoRegistroVerifactu ) : Boolean;
begin
     Result := ObtenRegistroPresentacion( rpFacturaEmitidaVerifactu, '', Serie, NroFactura );
     If   Result
     then begin
          EstadoPresentacion := TEstadoPresentacionVerifactu( RegistroPresentacionFields.EstadoPresentacion.Value );
          EstadoRegistro := TEstadoregistroVerifactu( RegistroPresentacionFields.EstadoRegistro.Value );
          end
     else begin
          EstadoPresentacion := TEstadoPresentacionVerifactu.epvPendiente;
          EstadoRegistro := TEstadoRegistroVerifactu.ervCorrecto;
          end;
end;

procedure TRegistroPresentacionModule.SuprimeRegistroPresentacionVerifactu( Serie      : String;
                                                                            NroFactura : LongInt );
begin
     RegistroPresentacionTable.IndexFieldNames := 'Tipo;Ejercicio;Serie;NroFactura;NroEfecto';
     If   RegistroPresentacionTable.FindKey( [ Ord( rpFacturaEmitidaVerifactu ), ApplicationContainer.Ejercicio, Serie, NroFactura ] )
     then RegistroPresentacionTable.Delete;
end;

function TRegistroPresentacionModule.ObtenUltimoNroFacturaVerifactu(     Serie      : String;
                                                                     out NroFactura : LongInt ) : Boolean;
begin
     Result := False;
     RegistroPresentacionTable.IndexFieldNames := 'Tipo;Ejercicio;Serie;NroFactura;NroEfecto';
     RegistroPresentacionTable.SetRange( [ Ord( rpFacturaEmitidaVerifactu ), ApplicationContainer.Ejercicio, Serie, 1 ], [ Ord( rpFacturaEmitidaVerifactu ), ApplicationContainer.Ejercicio, Serie, MaxLong ] );
     try
       RegistroPresentacionTable.Last;
       If   not RegistroPresentacionFields.NroFactura.IsNull
       then begin
            NroFactura := RegistroPresentacionFields.NroFactura.Value;
            Result := True;
            end;
     finally
       RegistroPresentacionTable.CancelRange;
       end;
end;

procedure TRegistroPresentacionModule.MarcaComoModificadoRegistroPresentacion( TipoRegistro    : TTipoRegistroPresentacion;
                                                                               Propietario,
                                                                               Serie          : String;
                                                                               NroFactura     : LongInt );
begin
     RegistroPresentacionTable.IndexFieldNames := 'Tipo;Ejercicio;Propietario;Serie;NroFactura;NroEfecto';
     If   RegistroPresentacionTable.FindKey( [ Ord( TipoRegistro ), ApplicationContainer.Ejercicio, Propietario, Serie, NroFactura, NroEfectoRegistroFactura ] )
     then try
            RegistroPresentacionTable.Edit;
            RegistroPresentacionFields.EstadoPresentacion.Value := Ord( TEstadoPresentacionSii.erpModificado );
            RegistroPresentacionTable.Post;
          except
            RegistroPresentacionTable.Cancel;
            raise;
            end;
end;

procedure TRegistroPresentacionModule.SuprimeRegistroPresentacion( TipoRegistro    : TTipoRegistroPresentacion;
                                                                   Propietario,
                                                                   Serie          : String;
                                                                   NroFactura     : LongInt );
begin
     RegistroPresentacionTable.IndexFieldNames := 'Tipo;Ejercicio;Propietario;Serie;NroFactura;NroEfecto';
     If   RegistroPresentacionTable.FindKey( [ Ord( TipoRegistro ), ApplicationContainer.Ejercicio, Propietario, Serie, NroFactura, NroEfectoRegistroFactura ] )
     then RegistroPresentacionTable.Delete;
end;

procedure TRegistroPresentacionModule.AddResponseHeader( AMethod         : string;
                                                         AResponseHeader : TStrings );
begin
     If   ( AMethod='POST' ) and ( AResponseHeader.Count>1 )
     then FResponseHeader.Assign( AResponseHeader );
end;

procedure TRegistroPresentacionModule.ShowError( E : Exception );
begin

     If   not ( E is EAbort )
     then begin

          If   FResponseHeader.Count>1
          then begin
               var URL := FResponseHeader.Strings[ 1 ];
               If   Copy( URL, 1, 9 )='Location:'
               then begin
                    URL := Trim( Copy( URL, 10, 255 ) );
                    ShowWebPage( URL, RpfMsg21 );
                    ProcessFrame.AddMsg( ntError, RpfMsg20 );
                    Exit;
                    end;
               end;

          ProcessFrame.AddMsg( ntError, Format( RpfMsg4 + ' : %s.', [ E.Message ] ) );
          end;

end;

initialization
    DecimalFormatSettings := TFormatSettings.Create;
    DecimalFormatSettings.DecimalSeparator := '.';

    TimeStampFormatSettings := TFormatSettings.Create;
    TimeStampFormatSettings.ShortDateFormat := 'dd-mm-yyyy';
    TimeStampFormatSettings.DateSeparator := '-';

end.

