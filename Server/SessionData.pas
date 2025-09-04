unit SessionData;

interface

uses
  System.SysUtils,
  System.Classes,
  Generics.Collections,

  Data.DB,
  nxdb,
  nxllTypes,
  nxllComponent,

  LibUtils,
  AppManager,
  DataManager,

  BaseServerContainer,
  MainData,
  ServerDataModule,
  EnterpriseData,
  BaseSessionData,
  SessionIntf,

  kbmMemTable,
  kbmMWCustomConnectionPool,
  kbmMWCustomDataset,
  kbmMWNexusDB,
  kbmMWCustomSQLMetaData,
  kbmMWResolvers,

  Gsm00Dm,
  Gsm10Dm,
  Gsm30Dm,
  Gsm40Dm,
  Gsm60Dm,
  Gsm70Dm,
  Gsm90Dm,
  Gsm91Dm,

  // Módulos propietarios

  Gsm101Dm,
  Gsm103Dm,
  Gsm105Dm,
  Gsm114Dm,
  Gsm116Dm,
  Gsm117Dm,
  Gsm119Dm,
  Gsm121Dm,

  // Módulos opcionales

  Gsm200Dm,
  Gsm201Dm,
  Gsm202Dm,
  Gsm203Dm,
  Gsm204Dm,
  Gsm205Dm,
  Gsm206Dm,
  Gsm207Dm,

  PreventaDataModule,
  CapturadorDataModule,

  Gim00Fields,
  Gim10Fields;

