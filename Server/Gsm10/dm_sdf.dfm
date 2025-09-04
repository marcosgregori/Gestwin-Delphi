object SerieFacturacionModule: TSerieFacturacionModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 118
  Width = 191
  object DmSerieFacturacionTable: TnxeTable
    Timeout = 15000
    TableName = 'SerieFacturacion'
    IndexFieldNames = 'Codigo'
    Left = 64
    Top = 22
  end
end
