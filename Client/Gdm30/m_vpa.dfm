object VpaQueryModule: TVpaQueryModule
  OnInitialize = PersistentQueryModuleInitialize
  OnUpdate = PersistentQueryModuleUpdate
  Height = 216
  Width = 299
  object SQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'SELECT  CodigoCliente AS Propietario, '#13#10'        Periodicidad, '#13#10 +
          '        MesPago, '#13#10'        NoAplicar, '#13#10'        UltimaAplicacion' +
          ', '#13#10'        RegistroAuxiliar,'#13#10'        LineaVentaPeriodica.*,'#13#10' ' +
          '       Cliente.Nombre AS PropietarioNombre,'#13#10'        CAST( 0.0 A' +
          'S BCD(16,4) ) AS ImporteBruto,'#13#10'        CAST( 0.0 AS BCD(16,4) )' +
          ' AS ImporteDescuento,'#13#10'        CAST( 0.0 AS BCD(16,4) ) AS Impor' +
          'teNeto,'#13#10'        CAST( False AS BOOLEAN ) AS Procesada          ' +
          '                  '#13#10#13#10'FROM VentaPeriodica'#13#10'     LEFT JOIN LineaV' +
          'entaPeriodica ON ( VentaPeriodica.NroFicha=LineaVentaPeriodica.N' +
          'roFicha )'#13#10'     LEFT JOIN Cliente ON ( VentaPeriodica.CodigoClie' +
          'nte=Cliente.Codigo )'#13#10'WHERE <Seleccion>'#13#10#13#10'  '#13#10
      end>
    Left = 55
    Top = 31
  end
end
