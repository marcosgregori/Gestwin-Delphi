unit nxsrServerMutex;

interface

{$I ..\Lib\nxsrDefine.inc}

uses
  SysUtils,
  nxllUtils, nxExeConst,
  {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF};

procedure CreateServerMutex;
procedure CreateTrayMutex;

implementation

function CreateMutexName: string;  //..

var ServiceName : String;

begin
     Result := nxAppHomeDirectory( nxAppDataSubdirVista );
     If   not nxFindCmdLineParam( 'SERVICENAME', ServiceName )
     then ServiceName := ExtractFileName( ParamStr( 0 ) );
     Result := Result + ServiceName;
     Result := StringReplace(result, ':', '_', [rfReplaceAll]);
     Result := StringReplace(result, '\', '_', [rfReplaceAll]);
     Result := StringReplace(result, '/', '_', [rfReplaceAll]);
end;

procedure CreateServerMutex;
var
  LastError    : DWord;
  SecurityDesc : TSecurityDescriptor;
  SecurityAttr : TSecurityAttributes;
  aName        : string;
  res          : Cardinal;
begin
  InitializeSecurityDescriptor(@SecurityDesc, SECURITY_DESCRIPTOR_REVISION);
  SetSecurityDescriptorDacl(@SecurityDesc, True, nil, False);
  SecurityAttr.nLength := SizeOf(SecurityAttr);
  SecurityAttr.lpSecurityDescriptor := @SecurityDesc;
  SecurityAttr.bInheritHandle := False;

  aName := 'Global\Server__' + CreateMutexName;

//  LastError := GetLastError;
  res := CreateMutex(@SecurityAttr, True, PChar(aName));
  LastError := GetLastError;
  if (res = 0) then
    raise EOSError.Create('No se puede crear el mutex del servidor, código de error: ' + IntToStr(LastError));
  if (LastError = ERROR_ALREADY_EXISTS) then
    raise EOSError.Create('Ya existe otra instancia del servidor en ejecución');
end;

procedure CreateTrayMutex;
var
  LastError    : DWord;
  SecurityDesc : TSecurityDescriptor;
  SecurityAttr : TSecurityAttributes;
  aName        : string;
  res          : Cardinal;
begin
  InitializeSecurityDescriptor(@SecurityDesc, SECURITY_DESCRIPTOR_REVISION);
  SetSecurityDescriptorDacl(@SecurityDesc, True, nil, False);
  SecurityAttr.nLength := SizeOf(SecurityAttr);
  SecurityAttr.lpSecurityDescriptor := @SecurityDesc;
  SecurityAttr.bInheritHandle := False;

  aName := 'Local\Tray__' + CreateMutexName;

//  LastError := GetLastError;
  res := CreateMutex(@SecurityAttr, True, PChar(aName));
  LastError := GetLastError;
  if (res = 0) then
    raise EOSError.Create('No se puede crear el mutex del icono de la bandeja, código de error: ' + IntToStr(LastError));
  if (LastError = ERROR_ALREADY_EXISTS) then
    raise EOSError.Create('El icono de la bandeja de esta instancia ya está activo.');
end;

end.
