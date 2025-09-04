object TurnoModule: TTurnoModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  PixelsPerInch = 96
  object DmTurnoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Turno'
    IndexFieldNames = 'NroTurno'
    Left = 76
    Top = 18
  end
end
