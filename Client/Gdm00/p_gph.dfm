object GphTemplateForm: TGphTemplateForm
  Left = 421
  Top = 282
  HelpType = htKeyword
  BorderStyle = bsDialog
  ClientHeight = 469
  ClientWidth = 847
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
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
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 433
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      847
      36)
    Height = 36
    Width = 847
    object Panel1: TcxGroupBox
      Left = 288
      Top = 1
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 34
      Width = 271
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 85
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 4
        Margins.Bottom = 0
        Align = alLeft
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
        AlignWithMargins = True
        Left = 91
        Top = 2
        Width = 85
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 4
        Margins.Bottom = 0
        Align = alLeft
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
      object imprimirBtn: TgBitBtn
        AlignWithMargins = True
        Left = 180
        Top = 2
        Width = 85
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 4
        Margins.Bottom = 0
        Align = alLeft
        Caption = '&Imprimir'
        Enabled = False
        OptionsImage.ImageIndex = 19
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        OnClick = imprimirBtnClick
        GlyphBitmap = gmPrinter
      end
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 35
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
    TabOrder = 0
    PanelKind = epDataPanel
    Height = 398
    Width = 837
    object GridChart1: TcxGrid
      Left = 2
      Top = 2
      Width = 833
      Height = 394
      Align = alClient
      TabOrder = 0
      object GridChart1View: TcxGridDBChartView
        PopupMenu = PrintPopupMenu
        Categories.DataBinding.FieldName = 'TextoPeriodo'
        DataController.DataSource = GridDataSource
        DiagramArea.Values.CaptionPosition = ldvcpAbove
        DiagramBar.Values.CaptionPosition = cdvcpCenter
        DiagramColumn.AxisValue.MinMaxValues = mmvAuto
        DiagramColumn.Values.CaptionPosition = cdvcpOutsideEnd
        DiagramLine.Active = True
        DiagramLine.Values.CaptionPosition = ldvcpAbove
        DiagramLine.Values.LineWidth = 3
        DiagramLine.Values.MarkerStyle = cmsCircle
        DiagramPie.Values.CaptionPosition = pdvcpOutsideEnd
        DiagramStackedArea.Values.CaptionPosition = ldvcpAbove
        DiagramStackedArea.Values.MarkerStyle = cmsCircle
        DiagramStackedBar.Values.CaptionPosition = cdvcpOutsideEnd
        DiagramStackedColumn.Values.CaptionPosition = cdvcpOutsideEnd
        Legend.Position = cppBottom
        ToolBox.DiagramSelector = True
        ToolBox.Visible = tvNever
      end
      object GridChart1Level: TcxGridLevel
        GridView = GridChart1View
      end
    end
  end
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    TabStop = True
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epKeyPanel
    Height = 35
    Width = 847
    object NroOperacionCtrl: TcxDBTextEdit
      Left = 93
      Top = 6
      DescriptionLabel = DescLabel
      DataBinding.DataField = 'NroOperacion'
      DataBinding.DataSource = PlantillaGraficoDataSource
      Properties.OnQueryRequest = NroOperacionCtrlPropertiesQueryRequest
      Properties.OnEditRequest = NroOperacionCtrlPropertiesEditRequest
      Properties.OnValidate = NroOperacionCtrlPropertiesValidate
      TabOrder = 0
      Width = 53
    end
    object Label2: TcxLabel
      Left = 15
      Top = 9
      TabStop = False
      Caption = 'N'#186' plantilla'
      ParentColor = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object DescLabel: TcxLabel
      Left = 170
      Top = 9
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
      Height = 19
      Width = 393
    end
  end
  object FormManager: TgxFormManager
    Dataset = PlantillaGraficoTable
    FirstKeyControl = NroOperacionCtrl
    FirstDataControl = GridChart1
    Model = fmEditForm
    BrowseOnlyDataset = True
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnUpdateButtonsState = FormManagerUpdateButtonsState
    Left = 684
    Top = 4
  end
  object PlantillaGraficoTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'PlantillaGrafico'
    IndexFieldNames = 'Tipo;NroOperacion;NroRegistro'
    AutoIncFieldName = 'NroRegistro'
    CanInsert = False
    OnRecordChanged = PlantillaGraficoTableRecordChanged
    Left = 652
    Top = 4
  end
  object LineaPlantillaGraficoTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'PlantillaGrafico'
    IndexFieldNames = 'Tipo;NroOperacion;NroRegistro'
    AutoIncFieldName = 'NroRegistro'
    CanInsert = False
    Left = 588
    Top = 4
  end
  object PlantillaGraficoDataSource: TDataSource
    DataSet = PlantillaGraficoTable
    Left = 620
    Top = 4
  end
  object GridData: TgxMemData
    Indexes = <
      item
        SortOptions = []
      end>
    SortOptions = []
    Left = 456
    Top = 2
  end
  object GridDataSource: TDataSource
    DataSet = GridData
    Left = 426
    Top = 2
  end
  object PrintPopupMenu: TPopupMenu
    AutoPopup = False
    Left = 492
    Top = 2
    object ImprimirItem: TMenuItem
      Caption = 'Imprimir gr'#225'fico'
      OnClick = imprimirBtnClick
    end
  end
end
