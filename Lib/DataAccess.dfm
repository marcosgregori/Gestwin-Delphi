object DataAccessModule: TDataAccessModule
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 569
  Width = 313
  object MainSession: TnxSession
    ServerEngine = RemoteServerEngine
    Left = 55
    Top = 24
  end
  object WinsockTransport: TnxWinsockTransport
    DisplayCategory = 'Transports'
    ServerNameRuntime = 'gestwin@localhost'
    ServerNameDesigntime = 'gestwin@localhost'
    CompressType = 11
    LostConnectionTimeout = 20000
    Left = 54
    Top = 152
  end
  object RemoteServerEngine: TnxRemoteServerEngine
    Transport = NamedPipeTransport
    RemoteThreadPriority = ABOVE_NORMAL
    Left = 56
    Top = 83
  end
  object AppDatabase: TnxeDatabase
    Session = MainSession
    AliasPath = 'F:\Desktop\Gestwin\data'
    Updatable = True
    Left = 196
    Top = 230
  end
  object DatabaseInfoTable: TnxeTable
    Database = AppDatabase
    Timeout = 6000
    TableName = '_DBI'
    IndexFieldNames = 'MajorVersion;MinorVersion;Release;Build'
    TableType = ttRecover
    Left = 196
    Top = 292
  end
  object LocalSession: TnxSession
    ActiveRuntime = True
    OnStateChanged = LocalSessionStateChanged
    UserName = 'LocalSession'
    ServerEngine = LocalServerEngine
    Left = 56
    Top = 350
  end
  object LocalServerEngine: TnxServerEngine
    ActiveRuntime = True
    SqlEngine = LocalSqlEngine
    ServerName = 'Gestwin'
    Options = [seoCloseInactiveFolders, seoCloseInactiveTables, seoCloseAllWhenInactive]
    TableExtension = 'nx1'
    Left = 56
    Top = 416
  end
  object LocalSqlEngine: TnxSqlEngine
    ActiveRuntime = True
    ActiveDesigntime = True
    StmtLogging = False
    StmtLogTableName = 'QueryLog'
    UseFieldCache = False
    Left = 56
    Top = 480
  end
  object RemoteServerInfoPlugin: TnxRemoteServerInfoPlugin
    DisplayCategory = 'Plugins'
    Session = MainSession
    Left = 194
    Top = 486
  end
  object NamedPipeTransport: TnxNamedPipeTransport
    DisplayCategory = 'Transports'
    ServerNameRuntime = 'Gestwin'
    ServerNameDesigntime = 'Gestwin'
    CompressType = 11
    LostConnectionTimeout = 20000
    Left = 56
    Top = 222
  end
  object SessionPool: TnxSessionPool
    ServerEngine = RemoteServerEngine
    Left = 198
    Top = 26
  end
end
