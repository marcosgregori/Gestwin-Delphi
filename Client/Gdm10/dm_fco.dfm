object FormaCobroModule: TFormaCobroModule
  Tag = 1
  OnDestroy = formaCobroModuleDestroy
  Height = 115
  Width = 201
  PixelsPerInch = 96
  object DmFormaCobroTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FormaCobro'
    IndexFieldNames = 'Codigo'
    Left = 70
    Top = 20
  end
end
