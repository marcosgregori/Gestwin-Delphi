object UsuarioModule: TUsuarioModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 184
  Width = 263
  object DmUsuarioTable: TnxeTable
    Timeout = 6000
    TableName = 'Usuario'
    IndexFieldNames = 'Codigo'
    Left = 50
    Top = 30
  end
end