type
  TSessionDataModule = class(TBaseSessionDataModule)
    EmpresaTable: TnxeTable;
    UsuarioTable: TnxeTable;
    BackupDatabase: TnxeDatabase;
    procedure DataModuleCreate(Sender: TObject);
  private

    // Módulos de la aplicación

    FDm00 : TDataModule00;
    FDm10 : TDataModule10;
    FDm30 : TDataModule30;
    FDm40 : TDataModule40;
    FDm60 : TDataModule60;
    FDm70 : TDataModule70;
    FDm90 : TDataModule90;
    FDm91 : TDataModule91;

    // Módulos propietarios

    FDm101 : TDataModule101;
    FDm103 : TDataModule103;
    FDm105 : TDataModule105;
    FDm114 : TDataModule114;
    FDm116 : TDataModule116;
    FDm117 : TDataModule117;
    FDm119 : TDataModule119;
    FDm121 : TDataModule121;

    // Módulos opcionales

    FDm200 : TDataModule200;
    FDm201 : TDataModule201;
    FDm202 : TDataModule202;
    FDm203 : TDataModule203;
    FDm204 : TDataModule204;
    FDm205 : TDataModule205;
    FDm206 : TDataModule206;
    FDm207 : TDataModule207;

    // Servicios

    FPreventaDataModule : TPreventaDataModule;
    FCapturadorDataModule : TCapturadorDataModule;

    // Jornada laboral

    FWorkDays : Integer;
    FWorkStart,
    FWorkFinish : TTime;

    function GetEnterpriseDataModule: TEnterpriseDataModule;
    function GetMainDataModule: TMainDataModule;

    function AssignDatabase( CodigoEmpresa : String ) : TnxDatabase;

    function GetDm00 : TDataModule00;
    function GetDm10 : TDataModule10;
    function GetDm30 : TDataModule30;
    function GetDm40 : TDataModule40;
    function GetDm60 : TDataModule60;
    function GetDm70 : TDataModule70;
    function GetDm90 : TDataModule90;
    function GetDm91 : TDataModule91;

    function GetDm101 : TDataModule101;
    function GetDm103 : TDataModule103;
    function GetDm105 : TDataModule105;
    function GetDm114 : TDataModule114;
    function GetDm116 : TDataModule116;
    function GetDm117 : TDataModule117;
    function GetDm119 : TDataModule119;
    function GetDm121 : TDataModule121;

    function GetDm200 : TDataModule200;
    function GetDm201 : TDataModule201;
    function GetDm202 : TDataModule202;
    function GetDm203 : TDataModule203;
    function GetDm204 : TDataModule204;
    function GetDm205 : TDataModule205;
    function GetDm206 : TDataModule206;
    function GetDm207 : TDataModule207;

    function GetDmPreventa : TPreventaDataModule;
    function GetDmCapturador : TCapturadorDataModule;

  public

    DestroyingSession : Boolean;

    EmpresaFields : TEmpresaFields;
    UsuarioFields : TUsuarioFields;

    // Configuracion de la tienda virtual

    ClienteTiendaFields : TClienteFields;

    PublicarArticulosSinExistencias,
    NoPublicarArticulosSinPrecio : Boolean;

    //..

    FacturaElectronica,
    Trazabilidad,
    PartidasPresupuestarias,
    Envases,
    Exportacion,
    TiendaVirtual,
    SuministroInmediatoInformacion : Boolean;

    LoggedIn : Boolean;

    constructor Create( AProgramNumber : SmallInt; AClientApplicationPath : String; AClientType : TClientType; AComputerName : String = ''; AUserName : String = ''; AClientID : String = '' ); reintroduce;
    destructor Destroy; override;

    function CompruebaAcceso( CodigoUsuario : String; PalabraPaso : String ) : Boolean;
    function CompruebaAccesoCliente( CodigoEmpresa, EMailCliente : String; PalabraPaso : String ) : Boolean;

    function AsignaParametrosTrabajo( CodigoUsuario, CodigoEmpresa : String; Fecha : TDate ) : Boolean; override;
    procedure SetupSessionParams( CodigoUsuario, CodigoEmpresa : String; Fecha : TDate; NroMesInicial : SmallInt ); override;

    procedure GetDatabaseInfo( CodigoEmpresa : String; out MajorVersion : Word; out MinorVersion : Word; out Release : Word; out Build : Word; out LastUpdate : TDateTime; out Options : String );
    function InitializeDatabase( CodigoEmpresa : String ) : Boolean; overload;
    function RecoverDatabase( CodigoEmpresa : String; RecoverTableList : TStringArray ) : Boolean; overload;

    procedure UpdateDatabase( CodigoEmpresa : String = '' );
    procedure EraseEnterpriseDatabase( CodigoEmpresa : String ); override;
    function BackupDatabaseTables( UserDatabase : Boolean; BackupDatabasePath : String; TableNames : String ) : Boolean;

    procedure CloseGlobalFiles;
    procedure OpenGlobalFiles;
    procedure CloseInactiveSessionResources;
    procedure FreeAllSessionDataModules;

    property MainDataModule : TMainDataModule read GetMainDataModule;
    property EnterpriseDataModule : TEnterpriseDataModule read GetEnterpriseDataModule;

    property WorkDays : Integer read FWorkDays write FWorkDays;
    property WorkStart : TTime read FWorkStart write FWorkStart;
    property WorkFinish : TTime read FWorkFinish write FWorkFinish;

    property Dm00 : TDataModule00 read GetDm00 write FDm00;
    property Dm10 : TDataModule10 read GetDm10 write FDm10;
    property Dm30 : TDataModule30 read GetDm30 write FDm30;
    property Dm40 : TDataModule40 read GetDm40 write FDm40;
    property Dm60 : TDataModule60 read GetDm60 write FDm60;
    property Dm70 : TDataModule70 read GetDm70 write FDm70;
    property Dm90 : TDataModule90 read GetDm90 write FDm90;
    property Dm91 : TDataModule91 read GetDm91 write FDm91;

    property Dm101 : TDataModule101 read GetDm101 write FDm101;
    property Dm103 : TDataModule103 read GetDm103 write FDm103;
    property Dm105 : TDataModule105 read GetDm105 write FDm105;
    property Dm114 : TDataModule114 read GetDm114 write FDm114;
    property Dm116 : TDataModule116 read GetDm116 write FDm116;
    property Dm117 : TDataModule117 read GetDm117 write FDm117;
    property Dm119 : TDataModule119 read GetDm119 write FDm119;
    property Dm121 : TDataModule121 read GetDm121 write FDm121;

    property Dm200 : TDataModule200 read GetDm200 write FDm200;
    property Dm201 : TDataModule201 read GetDm201 write FDm201;
    property Dm202 : TDataModule202 read GetDm202 write FDm202;
    property Dm203 : TDataModule203 read GetDm203 write FDm203;
    property Dm204 : TDataModule204 read GetDm204 write FDm204;
    property Dm205 : TDataModule205 read GetDm205 write FDm205;
    property Dm206 : TDataModule206 read GetDm206 write FDm206;
    property Dm207 : TDataModule207 read GetDm207 write FDm207;

    property DmPreventa : TPreventaDataModule read GetDmPreventa write FPreventaDataModule;
    property DmCapturador : TCapturadorDataModule read GetDmCapturador write FCapturadorDataModule;

  end;

  TServerDataModuleHelper = class helper for TServerDataModule
  protected
    function GetSessionDataModule : TSessionDataModule;
  public
    property SessionDataModule : TSessionDataModule read GetSessionDataModule;
    end;

  TSessionModuleHelper = class Helper for TSessionModule
  private
   function GetSessionDataModule : TSessionDataModule;
  public
    property SessionDataModule : TSessionDataModule read GetSessionDataModule;
    end;

