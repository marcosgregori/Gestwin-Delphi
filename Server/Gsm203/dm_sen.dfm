object StockEnvasesModule: TStockEnvasesModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 154
  Width = 277
  object StockEnvasesTable: TnxeTable
    Timeout = 6000
    TableName = 'StockEnvases'
    IndexFieldNames = 'Propietario;TipoEnvase;CodigoEnvase'
    Left = 74
    Top = 32
  end
end
