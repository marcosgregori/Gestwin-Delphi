object CxCntForm: TCxCntForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de contactos'
  ClientHeight = 199
  ClientWidth = 359
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  KeyPreview = True
  OldCreateOrder = True
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object queryPanel: TgQueryPanel
    Left = 0
    Top = 170
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryNombre
    SourceField = QueryCodigo
    SourceQuery = Query
    Height = 29
    Width = 359
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 359
    Height = 170
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    ExplicitWidth = 349
    object TableView: TcxGridDBTableView
      Tag = 564316032
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Position = fpTop
      FilterBox.Visible = fvNever
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataModeController.GridMode = True
      DataController.DataSource = DataSource
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = TableViewCodigo
      OptionsBehavior.FocusCellOnCycle = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Styles.ContentEven = ApplicationForms.QueryContentEvenStyle
      object TableViewCodigo: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'Codigo'
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 47
      end
      object TableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
        Width = 302
      end
      object TableViewDomicilio: TcxGridDBColumn
        DataBinding.FieldName = 'Domicilio'
        Visible = False
      end
      object TableViewLocalidad: TcxGridDBColumn
        DataBinding.FieldName = 'Localidad'
        Visible = False
      end
      object TableViewTelefono: TcxGridDBColumn
        DataBinding.FieldName = 'Telefono'
        Visible = False
      end
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object Query: TnxQuery
    Database = EnterpriseDataModule.UserDatabase
    SQL.Strings = (
      'SELECT Codigo, Nombre, Domicilio, Localidad, Telefono'
      'FROM   Contacto'
      'WHERE Codigo LIKE :CodigoOrigen '
      'ORDER BY Codigo')
    Left = 212
    Top = 78
    ParamData = <
      item
        DataType = ftWideString
        Name = 'CodigoOrigen'
        ParamType = ptInput
        Size = 5
        Value = '%'
      end>
    object QueryCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object QueryDomicilio: TWideStringField
      FieldName = 'Domicilio'
      Size = 40
    end
    object QueryLocalidad: TWideStringField
      FieldName = 'Localidad'
      Size = 30
    end
    object QueryTelefono: TWideStringField
      FieldName = 'Telefono'
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
end
