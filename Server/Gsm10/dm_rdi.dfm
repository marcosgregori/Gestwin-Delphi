object RelacionesDivisaModule: TRelacionesDivisaModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = relacionesDivisaModuleCreate
  OnDestroy = relacionesDivisaModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 184
  Width = 263
  object DmRelacionesDivisaTable: TnxeTable
    Timeout = 15000
    TableName = 'RelacionesDivisa'
    IndexFieldNames = 'CodigoDivisa'
    Left = 64
    Top = 24
  end
end
