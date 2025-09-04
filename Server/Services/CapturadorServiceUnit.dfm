object CapturadorService: TCapturadorService
  OnCreate = kbmMWQueryServiceCreate
  OnDestroy = kbmMWQueryServiceDestroy
  GatherStatistics = False
  AllowClientStatement = False
  AllowClientKeyFields = False
  AllowClientNamedQuery = False
  AllowClientTableName = False
  AllowClientSchemaName = False
  Height = 294
  Width = 425
end
