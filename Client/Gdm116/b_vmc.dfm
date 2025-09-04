object BoxVmcForm: TBoxVmcForm
  Left = 426
  Top = 317
  HelpType = htKeyword
  HelpKeyword = 'b_vmc'
  ActiveControl = CloseButton
  BorderStyle = bsDialog
  Caption = 'Valoraci'#243'n de la manufactura'
  ClientHeight = 546
  ClientWidth = 706
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
  Position = poDesigned
  Visible = True
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 510
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    DesignSize = (
      706
      36)
    Height = 36
    Width = 706
    object Panel3: TcxGroupBox
      Left = 267
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
  object DataPanel: TgxEditPanel
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
    Style.TextColor = clGreen
    TabOrder = 1
    PanelKind = epInputPanel
    Height = 505
    Width = 696
    object ArticuloLabel: TcxLabel
      Left = 123
      Top = 10
      TabStop = False
      AutoSize = False
      ParentColor = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Color = clBtnFace
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      Style.TextColor = clNavy
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 22
      Transparent = True
      Height = 19
      Width = 137
      AnchorY = 20
    end
    object DescripcionArticuloLabel: TcxLabel
      Left = 274
      Top = 10
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 23
      Transparent = True
      Height = 19
      Width = 363
      AnchorY = 20
    end
    object Label10: TcxLabel
      Left = 16
      Top = 11
      TabStop = False
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 24
      Transparent = True
      AnchorY = 20
    end
    object BiselCtrl: TcxCheckBox
      Left = 16
      Top = 114
      AutoSize = False
      Caption = 'Bisel'
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 4
      Transparent = True
      Height = 21
      Width = 95
    end
    object Bilateral2Ctrl: TcxCheckBox
      Left = 16
      Top = 139
      AutoSize = False
      Caption = 'Bilateral 2'
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 5
      Transparent = True
      Height = 21
      Width = 95
    end
    object Bilateral4Ctrl: TcxCheckBox
      Left = 16
      Top = 164
      AutoSize = False
      Caption = 'Bilateral  4'
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 6
      Transparent = True
      Height = 21
      Width = 95
    end
    object TaladroCtrl: TcxCheckBox
      Left = 16
      Top = 189
      AutoSize = False
      Caption = 'Taladro'
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 7
      Transparent = True
      Height = 21
      Width = 95
    end
    object FiguraCtrl: TcxCheckBox
      Left = 16
      Top = 214
      AutoSize = False
      Caption = 'Figura'
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 9
      Transparent = True
      Height = 21
      Width = 95
    end
    object MasterCtrl: TcxCheckBox
      Left = 16
      Top = 239
      AutoSize = False
      Caption = 'Master'
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 10
      Transparent = True
      Height = 21
      Width = 95
    end
    object EspecialCtrl: TcxCheckBox
      Left = 16
      Top = 264
      AutoSize = False
      Caption = 'Especial'
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 11
      Transparent = True
      Height = 21
      Width = 95
    end
    object TempladoCtrl: TcxCheckBox
      Left = 16
      Top = 289
      AutoSize = False
      Caption = 'Templado'
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 12
      Transparent = True
      Height = 21
      Width = 95
    end
    object EstriasCtrl: TcxCheckBox
      Left = 16
      Top = 314
      AutoSize = False
      Caption = 'Estr'#237'as'
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 13
      Transparent = True
      Height = 21
      Width = 95
    end
    object PintadoCtrl: TcxCheckBox
      Left = 16
      Top = 339
      AutoSize = False
      Caption = 'Pintado'
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 14
      Transparent = True
      Height = 21
      Width = 95
    end
    object EmbalajeCtrl: TcxCheckBox
      Left = 16
      Top = 365
      AutoSize = False
      Caption = 'Embalaje'
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 15
      Transparent = True
      Height = 21
      Width = 95
    end
    object CantoPulidoCtrl: TcxCheckBox
      Left = 16
      Top = 89
      AutoSize = False
      Caption = 'Canto pulido'
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 2
      Transparent = True
      Height = 21
      Width = 95
    end
    object cxLabel24: TcxLabel
      Left = 16
      Top = 35
      TabStop = False
      Caption = 'Superficie'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 25
      Transparent = True
    end
    object cxLabel25: TcxLabel
      Left = 410
      Top = 414
      TabStop = False
      Caption = 'Importe manufactura'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 26
      Transparent = True
    end
    object TotalManufacturaLabel: TcxLabel
      Left = 585
      Top = 414
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TextStyle = []
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taRightJustify
      TabOrder = 27
      Transparent = True
      Height = 17
      Width = 87
      AnchorX = 672
    end
    object cxLabel27: TcxLabel
      Left = 409
      Top = 441
      TabStop = False
      Caption = '% Incremento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 28
      Transparent = True
    end
    object PorcentajeIncrementoCtrl: TcxDBCurrencyEdit
      Left = 500
      Top = 438
      DataBinding.DataField = 'PorcentajeIncremento'
      DataBinding.DataSource = LineaValoracionManufacturaDataSource
      Properties.MaxLength = 8
      TabOrder = 21
      Width = 50
    end
    object IncrementoLabel: TcxLabel
      Left = 585
      Top = 441
      TabStop = False
      AutoSize = False
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.TextColor = clNavy
      Style.TextStyle = []
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taRightJustify
      TabOrder = 29
      Transparent = True
      Height = 17
      Width = 87
      AnchorX = 672
    end
    object Image1: TcxImage
      Left = 658
      Top = 5
      TabStop = False
      Picture.Data = {
        0D546478536D617274496D6167653C3F786D6C2076657273696F6E3D22312E30
        2220656E636F64696E673D225554462D38223F3E0D0A3C737667207665727369
        6F6E3D22312E31222069643D224C617965725F312220786D6C6E733D22687474
        703A2F2F7777772E77332E6F72672F323030302F7376672220786D6C6E733A78
        6C696E6B3D22687474703A2F2F7777772E77332E6F72672F313939392F786C69
        6E6B2220783D223070782220793D22307078222077696474683D223234707822
        206865696768743D2232347078222076696577426F783D223020302032342032
        342220656E61626C652D6261636B67726F756E643D226E657720302030203234
        2032342220786D6C3A73706163653D227072657365727665223E262331303B20
        203C672069643D2269636F6E223E0D0A09093C7061746820643D224D31392E37
        2C3230632D302E3338362C302C2D302E372C2D302E3331342C2D302E372C2D30
        2E37762D312E3663302C2D302E3338362C302E3331342C2D302E372C302E372C
        2D302E3768312E335637682D312E33632D302E3338362C302C2D302E372C2D30
        2E3331342C2D302E372C2D302E3756342E3763302C2D302E3338362C302E3331
        342C2D302E372C302E372C2D302E3768312E3356322E3263302C2D302E36362C
        2D302E35342C2D312E322C2D312E322C2D312E32682D312E3876312E3363302C
        302E3338362C2D302E3331342C302E372C2D302E372C302E37682D312E36632D
        302E3338362C302C2D302E372C2D302E3331342C2D302E372C2D302E37563148
        3876312E3363302C302E3338362C2D302E3331342C302E372C2D302E372C302E
        3748352E37632D302E3338362C302C2D302E372C2D302E3331342C2D302E372C
        2D302E37563148332E32632D302E36362C302C2D312E322C302E35342C2D312E
        322C312E3276312E3868312E3363302E3338362C302C302E372C302E3331342C
        302E372C302E3776312E3663302C302E3338362C2D302E3331342C302E372C2D
        302E372C302E37483276313068312E3363302E3338362C302C302E372C302E33
        31342C302E372C302E3776312E3663302C302E3338362C2D302E3331342C302E
        372C2D302E372C302E37483276312E3863302C302E36362C302E35342C312E32
        2C312E322C312E3268312E38762D312E3363302C2D302E3338362C302E333134
        2C2D302E372C302E372C2D302E3768312E3663302E3338362C302C302E372C30
        2E3331342C302E372C302E3776312E336837762D312E3363302C2D302E333836
        2C302E3331342C2D302E372C302E372C2D302E3768312E3663302E3338362C30
        2C302E372C302E3331342C302E372C302E3776312E3368312E3863302E36362C
        302C312E322C2D302E35342C312E322C2D312E32762D312E384831392E377A22
        2066696C6C3D2223453645394545222F3E0D0A09093C7061746820643D224D31
        392E372C3230632D302E3338362C302C2D302E372C2D302E3331342C2D302E37
        2C2D302E37762D312E3663302C2D302E3338362C302E3331342C2D302E372C30
        2E372C2D302E3768312E335637682D312E33632D302E3338362C302C2D302E37
        2C2D302E3331342C2D302E372C2D302E3756342E3763302C2D302E3338362C30
        2E3331342C2D302E372C302E372C2D302E3768312E3356322E3263302C2D302E
        36362C2D302E35342C2D312E322C2D312E322C2D312E32682D312E3876312E33
        63302C302E3338362C2D302E3331342C302E372C2D302E372C302E37682D312E
        36632D302E3338362C302C2D302E372C2D302E3331342C2D302E372C2D302E37
        56312E3038384C392E3438392C3233483135762D312E3363302C2D302E333836
        2C302E3331342C2D302E372C302E372C2D302E3768312E3663302E3338362C30
        2C302E372C302E3331342C302E372C302E3776312E3368312E3863302E36362C
        302C312E322C2D302E35342C312E322C2D312E32762D312E384831392E377A22
        2066696C6C3D222332333146323022206F7061636974793D22302E3034222F3E
        0D0A09093C7061746820643D224D31392E342C3138682D322E34563668322E34
        5635682D322E3456322E36682D3176322E34483756322E36483676322E344833
        2E36763168322E3476313248332E36763168322E3476322E346831762D322E34
        683976322E346831762D322E3468322E345631387A4D31362C31384837563668
        395631387A222066696C6C3D222334464330453822206F7061636974793D2230
        2E39222F3E0D0A09093C7061746820643D224D332E332C362E3648312E37632D
        302E3136362C302C2D302E332C2D302E3133342C2D302E332C2D302E3356342E
        3763302C2D302E3136362C302E3133342C2D302E332C302E332C2D302E336831
        2E3663302E3136362C302C302E332C302E3133342C302E332C302E3376312E36
        43332E362C362E3436362C332E3436362C362E362C332E332C362E367A4D372E
        332C322E3648352E37632D302E3136362C302C2D302E332C2D302E3133342C2D
        302E332C2D302E3356302E3763302C2D302E3136362C302E3133342C2D302E33
        2C302E332C2D302E3368312E3663302E3136362C302C302E332C302E3133342C
        302E332C302E3376312E3643372E362C322E3436362C372E3436362C322E362C
        372E332C322E367A4D31372E332C322E36682D312E36632D302E3136362C302C
        2D302E332C2D302E3133342C2D302E332C2D302E3356302E3763302C2D302E31
        36362C302E3133342C2D302E332C302E332C2D302E3368312E3663302E313636
        2C302C302E332C302E3133342C302E332C302E3376312E364331372E362C322E
        3436362C31372E3436362C322E362C31372E332C322E367A4D31372E332C3233
        2E36682D312E36632D302E3136362C302C2D302E332C2D302E3133342C2D302E
        332C2D302E33762D312E3663302C2D302E3136362C302E3133342C2D302E332C
        302E332C2D302E3368312E3663302E3136362C302C302E332C302E3133342C30
        2E332C302E3376312E364331372E362C32332E3436362C31372E3436362C3233
        2E362C31372E332C32332E367A4D372E332C32332E3648352E37632D302E3136
        362C302C2D302E332C2D302E3133342C2D302E332C2D302E33762D312E366330
        2C2D302E3136362C302E3133342C2D302E332C302E332C2D302E3368312E3663
        302E3136362C302C302E332C302E3133342C302E332C302E3376312E3643372E
        362C32332E3436362C372E3436362C32332E362C372E332C32332E367A4D3231
        2E362C362E3356342E3763302C2D302E3136362C2D302E3133342C2D302E332C
        2D302E332C2D302E33682D312E36632D302E3136362C302C2D302E332C302E31
        33342C2D302E332C302E3376312E3663302C302E3136362C302E3133342C302E
        332C302E332C302E3368312E364332312E3436362C362E362C32312E362C362E
        3436362C32312E362C362E337A4D332E332C31392E3648312E37632D302E3136
        362C302C2D302E332C2D302E3133342C2D302E332C2D302E33762D312E366330
        2C2D302E3136362C302E3133342C2D302E332C302E332C2D302E3368312E3663
        302E3136362C302C302E332C302E3133342C302E332C302E3376312E3643332E
        362C31392E3436362C332E3436362C31392E362C332E332C31392E367A4D3231
        2E362C31392E33762D312E3663302C2D302E3136362C2D302E3133342C2D302E
        332C2D302E332C2D302E33682D312E36632D302E3136362C302C2D302E332C30
        2E3133342C2D302E332C302E3376312E3663302C302E3136362C302E3133342C
        302E332C302E332C302E3368312E364332312E3436362C31392E362C32312E36
        2C31392E3436362C32312E362C31392E337A222066696C6C3D22233533363838
        30222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
      Properties.FitMode = ifmProportionalStretch
      Properties.ShowFocusRect = False
      Style.BorderStyle = ebsNone
      TabOrder = 30
      Transparent = True
      Height = 40
      Width = 35
    end
    object cxLabel6: TcxLabel
      Left = 274
      Top = 35
      TabStop = False
      Caption = 'Piezas'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 31
      Transparent = True
    end
    object PiezasLabel: TcxLabel
      Left = 350
      Top = 35
      TabStop = False
      AutoSize = False
      ParentColor = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Color = clBtnFace
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      Style.TextColor = clNavy
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 32
      Transparent = True
      Height = 19
      Width = 70
      AnchorX = 420
      AnchorY = 45
    end
    object CantosPanel: TcxGroupBox
      Left = 123
      Top = 58
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 3
      Height = 57
      Width = 560
      object Shape1: TShape
        Left = 0
        Top = 56
        Width = 560
        Height = 1
        Align = alBottom
        ExplicitLeft = 1
        ExplicitTop = 69
        ExplicitWidth = 680
      end
      object CortoCtrl: TcxDBCurrencyEdit
        Left = 74
        Top = 28
        CaptionLabel = cxLabel1
        DataBinding.DataField = 'Corto'
        DataBinding.DataSource = LineaValoracionManufacturaDataSource
        Properties.MaxLength = 8
        TabOrder = 1
        Width = 71
      end
      object cxLabel1: TcxLabel
        Left = 75
        Top = 7
        TabStop = False
        Caption = 'Corto'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object cxLabel2: TcxLabel
        Left = 151
        Top = 7
        TabStop = False
        Caption = 'ML'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
      end
      object MetrosLinealesCtrl: TcxLabel
        Left = 151
        Top = 32
        TabStop = False
        CaptionLabel = cxLabel2
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 5
        Transparent = True
        Height = 17
        Width = 69
        AnchorX = 220
      end
      object cxLabel4: TcxLabel
        Left = 226
        Top = 7
        TabStop = False
        Caption = 'Precio'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
      end
      object cxLabel5: TcxLabel
        Left = 476
        Top = 9
        TabStop = False
        Caption = 'Subtotal'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
      end
      object Label18: TcxLabel
        Left = 0
        Top = 5
        TabStop = False
        Caption = 'Largo'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
      end
      object LargoCtrl: TcxDBCurrencyEdit
        Left = 0
        Top = 28
        CaptionLabel = Label18
        DataBinding.DataField = 'Largo'
        DataBinding.DataSource = LineaValoracionManufacturaDataSource
        Properties.MaxLength = 8
        TabOrder = 0
        Width = 71
      end
      object PrecioCantosCtrl: TcxDBCurrencyEdit
        Left = 226
        Top = 28
        CaptionLabel = cxLabel4
        DataBinding.DataField = 'PrecioParametro1'
        DataBinding.DataSource = LineaValoracionManufacturaDataSource
        Properties.MaxLength = 8
        TabOrder = 2
        Width = 71
      end
      object SubtotalCantosLabel: TcxLabel
        Left = 476
        Top = 32
        TabStop = False
        CaptionLabel = cxLabel5
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 9
        Transparent = True
        Height = 17
        Width = 73
        AnchorX = 549
      end
    end
    object TaladroPanel: TcxGroupBox
      Left = 123
      Top = 164
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 8
      Height = 52
      Width = 560
      object Shape3: TShape
        Left = 0
        Top = 51
        Width = 560
        Height = 1
        Align = alBottom
        ExplicitTop = 50
        ExplicitWidth = 680
      end
      object cxLabel12: TcxLabel
        Left = 226
        Top = -1
        TabStop = False
        Caption = 'Precio'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
      end
      object cxLabel13: TcxLabel
        Left = 151
        Top = -1
        TabStop = False
        Caption = 'Escots'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
      end
      object cxLabel14: TcxLabel
        Left = 377
        Top = -1
        TabStop = False
        Caption = 'Precio'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
      end
      object cxLabel15: TcxLabel
        Left = 75
        Top = -1
        TabStop = False
        Caption = 'Precio'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
      end
      object cxLabel18: TcxLabel
        Left = 0
        Top = -1
        TabStop = False
        Caption = 'Taladros'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 10
        Transparent = True
      end
      object cxLabel19: TcxLabel
        Left = 302
        Top = -1
        TabStop = False
        Caption = 'Puntas'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 11
        Transparent = True
      end
      object EscotsCtrl: TcxDBCurrencyEdit
        Left = 151
        Top = 23
        DataBinding.DataField = 'CantidadParametro3'
        DataBinding.DataSource = LineaValoracionManufacturaDataSource
        Properties.MaxLength = 8
        TabOrder = 2
        Width = 71
      end
      object PrecioEscotsCtrl: TcxDBCurrencyEdit
        Left = 226
        Top = 23
        DataBinding.DataField = 'PrecioParametro3'
        DataBinding.DataSource = LineaValoracionManufacturaDataSource
        Properties.MaxLength = 8
        TabOrder = 3
        Width = 71
      end
      object PrecioPuntasCtrl: TcxDBCurrencyEdit
        Left = 377
        Top = 23
        DataBinding.DataField = 'PrecioParametro4'
        DataBinding.DataSource = LineaValoracionManufacturaDataSource
        Properties.MaxLength = 8
        TabOrder = 5
        Width = 71
      end
      object PrecioTaladrosCtrl: TcxDBCurrencyEdit
        Left = 75
        Top = 23
        DataBinding.DataField = 'PrecioParametro2'
        DataBinding.DataSource = LineaValoracionManufacturaDataSource
        Properties.MaxLength = 8
        TabOrder = 1
        Width = 71
      end
      object PuntasCtrl: TcxDBCurrencyEdit
        Left = 302
        Top = 23
        DataBinding.DataField = 'CantidadParametro4'
        DataBinding.DataSource = LineaValoracionManufacturaDataSource
        Properties.MaxLength = 8
        TabOrder = 4
        Width = 71
      end
      object SubtotalTaladroLabel: TcxLabel
        Left = 476
        Top = 26
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 12
        Transparent = True
        Height = 17
        Width = 73
        AnchorX = 549
      end
      object TaladrosCtrl: TcxDBCurrencyEdit
        Left = 0
        Top = 23
        DataBinding.DataField = 'CantidadParametro2'
        DataBinding.DataSource = LineaValoracionManufacturaDataSource
        Properties.MaxLength = 8
        TabOrder = 0
        Width = 71
      end
    end
    object EmbalajePanel: TcxGroupBox
      Left = 123
      Top = 334
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 16
      Height = 56
      Width = 560
      object Shape2: TShape
        Left = 0
        Top = 55
        Width = 560
        Height = 1
        Align = alBottom
        ExplicitLeft = -112
        ExplicitTop = 61
        ExplicitWidth = 683
      end
      object PrecioEmbalajeCtrl: TcxDBCurrencyEdit
        Left = 227
        Top = 27
        DataBinding.DataField = 'PrecioParametro6'
        DataBinding.DataSource = LineaValoracionManufacturaDataSource
        Properties.MaxLength = 8
        TabOrder = 2
        Width = 71
      end
      object cxLabel7: TcxLabel
        Left = 151
        Top = 7
        TabStop = False
        Caption = 'M2'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object MetrosCuadradosLabel: TcxLabel
        Left = 151
        Top = 30
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 4
        Transparent = True
        Height = 17
        Width = 69
        AnchorX = 220
      end
      object cxLabel9: TcxLabel
        Left = 227
        Top = 7
        TabStop = False
        Caption = 'Precio'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
      end
      object SubtotalEmbalajeLabel: TcxLabel
        Left = 476
        Top = 30
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taRightJustify
        TabOrder = 6
        Transparent = True
        Height = 17
        Width = 73
        AnchorX = 549
      end
      object EmbalajeAnchoCtrl: TcxDBCurrencyEdit
        Left = 74
        Top = 27
        CaptionLabel = cxLabel3
        DataBinding.DataField = 'EmbalajeAncho'
        DataBinding.DataSource = LineaValoracionManufacturaDataSource
        Properties.MaxLength = 8
        TabOrder = 1
        Width = 71
      end
      object cxLabel3: TcxLabel
        Left = 75
        Top = 6
        TabStop = False
        Caption = 'Ancho'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
      end
      object cxLabel10: TcxLabel
        Left = 0
        Top = 4
        TabStop = False
        Caption = 'Largo'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
      end
      object EmbalajeLargoCtrl: TcxDBCurrencyEdit
        Left = 0
        Top = 27
        CaptionLabel = cxLabel10
        DataBinding.DataField = 'EmbalajeLargo'
        DataBinding.DataSource = LineaValoracionManufacturaDataSource
        Properties.MaxLength = 8
        TabOrder = 0
        Width = 71
      end
    end
    object IDVCtrl: TcxCheckBox
      Left = 16
      Top = 392
      AutoSize = False
      Caption = 'IDV'
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 17
      Transparent = True
      Height = 21
      Width = 95
    end
    object CorteCtrl: TcxCheckBox
      Left = 16
      Top = 420
      AutoSize = False
      Caption = 'Corte'
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 18
      Transparent = True
      Height = 21
      Width = 95
    end
    object cxLabel20: TcxLabel
      Left = 197
      Top = 444
      TabStop = False
      Caption = 'Precio'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 33
      Transparent = True
    end
    object cxLabel21: TcxLabel
      Left = 121
      Top = 444
      TabStop = False
      Caption = 'Varios'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 34
      Transparent = True
    end
    object PrecioVariosCtrl: TcxDBCurrencyEdit
      Left = 197
      Top = 464
      DataBinding.DataField = 'PrecioParametro5'
      DataBinding.DataSource = LineaValoracionManufacturaDataSource
      Properties.MaxLength = 8
      TabOrder = 20
      Width = 71
    end
    object VariosCtrl: TcxDBCurrencyEdit
      Left = 121
      Top = 464
      DataBinding.DataField = 'CantidadParametro5'
      DataBinding.DataSource = LineaValoracionManufacturaDataSource
      Properties.MaxLength = 8
      TabOrder = 19
      Width = 71
    end
    object SuperficieLargoCtrl: TcxDBCurrencyEdit
      Left = 123
      Top = 32
      CaptionLabel = Label18
      DataBinding.DataField = 'SuperficieLargo'
      DataBinding.DataSource = LineaValoracionManufacturaDataSource
      Properties.MaxLength = 8
      TabOrder = 0
      Width = 71
    end
    object SuperficieAnchoCtrl: TcxDBCurrencyEdit
      Left = 197
      Top = 32
      CaptionLabel = cxLabel1
      DataBinding.DataField = 'SuperficieAncho'
      DataBinding.DataSource = LineaValoracionManufacturaDataSource
      Properties.MaxLength = 8
      TabOrder = 1
      Width = 71
    end
    object ImporteNetoLabel: TcxLabel
      Left = 585
      Top = 467
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TextStyle = [fsBold]
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taRightJustify
      TabOrder = 35
      Transparent = True
      Height = 17
      Width = 87
      AnchorX = 672
    end
    object cxLabel8: TcxLabel
      Left = 410
      Top = 467
      TabStop = False
      Caption = 'Importe neto'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 36
      Transparent = True
    end
    object cxLabel11: TcxLabel
      Left = 425
      Top = 35
      TabStop = False
      Caption = 'Precio'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 37
      Transparent = True
    end
    object PrecioLabel: TcxLabel
      Left = 500
      Top = 35
      TabStop = False
      AutoSize = False
      ParentColor = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Color = clBtnFace
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      Style.TextColor = clNavy
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 38
      Transparent = True
      Height = 19
      Width = 71
      AnchorX = 571
      AnchorY = 45
    end
  end
  object FormManager: TgxFormManager
    FirstDataControl = CantoPulidoCtrl
    ShowQueryOption = False
    OnCreateForm = FormManagerCreateForm
    OnDestroyForm = FormManagerDestroyForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 662
    Top = 130
  end
  object LineaValoracionManufacturaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnCalcFields = LineaValoracionManufacturaTableCalcFields
    TableName = 'LineaValoracionManufactura'
    IndexFieldNames = 'NroRegistroLinea'
    OpenOnMasterActivation = False
    Left = 624
    Top = 130
    object LineaValoracionManufacturaTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object LineaValoracionManufacturaTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object LineaValoracionManufacturaTableNroRegistroLinea: TIntegerField
      FieldName = 'NroRegistroLinea'
    end
    object LineaValoracionManufacturaTableSuperficieLargo: TBCDField
      FieldName = 'SuperficieLargo'
      Precision = 16
    end
    object LineaValoracionManufacturaTableSuperficieAncho: TBCDField
      FieldName = 'SuperficieAncho'
      Precision = 16
    end
    object LineaValoracionManufacturaTableLargo: TBCDField
      FieldName = 'Largo'
      Precision = 16
    end
    object LineaValoracionManufacturaTableCorto: TBCDField
      FieldName = 'Corto'
      Precision = 16
    end
    object LineaValoracionManufacturaTableEmbalajeAncho: TBCDField
      FieldName = 'EmbalajeAncho'
      Precision = 16
    end
    object LineaValoracionManufacturaTableEmbalajeLargo: TBCDField
      FieldName = 'EmbalajeLargo'
      Precision = 16
    end
    object LineaValoracionManufacturaTableMetrosLineales: TBCDField
      FieldName = 'MetrosLineales'
      Precision = 16
    end
    object LineaValoracionManufacturaTableMetrosCuadrados: TBCDField
      FieldName = 'MetrosCuadrados'
      Precision = 16
    end
    object LineaValoracionManufacturaTableCantidadParametro1: TBCDField
      FieldName = 'CantidadParametro1'
      Precision = 16
    end
    object LineaValoracionManufacturaTableCantidadParametro2: TBCDField
      FieldName = 'CantidadParametro2'
      Precision = 16
    end
    object LineaValoracionManufacturaTableCantidadParametro3: TBCDField
      FieldName = 'CantidadParametro3'
      Precision = 16
    end
    object LineaValoracionManufacturaTableCantidadParametro4: TBCDField
      FieldName = 'CantidadParametro4'
      Precision = 16
    end
    object LineaValoracionManufacturaTableCantidadParametro5: TBCDField
      FieldName = 'CantidadParametro5'
      Precision = 16
    end
    object LineaValoracionManufacturaTableCantidadParametro6: TBCDField
      FieldName = 'CantidadParametro6'
      Precision = 16
    end
    object LineaValoracionManufacturaTablePrecioParametro1: TFloatField
      FieldName = 'PrecioParametro1'
    end
    object LineaValoracionManufacturaTablePrecioParametro2: TFloatField
      FieldName = 'PrecioParametro2'
    end
    object LineaValoracionManufacturaTablePrecioParametro3: TFloatField
      FieldName = 'PrecioParametro3'
    end
    object LineaValoracionManufacturaTablePrecioParametro4: TFloatField
      FieldName = 'PrecioParametro4'
    end
    object LineaValoracionManufacturaTablePrecioParametro5: TFloatField
      FieldName = 'PrecioParametro5'
    end
    object LineaValoracionManufacturaTablePrecioParametro6: TFloatField
      FieldName = 'PrecioParametro6'
    end
    object LineaValoracionManufacturaTableSubtotalCantos: TBCDField
      FieldName = 'SubtotalCantos'
      Precision = 16
    end
    object LineaValoracionManufacturaTableSubtotalTaladro: TBCDField
      FieldName = 'SubtotalTaladro'
      Precision = 16
    end
    object LineaValoracionManufacturaTableSubtotalEmbalaje: TBCDField
      FieldName = 'SubtotalEmbalaje'
      Precision = 16
    end
    object LineaValoracionManufacturaTableTotalManufactura: TBCDField
      FieldName = 'TotalManufactura'
      Precision = 16
    end
    object LineaValoracionManufacturaTableIncremento: TBCDField
      FieldName = 'Incremento'
      Precision = 16
    end
    object LineaValoracionManufacturaTablePorcentajeIncremento: TBCDField
      FieldName = 'PorcentajeIncremento'
      Precision = 16
    end
    object LineaValoracionManufacturaTableImporteNeto: TBCDField
      FieldName = 'ImporteNeto'
      Precision = 16
    end
    object LineaValoracionManufacturaTableCampoCalculado: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'CampoCalculado'
      Calculated = True
    end
  end
  object LineaValoracionManufacturaDataSource: TDataSource
    DataSet = LineaValoracionManufacturaTable
    Left = 592
    Top = 130
  end
end
