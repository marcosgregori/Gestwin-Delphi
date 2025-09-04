object RegistroModule: TRegistroModule
  Tag = 1
  OnCreate = RegistroModuleCreate
  OnDestroy = RegistroModuleDestroy
  Height = 195
  Width = 281
  PixelsPerInch = 144
  object DmRegistroTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Registro'
    IndexFieldNames = 'IdPadre;Clave'
    Left = 69
    Top = 42
  end
end
