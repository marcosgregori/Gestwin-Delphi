object TasaModule: TTasaModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 178
  Width = 214
  object DmTiposIVATable: TnxeTable
    Timeout = 6000
    TableName = 'TiposIVA'
    IndexFieldNames = 'FechaAplicacion;CodigoPais;Codigo'
    Left = 82
    Top = 22
  end
  object DmRelacionesTiposIVATable: TnxeTable
    Timeout = 6000
    TableName = 'TiposIVA'
    IndexFieldNames = 'CodigoPais;Codigo'
    Left = 80
    Top = 92
  end
end
