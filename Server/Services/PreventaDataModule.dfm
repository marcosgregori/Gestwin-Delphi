object PreventaDataModule: TPreventaDataModule
  Tag = 1
  OnDestroy = DataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 396
  Width = 302
  object ClienteTable: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Codigo'
        DataType = ftWideString
        Size = 5
      end
      item
        Name = 'Nombre'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'Domicilio'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'Localidad'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'CodigoPais'
        DataType = ftWideString
        Size = 2
      end
      item
        Name = 'CodigoPostal'
        DataType = ftWideString
        Size = 5
      end
      item
        Name = 'NIF'
        DataType = ftWideString
        Size = 15
      end
      item
        Name = 'Telefono'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Fax'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Envios_Nombre'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'Envios_Domicilio'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'Envios_Localidad'
        DataType = ftWideString
        Size = 30
      end
      item
        Name = 'Envios_CodigoPostal'
        DataType = ftWideString
        Size = 5
      end
      item
        Name = 'Anotacion'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Aviso'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'MostrarAviso'
        DataType = ftBoolean
      end
      item
        Name = 'Contacto1_Nombre'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'Contacto1_Fijo'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Contacto1_Movil'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Contacto2_Nombre'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'Contacto2_Fijo'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Contacto2_Movil'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Contacto3_Nombre'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'Contacto3_Fijo'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Contacto3_Movil'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Factura_Tarifa'
        DataType = ftWideString
        Size = 2
      end
      item
        Name = 'Factura_NoAplicarOfertas'
        DataType = ftBoolean
      end>
    IndexFieldNames = 'Codigo'
    IndexName = '__MT__DEFAULT_'
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '7.84.00 Professional Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    AutoUpdateFieldVariables = False
    Left = 50
    Top = 128
    object ClienteTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object ClienteTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object ClienteTableDomicilio: TWideStringField
      FieldName = 'Domicilio'
      Size = 40
    end
    object ClienteTableLocalidad: TWideStringField
      FieldName = 'Localidad'
      Size = 30
    end
    object ClienteTableCodigoPais: TWideStringField
      FieldName = 'CodigoPais'
      Size = 2
    end
    object ClienteTableCodigoPostal: TWideStringField
      FieldName = 'CodigoPostal'
      Size = 5
    end
    object ClienteTableNIF: TWideStringField
      FieldName = 'NIF'
      Size = 15
    end
    object ClienteTableTelefono: TWideStringField
      FieldName = 'Telefono'
    end
    object ClienteTableFax: TWideStringField
      FieldName = 'Fax'
    end
    object ClienteTableEnvios_Nombre: TWideStringField
      FieldName = 'Envios_Nombre'
      Size = 40
    end
    object ClienteTableEnvios_Domicilio: TWideStringField
      FieldName = 'Envios_Domicilio'
      Size = 40
    end
    object ClienteTableEnvios_Localidad: TWideStringField
      FieldName = 'Envios_Localidad'
      Size = 30
    end
    object ClienteTableEnvios_CodigoPostal: TWideStringField
      FieldName = 'Envios_CodigoPostal'
      Size = 5
    end
    object ClienteTableAnotacion: TWideStringField
      FieldName = 'Anotacion'
      Size = 255
    end
    object ClienteTableAviso: TWideStringField
      FieldName = 'Aviso'
      Size = 255
    end
    object ClienteTableMostrarAviso: TBooleanField
      FieldName = 'MostrarAviso'
    end
    object ClienteTableContacto1_Nombre: TWideStringField
      FieldName = 'Contacto1_Nombre'
      Size = 40
    end
    object ClienteTableContacto1_Fijo: TWideStringField
      FieldName = 'Contacto1_Fijo'
    end
    object ClienteTableContacto1_Movil: TWideStringField
      FieldName = 'Contacto1_Movil'
    end
    object ClienteTableContacto2_Nombre: TWideStringField
      FieldName = 'Contacto2_Nombre'
      Size = 40
    end
    object ClienteTableContacto2_Fijo: TWideStringField
      FieldName = 'Contacto2_Fijo'
    end
    object ClienteTableContacto2_Movil: TWideStringField
      FieldName = 'Contacto2_Movil'
    end
    object ClienteTableContacto3_Nombre: TWideStringField
      FieldName = 'Contacto3_Nombre'
      Size = 40
    end
    object ClienteTableContacto3_Fijo: TWideStringField
      FieldName = 'Contacto3_Fijo'
    end
    object ClienteTableContacto3_Movil: TWideStringField
      FieldName = 'Contacto3_Movil'
    end
    object ClienteTableFactura_Tarifa: TWideStringField
      FieldName = 'Factura_Tarifa'
      Size = 2
    end
    object ClienteTableFactura_NoAplicarOfertas: TBooleanField
      FieldName = 'Factura_NoAplicarOfertas'
    end
  end
  object RutaTable: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Codigo'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 2
      end
      item
        Name = 'NroOrden'
        Attributes = [faRequired]
        DataType = ftSmallint
      end
      item
        Name = 'ClienteDescripcion'
        DataType = ftWideString
        Size = 30
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '7.84.00 Professional Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    AutoUpdateFieldVariables = False
    Left = 46
    Top = 202
    object RutaTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Required = True
      Size = 2
    end
    object RutaTableNroOrden: TSmallintField
      FieldName = 'NroOrden'
      Required = True
    end
    object RutaTableClienteDescripcion: TWideStringField
      FieldName = 'ClienteDescripcion'
      Size = 30
    end
  end
  object ConsumosTable: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'CodigoCliente'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 5
      end
      item
        Name = 'NroOrden'
        Attributes = [faRequired]
        DataType = ftSmallint
      end
      item
        Name = 'CodigoArticulo'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'CodigoClaseA'
        DataType = ftWideString
        Size = 3
      end
      item
        Name = 'CodigoClaseB'
        DataType = ftWideString
        Size = 3
      end
      item
        Name = 'CodigoClaseC'
        DataType = ftWideString
        Size = 3
      end
      item
        Name = 'Cajas'
        DataType = ftBCD
        Precision = 16
        Size = 4
      end
      item
        Name = 'Cantidad'
        DataType = ftBCD
        Precision = 16
        Size = 4
      end
      item
        Name = 'CantidadMedia'
        DataType = ftBCD
        Precision = 16
        Size = 4
      end
      item
        Name = 'UltimoPrecio'
        DataType = ftFloat
      end
      item
        Name = 'Precio'
        DataType = ftFloat
      end
      item
        Name = 'PrecioMedio'
        DataType = ftFloat
      end
      item
        Name = 'UltimoRecargo'
        DataType = ftBCD
        Precision = 16
        Size = 4
      end
      item
        Name = 'Recargo'
        DataType = ftBCD
        Precision = 16
        Size = 4
      end
      item
        Name = 'RecargoMedio'
        DataType = ftBCD
        Precision = 14
        Size = 4
      end
      item
        Name = 'UltimoPuntoVerde'
        DataType = ftBCD
        Precision = 16
        Size = 4
      end
      item
        Name = 'PuntoVerde'
        DataType = ftBCD
        Precision = 16
        Size = 4
      end
      item
        Name = 'UltimoDescuento'
        DataType = ftBCD
        Precision = 16
        Size = 4
      end
      item
        Name = 'Descuento'
        DataType = ftBCD
        Precision = 16
        Size = 4
      end
      item
        Name = 'DescuentoMedio'
        DataType = ftBCD
        Precision = 16
        Size = 4
      end
      item
        Name = 'Fecha'
        DataType = ftDate
      end>
    IndexFieldNames = 'CodigoCliente'
    IndexDefs = <
      item
        Name = 'ConsumosTableIndex1'
        Fields = 'CodigoCliente'
      end>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '7.84.00 Professional Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    AutoUpdateFieldVariables = False
    Left = 44
    Top = 280
    object ConsumosTableCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Required = True
      Size = 5
    end
    object ConsumosTableNroOrden: TSmallintField
      FieldName = 'NroOrden'
      Required = True
    end
    object ConsumosTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object ConsumosTableCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object ConsumosTableCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object ConsumosTableCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object ConsumosTableCajas: TBCDField
      FieldName = 'Cajas'
      Precision = 16
    end
    object ConsumosTableCantidad: TBCDField
      FieldName = 'Cantidad'
      Precision = 16
    end
    object ConsumosTableCantidadMedia: TBCDField
      FieldName = 'CantidadMedia'
      Precision = 16
      Size = 0
    end
    object ConsumosTablePrecioActual: TFloatField
      FieldName = 'PrecioActual'
    end
    object ConsumosTableUltimoPrecio: TFloatField
      FieldName = 'UltimoPrecio'
    end
    object ConsumosTablePrecio: TFloatField
      FieldName = 'Precio'
    end
    object ConsumosTablePrecioMedio: TFloatField
      FieldName = 'PrecioMedio'
    end
    object ConsumosTableUltimoRecargo: TBCDField
      FieldName = 'UltimoRecargo'
      Precision = 16
      Size = 0
    end
    object ConsumosTableRecargo: TBCDField
      FieldName = 'Recargo'
      Precision = 16
    end
    object ConsumosTableRecargoMedio: TBCDField
      FieldName = 'RecargoMedio'
      Precision = 14
      Size = 0
    end
    object ConsumosTableUltimoPuntoVerde: TBCDField
      FieldName = 'UltimoPuntoVerde'
      Precision = 16
      Size = 0
    end
    object ConsumosTablePuntoVerde: TBCDField
      FieldName = 'PuntoVerde'
      Precision = 16
    end
    object ConsumosTableDescuentoActual: TBCDField
      FieldName = 'DescuentoActual'
    end
    object ConsumosTableUltimoDescuento: TBCDField
      FieldName = 'UltimoDescuento'
      Precision = 16
      Size = 0
    end
    object ConsumosTableDescuento: TBCDField
      FieldName = 'Descuento'
      Precision = 16
    end
    object ConsumosTableDescuentoMedio: TBCDField
      FieldName = 'DescuentoMedio'
      Precision = 16
      Size = 0
    end
    object ConsumosTableFecha: TDateField
      FieldName = 'Fecha'
    end
  end
  object DeudaClienteTable: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexFieldNames = 'CodigoCliente'
    IndexDefs = <
      item
        Name = 'DeudaClienteTableIndex1'
        Fields = 'CodigoCliente'
        Options = [ixUnique]
      end>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '7.84.00 Professional Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    AutoUpdateFieldVariables = False
    Left = 176
    Top = 128
    object DeudaClienteTableCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object DeudaClienteTableImporte: TCurrencyField
      FieldName = 'Importe'
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
        Name = 'Descripcion'
        DataType = ftWideString
        Size = 60
      end
      item
        Name = 'Familia'
        DataType = ftWideString
        Size = 3
      end
      item
        Name = 'Precio_Venta'
        DataType = ftFloat
      end
      item
        Name = 'Dto_Venta'
        DataType = ftBCD
        Size = 4
      end
      item
        Name = 'UnidadesPorCaja'
        DataType = ftBCD
        Size = 4
      end
      item
        Name = 'Anotacion'
        DataType = ftWideString
        Size = 20
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
    Left = 50
    Top = 48
    object ArticuloTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Required = True
    end
    object ArticuloTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object ArticuloTableFamilia: TWideStringField
      DisplayWidth = 6
      FieldName = 'Familia'
      Size = 6
    end
    object ArticuloTablePrecio_Venta: TFloatField
      FieldName = 'Precio_Venta'
    end
    object ArticuloTableDto_Venta: TBCDField
      FieldName = 'Dto_Venta'
      Precision = 16
    end
    object ArticuloTableUnidadesPorCaja: TBCDField
      FieldName = 'UnidadesPorCaja'
      Precision = 16
    end
    object ArticuloTableOferta: TBooleanField
      FieldName = 'Oferta'
    end
    object ArticuloTableOfertaPrecioVenta: TFloatField
      FieldName = 'OfertaPrecioVenta'
    end
    object ArticuloTableOfertaDescuento: TBCDField
      FieldName = 'OfertaDescuento'
      Precision = 16
    end
    object ArticuloTableOfertaFechaInicial: TDateField
      FieldName = 'OfertaFechaInicial'
    end
    object ArticuloTableOfertaFechaFinal: TDateField
      FieldName = 'OfertaFechaFinal'
    end
    object ArticuloTableAnotacion: TWideStringField
      FieldName = 'Anotacion'
      Size = 1024
    end
    object ArticuloTableMostrarAviso: TBooleanField
      FieldName = 'MostrarAviso'
    end
    object ArticuloTableAviso: TWideStringField
      FieldName = 'Aviso'
      Size = 1024
    end
  end
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
    Left = 176
    Top = 48
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
end
