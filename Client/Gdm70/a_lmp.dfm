object MntLmpForm: TMntLmpForm
  Left = 471
  Top = 250
  HelpType = htKeyword
  HelpKeyword = 'a_lmp'
  BorderStyle = bsDialog
  Caption = 'Listas de materiales y procesos'
  ClientHeight = 568
  ClientWidth = 764
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    Style.TransparentBorder = True
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      764
      147)
    Height = 147
    Width = 764
    object KeyContainer: TcxGroupBox
      AlignWithMargins = True
      Left = 7
      Top = 2
      Margins.Left = 6
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Anchors = [akLeft, akTop, akRight]
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 0
      Height = 143
      Width = 750
      object Panel1: TcxGroupBox
        Left = 0
        Top = 0
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        DesignSize = (
          750
          32)
        Height = 32
        Width = 750
        object capCodigoLabel: TcxLabel
          Left = 9
          Top = 7
          TabStop = False
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object CodigoArticuloCtrl: TcxDBTextEdit
          Left = 101
          Top = 4
          DescriptionLabel = DescCodigoLabel
          DataBinding.DataField = 'CodigoArticulo'
          DataBinding.DataSource = RelacionOperacionesDataSource
          Properties.Required = True
          Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
          TabOrder = 1
          Width = 102
        end
        object ConsultaArticulosButton: TgBitBtn
          Left = 210
          Top = 3
          Width = 98
          Height = 27
          Caption = 'A&rt'#237'culos ...'
          Enabled = True
          OptionsImage.ImageIndex = 12
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 4
          OptionsImage.Spacing = 5
          TabOrder = 2
          TabStop = False
          OnClick = ConsultaArticulosButtonClick
          GlyphBitmap = gmFields
        end
        object DescCodigoLabel: TcxLabel
          Left = 325
          Top = 7
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
          Height = 19
          Width = 379
        end
      end
      object Panel2: TcxGroupBox
        Left = 0
        Top = 32
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        DesignSize = (
          750
          27)
        Height = 27
        Width = 750
        object CapClaseALabel: TcxLabel
          Left = 9
          Top = 4
          TabStop = False
          Caption = 'Clase A '
          Enabled = False
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object CodigoClaseACtrl: TcxDBTextEdit
          Tag = 1
          Left = 101
          Top = 0
          CaptionLabel = CapClaseALabel
          DescriptionLabel = DescClaseALabel
          DataBinding.DataField = 'CodigoClaseA'
          DataBinding.DataSource = RelacionOperacionesDataSource
          Enabled = False
          Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object DescClaseALabel: TcxLabel
          Left = 202
          Top = 4
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
          Height = 17
          Width = 330
        end
      end
      object Panel4: TcxGroupBox
        Left = 0
        Top = 59
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 2
        DesignSize = (
          750
          27)
        Height = 27
        Width = 750
        object CapClaseBLabel: TcxLabel
          Left = 9
          Top = 4
          TabStop = False
          Caption = 'Clase B'
          Enabled = False
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object CodigoClaseBCtrl: TcxDBTextEdit
          Tag = 2
          Left = 101
          Top = 0
          CaptionLabel = CapClaseBLabel
          DescriptionLabel = DescClaseBLabel
          DataBinding.DataField = 'CodigoClaseB'
          DataBinding.DataSource = RelacionOperacionesDataSource
          Enabled = False
          Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object DescClaseBLabel: TcxLabel
          Left = 202
          Top = 4
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
          Height = 18
          Width = 330
        end
      end
      object Panel5: TcxGroupBox
        Left = 0
        Top = 86
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 3
        DesignSize = (
          750
          27)
        Height = 27
        Width = 750
        object CapClaseCLabel: TcxLabel
          Left = 9
          Top = 4
          TabStop = False
          Caption = 'Clase C'
          Enabled = False
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object CodigoClaseCCtrl: TcxDBTextEdit
          Tag = 3
          Left = 101
          Top = 0
          CaptionLabel = CapClaseCLabel
          DescriptionLabel = DescCalseCLabel
          DataBinding.DataField = 'CodigoClaseC'
          DataBinding.DataSource = RelacionOperacionesDataSource
          Enabled = False
          Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
          Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
          Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object DescCalseCLabel: TcxLabel
          Left = 202
          Top = 4
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
          Height = 17
          Width = 330
        end
      end
      object Panel6: TcxGroupBox
        Left = 0
        Top = 113
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 4
        Height = 30
        Width = 750
        object Label3: TcxLabel
          Left = 9
          Top = 3
          TabStop = False
          Caption = 'N'#186' proceso'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object NroProcesoCtrl: TcxDBSpinEdit
          Left = 101
          Top = 0
          DataBinding.DataField = 'Proceso'
          DataBinding.DataSource = RelacionOperacionesDataSource
          Properties.Required = True
          Properties.DisplayFormat = '#'
          Properties.EditFormat = '#'
          Properties.MaxValue = 999.000000000000000000
          Properties.MinValue = 1.000000000000000000
          Properties.OnValidate = NroProcesoCtrlPropertiesValidate
          TabOrder = 1
          Width = 62
        end
        object DescProcesoLabel: TcxLabel
          Left = 202
          Top = 3
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
          Height = 17
          Width = 124
        end
      end
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 147
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    ParentShowHint = False
    ShowHint = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 1
    PanelKind = epDataPanel
    Height = 385
    Width = 754
    object topPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        750
        118)
      Height = 118
      Width = 750
      object PlantillaButton: TgBitBtn
        Left = 648
        Top = 86
        Width = 91
        Height = 27
        Hint = 'Crea una lista de materiales a partir de otra'
        Anchors = [akTop, akRight]
        Caption = '&Plantilla ...'
        Enabled = True
        OptionsImage.ImageIndex = 12
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        TabStop = False
        OnClick = PlantillaButtonClick
        GlyphBitmap = gmFields
      end
      object MinusButton: TgBitBtn
        Left = 619
        Top = 86
        Width = 28
        Height = 27
        Hint = 'Suprimir un proceso'
        Anchors = [akTop, akRight]
        Enabled = True
        OptionsImage.ImageIndex = 47
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Spacing = 5
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        TabStop = False
        OnClick = MinusButtonClick
        GlyphBitmap = gmMinus
      end
      object PlusButton: TgBitBtn
        Left = 590
        Top = 86
        Width = 28
        Height = 27
        Hint = 'A'#241'adir o insertar un nuevo proceso'
        Anchors = [akTop, akRight]
        Enabled = True
        OptionsImage.ImageIndex = 46
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Spacing = 5
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        TabStop = False
        OnClick = PlusButtonClick
        GlyphBitmap = gmPlus
      end
      object CodigoOperacionCtrl: TcxDBTextEdit
        Left = 102
        Top = 6
        DescriptionLabel = DescOperacionLabel
        DataBinding.DataField = 'CodigoOperacion'
        DataBinding.DataSource = RelacionOperacionesDataSource
        Properties.Required = True
        Properties.OnQueryRequest = CodigoOperacionCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoOperacionCtrlPropertiesEditRequest
        Properties.OnValuePosted = CodigoOperacionCtrlPropertiesValuePosted
        Properties.OnValidate = CodigoOperacionCtrlPropertiesValidate
        TabOrder = 0
        Width = 46
      end
      object TiempoPreparacionCtrl: TcxDBDurationEdit
        Left = 102
        Top = 33
        CaptionLabel = capPreparacionLabel
        DataBinding.DataField = 'TiempoPreparacion'
        DataBinding.DataSource = RelacionOperacionesDataSource
        TabOrder = 1
        Width = 85
      end
      object TiempoFabricacionCtrl: TcxDBDurationEdit
        Left = 102
        Top = 60
        CaptionLabel = capFabricacionLabel
        DataBinding.DataField = 'TiempoFabricacion'
        DataBinding.DataSource = RelacionOperacionesDataSource
        Properties.Required = True
        TabOrder = 2
        Width = 85
      end
      object UnidadesTiempoCtrl: TcxDBTextEdit
        Left = 102
        Top = 87
        CaptionLabel = capUnidadesTiempoLabel
        DataBinding.DataField = 'UnidadesTiempo'
        DataBinding.DataSource = RelacionOperacionesDataSource
        Properties.Required = True
        TabOrder = 3
        Width = 67
      end
      object Label1: TcxLabel
        Left = 10
        Top = 9
        TabStop = False
        Caption = 'Operaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
      end
      object DescOperacionLabel: TcxLabel
        Left = 203
        Top = 12
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
        Height = 19
        Width = 268
      end
      object capPreparacionLabel: TcxLabel
        Left = 10
        Top = 36
        TabStop = False
        Caption = 'Preparaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
      end
      object capFabricacionLabel: TcxLabel
        Left = 10
        Top = 63
        TabStop = False
        Caption = 'Fabricaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 10
        Transparent = True
      end
      object capUnidadesTiempoLabel: TcxLabel
        Left = 9
        Top = 90
        TabStop = False
        Caption = 'Unid. x tiempo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 11
        Transparent = True
      end
      object DocumentosButton: TgBitBtn
        Left = 590
        Top = 5
        Width = 120
        Height = 27
        Hint = 'Editar lista de documentos asociados'
        Anchors = [akTop, akRight]
        Caption = 'Documentos ...'
        Enabled = True
        OptionsImage.ImageIndex = 32
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        ParentShowHint = False
        ShowHint = True
        TabOrder = 12
        TabStop = False
        OnClick = AñadirDocumentosButtonClick
        GlyphBitmap = gmNewDocument
      end
      object AñadirDocumentosButton: TgBitBtn
        Left = 711
        Top = 5
        Width = 28
        Height = 27
        Hint = 'Ver documentos'
        Anchors = [akTop, akRight]
        Enabled = True
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
          2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
          77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
          22307078222077696474683D223234707822206865696768743D223234707822
          2076696577426F783D223020302032342032342220656E61626C652D6261636B
          67726F756E643D226E6577203020302032342032342220786D6C3A7370616365
          3D227072657365727665223E262331303B20203C672069643D2269636F6E2220
          786D6C3A73706163653D227072657365727665223E262331333B262331303B3C
          7061746820643D224D31392C356C2D322C2D3448362E32632D302E36362C302C
          2D312E322C302E35342C2D312E322C312E3276332E31383963302E3430392C2D
          302E3238312C302E3833332C2D302E3336312C312E3038332C2D302E33383263
          302E3035362C2D302E3030352C302E3131352C2D302E3030372C302E3137362C
          2D302E30303763302E3335322C302C312E3033332C302E3038332C312E36342C
          302E36343263302E3632332C302E3537322C302E3936352C312E3431372C312E
          3031342C322E35313163302E3034342C302E3937392C2D302E3034392C322E30
          30342C2D302E3236392C322E39393163302E3330352C302E3432322C302E3732
          382C302E3838382C312E3236332C312E33393263302E3533322C2D302E313131
          2C312E32332C2D302E3233332C312E38312C2D302E32383163302E3137342C2D
          302E3031342C302E3334392C2D302E3032312C302E3532312C2D302E30323163
          322E3238382C302C332E3233332C312E3137322C332E3335342C322E3236396C
          302E3030332C302E30323863302E3037392C302E3935322C2D302E3333382C31
          2E3734322C2D312E3134332C322E313636632D302E3533382C302E3238342C2D
          312E3131382C302E3333322C2D312E3339362C302E333535632D302E3038382C
          302E3030372C2D302E3138312C302E3031312C2D302E3237372C302E30313163
          2D302E3932312C302C2D322E3330372C2D302E3332312C2D332E3630322C2D31
          2E313935632D302E36312C302E3137352C2D312E35362C302E3436382C2D322E
          3337372C302E3833632D302E3430362C302E3838352C2D312E3031312C312E39
          38362C2D312E382C322E3835345632312E3863302C302E36362C302E35342C31
          2E322C312E322C312E326831352E3663302E36362C302C312E322C2D302E3534
          2C312E322C2D312E3256374C31392C357A222066696C6C3D2223453645394545
          222F3E0D0A3C7061746820643D224D31392E3636332C352E33333263302C302C
          2D322E3039372C342E3239352C2D342E3139322C382E363563302E3036322C30
          2E3137322C302E3130322C302E3334372C302E3132312C302E3532316C302E30
          30332C302E30323863302E3037392C302E3935322C2D302E3333382C312E3734
          322C2D312E3134332C322E313636632D302E3131382C302E3036322C2D302E32
          33372C302E3131322C2D302E3335352C302E3135344331322E3439342C32302E
          3231312C31312E3139362C32332C31312E332C32336831302E3563302E36362C
          302C312E322C2D302E35342C312E322C2D312E3256374C31392E3636332C352E
          3333327A222066696C6C3D222343434430443922206F7061636974793D22302E
          35222F3E0D0A3C7061746820643D224D31372C3176342E3863302C302E36362C
          302E35342C312E322C312E322C312E3268342E384C31372C317A222066696C6C
          3D2223414142324244222F3E0D0A3C7061746820643D224D31352C362E356330
          2C302E3237362C2D302E3232342C302E352C2D302E352C302E3548382E373236
          632D302E3131362C2D302E33382C2D302E3238322C2D302E3731342C2D302E35
          2C2D314831342E354331342E3737362C362C31352C362E3232342C31352C362E
          357A4D382E3637342C313148323063302E3237362C302C302E352C2D302E3232
          342C302E352C2D302E35732D302E3232342C2D302E352C2D302E352C2D302E35
          48382E38343143382E382C31302E3333352C382E3734342C31302E3636392C38
          2E3637342C31317A4D382C313768342E3033632D302E3738342C2D302E31322C
          2D312E3732392C2D302E3432372C2D322E3634352C2D31682D302E363538632D
          302E3336372C302E3131322C2D302E3739322C302E32352C2D312E3231372C30
          2E343039632D302E3030352C302E30332C2D302E3030392C302E30362C2D302E
          3030392C302E30393143372E352C31362E3737362C372E3732342C31372C382C
          31377A4D31342E352C3963302E3237362C302C302E352C2D302E3232342C302E
          352C2D302E35732D302E3232342C2D302E352C2D302E352C2D302E3548382E39
          303463302E3030342C302E30352C302E3030372C302E3130312C302E30312C30
          2E31353263302E3031332C302E3237392C302E3031332C302E3536332C302E30
          30332C302E3834384831342E357A4D382C3568362E3563302E3237362C302C30
          2E352C2D302E3232342C302E352C2D302E35732D302E3232342C2D302E352C2D
          302E352C2D302E354838632D302E3237362C302C2D302E352C302E3232342C2D
          302E352C302E3553372E3732342C352C382C357A4D32302C3136682D342E3736
          632D302E3139322C302E3238342C2D302E3435362C302E3532312C2D302E3738
          382C302E363935632D302E3333312C302E3137342C2D302E3637362C302E3235
          392C2D302E3935382C302E33303548323063302E3237362C302C302E352C2D30
          2E3232342C302E352C2D302E355332302E3237362C31362C32302C31367A4D32
          302C313248392E33363863302E3136352C302E3137332C302E3334352C302E33
          35322C302E35342C302E35333563302E3533322C2D302E3131312C312E32332C
          2D302E3233332C312E38312C2D302E32383163302E3137342C2D302E3031342C
          302E3334392C2D302E3032312C302E3532312C2D302E30323163312E3138322C
          302C322E3030352C302E3331332C322E3534322C302E37363748323063302E32
          37362C302C302E352C2D302E3232342C302E352C2D302E355332302E3237362C
          31322C32302C31327A4D32302C32304838632D302E3237362C302C2D302E352C
          302E3232342C2D302E352C302E3573302E3232342C302E352C302E352C302E35
          68313263302E3237362C302C302E352C2D302E3232342C302E352C2D302E3553
          32302E3237362C32302C32302C32307A4D32302C3134682D342E35323263302E
          3035392C302E3136362C302E3039362C302E3333352C302E3131352C302E3530
          326C302E3030332C302E30323863302E3031332C302E3136322C302E3031312C
          302E3331392C2D302E3030332C302E343748323063302E3237362C302C302E35
          2C2D302E3232342C302E352C2D302E355332302E3237362C31342C32302C3134
          7A4D32302C31384838632D302E3237362C302C2D302E352C302E3232342C2D30
          2E352C302E3573302E3232342C302E352C302E352C302E3568313263302E3237
          362C302C302E352C2D302E3232342C302E352C2D302E355332302E3237362C31
          382C32302C31387A222066696C6C3D222336353644373822206F706163697479
          3D22302E35222F3E0D0A3C7061746820643D224D322E3139342C3230632D302E
          3734342C302C2D312E3234312C2D302E34312C2D312E3239352C2D312E303763
          2D302E3034312C2D302E3439312C302E3232332C2D312E3830322C332E353333
          2C2D332E333963302E3232342C2D302E3531392C302E3933342C2D322E323436
          2C312E3535392C2D342E363437632D302E3138342C2D302E3331372C2D302E38
          38352C2D312E362C2D302E3939352C2D322E3933632D302E3035392C2D302E37
          31332C302E3036392C2D312E3234362C302E3337392C2D312E35383463302E32
          36392C2D302E3239322C302E3631312C2D302E33362C302E3739312C2D302E33
          373543362E3138392C362E3030322C362E32322C362C362E3235392C3663302E
          3230362C302C302E3630362C302E3034392C302E3936342C302E33373863302E
          3432322C302E3338372C302E3635352C312C302E3639322C312E383263302E30
          34362C312E3032372C2D302E3037332C322E31312C2D302E3334362C332E3133
          3463302E3137362C302E32392C302E3636382C312E3036362C322E3034392C32
          2E32393463302E3430382C2D302E3130322C312E3339392C2D302E33312C322E
          3138312C2D302E33373563302E3134362C2D302E3031322C302E3239342C2D30
          2E3031382C302E3433382C2D302E30313863312E3338322C302C322E3236352C
          302E3531362C322E3336312C312E33373963302E3034362C302E3535382C2D30
          2E31362C302E39362C2D302E3631322C312E313938632D302E3335382C302E31
          38392C2D302E3738342C302E3232342C2D312E3031332C302E323433632D302E
          30362C302E3030352C2D302E3132352C302E3030382C2D302E3139342C302E30
          3038632D302E3831392C302C2D322E3139372C2D302E3333382C2D332E343035
          2C2D312E323838632D302E3535312C302E3135312C2D322E3134342C302E3538
          392C2D332E3333362C312E313734632D302E3430392C302E39352C2D312E3832
          322C332E3839322C2D332E3636312C342E30343443322E3331352C31392E3939
          372C322E3235332C32302C322E3139342C32307A4D312E3931372C31382E3835
          3363302E3036352C302E3036332C302E3130332C302E30372C302E3136312C30
          2E30383163302E30312C302E3030322C302E3031392C302E3030342C302E3032
          362C302E30303563302E3136352C2D302E3032372C302E3431312C2D302E3232
          332C302E3637392C2D302E353463302E3334342C2D302E3430362C302E363435
          2C2D302E3837382C302E3836392C2D312E323637632D312E3632372C302E3938
          392C2D312E3732342C312E3634372C2D312E3732342C312E3635346C2D302E30
          30322C302E30313443312E39322C31382E3832362C312E3931382C31382E3834
          332C312E3931372C31382E3835337A4D31302E382C31342E34323663302E3631
          332C302E3239392C312E3231352C302E3437342C312E3634342C302E34373463
          302E3033382C302C302E3037352C2D302E3030312C302E31312C2D302E303034
          63302E3433312C2D302E3033362C302E3431322C2D302E3237322C302E343035
          2C2D302E3335632D302E3030342C2D302E3035322C2D302E3136372C2D302E32
          36342C2D302E3833382C2D302E323634632D302E3130312C302C2D302E32312C
          302E3030352C2D302E3332342C302E3031344331312E3431362C31342E333238
          2C31312E3038342C31342E3337382C31302E382C31342E3432367A4D372E3232
          382C31322E363732632D302E3134322C302E3533372C2D302E33362C312E3237
          332C2D302E3538392C312E38383263302E3336372C2D302E31342C302E393733
          2C2D302E3335392C312E3737332C2D302E36303943382E3036372C31332E3632
          332C372E3631372C31332E3137372C372E3232382C31322E3637327A4D362E30
          38382C372E313132632D302E3132372C302E3331392C2D302E3032322C312E31
          34322C302E3234382C322E30303963302E3135332C2D312E3032312C302E3133
          352C2D312E3830352C2D302E3035332C2D322E303438632D302E3032392C2D30
          2E3032332C2D302E3034392C2D302E3032372C2D302E3037332C2D302E303237
          632D302E3030352C302C2D302E3031312C302C2D302E3031372C302E30303143
          362E3136342C372E3034392C362E3134332C372E3035312C362E3038382C372E
          3131327A222066696C6C3D2223444234343533222F3E0D0A093C2F673E0D0A3C
          2F7376673E0D0A}
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Spacing = 5
        ParentShowHint = False
        ShowHint = True
        TabOrder = 13
        TabStop = False
        OnClick = VerDocumentosButtonClick
      end
    end
    object gGridFooter1: TGridTableViewPanel
      Left = 2
      Top = 349
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Transparent = True
      Grid = Grid
      DesignSize = (
        750
        34)
      Height = 34
      Width = 750
      object FooterPanelCantidad: TGridTableViewPanelLabel
        Left = 625
        Top = 4
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 0
        Transparent = True
        GridColumn = GridViewCantidad
        Height = 25
        Width = 78
        AnchorX = 703
        AnchorY = 17
      end
      object cxLabel4: TGridTableViewPanelLabel
        Left = 562
        Top = 8
        TabStop = False
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Total ...'
        Style.BorderStyle = ebsNone
        Style.Edges = [bLeft, bTop, bRight, bBottom]
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 1
        Transparent = True
        GridColumn = GridViewDescripcion
        Height = 17
        Width = 64
        AnchorY = 17
      end
    end
    object cxGroupBox2: TcxPageControl
      Left = 2
      Top = 120
      Width = 750
      Height = 229
      Align = alClient
      TabOrder = 1
      TabStop = False
      Properties.ActivePage = cxTabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 225
      ClientRectLeft = 4
      ClientRectRight = 746
      ClientRectTop = 28
      object cxTabSheet1: TcxTabSheet
        Caption = 'Componentes'
        ImageIndex = 0
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Grid: TcxGrid
          Left = 0
          Top = 0
          Width = 704
          Height = 197
          Align = alClient
          BorderStyle = cxcbsNone
          TabOrder = 0
          object GridView: TcxGridDBTableView
            Tag = 274729960
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataSource = RelacionMaterialesDataSource
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skSum
                FieldName = 'Cantidad'
                Sorted = True
              end
              item
                Kind = skSum
                FieldName = 'Importe'
              end>
            DataController.Summary.SummaryGroups = <>
            DataController.Summary.OnAfterSummary = GridViewDataControllerSummaryAfterSummary
            OptionsBehavior.PostponedSynchronization = False
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.FocusFirstCellOnNewRecord = True
            OptionsBehavior.FocusCellOnCycle = True
            OptionsBehavior.PullFocusing = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnHidingOnGrouping = False
            OptionsCustomize.ColumnHorzSizing = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Appending = True
            OptionsData.DeletingConfirmation = False
            OptionsSelection.InvertSelect = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.FooterAutoHeight = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            object GridViewCodigoComponente: TcxGridDBColumn
              Caption = 'Componente'
              DataBinding.FieldName = 'CodigoComponente'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Required = True
              Properties.OnQueryRequest = GridViewCodigoComponentePropertiesQueryRequest
              Properties.OnEditRequest = GridViewCodigoComponentePropertiesEditRequest
              Properties.OnValidate = GridViewCodigoComponentePropertiesValidate
            end
            object GridViewClaseAComponente: TcxGridDBColumn
              Tag = 1
              DataBinding.FieldName = 'ClaseAComponente'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.OnQueryRequest = GridViewClaseComponentePropertiesQueryRequest
              Properties.OnEditRequest = GridViewClaseComponentePropertiesEditRequest
              Properties.OnValidate = GridViewClaseAComponentePropertiesValidate
              Width = 45
            end
            object GridViewClaseBComponente: TcxGridDBColumn
              Tag = 2
              DataBinding.FieldName = 'ClaseBComponente'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.OnQueryRequest = GridViewClaseComponentePropertiesQueryRequest
              Properties.OnEditRequest = GridViewClaseComponentePropertiesEditRequest
              Properties.OnValidate = GridViewClaseBComponentePropertiesValidate
              Width = 45
            end
            object GridViewClaseCComponente: TcxGridDBColumn
              Tag = 3
              DataBinding.FieldName = 'ClaseCComponente'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.OnQueryRequest = GridViewClaseComponentePropertiesQueryRequest
              Properties.OnEditRequest = GridViewClaseComponentePropertiesEditRequest
              Properties.OnValidate = GridViewClaseCComponentePropertiesValidate
              Width = 45
            end
            object GridViewDescripcion: TcxGridDBColumn
              Caption = 'Descripci'#243'n'
              DataBinding.FieldName = 'Descripcion'
              Options.Editing = False
              Options.Focusing = False
              Width = 350
            end
            object GridViewCantidad: TcxGridDBColumn
              DataBinding.FieldName = 'Cantidad'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Width = 80
            end
          end
          object GridLevel: TcxGridLevel
            GridView = GridView
          end
        end
        object TableViewManager: TGridTableViewController
          Left = 704
          Top = 0
          Align = alRight
          Enabled = False
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 1
          TableView = GridView
          ShiftRecords = True
          UseGridFilterBox = False
          Height = 197
          Width = 38
        end
      end
      object cxTabSheet2: TcxTabSheet
        Caption = 'Observaciones'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        inline TAnnotationFrame1: TAnnotationFrame
          Left = 0
          Top = 0
          Width = 742
          Height = 197
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          ExplicitWidth = 742
          ExplicitHeight = 197
          inherited AnnotationPanel: TcxGroupBox
            ExplicitWidth = 750
            ExplicitHeight = 169
            Height = 165
            Width = 742
            inherited AnnotationRichEdit: TcxDBRichEdit
              DataBinding.DataField = 'Anotacion'
              DataBinding.DataSource = RelacionOperacionesDataSource
              ExplicitWidth = 746
              ExplicitHeight = 124
              Height = 120
              Width = 738
            end
            inherited Ruler: TfrxRuler
              Width = 738
              ExplicitWidth = 738
            end
          end
          inherited ButtonsBar: TcxGroupBox
            ExplicitWidth = 750
            Width = 742
            inherited FontNameComboBox: TcxFontNameComboBox
              ExplicitHeight = 28
            end
            inherited FontSizeComboBox: TcxComboBox
              ExplicitHeight = 28
            end
          end
        end
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 532
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      764
      36)
    Height = 36
    Width = 764
    object cxGroupBox1: TcxGroupBox
      Left = 254
      Top = 4
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
    Dataset = RelacionOperacionesTable
    FirstKeyControl = CodigoArticuloCtrl
    FirstDataControl = CodigoOperacionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnNoteRequest = FormManagerNoteRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 668
    Top = 10
  end
  object RelacionOperacionesTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterEdit = RelacionOperacionesTableAfterEdit
    BeforePost = RelacionOperacionesTableBeforePost
    BeforeDelete = RelacionOperacionesTableBeforeDelete
    TableName = 'RelacionOperaciones'
    IndexFieldNames = 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso'
    AutoIncFieldName = 'Proceso'
    OnSetKey = RelacionOperacionesTableSetKey
    OnGetRecord = RelacionOperacionesTableGetRecord
    OnCloseRecord = RelacionOperacionesTableCloseRecord
    OnUpdateState = RelacionOperacionesTableUpdateState
    Left = 640
    Top = 13
  end
  object RelacionOperacionesDataSource: TDataSource
    DataSet = RelacionOperacionesTable
    Left = 608
    Top = 10
  end
  object RelacionMaterialesDataSource: TDataSource
    DataSet = RelacionMaterialesTable
    Enabled = False
    Left = 544
    Top = 10
  end
  object RelacionMaterialesTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    BeforePost = RelacionMaterialesTableBeforePost
    OnCalcFields = RelacionMaterialesTableCalcFields
    OnFilterRecord = RelacionMaterialesTableFilterRecord
    OnNewRecord = RelacionMaterialesTableNewRecord
    TableName = 'RelacionMateriales'
    IndexFieldNames = 
      'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso;Nr' +
      'oLinea'
    MasterFields = 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso'
    MasterSource = RelacionOperacionesDataSource
    AutoIncFieldName = 'NroLinea'
    MasterRelation = mrBalanced
    Left = 578
    Top = 10
    object RelacionMaterialesTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object RelacionMaterialesTableCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object RelacionMaterialesTableCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object RelacionMaterialesTableCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object RelacionMaterialesTableDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 60
      Calculated = True
    end
    object RelacionMaterialesTableProceso: TSmallintField
      FieldName = 'Proceso'
    end
    object RelacionMaterialesTableNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object RelacionMaterialesTableCodigoComponente: TWideStringField
      FieldName = 'CodigoComponente'
    end
    object RelacionMaterialesTableClaseAComponente: TWideStringField
      FieldName = 'ClaseAComponente'
      Size = 3
    end
    object RelacionMaterialesTableClaseBComponente: TWideStringField
      FieldName = 'ClaseBComponente'
      Size = 3
    end
    object RelacionMaterialesTableClaseCComponente: TWideStringField
      FieldName = 'ClaseCComponente'
      Size = 3
    end
    object RelacionMaterialesTableCantidad: TFloatField
      FieldName = 'Cantidad'
    end
  end
  object ArticuloTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 642
    Top = 40
  end
  object ArticuloDataSource: TDataSource
    DataSet = ArticuloTable
    Left = 608
    Top = 40
  end
  object RelacionQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    RequestLive = True
    Left = 512
    Top = 39
  end
  object OperacionTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Operacion'
    IndexFieldNames = 'Codigo'
    Left = 544
    Top = 39
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'PopupMenu')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 415
    Top = 45
    PixelsPerInch = 96
    object ListadoExplosionItem: TdxBarButton
      Caption = 'Relaci'#243'n de materiales y procesos (&explosi'#243'n)'
      Category = 1
      Visible = ivAlways
      OnClick = ListadoExplosionItemClick
    end
    object ListadoImplosionItem: TdxBarButton
      Caption = 'Relaciones de materiales que incluyen un componente (&implosi'#243'n)'
      Category = 1
      Visible = ivAlways
      OnClick = ListadoImplosionItemClick
    end
  end
  object InformesPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemLinks = <
      item
        Visible = True
        ItemName = 'ListadoExplosionItem'
      end
      item
        Visible = True
        ItemName = 'ListadoImplosionItem'
      end>
    UseOwnFont = True
    Left = 448
    Top = 46
    PixelsPerInch = 96
  end
end
