object MntCcrForm: TMntCcrForm
  Left = 525
  Top = 419
  HelpType = htKeyword
  HelpKeyword = 'a_ccr'
  HelpContext = 202
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderStyle = bsDialog
  Caption = 'Configuraci'#243'n del correo (EMail)'
  ClientHeight = 845
  ClientWidth = 1356
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -20
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  Position = poDefault
  Visible = True
  PixelsPerInch = 144
  TextHeight = 28
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    PanelStyle.Active = True
    PanelStyle.CaptionIndent = 3
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      1356
      93)
    Height = 93
    Width = 1356
    object Label2: TcxLabel
      Left = 21
      Top = 47
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabStop = False
      Caption = 'C'#243'digo de usuario'
      TabOrder = 2
      Transparent = True
    end
    object LabelCtrl6: TcxLabel
      Left = 318
      Top = 47
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Vert = taVCenter
      TabOrder = 3
      Transparent = True
      Height = 31
      Width = 525
      AnchorY = 63
    end
    object LabelCtrl1: TcxLabel
      Left = 21
      Top = 9
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabStop = False
      Caption = 'C'#243'digo de empresa'
      TabOrder = 4
      Transparent = True
    end
    object LabelCtrl5: TcxLabel
      Left = 318
      Top = 9
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Vert = taVCenter
      TabOrder = 5
      Transparent = True
      Height = 32
      Width = 525
      AnchorY = 25
    end
    object UsuarioCtrl: TcxDBTextEdit
      Left = 210
      Top = 45
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DescriptionLabel = LabelCtrl6
      DataBinding.DataField = 'CodigoUsuario'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = UsuarioCtrlPropertiesQueryRequest
      Properties.OnEditRequest = UsuarioCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = UsuarioCtrlPropertiesValidate
      TabOrder = 1
      Width = 38
    end
    object EmpresaCtrl: TcxDBTextEdit
      Left = 210
      Top = 8
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DescriptionLabel = LabelCtrl5
      DataBinding.DataField = 'CodigoEmpresa'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = EmpresaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = EmpresaCtrlPropertiesEditRequest
      Properties.CharCase = ecUpperCase
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = EmpresaCtrlPropertiesValidate
      Style.TransparentBorder = True
      TabOrder = 0
      Width = 53
    end
    object cxImage2: TcxImage
      AlignWithMargins = True
      Left = 1297
      Top = 7
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 9
      Margins.Bottom = 5
      TabStop = False
      Align = alRight
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
        203C672069643D2269636F6E223E0D0A09093C7061746820643D224D32322E34
        2C3448312E36632D302E3333312C302C2D302E362C302E3236392C2D302E362C
        302E367631352E3863302C302E3333312C302E3236392C302E362C302E362C30
        2E366832302E3863302E3333312C302C302E362C2D302E3236392C302E362C2D
        302E3656342E364332332C342E3236392C32322E3733312C342C32322E342C34
        7A222066696C6C3D2223463044454234222F3E0D0A09093C7061746820643D22
        4D31342E33352C31342E3030376C2D302E3234392C302E323332632D302E3633
        362C302E3530372C2D312E3336352C302E3736312C2D322E3039332C302E3736
        31632D302E3733332C302C2D312E3436372C2D302E3235372C2D322E3130362C
        2D302E3737316C2D302E3234332C2D302E3232396C2D382E3537312C362E3731
        63302E3130352C302E3137332C302E3239352C302E3238392C302E3531332C30
        2E3238396832302E3863302E3231362C302C302E3430352C2D302E3131352C30
        2E3531312C2D302E3238364C31342E33352C31342E3030377A222066696C6C3D
        2223463044454234222F3E0D0A09093C7061746820643D224D32322E342C3448
        312E36632D302E3333312C302C2D302E362C302E3236392C2D302E362C302E36
        6C392E3434382C382E37393663302E3934332C302E3735382C322E3136342C30
        2E3736322C332E31312C302E3030384C32332C342E36373856342E364332332C
        342E3236392C32322E3733312C342C32322E342C347A222066696C6C3D222346
        3044454234222F3E0D0A09093C7061746820643D224D312E3038372C32302E37
        31632D302E3035352C2D302E30392C2D302E3038372C2D302E3139362C2D302E
        3038372C2D302E333156342E3837324C392E312C31332E354C312E3038372C32
        302E37317A4D32322E3931312C32302E37313263302E3035362C2D302E303931
        2C302E3038392C2D302E3139382C302E3038392C2D302E33313256342E393436
        6C2D382E3037352C382E3537394C32322E3931312C32302E3731327A22206669
        6C6C3D2223444243394139222F3E0D0A09093C7061746820643D224D32322E34
        2C34682D362E3739386C2D342E3237362C31374832322E3463302E3333312C30
        2C302E362C2D302E3236392C302E362C2D302E3656342E364332332C342E3236
        392C32322E3733312C342C32322E342C347A222066696C6C3D22233233314632
        3022206F7061636974793D22302E3036222F3E0D0A09093C7061746820643D22
        4D32332C342E3637386C2D392E3434322C382E373236632D302E3934362C302E
        3735342C2D322E3136372C302E3735312C2D332E31312C2D302E3030384C312C
        342E3676302E3237324C392E312C31332E356C2D382C372E326C382E3535382C
        2D362E3639396C302E3234332C302E32323963302E3633392C302E3531342C31
        2E3337332C302E3737312C322E3130362C302E37373163302E3732382C302C31
        2E3435372C2D302E3235342C322E3039332C2D302E3736316C302E3234392C2D
        302E3233324C32322E392C32302E376C2D372E3937352C2D372E3137354C3233
        2C342E39343656342E3637387A222066696C6C3D222332333146323022206F70
        61636974793D22302E34222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
      Properties.Center = False
      Properties.FitMode = ifmProportionalStretch
      Properties.ReadOnly = True
      Properties.ShowFocusRect = False
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = True
      StyleFocused.BorderStyle = ebsNone
      StyleHot.BorderStyle = ebsNone
      TabOrder = 6
      Transparent = True
      Height = 79
      Width = 48
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 792
    HelpContext = 202
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    PanelStyle.Active = True
    PanelStyle.CaptionIndent = 3
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      1356
      53)
    Height = 53
    Width = 1356
    object Panel2: TdxPanel
      Left = 479
      Top = 5
      Width = 391
      Height = 45
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Anchors = []
      Frame.Visible = False
      TabOrder = 0
      object OkButton: TgBitBtn
        Left = 2
        Top = 2
        Width = 127
        Height = 42
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = '&Aceptar'
        Enabled = True
        ModalResult = 1
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 0
        GlyphBitmap = gmOk
      end
      object CloseButton: TgBitBtn
        Left = 132
        Top = 2
        Width = 128
        Height = 42
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Cancel = True
        Caption = '&Cerrar'
        Enabled = True
        ModalResult = 2
        OptionsImage.ImageIndex = 7
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 1
        GlyphBitmap = gmClose
      end
      object DeleteButton: TgBitBtn
        Left = 263
        Top = 2
        Width = 127
        Height = 42
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = '&Suprimir'
        Enabled = True
        ModalResult = 3
        OptionsImage.ImageIndex = 5
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 2
        GlyphBitmap = gmDelete
      end
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 8
    Top = 93
    Margins.Left = 8
    Margins.Top = 0
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    PanelStyle.CaptionIndent = 3
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 699
    Width = 1340
    object ScrollBox: TcxScrollBox
      Left = 2
      Top = 2
      Width = 1336
      Height = 695
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      BorderStyle = cxcbsNone
      Color = clDefault
      LookAndFeel.ScrollbarMode = sbmClassic
      ParentColor = False
      TabOrder = 0
      Transparent = True
      object cxGroupBox6: TdxPanel
        AlignWithMargins = True
        Left = 5
        Top = 450
        Width = 1331
        Height = 236
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Frame.Visible = False
        TabOrder = 2
        object UsuarioCorreoCtrl: TcxDBTextEdit
          Left = 195
          Top = 41
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          DataBinding.DataField = 'Usuario'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 0
          Width = 332
        end
        object DireccionCorreoCtrl: TcxDBTextEdit
          Left = 195
          Top = 81
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          DataBinding.DataField = 'Direccion'
          DataBinding.DataSource = DataSource
          TabOrder = 2
          Width = 617
        end
        object Label47: TcxLabel
          Left = 11
          Top = 45
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Usuario de correo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
        end
        object Label48: TcxLabel
          Left = 668
          Top = 45
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Palabra de paso'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 5
          Transparent = True
        end
        object Label7: TcxLabel
          Left = 11
          Top = 87
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Direcci'#243'n de correo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 6
          Transparent = True
        end
        object FirmaCtrl: TcxDBMemo
          Left = 195
          Top = 122
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          DataBinding.DataField = 'Firma'
          DataBinding.DataSource = DataSource
          TabOrder = 7
          Height = 111
          Width = 617
        end
        object CrearFirmaButton: TgBitBtn
          Left = 11
          Top = 158
          Width = 127
          Height = 42
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Crear'
          Enabled = True
          OptionsImage.ImageIndex = 41
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 6
          OptionsImage.Spacing = 8
          TabOrder = 8
          OnClick = CrearFirmaButtonClick
          GlyphBitmap = gmEditBCard
        end
        object cxLabel8: TcxLabel
          Left = 11
          Top = 123
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Firma'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 9
          Transparent = True
        end
        object MensajePruebaButton: TgBitBtn
          Left = 830
          Top = 83
          Width = 276
          Height = 39
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Caption = 'Enviar mensaje de prueba'
          Enabled = True
          OptionsImage.ImageIndex = 51
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 6
          OptionsImage.Spacing = 8
          TabOrder = 3
          OnClick = MensajePruebaButtonClick
          GlyphBitmap = gmMail
        end
        object EMailPasswordCtrl: TgxDBPasswordEdit
          Left = 828
          Top = 41
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          AutoSize = False
          BeepOnEnter = False
          DataBinding.DataField = 'Password'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          Properties.Buttons = <
            item
              Default = True
              ImageIndex = 3
              Glyph.SourceDPI = 96
              Glyph.SourceHeight = 16
              Glyph.SourceWidth = 16
              Glyph.Data = {
                3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
                462D38223F3E0D0A3C7376672077696474683D22313030252220686569676874
                3D2231303025222076696577426F783D22302030203234203234222076657273
                696F6E3D22312E312220786D6C6E733D22687474703A2F2F7777772E77332E6F
                72672F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F
                2F7777772E77332E6F72672F313939392F786C696E6B2220786D6C3A73706163
                653D2270726573657276652220786D6C6E733A73657269663D22687474703A2F
                2F7777772E73657269662E636F6D2F22207374796C653D2266696C6C2D72756C
                653A6576656E6F64643B636C69702D72756C653A6576656E6F64643B7374726F
                6B652D6C696E656A6F696E3A726F756E643B7374726F6B652D6D697465726C69
                6D69743A323B223E262331303B202020203C672069643D2269636F6E223E0D0A
                09093C7061746820643D224D31392E3335342C31372E3233334C31342E313231
                2C31324C31392E3335342C362E3736374331392E3538372C362E353334203139
                2E3538372C362E3135322031392E3335342C352E3931394C31382E3038312C34
                2E3634364331372E3834382C342E3431332031372E3436362C342E3431332031
                372E3233332C342E3634364C31322C392E3837394C362E3736372C342E363436
                43362E3533342C342E34313320362E3135322C342E34313320352E3931392C34
                2E3634364C342E3634362C352E39313943342E3431332C362E31353220342E34
                31332C362E35333420342E3634362C362E3736374C392E3837392C31324C342E
                3634362C31372E32333343342E3431332C31372E34363620342E3431332C3137
                2E38343820342E3634362C31382E3038314C352E3931392C31392E3335344336
                2E3135322C31392E35383720362E3533342C31392E35383720362E3736372C31
                392E3335344C31322C31342E3132314C31372E3233332C31392E333534433137
                2E3436362C31392E3538372031372E3834382C31392E3538372031382E303831
                2C31392E3335344C31392E3335342C31382E3038314331392E3538372C31372E
                3834382031392E3538372C31372E3436362031392E3335342C31372E3233335A
                22207374796C653D2266696C6C3A726762283130312C3130392C313230293B66
                696C6C2D72756C653A6E6F6E7A65726F3B222F3E0D0A093C2F673E0D0A3C2F73
                76673E0D0A}
              Hint = 'Limpiar'
              Kind = bkGlyph
            end
            item
              Enabled = False
              ImageIndex = 4
              Glyph.SourceDPI = 96
              Glyph.SourceHeight = 16
              Glyph.SourceWidth = 16
              Glyph.Data = {
                3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
                462D38223F3E0D0A3C7376672077696474683D22313030252220686569676874
                3D2231303025222076696577426F783D22302030203234203234222076657273
                696F6E3D22312E312220786D6C6E733D22687474703A2F2F7777772E77332E6F
                72672F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F
                2F7777772E77332E6F72672F313939392F786C696E6B2220786D6C3A73706163
                653D2270726573657276652220786D6C6E733A73657269663D22687474703A2F
                2F7777772E73657269662E636F6D2F22207374796C653D2266696C6C2D72756C
                653A6576656E6F64643B636C69702D72756C653A6576656E6F64643B7374726F
                6B652D6C696E656A6F696E3A726F756E643B7374726F6B652D6D697465726C69
                6D69743A323B223E262331303B202020203C672069643D22584D4C49445F325F
                22207472616E73666F726D3D226D617472697828302E3336313731382C302C30
                2C302E3336313731382C2D352E33333432332C2D342E393734393929223E0D0A
                09093C706174682069643D22584D4C49445F375F2220643D224D37312E362C34
                384336382E352C34332E322036342E362C33392E362035392E392C33372E3243
                36312E312C33392E332036312E382C34312E362036312E382C34342E31433631
                2E382C34372E392036302E352C35312E312035372E382C35332E384335352E31
                2C35362E352035312E392C35372E382034382E312C35372E384334342E332C35
                372E382034312E312C35362E352033382E342C35332E384333352E372C35312E
                312033342E342C34372E392033342E342C34342E314333342E342C34312E3620
                33352C33392E332033362E332C33372E324333312E362C33392E362032372E37
                2C34332E322032342E362C34384332372E332C35322E322033302E372C35352E
                352033342E382C35384333382E392C36302E352034332E332C36312E37203438
                2E312C36312E374335322E392C36312E372035372E332C36302E352036312E34
                2C35384336352E352C35352E352036382E392C35322E322037312E362C34385A
                4D34392E352C33362E324334392E352C33352E382034392E342C33352E342034
                392E312C33352E324334382E382C33342E392034382E352C33342E382034382E
                312C33342E384334352E352C33342E382034332E332C33352E372034312E352C
                33372E354333392E372C33392E332033382E382C34312E352033382E382C3434
                2E314333382E382C34342E352033382E392C34342E392033392E322C34352E31
                4333392E352C34352E332033392E382C34352E352034302E322C34352E354334
                302E362C34352E352034312C34352E342034312E322C34352E314334312E352C
                34342E382034312E362C34342E352034312E362C34342E314334312E362C3432
                2E332034322E322C34302E382034332E352C33392E364334342E372C33382E34
                2034362E332C33372E372034382C33372E374334382E342C33372E372034382E
                382C33372E362034392C33372E334334392E332C33372034392E352C33362E36
                2034392E352C33362E325A4D37352E352C34384337352E352C34382E37203735
                2E332C34392E342037342E392C35302E314337322C35342E382036382E322C35
                382E362036332E332C36312E344335382E342C36342E322035332E342C36352E
                372034382C36352E374334322E362C36352E372033372E352C36342E33203332
                2E372C36312E344332372E392C35382E352032342C35342E382032312E312C35
                302E314332302E372C34392E342032302E352C34382E372032302E352C343843
                32302E352C34372E332032302E372C34362E362032312E312C34352E39433234
                2C34312E322032372E382C33372E342033322E372C33342E364333372E362C33
                312E382034322E362C33302E332034382C33302E334335332E342C33302E3320
                35382E352C33312E372036332E332C33342E364336382E312C33372E35203732
                2C34312E322037342E392C34352E394337352E332C34362E362037352E352C34
                372E332037352E352C34385A22207374796C653D2266696C6C3A726762283130
                312C3130392C313230293B66696C6C2D72756C653A6E6F6E7A65726F3B222F3E
                0D0A093C2F673E0D0A3C2F7376673E0D0A}
              Hint = 'Mostrar / ocultar la clave'
              Kind = bkGlyph
            end>
          Properties.EchoMode = eemPassword
          TabOrder = 1
          Height = 39
          Width = 278
        end
        object cxLabel5: TcxLabel
          AlignWithMargins = True
          Left = 6
          Top = 0
          Margins.Left = 6
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Identificaci'#243'n'
          Style.TextStyle = [fsBold]
          TabOrder = 10
          Transparent = True
        end
      end
      object cxGroupBox13: TdxPanel
        AlignWithMargins = True
        Left = 5
        Top = 246
        Width = 1331
        Height = 204
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Frame.Visible = False
        TabOrder = 1
        object ClaveSecretaCtrl: TcxDBTextEdit
          Left = 195
          Top = 122
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          CaptionLabel = cxLabel11
          DataBinding.DataField = 'ClaveSecreta'
          DataBinding.DataSource = DataSource
          Enabled = False
          Properties.Required = True
          TabOrder = 2
          Width = 459
        end
        object cxLabel11: TcxLabel
          Left = 11
          Top = 126
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Clave secreta'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 5
          Transparent = True
        end
        object cxLabel4: TcxLabel
          Left = 11
          Top = 83
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'ID de cliente'
          Enabled = False
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 6
          Transparent = True
        end
        object IDClienteCtrl: TcxDBTextEdit
          Left = 195
          Top = 80
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          CaptionLabel = cxLabel4
          AutoSize = False
          DataBinding.DataField = 'IDCliente'
          DataBinding.DataSource = DataSource
          Enabled = False
          Properties.Required = True
          TabOrder = 1
          Height = 37
          Width = 1074
        end
        object cxLabel13: TcxLabel
          Left = 11
          Top = 45
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Proveedor'
          Enabled = False
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 7
          Transparent = True
        end
        object ProveedorOAuthCtrl: TcxDBIndexedComboBox
          Left = 195
          Top = 38
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          CaptionLabel = cxLabel13
          DataBinding.DataField = 'ProveedorOAuth'
          DataBinding.DataSource = DataSource
          Enabled = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            'Google GMail'
            'Microsoft Office 365')
          TabOrder = 0
          Width = 245
        end
        object cxLabel15: TcxLabel
          Left = 668
          Top = 126
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'ID de inquilino'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 8
          Transparent = True
        end
        object IDInquilinoCtrl: TcxDBTextEdit
          Left = 828
          Top = 122
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          CaptionLabel = cxLabel15
          DataBinding.DataField = 'IDInquilino'
          DataBinding.DataSource = DataSource
          Enabled = False
          TabOrder = 3
          Width = 441
        end
        object cxLabel6: TcxLabel
          Left = 11
          Top = 165
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Usuario'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 9
          Transparent = True
        end
        object UsuarioOAuthCtrl: TcxDBTextEdit
          Left = 195
          Top = 161
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          DataBinding.DataField = 'UsuarioOAuth'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 4
          Width = 332
        end
        object cxLabel3: TcxLabel
          AlignWithMargins = True
          Left = 6
          Top = 0
          Margins.Left = 6
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'OAuth'
          Style.TextStyle = [fsBold]
          TabOrder = 10
          Transparent = True
        end
      end
      object cxGroupBox14: TdxPanel
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 1331
        Height = 241
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Frame.Visible = False
        TabOrder = 0
        object cxGroupBox5: TdxPanel
          Left = 0
          Top = 0
          Width = 704
          Height = 241
          Margins.Left = 9
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alLeft
          Frame.Visible = False
          TabOrder = 0
          object ServidorPOP3IMAPCtrl: TcxDBTextEdit
            Left = 195
            Top = 72
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            DataBinding.DataField = 'ServidorPOP3IMAP'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            TabOrder = 1
            Width = 380
          end
          object PuertoPOP3IMAPCtrl: TcxDBSpinEdit
            Left = 195
            Top = 113
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            DataBinding.DataField = 'PuertoPOP3IMAP'
            DataBinding.DataSource = DataSource
            Properties.OnEnter = PuertoPOP3IMAPCtrlPropertiesEnter
            Properties.AssignedValues.MinValue = True
            Properties.DisplayFormat = '#'
            Properties.EditFormat = '#'
            Properties.MaxValue = 9999.000000000000000000
            TabOrder = 2
            Width = 98
          end
          object ServidorEntranteLabel: TcxLabel
            Left = 11
            Top = 77
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Servidor'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 5
            Transparent = True
          end
          object Label51: TcxLabel
            Left = 11
            Top = 117
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Puerto'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 6
            Transparent = True
          end
          object cxLabel10: TcxLabel
            Left = 11
            Top = 197
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Seguridad'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 7
            Transparent = True
          end
          object SeguridadPOP3IMAPCtrl: TcxDBIndexedComboBox
            Left = 195
            Top = 192
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            DataBinding.DataField = 'SeguridadPOP3IMAP'
            DataBinding.DataSource = DataSource
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'Ninguna'
              'SSL/TLS'
              'STARTTLS')
            Properties.OnEditValueChanged = SeguridadPOP3IMAPCtrlPropertiesEditValueChanged
            TabOrder = 4
            Width = 179
          end
          object cxLabel16: TcxLabel
            Left = 11
            Top = 36
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Tipo de servidor'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 8
            Transparent = True
          end
          object TipoServidorEntranteCtrl: TcxDBIndexedComboBox
            Left = 195
            Top = 30
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            DataBinding.DataField = 'TipoServidorCorreoEntrante'
            DataBinding.DataSource = DataSource
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'POP3'
              'IMAP')
            Properties.OnValidate = TipoServidorEntranteCtrlPropertiesValidate
            TabOrder = 0
            Width = 119
          end
          object AccesoOAuthPOP3IMAPCtrl: TcxDBCheckBox
            Left = 9
            Top = 155
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            AutoSize = False
            Caption = 'Acceso OAuth'
            DataBinding.DataField = 'AccesoOAuthPOP3IMAP'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.ImmediatePost = True
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = AccesoOAuthPOP3IMAPCtrlPropertiesEditValueChanged
            Style.TextStyle = []
            Style.TransparentBorder = False
            TabOrder = 3
            Transparent = True
            Height = 31
            Width = 212
          end
          object cxLabel1: TcxLabel
            AlignWithMargins = True
            Left = 6
            Top = 0
            Margins.Left = 6
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Correo entrante'
            Style.TextStyle = [fsBold]
            TabOrder = 9
            Transparent = True
          end
        end
        object cxGroupBox4: TdxPanel
          Left = 704
          Top = 0
          Width = 627
          Height = 241
          Margins.Left = 9
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alClient
          Frame.Visible = False
          TabOrder = 1
          object ServidorSMTPCtrl: TcxDBTextEdit
            Left = 186
            Top = 32
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            DataBinding.DataField = 'ServidorSMTP'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            TabOrder = 0
            Width = 380
          end
          object PuertoSMTPCtrl: TcxDBSpinEdit
            Left = 186
            Top = 72
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            DataBinding.DataField = 'PuertoSMTP'
            DataBinding.DataSource = DataSource
            Properties.AssignedValues.MinValue = True
            Properties.DisplayFormat = '#'
            Properties.EditFormat = '#'
            Properties.MaxValue = 9999.000000000000000000
            TabOrder = 1
            Width = 95
          end
          object Label45: TcxLabel
            Left = 11
            Top = 36
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Servidor SMTP'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
          end
          object Label46: TcxLabel
            Left = 11
            Top = 77
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Puerto'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 5
            Transparent = True
          end
          object SeguridadSMTPCtrl: TcxDBIndexedComboBox
            Left = 188
            Top = 149
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            DataBinding.DataField = 'SeguridadSMTP'
            DataBinding.DataSource = DataSource
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'Ninguna'
              'SSL/TLS'
              'STARTTLS')
            Properties.OnEditValueChanged = SeguridadSMTPCtrlPropertiesEditValueChanged
            TabOrder = 2
            Width = 175
          end
          object cxLabel9: TcxLabel
            Left = 12
            Top = 155
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Seguridad'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 6
            Transparent = True
          end
          object AccesoOAuthSMTPCtrl: TcxDBCheckBox
            Left = 11
            Top = 113
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            AutoSize = False
            Caption = 'Acceso OAuth'
            DataBinding.DataField = 'AccesoOAuthSMTP'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.ImmediatePost = True
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = AccesoOAuthSMTPCtrlPropertiesEditValueChanged
            Style.TextStyle = []
            Style.TransparentBorder = False
            TabOrder = 3
            Transparent = True
            Height = 31
            Width = 202
          end
          object cxLabel2: TcxLabel
            AlignWithMargins = True
            Left = 6
            Top = 0
            Margins.Left = 6
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Correo saliente'
            Style.TextStyle = [fsBold]
            TabOrder = 7
            Transparent = True
          end
        end
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = ConfiguracionCorreoTable
    FirstKeyControl = EmpresaCtrl
    FirstDataControl = TipoServidorEntranteCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnCopyCurrentRecord = FormManagerCopyCurrentRecord
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 776
    Top = 3
  end
  object ConfiguracionCorreoTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    OnNewRecord = ConfiguracionCorreoTableNewRecord
    TableName = 'ConfiguracionCorreo'
    IndexFieldNames = 'CodigoEmpresa;CodigoUsuario'
    AutoIncFieldName = 'Codigo'
    Left = 744
    Top = 3
  end
  object DataSource: TDataSource
    DataSet = ConfiguracionCorreoTable
    Left = 710
    Top = 3
  end
  object ConfiguracionCorreoAuxTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'ConfiguracionCorreo'
    IndexFieldNames = 'CodigoEmpresa;CodigoUsuario'
    AutoIncFieldName = 'Codigo'
    Left = 744
    Top = 35
  end
end
