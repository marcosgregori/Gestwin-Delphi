object ConceptoApunteModule: TConceptoApunteModule
  Tag = 1
  OnCreate = conceptoApunteModuleCreate
  OnDestroy = conceptoApunteModuleDestroy
  Height = 184
  Width = 304
  PixelsPerInch = 96
  object DmConceptoApteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ConceptoApte'
    IndexFieldNames = 'NroConcepto'
    Left = 70
    Top = 18
  end
end
