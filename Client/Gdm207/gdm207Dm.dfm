object DataModule207: TDataModule207
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 164
  Width = 252
  object Dictionary: TnxeDatabaseDictionary
    Session = DataAccessModule.MainSession
    AliasPath = 'F:\V11.0\Gestwin\dm207'
    TargetDatabase = EnterpriseDataModule.UserDatabase
    SQLItems = <>
    Left = 44
    Top = 28
  end
end
