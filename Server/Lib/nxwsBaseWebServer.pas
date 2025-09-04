{##############################################################################}
{# NexusDB: nxwsBaseWebServer.pas 4.1201                                     #}
{# Copyright (c) Nexus Database 2003-2017                                     #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: Base Web Server                                                   #}
{##############################################################################}

{$I nxDefine.inc}
unit nxwsBaseWebServer;

interface

uses
  {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF},
  SysUtils,
  Variants,
  Classes,
  nxllComponent,
  nxllTypes;

const
  message_DOCNOTFOUND='<html><body><h1><b>ERROR 404</b> - Documento no encontrado</h1><p>%s</body></html>';

type
  TnxWebScriptProcessorBeforeProcess = procedure (sender: TObject; source: String) of object;

  TnxBaseWebServer = class;
  TnxHTTPRequest = class;

  TnxBaseAuthenticationClass = class of TnxBaseAuthentication;
  TnxBaseAuthentication = class
  protected
    fRealm: string;
    function GetAuthenticationReqest: string; virtual; abstract;
    function Decode(encoded : string): String; virtual; abstract;
  public

    constructor Create(aRealm: string); virtual;
    class procedure Register(aDescriptor: String);
    class function FindAuthentication(const aDescriptor: string): TnxBaseAuthenticationClass;

    property Realm: string read fRealm;
  end;

  InxSocketAdapter = interface
  ['{1003AD03-CF41-4B53-92D7-B5C9AC03F8D0}']
    function SendText(aText: AnsiString): Integer;
    function SendStream(aStream: TStream): Boolean;
  end;

  TnxBaseSessionClass = class of TnxBaseSession;
  TnxBaseSession = class(TObject)
  protected
    fLastTouch: TDateTime;
    fWebServer: TnxBaseWebServer;
    fSessionVarList: TStringlist;
  public
    procedure Touch;
    constructor Create(aWebServer: TnxBaseWebServer);
    destructor Destroy; override;
    property LastTouch: TDateTime read fLastTouch;
    property SessionVarList: TStringlist read fSessionVarList;
  end;

  TnxWebScriptProcessorClass = class of TnxWebScriptProcessor;
  TnxWebScriptProcessor = class
  private
    fBaseDir: String;
    procedure SetBaseDir(const Value: String);
  protected
    fOnBeforeProcess: TnxWebScriptProcessorBeforeProcess;
    fEqualString: string;
    fScript: TStringlist;
    fResultfileName: String;
    fFileName: String;
    fParams: String;
    fCustomObjects: TStringlist;
    fRequest: TnxHTTPRequest;

    procedure DoProcess(aRequest:TnxHTTPRequest); virtual; abstract;
    procedure DoPrepare(aRequest:TnxHTTPRequest); virtual; abstract;
    procedure DoHandleIncludes; virtual;
  public
    constructor Create(aRequest:TnxHTTPRequest); virtual;
    destructor Destroy; override;
    function ProcessFile(aFilename:String; Params: String; ResultFileName:String; aRequest:TnxHTTPRequest):integer;
    class procedure Register(anExtension: String);
    class function FindProcessor(const anExtension: string): TnxWebScriptProcessorClass;
    property OnBeforeProcess: TnxWebScriptProcessorBeforeProcess read fOnBeforeProcess write fOnBeforeProcess;
    property CustomObjects: TStringlist read fCustomObjects;
    property BaseDir: String read fBaseDir write SetBaseDir;
    property FileName: string read fFileName;
  end;

  TnxHTTPRequestClass = class of TnxHTTPRequest;
  TnxHTTPRequest = class(TnxLoggableComponent)
  private
    fUser: IUnknown;
    procedure SetUser(const Value: IUnknown);
  protected
    fOnReplyHeadersCreated: TNotifyEvent;
    fRawRequest: String;
    fWebServer: TnxBaseWebServer;
    fHeaderInfo: TStringlist;
    fRawHeaderInfo: TStringList;
    fReplyHeaders: TStringlist;
    fRequestDocument: String;
    fHttpVersion: String;
    fErrorCode: integer;
    fContentLength: integer;
    fBaseDir: string;
    fErrorMessage: String;
    fCookies: TStringlist;
    fSession: TnxBaseSession;
    fSessionClass: TnxBaseSessionClass;
    fParamList: TStringlist;
    fParams: String;
    fIsAuthorized: Boolean;
    fReplyMessage: string;
    fAuthentication: TnxBaseAuthentication;

    procedure ParseHeaders(aSocket: InxSocketAdapter; aAuth: TnxBaseAuthentication);
    procedure CreateSession; virtual;
    procedure ProcessScriptFile(aClass: TnxWebScriptProcessorClass; var resultfile: string);
    procedure BeforeProcessScript(aProcessor: TnxWebScriptProcessor); virtual;
    procedure ProcessRequest(aSocket: InxSocketAdapter); virtual;
    procedure SetParams(aString: String);
  published
  public
    constructor Create(aServer: TnxBaseWebServer; aRawRequest: String; aBaseDir: string); reintroduce; virtual;
    destructor Destroy; override;

    procedure CreateReplyHeaders; virtual;
    function URIEncode(const S: String): String;
    function Request(const what: String): Variant;
    function GetVar(const Name: String): String;
    procedure SetVar(const Name, Value: String);
    procedure SetError(code: integer; const what : String);

    property User: IUnknown read fUser write SetUser;
    property ErrorCode: integer read fErrorCode write fErrorCode;
    property RawHeaders: TStringList read fRawHeaderInfo;
    property Headers: TStringList read fHeaderInfo;
    property Cookies: TStringList read fCookies;
    property RequestDocument: string read fRequestDocument;
    property ReplyHeaders: TStringList read fReplyHeaders;
    property HTTPVersion: string read fHTTPVersion;
    property RawRequest: string read fRawRequest;
    property Session: TnxBaseSession read fSession;
    property Params: TStringlist read fParamList;
    property OnReplyHeadersCreated: TNotifyEvent read fOnReplyHeadersCreated write fOnReplyHeadersCreated;
  end;

  TAbstractRequestHandler = class
    procedure DoExecute(aSocket: InxSocketAdapter; ARequest: TnxHTTPRequest); virtual;
  end;

  TnxWebServerAuthenticate = procedure(Sender: TnxBaseWebServer; aRequest: TnxHTTPRequest; const aUserName, aPassword: UnicodeString; var aOk: boolean) of object;

  TnxBaseWebServer = class(TnxLoggableComponent)
  private
    procedure SetBaseDir(const Value: String);
  protected
    fBaseDir: String;
    fRequestClass: TnxHTTPRequestClass;
    fAuthenticationMethod: String;
    fAuthentication: TnxBaseAuthentication;
    fPort: integer;
    fActive: boolean;
    fOnAuthenticate: TnxWebServerAuthenticate;
    fHandlers: TStringList;
    procedure SetAuthenticationMethod(const Value: String);
    procedure DoExecute(aSocket: InxSocketAdapter; ARequest: TnxHTTPRequest); virtual;
    function DoAuthenticate(aRequest: TnxHTTPRequest; aUserName, aPassword: UnicodeString): Boolean; virtual;
    procedure SetPort(const Value: integer); virtual; abstract;
    procedure CreateSocket; virtual; abstract;
    procedure SetActive(const Value: boolean); virtual; abstract;
  published
  public
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;
    procedure AddHandler(aVirtualDir: string; aHandler: TAbstractRequestHandler);
    procedure RemoveHandler(aVirtualDir: string);
    property BaseDir: String read fBaseDir write SetBaseDir;
    property AuthenticationMethod: String read fAuthenticationMethod write SetAuthenticationMethod;
    property RequestClass: TnxHTTPRequestClass read fRequestClass write fRequestClass;
    property Port: integer read fPort write SetPort;
    property Active: boolean read fActive write SetActive;
    property OnAuthenticate: TnxWebServerAuthenticate read fOnAuthenticate write fOnAuthenticate;
    property Authentication: TnxBaseAuthentication read fAuthentication; 
  end;

function nxServerDecode(const aString: string): string;

implementation

uses
  {$IFDEF DCC16OrLater}
  Types,
  {$ENDIF}
  nxllUtils;

var
  _AuthenticationMethods : TStringlist;
  _ScriptProcessors : TStringlist;
  _Sessions: TThreadList;

resourcestring
 rMimeTypes1 =
'.3dm=x-world/x-3dmf' + #13#10 +
'.3dmf=x-world/x-3dmf' + #13#10 +
'.a=application/octet-stream' + #13#10 +
'.aab=application/x-authorware-bin' + #13#10 +
'.aam=application/x-authorware-map' + #13#10 +
'.aas=application/x-authorware-seg' + #13#10 +
'.abc=text/vnd.abc' + #13#10 +
'.acgi=text/html' + #13#10 +
'.afl=video/animaflex' + #13#10 +
'.ai=application/postscript' + #13#10 +
'.aif=audio/aiff' + #13#10 +
'.aifc=audio/aiff' + #13#10 +
'.aiff=audio/aiff' + #13#10 +
'.aim=application/x-aim' + #13#10 +
'.aip=text/x-audiosoft-intra' + #13#10 +
'.ani=application/x-navi-animation' + #13#10 +
'.aos=application/x-nokia-9000-communicator-add-on-software' + #13#10 +
'.aps=application/mime' + #13#10 +
'.arc=application/octet-stream' + #13#10 +
'.arj=application/arj' + #13#10 +
'.art=image/x-jg' + #13#10 +
'.asf=video/x-ms-asf' + #13#10 +
'.asm=text/x-asm' + #13#10 +
'.asp=text/asp' + #13#10 +
'.asx=application/x-mplayer2' + #13#10 +
'.au=audio/basic' + #13#10 +
'.avi=video/msvideo' + #13#10 +
'.bcpio=application/x-bcpio' + #13#10 +
'.bin=application/octet-stream' + #13#10 +
'.bm=image/bmp' + #13#10 +
'.bmp=image/bmp' + #13#10 +
'.boo=application/book-' + #13#10 +
'.book=application/book' + #13#10 +
'.boz=application/x-bzip2' + #13#10 +
'.bsh=application/x-bsh' + #13#10 +
'.bz=application/x-bzip' + #13#10 +
'.bz2=application/x-bzip2' + #13#10 +
'.c=text/plain' + #13#10 +
'.c++=text/plain' + #13#10 +
'.cat=application/vnd.ms-pki.seccat' + #13#10 +
'.cc=text/plain' + #13#10 +
'.ccad=application/clariscad' + #13#10 +
'.cco=application/x-cocoa' + #13#10 +
'.cdf=application/cdf' + #13#10 +
'.cer=application/pkix-cert' + #13#10 +
'.cer=application/x-x509-ca-cert' + #13#10 +
'.cha=application/x-chat' + #13#10 +
'.chat=application/x-chat' + #13#10 +
'.class=application/java' + #13#10 +
'.class=application/java-byte-code' + #13#10 +
'.class=application/x-java-class' + #13#10 +
'.com=application/octet-stream' + #13#10 +
'.com=text/plain' + #13#10 +
'.conf=text/plain' + #13#10 +
'.cpio=application/x-cpio' + #13#10 +
'.cpp=text/x-c' + #13#10 +
'.cpt=application/mac-compactpro' + #13#10 +
'.cpt=application/x-compactpro' + #13#10 +
'.cpt=application/x-cpt' + #13#10 +
'.crl=application/pkcs-crl' + #13#10 +
'.crl=application/pkix-crl' + #13#10 +
'.crt=application/pkix-cert' + #13#10 +
'.crt=application/x-x509-ca-cert' + #13#10 +
'.crt=application/x-x509-user-cert' + #13#10 +
'.csh=application/x-csh' + #13#10 +
'.csh=text/x-script.csh' + #13#10 +
'.css=text/css' + #13#10 +
'.cxx=text/plain' + #13#10 +
'.dcr=application/x-director' + #13#10 +
'.deepv=application/x-deepv' + #13#10 +
'.def=text/plain' + #13#10 +
'.der=application/x-x509-ca-cert' + #13#10 +
'.dif=video/x-dv' + #13#10 +
'.dir=application/x-director' + #13#10 +
'.dl=video/dl' + #13#10 +
'.dl=video/x-dl' + #13#10 +
'.doc=application/msword' + #13#10 +
'.dot=application/msword' + #13#10 +
'.dp=application/commonground' + #13#10 +
'.drw=application/drafting' + #13#10 +
'.dump=application/octet-stream' + #13#10 +
'.dv=video/x-dv' + #13#10 +
'.d[vi=application/x-dvi' + #13#10 +
'.dwf drawing/x-dwf=(old)' + #13#10 +
'.dwf=model/vnd.dwf' + #13#10 +
'.dwg=application/acad' + #13#10 +
'.dwg=image/vnd.dwg' + #13#10 +
'.dwg=image/x-dwg' + #13#10 +
'.dxf=application/dxf' + #13#10 +
'.dxf=image/vnd.dwg' + #13#10 +
'.dxf=image/x-dwg' + #13#10 +
'.dxr=application/x-director' + #13#10 +
'.el=text/x-script.elisp' + #13#10 +
'.elc application/x-bytecode.elisp (compiled=elisp)' + #13#10 +
'.elc=application/x-elc' + #13#10 +
'.env=application/x-envoy' + #13#10 +
'.eps=application/postscript' + #13#10 +
'.es=application/x-esrehber' + #13#10 +
'.etx=text/x-setext' + #13#10 +
'.evy=application/envoy' + #13#10 +
'.evy=application/x-envoy' + #13#10 +
'.exe=application/octet-stream' + #13#10 +
'.f=text/plain' + #13#10 +
'.f=text/x-fortran' + #13#10 +
'.f77=text/x-fortran' + #13#10 +
'.f90=text/plain' + #13#10 +
'.f90=text/x-fortran' + #13#10 +
'.fdf=application/vnd.fdf' + #13#10 +
'.fif=application/fractals' + #13#10 +
'.fif=image/fif' + #13#10 +
'.fli=video/fli' + #13#10 +
'.fli=video/x-fli' + #13#10 +
'.flo=image/florian' + #13#10 +
'.flx=text/vnd.fmi.flexstor' + #13#10 +
'.fmf=video/x-atomic3d-feature' + #13#10 +
'.for=text/plain' + #13#10 +
'.for=text/x-fortran' + #13#10 +
'.fpx=image/vnd.fpx' + #13#10 +
'.fpx=image/vnd.net-fpx' + #13#10 +
'.frl=application/freeloader' + #13#10 +
'.funk=audio/make' + #13#10 +
'.g=text/plain' + #13#10 +
'.g3=image/g3fax' + #13#10 +
'.gif=image/gif' + #13#10 +
'.gl=video/gl' + #13#10 +
'.gl=video/x-gl' + #13#10 +
'.gsd=audio/x-gsm' + #13#10 +
'.gsm=audio/x-gsm' + #13#10 +
'.gsp=application/x-gsp' + #13#10 +
'.gss=application/x-gss' + #13#10 +
'.gtar=application/x-gtar' + #13#10 +
'.gz=application/x-compressed' + #13#10 +
'.gz=application/x-gzip' + #13#10 +
'.gzip=application/x-gzip' + #13#10 +
'.gzip=multipart/x-gzip' + #13#10;

 rMimeTypes2 =
'.h=text/plain' + #13#10 +
'.h=text/x-h' + #13#10 +
'.hdf=application/x-hdf' + #13#10 +
'.help=application/x-helpfile' + #13#10 +
'.hgl=application/vnd.hp-hpgl' + #13#10 +
'.hh=text/plain' + #13#10 +
'.hh=text/x-h' + #13#10 +
'.hlb=text/x-script' + #13#10 +
'.hlp=application/hlp' + #13#10 +
'.hlp=application/x-helpfile' + #13#10 +
'.hlp=application/x-winhelp' + #13#10 +
'.hpg=application/vnd.hp-hpgl' + #13#10 +
'.hpgl=application/vnd.hp-hpgl' + #13#10 +
'.hqx=application/binhex' + #13#10 +
'.hqx=application/binhex4' + #13#10 +
'.hqx=application/mac-binhex' + #13#10 +
'.hqx=application/mac-binhex40' + #13#10 +
'.hqx=application/x-binhex40' + #13#10 +
'.hqx=application/x-mac-binhex40' + #13#10 +
'.hta=application/hta' + #13#10 +
'.htc=text/x-component' + #13#10 +
'.htm=text/html' + #13#10 +
'.html=text/html' + #13#10 +
'.htmls=text/html' + #13#10 +
'.htt=text/webviewhtml' + #13#10 +
'.htx=text/html' + #13#10 +
'.ice=x-conference/x-cooltalk' + #13#10 +
'.ico=image/x-icon' + #13#10 +
'.idc=text/plain' + #13#10 +
'.ief=image/ief' + #13#10 +
'.iefs=image/ief' + #13#10 +
'.iges=application/iges' + #13#10 +
'.iges=model/iges' + #13#10 +
'.igs=application/iges' + #13#10 +
'.igs=model/iges' + #13#10 +
'.ima=application/x-ima' + #13#10 +
'.imap=application/x-httpd-imap' + #13#10 +
'.inf=application/inf' + #13#10 +
'.ins=application/x-internett-signup' + #13#10 +
'.ip=application/x-ip2' + #13#10 +
'.isu=video/x-isvideo' + #13#10 +
'.it=audio/it' + #13#10 +
'.iv=application/x-inventor' + #13#10 +
'.ivr=i-world/i-vrml' + #13#10 +
'.ivy=application/x-livescreen' + #13#10 +
'.jam=audio/x-jam' + #13#10 +
'.jav=text/plain' + #13#10 +
'.jav=text/x-java-source' + #13#10 +
'.java=text/plain' + #13#10 +
'.java=text/x-java-source' + #13#10 +
'.jcm=application/x-java-commerce' + #13#10 +
'.jfif=image/jpeg' + #13#10 +
'.jfif=image/pjpeg' + #13#10 +
'.jfif-tbnl=image/jpeg' + #13#10 +
'.jpe=image/jpeg' + #13#10 +
'.jpe=image/pjpeg' + #13#10 +
'.jpeg=image/jpeg' + #13#10 +
'.jpeg=image/pjpeg' + #13#10 +
'.jpg=image/jpeg' + #13#10 +
'.jpg=image/pjpeg' + #13#10 +
'.jps=image/x-jps' + #13#10 +
'.js=application/x-javascript' + #13#10 +
'.jut=image/jutvision' + #13#10 +
'.kar=audio/midi' + #13#10 +
'.kar=music/x-karaoke' + #13#10 +
'.ksh=application/x-ksh' + #13#10 +
'.ksh=text/x-script.ksh' + #13#10 +
'.la=audio/nspaudio' + #13#10 +
'.la=audio/x-nspaudio' + #13#10 +
'.lam=audio/x-liveaudio' + #13#10 +
'.latex=application/x-latex' + #13#10 +
'.lha=application/lha' + #13#10 +
'.lha=application/octet-stream' + #13#10 +
'.lha=application/x-lha' + #13#10 +
'.lhx=application/octet-stream' + #13#10 +
'.list=text/plain' + #13#10 +
'.lma=audio/nspaudio' + #13#10 +
'.lma=audio/x-nspaudio' + #13#10 +
'.log=text/plain' + #13#10 +
'.lsp=application/x-lisp' + #13#10 +
'.lsp=text/x-script.lisp' + #13#10 +
'.lst=text/plain' + #13#10 +
'.lsx=text/x-la-asf' + #13#10 +
'.ltx=application/x-latex' + #13#10 +
'.lzh=application/octet-stream' + #13#10 +
'.lzh=application/x-lzh' + #13#10 +
'.lzx=application/lzx' + #13#10 +
'.lzx=application/octet-stream' + #13#10 +
'.lzx=application/x-lzx' + #13#10 +
'.m=text/plain' + #13#10 +
'.m=text/x-m' + #13#10 +
'.m1v=video/mpeg' + #13#10 +
'.m2a=audio/mpeg' + #13#10 +
'.m2v=video/mpeg' + #13#10 +
'.m3u=audio/x-mpequrl' + #13#10 +
'.man=application/x-troff-man' + #13#10 +
'.map=application/x-navimap' + #13#10 +
'.mar=text/plain' + #13#10 +
'.mbd=application/mbedlet' + #13#10 +
'.mc$=application/x-magic-cap-package-1.0' + #13#10 +
'.mcd=application/mcad' + #13#10 +
'.mcd=application/x-mathcad' + #13#10 +
'.mcf=image/vasa' + #13#10 +
'.mcf=text/mcf' + #13#10 +
'.mcp=application/netmc' + #13#10 +
'.me=application/x-troff-me' + #13#10 +
'.mht=message/rfc822' + #13#10 +
'.mhtml=message/rfc822' + #13#10 +
'.mid=application/x-midi' + #13#10 +
'.mid=audio/midi' + #13#10 +
'.mid=audio/x-mid' + #13#10 +
'.mid=audio/x-midi' + #13#10 +
'.mid=music/crescendo' + #13#10 +
'.mid=x-music/x-midi' + #13#10 +
'.midi=application/x-midi' + #13#10 +
'.midi=audio/midi' + #13#10 +
'.midi=audio/x-mid' + #13#10 +
'.midi=audio/x-midi' + #13#10 +
'.midi=music/crescendo' + #13#10 +
'.midi=x-music/x-midi' + #13#10 +
'.mif=application/x-frame' + #13#10 +
'.mif=application/x-mif' + #13#10 +
'.mime=message/rfc822' + #13#10 +
'.mime=www/mime' + #13#10 +
'.mjf=audio/x-vnd.audioexplosion.mjuicemediafile' + #13#10 +
'.mjpg=video/x-motion-jpeg' + #13#10 +
'.mm=application/base64' + #13#10 +
'.mm=application/x-meme' + #13#10 +
'.mme=application/base64' + #13#10 +
'.mod=audio/mod' + #13#10 +
'.mod=audio/x-mod' + #13#10 +
'.moov=video/quicktime' + #13#10 +
'.mov=video/quicktime' + #13#10 +
'.movie=video/x-sgi-movie' + #13#10 +
'.mp2=audio/mpeg' + #13#10 +
'.mp2=audio/x-mpeg' + #13#10 +
'.mp2=video/mpeg' + #13#10 +
'.mp2=video/x-mpeg' + #13#10 +
'.mp2=video/x-mpeq2a' + #13#10 +
'.mp3=audio/mpeg3' + #13#10 +
'.mp3=audio/x-mpeg-3' + #13#10 +
'.mp3=video/mpeg' + #13#10 +
'.mp3=video/x-mpeg' + #13#10 +
'.mpa=audio/mpeg' + #13#10 +
'.mpa=video/mpeg' + #13#10 +
'.mpc=application/x-project' + #13#10 +
'.mpe=video/mpeg' + #13#10 +
'.mpeg=video/mpeg' + #13#10 +
'.mpg=audio/mpeg' + #13#10 +
'.mpg=video/mpeg' + #13#10 +
'.mpga=audio/mpeg' + #13#10 +
'.mpp=application/vnd.ms-project' + #13#10 +
'.mpt=application/x-project' + #13#10 +
'.mpv=application/x-project' + #13#10 +
'.mpx=application/x-project' + #13#10 +
'.mrc=application/marc' + #13#10 +
'.ms=application/x-troff-ms' + #13#10 +
'.mv=video/x-sgi-movie' + #13#10 +
'.my=audio/make' + #13#10 +
'.mzz=application/x-vnd.audioexplosion.mzz' + #13#10 +
'.nap=image/naplps' + #13#10 +
'.naplps=image/naplps' + #13#10 +
'.nc=application/x-netcdf' + #13#10 +
'.ncm=application/vnd.nokia.configuration-message' + #13#10 +
'.nif=image/x-niff' + #13#10 +
'.niff=image/x-niff' + #13#10 +
'.nix=application/x-mix-transfer' + #13#10 +
'.nsc=application/x-conference' + #13#10 +
'.nvd=application/x-navidoc' + #13#10 +
'.o=application/octet-stream' + #13#10 +
'.oda=application/oda' + #13#10 +
'.omc=application/x-omc' + #13#10 +
'.omcd=application/x-omcdatamaker' + #13#10 +
'.omcr=application/x-omcregerator' + #13#10;

 rMimeTypes3 =
'.p=text/x-pascal' + #13#10 +
'.p10=application/pkcs10' + #13#10 +
'.p10=application/x-pkcs10' + #13#10 +
'.p12=application/pkcs-12' + #13#10 +
'.p12=application/x-pkcs12' + #13#10 +
'.p7a=application/x-pkcs7-signature' + #13#10 +
'.p7c=application/pkcs7-mime' + #13#10 +
'.p7c=application/x-pkcs7-mime' + #13#10 +
'.p7m=application/pkcs7-mime' + #13#10 +
'.p7m=application/x-pkcs7-mime' + #13#10 +
'.p7r=application/x-pkcs7-certreqresp' + #13#10 +
'.p7s=application/pkcs7-signature' + #13#10 +
'.part=application/pro_eng' + #13#10 +
'.pas=text/pascal' + #13#10 +
'.pbm=image/x-portable-bitmap' + #13#10 +
'.pcl=application/vnd.hp-pcl' + #13#10 +
'.pcl=application/x-pcl' + #13#10 +
'.pct=image/x-pict' + #13#10 +
'.pcx=image/x-pcx' + #13#10 +
'.pdb=chemical/x-pdb' + #13#10 +
'.pdf=application/pdf' + #13#10 +
'.pfunk=audio/make' + #13#10 +
'.pfunk=audio/make.my.funk' + #13#10 +
'.pgm=image/x-portable-graymap' + #13#10 +
'.pgm=image/x-portable-greymap' + #13#10 +
'.pic=image/pict' + #13#10 +
'.pict=image/pict' + #13#10 +
'.pkg=application/x-newton-compatible-pkg' + #13#10 +
'.pko=application/vnd.ms-pki.pko' + #13#10 +
'.pl=text/plain' + #13#10 +
'.pl=text/x-script.perl' + #13#10 +
'.plx=application/x-pixclscript' + #13#10 +
'.pm=image/x-xpixmap' + #13#10 +
'.pm=text/x-script.perl-module' + #13#10 +
'.pm4=application/x-pagemaker' + #13#10 +
'.pm5=application/x-pagemaker' + #13#10 +
'.png=image/png' + #13#10 +
'.pnm=application/x-portable-anymap' + #13#10 +
'.pnm=image/x-portable-anymap' + #13#10 +
'.pot=application/mspowerpoint' + #13#10 +
'.pot=application/vnd.ms-powerpoint' + #13#10 +
'.pov=model/x-pov' + #13#10 +
'.ppa=application/vnd.ms-powerpoint' + #13#10 +
'.ppm=image/x-portable-pixmap' + #13#10 +
'.pps=application/mspowerpoint' + #13#10 +
'.pps=application/vnd.ms-powerpoint' + #13#10 +
'.ppt=application/mspowerpoint' + #13#10 +
'.ppt=application/powerpoint' + #13#10 +
'.ppt=application/vnd.ms-powerpoint' + #13#10 +
'.ppt=application/x-mspowerpoint' + #13#10 +
'.ppz=application/mspowerpoint' + #13#10 +
'.pre=application/x-freelance' + #13#10 +
'.prt=application/pro_eng' + #13#10 +
'.ps=application/postscript' + #13#10 +
'.psd=application/octet-stream' + #13#10 +
'.pvu=paleovu/x-pv' + #13#10 +
'.pwz=application/vnd.ms-powerpoint' + #13#10 +
'.py=text/x-script.phyton' + #13#10 +
'.pyc=applicaiton/x-bytecode.python' + #13#10 +
'.qcp=audio/vnd.qcelp' + #13#10 +
'.qd3=x-world/x-3dmf' + #13#10 +
'.qd3d=x-world/x-3dmf' + #13#10 +
'.qif=image/x-quicktime' + #13#10 +
'.qt=video/quicktime' + #13#10 +
'.qtc=video/x-qtc' + #13#10 +
'.qti=image/x-quicktime' + #13#10 +
'.qtif=image/x-quicktime' + #13#10+
'.ra=audio/x-pn-realaudio' + #13#10 +
'.ra=audio/x-pn-realaudio-plugin' + #13#10 +
'.ra=audio/x-realaudio' + #13#10 +
'.ram=audio/x-pn-realaudio' + #13#10 +
'.ras=application/x-cmu-raster' + #13#10 +
'.ras=image/cmu-raster' + #13#10 +
'.ras=image/x-cmu-raster' + #13#10 +
'.rast=image/cmu-raster' + #13#10 +
'.rexx=text/x-script.rexx' + #13#10 +
'.rf=image/vnd.rn-realflash' + #13#10 +
'.rgb=image/x-rgb' + #13#10 +
'.rm=application/vnd.rn-realmedia' + #13#10 +
'.rm=audio/x-pn-realaudio' + #13#10 +
'.rmi=audio/mid' + #13#10 +
'.rmm=audio/x-pn-realaudio' + #13#10 +
'.rmp=audio/x-pn-realaudio' + #13#10 +
'.rmp=audio/x-pn-realaudio-plugin' + #13#10 +
'.rng=application/ringing-tones' + #13#10 +
'.rng=application/vnd.nokia.ringing-tone' + #13#10 +
'.rnx=application/vnd.rn-realplayer' + #13#10 +
'.roff=application/x-troff' + #13#10 +
'.rp=image/vnd.rn-realpix' + #13#10 +
'.rpm=audio/x-pn-realaudio-plugin' + #13#10 +
'.rt=text/richtext' + #13#10 +
'.rt=text/vnd.rn-realtext' + #13#10 +
'.rtf=application/rtf' + #13#10 +
'.rtf=application/x-rtf' + #13#10 +
'.rtf=text/richtext' + #13#10 +
'.rtx=application/rtf' + #13#10 +
'.rtx=text/richtext' + #13#10 +
'.rv=video/vnd.rn-realvideo' + #13#10 +
'.s=text/x-asm' + #13#10;

 rMimeTypes4 =
'.s3m=audio/s3m' + #13#10 +
'.saveme=application/octet-stream' + #13#10 +
'.sbk=application/x-tbook' + #13#10 +
'.scm=application/x-lotusscreencam' + #13#10 +
'.scm=text/x-script.guile' + #13#10 +
'.scm=text/x-script.scheme' + #13#10 +
'.scm=video/x-scm' + #13#10 +
'.sdml=text/plain' + #13#10 +
'.sdp=application/sdp' + #13#10 +
'.sdp=application/x-sdp' + #13#10 +
'.sdr=application/sounder' + #13#10 +
'.sea=application/sea' + #13#10 +
'.sea=application/x-sea' + #13#10 +
'.set=application/set' + #13#10 +
'.sgm=text/sgml' + #13#10 +
'.sgm=text/x-sgml' + #13#10 +
'.sgml=text/sgml' + #13#10 +
'.sgml=text/x-sgml' + #13#10 +
'.sh=application/x-bsh' + #13#10 +
'.sh=application/x-sh' + #13#10 +
'.sh=application/x-shar' + #13#10 +
'.sh=text/x-script.sh' + #13#10 +
'.shar=application/x-bsh' + #13#10 +
'.shar=application/x-shar' + #13#10 +
'.shtml=text/html' + #13#10 +
'.shtml=text/x-server-parsed-html' + #13#10 +
'.sid=audio/x-psid' + #13#10 +
'.sit=application/x-sit' + #13#10 +
'.sit=application/x-stuffit' + #13#10 +
'.skd=application/x-koan' + #13#10 +
'.skm=application/x-koan' + #13#10 +
'.skp=application/x-koan' + #13#10 +
'.skt=application/x-koan' + #13#10 +
'.sl=application/x-seelogo' + #13#10 +
'.smi=application/smil' + #13#10 +
'.smil=application/smil' + #13#10 +
'.snd=audio/basic' + #13#10 +
'.snd=audio/x-adpcm' + #13#10 +
'.sol=application/solids' + #13#10 +
'.spc=application/x-pkcs7-certificates' + #13#10 +
'.spc=text/x-speech' + #13#10 +
'.spl=application/futuresplash' + #13#10 +
'.spr=application/x-sprite' + #13#10 +
'.sprite=application/x-sprite' + #13#10 +
'.src=application/x-wais-source' + #13#10 +
'.ssi=text/x-server-parsed-html' + #13#10 +
'.ssm=application/streamingmedia' + #13#10 +
'.sst=application/vnd.ms-pki.certstore' + #13#10 +
'.step=application/step' + #13#10 +
'.stl=application/sla' + #13#10 +
'.stl=application/vnd.ms-pki.stl' + #13#10 +
'.stl=application/x-navistyle' + #13#10 +
'.stp=application/step' + #13#10 +
'.sv4cpio=application/x-sv4cpio' + #13#10 +
'.sv4crc=application/x-sv4crc' + #13#10 +
'.svf=image/vnd.dwg' + #13#10 +
'.svf=image/x-dwg' + #13#10 +
'.svg=image/svg+xml' + #13#10 + //..
'.svr=application/x-world' + #13#10 +
'.svr=x-world/x-svr' + #13#10 +
'.swf=application/x-shockwave-flash' + #13#10 +
'.t=application/x-troff' + #13#10 +
'.talk=text/x-speech' + #13#10 +
'.tar=application/x-tar' + #13#10 +
'.tbk=application/toolbook' + #13#10 +
'.tbk=application/x-tbook' + #13#10 +
'.tcl=application/x-tcl' + #13#10 +
'.tcl=text/x-script.tcl' + #13#10 +
'.tcsh=text/x-script.tcsh' + #13#10 +
'.tex=application/x-tex' + #13#10 +
'.texi=application/x-texinfo' + #13#10 +
'.texinfo=application/x-texinfo' + #13#10 +
'.text=application/plain' + #13#10 +
'.text=text/plain' + #13#10 +
'.tgz=application/gnutar' + #13#10 +
'.tgz=application/x-compressed' + #13#10 +
'.tif=image/tiff' + #13#10 +
'.tif=image/x-tiff' + #13#10 +
'.tiff=image/tiff' + #13#10 +
'.tiff=image/x-tiff' + #13#10 +
'.tr=application/x-troff' + #13#10 +
'.tsi=audio/tsp-audio' + #13#10 +
'.tsp=application/dsptype' + #13#10 +
'.tsp=audio/tsplayer' + #13#10 +
'.tsv=text/tab-separated-values' + #13#10 +
'.turbot=image/florian' + #13#10 +
'.txt=text/plain' + #13#10 +
'.uil=text/x-uil' + #13#10 +
'.uni=text/uri-list' + #13#10 +
'.unis=text/uri-list' + #13#10 +
'.unv=application/i-deas' + #13#10 +
'.uri=text/uri-list' + #13#10 +
'.uris=text/uri-list' + #13#10 +
'.ustar=application/x-ustar' + #13#10 +
'.ustar=multipart/x-ustar' + #13#10 +
'.uu=application/octet-stream' + #13#10 +
'.uu=text/x-uuencode' + #13#10 +
'.uue=text/x-uuencode' + #13#10;

 rMimeTypes5 ='.vcd=application/x-cdlink' + #13#10 +
'.vcs=text/x-vcalendar' + #13#10 +
'.vda=application/vda' + #13#10 +
'.vdo=video/vdo' + #13#10 +
'.vew=application/groupwise' + #13#10 +
'.viv=video/vivo' + #13#10 +
'.viv=video/vnd.vivo' + #13#10 +
'.vivo=video/vivo' + #13#10 +
'.vivo=video/vnd.vivo' + #13#10 +
'.vmd=application/vocaltec-media-desc' + #13#10 +
'.vmf=application/vocaltec-media-file' + #13#10 +
'.voc=audio/voc' + #13#10 +
'.voc=audio/x-voc' + #13#10 +
'.vos=video/vosaic' + #13#10 +
'.vox=audio/voxware' + #13#10 +
'.vqe=audio/x-twinvq-plugin' + #13#10 +
'.vqf=audio/x-twinvq' + #13#10 +
'.vql=audio/x-twinvq-plugin' + #13#10 +
'.vrml=application/x-vrml' + #13#10 +
'.vrml=model/vrml' + #13#10 +
'.vrml=x-world/x-vrml' + #13#10 +
'.vrt=x-world/x-vrt' + #13#10 +
'.vsd=application/x-visio' + #13#10 +
'.vst=application/x-visio' + #13#10 +
'.vsw=application/x-visio' + #13#10 +
'.w60=application/wordperfect6.0' + #13#10 +
'.w61=application/wordperfect6.1' + #13#10 +
'.w6w=application/msword' + #13#10 +
'.wav=audio/wav' + #13#10 +
'.wav=audio/x-wav' + #13#10 +
'.wb1=application/x-qpro' + #13#10 +
'.wbmp=image/vnd.wap.wbmp' + #13#10 +
'.web=application/vnd.xara' + #13#10 +
'.wiz=application/msword' + #13#10 +
'.wk1=application/x-123' + #13#10 +
'.wmf=windows/metafile' + #13#10 +
'.wml=text/vnd.wap.wml' + #13#10 +
'.wmlc=application/vnd.wap.wmlc' + #13#10 +
'.wmls=text/vnd.wap.wmlscript' + #13#10 +
'.wmlsc=application/vnd.wap.wmlscriptc' + #13#10 +
'.word=application/msword' + #13#10 +
'.wp=application/wordperfect' + #13#10 +
'.wp5=application/wordperfect' + #13#10 +
'.wp5=application/wordperfect6.0' + #13#10 +
'.wp6=application/wordperfect' + #13#10 +
'.wpd=application/wordperfect' + #13#10 +
'.wpd=application/x-wpwin' + #13#10 +
'.wq1=application/x-lotus' + #13#10 +
'.wri=application/mswrite' + #13#10 +
'.wri=application/x-wri' + #13#10 +
'.wrl=application/x-world' + #13#10 +
'.wrl=model/vrml' + #13#10 +
'.wrl=x-world/x-vrml' + #13#10 +
'.wrz=model/vrml' + #13#10 +
'.wrz=x-world/x-vrml' + #13#10 +
'.wsc=text/scriplet' + #13#10 +
'.wsrc=application/x-wais-source' + #13#10 +
'.wtk=application/x-wintalk' + #13#10 +
'.xbm=image/x-xbitmap' + #13#10 +
'.xbm=image/x-xbm' + #13#10 +
'.xbm=image/xbm' + #13#10 +
'.xdr=video/x-amt-demorun' + #13#10 +
'.xgz=xgl/drawing' + #13#10 +
'.xif=image/vnd.xiff' + #13#10 +
'.xl=application/excel' + #13#10 +
'.xla=application/excel' + #13#10 +
'.xla=application/x-excel' + #13#10 +
'.xla=application/x-msexcel' + #13#10 +
'.xlb=application/excel' + #13#10 +
'.xlb=application/vnd.ms-excel' + #13#10 +
'.xlb=application/x-excel' + #13#10 +
'.xlc=application/excel' + #13#10 +
'.xlc=application/vnd.ms-excel' + #13#10 +
'.xlc=application/x-excel' + #13#10 +
'.xld=application/excel' + #13#10 +
'.xld=application/x-excel' + #13#10 +
'.xlk=application/excel' + #13#10 +
'.xlk=application/x-excel' + #13#10 +
'.xll=application/excel' + #13#10 +
'.xll=application/vnd.ms-excel' + #13#10 +
'.xll=application/x-excel' + #13#10 +
'.xlm=application/excel' + #13#10 +
'.xlm=application/vnd.ms-excel' + #13#10 +
'.xlm=application/x-excel' + #13#10 +
'.xls=application/excel' + #13#10 +
'.xls=application/vnd.ms-excel' + #13#10 +
'.xls=application/x-excel' + #13#10 +
'.xls=application/x-msexcel' + #13#10 +
'.xlt=application/excel' + #13#10 +
'.xlt=application/x-excel' + #13#10 +
'.xlv=application/excel' + #13#10 +
'.xlv=application/x-excel' + #13#10 +
'.xlw=application/excel' + #13#10 +
'.xlw=application/vnd.ms-excel' + #13#10 +
'.xlw=application/x-excel' + #13#10 +
'.xlw=application/x-msexcel' + #13#10 +
'.xm=audio/xm' + #13#10 +
'.xml=application/xml' + #13#10 +
'.xml=text/xml' + #13#10 +
'.xmz=xgl/movie' + #13#10 +
'.xpix=application/x-vnd.ls-xpix' + #13#10 +
'.xpm=image/x-xpixmap' + #13#10 +
'.xpm=image/xpm' + #13#10 +
'.x-png=image/png' + #13#10 +
'.x-svg=image/svg+xml' + #13#10 +  //..
'.xsr=video/x-amt-showrun' + #13#10 +
'.xwd=image/x-xwd' + #13#10 +
'.xwd=image/x-xwindowdump' + #13#10 +
'.xyz=chemical/x-pdb' + #13#10 +
'.z=application/x-compressed' + #13#10 +
'.zip=application/x-compressed' + #13#10 +
'.zoo=application/octet-stream' + #13#10 +
'.zsh=text/x-script.zsh';

var
  _MimeTypes: TStringList;

function nxServerDecode(const aString: string): string;
var
   sAnsi : AnsiString;
   sUtf8 : UTF8String; // utf8-bytes string

   i, len: Integer;
   ESC: AnsiString;
   CharCode: integer;
   c: AnsiChar;
begin
   sAnsi := AnsiString(aString);
   SetLength(sUtf8, Length(sAnsi));

   // Convert URLEncoded str to utf8 str, it must
   // use utf8 hex escaping for non us-ascii chars
   //    +      = space
   //    %2A    = *
   //    %C3%84 = â (A with diaeresis)
   i := 1;
   len := 1;
   while (i <= Length(sAnsi)) do begin
     assert(len<=Length(sAnsi));
      if (sAnsi[i] <> '%') then begin
         if (sAnsi[i] = '+') then begin
            c := ' ';
         end else begin
            c := sAnsi[i];
         end;
         sUtf8[len] := c;
         Inc(len);
      end else begin
         Inc(i); // skip the % char
         ESC := Copy(sAnsi, i, 2); // Copy the escape code
         Inc(i, 1); // skip ESC, another +1 at end of loop
         try
            CharCode := StrToInt('$' + string(ESC));
            //if (CharCode > 0) and (CharCode < 256) then begin
               c := AnsiChar(CharCode);
               sUtf8[len] := c;
               Inc(len);
            //end;
         except end;
      end;
      Inc(i);
   end;
   Dec(len); // -1 to fix length (num of characters)
   SetLength(sUtf8, len);

   {$IFDEF DCC12OrLater}
   Result := UTF8ToString(sUtf8);
   {$ELSE}
   Result := UTF8Decode(sUtf8);
   {$ENDIF}
end;

type
  TnxTempFileStream = class(TFileStream)
  protected
    _fFileName: String;
  public
    constructor Create(aFileName: String; Mode: word); 
    destructor Destroy; override;
  end;

{ TnxBaseWebServer }

procedure TnxBaseWebServer.AddHandler(aVirtualDir: string;
  aHandler: TAbstractRequestHandler);
begin
  fHandlers.AddObject(aVirtualDir, aHandler);
end;

constructor TnxBaseWebServer.Create;
begin
  inherited Create(nil);
  fAuthenticationMethod := 'NONE';
  fAuthentication:=nil;
  fRequestClass:=TnxHTTPRequest;
  fBaseDir:=extractfilepath(paramstr(0))+'DocRoot\';
  fHandlers:=TStringList.Create;

  CreateSocket;
  Port:=10088;
end;

destructor TnxBaseWebServer.Destroy;
begin
  FreeAndNil(fAuthentication);
  fHandlers.Destroy;
  inherited;
end;

function TnxBaseWebServer.DoAuthenticate(aRequest: TnxHTTPRequest; aUserName, aPassword: UnicodeString): Boolean;
begin
  result:=false;
  if Assigned(fOnAuthenticate) then
    fOnAuthenticate(self, aRequest, aUserName, aPassword, result);
end;

procedure TnxBaseWebServer.DoExecute(aSocket: InxSocketAdapter;
  ARequest: TnxHTTPRequest);
var
  handlername: string;
  req: string;
begin
  ARequest.ParseHeaders(aSocket, fAuthentication);
  req:=Copy(ARequest.RequestDocument, 2, Length(ARequest.RequestDocument));
  if Pos('/', req)>0 then
  begin
    handlername:=Copy(req, 1, Pos('/', req)-1);
    if fHandlers.IndexOf(handlername)>-1 then
    begin
      TAbstractRequestHandler(fHandlers.Objects[fHandlers.IndexOf(handlername)]).DoExecute(aSocket, ARequest);
      exit;
    end;
  end;
  aRequest.ProcessRequest(aSocket);
end;

procedure TnxBaseWebServer.RemoveHandler(aVirtualDir: string);
begin
  if fHandlers.IndexOf(aVirtualDir)>-1 then
    fHandlers.Delete(fHandlers.IndexOf(aVirtualDir));
end;

procedure TnxBaseWebServer.SetAuthenticationMethod(const Value: String);
var
  aClass: TnxBaseAuthenticationClass;
begin
  aClass:=TnxBaseAuthentication.FindAuthentication(Value);
  if aClass<>nil then
  begin
    fAuthentication:=aClass.Create('NexusDB Server');
    fAuthenticationMethod := Value;
  end
  else
  begin
    FreeAndNil(fAuthentication);
    fAuthenticationMethod := 'NONE';
    if value<>'NONE' then
      raise Exception.Create('Unknown authentication method "'+value+'"');
  end;
end;

procedure TnxBaseWebServer.SetBaseDir(const Value: String);
begin
  fBaseDir := IncludeTrailingPathDelimiter(Value);
end;

{ TnxHTTPRequest }

procedure TnxHTTPRequest.BeforeProcessScript;
begin
end;

constructor TnxHTTPRequest.Create(aServer: TnxBaseWebServer; aRawRequest: String; aBaseDir: string);
begin
  inherited Create(nil);
  fIsAuthorized:=false;
  fSessionClass:=TnxBaseSession;
  fSession:=nil;
  fParamList:=TStringlist.Create;
  fWebServer:=aServer;
  fHeaderInfo:=TStringlist.Create;
  fRawHeaderInfo:=TStringlist.Create;
  fReplyHeaders:=TStringlist.Create;
  fCookies:=TStringlist.Create;
  fRawRequest:=aRawRequest;
  fRawHeaderInfo.Text:=fRawRequest;
  fBaseDir:=aBaseDir;
  fAuthentication:=aServer.Authentication;
  EventLog:=fWebServer.EventLog;
end;

procedure TnxHTTPRequest.CreateReplyHeaders;
var
  cookiename: string;
begin
  fReplyHeaders.Clear;
  fReplyHeaders.Add(fHTTPVersion+' '+inttostr(fErrorCode)+' '+fReplyMessage);
  fReplyHeaders.Add('Server: NexusDB WebServer /1.0');
  fReplyHeaders.Add('Accept-ranges: none');
  cookiename:='NXWebSession'+inttostr(Int64(fWebServer))+'='+inttostr(Int64(fSession));
  fReplyHeaders.Add('Set-Cookie:'+cookiename+'; path=/');
end;

procedure TnxHTTPRequest.CreateSession;
begin
  fSession:=fSessionClass.Create(fWebServer);
end;

destructor TnxHTTPRequest.Destroy;

  procedure ClearList(aStringlist: TStringlist);
  var
    i: integer;
  begin
    for I := 0 to aStringlist.Count - 1 do
      if aStringlist.Objects[i]<>nil then
        aStringlist.Objects[i].free;
  end;

begin
  ClearList(fHeaderInfo);
  fHeaderInfo.free;
  ClearList(fRawHeaderInfo);
  fRawHeaderInfo.free;
  ClearList(fReplyHeaders);
  fReplyHeaders.free;
  ClearList(fCookies);
  fCookies.free;
  ClearList(fParamList);
  fParamList.free;
//  FreeAndNil(fSession);
  inherited;
end;

function TnxHTTPRequest.GetVar(const Name: String): String;
begin
  result:=fSession.SessionVarList.Values[Name];
end;

procedure TnxHTTPRequest.ProcessScriptFile(aClass: TnxWebScriptProcessorClass;
  var resultfile: string);
var
  processor: TnxWebScriptProcessor;
  SearchRec: TSearchRec;
  ffresult: Integer;


  function GetTempDir: string;
  var
    Buffer: array[0..MAX_PATH] of Char;
  begin
    GetTempPath(Length(Buffer) - 1, Buffer);
    Result := StrPas(Buffer);
  end;

  function MakeTempFilename(const APath: String = ''): string;
  Begin
    SetLength(Result, MAX_PATH + 1);
    if GetTempFileName(PChar(APath), 'tmpnx', 0, PChar(Result))=0 then
      if GetTempFileName(PChar(GetTempDir), 'tmpnx', 0, PChar(Result))=0 then
        raise Exception.Create('Spool directory does not exist');
    Result := PChar(Result);
  End;

begin
  processor := aClass.Create(self);
  try
    resultFile := MakeTempFileName('Spool');
    try
      processor.BaseDir:=fBaseDir;
      BeforeProcessScript(Processor);
      fErrorCode := 200;
      processor.ProcessFile(fBaseDir + fRequestDocument, fHeaderInfo.Values['REQUEST_PARAMS'], resultFile, self);
      ffResult := FindFirst(resultFile, faAnyFile, SearchRec);
      try
        if ffresult <> 0 then
          fErrorCode := 404
        else if ((fErrorCode=200) or (fErrorCode=901)) then
        begin
          fContentLength := SearchRec.Size;
        end;
      finally
        FindClose(SearchRec);
      end;
    except
      on e: Exception do
      begin
        fErrorCode := 500;
        fErrorMessage := StringReplace(e.Message, ''#13'', '<BR>', [rfReplaceAll]);
      end;
    end;
  finally
    processor.Free;
  end;
end;

function TnxHTTPRequest.Request(const what: String): Variant;
var
  aString:Variant;
begin
  if fparamlist=nil then
  begin
    case Vartype(result) of
      vtWideString: result:='';
      vtInteger: result:=0;
    else
      result:=NULL;
    end;
    exit;
  end;
  aString:=fparamlist.values[what];
  //result := URIEncode(astring);
  result := astring;
end;

procedure TnxHTTPRequest.SetError(code: integer; const what: String);
begin
  ErrorCode:=code;
end;

procedure TnxHTTPRequest.SetParams(aString: string);
var
  thepos: integer;
begin
  fParams:=aString;
  thepos:=pos('?',fParams);
  if thepos<1 then
    exit;

  fparams:=copy(aString,thepos+1, length(aString));
  {$IFNDEF DCC11OrLater}
  fParams:=StringReplace(fParams,'&',#13,[rfReplaceAll]);
  fParamList.Text:=fParams;
  {$ELSE}
  fParamList.Delimiter := '&';
  fParamList.StrictDelimiter := true;
  fParamList.DelimitedText := fParams;
  {$ENDIF}
end;

procedure TnxHTTPRequest.SetUser(const Value: IUnknown);
begin
  if value<>nil then
    fUser := Value;
end;

procedure TnxHTTPRequest.SetVar(const Name, Value: String);
begin
  fSession.SessionVarList.Values[Name]:=value;
end;

function TnxHTTPRequest.URIEncode(const S: string): string;
const
  URL_UNRESERVED_CHARS = ['A' .. 'Z', 'a' .. 'z', '0' .. '9', '-', '_', '.', '~'];
var
  c : Char;
  i : Integer;
begin
  result := '';
  for i := 1 to Length(S) do begin
    c := S[i];
    if c in URL_UNRESERVED_CHARS then
      result := result + WideChar(c)
    else
      result := result + '%' + IntToHex(Ord(c), 2);
  end;
end;

procedure TnxHTTPRequest.ParseHeaders;
var
  i: int64;
  apos: integer;
  start: integer;
  name: string;
  value: string;
  aString: string;
  usr, pwd: string;
  requestlen: integer;
  cookiename: string;
begin
  i:=1;
  start:=i;
  if pos(#13#10#13#10, fRawRequest)>0 then
    requestlen:=pos(#13#10#13#10, fRawRequest)
  else
    requestlen:=length(fRawRequest);
  while i<requestlen do
  begin
    while (i<length(fRawRequest)) and (not (Ord(fRawRequest[i]) in [Ord(' '),Ord(#13),Ord(#10)])) do
      inc(i);
    name:=copy(fRawRequest, start, i-start);
    if name[length(name)]=':' then
      name:=copy(name,1,length(name)-1);
    start:=i+1;
    inc(i);
    while (i<length(fRawRequest)) and (not (Ord(fRawRequest[i]) in [Ord(#13),Ord(#10)])) do
      inc(i);
    value:=copy(fRawRequest, start, i-start);
    if (name='GET') or (name='POST') then
    begin
      aString:=value;
      value:=trim(copy(value, 1, pos(' HTTP', value)-1));
      aString:=copy(aString, pos('HTTP', aString), length(astring));
      fHeaderInfo.Values['HTTP_VERSION']:=aString;
      fHttpVersion:=aString;

      SetParams(value);
      if pos('?', value)>0 then
      begin
        fHeaderInfo.Values['REQUEST_PARAMS']:=nxServerDecode(copy(value, pos('?', value), length(value)));
        value:=copy(value, 1, pos('?', value)-1);
      end;


      if name='GET' then
        fHeaderInfo.Values['HTTP_METHOD']:='GET';
      if name='POST' then
        fHeaderInfo.Values['HTTP_METHOD']:='POST';
      name:='REQUEST_DOCUMENT';
      if trim(value)='/' then
      begin
        if FileExists(fBaseDir+'\index.html') then
          value:='/index.html'
        else
        if FileExists(fBaseDir+'\index.nxscript') then
          value:='/index.nxscript'
      end;

      fRequestDocument:=value;
    end;
    if aAuth<>nil then
      if uppercase(name)='AUTHORIZATION' then
      begin
        aString:=trim(value);
        apos:=pos(' ', uppercase(aString));
        if aAuth<>nil then
        begin
          aString:=trim(copy(aString, apos+1, length(astring)));
          aString:=aAuth.Decode(aString);
          fHeaderInfo.Values[name]:=aString;
          if pos(':',aString)>0 then
          begin
            usr:=trim(copy(aString, 1, pos(':',aString)-1));
            pwd:=trim(copy(aString, pos(':',aString)+1, length(astring)));
          end;
          fIsAuthorized:=fWebServer.DoAuthenticate(self, usr, pwd);
        end
        else
          raise Exception.Create('authentication type not supported');
      end;
    if uppercase(name)='COOKIE' then
      fCookies.Text:=StringReplace(StringReplace(value, ' ', '', [rfReplaceAll]), ';', #13, [rfReplaceAll])
    else
      fHeaderInfo.Values[name]:=value;
    while (i<length(fRawRequest)) and (Ord(fRawRequest[i]) in [Ord(' '),Ord(#13),Ord(#10)]) do
      inc(i);
    start:=i;
  end;

  if (fHeaderInfo.Values['HTTP_METHOD']='POST') and (fHeaderInfo.Values['Content-length']<>'') then
  begin
    SetParams('?'+nxServerDecode(copy(fRawRequest, requestlen+4, length(fRawRequest))));
    fHeaderInfo.Values['REQUEST_PARAMS']:=nxServerDecode(copy(fRawRequest, requestlen+4, length(fRawRequest)));
  end;

  if (fHeaderInfo.Values['HTTP_METHOD']='') then
    raise Exception.Create('GET or POST not found in header. If GET was used, replace with POST.');

  cookiename:='NXWebSession'+inttostr(Int64(fWebServer));
  i:=strtoint64def(fCookies.Values[cookiename], 0);

  fSession:=nil;
  if i>0 then
  begin
    with _Sessions.LockList do
    try
      i:=IndexOf(pointer(i));
      if i>-1 then
        fSession:=TnxBaseSession(Items[i]);
    finally
      _Sessions.UnlockList;
    end;
  end;

  if fSession=nil then
    CreateSession;
  fSession.Touch;
end;

procedure TnxHTTPRequest.ProcessRequest(aSocket: InxSocketAdapter);
var
  Stream: TFileStream;
  SearchRec:TSearchRec;
  ffresult: integer;
  resultfile: string;
  aClass: TnxWebScriptProcessorClass;
  cType: String;
  Auth: TnxBaseAuthentication;
  EnforceAuthentication: boolean;
begin
  resultFile:='';
  Auth:=fAuthentication;
  if Auth = nil then
    Auth:=TnxBaseAuthentication.FindAuthentication('BASIC').Create('NexusDB Server');

   try
    fReplyMessage:=' Reply from server';
    try
      ParseHeaders(aSocket, Auth);


      ffResult:=FindFirst(fBaseDir+fRequestDocument, faAnyFile, SearchRec);
      try
        if ffresult<>0 then
          fErrorCode:=404
        else
        begin
          fErrorCode:=200;
          fContentLength:=SearchRec.Size;
        end;
      finally
        FindClose(SearchRec);
      end;

      if fWebServer.AuthenticationMethod<>'NONE' then
        if not fIsAuthorized then
        begin
          fErrorCode:=401;
          fReplyMessage:='UNAUTHORIZED';
        end;

      if fErrorCode=200 then
      begin
        aClass:=TnxWebScriptProcessor.FindProcessor(ExtractFileExt(fBaseDir+fRequestDocument));
        if aClass<>nil then
          ProcessScriptFile(aClass, resultfile);
      end;
    except
      on e:Exception do
      begin
        fErrorCode:=500;
        fErrorMessage:=e.Message;
      end;
    end;

    EnforceAuthentication:=false;
    if (fErrorCode=901) then
    begin
      if fIsAuthorized then
        fErrorCode:=200
      else
      begin
        EnforceAuthentication:=true;
        fErrorCode:=401;
      end;
    end;

    CreateReplyHeaders;
    if assigned(fOnReplyHeadersCreated) then
      fOnReplyHeadersCreated(Self);

    lcLog(format('HTTPRequest - Result: %d; Url: %s; Host: %s', [fErrorCode, fRequestDocument, fHeaderInfo.Values['Host']]));

    case fErrorCode of
      200: begin // normal result
             try
               if resultfile<>'' then //asp result; needs to be tempstream
               begin
                 Stream:= TnxTempFileStream.Create(resultfile,fmOpenRead or fmShareDenyWrite);
                 cType:='text/html';
               end
               else // standard file
               begin
                 Stream:= TFileStream.Create(fBaseDir+fRequestDocument,fmOpenRead or fmShareDenyWrite);
                 cType:=_MimeTypes.Values[ExtractFileExt(fRequestDocument)];
               end;
               if cType='' then
                 cType:='application/octet-stream';
               fReplyHeaders.Add('Content-type: '+ctype);

               fReplyHeaders.Add('Content-length: '+inttostr(fContentLength));

               fReplyHeaders.Add('');
               aSocket.SendText(AnsiString(fReplyHeaders.Text));
               aSocket.SendStream(Stream); // stream is freed by the socket!!
             finally
  //             FreeAndNil(Stream);
             end;
           end;
      404: begin // file not found
             fReplyHeaders.Add('Content-length: '+inttostr(length(Format(message_DOCNOTFOUND, [fBaseDir+fRequestDocument]))));
             fReplyHeaders.add('');
             aSocket.SendText(AnsiString(fReplyHeaders.Text+Format(message_DOCNOTFOUND, [fBaseDir+fRequestDocument])));
           end;
      401: begin // file not found
             if (Auth<>nil) or (EnforceAuthentication) then
               fReplyHeaders.Add(Auth.GetAuthenticationReqest);
             fErrorCode:=401;
             fReplyHeaders.Add('Content-length: '+inttostr(length(message_DOCNOTFOUND)));
             fReplyHeaders.add('');
             aSocket.SendText(AnsiString(fReplyHeaders.Text+message_DOCNOTFOUND));
           end;
      else begin  // error message
             fReplyHeaders.Add('Content-length: '+inttostr(length(fErrorMessage)));
             fReplyHeaders.add('');
             aSocket.SendText(AnsiString(fReplyHeaders.Text+fErrorMessage));
           end;
    end;
   finally
     if fAuthentication<>Auth then
       Auth.Free;
   end;
end;

{ TnxTempFileStream }

constructor TnxTempFileStream.Create(aFileName: String; Mode: word);
begin
  inherited Create(aFileName, Mode);
  _fFileName:=aFileName;
end;

destructor TnxTempFileStream.Destroy;
begin
  nxCloseHandleAndInvalidate(THandle(FHandle));
  DeleteFile(_fFileName);
  inherited;
end;

{ TnxWebScriptProcessor }

constructor TnxWebScriptProcessor.Create(aRequest:TnxHTTPRequest);
begin
  fOnBeforeProcess:=nil;
  fRequest:=aRequest;
  fEqualString := ' = ';
  fSCript:=TStringlist.Create;
  fCustomObjects:=TStringlist.Create;
end;

function TnxWebScriptProcessor.ProcessFile(aFilename, Params,
  ResultFileName: String; aRequest: TnxHTTPRequest): integer;
var
  thepos: integer;
  aString: String;
  aLen: Integer;
begin
  result:=0;
  fResultFileName:=ResultFileName;
  params:=nxserverdecode(Params);
  aFilename:=nxServerdecode(aFilename);
  fParams:=Params;
  fFileName:=aFileName;
  fScript.LoadFromFile(fFilename);

  DoHandleIncludes;
  
  DoPrepare(aRequest);

  if assigned(fOnBeforeProcess) then
    fOnBeforeProcess(self, fScript.text);

  DoProcess(aRequest);

  fScript.LoadFromFile(resultfileName);
  aLen:=length('%%REDIRECT%%');
  if (fScript.Count>0) and (uppercase(copy(fScript[0],1,alen))='%%REDIRECT%%') then
  begin
    aString:=copy(fScript[0], alen+1, length(fScript[0]));
    thepos:=pos('?', astring);
    if thepos>0 then
    begin
      afileName:=copy(aString,1,thepos-1);
      Params:=copy(aString,thepos, length(astring));
    end
    else
      afileName:=astring;
    ProcessFile(aFilename,params, resultFileName, aRequest);
  end;
end;

class procedure TnxWebScriptProcessor.Register;
begin
  if not Assigned(_ScriptProcessors) then begin
    _ScriptProcessors := TStringList.Create;
    _ScriptProcessors.Sorted := True;
    _ScriptProcessors.Duplicates := dupError;
  end;
  try
    _ScriptProcessors.AddObject(anExtension, TObject(Self));
  except
    raise Exception.Create(Format('The extension "%s" is already registered', [anExtension]));
  end;
end;

procedure TnxWebScriptProcessor.SetBaseDir(const Value: String);
begin
  fBaseDir := IncludeTrailingPathDelimiter(Value);
end;

destructor TnxWebScriptProcessor.Destroy;
begin
  fCustomObjects.Free;
  fScript.Free;
  inherited;
end;

function PosStartingFrom(const SubStr, Value: String; From: integer): integer;
var
  ls,lv: integer;
begin
  Result := 0;
  ls := Length(SubStr);
  lv := Length(Value);
  if (ls = 0) or (lv = 0) then
    Exit;
  if From < 1 then
    From := 1;
  while (ls + from - 1) <= (lv) do
  begin
    if SubStr = copy(Value, from, ls) then
    begin
      result := from;
      break;
    end
    else
      inc(from);
  end;
end;

procedure TnxWebScriptProcessor.DoHandleIncludes;
var
  endpos: Integer;
  startpos: Integer;
  apos: Integer;
  aString: String;
  atext:string;
  tempStringlist: TStringlist;
  includes: boolean;
begin
  includes:=false;

  // handle includes
  startpos:=pos('<!--#INCLUDE',uppercase(fScript.text));
  if StartPos>0 then
  begin
    atext:=fScript.text;
    includes:=true;
  end;
  while startpos>0 do
  begin
    endpos:=posstartingfrom('-->', aText, startpos);
    if endpos>0 then
      endpos:=endpos+length('-->')+1
    else
      endpos:=length(astring);
    aString:=copy(atext,Startpos, endpos-startpos-1);
    delete(atext, Startpos, endpos-startpos-1);

    apos:=pos('FILE="', uppercase(aString));
    aString:=copy(aString,apos+length('FILE="'),length(aString));
    apos:=pos('"', aString);
    aString:=copy(aString,1,apos-1);
    aString:=StringReplace(aString,'/','\',[rfReplaceAll]);
    if (aString<>'') and (extractfilepath(aString)='') then
      aString:=BaseDir+astring;
    if (aString<>'') and (aString[1]='.') then
      aString:=BaseDir+copy(aString,3,length(astring));
    tempStringlist:=TStringList.Create;
    try
      tempStringlist.LoadFromFile(aString);
      Insert(#13+tempStringlist.Text+#13, atext, StartPos);
    finally
      tempStringlist.free;
    end;
    startpos:=pos('<!--#INCLUDE', uppercase(atext));
  end;
  if includes then
    fScript.text:=atext;
end;

class function TnxWebScriptProcessor.FindProcessor(const anExtension : string): TnxWebScriptProcessorClass;
var
  i    : Integer;
begin
  Result := nil;

  if Assigned(_ScriptProcessors) then
    with _ScriptProcessors do
      if Find(anExtension, i) then
        Result := TnxWebScriptProcessorClass(Objects[i]);
end;

{ TnxBaseSession }

constructor TnxBaseSession.Create(aWebServer: TnxBaseWebServer);
begin
  fWebServer:=aWebServer;
  fSessionVarList:=TStringlist.Create;
  with _Sessions.LockList do
  try
    Add(self);
  finally
    _Sessions.UnlockList;
  end;
end;

destructor TnxBaseSession.Destroy;
begin
  with _Sessions.LockList do
  try
    Remove(self);
  finally
    _Sessions.UnlockList;
  end;
  fSessionVarList.free;
  inherited;
end;

procedure TnxBaseSession.Touch;
begin
  fLastTouch:=now;
end;

{ TnxBaseAuthentication }

constructor TnxBaseAuthentication.Create(aRealm: string);
begin
  fRealm:=aRealm;
end;

class function TnxBaseAuthentication.FindAuthentication(
  const aDescriptor: string): TnxBaseAuthenticationClass;
var
  i    : Integer;
begin
  Result := nil;

  if Assigned(_AuthenticationMethods) then
    with _AuthenticationMethods do
      if Find(aDescriptor, i) then
        Result := TnxBaseAuthenticationClass(Objects[i]);
end;

class procedure TnxBaseAuthentication.Register(aDescriptor: String);
begin
  if not Assigned(_AuthenticationMethods) then begin
    _AuthenticationMethods := TStringList.Create;
    _AuthenticationMethods.Sorted := True;
    _AuthenticationMethods.Duplicates := dupError;
  end;
  try
    _AuthenticationMethods.AddObject(aDescriptor, TObject(Self));
  except
    raise Exception.Create(Format('The descriptor "%s" is already registered', [aDescriptor]));
  end;
end;

{ TAbstractRequestHandler }

procedure TAbstractRequestHandler.DoExecute(aSocket: InxSocketAdapter;
  ARequest: TnxHTTPRequest);
begin
  Assert(false);
end;

initialization
  _Sessions:=TThreadList.Create;
  _MimeTypes:=TStringList.Create;
  _MimeTypes.Text:=rMimeTypes1+rMimeTypes2+rMimeTypes3+rMimeTypes4+rMimeTypes5;
finalization
  FreeAndNil(_AuthenticationMethods);
  FreeAndNil(_ScriptProcessors);
  with _Sessions.LockList do
  try
    while count>0 do
    begin
      TObject(Items[0]).Free;
//      Delete(0); not necessary as the destroy method removes it from the list;
    end;
  finally
    _Sessions.UnlockList;
  end;
  _Sessions.Free;
  _MimeTypes.Free;
end.

