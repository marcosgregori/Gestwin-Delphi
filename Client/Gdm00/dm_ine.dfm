object InformeExternoModule: TInformeExternoModule
  Tag = 1
  OnDestroy = informeExternoModuleDestroy
  Height = 143
  Width = 218
  PixelsPerInch = 96
  object DmInformeExternoTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    AfterOpen = DmInformeExternoTableAfterOpen
    TableName = 'InformeExterno'
    IndexFieldNames = 'TipoDocumento;NroRegistro'
    Left = 66
    Top = 26
  end
end
