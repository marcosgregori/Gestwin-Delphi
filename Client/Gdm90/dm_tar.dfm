object TareaModule: TTareaModule
  Tag = 1
  OldCreateOrder = True
  OnCreate = tareaModuleCreate
  OnDestroy = tareaModuleDestroy
  Height = 122
  Width = 181
  object DmTareaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 15000
    TableName = 'Tarea'
    IndexFieldNames = 'Ejercicio;NroTarea'
    Left = 42
    Top = 14
  end
end
