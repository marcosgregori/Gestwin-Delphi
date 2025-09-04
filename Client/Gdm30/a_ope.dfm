object MntOpeForm: TMntOpeForm
  Left = 369
  Top = 292
  HelpType = htKeyword
  HelpKeyword = 'a_ope'
  HelpContext = 1106
  BorderStyle = bsDialog
  ClientHeight = 631
  ClientWidth = 526
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
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
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 65
    Width = 526
    object CodigoCtrl: TcxDBTextEdit
      Left = 90
      Top = 34
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 1
      Width = 46
    end
    object codigoCtrlCaption: TcxLabel
      Left = 16
      Top = 34
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
    object cxLabel1: TcxLabel
      Left = 16
      Top = 8
      TabStop = False
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
    object ClienteCtrl: TcxDBTextEdit
      Left = 90
      Top = 7
      DescriptionLabel = Label9
      DataBinding.DataField = 'CodigoPropietario'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
      Properties.OnEditRequest = ClienteCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = ClienteCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object Label9: TcxLabel
      Left = 162
      Top = 8
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 4
      Transparent = True
      Height = 20
      Width = 350
      AnchorY = 18
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 65
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
    Height = 531
    Width = 516
    object cxGroupBox3: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 33
      Width = 512
      object Label1: TcxLabel
        Left = 9
        Top = 10
        Caption = 'Nombre'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object NombreCtrl: TcxDBTextEdit
        Left = 83
        Top = 6
        DataBinding.DataField = 'Nombre'
        DataBinding.DataSource = DataSource
        TabOrder = 0
        Width = 421
      end
    end
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 251
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Height = 27
      Width = 512
      object Campo1Label: TcxLabel
        Left = 10
        Top = 6
        TabStop = False
        Caption = 'Campo 1'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo1Ctrl: TcxDBTextEdit
        Left = 83
        Top = 1
        CaptionLabel = Campo1Label
        DataBinding.DataField = 'Campo1'
        DataBinding.DataSource = DataSource
        TabOrder = 1
        Width = 291
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 278
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 3
      Height = 27
      Width = 512
      object Campo2Label: TcxLabel
        Left = 10
        Top = 4
        TabStop = False
        Caption = 'Campo 2'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo2Ctrl: TcxDBTextEdit
        Left = 83
        Top = 0
        CaptionLabel = Campo2Label
        DataBinding.DataField = 'Campo2'
        DataBinding.DataSource = DataSource
        TabOrder = 1
        Width = 291
      end
    end
    object cxGroupBox4: TcxGroupBox
      Left = 2
      Top = 305
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 4
      Height = 27
      Width = 512
      object Campo3Label: TcxLabel
        Left = 10
        Top = 3
        TabStop = False
        Caption = 'Campo 3'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo3Ctrl: TcxDBTextEdit
        Left = 83
        Top = 0
        CaptionLabel = Campo3Label
        DataBinding.DataField = 'Campo3'
        DataBinding.DataSource = DataSource
        TabOrder = 1
        Width = 151
      end
    end
    object cxGroupBox5: TcxGroupBox
      Left = 2
      Top = 332
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 5
      Height = 27
      Width = 512
      object Campo4Label: TcxLabel
        Left = 10
        Top = 3
        TabStop = False
        Caption = 'Campo 4'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo4Ctrl: TcxDBTextEdit
        Left = 83
        Top = 0
        CaptionLabel = Campo4Label
        DataBinding.DataField = 'Campo4'
        DataBinding.DataSource = DataSource
        TabOrder = 1
        Width = 151
      end
    end
    object cxGroupBox6: TcxGroupBox
      Left = 2
      Top = 359
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 6
      Height = 27
      Width = 512
      object Campo5Label: TcxLabel
        Left = 10
        Top = 3
        TabStop = False
        Caption = 'Campo 5'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo5Ctrl: TcxDBTextEdit
        Left = 83
        Top = 0
        CaptionLabel = Campo5Label
        DataBinding.DataField = 'Campo5'
        DataBinding.DataSource = DataSource
        TabOrder = 1
        Width = 151
      end
    end
    object cxGroupBox7: TcxGroupBox
      Left = 2
      Top = 386
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 7
      Height = 27
      Width = 512
      object Campo6Label: TcxLabel
        Left = 10
        Top = 3
        TabStop = False
        Caption = 'Campo 6'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo6Ctrl: TcxDBTextEdit
        Left = 83
        Top = 0
        CaptionLabel = Campo6Label
        DataBinding.DataField = 'Campo6'
        DataBinding.DataSource = DataSource
        TabOrder = 1
        Width = 151
      end
    end
    object cxGroupBox8: TcxGroupBox
      Left = 2
      Top = 413
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 8
      Height = 27
      Width = 512
      object Campo7Label: TcxLabel
        Left = 10
        Top = 3
        TabStop = False
        Caption = 'Campo 7'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo7Ctrl: TcxDBTextEdit
        Left = 83
        Top = 0
        CaptionLabel = Campo7Label
        DataBinding.DataField = 'Campo7'
        DataBinding.DataSource = DataSource
        TabOrder = 1
        Width = 151
      end
    end
    object cxGroupBox9: TcxGroupBox
      Left = 2
      Top = 440
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 9
      Height = 27
      Width = 512
      object Campo8Label: TcxLabel
        Left = 10
        Top = 3
        TabStop = False
        Caption = 'Campo 8'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo8Ctrl: TcxDBTextEdit
        Left = 83
        Top = 0
        CaptionLabel = Campo8Label
        DataBinding.DataField = 'Campo8'
        DataBinding.DataSource = DataSource
        TabOrder = 1
        Width = 151
      end
    end
    object cxGroupBox10: TcxGroupBox
      Left = 2
      Top = 467
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 10
      Height = 27
      Width = 512
      object Campo9Label: TcxLabel
        Left = 10
        Top = 3
        TabStop = False
        Caption = 'Campo 9'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo9Ctrl: TcxDBDateEdit
        Left = 83
        Top = 0
        CaptionLabel = Campo9Label
        DataBinding.DataField = 'CampoFecha1'
        DataBinding.DataSource = DataSource
        TabOrder = 1
        Width = 100
      end
    end
    object cxGroupBox11: TcxGroupBox
      Left = 2
      Top = 494
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 11
      Height = 27
      Width = 512
      object Campo10Label: TcxLabel
        Left = 10
        Top = 3
        TabStop = False
        Caption = 'Campo 10'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object Campo10Ctrl: TcxDBDateEdit
        Left = 83
        Top = 0
        CaptionLabel = Campo10Label
        DataBinding.DataField = 'CampoFecha2'
        DataBinding.DataSource = DataSource
        TabOrder = 1
        Width = 100
      end
    end
    object DireccionGroupBox: TcxGroupBox
      Left = 2
      Top = 35
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      DesignSize = (
        512
        216)
      Height = 216
      Width = 512
      object LocalidadCtrl: TcxDBTextEdit
        Left = 83
        Top = 1
        DataBinding.DataField = 'Localidad'
        DataBinding.DataSource = DataSource
        TabOrder = 0
        Width = 291
      end
      object TelefonoCtrl: TcxDBTextEdit
        Left = 83
        Top = 82
        DataBinding.DataField = 'Telefono'
        DataBinding.DataSource = DataSource
        TabOrder = 4
        Width = 151
      end
      object FaxCtrl: TcxDBTextEdit
        Left = 83
        Top = 136
        DataBinding.DataField = 'Fax'
        DataBinding.DataSource = DataSource
        TabOrder = 6
        Width = 151
      end
      object CodigoProvinciaCtrl: TcxDBTextEdit
        Left = 83
        Top = 55
        DescriptionLabel = DescCPLabel
        DataBinding.DataField = 'CodigoProvincia'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoProvinciaCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoProvinciaCtrlPropertiesEditRequest
        Properties.OnValidate = CodigoProvinciaCtrlPropertiesValidate
        TabOrder = 2
        Width = 25
      end
      object CodigoPostalCtrl: TcxDBTextEdit
        Left = 110
        Top = 55
        DescriptionLabel = DescCPLabel
        DataBinding.DataField = 'CodigoPostal'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoPostalCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoPostalCtrlPropertiesEditRequest
        Properties.OnValidate = CodigoPostalCtrlPropertiesValidate
        TabOrder = 3
        Width = 32
      end
      object PaisCtrl: TcxDBTextEdit
        Left = 83
        Top = 28
        DescriptionLabel = DescPaisLabel
        DataBinding.DataField = 'CodigoPais'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnEnter = PaisCtrlPropertiesEnter
        Properties.OnQueryRequest = PaisCtrlPropertiesQueryRequest
        Properties.OnEditRequest = PaisCtrlPropertiesEditRequest
        Properties.TextEditPad = tpLeftZero
        Properties.PadAlways = True
        Properties.OnValidate = PaisCtrlPropertiesValidate
        TabOrder = 1
        Width = 32
      end
      object MovilCtrl: TcxDBTextEdit
        Left = 83
        Top = 109
        DataBinding.DataField = 'Movil'
        DataBinding.DataSource = DataSource
        TabOrder = 5
        Width = 151
      end
      object capLocalidadLabel: TcxLabel
        Left = 10
        Top = 4
        Caption = 'Localidad'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 10
        Transparent = True
      end
      object capProvinciaLabel: TcxLabel
        Left = 10
        Top = 58
        Caption = 'Prov. / C.P.'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 11
        Transparent = True
      end
      object DescCPLabel: TcxLabel
        Left = 155
        Top = 58
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 12
        Transparent = True
        Height = 19
        Width = 310
      end
      object capFaxLabel: TcxLabel
        Left = 10
        Top = 139
        Caption = 'Fax'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 13
        Transparent = True
      end
      object Label8: TcxLabel
        Left = 10
        Top = 31
        Caption = 'Pais'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 14
        Transparent = True
      end
      object DescPaisLabel: TcxLabel
        Left = 155
        Top = 31
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 15
        Transparent = True
        Height = 19
        Width = 310
      end
      object Label3: TcxLabel
        Left = 10
        Top = 112
        Caption = 'M'#243'vil'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 16
        Transparent = True
      end
      object Label4: TcxLabel
        Left = 10
        Top = 85
        Caption = 'Tel'#233'fono'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 17
        Transparent = True
      end
      object Label10: TcxLabel
        Left = 10
        Top = 166
        Caption = 'E-mail'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 18
        Transparent = True
      end
      object EMailCtrl: TcxDBTextEdit
        Left = 83
        Top = 163
        DataBinding.DataField = 'EMail'
        DataBinding.DataSource = DataSource
        TabOrder = 7
        Width = 323
      end
      object capTelefonoLabel: TcxLabel
        Left = 10
        Top = 193
        Caption = 'N.I.F.'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 19
        Transparent = True
      end
      object NIFCtrl: TcxDBTextEdit
        Left = 83
        Top = 190
        DescriptionLabel = DescNIF
        DataBinding.DataField = 'NIF'
        DataBinding.DataSource = DataSource
        Properties.OnValidate = NIFCtrlPropertiesValidate
        TabOrder = 9
        Width = 107
      end
      object DescNIF: TcxLabel
        Left = 205
        Top = 193
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 20
        Transparent = True
        Height = 21
        Width = 296
      end
      object EnviarCorreoBtn: TgBitBtn
        Left = 413
        Top = 159
        Width = 91
        Height = 33
        Caption = '&Redactar'
        Enabled = True
        OptionsImage.ImageIndex = 52
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 8
        OnClick = EnviarCorreoBtnClick
        GlyphBitmap = gmSendMail
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 596
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      526
      35)
    Height = 35
    Width = 526
    object Panel2: TcxGroupBox
      Left = 134
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
  object FormManager: TgxFormManager
    Dataset = OperarioTable
    FirstKeyControl = ClienteCtrl
    FirstDataControl = NombreCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 456
    Top = 4
  end
  object OperarioTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Operario'
    IndexFieldNames = 'CodigoPropietario;Codigo'
    AutoIncFieldName = 'Codigo'
    Left = 424
    Top = 4
  end
  object DataSource: TDataSource
    DataSet = OperarioTable
    Left = 392
    Top = 4
  end
end
