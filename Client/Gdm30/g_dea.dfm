object GphDeaForm: TGphDeaForm
  Left = 421
  Top = 282
  HelpType = htKeyword
  HelpKeyword = 'g_dea'
  BorderStyle = bsDialog
  Caption = 'Gr'#225'ficos de datos econ'#243'micos de art'#237'culos'
  ClientHeight = 500
  ClientWidth = 900
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object ArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Familia;Codigo'
    AutoIncFieldName = 'Codigo'
    Left = 12
    Top = 10
    object ArticuloTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Required = True
    end
    object ArticuloTableFamilia: TWideStringField
      FieldName = 'Familia'
      Size = 6
    end
  end
end
