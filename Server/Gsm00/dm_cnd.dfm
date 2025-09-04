object ContadoresModule: TContadoresModule
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 231
  Width = 187
  object DmContadoresTable: TnxeTable
    Timeout = 6000
    TableName = 'Contadores'
    IndexFieldNames = 'CodigoEmpresa;Tipo;Ejercicio;Codigo;Valor'
    Left = 66
    Top = 26
  end
  object DmBloqueoContadoresTable: TnxeTable
    Timeout = 6000
    TableName = 'Contadores'
    IndexFieldNames = 'CodigoEmpresa;Tipo;Ejercicio;Codigo;Valor'
    Left = 66
    Top = 88
  end
end
