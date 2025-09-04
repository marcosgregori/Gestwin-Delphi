object PlantillaGraficoModule: TPlantillaGraficoModule
  Tag = 1
  OnCreate = PlantillaGraficoModuleCreate
  OnDestroy = PlantillaGraficoModuleDestroy
  Height = 119
  Width = 171
  PixelsPerInch = 96
  object DmPlantillaGraficoTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'PlantillaGrafico'
    IndexFieldNames = 'Tipo;NroOperacion;NroRegistro'
    Left = 64
    Top = 18
  end
end
