/// <summary>
///   This unit contains wrapper classes to the VirtualUI Settings COM API,
///   to manage and customize VirtualUI configuration from an application.
/// </summary>
unit VirtualUI_Settings;

{$IFDEF FPC}
  {$mode Delphi}
  {$H+}
{$ELSE}
  {$IFDEF VER90}{$DEFINE NOTSUPPORTED}{$ENDIF}
  {$IFDEF VER100}{$DEFINE NOTSUPPORTED}{$ENDIF}
  {$IFDEF VER110}{$DEFINE NOTSUPPORTED}{$ENDIF}
  {$IFDEF VER120}{$DEFINE NOTSUPPORTED}{$ENDIF}
  {$IFDEF NOTSUPPORTED}
  STOP! // This compiler version is not supported through this library
  {$ENDIF}
  {$IFDEF VER130}
    {$DEFINE DELPHI5}
  {$ELSE}
    {$IF CompilerVersion >= 14}
      {$DEFINE DELPHI6_PLUS}
    {$IFEND}
    {$IF CompilerVersion >= 20}
      {$DEFINE DELPHI2009_PLUS}
    {$IFEND}
    {$IF CompilerVersion >= 22}
      {$DEFINE DELPHIXE_PLUS}
    {$IFEND}
    {$IF CompilerVersion >= 23}
      {$DEFINE DELPHIXE2_PLUS}
    {$IFEND}
  {$ENDIF}
{$ENDIF}

interface
uses
  Windows, SysUtils, Registry, ActiveX, ShellAPI, Classes,
  {$IFDEF FMX}
    {$IF CompilerVersion >= 26}
    FMX.Graphics,
    {$ELSE}
    FMX.Types,
    {$IFEND}
  {$ELSE}
    {$IFDEF DELPHI6_PLUS}Variants,{$ENDIF}
    {$IFNDEF FPC}
    StdVCL,
    {$ENDIF}
    {$IFDEF DELPHI2009_PLUS}pngimage,{$ENDIF}
    {$IFDEF DELPHIXE2_PLUS}
    Vcl.Graphics, Vcl.OleServer,
    {$ELSE}
    Graphics, OleServer,
    {$ENDIF}
  {$ENDIF}
  IniFiles
  {$IFNDEF FPC}
  ,EncdDecd
  {$ENDIF}

  ;

const
  // TypeLibrary Major and minor versions
  VirtualUISMajorVersion = 1;
  VirtualUISMinorVersion = 0;

  LIBID_VirtualUIS: TGUID = '{D4DAF0A0-78A3-4A22-BA6D-C1566F6529F0}';

  IID_IServer: TGUID = '{845B4EE8-0F67-4D84-A4CE-642BBD520A47}';
  CLASS_Server_: TGUID = '{67F012A8-5C8D-4E30-B697-104AF434CF57}';
  IID_ILicense: TGUID = '{A1DF5DC4-7157-4643-B28F-3B3D20A0E5C8}';
  CLASS_License: TGUID = '{7FEB0F94-6A75-4C73-9842-7E16C6378BBB}';
  IID_IProfile: TGUID = '{D478CC7A-8071-47BD-BA2D-845131B51B42}';
  CLASS_Profile: TGUID = '{5FB96D71-BA5A-42BD-9917-65A0AC6AE52C}';
  IID_IProfiles: TGUID = '{C271394D-82FA-4DF9-A603-9927AA76A4F9}';
  CLASS_Profiles: TGUID = '{EF900598-E5FD-434D-8883-AC52B4A57E0A}';
  IID_IBinding: TGUID = '{52C63E8D-2FA4-4179-AFDB-2D33853F3356}';
  CLASS_Binding: TGUID = '{FD6E655F-6D88-4A68-A4C0-F5382C809AF6}';
  IID_IBindings: TGUID = '{9F6F6EDA-F253-4A6B-B058-EDBBEFC2718D}';
  CLASS_Bindings: TGUID = '{D76B13A0-35AB-4737-9F26-C27AC4257A82}';
  IID_ICertificate: TGUID = '{8B534446-EDC5-4EE7-91B0-13B5DACC5B51}';
  CLASS_Certificate: TGUID = '{8C4F00ED-0D77-42CC-BE28-DE88F31636C9}';
  IID_IAutoLogon: TGUID = '{1CA5335A-94E0-490E-9BB7-5C66026883D2}';
  CLASS_AutoLogon: TGUID = '{80C32ED0-8E5A-4685-B863-22B73811B589}';
  IID_IRDS: TGUID = '{103B86C8-E012-4AC7-A366-D3845BBB8D5E}';
  CLASS_RDS: TGUID = '{B67864A0-0650-4838-9864-F7F19CD979A8}';
  IID_IRDSAccounts: TGUID = '{60666BC2-7E17-4842-9716-CFA3DCFD5583}';
  CLASS_RDSAccounts: TGUID = '{AD852F92-BE8E-40DF-B7FE-E96EE599DCDE}';
  IID_IGateways: TGUID = '{716BBB17-7A57-46D1-93BB-2C8A947E1F6B}';
  CLASS_Gateways: TGUID = '{F2A03C8E-F1FA-4799-B0BC-CDB40BB4C020}';
  IID_IBroker: TGUID = '{A5B08CC6-00C2-44FB-8CAC-2C03C9BC7CE5}';
  CLASS_Broker: TGUID = '{B467362A-F019-4B67-A6E6-FF114ED443E7}';
  IID_IBrokers: TGUID = '{2AC5773C-E1BF-4B10-B99F-E28E9A459C29}';
  CLASS_Brokers: TGUID = '{3AA0858F-D8F5-44A1-B63B-55345ED222B5}';
  IID_IUser: TGUID = '{0BA574FB-8F9D-4B7B-97FC-C869231B4E6E}';
  CLASS_User: TGUID = '{3CDC6336-D35E-4A4A-AAF5-9E58C72F205E}';
  IID_IUsers: TGUID = '{751686C0-EA61-420F-A861-F8A7A8329307}';
  CLASS_Users: TGUID = '{D72E94FF-0629-4941-80AD-22646FCA47A1}';
  IID_IAuthentication: TGUID = '{FEC05713-8C95-4A12-805A-CC3B11571501}';
  CLASS_Authentication: TGUID = '{7EB04B7F-E4E5-45BA-A9A1-E4E761814F38}';
  IID_ISSOUser: TGUID = '{25D8274E-75C2-4AC6-B95C-EA146B138AAE}';
  CLASS_SSOUser: TGUID = '{875842CC-28E5-4C67-9F30-F28800DD07CC}';
  IID_ISSOUsers: TGUID = '{5B1D5A75-BBED-4694-8AE0-6EB944DF6318}';
  CLASS_SSOUsers: TGUID = '{8E18D593-AB10-4761-A91F-B1B796B353E8}';
  IID_IAssociatedUserAccount: TGUID = '{99D48E0A-0C91-494C-9A2C-B67BC782B3C2}';
  IID_IAssociatedUserAccounts: TGUID = '{A230AD4D-104A-4444-ADBD-259D5243A485}';
  CLASS_AssociatedUserAccount: TGUID = '{4EA144D9-3F22-402D-9B1C-B9A2B1BAFCCE}';
  CLASS_AssociatedUserAccounts: TGUID = '{3B5CDF2D-2399-4658-B625-F5634771858E}';
  IID_IAuthMethod: TGUID = '{FCF2B73F-2BE2-4097-9FBA-DB0CB413A228}';
  CLASS_AuthMethod: TGUID = '{86DE73AF-24FB-4387-BBA7-A343337DCD61}';
  IID_IAuthMethods: TGUID = '{21EB20DE-26DD-410C-B82D-4A7022BA7A59}';
  CLASS_AuthMethods: TGUID = '{6877032E-FFFF-4AC9-B706-EACA8E1EF7E3}';
  IID_IAuthMethod2FA: TGUID = '{5BB4FF42-4D4D-4775-BE40-26DDBB6806C0}';
  CLASS_AuthMethod2FA: TGUID = '{8F22F272-D630-450B-8462-1ADA844D4915}';
  IID_IAuthMethods2FA: TGUID = '{25C1AB81-7578-4249-BCE7-A9C8DD4A8BA9}';
  CLASS_AuthMethods2FA: TGUID = '{7AAAF00F-E2A4-4173-93CA-19CCDC6D88C7}';
  IID_IStrList: TGUID = '{B40601EE-2E1D-4973-9752-A80D1C00FAD2}';
  CLASS_StrList: TGUID = '{8B754975-FD37-4C47-A9AD-61D4D2018A63}';
  IID_IIPListItem: TGUID = '{F2F2F071-D5DB-4FB1-A2DE-D9976F359946}';
  CLASS_IPListItem: TGUID = '{619CD6A7-E2A6-4449-8D35-DDD733339047}';
  IID_IIPList: TGUID = '{8DF9476B-DD60-44B6-B240-210B64CA7D4E}';
  CLASS_IPList: TGUID = '{3C85F0D4-4AA5-44C6-94AE-76DE9C196B6E}';
  IID_IBruteForceDetection: TGUID = '{B3D8EE8F-2892-44AE-B037-728BB8E25B6D}';
  CLASS_BruteForceDetection: TGUID = '{816B52EB-17D8-41A4-963B-FAA6C653CCBB}';
  IID_ICertificateUtils: TGUID = '{8399F246-FE06-4F8F-B98E-85551B57756A}';
  CLASS_CertificateUtils_: TGUID = '{3EA01167-28DE-493B-960D-4150849639F3}';
  IID_ICertificateInfo: TGUID = '{F721D26C-AD65-4535-8331-9D78F20D37FA}';
  CLASS_CertificateInfo: TGUID = '{6ABABEA9-942E-4470-8B33-C38E9B63B72A}';
  IID_ICertificateInfoList: TGUID = '{802FD3E5-C8B0-4A3A-9C76-086BFCD2E900}';
  CLASS_CertificateInfoList: TGUID = '{7FEE5A33-C909-41F8-B636-1A413437035D}';
  IID_IPath: TGUID = '{83CAE401-7FB8-49F9-AD27-DF3C783CB52B}';
  CLASS_Path: TGUID = '{5C98F7EB-4F38-4641-BC20-5E9CED65F1F4}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library
// *********************************************************************//
// Constants for enum Protocol
type
  Protocol = TOleEnum;
const
  PROTO_HTTP = $00000000;
  PROTO_HTTPS = $00000001;

// Constants for enum ProfileKind
type
  ProfileKind = TOleEnum;
const
  PROFILE_APP = $00000000;
  PROFILE_WEBLINK = $00000001;

// Constants for enum ScreenResolution
type
  ScreenResolution = TOleEnum;
const
  SCREENRES_Custom = $00000000;
  SCREENRES_FitToBrowser = $00000001;
  SCREENRES_FitToScreen = $00000002;
  SCREENRES_640x480 = $00000003;
  SCREENRES_800x600 = $00000004;
  SCREENRES_1024x768 = $00000005;
  SCREENRES_1280x720 = $00000006;
  SCREENRES_1280x768 = $00000007;
  SCREENRES_1280x1024 = $00000008;
  SCREENRES_1440x900 = $00000009;
  SCREENRES_1440x1050 = $0000000A;
  SCREENRES_1600x1200 = $0000000B;
  SCREENRES_1680x1050 = $0000000C;
  SCREENRES_1920x1080 = $0000000D;
  SCREENRES_1920x1200 = $0000000E;

// Constants for enum ServerSection
type
  ServerSection = TOleEnum;
const
  SRVSEC_GENERAL = $00000000;
  SRVSEC_RDS = $00000001;
  SRVSEC_APPLICATIONS = $00000002;
  SRVSEC_LICENSES = $00000003;
  SRVSEC_BROKER = $00000004;
  SRVSEC_AUTHENTICATION = $00000005;
  SRVSEC_FOLDERS = $00000006;
  SRVSEC_BRUTEFORCE = $00000007;

// Constants for enum UserType
type
  UserType = TOleEnum;
const
  UT_USER = $00000000;
  UT_GROUP = $00000001;

// Constants for enum AuthenticationMethod
type
  AuthenticationMethod = TOleEnum;
const
  AM_WINLOGON = $00000000;
  AM_RADIUS = $00000001;
  AM_DUO = $00000002;
  AM_SAML = $00000003;
  AM_OAUTH = $00000004;
  AM_EXTERNAL = $00000005;

// Constants for enum AuthenticationMethod2FA
type
  AuthenticationMethod2FA = TOleEnum;
const
  AM2FA_TOTP = $00000000;
  AM2FA_DUO = $00000001;

// Constants for enum ProfileCredentials
type
  ProfileCredentials = TOleEnum;
const
  CRED_AUTHENTICATED = $00000000;
  CRED_ASK = $00000001;
  CRED_SAVED = $00000002;
  CRED_SERVER = $00000003;

// Constants for enum SetupMode
type
  SetupMode = TOleEnum;
const
  SETUP_NONE = $00000000;
  SETUP_STANDALONE = $00000001;
  SETUP_LOADBALANCING = $00000002;

// Constants for enum SessionAccount
type
  SessionAccount = TOleEnum;
const
  SESSION_ACCOUNT_LOGGED = $00000000;
  SESSION_ACCOUNT_CUSTOM = $00000001;
  SESSION_ACCOUNT_CONSOLE = $00000002;

// Constants for enum SessionMode
type
  SessionMode = TOleEnum;
const
  SESSION_MULTI_BROWSERS = $00000000;
  SESSION_ONE_BROWSER = $00000001;

// Constants for enum RestrictionAction
type
  RestrictionAction = TOleEnum;
const
  RESTRICTION_NONE = $00000000;
  RESTRICTION_ALLOW = $00000001;
  RESTRICTION_BLOCK = $00000002;

// Constants for enum LoadBalancingMethod
type
  LoadBalancingMethod = TOleEnum;
const
  LBM_BREADTH_FIRST = $00000000;
  LBM_DEPTH_FIRST = $00000001;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IServer = interface;
  IServerDisp = dispinterface;
  ILicense = interface;
  ILicenseDisp = dispinterface;
  IProfile = interface;
  IProfileDisp = dispinterface;
  IProfiles = interface;
  IProfilesDisp = dispinterface;
  IBinding = interface;
  IBindingDisp = dispinterface;
  IBindings = interface;
  IBindingsDisp = dispinterface;
  ICertificate = interface;
  ICertificateDisp = dispinterface;
  IAutoLogon = interface;
  IAutoLogonDisp = dispinterface;
  IRDS = interface;
  IRDSDisp = dispinterface;
  IRDSAccounts = interface;
  IRDSAccountsDisp = dispinterface;
  IGateways = interface;
  IGatewaysDisp = dispinterface;
  IBroker = interface;
  IBrokerDisp = dispinterface;
  IBrokers = interface;
  IBrokersDisp = dispinterface;
  IUser = interface;
  IUserDisp = dispinterface;
  IUsers = interface;
  IUsersDisp = dispinterface;
  IAuthentication = interface;
  IAuthenticationDisp = dispinterface;
  ISSOUser = interface;
  ISSOUserDisp = dispinterface;
  ISSOUsers = interface;
  ISSOUsersDisp = dispinterface;
  IAssociatedUserAccount = interface;
  IAssociatedUserAccountDisp = dispinterface;
  IAssociatedUserAccounts = interface;
  IAssociatedUserAccountsDisp = dispinterface;
  IAuthMethod = interface;
  IAuthMethodDisp = dispinterface;
  IAuthMethods = interface;
  IAuthMethodsDisp = dispinterface;
  IAuthMethod2FA = interface;
  IAuthMethod2FADisp = dispinterface;
  IAuthMethods2FA = interface;
  IAuthMethods2FADisp = dispinterface;
  IStrList = interface;
  IStrListDisp = dispinterface;
  IIPListItem = interface;
  IIPListItemDisp = dispinterface;
  IIPList = interface;
  IIPListDisp = dispinterface;
  IBruteForceDetection = interface;
  IBruteForceDetectionDisp = dispinterface;
  ICertificateUtils = interface;
  ICertificateUtilsDisp = dispinterface;
  ICertificateInfo = interface;
  ICertificateInfoDisp = dispinterface;
  ICertificateInfoList = interface;
  ICertificateInfoListDisp = dispinterface;
  IPath = interface;
  IPathDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  Server_ = IServer;
  License = ILicense;
  Profile = IProfile;
  Profiles = IProfiles;
  Binding = IBinding;
  Bindings = IBindings;
  Certificate = ICertificate;
  AutoLogon = IAutoLogon;
  RDS = IRDS;
  RDSAccounts = IRDSAccounts;
  Gateways = IGateways;
  Broker = IBroker;
  Brokers = IBrokers;
  User = IUser;
  Users = IUsers;
  Authentication = IAuthentication;
  SSOUser = ISSOUser;
  SSOUsers = ISSOUsers;
  AssociatedUserAccount = IAssociatedUserAccount;
  AssociatedUserAccounts = IAssociatedUserAccounts;
  AuthMethod = IAuthMethod;
  AuthMethods = IAuthMethods;
  AuthMethod2FA = IAuthMethod2FA;
  AuthMethods2FA = IAuthMethods2FA;
  StrList = IStrList;
  IPListItem = IIPListItem;
  IPList = IIPList;
  BruteForceDetection = IBruteForceDetection;
  CertificateUtils_ = ICertificateUtils;
  CertificateInfo = ICertificateInfo;
  CertificateInfoList = ICertificateInfoList;
  Path = IPath;


