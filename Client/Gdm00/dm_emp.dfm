object EmpresaModule: TEmpresaModule
  Tag = 1
  OnCreate = empresaModuleCreate
  OnDestroy = empresaModuleDestroy
  Height = 219
  Width = 173
  PixelsPerInch = 96
  object DmEmpresaTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Empresa'
    IndexFieldNames = 'Codigo'
    Left = 52
    Top = 18
  end
  object DmFicherosTable: TnxeTable
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Ficheros'
    IndexFieldNames = 'CodigoEmpresa;NombreFichero'
    Left = 52
    Top = 82
  end
end
