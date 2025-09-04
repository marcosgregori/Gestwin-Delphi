object CapturadorDataModule: TCapturadorDataModule
  Tag = 1
  OnDestroy = DataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 371
  Width = 270
  object ClaseTable: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Codigo'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Descripcion'
        DataType = ftWideString
        Size = 60
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = True
    SavedCompletely = False
    FilterOptions = []
    Version = '7.84.00 Professional Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    AutoUpdateFieldVariables = False
    Left = 34
    Top = 24
    object ClaseTableNroClase: TSmallintField
      FieldName = 'NroClase'
    end
    object ClaseTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Required = True
    end
    object ClaseTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
  end
  object ArticuloTable: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Codigo'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'CodigoBarras'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Descripcion'
        DataType = ftWideString
        Size = 60
      end
      item
        Name = 'Precio_Venta'
        DataType = ftFloat
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = True
    SavedCompletely = False
    FilterOptions = []
    Version = '7.84.00 Professional Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    AutoUpdateFieldVariables = False
    Left = 34
    Top = 94
    object ArticuloTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Required = True
    end
    object ArticuloTableCodigoBarras: TWideStringField
      FieldName = 'CodigoBarras'
    end
    object ArticuloTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object ArticuloTablePrecio_Venta: TFloatField
      FieldName = 'Precio_Venta'
    end
    object ArticuloTableUbicacion: TStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
  end
end
