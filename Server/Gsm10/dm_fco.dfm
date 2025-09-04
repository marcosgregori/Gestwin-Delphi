object FormaCobroModule: TFormaCobroModule
  Tag = 1
  OldCreateOrder = False
  OnDestroy = formaCobroModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 115
  Width = 201
  object DmFormaCobroTable: TnxeTable
    Timeout = 15000
    TableName = 'FormaCobro'
    IndexFieldNames = 'Codigo'
    Left = 70
    Top = 20
  end
end
