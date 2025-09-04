{$IF DECLARED(FireMonkeyVersion)}
  {$DEFINE VCL}
{$ELSE}
  {$DEFINE VCL}
{$IFEND}

{$I nxDefine.inc}

{.$define CommandLineServer}
{.$define DemoWebServer}
{$define WebApplications}

{$define AllowInactiveCleanup}  //..

{$define FullServerUI}
{.$define FancyServer}

{$define ServiceSupport}

{$define RemoteAdministration}
{.$define SSLRemoteAdministration}

{$define RemoteCommands}

{$define ServerScripting}

{.$define UseDirectHTTP}
{.$define UDF_NET}
{$define UDF_Scripts}

{.$define PortalGateway}

{.$define PackagedServer}
{.$define UseSummary}

{.$define UseReplicationMonitor}

{.$define ASPNet}

{ ---- don't change below this line }
{$ifdef CommandLineServer}
  {$UNDEF ServiceSupport}
{$endif}


