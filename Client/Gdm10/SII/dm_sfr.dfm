object SFRecibidasModule: TSFRecibidasModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 197
  Width = 477
  object HTTPRIOFR: THTTPRIO
    OnAfterExecute = HTTPRIOFRAfterExecute
    OnBeforeExecute = HTTPRIOFRBeforeExecute
    WSDLLocation = 
      'http://www.agenciatributaria.es/static_files/AEAT/Contenidos_Com' +
      'unes/La_Agencia_Tributaria/Modelos_y_formularios/Suministro_inme' +
      'diato_informacion/FicherosSuministros/V_1_1/SuministroFactRecibi' +
      'das.wsdl'
    Service = 'siiService'
    Port = 'SuministroFactRecibidas'
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soDocument, soUTF8InHeader, soCacheMimeResponse, soUTF8EncodeXML]
    Converter.Encoding = 'UTF-8'
    Left = 62
    Top = 36
  end
  object ApunteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 206
    Top = 98
  end
  object AsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 206
    Top = 34
  end
  object AsientoFacturaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 366
    Top = 42
  end
end
