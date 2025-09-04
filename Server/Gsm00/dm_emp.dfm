object EmpresaModule: TEmpresaModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 219
  Width = 173
  object DmEmpresaTable: TnxeTable
    Timeout = 6000
    TableName = 'Empresa'
    IndexFieldNames = 'Codigo'
    Left = 52
    Top = 18
  end
  object DmFicherosTable: TnxeTable
    Timeout = 6000
    TableName = 'Ficheros'
    IndexFieldNames = 'CodigoEmpresa;NombreFichero'
    Left = 52
    Top = 82
  end
end
