object DataModule204: TDataModule204
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 164
  Width = 252
  object Dictionary: TnxeDatabaseDictionary
    Session = DataAccessModule.MainSession
    AliasPath = 'F:\Gestwin\dm204'
    TargetDatabase = EnterpriseDataModule.UserDatabase
    SQLItems = <>
    Left = 38
    Top = 18
  end
end
