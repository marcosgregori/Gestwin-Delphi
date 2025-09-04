unit SessionIntf;

interface

uses  System.Types,
      SysUtils,

      nxllComponent,
      nxllTypes,
      nxivTypes,
      nxrdClass,
      nxrbTypes,
      nxsdTypes,

      DB,
      nxDB,

      LibUtils,
      AppManager;

const CLSID_SessionService : TnxGuid = '{D25D329E-527A-479A-A245-AE83DB3C6404}';

      // Errores de inicialización de la sesión

      SE_Correct = 0;
      SE_CantInitiateSession = -1;   // Los valores deben emprezar en -1 e ir decreciendo ( -1..-99 )
      SE_VersionMismatch = -2;
      SE_ServerLocked = -3;
      SE_ServerNeedsUpgrade = -4;
      SE_CantStartProcess = -5;


type

   TOnStartProgress = procedure( MarqueeMode : Boolean = False; MaxValue : LongInt = 100 ) of object;
   TOnProgress = function ( ObjectName : String; Percent1, Percent2 : SmallInt ) : Boolean of object;
   TOnEndProgress = procedure of object;

   INotificationCallback = interface(InxInvokable)
    ['{CFBC5146-9FBB-4DF4-949F-072A8393F40F}']
    function SendNotification( NotificationType : TNotificationType; Caption: String = ''; Description : String = '' ) : Boolean;
    end;

   IProgressCallback = interface(InxInvokable)
    ['{E8686E14-0649-477F-9E73-CFC6C63318FB}']
    procedure StartProgress( MarqueeMode : Boolean = False; MaxValue : LongInt = 100 );
    function SendProgress( ObjectName : String; Percent1, Percent2 : SmallInt ) : Boolean;
    procedure EndProgress;
    end;

  ISessionService = interface( InxInvokable )
    ['{C82139E7-1D4C-41A8-92B9-0E51FDADC068}']

    function InitializeSession( const ProgramNumber          : SmallInt;
                                      ClientApplicationPath  : String;
                                const FixedPath              : Boolean;
                                const ComputerName           : String;
                                const UserName               : String;
                                const ClientVersion          : String;
                                out   UpgradeNeeded          : Boolean;
                                out   Is64BitsServer         : Boolean ) : Integer;

    function SessionCount( const CodigoEmpresa : String = '' ) : SmallInt;

    // Devuelve el Id del SessionData, o -1 si no ha podido inicializarse la sesión

    function AccesoUsuario( const CodigoUsuario : String;
                            const AccesoInicial : Boolean;
                            const PalabraDePaso : String;
                            const CodigoEmpresa : String;
                            const Fecha         : TDate;
                            out   MensajeError  : String ): Boolean;

    // function GetSessionID : TnxSessionID;

    function GetNotificationCallback: INotificationCallback;
    procedure SetNotificationCallback(const ACallback: INotificationCallback);

    function GetProgressCallback: IProgressCallback;
    procedure SetProgressCallback(const ACallback: IProgressCallback);

    // Utilidades de las bases de datos a las que accede la sesión

    {
    function StartTransaction( Notify : Boolean ) : LongInt;
    procedure Commit( TransactionId : LongInt = - 1 );
    procedure Rollback( TransactionId : LongInt = - 1 );
    // procedure ResetTransactions;
    }

    procedure GetDatabaseInfo( const CodigoEmpresa : String; out MajorVersion : Word; out MinorVersion : Word; out Release : Word; out Build : Word; out LastUpdate : TDateTime; out Options : String );
    function InitializeDatabase( const CodigoEmpresa : String ) : Boolean;
    function RecoverDatabase( const CodigoEmpresa : String; RecoverTableList : TStringArray ) : Boolean;
    procedure EraseEnterpriseDatabase( const CodigoEmpresa : String );
    procedure UpdateDatabase( const CodigoEmpresa : String = '' );
    function BackupDatabaseTables( UserDatabase : Boolean; BackupDatabasePath : String; TableNames : String ) : Boolean;

    procedure RegisterOptionDataModule( OptionalDataModule : TModuloOpcional );

    // procedure CloseSession;
    // procedure CloseSessionService( SessionDataModuleID : Integer );  // Uso interno

    procedure FreeAllSessionDataModules;
    function CheckKey( RemoteCursorID  : TnxCursorID; const Key : TVariantArray; const DescFieldNames  : TStringArray; out DescFieldValues : TVariantArray ) : Boolean;

    function  GetApplicationPath : String;
    function  GetRootDataPath : String;
    function  GetTemporalDataPath : String;

    // property SessionID : TnxSessionID read GetSessionID;

    property NotificationCallback: INotificationCallback read GetNotificationCallback write SetNotificationCallback;
    property ProgressCallback: IProgressCallback read GetProgressCallback write SetProgressCallback;

    end;

  ISessionModule = interface( InxInvokable )
    ['{299398B5-FD14-4558-B6B8-F726C2DB9AC1}']

    // Los servicios de los módulos deben llamar a esta función antes de realizar cualquier otra operación, para fijar
    // la sesión a la que pertenece

    procedure AssignSession( const SessionID : Integer );
    end;

  IBaseSessionDataModule = interface( IInterface )
    ['{1AEB322E-06A9-4F95-BD1E-35DD13B97A1E}']

    function GetId : Integer;
    function AsignaParametrosTrabajo( CodigoUsuario, CodigoEmpresa : String; Fecha : TDate ) : Boolean;

    property Id : Integer read GetId;
    end;

  IInvokableRecord = interface( InxInvokable )
    ['{748028FE-7691-4AA8-93F0-3E9E2D3B518C}']

    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );

    property State : TDataSetState read GetState write SetState;
    end;

  TSessionModule = class( TnxClass, ISessionModule )
    protected

    FSessionDataModule : IBaseSessionDataModule;

    procedure AssignSession( const SessionID : Integer ); virtual; abstract;

    public
    property SessionDataModule : IBaseSessionDataModule read FSessionDataModule;

    end;

function GetFieldAsVariant( Field : TField ) : Variant;
procedure SetFieldAsVariant( Field : TField; Value : Variant );

var ServerSide : Boolean = False;     // Indica que estamos ejecutando una aplicación servidor (igual que Applicationmanager.ServerApplication)

implementation

uses  Variants;

function GetFieldAsVariant( Field : TField ) : Variant;
begin
     If   Assigned( Field )
     then Result := Field.AsVariant
     else Result := Null;
end;

procedure SetFieldAsVariant( Field : TField; Value : Variant );
begin
     If   Assigned( Field )
     then Field.AsVariant := Value;
end;

initialization
   nxInvokeRegistry.RegisterInterface( TypeInfo( INotificationCallback ) );
   nxInvokeRegistry.RegisterInterface( TypeInfo( IProgressCallback ) );
   nxInvokeRegistry.RegisterInterface( TypeInfo( ISessionService ) );
   nxInvokeRegistry.RegisterInterface( TypeInfo( ISessionModule ) );
   nxInvokeRegistry.RegisterInterface( TypeInfo( IBaseSessionDataModule ) );
   nxInvokeRegistry.RegisterInterface( TypeInfo( IInvokableRecord ) );

end.
