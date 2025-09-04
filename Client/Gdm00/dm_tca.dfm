object TipoCambioModule: TTipoCambioModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 134
  Width = 160
  object DmTipoCambioTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'TipoCambio'
    IndexFieldNames = 'Fecha;CodigoDivisa'
    Left = 46
    Top = 30
    object DmTipoCambioTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object DmTipoCambioTableCodigoDivisa: TWideStringField
      FieldName = 'CodigoDivisa'
      Size = 3
    end
    object DmTipoCambioTableTipoCambio: TFloatField
      FieldName = 'TipoCambio'
    end
  end
end