function InitializeSession(     ProgramNumber          : SmallInt;
                                ClientApplicationPath  : String;
                                FixedPath              : Boolean;
                                ComputerName,
                                UserName,
                                ClientVersion          : String;
                                ClientType             : TClientType;
                            out UpgradeNeeded          : Boolean;
                            out Is64BitsServer         : Boolean;
                            out SessionDataModule      : TSessionDataModule ) : Integer;
function GetSessionDataModule( const SessionID : Integer ) : TSessionDataModule; overload;
function GetSessionDataModuleExt( ClientType : TClientType; ClientID, ClientName, UserName, CodigoEmpresa : String ) : TSessionDataModule; overload;
function GetActiveSessions : Integer;
function CloseSession( SessionID : Integer ) : Boolean;

// function CheckSessionDataModule( ID : Integer; SessionService : ISession; CodigoEmpresa, CodigoUsuario  : String; Fecha : TDate ) : Integer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses nxdbBase,
     nxllBDE,
     nxllUtils,

     Files,
     DateUtils,

     dmi_sdt;

resourceString
     RsEmpresaInexistente = 'Codigo de Empresa inexistente.';
     RsErrorCerrandoEnterpriseDataModule = 'Se ha producido un error intentando cerrar los ficheros y servicios de la Empresa y ejercicio activos.';

function InitializeSession(     ProgramNumber          : SmallInt;
                                ClientApplicationPath  : String;
                                FixedPath              : Boolean;
                                ComputerName,
                                UserName,
                                ClientVersion          : String;
                                ClientType             : TClientType;
                            out UpgradeNeeded          : Boolean;
                            out Is64BitsServer         : Boolean;
                            out SessionDataModule      : TSessionDataModule ) : Integer;

var  LocalComputerName,
     LocalUserName : String;

begin
     If   ServerLocked
     then Result := SE_ServerLocked
     else If   ClientVersion=ComparableAppVersion
          then begin
               GetComputerAndUserName( LocalComputerName, LocalUserName );
               If   not FixedPath
               then If   ComputerName<>LocalComputerName  // El cliente no está en el mismo equipo que éste servidor
                    then ClientApplicationPath := ApplicationPath;

               SessionDataModule := TSessionDataModule.Create( ProgramNumber,
                                                               ClientApplicationPath,
                                                               ClientType,
                                                               ComputerName,
                                                               UserName );

               UpgradeNeeded := SessionDataModule.DatabaseUpdateRequested;
               {$IFDEF CPUX64}
               Is64BitsServer := True;
               {$ELSE}
               Is64BitsServer := False;
               {$ENDIF}
               Result := SessionDataModule.ID;
               end
          else Result := SE_VersionMismatch;
end;

function GetSessionDataModule( const SessionID : Integer ) : TSessionDataModule;
begin
     Result := TSessionDataModule( SessionDataList.Get( SessionID ) );
end;

// Devuelve un SessionDataModule cuyo ClientID sea el indicado.
// Si la Empresa asignada no coincide con la deseada se cambia de Empresa activa. Se utiliza desde servicios externos (RPC, etc..) en los que la Empresa
// se asigna en la misma llamada a la función y puede no existir una sesión activa

function GetSessionDataModuleExt( ClientType    : TClientType;
                                  ClientID,
                                  ClientName,
                                  UserName,
                                  CodigoEmpresa : String ) : TSessionDataModule;

var   SessionDataModule : TSessionDataModule;
      Index : SmallInt;

