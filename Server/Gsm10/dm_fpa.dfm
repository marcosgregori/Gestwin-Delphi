object FormaPagoModule: TFormaPagoModule
  Tag = 1
  OldCreateOrder = False
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 184
  Width = 263
  object DmFormaPagoTable: TnxeTable
    Timeout = 15000
    TableName = 'FormaPago'
    IndexFieldNames = 'Codigo'
    Left = 62
    Top = 30
  end
end
