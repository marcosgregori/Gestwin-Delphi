unit dm_ast;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Generics.Defaults, Generics.Collections,

  LibUtils,
  AppForms,
  DataManager,

  Gim10Fields,
  nxdb,

  dmi_ast;

type

  TAsientoModule = class(TDataModule)
    DmAsientoTable: TnxeTable;
    DmAsientoAuxTable: TnxeTable;
    procedure AsientoModuleCreate(Sender: TObject);
    procedure AsientoModuleDestroy(Sender: TObject);
    procedure TablesBeforeOpen(DataSet: TDataSet);
  private

    AsientoService : IAsientoService;

    DmAsientoFields,
    DmAsientoAuxFields,
    DmAsientoFacturaFields : TAsientoFields;

    FEjercicioTransicionCriterioCaja : Variant;

    function GetEjercicioTransicionCriterioCaja : Boolean;

    function ExisteNroAsiento( ValorActual : LongInt ) : Boolean;
    function ExisteAsientoContador( NroAsiento : LongInt ) : Boolean;

  public

    function  ProximoNroAsiento : LongInt;
    procedure RetiraNroAsiento( AsientoFields : TAsientoFields; CompruebaEstado : Boolean = True );
    function  ProximoNroRegistro( TipoDocumento : SmallInt; ResetCounter  : Boolean = False ) : LongInt;
    procedure CompruebaNroAsiento( FormManager: TgxFormManager; AsientoFields : TAsientoFields );

    procedure ActualizaAsiento( AsientoFields  : TAsientoFields );
    Procedure SuprimeAsiento( AsientoFields  : TAsientoFields ); overload;

    function SuprimeAsiento( Ejercicio : SmallInt; NroAsiento : LongInt; PreservaCabecera : Boolean = False ) : Boolean; overload;
    function SuprimeAsiento( Ejercicio : SmallInt; NroAsiento : LongInt; TipoAsiento : SmallInt; FechaDocumento : TDate; SubcuentaPropietario : String; Serie : String; NroDocumento : LongInt; NroEfecto : SmallInt;  PreservaCabecera : Boolean = False ) : Boolean; overload;

    function CopiaAsiento( Ejercicio  : SmallInt; NroAsiento : LongInt; Fecha : TDate ) : Boolean;

    Procedure ActualizaApunte( TipoAsiento : TTipoAsiento; ApunteFields  : TApunteFields );
    Procedure SuprimeApunte( TipoAsiento : TTipoAsiento; ApunteFields  : TApunteFields );

    // function  Suprime( NroAsiento : LongInt; TipoAsiento : SmallInt; Serie : String; NroDocumento : LongInt; NroEfecto : SmallInt; SuprimirCabecera : Boolean ) : Boolean;
    // procedure SuprimeDirectamente( NroAsiento : LongInt; SuprimirCabecera : Boolean );

    function  Obten( AIndexFieldNames : String; KeyArray : array of const ) : Boolean;

    function  ObtenDocumento( TipoDocumento, Ejercicio : SmallInt; CodigoPropietario : String; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt = NroEfectoRegistroFactura; AsientoFields : TAsientoFields = nil ) : Boolean;
    function ObtenImportesFactura( Ejercicio : SmallInt; NroAsiento : LongInt; var BaseImponible, CuotaIVA, CuotaRE, ImporteTotal : Decimal ) : Boolean;
    // procedure CompruebaCambio( AsientoFields : TAsientoFields; ApunteFields : TApunteFields );
    procedure CompruebaTrimestre( var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean );

    function ExistenApuntesTraspasoIVA( Ejercicio : SmallInt = 0 ) : Boolean;

    function  TrimestreCorrecto( aMonth : SmallInt ) : Boolean;
    function  EjercicioCerrado : Boolean;
    procedure CompruebaEjercicioCerrado( EditarAsiento : Boolean = False );

    procedure ActualizaFactura( AsientoFields : TAsientoFields; ConceptoFactura : String; SubcuentaRetencion : String; TipoRetencion : SmallInt; BaseRetencion, ImporteRetencion : Decimal );
    procedure SuprimeFacturaEmitida( AsientoFields : TAsientoFields );
    procedure SuprimeFacturaRecibida( AsientoFields : TAsientoFields );

    procedure ActualizaApunteFactura( AsientoFields : TAsientoFields; ApunteFields : TApunteFields );

    procedure SuprimeApunteFactura( AsientoFields : TAsientoFields; ApunteFields : TApunteFields );
    function ImporteCobrosEfectivo( Subcuenta : String;
                                    FechaInicial,
                                    FechaFinal     : TDateTime;
                                    Cargos         : Boolean ) : Decimal;

    { Indica que el usuario ha vuelto al modo normal desde el criterio de caja en este ejercicio. Eso siginifica que hay que
      seguir procesando los efectos pendientes de pago/cobro del ejercicio anterior como si aún estuvieran acogidos al criterio de caja (un horror)
    }
    property EjercicioTransicionCriterioCaja : Boolean read GetEjercicioTransicionCriterioCaja;
  end;

