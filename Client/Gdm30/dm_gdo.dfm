object GrupoDocumentoModule: TGrupoDocumentoModule
  Tag = 1
  OnCreate = GrupoDocumentoModuleCreate
  OnDestroy = GrupoDocumentoModuleDestroy
  Height = 150
  Width = 215
  PixelsPerInch = 96
  object DmGrupoDocumentoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'GrupoDocumento'
    IndexFieldNames = 'Codigo'
    Left = 56
    Top = 20
  end
end
