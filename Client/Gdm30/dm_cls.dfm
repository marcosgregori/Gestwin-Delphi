object ClaseModule: TClaseModule
  Tag = 1
  OnCreate = claseModuleCreate
  OnDestroy = claseModuleDestroy
  Height = 262
  Width = 213
  object DmTarifaClaseTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaClase'
    IndexFieldNames = 'Seccion;CodigoPropietario;CodigoArticulo;ClaseA;ClaseB;ClaseC'
    Left = 78
    Top = 88
  end
  object DmClaseTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Clase'
    IndexFieldNames = 'NroClase;Codigo'
    Left = 78
    Top = 24
  end
  object DmClasesArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ClasesArticulo'
    IndexFieldNames = 'CodigoArticulo;NroClase;CodigoClase'
    Left = 76
    Top = 160
  end
end
