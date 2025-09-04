object divisaModule: TdivisaModule
  Tag = 1
  OldCreateOrder = False
  OnDestroy = divisaModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 113
  Width = 130
  object DmDivisaTable: TnxeTable
    Timeout = 6000
    TableName = 'Divisa'
    IndexFieldNames = 'Codigo'
    Left = 42
    Top = 22
    object DmDivisaTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 3
    end
    object DmDivisaTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object DmDivisaTablePrecisionRedondeo: TFloatField
      FieldName = 'PrecisionRedondeo'
    end
    object DmDivisaTableCambioFijo: TBooleanField
      FieldName = 'CambioFijo'
    end
    object DmDivisaTableTipoCambio: TFloatField
      FieldName = 'TipoCambio'
    end
  end
end
