object DataModule10: TDataModule10
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 264
  Width = 242
  PixelsPerInch = 144
  object Dictionary: TnxeDatabaseDictionary
    Session = DataAccessModule.MainSession
    AliasPath = 'F:\V11.0\Gestwin\dm10'
    TargetDatabase = EnterpriseDataModule.UserDatabase
    SQLItems = <
      item
        Title = 'Procedures'
        SQLText = '// Test               '#13#10
      end>
    Left = 90
    Top = 24
  end
  object SQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'DiarioFacturacion'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Libro SMALLINT,'#13#10'Ejercicio SMALLINT,' +
          #13#10'NroAsiento INTEGER,'#13#10'NroApunte SMALLINT,'#13#10'NroRegistro INTEGER,' +
          #13#10'Serie NVARCHAR(40),'#13#10'NroFactura INTEGER,'#13#10'Fecha DATE,'#13#10'FechaDo' +
          'cumento DATE,                                             '#13#10'Tipo' +
          ' SMALLINT,'#13#10'CodigoPais NVARCHAR(3),'#13#10'NombrePais  NVARCHAR(40),  ' +
          '                      '#13#10'Propietario NVARCHAR(9),                ' +
          '                '#13#10'Nombre NVARCHAR(80),'#13#10'NIF NVARCHAR(20),'#13#10'Subcu' +
          'enta NVARCHAR(9),'#13#10'BaseImponibleIVA BCD(16,4),'#13#10'TipoIVA BCD(16,4' +
          '),'#13#10'CuotaIVA BCD(16,4),'#13#10'BaseImponibleRE BCD(16,4),'#13#10'TipoRE BCD(' +
          '16,4),'#13#10'CuotaRE BCD(16,4),'#13#10'Importe BCD(16,4),'#13#10'BaseImponibleCaj' +
          'a BCD(16,4),'#13#10'CuotaIVACaja BCD(16,4),'#13#10'ImporteCaja BCD(16,4),   ' +
          ' '#13#10'FechaCobro DATE,'#13#10'CodigoMedioCobro NVARCHAR(1),    '#13#10'Concepto' +
          'Cobro NVARCHAR(80),'#13#10'CCC NVARCHAR(35),      '#13#10'NroBasesImponibles' +
          ' SMALLINT,'#13#10'TotalCuotas BCD(16,4),'#13#10'TotalImporte BCD(16,4),'#13#10'   ' +
          '                                '#13#10'CONSTRAINT Index0 PRIMARY KEY ' +
          '( Libro, Ejercicio, NroAsiento, NroApunte, Tipo ) );'#13#10#13#10'CREATE I' +
          'NDEX Index1 ON <TableName> ( Fecha, NroRegistro );'#13#10'CREATE INDEX' +
          ' Index2 ON <TableName> ( Serie, Fecha, NroRegistro );'#13#10'CREATE IN' +
          'DEX Index3 ON <TableName> ( NroRegistro, Fecha );'#13#10'CREATE INDEX ' +
          'Index4 ON <TableName> ( Propietario, Fecha, NroRegistro );'#13#10'CREA' +
          'TE INDEX Index5 ON <TableName> ( CodigoPais, NroRegistro );    '#13 +
          #10
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
          'Apunte SMALLINT,'#13#10'Fecha DATE,'#13#10'Concepto NVARCHAR( 80 ),'#13#10'Debe BC' +
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
          'CD(16,4),'#13#10'Pendiente BCD(16,4),'#13#10'Tipo BCD(16,4),'#13#10'Periodo BCD(16' +
          ',4),'#13#10'Descripcion NVARCHAR(40),'#13#10'Ubicacion NVARCHAR(30),'#13#10'FechaC' +
          'ompra DATE,'#13#10'CodigoProveedor NVARCHAR(9),'#13#10'DescripcionProveedor ' +
          'NVARCHAR(40),'#13#10'SerieNroFactura NVARCHAR(40),'#13#10'CONSTRAINT Index0 ' +
          'PRIMARY KEY ( Codigo, Ejercicio ) );'#13#10
      end
      item
        Title = 'DeclaracionOperaciones'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'TipoRegistro SMALLINT,'#13#10'CodigoAgrupa' +
          'cion NVARCHAR(20),                                        '#13#10'Prop' +
          'ietario NVARCHAR(9),'#13#10'Nombre NVARCHAR(40),'#13#10'CriterioCaja  BOOLEA' +
          'N,                                                 '#13#10'CodigoOrige' +
          'n NVARCHAR(4),'#13#10'OrigenOperacion SMALLINT,                       ' +
          '                                                     '#13#10'NIF NVARC' +
          'HAR(17),'#13#10'ImporteTrimestre1 BCD(16,4),'#13#10'ImporteTrimestre2 BCD(16' +
          ',4),'#13#10'ImporteTrimestre3 BCD(16,4),'#13#10'ImporteTrimestre4 BCD(16,4),' +
          #13#10'ImporteTotalAnual BCD(16,4),'#13#10'ImporteEfectivoCriterioCaja BCD(' +
          '16,4),    '#13#10'ImporteTotalCriterioCaja BCD(16,4) );'#13#10#13#10'CREATE INDE' +
          'X Index1 ON <TableName> ( TipoRegistro, CodigoAgrupacion );'#13#10'CRE' +
          'ATE INDEX Index2 ON <TableName> ( TipoRegistro, NIF );      '#13#10
      end
      item
        Title = 'RelacionEfectos'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Ejercicio SMALLINT,'#13#10'Serie NVARCHAR(' +
          '40),'#13#10'NroFactura INTEGER,'#13#10'NroEfecto SMALLINT,'#13#10'FechaVencimiento' +
          ' DATE,'#13#10'FechaLibramiento DATE,'#13#10'FechaCobro DATE,'#13#10'Propietario NV' +
          'ARCHAR(9),'#13#10'Nombre NVarChar(40),'#13#10'Entidad NVARCHAR(9),'#13#10'Descripc' +
          'ion NVARCHAR(40),'#13#10'Concepto NVARCHAR(80),'#13#10'CodigoGrupo NVARCHAR(' +
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
          '( 80 ),'#13#10'FormaCobro NVARCHAR(2),'#13#10'DescripcionFormaCobro NVARCHAR' +
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
          ','#13#10'    DC NVARCHAR(2),'#13#10'    CuentaCorriente NVARCHAR(10),'#13#10'    B' +
          'IC NVARCHAR(11),        '#13#10'    IBAN NVARCHAR(34),        '#13#10'    Co' +
          'digo NVARCHAR(5),'#13#10'    Nombre NVARCHAR(40),'#13#10'    Domicilio NVARC' +
          'HAR(40),'#13#10'    Localidad NVARCHAR(30),'#13#10'    CodigoPostal NVARCHAR' +
          '(5),'#13#10'    Provincia NVARCHAR(30),'#13#10'    CodigoAgrupacion NVARCHAR' +
          '(20),        '#13#10'    NIF NVARCHAR(17),'#13#10'    CodigoSubcuenta NVARCH' +
          'AR(9),'#13#10'    ImporteCifra NVARCHAR(128),'#13#10'    CodigoBanco NVARCHA' +
          'R(9),'#13#10'    EjercicioRemesa SmallInt,'#13#10'    NroRemesa Integer,'#13#10'  ' +
          '  Concepto NVARCHAR(30),'#13#10'    FormaDePago NVARCHAR(30)'#13#10');'#13#10#13#10'CR' +
          'EATE INDEX Index1 ON <TableName> ( Ejercicio, Serie, NroFactura,' +
          ' NroEfecto );'#13#10'CREATE INDEX Index2 ON <TableName> ( CodigoSubcue' +
          'nta );'#13#10'CREATE INDEX Index3 ON <TableName> ( NIF );'#13#10'CREATE INDE' +
          'X Index4 ON <TableName> ( CodigoAgrupacion );    '#13#10
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
          'x5 ON <TableName> ( NIF );'#13#10'CREATE INDEX Index6 ON <TableName> (' +
          ' TipoRegistro, Fecha, NroDocumento );    '#13#10'    '#13#10
      end
      item
        Title = 'Balance'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Tipo SMALLINT,'#13#10'Nivel SMALLINT,'#13#10'Cod' +
          'igo NVARCHAR(3),                   '#13#10'Cuenta NVARCHAR(9),'#13#10'Descri' +
          'pcion NVARCHAR(120),'#13#10'Debe BCD(16,4),'#13#10'Haber BCD(16,4) );'#13#10#13#10'CRE' +
          'ATE INDEX Index0 ON <TableName> ( Tipo, Nivel, Cuenta );  '#13#10'CREA' +
          'TE INDEX Index1 ON <TableName> ( Codigo );'#13#10#13#10
      end
      item
        Title = 'OrdenDomiciliacion'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'    Codigo NVARCHAR(5),'#13#10'    Nombre ' +
          'NVARCHAR(40),'#13#10'    Domicilio NVARCHAR(40),'#13#10'    Localidad NVARCH' +
          'AR(30),'#13#10'    CodigoPais NVARCHAR(3),'#13#10'    NombrePais NVARCHAR(30' +
          '),'#13#10'    CP NVARCHAR(5),'#13#10'    Provincia NVARCHAR(30),'#13#10'    Refere' +
          'nciaMandato NVARCHAR(35),'#13#10'    SwiftBIC NVARCHAR(11),'#13#10'    IBAN ' +
          'NVARCHAR(35)      '#13#10');  '#13#10
      end
      item
        Title = 'LiquidacionIVA'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Modelo SMALLINT,'#13#10'Tipo SMALLINT,'#13#10'No' +
          'mbre NVARCHAR(256),'#13#10'BaseImponibleIVA BCD(16,4),'#13#10'TipoIVA BCD(16' +
          ',4),'#13#10'CuotaIVA BCD(16,4),'#13#10'                                   '#13#10 +
          'CONSTRAINT Index0 PRIMARY KEY ( Modelo, Tipo ) );'#13#10'  '#13#10
      end
      item
        Title = 'OperacionesIntracomunitarias'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10#13#10'Ejercicio SMALLINT,'#13#10'TipoRegistro ' +
          'SMALLINT,  // 0 = Adquisiciones y rectificaciones en el periodo,' +
          ' 1 = Rectificaciones de facturas de periodos anteriorres        ' +
          '                                                                ' +
          '                                                                ' +
          '                                                                ' +
          '                             '#13#10'ClaveOperacion NVARCHAR(1),  '#13#10'NI' +
          'F NVARCHAR(17),                                     '#13#10'Subcuenta ' +
          'NVARCHAR(9),'#13#10'NombreOperador NVARCHAR(40),                      ' +
          '                   '#13#10'BaseImponible BCD(16,4),'#13#10'EjercicioRectific' +
          'acion SMALLINT,'#13#10'SerieFacturaRectificada NVARCHAR(40),'#13#10'NroFactu' +
          'raRectificada INTEGER,    '#13#10'FechaRectificacion DATE,'#13#10'BaseImponi' +
          'bleRectificada BCD(16,4),'#13#10'BaseImponibleAnterior BCD(16,4),     ' +
          '                                           '#13#10'  '#13#10'CONSTRAINT Inde' +
          'x0 PRIMARY KEY ( Ejercicio, TipoRegistro, ClaveOperacion, NIF ) ' +
          ');'#13#10#13#10'  '#13#10
      end>
    Left = 90
    Top = 129
  end
end
