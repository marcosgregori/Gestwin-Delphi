object DataModule70: TDataModule70
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 261
  Width = 382
  object Dictionary: TnxeDatabaseDictionary
    AliasPath = 'F:\Desktop\Gestwin\dm70'
    SQLItems = <>
    OnVerify = DictionaryVerify
    OnAfterUpdate = DictionaryAfterUpdate
    Left = 46
    Top = 25
  end
  object SQLSet: TgxSQLSet
    SQLItems = <>
    Left = 48
    Top = 88
  end
  object DetailSourceTable: TnxeTable
    Timeout = 6000
    TableType = ttRecover
    Left = 161
    Top = 88
  end
  object MasterSourceTable: TnxeTable
    Timeout = 6000
    TableType = ttRecover
    Left = 160
    Top = 24
  end
end
