unit nxwsBasicAuthentication;

interface

uses
  nxwsBaseWebServer, nxllBase64, sysutils;

type
  TnxBasicAuthentication = class(TnxBaseAuthentication)
  protected
    function GetAuthenticationReqest: string; override;
    function Decode(encoded : string): String; override;
  end;

implementation

{ TnxBasicAuthentication }

function TnxBasicAuthentication.Decode(encoded: string): String;
begin
  result:=trim(encoded);
  result:=string(Base64ToStr(AnsiString(result)));
end;

function TnxBasicAuthentication.GetAuthenticationReqest: string;
begin
  result:='WWW-Authenticate: Basic realm="'+fRealm+'"';
end;

initialization
  TnxBasicAuthentication.Register('BASIC');
end.

