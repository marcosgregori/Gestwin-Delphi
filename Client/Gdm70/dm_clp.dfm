object ClaseProduccionModule: TClaseProduccionModule
  Tag = 1
  OldCreateOrder = False
  Height = 187
  Width = 158
  object DmTarifaClaseTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaClase'
    IndexFieldNames = 'Seccion;CodigoPropietario;CodigoArticulo;ClaseA;ClaseB;ClaseC'
    Left = 54
    Top = 78
  end
  object DmClaseTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Clase'
    IndexFieldNames = 'NroClase;Codigo'
    Left = 54
    Top = 14
  end
end
