object RegistroActualizacionModule: TRegistroActualizacionModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 157
  Width = 266
  PixelsPerInch = 96
  object DmRegistroActualizacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RegistroActualizacion'
    IndexFieldNames = 'TipoRegistro;Codigo'
    Left = 90
    Top = 34
  end
end
