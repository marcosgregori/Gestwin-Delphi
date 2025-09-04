unit UpdateService;

{$I kbmMW.inc}

interface

uses
  SysUtils,
{$ifdef LEVEL6}
  Variants,
{$else}
  VCL.Forms,
{$endif}
  Classes,
  kbmMWSecurity,
  kbmMWServer,
  kbmMWServiceUtils,
  kbmMWGlobal,
  kbmMWFileService,
  kbmMWFilePool;

type
  TUpdateService = class(TkbmMWFileService)
    procedure kbmMWFileServiceAuthenticate(Sender: TObject;
      ClientIdent: TkbmMWClientIdentity; var Perm: TkbmMWAccessPermissions;
      var AMessage: string);
    procedure kbmMWFileServiceFileAccess(Sender: TObject; var Path: string;
      var AccessPermissions: TkbmMWFileAccessPermissions);
    procedure kbmMWFileServiceCreate(Sender: TObject);
  private

     ReadLock : Boolean;

     function CheckRegister( SerialNumber,
                             RegNumber          : Int64;
                             ProgramNumber,
                             ProgramVersion,
                             ProgramRelease,
                             ServerConnections : SmallInt ) : SmallInt;
    function PerformLockRead(ClientIdent: TkbmMWClientIdentity;
      const Args: array of Variant): Variant;

  protected

     function ProcessRequest(const Func:string; const ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant; override;
     function PerformInstall(ClientIdent: TkbmMWClientIdentity; const Args: array of Variant): Variant;
     function PerformUpgrade(ClientIdent: TkbmMWClientIdentity; const Args: array of Variant): Variant;
     function PerformCreateDirPath(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
     function PerformGetFileVersion(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
     function PerformGetFileSize(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
     function PerformGetFileStamp(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
     function PerformFileExists(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
  public
     { Public declarations }
     class function GetPrefServiceName:string; override;
     class function GetFlags:TkbmMWServiceFlags; override;
  end;

var  ServerRootPath : String = 'ServerData';
     CodigoEmpresaLicencias : String = '001';

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses kbmMWExceptions,
     Files,
     LibUtils,
     DataManager,
     AppManager,
     EnterpriseData,
     BaseSessionData,
     SessionData,

     ServerContainer,
     SuscriptionConsts,

     nxdmServer;

{$R *.dfm}

const ServiceName = 'UpdateService';

// Service definitions.
//---------------------

class function TUpdateService.GetPrefServiceName:string;
begin
     Result := ServiceName;
end;

procedure TUpdateService.kbmMWFileServiceAuthenticate(     Sender      : TObject;
                                                           ClientIdent : TkbmMWClientIdentity;
                                                       var Perm        : TkbmMWAccessPermissions;
                                                       var AMessage    : string );
begin
     If   ClientIdent.Username='gwadmin'
     then begin
          If   ClientIdent.Password='gaBc42_AA'
          then Perm := [ mwapRead, mwapWrite, mwapDelete, mwapExecute, mwapInternalExecute ]
          end
     else If   ClientIdent.Username='gwuser'
          then If   ClientIdent.Password='gdA2076_b2'
               then Perm := [ mwapRead, mwapExecute ];
end;

procedure TUpdateService.kbmMWFileServiceCreate(Sender: TObject);
begin
     BoundTransport := ServerContainerModule.FileServerTransport;
     FilePool := ServerContainerModule.FilePool;
end;

procedure TUpdateService.kbmMWFileServiceFileAccess(     Sender            : TObject;
                                                     var Path              : String;
                                                     var AccessPermissions : TkbmMWFileAccessPermissions);
begin
     AccessPermissions := AccessPermissions + [ mwfapOverwrite ];
end;

class function TUpdateService.GetFlags:TkbmMWServiceFlags;
begin
     Result:=[ mwsfListed, mwsfListRequireAuth, mwsfRunRequireAuth ];
end;

// Master request processor.
//--------------------------

function TUpdateService.ProcessRequest(const Func:string; const ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
var
   AFunc:string;
begin
     AFunc:=UpperCase(Func);
     if AFunc='INSTALL' then
        Result:=PerformInstall(ClientIdent,Args)
     else if AFunc='FILEEXISTS' then
        Result:=PerformFileExists(ClientIdent,Args)
     else if AFunc='UPGRADE' then
        Result:=PerformUpgrade(ClientIdent,Args)
     else if AFunc='CREATEDIRPATH' then
        Result:=PerformCreateDirPath(ClientIdent,Args)
     else if AFunc='GETFILEVERSION' then
        Result:=PerformGetFileVersion(ClientIdent,Args)
     else if AFunc='GETFILESIZE' then
        Result:=PerformGetFileSize(ClientIdent,Args)
     else if AFunc='GETFILESTAMP' then
        Result:=PerformGetFileStamp(ClientIdent,Args)
     else if AFunc='LOCKREAD' then
        Result:=PerformLockRead(ClientIdent,Args)
     else Result:=inherited ProcessRequest(Func,ClientIdent,Args);
end;


// Functions published by the service.
//------------------------------------

function TUpdateService.PerformCreateDirPath(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var  Path : String;

begin
     try
       Path := ApplicationPath + ServerRootPath + '\' + Args[ 0 ];
       CreateDirPath( Path );
       Result := True;
     except
       Result := False;
       end;
end;


// No compruebo la clave de activación, porque la supongo verificada en el cliente

function TUpdateService.CheckRegister( SerialNumber,
                                       RegNumber          : Int64;
                                       ProgramNumber,
                                       ProgramVersion,
                                       ProgramRelease,
                                       ServerConnections : SmallInt ) : SmallInt;

var  SessionDataModule : TSessionDataModule;
     NroSerieEncontrado,
     VersionDiferenteEncontrada,
     NroUsuariosDiferente,
     Encontrado : Boolean;

begin
     SessionDataModule := GetSessionDataModuleExt( ctLicensing, '', ServiceName, '', CodigoEmpresaLicencias );
     If   Assigned( SessionDataModule )
     then With SessionDataModule.Dm91.LicenciasModule do
            try
              If   not TarjetaRegistroTable.FindKey( [ RegNumber ] )
              then Result := CCL_USUARIOINCORRECTO
              else If   TarjetaRegistroFields.TipoContrato.Value=2
                   then Result := CCL_BLOQUEADO
                   else If   ( TarjetaRegistroFields.NroSerie.Value<>SerialNumber ) or
                             ( TarjetaRegistroFields.Version.Value<>ProgramVersion ) or
                             ( TarjetaRegistroFields.Release.Value<>ProgramRelease ) or
                             ( TarjetaRegistroFields.NroUsuarios.Value<>ServerConnections )
                        then begin
                             NroSerieEncontrado := False;
                             VersionDiferenteEncontrada := False;
                             NroUsuariosDiferente := False;
                             Encontrado := False;
                             With LineaTarjetaRegistroTable do
                               begin
                               SetRange( [ TarjetaRegistroFields.NroRegistro.Value, 0 ], [ TarjetaRegistroFields.NroRegistro.Value, MaxSmallInt ] );
                               First;
                               While not Eof do
                                 begin
                                 If   LineaTarjetaRegistroFields.NroSerie.Value=SerialNumber
                                 then begin
                                      NroSerieEncontrado := True;
                                      If   ( LineaTarjetaRegistroFields.Version.Value=ProgramVersion ) and
                                           ( LineaTarjetaRegistroFields.Release.Value=ProgramRelease )
                                      then begin
                                           If   LineaTarjetaRegistroFields.NroUsuarios.Value=ServerConnections
                                           then begin
                                                Encontrado := True;
                                                Break;
                                                end
                                           else NroUsuariosDiferente := True;
                                           end
                                      else VersionDiferenteEncontrada := True  // Puede que haya otro registro de la versión correcta. Se sigue buscando;
                                      end;
                                 Next;
                                 end;
                               end;

                             If   Encontrado
                             then Result := CCL_CORRECTA
                             else If   NroSerieEncontrado
                                  then begin
                                       If   VersionDiferenteEncontrada
                                       then Result := CCL_VERSIONINCORRECTA
                                       else If   NroUsuariosDiferente
                                            then Result := CCL_NROUSUARIOSDIFERENTE
                                            else Result := CCL_NROPROGRAMAINCORRECTO;
                                       end
                                  else Result := CCL_NROSERIEINCORRECTO;

                             end
                        else If   TarjetaRegistroFields.Aplicacion.Value<>ProgramNumber
                             then Result := CCL_NROPROGRAMAINCORRECTO
                             else If   ( TarjetaRegistroFields.Version.Value<>ProgramVersion ) and
                                       ( TarjetaRegistroFields.Release.Value<>ProgramRelease )
                                  then Result := CCL_VERSIONINCORRECTA
                                  else If   TarjetaRegistroFields.NroUsuarios.Value<>ServerConnections
                                       then Result := CCL_NROUSUARIOSDIFERENTE
                                       else Result := CCL_CORRECTA;

              except
                Result := CCL_ERRORINTERNO;
                end;

end;

function IsInternalLocation( Location : String ) : Boolean;

var  Ap : SmallInt;

begin
     Result := False;
     Ap := Pos( ':', Location );
     If   Ap>0
     then Location := Copy( Location, 1, Ap - 1 );
     Result := Pos( Location, dmServer.FileServiceSettings.InternalAddresses )>0;
     ShowNotification( ntInformation, 'Internal location check : ' + Location + ' -> ' + dmServer.FileServiceSettings.InternalAddresses + ' Result = ' + StrBoolean( Result ) );
end;

{* -----------------------------------------------------------------------------

 @params SerialNumber
         ActivationKey
         RegNumber
         ProgramNumber
         ProgramVersion
         ProgramRelease
         ServerConnections

   ------------------------------------------------------------------------------}

function TUpdateService.PerformUpgrade(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var  SessionDataModule : TSessionDataModule;
     SerialNumber,
     ActivationKey,
     RegNumber : Int64;
     ProgramNumber,
     ProgramVersion,
     ProgramRelease,
     ServerConnections : SmallInt;

begin

     Result := CCL_ERROR;

     try

       SerialNumber := Args[ 0 ];
       ActivationKey := Args[ 1 ];
       RegNumber := Args[ 2 ];
       ProgramNumber := Args[ 3 ];
       ProgramVersion := Args[ 4 ];
       ProgramRelease := Args[ 5 ];
       ServerConnections := Args[ 6 ];

       SessionDataModule := GetSessionDataModuleExt( ctLicensing, '', ServiceName, '', CodigoEmpresaLicencias );
       If   Assigned( SessionDataModule )
       then With SessionDataModule.Dm91.LicenciasModule do
              begin

              If   IsInternalLocation( ClientIdent.RemoteLocation ) // Uso Interno
              then Result := CCL_CORRECTA
              else Result := CheckRegister( SerialNumber, RegNumber, ProgramNumber, ProgramVersion, ProgramRelease, ServerConnections  );

              RegistroActualizacionesTable.Append;

              RegistroActualizacionesFields.Fecha.Value := Now;
              RegistroActualizacionesFields.NroSerie.Value := SerialNumber;
              RegistroActualizacionesFields.ClaveActivacion.Value := ActivationKey;
              RegistroActualizacionesFields.NroRegistroAplicacion.Value := RegNumber;
              RegistroActualizacionesFields.NroPrograma.Value := ProgramNumber;
              RegistroActualizacionesFields.Version.Value := ProgramVersion;
              RegistroActualizacionesFields.Release.Value := ProgramRelease;
              RegistroActualizacionesFields.Localizacion.Value := { ClientIdent.ClientLocation; //  + ' ' +} ClientIdent.RemoteLocation;
              RegistroActualizacionesFields.CodigoResultado.Value := Result;

              RegistroActualizacionesTable.Post;
              end;

       except
         Result := CCL_ERRORINTERNO;
         end;


end;

function TUpdateService.PerformInstall(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var  SessionDataModule : TSessionDataModule;
     SerialNumber,
     ActivationKey,
     RegNumber : Int64;
     ProgramNumber,
     ProgramVersion,
     ProgramRelease,
     ServerConnections : SmallInt;

begin

     Result := CCL_ERROR;

     try

       SerialNumber := Args[ 0 ];
       ActivationKey := Args[ 1 ];
       RegNumber := Args[ 2 ];
       ProgramNumber := Args[ 3 ];
       ProgramVersion := Args[ 4 ];
       ProgramRelease := Args[ 5 ];
       ServerConnections := Args[ 6 ];

       SessionDataModule := GetSessionDataModuleExt( ctLicensing, '', ServiceName, '', CodigoEmpresaLicencias );
       If   Assigned( SessionDataModule )
       then With SessionDataModule.Dm91.LicenciasModule do
              begin

              Result := CheckRegister( SerialNumber, RegNumber, ProgramNumber, ProgramVersion, ProgramRelease, ServerConnections  );

              RegistroAplicacionTable.Append;

              RegistroAplicacionFields.Fecha.Value := Now;
              RegistroAplicacionFields.NroSerie.Value := SerialNumber;
              RegistroAplicacionFields.ClaveActivacion.Value := ActivationKey;
              RegistroAplicacionFields.NroRegistroAplicacion.Value := RegNumber;
              RegistroAplicacionFields.NroPrograma.Value := ProgramNumber;
              RegistroAplicacionFields.Version.Value := ProgramVersion;
              RegistroAplicacionFields.Release.Value := ProgramRelease;
              RegistroAplicacionFields.NroUsuarios.Value := ServerConnections;
              RegistroAplicacionFields.Localizacion.Value := ClientIdent.ClientLocation + ' ' + ClientIdent.RemoteLocation;
              RegistroAplicacionFields.CodigoResultado.Value := Result;

              RegistroAplicacionTable.Post;

              end;

     except
       Result := CCL_ERRORINTERNO;
       end;
end;


function TUpdateService.PerformLockRead(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;
begin
     ReadLock := Args[ 0 ];
end;

function TUpdateService.PerformGetFileVersion(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var  FilePath : String;
     IncludeBuild : Boolean;
     Major,
     Minor,
     Release,
     Build : Word;
     Prerelease,
     Debug,
     SpecialBuild,
     PrivateBuild : Boolean;

begin
     Result := 0;
     FilePath := ApplicationPath + ServerRootPath + '\' + Args[ 0 ];
     IncludeBuild := Args[ 1 ];
     VersionInfo := GetFileVersion( FilePath );
     If   kbmMWGetFileVersionInfo( FilePath, Major, Minor, Release, Build, Prerelease, Debug, SpecialBuild, PrivateBuild )
     then If   IncludeBuild
          then Result := GetComparableVersion( Major, Minor, Release, Build )
          else Result := GetComparableVersion( Major, Minor, Release );
end;

// Utilizo FindFirst para obtener información de los ficheros porque las funciones GetFileSize y GetFileStamp no
// permiten leer ficheros en uso

function TUpdateService.PerformGetFileSize(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var  FilePath : String;
     Size : Int64;
     FileInfo : TSearchRec;

begin
     Result := 0;
     FilePath := ApplicationPath + ServerRootPath + '\' + Args[ 0 ];
     If   SysUtils.FindFirst( FilePath, faArchive, FileInfo )=0
     then begin
          Result := FileInfo.Size;
          SysUtils.FindClose( FileInfo );
          end;
end;

function TUpdateService.PerformGetFileStamp(ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant;

var  FilePath : String;
     FileInfo : TSearchRec;

begin
     Result := LowestStrDate;
     FilePath := ApplicationPath + ServerRootPath + '\' + Args[ 0 ];
     If   SysUtils.FindFirst( FilePath, faArchive, FileInfo )=0
     then begin
          Result := DateTimeToStr( FileInfo.TimeStamp );
          SysUtils.FindClose( FileInfo );
          end;
end;

function TUpdateService.PerformFileExists(ClientIdent: TkbmMWClientIdentity; const Args: array of Variant): Variant;

var  FilePath : String;

begin
     FilePath := ApplicationPath + ServerRootPath + '\' + Args[ 0 ];
     Result := FileExists( FilePath )
end;

end.
