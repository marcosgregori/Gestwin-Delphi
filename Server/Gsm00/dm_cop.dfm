object CodigoPostalModule: TCodigoPostalModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 186
  Width = 313
  object DmCodigoPostalTable: TnxeTable
    Timeout = 15000
    TableName = 'CodigoPostal'
    IndexFieldNames = 'CodigoPais;CodigoProvincia;Codigo'
    Left = 70
    Top = 20
  end
end
