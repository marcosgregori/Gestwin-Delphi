object direccionModule: TdireccionModule
  Tag = 1
  OnDestroy = DireccionModuleDestroy
  Height = 244
  Width = 228
  PixelsPerInch = 96
  object DmDireccionCorreoTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    AfterOpen = DmDireccionCorreoTableAfterOpen
    TableName = 'DireccionCorreo'
    IndexFieldNames = 'Codigo'
    Left = 68
    Top = 20
    object DmDireccionCorreoTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 2
    end
    object DmDireccionCorreoTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object DmDireccionCorreoTableEsUnGrupo: TBooleanField
      FieldName = 'EsUnGrupo'
    end
    object DmDireccionCorreoTableEMail: TWideStringField
      FieldName = 'EMail'
      Size = 80
    end
    object DmDireccionCorreoTableGrupo: TWideStringField
      FieldName = 'Grupo'
      Size = 2
    end
  end
end
