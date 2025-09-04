object RptShpForm: TRptShpForm
  Left = 511
  Top = 325
  HelpType = htKeyword
  HelpKeyword = 'l_shp'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de situaci'#243'n de hojas de pedido'
  ClientHeight = 243
  ClientWidth = 521
  Color = clBtnFace
  DoubleBuffered = True
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
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
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
    TabOrder = 0
    PanelKind = epInputPanel
    Height = 202
    Width = 511
    object SeriePanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        507
        64)
      Height = 64
      Width = 507
      object SerieRangeBox: TgxRangeBox
        Left = 128
        Top = 13
        Width = 13
        Height = 37
        Hint = 
          'Los campos situados a la derecha marcan un rango de valores.'#13'Arr' +
          'iba el l'#237'mite inferior y abajo el superior.'
        ParentShowHint = False
        ShowHint = True
      end
      object cxLabel6: TcxLabel
        Left = 11
        Top = 10
        TabStop = False
        Caption = 'Serie'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object cxLabel7: TcxLabel
        Left = 270
        Top = 8
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 20
        Width = 226
        AnchorY = 18
      end
      object cxLabel8: TcxLabel
        Left = 270
        Top = 35
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 20
        Width = 226
        AnchorY = 45
      end
      object SerieEditSelector: TgxEditSelector
        Left = 222
        Top = 7
        Alignment = alCenterCenter
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 3
        SelectorOptions.StartEdit = SerieInicialCtrl
        SelectorOptions.EndEdit = SerieFinalCtrl
        SelectorOptions.GridView = SeriesFacturacionTableView
        SelectorOptions.RangeBox = SerieRangeBox
        SelectorOptions.FieldName = 'Codigo'
        Height = 25
        Width = 25
      end
      object SerieFinalCtrl: TcxDBTextEdit
        Left = 143
        Top = 34
        DescriptionLabel = cxLabel8
        DataBinding.DataField = 'SerieFinal'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = SerieFacturacionCtrlPropertiesQueryRequest
        Properties.TextEditPad = tpRightHighest
        Properties.PadAlways = True
        Properties.OnValidate = SerieFacturacionCtrlPropertiesValidate
        TabOrder = 4
        Width = 25
      end
      object SerieInicialCtrl: TcxDBTextEdit
        Left = 143
        Top = 7
        DescriptionLabel = cxLabel7
        DataBinding.DataField = 'SerieInicial'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = SerieFacturacionCtrlPropertiesQueryRequest
        Properties.OnValidate = SerieFacturacionCtrlPropertiesValidate
        TabOrder = 5
        Width = 25
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 66
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      DesignSize = (
        507
        131)
      Height = 131
      Width = 507
      object Label27: TcxLabel
        Left = 11
        Top = -1
        TabStop = False
        Caption = 'Seleccionar por ...'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object PageControl: TcxPageControl
        Left = 7
        Top = 22
        Width = 495
        Height = 95
        Anchors = [akLeft, akTop, akRight]
        Focusable = False
        TabOrder = 1
        Properties.ActivePage = TabSheet1
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 91
        ClientRectLeft = 4
        ClientRectRight = 491
        ClientRectTop = 33
        object TabSheet1: TcxTabSheet
          Caption = 'N'#186' de hoja de pedido'
          object gxRangeBox2: TgxRangeBox
            Left = 117
            Top = 11
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object NroDocumentoInicialCtrl: TcxDBTextEdit
            Left = 132
            Top = 3
            DataBinding.DataField = 'NroDocumentoInicial'
            DataBinding.DataSource = DataSource
            TabOrder = 0
            Width = 67
          end
          object NroDocumentoFinalCtrl: TcxDBTextEdit
            Left = 132
            Top = 30
            DataBinding.DataField = 'NroDocumentoFinal'
            DataBinding.DataSource = DataSource
            TabOrder = 1
            Width = 67
          end
          object DocumentoLabel: TcxLabel
            Left = 8
            Top = 7
            TabStop = False
            Caption = 'N'#186' de hoja'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
        end
        object TabSheet2: TcxTabSheet
          Caption = '&Fecha'
          object gxRangeBox1: TgxRangeBox
            Left = 117
            Top = 10
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object FechaInicialCtrl: TcxDBDateEdit
            Tag = 3
            Left = 132
            Top = 3
            DataBinding.DataField = 'FechaInicial'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            TabOrder = 0
            Width = 100
          end
          object FechaFinalCtrl: TcxDBDateEdit
            Left = 132
            Top = 30
            DataBinding.DataField = 'FechaFinal'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            TabOrder = 1
            Width = 100
          end
          object Label6: TcxLabel
            Left = 8
            Top = 7
            TabStop = False
            Caption = 'Fecha'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
        end
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 207
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      521
      36)
    Height = 36
    Width = 521
    object Panel3: TcxGroupBox
      Left = 174
      Top = 4
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
    FirstDataControl = SerieInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 478
    Top = 12
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 476
    Top = 47
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 444
    Top = 47
  end
  object Report: TgxReportManager
    FileName = 'dm120\l_shp'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    OnSetReportName = ReportSetReportName
    Left = 386
    Top = 12
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 416
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 447
    Top = 12
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataNroDocumentoInicial: TIntegerField
      FieldName = 'NroDocumentoInicial'
    end
    object DataNroDocumentoFinal: TIntegerField
      FieldName = 'NroDocumentoFinal'
    end
    object DataSerieInicial: TStringField
      FieldName = 'SerieInicial'
      Size = 2
    end
    object DataSerieFinal: TStringField
      FieldName = 'SerieFinal'
      Size = 2
    end
  end
  object SeriesFacturacionTable: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.InMemoryDatabase
    Timeout = 6000
    StoreDefs = True
    FieldDefs = <
      item
        Name = 'NroRegistro'
        DataType = ftSmallint
      end
      item
        Name = 'Codigo'
        DataType = ftString
        Size = 9
      end
      item
        Name = 'Descripcion'
        DataType = ftString
        Size = 80
      end>
    IndexDefs = <
      item
        Name = 'Sequential Access Index'
        Options = [ixPrimary, ixUnique, ixDescending, ixCaseInsensitive]
      end
      item
        Name = 'Index1'
        Fields = 'NroRegistro'
      end
      item
        Name = 'Index2'
        Fields = 'Codigo'
      end>
    AutoIncFieldName = 'NroRegistro'
    TableType = ttMemVirtual
    Left = 477
    Top = 84
    object SeriesFacturacionTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
    end
    object SeriesFacturacionTableCodigo: TStringField
      DisplayWidth = 2
      FieldName = 'Codigo'
      Size = 2
    end
    object SeriesFacturacionTableDescripcion: TStringField
      DisplayWidth = 30
      FieldName = 'Descripcion'
      Size = 30
    end
  end
  object SeriesFacturacionDataSource: TDataSource
    DataSet = SeriesFacturacionTable
    Left = 443
    Top = 84
  end
  object GridViewRepository: TcxGridViewRepository
    Left = 410
    Top = 84
    object SeriesFacturacionTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = SeriesFacturacionDataSource
      DataController.KeyFieldNames = 'NroRegistro'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.FocusFirstCellOnNewRecord = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsData.Appending = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object SeriesFacturacionTableViewCodigo: TcxGridDBColumn
        DataBinding.FieldName = 'Codigo'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.OnQueryRequest = SerieFacturacionCtrlPropertiesQueryRequest
        Properties.OnValidate = SeriesFacturacionTableViewCodigoPropertiesValidate
        Width = 80
      end
      object SeriesFacturacionTableViewDescripcion: TcxGridDBColumn
        DataBinding.FieldName = 'Descripcion'
        Options.Editing = False
        Options.Focusing = False
        Width = 350
      end
    end
  end
end
