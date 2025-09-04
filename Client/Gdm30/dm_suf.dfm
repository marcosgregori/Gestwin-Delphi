object SuministroFacturasModule: TSuministroFacturasModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 265
  Width = 429
  PixelsPerInch = 120
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 233
    Top = 130
  end
  object FacturaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    Left = 233
    Top = 50
  end
  object HttpRio: TclHttpRio
    OnBeforeExecute = HttpRioBeforeExecute
    Options = [soSendMultiRefObj, soTryAllSchema, soUTF8InHeader, soUTF8EncodeXML]
    HttpClient = Http
    UserAgent = 'CleverComponents SOAP 1.0'
    CharSet = 'utf-8'
    Left = 78
    Top = 43
  end
  object Http: TclHttp
    CertChainFlags = [rfDisableRootAutoUpdate]
    OnGetCertificate = HttpGetCertificate
    UserAgent = 'Mozilla/4.0 (compatible; Clever Internet Suite)'
    OnReceiveResponse = HttpReceiveResponse
    Left = 78
    Top = 133
  end
end