begin

     SessionDataModule := nil;

     If   not ( ClientType in [ ctWindows, ctServer ] )
     then With SessionDataList do
            For Index := 0 to Count - 1 do
              If   Assigned( Items[ Index ] )
              then begin
                   // Si el ClientID no está asignado se comparte la sesión (por ejemplo ctLicensing)
                   var Sdm := TSessionDataModule( Items[ Index ] );
                   If   ( ( Sdm.ClientID=ClientID ) or ( ClientID='' ) ) and ( Sdm.CodigoEmpresa=CodigoEmpresa )  // El usuario remoto puede cambiar de Empresa activa manteniendo su ClientID
                   then SessionDataModule := Sdm;
                   end;

     // Los datos globales (MainDataModule) de las sesiones que no se han inicializado desde Windows, siempre apuntan al directorio
     // de datos en el que está instalado el servidor (ApplicationPath)

     If   not Assigned( SessionDataModule )
     then SessionDataModule := TSessionDataModule.Create( 0,
                                                          ApplicationPath,
                                                          ClientType,
                                                          { AComputerName } ClientName,
                                                          { AUserName } UserName,
                                                          { AClientID } ClientID );

     // Si CodigoEmpresa no está asignado se puede acceder igualmente a los ficheros globales. Si lo está y no
     // coincide con la Empresa solicitada, se cambia de Empresa activa
     // Como en las aplicaciones RPC puede no estar asignado el usuario, se asigna por defecto el usuario maestro

     SessionDataModule.LastAccess := Now;

     If   ( CodigoEmpresa<>'' ) and ( SessionDataModule.CodigoEmpresa<>CodigoEmpresa )
     then try
            SessionDataModule.AsignaParametrosTrabajo( '00', CodigoEmpresa, Today );
          except
            If   Assigned( SessionDataModule )
            then SessionDataModule.Free;
            SessionDataModule := nil;
            raise;
            end;

     Result := SessionDataModule;
end;

function GetActiveSessions : Integer;

var  Index : Integer;

begin
     Result := 0;
     With SessionDataList do
       For Index := 0 to Count - 1 do
          If   Assigned( Items[ Index ] )
          then Inc( Result );
end;

function CloseSession( SessionID : Integer ) : Boolean;

var  SessionDataModule : TSessionDataModule;

begin
     SessionDataModule := GetSessionDataModule( SessionID );
     Result := Assigned( SessionDataModule );
     If   Result
     then SessionDataModule.Free;
end;

{
function CheckSessionDataModule( ID             : Integer;
                                 SessionService : ISession;
                                 CodigoEmpresa,
                                 CodigoUsuario  : String;
                                 Fecha          : TDate ) : Integer;

var  SessionDataModule : IBaseSessionDataModule;

begin
     SessionDataModule := SessionDataList.Get( ID );
     If   Assigned( SessionDataModule )
     then SessionDataModule.AsignaParametrosTrabajo( CodigoEmpresa, Fecha )
     else SessionDataModule := TSessionDataModule.Create( SessionService, CodigoEmpresa, CodigoUsuario, Fecha );
     Result := SessionDataModule.ID;
end;
}

// TSessionDataModule

procedure TSessionDataModule.SetupSessionParams( CodigoUsuario, CodigoEmpresa : String; Fecha : TDate; NroMesInicial : SmallInt );
begin

     If   not EmpresaTable.FindKey( [ CodigoEmpresa ] )
     then Abort;

     If   not UsuarioTable.FindKey( [ CodigoUsuario ] )
     then Abort;

     inherited SetupSessionParams( CodigoUsuario, CodigoEmpresa,Fecha, NroMesInicial );

     // Ajuste de la jornada laboral

     If   EmpresaFields.DiasLaborables.Value=0
     then FWorkDays := 31
     else FWorkDays := EmpresaFields.DiasLaborables.Value;

     If   EmpresaFields.InicioJornadaLaboral.Value=0
     then FWorkStart := EncodeTime( 9, 0, 0, 0 )
     else FWorkStart := EmpresaFields.InicioJornadaLaboral.Value;

     If   EmpresaFields.FinJornadaLaboral.Value=0
     then FWorkFinish := EncodeTime( 20, 0, 0, 0 )
     else FWorkFinish := EmpresaFields.FinJornadaLaboral.Value;

end;

constructor TSessionDataModule.Create( AProgramNumber         : SmallInt;
                                       AClientApplicationPath : String;
                                       AClientType            : TClientType;
                                       AComputerName          : String = '';
                                       AUserName              : String = '';
                                       AClientID              : String = '' );
begin
     inherited Create( AProgramNumber, AClientApplicationPath, AClientType, AComputerName, AUserName, AClientID );

     Dm00;  // Se abre el diccionario global, pero no se abre ninguna tabla

     BaseServerContainerModule.DoSessionAdded( ID, ClientType, ClientName );  // El ID se ha generado automáticamente en TBaseSessionData.Create e identifica la sesión internamente (lista de sesiones)
end;

procedure TSessionDataModule.DataModuleCreate(Sender: TObject);
begin
     inherited;

     If   not DatabaseUpdateRequested
     then begin
          OpenGlobalFiles;
          Dm00;
          end;

     FInitialized := True;
end;

