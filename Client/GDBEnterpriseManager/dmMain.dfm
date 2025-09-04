object dmEM: TdmEM
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 402
  Width = 656
  object nxSessionInMemOnly: TnxSession
    ActiveRuntime = True
    ServerEngine = nxServerEngineEM
    Left = 160
    Top = 32
  end
  object dbEMSystem: TnxDatabase
    Session = nxSessionEMSystem
    Left = 544
    Top = 88
  end
  object dbInMemOnly: TnxDatabase
    ActiveRuntime = True
    Session = nxSessionInMemOnly
    AliasPath = '#InMemOnly'
    Left = 160
    Top = 88
  end
  object nxServerEngineInternalServer: TnxServerEngine
    ActiveRuntime = True
    OnStateChanged = nxServerEngineInternalServerStateChanged
    SqlEngine = nxSqlEngineInternalServer
    ServerName = ''
    Options = []
    TableExtension = 'nx1'
    Left = 408
    Top = 32
  end
  object nxSqlEngineInternalServer: TnxSqlEngine
    ActiveRuntime = True
    ActiveDesigntime = True
    StmtLogging = False
    StmtLogTableName = 'QueryLog'
    UseFieldCache = False
    Left = 408
    Top = 88
  end
  object nxSessionEMSystem: TnxSession
    ActiveRuntime = True
    ServerEngine = nxServerEngineInternalServer
    Left = 544
    Top = 32
  end
  object taSQLLog: TnxTable
    Database = dbEMSystem
    TableName = 'SQLLog'
    Left = 544
    Top = 152
    object taSQLLogID: TUnsignedAutoIncField
      FieldName = 'ID'
    end
    object taSQLLogRunAt: TDateTimeField
      FieldName = 'RunAt'
    end
    object taSQLLogServerName: TWideStringField
      FieldName = 'ServerName'
      Size = 200
    end
    object taSQLLogDatabaseName: TWideStringField
      FieldName = 'DatabaseName'
      Size = 200
    end
    object taSQLLogSQL: TWideMemoField
      FieldName = 'SQL'
      BlobType = ftWideMemo
    end
    object taSQLLogSessionID: TGuidField
      FieldName = 'SessionID'
      Size = 38
    end
    object taSQLLogRunTime: TLongWordField
      FieldName = 'RunTime'
    end
  end
  object nxServerEngineEM: TnxServerEngine
    ActiveRuntime = True
    MaxRAM = 100
    SqlEngine = nxSqlEngineEM
    ServerName = ''
    Options = []
    TableExtension = 'nx1'
    Left = 56
    Top = 32
  end
  object nxSqlEngineEM: TnxSqlEngine
    ActiveRuntime = True
    StmtLogging = False
    StmtLogTableName = 'QueryLog'
    UseFieldCache = False
    Left = 56
    Top = 88
  end
  object nxSqlTriggerMonitorInternalServer: TnxSqlTriggerMonitor
    DisplayName = 'SQL Triggers'
    DisplayCategory = 'SQL Engine'
    ServerEngine = nxServerEngineInternalServer
    SqlEngine = nxSqlEngineInternalServer
    Left = 408
    Top = 152
  end
end
