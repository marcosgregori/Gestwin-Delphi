object DataModule60: TDataModule60
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 138
  Width = 174
  object Dictionary: TnxeDatabaseDictionary
    Session = DataAccessModule.MainSession
    AliasPath = 'F:\Desktop\Gestwin\dm60'
    TargetDatabase = EnterpriseDataModule.UserDatabase
    SQLItems = <
      item
        Title = 'CreaRutaDistribucion'
        SQLText = 
          #13#10'// B'#225'sicamente se trata de crear la nueva tabla RutaDistribuci' +
          #243'n y de asignar el NroOperacion del registro de RutaDistribucion' +
          ' a'#13#10'// la tabla LineaRutaDistribuci'#243'n, teniendo en cuenta que es' +
          'e campo todav'#237'a no existe en la vieja tabla  '#13#10#13#10'CREATE TABLE Ru' +
          'taDistribucion('#13#10'    NroOperacion AutoInc,'#13#10'    CodigoRuta NVarC' +
          'har(2) NOT NULL,'#13#10'    Fecha Date DEFAULT CURRENT_DATE NOT NULL'#13#10 +
          ');'#13#10'CREATE INDEX I_RutaDistribucion_0 ON RutaDistribucion(NroOpe' +
          'racion);'#13#10'CREATE INDEX I_RutaDistribucion_1 ON RutaDistribucion(' +
          'Fecha, CodigoRuta);'#13#10#13#10'ALTER TABLE LineaRutaDistribucion '#13#10'ADD C' +
          'OLUMN NroOperacion DWORD;'#13#10#13#10'INSERT INTO RutaDistribucion '#13#10'SELE' +
          'CT CAST( NULL AS DWORD ), CodigoRuta, Fecha '#13#10'FROM LineaRutaDist' +
          'ribucion '#13#10'GROUP BY CodigoRuta, Fecha;'#13#10#13#10'UPDATE LineaRutaDistri' +
          'bucion '#13#10'SET NroOperacion=( SELECT NroOperacion '#13#10'              ' +
          '     FROM   RutaDistribucion '#13#10'                   WHERE  RutaDis' +
          'tribucion.CodigoRuta=LineaRutaDistribucion.CodigoRuta AND RutaDi' +
          'stribucion.Fecha=LineaRutaDistribucion.Fecha );  '#13#10'   '#13#10
      end>
    Left = 38
    Top = 18
  end
end
