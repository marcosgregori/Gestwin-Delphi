object KbmRpcDataModule: TKbmRpcDataModule
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 348
  Width = 398
  object Client: TkbmMWSimpleClient
    Transport = ClientTransport
    ResponseAttributes.Strings = (
      '')
    Priority = 128
    Left = 48
    Top = 36
  end
  object ClientTransport: TkbmMWTCPIPIndyClientTransport
    IdleInterval = 0
    Active = False
    Port = 80
    Host = 'localhost'
    IPVersion = 4
    StreamFormat = 'STANDARD'
    VerifyTransfer = False
    TransportStateOptions = []
    MaxRetries = 0
    MaxRetriesAlternative = 0
    RequestTimeout = 20
    MinClientPort = 0
    MaxClientPort = 0
    ConnectTimeout = 10
    StringConversion = mwscFixed
    Left = 166
    Top = 36
  end
  object FileClient: TkbmMWFileClient
    Transport = ClientTransport
    Priority = 128
    FileService = 'FileService'
    FileServiceVersion = 'kbmMW_1.0'
    BlockSize = 32768
    AllowOverwrite = True
    KeepPartialFileOnCancel = False
    KeepPartialFileOnException = False
    OnProgress = FileClientProgress
    Left = 48
    Top = 108
  end
  object NexusDBClientTransport: TkbmMWNexusDBClientTransport
    Left = 276
    Top = 36
  end
  object ClientConnectionPool: TkbmMWClientConnectionPool
    Transport = ClientTransport
    Left = 164
    Top = 110
  end
  object EnterprisePooledSession: TkbmMWPooledSession
    ConnectionPool = ClientConnectionPool
    AutoSessionName = False
    SessionName = 'ENTERPRISESESSION'
    Left = 160
    Top = 270
  end
  object MainPooledSession: TkbmMWPooledSession
    ConnectionPool = ClientConnectionPool
    AutoSessionName = False
    SessionName = 'MAINSESSION'
    Left = 162
    Top = 187
  end
  object BinaryStreamFormat: TkbmMWBinaryStreamFormat
    Version = '4.94'
    sfLargeFields = []
    sfCalculated = []
    sfLookup = []
    LargeFieldSize = 0
    sfDisplayWidth = []
    Left = 280
    Top = 110
  end
end