// *********************************************************************//
// Interface: IServer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {845B4EE8-0F67-4D84-A4CE-642BBD520A47}
// *********************************************************************//
  IServer = interface(IDispatch)
    ['{845B4EE8-0F67-4D84-A4CE-642BBD520A47}']
    function Get_Binding: IBinding; safecall;
    function Get_Certificate: ICertificate; safecall;
    function Get_RDSAccounts: IRDSAccounts; safecall;
    function Get_Profiles: IProfiles; safecall;
    procedure Load; safecall;
    procedure Save; safecall;
    procedure HideSection(section: ServerSection); safecall;
    procedure ShowSection(section: ServerSection); safecall;
    function Get_License: ILicense; safecall;
    function Get_Gateways: IGateways; safecall;
    function Get_NetworkID: WideString; safecall;
    procedure Set_NetworkID(const Value: WideString); safecall;
    function Get_Authentication: IAuthentication; safecall;
    function Get_RDS: IRDS; safecall;
    function Get_APIKey: WideString; safecall;
    procedure Set_APIKey(const Value: WideString); safecall;
    function Get_SetupMode: SetupMode; safecall;
    function Get_Bindings: IBindings; safecall;
    function Get_Broker: IBroker; safecall;
    function Get_BruteForceDetection: IBruteForceDetection; safecall;
    function Get_SecondaryBrokers: IBrokers; safecall;
    property Binding: IBinding read Get_Binding;
    property Certificate: ICertificate read Get_Certificate;
    property RDSAccounts: IRDSAccounts read Get_RDSAccounts;
    property Profiles: IProfiles read Get_Profiles;
    property License: ILicense read Get_License;
    property Gateways: IGateways read Get_Gateways;
    property NetworkID: WideString read Get_NetworkID write Set_NetworkID;
    property Authentication: IAuthentication read Get_Authentication;
    property RDS: IRDS read Get_RDS;
    property APIKey: WideString read Get_APIKey write Set_APIKey;
    property SetupMode: SetupMode read Get_SetupMode;
    property Bindings: IBindings read Get_Bindings;
    property Broker: IBroker read Get_Broker;
    property BruteForceDetection: IBruteForceDetection read Get_BruteForceDetection;
    property SecondaryBrokers: IBrokers read Get_SecondaryBrokers;
  end;

// *********************************************************************//
// DispIntf:  IServerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {845B4EE8-0F67-4D84-A4CE-642BBD520A47}
// *********************************************************************//
  IServerDisp = dispinterface
    ['{845B4EE8-0F67-4D84-A4CE-642BBD520A47}']
    property Binding: IBinding readonly dispid 201;
    property Certificate: ICertificate readonly dispid 202;
    property RDSAccounts: IRDSAccounts readonly dispid 203;
    property Profiles: IProfiles readonly dispid 204;
    procedure Load; dispid 205;
    procedure Save; dispid 206;
    procedure HideSection(section: ServerSection); dispid 207;
    procedure ShowSection(section: ServerSection); dispid 208;
    property License: ILicense readonly dispid 209;
    property Gateways: IGateways readonly dispid 210;
    property NetworkID: WideString dispid 211;
    property Authentication: IAuthentication readonly dispid 212;
    property RDS: IRDS readonly dispid 213;
    property APIKey: WideString dispid 214;
    property SetupMode: SetupMode readonly dispid 215;
    property Bindings: IBindings readonly dispid 216;
    property Broker: IBroker readonly dispid 217;
    property BruteForceDetection: IBruteForceDetection readonly dispid 218;
    property SecondaryBrokers: IBrokers readonly dispid 219;
  end;

// *********************************************************************//
// Interface: ILicense
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A1DF5DC4-7157-4643-B28F-3B3D20A0E5C8}
// *********************************************************************//
  /// <summary>
  /// Contains methods and properties to control VirtualUI Server's
  /// licence activation. 
  /// </summary>                                                   
  ILicense = interface(IDispatch)
    ['{A1DF5DC4-7157-4643-B28F-3B3D20A0E5C8}']
    function Get_CustomerID: WideString; safecall;
    procedure Set_CustomerID(const Value: WideString); safecall;
    function Get_Limits(const name: WideString): Integer; safecall;
    function Get_Features(const name: WideString): Integer; safecall;
    function Get_IsTrial: WordBool; safecall;
    procedure Set_IsTrial(Value: WordBool); safecall;
    function Get_SerialStr: WideString; safecall;
    procedure Set_SerialStr(const Value: WideString); safecall;

    /// <summary>
    /// Activates the Server's machine license.
    /// </summary>
    /// <param name="customerId">ID of the license to register. </param>
    /// <param name="serial">Serial number of the license. </param>
    /// <param name="resultCode">Activation result code. </param>
    /// <param name="resultText">Message about the error. </param>
    /// <returns>
    /// True if the license was successfully activated. False
    /// otherwise (in which case check resultCode and resultText).
    /// </returns>
    function Activate(const customerId: WideString; const serial: WideString;
                      out resultCode: Integer; out resultTex: WideString): WordBool; safecall;
    /// <summary>
    /// Deactivates the previously activated license.
    /// </summary>
    procedure Deactivate; safecall;

    function Get_TrialDaysLeft: Integer; safecall;
    function Get_IsValid: WordBool; safecall;

    /// <summary>
    /// Using the Serial number property, gets from Activation Server the
    /// Manual Key for Server's machine. This key can be used to generate the
    /// license data needed to perform manual activation.
    /// </summary>
    /// <returns>
    /// The manual activation key.
    /// </returns>
    function GetManualActivationKey: WideString; safecall;

    /// <summary>
    /// Activates the Server's machine license manually.
    /// </summary>
    /// <param name="Data">License data received from Server. </param>
    /// <param name="resultCode">Activation result code. </param>
    /// <param name="resultText">Message about the error. </param>
    /// <returns>
    /// True if the license was successfully activated. False
    /// otherwise (in which case check resultCode and resultText).
    /// </returns>
    function ActivateManual(const Data: WideString; out resultCode: Integer;
                            out resultText: WideString): WordBool; safecall;

    function Get_ServerUrl: WideString; safecall;
    procedure Set_ServerUrl(const Value: WideString); safecall;
    function Get_Expiration: WideString; safecall;

    /// <summary>
    ///   ID of the current Server License.
    /// </summary>
    property CustomerID: WideString read Get_CustomerID write Set_CustomerID;

    /// <summary>
    /// \Returns the License limits, if any (ie, trial days, max
    /// servers, max users per installation, etc).
    /// </summary>
    property Limits[const name: WideString]: Integer read Get_Limits;

    /// <summary>
    ///   Returns custom features enabled on the License, if any.
    /// </summary>
    property Features[const name: WideString]: Integer read Get_Features;

    /// <summary>
    ///   Returns true if the current License is in trial mode.
    /// </summary>
    property IsTrial: WordBool read Get_IsTrial write Set_IsTrial;

    /// <summary>
    ///   Serial number of the current License.
    /// </summary>
    property SerialStr: WideString read Get_SerialStr write Set_SerialStr;

    property TrialDaysLeft: Integer read Get_TrialDaysLeft;

    /// <summary>
    ///   Returns true if the current License is valid (registered and not expired)
    /// </summary>
    property IsValid: WordBool read Get_IsValid;

    /// <summary>
    ///   License Server URL (optional). To set Primary and Backup servers,
    ///   separate them with semicolon.
    ///   Example: https://primaryUrl:7443;https://backupUrl:7443
    /// </summary>
    property ServerUrl: WideString read Get_ServerUrl write Set_ServerUrl;

    /// <summary>
    ///   License expiration date, in format YYYY-MM-DD.
    /// </summary>
    property Expiration: WideString read Get_Expiration;
  end;

// *********************************************************************//
// DispIntf:  ILicenseDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A1DF5DC4-7157-4643-B28F-3B3D20A0E5C8}
// *********************************************************************//
  ILicenseDisp = dispinterface
    ['{A1DF5DC4-7157-4643-B28F-3B3D20A0E5C8}']
    property CustomerID: WideString dispid 201;
    property Limits[const name: WideString]: Integer readonly dispid 203;
    property Features[const name: WideString]: Integer readonly dispid 204;
    property IsTrial: WordBool dispid 205;
    property SerialStr: WideString dispid 202;
    function Activate(const customerId: WideString; const serial: WideString;
                      out resultCode: Integer; out resultTex: WideString): WordBool; dispid 206;
    procedure Deactivate; dispid 207;
    property TrialDaysLeft: Integer readonly dispid 208;
    property IsValid: WordBool readonly dispid 209;
    function GetManualActivationKey: WideString; dispid 210;
    function ActivateManual(const Data: WideString; out resultCode: Integer;
                            out resultText: WideString): WordBool; dispid 211;
    property ServerUrl: WideString dispid 212;
    property Expiration: WideString readonly dispid 213;
  end;

// *********************************************************************//
// Interface: IProfile
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D478CC7A-8071-47BD-BA2D-845131B51B42}
// *********************************************************************//
  /// <summary>
  /// A profile contains information about an application or web
  /// link configured to be opened in VirtualUI's home page (or
  /// directly through its URL). 
  /// </summary>                                                
  IProfile = interface(IDispatch)
    ['{D478CC7A-8071-47BD-BA2D-845131B51B42}']
    function Get_ID: WideString; safecall;
    procedure Set_ID(const Value: WideString); safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Value: WideString); safecall;
    function Get_VirtualPath: WideString; safecall;
    procedure Set_VirtualPath(const Value: WideString); safecall;
    function Get_IsDefault: WordBool; stdcall;
    procedure Set_IsDefault(Value: WordBool); safecall;
    function Get_Enabled: WordBool; stdcall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function Get_ProfileKind: ProfileKind; stdcall;
    procedure Set_ProfileKind(Value: ProfileKind); safecall;
    function Get_FileName: WideString; safecall;
    procedure Set_FileName(const Value: WideString); safecall;
    function Get_Arguments: WideString; safecall;
    procedure Set_Arguments(const Value: WideString); safecall;
    function Get_StartDir: WideString; safecall;
    procedure Set_StartDir(const Value: WideString); safecall;
    function Get_UserName: WideString; safecall;
    procedure Set_UserName(const Value: WideString); safecall;
    function Get_Password: WideString; safecall;
    procedure Set_Password(const Value: WideString); safecall;
    function Get_ScreenResolution: ScreenResolution; stdcall;
    procedure Set_ScreenResolution(Value: ScreenResolution); safecall;
    function Get_WebLink: WideString; safecall;
    procedure Set_WebLink(const Value: WideString); safecall;
    function Get_HomePage: WideString; safecall;
    procedure Set_HomePage(const Value: WideString); safecall;
    function Get_IdleTimeout: Integer; stdcall;
    procedure Set_IdleTimeout(Value: Integer); safecall;
    function Get_IconData: WideString; safecall;
    procedure Set_IconData(const Value: WideString); safecall;
    function Get_Visible: WordBool; stdcall;
    procedure Set_Visible(Value: WordBool); safecall;
    function Get_GuestAllowed: WordBool; stdcall;
    procedure Set_GuestAllowed(Value: WordBool); safecall;
    function Get_Users: IUsers; safecall;
    function Get_PublicKey: WideString; safecall;
    function Get_Credentials: ProfileCredentials; safecall;
    procedure Set_Credentials(Value: ProfileCredentials); safecall;
    function Get_BrokerPool: WideString; safecall;
    procedure Set_BrokerPool(const Value: WideString); safecall;
    function Get_BrowserRules: WideString; safecall;
    procedure Set_BrowserRules(const Value: WideString); safecall;
    function Get_AllowBrowserArguments: WordBool; safecall;
    procedure Set_AllowBrowserArguments(Value: WordBool); safecall;
    function Get_RestrictionAction: RestrictionAction; safecall;
    procedure Set_RestrictionAction(Value: RestrictionAction); safecall;
    function Get_Restrictions: IStrList; safecall;
    function Get_AllowedAuthMethods: IStrList; safecall;
    function Get_AccessHours: WideString; safecall;
    procedure Set_AccessHours(const Value: WideString); safecall;
    function Get_AccessDateEnabled: WordBool; safecall;
    procedure Set_AccessDateEnabled(Value: WordBool); safecall;
    function Get_AccessDateFrom: WideString; safecall;
    procedure Set_AccessDateFrom(const Value: WideString); safecall;
    function Get_AccessDateTo: WideString; safecall;
    procedure Set_AccessDateTo(const Value: WideString); safecall;

    /// <summary>
    ///   Internal ID of the profile. This value is auto generated by the
    ///   library when the profile is created.
    /// </summary>
    property ID: WideString read Get_ID write Set_ID;

    /// <summary>
    /// Profile name. It's the caption for the Application or Web
    /// link in the VirtualUI home page.
    /// </summary>
    property Name: WideString read Get_Name write Set_Name;

    /// <summary>
    ///   The Virtual Path must be unique across all profiles. It will create a
    ///   unique URL address for the profile. The complete path will consist
    ///   of: http(s)://ip:port/VirtualPath/. The users can then create a web
    ///   shortcut to this connection in particular and bypass the Thinfinity
    ///   VirtualUI home page.
    /// </summary>
    property VirtualPath: WideString read Get_VirtualPath write Set_VirtualPath;

    /// <summary>
    ///   This option is used to make this profile the default application: the
    ///   authenticated user will connect to this profile directly instead of
    ///   choosing between the available profiles on the VirtualUI home page.
    /// </summary>
    property IsDefault: WordBool read Get_IsDefault write Set_IsDefault;

    /// <summary>
    /// Enables or disables the profile. Disabled profiles are not
    /// accessible by users.
    /// </summary>
    property Enabled: WordBool read Get_Enabled write Set_Enabled;

    /// <summary>
    /// Gets or sets the profile type: Application or Web Link. Uses
    /// the PROFILE_App and PROFILE_WebLink constants.
    /// </summary>
    property ProfileKind: ProfileKind read Get_ProfileKind write Set_ProfileKind;

    /// <summary>
    ///   Complete path of the application executable file. Only used when the
    ///   ProfileKind is Application.
    /// </summary>
    property FileName: WideString read Get_FileName write Set_FileName;

    /// <summary>
    ///   Parameters to be passed to application.
    /// </summary>
    property Arguments: WideString read Get_Arguments write Set_Arguments;

    /// <summary>
    /// Application startup directory. In most cases, the same
    /// directory of the application executable file.
    /// </summary>
    property StartDir: WideString read Get_StartDir write Set_StartDir;

    /// <summary>
    ///   A valid Windows User account to run the application.
    ///   Used when Credentials is CRED_SAVED.
    /// </summary>
    property UserName: WideString read Get_UserName write Set_UserName;

    /// <summary>
    ///   Password of the Windows User account. Can be set, but not retrieved
    ///   for security reasons.
    ///   Used when Credentials is CRED_SAVED.
    /// </summary>
    property Password: WideString read Get_Password write Set_Password;

    /// <summary>
    ///   Screen resolution in the browser. Uses the constants SCREENRES_...
    /// </summary>
    property ScreenResolution: ScreenResolution read Get_ScreenResolution write Set_ScreenResolution;

    /// <summary>
    /// Complete Web Link URL (used only when ProfileKind is Web Link).
    /// </summary>
    property WebLink: WideString read Get_WebLink write Set_WebLink;

    /// <summary>
    /// Use it to set a customized home page for the application.
    /// </summary>
    property HomePage: WideString read Get_HomePage write Set_HomePage;

    /// <summary>
    /// Set a timeout in minutes if you want VirtualUI Server to wait
    /// before killing the application once the browser has been
    /// closed. Timeout 0 will kill the application immediately after
    /// the browser has been closed.
    /// </summary>
    property IdleTimeout: Integer read Get_IdleTimeout write Set_IdleTimeout;

    /// <summary>
    /// Contains the icon of the profile. This icon is visible in the
    /// VirtualUI home page. The icon must be encoded in base64. To
    /// convert the icon from a PNG image, you can use the
    /// IconToBase64 function. To convert the stored icon to a PNG
    /// image, you can use the Base64ToIcon function.
    /// </summary>
    property IconData: WideString read Get_IconData write Set_IconData;

    /// <summary>
    /// Profiles marked as not visible are hidden in home page.
    /// </summary>
    property Visible: WordBool read Get_Visible write Set_Visible;

    /// <summary>
    /// Indicates anonymous access to this profile. If false, the
    /// users or groups in Users are used.
    /// </summary>
    property GuestAllowed: WordBool read Get_GuestAllowed write Set_GuestAllowed;

    /// <summary>
    /// Users or Groups with granted access to this profile (only
    /// when GuestAllowed is false).
    /// </summary>
    property Users: IUsers read Get_Users;

    /// <summary>
    /// Profile Access Key. Can be used for OTURL generation.
    /// </summary>
    property PublicKey: WideString read Get_PublicKey;

    /// <summary>
    /// Windows Credentials to run the application:
    ///   CRED_AUTHENTICATED: Use the authenticated user credentials
    ///   CRED_ASK: Ask for credentials
    ///   CRED_SAVED: Use the UserName and Password properties.
    ///   CRED_SERVER: Use the Server's RDS Account
    /// </summary>
    property Credentials: ProfileCredentials read Get_Credentials write Set_Credentials;

    /// <summary>
    /// (optional) Pool Name of the Broker to use.
    /// </summary>
    property BrokerPool: WideString read Get_BrokerPool write Set_BrokerPool;

    /// <summary>
    /// Custom Browser Rules file to apply in this Profile.
    /// </summary>
    property BrowserRules: WideString read Get_BrowserRules write Set_BrowserRules;

    /// <summary>
    /// Allow to pass application arguments from browser
    /// </summary>
    property AllowBrowserArguments: WordBool read Get_AllowBrowserArguments write Set_AllowBrowserArguments;

    /// <summary>
    /// Use of Restrictions list:
    ///   NONE: No restrictions. The addresses in Restrictions list are ignored.
    ///   ALLOW: Allow connections from addresses in Restrictions list only.
    ///   BLOCK: Block connections from addresses in Restrictions list.
    /// </summary>
    property RestrictionAction: RestrictionAction read Get_RestrictionAction write Set_RestrictionAction;

    /// <summary>
    /// IP addresses Restrictions list. Used according to RestrictionAction.
    /// </summary>
    property Restrictions: IStrList read Get_Restrictions;

    /// <summary>
    /// Allow access to users authenticated through this methods only.
    /// No restrictions if the list is empty.
    /// </summary>
    property AllowedAuthMethods: IStrList read Get_AllowedAuthMethods;

    /// <summary>
    /// Restricts access to profile based on day of the week and hour.
    /// This field is a string of 7x24 characters (representing 24 hours
    /// for Sunday, 24 for Monday, and so on). To allow connections to
    /// this profile the corresponding hour must be marked with "1"
    /// ("0" to block).
    /// </summary>
    property AccessHours: WideString read Get_AccessHours write Set_AccessHours;

    /// <summary>
    /// Enables access restriction based on dates period (AccessDateFrom
    /// and AccessDateTo fields)
    /// </summary>
    property AccessDateEnabled: WordBool read Get_AccessDateEnabled write Set_AccessDateEnabled;

    /// <summary>
    /// if AccessDateEnabled is true, the profile is not accessible
    /// prior to this date.
    /// </summary>
    property AccessDateFrom: WideString read Get_AccessDateFrom write Set_AccessDateFrom;

    /// <summary>
    /// if AccessDateEnabled is true, the profile is not accessible
    /// past this date.
    /// </summary>
    property AccessDateTo: WideString read Get_AccessDateTo write Set_AccessDateTo;
  end;

