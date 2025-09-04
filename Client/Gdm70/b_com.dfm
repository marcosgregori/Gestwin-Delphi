object BoxComForm: TBoxComForm
  Left = 607
  Top = 376
  HelpType = htKeyword
  HelpKeyword = 'b_com'
  BorderStyle = bsDialog
  Caption = 'Calendario de ocupaci'#243'n de m'#225'quinas'
  ClientHeight = 431
  ClientWidth = 758
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
  Position = poDefault
  Visible = True
  OnResize = gxFormResize
  TextHeight = 17
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 69
    Width = 758
    object CodigoMaquinaCtrl: TcxDBTextEdit
      Left = 87
      Top = 5
      DescriptionLabel = cxLabel3
      DataBinding.DataField = 'CodigoMaquina'
      DataBinding.DataSource = MemDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoMaquinaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoMaquinaCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoMaquinaCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object CodigoCtrlCaption: TcxLabel
      Left = 15
      Top = 8
      TabStop = False
      Caption = 'M'#225'quina'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel1: TcxLabel
      Left = 15
      Top = 35
      TabStop = False
      Caption = 'Turno'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object NroTurnoCtrl: TcxDBSpinEdit
      Left = 87
      Top = 32
      DescriptionLabel = cxLabel4
      DataBinding.DataField = 'Turno'
      DataBinding.DataSource = MemDataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroTurnoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = NroTurnoCtrlPropertiesEditRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = NroTurnoCtrlPropertiesValidate
      TabOrder = 1
      Width = 46
    end
    object cxLabel3: TcxLabel
      Left = 167
      Top = 6
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 292
      AnchorY = 16
    end
    object cxLabel4: TcxLabel
      Left = 167
      Top = 33
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 292
      AnchorY = 43
    end
    object cxGroupBox7: TcxGroupBox
      Left = 292
      Top = 2
      Align = alRight
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 6
      Height = 65
      Width = 464
      object cxImage1: TcxImage
        Left = 423
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
          3B3C672069643D2269636F6E2220786D6C3A73706163653D2270726573657276
          65223E262331333B262331303B3C7061746820643D224D32312E382C33682D32
          2E3330353163302E303032322C302E303333322C302E303035312C302E303636
          332C302E303035312C302E3176302E3963302C302E3832352C2D302E3637352C
          312E352C2D312E352C312E35732D312E352C2D302E3637352C2D312E352C2D31
          2E35762D302E3963302C2D302E303333372C302E303032392C2D302E30363638
          2C302E303035312C2D302E3148372E3439343943372E343937312C332E303333
          322C372E352C332E303636332C372E352C332E3176302E3963302C302E383235
          2C2D302E3637352C312E352C2D312E352C312E35732D312E352C2D302E363735
          2C2D312E352C2D312E35762D302E3963302C2D302E303333372C302E30303239
          2C2D302E303636382C302E303035312C2D302E3148322E32632D302E36362C30
          2C2D312E322C302E35342C2D312E322C312E3276322E3868323256342E324332
          332C332E35342C32322E34362C332C32312E382C337A222066696C6C3D222344
          4234343533222F3E0D0A3C7061746820643D224D32322C32324832632D302E35
          3532332C302C2D312C2D302E343437372C2D312C2D3156376832327631344332
          332C32312E353532332C32322E353532332C32322C32322C32327A222066696C
          6C3D2223453645394545222F3E0D0A3C7061746820643D224D32312E382C3368
          2D322E3330353163302E303032322C302E303333322C302E303035312C302E30
          3636332C302E303035312C302E3176302E3963302C302E3832352C2D302E3637
          352C312E352C2D312E352C312E35632D302E343337352C302C2D302E38333136
          2C2D302E3139312C2D312E313036342C2D302E343932334C372E303833312C32
          3248323263302E353532332C302C312C2D302E343437372C312C2D3156375634
          2E324332332C332E35342C32322E34362C332C32312E382C337A222066696C6C
          3D222332333146323022206F7061636974793D22302E31222F3E0D0A3C706174
          6820643D224D362C354C362C35632D302E35352C302C2D312C2D302E34352C2D
          312C2D31563263302C2D302E35352C302E34352C2D312C312C2D31683063302E
          35352C302C312C302E34352C312C31763243372C342E35352C362E35352C352C
          362C357A4D31392C34563263302C2D302E35352C2D302E34352C2D312C2D312C
          2D316830632D302E35352C302C2D312C302E34352C2D312C31763263302C302E
          35352C302E34352C312C312C3168304331382E35352C352C31392C342E35352C
          31392C347A222066696C6C3D2223353336383830222F3E0D0A3C706174682064
          3D224D31342C39682D347633683456397A4D31392C39682D347633683456397A
          4D392C31334835763368345631337A4D31342C3133682D34763368345631337A
          4D31392C3133682D34763368345631337A4D392C31374835763368345631377A
          4D31342C3137682D34763368345631377A4D31392C3137682D34763368345631
          377A222066696C6C3D2223384539343943222F3E0D0A093C2F673E0D0A3C2F73
          76673E0D0A}
        Properties.Center = False
        Properties.FitMode = ifmProportionalStretch
        Properties.ReadOnly = True
        Properties.ShowFocusRect = False
        Style.BorderStyle = ebsNone
        StyleFocused.BorderStyle = ebsNone
        StyleHot.BorderStyle = ebsNone
        TabOrder = 0
        Transparent = True
        Height = 61
        Width = 39
      end
      object cxLabel2: TcxLabel
        Left = 12
        Top = 7
        TabStop = False
        Caption = 'Mes'
        Transparent = True
      end
      object cxButton1: TcxButton
        Tag = -1
        Left = 48
        Top = 4
        Width = 26
        Height = 26
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.SourceHeight = 20
        OptionsImage.Glyph.SourceWidth = 20
        OptionsImage.Glyph.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
          2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
          77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
          22307078222077696474683D223234707822206865696768743D223234707822
          2076696577426F783D223020302032342032342220656E61626C652D6261636B
          67726F756E643D226E6577203020302032342032342220786D6C3A7370616365
          3D227072657365727665223E262331303B20202623393B2623393B2623393B26
          23393B2623393B2623393B2623393B3C672069643D2269636F6E2220786D6C3A
          73706163653D227072657365727665223E262331333B262331303B3C63697263
          6C652063783D223132222063793D2231322220723D2231302E39383939222066
          696C6C3D2223344643304538222F3E0D0A3C7061746820643D224D31392E3737
          31312C342E32323839632D302E3031352C2D302E3031352C2D302E303330352C
          2D302E303239352C2D302E303435362C2D302E303434346C2D31352E3534312C
          31352E35343163302E303134392C302E303135312C302E303239342C302E3033
          30352C302E303434342C302E3034353663342E323931382C342E323931382C31
          312E323530332C342E323931382C31352E353432312C305332342E303632392C
          382E353230382C31392E373731312C342E323238397A222066696C6C3D222333
          4241454441222F3E0D0A3C7061746820643D224D362E303136372C31312E3731
          34396C352E373938332C2D352E3739383363302E313535362C2D302E31353536
          2C302E343130312C2D302E313535362C302E353635372C306C302E383438352C
          302E3834383563302E313535362C302E313535362C302E313535362C302E3431
          30312C302C302E353635374C392E353630312C313168382E3031393563302E32
          322C302C302E343230342C302E31382C302E343230342C302E3476312E326330
          2C302E32322C2D302E323030342C302E342C2D302E343230342C302E3448392E
          353634356C332E363634372C332E3636343763302E313535362C302E31353536
          2C302E313535362C302E343130312C302C302E353635376C2D302E383438352C
          302E38343835632D302E313535362C302E313535362C2D302E343130312C302E
          313535362C2D302E353635372C306C2D342E393439372C2D342E393439376C2D
          302E383438352C2D302E3834383543352E383631312C31322E313235312C352E
          383631312C31312E383730352C362E303136372C31312E373134397A22206669
          6C6C3D2223464646464646222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
        PaintStyle = bpsGlyph
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 2
        OnClick = MesButtonClick
      end
      object cxButton2: TcxButton
        Tag = 1
        Left = 209
        Top = 4
        Width = 26
        Height = 26
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.SourceHeight = 20
        OptionsImage.Glyph.SourceWidth = 20
        OptionsImage.Glyph.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
          2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
          77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
          22307078222077696474683D223234707822206865696768743D223234707822
          2076696577426F783D223020302032342032342220656E61626C652D6261636B
          67726F756E643D226E6577203020302032342032342220786D6C3A7370616365
          3D227072657365727665223E262331303B20202623393B2623393B2623393B26
          23393B2623393B2623393B2623393B3C672069643D2269636F6E2220786D6C3A
          73706163653D227072657365727665223E262331333B262331303B3C63697263
          6C652063783D223132222063793D2231322220723D2231302E39383939222066
          696C6C3D2223344643304538222F3E0D0A3C7061746820643D224D31392E3737
          31312C342E32323839632D302E3031352C2D302E3031352C2D302E303330352C
          2D302E303239352C2D302E303435362C2D302E303434346C2D31352E3534312C
          31352E35343163302E303134392C302E303135312C302E303239342C302E3033
          30352C302E303434342C302E3034353663342E323931382C342E323931382C31
          312E323530332C342E323931382C31352E353432312C305332342E303632392C
          382E353230382C31392E373731312C342E323238397A222066696C6C3D222333
          4241454441222F3E0D0A3C7061746820643D224D31372E393632392C31312E37
          3134396C2D352E373938332C2D352E37393833632D302E313535362C2D302E31
          3535362C2D302E343130312C2D302E313535362C2D302E353635372C306C2D30
          2E383438352C302E38343835632D302E313535362C302E313535362C2D302E31
          3535362C302E343130312C302C302E353635374C31342E343139352C31314836
          2E34632D302E32322C302C2D302E342C302E31382C2D302E342C302E3476312E
          3263302C302E32322C302E31382C302E342C302E342C302E3468382E30313531
          6C2D332E363634372C332E36363437632D302E313535362C302E313535362C2D
          302E313535362C302E343130312C302C302E353635376C302E383438352C302E
          3834383563302E313535362C302E313535362C302E343130312C302E31353536
          2C302E353635372C306C342E393439372C2D342E393439376C302E383438352C
          2D302E383438354331382E313138352C31322E313235312C31382E313138352C
          31312E383730352C31372E393632392C31312E373134397A222066696C6C3D22
          23464646464646222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
        PaintStyle = bpsGlyph
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 3
        OnClick = MesButtonClick
      end
      object MesCtrl: TcxDBIndexedComboBox
        Left = 73
        Top = 5
        DataBinding.DataField = 'Mes'
        DataBinding.DataSource = MemDataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'Enero'
          'Febrero'
          'Marzo'
          'Abril'
          'Mayo'
          'Junio'
          'Julio'
          'Agosto'
          'Septiembre'
          'Octubre'
          'Noviembre'
          'Diciembre')
        Properties.OnEditValueChanged = MesCtrlPropertiesEditValueChanged
        Properties.FirstIndexValue = 1
        TabOrder = 4
        Width = 135
      end
      object cxLabel5: TcxLabel
        Left = 246
        Top = 7
        TabStop = False
        Caption = 'Ejercicio'
        Transparent = True
      end
      object cxButton3: TcxButton
        Tag = -1
        Left = 303
        Top = 4
        Width = 26
        Height = 26
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.SourceHeight = 20
        OptionsImage.Glyph.SourceWidth = 20
        OptionsImage.Glyph.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
          2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
          77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
          22307078222077696474683D223234707822206865696768743D223234707822
          2076696577426F783D223020302032342032342220656E61626C652D6261636B
          67726F756E643D226E6577203020302032342032342220786D6C3A7370616365
          3D227072657365727665223E262331303B20202623393B2623393B2623393B26
          23393B2623393B2623393B2623393B3C672069643D2269636F6E2220786D6C3A
          73706163653D227072657365727665223E262331333B262331303B3C63697263
          6C652063783D223132222063793D2231322220723D2231302E39383939222066
          696C6C3D2223344643304538222F3E0D0A3C7061746820643D224D31392E3737
          31312C342E32323839632D302E3031352C2D302E3031352C2D302E303330352C
          2D302E303239352C2D302E303435362C2D302E303434346C2D31352E3534312C
          31352E35343163302E303134392C302E303135312C302E303239342C302E3033
          30352C302E303434342C302E3034353663342E323931382C342E323931382C31
          312E323530332C342E323931382C31352E353432312C305332342E303632392C
          382E353230382C31392E373731312C342E323238397A222066696C6C3D222333
          4241454441222F3E0D0A3C7061746820643D224D362E303136372C31312E3731
          34396C352E373938332C2D352E3739383363302E313535362C2D302E31353536
          2C302E343130312C2D302E313535362C302E353635372C306C302E383438352C
          302E3834383563302E313535362C302E313535362C302E313535362C302E3431
          30312C302C302E353635374C392E353630312C313168382E3031393563302E32
          322C302C302E343230342C302E31382C302E343230342C302E3476312E326330
          2C302E32322C2D302E323030342C302E342C2D302E343230342C302E3448392E
          353634356C332E363634372C332E3636343763302E313535362C302E31353536
          2C302E313535362C302E343130312C302C302E353635376C2D302E383438352C
          302E38343835632D302E313535362C302E313535362C2D302E343130312C302E
          313535362C2D302E353635372C306C2D342E393439372C2D342E393439376C2D
          302E383438352C2D302E3834383543352E383631312C31322E313235312C352E
          383631312C31312E383730352C362E303136372C31312E373134397A22206669
          6C6C3D2223464646464646222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
        PaintStyle = bpsGlyph
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 6
        OnClick = EjercicioButtonClick
      end
      object cxButton4: TcxButton
        Tag = 1
        Left = 381
        Top = 4
        Width = 26
        Height = 26
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.SourceHeight = 20
        OptionsImage.Glyph.SourceWidth = 20
        OptionsImage.Glyph.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
          2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
          77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
          22307078222077696474683D223234707822206865696768743D223234707822
          2076696577426F783D223020302032342032342220656E61626C652D6261636B
          67726F756E643D226E6577203020302032342032342220786D6C3A7370616365
          3D227072657365727665223E262331303B20202623393B2623393B2623393B26
          23393B2623393B2623393B2623393B3C672069643D2269636F6E2220786D6C3A
          73706163653D227072657365727665223E262331333B262331303B3C63697263
          6C652063783D223132222063793D2231322220723D2231302E39383939222066
          696C6C3D2223344643304538222F3E0D0A3C7061746820643D224D31392E3737
          31312C342E32323839632D302E3031352C2D302E3031352C2D302E303330352C
          2D302E303239352C2D302E303435362C2D302E303434346C2D31352E3534312C
          31352E35343163302E303134392C302E303135312C302E303239342C302E3033
          30352C302E303434342C302E3034353663342E323931382C342E323931382C31
          312E323530332C342E323931382C31352E353432312C305332342E303632392C
          382E353230382C31392E373731312C342E323238397A222066696C6C3D222333
          4241454441222F3E0D0A3C7061746820643D224D31372E393632392C31312E37
          3134396C2D352E373938332C2D352E37393833632D302E313535362C2D302E31
          3535362C2D302E343130312C2D302E313535362C2D302E353635372C306C2D30
          2E383438352C302E38343835632D302E313535362C302E313535362C2D302E31
          3535362C302E343130312C302C302E353635374C31342E343139352C31314836
          2E34632D302E32322C302C2D302E342C302E31382C2D302E342C302E3476312E
          3263302C302E32322C302E31382C302E342C302E342C302E3468382E30313531
          6C2D332E363634372C332E36363437632D302E313535362C302E313535362C2D
          302E313535362C302E343130312C302C302E353635376C302E383438352C302E
          3834383563302E313535362C302E313535362C302E343130312C302E31353536
          2C302E353635372C306C342E393439372C2D342E393439376C302E383438352C
          2D302E383438354331382E313138352C31322E313235312C31382E313138352C
          31312E383730352C31372E393632392C31312E373134397A222066696C6C3D22
          23464646464646222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
        PaintStyle = bpsGlyph
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 7
        OnClick = EjercicioButtonClick
      end
      object EjercicioCtrl: TcxDBIntegerEdit
        Left = 329
        Top = 6
        DataBinding.DataField = 'Ejercicio'
        DataBinding.DataSource = MemDataSource
        Properties.MaxValue = 9999.000000000000000000
        Properties.MinValue = 2000.000000000000000000
        Properties.OnEditValueChanged = EjercicioCtrlPropertiesEditValueChanged
        TabOrder = 8
        Width = 50
      end
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 69
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
    Height = 326
    Width = 748
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 296
      Width = 744
      object LeftCalendarPanel: TcxGroupBox
        Left = 2
        Top = 2
        Align = alLeft
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 292
        Width = 355
        object LeftWorkCalendar: TWorkCalendar
          Left = 2
          Top = 31
          Width = 351
          Height = 259
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alClient
          Ctl3D = False
          DefaultDrawing = False
          ReadOnly = True
          StartOfWeek = 1
          TabOrder = 0
          UseCurrentDate = False
          OnDrawCell = LeftWorkCalendarDrawCell
        end
        object LeftCalendarLabel: TcxLabel
          AlignWithMargins = True
          Left = 5
          Top = 5
          TabStop = False
          Align = alTop
          AutoSize = False
          Caption = 'Mes / Ejercicio'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 23
          Width = 345
        end
      end
      object RightCalendarPanel: TcxGroupBox
        Left = 357
        Top = 2
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 292
        Width = 385
        object RightWorkCalendar: TWorkCalendar
          Left = 2
          Top = 31
          Width = 381
          Height = 259
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alClient
          Ctl3D = False
          DefaultDrawing = False
          ReadOnly = True
          StartOfWeek = 1
          TabOrder = 0
          UseCurrentDate = False
          OnDrawCell = RightWorkCalendarDrawCell
        end
        object RightCalendarLabel: TcxLabel
          AlignWithMargins = True
          Left = 5
          Top = 5
          TabStop = False
          Align = alTop
          AutoSize = False
          Caption = 'Mes / Ejercicio'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 23
          Width = 375
        end
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 298
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 26
      Width = 744
      object cxLabel8: TcxLabel
        AlignWithMargins = True
        Left = 5
        Top = 5
        TabStop = False
        Align = alLeft
        AutoSize = False
        Caption = 'Indicador de carga'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 16
        Width = 133
        AnchorY = 13
      end
      object cxGroupBox5: TcxGroupBox
        Left = 141
        Top = 2
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 1
        Height = 22
        Width = 601
        object Shape2: TShape
          AlignWithMargins = True
          Left = 133
          Top = 0
          Width = 28
          Height = 22
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Brush.Color = 7894527
          Pen.Style = psClear
          ExplicitLeft = 132
          ExplicitHeight = 21
        end
        object Shape1: TShape
          AlignWithMargins = True
          Left = 105
          Top = 0
          Width = 28
          Height = 22
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Brush.Color = 10987007
          Pen.Style = psClear
          ExplicitLeft = 104
          ExplicitHeight = 21
        end
        object Shape3: TShape
          AlignWithMargins = True
          Left = 77
          Top = 0
          Width = 28
          Height = 22
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Brush.Color = 11401719
          Pen.Style = psClear
          ExplicitLeft = 76
          ExplicitHeight = 21
        end
        object Shape4: TShape
          AlignWithMargins = True
          Left = 49
          Top = 0
          Width = 28
          Height = 22
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Brush.Color = 11921612
          Pen.Style = psClear
          ExplicitLeft = 48
          ExplicitHeight = 21
        end
        object Shape5: TShape
          AlignWithMargins = True
          Left = 21
          Top = 0
          Width = 28
          Height = 22
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Pen.Style = psClear
          ExplicitLeft = 48
          ExplicitHeight = 21
        end
        object cxImage2: TcxImage
          Left = 0
          Top = 0
          TabStop = False
          Align = alLeft
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
            203C672069643D2269636F6E223E0D0A09093C7061746820643D224D31382E36
            2C313448352E34632D302E32322C302C2D302E342C2D302E31382C2D302E342C
            2D302E34762D322E3263302C2D302E32322C302E31382C2D302E342C302E342C
            2D302E346831332E3263302E32322C302C302E342C302E31382C302E342C302E
            3476322E324331392C31332E38322C31382E38322C31342C31382E362C31347A
            222066696C6C3D2223383238443943222F3E0D0A093C2F673E0D0A3C2F737667
            3E0D0A}
          Properties.FitMode = ifmProportionalStretch
          Properties.GraphicClassName = 'TdxSmartImage'
          Properties.ReadOnly = True
          Properties.ShowFocusRect = False
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          StyleFocused.BorderStyle = ebsNone
          StyleHot.BorderStyle = ebsNone
          TabOrder = 0
          Transparent = True
          Height = 22
          Width = 21
        end
        object cxImage3: TcxImage
          AlignWithMargins = True
          Left = 162
          Top = 1
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          TabStop = False
          Align = alLeft
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
            203C672069643D2269636F6E223E0D0A09093C7061746820643D224D32312E34
            2C3131682D372E3456332E3663302C2D302E33332C2D302E32372C2D302E362C
            2D302E362C2D302E36682D312E38632D302E33332C302C2D302E362C302E3237
            2C2D302E362C302E3676372E3448332E36632D302E33332C302C2D302E362C30
            2E32372C2D302E362C302E3676312E3863302C302E33332C302E32372C302E36
            2C302E362C302E3668372E3476372E3463302C302E33332C302E32372C302E36
            2C302E362C302E3668312E3863302E33332C302C302E362C2D302E32372C302E
            362C2D302E36762D372E3468372E3463302E33332C302C302E362C2D302E3237
            2C302E362C2D302E36762D312E384332322C31312E32372C32312E37332C3131
            2C32312E342C31317A222066696C6C3D2223364237363836222F3E0D0A093C2F
            673E0D0A3C2F7376673E0D0A}
          Properties.FitMode = ifmProportionalStretch
          Properties.GraphicClassName = 'TdxSmartImage'
          Properties.ReadOnly = True
          Properties.ShowFocusRect = False
          Style.BorderStyle = ebsNone
          StyleFocused.BorderStyle = ebsNone
          StyleHot.BorderStyle = ebsNone
          TabOrder = 1
          Transparent = True
          Height = 20
          Width = 21
        end
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 395
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      758
      36)
    Height = 36
    Width = 758
    object Panel2: TcxGroupBox
      Left = 291
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 180
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
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
        AlignWithMargins = True
        Left = 90
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
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
    FirstKeyControl = CodigoMaquinaCtrl
    FirstDataControl = LeftWorkCalendar
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 358
    Top = 32
  end
  object SecuenciaAsignacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    TableName = 'SecuenciaAsignacion'
    IndexFieldNames = 'CodigoMaquina;Fecha;Turno;NroOrdenEntrada'
    AutoIncFieldName = 'NroOrdenEntrada'
    Left = 232
    Top = 32
    object SecuenciaAsignacionTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
      Required = True
    end
    object SecuenciaAsignacionTableNroOrdenFabricacion: TIntegerField
      FieldName = 'NroOrdenFabricacion'
      Required = True
    end
    object SecuenciaAsignacionTableNroProceso: TSmallintField
      FieldName = 'NroProceso'
      Required = True
    end
    object SecuenciaAsignacionTableSegmento: TSmallintField
      FieldName = 'Segmento'
      Required = True
    end
    object SecuenciaAsignacionTableCodigoMaquina: TWideStringField
      FieldName = 'CodigoMaquina'
      Size = 5
    end
    object SecuenciaAsignacionTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object SecuenciaAsignacionTableTurno: TSmallintField
      FieldName = 'Turno'
    end
    object SecuenciaAsignacionTableNroOrdenEntrada: TSmallintField
      FieldName = 'NroOrdenEntrada'
    end
    object SecuenciaAsignacionTablePrioridad: TSmallintField
      FieldName = 'Prioridad'
    end
    object SecuenciaAsignacionTableTiempo: TLongWordField
      FieldName = 'Tiempo'
    end
    object SecuenciaAsignacionTableCantidad: TBCDField
      FieldName = 'Cantidad'
      Precision = 16
    end
    object SecuenciaAsignacionTableRealizado: TBooleanField
      FieldName = 'Realizado'
    end
    object SecuenciaAsignacionTableCodigoArticulo: TStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoArticulo'
      Calculated = True
    end
    object SecuenciaAsignacionTableCodigoClaseA: TStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoClaseA'
      Size = 3
      Calculated = True
    end
    object SecuenciaAsignacionTableCodigoClaseB: TStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoClaseB'
      Size = 3
      Calculated = True
    end
    object SecuenciaAsignacionTableCodigoClaseC: TStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoClaseC'
      Size = 3
      Calculated = True
    end
    object SecuenciaAsignacionTableDescripcionArticulo: TStringField
      FieldKind = fkCalculated
      FieldName = 'DescripcionArticulo'
      Size = 80
      Calculated = True
    end
    object SecuenciaAsignacionTableHoraInicio: TTimeField
      FieldName = 'HoraInicio'
    end
  end
  object SecuenciaAsignacionDataSource: TDataSource
    DataSet = SecuenciaAsignacionTable
    Enabled = False
    Left = 202
    Top = 32
  end
  object MemData: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 321
    Top = 32
    object MemDataCodigoMaquina: TStringField
      FieldName = 'CodigoMaquina'
      Size = 5
    end
    object MemDataTurno: TSmallintField
      FieldName = 'Turno'
    end
    object MemDataMes: TSmallintField
      FieldName = 'Mes'
    end
    object MemDataEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
  end
  object MemDataSource: TDataSource
    DataSet = MemData
    Left = 290
    Top = 32
  end
  object OrdenFabricacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    TableName = 'OrdenFabricacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden'
    AutoIncFieldName = 'NroOrdenEntrada'
    Left = 162
    Top = 32
  end
end
