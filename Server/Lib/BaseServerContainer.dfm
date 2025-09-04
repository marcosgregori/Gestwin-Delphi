object BaseServerContainerModule: TBaseServerContainerModule
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 307
  Width = 633
  object ServerTransport: TkbmMWTCPIPIndyServerTransport
    Server = Server
    Enabled = False
    Bindings = <
      item
        IP = '0.0.0.0'
        Port = 80
        ReuseSocket = rsTrue
      end>
    StreamFormat = 'STANDARD'
    VerifyTransfer = False
    TransportStateOptions = []
    StringConversion = mwscFixed
    KeepAliveTimeOut = 0
    KeepAliveInterval = 0
    Left = 219
    Top = 49
  end
  object FilePool: TkbmMWFilePool
    MaxAge = 30
    GarbageInterval = 15
    GarbageCollection = True
    ForceGCThreshold = 500
    AutoCreateDirectories = True
    Left = 382
    Top = 128
  end
  object JSONStreamFormat: TkbmMWJSONStreamFormat
    Version = '4.20'
    sfDeltas = []
    sfCalculated = []
    sfLookup = []
    sfObjectNotation = []
    VersionName = 'version'
    DefinitionName = 'definition'
    DataName = 'data'
    RowIDName = 'id'
    UTFFormat = mwfUTF8
    Left = 382
    Top = 47
  end
  object FileServerTransport: TkbmMWTCPIPIndyServerTransport
    Server = Server
    Enabled = False
    Bindings = <
      item
        IP = '0.0.0.0'
        Port = 80
        ReuseSocket = rsTrue
      end>
    StreamFormat = 'ZIPPED'
    VerifyTransfer = False
    TransportStateOptions = []
    StringConversion = mwscFixed
    KeepAliveTimeOut = 0
    KeepAliveInterval = 0
    Left = 219
    Top = 126
  end
  object XMLStreamFormat: TkbmMWXMLStreamFormat
    Version = '3.10'
    sfDeltas = []
    sfCalculated = []
    sfLookup = []
    sfXML = [sfXMLSaveRowID, sfXMLVersions, sfXMLExplicitDataNode]
    DatasetNodeName = 'dataSet'
    RowNodeName = 'row'
    FieldNodeName = 'field'
    VersionNodeName = 'version'
    DefinitionNodeName = 'definition'
    DataNodeName = 'data'
    Left = 522
    Top = 50
  end
  object Server: TkbmMWServer
    Active = False
    CPUAffinityMask = 15
    GarbageCollection = True
    GarbageInterval = 30
    EnableDefaultService = False
    ShutdownWait = 60
    EarlyAuthentication = False
    Left = 73
    Top = 47
  end
end
