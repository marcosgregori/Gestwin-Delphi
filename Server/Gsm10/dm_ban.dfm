object BancoModule: TBancoModule
  Tag = 1
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 131
  Width = 158
  object DmBancoTable: TnxeTable
    Timeout = 6000
    TableName = 'Banco'
    IndexFieldNames = 'Subcuenta'
    Left = 52
    Top = 26
  end
end
