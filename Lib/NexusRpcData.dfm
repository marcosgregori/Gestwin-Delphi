object NexusRpcDataModule: TNexusRpcDataModule
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 229
  Width = 425
  PixelsPerInch = 120
  object RemotingClient: TnxRemotingClient
    DisplayCategory = 'Plugins'
    Session = RemoteSimpleSession
    Left = 178
    Top = 33
  end
  object RemoteSimpleSession: TnxSimpleSession
    Transport = NamedPipeTransport
    Timeout = 60000
    Left = 303
    Top = 35
  end
  object WinsockTransport: TnxWinsockTransport
    DisplayCategory = 'Transports'
    EventLogOptions = [nxtpLogErrors, nxtpLogRequests, nxtpLogReplies]
    Timeout = 60000
    ServerNameRuntime = 'gestwin@localhost'
    ServerNameDesigntime = 'gestwin@localhost'
    WatchdogInterval = 30000
    LostConnectionTimeout = 60000
    OverlappedClient = True
    CallbackThreadCount = 2
    Left = 50
    Top = 30
  end
  object NamedPipeTransport: TnxNamedPipeTransport
    DisplayCategory = 'Transports'
    Timeout = 60000
    ServerNameRuntime = 'Gestwin'
    ServerNameDesigntime = 'Gestwin'
    WatchdogInterval = 30000
    LostConnectionTimeout = 60000
    OverlappedClient = True
    CallbackThreadCount = 2
    Left = 50
    Top = 123
  end
end
