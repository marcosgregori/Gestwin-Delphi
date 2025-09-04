object SaldosModule: TSaldosModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 441
  Width = 557
  PixelsPerInch = 144
  object DmSaldosTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Saldos'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    Left = 105
    Top = 50
  end
  object DmAsientoTable: TnxeTable
    Database = EnterpriseDataModule.Database
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 105
    Top = 251
  end
  object DmApunteTable: TnxeTable
    Database = EnterpriseDataModule.Database
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 293
    Top = 251
  end
  object DmExtractoQuery: TnxeQuery
    Timeout = 180000
    SQL.Strings = (
      'SELECT Ejercicio,'
      '       NroAsiento,'
      '       NroApunte,'
      '       Fecha,'
      '       Subcuenta,'
      '       CentroCoste,'
      '       Contrapartida,'
      '       Debe,'
      '       Haber'
      'FROM   Apunte'
      
        'WHERE  Subcuenta LIKE :SearchSubcuenta AND ( :TodosLosCentrosCos' +
        'te OR CentroCoste=:CentroCoste ) AND Apunte.Fecha BETWEEN :Fecha' +
        'Inicial AND :FechaFinal'
      'ORDER BY Fecha, NroAsiento, NroApunte')
    Left = 293
    Top = 50
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchSubcuenta'
        ParamType = ptUnknown
      end
      item
        DataType = ftBoolean
        Name = 'TodosLosCentrosCoste'
        ParamType = ptUnknown
        Value = False
      end
      item
        DataType = ftWideString
        Name = 'CentroCoste'
        ParamType = ptUnknown
        Value = ''
      end
      item
        DataType = ftDate
        Name = 'FechaInicial'
        ParamType = ptUnknown
        Value = 38353d
      end
      item
        DataType = ftDate
        Name = 'FechaFinal'
        ParamType = ptUnknown
        Value = 39082d
      end>
    object DmExtractoQueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object DmExtractoQueryNroAsiento: TIntegerField
      FieldName = 'NroAsiento'
    end
    object DmExtractoQueryNroApunte: TSmallintField
      FieldName = 'NroApunte'
    end
    object DmExtractoQueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object DmExtractoQuerySubcuenta: TWideStringField
      FieldName = 'Subcuenta'
      Size = 9
    end
    object DmExtractoQueryCentroCoste: TWideStringField
      FieldName = 'CentroCoste'
      Size = 3
    end
    object DmExtractoQueryContrapartida: TWideStringField
      FieldName = 'Contrapartida'
      Size = 9
    end
    object DmExtractoQueryDebe: TBCDField
      FieldName = 'Debe'
    end
    object DmExtractoQueryHaber: TBCDField
      FieldName = 'Haber'
    end
  end
  object SQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'Extracto'
        SQLText = 
          'SELECT'#13#10'Ejercicio,'#13#10'NroAsiento,'#13#10'NroApunte,'#13#10'Fecha,'#13#10'Subcuenta,'#13 +
          #10'CentroCoste,'#13#10'Contrapartida,'#13#10'Debe,'#13#10'Haber'#13#10'FROM'#13#10'Apunte'#13#10#13#10
      end>
    Left = 108
    Top = 153
  end
end
