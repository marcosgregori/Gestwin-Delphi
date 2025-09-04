object BrwEdaForm: TBrwEdaForm
  Left = 461
  Top = 257
  HelpType = htKeyword
  HelpKeyword = 'b_eda'
  BorderStyle = bsDialog
  Caption = 'Consulta de existencias mensuales'
  ClientHeight = 557
  ClientWidth = 745
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
      745
      141)
    Height = 141
    Width = 745
    object CodigoArticuloCtrl: TcxDBTextEdit
      Left = 115
      Top = 7
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
      Left = 115
      Top = 59
      CaptionLabel = capClaseALabel
      DescriptionLabel = DescClaseALabel
      AutoSize = False
      DataBinding.DataField = 'CodigoClaseA'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 2
      Height = 25
      Width = 33
    end
    object CodigoClaseBCtrl: TcxDBTextEdit
      Tag = 2
      Left = 115
      Top = 86
      CaptionLabel = capClaseBLabel
      DescriptionLabel = DescClaseBLabel
      AutoSize = False
      DataBinding.DataField = 'CodigoClaseB'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 3
      Height = 25
      Width = 33
    end
    object CodigoAlmacenCtrl: TcxDBTextEdit
      Left = 455
      Top = 59
      CaptionLabel = Label1
      DescriptionLabel = DescAlmacenLabel
      Anchors = [akTop, akRight]
      DataBinding.DataField = 'CodigoAlmacen'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = CodigoAlmacenCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoAlmacenCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoAlmacenCtrlPropertiesValidate
      TabOrder = 6
      Width = 25
    end
    object CodigoClaseCCtrl: TcxDBTextEdit
      Tag = 3
      Left = 115
      Top = 113
      CaptionLabel = capClaseCLabel
      DescriptionLabel = DescClaseCLabel
      AutoSize = False
      DataBinding.DataField = 'CodigoClaseC'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 4
      Height = 25
      Width = 33
    end
    object UbicacionCtrl: TcxDBTextEdit
      Left = 455
      Top = 113
      CaptionLabel = Label10
      DescriptionLabel = Label11
      Anchors = [akTop, akRight]
      DataBinding.DataField = 'Ubicacion'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = UbicacionCtrlPropertiesQueryRequest
      Properties.OnEditRequest = UbicacionCtrlPropertiesEditRequest
      Properties.OnValidate = UbicacionCtrlPropertiesValidate
      TabOrder = 8
      Width = 53
    end
    object TodasLasClasesCtrl: TcxDBCheckBox
      Left = 8
      Top = 33
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
      Width = 124
    end
    object TodosLosAlmacenesCtrl: TcxDBCheckBox
      Left = 317
      Top = 33
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Todos los almacenes'
      DataBinding.DataField = 'TodosLosAlmacenes'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = TodosLosAlmacenesCtrlPropertiesEditValueChange
      TabOrder = 5
      Transparent = True
      Height = 25
      Width = 155
    end
    object TodasLasUbicacionesCtrl: TcxDBCheckBox
      Left = 317
      Top = 86
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Todas las ubicaciones'
      DataBinding.DataField = 'TodasLasUbicaciones'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = TodasLasUbicacionesCtrlPropertiesEditValueChanged
      TabOrder = 7
      Transparent = True
      Height = 25
      Width = 155
    end
    object codigoCtrlCaption: TcxLabel
      Left = 12
      Top = 10
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object DescArticuloLabel: TcxLabel
      Left = 232
      Top = 10
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
      Height = 19
      Width = 489
    end
    object capClaseALabel: TcxLabel
      Left = 12
      Top = 62
      Caption = 'Clase A '
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
    end
    object capClaseBLabel: TcxLabel
      Left = 12
      Top = 89
      Caption = 'Clase B'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
    end
    object DescClaseALabel: TcxLabel
      Left = 154
      Top = 63
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
      Height = 19
      Width = 158
    end
    object DescClaseBLabel: TcxLabel
      Left = 154
      Top = 89
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 14
      Transparent = True
      Height = 19
      Width = 158
    end
    object DescAlmacenLabel: TcxLabel
      Left = 518
      Top = 62
      Anchors = [akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 15
      Transparent = True
      Height = 19
      Width = 180
    end
    object capClaseCLabel: TcxLabel
      Left = 12
      Top = 116
      Caption = 'Clase C'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 16
      Transparent = True
    end
    object DescClaseCLabel: TcxLabel
      Left = 154
      Top = 116
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 17
      Transparent = True
      Height = 19
      Width = 158
    end
    object Label10: TcxLabel
      Left = 321
      Top = 116
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Ubicaci'#243'n'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 18
      Transparent = True
      Height = 17
      Width = 57
    end
    object Label11: TcxLabel
      Left = 518
      Top = 116
      Anchors = [akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 19
      Transparent = True
      Height = 19
      Width = 180
    end
    object Label1: TcxLabel
      Left = 321
      Top = 63
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Almac'#233'n'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 20
      Transparent = True
      Height = 17
      Width = 49
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 146
    Margins.Left = 5
    Margins.Top = 5
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
    PanelKind = epInputPanel
    DesignSize = (
      735
      375)
    Height = 375
    Width = 735
    object Label3: TcxLabel
      Left = 8
      Top = 41
      Caption = #218'ltima entrada'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 0
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 8
      Top = 122
      Caption = #218'ltima salida'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object UltimoCosteLabel: TcxLabel
      Left = 8
      Top = 68
      Caption = #218'ltimo coste'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
    object CosteMedioLabel: TcxLabel
      Left = 8
      Top = 95
      Caption = 'Coste medio'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 8
      Top = 14
      Caption = 'Pendiente de recibir'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 8
      Top = 149
      Caption = 'Pendiente de servir'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 8
      Top = 176
      Caption = 'Existencias virtuales'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
    end
    object Grid: TcxGrid
      Left = 230
      Top = 9
      Width = 497
      Height = 360
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = cxcbsNone
      TabOrder = 7
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
        object TableViewPeriodo: TcxGridDBColumn
          DataBinding.FieldName = 'Periodo'
          DataBinding.IsNullValueType = True
          Visible = False
        end
        object TableViewNombrePeriodo: TcxGridDBColumn
          Caption = 'Periodo'
          DataBinding.FieldName = 'NombrePeriodo'
          Width = 65
        end
        object TableViewEntradas: TcxGridDBColumn
          DataBinding.FieldName = 'Entradas'
        end
        object TableViewSalidas: TcxGridDBColumn
          DataBinding.FieldName = 'Salidas'
        end
        object TableViewSaldo: TcxGridDBColumn
          Caption = 'Existencias'
          DataBinding.FieldName = 'Saldo'
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
    object PendienteRecibirBox: TcxLabel
      Left = 133
      Top = 11
      AutoSize = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 8
      Transparent = True
      Height = 25
      Width = 84
      AnchorX = 217
      AnchorY = 24
    end
    object PendienteServirBox: TcxLabel
      Left = 133
      Top = 146
      AutoSize = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 9
      Transparent = True
      Height = 25
      Width = 84
      AnchorX = 217
      AnchorY = 159
    end
    object CosteMedioBox: TcxLabel
      Left = 133
      Top = 92
      AutoSize = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 10
      Transparent = True
      Height = 25
      Width = 84
      AnchorX = 217
      AnchorY = 105
    end
    object UltimaSalidaBox: TcxLabel
      Left = 133
      Top = 119
      AutoSize = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Vert = taVCenter
      TabOrder = 11
      Transparent = True
      Height = 25
      Width = 74
      AnchorY = 132
    end
    object UltimoCosteBox: TcxLabel
      Left = 133
      Top = 65
      AutoSize = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 12
      Transparent = True
      Height = 25
      Width = 84
      AnchorX = 217
      AnchorY = 78
    end
    object UltimaEntradaBox: TcxLabel
      Left = 133
      Top = 38
      AutoSize = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Vert = taVCenter
      TabOrder = 13
      Transparent = True
      Height = 25
      Width = 74
      AnchorY = 51
    end
    object ExistenciasVirtualesBox: TcxLabel
      Left = 133
      Top = 173
      AutoSize = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 14
      Transparent = True
      Height = 25
      Width = 84
      AnchorX = 217
      AnchorY = 186
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 521
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      745
      36)
    Height = 36
    Width = 745
    object Panel3: TcxGroupBox
      Left = 287
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
    Left = 597
    Top = 16
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 567
    Top = 16
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
    object DataTodasLasUbicaciones: TBooleanField
      FieldName = 'TodasLasUbicaciones'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 536
    Top = 16
  end
  object GridDataSource: TDataSource
    DataSet = GridData
    Left = 537
    Top = 48
  end
  object GridData: TgxMemData
    Active = True
    Indexes = <
      item
        FieldName = 'Indice'
        SortOptions = []
      end>
    SortOptions = []
    Left = 567
    Top = 49
    object GridDataIndice: TSmallintField
      FieldName = 'Indice'
    end
    object GridDataNombrePeriodo: TStringField
      FieldName = 'NombrePeriodo'
      Size = 45
    end
    object GridDataEntradas: TBCDField
      FieldName = 'Entradas'
    end
    object GridDataSalidas: TBCDField
      FieldName = 'Salidas'
    end
    object GridDataSaldo: TBCDField
      FieldName = 'Saldo'
    end
  end
end
