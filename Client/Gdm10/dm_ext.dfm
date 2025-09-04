object ExtractoModule: TExtractoModule
  Tag = 1
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Height = 192
  Width = 192
  object DmApunteQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    Left = 56
    Top = 70
  end
end
