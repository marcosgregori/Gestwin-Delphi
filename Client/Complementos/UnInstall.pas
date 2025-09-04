unit UnInstall;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.IniFiles,
  Data.DB,
  Winapi.Windows,
  System.Win.Registry;

type  TUnInstallAppInfo = record
        RegKeyBaseName,
        DisplayName,
        DisplayIcon,
        ExeFilename,
        AppInstallPath,
        AppVersion,
        AppPublisher,
        AppPublisherURL,
        AppSupportPhone,
        AppSupportURL,
        AppUpdatesURL,
        AppReadmeFile,
        AppContact,
        AppComments,
        AppModifyPath : String;
        end;

procedure SetRegisterUnInstallInfo( var UnInstallAppInfo : TUnInstallAppInfo );
function  GetRegisterUnInstallInfo( KeyBaseName : String ) : TUnInstallAppInfo;
procedure DeleteRegisterUnInstallInfo( KeyName : String );

implementation

type  TRegErrorFunc = ( reRegSetValueEx, reRegCreateKeyEx, reRegOpenKeyEx );

conSt SetupVersion = '1.0';

      NEWREGSTR_PATH_SETUP = 'Software\Microsoft\Windows\CurrentVersion';
      NEWREGSTR_PATH_EXPLORER = NEWREGSTR_PATH_SETUP + '\Explorer';
      NEWREGSTR_PATH_SPECIAL_FOLDERS = NEWREGSTR_PATH_EXPLORER + '\Shell Folders';
      NEWREGSTR_PATH_UNINSTALL = NEWREGSTR_PATH_SETUP + '\Uninstall';
      NEWREGSTR_VAL_UNINSTALLER_DISPLAYNAME = 'DisplayName';
      NEWREGSTR_VAL_UNINSTALLER_COMMANDLINE = 'UninstallString';

      KEY_WOW64_64KEY = $0100;

var   ErrorCode: Longint;
      Hk : HKEY;

procedure RegError( conSt Func      : TRegErrorFunc;
                    conSt RootKey   : HKEY;
                    conSt KeyName   : String );

begin
     raise Exception.Create( Format( 'Error en el registro. Clave : %s, Código de error : %d.', [ KeyName, ErrorCode ] ) );
end;

procedure SetRegisterUnInstallInfo( var UnInstallAppInfo : TUnInstallAppInfo );

  { Almacena información de desinStalación en el registro de forma que el programa pueda ser
    desinStalado desde la opción del Panel de Control Modificar/Des-instalar programas }

var  RootKey: HKEY;
     SubkeyName: String;
     Reg : TRegistry;
     Z : String;

procedure WtiteStringIfNotEmpty( Key, Value : String );
begin
     If   Value<>''
     then Reg.WriteString( Key, Value );
end;

function GetInstallDateString: String;

var  St : TSyStemTime;

begin
     GetLocalTime( St );
     Result := Format('%.4u%.2u%.2u', [ St.wYear, St.wMonth, St.wDay ]);
end;

