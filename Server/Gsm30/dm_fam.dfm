object FamiliaModule: TFamiliaModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = familiaModuleCreate
  OpenDatasetsOnCreate = True
  Height = 150
  Width = 215
  object DmFamiliaTable: TnxeTable
    Timeout = 15000
    TableName = 'Familia'
    IndexFieldNames = 'Codigo'
    Left = 46
    Top = 32
  end
end
