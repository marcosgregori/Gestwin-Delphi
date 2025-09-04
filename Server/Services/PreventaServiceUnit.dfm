object PreventaService: TPreventaService
  OnCreate = kbmMWQueryServiceCreate
  OnDestroy = kbmMWQueryServiceDestroy
  GatherStatistics = False
  AllowClientStatement = False
  AllowClientKeyFields = False
  AllowClientNamedQuery = False
  AllowClientTableName = False
  AllowClientSchemaName = False
  TransportStreamFormat = JONStreamFormat
  Height = 350
  Width = 293
  PixelsPerInch = 144
  object JONStreamFormat: TkbmMWJSONStreamFormat
    Version = '4.20'
    sfDeltas = []
    sfCalculated = []
    sfLookup = []
    sfObjectNotation = []
    VersionName = 'version'
    DefinitionName = 'definition'
    DataName = 'data'
    RowIDName = 'id'
    UTFFormat = mwfUTF8
    Left = 102
    Top = 48
  end
  object MovimientosData: TnxeTable
    Session = BaseSessionDataModule.DBSession
    Timeout = 6000
    TableName = 'MovimientosData'
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'MovimientosDataIndex1'
        Fields = 'IdRegistro;GrupoLinea'
        Options = [ixPrimary]
      end>
    IndexFieldNames = 'IdRegistro;GrupoLinea'
    AutoIncFieldName = 'NroLinea'
    TableType = ttVirtual
    Left = 99
    Top = 162
    object MovimientosDataIdRegistro: TIntegerField
      FieldName = 'IdRegistro'
    end
    object MovimientosDataIdLinea: TIntegerField
      FieldName = 'IdLinea'
    end
    object MovimientosDataUUID: TStringField
      FieldName = 'UUID'
      Size = 60
    end
    object MovimientosDataTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object MovimientosDataGrupoLinea: TSmallintField
      FieldName = 'GrupoLinea'
    end
    object MovimientosDataFechaMovimiento: TDateField
      FieldName = 'FechaMovimiento'
    end
    object MovimientosDataFechaEntrega: TDateField
      FieldName = 'FechaEntrega'
    end
    object MovimientosDataCreado: TDateTimeField
      FieldName = 'Creado'
    end
    object MovimientosDataCodigoCliente: TStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object MovimientosDataEntrega: TBCDField
      FieldName = 'Entrega'
    end
    object MovimientosDataCodigoArticulo: TStringField
      FieldName = 'CodigoArticulo'
    end
    object MovimientosDataCodigoClaseA: TStringField
      FieldName = 'CodigoClaseA'
      Size = 5
    end
    object MovimientosDataCodigoClaseB: TStringField
      FieldName = 'CodigoClaseB'
      Size = 5
    end
    object MovimientosDataCodigoClaseC: TStringField
      FieldName = 'CodigoClaseC'
      Size = 5
    end
    object MovimientosDataDescripcion: TStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object MovimientosDataNroCajas: TBCDField
      FieldName = 'NroCajas'
    end
    object MovimientosDataCantidad: TBCDField
      FieldName = 'Cantidad'
    end
    object MovimientosDataPrecio: TFloatField
      FieldName = 'Precio'
    end
    object MovimientosDataRecargo: TBCDField
      FieldName = 'Recargo'
    end
    object MovimientosDataDescuento: TBCDField
      FieldName = 'Descuento'
    end
    object MovimientosDataAnotacion: TnxMemoField
      FieldName = 'Anotacion'
      BlobType = ftMemo
    end
    object MovimientosDataFirma: TMemoField
      FieldName = 'Firma'
      BlobType = ftMemo
    end
  end
end
