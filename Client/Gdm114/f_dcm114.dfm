object DCMFunctionsModule: TDCMFunctionsModule
  Tag = 1
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Height = 149
  Width = 263
  object DmDocumentoControlMercanciasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'DocumentoControlMercancias'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    AutoIncFieldName = 'NroRegistro'
    Left = 98
    Top = 32
  end
end
