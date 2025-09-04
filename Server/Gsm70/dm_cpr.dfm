object ContenedorModule: TContenedorModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 270
  Width = 447
  PixelsPerInch = 96
  object DmContenedorTable: TnxeTable
    Timeout = 6000
    TableName = 'Contenedor'
    IndexFieldNames = 'Ejercicio;NroOrdenFabricacion;NroProceso'
    Left = 61
    Top = 34
  end
end
