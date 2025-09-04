object RptCpe40Module: TRptCpe40Module
  Tag = 1
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 226
  Width = 299
  object DmHojaCargaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 15000
    TableName = 'HojaCarga'
    IndexFieldNames = 'Ejercicio;NroHoja'
    Left = 59
    Top = 26
  end
end
