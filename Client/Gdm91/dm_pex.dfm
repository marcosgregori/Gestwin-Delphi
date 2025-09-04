object ProveedorExternoModule: TProveedorExternoModule
  Tag = 1
  OnCreate = ProveedorExternoModuleCreate
  OnDestroy = ProveedorExternoModuleDestroy
  Height = 184
  Width = 263
  PixelsPerInch = 96
  object DmProveedorExternoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ProveedorExterno'
    IndexFieldNames = 'Codigo'
    Left = 42
    Top = 14
  end
end
