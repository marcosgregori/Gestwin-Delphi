object Configuracion105Module: TConfiguracion105Module
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 184
  Width = 263
  object DmDesgloseBultosLineaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'DesgloseBultosLinea'
    IndexFieldNames = 'NroRegistroLinea;NroBulto'
    AutoIncFieldName = 'NroBulto'
    OpenOnMasterActivation = False
    Left = 69
    Top = 32
  end
end
