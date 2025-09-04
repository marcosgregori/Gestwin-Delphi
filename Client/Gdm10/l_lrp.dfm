object RptLrpForm: TRptLrpForm
  Left = 387
  Top = 246
  HelpType = htKeyword
  HelpKeyword = 'l_lrp'
  HelpContext = 2114
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Relaci'#243'n de retenciones practicadas'
  ClientHeight = 200
  ClientWidth = 580
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
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
    DesignSize = (
      570
      159)
    Height = 159
    Width = 570
    object SerieRangeBox: TgxRangeBox
      Left = 117
      Top = 14
      Width = 13
      Height = 37
      Hint = 
        'Los campos situados a la derecha marcan un rango de valores.'#13'Arr' +
        'iba el l'#237'mite inferior y abajo el superior.'
      ParentShowHint = False
      ShowHint = True
      Visible = False
    end
    object gxRangeBox1: TgxRangeBox
      Left = 117
      Top = 68
      Width = 13
      Height = 37
      Hint = 
        'Los campos situados a la derecha marcan un rango de valores.'#13'Arr' +
        'iba el l'#237'mite inferior y abajo el superior.'
      ParentShowHint = False
      ShowHint = True
    end
    object SerieInicialCtrl: TcxDBTextEdit
      Left = 132
      Top = 8
      DescriptionLabel = Label7
      DataBinding.DataField = 'SerieInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object SerieFinalCtrl: TcxDBTextEdit
      Left = 132
      Top = 35
      DescriptionLabel = Label9
      DataBinding.DataField = 'SerieFinal'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 1
      Visible = False
      Width = 25
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 132
      Top = 62
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 2
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 132
      Top = 89
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 3
      Width = 100
    end
    object SoloTablaCtrl: TcxDBCheckBox
      Left = 6
      Top = 119
      AutoSize = False
      Caption = '&Solo tabla resumen'
      DataBinding.DataField = 'SoloTablaResumen'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 4
      Transparent = True
      Height = 21
      Width = 145
    end
    object Label6: TcxLabel
      Left = 10
      Top = 12
      TabStop = False
      Caption = 'Serie'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 10
      Top = 66
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object EditSelector: TgxEditSelector
      Left = 210
      Top = 8
      Alignment = alCenterCenter
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 7
      EditMode = tesSimple
      SelectorOptions.StartEdit = SerieInicialCtrl
      SelectorOptions.EndEdit = SerieFinalCtrl
      SelectorOptions.GridView = SeriesFacturacionTableView
      SelectorOptions.RangeBox = SerieRangeBox
      SelectorOptions.FieldName = 'Codigo'
      Height = 25
      Width = 25
    end
    object Label7: TcxLabel
      Left = 247
      Top = 11
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 313
    end
    object Label9: TcxLabel
      Left = 247
      Top = 38
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 313
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 164
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      580
      36)
    Height = 36
    Width = 580
    object Panel3: TcxGroupBox
      Left = 205
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
    FirstDataControl = SerieInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 532
    Top = 12
  end
  object AsientoQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    Left = 532
    Top = 42
  end
  object ApunteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 500
    Top = 42
  end
  object Data: TgxMemData
    Indexes = <
      item
        SortOptions = []
      end>
    SortOptions = []
    Left = 501
    Top = 12
    object DataSerieInicial: TWideStringField
      FieldName = 'SerieInicial'
      Size = 2
    end
    object DataSerieFinal: TWideStringField
      FieldName = 'SerieFinal'
      Size = 2
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataSoloTablaResumen: TBooleanField
      FieldName = 'SoloTablaResumen'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 470
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_lrp'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 470
    Top = 42
  end
  object GridViewRepository: TcxGridViewRepository
    Left = 370
    Top = 10
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
        Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
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
  object SeriesFacturacionDataSource: TDataSource
    DataSet = SeriesFacturacionTable
    Left = 401
    Top = 10
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
      end>
    AutoIncFieldName = 'NroRegistro'
    TableType = ttMemVirtual
    Left = 433
    Top = 10
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
  object RelacionTable: TnxMemTable
    ActiveRuntime = True
    Database = SessionDataModule.InMemoryDatabase
    IndexFieldNames = 'FechaAplicacion;Tipo;Propietario'
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'Sequential Access Index'
        Options = [ixPrimary, ixUnique, ixDescending, ixCaseInsensitive]
      end
      item
        Name = 'Index1'
        Fields = 'FechaAplicacion;Tipo;Propietario'
      end>
    Left = 500
    Top = 74
    object RelacionTableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object RelacionTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object RelacionTablePropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 9
    end
  end
  object SumasTable: TnxMemTable
    ActiveRuntime = True
    Database = SessionDataModule.InMemoryDatabase
    IndexFieldNames = 'FechaAplicacion;Tipo'
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'Sequential Access Index'
        Options = [ixPrimary, ixUnique, ixDescending, ixCaseInsensitive]
      end
      item
        Name = 'Index1'
        Fields = 'FechaAplicacion;Tipo'
      end>
    Left = 500
    Top = 106
    object SumasTableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object SumasTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object SumasTableBaseImponible: TBCDField
      FieldName = 'BaseImponible'
    end
    object SumasTableRetencion: TBCDField
      FieldName = 'Retencion'
    end
    object SumasTableImporte: TBCDField
      FieldName = 'Importe'
    end
  end
end
