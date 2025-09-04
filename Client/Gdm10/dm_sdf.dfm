object SerieFacturacionModule: TSerieFacturacionModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 118
  Width = 191
  object DmSerieFacturacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'SerieFacturacion'
    IndexFieldNames = 'Codigo'
    Left = 64
    Top = 22
  end
end
