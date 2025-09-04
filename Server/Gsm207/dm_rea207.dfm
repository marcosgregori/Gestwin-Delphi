object RegistroActualizacionModule: TRegistroActualizacionModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 253
  Width = 293
  PixelsPerInch = 96
  object RegistroActualizacionTable: TnxeTable
    Timeout = 6000
    TableName = 'RegistroActualizacion'
    IndexFieldNames = 'TipoRegistro;Codigo'
    Left = 88
    Top = 24
  end
  object RegistroActualizacionIDTable: TnxeTable
    Timeout = 6000
    TableName = 'RegistroActualizacion'
    IndexFieldNames = 'TipoRegistro;ID'
    Left = 88
    Top = 98
  end
end