// *********************************************************************//
// DispIntf:  IProfileDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D478CC7A-8071-47BD-BA2D-845131B51B42}
// *********************************************************************//
  IProfileDisp = dispinterface
    ['{D478CC7A-8071-47BD-BA2D-845131B51B42}']
    property ID: WideString dispid 201;
    property Name: WideString dispid 202;
    property VirtualPath: WideString dispid 203;
    property IsDefault: WordBool dispid 204;
    property Enabled: WordBool dispid 205;
    property ProfileKind: ProfileKind dispid 207;
    property FileName: WideString dispid 208;
    property Arguments: WideString dispid 209;
    property StartDir: WideString dispid 210;
    property UserName: WideString dispid 211;
    property Password: WideString dispid 212;
    property ScreenResolution: ScreenResolution dispid 213;
    property WebLink: WideString dispid 214;
    property HomePage: WideString dispid 215;
    property IdleTimeout: Integer dispid 216;
    property IconData: WideString dispid 206;
    property Visible: WordBool dispid 217;
    property GuestAllowed: WordBool dispid 218;
    property Users: IUsers readonly dispid 219;
    property PublicKey: WideString dispid 220;
    property Credentials: ProfileCredentials dispid 221;
    property BrokerPool: WideString dispid 222;
    property BrowserRules: WideString dispid 223;
    property AllowBrowserArguments: WordBool dispid 224;
    property RestrictionAction: RestrictionAction dispid 225;
    property Restrictions: IStrList readonly dispid 226;
    property AllowedAuthMethods: IStrList readonly dispid 227;
    property AccessHours: WideString dispid 228;
    property AccessDateEnabled: WordBool dispid 229;
    property AccessDateFrom: WideString dispid 230;
    property AccessDateTo: WideString dispid 231;
  end;

// *********************************************************************//
// Interface: IProfiles
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C271394D-82FA-4DF9-A603-9927AA76A4F9}
// *********************************************************************//
  /// <summary>
  ///   Manages the list of profiles registered in the Server. A profile is one
  ///   application or web link configured to be opened in VirtualUI's home
  ///   page (or directly through it's URL). The method Add is used to create a
  ///   new empty profile in the VirtualUI Server. The properties of this
  ///   profile can be managed through the IProfile interface to complete
  ///   configuration of a new application or web link.
  /// </summary>
  IProfiles = interface(IDispatch)
    ['{C271394D-82FA-4DF9-A603-9927AA76A4F9}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): IProfile; safecall;

    /// <summary>
    /// Creates a new profile and adds it to the list.
    /// </summary>
    /// <returns>
    /// The newly created profile.
    /// </returns>
    /// <seealso cref="IProfile interface"/>
    function Add: IProfile; safecall;

    /// <summary>
    /// Deletes a profile from the list.
    /// </summary>
    /// <param name="profile">The profile to be deleted. </param>
    procedure Delete(const profile: IProfile); safecall;

    /// <summary>
    ///   Returns the profile count.
    /// </summary>
    property Count: Integer read Get_Count;

    /// <value>
    /// Profile interface.
    /// </value>
    /// <summary>
    /// \Returns a profile from the list by its index.
    /// </summary>
    /// <seealso cref="IProfile"/>
    property Item[index: Integer]: IProfile read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  IProfilesDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C271394D-82FA-4DF9-A603-9927AA76A4F9}
// *********************************************************************//
  IProfilesDisp = dispinterface
    ['{C271394D-82FA-4DF9-A603-9927AA76A4F9}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: IProfile readonly dispid 202;
    function Add: IProfile; dispid 205;
    procedure Delete(const profile: IProfile); dispid 206;
  end;

// *********************************************************************//
// Interface: IBinding
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {52C63E8D-2FA4-4179-AFDB-2D33853F3356}
// *********************************************************************//
  /// <summary>
  /// Binding configuration.
  /// </summary>
  IBinding = interface(IDispatch)
    ['{52C63E8D-2FA4-4179-AFDB-2D33853F3356}']
    function Get_Protocol: Protocol; stdcall;
    procedure Set_Protocol(Value: Protocol); safecall;
    function Get_IPAddress: WideString; safecall;
    procedure Set_IPAddress(const Value: WideString); safecall;
    function Get_Port: Integer; stdcall;
    procedure Set_Port(Value: Integer); safecall;
    function Get_HostName: WideString; safecall;
    procedure Set_HostName(const Value: WideString); safecall;
    function Get_RedirectUrl: WideString; safecall;
    procedure Set_RedirectUrl(const Value: WideString); safecall;
    function Get_RedirectStatusCode: Integer; safecall;
    procedure Set_RedirectStatusCode(Value: Integer); safecall;
    function Get_Certificate: ICertificateInfo; safecall;
    procedure Set_Certificate(const Value: ICertificateInfo); safecall;

    /// <summary>
    /// Gets o sets the network protocol: HTTP or HTTPS. Uses the
    /// PROTO_HTTP and PROTO_HTTPS constants.
    /// </summary>
    property Protocol: Protocol read Get_Protocol write Set_Protocol;

    /// <summary>
    /// Gets o sets the local IP Address. Leave empty to use all
    /// addresses.
    /// </summary>
    property IPAddress: WideString read Get_IPAddress write Set_IPAddress;

    /// <summary>
    /// Gets o sets the listening port.
    /// </summary>
    property Port: Integer read Get_Port write Set_Port;

    /// <summary>
    /// Binding Hostname (optional). If used, clients must use the hostname
    /// instead of the IP address to access the site.
    /// </summary>
    property HostName: WideString read Get_HostName write Set_HostName;

    /// <summary>
    /// URL to redirect requests received through this binding
    /// </summary>
    property RedirectUrl: WideString read Get_RedirectUrl write Set_RedirectUrl;

    /// <summary>
    /// Status code used in redirection:
    ///   301: Permanent.
    ///   302: Found.
    ///   307: Temporary.
    ///   308: Redirect.
    /// </summary>
    property RedirectStatusCode: Integer read Get_RedirectStatusCode write Set_RedirectStatusCode;

    /// <summary>
    /// Certificate for HTTPS. The certificate must be installed on Windows.
    /// CertificateUtils can be used to import or create new certificates.
    /// </summary>
    /// <seealso cref="ICertificateUtils interface" />
    property Certificate: ICertificateInfo read Get_Certificate write Set_Certificate;
  end;

// *********************************************************************//
// DispIntf:  IBindingDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {52C63E8D-2FA4-4179-AFDB-2D33853F3356}
// *********************************************************************//
  IBindingDisp = dispinterface
    ['{52C63E8D-2FA4-4179-AFDB-2D33853F3356}']
    property Protocol: Protocol dispid 201;
    property IPAddress: WideString dispid 202;
    property Port: Integer dispid 203;
    property HostName: WideString dispid 204;
    property RedirectUrl: WideString dispid 205;
    property RedirectStatusCode: Integer dispid 206;
    property Certificate: ICertificateInfo dispid 207;
  end;

// *********************************************************************//
// Interface: IBindings
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9F6F6EDA-F253-4A6B-B058-EDBBEFC2718D}
// *********************************************************************//
  /// <summary>
  ///   Manage the Server's Binding configuration.
  /// </summary>
  IBindings = interface(IDispatch)
    ['{9F6F6EDA-F253-4A6B-B058-EDBBEFC2718D}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): IBinding; safecall;

    /// <summary>
    /// Creates a new binding.
    /// </summary>
    /// <returns>
    /// The newly created binding.
    /// </returns>
    /// <seealso cref="IBinding interface"/>
    function Add: IBinding; safecall;

    /// <summary>
    ///   Removes a binding from the list.
    /// </summary>
    /// <param name="binding">
    ///   The binding to be removed.
    /// </param>
    procedure Delete(const binding: IBinding); safecall;

    /// <summary>
    ///   Returns the bindings list count.
    /// </summary>
    property Count: Integer read Get_Count;

    /// <summary>
    ///   Returns a binding from the list by it's index.
    /// </summary>
    /// <seealso cref="IBinding interface"/>
    property Item[index: Integer]: IBinding read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  IBindingsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9F6F6EDA-F253-4A6B-B058-EDBBEFC2718D}
// *********************************************************************//
  IBindingsDisp = dispinterface
    ['{9F6F6EDA-F253-4A6B-B058-EDBBEFC2718D}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: IBinding readonly dispid 202;
    function Add: IBinding; dispid 205;
    procedure Delete(const binding: IBinding); dispid 206;
  end;

// *********************************************************************//
// Interface: ICertificate
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8B534446-EDC5-4EE7-91B0-13B5DACC5B51}
// *********************************************************************//
  /// <summary>
  ///   DEPRECATED: Use Bindings instead.
  /// </summary>
  ICertificate = interface(IDispatch)
    ['{8B534446-EDC5-4EE7-91B0-13B5DACC5B51}']
    function Get_CertFile: WideString; safecall;
    procedure Set_CertFile(const Value: WideString); safecall;
    function Get_CAFile: WideString; safecall;
    procedure Set_CAFile(const Value: WideString); safecall;
    function Get_PKFile: WideString; safecall;
    procedure Set_PKFile(const Value: WideString); safecall;
    function Get_PassPhrase: WideString; safecall;
    procedure Set_PassPhrase(const Value: WideString); safecall;
    property CertFile: WideString read Get_CertFile write Set_CertFile;
    property CAFile: WideString read Get_CAFile write Set_CAFile;
    property PKFile: WideString read Get_PKFile write Set_PKFile;
    property PassPhrase: WideString read Get_PassPhrase write Set_PassPhrase;
  end;

// *********************************************************************//
// DispIntf:  ICertificateDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8B534446-EDC5-4EE7-91B0-13B5DACC5B51}
// *********************************************************************//
  ICertificateDisp = dispinterface
    ['{8B534446-EDC5-4EE7-91B0-13B5DACC5B51}']
    property CertFile: WideString dispid 201;
    property CAFile: WideString dispid 202;
    property PKFile: WideString dispid 203;
    property PassPhrase: WideString dispid 204;
  end;

// *********************************************************************//
// Interface: IAutoLogon
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1CA5335A-94E0-490E-9BB7-5C66026883D2}
// *********************************************************************//
  IAutoLogon = interface(IDispatch)
    ['{1CA5335A-94E0-490E-9BB7-5C66026883D2}']
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function Get_UserName: WideString; safecall;
    procedure Set_UserName(const Value: WideString); safecall;
    function Get_Password: WideString; safecall;
    procedure Set_Password(const Value: WideString); safecall;
    function Get_Shell: WideString; safecall;
    procedure Set_Shell(const Value: WideString); safecall;

    /// <summary>
    /// Enables or disables session AutoLogon.
    /// </summary>
    property Enabled: WordBool read Get_Enabled write Set_Enabled;

    /// <summary>
    /// Username for session AutoLogon.
    /// </summary>
    property UserName: WideString read Get_UserName write Set_UserName;

    /// <summary>
    /// Password for session AutoLogon.
    /// </summary>
    property Password: WideString read Get_Password write Set_Password;

    /// <summary>
    /// Session shell.
    /// </summary>
    property Shell: WideString read Get_Shell write Set_Shell;
  end;

// *********************************************************************//
// DispIntf:  IAutoLogonDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1CA5335A-94E0-490E-9BB7-5C66026883D2}
// *********************************************************************//
  IAutoLogonDisp = dispinterface
    ['{1CA5335A-94E0-490E-9BB7-5C66026883D2}']
    property Enabled: WordBool dispid 201;
    property UserName: WideString dispid 202;
    property Password: WideString dispid 203;
    property Shell: WideString dispid 204;
  end;

// *********************************************************************//
// Interface: IRDS
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {103B86C8-E012-4AC7-A366-D3845BBB8D5E}
// *********************************************************************//
  /// <summary>
  ///   Manages the configuration of an alternative Remote Desktop Services
  ///   account. VirtualUI makes use of an interactive session. The default
  ///   setting is to run applications under the console session, but it can be
  ///   configured to do it under Remote Desktop Services sessions. For the
  ///   production environment, it is recommended to set VirtualUI to run
  ///   applications under its own Remote Desktop Services session. This will
  ///   ensure that the service is available at all times. Alternatively, you
  ///   can choose to have VirtualUI run the applications under the console
  ///   session by configuring the Auto Logon feature on your Windows operating
  ///   system.
  /// </summary>
  IRDS = interface(IDispatch)
    ['{103B86C8-E012-4AC7-A366-D3845BBB8D5E}']
    function Get_UserName: WideString; safecall;
    procedure Set_UserName(const Value: WideString); safecall;
    function Get_Password: WideString; safecall;
    procedure Set_Password(const Value: WideString); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function Get_SessionSharing: WordBool; safecall;
    procedure Set_SessionSharing(Value: WordBool); safecall;
    function Get_SessionCount: Integer; safecall;
    procedure Set_SessionCount(Value: Integer); safecall;

    /// <summary>
    /// Creates a new RDS account using UserName and Password properties.
    /// </summary>
    procedure CreateAccount; safecall;

    function Get_SessionAccount: SessionAccount; safecall;
    procedure Set_SessionAccount(Value: SessionAccount); safecall;
    function Get_SessionMode: SessionMode; safecall;
    procedure Set_SessionMode(Value: SessionMode); safecall;
    function Get_ThirdPartyApps: WordBool; safecall;
    procedure Set_ThirdPartyApps(Value: WordBool); safecall;
    function Get_AutoLogon: IAutoLogon; safecall;

    /// <summary>
    /// Enables or disables the use of RDS account. Available on Windows Server
    /// with Remote Desktop Session Host (RD Session Host) role service installed.
    /// </summary>
    property Enabled: WordBool read Get_Enabled write Set_Enabled;

    /// <summary>
    /// Gets o sets the RDS account Username.
    /// Used when SessionCount is SESSION_ACCOUNT_CUSTOM.
    /// </summary>
    property UserName: WideString read Get_UserName write Set_UserName;

    /// <summary>
    /// Gets o sets the RDS account Password. Can be set, but is not
    /// retrieved for security reasons.
    /// Used when SessionCount is SESSION_ACCOUNT_CUSTOM.
    /// </summary>
    property Password: WideString read Get_Password write Set_Password;

    /// <summary>
    /// DEPRECATED. Use SessionMode instead.
    /// </summary>
    property SessionSharing: WordBool read Get_SessionSharing write Set_SessionSharing;

    /// <summary>
    /// DEPRECATED. Use UsersLimit on IBroker instead.
    /// </summary>
    property SessionCount: Integer read Get_SessionCount write Set_SessionCount;

    /// <summary>
    /// Account to use:
    ///   SESSION_ACCOUNT_CUSTOM: Use UserName and Password properties.
    ///   SESSION_ACCOUNT_LOGGED: Use the logged-on user account.
    ///   SESSION_ACCOUNT_CONSOLE: Run under the console session.
    /// </summary>
    property SessionAccount: SessionAccount read Get_SessionAccount write Set_SessionAccount;

    /// <summary>
    /// Session mode:
    ///   SESSION_MULTI_BROWSERS: Multiple browsers per session.
    ///   SESSION_ONE_BROWSER: One browser per session.
    /// </summary>
    property SessionMode: SessionMode read Get_SessionMode write Set_SessionMode;

    /// <summary>
    ///  .
    /// </summary>
    property ThirdPartyApps: WordBool read Get_ThirdPartyApps write Set_ThirdPartyApps;

    /// <summary>
    ///  AutoLogon options for console session.
    /// </summary>
    property AutoLogon: IAutoLogon read Get_AutoLogon;
  end;

