object SincronizacionTiendaMagentoModule: TSincronizacionTiendaMagentoModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 1194
  Width = 1314
  PixelsPerInch = 144
  object DmCategoriaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Categoria'
    IndexFieldNames = 'Codigo'
    Left = 485
    Top = 36
  end
  object DmArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 485
    Top = 140
  end
  object DmMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 761
    Top = 36
  end
  object DmLineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 752
    Top = 248
  end
  object DmClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    AutoIncFieldName = 'Codigo'
    Left = 488
    Top = 434
  end
  object DmClienteQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'SELECT Codigo, Nombre, EMail'
      'FROM Cliente'
      'WHERE TiendaVirtual AND NOT Obsoleto')
    Left = 488
    Top = 539
    object DmClienteQueryCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object DmClienteQueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 60
    end
    object DmClienteQueryEMail: TWideStringField
      FieldName = 'EMail'
      Size = 80
    end
  end
  object DmTiposIVATable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TiposIVA'
    IndexFieldNames = 'FechaAplicacion;CodigoPais;Codigo'
    Left = 488
    Top = 642
  end
  object DmClaseTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Clase'
    IndexFieldNames = 'NroClase;NroOrden'
    Left = 755
    Top = 642
  end
  object DmArticulosRelacionadosTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ArticulosRelacionados'
    IndexFieldNames = 'Codigo;Tipo;NroOrden'
    Left = 488
    Top = 747
  end
  object DmRegistroActualizacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RegistroActualizacion'
    IndexFieldNames = 'TipoRegistro;Codigo'
    Left = 1103
    Top = 36
  end
  object NivelesCategoriaTable: TnxMemTable
    Database = SessionDataModule.InMemoryDatabase
    StoreDefs = True
    FieldDefs = <
      item
        Name = 'Nivel'
        DataType = ftSmallint
      end
      item
        Name = 'Codigo'
        DataType = ftString
        Size = 5
      end>
    IndexDefs = <
      item
        Name = 'Sequential Access Index'
        Options = [ixUnique, ixDescending, ixCaseInsensitive]
      end
      item
        Name = 'Index0'
        Fields = 'Nivel'
        Options = [ixPrimary]
      end>
    TableName = 'NivelesCategoria'
    Left = 275
    Top = 248
    object NivelesCategoriaTableNivel: TSmallintField
      FieldName = 'Nivel'
    end
    object NivelesCategoriaTableCodigo: TnxStringField
      FieldName = 'Codigo'
      Size = 5
    end
  end
  object CategoriaAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Categoria'
    IndexFieldNames = 'Codigo'
    Left = 272
    Top = 344
    object CategoriaAuxTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object CategoriaAuxTableCodigoPadre: TWideStringField
      FieldName = 'CodigoPadre'
      Size = 5
    end
  end
  object DmLineaMovimientoOrigenTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'TipoMovimientoOrigen;EjercicioOrigen;NroOperacionOrigen'
    Left = 755
    Top = 344
  end
  object DmMovimientoOrigenTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 761
    Top = 140
  end
  object DmClasesArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ClasesArticulo'
    IndexFieldNames = 'CodigoArticulo;NroClase;CodigoClase'
    Left = 491
    Top = 851
  end
  object DmRegistroActualizacionAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RegistroActualizacion'
    IndexFieldNames = 'TipoRegistro;Actualizado;Codigo'
    Left = 1103
    Top = 140
  end
  object Encoder: TclEncoder
    SuppressCrlf = True
    CharSet = 'utf-8'
    Left = 66
    Top = 36
  end
  object DmTarifaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaVentas'
    IndexFieldNames = 'Tipo;CodigoTarifa;CodigoArticulo'
    Left = 494
    Top = 956
  end
  object DmFamiliaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Familia'
    IndexFieldNames = 'Codigo'
    Left = 494
    Top = 1061
  end
  object DmClaseAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Clase'
    IndexFieldNames = 'NroClase;NroOrden'
    Left = 755
    Top = 747
  end
  object DmArticuloAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 485
    Top = 248
  end
  object DmCategoriasArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'CategoriasArticulo'
    IndexFieldNames = 'CodigoArticulo;NroOrden;CodigoCategoria'
    Left = 488
    Top = 344
  end
end
