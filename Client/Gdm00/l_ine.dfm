object RptIneForm: TRptIneForm
  Left = 494
  Top = 301
  HelpType = htKeyword
  HelpKeyword = 'l_ine'
  HelpContext = 214
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de informes externos'
  ClientHeight = 113
  ClientWidth = 477
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
      467
      72)
    Height = 72
    Width = 467
    object gxRangeBox1: TgxRangeBox
      Left = 108
      Top = 14
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object Label1: TcxLabel
      Left = 10
      Top = 11
      TabStop = False
      Caption = 'N'#186' de registro'
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 190
      Top = 35
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 273
      AnchorY = 45
    end
    object Label3: TcxLabel
      Left = 190
      Top = 11
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 273
      AnchorY = 21
    end
    object NroRegistroInicialCtrl: TcxDBSpinEdit
      Left = 124
      Top = 8
      DescriptionLabel = Label3
      DataBinding.DataField = 'NroRegistroInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = NroRegistroCtrlPropertiesQueryRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 999.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = NroRegistroCtrlPropertiesValidate
      TabOrder = 0
      Width = 54
    end
    object NroRegistroFinalCtrl: TcxDBSpinEdit
      Left = 124
      Top = 34
      DescriptionLabel = Label4
      DataBinding.DataField = 'NroRegistroFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = NroRegistroCtrlPropertiesQueryRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 999.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = NroRegistroCtrlPropertiesValidate
      TabOrder = 1
      Width = 54
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 77
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      477
      36)
    Height = 36
    Width = 477
    object Panel3: TcxGroupBox
      Left = 152
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
    FirstDataControl = NroRegistroInicialCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 314
    Top = 8
  end
  object Report: TgxReportManager
    FileName = 'dm00\l_ine'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 216
    Top = 8
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 282
    Top = 8
    object DataNroRegistroInicial: TSmallintField
      FieldName = 'NroRegistroInicial'
    end
    object DataNroRegistroFinal: TSmallintField
      FieldName = 'NroRegistroFinal'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 250
    Top = 8
  end
end
