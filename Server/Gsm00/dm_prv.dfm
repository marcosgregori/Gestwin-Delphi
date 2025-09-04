object ProvinciaModule: TProvinciaModule
  Tag = 1
  OnCreate = ServerModuleCreate
  OnDestroy = ServerModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 282
  Width = 230
  object DmProvinciaTable: TnxeTable
    Timeout = 6000
    TableName = 'Provincia'
    IndexFieldNames = 'CodigoPais;Codigo'
    Left = 50
    Top = 20
  end
  object DmProvinciaQuery: TnxeQuery
    Timeout = 180000
    Left = 50
    Top = 106
  end
  object nxSqlUpdateObject1: TnxSqlUpdateObject
    Left = 46
    Top = 176
  end
end
