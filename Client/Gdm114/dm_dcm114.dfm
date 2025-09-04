object DocumentoControlMercanciasModule: TDocumentoControlMercanciasModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 273
  Width = 388
  object DmDocumentoControlMercanciasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'DocumentoControlMercancias'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 254
    Top = 36
  end
  object DmMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 61
    Top = 34
  end
  object DmLineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 61
    Top = 98
  end
  object DmLineaMovimientoAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 61
    Top = 162
  end
  object DmCargaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Carga'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroLinea'
    Left = 256
    Top = 104
  end
  object DmDocumentoControlMercanciasAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'DocumentoControlMercancias'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 256
    Top = 170
  end
end
