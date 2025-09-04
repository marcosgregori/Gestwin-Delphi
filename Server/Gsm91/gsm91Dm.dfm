object DataModule91: TDataModule91
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 232
  Width = 194
  object Dictionary: TnxeDatabaseDictionary
    AliasPath = 'F:\Desktop\Gestwin\dm91'
    SQLItems = <>
    OnVerify = DictionaryVerify
    OnAfterUpdate = DictionaryAfterUpdate
    Left = 46
    Top = 25
  end
  object SQLSet: TgxSQLSet
    SQLItems = <>
    Left = 42
    Top = 92
  end
end
