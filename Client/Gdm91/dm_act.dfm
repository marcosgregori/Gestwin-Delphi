object ActividadModule: TActividadModule
  Tag = 1
  OnCreate = ActividadModuleCreate
  OnDestroy = ActividadModuleDestroy
  Height = 184
  Width = 263
  PixelsPerInch = 96
  object DmActividadTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Actividad'
    IndexFieldNames = 'Codigo'
    Left = 42
    Top = 14
  end
end
