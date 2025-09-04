object BoxAalForm: TBoxAalForm
  Left = 480
  Top = 315
  HelpType = htKeyword
  HelpKeyword = 'b_aal'
  BorderStyle = bsDialog
  Caption = 'Asignaci'#243'n de almac'#233'n'
  ClientHeight = 161
  ClientWidth = 416
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
    Height = 120
    Width = 406
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 6
      Top = 47
      Align = alClient
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      Style.TransparentBorder = False
      TabOrder = 1
      Transparent = True
      Height = 67
      Width = 394
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 8
        Top = 17
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        Caption = 'Indique el almac'#233'n al que quiere traspasar todas las l'#237'neas.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 383
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 3
      Top = 3
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        400
        41)
      Height = 41
      Width = 400
      object AlmacenCtrl: TcxDBTextEdit
        Left = 83
        Top = 8
        DescriptionLabel = Label5
        DataBinding.DataField = 'Almacen'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
        Properties.OnEditRequest = AlmacenCtrlPropertiesEditRequest
        Properties.OnValidate = AlmacenCtrlPropertiesValidate
        TabOrder = 0
        Width = 25
      end
      object Label4: TcxLabel
        Left = 10
        Top = 11
        TabStop = False
        Caption = 'Almac'#233'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object Label5: TcxLabel
        Left = 151
        Top = 11
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
        Height = 19
        Width = 179
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 125
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      416
      36)
    Height = 36
    Width = 416
    object Panel3: TcxGroupBox
      Left = 123
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
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 252
    Top = 40
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 184
    Top = 40
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 217
    Top = 40
    object DataAlmacen: TWideStringField
      FieldName = 'Almacen'
      Size = 2
    end
  end
end
