object BrwCacForm: TBrwCacForm
  Left = 524
  Top = 270
  HelpType = htKeyword
  HelpKeyword = 'b_cac'
  BorderStyle = bsDialog
  Caption = 'Consumos mensuales de clientes por art'#237'culo y familia'
  ClientHeight = 590
  ClientWidth = 609
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
    DesignSize = (
      609
      183)
    Height = 183
    Width = 609
    object CodigoClienteCtrl: TcxDBTextEdit
      Left = 98
      Top = 4
      DescriptionLabel = Label11
      DataBinding.DataField = 'CodigoCliente'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClienteCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object PageControl: TcxPageControl
      Left = 7
      Top = 34
      Width = 596
      Height = 146
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 1
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      OnChange = PageControlChange
      OnEnter = PageControlEnter
      ClientRectBottom = 142
      ClientRectLeft = 4
      ClientRectRight = 592
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = 'A&rt'#237'culo'
        DesignSize = (
          588
          114)
        object CodigoArticuloCtrl: TcxDBTextEdit
          Left = 90
          Top = 2
          DescriptionLabel = Label12
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
          Left = 90
          Top = 29
          CaptionLabel = CapClaseALabel
          DescriptionLabel = Label2
          DataBinding.DataField = 'CodigoClaseA'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoClaseACtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object CodigoClaseBCtrl: TcxDBTextEdit
          Tag = 2
          Left = 90
          Top = 56
          CaptionLabel = CapClaseBLabel
          DescriptionLabel = Label14
          DataBinding.DataField = 'CodigoClaseB'
          DataBinding.DataSource = DataSource
          TabOrder = 2
          Width = 32
        end
        object CodigoClaseCCtrl: TcxDBTextEdit
          Tag = 3
          Left = 90
          Top = 83
          CaptionLabel = CapClaseCLabel
          DescriptionLabel = Label15
          DataBinding.DataField = 'CodigoClaseC'
          DataBinding.DataSource = DataSource
          TabOrder = 3
          Width = 32
        end
        object codigoCtrlCaption: TcxLabel
          Left = 5
          Top = 5
          TabStop = False
          Caption = 'Art'#237'culo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
        end
        object Label12: TcxLabel
          Left = 202
          Top = 5
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 5
          Transparent = True
          Height = 19
          Width = 382
        end
        object CapClaseALabel: TcxLabel
          Left = 5
          Top = 33
          TabStop = False
          Caption = 'Clase A '
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 6
          Transparent = True
        end
        object CapClaseBLabel: TcxLabel
          Left = 5
          Top = 60
          TabStop = False
          Caption = 'Clase B'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 7
          Transparent = True
        end
        object Label14: TcxLabel
          Left = 202
          Top = 60
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 8
          Transparent = True
          Height = 19
          Width = 382
        end
        object CapClaseCLabel: TcxLabel
          Left = 5
          Top = 87
          TabStop = False
          Caption = 'Clase C'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 9
          Transparent = True
        end
        object Label15: TcxLabel
          Left = 202
          Top = 87
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 10
          Transparent = True
          Height = 19
          Width = 382
        end
        object Label2: TcxLabel
          Left = 202
          Top = 33
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 11
          Transparent = True
          Height = 19
          Width = 382
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = '&Familia'
        DesignSize = (
          588
          114)
        object CodigoFamiliaCtrl: TcxDBTextEdit
          Left = 90
          Top = 2
          DescriptionLabel = Label16
          DataBinding.DataField = 'CodigoFamilia'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoFamiliaCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoFamiliaCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoFamiliaCtrlPropertiesValidate
          TabOrder = 0
          Width = 62
        end
        object Label1: TcxLabel
          Left = 7
          Top = 6
          TabStop = False
          Caption = 'Familia'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
        object Label16: TcxLabel
          Left = 203
          Top = 6
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
          Height = 19
          Width = 375
        end
      end
    end
    object Label10: TcxLabel
      Left = 16
      Top = 8
      TabStop = False
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
    object Label11: TcxLabel
      Left = 211
      Top = 8
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
      Height = 19
      Width = 368
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 183
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
    Height = 371
    Width = 599
    object Grid: TcxGrid
      Left = 2
      Top = 2
      Width = 595
      Height = 367
      Align = alClient
      BevelInner = bvNone
      BorderStyle = cxcbsNone
      TabOrder = 0
      ExplicitLeft = 5
      ExplicitTop = 5
      ExplicitWidth = 589
      ExplicitHeight = 361
      object TableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = GridDataSource
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            Column = TableViewUnidades
          end
          item
            Kind = skSum
            Column = TableViewImporte
          end
          item
            Kind = skSum
            Column = TableViewPrecioMedio
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object TableViewPeriodo: TcxGridDBColumn
          Caption = 'Mes'
          DataBinding.FieldName = 'TextoPeriodo'
          Width = 87
        end
        object TableViewUnidades: TcxGridDBColumn
          DataBinding.FieldName = 'Unidades'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Width = 135
        end
        object TableViewImporte: TcxGridDBColumn
          DataBinding.FieldName = 'Importe'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Width = 135
        end
        object TableViewPrecioMedio: TcxGridDBColumn
          Caption = 'Precio medio'
          DataBinding.FieldName = 'PrecioMedio'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Width = 135
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 554
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      609
      36)
    Height = 36
    Width = 609
    object Panel3: TcxGroupBox
      Left = 219
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
  object ConsumoVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ConsumoVentas'
    IndexFieldNames = 
      'Tipo;Ejercicio;Cliente;FamiliaArticulo;CodigoClaseA;CodigoClaseB' +
      ';CodigoClaseC'
    Left = 312
    Top = 4
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstKeyControl = CodigoClienteCtrl
    FirstDataControl = Grid
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 415
    Top = 4
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 355
    Top = 4
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 384
    Top = 4
    object DataCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object DataCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
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
    object DataCodigoFamilia: TWideStringField
      FieldName = 'CodigoFamilia'
      Size = 6
    end
  end
  object GridData: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 386
    Top = 34
    object GridDataNroPeriodo: TWideStringField
      FieldName = 'NroPeriodo'
    end
    object GridDataTextoPeriodo: TStringField
      FieldName = 'TextoPeriodo'
      Size = 30
    end
    object GridDataUnidades: TBCDField
      FieldName = 'Unidades'
    end
    object GridDataImporte: TBCDField
      FieldName = 'Importe'
    end
    object GridDataPrecioMedio: TBCDField
      FieldName = 'PrecioMedio'
    end
  end
  object GridDataSource: TDataSource
    DataSet = GridData
    Left = 356
    Top = 34
  end
end
