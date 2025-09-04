object ListaMaterialesModule: TListaMaterialesModule
  Tag = 1
  OnCreate = listaMaterialesModuleCreate
  OnDestroy = listaMaterialesModuleDestroy
  Height = 289
  Width = 229
  PixelsPerInch = 96
  object DmListaMaterialesTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ListaMateriales'
    IndexFieldNames = 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;NroLinea'
    Left = 90
    Top = 26
  end
  object DmLineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 90
    Top = 112
  end
end
