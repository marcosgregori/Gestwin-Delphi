object MntTlaForm: TMntTlaForm
  Left = 425
  Top = 231
  HelpType = htKeyword
  HelpKeyword = 'a_tla'
  BorderStyle = bsDialog
  Caption = 
    'Referencias, precios, recargos y descuentos por cliente y art'#237'cu' +
    'lo'
  ClientHeight = 448
  ClientWidth = 673
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
      673
      32)
    Height = 32
    Width = 673
    object CodigoClienteCtrl: TcxDBTextEdit
      Left = 135
      Top = 4
      DescriptionLabel = Label5
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = ClienteDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClienteCtrlPropertiesEditRequest
      Properties.OnValuePosted = RangeValuePosted
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object Label2: TcxLabel
      Left = 17
      Top = 7
      TabStop = False
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 255
      Top = 7
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
      Height = 19
      Width = 382
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 412
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      673
      36)
    Height = 36
    Width = 673
    object Panel3: TcxGroupBox
      Left = 207
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 261
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
      object DeleteButton: TgBitBtn
        Left = 175
        Top = 1
        Width = 85
        Height = 28
        Caption = '&Suprimir'
        Enabled = True
        ModalResult = 3
        OptionsImage.ImageIndex = 5
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        GlyphBitmap = gmDelete
      end
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 32
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
    Height = 380
    Width = 663
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 98
      Width = 619
      Height = 277
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 1
      object GridView: TcxGridDBTableView
        Tag = 619705728
        PopupMenu = PopupMenu
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
        end
        object GridViewPrecio: TcxGridDBColumn
          DataBinding.FieldName = 'Precio'
          Width = 70
        end
        object GridViewRecargo: TcxGridDBColumn
          DataBinding.FieldName = 'Recargo'
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
      Left = 624
      Top = 98
      Margins.Left = 0
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 2
      TableView = GridView
      ShiftRecords = False
      UseGridFilterBox = False
      OnDelete = TableViewManagerDelete
      Height = 277
      Width = 34
    end
    object Panel1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        659
        93)
      Height = 93
      Width = 659
      object gxRangeBox1: TgxRangeBox
        Left = 110
        Top = 10
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object ArticuloInicialCtrl: TcxDBTextEdit
        Left = 126
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
        Left = 126
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
        Left = 5
        Top = 52
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
        Height = 37
        Width = 138
      end
      object Label4: TcxLabel
        Left = 10
        Top = 5
        TabStop = False
        Caption = 'Art'#237'culo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object Label1: TcxLabel
        Left = 265
        Top = 5
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
        Height = 19
        Width = 387
      end
      object Label3: TcxLabel
        Left = 265
        Top = 32
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
        Height = 19
        Width = 387
      end
    end
    object claseActivaLabel: TcxLabel
      Left = 8
      Top = 6
      TabStop = False
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
  object TarifaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaVentas'
    IndexFieldNames = 'Tipo;CodigoTarifa;CodigoArticulo'
    Left = 480
    Top = 69
  end
  object FormManager: TgxFormManager
    Dataset = ClienteTable
    FirstKeyControl = CodigoClienteCtrl
    FirstDataControl = ArticuloInicialCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnCopyCurrentRecord = FormManagerCopyCurrentRecord
    OnReportRequest = FormManagerReportRequest
    OnDeleteButton = FormManagerDeleteButton
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 612
    Top = 6
  end
  object TarifaVentasQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    RequestLive = True
    SQL.Strings = (
      
        'SELECT Articulo.Codigo, Articulo.Descripcion, TarifaVentas.Refer' +
        'encia, TarifaVentas.Precio, TarifaVentas.Recargo, TarifaVentas.D' +
        'escuento'
      'FROM   TarifaVentas'
      
        '       LEFT JOIN Articulo ON ( Articulo.Codigo=TarifaVentas.Codi' +
        'goArticulo )'
      
        'WHERE  TarifaVentas.Tipo=0 AND TarifaVentas.CodigoTarifa=:Codigo' +
        'Cliente AND TarifaVentas.CodigoArticulo BETWEEN :ArticuloInicial' +
        ' AND :ArticuloFinal')
    Left = 510
    Top = 7
    ParamData = <
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
    DataSet = TarifaVentasCachedDataset
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
  object TarifaVentasCachedDataset: TnxeCachedDataSet
    Database = SessionDataModule.TmpDatabase
    Options = [cdsoSetVisibleFields]
    BeforeEdit = TarifaVentasCachedDatasetBeforeEdit
    BeforePost = TarifaVentasCachedDatasetBeforePost
    SourceDataSet = TarifaVentasQuery
    Left = 480
    Top = 7
    object TarifaVentasCachedDatasetCodigo: TWideStringField
      FieldName = 'Codigo'
    end
    object TarifaVentasCachedDatasetDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object TarifaVentasCachedDatasetReferencia: TWideStringField
      FieldName = 'Referencia'
    end
    object TarifaVentasCachedDatasetPrecio: TFloatField
      FieldName = 'Precio'
    end
    object TarifaVentasCachedDatasetRecargo: TBCDField
      FieldName = 'Recargo'
    end
    object TarifaVentasCachedDatasetDescuento: TBCDField
      FieldName = 'Descuento'
    end
  end
  object ClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterScroll = ClienteTableAfterScroll
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    CanInsert = False
    OnGetRecord = ClienteTableGetRecord
    OnRecordChanged = ClienteTableRecordChanged
    Left = 582
    Top = 6
    object ClienteTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object ClienteTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
  end
  object ClienteDataSource: TDataSource
    DataSet = ClienteTable
    Left = 548
    Top = 6
  end
  object TarifaVentasAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaVentas'
    IndexFieldNames = 'Tipo;CodigoTarifa;CodigoArticulo'
    Left = 510
    Top = 69
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'PopupMenu')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 383
    Top = 65
    PixelsPerInch = 96
    object FichaArticuloItem: TdxBarButton
      Caption = 'Ficha del art'#237'culo'
      Category = 1
      Visible = ivAlways
      OnClick = FichaArticuloItemClick
    end
  end
  object PopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'FichaArticuloItem'
      end>
    UseOwnFont = False
    OnPopup = PopupMenuPopup
    Left = 416
    Top = 66
    PixelsPerInch = 96
  end
end
