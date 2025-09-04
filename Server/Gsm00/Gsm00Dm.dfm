object DataModule00: TDataModule00
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = False
  Height = 422
  Width = 380
  object EmpresaTable: TnxeTable
    Timeout = 6000
    TableName = 'Empresa'
    IndexFieldNames = 'Codigo'
    Left = 40
    Top = 102
  end
  object UsuarioTable: TnxeTable
    Timeout = 6000
    TableName = 'Usuario'
    IndexFieldNames = 'Codigo'
    Left = 40
    Top = 164
  end
  object SQLSet: TgxSQLSet
    SQLItems = <>
    Left = 36
    Top = 310
  end
  object SourceTable: TnxeTable
    Timeout = 6000
    TableType = ttRecover
    Left = 175
    Top = 44
  end
  object TargetTable: TnxeTable
    Timeout = 6000
    TableType = ttRecover
    Left = 257
    Top = 44
  end
  object Dictionary: TnxeDatabaseDictionary
    AliasPath = 'F:\Desktop\Gestwin\dm00'
    SQLItems = <>
    OnBeforeUpdate = DictionaryBeforeUpdate
    OnAfterUpdate = DictionaryAfterUpdate
    Left = 44
    Top = 40
  end
end
