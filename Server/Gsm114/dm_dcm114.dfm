object DocumentoControlMercanciasModule: TDocumentoControlMercanciasModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 268
  Width = 430
  object DmDocumentoControlMercanciasAuxTable: TnxeTable
    Timeout = 15000
    TableName = 'DocumentoControlMercancias'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 96
    Top = 42
  end
end
