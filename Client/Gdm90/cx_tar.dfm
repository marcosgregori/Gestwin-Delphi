object CxTarForm: TCxTarForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de tareas'
  ClientHeight = 178
  ClientWidth = 776
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
    Top = 149
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryNombre
    SourceField = QueryNroTarea
    FixedRangeField = QueryFecha
    SourceQuery = Query
    Height = 29
    Width = 776
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 776
    Height = 149
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 369595008
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
      OptionsBehavior.IncSearchItem = TableViewNroTarea
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
      object TableViewNroTarea: TcxGridDBColumn
        Caption = 'N'#186
        DataBinding.FieldName = 'NroTarea'
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 63
      end
      object TableViewFecha: TcxGridDBColumn
        DataBinding.FieldName = 'Fecha'
        Width = 68
      end
      object TableViewCodigoCliente: TcxGridDBColumn
        Caption = 'C'#243'd.'
        DataBinding.FieldName = 'CodigoCliente'
        Width = 50
      end
      object TableViewNombre: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'Nombre'
        Width = 211
      end
      object TableViewCodigoTecnico: TcxGridDBColumn
        Caption = 'T'#233'c.'
        DataBinding.FieldName = 'CodigoTecnico'
        Width = 34
      end
      object TableViewUrgente: TcxGridDBColumn
        Caption = 'Urg.'
        DataBinding.FieldName = 'Urgente'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssUnchecked
        Width = 34
      end
      object TableViewAsunto: TcxGridDBColumn
        DataBinding.FieldName = 'Asunto'
        Width = 245
      end
      object TableViewFechaResolucion: TcxGridDBColumn
        Caption = 'Resoluci'#243'n'
        DataBinding.FieldName = 'FechaResolucion'
        Width = 71
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
      'SELECT   Tarea.*, Cliente.Nombre'
      'FROM     Tarea'
      
        '         LEFT JOIN Cliente ON ( Tarea.CodigoCliente=Cliente.Cod' +
        'igo )'
      'ORDER BY Tarea.Fecha, Tarea.NroTarea')
    Left = 468
    Top = 34
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object QueryNroTarea: TIntegerField
      FieldName = 'NroTarea'
    end
    object QueryEstado: TSmallintField
      FieldName = 'Estado'
    end
    object QueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object QueryCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object QueryCodigoTecnico: TWideStringField
      FieldName = 'CodigoTecnico'
      Size = 2
    end
    object QueryUrgente: TBooleanField
      FieldName = 'Urgente'
    end
    object QueryCodigoTipoTarea: TWideStringField
      FieldName = 'CodigoTipoTarea'
      Size = 2
    end
    object QueryAsunto: TWideStringField
      FieldName = 'Asunto'
      Size = 80
    end
    object QueryFechaResolucion: TDateField
      FieldName = 'FechaResolucion'
    end
    object QueryTiempo: TLongWordField
      FieldName = 'Tiempo'
    end
    object QueryDuracion: TTimeField
      FieldName = 'Duracion'
    end
    object QueryResolucion: TWideStringField
      FieldName = 'Resolucion'
      Size = 80
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 438
    Top = 34
  end
end
