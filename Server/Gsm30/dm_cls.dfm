object ClaseModule: TClaseModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 258
  Width = 188
  object DmTarifaClaseTable: TnxeTable
    Timeout = 6000
    TableName = 'TarifaClase'
    IndexFieldNames = 'Seccion;CodigoPropietario;CodigoArticulo;ClaseA;ClaseB;ClaseC'
    Left = 64
    Top = 90
  end
  object DmClaseTable: TnxeTable
    Timeout = 6000
    TableName = 'Clase'
    IndexFieldNames = 'NroClase;Codigo'
    Left = 64
    Top = 26
  end
end
