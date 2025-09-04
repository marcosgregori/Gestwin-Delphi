object EfectoModule: TEfectoModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 258
  Width = 338
  object DmEfectoTable: TnxeTable
    Timeout = 6000
    TableName = 'Efecto'
    IndexFieldNames = 'Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto'
    Left = 66
    Top = 38
  end
end
