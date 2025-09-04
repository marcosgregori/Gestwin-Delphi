object EnterpriseDataModule: TEnterpriseDataModule
  OnCreate = SectionDataModuleCreate
  OnDestroy = SectionDataModuleDestroy
  Height = 276
  Width = 244
  object AuxDatabase: TnxeDatabase
    EventLogEnabled = True
    Timeout = 15000
    AliasPath = 'F:\Desktop\Gestwin\data_001'
    Updatable = True
    Left = 64
    Top = 115
  end
  object Database: TnxeDatabase
    EventLogEnabled = True
    Timeout = 60000
    AliasPath = 'F:\Desktop\Gestwin\data_001'
    Left = 68
    Top = 43
  end
end
