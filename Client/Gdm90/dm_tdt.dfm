object TipoTareaModule: TTipoTareaModule
  Tag = 1
  OnCreate = TipoTareaModuleCreate
  OnDestroy = TipoTareaModuleDestroy
  Height = 184
  Width = 263
  PixelsPerInch = 96
  object DmTipoTareaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TipoTarea'
    IndexFieldNames = 'Codigo'
    Left = 42
    Top = 14
  end
end
