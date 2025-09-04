object EfectoModule: TEfectoModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = efectoModuleCreate
  OnDestroy = efectoModuleDestroy
  Height = 150
  Width = 215
  object DmEfectoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Efecto'
    IndexFieldNames = 'Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto'
    Left = 36
    Top = 10
  end
end
