object DataModule70: TDataModule70
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 190
  Width = 166
  PixelsPerInch = 96
  object Dictionary: TnxeDatabaseDictionary
    Session = DataAccessModule.MainSession
    AliasPath = 'F:\V11.0\Gestwin\dm70'
    TargetDatabase = EnterpriseDataModule.UserDatabase
    SQLItems = <>
    Left = 60
    Top = 16
  end
  object SQLSet: TgxSQLSet
    SQLItems = <>
    Left = 56
    Top = 82
  end
end
