object MntTccForm: TMntTccForm
  Left = 425
  Top = 231
  HelpType = htKeyword
  HelpKeyword = 'a_tcc'
  BorderStyle = bsDialog
  Caption = 'Tarifas de compra por clases de art'#237'culo'
  ClientHeight = 399
  ClientWidth = 556
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
      556
      116)
    Height = 116
    Width = 556
    object CodigoProveedorCtrl: TcxDBTextEdit
      Left = 102
      Top = 4
      DescriptionLabel = DescCodigoProveedorLabel
      DataBinding.DataField = 'CodigoProveedor'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoProveedorCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoProveedorCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = CodigoProveedorCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object CodigoClaseACtrl: TcxDBTextEdit
      Left = 102
      Top = 58
      CaptionLabel = CapClaseALabel
      DescriptionLabel = DescClaseALabel
      DataBinding.DataField = 'CodigoClaseA'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClaseACtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseACtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseACtrlPropertiesValidate
      TabOrder = 2
      Width = 32
    end
    object CodigoClaseBCtrl: TcxDBTextEdit
      Left = 102
      Top = 85
      CaptionLabel = CapClaseBLabel
      DescriptionLabel = DescClaseBLabel
      DataBinding.DataField = 'CodigoClaseB'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClaseBCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseBCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseBCtrlPropertiesValidate
      TabOrder = 3
      Width = 32
    end
    object CodigoArticuloCtrl: TcxDBTextEdit
      Left = 102
      Top = 31
      DescriptionLabel = DescArticuloLabel
      DataBinding.DataField = 'CodigoArticulo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
      TabOrder = 1
      Width = 102
    end
    object Label2: TcxLabel
      Left = 10
      Top = 7
      Caption = 'Proveedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
    object DescCodigoProveedorLabel: TcxLabel
      Left = 214
      Top = 7
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
      Height = 19
      Width = 302
    end
    object CapClaseALabel: TcxLabel
      Left = 12
      Top = 62
      Caption = 'Clase A '
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
    end
    object CapClaseBLabel: TcxLabel
      Left = 12
      Top = 89
      Caption = 'Clase B'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
    end
    object DescClaseALabel: TcxLabel
      Left = 214
      Top = 62
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
      Height = 19
      Width = 302
    end
    object DescClaseBLabel: TcxLabel
      Left = 214
      Top = 89
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
      Height = 19
      Width = 302
    end
    object Label4: TcxLabel
      Left = 12
      Top = 35
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
    end
    object DescArticuloLabel: TcxLabel
      Left = 214
      Top = 35
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
      Height = 19
      Width = 302
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 116
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
    Height = 247
    Width = 546
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 498
      Height = 237
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 0
      ExplicitLeft = 6
      ExplicitTop = 6
      ExplicitWidth = 496
      ExplicitHeight = 230
      object GridView: TcxGridDBTableView
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
          Caption = 'C'#243'd.'
          DataBinding.FieldName = 'Codigo'
          Options.Editing = False
          Options.Focusing = False
          Width = 35
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Options.Editing = False
          Options.Focusing = False
          Width = 210
        end
        object GridViewPrecio: TcxGridDBColumn
          DataBinding.FieldName = 'Precio'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.MaxLength = 9
        end
        object GridViewDescuento: TcxGridDBColumn
          Caption = '% Dto.'
          DataBinding.FieldName = 'Descuento'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.MaxLength = 6
          Width = 35
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object TableViewManager: TGridTableViewController
      AlignWithMargins = True
      Left = 503
      Top = 5
      Margins.Left = 0
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 1
      Visible = False
      TableView = GridView
      ShiftRecords = False
      UseGridFilterBox = False
      ExplicitLeft = 502
      ExplicitTop = 6
      ExplicitHeight = 235
      Height = 237
      Width = 38
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 363
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    ExplicitTop = 358
    DesignSize = (
      556
      36)
    Height = 36
    Width = 556
    object Panel3: TcxGroupBox
      Left = 192
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
  object TarifaClaseTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaClase'
    IndexFieldNames = 'Seccion;CodigoPropietario;CodigoArticulo;ClaseA;ClaseB;ClaseC'
    Left = 352
    Top = 36
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstKeyControl = CodigoProveedorCtrl
    FirstDataControl = Grid
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 448
    Top = 4
  end
  object TarifaClaseQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    RequestLive = True
    SQL.Strings = (
      ''
      
        'SELECT *, CAST( 0.0 AS Float ) AS Precio, CAST( 0.0 AS BCD(16,4)' +
        ' ) AS Descuento'
      'FROM Clase '
      'WHERE NroClase=1 ')
    Left = 304
    Top = 4
  end
  object TarifaDataSource: TDataSource
    DataSet = TarifaClaseCachedDataset
    Left = 244
    Top = 6
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 382
    Top = 4
    object DataCodigoProveedor: TWideStringField
      FieldName = 'CodigoProveedor'
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
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 352
    Top = 4
  end
  object TarifaClaseCachedDataset: TnxeCachedDataSet
    Database = SessionDataModule.TmpDatabase
    Options = [cdsoSetVisibleFields]
    BeforeEdit = TarifaClaseCachedDatasetBeforeEdit
    BeforePost = TarifaClaseCachedDatasetBeforePost
    SourceDataSet = TarifaClaseQuery
    Left = 274
    Top = 4
    object TarifaClaseCachedDatasetNroClase: TSmallintField
      FieldName = 'NroClase'
    end
    object TarifaClaseCachedDatasetCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 3
    end
    object TarifaClaseCachedDatasetDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object TarifaClaseCachedDatasetPeso: TBCDField
      FieldName = 'Peso'
      Precision = 16
    end
    object TarifaClaseCachedDatasetCapacidad: TBCDField
      FieldName = 'Capacidad'
      Precision = 16
    end
    object TarifaClaseCachedDatasetTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object TarifaClaseCachedDatasetPrecio: TFloatField
      FieldName = 'Precio'
    end
    object TarifaClaseCachedDatasetDescuento: TBCDField
      FieldName = 'Descuento'
      Precision = 16
    end
  end
end
