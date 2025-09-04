object HojasDePedido120Module: THojasDePedido120Module
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 395
  Width = 312
  object DmRelacionDocumentosTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RelacionDocumentos'
    IndexFieldNames = 'Tipo;NroOperacion'
    Left = 76
    Top = 26
  end
  object DmLineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 74
    Top = 165
  end
  object DmLineaMovimientoDestinoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'NroRegistroOrigen'
    Left = 70
    Top = 285
  end
  object DmMovimientoDestinoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 74
    Top = 224
  end
  object SQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'HojaPedido'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Ejercicio SMALLINT,'#13#10'Serie NVARCHAR(' +
          '2),'#13#10'NroDocumento INTEGER,'#13#10'NroOperacion INTEGER,  '#13#10'Fecha DATE,' +
          #13#10'FechaEntrega DATE,'#13#10'CodigoCliente  NVARCHAR(5),'#13#10'NombreCliente' +
          ' NVARCHAR(60),'#13#10'NroLinea SMALLINT,    '#13#10'CodigoArticulo NVARCHAR(' +
          '20),'#13#10'CodigoClaseA NVARCHAR(3),'#13#10'CodigoClaseB NVARCHAR(3),'#13#10'Codi' +
          'goClaseC NVARCHAR(3),    '#13#10'Descripcion NVARCHAR(60),'#13#10'CodigoAlma' +
          'cen NVARCHAR(2),    '#13#10'NombreAlmacen NVARCHAR(30),'#13#10'Cantidad BCD(' +
          '16,4),'#13#10'Servido BCD(16,4),    '#13#10'Precio Double Precision,'#13#10'Import' +
          'eBruto BCD(16,4),    '#13#10'Descuento BCD(16,4),'#13#10'Recargo BCD(16,4),'#13 +
          #10'ImporteNeto BCD(16,4),'#13#10'Existencias BCD(16,4),'#13#10'ExistenciasVirt' +
          'uales BCD(16,4),'#13#10'  '#13#10'Ejercicio1 SMALLINT,'#13#10'Serie1 NVARCHAR(2),'#13 +
          #10'NroDocumento1 INTEGER,'#13#10'NroOperacion1 INTEGER,'#13#10'CodigoProveedor' +
          ' NVARCHAR(5),'#13#10'NombreProveedor NVARCHAR(60),'#13#10'Recibido BCD(16,4)' +
          ',  '#13#10'  '#13#10'Ejercicio2 SMALLINT,'#13#10'Serie2 NVARCHAR(2),'#13#10'NroDocumento' +
          '2 INTEGER,'#13#10'NroOperacion2 INTEGER,    '#13#10'PrecioCompra BCD(16,4) )' +
          ';'#13#10#13#10'CREATE INDEX Index1 ON <TableName> ( Ejercicio, Serie, NroD' +
          'ocumento, CodigoProveedor, NroLinea );'#13#10'CREATE INDEX Index2 ON <' +
          'TableName> ( Fecha, Serie, NroDocumento, CodigoProveedor, NroLin' +
          'ea );'#13#10'  '#13#10
      end>
    Left = 222
    Top = 28
  end
  object DmMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 74
    Top = 96
  end
end
