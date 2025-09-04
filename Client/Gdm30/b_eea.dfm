object brwEeaForm: TbrwEeaForm
  Left = 461
  Top = 257
  HelpType = htKeyword
  HelpKeyword = 'b_eea'
  BorderStyle = bsDialog
  Caption = 'Consulta de existencias actuales en todos los almacenes'
  ClientHeight = 450
  ClientWidth = 642
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      642
      143)
    Height = 143
    Width = 642
    object CodigoArticuloCtrl: TcxDBTextEdit
      Left = 110
      Top = 6
      DescriptionLabel = DescArticuloLabel
      DataBinding.DataField = 'CodigoArticulo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
      TabOrder = 0
      Width = 102
    end
    object CodigoClaseACtrl: TcxDBTextEdit
      Tag = 1
      Left = 110
      Top = 58
      CaptionLabel = capClaseALabel
      DescriptionLabel = descClaseALabel
      DataBinding.DataField = 'CodigoClaseA'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseACtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 2
      Width = 32
    end
    object CodigoClaseBCtrl: TcxDBTextEdit
      Tag = 2
      Left = 110
      Top = 85
      CaptionLabel = capClaseBLabel
      DescriptionLabel = descClaseBLabel
      DataBinding.DataField = 'CodigoClaseB'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseACtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 3
      Width = 32
    end
    object CodigoClaseCCtrl: TcxDBTextEdit
      Tag = 3
      Left = 110
      Top = 112
      CaptionLabel = capClaseCLabel
      DescriptionLabel = descClaseCLabel
      DataBinding.DataField = 'CodigoClaseC'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseACtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 4
      Width = 32
    end
    object TodasLasClasesCtrl: TcxDBCheckBox
      Left = 5
      Top = 32
      AutoSize = False
      Caption = 'Todas las clases'
      DataBinding.DataField = 'TodasLasClases'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = TodasLasClasesCtrlPropertiesEditValueChanged
      TabOrder = 1
      Transparent = True
      Height = 25
      Width = 122
    end
    object codigoCtrlCaption: TcxLabel
      Left = 9
      Top = 10
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object DescArticuloLabel: TcxLabel
      Left = 227
      Top = 10
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
      Height = 19
      Width = 386
    end
    object capClaseALabel: TcxLabel
      Left = 9
      Top = 61
      Caption = 'Clase A '
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
    end
    object capClaseBLabel: TcxLabel
      Left = 9
      Top = 88
      Caption = 'Clase B'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
    end
    object descClaseALabel: TcxLabel
      Left = 227
      Top = 61
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
      Height = 19
      Width = 265
    end
    object descClaseBLabel: TcxLabel
      Left = 227
      Top = 88
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
      Height = 19
      Width = 265
    end
    object capClaseCLabel: TcxLabel
      Left = 9
      Top = 115
      Caption = 'Clase C'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
    end
    object descClaseCLabel: TcxLabel
      Left = 227
      Top = 115
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
      Height = 19
      Width = 265
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 143
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 271
    Width = 632
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 622
      Height = 261
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = cxcbsNone
      TabOrder = 0
      object TableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        FilterBox.CustomizeDialog = False
        FilterBox.Visible = fvNever
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = GridDataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,##.00'
            Kind = skSum
            Column = TableViewEntradas
          end
          item
            Format = '#,##.00'
            Kind = skSum
            Column = TableViewSalidas
          end
          item
            Format = '#,##.00'
            Kind = skSum
            Column = TableViewExistencias
          end>
        DataController.Summary.SummaryGroups = <>
        Filtering.MRUItemsList = False
        Filtering.ColumnMRUItemsList = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.ScrollBars = ssNone
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object TableViewCodigo: TcxGridDBColumn
          Caption = 'C'#243'd.'
          DataBinding.FieldName = 'Codigo'
          Width = 25
        end
        object TableViewNombre: TcxGridDBColumn
          Caption = 'Almac'#233'n'
          DataBinding.FieldName = 'Nombre'
          Width = 200
        end
        object TableViewEntradas: TcxGridDBColumn
          DataBinding.FieldName = 'Entradas'
          Width = 80
        end
        object TableViewSalidas: TcxGridDBColumn
          DataBinding.FieldName = 'Salidas'
          Width = 80
        end
        object TableViewExistencias: TcxGridDBColumn
          DataBinding.FieldName = 'Existencias'
          Width = 80
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 414
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      642
      36)
    Height = 36
    Width = 642
    object Panel3: TcxGroupBox
      Left = 235
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 174
      object OkButton: TgBitBtn
        Left = 1
        Top = 1
        Width = 85
        Height = 28
        Caption = '&Aceptar'
        Enabled = True
        ModalResult = 1
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 0
        GlyphBitmap = gmOk
      end
      object CloseButton: TgBitBtn
        Left = 88
        Top = 1
        Width = 85
        Height = 28
        Cancel = True
        Caption = '&Cerrar'
        Enabled = True
        ModalResult = 2
        OptionsImage.ImageIndex = 7
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 1
        GlyphBitmap = gmClose
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstKeyControl = CodigoArticuloCtrl
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 581
    Top = 4
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 549
    Top = 4
    object DataCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object DataTodasLasClases: TBooleanField
      FieldName = 'TodasLasClases'
    end
    object DataCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object DataCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object DataCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object DataTodosLosAlmacenes: TBooleanField
      FieldName = 'TodosLosAlmacenes'
    end
    object DataCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object DataUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 518
    Top = 4
  end
  object AlmacenTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Almacen'
    IndexFieldNames = 'Codigo'
    Left = 484
    Top = 4
  end
  object GridData: TgxMemData
    Active = True
    Indexes = <
      item
        FieldName = 'Codigo'
        SortOptions = []
      end>
    SortOptions = []
    Left = 549
    Top = 36
    object GridDataCodigo: TStringField
      FieldName = 'Codigo'
      Size = 2
    end
    object GridDataNombre: TStringField
      FieldName = 'Nombre'
      Size = 60
    end
    object GridDataEntradas: TBCDField
      FieldName = 'Entradas'
    end
    object GridDataSalidas: TBCDField
      FieldName = 'Salidas'
    end
    object GridDataExistencias: TBCDField
      FieldName = 'Existencias'
    end
  end
  object GridDataSource: TDataSource
    DataSet = GridData
    Left = 519
    Top = 35
  end
end
