object CalendarioModule: TCalendarioModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 210
  Width = 278
  object DmCalendarioTable: TnxeTable
    Timeout = 6000
    TableName = 'Calendario'
    IndexFieldNames = 'Fecha'
    Left = 61
    Top = 34
  end
  object DmTurnoTable: TnxeTable
    Timeout = 6000
    TableName = 'Turno'
    IndexFieldNames = 'NroTurno'
    Left = 61
    Top = 102
  end
  object DmCalendarioTipoTable: TnxeTable
    Timeout = 6000
    TableName = 'Calendario'
    IndexFieldNames = 'Fecha'
    Left = 171
    Top = 32
  end
end
