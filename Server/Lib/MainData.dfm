object MainDataModule: TMainDataModule
  OnDestroy = SectionDataModuleDestroy
  Height = 238
  Width = 231
  PixelsPerInch = 96
  object Database: TnxeDatabase
    EventLog = dmServer.EventLog
    EventLogEnabled = True
    Session = BaseSessionDataModule.DBSession
    Timeout = 60000
    AliasPath = 'F:\Desktop\Gestwin\data'
    Left = 44
    Top = 105
  end
  object Dictionary: TnxeDatabaseDictionary
    AliasPath = 'F:\Desktop\Gestwin\dm00'
    TargetDatabase = Database
    SQLItems = <>
    Left = 44
    Top = 32
  end
end
