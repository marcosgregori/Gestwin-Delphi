object SessionDataModule: TSessionDataModule
  OnCreate = DataModuleCreate
  Height = 271
  Width = 460
  PixelsPerInch = 120
  object EmpresaTable: TnxeTable
    Timeout = 6000
    TableName = 'Empresa'
    IndexFieldNames = 'Codigo'
    Left = 85
    Top = 50
  end
  object UsuarioTable: TnxeTable
    Timeout = 6000
    TableName = 'Usuario'
    IndexFieldNames = 'Codigo'
    Left = 80
    Top = 145
  end
  object BackupDatabase: TnxeDatabase
    Left = 248
    Top = 145
  end
end
