object BrwVpaForm: TBrwVpaForm
  Left = 461
  Top = 257
  HelpType = htKeyword
  HelpKeyword = 'b_eea'
  BorderStyle = bsDialog
  Caption = 'Ventas peri'#243'dicas por cliente y art'#237'culo'
  ClientHeight = 502
  ClientWidth = 1044
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
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 211
    Width = 1044
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 32
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      DesignSize = (
        1040
        30)
      Height = 30
      Width = 1040
      object CodigoArticuloCtrl: TcxDBTextEdit
        Left = 113
        Top = 3
        DescriptionLabel = DescArticuloLabel
        DataBinding.DataField = 'CodigoArticulo'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
        Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
        TabOrder = 0
        Width = 102
      end
      object codigoCtrlCaption: TcxLabel
        Left = 9
        Top = 6
        Caption = 'Art'#237'culo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object DescArticuloLabel: TcxLabel
        Left = 240
        Top = 6
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
        Height = 19
        Width = 768
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 88
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 3
      Height = 26
      Width = 1040
      object TodasLasClasesCtrl: TcxDBCheckBox
        Left = 7
        Top = 1
        AutoSize = False
        Caption = 'Todas las clases'
        DataBinding.DataField = 'TodasLasClases'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.ImmediatePost = True
        Properties.NullStyle = nssUnchecked
        Properties.OnEditValueChanged = TodasLasClasesCtrlPropertiesEditValueChanged
        Style.TransparentBorder = False
        TabOrder = 0
        Transparent = True
        Height = 25
        Width = 123
      end
    end
    object cxGroupBox3: TcxGroupBox
      Left = 2
      Top = 114
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 4
      Height = 30
      Width = 1040
      object capClaseALabel: TcxLabel
        Left = 9
        Top = 8
        Caption = 'Clase A '
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object CodigoClaseACtrl: TcxDBTextEdit
        Tag = 1
        Left = 113
        Top = 4
        CaptionLabel = capClaseALabel
        DescriptionLabel = descClaseALabel
        DataBinding.DataField = 'CodigoClaseA'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoClaseACtrlPropertiesEditRequest
        Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
        TabOrder = 0
        Width = 32
      end
      object descClaseALabel: TcxLabel
        Left = 240
        Top = 7
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
        Height = 19
        Width = 500
      end
    end
    object cxGroupBox4: TcxGroupBox
      Left = 2
      Top = 144
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 5
      Height = 30
      Width = 1040
      object capClaseBLabel: TcxLabel
        Left = 9
        Top = 6
        Caption = 'Clase B'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object CodigoClaseBCtrl: TcxDBTextEdit
        Tag = 2
        Left = 113
        Top = 2
        CaptionLabel = capClaseBLabel
        DescriptionLabel = descClaseBLabel
        DataBinding.DataField = 'CodigoClaseB'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoClaseACtrlPropertiesEditRequest
        Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
        TabOrder = 0
        Width = 32
      end
      object descClaseBLabel: TcxLabel
        Left = 240
        Top = 5
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
        Height = 19
        Width = 500
      end
    end
    object cxGroupBox5: TcxGroupBox
      Left = 2
      Top = 174
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = True
      TabOrder = 6
      Height = 30
      Width = 1040
      object capClaseCLabel: TcxLabel
        Left = 9
        Top = 4
        Caption = 'Clase C'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object CodigoClaseCCtrl: TcxDBTextEdit
        Tag = 3
        Left = 113
        Top = 1
        CaptionLabel = capClaseCLabel
        DescriptionLabel = descClaseCLabel
        DataBinding.DataField = 'CodigoClaseC'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoClaseACtrlPropertiesEditRequest
        Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
        TabOrder = 0
        Width = 32
      end
      object descClaseCLabel: TcxLabel
        Left = 240
        Top = 4
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
        Height = 19
        Width = 500
      end
    end
    object cxGroupBox6: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        1040
        30)
      Height = 30
      Width = 1040
      object CodigoClienteCtrl: TcxDBTextEdit
        Left = 113
        Top = 3
        DescriptionLabel = cxLabel2
        DataBinding.DataField = 'CodigoCliente'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoClienteCtrlPropertiesEditRequest
        Properties.TextEditPad = tpLeftZero
        Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
        TabOrder = 0
        Width = 50
      end
      object cxLabel1: TcxLabel
        Left = 9
        Top = 6
        Caption = 'Cliente'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object cxLabel2: TcxLabel
        Left = 240
        Top = 6
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
        Height = 19
        Width = 768
      end
    end
    object cxGroupBox7: TcxGroupBox
      Left = 2
      Top = 62
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Height = 26
      Width = 1040
      object cxLabel6: TcxLabel
        Left = 9
        Top = 3
        TabStop = False
        Caption = 'Agrupar por ...'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object AgruparCtrl: TcxDBRadioGroup
        Left = 108
        Top = 3
        Alignment = alRightBottom
        DataBinding.DataField = 'Agrupar'
        DataBinding.DataSource = DataSource
        Properties.Columns = 2
        Properties.ImmediatePost = True
        Properties.Items = <
          item
            Caption = 'Cliente'
            Value = 0
          end
          item
            Caption = 'Art'#237'culo'
            Value = 1
          end>
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 24
        Width = 205
      end
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 211
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
    Height = 255
    Width = 1034
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 986
      Height = 245
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
        OnCustomDrawCell = TableViewCustomDrawCell
        DataController.DataSource = LineaVentaPeriodicaDataSource
        DataController.KeyFieldNames = 'NroFicha;NroRegistro'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            FieldName = 'Cantidad'
            Column = TableViewCantidad
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
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object TableViewTextoCabecera: TcxGridDBColumn
          AlternateCaption = '>'
          DataBinding.FieldName = 'TextoCabecera'
          Visible = False
          OnGetDisplayText = TableViewTextoCabeceraGetDisplayText
          GroupIndex = 0
        end
        object TableViewNroFicha: TcxGridDBColumn
          Caption = 'N'#170' ficha'
          DataBinding.FieldName = 'NroFicha'
          Width = 40
        end
        object TableViewCodigoArticulo: TcxGridDBColumn
          Caption = 'Codigo'
          DataBinding.FieldName = 'CodigoArticulo'
          Width = 90
        end
        object TableViewCodigoClaseA: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseA'
        end
        object TableViewCodigoClaseB: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseB'
        end
        object TableViewCodigoClaseC: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseC'
        end
        object TableViewDescripcion: TcxGridDBColumn
          DataBinding.FieldName = 'Descripcion'
          Width = 300
        end
        object TableViewNumeroSerie: TcxGridDBColumn
          Caption = 'N'#186' de serie'
          DataBinding.FieldName = 'NumeroSerie'
          Width = 180
        end
        object TableViewCantidad: TcxGridDBColumn
          DataBinding.FieldName = 'Cantidad'
          Width = 90
        end
        object TableViewPrecio: TcxGridDBColumn
          DataBinding.FieldName = 'Precio'
        end
        object TableViewRecargo: TcxGridDBColumn
          DataBinding.FieldName = 'Recargo'
          Width = 90
        end
        object TableViewDescuento: TcxGridDBColumn
          Caption = '% Dto.'
          DataBinding.FieldName = 'Descuento'
          Width = 50
        end
        object TableViewNoAplicar: TcxGridDBColumn
          Caption = 'N/A'
          DataBinding.FieldName = 'NoAplicar'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.NullStyle = nssUnchecked
          Width = 30
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
    object TableViewManager: TGridTableViewController
      Left = 994
      Top = 2
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 1
      Visible = False
      TableView = TableView
      ShiftRecords = True
      UseGridFilterBox = False
      OnUserSelection = TableViewManagerUserSelection
      Height = 251
      Width = 38
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 466
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      1044
      36)
    Height = 36
    Width = 1044
    object Panel3: TcxGroupBox
      Left = 438
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
    FirstKeyControl = CodigoClienteCtrl
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
    object DataCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
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
    object DataAgrupar: TSmallintField
      FieldName = 'Agrupar'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 518
    Top = 4
  end
  object LineaVentaPeriodicaQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    OnCalcFields = LineaVentaPeriodicaQueryCalcFields
    Left = 552
    Top = 36
    object LineaVentaPeriodicaQueryNroFicha: TIntegerField
      FieldName = 'NroFicha'
      Required = True
    end
    object LineaVentaPeriodicaQueryNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
      Required = True
    end
    object LineaVentaPeriodicaQueryCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object LineaVentaPeriodicaQueryCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object LineaVentaPeriodicaQueryCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object LineaVentaPeriodicaQueryCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object LineaVentaPeriodicaQueryNumeroSerie: TWideStringField
      FieldName = 'NumeroSerie'
      Size = 40
    end
    object LineaVentaPeriodicaQueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object LineaVentaPeriodicaQueryCantidad: TBCDField
      FieldName = 'Cantidad'
      Precision = 16
    end
    object LineaVentaPeriodicaQueryPrecio: TFloatField
      FieldName = 'Precio'
    end
    object LineaVentaPeriodicaQueryRecargo: TBCDField
      FieldName = 'Recargo'
      Precision = 16
    end
    object LineaVentaPeriodicaQueryDescuento: TBCDField
      FieldName = 'Descuento'
      Precision = 16
    end
    object LineaVentaPeriodicaQueryCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object LineaVentaPeriodicaQueryNombreCliente: TWideStringField
      FieldName = 'NombreCliente'
      Size = 60
    end
    object LineaVentaPeriodicaQueryNoAplicar: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'NoAplicar'
      Calculated = True
    end
    object LineaVentaPeriodicaQueryTextoCabecera: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'TextoCabecera'
      Size = 80
      Calculated = True
    end
  end
  object LineaVentaPeriodicaDataSource: TDataSource
    DataSet = LineaVentaPeriodicaQuery
    Enabled = False
    Left = 519
    Top = 35
  end
end