// *********************************************************************//
// DispIntf:  IRDSDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {103B86C8-E012-4AC7-A366-D3845BBB8D5E}
// *********************************************************************//
  IRDSDisp = dispinterface
    ['{103B86C8-E012-4AC7-A366-D3845BBB8D5E}']
    property UserName: WideString dispid 201;
    property Password: WideString dispid 202;
    property Enabled: WordBool dispid 203;
    property SessionSharing: WordBool dispid 204;
    property SessionCount: Integer dispid 205;
    procedure CreateAccount; dispid 206;
    property SessionAccount: SessionAccount dispid 207;
    property SessionMode: SessionMode dispid 208;
    property ThirdPartyApps: WordBool dispid 209;
    property AutoLogon: IAutoLogon readonly dispid 210;
  end;

// *********************************************************************//
// Interface: IRDSAccounts
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {60666BC2-7E17-4842-9716-CFA3DCFD5583}
// *********************************************************************//
  /// <summary>
  /// DEPRECATED: Use IRDS instead.
  /// </summary>
  IRDSAccounts = interface(IDispatch)
    ['{60666BC2-7E17-4842-9716-CFA3DCFD5583}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): IRDS; safecall;
    function Add(const UserName: WideString; const Password: WideString; CreateAccount: WordBool): IRDS; safecall;
    function Delete(const UserName: WideString; DeleteAccount: WordBool): WordBool; safecall;
    property Count: Integer read Get_Count;
    property Item[index: Integer]: IRDS read Get_Item;
  end;

// *********************************************************************//
// DispIntf:  IRDSAccountsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {60666BC2-7E17-4842-9716-CFA3DCFD5583}
// *********************************************************************//
  IRDSAccountsDisp = dispinterface
    ['{60666BC2-7E17-4842-9716-CFA3DCFD5583}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: IRDS readonly dispid 202;
    function Add(const UserName: WideString; const Password: WideString; CreateAccount: WordBool): IRDS; dispid 203;
    function Delete(const UserName: WideString; DeleteAccount: WordBool): WordBool; dispid 204;
  end;

// *********************************************************************//
// Interface: IGateways
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {716BBB17-7A57-46D1-93BB-2C8A947E1F6B}
// *********************************************************************//
  /// <summary>
  ///   Manages the configuration of gateway servers.
  /// </summary>
  IGateways = interface(IDispatch)
    ['{716BBB17-7A57-46D1-93BB-2C8A947E1F6B}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): WideString; safecall;

    /// <summary>
    /// Adds a new URL to the gateway list.
    /// </summary>
    /// <param name="URL">
    ///   The Gateway URL to be added.
    /// </param>
    procedure Add(const URL: WideString); safecall;

    /// <summary>
    ///   Deletes an URL from the list.
    /// </summary>
    /// <param name="index">
    ///   The index of the URL to be deleted.
    /// </param>
    procedure Delete(Index: Integer); safecall;

    /// <summary>
    ///   Returns the URLs count.
    /// </summary>
    property Count: Integer read Get_Count;

    /// <summary>
    ///   Returns an URL from the list by it's index.
    /// </summary>
    property Item[index: Integer]: WideString read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  IGatewaysDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {716BBB17-7A57-46D1-93BB-2C8A947E1F6B}
// *********************************************************************//
  IGatewaysDisp = dispinterface
    ['{716BBB17-7A57-46D1-93BB-2C8A947E1F6B}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: WideString readonly dispid 202;
    procedure Add(const URL: WideString); dispid 203;
    procedure Delete(Index: Integer); dispid 204;
  end;

// *********************************************************************//
// Interface: IBroker
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A5B08CC6-00C2-44FB-8CAC-2C03C9BC7CE5}
// *********************************************************************//
  /// <summary>
  ///   Manages Broker configuration.
  /// </summary>
  IBroker = interface(IDispatch)
    ['{A5B08CC6-00C2-44FB-8CAC-2C03C9BC7CE5}']
    function Get_Primary: WordBool; safecall;
    procedure Set_Primary(Value: WordBool); safecall;
    function Get_UsersLimit: Integer; safecall;
    procedure Set_UsersLimit(Value: Integer); safecall;
    function Get_PoolName: WideString; safecall;
    procedure Set_PoolName(const Value: WideString); safecall;
    function Get_LoadBalancingMethod: LoadBalancingMethod; safecall;
    procedure Set_LoadBalancingMethod(Value: LoadBalancingMethod); safecall;
    function Get_Default: WordBool; safecall;
    procedure Set_Default(Value: WordBool); safecall;
    function Get_RDS: IRDS; safecall;
    function Get_TmpFiles: IPath; safecall;

    /// <summary>
    /// Broker role.
    /// <summary>
    property Primary: WordBool read Get_Primary write Set_Primary;

    /// <summary>
    /// Users limit.
    /// </summary>
    property UsersLimit: Integer read Get_UsersLimit write Set_UsersLimit;

    /// <summary>
    /// Pool name for non primary brokers. Leave emtpy to use default.
    /// </summary>
    property PoolName: WideString read Get_PoolName write Set_PoolName;

    /// <summary>
    /// Breadth-first Load Balancing allows you to evenly distribute user
    /// sessions across the session hosts in a broker pool.
    /// Depth-first load balancing allows you to saturate a session host
    /// with user sessions in a broker pool.
    /// </summary>
    property LoadBalancingMethod: LoadBalancingMethod read Get_LoadBalancingMethod write Set_LoadBalancingMethod;

    /// <summary>
    /// In secondary brokers pool, mark this pool as default.
    /// </summary>
    property Default: WordBool read Get_Default write Set_Default;

    /// <summary>
    /// Session settings for broker or pool.
    /// </summary>
    property RDS: IRDS read Get_RDS;

    /// <summary>
    /// Folders settings for broker or pool.
    /// </summary>
    property TmpFiles: IPath read Get_TmpFiles;
  end;

// *********************************************************************//
// DispIntf:  IBrokerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A5B08CC6-00C2-44FB-8CAC-2C03C9BC7CE5}
// *********************************************************************//
  IBrokerDisp = dispinterface
    ['{A5B08CC6-00C2-44FB-8CAC-2C03C9BC7CE5}']
    property Primary: WordBool dispid 201;
    property UsersLimit: Integer dispid 202;
    property PoolName: WideString dispid 203;
    property LoadBalancingMethod: LoadBalancingMethod dispid 204;
    property Default: WordBool dispid 205;
    property RDS: IRDS readonly dispid 206;
    property TmpFiles: IPath readonly dispid 207;
  end;

// *********************************************************************//
// Interface: IBrokers
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2AC5773C-E1BF-4B10-B99F-E28E9A459C29}
// *********************************************************************//
  IBrokers = interface(IDispatch)
    ['{2AC5773C-E1BF-4B10-B99F-E28E9A459C29}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): IBroker; safecall;
    function Add: IBroker; safecall;
    procedure Delete(const broker: IBroker); safecall;
    procedure Clear; safecall;
    property Count: Integer read Get_Count;
    property Item[index: Integer]: IBroker read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  IBrokersDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2AC5773C-E1BF-4B10-B99F-E28E9A459C29}
// *********************************************************************//
  IBrokersDisp = dispinterface
    ['{2AC5773C-E1BF-4B10-B99F-E28E9A459C29}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: IBroker readonly dispid 202;
    function Add: IBroker; dispid 205;
    procedure Delete(const broker: IBroker); dispid 206;
    procedure Clear; dispid 207;
  end;

// *********************************************************************//
// Interface: IUser
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0BA574FB-8F9D-4B7B-97FC-C869231B4E6E}
// *********************************************************************//
  /// <summary>
  /// User for permissions settings.
  /// </summary>
  IUser = interface(IDispatch)
    ['{0BA574FB-8F9D-4B7B-97FC-C869231B4E6E}']
    function Get_UserType: UserType; safecall;
    function Get_SamCompatible: WideString; safecall;

    /// <summary>
    /// User type: User name or Group name.
    /// </summary>
    property UserType: UserType read Get_UserType;

    /// <summary>
    /// Windows User or Group name.
    /// </summary>
    property SamCompatible: WideString read Get_SamCompatible;
  end;

// *********************************************************************//
// DispIntf:  IUserDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0BA574FB-8F9D-4B7B-97FC-C869231B4E6E}
// *********************************************************************//
  IUserDisp = dispinterface
    ['{0BA574FB-8F9D-4B7B-97FC-C869231B4E6E}']
    property UserType: UserType dispid 201;
    property SamCompatible: WideString dispid 202;
  end;

// *********************************************************************//
// Interface: IUsers
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {751686C0-EA61-420F-A861-F8A7A8329307}
// *********************************************************************//
  /// <summary>
  /// List of IUser.
  /// </summary>
  IUsers = interface(IDispatch)
    ['{751686C0-EA61-420F-A861-F8A7A8329307}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): IUser; safecall;

    /// <summary>
    /// Creates a new User and adds it to the list.
    /// </summary>
    /// <param name="UserType">
    ///   Indicates type of User that SamCompatible defines
    ///   (UserType enum: User or Group).
    /// </param>
    /// <param name="SamCompatible">
    ///   User or Group (according to UserType) to grant.
    /// </param>
    /// <returns>
    /// The newly created User.
    /// </returns>
    /// <seealso cref="IUser">
    ///   User interface.
    /// </seealso>
    function Add(UserType: UserType; const SamCompatible: WideString): IUser; safecall;

    /// <summary>
    ///   Deletes a User from the list.
    /// </summary>
    /// <param name="UserType">
    ///   Indicates type of User that SamCompatible defines
    ///   (UserType enum: User or Group).
    /// </param>
    /// <param name="SamCompatible">
    ///   The User to be deleted.
    /// </param>
    function Delete(UserType: UserType; const SamCompatible: WideString): WordBool; safecall;

    /// <summary>
    ///   Removes the User.
    /// </summary>
    function Remove(const User: IUser): WordBool; safecall;

    /// <summary>
    ///   Returns the Users count.
    /// </summary>
    property Count: Integer read Get_Count;

    /// <summary>
    ///   Returns a User from the list by it's index.
    /// </summary>
    /// <seealso cref="IUser">
    ///   User interface.
    /// </seealso>
    property Item[index: Integer]: IUser read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  IUsersDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {751686C0-EA61-420F-A861-F8A7A8329307}
// *********************************************************************//
  IUsersDisp = dispinterface
    ['{751686C0-EA61-420F-A861-F8A7A8329307}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: IUser readonly dispid 202;
    function Add(UserType: UserType; const SamCompatible: WideString): IUser; dispid 203;
    function Delete(UserType: Integer; const SamCompatible: WideString): WordBool; dispid 204;
    function Remove(const User: IUser): WordBool; dispid 205;
  end;

// *********************************************************************//
// Interface: IAuthentication
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FEC05713-8C95-4A12-805A-CC3B11571501}
// *********************************************************************//
  /// <summary>
  ///   Manages the Server authentication settings.
  /// </summary>
  IAuthentication = interface(IDispatch)
    ['{FEC05713-8C95-4A12-805A-CC3B11571501}']
    function Get_AllowAnonymous: WordBool; stdcall;
    procedure Set_AllowAnonymous(Value: WordBool); safecall;
    function Get_SSOUsers: ISSOUsers; safecall;
    function Get_AuthMethods: IAuthMethods; safecall;
    function Get_SecondFactorMethods: IAuthMethods2FA; safecall;

    /// <summary>
    ///   Enables or disables the anonymous access to the Server home page.
    /// </summary>
    property AllowAnonymous: WordBool read Get_AllowAnonymous write Set_AllowAnonymous;

    /// <summary>
    ///   Returns the SSO user mappings. This can be used to map usernames
    ///   used in SSO authentication methods to Windows user names or
    ///   groups, used in profiles permissions.
    /// </summary>
    property SSOUsers: ISSOUsers read Get_SSOUsers;

    /// <summary>
    ///   Returns the available Authentication Methods on the Server.
    /// </summary>
    property AuthMethods: IAuthMethods read Get_AuthMethods;

    /// <summary>
    ///   Methods for Two-Factor authentication. Used in IAuthMethod.
    /// </summary>
    property SecondFactorMethods: IAuthMethods2FA read Get_SecondFactorMethods;
  end;

// *********************************************************************//
// DispIntf:  IAuthenticationDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FEC05713-8C95-4A12-805A-CC3B11571501}
// *********************************************************************//
  IAuthenticationDisp = dispinterface
    ['{FEC05713-8C95-4A12-805A-CC3B11571501}']
    property AllowAnonymous: WordBool dispid 201;
    property SSOUsers: ISSOUsers readonly dispid 202;
    property AuthMethods: IAuthMethods readonly dispid 203;
    property SecondFactorMethods: IAuthMethods2FA readonly dispid 204;
  end;

// *********************************************************************//
// Interface: ISSOUser
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {25D8274E-75C2-4AC6-B95C-EA146B138AAE}
// *********************************************************************//
  /// <summary>
  ///   Manages one SSO user mapping.
  /// </summary>
  ISSOUser = interface(IDispatch)
    ['{25D8274E-75C2-4AC6-B95C-EA146B138AAE}']
    function Get_RemoteUser: WideString; safecall;
    function Get_MethodId: WideString; safecall;
    function Get_Enabled: WordBool; stdcall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function Get_AssociatedUserAccounts: IAssociatedUserAccounts; safecall;
    function Get_WinUsername: WideString; safecall;
    procedure Set_WinUsername(const Value: WideString); safecall;
    function Get_WinPassword: WideString; safecall;
    procedure Set_WinPassword(const Value: WideString); safecall;

    /// <summary>
    ///   Remote Username mask to match
    /// </summary>
    property RemoteUser: WideString read Get_RemoteUser;

    /// <summary>
    ///   MethodId to match. Can be one of the Authentication Methods
    ///   configured in Server (like Google, Facebook, etc) or * to match all
    /// </summary>
    property MethodId: WideString read Get_MethodId;

    /// <summary>
    ///   Enables or disables this mapping
    /// </summary>
    property Enabled: WordBool read Get_Enabled write Set_Enabled;

    /// <summary>
    ///   Users or Groups mapped to this RemoteUser/MethodId
    /// </summary>
    property AssociatedUserAccounts: IAssociatedUserAccounts read Get_AssociatedUserAccounts;

    /// <summary>
    /// (optional) Custom Windows Credentials to use
    /// </summary>
    property WinUsername: WideString read Get_WinUsername write Set_WinUsername;

    /// <summary>
    /// (optional) Custom Windows Credentials to use. Password can
    /// be set, but is not retrieved for security reasons.
    /// </summary>
    property WinPassword: WideString read Get_WinPassword write Set_WinPassword;
  end;

// *********************************************************************//
// DispIntf:  ISSOUserDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {25D8274E-75C2-4AC6-B95C-EA146B138AAE}
// *********************************************************************//
  ISSOUserDisp = dispinterface
    ['{25D8274E-75C2-4AC6-B95C-EA146B138AAE}']
    property RemoteUser: WideString readonly dispid 201;
    property MethodId: WideString readonly dispid 202;
    property Enabled: WordBool dispid 203;
    property AssociatedUserAccounts: IAssociatedUserAccounts readonly dispid 204;
    property WinUsername: WideString dispid 205;
    property WinPassword: WideString dispid 206;
  end;

// *********************************************************************//
// Interface: ISSOUsers
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5B1D5A75-BBED-4694-8AE0-6EB944DF6318}
// *********************************************************************//
  /// <summary>
  /// List of ISSOUser. Manages the SSO user mappings.
  /// </summary>
  ISSOUsers = interface(IDispatch)
    ['{5B1D5A75-BBED-4694-8AE0-6EB944DF6318}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): ISSOUser; safecall;

    /// <summary>
    ///   Creates a new Associated User and adds it to the list.
    /// </summary>
    /// <param name="RemoteUser">
    ///   Remote Username mask
    /// </param>
    /// <param name="MethodID">
    ///   MethodId to match. Can be one of the Authentication Methods
    ///   configured in Server (like Google, Facebook, etc) or * to match all
    /// </param>
    /// <param name="Enabled">
    ///   Indicates if the mapping is enabled or disabled.
    /// </param>
    /// <returns>
    /// The newly created SSO User mapping.
    /// </returns>
    /// <seealso cref="ISSOUser">
    ///   SSO User interface.
    /// </seealso>
    function Add(const RemoteUser: WideString; const MethodID: WideString; Enabled: WordBool): ISSOUser; safecall;

    /// <summary>
    ///   Deletes a SSO User mapping from the list, based on RemoteUser+MethodId.
    /// </summary>
    function Delete(const RemoteUser: WideString; const MethodId: WideString): WordBool; safecall;

    /// <summary>
    ///   Removes the SSO User mapping.
    /// </summary>
    function Remove(const SSOUser: ISSOUser): WordBool; safecall;

    /// <summary>
    ///   Returns the mappings count.
    /// </summary>
    property Count: Integer read Get_Count;

    /// <summary>
    ///   Returns a SSO User mapping from the list by it's index.
    /// </summary>
    /// <seealso cref="ISSOUser">
    ///   SSO User interface.
    /// </seealso>
    property Item[index: Integer]: ISSOUser read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  ISSOUsersDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5B1D5A75-BBED-4694-8AE0-6EB944DF6318}
// *********************************************************************//
  ISSOUsersDisp = dispinterface
    ['{5B1D5A75-BBED-4694-8AE0-6EB944DF6318}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: ISSOUser readonly dispid 202;
    function Add(const RemoteUser: WideString; const MethodID: WideString; Enabled: WordBool): ISSOUser; dispid 203;
    function Delete(const RemoteUser: WideString; const MethodId: WideString): WordBool; dispid 204;
    function Remove(const SSOUser: ISSOUser): WordBool; dispid 205;
  end;

// *********************************************************************//
// Interface: IAssociatedUserAccount
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {99D48E0A-0C91-494C-9A2C-B67BC782B3C2}
// *********************************************************************//
  /// <summary>
  ///   Manages a associated account to a SSO user mapping.
  /// </summary>
  IAssociatedUserAccount = interface(IDispatch)
    ['{99D48E0A-0C91-494C-9A2C-B67BC782B3C2}']
    function Get_UserType: UserType; safecall;
    function Get_SamCompatible: WideString; safecall;

    /// <summary>
    ///   Indicates type of User that SamCompatible defines
    ///   (UserType enum: User or Group).
    /// </summary>
    property UserType: UserType read Get_UserType;

    /// <summary>
    ///   User or Group (according to UserType).
    /// </summary>
    property SamCompatible: WideString read Get_SamCompatible;
  end;

// *********************************************************************//
// DispIntf:  IAssociatedUserAccountDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {99D48E0A-0C91-494C-9A2C-B67BC782B3C2}
// *********************************************************************//
  IAssociatedUserAccountDisp = dispinterface
    ['{99D48E0A-0C91-494C-9A2C-B67BC782B3C2}']
    property UserType: UserType readonly dispid 201;
    property SamCompatible: WideString readonly dispid 202;
  end;

// *********************************************************************//
// Interface: IAssociatedUserAccounts
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A230AD4D-104A-4444-ADBD-259D5243A485}
// *********************************************************************//
  /// <summary>
  ///   Manages user accounts associated to a SSO user mapping.
  /// </summary>
  IAssociatedUserAccounts = interface(IDispatch)
    ['{A230AD4D-104A-4444-ADBD-259D5243A485}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): IAssociatedUserAccount; safecall;

    /// <summary>
    ///   Creates a new Associated User and adds it to the list.
    /// </summary>
    /// <param name="UserType">
    ///   Indicates type of User that SamCompatible defines
    ///   (UserType enum: User or Group).
    /// </param>
    /// <param name="SamCompatible">
    ///   User or Group (according to UserType) to grant.
    /// </param>
    /// <returns>
    ///   The newly created Associated User.
    /// </returns>
    /// <seealso cref="IAssociatedUserAccount">
    ///   Associated User interface.
    /// </seealso>
    function Add(UserType: UserType; const SamCompatible: WideString): IAssociatedUserAccount; safecall;

    /// <summary>
    ///   Deletes a Associated User from the list.
    /// </summary>
    /// <param name="UserType">
    ///   Indicates type of User that SamCompatible defines
    ///   (UserType enum: User or Group).
    /// </param>
    /// <param name="SamCompatible">
    ///   The User to be deleted.
    /// </param>
    function Delete(UserType: UserType; const SamCompatible: WideString): WordBool; safecall;

    /// <summary>
    ///   Removes the Associated User.
    /// </summary>
    function Remove(const User: IAssociatedUserAccount): WordBool; safecall;

    /// <summary>
    ///   Returns the Associated Users count.
    /// </summary>
    property Count: Integer read Get_Count;

    /// <summary>
    ///   Returns a Associated User from the list by it's index.
    /// </summary>
    /// <seealso cref="IAssociatedUserAccount">
    ///   Associated User interface.
    /// </seealso>
    property Item[index: Integer]: IAssociatedUserAccount read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  IAssociatedUserAccountsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A230AD4D-104A-4444-ADBD-259D5243A485}
// *********************************************************************//
  IAssociatedUserAccountsDisp = dispinterface
    ['{A230AD4D-104A-4444-ADBD-259D5243A485}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: IAssociatedUserAccount readonly dispid 202;
    function Add(UserType: UserType; const SamCompatible: WideString): IAssociatedUserAccount; dispid 203;
    function Delete(UserType: UserType; const SamCompatible: WideString): WordBool; dispid 204;
    function Remove(const User: IAssociatedUserAccount): WordBool; dispid 205;
  end;

// *********************************************************************//
// Interface: IAuthMethod
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FCF2B73F-2BE2-4097-9FBA-DB0CB413A228}
// *********************************************************************//
  /// <summary>
  /// Manages the configuration of an Authentication Method.
  /// </summary>
  IAuthMethod = interface(IDispatch)
    ['{FCF2B73F-2BE2-4097-9FBA-DB0CB413A228}']
    function Get_MethodId: AuthenticationMethod; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Value: WideString); safecall;
    function Get_Enabled: WordBool; stdcall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function Get_IsReadOnly: WordBool; safecall;
    function Get_Icon: WideString; safecall;
    procedure Set_Icon(const Value: WideString); safecall;
    function Get_VirtualPath: WideString; safecall;
    procedure Set_VirtualPath(const Value: WideString); safecall;
    function Get_Settings: WideString; safecall;
    procedure Set_Settings(const Value: WideString); safecall;
    function Get_SecondFactorMethod: WideString; safecall;
    procedure Set_SecondFactorMethod(const Value: WideString); safecall;

    /// <summary>
    ///   Returns the ID of the Authentication Method.
    /// </summary>
    property MethodId: AuthenticationMethod read Get_MethodId;

    /// <summary>
    ///   Gets or sets the Authentication Method name.
    /// </summary>
    property Name: WideString read Get_Name write Set_Name;

    /// <summary>
    ///   Enables or disables the Authentication Method.
    /// </summary>
    property Enabled: WordBool read Get_Enabled write Set_Enabled;

    /// <summary>
    ///   Returns true if the Authentication Method is read only. This applies
    ///   to the built-in methods: they can be disabled but not deleted.
    /// </summary>
    property IsReadOnly: WordBool read Get_IsReadOnly;

    /// <summary>
    ///   Contains the icon of the Authentication Method. This icon is used in the
    ///   VirtualUI home page. The icon must be encoded in base64. To set the
    ///   icon from a PNG image, you can use the IconToBase64 function. To
    ///   convert the stored icon to a PNG image, can use the Base64ToIcon
    ///   function.
    /// </summary>
    property Icon: WideString read Get_Icon write Set_Icon;

    /// <summary>
    ///   Virtual Path for the Authentication Method.
    ///   Access the web with this path to bypass the method selection.
    /// </summary>
    property VirtualPath: WideString read Get_VirtualPath write Set_VirtualPath;

    /// <summary>
    ///   Contains the specific settings for the Authentication Method, in the
    ///   form Name=Value separated by a new line (CRLF).
    /// </summary>
    property Settings: WideString read Get_Settings write Set_Settings;

    /// <summary>
    ///   2FA Method name to use (none if empty). 2FA methods are
    ///   in IAuthentication.SecondFactorMethods list.
    /// </summary>
    property SecondFactorMethod: WideString read Get_SecondFactorMethod write Set_SecondFactorMethod;
  end;

// *********************************************************************//
// DispIntf:  IAuthMethodDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FCF2B73F-2BE2-4097-9FBA-DB0CB413A228}
// *********************************************************************//
  IAuthMethodDisp = dispinterface
    ['{FCF2B73F-2BE2-4097-9FBA-DB0CB413A228}']
    property MethodId: AuthenticationMethod readonly dispid 201;
    property Name: WideString dispid 202;
    property Enabled: WordBool dispid 203;
    property IsReadOnly: WordBool readonly dispid 204;
    property Icon: WideString dispid 205;
    property VirtualPath: WideString dispid 206;
    property Settings: WideString dispid 207;
    property SecondFactorMethod: WideString dispid 208;
  end;

// *********************************************************************//
// Interface: IAuthMethods
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {21EB20DE-26DD-410C-B82D-4A7022BA7A59}
// *********************************************************************//
  /// <summary>
  /// List of Authentication methods.
  /// </summary>
  IAuthMethods = interface(IDispatch)
    ['{21EB20DE-26DD-410C-B82D-4A7022BA7A59}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): IAuthMethod; safecall;

    /// <summary>
    ///   Adds a new Authentication Method.
    /// </summary>
    /// <param name="MethodId">
    ///   The ID of the Authentication Method to add.
    /// </param>
    function Add(MethodId: AuthenticationMethod): IAuthMethod; safecall;

    /// <summary>
    ///   Deletes an Authentication Method from the list.
    /// </summary>
    /// <param name="Method">
    ///   The Authentication Method to delete.
    /// </param>
    function Remove(const Method: IAuthMethod): WordBool; safecall;

    /// <summary>
    ///   Returns the Authentication Methods count.
    /// </summary>
    property Count: Integer read Get_Count;

    /// <summary>
    ///   Returns an Authentication Method from the list by it's index.
    /// </summary>
    property Item[index: Integer]: IAuthMethod read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  IAuthMethodsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {21EB20DE-26DD-410C-B82D-4A7022BA7A59}
// *********************************************************************//
  IAuthMethodsDisp = dispinterface
    ['{21EB20DE-26DD-410C-B82D-4A7022BA7A59}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: IAuthMethod readonly dispid 202;
    function Add(MethodId: AuthenticationMethod): IAuthMethod; dispid 203;
    function Remove(const Method: IAuthMethod): WordBool; dispid 204;
  end;

// *********************************************************************//
// Interface: IAuthMethod2FA
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5BB4FF42-4D4D-4775-BE40-26DDBB6806C0}
// *********************************************************************//
  /// <summary>
  /// Manages the configuration of a Second Factor Authentication Method.
  /// </summary>
  IAuthMethod2FA = interface(IDispatch)
    ['{5BB4FF42-4D4D-4775-BE40-26DDBB6806C0}']
    function Get_Name: WideString; safecall;
    function Get_Settings: WideString; safecall;
    procedure Set_Settings(const Value: WideString); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Value: WordBool); safecall;

    /// <summary>
    ///   Gets the Authentication Method name.
    /// </summary>
    property Name: WideString read Get_Name;

    /// <summary>
    ///   Contains the specific settings for the Authentication Method, in the
    ///   form Name=Value separated by a new line (CRLF).
    /// </summary>
    property Settings: WideString read Get_Settings write Set_Settings;

    /// <summary>
    ///   Enables or disables this 2FA method.
    /// </summary>
    property Enabled: WordBool read Get_Enabled write Set_Enabled;

    /// <summary>
    ///   Reset Two-Factor key stored on Server for the given UserName.
    /// </summary>
    procedure ResetKey(const UserName: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IAuthMethod2FADisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5BB4FF42-4D4D-4775-BE40-26DDBB6806C0}
// *********************************************************************//
  IAuthMethod2FADisp = dispinterface
    ['{5BB4FF42-4D4D-4775-BE40-26DDBB6806C0}']
    property Name: WideString readonly dispid 201;
    property Settings: WideString dispid 202;
    property Enabled: WordBool dispid 203;
    procedure ResetKey(const Username: WideString); dispid 204;
  end;

// *********************************************************************//
// Interface: IAuthMethods2FA
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {25C1AB81-7578-4249-BCE7-A9C8DD4A8BA9}
// *********************************************************************//
  /// <summary>
  /// List of 2FA methods.
  /// </summary>
  IAuthMethods2FA = interface(IDispatch)
    ['{25C1AB81-7578-4249-BCE7-A9C8DD4A8BA9}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): IAuthMethod2FA; safecall;

    /// <summary>
    ///   Adds a new Second Factor Authentication Method.
    /// </summary>
    /// <param name="MethodId">
    ///   The ID of the Authentication Method to add.
    /// </param>
    function Add(MethodId: AuthenticationMethod2FA): IAuthMethod2FA; safecall;

    /// <summary>
    ///   Deletes an Second Factor Authentication Method from the list.
    /// </summary>
    /// <param name="Method">
    ///   The 2FA Method to delete.
    /// </param>
    function Remove(const Method: IAuthMethod2FA): WordBool; safecall;

    /// <summary>
    ///   Returns the 2FA Methods count.
    /// </summary>
    property Count: Integer read Get_Count;

    /// <summary>
    ///   Returns a 2FA Method from the list by it's index.
    /// </summary>
    property Item[index: Integer]: IAuthMethod2FA read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  IAuthMethods2FADisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {25C1AB81-7578-4249-BCE7-A9C8DD4A8BA9}
// *********************************************************************//
  IAuthMethods2FADisp = dispinterface
    ['{25C1AB81-7578-4249-BCE7-A9C8DD4A8BA9}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: IAuthMethod2FA readonly dispid 202;
    function Add(MethodId: AuthenticationMethod2FA): IAuthMethod2FA; dispid 203;
    function Remove(const Method: IAuthMethod2FA): WordBool; dispid 204;
  end;

// *********************************************************************//
// Interface: IStrList
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B40601EE-2E1D-4973-9752-A80D1C00FAD2}
// *********************************************************************//
  /// <summary>
  /// Generic list of strings used by some interfaces.
  /// </summary>
  IStrList = interface(IDispatch)
    ['{B40601EE-2E1D-4973-9752-A80D1C00FAD2}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): WideString; safecall;
    procedure Add(const Value: WideString); safecall;
    procedure Delete(Index: Integer); safecall;
    procedure Clear; safecall;
    function Contains(const Value: WideString): WordBool; safecall;
    property Count: Integer read Get_Count;
    property Item[index: Integer]: WideString read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  IStrListDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B40601EE-2E1D-4973-9752-A80D1C00FAD2}
// *********************************************************************//
  IStrListDisp = dispinterface
    ['{B40601EE-2E1D-4973-9752-A80D1C00FAD2}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: WideString readonly dispid 202;
    procedure Add(const Value: WideString); dispid 203;
    procedure Delete(Index: Integer); dispid 204;
    procedure Clear; dispid 205;
    function Contains(const Value: WideString): WordBool; dispid 206;
  end;

// *********************************************************************//
// Interface: IIPListItem
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F2F2F071-D5DB-4FB1-A2DE-D9976F359946}
// *********************************************************************//
  /// <summary>
  /// IP Address/Mask item. Used in IIPList for IBruteForceDetection properties.
  /// </summary>
  IIPListItem = interface(IDispatch)
    ['{F2F2F071-D5DB-4FB1-A2DE-D9976F359946}']
    function Get_Address: WideString; safecall;
    procedure Set_Address(const Value: WideString); safecall;
    function Get_Persistent: WordBool; safecall;
    function Get_Expiration: WideString; safecall;

    /// <summary>
    /// IP Address or Mask
    /// </summary>
    property Address: WideString read Get_Address write Set_Address;

    /// <summary>
    /// True if item was added manually, False otherwise.
    /// Not persistent items are added at runtime.
    /// </summary>
    property Persistent: WordBool read Get_Persistent;

    /// <summary>
    /// Item Expiration Date, in format YYYY-MM-DD HH:MM:SS
    /// </summary>
    property Expiration: WideString read Get_Expiration;
  end;

// *********************************************************************//
// DispIntf:  IIPListItemDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F2F2F071-D5DB-4FB1-A2DE-D9976F359946}
// *********************************************************************//
  IIPListItemDisp = dispinterface
    ['{F2F2F071-D5DB-4FB1-A2DE-D9976F359946}']
    property Address: WideString dispid 201;
    property Persistent: WordBool readonly dispid 202;
    property Expiration: WideString readonly dispid 203;
  end;

// *********************************************************************//
// Interface: IIPList
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8DF9476B-DD60-44B6-B240-210B64CA7D4E}
// *********************************************************************//
  /// <summary>
  /// List of IIPListItem, used in IBruteForceDetection properties.
  /// </summary>
  IIPList = interface(IDispatch)
    ['{8DF9476B-DD60-44B6-B240-210B64CA7D4E}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): IIPListItem; safecall;

    /// <summary>
    ///   Add IP Address or Mask to list.
    /// </summary>
    /// <returns>
    ///   The newly created item.
    /// </returns>
    /// <seealso cref="IIPListItem interface"/>
    function Add(const Address: WideString): IIPListItem; safecall;

    /// <summary>
    /// Removes IP item from the list by it's index.
    /// </summary>
    procedure Delete(Index: Integer); safecall;

    /// <summary>
    /// Returns items Count.
    /// </summary>
    property Count: Integer read Get_Count;

    /// <summary>
    /// Returns a IP item from the list by it's index.
    /// </summary>
    /// <seealso cref="IIPListItem interface"/>
    property Item[index: Integer]: IIPListItem read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  IIPListDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8DF9476B-DD60-44B6-B240-210B64CA7D4E}
// *********************************************************************//
  IIPListDisp = dispinterface
    ['{8DF9476B-DD60-44B6-B240-210B64CA7D4E}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: IIPListItem readonly dispid 202;
    function Add(const Address: WideString): IIPListItem; dispid 203;
    procedure Delete(Index: Integer); dispid 204;
  end;

// *********************************************************************//
// Interface: IBruteForceDetection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B3D8EE8F-2892-44AE-B037-728BB8E25B6D}
// *********************************************************************//
  /// <summary>
  /// Brute Force detection configuration. If enabled, after a number of invalid
  /// login attempts IP addresses will be blocked for a time
  /// </summary>
  IBruteForceDetection = interface(IDispatch)
    ['{B3D8EE8F-2892-44AE-B037-728BB8E25B6D}']
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function Get_MaxLoginAttempts: Integer; safecall;
    procedure Set_MaxLoginAttempts(Value: Integer); safecall;
    function Get_BlockTime: Integer; safecall;
    procedure Set_BlockTime(Value: Integer); safecall;
    function Get_WhiteList: IIPList; safecall;
    function Get_BlackList: IIPList; safecall;

    /// <summary>
    /// Enables Brute Force detection
    /// </summary>
    property Enabled: WordBool read Get_Enabled write Set_Enabled;

    /// <summary>
    /// Max failed login attempts. When reached, the origin IP address is
    /// blocked (if not included in whitelist).
    /// </summary>
    property MaxLoginAttempts: Integer read Get_MaxLoginAttempts write Set_MaxLoginAttempts;

    /// <summary>
    /// Block time, in minutes, for IP addresses thath reaches MaxLoginAttempts
    /// </summary>
    property BlockTime: Integer read Get_BlockTime write Set_BlockTime;

    /// <summary>
    /// Addresses in this list are never blocked. Local IP addresses are
    /// added at runtime and cannot be removed.
    /// </summary>
    /// <seealso cref="IIPList interface"/>
    property WhiteList: IIPList read Get_WhiteList;

    /// <summary>
    /// Currently blocked IP addresses. When BlockTime elapses, IP are removed
    /// from list and can login again.
    /// Addresses manually added (persistent) are not removed.
    /// </summary>
    /// <seealso cref="IIPList interface"/>
    property BlackList: IIPList read Get_BlackList;
  end;

// *********************************************************************//
// DispIntf:  IBruteForceDetectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B3D8EE8F-2892-44AE-B037-728BB8E25B6D}
// *********************************************************************//
  IBruteForceDetectionDisp = dispinterface
    ['{B3D8EE8F-2892-44AE-B037-728BB8E25B6D}']
    property Enabled: WordBool dispid 201;
    property MaxLoginAttempts: Integer dispid 202;
    property BlockTime: Integer dispid 203;
    property WhiteList: IIPList readonly dispid 204;
    property BlackList: IIPList readonly dispid 205;
  end;

// *********************************************************************//
// Interface: ICertificateUtils
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8399F246-FE06-4F8F-B98E-85551B57756A}
// *********************************************************************//
  ICertificateUtils = interface(IDispatch)
    ['{8399F246-FE06-4F8F-B98E-85551B57756A}']
    function GetCertificates: ICertificateInfoList; safecall;
    function GetCertificateInfo(const CertificateStore: WideString; const Thumbprint: WideString): ICertificateInfo; safecall;
    function ImportCertificate(const FileName: WideString; const Password: WideString;
                               out Thumbprint: WideString; out CertificateStore: WideString): WordBool; safecall;
    function CreateSelfSignedCertificate(const OutputfileName: WideString;
                                         const Password: WideString; const CommonName: WideString;
                                         const Country: WideString; const State: WideString;
                                         const Locality: WideString;
                                         const Organization: WideString;
                                         const OrganizationalUnit: WideString;
                                         const EmailAddress: WideString; KeySize: Integer;
                                         out Thumbprint: WideString;
                                         out CertificateStore: WideString): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  ICertificateUtilsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8399F246-FE06-4F8F-B98E-85551B57756A}
