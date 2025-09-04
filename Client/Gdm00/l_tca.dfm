object rptTcaForm: TrptTcaForm
  Left = 587
  Top = 422
  HelpType = htKeyword
  HelpKeyword = 'l_tca'
  HelpContext = 218
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de tipos de cambio'
  ClientHeight = 141
  ClientWidth = 481
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
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
      471
      100)
    Height = 100
    Width = 471
    object gxRangeBox1: TgxRangeBox
      Left = 96
      Top = 42
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 112
      Top = 35
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 95
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 112
      Top = 62
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 2
      Width = 95
    end
    object CodigoDivisaCtrl: TcxDBTextEdit
      Left = 112
      Top = 8
      DescriptionLabel = Label4
      DataBinding.DataField = 'CodigoDivisa'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoDivisaCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoDivisaCtrlPropertiesValidate
      TabOrder = 0
      Width = 32
    end
    object Label1: TcxLabel
      Left = 10
      Top = 38
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 10
      Top = 12
      Caption = 'C'#243'digo divisa'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 221
      Top = 12
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 239
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 105
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      481
      36)
    Height = 36
    Width = 481
    object Panel3: TcxGroupBox
      Left = 154
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
    Dataset = MemData
    FirstDataControl = CodigoDivisaCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 350
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm00\l_tca'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = MemData
    ToPrinter = False
    BeforeStart = ReportBeforeStart
    Left = 260
    Top = 10
  end
  object MemData: TgxMemData
    Indexes = <>
    SortOptions = []
    AfterInsert = MemDataAfterInsert
    Left = 322
    Top = 10
    object MemDataCodigoDivisa: TWideStringField
      FieldName = 'CodigoDivisa'
      Required = True
      Size = 3
    end
    object MemDataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object MemDataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
  end
  object DataSource: TDataSource
    DataSet = MemData
    Left = 292
    Top = 10
  end
end
