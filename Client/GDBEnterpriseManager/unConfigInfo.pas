{##############################################################################}
{# NexusDB Enterprise Manager: unConfigInfo.pas 4.7001                       #}
{# Copyright (c) Nexus Database 2003-2023                                     #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB Enterprise Manager: Persistently Stored Configuration Info         #}
{##############################################################################}

{$I nxemDefine.inc}

unit unConfigInfo;

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF},
  Forms,
  SysUtils,
  Grids,
  DB,
  DBGrids,
  INIFiles,
  Classes,
  System.Generics.Collections,

  nxllTypes,
  nxptBasePooledTransport;

const
  {$IFDEF UseRegistryConfig}
  cfgRootKey                            = HKEY_CURRENT_USER;
  {$ENDIF}
  cfgSavedMonitorWidth                  = 'SQLSavedMonitorWidth';
  cfgSavedMonitorHeight                 = 'SQLSavedMonitorHeight';
  cfgKeyOptions                         = 'Options';
  cfgServerWindowWidth                  = 'ServerWindowWidth';
  cfgKeyRegisteredTcpIpServers          = 'Registered TcpIp Servers';
  cfgKeyRegisteredNamedPipeServers      = 'Registered NamedPipe Servers';
  cfgKeyRegisteredHttpServers           = 'Registered Http Servers';
  cfgHttpClientIgnoreUnknownCA          = 'ClientIgnoreUnknownCA';
  cfgHttpClientIgnoreCertDateInvalid    = 'ClientIgnoreCertDateInvalid';
  cfgHttpClientIgnoreCertCNInvalid      = 'ClientIgnoreCertCNInvalid';
  cfgHttpClientIgnoreCertWrongUsage     = 'ClientIgnoreCertWrongUsage';
  cfgShowBrowser                        = 'Show Browser';
  cfgReadOnlyDatasets                   = 'ReadOnly Datasets';
  cfgDefaultTimeout                     = 'Default Timeout';
  cfgOptimisticRecordlocks              = 'OptimisticRecordlocks';
  cfgBackupDatabase                     = 'BackupDatabase';
  cfgRestoreDatabase                    = 'RestoreDatabase';
  cfgKeepaliveFrequency                 = 'KeepaliveFrequency';
  cfgRecNoSupport                       = 'RecNoSupport';
  cfgLastServer                         = 'LastServer';
  cfgSortAvailIndexFields               = 'Available Index Fields Sorted';
  cfgKeyRuntimeLoadedPackages           = 'Runtime Loaded Packages';
  cfgSkinName                           = 'Skin Name';
  cfgNativeLook                         = 'Native Look';
  cfgDisplayMilliseconds                = 'Display Milliseconds';
  cfgTabsOnTop                          = 'TabsOnTop';
  cfgUseUnicodeGrid                     = 'UseUnicodeGrid';
  cfgBroadcastForServers                = 'BroadcastForServers';
  cfgReloadLastSql                      = 'ReloadLastSql';
  cfgSimplePassword                     = 'SimplePassword';
  cfgAllowCloseInactive                 = 'AllowCloseInactive';
  cfgUseLongTabDescription              = 'UseLongTabDescription';
  cfgNewTableDefaultRecordEngine        = 'NewTableDefaultRecordEngine';
  cfgNewTableDefaultCompressionEngine   = 'NewTableDefaultCompressionEngine';
  cfgNewTableDefaultCompressionLevel    = 'NewTableDefaultCompressionLevel';
  cfgNewTableDefaultEncryptionEngine    = 'NewTableDefaultEncryptionEngine';
  cfgNewTableDefaultIndexEngine         = 'NewTableDefaultIndexEngine';
  cfgAutoTreeRefresh                    = 'AutoTreeRefresh';
  cfgUseLargeToolbarGlyphs              = 'UseLargeToolbarGlyphs';
  cfgLastUpdateCheck                    = 'LastUpdateCheck';
  cfgLastUpdateVersion                  = 'LastUpdateVersion';
  cfgFontName                           = 'FontName';
  cfgFontSize                           = 'FontSize';
  cfgKeyServerConnectionParams          = 'Server Connection Params';
  cfgOriginalWidth                      = 'Original Width';
  cfgOriginalHeight                     = 'Original Height';

  nxeRegistrySubKey                     = '\EnterpriseManager';

  defWindowState                        = wsNormal;
  defcfgShowBrowser                     = True;
  defcfgReadOnlyDatasets                = False;
  defcfgSortAvailIndexFields            = True;

type
  TnxeConfigOptions = set of (coShowBrowser, coReadOnlyDatasets);

  TnxCertIgnoreRecord = record
    ClientIgnoreUnknownCA,
    ClientIgnoreCertDateInvalid,
    ClientIgnoreCertCNInvalid,
    ClientIgnoreCertWrongUsage      : Boolean;
  end;

  TnxeConfig = class(TPersistent)
  protected {private}
    FLastServer                     : string;
    FSortAvailIndexFields           : Boolean;
    FServerWindowWidth              : Integer;
    FOptions                        : TnxeConfigOptions;
    FRegisteredTcpIpServers,
    FRegisteredNamedPipeServers,
    FRegisteredHttpServers          : TStrings;
    FHttpCertIgnore                 : TDictionary<string, TnxCertIgnoreRecord>; //one per Http server
    FINIFilename                    : TFileName;
    {$IFDEF UseRegistryConfig}
    FRegistryKey                    : string;
    {$ENDIF}
    FDefaultTimeout                 : Integer;
      { default timeout for all operations unless overriden in
        table- or sqlwindows etc }
    FWorkingDirectory               : String;
      { the current dir upon startup
        (from the "start in" shortcut setting) }
    FOptimisticRecordlocks           : Boolean;
    FKeepaliveFrequency              : Integer;
    FRecNoSupport                    : Boolean;
    FRuntimeLoadedPackages           : TStrings;
    FSkinName                        : string;
    FDisplayMilliseconds             : Boolean;
    FTabsOnTop                       : Boolean;
    FUsePlainGrid                    : Boolean;
    FBroadcastForServers             : Boolean;
    fReloadLastSql                   : Boolean;
    fSimplePassword                  : string;
    fAllowCloseInactive              : Boolean;
    fUseLongTabDescription           : Boolean;
    fNewTableDefaultRecordEngine     : string;
    fNewTableDefaultCompressionEngine: string;
    fNewTableDefaultCompressionLevel : Integer;
    fNewTableDefaultEncryptionEngine : string;
    fNewTableDefaultIndexEngine      : string;
    fAutoTreeRefresh                 : Boolean;
    fUseLargeToolbarGlyphs           : Boolean;
    fLastUpdateCheck                 : TDateTime;
    fLastUpdateVersion               : string;
    fFontName                        : string;
    fFontSize                        : Integer;
    fServerConnectionParams          : TStrings;
    fOriginalWidth,
    fOriginalHeight                  : Integer;

    cIniFile                         : TMemIniFile;
  protected
    procedure SetLastServer(const aValue : string);
    procedure SetDefaultTimeout(const Value: Integer);

    function GetCertIgnoreRecord(Idx : string): TnxCertIgnoreRecord;
    procedure SetCertIgnoreRecord(Idx : string; Value: TnxCertIgnoreRecord);
  published
  public
    constructor Create;
    destructor Destroy; override;
    procedure Refresh;
    procedure Save;
    property LastServer : string
      read FLastServer write SetLastServer;

    property INIFilename : TFileName
      read FINIFilename;

    property Options: TnxeConfigOptions
      read FOptions write FOptions;

    property RegisteredTcpIpServers: TStrings
      read FRegisteredTcpIpServers write FRegisteredTcpIpServers;

    property RegisteredNamedPipeServers: TStrings
      read FRegisteredNamedPipeServers write FRegisteredNamedPipeServers;

    property RegisteredHttpServers: TStrings
      read FRegisteredHttpServers write FRegisteredHttpServers;

    property HttpServerCertIgnore[Idx : string]: TnxCertIgnoreRecord
      read GetCertIgnoreRecord write SetCertIgnoreRecord;

    property SortAvailIndexFields : Boolean
      read FSortAvailIndexFields write FSortAvailIndexFields;

    property ServerWindowWidth: Integer
      read FServerWindowWidth write FServerWindowWidth;

    property DefaultTimeout: Integer read FDefaultTimeout write SetDefaultTimeout;

    property WorkingDirectory: String read FWorkingDirectory;

    property OptimisticRecordlocks: Boolean read FOptimisticRecordlocks write FOptimisticRecordlocks;

    property KeepaliveFrequency: Integer read FKeepaliveFrequency write FKeepaliveFrequency;

    property RecNoSupport : Boolean read FRecNoSupport write FRecNoSupport;

    property RuntimeLoadedPackages : TStrings
      read FRuntimeLoadedPackages write FRuntimeLoadedPackages;

    property SkinName : string
      read FSkinName write FSkinName;

    property TabsOnTop : Boolean
      read fTabsOnTop write fTabsOntop;

    property DisplayMilliseconds : Boolean
      read FDisplayMilliseconds write FDisplayMilliseconds;

    property UsePlainGrid : Boolean
      read FUsePlainGrid write FUsePlainGrid;

    property BroadcastForServers : Boolean
      read FBroadcastForServers write FBroadcastForServers;

    property ReloadLastSql : Boolean
      read fReloadLastSql write fReloadLastSql;

    property SimplePassword : string
      read fSimplePassword write fSimplePassword;

    property AllowCloseInactive : Boolean
      read fAllowCloseInactive write fAllowCloseInactive;

    property UseLongTabDescription : Boolean
      read fUseLongTabDescription write fUseLongTabDescription;

    property NewTableDefaultRecordEngine : string
      read fNewTableDefaultRecordEngine write fNewTableDefaultRecordEngine;

    property NewTableDefaultCompressionEngine : string
      read fNewTableDefaultCompressionEngine write fNewTableDefaultCompressionEngine;

    property NewTableDefaultCompressionLevel : integer
      read fNewTableDefaultCompressionLevel write fNewTableDefaultCompressionLevel;

    property NewTableDefaultEncryptionEngine : string
      read fNewTableDefaultEncryptionEngine write fNewTableDefaultEncryptionEngine;

    property NewTableDefaultIndexEngine : string
      read fNewTableDefaultIndexEngine write fNewTableDefaultIndexEngine;

    property AutoTreeRefresh : Boolean
      read fAutoTreeRefresh write fAutoTreeRefresh;

    property UseLargeToolbarGlyphs : Boolean
      read fUseLargeToolbarGlyphs write fUseLargeToolbarGlyphs;

    property LastUpdateCheck : TDateTime
      read fLastUpdateCheck write fLastUpdateCheck;

    property LastUpdateVersion : string
      read fLastUpdateVersion write fLastUpdateVersion;

    property FontName : string
      read fFontName write fFontName;

    property FontSize : Integer
      read fFontSize write fFontSize;

    property ServerConnectionParams : TStrings
      read FServerConnectionParams write FServerConnectionParams;

    property OriginalWidth : Integer
      read fOriginalWidth write fOriginalWidth;

    property OriginalHeight : Integer
      read fOriginalHeight write fOriginalHeight;

    property IniFile : TMemIniFile
      read cIniFile;
  end;

  procedure nxeConfigSaveFormPrefs(const Section : string; Form : TForm);
  procedure nxeConfigGetFormPrefs(const Section : string; Form : TForm);
  procedure nxeConfigSaveString(const Section, Ident, Value : string);
  function nxeConfigGetString(const Section, Ident, Default : string) : string;
  procedure nxeConfigSaveInteger(const Section, Ident : string; Value : Integer);
  function nxeConfigGetInteger(const Section, Ident : string; Default : Integer) : Integer;
  procedure nxeConfigSaveBoolean(const Section, Ident : string; Value : Boolean);
  function nxeConfigGetBoolean(const Section, Ident : string; Default : Boolean) : Boolean;
  procedure nxeConfigSaveDBColumnPrefs(const Section : string; Columns : TDBGridColumns);
  procedure nxeConfigGetDBColumnWidths(const Section : string; Columns : TDBGridColumns);
  procedure nxeConfigGetDBColumnPrefs(const Section : string; Columns : TDBGridColumns);
  procedure nxeConfigSaveColumnPrefs(const Section : string; Grid : TStringGrid);
  procedure nxeConfigGetColumnPrefs(const Section : string; Grid : TStringGrid);
  procedure nxeConfigSaveKeysAndValues(const Section : string; Strings : TStringList);
  procedure nxeConfigGetKeysAndValues(const Section : string; Strings : TStringList);
  function nxeConfigGetConnectionProperties(aServername : string; out aCompressionType, aCompressionLimit : Integer) : Boolean;
  procedure nxeConfigSetConnectionProperties(aServername : string; const aCompressionType, aCompressionLimit : Integer);

  function MulFactor(aOld, aNew : Integer) : Double;
  function ReverseString(s : string) : string;


var
  Config : TnxeConfig;

implementation

uses
  {$IFDEF UseRegistryConfig}
  Registry,
  {$ENDIF}
  {$IFDEF UseINIConfig}
  Dialogs,
  {$ENDIF}
  nxllException,
  nxdbBase,
  nxllConst,
  nxllUtils,
  nxdb,
  nxExeConst;


resourcestring
  rsErrorWritingINIFile = 'Error writing INI file: ';

var
  IsReadOnly : Boolean;

function MulFactor(aOld, aNew : Integer) : Double;
begin
  Result := 1.0;
  if (aOld <> 0) and (aNew <> 0) then
    Result := aNew / aOld;
end;

{------------------------------------------------------------------------------}
function ReverseString(s : string) : string;
var
  i : Integer;
begin
  Result := '';
  for i := Length(s) downto 1 do
    Result := Result + s[i];
end;
{------------------------------------------------------------------------------}
procedure nxeConfigSaveFormPrefs(const Section : string; Form : TForm);
var
  Placement : TWindowPlacement;
begin
  if IsReadOnly then
    Exit;
  Placement.length :=SizeOf(TWindowPlacement);
  if not GetWindowPlacement(Form.Handle, @Placement) then
    Exit;
  with Placement do begin
    Config.IniFile.WriteInteger(Section, 'Flags', Flags);
    Config.IniFile.WriteInteger(Section, 'ShowCmd', ShowCmd);
    Config.IniFile.WriteInteger(Section, 'Left', rcNormalPosition.Left);
    Config.IniFile.WriteInteger(Section, 'Top', rcNormalPosition.Top);
    Config.IniFile.WriteInteger(Section, 'Right', rcNormalPosition.Right);
    Config.IniFile.WriteInteger(Section, 'Bottom', rcNormalPosition.Bottom);
    Config.IniFile.WriteInteger(Section, 'ptMinPosition.X', ptMinPosition.X);
    Config.IniFile.WriteInteger(Section, 'ptMinPosition.Y', ptMinPosition.Y);
    Config.IniFile.WriteInteger(Section, 'ptMaxPosition.X', ptMaxPosition.X);
    Config.IniFile.WriteInteger(Section, 'ptMaxPosition.Y', ptMaxPosition.Y);
    Config.IniFile.WriteInteger(Section, 'OriginalWidth', Screen.MonitorFromWindow(Form.Handle).Width);
    Config.IniFile.WriteInteger(Section, 'OriginalHeight', Screen.MonitorFromWindow(Form.Handle).Height);
  End;
end;
{------------------------------------------------------------------------------}
procedure nxeConfigGetFormPrefs(const Section : string; Form : TForm);
var
  Placement      : TWindowPlacement;
  WidthFactor,
  HeightFactor   : Double;
  NormalPosition : TRect;
begin
  NormalPosition.Left := Config.IniFile.ReadInteger(Section, 'Left', Form.Left);
  NormalPosition.Top := Config.IniFile.ReadInteger(Section, 'Top', Form.Top);
  NormalPosition.Right := Config.IniFile.ReadInteger(Section, 'Right', Form.Left+Form.Width);
  NormalPosition.Bottom := Config.IniFile.ReadInteger(Section, 'Bottom', Form.Top+Form.Height);
  WidthFactor := MulFactor(Config.IniFile.ReadInteger(Section, 'OriginalWidth', Screen.MonitorFromRect(NormalPosition).Width), Screen.MonitorFromRect(NormalPosition).Width);
  HeightFactor := MulFactor(Config.IniFile.ReadInteger(Section, 'OriginalHeight', Screen.MonitorFromRect(NormalPosition).Height), Screen.MonitorFromRect(NormalPosition).Height);
  with Placement do begin
    FillChar(Placement, SizeOf(TWindowPlacement), 0);
    length := SizeOf(TWindowPlacement);
    Flags := Config.IniFile.ReadInteger(Section, 'Flags', 0);
    ShowCmd := Config.IniFile.ReadInteger(Section, 'ShowCmd', SW_SHOW);
    if ShowCmd = SW_SHOWMINIMIZED then
	    ShowCmd := SW_SHOW;
	  rcNormalPosition.Left := Trunc(WidthFactor * Config.IniFile.ReadInteger(Section, 'Left', Form.Left));
    rcNormalPosition.Top := Trunc(HeightFactor * Config.IniFile.ReadInteger(Section, 'Top', Form.Top));
    rcNormalPosition.Right := Trunc(WidthFactor * Config.IniFile.ReadInteger(Section, 'Right', Form.Left+Form.Width));
    rcNormalPosition.Bottom := Trunc(HeightFactor * Config.IniFile.ReadInteger(Section, 'Bottom', Form.Top+Form.Height));
    ptMinPosition.X := Config.IniFile.ReadInteger(Section, 'ptMinPosition.X', 0);
    ptMinPosition.Y := Config.IniFile.ReadInteger(Section, 'ptMinPosition.Y', 0);
    ptMaxPosition.X := Config.IniFile.ReadInteger(Section, 'ptMaxPosition.X', 0);
    ptMaxPosition.Y := Config.IniFile.ReadInteger(Section, 'ptMaxPosition.Y', 0);
    IF Assigned(Screen.MonitorFromRect(Placement.rcNormalPosition, mdNull)) THEN
      SetWindowPlacement(Form.Handle, @Placement)
  end;
end;
{------------------------------------------------------------------------------}
procedure nxeConfigSaveString(const Section, Ident, Value : string);
begin
  if IsReadOnly then
    Exit;
  Config.IniFile.WriteString(Section, Ident, Value);
end;
{------------------------------------------------------------------------------}
function nxeConfigGetString(const Section, Ident, Default : string) : string;
begin
  Result := Config.IniFile.ReadString(Section, Ident, Default);
end;
{------------------------------------------------------------------------------}
procedure nxeConfigSaveInteger(const Section, Ident : string; Value : Integer);
begin
  if IsReadOnly then
    Exit;
  Config.IniFile.WriteInteger(Section, Ident, Value);
end;
{------------------------------------------------------------------------------}
function nxeConfigGetInteger(const Section, Ident : string; Default : Integer) : Integer;
begin
  Result := Config.IniFile.ReadInteger(Section, Ident, Default);
end;
{------------------------------------------------------------------------------}
procedure nxeConfigSaveBoolean(const Section, Ident : string; Value : Boolean);
begin
  if IsReadOnly then
    Exit;
  Config.IniFile.WriteBool(Section, Ident, Value);
end;
{------------------------------------------------------------------------------}
function nxeConfigGetBoolean(const Section, Ident : string; Default : Boolean) : Boolean;
begin
  Result :=   Config.IniFile.ReadBool(Section, Ident, Default);
end;
{------------------------------------------------------------------------------}
procedure nxeConfigSaveDBColumnPrefs(const Section : string; Columns : TDBGridColumns);
var
  Idx : Integer;
begin
  if IsReadOnly then
    Exit;
  Config.IniFile.EraseSection(Section);
  for Idx := 0 to Pred(Columns.Count) do
    nxeConfigSaveString(Section, Columns[Idx].FieldName, IntToStr(Columns[Idx].Width));
end;
{------------------------------------------------------------------------------}
procedure nxeConfigGetDBColumnPrefs(const Section : string; Columns : TDBGridColumns);
var
  Idx : Integer;
  Col : TColumn;
  ColumnInfo : TStringList;
  Dataset : TDataSet;
begin
  if Columns.Grid.FieldCount = 0 then Exit;

  Dataset := Columns.Grid.Fields[0].DataSet;
  ColumnInfo := TStringList.Create;
  try
    ColumnInfo.Sorted := False;
    Config.IniFile.ReadSection(Section, ColumnInfo);
    { if there are new columns in the dataset, don't use stored column
      settings, otherwise the new columns end up to the far right. }
    for Idx := 0 to Pred(Dataset.FieldCount) do
      if ColumnInfo.IndexOf(Dataset.Fields[Idx].FieldName)<0 then begin
        Columns.RebuildColumns;
        Exit;
      end;
    Columns.BeginUpdate;
    try
      Columns.Clear;
      for Idx := 0 to Pred(ColumnInfo.Count) do begin
        if (Dataset.FindField(ColumnInfo[Idx]) <> nil) then begin
          Col := Columns.Add;
          Col.FieldName := ColumnInfo[Idx];
          Col.Width := nxeConfigGetInteger(Section, Col.FieldName, Col.Width);
        end;
      end;
      for Idx := 0 to Pred(Dataset.FieldCount) do begin
        if (ColumnInfo.IndexOf(Dataset.Fields[Idx].FieldName) = -1) then begin
          Col := Columns.Add;
          Col.FieldName := Dataset.Fields[Idx].FieldName;
        end;
      end;
    finally
      Columns.EndUpdate;
    end;
  finally
    ColumnInfo.Free;
  end;
end;
{------------------------------------------------------------------------------}
procedure nxeConfigGetDBColumnWidths(const Section : string; Columns : TDBGridColumns);
var
  ColIdx,
  Idx : Integer;
  ColumnInfo : TStringList;
begin
  if Columns.Grid.FieldCount = 0 then Exit;

  ColumnInfo := TStringList.Create;
  try
    ColumnInfo.Sorted := False;
    Config.IniFile.ReadSection(Section, ColumnInfo);
    Columns.BeginUpdate;
    try
      for Idx := 0 to Pred(ColumnInfo.Count) do begin
        for ColIdx := 0 to Pred(Columns.Count) do
          if ColumnInfo[Idx]=Columns[ColIdx].FieldName then begin
            Columns[ColIdx].Width := nxeConfigGetInteger(Section, Columns[ColIdx].FieldName, Columns[ColIdx].Width);
            Break;
          end;
      end;
    finally
      Columns.EndUpdate;
    end;
  finally
    ColumnInfo.Free;
  end;
end;
{------------------------------------------------------------------------------}
procedure nxeConfigSaveColumnPrefs(const Section : string; Grid : TStringGrid);
var
  Idx : Integer;
begin
  if IsReadOnly then
    Exit;
  for Idx := 0 to Pred(Grid.ColCount) do
    nxeConfigSaveInteger(Section, IntToStr(Idx), Grid.ColWidths[Idx]);
end;
{------------------------------------------------------------------------------}
procedure nxeConfigGetColumnPrefs(const Section : string; Grid : TStringGrid);
var
  Idx : Integer;
begin
  for Idx := 0 to Pred(Grid.ColCount) do
    Grid.ColWidths[Idx] := nxeConfigGetInteger(Section, IntToStr(Idx), Grid.ColWidths[Idx]);
end;
{------------------------------------------------------------------------------}
procedure nxeConfigSaveKeysAndValues(const Section : string; Strings : TStringList);
var
  Idx : Integer;
begin
  Config.IniFile.EraseSection(Section);
  for Idx := 0 to Pred(Strings.Count) do
    Config.IniFile.WriteString(Section, Strings.Names[Idx], Strings.Values[Strings.Names[Idx]]);
end;
{------------------------------------------------------------------------------}
procedure nxeConfigGetKeysAndValues(const Section : string; Strings : TStringList);
var
  Idx : Integer;
begin
  Config.IniFile.ReadSection(Section, Strings);
  for Idx := 0 to Pred(Strings.Count) do
    Strings[Idx] := Strings[Idx]+'='+Config.IniFile.ReadString(Section, Strings[Idx], '');
end;
{------------------------------------------------------------------------------}
function nxeConfigGetConnectionProperties(aServername : string; out aCompressionType, aCompressionLimit : Integer) : Boolean;
var
  sl : TStringList;
begin
  Result := False;
  aCompressionType := 0;
  aCompressionLimit := 0;
  sl := TStringList.Create;
  try
    sl.Sorted := False;
    // eg NexusDB@192.168.0.666=11,1024
    sl.CommaText := Config.fServerConnectionParams.Values[aServername];
    if sl.Count >= 2 then begin
      aCompressionType := sl[0].ToInteger;
      aCompressionLimit := sl[1].ToInteger;
      Result := True;
    end;
  finally
    sl.Free;
  end;
end;
{------------------------------------------------------------------------------}
procedure nxeConfigSetConnectionProperties(aServername : string; const aCompressionType, aCompressionLimit : Integer);
begin
  if Config.fServerConnectionParams.IndexOfName(aServername) >= 0 then
    Config.fServerConnectionParams.Values[aServername] := aCompressionType.ToString + ',' + aCompressionLimit.ToString
  else
    Config.fServerConnectionParams.AddPair(aServername, aCompressionType.ToString + ',' + aCompressionLimit.ToString);
end;
{------------------------------------------------------------------------------}
constructor TnxeConfig.Create;
begin
  FWorkingDirectory := nxAppHomeDirectory(nxAppDataSubdirVista);

  FINIFilename := FWorkingDirectory + ChangeFileExt(ExtractFileName(Application.ExeName), '.INI');
  cIniFile := TMemIniFile.Create(FINIFilename);
  {$IFDEF UseRegistryConfig}
  FRegistryKey := nxccREG_PRODUCT + nxeRegistrySubKey;
  {$ENDIF}
  FRegisteredTcpIpServers := TStringList.Create;
  FRegisteredNamedPipeServers := TStringList.Create;
  FRegisteredHttpServers := TStringList.Create;
  FHttpCertIgnore := TDictionary<string, TnxCertIgnoreRecord>.Create;
  FRuntimeLoadedPackages := TStringList.Create;
  fServerConnectionParams := TStringList.Create;
  Refresh;
end;
{------------------------------------------------------------------------------}
destructor TnxeConfig.Destroy;
begin
  FRegisteredTcpIpServers.Free;
  FRegisteredNamedPipeServers.Free;
  FRegisteredHttpServers.Free;
  FHttpCertIgnore.Free;
  FRuntimeLoadedPackages.Free;
  fServerConnectionParams.Free;
  cIniFile.UpdateFile;
  cIniFile.Free;
  inherited;
end;

function TnxeConfig.GetCertIgnoreRecord(Idx : string): TnxCertIgnoreRecord;
begin
  Result := FHttpCertIgnore[Idx];
end;

{------------------------------------------------------------------------------}
procedure TnxeConfig.Refresh;
var
  i      : Integer;
{$IFDEF UseINIConfig}
  Window : TnxShStr;
{$ENDIF}
begin
  FOptions := [];
  {$IFDEF UseINIConfig}
  with TMemINIFile.Create(FINIFilename) do
  try
    FServerWindowWidth := ReadInteger(cfgKeyOptions, cfgServerWindowWidth, 250);

    if ReadBool(cfgKeyOptions, cfgShowBrowser, defcfgShowBrowser) then
      Include(FOptions, coShowBrowser);

    if ReadBool(cfgKeyOptions, cfgReadOnlyDatasets, defcfgReadOnlyDatasets) then
      Include(FOptions, coReadOnlyDatasets);

    FSortAvailIndexFields := ReadBool(cfgKeyOptions, cfgSortAvailIndexFields, defcfgSortAvailIndexFields);

    ReadSection(cfgKeyRegisteredTcpIpServers, FRegisteredTcpIpServers);

    ReadSection(cfgKeyRegisteredNamedPipeServers, FRegisteredNamedPipeServers);

    ReadSection(cfgKeyRegisteredHttpServers, FRegisteredHttpServers);

    {TODO -oarray -cGeneral : ActionItem}

    FDefaultTimeout := ReadInteger(cfgKeyOptions, cfgDefaultTimeout, nxDefaultTimeOut);

    FOptimisticRecordlocks := ReadBool(cfgKeyOptions, cfgOptimisticRecordlocks, False);

    FKeepaliveFrequency := {$IFDEF DEBUGNOHEARTBEAT}0{$ELSE}ReadInteger(cfgKeyOptions, cfgKeepaliveFrequency, nxDefaultHeartbeatInterval){$ENDIF};

    FRecNoSupport := ReadBool(cfgKeyOptions, cfgRecNoSupport, False);

    ReadSection(cfgKeyRuntimeLoadedPackages, FRuntimeLoadedPackages);

    FSkinName := ReadString(cfgKeyOptions, cfgSkinName, 'DevExpressStyle'); //default = no previous setting

    FDisplayMilliseconds := ReadBool(cfgKeyOptions, cfgDisplayMilliseconds, True);

    fTabsOnTop := ReadBool(cfgKeyOptions, cfgTabsOnTop, false);

    FUseUnicodeGrid := ReadBool(cfgKeyOptions, cfgUseUnicodeGrid, false);

    FBroadcastForServers := ReadBool(cfgKeyOptions, cfgBroadcastForServers, True);

    fReloadLastSql := ReadBool(cfgKeyOptions, cfgReloadLastSql, True);

    fCancelableQuery := ReadBool(cfgKeyOptions, cfgCancelableQuery, False);

    fLowPriorityAfter := ReadInteger(cfgKeyOptions, cfgLowPriorityAfter, 0);

    fSimplePassword := ReverseString(ReadString(cfgKeyOptions, cfgSimplePassword, ''));

    fAllowCloseInactive := ReadBool(cfgKeyOptions, cfgAllowCloseInactive, False);

    fUseLongTabDescription := ReadBool(cfgKeyOptions, cfgUseLongTabDescription, False);

    fNewTableDefaultRecordEngine := ReadString(cfgKeyOptions, cfgNewTableDefaultRecordEngine, 'Variable');

    fNewTableDefaultCompressionEngine := ReadString(cfgKeyOptions, cfgNewTableDefaultCompressionEngine, 'Compressor');

    fNewTableDefaultCompressionLevel := ReadInteger(cfgKeyOptions, cfgNewTableDefaultCompressionLevel, 11);

    fNewTableDefaultEncryptionEngine := ReadString(cfgKeyOptions, cfgNewTableDefaultEncryptionEngine, '');

    fNewTableDefaultIndexEngine := ReadString(cfgKeyOptions, cfgNewTableDefaultIndexEngine, '');

    fAutoTreeRefresh := ReadBool(cfgKeyOptions, cfgAutoTreeRefresh, True);

    fUseLargeToolbarGlyphs := ReadBool(cfgKeyOptions, cfgUseLargeToolbarGlyphs, False);

    fLastUpdateCheck := ReadDateTime(cfgKeyOptions, cfgLastUpdateCheck, EncodeDate(2000, 01, 01));

    fLastUpdateVersion := ReadString(cfgKeyOptions, cfgLastUpdateVersion, '');

    fFontName := ReadString(cfgKeyOptions, cfgFontName, 'Segoe UI');

    fFontSize := ReadInteger(cfgKeyOptions, cfgFontSize, 9); //..

    ReadSection(cfgKeyServerConnectionParams, fServerConnectionParams);

    fOriginalHeight := ReadInteger(cfgKeyOptions, cfgOriginalHeight, 0);

    fOriginalWidth := ReadInteger(cfgKeyOptions, cfgOriginalWidth, 0);

    UpdateFile;
  finally
    Free;
  end;
  {$ENDIF}

  {$IFDEF UseRegistryConfig}
  with TRegistry.Create do
  try

    { set defaults }
    if defcfgShowBrowser then
      Include(FOptions, coShowBrowser);
    if defcfgReadOnlyDatasets then
      Include(FOptions, coReadOnlyDatasets);
    FSortAvailIndexFields := defcfgSortAvailIndexFields;

    { set and open the main key }
    RootKey := cfgRootKey;
    if KeyExists(FRegistryKey + '\' + cfgKeyOptions) then
    OpenKey(FRegistryKey + '\' + cfgKeyOptions, False);

    { get the window size, position }
    FServerWindowWidth := 250;
    if ValueExists(cfgServerWindowWidth) then
      FServerWindowWidth := ReadInteger(cfgServerWindowWidth);

    if ValueExists(cfgShowBrowser) then
      if ReadBool(cfgShowBrowser) then
        Include(FOptions, coShowBrowser)
      else
        Exclude(FOptions, coShowBrowser);

    if ValueExists(cfgReadOnlyDatasets) then
      if ReadBool(cfgReadOnlyDatasets) then
        Include(FOptions, coReadOnlyDatasets)
      else
        Exclude(FOptions, coReadOnlyDatasets);

    if ValueExists(cfgSortAvailIndexFields) then
      FSortAvailIndexFields := ReadBool(cfgSortAvailIndexFields);

    if ValueExists(cfgLastServer) then
      FLastServer := ReadString(cfgLastServer);

    FDefaultTimeout := nxDefaultTimeOut;
    if ValueExists(cfgDefaultTimeout) then
      FDefaultTimeout := ReadInteger(cfgDefaultTimeout);

    FOptimisticRecordlocks := False;
    if ValueExists(cfgOptimisticRecordlocks) then
      FOptimisticRecordlocks := ReadBool(cfgOptimisticRecordlocks);

    FKeepaliveFrequency := {$IFDEF DEBUGNOHEARTBEAT}0{$ELSE}nxDefaultHeartbeatInterval{$ENDIF};
    if ValueExists(cfgKeepaliveFrequency) then
      FKeepaliveFrequency := {$IFDEF DEBUGNOHEARTBEAT}0{$ELSE}ReadInteger(cfgKeepaliveFrequency){$ENDIF};

    FRecNoSupport := False;
    if ValueExists(cfgRecNoSupport) then
      FRecNoSupport := ReadBool(cfgRecNoSupport);

    FSkinName := 'DevExpressStyle'; //default = no previous setting
    if ValueExists(cfgSkinName) then
      FSkinName := ReadString(cfgSkinName);

    FDisplayMilliseconds := True;
    if ValueExists(cfgDisplayMilliseconds) then
      FDisplayMilliseconds := ReadBool(cfgDisplayMilliseconds);

    FTabsOnTop := false;
    if ValueExists(cfgTabsOnTop) then
      FTabsOnTop := ReadBool(cfgTabsOnTop);

    FUsePlainGrid := false;
    if ValueExists(cfgUseUnicodeGrid) then
      FUsePlainGrid := ReadBool(cfgUseUnicodeGrid);

    FBroadcastForServers := True;
    if ValueExists(cfgBroadcastForServers) then
      FBroadcastForServers := ReadBool(cfgBroadcastForServers);

    FReloadLastSql := True;
    if ValueExists(cfgReloadLastSql) then
      FReloadLastSql := ReadBool(cfgReloadLastSql);

    fSimplePassword := '';
    if ValueExists(cfgSimplePassword) then
      fSimplePassword := ReverseString(ReadString(cfgSimplePassword));

    fAllowCloseInactive := False;
    if ValueExists(cfgAllowCloseInactive) then
      fAllowCloseInactive := ReadBool(cfgAllowCloseInactive);

    fUseLongTabDescription := False;
    if ValueExists(cfgUseLongTabDescription) then
      fUseLongTabDescription := ReadBool(cfgUseLongTabDescription);

    fNewTableDefaultRecordEngine := 'Variable';
    if ValueExists(cfgNewTableDefaultRecordEngine) then
      fNewTableDefaultRecordEngine := ReadString(cfgNewTableDefaultRecordEngine);

    fNewTableDefaultCompressionEngine := 'Compressor';
    if ValueExists(cfgNewTableDefaultCompressionEngine) then
      fNewTableDefaultCompressionEngine := ReadString(cfgNewTableDefaultCompressionEngine);

    fNewTableDefaultCompressionLevel := 11;
    if ValueExists(cfgNewTableDefaultCompressionLevel) then
      fNewTableDefaultCompressionLevel := ReadInteger(cfgNewTableDefaultCompressionLevel);

    fNewTableDefaultEncryptionEngine := '';
    if ValueExists(cfgNewTableDefaultEncryptionEngine) then
      fNewTableDefaultEncryptionEngine := ReadString(cfgNewTableDefaultEncryptionEngine);

    fNewTableDefaultIndexEngine := '';
    if ValueExists(cfgNewTableDefaultIndexEngine) then
      fNewTableDefaultIndexEngine := ReadString(cfgNewTableDefaultIndexEngine);

    fAutoTreeRefresh := True;
    if ValueExists(cfgAutoTreeRefresh) then
      fAutoTreeRefresh := ReadBool(cfgAutoTreeRefresh);

    fUseLargeToolbarGlyphs := True;
    if ValueExists(cfgUseLargeToolbarGlyphs) then
      fUseLargeToolbarGlyphs := ReadBool(cfgUseLargeToolbarGlyphs);

    fLastUpdateCheck := EncodeDate(2000, 01, 01);
    if ValueExists(cfgLastUpdateCheck) then
      fLastUpdateCheck := ReadDateTime(cfgLastUpdateCheck);

    fLastUpdateVersion := '';
    if ValueExists(cfgLastUpdateVersion) then
      fLastUpdateVersion := ReadString(cfgLastUpdateVersion);

    fFontName := '';
    if ValueExists(cfgFontName) then
      fFontName := ReadString(cfgFontName);

    fFontSize := 9;
    if ValueExists(cfgFontSize) then
      fFontSize := ReadInteger(cfgFontSize);

    if ValueExists(cfgOriginalHeight) then
      fOriginalHeight := ReadInteger(cfgOriginalHeight);

    if ValueExists(cfgOriginalWidth) then
      fOriginalWidth := ReadInteger(cfgOriginalWidth);

   //only place subkeys after this point, simple options go above

    OpenKey(FRegistryKey + '\' + cfgKeyRegisteredTcpIpServers, False);
    GetKeyNames(FRegisteredTcpIpServers);

    OpenKey(FRegistryKey + '\' + cfgKeyRegisteredNamedPipeServers, False);
    GetKeyNames(FRegisteredNamedPipeServers);

    OpenKey(FRegistryKey + '\' + cfgKeyRegisteredHttpServers, False);
    GetKeyNames(FRegisteredHttpServers);

    var Values : TStringList := TStringList.Create;
    FHttpCertIgnore.Clear;

    for i := 0 to Pred(FRegisteredHttpServers.Count) do begin
      OpenKey(FRegistryKey + '\' + cfgKeyRegisteredHttpServers + '\' + FRegisteredHttpServers[i], False);
      var IgnoreRec := Default(TnxCertIgnoreRecord);
      GetValueNames(Values);
      for var j := 0 to Pred(Values.Count) do begin
        if Values[j] = cfgHttpClientIgnoreUnknownCA then
          IgnoreRec.ClientIgnoreUnknownCA := ReadBool(cfgHttpClientIgnoreUnknownCA);
        if Values[j] = cfgHttpClientIgnoreCertDateInvalid then
          IgnoreRec.ClientIgnoreCertDateInvalid := ReadBool(cfgHttpClientIgnoreCertDateInvalid);
        if Values[j] = cfgHttpClientIgnoreCertCNInvalid then
          IgnoreRec.ClientIgnoreCertCNInvalid := ReadBool(cfgHttpClientIgnoreCertCNInvalid);
        if Values[j] = cfgHttpClientIgnoreCertWrongUsage then
          IgnoreRec.ClientIgnoreCertWrongUsage := ReadBool(cfgHttpClientIgnoreCertWrongUsage);
      end;
      FHttpCertIgnore.Add(FRegisteredHttpServers[i], IgnoreRec);
    end;

    OpenKey(FRegistryKey + '\' + cfgKeyRuntimeLoadedPackages, False);
    i := 0;
    while ValueExists(IntToStr(i)) do begin
      FRuntimeLoadedPackages.Add(ReadString(IntToStr(i)));
      Inc(i);
    end;

    OpenKey(FRegistryKey + '\' + cfgKeyServerConnectionParams, False);
    GetKeyNames(fServerConnectionParams);

  finally
    Free;
  end;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
procedure TnxeConfig.Save;
var
  I: Integer;
begin
  {$IFDEF UseINIConfig}
  with TMemINIFile.Create(FINIFilename) do
  try
    try
      { Main window stuff }
      WriteInteger(cfgKeyOptions, cfgServerWindowWidth, FServerWindowWidth);

      { Options }
      WriteBool(cfgKeyOptions, cfgShowBrowser, (coShowBrowser in FOptions));
      WriteBool(cfgKeyOptions, cfgReadOnlyDatasets, (coReadOnlyDatasets in FOptions));
      WriteBool(cfgKeyOptions, cfgSortAvailIndexFields, FSortAvailIndexFields);
      WriteInteger(cfgKeyOptions, cfgDefaultTimeout, FDefaultTimeout);
      WriteBool(cfgKeyOptions, cfgOptimisticRecordlocks, FOptimisticRecordlocks);
      WriteInteger(cfgKeyOptions, cfgKeepaliveFrequency, FKeepaliveFrequency);
      WriteBool(cfgKeyOptions, cfgRecNoSupport, FRecNoSupport);

      { Registered Servers }
      EraseSection(cfgKeyRegisteredTcpIpServers);
      with FRegisteredTcpIpServers do
        for I := 0 to Count - 1 do
          WriteString(cfgKeyRegisteredTcpIpServers, Strings[I], '');

      EraseSection(cfgKeyRegisteredNamedPipeServers);
      with FRegisteredNamedPipeServers do
        for I := 0 to Count - 1 do
          WriteString(cfgKeyRegisteredNamedPipeServers, Strings[I], '');

      EraseSection(cfgKeyRegisteredHttpServers);
      with FRegisteredHttpServers do
        for I := 0 to Count - 1 do
          WriteString(cfgKeyRegisteredHttpServers, Strings[I], '');

      {TODO -oARRAY -cGeneral : ActionItem}

      EraseSection(cfgKeyRuntimeLoadedPackages);
      with FRuntimeLoadedPackages do
        for I := 0 to Count - 1 do
          WriteString(cfgKeyRuntimeLoadedPackages, Strings[I], '');

      EraseSection(cfgKeyServerConnectionParams);
      with fServerConnectionParams do
        for i := 0 to Count - 1 do
          WriteString(cfgKeyServerConnectionParams, Strings[i], '');

      WriteString(cfgKeyOptions, cfgSkinName, FSkinName);

      WriteBool(cfgKeyOptions, cfgDisplayMilliseconds, FDisplayMilliseconds);

      WriteBool(cfgKeyOptions, cfgTabsOnTop, FTabsOnTop);

      WriteBool(cfgKeyOptions, cfgUseUnicodeGrid, FUseUnicodeGrid);

      WriteBool(cfgKeyOptions, cfgBroadcastForServers, FBroadcastForServers);

      WriteBool(cfgKeyOptions, cfgReloadLastSql, FReloadLastSql);

      WriteString(cfgKeyOptions, cfgSimplePassword, ReverseString(SimplePassword));

      WriteBool(cfgKeyOptions, cfgAllowCloseInactive, fAllowCloseInactive);

      WriteBool(cfgKeyOptions, cfgUseLongTabDescription, fUseLongTabDescription);

      WriteString(cfgKeyOptions, cfgNewTableDefaultRecordEngine, fNewTableDefaultRecordEngine);

      WriteString(cfgKeyOptions, cfgNewTableDefaultCompressionEngine, fNewTableDefaultCompressionEngine);

      WriteString(cfgKeyOptions, cfgNewTableDefaultCompressionLevel, fNewTableDefaultCompressionLevel);

      WriteString(cfgKeyOptions, cfgNewTableDefaultEncryptionEngine, fNewTableDefaultEncryptionEngine);

      WriteString(cfgKeyOptions, cfgNewTableDefaultIndexEngine, fNewTableDefaultIndexEngine);

      WriteString(cfgKeyOptions, cfgAutoTreeRefresh, fAutoTreeRefresh);

      WriteBool(cfgKeyOptions, cfgUseLargeToolbarGlyphs, fUseLargeToolbarGlyphs);

      WriteDateTime(cfgKeyOptions, cfgLastUpdateCheck, fLastUpdateCheck);

      WriteString(cfgKeyOptions, cfgLastUpdateVersion, fLastUpdateVersion);

      WriteString(cfgKeyOptions, cfgFontName, fFontName);

      WriteInteger(cfgKeyOptions, cfgFontSize, fFontSize);

      WriteInteger(cfgKeyOptions, cfgOriginalHeight, fOriginalHeight);

      WriteInteger(cfgKeyOptions, cfgOriginalWidth, fOriginalWidth);

      UpdateFile;
    finally
      Free;
    end;
  except
    on E:Exception do
      ShowMessage(rsErrorWritingINIFile + E.Message);
  end;
  {$ENDIF}
  {$IFDEF UseRegistryConfig}
  if (FRegistryKey <> '') and (FRegistryKey[1] = '\') then begin
    with TRegistry.Create do
    try
      RootKey := cfgRootKey;

      {delete the options key and all that's in it}
      DeleteKey(FRegistryKey + '\' + cfgKeyOptions);

      {create the options key afresh, make it the current key}
      OpenKey(FRegistryKey + '\' + cfgKeyOptions, True);

      {write out all the config info}

      { Window coordinates }
      WriteInteger(cfgServerWindowWidth, FServerWindowWidth);

      { Options }
      WriteBool(cfgShowBrowser, (coShowBrowser in FOptions));
      WriteBool(cfgReadOnlyDatasets, (coReadOnlyDatasets in FOptions));
      WriteBool(cfgSortAvailIndexFields, FSortAvailIndexFields);
      WriteInteger(cfgDefaultTimeout, FDefaultTimeout);
      WriteBool(cfgOptimisticRecordlocks, FOptimisticRecordlocks);
      WriteInteger(cfgKeepaliveFrequency, FKeepaliveFrequency);
      WriteBool(cfgRecNoSupport, FRecNoSupport);
      WriteString(cfgSkinName, FSkinName);
      WriteBool(cfgDisplayMilliseconds, FDisplayMilliseconds);
      WriteBool(cfgTabsOnTop, FTabsOnTop);
      WriteBool(cfgUseUnicodeGrid, FUsePlainGrid);
      WriteBool(cfgBroadcastForServers, FBroadcastForServers);
      WriteBool(cfgReloadLastSql, FReloadLastSql);
      WriteString(cfgSimplePassword, ReverseString(FSimplePassword));
      WriteBool(cfgAllowCloseInactive, fAllowCloseInactive);
      WriteBool(cfgUseLongTabDescription, fUseLongTabDescription);
      WriteString(cfgNewTableDefaultRecordEngine, fNewTableDefaultRecordEngine);
      WriteString(cfgNewTableDefaultCompressionEngine, fNewTableDefaultCompressionEngine);
      WriteInteger(cfgNewTableDefaultCompressionLevel, fNewTableDefaultCompressionLevel);
      WriteString(cfgNewTableDefaultEncryptionEngine, fNewTableDefaultEncryptionEngine);
      WriteString(cfgNewTableDefaultIndexEngine, fNewTableDefaultIndexEngine);
      WriteBool(cfgAutoTreeRefresh, fAutoTreeRefresh);
      WriteBool(cfgUseLargeToolbarGlyphs, fUseLargeToolbarGlyphs);
      WriteDateTime(cfgLastUpdateCheck, fLastUpdateCheck);
      WriteString(cfgLastUpdateVersion, fLastUpdateVersion);
      WriteString(cfgFontName, fFontName);
      WriteInteger(cfgFontSize, fFontSize);
      WriteInteger(cfgOriginalHeight, fOriginalHeight);
      WriteInteger(cfgOriginalWidth, fOriginalWidth);

      { Last server }
      WriteString(cfgLastServer, FLastServer);

      { Registered Servers }
      DeleteKey(FRegistryKey + '\' + cfgKeyRegisteredTcpIpServers);
      CreateKey(FRegistryKey + '\' + cfgKeyRegisteredTcpIpServers);
      with FRegisteredTcpIpServers do
        for I := 0 to Count - 1 do
          CreateKey(FRegistryKey + '\' + cfgKeyRegisteredTcpIpServers + '\' + Strings[I]);

      DeleteKey(FRegistryKey + '\' + cfgKeyRegisteredNamedPipeServers);
      CreateKey(FRegistryKey + '\' + cfgKeyRegisteredNamedPipeServers);
      with FRegisteredNamedPipeServers do
        for I := 0 to Count - 1 do
          CreateKey(FRegistryKey + '\' + cfgKeyRegisteredNamedPipeServers + '\' + Strings[I]);

      DeleteKey(FRegistryKey + '\' + cfgKeyRegisteredHttpServers);
      CreateKey(FRegistryKey + '\' + cfgKeyRegisteredHttpServers);
      with FRegisteredHttpServers do
        for I := 0 to Count - 1 do begin
          OpenKey(FRegistryKey + '\' + cfgKeyRegisteredHttpServers + '\' + Strings[I], True);
          if not FHttpCertIgnore.ContainsKey(Strings[I]) then
            FHttpCertIgnore.Add(Strings[I], Default(TnxCertIgnoreRecord));
          WriteBool(cfgHttpClientIgnoreUnknownCA, FHttpCertIgnore[Strings[I]].ClientIgnoreUnknownCA);
          WriteBool(cfgHttpClientIgnoreCertDateInvalid, FHttpCertIgnore[Strings[I]].ClientIgnoreCertDateInvalid);
          WriteBool(cfgHttpClientIgnoreCertCNInvalid, FHttpCertIgnore[Strings[I]].ClientIgnoreCertCNInvalid);
          WriteBool(cfgHttpClientIgnoreCertWrongUsage, FHttpCertIgnore[Strings[I]].ClientIgnoreCertWrongUsage);
        end;

      DeleteKey(FRegistryKey + '\' + cfgKeyRuntimeLoadedPackages);
      OpenKey(FRegistryKey + '\' + cfgKeyRuntimeLoadedPackages, True);
      with FRuntimeLoadedPackages do
        for I := 0 to Count - 1 do
          WriteString(IntToStr(i), Strings[I]);

      DeleteKey(FRegistryKey + '\' + cfgKeyServerConnectionParams);
      CreateKey(FRegistryKey + '\' + cfgKeyServerConnectionParams);
      with fServerConnectionParams do
        for i := 0 to Count - 1 do
          CreateKey(FRegistryKey + '\' + cfgKeyServerConnectionParams + '\' + Strings[i]);

    finally
      Free;
    end;
  end;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
procedure TnxeConfig.SetCertIgnoreRecord(Idx : string; Value: TnxCertIgnoreRecord);
begin
  FHttpCertIgnore[Idx] := Value;
end;

procedure TnxeConfig.SetDefaultTimeout(const Value: Integer);
begin
  FDefaultTimeout := Value;
end;
{------------------------------------------------------------------------------}
procedure TnxeConfig.SetLastServer(const aValue : string);
begin
  if FLastServer <> aValue then
    FLastServer := aValue;
end;
{------------------------------------------------------------------------------}


initialization
  Config := TnxeConfig.Create;
  if FileExists(Config.FINIFilename) then
    IsReadOnly := (FileGetAttr(Config.FINIFilename) and
                   SysUtils.faReadOnly) <> 0
  else
    IsReadOnly := False;
finalization
  if assigned(Config) then
    FreeAndNil(Config);
end.

