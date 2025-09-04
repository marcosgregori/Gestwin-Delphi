object RelacionesDivisaModule: TRelacionesDivisaModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = relacionesDivisaModuleCreate
  OnDestroy = relacionesDivisaModuleDestroy
  Height = 184
  Width = 263
  object DmRelacionesDivisaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RelacionesDivisa'
    IndexFieldNames = 'CodigoDivisa'
    Left = 64
    Top = 24
  end
end
