object ListaMaterialesProcesosModule: TListaMaterialesProcesosModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 284
  Width = 285
  object DmRelacionMaterialesTable: TnxeTable
    Timeout = 15000
    TableName = 'RelacionMateriales'
    IndexFieldNames = 
      'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso;Nr' +
      'oLinea'
    Left = 62
    Top = 92
  end
  object DmRelacionOperacionesTable: TnxeTable
    Timeout = 15000
    TableName = 'RelacionOperaciones'
    IndexFieldNames = 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso'
    Left = 66
    Top = 16
  end
end
