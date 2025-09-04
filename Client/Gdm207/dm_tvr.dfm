object TiendaVirtualModule: TTiendaVirtualModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 235
  Width = 208
  object DmTarifaVentasTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaVentas'
    IndexFieldNames = 'CodigoArticulo;Tipo;CodigoTarifa'
    Left = 69
    Top = 35
  end
  object DmClaseTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Clase'
    IndexFieldNames = 'NroClase;Descripcion'
    Left = 70
    Top = 104
  end
end
