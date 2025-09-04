object MntTcvForm: TMntTcvForm
  Left = 425
  Top = 231
  HelpType = htKeyword
  HelpKeyword = 'a_tcv'
  BorderStyle = bsDialog
  Caption = 'Tarifas de venta por cliente y clase de art'#237'culo'
  ClientHeight = 402
  ClientWidth = 563
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
      563
      115)
    Height = 115
    Width = 563
    object CodigoClienteCtrl: TcxDBTextEdit
      Left = 102
      Top = 4
      DescriptionLabel = Label1
      DataBinding.DataField = 'CodigoCliente'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClienteCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object CodigoClaseACtrl: TcxDBTextEdit
      Left = 102
      Top = 58
      CaptionLabel = CapClaseALabel
      DescriptionLabel = Label5
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
      DescriptionLabel = Label6
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
      DescriptionLabel = Label3
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
      Left = 12
      Top = 7
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
    object Label1: TcxLabel
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
      Width = 319
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
    object Label5: TcxLabel
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
      Width = 319
    end
    object Label6: TcxLabel
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
      Width = 319
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
    object Label3: TcxLabel
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
      Width = 319
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 115
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
    Height = 251
    Width = 553
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 505
      Height = 241
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 0
      ExplicitLeft = 6
      ExplicitTop = 6
      ExplicitWidth = 503
      ExplicitHeight = 239
      object GridView: TcxGridDBTableView
        Tag = 271916760
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataModeController.GridMode = True
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
      Left = 510
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
      ExplicitLeft = 509
      ExplicitTop = 6
      Height = 241
      Width = 38
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 366
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      563
      36)
    Height = 36
    Width = 563
    object Panel3: TcxGroupBox
      Left = 196
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
    FirstKeyControl = CodigoClienteCtrl
    FirstDataControl = Grid
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 450
    Top = 4
  end
  object TarifaClaseQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    RequestLive = True
    SQL.Strings = (
      ''
      
        'SELECT *, CAST( 0.0 AS Double Precision ) AS Precio, CAST( 0.0 A' +
        'S BCD(16,4) ) AS Descuento'
      'FROM Clase '
      'WHERE Nro_Clase=1 ')
    Left = 304
    Top = 4
  end
  object TarifaDataSource: TDataSource
    DataSet = TarifaClaseCachedDataset
    Left = 244
    Top = 4
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 382
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
    object TarifaClaseCachedDatasetPrecio: TFloatField
      FieldName = 'Precio'
    end
    object TarifaClaseCachedDatasetDescuento: TBCDField
      FieldName = 'Descuento'
    end
  end
end
