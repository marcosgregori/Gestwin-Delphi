object CuentaModule: TCuentaModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 185
  Width = 263
  object DmCuentaTable: TnxeTable
    Timeout = 6000
    BeforeOpen = DmCuentaTableBeforeOpen
    TableName = 'Cuenta'
    IndexFieldNames = 'Codigo'
    Left = 70
    Top = 20
  end
end
