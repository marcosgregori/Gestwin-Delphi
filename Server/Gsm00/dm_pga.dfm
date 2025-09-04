object ConfiguracionModule: TConfiguracionModule
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 295
  Width = 212
  object DmConfiguracionTable: TnxeTable
    Timeout = 6000
    TableName = 'Configuracion'
    IndexFieldNames = 'Aplicacion;Tipo;Codigo'
    Left = 80
    Top = 26
    object DmConfiguracionTableAplicacion: TSmallintField
      FieldName = 'Aplicacion'
    end
    object DmConfiguracionTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object DmConfiguracionTableCodigo: TWideStringField
      FieldName = 'Codigo'
    end
    object DmConfiguracionTableData: TBlobField
      FieldName = 'Data'
      Size = 512
    end
  end
  object DmFicherosTable: TnxeTable
    Timeout = 6000
    TableName = 'Ficheros'
    IndexFieldNames = 'CodigoEmpresa;NombreFichero'
    Left = 80
    Top = 88
  end
  object XMLDocument: TXMLDocument
    Options = [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix, doNamespaceDecl]
    Left = 82
    Top = 162
    DOMVendorDesc = 'MSXML'
  end
end
