object MntUsrForm: TMntUsrForm
  Left = 525
  Top = 419
  HelpType = htKeyword
  HelpKeyword = 'a_usr'
  HelpContext = 202
  BorderStyle = bsDialog
  Caption = 'Usuarios'
  ClientHeight = 643
  ClientWidth = 910
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
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
    Height = 36
    Width = 910
    object CodigoCtrl: TcxDBTextEdit
      Left = 146
      Top = 7
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 0
      Width = 25
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 9
      TabStop = False
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 608
    HelpContext = 202
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      910
      35)
    Height = 35
    Width = 910
    object Panel2: TcxGroupBox
      Left = 322
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 261
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
    Top = 36
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
    Height = 572
    Width = 900
    object PageControl: TcxPageControl
      Left = 2
      Top = 36
      Width = 896
      Height = 534
      Align = alClient
      Focusable = False
      TabOrder = 1
      Properties.ActivePage = cxTabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 530
      ClientRectLeft = 4
      ClientRectRight = 892
      ClientRectTop = 28
      object cxTabSheet1: TcxTabSheet
        Caption = 'Acce&so'
        ImageIndex = 0
        object cxScrollBox1: TcxScrollBox
          Left = 0
          Top = 0
          Width = 888
          Height = 502
          Align = alClient
          BorderStyle = cxcbsNone
          LookAndFeel.NativeStyle = False
          LookAndFeel.ScrollbarMode = sbmClassic
          TabOrder = 0
          Transparent = True
          object cxGroupBox3: TcxGroupBox
            AlignWithMargins = True
            Left = 6
            Top = 70
            Margins.Left = 6
            Align = alTop
            Caption = 'Ventana de inicio'
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TextStyle = [fsBold]
            TabOrder = 1
            Transparent = True
            Height = 193
            Width = 879
            object VentanaInicioCtrl: TcxDBRadioGroup
              Left = 8
              Top = 26
              Alignment = alCenterCenter
              DataBinding.DataField = 'VentanaInicio'
              DataBinding.DataSource = DataSource
              Properties.Columns = 2
              Properties.DefaultValue = 0
              Properties.Items = <
                item
                  Caption = 'Ninguna'
                  Value = 0
                end
                item
                  Caption = 'Asientos'
                  Value = 1
                end
                item
                  Caption = 'Facturas emitidas'
                  Value = 2
                end
                item
                  Caption = 'Facturas recibidas'
                  Value = 3
                end
                item
                  Caption = 'Efectos a cobrar'
                  Value = 4
                end
                item
                  Caption = 'Efectos a pagar'
                  Value = 5
                end
                item
                  Caption = 'Remesas'
                  Value = 6
                end
                item
                  Caption = 'Pedidos de compra'
                  Value = 7
                end
                item
                  Caption = 'Albaranes de compra'
                  Value = 8
                end
                item
                  Caption = 'Presupuestos'
                  Value = 9
                end
                item
                  Caption = 'Pedidos de venta'
                  Value = 10
                end
                item
                  Caption = 'Albaranes de venta'
                  Value = 11
                end
                item
                  Caption = 'Movimientos de almac'#233'n'
                  Value = 12
                end
                item
                  Caption = 'T'#237'ckets de venta'
                  Value = 13
                end>
              Style.BorderStyle = ebsNone
              TabOrder = 0
              Transparent = True
              Height = 159
              Width = 387
            end
            object cxImage1: TcxImage
              Left = 845
              Top = 2
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
                202623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B3C672069643D226D61696E2220786D
                6C3A73706163653D227072657365727665223E202020202623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B3C636C697050617468
                2069643D22636C69705F6D61736B2220786D6C3A73706163653D227072657365
                727665223E2020202020202623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B3C70617468
                20643D224D31342E323137352C32332E333633384C31362E303936342C31392E
                35682D302E33313832632D302E343332352C302C2D302E383231352C2D302E32
                3436362C2D312E303135312C2D302E36333332632D302E313931352C2D302E33
                3832352C2D302E313533382C2D302E383338362C302E303937382C2D312E3138
                33346C322E393833392C2D342E3135313763302E303033382C2D302E30303533
                2C302E303037372C2D302E3030372C302E303131362C2D302E3031323263302E
                3234372C2D302E333239392C302E363430332C2D302E353139352C312E303532
                322C2D302E3531393568342E3930333363302E303633392C302C302E31323637
                2C302E303035362C302E313838312C302E30313536563048307632346831342E
                313039374331342E303833382C32332E373836332C31342E313137392C32332E
                353636362C31342E323137352C32332E333633387A222F3E0D0A09093C2F636C
                6970506174683E0D0A3C672069643D2269636F6E2220636C69702D706174683D
                2275726C2823636C69705F6D61736B292220786D6C3A73706163653D22707265
                7365727665223E2020202020202623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B3C6720
                69643D227472616E73666F726D65645F69636F6E22207472616E73666F726D3D
                227472616E736C617465282D31202D31292220786D6C3A73706163653D227072
                657365727665223E262331333B262331303B3C7061746820643D224D32332C36
                56332E3263302C2D302E36362C2D302E35342C2D312E322C2D312E322C2D312E
                3248322E32632D302E36362C302C2D312E322C302E35342C2D312E322C312E32
                76322E384832337A222066696C6C3D2223344238394443222F3E0D0A3C706174
                6820643D224D312C367631342E3863302C302E36362C302E35342C312E322C31
                2E322C312E326831392E3663302E36362C302C312E322C2D302E35342C312E32
                2C2D312E325636222066696C6C3D2223453645394545222F3E0D0A3C70617468
                20643D224D32312E382C32682D332E373733386C2D352E373337372C32304832
                312E3863302E36362C302C312E322C2D302E35342C312E322C2D312E3256332E
                324332332C322E35342C32322E34362C322C32312E382C327A222066696C6C3D
                222332333146323022206F7061636974793D22302E3036222F3E0D0A0909093C
                2F673E0D0A09093C2F673E0D0A3C672069643D226F7665726C61792220786D6C
                3A73706163653D227072657365727665223E262331333B262331303B3C706174
                6820643D224D32302E363937372C31372E3568322E3335373663302E31313436
                2C302C302E3136362C302E313433372C302E303737342C302E323136346C2D37
                2E383032362C362E32363533632D302E3131372C302E303935392C2D302E3238
                322C2D302E303335382C2D302E323134332C2D302E313731324C31372E363933
                332C31382E35682D312E39313531632D302E313131342C302C2D302E3137352C
                2D302E313237312C2D302E313038332C2D302E323136336C322E393836392C2D
                342E3135373763302E303539342C2D302E303739342C302E313532372C2D302E
                313236312C302E323531382C2D302E3132363168342E3930333463302E313136
                352C302C302E313732382C302E313432372C302E303837362C302E323232334C
                32302E363937372C31372E357A222066696C6C2D72756C653D226576656E6F64
                64222066696C6C3D2223464643453535222F3E0D0A3C7061746820643D224D32
                332E3831322C3134682D312E393834356C2D362E363538332C392E3938343463
                302E303436362C302E303238382C302E313038322C302E303239372C302E3136
                312C2D302E303133366C372E383032362C2D362E3235393963302E303838362C
                2D302E303732372C302E303337322C2D302E323130392C2D302E303737342C2D
                302E32313039682D322E333537366C332E323031382C2D332E32373737433233
                2E393834372C31342E313432372C32332E393238352C31342C32332E3831322C
                31347A222066696C6C2D72756C653D226576656E6F6464222066696C6C3D2223
                46364242343322206F7061636974793D22302E38222F3E0D0A09093C2F673E0D
                0A093C2F673E0D0A3C2F7376673E0D0A}
              Properties.Center = False
              Properties.GraphicClassName = 'TdxPNGImage'
              Properties.GraphicTransparency = gtTransparent
              Properties.ShowFocusRect = False
              Style.BorderStyle = ebsNone
              Style.HotTrack = False
              TabOrder = 1
              Transparent = True
              Height = 189
              Width = 32
            end
          end
          object cxGroupBox4: TcxGroupBox
            AlignWithMargins = True
            Left = 3
            Top = 3
            Align = alTop
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 0
            Transparent = True
            DesignSize = (
              882
              61)
            Height = 61
            Width = 882
            object CodigoEmpresaCtrl: TcxDBTextEdit
              Left = 132
              Top = 32
              CaptionLabel = Label2
              DescriptionLabel = DescEmpresaLabel
              DataBinding.DataField = 'CodigoEmpresa'
              DataBinding.DataSource = DataSource
              Properties.OnQueryRequest = CodigoEmpresaCtrlPropertiesQueryRequest
              Properties.OnEditRequest = CodigoEmpresaCtrlPropertiesEditRequest
              Properties.TextEditPad = tpLeftZero
              Properties.OnValidate = CodigoEmpresaCtrlPropertiesValidate
              TabOrder = 1
              Width = 32
            end
            object Label6: TcxLabel
              Left = 8
              Top = 9
              TabStop = False
              Caption = 'Palabra de paso'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 2
              Transparent = True
            end
            object Label2: TcxLabel
              Left = 8
              Top = 36
              TabStop = False
              Caption = 'Empresa'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 3
              Transparent = True
            end
            object DescEmpresaLabel: TcxLabel
              Left = 183
              Top = 36
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 4
              Transparent = True
              Height = 19
              Width = 789
            end
            object cxLabel2: TcxLabel
              Left = 285
              Top = 9
              TabStop = False
              Caption = 'M'#225'ximo 10 caracteres.'
              Style.TextColor = clGray
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 5
              Transparent = True
            end
            object UserPasswordCtrl: TgxDBPasswordEdit
              Left = 132
              Top = 4
              AutoSize = False
              DataBinding.DataField = 'UserPassword'
              DataBinding.DataSource = MemDataSource
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
              Properties.Images = ImageList
              TabOrder = 0
              Height = 26
              Width = 142
            end
          end
        end
      end
      object cxTabSheet2: TcxTabSheet
        Caption = 'Personalizaci'#243'n'
        ImageIndex = 2
        object cxScrollBox3: TcxScrollBox
          Left = 0
          Top = 0
          Width = 888
          Height = 502
          Align = alClient
          BorderStyle = cxcbsNone
          LookAndFeel.NativeStyle = False
          LookAndFeel.ScrollbarMode = sbmClassic
          TabOrder = 0
          Transparent = True
          object cxGroupBox2: TcxGroupBox
            AlignWithMargins = True
            Left = 6
            Top = 3
            Margins.Left = 6
            Align = alTop
            Caption = 'Apariencia'
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TextStyle = [fsBold]
            TabOrder = 0
            Transparent = True
            Height = 176
            Width = 879
            object Image5: TcxImage
              Left = 845
              Top = 2
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
                202623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B3C672069643D2269636F6E2220786D
                6C3A73706163653D227072657365727665223E262331333B262331303B3C6369
                72636C652063783D223132222063793D22362E352220723D22352E3522206669
                6C6C3D2223454435353634222F3E0D0A3C636972636C652063783D2231352E39
                222063793D22382E322220723D22352E35222066696C6C3D2223464236453532
                222F3E0D0A3C636972636C652063783D2231372E35222063793D223132222072
                3D22352E35222066696C6C3D2223464643453535222F3E0D0A3C636972636C65
                2063783D2231352E38222063793D2231352E382220723D22352E35222066696C
                6C3D2223413044343638222F3E0D0A3C636972636C652063783D223132222063
                793D2231372E352220723D22352E35222066696C6C3D2223343843464145222F
                3E0D0A3C7061746820643D224D31322E303735362C31312E393938314331322E
                303530332C31312E393938342C31322E303235342C31322C31322C3132632D31
                2E353132312C302C2D322E383831342C2D302E363130352C2D332E383735362C
                2D312E3539383143352E313231382C31302E343432362C322E372C31322E3838
                37382C322E372C31352E3963302C332E303337362C322E343632342C352E352C
                352E352C352E3573352E352C2D322E343632342C352E352C2D352E354331332E
                372C31342E333734352C31332E303738372C31322E393934342C31322E303735
                362C31312E393938317A222066696C6C3D2223344643304538222F3E0D0A3C70
                61746820643D224D362E352C362E35632D332E303337362C302C2D352E352C32
                2E343632342C2D352E352C352E3573322E343632342C352E352C352E352C352E
                3573352E352C2D322E343632342C352E352C2D352E3543382E393632342C3132
                2C362E352C392E353337362C362E352C362E357A222066696C6C3D2223354439
                434543222F3E0D0A3C7061746820643D224D362E352C362E3563302C2D312E35
                3234322C302E363230322C2D322E393033332C312E363231382C2D332E383939
                3443382E313134352C322E363030352C382E313037332C322E362C382E312C32
                2E36632D332E303337362C302C2D352E352C322E343632342C2D352E352C352E
                3573322E343632342C352E352C352E352C352E3563312E343939372C302C322E
                3835382C2D302E363031332C332E383530322C2D312E35373436632D302E3030
                38362C2D302E303038392C2D302E303136372C2D302E303138332C2D302E3032
                35322C2D302E3032373343382E393232312C31312E393537382C362E352C392E
                353132342C362E352C362E357A222066696C6C3D2223414339324544222F3E0D
                0A093C2F673E0D0A3C2F7376673E0D0A}
              Properties.Center = False
              Properties.GraphicClassName = 'TdxSmartImage'
              Properties.GraphicTransparency = gtTransparent
              Properties.ShowFocusRect = False
              Style.BorderStyle = ebsNone
              Style.HotTrack = False
              TabOrder = 0
              Transparent = True
              Height = 86
              Width = 32
            end
            object EstiloPersonalizadoCtrl: TcxDBCheckBox
              Left = 13
              Top = 26
              AutoSize = False
              Caption = 'Estilo'
              DataBinding.DataField = 'EstiloPersonalizado'
              DataBinding.DataSource = DataSource
              Properties.Alignment = taLeftJustify
              Properties.ImmediatePost = True
              Properties.NullStyle = nssUnchecked
              Properties.OnEditValueChanged = DecoracionCtrlPropertiesEditValueChanged
              TabOrder = 1
              Transparent = True
              Height = 25
              Width = 91
            end
            object DecoracionCtrl: TcxDBIndexedComboBox
              Left = 129
              Top = 26
              DataBinding.DataField = 'Decoracion'
              DataBinding.DataSource = DataSource
              Properties.Alignment.Horz = taLeftJustify
              Properties.DropDownListStyle = lsFixedList
              Properties.Items.Strings = (
                'Plano'
                'Estandar'
                'Ultra-Plano')
              TabOrder = 2
              Width = 143
            end
            object UsarPielesCtrl: TcxDBCheckBox
              Left = 13
              Top = 53
              AutoSize = False
              Caption = 'Piel'
              DataBinding.DataField = 'UsarPieles'
              DataBinding.DataSource = DataSource
              Properties.Alignment = taLeftJustify
              Properties.ImmediatePost = True
              Properties.NullStyle = nssUnchecked
              Properties.OnEditValueChanged = UsarPielesCtrlPropertiesEditValueChanged
              TabOrder = 3
              Transparent = True
              Height = 25
              Width = 78
            end
            object PielCtrl: TcxComboBox
              Left = 129
              Top = 53
              Enabled = False
              Properties.Alignment.Horz = taLeftJustify
              Properties.DropDownListStyle = lsFixedList
              Properties.DropDownRows = 12
              Properties.DropDownSizeable = True
              Properties.Sorted = True
              Properties.OnEditValueChanged = PielCtrlPropertiesEditValueChanged
              TabOrder = 4
              Width = 183
            end
            object cxGroupBox1: TcxGroupBox
              AlignWithMargins = True
              Left = 8
              Top = 94
              Margins.Left = 6
              Margins.Top = 6
              Align = alBottom
              Caption = 'Informaci'#243'n'
              PanelStyle.Active = True
              Style.BorderStyle = ebsNone
              Style.TextColor = clGray
              Style.TextStyle = [fsBold]
              TabOrder = 6
              Height = 77
              Width = 866
              object cxLabel1: TcxLabel
                AlignWithMargins = True
                Left = 10
                Top = 20
                Margins.Left = 8
                Margins.Top = 18
                Margins.Bottom = 0
                TabStop = False
                Align = alClient
                Caption = 
                  'El estilo se limita a la apariencia de los controles de la aplic' +
                  'aci'#243'n, mientras que las pieles modifican el aspecto general : bo' +
                  'rdes de las ventanas, colores de los objetos, etc.. '
                Style.TextColor = cl3DDkShadow
                Properties.WordWrap = True
                TabOrder = 0
                Transparent = True
                Width = 851
              end
            end
            object cxLabel4: TcxLabel
              Left = 327
              Top = 56
              TabStop = False
              Caption = 'Paleta'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 7
              Transparent = True
            end
            object PaletaCtrl: TcxImageComboBox
              Left = 385
              Top = 52
              Properties.DropDownRows = 12
              Properties.Images = PaletteImageList
              Properties.ImmediatePost = True
              Properties.Items = <
                item
                  Description = 'Acuarela'
                  ImageIndex = 0
                  Value = 'Aquarelle'
                end
                item
                  Description = 'Batido de moras'
                  ImageIndex = 2
                  Value = 'Blackberry Shake'
                end
                item
                  Description = 'Blanco y negro'
                  ImageIndex = 4
                  Value = 'BW'
                end
                item
                  Description = 'Fruta'
                  ImageIndex = 8
                  Value = 'Date Fruit'
                end
                item
                  Description = 'Predeterminado'
                  ImageIndex = 9
                  Value = 'Default'
                end
                item
                  Description = 'Lib'#233'lula'
                  ImageIndex = 10
                  Value = 'Dragonfly'
                end
                item
                  Description = 'Gloom Gloom'
                  ImageIndex = 13
                  Value = 'Gloom Gloom'
                end
                item
                  Description = 'Saltamontes'
                  ImageIndex = 14
                  Value = 'Grasshopper'
                end
                item
                  Description = 'Oto'#241'o'
                  ImageIndex = 15
                  Value = 'Leaf Rustle'
                end
                item
                  Description = 'Morena'
                  ImageIndex = 18
                  Value = 'Moray Eel'
                end
                item
                  Description = 'Neon'
                  ImageIndex = 20
                  Value = 'Neon Lollipop'
                end
                item
                  Description = 'Madera noruega'
                  ImageIndex = 21
                  Value = 'Norwegian Wood'
                end
                item
                  Description = 'Oxigeno'
                  ImageIndex = 22
                  Value = 'Oxygen 3'
                end
                item
                  Description = 'Pl'#225'stico espacial'
                  ImageIndex = 23
                  Value = 'Plastic Space'
                end
                item
                  Description = 'Tokyo'
                  ImageIndex = 26
                  Value = 'Tokyo'
                end
                item
                  Description = 'Vac'#237'o'
                  ImageIndex = 27
                  Value = 'Vacuum'
                end>
              TabOrder = 5
              Width = 265
            end
          end
          object cxGroupBox5: TcxGroupBox
            AlignWithMargins = True
            Left = 6
            Top = 185
            Margins.Left = 6
            Align = alTop
            Caption = 'Opciones y comportamiento'
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TextStyle = [fsBold]
            TabOrder = 1
            Transparent = True
            DesignSize = (
              879
              313)
            Height = 313
            Width = 879
            object Image8: TcxImage
              Left = 1102
              Top = 17
              TabStop = False
              Anchors = [akTop, akRight]
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
                202623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B3C672069643D2269636F6E2220786D6C3A7370
                6163653D227072657365727665223E262331333B262331303B3C706174682064
                3D224D32332C3656332E3263302C2D302E36362C2D302E35342C2D312E322C2D
                312E322C2D312E3248322E32632D302E36362C302C2D312E322C302E35342C2D
                312E322C312E3276322E384832337A222066696C6C3D2223344238394443222F
                3E0D0A3C7061746820643D224D312C367631342E3863302C302E36362C302E35
                342C312E322C312E322C312E326831392E3663302E36362C302C312E322C2D30
                2E35342C312E322C2D312E325636222066696C6C3D2223453645394545222F3E
                0D0A3C7061746820643D224D32312E382C32682D332E373733386C2D312E3732
                31332C364832317635682D362E313239356C2D302E323836392C314832317636
                682D382E313337376C2D302E353733382C324832312E3863302E36362C302C31
                2E322C2D302E35342C312E322C2D312E3256332E324332332C322E35342C3232
                2E34362C322C32312E382C327A222066696C6C3D222332333146323022206F70
                61636974793D22302E3036222F3E0D0A3C7061746820643D224D382C32304833
                563868355632307A4D392C3230683132762D3648395632307A4D392C38763568
                3132563848397A222066696C6C3D222338453934394322206F7061636974793D
                22302E37222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
              Properties.FitMode = ifmProportionalStretch
              Properties.ShowFocusRect = False
              Style.BorderStyle = ebsNone
              TabOrder = 19
              Transparent = True
              Height = 32
              Width = 32
            end
            object SimularTabCtrl: TcxDBCheckBox
              Left = 13
              Top = 27
              Caption = '&Simular tabulaci'#243'n con el teclado num'#233'rico.'
              DataBinding.DataField = 'SimularTab'
              DataBinding.DataSource = DataSource
              Properties.Alignment = taLeftJustify
              Properties.FullFocusRect = True
              Properties.NullStyle = nssUnchecked
              TabOrder = 0
              Transparent = True
            end
            object ConsultasIzquierdaCtrl: TcxDBCheckBox
              Left = 13
              Top = 106
              DescriptionLabel = ConsultasIzquierdaCtrl
              Caption = 'Mostrar las ventanas de consulta en el lado izquierdo'
              DataBinding.DataField = 'ConsultasIzquierda'
              DataBinding.DataSource = DataSource
              Properties.NullStyle = nssUnchecked
              TabOrder = 3
              Transparent = True
            end
            object TecladoNumericoCtrl: TcxDBCheckBox
              Left = 13
              Top = 132
              Caption = 'Mostrar bot'#243'n de teclado num'#233'rico (Tablet PC)'
              DataBinding.DataField = 'TecladoNumerico'
              DataBinding.DataSource = DataSource
              Properties.NullStyle = nssUnchecked
              TabOrder = 4
              Transparent = True
            end
            object PlanificadorCtrl: TcxDBCheckBox
              Left = 13
              Top = 243
              Caption = 'Activar el planificador'
              DataBinding.DataField = 'Planificador'
              DataBinding.DataSource = DataSource
              Properties.NullStyle = nssUnchecked
              Properties.OnChange = PlanificadorCtrlPropertiesChange
              TabOrder = 9
              Transparent = True
            end
            object BuzonesCorreoCtrl: TcxDBCheckBox
              Left = 41
              Top = 185
              Caption = 'Mostrar bot'#243'n de acceso a los buzones de correo'
              DataBinding.DataField = 'BuzonesCorreo'
              DataBinding.DataSource = DataSource
              Properties.GlyphCount = 1
              Properties.NullStyle = nssUnchecked
              TabOrder = 6
              Transparent = True
            end
            object FuenteLabel: TcxLabel
              Left = 18
              Top = 215
              TabStop = False
              Caption = 'Fuente de las anotaciones'
              TabOrder = 18
              Transparent = True
            end
            object FuenteAnotacionesCtrl: TcxDBFontNameComboBox
              Left = 178
              Top = 213
              DataBinding.DataField = 'FuenteAnotaciones'
              DataBinding.DataSource = DataSource
              Properties.DropDownSizeable = True
              TabOrder = 7
              Width = 179
            end
            object TamanoFuenteAnotacionesCtrl: TcxDBComboBox
              Left = 359
              Top = 213
              DataBinding.DataField = 'TamanoFuenteAnotaciones'
              DataBinding.DataSource = DataSource
              Properties.Items.Strings = (
                '6'
                '7'
                '8'
                '9'
                '10'
                '11'
                '12'
                '14'
                '16'
                '18'
                '20'
                '22'
                '24'
                '26'
                '28'
                '36'
                '48'
                '72')
              TabOrder = 8
              Width = 63
            end
            object MaximizarVentanasEdicionCtrl: TcxDBCheckBox
              Left = 13
              Top = 79
              Hint = 
                'Cuando est'#225' activo el gestor de ventanas MDI esta opci'#243'n provoca' +
                ' que las ventanas de edici'#243'n se muestren siempre maximizadas, es' +
                ' decir, ocupando todo el espacio disponible del escritorio.'
              Caption = 'Maximizar las ventanas de edici'#243'n'
              DataBinding.DataField = 'MaximizarVentanasEdicion'
              DataBinding.DataSource = DataSource
              Properties.NullStyle = nssUnchecked
              TabOrder = 2
              Transparent = True
            end
            object DesactivarNotificacionesCtrl: TcxDBCheckBox
              Left = 37
              Top = 270
              Hint = 
                'Gestwin incluye eventos de forma autom'#225'tica en la agenda para ay' +
                'udarle a recordar las tareas pendientes. Puede desactivar esta f' +
                'unci'#243'n marcando esta casilla.'
              Caption = 'Desactivar las notificaciones autom'#225'ticas de la aplicaci'#243'n'
              DataBinding.DataField = 'DesactivarNotificaciones'
              DataBinding.DataSource = DataSource
              Enabled = False
              Properties.NullStyle = nssUnchecked
              TabOrder = 10
              Transparent = True
            end
            object ModoTactilCtrl: TcxDBCheckBox
              Left = 456
              Top = 106
              DescriptionLabel = ModoTactilCtrl
              Caption = 'Modo t'#225'ctil'
              DataBinding.DataField = 'ModoTactil'
              DataBinding.DataSource = DataSource
              Properties.NullStyle = nssUnchecked
              Properties.OnChange = ModoTactilCtrlPropertiesChange
              TabOrder = 14
              Transparent = True
            end
            object cxLabel13: TcxLabel
              Left = 473
              Top = 133
              TabStop = False
              Caption = 'Tama'#241'o'
              Enabled = False
              TabOrder = 20
              Transparent = True
            end
            object TamañoModoTactilCtrl: TcxDBSpinEdit
              Left = 661
              Top = 132
              CaptionLabel = cxLabel13
              DataBinding.DataField = 'TamanoModoTactil'
              DataBinding.DataSource = DataSource
              Enabled = False
              Properties.DisplayFormat = '#'
              Properties.EditFormat = '#'
              Properties.MaxValue = 99.000000000000000000
              Properties.MinValue = 24.000000000000000000
              TabOrder = 15
              Width = 64
            end
            object AlertasPermanentesCtrl: TcxDBCheckBox
              Left = 456
              Top = 53
              Caption = 'Alertas permanentes por defecto'
              DataBinding.DataField = 'AlertasPermanentes'
              DataBinding.DataSource = DataSource
              Properties.NullStyle = nssUnchecked
              TabOrder = 12
              Transparent = True
            end
            object cxLabel16: TcxLabel
              Left = 456
              Top = 81
              TabStop = False
              Caption = 'Posici'#243'n de la ventana de alertas'
              TabOrder = 21
              Transparent = True
            end
            object PosicionAlertasCtrl: TcxDBIndexedComboBox
              Left = 661
              Top = 79
              DescriptionLabel = PosicionAlertasCtrl
              DataBinding.DataField = 'PosicionAlertas'
              DataBinding.DataSource = DataSource
              Properties.Alignment.Horz = taLeftJustify
              Properties.DropDownListStyle = lsFixedList
              Properties.Items.Strings = (
                'Arriba derecha'
                'Abajo derecha'
                'Abajo izquierda'
                'Arriba izquierda')
              TabOrder = 13
              Width = 139
            end
            object cxImage2: TcxImage
              Left = 845
              Top = 2
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
                202623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B3C672069643D2269636F6E2220786D6C3A7370
                6163653D227072657365727665223E262331333B262331303B3C706174682064
                3D224D32332C3656332E3263302C2D302E36362C2D302E35342C2D312E322C2D
                312E322C2D312E3248322E32632D302E36362C302C2D312E322C302E35342C2D
                312E322C312E3276322E384832337A222066696C6C3D2223344238394443222F
                3E0D0A3C7061746820643D224D312C367631342E3863302C302E36362C302E35
                342C312E322C312E322C312E326831392E3663302E36362C302C312E322C2D30
                2E35342C312E322C2D312E325636222066696C6C3D2223453645394545222F3E
                0D0A3C7061746820643D224D32312E382C32682D332E373733386C2D312E3732
                31332C364832317635682D362E313239356C2D302E323836392C314832317636
                682D382E313337376C2D302E353733382C324832312E3863302E36362C302C31
                2E322C2D302E35342C312E322C2D312E3256332E324332332C322E35342C3232
                2E34362C322C32312E382C327A222066696C6C3D222332333146323022206F70
                61636974793D22302E3036222F3E0D0A3C7061746820643D224D382C32304833
                563868355632307A4D392C3230683132762D3648395632307A4D392C38763568
                3132563848397A222066696C6C3D222338453934394322206F7061636974793D
                22302E37222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
              Properties.Center = False
              Properties.FitMode = ifmProportionalStretch
              Properties.ShowFocusRect = False
              Style.BorderStyle = ebsNone
              StyleHot.BorderStyle = ebsNone
              TabOrder = 22
              Transparent = True
              Height = 309
              Width = 32
            end
            object GestorVentanasTDICtrl: TcxDBCheckBox
              Left = 13
              Top = 53
              Caption = 'Gestor de ventanas TDI (estilo Web)'
              DataBinding.DataField = 'GestorVentanasTDI'
              DataBinding.DataSource = DataSource
              Properties.NullStyle = nssUnchecked
              Properties.OnChange = GestorVentanasTDICtrlPropertiesChange
              TabOrder = 1
              Transparent = True
            end
            object cxDBCheckBox1: TcxDBCheckBox
              Left = 13
              Top = 158
              Caption = 'No cerrar las ventanas de edici'#243'n con <Esc>'
              DataBinding.DataField = 'NoCerrarVentanasConEsc'
              DataBinding.DataSource = DataSource
              Properties.NullStyle = nssUnchecked
              TabOrder = 5
              Transparent = True
            end
            object cxLabel5: TcxLabel
              Left = 456
              Top = 160
              TabStop = False
              Caption = 'Disposici'#243'n de las ventanas'
              TabOrder = 23
              Transparent = True
            end
            object DisposicionVentanasCtrl: TcxDBImageComboBox
              Left = 661
              Top = 159
              CaptionLabel = cxLabel5
              DataBinding.DataField = 'DisposicionVentanas'
              DataBinding.DataSource = DataSource
              Properties.Alignment.Horz = taLeftJustify
              Properties.Images = ImageList
              Properties.Items = <
                item
                  Description = 'Libre'
                  ImageIndex = 0
                  Value = 0
                end
                item
                  Description = 'Principal a la izquierda'
                  ImageIndex = 1
                  Value = 1
                end
                item
                  Description = 'Principal arriba'
                  ImageIndex = 2
                  Value = 2
                end>
              TabOrder = 16
              Width = 180
            end
            object cxLabel17: TcxLabel
              Left = 456
              Top = 187
              TabStop = False
              Caption = 'Modo de renderizado'
              TabOrder = 24
              Transparent = True
            end
            object ModoRenderizadoCtrl: TcxDBIndexedComboBox
              Left = 661
              Top = 185
              CaptionLabel = cxLabel17
              DataBinding.DataField = 'ModoRenderizado'
              DataBinding.DataSource = DataSource
              Properties.Alignment.Horz = taLeftJustify
              Properties.DropDownListStyle = lsFixedList
              Properties.Items.Strings = (
                'Defecto'
                'GDI'
                'DirectX'
                'GDI+')
              TabOrder = 17
              Width = 82
            end
            object ActivarPanelCtrl: TcxDBCheckBox
              Left = 456
              Top = 27
              Caption = 'Activar el panel de control'
              DataBinding.DataField = 'PanelControl'
              DataBinding.DataSource = DataSource
              Properties.NullStyle = nssUnchecked
              TabOrder = 11
              Transparent = True
            end
            object Image1: TcxImage
              Left = 9
              Top = 184
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
                202623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
                3B2623393B2623393B2623393B2623393B2623393B2623393B3C672069643D22
                69636F6E2220786D6C3A73706163653D227072657365727665223E262331333B
                262331303B3C7061746820643D224D32322E383134332C382E37313433433232
                2E343138352C382E353039332C31322C332C31322C3353312E353935392C382E
                353039332C312E322C382E37313433732D302E30342C312E313739372C302E34
                2C312E3536363863302E323136382C302E313930372C31302E342C382E323934
                392C31302E342C382E323934397331302E313930342C2D382E313034322C3130
                2E343037322C2D382E323934394332322E383437322C392E3839342C32332E32
                3130322C382E393139332C32322E383134332C382E373134337A222066696C6C
                3D2223453645394545222F3E0D0A3C7061746820643D224D32302E382C323048
                332E32632D302E3338352C302C2D302E372C2D302E3331352C2D302E372C2D30
                2E3756312E3763302C2D302E3338352C302E3331352C2D302E372C302E372C2D
                302E376831372E3663302E3338352C302C302E372C302E3331352C302E372C30
                2E377631372E364332312E352C31392E3638352C32312E3138352C32302C3230
                2E382C32307A222066696C6C3D2223464643453535222F3E0D0A3C7061746820
                643D224D32302E392C31682D322E323636374C382E352C32306831322E346330
                2E3338352C302C302E362C2D302E3431352C302E362C2D302E3856312E364332
                312E352C312E3231352C32312E3238352C312C32302E392C317A222066696C6C
                3D222346364242343322206F7061636974793D22302E38222F3E0D0A3C706174
                6820643D224D362C31332E356831324D362C31302E356831324D362C372E3568
                31324D362C342E35683132222066696C6C3D226E6F6E6522207374726F6B653D
                222346364637464222207374726F6B652D77696474683D223122207374726F6B
                652D6C696E656361703D22726F756E6422207374726F6B652D6D697465726C69
                6D69743D2231222F3E0D0A3C7061746820643D224D312C382E3839383663302C
                302C382E37362C352E373332372C392E342C362E3137353163312E30322C2D30
                2E363038332C322E31382C2D302E363038332C332E312C3063302E35362C2D30
                2E333530322C392E352C2D362E313735312C392E352C2D362E313735316C2D38
                2E372C392E353835336C2D342E332C2D302E303932324C312C382E383938367A
                222066696C6C3D222332333146323022206F7061636974793D22302E31222F3E
                0D0A3C7061746820643D224D31332C31362E35682D324C312E313438392C392E
                303443302E393830392C392E32312C312C392E313035382C312C392E32393434
                7631322E3636343763302C302E333036362C302E313534382C302E353833332C
                302E342C302E3737343263302E323132372C302E313635362C32302E39383733
                2C302E313635362C32312E322C3063302E323435322C2D302E313930392C302E
                342C2D302E343637362C302E342C2D302E3737343256392E3239343463302C2D
                302E323238362C302E303133372C2D302E3039362C2D302E313331372C2D302E
                323638324C31332C31362E357A222066696C6C3D2223414142324244222F3E0D
                0A3C7061746820643D224D31302E303537312C31362E303232356C2D382E3836
                31332C362E3530333643312E343130362C32322E383130372C312E373830382C
                32332C322E322C32336831392E3663302E343139322C302C302E373839342C2D
                302E313839332C312E303034312C2D302E343733396C2D382E383631332C2D36
                2E353033364331322E382C31352E313732342C31312E313636372C31352E3136
                30382C31302E303537312C31362E303232357A222066696C6C3D222343434430
                4439222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
              Properties.FitMode = ifmProportionalStretch
              Properties.GraphicClassName = 'TdxSmartImage'
              Properties.ReadOnly = True
              Properties.ShowFocusRect = False
              Style.BorderStyle = ebsNone
              StyleFocused.BorderStyle = ebsNone
              StyleHot.BorderStyle = ebsNone
              TabOrder = 25
              Transparent = True
              Height = 26
              Width = 26
            end
          end
        end
      end
      object TiendaVirtualTabSheet: TcxTabSheet
        Caption = 'Tienda virtual'
        ImageIndex = 3
        object cxGroupBox7: TcxGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Transparent = True
          Height = 108
          Width = 882
          object cxLabel7: TcxLabel
            Left = 27
            Top = 38
            TabStop = False
            Caption = 'Nombre'
            TabOrder = 4
            Transparent = True
          end
          object Tienda_NombreUsuarioCtrl: TcxDBTextEdit
            Left = 131
            Top = 37
            DataBinding.DataField = 'Tienda_NombreUsuario'
            DataBinding.DataSource = DataSource
            TabOrder = 1
            Width = 146
          end
          object Tienda_PasswordCtrl: TcxDBTextEdit
            Left = 131
            Top = 64
            DataBinding.DataField = 'Tienda_Password'
            DataBinding.DataSource = DataSource
            Properties.EchoMode = eemPassword
            Properties.ShowPasswordRevealButton = True
            TabOrder = 2
            Width = 146
          end
          object ComprobarAccesoButton: TgBitBtn
            Left = 280
            Top = 63
            Width = 108
            Height = 28
            Caption = 'Comprobar'
            Enabled = True
            OptionsImage.ImageIndex = 44
            OptionsImage.Images = ApplicationContainer.ButtonImageList
            OptionsImage.Margin = 5
            TabOrder = 3
            TabStop = False
            OnClick = ComprobarAccesoButtonClick
            GlyphBitmap = gmUser
          end
          object cxLabel12: TcxLabel
            Left = 27
            Top = 65
            TabStop = False
            Caption = 'Palabra de paso'
            TabOrder = 5
            Transparent = True
          end
          object Tienda_AdministradorCtrl: TcxDBCheckBox
            Left = 15
            Top = 9
            AutoSize = False
            Caption = 'Administrador'
            DataBinding.DataField = 'Tienda_Administrador'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taLeftJustify
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = Tienda_AdministradorCtrlPropertiesEditValueChanged
            Style.TransparentBorder = False
            TabOrder = 0
            Transparent = True
            Height = 25
            Width = 116
          end
        end
      end
    end
    object Panel1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 34
      Width = 896
      object NombreCtrl: TcxDBTextEdit
        Left = 139
        Top = 5
        DataBinding.DataField = 'Nombre'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        TabOrder = 0
        Width = 255
      end
      object Label1: TcxLabel
        Left = 8
        Top = 8
        TabStop = False
        Caption = 'Nombre'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = UsuarioTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = NombreCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnDeleteButton = FormManagerDeleteButton
    Left = 774
    Top = 3
  end
  object UsuarioTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    BeforeInsert = UsuarioTableCheckUser
    AfterInsert = UsuarioTableAfterInsert
    AfterEdit = UsuarioTableAfterEdit
    BeforePost = UsuarioTableBeforePost
    BeforeDelete = UsuarioTableCheckUser
    OnNewRecord = UsuarioTableNewRecord
    TableName = 'Usuario'
    IndexFieldNames = 'Codigo'
    AutoIncFieldName = 'Codigo'
    OnGetRecord = UsuarioTableGetRecord
    Left = 744
    Top = 3
  end
  object DataSource: TDataSource
    DataSet = UsuarioTable
    Left = 710
    Top = 3
  end
  object Data: TgxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 668
    Top = 3
    object DataUserPassword: TWideStringField
      FieldName = 'UserPassword'
      Size = 10
    end
  end
  object MemDataSource: TDataSource
    DataSet = Data
    Left = 636
    Top = 3
  end
  object ImageList: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    Left = 741
    Top = 179
    Bitmap = {
      494C010105000800040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000160808085E10101082101010830808085F000000180000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000F16161696343434E81818189F0D0D0D740C0C0C7216161698323232E21717
      179D000000160000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000010101232E2E
      2EDA1313138D0000000D0303033D15151594161616980505054C000000070E0E
      0E79313131E10202022F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000112F2F2FDC0909
      0963000000000B0B0B6A3F3F3FFE3F3F3FFF3F3F3FFF3F3F3FFF111111870000
      00000505054A323232E20000001A000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000011111184171717990000
      0000000000103B3B3BF63F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFE0101
      0126000000000F0F0F7C16161696000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000004040445303030DF0000
      00160303033B333333E51E1E1EB03F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF0707
      07580000000B292929CE06060655000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000E0E0E792B2B
      2BD404040445383838F1050505483C3C3CF93F3F3FFF3F3F3FFF3F3F3FFF0606
      0654252525C31111118700000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000909
      0963343434E73C3C3CF8202020B604040446262626C63F3F3FFF3F3F3FFD3232
      32E50B0B0B6C0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000016101010812A2A2ACF3B3B3BF63C3C3CF82C2C2CD51212128A0000
      001D000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000202021A636160A56A6766AA6A67
      66AA6A6766AA6A6766AA6A6766AA6A6766AA646261AA62605FAA62605FAA6260
      5FAA62605FAA62605FAA5E5C5BA60302021E0101011A4E4A46A5534F4BAA534F
      4BAA534F4BAA625F5DAA6A6766AA6A6766AA666462AA646260AA646260AA6462
      60AA646260AA646260AA5F5E5CA60303031E0202021A636160A56A6766AA6A67
      66AA6A6766AA6A6766AA6A6766AA6A6766AA666462AA646260AA646260AA6462
      60AA646260AA646260AA5F5E5CA60303031E0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000019191854EEE9E6FFDBD5D1FFDBD5
      D1FFDBD5D1FFDBD5D1FFDBD5D1FFDBD5D1FFD6D0CCFFD0CAC7FFD0CAC7FFD0CA
      C7FFD0CAC7FFD0CAC7FFDED9D7FF1817175514131254BDB2AAFFBDB2AAFFBDB2
      AAFFBDB2AAFFDED7D2FFEEE9E6FFEEE9E6FFE8E3E0FFE2DDDAFFE2DDDAFFE2DD
      DAFFE2DDDAFFE2DDDAFFE2DDDAFF1818185519191854EEE9E6FFEEE9E6FFEEE9
      E6FFEEE9E6FFEEE9E6FFEEE9E6FFEEE9E6FFE8E3E0FFE2DDDAFFE2DDDAFFE2DD
      DAFFE2DDDAFFE2DDDAFFE2DDDAFF181818550000000000000000000000000000
      0000000000020000000000000000000000000000000000000000000000000000
      0002000000000000000000000000000000001A191955EEE9E6FFB5ADA8FFB5AD
      A8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5AD
      A8FFB5ADA8FFB5ADA8FFDED9D7FF1817175514131255BDB2AAFFBDB2AAFFBDB2
      AAFFBDB2AAFFDED7D2FFEEE9E6FFEEE9E6FFECE7E4FFE2DDDAFFE2DDDAFFE2DD
      DAFFE2DDDAFFE2DDDAFFE2DDDAFF181818551A191955EEE9E6FFEEE9E6FFEEE9
      E6FFEEE9E6FFEEE9E6FFEEE9E6FFEEE9E6FFECE7E4FFE2DDDAFFE2DDDAFFE2DD
      DAFFE2DDDAFFE2DDDAFFE2DDDAFF181818550000000000000000000000000D0D
      0D752C2C2CD50000001800000000000000000000000000000000000000152A2A
      2AD10F0F0F7C0000000000000000000000001A191955EEE9E6FFB5ADA8FFB5AD
      A8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5AD
      A8FFB5ADA8FFB5ADA8FFDED9D7FF1817175514131255BDB2AAFFBDB2AAFFBDB2
      AAFFBDB2AAFFDED7D2FFEEE9E6FFEEE9E6FFEEE9E6FFE3DEDBFFE2DDDAFFE2DD
      DAFFE2DDDAFFE2DDDAFFE2DDDAFF181818551A191955EEE9E6FFEEE9E6FFEEE9
      E6FFEEE9E6FFEEE9E6FFEEE9E6FFE7D7B1FFE7D6B1FFE3DEDBFFE2DDDAFFE2DD
      DAFFE2DDDAFFE2DDDAFFE2DDDAFF181818550000000000000000000000002828
      28CC3F3F3FFF2D2D2DD6000000180000000000000000000000152B2B2BD13F3F
      3FFF2A2A2AD10000000200000000000000001A191955EEE9E6FFB5ADA8FFB5AD
      A8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5AD
      A8FFB5ADA8FFB5ADA8FFDED9D7FF1817175514131255BDB2AAFFBDB2AAFFBDB2
      AAFFBDB2AAFFDED7D2FFECE3D4FFE3C887FFEEE9E6FFE7E2DFFFE2DDDAFFE2DD
      DAFFE2DDDAFFE2DDDAFFE2DDDAFF181818551A191955EEE9E6FFEEE9E6FFEEE9
      E6FFEEE9E6FFEEE9E6FFEEE9E6FFE7D5ADFFE7D5ADFFE7E2DFFFE2DDDAFFE2DD
      DAFFE2DDDAFFE2DDDAFFE2DDDAFF181818550000000000000000000000000000
      0012282828CD3F3F3FFF2D2D2DD600000018000000152B2B2BD13F3F3FFF2B2B
      2BD1000000150000000000000000000000001A191955EEE9E6FFB5ADA8FFB5AD
      A8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5AD
      A8FFB5ADA8FFB5ADA8FFDED9D7FF1817175514131255BDB2AAFFBDB2AAFFBDB2
      AAFFBDB2AAFFDCD2C3FFDDB856FFE4CD94FFE7D5ADFFE5D4AEFFE2DDDAFFE2DD
      DAFFE2DDDAFFE2DDDAFFE2DDDAFF181818551A191955EEE9E6FFEEE9E6FFEEE9
      E6FFEEE9E6FFEEE9E6FFE3C98AFFE4CC92FFE4CC94FFE0C788FFE2DDDAFFE2DD
      DAFFE2DDDAFFE2DDDAFFE2DDDAFF181818550000000000000000000000000000
      000000000012282828CD3F3F3FFF2D2D2DD62B2B2BD13F3F3FFF2B2B2BD10000
      0015000000000000000000000000000000001A191955EEE9E6FFB5ADA8FFB5AD
      A8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5AD
      A8FFB5ADA8FFB5ADA8FFDED9D7FF1817175514131255BDB2AAFFBDB2AAFFBDB2
      AAFFBDB2AAFFDCD2C4FFDEB959FFE4CC91FFE7D5ADFFE7D7B1FFE2DDDAFFE2DD
      DAFFE2DDDAFFE2DDDAFFE2DDDAFF181818551A191955EEE9E6FFEEE9E6FFEEE9
      E6FFEEE9E6FFEEE9E6FFECE3D6FFDEB959FFDDB857FFECE3D6FFE2DDDAFFE2DD
      DAFFE2DDDAFFE2DDDAFFE2DDDAFF181818550000000000000000000000000000
      00000000000000000012282828CD3F3F3FFF3F3F3FFF2B2B2BD1000000150000
      0000000000000000000000000000000000001A191955EEE9E6FFB5ADA8FFB5AD
      A8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5AD
      A8FFB5ADA8FFB5ADA8FFDED9D7FF1817175514131255BDB2AAFFBDB2AAFFBDB2
      AAFFBDB2AAFFDED7D2FFECE4D9FFE4CB8EFFEEE9E6FFEEE9E6FFE5E0DDFFE2DD
      DAFFE2DDDAFFE2DDDAFFE2DDDAFF1818185518171755DED7D2FFDED7D2FFDED7
      D2FFDED7D2FFDED7D2FFDED7D2FFDCD2C5FFDCD1C3FFDED7D2FFD5CFCAFFD3CC
      C7FFD3CCC7FFD3CCC7FFD3CCC7FF171616550000000000000000000000000000
      000000000000000000152B2B2BD13F3F3FFF3F3F3FFF2D2D2DD6000000180000
      0000000000000000000000000000000000001A191955EEE9E6FFB5ADA8FFB5AD
      A8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5ADA8FFB5AD
      A8FFB5ADA8FFB5ADA8FFDED9D7FF1817175514131255BDB2AAFFBDB2AAFFBDB2
      AAFFBDB2AAFFDED7D2FFEEE9E6FFEEE9E6FFEEE9E6FFEEE9E6FFE9E4E1FFE2DD
      DAFFE2DDDAFFE2DDDAFFE2DDDAFF1818185514131255BDB2AAFFBDB2AAFFBDB2
      AAFFBDB2AAFFBDB2AAFFBDB2AAFFBDB2AAFFBDB2AAFFBDB2AAFFB9AEA6FFB4AA
      A2FFB4AAA2FFB4AAA2FFB4AAA2FF131211550000000000000000000000000000
      0000000000152B2B2BD13F3F3FFF2B2B2BD1282828CD3F3F3FFF2D2D2DD60000
      0018000000000000000000000000000000001A191955EEE9E6FFC8C1BDFFC8C1
      BDFFC8C1BDFFC8C1BDFFC8C1BDFFC8C1BDFFC8C1BDFFC8C1BDFFC8C1BCFFC3BC
      B8FFC3BCB8FFC3BCB8FFDED9D7FF1817175514131255BDB2AAFFBDB2AAFFBDB2
      AAFFBDB2AAFFDED7D2FFEEE9E6FFEEE9E6FFEEE9E6FFEEE9E6FFECE7E4FFE2DD
      DAFFE2DDDAFFE2DDDAFFE2DDDAFF1818185514131255BDB2AAFFBDB2AAFFBDB2
      AAFFBDB2AAFFBDB2AAFFBDB2AAFFBDB2AAFFBDB2AAFFBDB2AAFFBBB1A9FFB4AA
      A2FFB4AAA2FFB4AAA2FFB4AAA2FF131211550000000000000000000000000000
      00152B2B2BD13F3F3FFF2B2B2BD10000001500000012282828CD3F3F3FFF2D2D
      2DD6000000180000000000000000000000001A191955EEE9E6FFEEE9E6FFEEE9
      E6FFEEE9E6FFEEE9E6FFEEE9E6FFEEE9E6FFEEE9E6FFEEE9E6FFEEE9E6FFE0DB
      D9FFDED9D7FFDED9D7FFDED9D7FF1817175514131255BDB2AAFFBDB2AAFFBDB2
      AAFFBDB2AAFFDED7D2FFEEE9E6FFEEE9E6FFEEE9E6FFEEE9E6FFEEE9E6FFE3DE
      DBFFE2DDDAFFE2DDDAFFE2DDDAFF1818185514131255BDB2AAFFBDB2AAFFBDB2
      AAFFBDB2AAFFBDB2AAFFBDB2AAFFBDB2AAFFBDB2AAFFBDB2AAFFBDB2AAFFB5AB
      A3FFB4AAA2FFB4AAA2FFB4AAA2FF131211550000000000000000000000002A2A
      2AD03F3F3FFF2B2B2BD100000015000000000000000000000012282828CD3F3F
      3FFF2C2C2CD5000000020000000000000000180F0855DC894AFFDC894AFFDC89
      4AFFDC894AFFDC894AFFDC894AFFDC894AFFDC894AFFDC894AFFDC894AFFD484
      48FFCE8047FFCE8047FFCE8047FF160E0755180F0855DC894AFFDC894AFFDC89
      4AFFDC894AFFDC894AFFDC894AFFDC894AFFDC894AFFDC894AFFDC894AFFD685
      49FFD18348FFD18348FFD18348FF170E0755180F0855DC894AFFDC894AFFDC89
      4AFFDC894AFFDC894AFFDC894AFFDC894AFFDC894AFFDC894AFFDC894AFFD685
      49FFD18348FFD18348FFD18348FF170E07550000000000000000000000000C0C
      0C6E2A2A2AD00000001500000000000000000000000000000000000000122828
      28CC0D0D0D75000000000000000000000000170E0854DC894AFFDC894AFFDC89
      4AFFDC894AFFDC894AFFDC894AFFDC894AFFDC894AFFDC894AFFDC894AFFD886
      49FFCE8047FFCE8047FFCE8047FF160E0755170E0854DC894AFFDC894AFFDC89
      4AFFDC894AFFDC894AFFDC894AFFDC894AFFDC894AFFDC894AFFDC894AFFD987
      49FFD18348FFD18348FFD18348FF170E0755170E0854DC894AFFDC894AFFDC89
      4AFFDC894AFFDC894AFFDC894AFFDC894AFFDC894AFFDC894AFFDC894AFFD987
      49FFD18348FFD18348FFD18348FF170E07550000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000101001858371EA2623C21AA623C
      21AA623C21AA623C21AA623C21AA623C21AA623C21AA623C21AA623C21AA613C
      21AA5B381FAA5B381FAA54341DA30201001B0101001858371EA2623C21AA623C
      21AA623C21AA623C21AA623C21AA623C21AA623C21AA623C21AA623C21AA613C
      21AA5C3920AA5C3920AA55351DA30201001B0101001858371EA2623C21AA623C
      21AA623C21AA623C21AA623C21AA623C21AA623C21AA623C21AA623C21AA613C
      21AA5C3920AA5C3920AA55351DA30201001B0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
    DesignInfo = 11731685
    ImageInfo = <
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
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
          7061746820643D224D32332C3656332E3263302C2D302E36362C2D302E35342C
          2D312E322C2D312E322C2D312E3248322E32632D302E36362C302C2D312E322C
          302E35342C2D312E322C312E3276322E384832337A222066696C6C3D22233442
          38394443222F3E0D0A3C7061746820643D224D312C367631342E3863302C302E
          36362C302E35342C312E322C312E322C312E326831392E3663302E36362C302C
          312E322C2D302E35342C312E322C2D312E325636222066696C6C3D2223453645
          394545222F3E0D0A3C7265637420783D22332220793D2238222077696474683D
          22313822206865696768743D223132222066696C6C3D22233845393439432220
          6F7061636974793D22302E37222F3E0D0A3C7061746820643D224D32312E382C
          32682D332E373733386C2D312E373231332C36483231763132682D382E313337
          376C2D302E353733382C324832312E3863302E36362C302C312E322C2D302E35
          342C312E322C2D312E3256332E324332332C322E35342C32322E34362C322C32
          312E382C327A222066696C6C3D222332333146323022206F7061636974793D22
          302E3038222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
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
          7061746820643D224D32332C3656332E3263302C2D302E36362C2D302E35342C
          2D312E322C2D312E322C2D312E3248322E32632D302E36362C302C2D312E322C
          302E35342C2D312E322C312E3276322E384832337A222066696C6C3D22233442
          38394443222F3E0D0A3C7061746820643D224D312C367631342E3863302C302E
          36362C302E35342C312E322C312E322C312E326831392E3663302E36362C302C
          312E322C2D302E35342C312E322C2D312E325636222066696C6C3D2223453645
          394545222F3E0D0A3C7061746820643D224D32312E382C32682D332E37373338
          6C2D352E373337372C32304832312E3863302E36362C302C312E322C2D302E35
          342C312E322C2D312E3256332E324332332C322E35342C32322E34362C322C32
          312E382C327A222066696C6C3D222332333146323022206F7061636974793D22
          302E3036222F3E0D0A3C7061746820643D224D382C3648317631342E3863302C
          302E36362C302E35342C312E322C312E322C312E3268352E3856367A22206669
          6C6C3D2223414142324244222F3E0D0A3C7061746820643D224D382E35343635
          2C31332E363836356C322E3439312C322E3535343763302E303738342C302E30
          3738342C302E323036382C302E303738342C302E323835322C306C302E343237
          382C2D302E3432373863302E303738342C2D302E303738342C302E303738342C
          2D302E323437372C302C2D302E333236324C31302E333332372C313468342E33
          333363302E313239342C302C302E323334342C2D302E313034392C302E323334
          342C2D302E32333434762D302E3530333163302C2D302E313434342C2D302E31
          3138312C2D302E323632352C2D302E323632352C2D302E32363235682D342E33
          3032366C312E343433382C2D312E3563302E303738342C2D302E303738342C30
          2E303738342C2D302E313838332C302C2D302E323636386C2D302E343237382C
          2D302E34313836632D302E303738342C2D302E303738342C2D302E323036382C
          2D302E303733382C2D302E323835322C302E303034364C382E353436332C3133
          2E3343382E343331332C31332E343132352C382E3432352C31332E353638382C
          382E353436352C31332E363836357A222066696C6C3D2223334241454441222F
          3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
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
          7061746820643D224D32332C3656332E3263302C2D302E36362C2D302E35342C
          2D312E322C2D312E322C2D312E3248322E32632D302E36362C302C2D312E322C
          302E35342C2D312E322C312E3276322E384832337A222066696C6C3D22233442
          38394443222F3E0D0A3C7061746820643D224D312C367631342E3863302C302E
          36362C302E35342C312E322C312E322C312E326831392E3663302E36362C302C
          312E322C2D302E35342C312E322C2D312E325636222066696C6C3D2223453645
          394545222F3E0D0A3C7265637420783D22312220793D2236222077696474683D
          22323222206865696768743D2235222066696C6C3D2223414142324244222F3E
          0D0A3C7061746820643D224D32312E382C32682D332E373733386C2D352E3733
          37372C32304832312E3863302E36362C302C312E322C2D302E35342C312E322C
          2D312E3256332E324332332C322E35342C32322E34362C322C32312E382C327A
          222066696C6C3D222332333146323022206F7061636974793D22302E3036222F
          3E0D0A3C7061746820643D224D31312E383133352C31312E353436356C2D322E
          353534372C322E343931632D302E303738342C302E303738342C2D302E303738
          342C302E323036382C302C302E323835326C302E343237382C302E3432373863
          302E303738342C302E303738342C302E323437372C302E303738342C302E3332
          36322C304C31312E352C31332E3333323776342E33333363302C302E31323934
          2C302E313034392C302E323334342C302E323334342C302E3233343468302E35
          30333163302E313434342C302C302E323632352C2D302E313138312C302E3236
          32352C2D302E32363235762D342E333032366C312E352C312E3434333863302E
          303738342C302E303738342C302E313838332C302E303738342C302E32363638
          2C306C302E343138362C2D302E3432373863302E303738342C2D302E30373834
          2C302E303733382C2D302E323036382C2D302E303034362C2D302E323835324C
          31322E322C31312E353436334331322E303837352C31312E343331332C31312E
          393331332C31312E3432352C31312E383133352C31312E353436357A22206669
          6C6C3D2223334241454441222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          617965725F312220783D223070782220793D22307078222077696474683D2232
          34707822206865696768743D2232347078222076696577426F783D2230203020
          32342032342220656E61626C652D6261636B67726F756E643D226E6577203020
          302032342032342220786D6C6E733D22687474703A2F2F7777772E77332E6F72
          672F323030302F7376672220786D6C3A73706163653D22707265736572766522
          3E20203C672069643D2269636F6E2220786D6C3A73706163653D227072657365
          727665223E202020203C7061746820643D224D31392E333533392C31372E3233
          32364C31342E313231332C31326C352E323332362C2D352E3233323663302E32
          3333332C2D302E323333332C302E323333332C2D302E363135322C302C2D302E
          383438356C2D312E323732382C2D312E32373238632D302E323333332C2D302E
          323333332C2D302E363135322C2D302E323333332C2D302E383438352C304C31
          322C392E383738374C362E373637342C342E36343631632D302E323333332C2D
          302E323333332C2D302E363135322C2D302E323333332C2D302E383438352C30
          4C342E363436312C352E39313839632D302E323333332C302E323333332C2D30
          2E323333332C302E363135322C302C302E383438354C392E383738372C31326C
          2D352E323332362C352E32333236632D302E323333332C302E323333332C2D30
          2E323333332C302E363135322C302C302E383438356C312E323732382C312E32
          37323863302E323333332C302E323333332C302E363135322C302E323333332C
          302E383438352C304C31322C31342E313231336C352E323332362C352E323332
          3663302E323333332C302E323333332C302E363135322C302E323333332C302E
          383438352C306C312E323732382C2D312E323732384331392E353837332C3137
          2E383437382C31392E353837332C31372E343635392C31392E333533392C3137
          2E323332367A22207374796C653D2266696C6C3A207267622836342C2036342C
          203634293B222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
      end
      item
        ImageClass = 'TdxSmartImage'
        Image.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          617965725F312220783D223070782220793D22307078222076696577426F783D
          2230203020323420323422207374796C653D22656E61626C652D6261636B6772
          6F756E643A6E6577203020302039362039363B2220786D6C6E733D2268747470
          3A2F2F7777772E77332E6F72672F323030302F7376672220786D6C3A73706163
          653D227072657365727665223E20203C7374796C6520747970653D2274657874
          2F637373223E2E7374307B66696C6C3A233333333333333B7D3C2F7374796C65
          3E0D0A3C672069643D22584D4C49445F325F22207374796C653D222220747261
          6E73666F726D3D226D617472697828302E3336313731382C20302C20302C2030
          2E3336313731382C202D352E3333343233322C202D342E393734393838292220
          786D6C3A73706163653D227072657365727665223E202020203C706174682069
          643D22584D4C49445F375F2220636C6173733D227374302220643D224D37312E
          362C3438632D332E312D342E382D372D382E342D31312E372D31302E3863312E
          322C322E312C312E392C342E342C312E392C362E3963302C332E382D312E332C
          372D342C392E3720632D322E372C322E372D352E392C342D392E372C34632D33
          2E382C302D372D312E332D392E372D34632D322E372D322E372D342D352E392D
          342D392E3763302D322E352C302E362D342E382C312E392D362E39632D342E37
          2C322E342D382E362C362D31312E372C31302E382063322E372C342E322C362E
          312C372E352C31302E322C313073382E352C332E372C31332E332C332E377339
          2E322D312E322C31332E332D332E375336382E392C35322E322C37312E362C34
          387A204D34392E352C33362E3263302D302E342D302E312D302E382D302E342D
          3120632D302E332D302E332D302E362D302E342D312D302E34632D322E362C30
          2D342E382C302E392D362E362C322E37732D322E372C342D322E372C362E3663
          302C302E342C302E312C302E382C302E342C3173302E362C302E342C312C302E
          3473302E382D302E312C312D302E342063302E332D302E332C302E342D302E36
          2C302E342D3163302D312E382C302E362D332E332C312E392D342E3563312E32
          2D312E322C322E382D312E392C342E352D312E3963302E342C302C302E382D30
          2E312C312D302E344334392E332C33372C34392E352C33362E362C34392E352C
          33362E327A204D37352E352C34382063302C302E372D302E322C312E342D302E
          362C322E31632D322E392C342E372D362E372C382E352D31312E362C31312E33
          732D392E392C342E332D31352E332C342E33732D31302E352D312E342D31352E
          332D342E335332342C35342E382C32312E312C35302E3120632D302E342D302E
          372D302E362D312E342D302E362D322E3173302E322D312E342C302E362D322E
          3163322E392D342E372C362E372D382E352C31312E362D31312E3373392E392D
          342E332C31352E332D342E337331302E352C312E342C31352E332C342E337338
          2E372C362E362C31312E362C31312E33204337352E332C34362E362C37352E35
          2C34372E332C37352E352C34387A22207374796C653D2266696C6C3A20726762
          2836342C2036342C203634293B222F3E0D0A093C2F673E0D0A3C2F7376673E0D
          0A}
      end>
  end
  object PaletteImageList: TcxImageList
    SourceDPI = 96
    Height = 18
    Width = 92
    FormatVersion = 1
    DesignInfo = 9241317
    ImageInfo = <
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E403101603393A3BDA72000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC61050000004D4944415478DAEDD0A115
          C0200C4551C6640B7661976EC30668340D968A8AD8FB4E62BFB8A5EB53899FE9
          CE486D998B859D2E469EB19207050A142850A0408102050A142850A04081F28F
          A2AB1723B45BB28C751B0E0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E4031015332B14822390000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC6105000000494944415478DAEDD0A111
          00200C04419AC362E80C439B1480201A0422766F12FB62CBD05389EFE962A4E6
          8A85952E46DADCC98302050A142850A0408102050A142850A040F9A3E8EA0055
          0B9DB7B249CEF00000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E4031015340F67C05186000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC61050000004D4944415478DAEDD03115
          C0200C4551CC21A346905147D1522190AE303064BDEF24EB1F6E7B75D4F2BF72
          39D29F51B95C98E5FE9188E2418102050A142850A0408102050A142850A0DC51
          B4B500E49C6EE37AAD1B800000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E40310153430D1A67CBB000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC6105000000504944415478DAEDD0B10D
          C0200C004196A0630AC6C878CCC09434C4121D2952B8BD97DD5AD695A14F25B6
          F5273971A4CE9599B8B0D3E5DF389F408102050A142850A0408102050A142850
          A0FCA0E8EA0557A64246BE8461B40000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E4031016051159D4D50E000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC6105000000444944415478DAEDD0A10D
          0020144341666254C29C383CD52010DFDE4B6A2BAE0D3DB56C95CB49AF95875D
          2E27B31C142850A0408102050A142850A040810205CA1F4557071597B4257A93
          FF8D0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E40310160522E604B418000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC6105000000514944415478DAEDD0A115
          C0200C455156C1D531032B76894EC0522C01C1B6A222F6BE93D82F6EB9F5A9C4
          5FAD272F4666ED998B8595EE8C3C237950A0408102050A142850A0408102050A
          1428FF287AB5011A93A21652D2DEBA0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E403101537063531BAE1000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC61050000004C4944415478DAEDD0A111
          00210C45415AA01C2CB55011553073451ED12010B1FB26B15F6C99BA2AF1AD8F
          E4E54762E14F1723757DC98302050A142850A0408102050A142850A04079A3E8
          6803F63A20F74DF3B04A0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E40310153724E051FB05000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC61050000004A4944415478DAEDD0AB0D
          00200C40418620610306663396C1F2B12010B5F7D2DA26BDD4F494F6E6528313
          3FB22FCC70E79F3E8203050A142850A0408102050A142850A04081F247D1D502
          3FEE2B6891840ADF0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E403101605381B664D62000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC61050000004E4944415478DAEDD0A115
          C0200C455116ED146C82ED1008D660205C1B0D02117BDF49EC17B7341D95F895
          2E46DEA7662E16BE743132FB481E142850A0408102050A142850A040810205CA
          1D455B3F41FFBB13AD9DF6C50000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E4031015382BF776FA5B000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC61050000004A4944415478DAEDD02115
          00200C45515A108930B4A119552800D32010B3F79DCD7E71CBD053895FE962A4
          E58A859D2E466A9FC98302050A142850A0408102050A142850A040F9A3E8EA00
          AC21B035C111F0D90000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E403101539093B0D8AFE000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC61050000004F4944415478DAEDD0A111
          00210C45413ABB1A288A06AE232405E198B98B068188DD3789FD62CBABA3123F
          D3C5C8D347E662E14B1723ABB6E4418102050A142850A0408102050A142850A0
          DC51B4F503FC09AB9354EAE4E00000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E40310153923E0B64328000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC6105000000484944415478DAEDD0A915
          00200C4441247DE0A9811AD1F4CA61412062E7BFC4AE98D4F594F697DA82171F
          D90B33DC1919397850A0408102050A142850A0408102050A14287F145D2D1DB0
          A5E80CEC72F00000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E40310153A07F798F43A000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC61050000004B4944415478DAEDD0A115
          00210C44418AC260A905413D3472251ED12010B1F35F62574C59BA2AF1AD8FE4
          E54762E14F1723757EC98302050A142850A0408102050A142850A04079A3E868
          03FF6BFE88E680F6440000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E40310153A2522F8B5DE000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC6105000000524944415478DAEDD0A115
          C0200C45518662093A04BA9330007356C0046D742B2A62EF3B89FDE296A94F25
          FE5A3B7931525BCF5C2CDCE962E43847F2A0408102050A142850A0408102050A
          142850FE51F4EA01955B86951380C0260000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E40310153B0BE7358950000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC61050000004B4944415478DAEDD0A111
          00210C0041AAF8FE70086AA0083AA052403F0211E4DE243693D9D47594F6CE70
          FB482E2D32AFDEF8460D0E142850A0408102050A142850A040810205CA1D45BF
          16C9F43984E77EE2DC0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E40310153B2BDC5BA998000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC6105000000524944415478DAEDD0A115
          C0200C45515643B04825E354B00CEBD42098A18D6E4545EC7D27B15FDC72EA53
          89DFEB4A5E8CDCB3662E165ABA1839FA481E142850A0408102050A142850A040
          810205CA3F8A5E3DE4C120E61600616B0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E4031016000C47A54D92000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC6105000000514944415478DAEDD0A111
          C0201045416A41C522319129903E90D4472E36111167F7CDC7DE0C5B863E9578
          FDBC928B23F56899C5859DEEF9CF5CC9418102050A142850A0408102050A1428
          50A0FCA3E8D50D4C0D6C28573CD2C70000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E40310160616EC9D136E000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC6105000000534944415478DAEDD03115
          80300C45D1EAA9802E38A8093CB5069057039D21330C0C59EF3BC9FA875B863E
          95F8DA8EE4C5C8EA67E662E14E17237B5EC98302050A142850A0408102050A14
          2850A040F947D1AB071762BAA6E68224980000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E403101601153AD5D413000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC61050000004C4944415478DAEDD0B111
          C0200C04417543BB8C3BA1011AA20890533B2050BA3752FAC1C6A35F91BFCAE5
          481BB372B9B0CBBD233D8A07050A142850A0408102050A142850A040817247D1
          A703C134E33473D58A160000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E40310160133E8D851EE000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC61050000004C4944415478DAEDD03115
          00210C444144600047284204129076468ED45050A49DFF92768B29535725BEF5
          91BCFC482CFCE962A4AE2F7950A0408102050A142850A0408102050A14286F14
          1D6D8CB09377A72A58C50000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E4031016062EC49FABF0000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC6105000000514944415478DAEDD0B111
          80201045418AA0724BA00BBA71CC20A4013C530D0C2EDD3777E90FB61CFA54E2
          C75CC97B86FA99B958D8E962A4B62B7950A0408102050A142850A0408102050A
          1428FF287A75031C7CF9045B8B87CB0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E4031016031E9F316F19000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC6105000000514944415478DAEDD0B10D
          80300C45C1AC9A5D32008AC46A518640C908E01A0A0AB7F764B7BFB8D2F5A9C4
          5F7B262F46DA5933170B77BA1859E3481E142850A0408102050A142850A04081
          0205CA3F8A5E3D5DCFBA23962204C80000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E40310160717828112B9000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC61050000004D4944415478DAEDD0A10D
          00211045414AA42B2409455C6524782A603527106BE765D77E3165E85789DFE9
          62E49B2B73B150D3C5486F2D7950A0408102050A142850A0408102050A14286F
          145D1DA50860D5E956CCCC0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E40310160731508C9744000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC61050000004C4944415478DAEDD0A115
          C0200C45511CA3C2141D820518902168B05454C4DE7712FBC52D439F4AFC4A17
          23B5CFCCC5C24E77469E963C2850A0408102050A142850A0408102050A947F14
          5DBD4C53A59494C15A3B0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E4031016080F16759620000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC61050000004A4944415478DAEDD0A115
          00210C4441DAC2A229031AA2C86BE3880681889DFF12BB62CAD25589AF6D242F
          3F120B7FBA18F9FA4C1E142850A0408102050A142850A040810205CA1B45471B
          96B967174C70007A0000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E4031016082E5A1C867E000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC61050000004B4944415478DAEDD0A115
          00210C44419A4260A9858A28839AAE97231A042276FE4BEC8A29535725BEF591
          BCFC482CFCE962A4AE2F7950A0408102050A142850A0408102050A14286F141D
          6D6D3C989797AADA180000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E4031016090F0F6EA761000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC6105000000474944415478DAEDD0A111
          00200C04C154472FB443AB0C1AA2412062F726B12F36869E227F95CB9119BD72
          B9B0CBE5482B07050A142850A0408102050A142850A04081F247D1D50198CDBC
          65CC09A2E40000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E40310160928AA64120A000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC6105000000474944415478DAEDD0A111
          00200C04C154472FB443AB0C1AA2412062F726B12F36869E227F95CB9119BD72
          B9B0CBE5482B07050A142850A0408102050A142850A04081F247D1D50198CDBC
          65CC09A2E40000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E40310160A05C4961DBC000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC6105000000514944415478DAEDD0A115
          80300C45D12E53534B0DA6B253305587EB3A100D02117BDF49EC17B72C7D2AF1
          E798C98B91DA7AE662E14E1723FBB89207050A142850A0408102050A142850A0
          4081F28FA2570F26BD7AC89C2A60360000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D494844520000005C00000012080200000059DF2E
          130000002D744558744372656174696F6E2054696D65006C752E203136206D61
          722E20323032302032303A31323A3437202B30313030517FF4B6000000077449
          4D4507E40310160A22619CA8D7000000097048597300000B1200000B1201D2DD
          7EFC0000000467414D410000B18F0BFC61050000004B4944415478DAEDD0A10D
          002110454134AD90D00609E5D1C2157AAC0681583B2FBBF68B294B5725BEF599
          BCFC482CFCE962A47E237950A0408102050A142850A0408102050A14286F141D
          6DC566E5994285AE690000000049454E44AE426082}
      end>
  end
end
