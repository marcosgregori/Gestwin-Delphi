{##############################################################################}
{# NexusDB Server: nxsrDefine.inc 4.50                                        #}
{# Copyright (c) Nexus Database 2003-2018                                     #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB Server: Server Compiler options/directives include file            #}
{##############################################################################}

{$I nxDefine.inc}

{.$define CommandLineServer}
{.$define DemoWebServer}
{.$define WebApplications}

{$define FullServerUI}
{.$define FancyServer}

{$define ServiceSupport}

{$define RemoteAdministration}
{.$define SSLRemoteAdministration}

{$define RemoteCommands}

{$define ServerScripting}

{$define UseDirectHTTP}
{$define UDF_NET}
{$define UDF_Scripts}

{$IFDEF DCC16OrLater}
{$define RemoteDB}
{$ENDIF}

{.$define PortalGateway}

{.$define PackagedServer}
{.$define UseSummary}

{.$define UseReplicationMonitor}

{.$define ASPNet}

{ ---- don't change below this line }
{$ifdef CommandLineServer}
  {$UNDEF ServiceSupport}
{$endif}


