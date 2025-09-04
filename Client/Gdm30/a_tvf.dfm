object MntTvfForm: TMntTvfForm
  Left = 425
  Top = 231
  HelpType = htKeyword
  HelpKeyword = 'a_tvf'
  BorderStyle = bsDialog
  Caption = 'Descuentos por codigo de tarifa y familia'
  ClientHeight = 476
  ClientWidth = 569
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
      569
      36)
    Height = 36
    Width = 569
    object CodigoTarifaCtrl: TcxDBTextEdit
      Left = 156
      Top = 6
      DescriptionLabel = DescCodigoTarifaLabel
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = CodigoTarifaDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoTarifaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoTarifaCtrlPropertiesEditRequest
      Properties.OnValuePosted = RangeValuePosted
      Properties.OnValidate = CodigoTarifaCtrlPropertiesValidate
      TabOrder = 0
      Width = 24
    end
    object Label2: TcxLabel
      Left = 17
      Top = 8
      Caption = 'C'#243'digo de tarifa'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object DescCodigoTarifaLabel: TcxLabel
      Left = 229
      Top = 8
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
      Height = 19
      Width = 326
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 440
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      569
      36)
    Height = 36
    Width = 569
    object Panel3: TcxGroupBox
      Left = 155
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
  object dataPanel: TgxEditPanel
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
    Height = 404
    Width = 559
    object Panel2: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        555
        95)
      Height = 95
      Width = 555
      object gxRangeBox2: TgxRangeBox
        Left = 129
        Top = 10
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object FamiliaInicialCtrl: TcxDBTextEdit
        Left = 148
        Top = 2
        DescriptionLabel = Label7
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
        DescriptionLabel = Label8
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
        Left = 3
        Top = 55
        AutoSize = False
        Caption = 'Mostrar s'#243'lo las familias con descuento'
        DataBinding.DataField = 'SoloFamiliasConTarifa'
        DataBinding.DataSource = DataSource
        Properties.OnValuePosted = RangeValuePosted
        Properties.Alignment = taRightJustify
        Properties.ImmediatePost = True
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Properties.OnChange = SoloFamiliasConTarifaCtrlPropertiesChange
        TabOrder = 2
        Transparent = True
        Height = 35
        Width = 160
      end
      object Label5: TcxLabel
        Left = 10
        Top = 5
        Caption = 'Familia'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object Label7: TcxLabel
        Left = 223
        Top = 5
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
        Height = 19
        Width = 321
      end
      object Label8: TcxLabel
        Left = 223
        Top = 32
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
        Height = 19
        Width = 321
      end
    end
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 100
      Width = 511
      Height = 299
      Margins.Right = 0
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 1
      object GridView: TcxGridDBTableView
        Tag = 383337616
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataModeController.GridMode = True
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = TarifaVentasFamiliaDataSource
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
      Left = 516
      Top = 100
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
      Height = 299
      Width = 38
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
    Left = 438
    Top = 67
  end
  object FormManager: TgxFormManager
    Dataset = CodigoTarifaTable
    FirstKeyControl = CodigoTarifaCtrl
    FirstDataControl = FamiliaInicialCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnDeleteButton = FormManagerDeleteButton
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 472
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 468
    Top = 35
    object DataFamiliaInicial: TWideStringField
      FieldName = 'FamiliaInicial'
      Size = 6
    end
    object DataFamiliaFinal: TWideStringField
      FieldName = 'FamiliaFinal'
      Size = 6
    end
    object DataSoloFamiliasConTarifa: TBooleanField
      FieldName = 'SoloFamiliasConTarifa'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 438
    Top = 35
  end
  object CodigoTarifaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterScroll = CodigoTarifaTableAfterScroll
    TableName = 'CodigoTarifa'
    IndexFieldNames = 'Codigo'
    CanInsert = False
    OnGetRecord = CodigoTarifaTableGetRecord
    OnRecordChanged = CodigoTarifaTableRecordChanged
    Left = 442
    object CodigoTarifaTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 2
    end
    object CodigoTarifaTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
  end
  object CodigoTarifaDataSource: TDataSource
    DataSet = CodigoTarifaTable
    Left = 408
  end
  object TarifaVentasFamiliaCachedDataSet: TnxeCachedDataSet
    Database = SessionDataModule.TmpDatabase
    Options = [cdsoSetVisibleFields]
    BeforeEdit = TarifaVentasFamiliaCachedDataSetBeforeEdit
    BeforePost = TarifaVentasFamiliaCachedDataSetBeforePost
    SourceDataSet = TarifaVentasFamiliaQuery
    Left = 372
    Top = 35
    object TarifaVentasFamiliaCachedDataSetCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 6
    end
    object TarifaVentasFamiliaCachedDataSetDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object TarifaVentasFamiliaCachedDataSetCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object TarifaVentasFamiliaCachedDataSetPrecio: TFloatField
      FieldName = 'Precio'
    end
    object TarifaVentasFamiliaCachedDataSetDescuento: TBCDField
      FieldName = 'Descuento'
    end
  end
  object TarifaVentasFamiliaDataSource: TDataSource
    DataSet = TarifaVentasFamiliaCachedDataSet
    Left = 342
    Top = 35
  end
  object TarifaVentasFamiliaQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    RequestLive = True
    SQL.Strings = (
      'SELECT Familia.Codigo,'
      '       Familia.Descripcion,'
      '       TarifaVentas.CodigoArticulo,'
      '       TarifaVentas.Precio,'
      '       TarifaVentas.Descuento'
      'FROM   Familia'
      
        '       LEFT JOIN TarifaVentas ON ( TarifaVentas.Tipo=2 AND Tarif' +
        'aVentas.CodigoTarifa=:CodigoTarifa AND TarifaVentas.CodigoArticu' +
        'lo=Familia.Codigo )'
      'WHERE  Familia.Codigo BETWEEN :FamiliaInicial AND :FamiliaFinal'
      'ORDER BY Familia.Codigo')
    Left = 404
    Top = 35
    ParamData = <
      item
        DataType = ftWideString
        Name = 'CodigoTarifa'
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
end
