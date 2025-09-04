object RegistroExportacionModule: TRegistroExportacionModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 176
  Width = 306
  PixelsPerInch = 144
  object DmRegistroExportacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RegistroExportacion'
    IndexFieldNames = 'TipoDocumento;Ejercicio;Serie;NroDocumento;NroRegistro'
    Left = 105
    Top = 36
  end
end