var  AsientoModule : TAsientoModule = nil;

function Asiento : TAsientoModule;

implementation

uses System.Types,
     cxDateUtils,
     dxCalendarUtils,
     cxEdit,
     Variants,
     AppContainer,

     AppManager,
     DateUtils,
     EnterpriseDataAccess,
     NexusRpcData,

     Gim00Fields,
     Gdm00Dm,

     ApunteIntf,
     AsientoIntf,

     dmi_cnd,
     dmi_fac,

     dm_sal,
     dm_sub,
     dm_cli,
     dm_pro,
     dm_rdi,
     dm_fco,
     dm_fpa,
     dm_iva,
     dm_cnd,
     dm_pga,
     dm_ecc,
     dm_ecp,
     dm_rem,
     dm_rdp,
     dm_fac,

     b_pro,
     b_msg,

     f_prg;

{$R *.DFM}

resourceString
     RsMsg1  = 'La fecha del documento no pertenece al trimestre actual.';
     RsMsg2  = 'No está permitido crear registros que no pertenezcan al trimestre actual.';
     RsMsg3  = 'actual';
     RsMsg4  = 'El ejercicio actual está cerrado.';
     RsMsg5  = 'Si modifica el contenido de algún asiento y no realiza de nuevo el cierre la contabilidad podría quedar en una situación inconsistente.';
     RsMsg6  = ''#13'¿Esta seguro de que desea editar los asientos?';
     RsMsg7  = 'El asiento que intenta suprimir no se corresponde con el generado por este tipo de documento.';
     RsMsg8  = 'No será suprimido.';
     RsMsg9  = 'No se ha podido completar correctamente el asiento de facturación.';
     RsMsg10 = 'El asiento puede haber quedado en una situación inconsistente.'#13'Por favor, revíselo y reintente la operación.';
     RsMsg11 = 'Seleccionando registros del libro de facturas %s.';
     RsMsg12 = 'recibidas';
     RsMsg13 = 'expedidas';
     RsMsg14 = 'Ya existe un asiento con este mismo número.';
     RsMsg15 = 'Otro usuario ya ha reservado este número de asiento.'#13'Introduzca otro número o pulse [B][F12][/B] para generar un número exclusivo automáticamente.';
     RsMsg16 = 'El asiento de %s nº %d contiene un tipo impositivo que no existe en la factura.';
     RsMsg17 = 'Debe revisar los asientos de %s de la factura nº %s %d y volver a generar, si es necesario, los asientos de erróneos.';
     RsMsg18 = 'No se ha podido suprimir el asiento nº %d.';
     RsMsg19 = 'Compruebe que no está siendo editado por otro usuario y reintente el proceso cuando lo considere oportuno.';
     RsMsg20 = 'El asiento nº %d no existe.';
     RsMsg21 = ''#13'¿Esta seguro de que desea continuar?';

function Asiento : TAsientoModule;
begin
     CreateDataModule( TAsientoModule, AsientoModule );
     Result := AsientoModule;
end;

{ TAsientoModule  }

procedure TAsientoModule.ActualizaApunte( TipoAsiento : TTipoAsiento; ApunteFields: TApunteFields );
begin
     AsientoService.ActualizaApunte( TipoAsiento, TApunte.FromDataset( ApunteFields ) );
end;

procedure TAsientoModule.ActualizaAsiento( AsientoFields : TAsientoFields);
begin
     AsientoService.ActualizaAsiento( TAsiento.FromDataset( AsientoFields ) );
