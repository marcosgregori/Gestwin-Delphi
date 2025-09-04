object DataModule40: TDataModule40
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 173
  Width = 254
  object Dictionary: TnxeDatabaseDictionary
    Session = DataAccessModule.MainSession
    AliasPath = 'F:\Gestwin\dm40'
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
