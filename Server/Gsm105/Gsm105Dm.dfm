object DataModule105: TDataModule105
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 151
  Width = 172
  object Dictionary: TnxeDatabaseDictionary
    AliasPath = 'F:\Desktop\Gestwin\dm105'
    SQLItems = <>
    Left = 46
    Top = 25
  end
end
