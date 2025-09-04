object DataModule116: TDataModule116
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 134
  Width = 155
  object Dictionary: TnxeDatabaseDictionary
    Session = DataAccessModule.MainSession
    AliasPath = 'F:\Desktop\Gestwin\dm116'
    SQLItems = <>
    Left = 38
    Top = 18
  end
end
