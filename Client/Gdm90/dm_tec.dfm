object TecnicoModule: TTecnicoModule
  Tag = 1
  OnCreate = TecnicoModuleCreate
  OnDestroy = TecnicoModuleDestroy
  Height = 184
  Width = 263
  PixelsPerInch = 96
  object DmTecnicoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Tecnico'
    IndexFieldNames = 'Codigo'
    Left = 42
    Top = 14
  end
end
