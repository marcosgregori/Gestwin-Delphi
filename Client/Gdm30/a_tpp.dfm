object MntTppForm: TMntTppForm
  Left = 425
  Top = 231
  HelpType = htKeyword
  HelpKeyword = 'a_tpp'
  BorderStyle = bsDialog
  Caption = 'Referencias  y tarifas por proveedor'
  ClientHeight = 411
  ClientWidth = 692
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
      692
      36)
    Height = 36
    Width = 692
    object CodigoProveedorCtrl: TcxDBTextEdit
      Left = 132
      Top = 6
      DescriptionLabel = DescCodigoProveedorLabel
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = ProveedorDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoProveedorCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoProveedorCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoProveedorCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object Label2: TcxLabel
      Left = 18
      Top = 9
      Caption = 'Proveedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object DescCodigoProveedorLabel: TcxLabel
      Left = 253
      Top = 9
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
      Height = 19
      Width = 405
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 375
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      692
      36)
    Height = 36
    Width = 692
    object Panel3: TcxGroupBox
      Left = 261
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
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 36
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
    Height = 339
    Width = 682
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 97
      Width = 634
      Height = 237
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 1
      object GridView: TcxGridDBTableView
        Tag = 619689712
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
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Options.Editing = False
          Options.Focusing = False
          Width = 300
        end
        object GridViewReferencia: TcxGridDBColumn
          DataBinding.FieldName = 'Referencia'
          Width = 150
        end
        object GridViewPrecio: TcxGridDBColumn
          DataBinding.FieldName = 'Precio'
          Width = 70
        end
        object GridViewDescuento: TcxGridDBColumn
          Caption = '% Dto.'
          DataBinding.FieldName = 'Descuento'
          Width = 50
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object TableViewManager: TGridTableViewController
      AlignWithMargins = True
      Left = 639
      Top = 97
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
      Height = 237
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
        678
        92)
      Height = 92
      Width = 678
      object gxRangeBox1: TgxRangeBox
        Left = 107
        Top = 10
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object ArticuloInicialCtrl: TcxDBTextEdit
        Left = 123
        Top = 2
        DescriptionLabel = Label1
        DataBinding.DataField = 'ArticuloInicial'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
        Properties.OnValuePosted = RangeValuePosted
        Properties.ExpandZeroes = False
        Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
        TabOrder = 0
        Width = 130
      end
      object ArticuloFinalCtrl: TcxDBTextEdit
        Left = 123
        Top = 29
        DescriptionLabel = Label3
        DataBinding.DataField = 'ArticuloFinal'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
        Properties.OnValuePosted = RangeValuePosted
        Properties.ExpandZeroes = False
        Properties.TextEditPad = tpRightHighest
        Properties.PadAlways = True
        Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
        TabOrder = 1
        Width = 130
      end
      object SoloTarifaCtrl: TcxDBCheckBox
        Left = 3
        Top = 50
        AutoSize = False
        Caption = 'Mostrar s'#243'lo los art'#237'culos con tarifa'
        DataBinding.DataField = 'SoloTarifa'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.ImmediatePost = True
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Properties.OnChange = SoloTarifaCtrlPropertiesChange
        TabOrder = 2
        Transparent = True
        Height = 36
        Width = 137
      end
      object Label4: TcxLabel
        Left = 10
        Top = 5
        Caption = 'Art'#237'culo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object Label1: TcxLabel
        Left = 272
        Top = 5
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
        Height = 19
        Width = 398
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
        Width = 398
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
  object TarifaComprasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaCompras'
    IndexFieldNames = 'Tipo;CodigoProveedor;CodigoArticulo'
    Left = 480
    Top = 69
  end
  object FormManager: TgxFormManager
    Dataset = ProveedorTable
    FirstKeyControl = CodigoProveedorCtrl
    FirstDataControl = ArticuloInicialCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnCopyCurrentRecord = FormManagerCopyCurrentRecord
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 612
    Top = 6
  end
  object TarifaComprasQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    RequestLive = True
    SQL.Strings = (
      
        'SELECT Articulos.Codigo, Articulos.Descripcion, TarifaCompras.Re' +
        'ferencia, TarifaCompras.Precio, TarifaCompras.Descuento'
      'FROM ( SELECT Articulo.Codigo, Articulo.Descripcion'
      '       FROM Articulo'
      
        '       WHERE Articulo.Codigo BETWEEN :ArticuloInicial AND :Artic' +
        'uloFinal AND NOT Articulo.Obsoleto'
      '       ORDER BY Codigo ) AS Articulos'
      
        'LEFT JOIN TarifaCompras ON ( TarifaCompras.Tipo=0 AND TarifaComp' +
        'ras.CodigoProveedor=:CodigoProveedor AND TarifaCompras.CodigoArt' +
        'iculo=Articulos.Codigo )')
    Left = 510
    Top = 7
    ParamData = <
      item
        DataType = ftWideString
        Name = 'ArticuloInicial'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'ArticuloFinal'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'CodigoProveedor'
        ParamType = ptUnknown
      end>
  end
  object TarifaDataSource: TDataSource
    DataSet = TarifaComprasCachedDataset
    Left = 450
    Top = 7
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 510
    Top = 37
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
    end
    object DataSoloTarifa: TBooleanField
      FieldName = 'SoloTarifa'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 480
    Top = 37
  end
  object TarifaComprasCachedDataset: TnxeCachedDataSet
    Database = SessionDataModule.TmpDatabase
    Options = [cdsoSetVisibleFields]
    BeforeEdit = TarifaComprasCachedDatasetBeforeEdit
    BeforePost = TarifaComprasCachedDatasetBeforePost
    SourceDataSet = TarifaComprasQuery
    Left = 480
    Top = 7
    object TarifaComprasCachedDatasetCodigo: TWideStringField
      FieldName = 'Codigo'
    end
    object TarifaComprasCachedDatasetDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object TarifaComprasCachedDatasetReferencia: TWideStringField
      FieldName = 'Referencia'
    end
    object TarifaComprasCachedDatasetPrecio: TFloatField
      FieldName = 'Precio'
    end
    object TarifaComprasCachedDatasetDescuento: TBCDField
      FieldName = 'Descuento'
      Precision = 16
    end
  end
  object ProveedorTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterScroll = ProveedorTableAfterScroll
    TableName = 'Proveedor'
    IndexFieldNames = 'Codigo'
    CanInsert = False
    OnGetRecord = ProveedorTableGetRecord
    Left = 584
    Top = 6
    object ProveedorTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object ProveedorTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
  end
  object ProveedorDataSource: TDataSource
    DataSet = ProveedorTable
    Left = 548
    Top = 6
  end
  object TarifaComprasAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaCompras'
    IndexFieldNames = 'Tipo;CodigoProveedor;CodigoArticulo'
    Left = 512
    Top = 69
  end
end
