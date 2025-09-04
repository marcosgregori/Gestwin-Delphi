object DataModule20: TDataModule20
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 252
  Width = 263
  object Dictionary: TnxeDatabaseDictionary
    Session = DataAccessModule.MainSession
    AliasPath = 'F:\Gestwin\dm20'
    TargetDatabase = EnterpriseDataModule.UserDatabase
    SQLItems = <>
    Left = 50
    Top = 16
  end
end
