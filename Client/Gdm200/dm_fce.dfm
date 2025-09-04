object FacturaElectronicaDataModule: TFacturaElectronicaDataModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 569
  Width = 578
  PixelsPerInch = 120
  object PublicKeyHandler: TElPDFPublicKeySecurityHandler
    IgnoreTimestampFailure = False
    Left = 110
    Top = 48
  end
  object XMLDocument: TXMLDocument
    Options = [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix]
    Left = 107
    Top = 128
    DOMVendorDesc = 'MSXML'
  end
  object DmOrganismoPublicoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'OrganismoPublico'
    IndexFieldNames = 'Tipo;Codigo'
    Left = 105
    Top = 225
  end
  object DmMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 313
    Top = 53
  end
  object DmLineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 313
    Top = 229
  end
  object DmGrupoLineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    Left = 313
    Top = 147
  end
  object DmFacturaComprasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaCompras'
    IndexFieldNames = 'Ejercicio;Proveedor;SerieNroFactura'
    Left = 313
    Top = 328
  end
  object DmRegistroFacturaElectronicaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RegistroFacturaElectronica'
    IndexFieldNames = 'Tipo;Ejercicio;Propietario;Serie;NroFactura'
    Left = 318
    Top = 433
  end
end
