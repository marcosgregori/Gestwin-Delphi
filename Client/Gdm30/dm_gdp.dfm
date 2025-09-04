object GrupoProveedorModule: TGrupoProveedorModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  PixelsPerInch = 96
  object DmGrupoProveedorTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'GrupoProveedor'
    IndexFieldNames = 'Codigo'
    Left = 56
    Top = 20
  end
end
