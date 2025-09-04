object RelacionDocumentosModule: TRelacionDocumentosModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = ResultadosModuleDestroy
  Height = 182
  Width = 212
  object DmRelacionDocumentosTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RelacionDocumentos'
    IndexFieldNames = 'Tipo;NroOperacion'
    Left = 76
    Top = 26
  end
end
