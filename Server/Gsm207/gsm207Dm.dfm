object DataModule207: TDataModule207
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 189
  Width = 246
  object Dictionary: TnxeDatabaseDictionary
    AliasPath = 'F:\Desktop\Gestwin\dm207'
    SQLItems = <>
    OnVerify = DictionaryVerify
    OnBeforeUpdate = DictionaryBeforeUpdate
    OnAfterUpdate = DictionaryAfterUpdate
    Left = 46
    Top = 25
  end
  object SQLSet: TgxSQLSet
    SQLItems = <>
    Left = 44
    Top = 90
  end
  object SourceTable: TnxeTable
    Timeout = 6000
    TableType = ttRecover
    Left = 135
    Top = 28
  end
  object TargetTable: TnxeTable
    Timeout = 6000
    TableType = ttRecover
    Left = 135
    Top = 90
  end
end