begin

     Reg := TRegistry.Create;

     try

       If   UnInstallAppInfo.RegKeyBaseName=''
       then UnInstallAppInfo.RegKeyBaseName := UnInstallAppInfo.DisplayName;

       SubkeyName := NEWREGSTR_PATH_UNINSTALL + '\' + UnInstallAppInfo.RegKeyBaseName;

       // Si ya existe la misma clave la borro antes de crearla, tando en HKEY_CURRENT_USER como en HKEY_LOCAL_MACHINE

       DeleteRegisterUnInstallInfo( SubKeyName );

       // Y creo la clave de desinstalación (solo admin)

       Reg.RootKey := HKEY_LOCAL_MACHINE;   // Si no fuese Administrador entonces RootKey := HKEY_CURRENT_USER;

       If   Reg.CreateKey( SubKeyName )
       then begin

            Reg.WriteString( 'DisplayName', UnInstallAppInfo.DisplayName );

            If   UnInstallAppInfo.DisplayIcon<>''
            then Reg.WriteString( 'DisplayIcon', UnInstallAppInfo.DisplayIcon );

            Reg.WriteString(  'UnInstallString', UnInstallAppInfo.ExeFilename );
            Reg.WriteString( 'InstallPath', UnInstallAppInfo.AppInstallPath );

            WtiteStringIfNotEmpty( 'DisplayVersion', UnInstallAppInfo.AppVersion );
            WtiteStringIfNotEmpty( 'Publisher', UnInstallAppInfo.AppPublisher );
            WtiteStringIfNotEmpty( 'URLInfoAbout', UnInstallAppInfo.AppPublisherURL );
            WtiteStringIfNotEmpty( 'HelpTelephone', UnInstallAppInfo.AppSupportPhone );
            WtiteStringIfNotEmpty( 'HelpLink', UnInstallAppInfo.AppSupportURL );
            WtiteStringIfNotEmpty( 'URLUpdateInfo', UnInstallAppInfo.AppUpdatesURL );
            WtiteStringIfNotEmpty( 'Readme', UnInstallAppInfo.AppReadmeFile );
            WtiteStringIfNotEmpty( 'Contact', UnInstallAppInfo.AppContact );
            WtiteStringIfNotEmpty( 'Comments', UnInstallAppInfo.AppComments );

            Z := UnInstallAppInfo.AppModifyPath;
            If   Z<>''
            then Reg.WriteString( 'ModifyPath', Z)
            else Reg.WriteInteger( 'NoModify', 1 );

            Reg.WriteInteger( 'NoRepair', 1);
            Reg.WriteString( 'InstallDate', GetInstallDateString );

            Reg.CloseKey;
            end;

      finally
        Reg.Free;
        end;
end;

function  GetRegisterUnInstallInfo( KeyBaseName : String ) : TUnInstallAppInfo;

var  Reg : TRegistry;
     SubkeyName: String;

begin

     Reg := TRegistry.Create;

     try

       Reg.RootKey := HKEY_LOCAL_MACHINE;
       SubkeyName := NEWREGSTR_PATH_UNINSTALL + '\' + KeyBaseName;

       If   Reg.OpenKey( SubKeyName, True )
       then With Result do
              begin
              RegKeyBaseName := KeyBaseName;
              DisplayName := Reg.ReadString( 'DisplayName' );
              DisplayIcon := Reg.ReadString( 'DisplayIcon' );
              ExeFilename := Reg.ReadString( 'UnInstallString' );
              AppInstallPath := Reg.ReadString( 'InstallPath' );
              AppVersion := Reg.ReadString( 'DisplayVersion' );
              AppPublisher := Reg.ReadString( 'Publisher' );
              AppPublisherURL := Reg.ReadString( 'URLInfoAbout' );
              AppSupportPhone := Reg.ReadString( 'HelpTelephone' );
              AppSupportURL := Reg.ReadString( 'HelpLink' );
              AppUpdatesURL := Reg.ReadString( 'URLUpdateInfo' );
              AppReadmeFile := Reg.ReadString( 'Readme' );
              AppContact := Reg.ReadString( 'Contact' );
              AppComments := Reg.ReadString( 'Comments' );
              AppModifyPath := Reg.ReadString( 'ModifyPath' );

              Reg.CloseKey;
              end;

     finally
       Reg.Free;
       end;

end;

procedure DeleteRegisterUnInstallInfo( KeyName : String );

var  Reg : TRegistry;
     // KeyName : String;

begin
     Reg := TRegistry.Create;
     try
       // KeyName := NEWREGSTR_PATH_UNINSTALL + '\' + KeyBaseName;
       Reg.RootKey := HKEY_CURRENT_USER;
       If   Reg.OpenKey( KeyName, True )
       then Reg.DeleteKey( KeyName );
       Reg.RootKey := HKEY_LOCAL_MACHINE;
       If   Reg.OpenKey( KeyName, True )
       then Reg.DeleteKey( KeyName );
     finally
       Reg.Free;
       end;
end;

end.
