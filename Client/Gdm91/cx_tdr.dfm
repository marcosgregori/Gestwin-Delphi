object CxTdrForm: TCxTdrForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de tarjetas de registro'
  ClientHeight = 244
  ClientWidth = 812
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  KeyPreview = True
  OldCreateOrder = True
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
  object queryPanel: TgQueryPanel
    Left = 0
    Top = 215
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryNombre
    SourceField = QueryNroRegistro
    SourceQuery = Query
    Height = 29
    Width = 812
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 812
    Height = 215
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    ExplicitWidth = 684
    object TableView: TcxGridDBTableView
      Tag = 564314448
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
      OptionsBehavior.IncSearchItem = TableViewNroRegistro
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
      object TableViewNroRegistro: TcxGridDBColumn
        Caption = 'N'#186' Registro'
        DataBinding.FieldName = 'NroRegistro'
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 65
      end
      object TableViewTextoAplicacion: TcxGridDBColumn
        Caption = 'Aplicaci'#243'n'
        DataBinding.FieldName = 'TextoAplicacion'
        Width = 220
      end
      object TableViewCodigoGestion: TcxGridDBColumn
        Caption = 'C'#243'd.'
        DataBinding.FieldName = 'CodigoGestion'
        Width = 40
      end
      object TableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
        Width = 260
      end
      object TableViewDomicilio: TcxGridDBColumn
        DataBinding.FieldName = 'Domicilio'
        Visible = False
      end
      object TableViewLocalidad: TcxGridDBColumn
        DataBinding.FieldName = 'Localidad'
        Visible = False
      end
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object Query: TnxQuery
    Database = EnterpriseDataModule.UserDatabase
    OnCalcFields = QueryCalcFields
    SQL.Strings = (
      
        'SELECT NroRegistro, Aplicacion, CodigoGestion, Nombre, Domicilio' +
        ', Localidad'
      'FROM   TarjetaRegistro'
      'ORDER BY NroRegistro')
    Left = 214
    Top = 78
    object QueryNroRegistro: TIntegerField
      FieldName = 'NroRegistro'
    end
    object QueryAplicacion: TSmallintField
      FieldName = 'Aplicacion'
    end
    object QueryTextoAplicacion: TWideStringField
      DisplayWidth = 40
      FieldKind = fkCalculated
      FieldName = 'TextoAplicacion'
      Size = 40
      Calculated = True
    end
    object QueryCodigoGestion: TWideStringField
      FieldName = 'CodigoGestion'
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
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 216
    Top = 108
  end
end