// *********************************************************************//
  ICertificateUtilsDisp = dispinterface
    ['{8399F246-FE06-4F8F-B98E-85551B57756A}']
    function GetCertificates: ICertificateInfoList; dispid 201;
    function GetCertificateInfo(const CertificateStore: WideString; const Thumbprint: WideString): ICertificateInfo; dispid 202;
    function ImportCertificate(const FileName: WideString; const Password: WideString;
                               out Thumbprint: WideString; out CertificateStore: WideString): WordBool; dispid 203;
    function CreateSelfSignedCertificate(const OutputfileName: WideString;
                                         const Password: WideString; const CommonName: WideString;
                                         const Country: WideString; const State: WideString;
                                         const Locality: WideString;
                                         const Organization: WideString;
                                         const OrganizationalUnit: WideString;
                                         const EmailAddress: WideString; KeySize: Integer;
                                         out Thumbprint: WideString;
                                         out CertificateStore: WideString): WordBool; dispid 204;
  end;

// *********************************************************************//
// Interface: ICertificateInfo
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F721D26C-AD65-4535-8331-9D78F20D37FA}
// *********************************************************************//
  /// <summary>
  /// Certificate information.
  /// </summary>
  ICertificateInfo = interface(IDispatch)
    ['{F721D26C-AD65-4535-8331-9D78F20D37FA}']
    function Get_CommonName: WideString; safecall;
    function Get_IssuedTo: WideString; safecall;
    function Get_ExpirationDate: WideString; safecall;
    function Get_FriendlyName: WideString; safecall;
    function Get_CertificateStore: WideString; safecall;
    function Get_IssuedBy: WideString; safecall;
    function Get_Thumbprint: WideString; safecall;
    function Get_DisplayName: WideString; safecall;
    property CommonName: WideString read Get_CommonName;
    property IssuedTo: WideString read Get_IssuedTo;
    property ExpirationDate: WideString read Get_ExpirationDate;
    property FriendlyName: WideString read Get_FriendlyName;
    property CertificateStore: WideString read Get_CertificateStore;
    property IssuedBy: WideString read Get_IssuedBy;
    property Thumbprint: WideString read Get_Thumbprint;
    property DisplayName: WideString read Get_DisplayName;
  end;

