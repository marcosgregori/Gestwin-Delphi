object UsuarioModule: TUsuarioModule
  Tag = 1
  OnDestroy = usuarioModuleDestroy
  Height = 147
  Width = 252
  PixelsPerInch = 96
  object DmUsuarioTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    AfterOpen = DmUsuarioTableAfterOpen
    TableName = 'Usuario'
    IndexFieldNames = 'Codigo'
    Left = 50
    Top = 16
  end
end
