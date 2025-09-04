object FormaEnvioModule: TFormaEnvioModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 198
  Width = 309
  object DmFormaEnvioTable: TnxeTable
    Timeout = 15000
    TableName = 'FormaEnvio'
    IndexFieldNames = 'Codigo'
    Left = 44
    Top = 22
  end
end
