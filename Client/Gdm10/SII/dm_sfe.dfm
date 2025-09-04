object SFEmitidasModule: TSFEmitidasModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 177
  Width = 477
  object HTTPRIOFE: THTTPRIO
    OnAfterExecute = HTTPRIOFEAfterExecute
    OnBeforeExecute = HTTPRIOFEBeforeExecute
    WSDLLocation = 
      'http://www.agenciatributaria.es/static_files/AEAT/Contenidos_Com' +
      'unes/La_Agencia_Tributaria/Modelos_y_formularios/Suministro_inme' +
      'diato_informacion/FicherosSuministros/V_1_1/SuministroFactEmitid' +
      'as.wsdl'
    Service = 'siiService'
    Port = 'SuministroFactEmitidas'
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soDocument, soUTF8InHeader, soCacheMimeResponse, soUTF8EncodeXML]
    Converter.Encoding = 'UTF-8'
    Left = 56
    Top = 32
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
