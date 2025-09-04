object MntTcoaForm: TMntTcoaForm
  Left = 425
  Top = 231
  HelpType = htKeyword
  HelpKeyword = 'a_tcoa'
  BorderStyle = bsDialog
  Caption = 'Tabla de tipos de comisi'#243'n por art'#237'culo'
  ClientHeight = 465
  ClientWidth = 618
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
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
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      618
      63)
    Height = 63
    Width = 618
    object CodigoClienteCtrl: TcxDBTextEdit
      Left = 156
      Top = 32
      DescriptionLabel = Label5
      DataBinding.DataField = 'CodigoCliente'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClienteCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
      TabOrder = 1
      Width = 46
    end
    object VendedorCtrl: TcxDBTextEdit
      Left = 156
      Top = 5
      DescriptionLabel = Label7
      DataBinding.DataField = 'CodigoVendedor'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
      Properties.OnEditRequest = VendedorCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = VendedorCtrlPropertiesValidate
      TabOrder = 0
      Width = 24
    end
    object Label2: TcxLabel
      Left = 18
      Top = 35
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 279
      Top = 35
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
      Height = 19
      Width = 313
    end
    object Label6: TcxLabel
      Left = 18
      Top = 8
      Caption = 'Vendedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 279
      Top = 8
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
      Height = 19
      Width = 313
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 429
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      618
      36)
    Height = 36
    Width = 618
    object Panel3: TcxGroupBox
      Left = 223
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 175
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
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 63
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
    Height = 366
    Width = 608
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 102
      Width = 560
      Height = 259
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 1
      object GridView: TcxGridDBTableView
        Tag = 443593896
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = TarifaDataSource
        DataController.KeyFieldNames = 'Codigo'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.PostponedSynchronization = False
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.FocusFirstCellOnNewRecord = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsBehavior.PullFocusing = True
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.FooterAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object GridViewCodigo: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'Codigo'
          Options.Editing = False
          Options.Focusing = False
          Width = 70
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Options.Editing = False
          Options.Focusing = False
          Width = 250
        end
        object GridViewTipo: TcxGridDBColumn
          Caption = '% Comisi'#243'n'
          DataBinding.FieldName = 'Tipo'
          Width = 50
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object TableViewManager: TGridTableViewController
      AlignWithMargins = True
      Left = 565
      Top = 102
      Margins.Left = 0
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 2
      Visible = False
      TableView = GridView
      ShiftRecords = False
      UseGridFilterBox = False
      Height = 259
      Width = 38
    end
    object Panel1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        604
        97)
      Height = 97
      Width = 604
      object gxRangeBox1: TgxRangeBox
        Left = 133
        Top = 10
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object ArticuloInicialCtrl: TcxDBTextEdit
        Left = 149
        Top = 2
        DescriptionLabel = Label1
        DataBinding.DataField = 'ArticuloInicial'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
        Properties.OnValuePosted = CampoPropertiesValuePosted
        Properties.ExpandZeroes = False
        Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
        TabOrder = 0
        Width = 102
      end
      object ArticuloFinalCtrl: TcxDBTextEdit
        Left = 149
        Top = 29
        DescriptionLabel = Label3
        DataBinding.DataField = 'ArticuloFinal'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
        Properties.OnValuePosted = CampoPropertiesValuePosted
        Properties.ExpandZeroes = False
        Properties.TextEditPad = tpRightHighest
        Properties.PadAlways = True
        Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
        TabOrder = 1
        Width = 102
      end
      object SoloComisionCtrl: TcxDBCheckBox
        Left = 8
        Top = 54
        AutoSize = False
        Caption = 'Mostrar s'#243'lo los art'#237'culos con comisi'#243'n'
        DataBinding.DataField = 'SoloComision'
        DataBinding.DataSource = DataSource
        Properties.OnValuePosted = CampoPropertiesValuePosted
        Properties.Alignment = taRightJustify
        Properties.ImmediatePost = True
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 2
        Transparent = True
        Height = 35
        Width = 159
      end
      object Label4: TcxLabel
        Left = 10
        Top = 6
        Caption = 'Art'#237'culo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object Label1: TcxLabel
        Left = 272
        Top = 6
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
        Height = 19
        Width = 343
      end
      object Label3: TcxLabel
        Left = 272
        Top = 32
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
        Height = 19
        Width = 343
      end
    end
    object claseActivaLabel: TcxLabel
      Left = 8
      Top = 6
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clGreen
      Style.Font.Height = -11
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
  end
  object TablaComisionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TablaComision'
    IndexFieldNames = 'Relacion;CodigoVendedor;CodigoCliente;CodigoArticulo'
    Left = 384
    Top = 55
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstKeyControl = VendedorCtrl
    FirstDataControl = ArticuloInicialCtrl
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 488
    Top = 6
  end
  object TablaComisionQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    RequestLive = True
    SQL.Strings = (
      'SELECT Articulo.Codigo, Articulo.Descripcion, TablaComision.Tipo'
      
        'FROM Articulo LEFT JOIN TablaComision ON ( TablaComision.Relacio' +
        'n=0 AND TablaComision.CodigoVendedor=:CodigoVendedor AND TablaCo' +
        'mision.CodigoCliente=:CodigoCliente AND TablaComision.CodigoArti' +
        'culo=Articulo.Codigo )'
      
        'WHERE Articulo.Codigo BETWEEN :ArticuloInicial AND :ArticuloFina' +
        'l AND NOT Articulo.Obsoleto'
      'ORDER BY Codigo')
    Left = 384
    Top = 5
    ParamData = <
      item
        DataType = ftWideString
        Name = 'CodigoVendedor'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'CodigoCliente'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'ArticuloInicial'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'ArticuloFinal'
        ParamType = ptUnknown
      end>
  end
  object TarifaDataSource: TDataSource
    DataSet = TablaComisionCachedDataset
    Left = 324
    Top = 5
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 452
    Top = 5
    object DataCodigoVendedor: TWideStringField
      FieldName = 'CodigoVendedor'
      Size = 2
    end
    object DataCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
    end
    object DataSoloComision: TBooleanField
      FieldName = 'SoloComision'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 420
    Top = 5
  end
  object TablaComisionCachedDataset: TnxeCachedDataSet
    Database = SessionDataModule.TmpDatabase
    Options = [cdsoSetVisibleFields]
    BeforeEdit = TablaComisionCachedDatasetBeforeEdit
    BeforePost = TablaComisionCachedDatasetBeforePost
    SourceDataSet = TablaComisionQuery
    Left = 354
    Top = 5
    object TablaComisionCachedDatasetCodigo: TWideStringField
      FieldName = 'Codigo'
    end
    object TablaComisionCachedDatasetDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object TablaComisionCachedDatasetTipo: TBCDField
      FieldName = 'Tipo'
    end
  end
end
