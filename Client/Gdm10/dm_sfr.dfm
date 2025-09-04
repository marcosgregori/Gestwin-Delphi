object SFRecibidasModule: TSFRecibidasModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 309
  Width = 719
  PixelsPerInch = 144
  object ApunteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 309
    Top = 147
  end
  object AsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 309
    Top = 51
  end
  object AsientoFacturaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 549
    Top = 63
  end
  object HttpRio: TclHttpRio
    OnBeforeExecute = HttpRioBeforeExecute
    Options = [soSendMultiRefObj, soTryAllSchema, soUTF8InHeader, soUTF8EncodeXML]
    HttpClient = Http
    UserAgent = 'CleverComponents SOAP 1.0'
    CharSet = 'utf-8'
    Left = 93
    Top = 51
  end
  object Http: TclHttp
    CertChainFlags = [rfDisableRootAutoUpdate]
    OnGetCertificate = HttpGetCertificate
    UserAgent = 'Mozilla/4.0 (compatible; Clever Internet Suite)'
    OnReceiveResponse = HttpReceiveResponse
    Left = 93
    Top = 159
  end
end
