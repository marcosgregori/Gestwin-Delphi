object DataModule207: TDataModule207
  OldCreateOrder = False
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 338
  Width = 453
  object Dictionary: TnxeDatabaseDictionary
    AliasPath = 'F:\Desktop\Gestwin\dm207'
    SQLItems = <>
    OnVerify = DictionaryVerify
    OnAfterUpdate = DictionaryAfterUpdate
    Left = 46
    Top = 25
  end
  object SQLSet: TgxSQLSet
    SQLItems = <>
    Left = 44
    Top = 90
  end
end
