object DataModule00: TDataModule00
  OnCreate = AppDataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 430
  Width = 620
  object Dictionary: TnxeDatabaseDictionary
    Session = DataAccessModule.MainSession
    AliasPath = 'F:\Desktop\Gestwin\dm00'
    TargetDatabase = DataAccessModule.AppDatabase
    SQLItems = <>
    Left = 52
    Top = 28
  end
  object DmEmpresaTable: TnxeTable
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Empresa'
    IndexFieldNames = 'Codigo'
    Left = 52
    Top = 84
  end
  object DmUsuarioTable: TnxeTable
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Usuario'
    IndexFieldNames = 'Codigo'
    Left = 52
    Top = 146
  end
  object DmDiarioProcesosTable: TnxeTable
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'DiarioProcesos'
    IndexFieldNames = 'CodigoEmpresa;CodigoUsuario;Tipo;Fecha;Hora'
    Left = 52
    Top = 204
  end
  object NotificacionReport: TgxReportManager
    FileName = 'l_inf'
    HideReportList = False
    SQLItems = <>
    ToPrinter = False
    Left = 52
    Top = 268
  end
  object DmInformeExternoTable: TnxeTable
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'InformeExterno'
    IndexFieldNames = 'TipoDocumento;NroRegistro'
    Left = 180
    Top = 24
  end
  object RecInformeExternoTable: TnxeTable
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'InformeExterno'
    TableType = ttRecover
    Left = 180
    Top = 268
  end
  object SQLSet: TgxSQLSet
    SQLItems = <>
    Left = 52
    Top = 332
  end
  object DmPlanificadorTable: TnxeTable
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Planificador'
    IndexFieldNames = 'Id'
    Left = 342
    Top = 26
    object DmPlanificadorTableID: TUnsignedAutoIncField
      FieldName = 'Id'
    end
    object DmPlanificadorTableIDPadre: TIntegerField
      FieldName = 'IdPadre'
    end
    object DmPlanificadorTableIDRecurso: TWideStringField
      FieldName = 'IdRecurso'
    end
    object DmPlanificadorTableIDEvento: TWideStringField
      FieldName = 'IdEvento'
    end
    object DmPlanificadorTableInicioActual: TDateTimeField
      FieldName = 'InicioActual'
    end
    object DmPlanificadorTableFinalActual: TDateTimeField
      FieldName = 'FinalActual'
    end
    object DmPlanificadorTableTitulo: TWideStringField
      FieldName = 'Titulo'
      Size = 80
    end
    object DmPlanificadorTableTipoDeEvento: TIntegerField
      FieldName = 'TipoDeEvento'
    end
    object DmPlanificadorTableInicio: TDateTimeField
      FieldName = 'Inicio'
    end
    object DmPlanificadorTableFinal: TDateTimeField
      FieldName = 'Final'
    end
    object DmPlanificadorTableColorEtiqueta: TIntegerField
      FieldName = 'ColorEtiqueta'
    end
    object DmPlanificadorTableLugar: TWideStringField
      FieldName = 'Lugar'
      Size = 80
    end
    object DmPlanificadorTableMensaje: TWideStringField
      FieldName = 'Mensaje'
      Size = 512
    end
    object DmPlanificadorTableOpciones: TIntegerField
      FieldName = 'Opciones'
    end
    object DmPlanificadorTableIndiceRecurrencia: TIntegerField
      FieldName = 'IndiceRecurrencia'
    end
    object DmPlanificadorTableInformacionRecurrencia: TBlobField
      FieldName = 'InformacionRecurrencia'
    end
    object DmPlanificadorTableFechaRecordatorio: TDateTimeField
      FieldName = 'FechaRecordatorio'
    end
    object DmPlanificadorTableMinutosAntesEmpezarRecordatorio: TIntegerField
      FieldName = 'MinutosAntesEmpezarRecordatorio'
    end
    object DmPlanificadorTableDatosRecordatorio: TBlobField
      FieldName = 'DatosRecordatorio'
    end
    object DmPlanificadorTableEstado: TIntegerField
      FieldName = 'Estado'
    end
    object DmPlanificadorTableTareaCompletada: TIntegerField
      FieldName = 'TareaCompletada'
    end
    object DmPlanificadorTableTareaIndice: TIntegerField
      FieldName = 'TareaIndice'
    end
    object DmPlanificadorTableTareaEnlaces: TBlobField
      FieldName = 'TareaEnlaces'
    end
    object DmPlanificadorTableTareaEstado: TIntegerField
      FieldName = 'TareaEstado'
    end
  end
  object PlanificadorDataSource: TDataSource
    DataSet = DmPlanificadorTable
    Left = 342
    Top = 156
  end
  object SchedulerDBStorage: TcxSchedulerDBStorage
    UseActualTimeRange = True
    Reminders.Active = False
    Reminders.DefaultReminder = True
    Reminders.ReminderByResource = True
    Reminders.ReminderWindowLookAndFeel.NativeStyle = False
    Reminders.OnAlertReminder = SchedulerDBStorageRemindersAlertReminder
    Resources.Items = <
      item
        Name = 'Usuario'
        ResourceID = '******'
      end>
    Resources.DataSource = RecursosPlanificadorDataSource
    Resources.ResourceColor = 'Color'
    Resources.ResourceID = 'Id'
    Resources.ResourceImageIndex = 'IndiceImagen'
    Resources.ResourceName = 'Nombre'
    SmartRefresh = True
    CustomFields = <
      item
        FieldName = 'IdEvento'
      end>
    Holidays = SchedulerHolidays
    DataSource = PlanificadorDataSource
    FieldNames.ActualFinish = 'FinalActual'
    FieldNames.ActualStart = 'InicioActual'
    FieldNames.Caption = 'Titulo'
    FieldNames.EventType = 'TipoDeEvento'
    FieldNames.Finish = 'Final'
    FieldNames.ID = 'Id'
    FieldNames.LabelColor = 'ColorEtiqueta'
    FieldNames.Location = 'Lugar'
    FieldNames.Message = 'Mensaje'
    FieldNames.Options = 'Opciones'
    FieldNames.ParentID = 'IdPadre'
    FieldNames.RecurrenceIndex = 'IndiceRecurrencia'
    FieldNames.RecurrenceInfo = 'InformacionRecurrencia'
    FieldNames.ReminderDate = 'FechaRecordatorio'
    FieldNames.ReminderMinutesBeforeStart = 'MinutosAnterEmpezarRecordatorio'
    FieldNames.ReminderResourcesData = 'DatosRecordatorio'
    FieldNames.ResourceID = 'IdRecurso'
    FieldNames.Start = 'Inicio'
    FieldNames.State = 'Estado'
    FieldNames.TaskCompleteField = 'TareaCompleta'
    FieldNames.TaskIndexField = 'TareaIndice'
    FieldNames.TaskLinksField = 'TareaEnlaces'
    FieldNames.TaskStatusField = 'TareaEstado'
    UseIndexedID = True
    OnEventInserted = SchedulerDBStorageEventInserted
    Left = 342
    Top = 226
  end
  object SourceTable: TnxeTable
    Timeout = 6000
    Left = 423
    Top = 344
  end
  object TargetTable: TnxeTable
    Timeout = 6000
    Left = 505
    Top = 344
  end
  object DictionaryTable: TnxeTable
    Timeout = 6000
    Left = 340
    Top = 344
  end
  object SchedulerHolidays: TcxSchedulerHolidays
    Locations = <>
    Left = 486
    Top = 228
  end
  object DmRecursosPlanificadorTable: TnxeTable
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'RecursosPlanificador'
    IndexFieldNames = 'Id'
    Left = 482
    Top = 24
    object DmRecursosPlanificadorTableID: TIntegerField
      FieldName = 'Id'
      Required = True
    end
    object DmRecursosPlanificadorTableColor: TIntegerField
      FieldName = 'Color'
    end
    object DmRecursosPlanificadorTableIndiceImagen: TIntegerField
      FieldName = 'IndiceImagen'
    end
    object DmRecursosPlanificadorTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 255
    end
  end
  object RecursosPlanificadorDataSource: TDataSource
    DataSet = DmRecursosPlanificadorTable
    Left = 484
    Top = 158
  end
  object DmPlanificadorAuxTable: TnxeTable
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Planificador'
    IndexFieldNames = 'IdEvento'
    Left = 340
    Top = 88
  end
end
