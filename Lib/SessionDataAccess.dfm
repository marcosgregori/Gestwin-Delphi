object SessionDataModule: TSessionDataModule
  OnCreate = SessionDataModuleCreate
  OnDestroy = SessionDataModuleDestroy
  Height = 232
  Width = 456
  object TmpDatabase: TnxeDatabase
    DisplayCategory = 'Temporal'
    Session = DataAccessModule.LocalSession
    AliasPath = 'F:\Desktop\Gestwin\Temp'
    Left = 66
    Top = 34
  end
  object ImportsDatabase: TnxeDatabase
    DisplayCategory = 'Temporal'
    Session = DataAccessModule.LocalSession
    AliasPath = 'F:\Desktop\Gestwin\Imports'
    Left = 178
    Top = 34
  end
  object ExportsDatabase: TnxeDatabase
    DisplayCategory = 'Temporal'
    Session = DataAccessModule.LocalSession
    AliasPath = 'F:\Desktop\Gestwin\Exports'
    Left = 283
    Top = 33
  end
  object InMemoryDatabase: TnxeDatabase
    DisplayCategory = 'InMemory'
    Session = DataAccessModule.LocalSession
    AliasPath = '#'
    Left = 66
    Top = 100
  end
  object ServerTmpDatabase: TnxeDatabase
    DisplayCategory = 'Temporal'
    Session = DataAccessModule.MainSession
    AliasPath = 'F:\Desktop\Gestwin\Temp'
    Left = 176
    Top = 100
  end
end
