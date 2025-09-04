object RpcInstallModule: TRpcInstallModule
  Tag = 1
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 227
  Width = 267
  object Client: TkbmMWSimpleClient
    Transport = ClientTransport
    ResponseAttributes.Strings = (
      '')
    Priority = 128
    Left = 48
    Top = 30
  end
  object ClientTransport: TkbmMWTCPIPIndyClientTransport
    IdleInterval = 0
    Active = False
    Port = 80
    Host = 'gestwinupdate.es'
    IPVersion = 4
    StreamFormat = 'ZIPPED'
    VerifyTransfer = False
    TransportStateOptions = []
    MaxRetries = 3
    MaxRetriesAlternative = 0
    RequestTimeout = 20
    MinClientPort = 0
    MaxClientPort = 0
    ConnectTimeout = 10
    StringConversion = mwscFixed
    Left = 136
    Top = 30
  end
  object UpdateServiceClient: TkbmMWFileClient
    Transport = ClientTransport
    Priority = 128
    FileService = 'UpdateService'
    FileServiceVersion = 'kbmMW_1.0'
    BlockSize = 32768
    AllowOverwrite = True
    KeepPartialFileOnCancel = False
    KeepPartialFileOnException = False
    OnProgress = UpdateServiceClientProgress
    Left = 48
    Top = 116
  end
end