end;

procedure TAsientoModule.AsientoModuleCreate(Sender: TObject);
begin

     NexusRpc.CreateRemoteInstance( CLSID_AsientoService, IAsientoService, AsientoService );

     DmAsientoFields := TAsientoFields.Create( DmAsientoTable );
     DmAsientoAuxFields := TAsientoFields.Create( DmAsientoAuxTable );
     DmAsientoFacturaFields := TAsientoFields.Create( DmAsientoAuxTable, True );

end;

procedure TAsientoModule.AsientoModuleDestroy(Sender: TObject);
begin
     AsientoModule := nil;
end;

function TAsientoModule.Obten( AIndexFieldNames : String;
                               KeyArray         : array of const ) : Boolean;
begin
     With DmAsientoAuxTable do
       begin
       IndexFieldNames := AIndexFieldNames;
       Result := FindKey( KeyArray );
       end;
end;

procedure TAsientoModule.RetiraNroAsiento( AsientoFields   : TAsientoFields;
                                           CompruebaEstado : Boolean = True );
begin     
     If   Assigned( AsientoFields )
     then If   AsientoFields.Dataset is TnxeTable
          then With TnxeTable( AsientoFields.Dataset ) do
                 If   not CompruebaEstado or ( not InternalProcess and not ( State in [ dsEdit, dsInsert ] ) and ( PreviousState in [ dsEdit, dsInsert ] ) )
                 then Contadores.RetiraValor( cnAsiento, ApplicationContainer.Ejercicio, '', AsientoFields.NroAsiento.Value );
end;

function TAsientoModule.ExisteNroAsiento( ValorActual : LongInt ) : Boolean;
begin
     With DmAsientoAuxTable do
       begin
       IndexFieldNames := 'Ejercicio;NroAsiento';
       Result := FindKey( [ ApplicationContainer.Ejercicio, ValorActual ] );
       end;
end;

procedure TAsientoModule.CompruebaNroAsiento( FormManager   : TgxFormManager;
                                              AsientoFields : TAsientoFields  );

var  Error : Boolean;

begin
     Error := False;
     case AsientoFields.Dataset.State of
       dsSetKey : If   not FormManager.InsertingAutoIncRecord and ExisteAsientoContador( AsientoFields.NroAsiento.Value )
                  then begin
                       ShowNotification( ntStop, RsMsg14, RsMsg15 );
                       Error := True;
                       end;

       dsInsert : ;  // De esta comprobación se ocupa el gestor de errores de clave duplicada
       end;

     If   Error
     then begin
          AsientoFields.Dataset.Cancel;
          Abort;
          end;
end;

function TAsientoModule.ExisteAsientoContador( NroAsiento : LongInt ) : Boolean;
begin
     Result := AsientoService.ExisteAsientoContador( NroAsiento );
end;

function TAsientoModule.ProximoNroAsiento : LongInt;
begin
     Result := AsientoService.ProximoNroAsiento;
end;

function TAsientoModule.ProximoNroRegistro( TipoDocumento : SmallInt;
                                            ResetCounter  : Boolean = False ) : LongInt;
begin
     Result := AsientoService.ProximoNroRegistro( TipoDocumento, ResetCounter );
end;

procedure TAsientoModule.SuprimeApunte( TipoAsiento : TTipoAsiento; ApunteFields : TApunteFields );
begin
     AsientoService.SuprimeApunte( ApunteFields.GetRemoteCursorID, ApunteFields.Ejercicio.Value, ApunteFields.NroAsiento.Value, TipoAsiento, ApunteFields.NroApunte.Value );
end;

procedure TAsientoModule.SuprimeAsiento( AsientoFields : TAsientoFields );
begin
     AsientoService.SuprimeAsiento( AsientoFields.GetRemoteCursorID, AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value );
end;

function TAsientoModule.SuprimeAsiento( Ejercicio : SmallInt; NroAsiento : LongInt; PreservaCabecera : Boolean ) : Boolean;
begin
     Result := AsientoService.SuprimeAsiento( Ejercicio, NroAsiento, PreservaCabecera );
end;

