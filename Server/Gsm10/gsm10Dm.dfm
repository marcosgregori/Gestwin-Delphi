object DataModule10: TDataModule10
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 243
  Width = 420
  object Dictionary: TnxeDatabaseDictionary
    AliasPath = 'F:\Desktop\Gestwin\dm10'
    SQLItems = <
      item
        Title = 'Procedures'
        SQLText = '// Test               '#13#10
      end>
    OnBeforeUpdate = DictionaryBeforeUpdate
    OnAfterUpdate = DictionaryAfterUpdate
    Left = 60
    Top = 16
  end
  object SQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'DiarioFacturacion'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Libro SMALLINT,'#13#10'Ejercicio SMALLINT,' +
          #13#10'NroAsiento INTEGER,'#13#10'NroApunte SMALLINT,'#13#10'NroRegistro INTEGER,' +
          #13#10'Serie NVARCHAR(40),'#13#10'NroFactura INTEGER,'#13#10'Fecha DATE,'#13#10'FechaDo' +
          'cumento DATE,'#13#10'Tipo SMALLINT,'#13#10'Nombre NVARCHAR(80),'#13#10'NIF NVARCHA' +
          'R(20),'#13#10'Subcuenta NVARCHAR(9),'#13#10'BaseImponibleIVA BCD(16,4),'#13#10'Tip' +
          'oIVA BCD(16,4),'#13#10'CuotaIVA BCD(16,4),'#13#10'BaseImponibleRE BCD(16,4),' +
          #13#10'TipoRE BCD(16,4),'#13#10'CuotaRE BCD(16,4),'#13#10'Importe BCD(16,4),'#13#10'Nro' +
          'BasesImponibles SMALLINT,'#13#10'TotalCuotas BCD(16,4) ,'#13#10'TotalImporte' +
          ' BCD(16,4),'#13#10#13#10'CONSTRAINT Index0 PRIMARY KEY ( Libro, Ejercicio,' +
          ' NroAsiento, NroApunte, Tipo ) );'#13#10#13#10'CREATE INDEX Index1 ON <Tab' +
          'leName> ( Fecha, NroRegistro );'#13#10'CREATE INDEX Index2 ON <TableNa' +
          'me> ( Serie, Fecha, NroRegistro );'#13#10'CREATE INDEX Index3 ON <Tabl' +
          'eName> ( NroRegistro, Fecha );'#13#10
      end
      item
        Title = 'CabeceraExtracto'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Subcuenta NVARCHAR(9),'#13#10'DescripcionS' +
          'ubcuenta NVARCHAR(120),'#13#10'CentroCoste NVARCHAR(4),'#13#10'DescripcionCe' +
          'ntroCoste NVARCHAR(40),'#13#10'Debe BCD(16,4),'#13#10'Haber BCD(16,4),'#13#10'Sald' +
          'o BCD(16,4) );'#13#10#13#10'CREATE INDEX Index0 ON <TableName> ( Subcuenta' +
          ' );'#13#10
      end
      item
        Title = 'LineasExtracto'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Subcuenta NVARCHAR(9),'#13#10'CentroCoste ' +
          'NVARCHAR(4),'#13#10'Contrapartida NVARCHAR(9),'#13#10'DescripcionContraparti' +
          'da NVARCHAR(120),'#13#10'Ejercicio SMALLINT,'#13#10'NroAsiento INTEGER,'#13#10'Nro' +
          'Apunte SMALLINT,'#13#10'Fecha DATE,'#13#10'Concepto NVARCHAR( 30 ),'#13#10'Debe BC' +
          'D(16,4),'#13#10'Haber BCD(16,4),'#13#10'Saldo BCD(16,4) );'#13#10#13#10'CREATE INDEX I' +
          'ndex0 ON <TableName> ( Subcuenta, Fecha, NroAsiento, NroApunte )' +
          ';'#13#10#13#10
      end
      item
        Title = 'RelacionSaldos'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Cuenta NVARCHAR(9),'#13#10'Periodo SMALLIN' +
          'T,'#13#10'NombrePeriodo NVARCHAR(20),'#13#10'DescripcionCuenta NVARCHAR(120)' +
          ','#13#10'SaldoInicial BCD(16,4),'#13#10'DebePeriodo BCD(16,4),'#13#10'HaberPeriodo' +
          ' BCD(16,4),'#13#10'Orden SMALLINT,'#13#10'Debe BCD(16,4),'#13#10'Haber BCD(16,4),'#13 +
          #10'Saldo BCD(16,4) );'#13#10#13#10'CREATE INDEX Index1 ON <TableName> ( Cuen' +
          'ta );'#13#10'CREATE INDEX Index2 ON <TableName> ( Periodo, Orden, Cuen' +
          'ta );  // Utilizado en l_dir'#13#10'CREATE INDEX Index3 ON <TableName>' +
          ' ( DescripcionCuenta );'#13#10'CREATE INDEX Index4 ON <TableName> ( Sa' +
          'ldo DESC );                                                     ' +
          '                                                         '#13#10
      end
      item
        Title = 'TablaAmortizacion'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Ejercicio SMALLINT,'#13#10'Codigo NVARCHAR' +
          '(9),'#13#10'Importe BCD(16,4),'#13#10'Amortizacion BCD(16,4),'#13#10'Valor BCD(16,' +
          '4),'#13#10'Adiciones BCD(16,4),'#13#10'Bajas BCD(16,4),'#13#10'AplicadoEjercicio B' +
          'CD(16,4),'#13#10'Pendiente BCD(16,4),'#13#10'Tipo BCD(16,4) ,'#13#10'Periodo BCD(1' +
          '6,4),'#13#10'Descripcion NVARCHAR(40),'#13#10'Ubicacion NVARCHAR(30),'#13#10'Fecha' +
          'Compra DATE,'#13#10'CodigoProveedor NVARCHAR(9),'#13#10'DescripcionProveedor' +
          ' NVARCHAR(40),'#13#10'Serie NVARCHAR(40),'#13#10'NroFactura INTEGER,'#13#10'CONSTR' +
          'AINT Index0 PRIMARY KEY ( Codigo, Ejercicio ) );'#13#10
      end
      item
        Title = 'RelacionOperaciones'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'TipoRegistro SMALLINT,'#13#10'Propietario ' +
          'NVARCHAR(9),'#13#10'Nombre NVARCHAR(40),'#13#10'CodigoOrigen NVARCHAR(4),'#13#10'N' +
          'IF NVARCHAR(15),'#13#10'ImporteTrimestre1 BCD(16,4),'#13#10'ImporteTrimestre' +
          '2 BCD(16,4),'#13#10'ImporteTrimestre3 BCD(16,4),'#13#10'ImporteTrimestre4 BC' +
          'D(16,4),'#13#10'ImporteTotalAnual BCD(16,4) );'#13#10#13#10'CREATE INDEX Index1 ' +
          'ON <TableName> ( Propietario );'#13#10'CREATE INDEX Index2 ON <TableNa' +
          'me> ( NIF );    '#13#10
      end
      item
        Title = 'RelacionEfectos'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Ejercicio SMALLINT,'#13#10'Serie NVARCHAR(' +
          '40),'#13#10'NroFactura INTEGER,'#13#10'NroEfecto SMALLINT,'#13#10'FechaVencimiento' +
          ' DATE,'#13#10'FechaLibramiento DATE,'#13#10'FechaCobro DATE,'#13#10'Propietario NV' +
          'ARCHAR(9),'#13#10'Nombre NVarChar(40),'#13#10'Entidad NVARCHAR(9),'#13#10'Descripc' +
          'ion NVARCHAR(40),'#13#10'Concepto NVARCHAR(30),'#13#10'CodigoGrupo NVARCHAR(' +
          ' 9 ),'#13#10'DescripcionGrupo NVARCHAR( 40 ),'#13#10'Importe BCD(16,4),'#13#10'Imp' +
          'orteCobrado BCD(16,4),'#13#10'GastosGestion BCD(16,4),'#13#10'GastosDevoluci' +
          'on BCD(16,4),'#13#10'CodigoFormaCobro NVARCHAR(2),'#13#10'DescripcionFormaCo' +
          'bro NVARCHAR(30) );'#13#10'CREATE INDEX Index0 ON <TableName> ( FechaV' +
          'encimiento, Entidad, Serie, NroFactura, NroEfecto );'#13#10'CREATE IND' +
          'EX Index1 ON <TableName> ( CodigoGrupo, Serie, FechaVencimiento,' +
          ' NroFactura, NroEfecto );'#13#10'CREATE INDEX Index2 ON <TableName> ( ' +
          'CodigoGrupo, Serie, Propietario, FechaVencimiento, NroFactura, N' +
          'roEfecto );'#13#10'CREATE INDEX Index3 ON <TableName> ( Entidad, Fecha' +
          'Vencimiento, Serie, NroFactura, NroEfecto );'#13#10
      end
      item
        Title = 'RelacionFacturas'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Ejercicio SMALLINT,'#13#10'Serie NVARCHAR(' +
          ' 40 ),'#13#10'NroFactura INTEGER,'#13#10'NroEfecto SMALLINT,'#13#10'Fecha DATE,'#13#10'P' +
          'ropietario NVARCHAR(9),'#13#10'NombrePropietario NVARCHAR( 40 ),'#13#10'Enti' +
          'dad NVARCHAR(9),'#13#10'NombreEntidad NVARCHAR(40),'#13#10'Concepto NVARCHAR' +
          '( 30 ),'#13#10'FormaCobro NVARCHAR(2),'#13#10'DescripcionFormaCobro NVARCHAR' +
          '(30),'#13#10'FechaVencimiento DATE,'#13#10'Importe BCD(16,4),'#13#10'ImportePendie' +
          'nte BCD(16,4) );'#13#10#13#10'CREATE INDEX Index0 ON <TableName> ( Serie, ' +
          'Fecha, NroFactura, NroEfecto );'#13#10'CREATE INDEX Index1 ON <TableNa' +
          'me> ( Serie, Ejercicio, NroFactura, NroEfecto );'#13#10'CREATE INDEX I' +
          'ndex2 ON <TableName> ( Serie, Propietario, NroFactura, NroEfecto' +
          ' );'#13#10'CREATE INDEX Index3 ON <TableName> ( Serie, Entidad, NroFac' +
          'tura, NroEfecto );'#13#10'CREATE INDEX Index4 ON <TableName> ( Serie, ' +
          'FormaCobro, NroFactura, NroEfecto );'#13#10'CREATE INDEX Index5 ON <Ta' +
          'bleName> ( Fecha, Propietario, Serie, NroFactura, NroEfecto );'#13#10
      end
      item
        Title = 'CartaRemesa'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'    NroRemesa INTEGER,'#13#10'    Fecha DA' +
          'TE,'#13#10'    SubcuentaEntidad NVARCHAR(9),'#13#10'    CodigoEntidad NVARCH' +
          'AR(2),'#13#10'    Entidad NVARCHAR(40),'#13#10'    Presentador NVARCHAR(30),' +
          #13#10'    NIFPresentador NVARCHAR(10),'#13#10'    EntidadReceptora NVarCha' +
          'r(4),'#13#10'    OficinaReceptora NVARCHAR(4),'#13#10'    EntidadDeposito NV' +
          'ARCHAR(4),'#13#10'    OficinaDeposito NVARCHAR(4),'#13#10'    DCDeposito NVa' +
          'rChar(2),'#13#10'    CuentaDeposito NVARCHAR(10),'#13#10'    FechaVtoInicial' +
          ' DATE,'#13#10'    FechaVtoFinal DATE,'#13#10'    ImporteRemesa BCD(16,4),'#13#10' ' +
          '   CodigoIdentificacion NVARCHAR(15),'#13#10'    NroOrden SmallInt,'#13#10' ' +
          '   NroEfectos SmallInt,'#13#10'    UltimoVencimiento Date'#13#10');'#13#10#13#10'CREAT' +
          'E INDEX Index0 ON <TableName> ( NroRemesa );'#13#10
      end
      item
        Title = 'LineaCartaRemesa'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'    NroRemesa Integer,'#13#10'    FechaVen' +
          'cimiento Date,'#13#10'    Serie NVARCHAR(40),'#13#10'    NroFactura Integer,' +
          #13#10'    NroEfecto SmallInt,'#13#10'    CodigoCliente NVARCHAR(9),'#13#10'    N' +
          'ombreCliente NVARCHAR(30),'#13#10'    Plaza NVARCHAR(30),'#13#10'    Importe' +
          ' BCD(16,4)'#13#10');'#13#10#13#10'CREATE INDEX Index0 ON <TableName> ( NroRemesa' +
          ', FechaVencimiento );'#13#10
      end
      item
        Title = 'Documento'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'    Ejercicio SmallInt,'#13#10'    Serie N' +
          'VARCHAR(40),'#13#10'    NroFactura Integer,'#13#10'    NroEfecto SmallInt,'#13#10 +
          '    Importe BCD(16,4),'#13#10'    ImporteTrimestre1 BCD(16,4),'#13#10'    Im' +
          'porteTrimestre2 BCD(16,4),'#13#10'    ImporteTrimestre3 BCD(16,4) ,'#13#10' ' +
          '   ImporteTrimestre4 BCD(16,4),'#13#10'    ImporteEfectivo BCD(16,4),'#13 +
          #10'    FechaVencimiento Date,'#13#10'    FechaFactura Date,'#13#10'    FechaCa' +
          'rgo Date,'#13#10'    CodigoEntidad NVARCHAR(4),'#13#10'    Entidad NVARCHAR(' +
          '30),'#13#10'    CodigoSucursal NVARCHAR(4),'#13#10'    Sucursal NVARCHAR(30)' +
          ','#13#10'    DC NVARCHAR(2),'#13#10'    CuentaCorriente NVARCHAR(10),'#13#10'    C' +
          'odigo NVARCHAR(5),'#13#10'    Nombre NVARCHAR(40),'#13#10'    Domicilio NVAR' +
          'CHAR(40),'#13#10'    Localidad NVARCHAR(30),'#13#10'    CodigoPostal NVARCHA' +
          'R(5),'#13#10'    Provincia NVARCHAR(30),'#13#10'    NIF NVARCHAR(15),'#13#10'    C' +
          'odigoSubcuenta NVARCHAR(9),'#13#10'    ImporteCifra NVARCHAR(128),'#13#10'  ' +
          '  CodigoBanco NVARCHAR(9),'#13#10'    EjercicioRemesa SmallInt,'#13#10'    N' +
          'roRemesa Integer,'#13#10'    Concepto NVARCHAR(30),'#13#10'    FormaDePago N' +
          'VARCHAR(30)'#13#10');'#13#10#13#10'CREATE INDEX Index1 ON <TableName> ( Ejercici' +
          'o, Serie, NroFactura, NroEfecto );'#13#10'CREATE INDEX Index2 ON <Tabl' +
          'eName> ( CodigoSubcuenta );'#13#10'CREATE INDEX Index3 ON <TableName> ' +
          '( NIF );    '#13#10
      end
      item
        Title = 'RelacionRetenciones'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'TipoRegistro SMALLINT,'#13#10'Serie NVARCH' +
          'AR(40),'#13#10'NroDocumento INTEGER,'#13#10'Fecha DATE,'#13#10'Propietario NVARCHA' +
          'R(9),'#13#10'Nombre NVARCHAR(40),'#13#10'NIF NVARCHAR(15),'#13#10'BaseImponible BC' +
          'D(16,4),'#13#10'Retenedores INTEGER,'#13#10'TipoRetencion SMALLINT,'#13#10'Retenci' +
          'on BCD(16,4),'#13#10'ImporteRetencion BCD(16,4),'#13#10'ImporteFactura BCD(1' +
          '6,4) );'#13#10#13#10'CREATE INDEX Index1 ON <TableName> ( TipoRegistro, Se' +
          'rie, Fecha, NroDocumento );'#13#10'CREATE INDEX Index2 ON <TableName> ' +
          '( TipoRegistro, TipoRetencion );'#13#10'CREATE INDEX Index3 ON <TableN' +
          'ame> ( TipoRegistro, Propietario, Fecha, NroDocumento );'#13#10'CREATE' +
          ' INDEX Index4 ON <TableName> ( Propietario );'#13#10'CREATE INDEX Inde' +
          'x5 ON <TableName> ( NIF );  '#13#10
      end
      item
        Title = 'Balance'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Tipo SMALLINT,'#13#10'Nivel SMALLINT,     ' +
          '                              '#13#10'Cuenta NVARCHAR(9),'#13#10'Descripcion' +
          ' NVARCHAR(120),'#13#10'Debe BCD(16,4),'#13#10'Haber BCD(16,4) );'#13#10#13#10'CREATE I' +
          'NDEX Index0 ON <TableName> ( Tipo, Nivel, Cuenta );  '#13#10
      end>
    Left = 58
    Top = 142
  end
  object SourceTable: TnxeTable
    Timeout = 6000
    TableType = ttRecover
    Left = 177
    Top = 22
  end
  object TargetTable: TnxeTable
    Timeout = 6000
    TableType = ttRecover
    Left = 177
    Top = 84
  end
  object MasterSourceTable: TnxeTable
    Timeout = 6000
    TableType = ttRecover
    Left = 287
    Top = 16
  end
  object RelacionIdsTable: TnxeTable
    Timeout = 6000
    TableType = ttVirtual
    Left = 177
    Top = 158
  end
end
