object DataModule90: TDataModule90
  OldCreateOrder = False
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 338
  Width = 453
  object Dictionary: TnxeDatabaseDictionary
    AliasPath = 'F:\Desktop\Gestwin\dm90'
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