// *********************************************************************//
// DispIntf:  ICertificateInfoDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F721D26C-AD65-4535-8331-9D78F20D37FA}
// *********************************************************************//
  ICertificateInfoDisp = dispinterface
    ['{F721D26C-AD65-4535-8331-9D78F20D37FA}']
    property CommonName: WideString readonly dispid 201;
    property IssuedTo: WideString readonly dispid 202;
    property ExpirationDate: WideString readonly dispid 203;
    property FriendlyName: WideString readonly dispid 204;
    property CertificateStore: WideString readonly dispid 205;
    property IssuedBy: WideString readonly dispid 206;
    property Thumbprint: WideString readonly dispid 207;
    property DisplayName: WideString readonly dispid 208;
  end;

// *********************************************************************//
// Interface: ICertificateInfoList
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {802FD3E5-C8B0-4A3A-9C76-086BFCD2E900}
// *********************************************************************//
  /// <summary>
  /// List of certificates.
  /// </summary>
  ICertificateInfoList = interface(IDispatch)
    ['{802FD3E5-C8B0-4A3A-9C76-086BFCD2E900}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): ICertificateInfo; safecall;
    procedure Add(const item: ICertificateInfo); safecall;
    property Count: Integer read Get_Count;
    property Item[index: Integer]: ICertificateInfo read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  ICertificateInfoListDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {802FD3E5-C8B0-4A3A-9C76-086BFCD2E900}
// *********************************************************************//
  ICertificateInfoListDisp = dispinterface
    ['{802FD3E5-C8B0-4A3A-9C76-086BFCD2E900}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: ICertificateInfo readonly dispid 202;
    procedure Add(const item: ICertificateInfo); dispid 203;
  end;

// *********************************************************************//
// Interface: IPath
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {83CAE401-7FB8-49F9-AD27-DF3C783CB52B}
// *********************************************************************//
  IPath = interface(IDispatch)
    ['{83CAE401-7FB8-49F9-AD27-DF3C783CB52B}']
    function Get_Path: WideString; safecall;
    procedure Set_Path(const Value: WideString); safecall;
    function Get_UserName: WideString; safecall;
    procedure Set_UserName(const Value: WideString); safecall;
    function Get_Password: WideString; safecall;
    procedure Set_Password(const Value: WideString); safecall;
    property Path: WideString read Get_Path write Set_Path;
    property UserName: WideString read Get_UserName write Set_UserName;
    property Password: WideString read Get_Password write Set_Password;
  end;

// *********************************************************************//
// DispIntf:  IPathDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {83CAE401-7FB8-49F9-AD27-DF3C783CB52B}
// *********************************************************************//
  IPathDisp = dispinterface
    ['{83CAE401-7FB8-49F9-AD27-DF3C783CB52B}']
    property Path: WideString dispid 201;
    property UserName: WideString dispid 202;
    property Password: WideString dispid 203;
  end;

// *********************************************************************//
// The Class CoServer_ provides a Create and CreateRemote method to
// create instances of the default interface IServer exposed by
// the CoClass Server. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoServer_ = class
    class function Create: IServer;
    class function CreateRemote(const MachineName: string): IServer;
  end;

// *********************************************************************//
// The Class CoLicense provides a Create and CreateRemote method to
// create instances of the default interface ILicense exposed by
// the CoClass License. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoLicense = class
    class function Create: ILicense;
    class function CreateRemote(const MachineName: string): ILicense;
  end;

// *********************************************************************//
// The Class CoProfile provides a Create and CreateRemote method to
// create instances of the default interface IProfile exposed by
// the CoClass Profile. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoProfile = class
    class function Create: IProfile;
    class function CreateRemote(const MachineName: string): IProfile;
  end;

// *********************************************************************//
// The Class CoProfiles provides a Create and CreateRemote method to
// create instances of the default interface IProfiles exposed by
// the CoClass Profiles. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoProfiles = class
    class function Create: IProfiles;
    class function CreateRemote(const MachineName: string): IProfiles;
  end;

// *********************************************************************//
// The Class CoBinding provides a Create and CreateRemote method to
// create instances of the default interface IBinding exposed by
// the CoClass Binding. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoBinding = class
    class function Create: IBinding;
    class function CreateRemote(const MachineName: string): IBinding;
  end;

// *********************************************************************//
// The Class CoBindings provides a Create and CreateRemote method to
// create instances of the default interface IBindings exposed by
// the CoClass Bindings. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoBindings = class
    class function Create: IBindings;
    class function CreateRemote(const MachineName: string): IBindings;
  end;

// *********************************************************************//
// The Class CoCertificate provides a Create and CreateRemote method to
// create instances of the default interface ICertificate exposed by
// the CoClass Certificate. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoCertificate = class
    class function Create: ICertificate;
    class function CreateRemote(const MachineName: string): ICertificate;
  end;

// *********************************************************************//
// The Class CoAutoLogon provides a Create and CreateRemote method to
// create instances of the default interface IAutoLogon exposed by
// the CoClass AutoLogon. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoAutoLogon = class
    class function Create: IAutoLogon;
    class function CreateRemote(const MachineName: string): IAutoLogon;
  end;

// *********************************************************************//
// The Class CoRDS provides a Create and CreateRemote method to
// create instances of the default interface IRDS exposed by
// the CoClass RDS. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoRDS = class
    class function Create: IRDS;
    class function CreateRemote(const MachineName: string): IRDS;
  end;

// *********************************************************************//
// The Class CoRDSAccounts provides a Create and CreateRemote method to
// create instances of the default interface IRDSAccounts exposed by
// the CoClass RDSAccounts. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoRDSAccounts = class
    class function Create: IRDSAccounts;
    class function CreateRemote(const MachineName: string): IRDSAccounts;
  end;

// *********************************************************************//
// The Class CoGateways provides a Create and CreateRemote method to
// create instances of the default interface IGateways exposed by
// the CoClass Gateways. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoGateways = class
    class function Create: IGateways;
    class function CreateRemote(const MachineName: string): IGateways;
  end;

// *********************************************************************//
// The Class CoBroker provides a Create and CreateRemote method to
// create instances of the default interface IBroker exposed by
// the CoClass Broker. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoBroker = class
    class function Create: IBroker;
    class function CreateRemote(const MachineName: string): IBroker;
  end;

// *********************************************************************//
// The Class CoBrokers provides a Create and CreateRemote method to
// create instances of the default interface IBrokers exposed by
// the CoClass Brokers. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoBrokers = class
    class function Create: IBrokers;
    class function CreateRemote(const MachineName: string): IBrokers;
  end;

// *********************************************************************//
// The Class CoUser provides a Create and CreateRemote method to
// create instances of the default interface IUser exposed by
// the CoClass User. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoUser = class
    class function Create: IUser;
    class function CreateRemote(const MachineName: string): IUser;
  end;

// *********************************************************************//
// The Class CoUsers provides a Create and CreateRemote method to
// create instances of the default interface IUsers exposed by
// the CoClass Users. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoUsers = class
    class function Create: IUsers;
    class function CreateRemote(const MachineName: string): IUsers;
  end;

// *********************************************************************//
// The Class CoAuthentication provides a Create and CreateRemote method to
// create instances of the default interface IAuthentication exposed by
// the CoClass Authentication. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoAuthentication = class
    class function Create: IAuthentication;
    class function CreateRemote(const MachineName: string): IAuthentication;
  end;

// *********************************************************************//
// The Class CoSSOUser provides a Create and CreateRemote method to
// create instances of the default interface ISSOUser exposed by
// the CoClass SSOUser. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoSSOUser = class
    class function Create: ISSOUser;
    class function CreateRemote(const MachineName: string): ISSOUser;
  end;

// *********************************************************************//
// The Class CoSSOUsers provides a Create and CreateRemote method to
// create instances of the default interface ISSOUsers exposed by
// the CoClass SSOUsers. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoSSOUsers = class
    class function Create: ISSOUsers;
    class function CreateRemote(const MachineName: string): ISSOUsers;
  end;

// *********************************************************************//
// The Class CoAssociatedUserAccount provides a Create and CreateRemote method to
// create instances of the default interface IAssociatedUserAccount exposed by
// the CoClass AssociatedUserAccount. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoAssociatedUserAccount = class
    class function Create: IAssociatedUserAccount;
    class function CreateRemote(const MachineName: string): IAssociatedUserAccount;
  end;

// *********************************************************************//
// The Class CoAssociatedUserAccounts provides a Create and CreateRemote method to
// create instances of the default interface IAssociatedUserAccounts exposed by
// the CoClass AssociatedUserAccounts. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoAssociatedUserAccounts = class
    class function Create: IAssociatedUserAccounts;
    class function CreateRemote(const MachineName: string): IAssociatedUserAccounts;
  end;

// *********************************************************************//
// The Class CoAuthMethod provides a Create and CreateRemote method to
// create instances of the default interface IAuthMethod exposed by
// the CoClass AuthMethod. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoAuthMethod = class
    class function Create: IAuthMethod;
    class function CreateRemote(const MachineName: string): IAuthMethod;
  end;

// *********************************************************************//
// The Class CoAuthMethods provides a Create and CreateRemote method to
// create instances of the default interface IAuthMethods exposed by
// the CoClass AuthMethods. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoAuthMethods = class
    class function Create: IAuthMethods;
    class function CreateRemote(const MachineName: string): IAuthMethods;
  end;

// *********************************************************************//
// The Class CoAuthMethod2FA provides a Create and CreateRemote method to
// create instances of the default interface IAuthMethod2FA exposed by
// the CoClass AuthMethod2FA. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoAuthMethod2FA = class
    class function Create: IAuthMethod2FA;
    class function CreateRemote(const MachineName: string): IAuthMethod2FA;
  end;

// *********************************************************************//
// The Class CoAuthMethods2FA provides a Create and CreateRemote method to
// create instances of the default interface IAuthMethods2FA exposed by
// the CoClass AuthMethods2FA. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoAuthMethods2FA = class
    class function Create: IAuthMethods2FA;
    class function CreateRemote(const MachineName: string): IAuthMethods2FA;
  end;

// *********************************************************************//

// *********************************************************************//
// The Class CoStrList provides a Create and CreateRemote method to
// create instances of the default interface IStrList exposed by
// the CoClass StrList. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoStrList = class
    class function Create: IStrList;
    class function CreateRemote(const MachineName: string): IStrList;
  end;

// *********************************************************************//
// The Class CoIPListItem provides a Create and CreateRemote method to
// create instances of the default interface IIPListItem exposed by
// the CoClass IPListItem. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoIPListItem = class
    class function Create: IIPListItem;
    class function CreateRemote(const MachineName: string): IIPListItem;
  end;

// *********************************************************************//
// The Class CoIPList provides a Create and CreateRemote method to
// create instances of the default interface IIPList exposed by
// the CoClass IPList. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoIPList = class
    class function Create: IIPList;
    class function CreateRemote(const MachineName: string): IIPList;
  end;

// *********************************************************************//
// The Class CoBruteForceDetection provides a Create and CreateRemote method to
// create instances of the default interface IBruteForceDetection exposed by
// the CoClass BruteForceDetection. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoBruteForceDetection = class
    class function Create: IBruteForceDetection;
    class function CreateRemote(const MachineName: string): IBruteForceDetection;
  end;

// *********************************************************************//
// The Class CoCertificateUtils provides a Create and CreateRemote method to
// create instances of the default interface ICertificateUtils exposed by
// the CoClass CertificateUtils. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoCertificateUtils_ = class
    class function Create: ICertificateUtils;
    class function CreateRemote(const MachineName: string): ICertificateUtils;
  end;

// *********************************************************************//
// The Class CoCertificateInfo provides a Create and CreateRemote method to
// create instances of the default interface ICertificateInfo exposed by
// the CoClass CertificateInfo. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoCertificateInfo = class
    class function Create: ICertificateInfo;
    class function CreateRemote(const MachineName: string): ICertificateInfo;
  end;

// *********************************************************************//
// The Class CoCertificateInfoList provides a Create and CreateRemote method to
// create instances of the default interface ICertificateInfoList exposed by
// the CoClass CertificateInfoList. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoCertificateInfoList = class
    class function Create: ICertificateInfoList;
    class function CreateRemote(const MachineName: string): ICertificateInfoList;
  end;

// *********************************************************************//
// The Class CoPath provides a Create and CreateRemote method to
// create instances of the default interface IPath exposed by
// the CoClass Path. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoPath = class
    class function Create: IPath;
    class function CreateRemote(const MachineName: string): IPath;
  end;

  /// <summary>
  ///   Main class. Contains methods and properties to manage all Server
  ///   configuration.
  /// </summary>
  TServer = class(TInterfacedObject, IServer)
  private
    FServer: IServer;
  protected
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;

    function Get_Binding: IBinding; safecall;
    function Get_Certificate: ICertificate; safecall;
    function Get_RDSAccounts: IRDSAccounts; safecall;
    function Get_Profiles: IProfiles; safecall;
    function Get_License: ILicense; safecall;
    function Get_Gateways: IGateways; safecall;
    function Get_NetworkID: WideString; safecall;
    procedure Set_NetworkID(const Value: WideString); safecall;
    function Get_Authentication: IAuthentication; safecall;
    function Get_RDS: IRDS; safecall;
    function Get_APIKey: WideString; safecall;
    procedure Set_APIKey(const Value: WideString); safecall;
    function Get_SetupMode: SetupMode; safecall;
    function Get_Bindings: IBindings; safecall;
    function Get_Broker: IBroker; safecall;
    function Get_BruteForceDetection: IBruteForceDetection; safecall;
    function Get_SecondaryBrokers: IBrokers; safecall;
  public
    constructor Create;
    destructor Destroy; override;

    /// <summary>
    ///   DEPRECATED: use Bindings instead.
    /// </summary>
    /// <seealso cref="IBinding interface" />
    property Binding: IBinding read Get_Binding;

    /// <summary>
    /// DEPRECATED: Not longer supported. Use Bindings instead.
    /// </summary>
    property Certificate: ICertificate read Get_Certificate;

    /// <summary>
    /// \(deprecated: use RDS property) Returns the list of
    /// Remote Desktop Services accounts.
    /// </summary>
    /// <seealso cref="IRDSAccounts interface"/>
    property RDSAccounts: IRDSAccounts read Get_RDSAccounts;

    /// <summary>
    /// \Returns the Remote Desktop Services configuration.
    /// </summary>
    /// <seealso cref="IRDSAccounts interface"/>
    property RDS: IRDS read Get_RDS;

    /// <summary>
    /// \Returns the profiles list.
    /// </summary>
    /// <seealso cref="IProfiles interface"/>
    property Profiles: IProfiles read Get_Profiles;

    /// <summary>
    /// \Returns the current Server's licence.
    /// </summary>
    /// <seealso cref="ILicense interface"/>
    property License: ILicense read Get_License;

    /// <summary>
    /// \Returns the current Server's gateways.
    /// </summary>
    /// <seealso cref="IGateway interface"/>
    property Gateways: IGateways read Get_Gateways;

    /// <summary>
    /// Global Network ID. All the Gateway and Server installations involved
    /// in a Load Balancing architecture share the same network ID.
    /// </summary>
    property NetworkID: WideString read Get_NetworkID write Set_NetworkID;

    /// <summary>
    ///   Returns the Authentication settings
    /// </summary>
    /// <seealso cref="IAuthentication"/>
    ///   Authentication interface
    /// </seealso>
    property Authentication: IAuthentication read Get_Authentication;

    /// <summary>
    /// API Key. Used for OTURL creation.
    /// </summary>
    property APIKey: WideString read Get_APIKey write Set_APIKey;

    /// <summary>
    /// VirtualUI installation mode: Standalone or Load Balancing.
    /// </summary>
    property SetupMode: SetupMode read Get_SetupMode;

    /// <summary>
    /// Binding configuration.
    /// </summary>
    /// <seealso cref="IBindings" />
    property Bindings: IBindings read Get_Bindings;

    /// <summary>
    /// Broker options.
    /// </summary>
    /// <seealso cref="IBroker" />
    property Broker: IBroker read Get_Broker;

    /// <summary>
    /// Brute Force detection configuration.
    /// </summary>
    /// <seealso cref="IBruteForceDetection" />
    property BruteForceDetection: IBruteForceDetection read Get_BruteForceDetection;

    /// <summary>
    /// .
    /// </summary>
    property SecondaryBrokers: IBrokers read Get_SecondaryBrokers;

    /// <summary>
    /// Loads all the configuration entries and profiles from file.
    /// It is automatically called by constructor.
    /// </summary>
    procedure Load; safecall;

    /// <summary>
    /// Saves the entire configuration parameters and profiles.
    /// </summary>
    procedure Save; safecall;

    /// <summary>
    /// Hides a configuration section in the VirtualUI Server Manager GUI.
    /// </summary>
    /// <param name="section">The Server configuration section to hide to user:
    ///   SRVSEC_GENERAL: General tab, that contains the Binding configuration.
    ///   SRVSEC_RDS: Sessions configuration.
    ///   SRVSEC_APPLICATIONS: List of applications.
    ///   SRVSEC_LICENSES: License information.
    ///   SRVSEC_BROKER: Broker options.
    ///   SRVSEC_AUTHENTICATION: Authentication options, methods and user mappings.
    ///   SRVSEC_FOLDERS: Folder options.
    ///   SRVSEC_BRUTEFORCE: Brute force detection options.
    /// </param>
    procedure HideSection(section: ServerSection); safecall;

    /// <summary>
    /// Makes visible a configuration section in the VirtualUI Server Manager GUI.
    /// </summary>
    /// <param name="section">The Server configuration section to show to user.
    ///   SRVSEC_GENERAL: General tab, that contains the Binding configuration.
    ///   SRVSEC_RDS: Sessions configuration.
    ///   SRVSEC_APPLICATIONS: List of applications.
    ///   SRVSEC_LICENSES: License information.
    ///   SRVSEC_BROKER: Broker options.
    ///   SRVSEC_AUTHENTICATION: Authentication options, methods and user mappings.
    ///   SRVSEC_FOLDERS: Folder options.
    ///   SRVSEC_BRUTEFORCE: Brute force detection options.
    /// </param>
    procedure ShowSection(section: ServerSection); safecall;
  end;

  /// <summary>
  /// Helper functions to manage Binding certificates.
  /// </summary>
  TCertificateUtils = class(TInterfacedObject, ICertificateUtils)
  private
    FCertificateUtils: ICertificateUtils;
  protected
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
  public
    constructor Create;
    destructor Destroy; override;

    /// <summary>
    /// Returns available certificates installed on Windows. Only
    /// certificates in this list can be used for HTTPS binding configuration.
    /// </summary>
    /// <seealso cref="ICertificateInfoList interface"/>
    function GetCertificates: ICertificateInfoList; safecall;

    /// <summary>
    /// Returns information for certificate that matches specified
    /// Store and Thumbprint.
    /// </summary>
    /// <seealso cref="ICertificateInfo interface"/>
    function GetCertificateInfo(const CertificateStore: WideString; const Thumbprint: WideString): ICertificateInfo; safecall;

    /// <summary>
    ///   Imports certificate from file. If success, returns CertificateStore and Thumbprint.
    /// </summary>
    /// <param name="FileName">
    ///   Certificate file to import.
    /// </param>
    /// <param name="Password">
    ///   Certificate password, if required. Used to import protected PFX files.
    /// </param>
    /// <param name="Thumbprint">
    ///   (output) Returns Thumbprint of imported certificate.
    /// </param>
    /// <param name="CertificateStore">
    ///   (output) Returns where certificate was stored.
    /// </param>
    function ImportCertificate(const FileName, Password: WideString; out Thumbprint: WideString;
      out CertificateStore: WideString): WordBool; safecall;

    /// <summary>
    ///   Creates and import a new Self-signed certificate with the specified
    ///   attributes. If success, returns CertificateStore and Thumbprint.
    /// </summary>
    /// <param name="OutputfileName">
    ///   Destination filename for certificate. If empty, a temp file will be used.
    /// </param>
    /// <param name="Password">
    ///   Password to be set in generated certificate file. Can be empty.
    /// </param>
    /// <param name="CommonName, Country, State, Locality, Organization, OrganizationalUnit, EmailAddress">
    ///   Certificate attributes.
    /// </param>
    /// <param name="KeySize">
    ///   KeySize. Use 2048 or higher.
    /// </param>
    /// <param name="Thumbprint">
    ///   (output) Returns Thumbprint of imported certificate.
    /// </param>
    /// <param name="CertificateStore">
    ///   (output) Returns where certificate was stored.
    /// </param>
    function CreateSelfSignedCertificate(const OutputfileName, Password, CommonName, Country,
      State, Locality, Organization, OrganizationalUnit, EmailAddress: WideString;
      KeySize: Integer; out Thumbprint, CertificateStore: WideString): WordBool; safecall;
  end;

/// <summary>
/// \Returns a global Server object. You can use this function to
/// manage all Server configuration, or create your own instance
/// of TServer. 
/// </summary>                                                   
function Server: TServer;

function CertificateUtils: TCertificateUtils;

/// <summary>
///   Returns the path where Thinfinity.VirtualUI.Settings.dll is located.
/// </summary>
function GetDllDir:string;

/// <summary>
/// Runs an application in elevated mode. This mode is required
/// to save the Server's configuration in protected files.
/// </summary>
/// <param name="filename">Full path of application to execute.
///                        </param>
/// <param name="Parameters">\Arguments. </param>
/// <example>
/// In the main program of the application using this classes,
/// you can include: <c> if ParamCount=0 then
/// RunAsAdmin(ParamStr(0), '/some_param') else begin
/// Application.Initialize; [...] </c> 
/// </example>
function RunAsAdmin(filename: string; Parameters: string): Boolean;

// Versions prior to D2009 don't include PNG classes. You can use
// third party alternatives to do the convertion routines PNG-BASE64.
{$IFDEF DELPHI2009_PLUS}
/// <summary>
///   Converts the IProfile.IconData (base64 string) to a PNG image.
/// </summary>
/// <param name="data">
///   The image encoded in base64.
/// </param>
{$IFDEF FMX}
function Base64ToIcon(AData: String): TBitmap;
{$ELSE}
function Base64ToIcon(AData: String): TPngImage;
{$ENDIF}

/// <summary>
///   Converts a PNG image to be stored in IProfile.IconData (as base64 string).
/// </summary>
/// <param name="png">
///   The image to be encoded in base64.
/// </param>
{$IFDEF FMX}
function IconToBase64(png: TBitmap): string;
{$ELSE}
function IconToBase64(png: TPngImage): string;
{$ENDIF}
{$ENDIF}

implementation

uses ComObj;

class function CoServer_.Create: IServer;
begin
  Result := CreateComObject(CLASS_Server_) as IServer;
end;

class function CoServer_.CreateRemote(const MachineName: string): IServer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Server_) as IServer;
end;

class function CoLicense.Create: ILicense;
begin
  Result := CreateComObject(CLASS_License) as ILicense;
end;

class function CoLicense.CreateRemote(const MachineName: string): ILicense;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_License) as ILicense;
end;

