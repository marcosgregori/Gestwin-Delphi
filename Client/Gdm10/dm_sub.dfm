object CuentaModule: TCuentaModule
  Tag = 1
  OnCreate = CuentaModuleCreate
  OnDestroy = CuentaModuleDestroy
  Height = 185
  Width = 263
  PixelsPerInch = 96
  object DmCuentaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeOpen = DmCuentaTableBeforeOpen
    TableName = 'Cuenta'
    IndexFieldNames = 'Codigo'
    Left = 70
    Top = 20
  end
end
