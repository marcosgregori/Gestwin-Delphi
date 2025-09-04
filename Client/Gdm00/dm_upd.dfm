object ActualizacionModule: TActualizacionModule
  OnDestroy = DataModuleDestroy
  Height = 215
  Width = 292
  object AsientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    AutoIncFieldName = 'NroAsiento'
    RemoteEdit = True
    Left = 38
    Top = 24
    object AsientoTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
      Required = True
    end
  end
end
