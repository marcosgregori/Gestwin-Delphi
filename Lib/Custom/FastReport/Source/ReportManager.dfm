object ReportManagerDataModule: TReportManagerDataModule
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 664
  Width = 739
  object OpenDialog: TOpenDialog
    Filter = 'Fichero de informe  (*.frp)|*.frp'
    Left = 72
    Top = 18
  end
  object FrxBarCodeObject: TfrxBarCodeObject
    Left = 218
    Top = 18
  end
  object FrxRichObject: TfrxRichObject
    Left = 220
    Top = 118
  end
  object FrxCrossObject: TfrxCrossObject
    Left = 220
    Top = 180
  end
  object frxCheckBoxObject: TfrxCheckBoxObject
    Left = 340
    Top = 18
  end
  object frxGradientObject: TfrxGradientObject
    Left = 340
    Top = 72
  end
  object frxDotMatrixExport: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = True
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 584
    Top = 376
  end
  object frxDialogControls: TfrxDialogControls
    Left = 340
    Top = 126
  end
  object frxGZipCompressor: TfrxGZipCompressor
    Left = 340
    Top = 190
  end
  object FrxNXComponents: TfrxNXComponents
    Left = 70
    Top = 170
  end
  object Designer: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Segoe UI'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = '.fr3'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    OnShowStartupScreen = DesignerShowStartupScreen
    Left = 72
    Top = 112
  end
  object frxHTMLExport: TfrxHTMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = True
    DataOnly = False
    OpenAfterExport = False
    FixedWidth = True
    Background = True
    Centered = False
    EmptyLines = True
    Print = False
    PictureType = gpPNG
    Outline = False
    Left = 488
    Top = 126
  end
  object frxXMLExport: TfrxXMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = True
    DataOnly = False
    Wysiwyg = False
    Background = True
    Creator = 'Gestwin'
    EmptyLines = False
    SuppressPageHeadersFooters = False
    RowsCount = 0
    Split = ssNotSplit
    Left = 488
    Top = 182
  end
  object frxRTFExport: TfrxRTFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = True
    DataOnly = False
    PictureType = gpPNG
    OpenAfterExport = False
    Wysiwyg = True
    Creator = 'Gestwin'
    SuppressPageHeadersFooters = False
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 488
    Top = 247
  end
  object frxBMPExport: TfrxBMPExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = True
    DataOnly = False
    Left = 488
    Top = 305
  end
  object frxJPEGExport: TfrxJPEGExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = True
    DataOnly = False
    Left = 488
    Top = 370
  end
  object frxPDFExport: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EmbedFontsIfProtected = False
    InteractiveFormsFontSubset = 'A-Z,a-z,0-9,#43-#47 '
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'Gestwin'
    Subject = 'Fichero PDF Gestwin'
    Creator = 'Gestwin'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    Left = 488
    Top = 20
  end
  object frxSimpleTextExport: TfrxSimpleTextExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = True
    DataOnly = False
    Frames = False
    EmptyLines = False
    OEMCodepage = False
    UTF8 = False
    OpenAfterExport = False
    DeleteEmptyColumns = True
    Left = 486
    Top = 512
  end
  object frxCSVExport: TfrxCSVExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = True
    DataOnly = False
    Separator = ';'
    OEMCodepage = False
    UTF8 = False
    OpenAfterExport = False
    NoSysSymbols = True
    ForcedQuotes = False
    Left = 586
    Top = 516
  end
  object frxMailExport: TfrxMailExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = True
    DataOnly = False
    ShowExportDialog = True
    UseIniFile = True
    ConfirmReading = False
    Left = 486
    Top = 578
  end
  object ReportQuery: TnxeQuery
    Timeout = 180000
    RequestLive = True
    ReadOnly = True
    Left = 72
    Top = 286
  end
  object frxODSExport: TfrxODSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = True
    CreationTime = 0.000000000000000000
    DataOnly = False
    PictureType = gpPNG
    OpenAfterExport = False
    Background = True
    Creator = 'Gestwin'
    SingleSheet = False
    Language = 'en'
    SuppressPageHeadersFooters = False
    Left = 588
    Top = 248
  end
  object frxODTExport: TfrxODTExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = True
    CreationTime = 0.000000000000000000
    DataOnly = False
    PictureType = gpPNG
    OpenAfterExport = False
    Background = True
    Creator = 'Gestwin'
    SingleSheet = False
    Language = 'en'
    SuppressPageHeadersFooters = False
    Left = 588
    Top = 306
  end
  object XMLDocument: TXMLDocument
    Options = [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix, doNamespaceDecl]
    Left = 70
    Top = 340
    DOMVendorDesc = 'MSXML'
  end
  object frxCrypt: TfrxCrypt
    Left = 342
    Top = 254
  end
  object frxDOCXExport: TfrxDOCXExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    PictureType = gpPNG
    ExportType = dxTable
    Left = 486
    Top = 446
  end
  object frxGaugeObject: TfrxGaugeObject
    Left = 220
    Top = 252
  end
  object frxMapObject: TfrxMapObject
    Left = 214
    Top = 334
  end
end
