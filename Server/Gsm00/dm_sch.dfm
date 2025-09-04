object SchedulerModule: TSchedulerModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 316
  Width = 384
  PixelsPerInch = 96
  object DmPlanificadorTable: TnxeTable
    Timeout = 6000
    TableName = 'Planificador'
    IndexFieldNames = 'IDEvento'
    Left = 62
    Top = 32
  end
  object DmRecursosPlanificadorTable: TnxeTable
    Timeout = 6000
    TableName = 'RecursosPlanificador'
    IndexFieldNames = 'ID'
    Left = 202
    Top = 32
  end
  object DmPlanificadorAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'Planificador'
    IndexFieldNames = 'IDEvento'
    Left = 58
    Top = 112
  end
end
