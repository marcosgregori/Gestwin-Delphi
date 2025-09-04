object cxMdcForm: TcxMdcForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de movimientos de caja'
  ClientHeight = 204
  ClientWidth = 530
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 17
  object queryPanel: TgQueryPanel
    Left = 0
    Top = 175
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SourceQuery = Query
    ExplicitTop = 170
    Height = 29
    Width = 530
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 530
    Height = 175
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    ExplicitWidth = 523
    ExplicitHeight = 170
    object TableView: TcxGridDBTableView
      Tag = 369592104
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Position = fpTop
      FilterBox.Visible = fvNever
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataModeController.GridMode = True
      DataController.DataSource = dataSource
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = TableViewNroOperacion
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
      object TableViewSerie: TcxGridDBColumn
        Caption = 'Se.'
        DataBinding.FieldName = 'Serie'
        Visible = False
      end
      object TableViewNroOperacion: TcxGridDBColumn
        Caption = 'N'#186' Operac.'
        DataBinding.FieldName = 'NroOperacion'
      end
      object TableViewFecha: TcxGridDBColumn
        DataBinding.FieldName = 'Fecha'
      end
      object TableViewOperacion: TcxGridDBColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'Operacion'
      end
      object TableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
      end
      object TableViewImporte: TcxGridDBColumn
        DataBinding.FieldName = 'Importe'
        PropertiesClassName = 'TcxCurrencyEditProperties'
      end
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object Query: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'SELECT Ejercicio,'
      '       Serie,'
      '       NroOperacion,'
      '       Fecha,'
      
        '       CASE WHEN TipoOperacion=0 THEN CAST( '#39'Ingreso en caja'#39' AS' +
        ' NVARCHAR ) ELSE CAST( '#39'Pago por caja'#39' AS NVARCHAR ) END AS Oper' +
        'acion,'
      '       Descripcion,'
      '       Importe'
      'FROM MovimientoCaja'
      'WHERE{ ( :TodasLasSeries OR ( Serie=:Serie ) ) }'
      'ORDER BY Ejercicio, Serie, NroOperacion')
    Left = 470
    Top = 34
    ParamData = <
      item
        DataType = ftBoolean
        Name = 'TodasLasSeries'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'Serie'
        ParamType = ptUnknown
      end>
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object QuerySerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object QueryNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object QueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object QueryOperacion: TWideStringField
      FieldName = 'Operacion'
      Size = 15
    end
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 35
    end
    object QueryImporte: TBCDField
      FieldName = 'Importe'
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 438
    Top = 34
  end
end