destructor TSessionDataModule.Destroy;
begin
     try

       DestroyingSession := True;

       // Si se cierra la sesión desde el cliente éste no llega a recibir el ntCloseSession
       // Sin embargo, si se cierra la sesión en el servidor la recibe, y se cierra la aplicación cliente


       If   ClientType=ctWindows
       then SendNotification( ntCloseSession );

       BaseServerContainerModule.DoSessionRemoved( ID );

       inherited;

     except on E : Exception do
       begin

       // Cuando se produce alguna excepción al descargar cualquier módulo el proceso no finaliza
       // Creo que es importante no interrumpir la limpieza del módulo, aunque se quede algun fragmento de memoria colgado

       LogException( E, Self );

       end;

     end;

end;

function TSessionDataModule.CompruebaAcceso( CodigoUsuario : String; PalabraPaso : String ) : Boolean;
begin

     LoggedIn := False;
     If   UsuarioTable.FindKey( [ CodigoUsuario ] )
     then LoggedIn := UsuarioFields.Password.Value=nxCalcShStrELFHash( PalabraPaso );
     Result := LoggedIn;

     Result := True;  // ******* DEBUG
end;

function TSessionDataModule.CompruebaAccesoCliente( CodigoEmpresa,
                                                    EMailCliente  : String;
                                                    PalabraPaso   : String ) : Boolean;
begin
     LoggedIn := False;
     If   Dm10.ClienteModule.ObtenPorEMail( EMailCliente, ClienteTiendaFields )
     then LoggedIn := True; // ******* DEBUG     Dm10.ClienteModule.DmClienteFields.PalabraPaso.Value=PalabraPaso;
     If   LoggedIn
     then begin
          PublicarArticulosSinExistencias := Dm00.RegistroModule.ObtenValorBool( ncrPublicarArticulosSinExistencias );
          NoPublicarArticulosSinPrecio := Dm00.RegistroModule.ObtenValorBool( ncrNoPublicarArticulosSinPrecio );

          end;

     Result := LoggedIn;
end;

function TSessionDataModule.AsignaParametrosTrabajo( CodigoUsuario,
                                                     CodigoEmpresa    : String;
                                                     Fecha            : TDate ) : Boolean;
begin
     Result := False;
     CleanNotificationData;
     DatabaseUpdateRequested := False;

     try

       // Es importante NO utilizar FreeAndNil para que la variable no se anule antes de destruir todos sus módulos

       If   Assigned( FEnterpriseDataModule )
       then begin
            FEnterpriseDataModule.Free;
            FEnterpriseDataModule := nil;
            end;

     except on E : Exception do
       begin
       FEnterpriseDataModule := nil;
       SendException( E, Self, RsErrorCerrandoEnterpriseDataModule );
       raise;
       end;
     end;

     If   EmpresaTable.FindKey( [ CodigoEmpresa ] )
     then begin
          Self.CodigoEmpresa := CodigoEmpresa;
          try
            FEnterpriseDataModule := TEnterpriseDataModule.Create( Self, CodigoEmpresa, EmpresaFields.DataPath.Value );
            If   Assigned( FEnterpriseDataModule )
            then begin

                 SetupSessionParams( CodigoUsuario, CodigoEmpresa, Fecha, EmpresaFields.Contable_MesInicial.Value );

                 // Inicializando componentes de KbmMW

                 ConnectionPool.Session := DBSession;
                 ConnectionPool.Database := EnterpriseDataModule.SectionDatabase;
                 ConnectionPool.Active := True;

                 {

                   Creo y cargo los módulos de datos de cada sección
                   Si no existe el diccionario correspondiente es porque no está incluido en la distribución y el usuario no dispone de esa opción
                   El único motivo para activar todos los diccionarios ahora es que es necesario disponer desde el primer momento de una
                   relación de ellos por si hay que actualizar la base de datos.

                   Los módulos que no tienen un diccionario asociado se cargan e inicializan cuando se utiliza algún servicio asociado a ellos.

                 }

                 Dm10;

                 If   ExistsDictionary( 30 )
                 then Dm30;

                 If   ExistsDictionary( 40 )
                 then Dm40;

                 If   ExistsDictionary( 60 )
                 then Dm60;

                 If   ExistsDictionary( 70 )
                 then Dm70;

                 If   ExistsDictionary( 90 )
                 then Dm90;

                 If   ExistsDictionary( 91 )
                 then Dm91;

                 { Módulos propietarios }

                 If   ExistsDictionary( 103 )
                 then Dm103;

                 If   ExistsDictionary( 105 )
                 then Dm105;

                 If   ExistsDictionary( 114 )
                 then Dm114;

                 If   ExistsDictionary( 116 )
                 then Dm116;

                 If   ExistsDictionary( 119 )
                 then Dm119;

                 { Módulos opcionales }

                 If   ExistsDictionary( 203 )    // Envases y contenedores
                 then Dm203;

                 If   ExistsDictionary( 204 )    // Exportación
                 then Dm204;

                 If   ExistsDictionary( 207 )     // Tienda virtual
                 then Dm207;

                 // Actualizo el contenido de los registros de configuración, tanto globales como los de cada módulo activo

                 If   not InitializingDatabase and
                      not UpdatingDatabase and
                      not RecoveringDatabase
                 then Dm00.ConfiguracionModule.Update;

                 Result := True;
                 end;

            except on E : Exception do
              begin
              If   Assigned( FEnterpriseDataModule )
              then FEnterpriseDataModule.Free;
              FEnterpriseDataModule := nil;
              If   not UpdatingDatabase and not ( E is EAbort )
              then SendException( E, Self );
              raise;
              end;
            end;

          end
     else raise Exception.Create( RsEmpresaInexistente );

