object RegistroModule: TRegistroModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 186
  Width = 313
  object DmRegistroTable: TnxeTable
    Timeout = 6000
    TableName = 'Registro'
    IndexFieldNames = 'IdPadre;Clave'
    Left = 74
    Top = 34
  end
end
