object ServerContainerModule: TServerContainerModule
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 264
  Width = 657
  object CloneDatabase: TnxDatabase
    Session = SessionTarget
    Left = 412
    Top = 90
  end
  object OriginalDatabase: TnxDatabase
    Session = SessionSource
    Left = 198
    Top = 90
  end
  object SessionSource: TnxSession
    ServerEngine = RemoteServerEngineSource
    Left = 68
    Top = 22
  end
  object RemoteServerEngineSource: TnxRemoteServerEngine
    Transport = SourceTransport
    Left = 68
    Top = 90
  end
  object BackupController: TnxBackupController
    OriginalDatabase = OriginalDatabase
    CloneDatabase = CloneDatabase
    KeepIndexes = True
    Options = [bcoCloseInactiveOnSource, bcoCloseInactiveOnTarget]
    SourceThreadPriority = NORMAL
    TargetThreadPriority = NORMAL
    SkippedTablesCount = 0
    UseLZCompression = False
    RemoveEncryption = False
    Left = 305
    Top = 90
  end
  object SessionTarget: TnxSession
    ServerEngine = RemoteServerEngineTarget
    Left = 536
    Top = 30
  end
  object RemoteServerEngineTarget: TnxRemoteServerEngine
    Transport = TargetTransport
    Left = 536
    Top = 90
  end
  object SourceTransport: TnxNamedPipeTransport
    DisplayCategory = 'Transports'
    ServerNameRuntime = 'Gestwin'
    ServerNameDesigntime = 'Gestwin'
    Left = 68
    Top = 160
  end
  object TargetTransport: TnxNamedPipeTransport
    DisplayCategory = 'Transports'
    ServerNameRuntime = 'Gestwin'
    ServerNameDesigntime = 'Gestwin'
    Left = 536
    Top = 160
  end
end
