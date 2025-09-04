object dmServer: TdmServer
  OnCreate = DataModuleCreate
  Height = 546
  Width = 664
  object Server: TnxServerManager
    DisplayCategory = 'NONE'
    AutoSaveConfig = False
    LoginTries = 3
    MaxUserCount = -1
    ServerEngine = ServerEngine
    SQLEngine = SqlEngine
    Left = 72
    Top = 24
  end
  object ServerEngine: TnxServerEngine
    DisplayName = 'Servidor'
    DisplayCategory = 'Base de datos'
    EventLog = EventLog
    OnStateChanged = ServerEngineStateChanged
    SqlEngine = SqlEngine
    ServerName = 'Gestwin'
    Options = [seoCloseInactiveFolders, seoCloseInactiveTables, seoCloseAllWhenInactive]
    TableExtension = 'nx1'
    Left = 72
    Top = 91
  end
  object SqlEngine: TnxSqlEngine
    DisplayName = 'SQL'
    DisplayCategory = 'NONE'
    EventLog = EventLog
    OnStateChanged = SqlEngineStateChanged
    StmtLogging = False
    StmtLogTableName = 'QueryLog'
    UseFieldCache = False
    Left = 180
    Top = 91
  end
  object ServerCommandHandler: TnxServerCommandHandler
    DisplayCategory = 'NONE'
    EventLog = EventLog
    ServerEngine = ServerEngine
    Left = 532
    Top = 30
  end
  object TCPIPv4Transport: TnxWinsockTransport
    DisplayName = 'Transporte TCP/IPv4'
    DisplayCategory = 'Base de datos'
    EventLog = EventLog
    CommandHandler = ServerCommandHandler
    Mode = nxtmListen
    RespondToBroadcasts = True
    ServerNameRuntime = 'Gestwin'
    ServerNameDesigntime = 'Gestwin'
    CompressType = 11
    LostConnectionTimeout = 20000
    Left = 312
    Top = 24
  end
  object EventLog: TnxEventLog
    DisplayName = 'Diario de eventos'
    DisplayCategory = 'NONE'
    OnSettingsLoaded = EventLogSettingsLoaded
    Enabled = True
    NumRotations = 0
    RotationSize = 32
    MaxSize = 200
    Left = 532
    Top = 245
  end
  object SecurityMonitor: TnxSecurityMonitor
    DisplayName = 'Usuarios'
    DisplayCategory = 'NONE'
    EventLog = EventLog
    EventLogEnabled = True
    ServerEngine = ServerEngine
    MaxSessionCount = -1
    AlwaysLoginAdmins = False
    Left = 528
    Top = 311
  end
  object ServerInfoPluginCommandHandler: TnxServerInfoPluginCommandHandler
    DisplayName = 'Informaci'#243'n del servidor'
    DisplayCategory = 'NONE'
    EventLog = EventLog
    CommandHandler = ServerCommandHandler
    PluginEngine = ServerInfoPlugin
    Left = 210
    Top = 399
  end
  object ServerInfoPlugin: TnxServerInfoPlugin
    DisplayName = 'Informaci'#243'n del servidor'
    DisplayCategory = 'NONE'
    EventLog = EventLog
    Left = 72
    Top = 400
  end
  object SecuredCommandHandler: TnxSecuredCommandHandler
    DisplayCategory = 'NONE'
    EventLog = EventLog
    Left = 72
    Top = 278
  end
  object RemotingServer: TnxRemotingServer
    DisplayName = 'Servidor RPC'
    DisplayCategory = 'NONE'
    Left = 72
    Top = 460
  end
  object RemotingCommandHandler: TnxRemotingCommandHandler
    DisplayCategory = 'NONE'
    CommandHandler = ServerCommandHandler
    PluginEngine = RemotingServer
    Left = 208
    Top = 462
  end
  object SimpleMonitor: TnxSimpleMonitor
    DisplayName = 'Monitor'
    DisplayCategory = 'NONE'
    EventLogEnabled = True
    ServerEngine = ServerEngine
    AttachTo = []
    Left = 526
    Top = 452
  end
  object NamedPipeTransport: TnxNamedPipeTransport
    DisplayName = 'Transporte Windows (NP)'
    DisplayCategory = 'Base de datos'
    EventLog = EventLog
    CommandHandler = ServerCommandHandler
    Mode = nxtmListen
    RespondToBroadcasts = True
    ServerNameRuntime = 'Gestwin'
    CompressType = 11
    LostConnectionTimeout = 20000
    Left = 310
    Top = 94
  end
end
