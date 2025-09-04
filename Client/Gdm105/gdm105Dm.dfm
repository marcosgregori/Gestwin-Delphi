object DataModule105: TDataModule105
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 124
  Width = 184
  object Dictionary: TnxeDatabaseDictionary
    Session = DataAccessModule.MainSession
    AliasPath = 'F:\Desktop\Gestwin\dm105'
    TargetDatabase = EnterpriseDataModule.UserDatabase
    SQLItems = <>
    Left = 38
    Top = 18
  end
end