end;

procedure TSessionDataModule.OpenGlobalFiles;
begin
     If   not EmpresaTable.Active
     then try

            EmpresaTable.Database := MainDataModule.Database;
            UsuarioTable.Database := MainDataModule.Database;

            EmpresaTable.Open;
            UsuarioTable.Open;

            // Indico que la estructura está incompleta para que no se produzca un error si ha cambiado
            // (me va bien para actualizar los ficheros de Empresa y Usuario sin tener que actualizar el número de versión)

            EmpresaFields := TEmpresaFields.Create( EmpresaTable, { StaticData } False, { Incomplete } True );
            UsuarioFields := TUsuarioFields.Create( UsuarioTable, False, True );

            ClienteTiendaFields := TClienteFields.Create( Self );

            Dm00.OpenGlobalFiles;

          except on E : Exception do
            begin
            try
              CloseGlobalFiles;
            except
              end;
            If   ( E is EnxDatabaseError ) and ( EnxDatabaseError( E ).ErrorCode=DBIERR_TABLELEVEL )
            then RequestDatabaseUpdate
            else raise;
            end;
          end;

end;

procedure TSessionDataModule.CloseGlobalFiles;
begin
     EmpresaTable.Close;
     UsuarioTable.Close;

     Dm00.CloseGlobalFiles;

     CloseInactiveSessionResources;
end;

procedure TSessionDataModule.CloseInactiveSessionResources;
begin
     With DBSession do
       begin
       CloseInactiveTables;
       CloseInactiveFolders;
       end;
end;

procedure TSessionDataModule.FreeAllSessionDataModules;
begin
     EnterpriseDataModule.FreeAllDataModules;
end;

function TSessionDataModule.GetDm00 : TDataModule00;
begin
     Result := TDataModule00( CheckServerDataModule( MainDataModule, TDataModule00, FDm00 ) );
end;

function TSessionDataModule.GetDm10 : TDataModule10;
begin
     Result := TDataModule10( CheckServerDataModule( EnterpriseDataModule, TDataModule10, FDm10 ) );
end;

function TSessionDataModule.GetDm30 : TDataModule30;
begin
     Result := TDataModule30( CheckServerDataModule( EnterpriseDataModule, TDataModule30, FDm30 ) );
end;

function TSessionDataModule.GetDm40 : TDataModule40;
begin
     Result := TDataModule40( CheckServerDataModule( EnterpriseDataModule, TDataModule40, FDm40 ) );
end;

function TSessionDataModule.GetDm60 : TDataModule60;
begin
     Result := TDataModule60( CheckServerDataModule( EnterpriseDataModule, TDataModule60, FDm60 ) );
end;

function TSessionDataModule.GetDm70 : TDataModule70;
begin
     Result := TDataModule70( CheckServerDataModule( EnterpriseDataModule, TDataModule70, FDm70 ) );
end;

function TSessionDataModule.GetDm90 : TDataModule90;
begin
     Result := TDataModule90( CheckServerDataModule( EnterpriseDataModule, TDataModule90, FDm90 ) );
end;

function TSessionDataModule.GetDm91 : TDataModule91;
begin
     Result := TDataModule91( CheckServerDataModule( EnterpriseDataModule, TDataModule91, FDm91 ) );
end;

function TSessionDataModule.GetDm101 : TDataModule101;
begin
     Result := TDataModule101( CheckServerDataModule( EnterpriseDataModule, TDataModule101, FDm101 ) );
