object DataModule90: TDataModule90
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 117
  Width = 361
  object Dictionary: TnxeDatabaseDictionary
    Session = DataAccessModule.MainSession
    AliasPath = 'F:\Gestwin\dm90'
    TargetDatabase = EnterpriseDataModule.UserDatabase
    SQLItems = <>
    Left = 50
    Top = 16
  end
  object MasterRecoverTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    
    TableType = ttRecover
    Left = 145
    Top = 16
  end
end