function TAsientoModule.SuprimeAsiento( Ejercicio            : SmallInt;
                                        NroAsiento           : LongInt;
                                        TipoAsiento          : SmallInt;
                                        FechaDocumento       : TDate;
                                        SubcuentaPropietario : String;
                                        Serie                : String;
                                        NroDocumento         : LongInt;
                                        NroEfecto            : SmallInt;
                                        PreservaCabecera     : Boolean = False ) : Boolean;

begin
     Result := AsientoService.SuprimeAsiento( Ejercicio, NroAsiento, TipoAsiento, FechaDocumento, SubcuentaPropietario, Serie, NroDocumento, NroEfecto, PreservaCabecera );
end;

procedure TAsientoModule.ActualizaFactura( AsientoFields  : TAsientoFields; ConceptoFactura : String; SubcuentaRetencion : String; TipoRetencion : SmallInt; BaseRetencion, ImporteRetencion : Decimal );
begin
     AsientoService.ActualizaFactura( TAsiento.FromDataset( AsientoFields ), ConceptoFactura, SubcuentaRetencion, TipoRetencion, BaseRetencion, ImporteRetencion );
end;

procedure TAsientoModule.ActualizaApunteFactura( AsientoFields : TAsientoFields;
                                                 ApunteFields  : TApunteFields );
begin
     AsientoService.ActualizaApunteFactura( TAsiento.FromDataset( AsientoFields ), TApunte.FromDataset( ApunteFields ) );
end;

procedure TAsientoModule.SuprimeApunteFactura( AsientoFields : TAsientoFields;
                                               ApunteFields  : TApunteFields );
begin
     AsientoService.SuprimeApunteFactura( TAsiento.FromDataset( AsientoFields ), TApunte.FromDataset( ApunteFields ) );
end;

procedure TAsientoModule.SuprimeFacturaEmitida( AsientoFields : TAsientoFields );
begin
     AsientoService.SuprimeFacturaEmitida( AsientoFields.GetRemoteCursorID, AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value );
end;

procedure TAsientoModule.SuprimeFacturaRecibida( AsientoFields : TAsientoFields );
begin
     AsientoService.SuprimeFacturaRecibida( AsientoFields.GetRemoteCursorID, AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value );
end;

function TAsientoModule.CopiaAsiento( Ejercicio  : SmallInt;
                                      NroAsiento : Integer;
                                      Fecha      : TDate ) : Boolean;
begin
     Result := AsientoService.CopiaAsiento( Ejercicio, NroAsiento, Fecha );
end;

function  TAsientoModule.ObtenDocumento( TipoDocumento,
                                         Ejercicio         : SmallInt;
                                         CodigoPropietario : String;
                                         Serie             : String;
                                         NroFactura        : LongInt;
                                         NroEfecto         : SmallInt = NroEfectoRegistroFactura;
                                         AsientoFields     : TAsientoFields = nil  ) : Boolean;
begin
     Result := False;
     With DmAsientoAuxTable do
       If   TipoDocumento in [ taFraRecibida, taPago ]
       then begin
            IndexFieldNames := 'TipoAsiento;Ejercicio;Propietario;Serie;NroFactura;NroEfecto';
            Result := FindKey( [ TipoDocumento, Ejercicio, CodigoPropietario, Serie, NroFactura, NroEfecto ] );
            end
       else begin
            IndexFieldNames := 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto';
            Result := FindKey( [ TipoDocumento, Ejercicio, Serie, NroFactura, NroEfecto ] );
            end;

     If   Assigned( AsientoFields )
     then AsientoFields.Update( DmAsientoAuxTable );

end;

function TAsientoModule.ObtenImportesFactura( Ejercicio : SmallInt; NroAsiento : LongInt; var BaseImponible, CuotaIVA, CuotaRE, ImporteTotal : Decimal ) : Boolean;
begin
     Result := AsientoService.ObtenImportesFactura( Ejercicio, NroAsiento, BaseImponible, CuotaIVA, CuotaRE, ImporteTotal );
end;

