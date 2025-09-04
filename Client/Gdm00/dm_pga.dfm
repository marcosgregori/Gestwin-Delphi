object ConfiguracionModule: TConfiguracionModule
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 345
  Width = 263
  PixelsPerInch = 120
  object DmConfiguracionTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Configuracion'
    IndexFieldNames = 'Aplicacion;Tipo;Codigo'
    Left = 100
    Top = 33
    object DmConfiguracionTableAplicacion: TSmallintField
      FieldName = 'Aplicacion'
    end
    object DmConfiguracionTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object DmConfiguracionTableCodigo: TWideStringField
      DisplayWidth = 40
      FieldName = 'Codigo'
      Size = 40
    end
    object DmConfiguracionTableData: TBlobField
      FieldName = 'Data'
      Size = 512
    end
  end
  object DmFicherosTable: TnxeTable
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Ficheros'
    IndexFieldNames = 'CodigoEmpresa;NombreFichero'
    Left = 100
    Top = 108
  end
  object XMLDocument: TXMLDocument
    Options = [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix, doNamespaceDecl]
    Left = 103
    Top = 203
    DOMVendorDesc = 'MSXML'
  end
end
