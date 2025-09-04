object RptLcv105Module: TRptLcv105Module
  Tag = 1
  OnCreate = DataModuleCreate
  Height = 103
  Width = 197
  object VendedoresFacturaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'VendedoresFactura'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    AutoIncFieldName = 'NroRegistro'
    Left = 76
    Top = 16
    object VendedoresFacturaTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object VendedoresFacturaTableSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object VendedoresFacturaTableNroFactura: TIntegerField
      FieldName = 'NroFactura'
    end
    object VendedoresFacturaTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
    end
    object VendedoresFacturaTableCodigoVendedor: TWideStringField
      FieldName = 'CodigoVendedor'
      Size = 2
    end
    object VendedoresFacturaTableNombre: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Nombre'
      Size = 30
      Calculated = True
    end
    object VendedoresFacturaTableImporteBase: TBCDField
      FieldName = 'ImporteBase'
      Precision = 16
    end
    object VendedoresFacturaTableComision: TBCDField
      FieldName = 'Comision'
      Precision = 16
    end
  end
end