class function CoProfile.Create: IProfile;
begin
  Result := CreateComObject(CLASS_Profile) as IProfile;
end;

class function CoProfile.CreateRemote(const MachineName: string): IProfile;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Profile) as IProfile;
end;

class function CoProfiles.Create: IProfiles;
begin
  Result := CreateComObject(CLASS_Profiles) as IProfiles;
end;

class function CoProfiles.CreateRemote(const MachineName: string): IProfiles;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Profiles) as IProfiles;
end;

class function CoBinding.Create: IBinding;
begin
  Result := CreateComObject(CLASS_Binding) as IBinding;
end;

class function CoBinding.CreateRemote(const MachineName: string): IBinding;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Binding) as IBinding;
end;

class function CoBindings.Create: IBindings;
begin
  Result := CreateComObject(CLASS_Bindings) as IBindings;
end;

class function CoBindings.CreateRemote(const MachineName: string): IBindings;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Bindings) as IBindings;
end;

class function CoCertificate.Create: ICertificate;
begin
  Result := CreateComObject(CLASS_Certificate) as ICertificate;
end;

class function CoCertificate.CreateRemote(const MachineName: string): ICertificate;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Certificate) as ICertificate;
end;

class function CoAutoLogon.Create: IAutoLogon;
begin
  Result := CreateComObject(CLASS_AutoLogon) as IAutoLogon;
end;

class function CoAutoLogon.CreateRemote(const MachineName: string): IAutoLogon;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AutoLogon) as IAutoLogon;
end;

class function CoRDS.Create: IRDS;
begin
  Result := CreateComObject(CLASS_RDS) as IRDS;
end;

class function CoRDS.CreateRemote(const MachineName: string): IRDS;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RDS) as IRDS;
end;

class function CoRDSAccounts.Create: IRDSAccounts;
begin
  Result := CreateComObject(CLASS_RDSAccounts) as IRDSAccounts;
end;

class function CoRDSAccounts.CreateRemote(const MachineName: string): IRDSAccounts;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RDSAccounts) as IRDSAccounts;
end;

class function CoGateways.Create: IGateways;
begin
  Result := CreateComObject(CLASS_Gateways) as IGateways;
end;

class function CoGateways.CreateRemote(const MachineName: string): IGateways;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Gateways) as IGateways;
end;

class function CoBroker.Create: IBroker;
begin
  Result := CreateComObject(CLASS_Broker) as IBroker;
end;

class function CoBroker.CreateRemote(const MachineName: string): IBroker;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Broker) as IBroker;
end;

class function CoBrokers.Create: IBrokers;
begin
  Result := CreateComObject(CLASS_Brokers) as IBrokers;
end;

class function CoBrokers.CreateRemote(const MachineName: string): IBrokers;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Brokers) as IBrokers;
end;