end;

function TSessionDataModule.GetDm103 : TDataModule103;
begin
     Result := TDataModule103( CheckServerDataModule( EnterpriseDataModule, TDataModule103, FDm103 ) );
end;

function TSessionDataModule.GetDm105 : TDataModule105;
begin
     Result := TDataModule105( CheckServerDataModule( EnterpriseDataModule, TDataModule105, FDm105 ) );
end;

function TSessionDataModule.GetDm114 : TDataModule114;
begin
     Result := TDataModule114( CheckServerDataModule( EnterpriseDataModule, TDataModule114, FDm114 ) );
end;

function TSessionDataModule.GetDm116 : TDataModule116;
begin
     Result := TDataModule116( CheckServerDataModule( EnterpriseDataModule, TDataModule116, FDm116 ) );
end;

function TSessionDataModule.GetDm117 : TDataModule117;
begin
     Result := TDataModule117( CheckServerDataModule( EnterpriseDataModule, TDataModule117, FDm117 ) );
end;

function TSessionDataModule.GetDm119 : TDataModule119;
begin
     Result := TDataModule119( CheckServerDataModule( EnterpriseDataModule, TDataModule119, FDm119 ) );
end;

function TSessionDataModule.GetDm121 : TDataModule121;
begin
     Result := TDataModule121( CheckServerDataModule( EnterpriseDataModule, TDataModule121, FDm121 ) );
end;


function TSessionDataModule.GetDm200 : TDataModule200;
begin
     Result := TDataModule200( CheckServerDataModule( EnterpriseDataModule, TDataModule200, FDm200 ) );
end;

function TSessionDataModule.GetDm201: TDataModule201;
begin
     Result := TDataModule201( CheckServerDataModule( EnterpriseDataModule, TDataModule201, FDm201 ) );
end;

function TSessionDataModule.GetDm202 : TDataModule202;
begin
     Result := TDataModule202( CheckServerDataModule( EnterpriseDataModule, TDataModule202, FDm202 ) );
end;

function TSessionDataModule.GetDm203 : TDataModule203;
begin
     Result := TDataModule203( CheckServerDataModule( EnterpriseDataModule, TDataModule203, FDm203 ) );
end;

function TSessionDataModule.GetDm204 : TDataModule204;
begin
     Result := TDataModule204( CheckServerDataModule( EnterpriseDataModule, TDataModule204, FDm204 ) );
end;

function TSessionDataModule.GetDm205 : TDataModule205;
begin
     Result := TDataModule205( CheckServerDataModule( EnterpriseDataModule, TDataModule205, FDm205 ) );
end;

function TSessionDataModule.GetDm206 : TDataModule206;
begin
     Result := TDataModule206( CheckServerDataModule( EnterpriseDataModule, TDataModule206, FDm206 ) );
end;

function TSessionDataModule.GetDm207 : TDataModule207;
begin
     Result := TDataModule207( CheckServerDataModule( EnterpriseDataModule, TDataModule207, FDm207 ) );
end;

function TSessionDataModule.GetDmPreventa : TPreventaDataModule;
begin
     Result := TPreventaDataModule( CheckServerDataModule( EnterpriseDataModule, TPreventaDataModule, FPreventaDataModule ) );
end;

function TSessionDataModule.GetDmCapturador : TCapturadorDataModule;
begin
     Result := TCapturadorDataModule( CheckServerDataModule( EnterpriseDataModule, TCapturadorDataModule, FCapturadorDataModule ) );
end;

procedure TSessionDataModule.GetDatabaseInfo(     CodigoEmpresa : String;
                                              out MajorVersion,
                                                  MinorVersion,
                                                  Release,
                                                  Build: Word;
                                              out LastUpdate   : TDateTime;
                                              out Options      : String );
begin
     inherited GetDatabaseInfo( AssignDatabase( CodigoEmpresa ), MajorVersion, MinorVersion, Release, Build, LastUpdate, Options );
end;

function TSessionDataModule.GetEnterpriseDataModule : TEnterpriseDataModule;
begin
     Result := TEnterpriseDataModule( FEnterpriseDataModule );
end;

function TSessionDataModule.GetMainDataModule: TMainDataModule;
begin
     Result := TMainDataModule( FMainDataModule );
end;

function TSessionDataModule.AssignDatabase( CodigoEmpresa : String ) : TnxDatabase;

var  Database : TnxDatabase;

