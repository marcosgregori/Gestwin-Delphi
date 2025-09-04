object SincronizacionTiendaModule: TSincronizacionTiendaModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 154
  Width = 206
  object RegistroActualizacionTable: TnxeTable
    Timeout = 6000
    TableName = 'RegistroActualizacion'
    IndexFieldNames = 'TipoRegistro;Codigo'
    Left = 74
    Top = 32
  end
end
