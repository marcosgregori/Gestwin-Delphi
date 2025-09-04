object ExportImportModule: TExportImportModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 648
  Width = 1116
  PixelsPerInch = 144
  object DmDireccionCorreoTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'DireccionCorreo'
    IndexFieldNames = 'Codigo'
    Left = 867
    Top = 189
  end
  object ZipForge: TZipForge
    ExtractCorruptedFiles = False
    CompressionLevel = clNormal
    CompressionMode = 6
    CurrentVersion = '6.93 '
    SpanningMode = smNone
    SpanningOptions.AdvancedNaming = True
    SpanningOptions.FirstVolumeSize = 0
    SpanningOptions.VolumeSize = vsAutoDetect
    SpanningOptions.CustomVolumeSize = 65536
    Options.StorePath = spNoPath
    Options.FlushBuffers = True
    Options.OEMFileNames = True
    InMemory = False
    OnOverallProgress = ZipForgeOverallProgress
    OnProcessFileFailure = ZipForgeProcessFileFailure
    Zip64Mode = zmAuto
    UnicodeFilenames = True
    EncryptionMethod = caPkzipClassic
    Left = 669
    Top = 108
  end
  object DmCorreoTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Correo'
    IndexFieldNames = 'CodigoEmpresa;CodigoUsuario;Carpeta;Tipo'
    Left = 867
    Top = 276
  end
  object CorreoEntranteDataset: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 867
    Top = 369
    object CorreoEntranteDatasetIndice: TIntegerField
      FieldName = 'Indice'
    end
    object CorreoEntranteDatasetAsunto: TStringField
      FieldName = 'Asunto'
      Size = 128
    end
    object CorreoEntranteDatasetRemitente: TStringField
      FieldName = 'Remitente'
      Size = 128
    end
    object CorreoEntranteDatasetDestinatario: TWideStringField
      FieldName = 'Destinatario'
      Size = 128
    end
    object CorreoEntranteDatasetFecha: TDateField
      FieldName = 'Fecha'
    end
    object CorreoEntranteDatasetHora: TTimeField
      FieldName = 'Hora'
    end
    object CorreoEntranteDatasetSeleccionado: TBooleanField
      FieldName = 'Seleccionado'
    end
    object CorreoEntranteDatasetParametros: TMemoField
      FieldName = 'Parametros'
      BlobType = ftWideMemo
    end
    object CorreoEntranteDatasetIndiceClase: TSmallintField
      FieldName = 'IndiceClase'
    end
  end
  object OutgoingMailMessage: TclMailMessage
    ToList = <>
    CCList = <>
    BCCList = <>
    Date = 44541.320007511570000000
    CharSet = 'utf-8'
    ContentType = 'text/plain'
    Left = 123
    Top = 90
  end
  object Pop3: TclPop3
    TLSFlags = [tfUseTLS, tfUseTLS11, tfUseTLS12, tfUseTLS13]
    OnVerifyServer = Pop3VerifyServer
    CharSet = 'utf-8'
    Left = 261
    Top = 90
  end
  object Imap4: TclImap4
    TLSFlags = [tfUseTLS, tfUseTLS11, tfUseTLS12, tfUseTLS13]
    OnVerifyServer = Imap4VerifyServer
    CharSet = 'utf-8'
    Left = 261
    Top = 189
  end
  object Smtp: TclSmtp
    UseSystemTLSFlags = False
    OnVerifyServer = SmtpVerifyServer
    CharSet = 'utf-8'
    MailAgent = 'Gestwin'
    Left = 261
    Top = 300
  end
  object OAuth: TclOAuth
    Request = HttpRequest
    HttpServer = SimpleHttpServer
    UserAgent = 'Gestwin OAUTH 2.0'
    EnterCodeFormCaption = 'Introduzca el c'#243'digo de autorizaci'#243'n'
    SuccessHtmlResponse = 
      '<html><body><h3 style="color:green;margin:30px;text-align:center' +
      ';">Autorizaci'#243'n OAuth conseguida!</h3></body></html>'
    FailedHtmlResponse = 
      '<html><body><h3 style="color:red;margin:30px;text-align:center;"' +
      '>La autorizaci'#243'n OAuth ha fallado!</h3></body></html>'
    OnLaunchBrowser = OAuthLaunchBrowser
    Left = 264
    Top = 414
  end
  object DmConfiguracionCorreoTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'ConfiguracionCorreo'
    IndexFieldNames = 'CodigoEmpresa;CodigoUsuario'
    Left = 867
    Top = 105
  end
  object IncomingMailMessage: TclMailMessage
    ToList = <>
    CCList = <>
    BCCList = <>
    Date = 44541.320007511570000000
    CharSet = 'utf-8'
    ContentType = 'text/plain'
    OnSaveAttachment = IncomingMailMessageSaveAttachment
    Left = 120
    Top = 186
  end
  object HttpRequest: TclHttpRequest
    Header.Accept = '*/*'
    Left = 117
    Top = 414
  end
  object SimpleHttpServer: TclSimpleHttpServer
    ServerName = 'Clever Internet Suite HTTP service'
    Left = 117
    Top = 516
  end
  object FtpClient: TclFtp
    OnProgress = FtpClientProgress
    PassiveMode = True
    Left = 510
    Top = 108
  end
end
