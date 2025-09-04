object AuxiliarProveedorModule: TAuxiliarProveedorModule
  Tag = 1
  OnCreate = AuxiliarProveedorModuleCreate
  OnDestroy = AuxiliarProveedorModuleDestroy
  Height = 184
  Width = 263
  PixelsPerInch = 96
  object DmAuxiliarProveedorTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'AuxiliarProveedor'
    IndexFieldNames = 'CodigoProveedor;Codigo'
    Left = 74
    Top = 18
  end
end
