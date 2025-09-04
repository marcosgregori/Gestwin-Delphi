object EstructuraFicheroModule: TEstructuraFicheroModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 362
  Width = 246
  object DmEstructuraFicheroTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    AfterOpen = DmEstructuraFicheroTableAfterOpen
    TableName = 'EstructuraFichero'
    IndexFieldNames = 'Fichero;NroRegistro'
    Left = 100
    Top = 24
  end
  object DmLineaEstructFicheroTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    AfterOpen = DmLineaEstructFicheroTableAfterOpen
    TableName = 'LineaEstructFichero'
    IndexFieldNames = 'Fichero;NroRegistro;NroLinea'
    Left = 98
    Top = 86
  end
  object FsScript: TfsScript
    SyntaxType = 'PascalScript'
    Left = 100
    Top = 154
  end
  object FsPascal: TfsPascal
    Left = 100
    Top = 212
  end
  object fsIniRTTI: TfsIniRTTI
    Left = 98
    Top = 276
  end
end
