object DataModule119: TDataModule119
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 164
  Width = 252
  object Dictionary: TnxeDatabaseDictionary
    Session = DataAccessModule.MainSession
    AliasPath = 'F:\Desktop\Gestwin\dm119'
    SQLItems = <>
    Left = 38
    Top = 18
  end
end