class function CoUser.Create: IUser;
begin
  Result := CreateComObject(CLASS_User) as IUser;
end;

class function CoUser.CreateRemote(const MachineName: string): IUser;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_User) as IUser;
end;

class function CoUsers.Create: IUsers;
begin
  Result := CreateComObject(CLASS_Users) as IUsers;
end;

class function CoUsers.CreateRemote(const MachineName: string): IUsers;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Users) as IUsers;
end;

class function CoAuthentication.Create: IAuthentication;
begin
  Result := CreateComObject(CLASS_Authentication) as IAuthentication;
end;

class function CoAuthentication.CreateRemote(const MachineName: string): IAuthentication;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Authentication) as IAuthentication;
end;

class function CoSSOUser.Create: ISSOUser;
begin
  Result := CreateComObject(CLASS_SSOUser) as ISSOUser;
end;

class function CoSSOUser.CreateRemote(const MachineName: string): ISSOUser;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SSOUser) as ISSOUser;
end;

class function CoSSOUsers.Create: ISSOUsers;
begin
  Result := CreateComObject(CLASS_SSOUsers) as ISSOUsers;
end;

class function CoSSOUsers.CreateRemote(const MachineName: string): ISSOUsers;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SSOUsers) as ISSOUsers;
end;

class function CoAssociatedUserAccount.Create: IAssociatedUserAccount;
begin
  Result := CreateComObject(CLASS_AssociatedUserAccount) as IAssociatedUserAccount;
end;

class function CoAssociatedUserAccount.CreateRemote(const MachineName: string): IAssociatedUserAccount;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AssociatedUserAccount) as IAssociatedUserAccount;
end;

class function CoAssociatedUserAccounts.Create: IAssociatedUserAccounts;
begin
  Result := CreateComObject(CLASS_AssociatedUserAccounts) as IAssociatedUserAccounts;
end;

class function CoAssociatedUserAccounts.CreateRemote(const MachineName: string): IAssociatedUserAccounts;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AssociatedUserAccounts) as IAssociatedUserAccounts;
end;

class function CoAuthMethod.Create: IAuthMethod;
begin
  Result := CreateComObject(CLASS_AuthMethod) as IAuthMethod;
end;

class function CoAuthMethod.CreateRemote(const MachineName: string): IAuthMethod;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AuthMethod) as IAuthMethod;
end;

class function CoAuthMethods.Create: IAuthMethods;
begin
  Result := CreateComObject(CLASS_AuthMethods) as IAuthMethods;
end;

class function CoAuthMethods.CreateRemote(const MachineName: string): IAuthMethods;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AuthMethods) as IAuthMethods;
end;

class function CoAuthMethod2FA.Create: IAuthMethod2FA;
begin
  Result := CreateComObject(CLASS_AuthMethod2FA) as IAuthMethod2FA;
end;

class function CoAuthMethod2FA.CreateRemote(const MachineName: string): IAuthMethod2FA;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AuthMethod2FA) as IAuthMethod2FA;
end;

class function CoAuthMethods2FA.Create: IAuthMethods2FA;
begin
  Result := CreateComObject(CLASS_AuthMethods2FA) as IAuthMethods2FA;
end;

class function CoAuthMethods2FA.CreateRemote(const MachineName: string): IAuthMethods2FA;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AuthMethods2FA) as IAuthMethods2FA;
end;

class function CoStrList.Create: IStrList;
begin
  Result := CreateComObject(CLASS_StrList) as IStrList;
end;

class function CoStrList.CreateRemote(const MachineName: string): IStrList;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_StrList) as IStrList;
end;

class function CoIPListItem.Create: IIPListItem;
begin
  Result := CreateComObject(CLASS_IPListItem) as IIPListItem;
end;

class function CoIPListItem.CreateRemote(const MachineName: string): IIPListItem;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_IPListItem) as IIPListItem;
end;

class function CoIPList.Create: IIPList;
begin
  Result := CreateComObject(CLASS_IPList) as IIPList;
end;

class function CoIPList.CreateRemote(const MachineName: string): IIPList;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_IPList) as IIPList;
end;

class function CoBruteForceDetection.Create: IBruteForceDetection;
begin
  Result := CreateComObject(CLASS_BruteForceDetection) as IBruteForceDetection;
end;

class function CoBruteForceDetection.CreateRemote(const MachineName: string): IBruteForceDetection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BruteForceDetection) as IBruteForceDetection;
end;

class function CoCertificateUtils_.Create: ICertificateUtils;
begin
  Result := CreateComObject(CLASS_CertificateUtils_) as ICertificateUtils;
end;

class function CoCertificateUtils_.CreateRemote(const MachineName: string): ICertificateUtils;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CertificateUtils_) as ICertificateUtils;
end;

class function CoCertificateInfo.Create: ICertificateInfo;
begin
  Result := CreateComObject(CLASS_CertificateInfo) as ICertificateInfo;
end;

class function CoCertificateInfo.CreateRemote(const MachineName: string): ICertificateInfo;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CertificateInfo) as ICertificateInfo;
end;

class function CoCertificateInfoList.Create: ICertificateInfoList;
begin
  Result := CreateComObject(CLASS_CertificateInfoList) as ICertificateInfoList;
end;

class function CoCertificateInfoList.CreateRemote(const MachineName: string): ICertificateInfoList;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CertificateInfoList) as ICertificateInfoList;
end;

class function CoPath.Create: IPath;
begin
  Result := CreateComObject(CLASS_Path) as IPath;
end;

class function CoPath.CreateRemote(const MachineName: string): IPath;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Path) as IPath;
end;

var
  gCertificateUtils: TCertificateUtils;
  gServer: TServer;
  LibHandle: THandle;
  DllGetInstance: function(var Value: IServer):HResult; stdcall;
  DllCertUtilsGetInstance: function(var Value: ICertificateUtils):HResult; stdcall;

function GetDllDir: string;
var
  oem: string;
  reg: TRegistry;
  ini: TIniFile;
  k32, k64: string;
begin
  Result := '';
  k32 := '';
  k64 := '';
  oem := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) + 'OEM.ini';
  if FileExists(oem{$IFDEF DELPHIXE_PLUS}, False{$ENDIF}) then
  begin
    ini := TIniFile.Create(oem);
    try
      k32 := Trim(ini.ReadString('PATHS', 'Key32', ''));
      k64 := Trim(ini.ReadString('PATHS', 'Key64', ''));
    finally
      ini.Free;
    end;
  end;
  if k32 = '' then k32 := '\SOFTWARE\Wow6432Node\Cybele Software\Setups\Thinfinity\VirtualUI';
  if k64 = '' then k64 := '\SOFTWARE\Cybele Software\Setups\Thinfinity\VirtualUI';
  reg := TRegistry.Create(KEY_QUERY_VALUE or KEY_ENUMERATE_SUB_KEYS);
  try
    reg.RootKey:=HKEY_LOCAL_MACHINE;
    if reg.OpenKeyReadOnly(k32) or reg.OpenKeyReadOnly(k64) then
    begin
      {$IFDEF WIN32}
      if Reg.ValueExists('TargetDir_x86') then
        Result := IncludeTrailingPathDelimiter(reg.ReadString('TargetDir_x86'));
      {$ELSE}
      if Reg.ValueExists('TargetDir_x64') then
        Result := IncludeTrailingPathDelimiter(reg.ReadString('TargetDir_x64'));
      {$ENDIF}
    end
    else Result := ExtractFilePath(ParamStr(0));
  finally
    reg.Free;
  end;
end;

procedure LoadLib;
var
  Filename: string;
begin
 if LibHandle = 0 then
  begin
    Filename := 'Thinfinity.VirtualUI.Settings.dll';
    LibHandle := LoadLibrary(PChar(GetDllDir + Filename));
    if LibHandle = 0 then Exit;
    try
      @DllGetInstance := GetProcAddress(LibHandle, 'DllGetInstance');
      if @DllGetInstance = nil then RaiseLastOSError;
      @DllCertUtilsGetInstance := GetProcAddress(LibHandle, 'DllCertUtilsGetInstance');
    except
      FreeLibrary(LibHandle);
      LibHandle := 0;
      raise;
    end;
  end;
end;

function Server: TServer;
begin
  if not Assigned(gServer) then
    gServer := TServer.Create;
  Result := gServer;
end;

function CertificateUtils: TCertificateUtils;
begin
  if not Assigned(gCertificateUtils) then
    gCertificateUtils := TCertificateUtils.Create;
  Result := gCertificateUtils;
end;

function RunAsAdmin(filename: string; Parameters: string): Boolean;
var
  sei: TShellExecuteInfo;
begin
  ZeroMemory(@sei, SizeOf(sei));
  sei.cbSize := SizeOf(TShellExecuteInfo);
  sei.Wnd := GetDesktopWindow();
  sei.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
  sei.lpVerb := PChar('runas');
  sei.lpFile := PChar(Filename);
  if parameters <> '' then
    sei.lpParameters := PChar(parameters);
  sei.nShow := SW_SHOWNORMAL;
  {$IFDEF UNICODE}
  Result := ShellExecuteExW(@sei);
  {$ELSE}
  Result := ShellExecuteExA(@sei);
  {$ENDIF}
end;

const
  PNG_DATA_HEADER = 'data:image/png;base64,';

{$IFDEF DELPHI2009_PLUS} 
{$IFDEF FMX}
function Base64ToIcon(AData: String): TBitmap;
{$ELSE}
function Base64ToIcon(AData: String): TPngImage;
{$ENDIF}
var
  Input: TStringStream;
  Output: TBytesStream;
begin
  {$IFDEF FMX}
  Result := TBitmap.Create(0,0);
  {$ELSE}
  Result := TPngImage.Create;
  {$ENDIF}
  if AData = '' then
    Result.Assign(nil)
  else begin
    if SameText(copy(AData,1,length(PNG_DATA_HEADER)), PNG_DATA_HEADER) then
      Delete(AData,1,length(PNG_DATA_HEADER));
    Input := TStringStream.Create(AData, TEncoding.ASCII);
    Output := TBytesStream.Create;
    try
      DecodeStream(Input, Output);
      Output.Position := 0;
      Result.LoadFromStream(Output);
    finally
      Input.Free;
      Output.Free;
    end;
  end;
end;

{$IFDEF FMX}
function IconToBase64(png: TBitmap): string;
{$ELSE}
function IconToBase64(png: TPngImage): string;
{$ENDIF}
var
  Input: TBytesStream;
  Output: TStringStream;
begin
  Result := '';
  Input := TBytesStream.Create;
  try
    png.SaveToStream(Input);
    Input.Position := 0;
    Output := TStringStream.Create('', TEncoding.ASCII);
    try
      EncodeStream(Input, Output);
      Result := Output.DataString;
    finally
      Output.Free;
    end;
  finally
    Input.Free;
  end;
end;
{$ENDIF}

{ TServer }

constructor TServer.Create;
begin
  inherited;
  if Assigned(DllGetInstance) then
  begin
    DllGetInstance(FServer);
  end;
end;

destructor TServer.Destroy;
begin
  if gServer = Self then
    gServer := nil;
  inherited;
end;

function TServer.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  if Assigned(FServer) then
    Result := FServer.GetIDsOfNames(IID, Names, NameCount, LocaleID, DispIDs)
  else
    Result := E_NOTIMPL;
end;

function TServer.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  if Assigned(FServer) then
    Result := FServer.GetTypeInfo(Index, LocaleID, TypeInfo)
  else begin
    Result := E_NOTIMPL;
    Pointer(TypeInfo) := nil;
  end;
end;

function TServer.GetTypeInfoCount(out Count: Integer): HResult;
begin
  if Assigned(FServer) then
    Result := FServer.GetTypeInfoCount(Count)
  else begin
    Result := 0;
    Count := 0;
  end;
end;

function TServer.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
begin
  if Assigned(FServer) then
    Result := FServer.Invoke(DispID, IID, LocaleID, Flags, Params, VarResult, ExcepInfo, ArgErr)
  else
    Result := E_NOTIMPL;
end;

function TServer.Get_Authentication: IAuthentication;
begin
  Result := FServer.Authentication;
end;

function TServer.Get_Binding: IBinding;
begin
  Result := FServer.Binding;
end;

function TServer.Get_Bindings: IBindings;
begin
  Result := FServer.Bindings;
end;

function TServer.Get_Broker: IBroker;
begin
  Result := FServer.Broker;
end;

function TServer.Get_BruteForceDetection: IBruteForceDetection;
begin
  Result := FServer.BruteForceDetection;
end;

function TServer.Get_SecondaryBrokers: IBrokers;
begin
  Result := FServer.SecondaryBrokers;
end;

function TServer.Get_Certificate: ICertificate;
begin
  Result := FServer.Certificate;
end;

function TServer.Get_Gateways: IGateways;
begin
  Result := FServer.Gateways;
end;

function TServer.Get_License: ILicense;
begin
  Result := FServer.License;
end;

function TServer.Get_NetworkID: WideString;
begin
  Result := FServer.NetworkID;
end;

procedure TServer.Set_NetworkID(const Value: WideString);
begin
  FServer.NetworkID := Value;
end;

function TServer.Get_APIKey: WideString;
begin
  Result := FServer.APIKey;
end;

procedure TServer.Set_APIKey(const Value: WideString);
begin
  FServer.APIKey := Value;
end;

function TServer.Get_Profiles: IProfiles;
begin
  Result := FServer.Profiles;
end;

function TServer.Get_RDS: IRDS;
begin
  Result := FServer.RDS;
end;

function TServer.Get_RDSAccounts: IRDSAccounts;
begin
  Result := FServer.RDSAccounts;
end;

function TServer.Get_SetupMode: SetupMode;
begin
  Result := FServer.SetupMode;
end;

procedure TServer.Load;
begin
  if Assigned(FServer) then
    FServer.Load;
end;

procedure TServer.Save;
begin
  if Assigned(FServer) then
    FServer.Save;
end;

procedure TServer.HideSection(section: ServerSection);
begin
  if Assigned(FServer) then
    FServer.HideSection(section);
end;

procedure TServer.ShowSection(section: ServerSection);
begin
  if Assigned(FServer) then
    FServer.ShowSection(section);
end;

{ TCertificateUtils }

constructor TCertificateUtils.Create;
begin
  inherited;
  if Assigned(DllCertUtilsGetInstance) then
    DllCertUtilsGetInstance(FCertificateUtils)
  else
    raise ENotImplemented.Create('CertificateUtils');
end;

destructor TCertificateUtils.Destroy;
begin
  if gCertificateUtils = Self then
    gCertificateUtils := nil;
  inherited;
end;

function TCertificateUtils.GetCertificates: ICertificateInfoList;
begin
  Result := FCertificateUtils.GetCertificates;
end;

function TCertificateUtils.GetCertificateInfo(const CertificateStore, Thumbprint: WideString): ICertificateInfo;
begin
  Result := FCertificateUtils.GetCertificateInfo(CertificateStore, Thumbprint);
end;

function TCertificateUtils.ImportCertificate(const FileName,
  Password: WideString; out Thumbprint, CertificateStore: WideString): WordBool;
begin
  Result := FCertificateUtils.ImportCertificate(FileName, Password, Thumbprint, CertificateStore);
end;

function TCertificateUtils.CreateSelfSignedCertificate(const OutputfileName,
  Password, CommonName, Country, State, Locality, Organization,
  OrganizationalUnit, EmailAddress: WideString; KeySize: Integer;
  out Thumbprint, CertificateStore: WideString): WordBool;
begin
  Result := FCertificateUtils.CreateSelfSignedCertificate(OutputfileName,
      Password, CommonName, Country, State, Locality, Organization,
      OrganizationalUnit, EmailAddress, KeySize, Thumbprint, CertificateStore);
end;

function TCertificateUtils.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  if Assigned(FCertificateUtils) then
    Result := FCertificateUtils.GetIDsOfNames(IID, Names, NameCount, LocaleID, DispIDs)
  else
    Result := E_NOTIMPL;
end;

function TCertificateUtils.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  if Assigned(FCertificateUtils) then
    Result := FCertificateUtils.GetTypeInfo(Index, LocaleID, TypeInfo)
  else begin
    Result := E_NOTIMPL;
    Pointer(TypeInfo) := nil;
  end;
end;

function TCertificateUtils.GetTypeInfoCount(out Count: Integer): HResult;
begin
  if Assigned(FCertificateUtils) then
    Result := FCertificateUtils.GetTypeInfoCount(Count)
  else begin
    Result := 0;
    Count := 0;
  end;
end;

function TCertificateUtils.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
begin
  if Assigned(FCertificateUtils) then
    Result := FCertificateUtils.Invoke(DispID, IID, LocaleID, Flags, Params, VarResult, ExcepInfo, ArgErr)
  else
    Result := E_NOTIMPL;
end;

initialization
  LoadLib;
finalization
  FreeAndNil(gServer);
  FreeAndNil(gCertificateUtils);
end.
