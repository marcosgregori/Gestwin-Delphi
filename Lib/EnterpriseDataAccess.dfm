object EnterpriseDataModule: TEnterpriseDataModule
  OnCreate = EnterpriseDataModuleCreate
  OnDestroy = EnterpriseDataModuleDestroy
  Height = 212
  Width = 158
  object UserDatabase: TnxeDatabase
    OnStateChanged = UserDatabaseStateChanged
    Session = DataAccessModule.MainSession
    AliasPath = 'F:\Desktop\Gestwin\data_001'
    Updatable = True
    Left = 42
    Top = 24
  end
  object UserAuxDatabase: TnxeDatabase
    Session = DataAccessModule.MainSession
    AliasPath = 'F:\Desktop\Gestwin\data_001'
    Updatable = True
    Left = 42
    Top = 92
  end
end
