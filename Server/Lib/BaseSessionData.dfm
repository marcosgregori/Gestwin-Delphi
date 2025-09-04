object BaseSessionDataModule: TBaseSessionDataModule
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 426
  Width = 673
  object PooledSession: TkbmMWPooledSession
    ConnectionPool = ConnectionPool
    AutoSessionName = False
    SessionName = 'ENTERPRISESESSION'
    Left = 184
    Top = 183
  end
  object ConnectionPool: TkbmMWNexusDBConnectionPool
    GarbageCollection = False
    MetaData = NexusDBMetaData
    Session = DBSession
    Left = 78
    Top = 115
  end
  object AppResolver: TkbmMWNexusDBResolver
    Left = 188
    Top = 115
  end
  object NexusDBMetaData: TkbmMWNexusDBMetaData
    FieldNameQuote = '"'
    FieldNameCase = mwncUnaltered
    TableNameQuote = '"'
    TableNameCase = mwncUnaltered
    QuoteAllFieldNames = False
    QuoteTableName = True
    StringQuote = '"'
    QuoteStringQuote = '"'
    DateLayout = 'yyyy-mm-dd'
    TimeLayout = 'hh:mm:ss.zzz'
    DateTimeLayout = 'yyyy-mm-dd hh:mm:ss.zzz'
    TrueValue = 'TRUE'
    FalseValue = 'FALSE'
    Left = 76
    Top = 181
  end
  object EnterpriseQuery: TkbmMWNexusDBQuery
    CacheParams = ptUnknown
    CacheFlags = []
    SessionName = 'MAINSESSION'
    ConnectionPool = ConnectionPool
    RunInTransaction = False
    StatementPassthrough = True
    DesignActivation = True
    AttachMaxCount = 1
    AttachedAutoRefresh = True
    EnableVersioning = True
    IndexDefs = <>
    SortOptions = []
    ReadOnly = True
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    PersistentBackup = False
    Params = <>
    Left = 72
    Top = 260
  end
  object DBSession: TnxSession
    EventLogEnabled = True
    Timeout = 60000
    Left = 79
    Top = 36
  end
  object DatabaseInfoTable: TnxeTable
    Timeout = 6000
    TableName = '_DBI'
    IndexFieldNames = 'MajorVersion;MinorVersion;Release;Build'
    TableType = ttRecover
    Left = 72
    Top = 342
    object DatabaseInfoTableMajorVersion: TSmallintField
      FieldName = 'MajorVersion'
    end
    object DatabaseInfoTableMinorVersion: TSmallintField
      FieldName = 'MinorVersion'
    end
    object DatabaseInfoTableRelease: TSmallintField
      FieldName = 'Release'
    end
    object DatabaseInfoTableBuild: TIntegerField
      FieldName = 'Build'
    end
    object DatabaseInfoTableUpdated: TDateTimeField
      FieldName = 'Updated'
    end
    object DatabaseInfoTableOptions: TWideStringField
      FieldName = 'Options'
    end
  end
  object SQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'CreateDatabaseInfo'
        SQLText = 
          'CREATE TABLE _DBI ('#13#10'MajorVersion SmallInt,'#13#10'MinorVersion SmallI' +
          'nt,'#13#10'Release SmallInt,'#13#10'Build Integer,'#13#10'Updated Timestamp,'#13#10'Opti' +
          'ons NVARCHAR(20)'#13#10');'#13#10'CREATE UNIQUE INDEX Index0 ON _DBI(MajorVe' +
          'rsion, MinorVersion, Release, Build);'#13#10
      end>
    Left = 182
    Top = 340
  end
  object ImportsDatabase: TnxeDatabase
    DisplayCategory = 'Temporal'
    Session = DBSession
    AliasPath = 'F:\Desktop\Gestwin\Imports'
    Left = 466
    Top = 119
  end
  object ExportsDatabase: TnxeDatabase
    DisplayCategory = 'Temporal'
    Session = DBSession
    AliasPath = 'F:\Desktop\Gestwin\Exports'
    Left = 561
    Top = 118
  end
  object InMemoryDatabase: TnxeDatabase
    DisplayCategory = 'InMemory'
    Session = DBSession
    AliasPath = '#'
    Left = 360
    Top = 119
  end
  object TemporalDatabase: TnxeDatabase
    DisplayCategory = 'Temporal'
    Session = DBSession
    AliasPath = 'F:\Desktop\Gestwin\Temp'
    Left = 358
    Top = 39
  end
  object MainQuery: TkbmMWNexusDBQuery
    CacheParams = ptUnknown
    CacheFlags = []
    SessionName = 'MAINSESSION'
    ConnectionPool = ConnectionPool
    StatementPassthrough = True
    DesignActivation = True
    AttachMaxCount = 1
    AttachedAutoRefresh = True
    EnableVersioning = True
    IndexDefs = <>
    SortOptions = []
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    PersistentBackup = False
    Params = <>
    Left = 187
    Top = 259
  end
  object BTScroogeXHTML: TBTScroogeXHTML
    ConvertEmptyParagraphs = False
    ConvertHyperlinks = False
    ConvertIndent = False
    ConvertLanguage = False
    ConvertPictures = False
    ConvertSpaces = False
    ConvertToPlainText = True
    ConvertUsingPrettyIndents = True
    DebugMode = False
    DocumentType = dtHTML_50
    FontConversionOptions = [opFontName, opFontSize, opFontStyle, opFontColor, opFontBGColor]
    FontSizeScale = fsPoint
    HyperlinkOptions = []
    IncludeDocType = False
    IncludeXMLDeclaration = False
    LogLevel = logInfo
    ReplaceFonts.Strings = (
      'Arial=Arial,Helvetica,sans-serif'
      'Courier=Courier,monospace'
      'Symbol=Symbol'
      'Times=Times,serif')
    TabString = ' '
    OptionsHead.AddOuterHTML = True
    OptionsHead.DocumentTitle = 'Untitled document'
    OptionsHead.MetaContentType = 'text/html; charset=UTF-8'
    OptionsHead.MetaOptions = [moMetaGenerator]
    OptionsOptimize.DefaultFontColor = '#000000'
    OptionsOptimize.DefaultFontName = 'Times,serif'
    OptionsOptimize.DefaultFontSize = 12
    OptionsOptimize.IncludeDefaultFontStyle = False
    Left = 358
    Top = 232
  end
end
