object CalendarioModule: TCalendarioModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 226
  Width = 249
  PixelsPerInch = 96
  object DmCalendarioTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Calendario'
    IndexFieldNames = 'Fecha'
    Left = 68
    Top = 34
  end
  object DmTurnoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Turno'
    IndexFieldNames = 'NroTurno'
    Left = 68
    Top = 98
  end
  object DmCalendarioAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Calendario'
    IndexFieldNames = 'Fecha'
    Left = 172
    Top = 34
  end
end
