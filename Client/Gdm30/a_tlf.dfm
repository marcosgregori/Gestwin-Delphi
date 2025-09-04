object MntTlfForm: TMntTlfForm
  Left = 425
  Top = 231
  HelpType = htKeyword
  HelpKeyword = 'a_tlf'
  BorderStyle = bsDialog
  Caption = 'Descuentos por cliente y familia'
  ClientHeight = 419
  ClientWidth = 565
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
      565
      36)
    Height = 36
    Width = 565
    object CodigoClienteCtrl: TcxDBTextEdit
      Left = 156
      Top = 6
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
    object Label5: TcxLabel
      Left = 250
      Top = 9
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
      Height = 19
      Width = 304
    end
    object Label2: TcxLabel
      Left = 17
      Top = 9
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 383
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      565
      36)
    Height = 36
    Width = 565
    object Panel3: TcxGroupBox
      Left = 153
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 260
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
    Height = 347
    Width = 555
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 98
      Width = 507
      Height = 244
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 1
      object GridView: TcxGridDBTableView
        Tag = 619709600
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
          Width = 55
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Options.Editing = False
          Options.Focusing = False
          Width = 300
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
      Left = 512
      Top = 98
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
      Height = 244
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
        551
        93)
      Height = 93
      Width = 551
      object gxRangeBox1: TgxRangeBox
        Left = 132
        Top = 10
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object FamiliaInicialCtrl: TcxDBTextEdit
        Left = 148
        Top = 2
        DescriptionLabel = Label1
        DataBinding.DataField = 'FamiliaInicial'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = FamiliaCtrlPropertiesQueryRequest
        Properties.OnEditRequest = FamiliaCtrlPropertiesEditRequest
        Properties.OnValuePosted = RangeValuePosted
        Properties.OnValidate = FamiliaCtrlPropertiesValidate
        TabOrder = 0
        Width = 62
      end
      object FamiliaFinalCtrl: TcxDBTextEdit
        Left = 148
        Top = 29
        DataBinding.DataField = 'FamiliaFinal'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = FamiliaCtrlPropertiesQueryRequest
        Properties.OnEditRequest = FamiliaCtrlPropertiesEditRequest
        Properties.OnValuePosted = RangeValuePosted
        Properties.TextEditPad = tpRightHighest
        Properties.PadAlways = True
        Properties.OnValidate = FamiliaCtrlPropertiesValidate
        TabOrder = 1
        Width = 62
      end
      object SoloFamiliasConTarifaCtrl: TcxDBCheckBox
        Left = 5
        Top = 52
        AutoSize = False
        Caption = 'Mostrar s'#243'lo las familias con descuento'
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
        Width = 160
      end
      object Label4: TcxLabel
        Left = 10
        Top = 5
        Caption = 'Familia'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object Label1: TcxLabel
        Left = 242
        Top = 5
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
        Height = 19
        Width = 301
      end
      object Label3: TcxLabel
        Left = 242
        Top = 32
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
        Height = 19
        Width = 301
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
  object TarifaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaVentas'
    IndexFieldNames = 'Tipo;CodigoTarifa;CodigoArticulo'
    Left = 334
    Top = 67
  end
  object FormManager: TgxFormManager
    Dataset = ClienteTable
    FirstKeyControl = CodigoClienteCtrl
    FirstDataControl = FamiliaInicialCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnCopyCurrentRecord = FormManagerCopyCurrentRecord
    OnReportRequest = FormManagerReportRequest
    OnDeleteButton = FormManagerDeleteButton
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 466
    Top = 4
  end
  object TarifaVentasQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    RequestLive = True
    SQL.Strings = (
      ''
      
        'SELECT Familia.Codigo, Familia.Descripcion, TarifaVentas.Descuen' +
        'to'
      
        'FROM Familia LEFT JOIN TarifaVentas ON ( TarifaVentas.Tipo=3 AND' +
        ' TarifaVentas.CodigoTarifa=:CodigoCliente AND TarifaVentas.Codig' +
        'oArticulo=Familia.Codigo )'
      'WHERE Familia.Codigo BETWEEN :FamiliaInicial AND :FamiliaFinal'
      'ORDER BY Codigo')
    Left = 364
    Top = 4
    ParamData = <
      item
        DataType = ftWideString
        Name = 'CodigoCliente'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'FamiliaInicial'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'FamiliaFinal'
        ParamType = ptUnknown
      end>
  end
  object TarifaDataSource: TDataSource
    DataSet = TarifaVentasCachedDataset
    Left = 304
    Top = 4
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 364
    Top = 35
    object DataFamiliaInicial: TWideStringField
      DisplayWidth = 3
      FieldName = 'FamiliaInicial'
      Size = 6
    end
    object DataFamiliaFinal: TWideStringField
      FieldName = 'FamiliaFinal'
      Size = 6
    end
    object DataSoloTarifa: TBooleanField
      FieldName = 'SoloTarifa'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 334
    Top = 35
  end
  object TarifaVentasCachedDataset: TnxeCachedDataSet
    Database = SessionDataModule.TmpDatabase
    Options = [cdsoSetVisibleFields]
    BeforeEdit = TarifaVentasCachedDatasetBeforeEdit
    BeforePost = TarifaVentasCachedDatasetBeforePost
    SourceDataSet = TarifaVentasQuery
    Left = 334
    Top = 4
    object TarifaVentasCachedDatasetCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 6
    end
    object TarifaVentasCachedDatasetDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
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
    Left = 436
    Top = 4
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
    Left = 402
    Top = 4
  end
  object TarifaVentasAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaVentas'
    IndexFieldNames = 'Tipo;CodigoTarifa;CodigoArticulo'
    Left = 364
    Top = 67
  end
end