function TAsientoModule.GetEjercicioTransicionCriterioCaja : Boolean;
begin

     // Es un ejercicio de transición si ya no está activado el criterio de caja pero en el ejercicio anterior hay movimientos de traspaso de I.V.A. por ese motivo

     If   VarIsEmpty( FEjercicioTransicionCriterioCaja )
     then FEjercicioTransicionCriterioCaja := not DataModule00.DmEmpresaFields.RegimenEspecialCriterioCaja.Value and ExistenApuntesTraspasoIVA( ApplicationContainer.EjercicioPrev );

     Result := FEjercicioTransicionCriterioCaja;
end;

function TAsientoModule.ExistenApuntesTraspasoIVA( Ejercicio : SmallInt = 0 ) : Boolean;
begin
     Result := AsientoService.ExistenApuntesTraspasoIVA( Ejercicio );
end;

{
procedure TAsientoModule.CompruebaCambio( AsientoFields : TAsientoFields;
                                          ApunteFields  : TApunteFields );

begin
     If   not VarIsVoid( AsientoFields.NroAsiento.OldValue )
     then If   ( AsientoFields.Fecha.OldValue<>AsientoFields.Fecha.Value ) or ( AsientoFields.TipoAsiento.OldValue<>AsientoFields.TipoAsiento.Value )
          then AsientoService.CambiaFechaApuntes( AsientoFields.NroAsiento.Value, AsientoFields.Fecha.Value );
end;
}

//* 09.098.2002 Añadida la función TrimestreCorrecto para poder utilizarla desde
//              otros procedimientos

function TAsientoModule.TrimestreCorrecto( AMonth : SmallInt ) : Boolean;
begin
     If   DataModule00.DmEmpresaFields.Contable_BloqueoTrim.Value
     then Result := MonthQuarter( AMonth )=DateQuarter( ApplicationContainer.TodayDate )
     else Result := True;
end;

procedure TAsientoModule.CompruebaTrimestre( var DisplayValue : Variant;
                                             var ErrorText    : TCaption;
                                             var Error        : Boolean );
var  Date : TDateTime;

begin
     If   TextToDateEx( DisplayValue, Date )
     then If   not TrimestreCorrecto( MonthOf( Date ) )
          then begin
               Error := True;
               ErrorText := JoinMessage( RsMsg1, RsMsg2 );
               end;
end;

function  TAsientoModule.EjercicioCerrado : Boolean;
begin
     With DmAsientoTable do
       try
         IndexFieldNames := 'TipoAsiento;Ejercicio;NroRegistro';
         Result := FindEqualFirst( [ taCierre, ApplicationContainer.Ejercicio ] );
       finally
         IndexFieldNames := 'Ejercicio;NroAsiento';
         end;
end;

procedure TAsientoModule.CompruebaEjercicioCerrado( EditarAsiento : Boolean = False );
begin
     If   EjercicioCerrado
     then begin
          var TextoMensaje := RsMsg5;
          If   EditarAsiento
          then StrAdd( TextoMensaje, RsMsg6 )
          else StrAdd( TextoMensaje, RsMsg21 );
          If   ShowNotification( ntQuestionWarning, RsMsg4, TextoMensaje )<>mrYes
          then Abort;
          end;
end;

procedure TAsientoModule.TablesBeforeOpen(DataSet: TDataSet);
begin
     EnterpriseDataModule.CheckUserAuxDatabase( Dataset );
end;

{
procedure TAsientoModule.AbreAsientoFactura( AsientoFields : TAsientoFields );
begin
     AsientoService.AbreAsientoFactura( TAsiento.FromDataset( AsientoFields ) );
end;

procedure TAsientoModule.CierraAsientoFactura( AsientoFields      : TAsientoFields;
                                               ConceptoFactura    : String;
                                               SubcuentaRetencion : String;
                                               TipoRetencion      : SmallInt;
                                               BaseRetencion,
                                               ImporteRetencion   : Decimal );
begin
     AsientoService.CierraAsientoFactura( TAsiento.FromDataset( AsientoFields ), ConceptoFactura, SubcuentaRetencion, TipoRetencion, BaseRetencion, ImporteRetencion );
end;
}

function TAsientoModule.ImporteCobrosEfectivo( Subcuenta      : String;
                                               FechaInicial,
                                               FechaFinal     : TDateTime;
                                               Cargos         : Boolean ) : Decimal;

begin
     Result := AsientoService.ImporteCobrosEfectivo( Subcuenta, FechaInicial, FechaFinal, Cargos );
end;

end.

