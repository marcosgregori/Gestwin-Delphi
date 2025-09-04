object MovimientoCajaModule: TMovimientoCajaModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = MovimientoCajaModuleCreate
  OnDestroy = MovimientoCajaModuleDestroy
  Height = 224
  Width = 186
  object DmMovimientoCajaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'MovimientoCaja'
    IndexFieldNames = 'Ejercicio;Serie;NroOperacion'
    Left = 66
    Top = 40
  end
end
