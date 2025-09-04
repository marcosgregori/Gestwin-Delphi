object WebServiceDataModule: TWebServiceDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 225
  Width = 365
  object ApplicationSQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'EdicionProvincia'
        SQLText = 
          'SELECT Provincia.*, Pais.Nombre AS NombrePais'#13#10'FROM   Provincia ' +
          'INNER JOIN Pais ON ( Pais.Codigo=CodigoPais )'#13#10'  '#13#10
      end>
    Left = 60
    Top = 32
  end
end
