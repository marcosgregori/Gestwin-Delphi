object CapturadorModule: TCapturadorModule
  Tag = 1
  OnCreate = CapturadorModuleCreate
  OnDestroy = CapturadorModuleDestroy
  Height = 184
  Width = 304
  PixelsPerInch = 96
  object DmCapturadorTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Capturador'
    IndexFieldNames = 'NroCapturador'
    Left = 70
    Top = 18
  end
end
