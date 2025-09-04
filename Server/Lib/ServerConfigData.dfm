object ServerConfigDataModule: TServerConfigDataModule
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 334
  Width = 359
  object ServerManager: TnxServerManager
    DisplayCategory = 'NONE'
    AutoSaveConfig = True
    LoginTries = 3
    MaxUserCount = -1
    ServerEngine = ServerEngine
    Left = 152
    Top = 46
  end
  object ServerEngine: TnxServerEngine
    DisplayName = 'Servidor'
    ServerName = 'Gestwin'
    Options = [seoCloseInactiveFolders, seoCloseInactiveTables]
    TableExtension = 'nx1'
    Left = 54
    Top = 48
  end
  object TCPIPv4Transport: TnxWinsockTransport
    DisplayName = 'TCP/IPv4'
    DisplayCategory = 'Transportes'
    EventLogEnabled = True
    Mode = nxtmListen
    RespondToBroadcasts = True
    ServerNameRuntime = 'Gestwin'
    ServerNameDesigntime = 'Gestwin'
    LostConnectionTimeout = 20000
    Left = 52
    Top = 122
  end
  object NamedPipeTransport: TnxNamedPipeTransport
    DisplayName = 'Windows (NP)'
    DisplayCategory = 'Transportes'
    EventLogEnabled = True
    Mode = nxtmListen
    RespondToBroadcasts = True
    ServerNameRuntime = 'Gestwin'
    LostConnectionTimeout = 20000
    Left = 50
    Top = 192
  end
end