begin
     Database := nil;
     If   CodigoEmpresa=''
     then Database := MainDataModule.SectionDatabase
     else If   AsignaParametrosTrabajo( '00', CodigoEmpresa, Now )
          then Database := EnterpriseDataModule.SectionDatabase;
     Result := Database;
end;

function TSessionDataModule.InitializeDatabase( CodigoEmpresa  : String ) : Boolean;

var Database : TnxDatabase;

begin
     Result := False;
     InitializingDatabase := True;
     ServerLocked := True;
     try
       CloseSessions( [ ctLicensing, ctRPC, ctWindows ], Self );
       Database := AssignDatabase( CodigoEmpresa );
       Dm00.FreeAllDataModules;
       CloseGlobalFiles;

       If   Assigned( Database )
       then Result := inherited InitializeDatabase( Database );

     finally
       InitializingDatabase := False;
       ServerLocked := False;
       OpenGlobalFiles;
       end;
end;

function TSessionDataModule.RecoverDatabase( CodigoEmpresa    : String;
                                             RecoverTableList : TStringArray): Boolean;
var Database : TnxDatabase;

begin
     Result := False;
     RecoveringDatabase := True;
     ServerLocked := True;

     try

       CloseSessions( [ ctLicensing, ctRPC, ctWindows ], Self );

       Database := AssignDatabase( CodigoEmpresa );
       Dm00.FreeAllDataModules;
       CloseGlobalFiles;

       If   Assigned( Database )
       then Result := inherited RecoverDatabase( Database, RecoverTableList );

      finally
        RecoveringDatabase := False;
        ServerLocked := False;
        OpenGlobalFiles;
        end;

end;

procedure TSessionDataModule.EraseEnterpriseDatabase( CodigoEmpresa : String );

var  DataPath : String;

begin
     If   EmpresaTable.FindKey( [ CodigoEmpresa ] )
     then begin
          DataPath := EnterpriseDataPath( EmpresaFields.DataPath.Value, CodigoEmpresa );
          EraseDirectory( DataPath );
          end
     else SendNotification( ntError, RsEmpresaInexistente );
end;

// Pasar un CodigoEmpresa vacío para actualizar la base de datos de la aplicación (data)

procedure TSessionDataModule.UpdateDatabase( CodigoEmpresa : String = '' );

var Database : TnxDatabase;

begin
     UpdatingDatabase := True;
     ServerLocked := True;
     try

       try
         Database := AssignDatabase( CodigoEmpresa );  // Ojo, AssignDatabase accede a EmpresaTable
       except on E : Exception do
         If   ( E is EnxDatabaseError ) and ( EnxDatabaseError( E ).ErrorCode=DBIERR_INVALIDDIR )   // El directorio de la base de datos no existe. Salgamos sin hacer demasiado ruido.
         then Exit
         else raise;
         end;

       CloseSessions( [ ctLicensing, ctRPC, ctWindows ], Self );  // Cierro todas las sesiones .
       Dm00.FreeAllDataModules;
       CloseGlobalFiles;
       If   Assigned( Database )
       then inherited UpdateDatabase( CodigoEmpresa, Database );
     finally
       UpdatingDatabase := False;
       ServerLocked := False;
       OpenGlobalFiles;
       end;
end;

function TSessionDataModule.BackupDatabaseTables( UserDatabase       : Boolean;
                                                  BackupDatabasePath : String;
                                                  TableNames         : String ) : Boolean;  // Lista de nombres de tabla separada por comas

var  TableName : String;
     ListaTablas : TStringList;
     Database : TnxeDatabase;

begin
     Result := False;
     ListaTablas := TStringList.Create;
     try

       ListaTablas.CommaText := TableNames;

       BackupDatabase.Session := DBSession;
       BackupDatabase.AliasPath := AddPathDelim( BackupDatabasePath );
       BackupDatabase.Open;

       If   UserDatabase
       then Database := EnterpriseDataModule.Database
       else Database := MainDataModule.Database;

       For TableName in ListaTablas do
         BackupTable( Database, BackupDatabase, TableName );

       Result := True;

     finally
       ListaTablas.Free;
       BackupDatabase.Close;
       end;
end;

{ TServerDataModuleHelper }

function TServerDataModuleHelper.GetSessionDataModule: TSessionDataModule;
begin
     Result := TSessionDataModule( FSessionDataModule ); // El tipo base es BaseSessionDataModule
end;

{ TSessionModuleHelper }

function TSessionModuleHelper.GetSessionDataModule : TSessionDataModule;
begin
     Result := TSessionDataModule( FSessionDataModule );
end;

end.


