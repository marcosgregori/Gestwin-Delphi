object CuentaAnaliticaModule: TCuentaAnaliticaModule
  Tag = 1
  OnCreate = CuentaAnaliticaModuleCreate
  OnDestroy = CuentaAnaliticaModuleDestroy
  Height = 147
  Width = 264
  PixelsPerInch = 96
  object DmCuentaAnaliticaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'CuentaAnalitica'
    IndexFieldNames = 'CentroCoste;Codigo'
    Left = 74
    Top = 18
  end
end
