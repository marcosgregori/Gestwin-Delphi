object MntCopForm: TMntCopForm
  Left = 379
  Top = 234
  HelpType = htKeyword
  HelpKeyword = 'a_cop'
  HelpContext = 211
  BorderStyle = bsDialog
  Caption = 'C'#243'digos postales'
  ClientHeight = 206
  ClientWidth = 590
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
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
      590
      85)
    Height = 85
    Width = 590
    object CodigoProvinciaCtrl: TcxDBTextEdit
      Left = 116
      Top = 29
      DescriptionLabel = Label3
      DataBinding.DataField = 'CodigoProvincia'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoProvinciaTextEditPropertiesQueryRequest
      Properties.OnEditRequest = CodigoProvinciaTextEditPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoProvinciaTextEditPropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object CodigoCtrl: TcxDBTextEdit
      Left = 116
      Top = 55
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      TabOrder = 2
      Width = 75
    end
    object CodigoPaisCtrl: TcxDBTextEdit
      Left = 116
      Top = 3
      DescriptionLabel = Label5
      DataBinding.DataField = 'CodigoPais'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoPaisTextEditPropertiesQueryRequest
      Properties.OnEditRequest = CodigoPaisTextEditPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoPaisTextEditPropertiesValidate
      TabOrder = 0
      Width = 32
    end
    object codigoCtrlCaption: TcxLabel
      Left = 13
      Top = 32
      Caption = 'Provincia - Zona'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 13
      Top = 58
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 180
      Top = 32
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 402
    end
    object Label4: TcxLabel
      Left = 13
      Top = 6
      Caption = 'Pais'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 180
      Top = 6
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 402
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 170
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      590
      36)
    Height = 36
    Width = 590
    object Panel2: TcxGroupBox
      Left = 162
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 262
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
    Top = 85
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
    DesignSize = (
      580
      85)
    Height = 85
    Width = 580
    object NombreCtrl: TcxDBMemo
      Left = 111
      Top = 6
      Anchors = [akLeft, akTop, akRight]
      DataBinding.DataField = 'Nombre'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.WantReturns = False
      TabOrder = 0
      Height = 73
      Width = 460
    end
    object Label1: TcxLabel
      Left = 9
      Top = 9
      Caption = 'Nombre'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object FormManager: TgxFormManager
    Dataset = CodigoPostalTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = NombreCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 350
    Top = 4
  end
  object DataSource: TDataSource
    DataSet = CodigoPostalTable
    Left = 288
    Top = 4
  end
  object CodigoPostalTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'CodigoPostal'
    IndexFieldNames = 'CodigoPais;CodigoProvincia;Codigo'
    Left = 318
    Top = 4
  end
end
