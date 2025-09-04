object SaldosModule: TSaldosModule
  Tag = 1
  OnCreate = SaldosModuleCreate
  OnDestroy = SaldosModuleDestroy
  Height = 192
  Width = 140
  object DmSaldosTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Saldos'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    Left = 54
    Top = 26
  end
  object DmExistenciasTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Existencia'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    Left = 52
    Top = 102
  end
end
