object MntRemForm: TMntRemForm
  Left = 439
  Top = 254
  HelpType = htKeyword
  HelpKeyword = 'a_rem'
  HelpContext = 3121
  ActiveControl = DeleteButton
  BorderStyle = bsDialog
  Caption = 'Remesas de cobro'
  ClientHeight = 499
  ClientWidth = 851
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Hint = 
      'Utilice el bot'#243'n derecho del rat'#243'n para acceder al men'#250' de opcio' +
      'nes'
    Align = alTop
    PanelStyle.Active = True
    ParentShowHint = False
    ShowHint = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    OnEnter = keyPanelEnter
    PanelKind = epKeyPanel
    DesignSize = (
      851
      34)
    Height = 34
    Width = 851
    object AnotacionButton: TcxButton
      Left = 220
      Top = 4
      Width = 106
      Height = 27
      Hint = 
        'Anotaci'#243'n de la aceptaci'#243'n, cobro, descuento o cancelaci'#243'n de la' +
        ' remesa.'
      Caption = 'A&notaci'#243'n'
      DropDownMenu = MainPopupMenu
      Kind = cxbkOfficeDropDown
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.SourceHeight = 16
      OptionsImage.Glyph.SourceWidth = 16
      OptionsImage.Glyph.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C73766720786D6C6E733A64633D22687474703A2F2F7075
        726C2E6F72672F64632F656C656D656E74732F312E312F2220786D6C6E733A63
        633D22687474703A2F2F6372656174697665636F6D6D6F6E732E6F72672F6E73
        232220786D6C6E733A7264663D22687474703A2F2F7777772E77332E6F72672F
        313939392F30322F32322D7264662D73796E7461782D6E73232220786D6C6E73
        3A7376673D22687474703A2F2F7777772E77332E6F72672F323030302F737667
        2220786D6C6E733D22687474703A2F2F7777772E77332E6F72672F323030302F
        7376672220786D6C6E733A736F6469706F64693D22687474703A2F2F736F6469
        706F64692E736F75726365666F7267652E6E65742F4454442F736F6469706F64
        692D302E6474642220786D6C6E733A696E6B73636170653D22687474703A2F2F
        7777772E696E6B73636170652E6F72672F6E616D657370616365732F696E6B73
        63617065222076657273696F6E3D22312E31222069643D224C617965725F3122
        20783D223070782220793D22307078222077696474683D223234707822206865
        696768743D2232347078222076696577426F783D223020302032342032342220
        656E61626C652D6261636B67726F756E643D226E657720302030203234203234
        2220736F6469706F64693A646F636E616D653D2277696E646F772D656469742E
        7376672220696E6B73636170653A76657273696F6E3D22302E39322E32202835
        6333653830642C20323031372D30382D303629223E0D0A093C6D657461646174
        612069643D226D657461646174613338223E0D0A09093C7264663A5244463E0D
        0A0909093C63633A576F726B207264663A61626F75743D22223E0D0A09090909
        3C64633A666F726D61743E696D6167652F7376672B786D6C3C2F64633A666F72
        6D61743E0D0A090909093C64633A74797065207264663A7265736F757263653D
        22687474703A2F2F7075726C2E6F72672F64632F64636D69747970652F537469
        6C6C496D616765222F3E0D0A0909093C2F63633A576F726B3E0D0A09093C2F72
        64663A5244463E0D0A093C2F6D657461646174613E0D0A093C64656673206964
        3D22646566733336223E0D0A09093C636C6970506174682069643D22636C6970
        5F6D61736B223E0D0A0909093C7061746820696E6B73636170653A636F6E6E65
        63746F722D6375727661747572653D2230222069643D2270617468322220643D
        224D2031322E343531362C32342048203020562030204820323420562031332E
        36323935204C2032332E323438382C31322E3837383320432032322E39373235
        2C31322E363032312032322E363035332C31322E34352032322E323134372C31
        322E34352063202D302E333930372C30202D302E373537392C302E3135323120
        2D312E303334322C302E34323833206C202D302E363330352C302E3633303520
        2D302E363338332C302E363338332063202D33652D342C33652D34202D36652D
        342C37652D34202D39652D342C3130652D34202D302E3032332C302E30323320
        2D352E353037372C352E35313437202D352E373730352C352E37373734202D30
        2E303135362C302E30313536202D302E30332C302E30333138202D302E303434
        372C302E303438202D302E312C302E30393334202D302E313832342C302E3230
        3633202D302E323337382C302E33333537206C202D302E393935372C322E3332
        3333206320302C3130652D35202D3130652D352C32652D34202D3130652D352C
        33652D34206C202D302E313134312C302E32363634202D302E323330352C302E
        3533373820432031322E343339372C32332E363138342031322E343139362C32
        332E383133382031322E343531362C3234205A206D2031312E343237372C2D37
        2E31363231202D302E363338332C302E363338332063202D33652D342C33652D
        34202D37652D342C36652D34202D302E3030312C39652D34202D302E30353839
        2C302E303539202D352E353739392C352E35383731202D352E373730342C352E
        37373736202D302E303133352C302E30313335202D302E303238312C302E3032
        3534202D302E303432312C302E30333831202D302E303934352C302E31303320
        2D302E323039342C302E31383737202D302E333431372C302E32343434204C20
        31362E3030362C323420482032342076202D372E32383238207A222F3E0D0A09
        093C2F636C6970506174683E0D0A093C2F646566733E0D0A093C736F6469706F
        64693A6E616D6564766965772070616765636F6C6F723D222366666666666622
        20626F72646572636F6C6F723D22233636363636362220626F726465726F7061
        636974793D223122206F626A656374746F6C6572616E63653D22313022206772
        6964746F6C6572616E63653D22313022206775696465746F6C6572616E63653D
        2231302220696E6B73636170653A706167656F7061636974793D22302220696E
        6B73636170653A70616765736861646F773D22322220696E6B73636170653A77
        696E646F772D77696474683D22313932302220696E6B73636170653A77696E64
        6F772D6865696768743D2231303137222069643D226E616D6564766965773334
        222073686F77677269643D2266616C73652220696E6B73636170653A7A6F6F6D
        3D2233352E33343833352220696E6B73636170653A63783D2231312E39363930
        32352220696E6B73636170653A63793D22392E323436343231312220696E6B73
        636170653A77696E646F772D783D222D382220696E6B73636170653A77696E64
        6F772D793D222D332220696E6B73636170653A77696E646F772D6D6178696D69
        7A65643D22312220696E6B73636170653A63757272656E742D6C617965723D22
        4C617965725F31222F3E0D0A093C672069643D227472616E73666F726D65645F
        69636F6E22207472616E73666F726D3D227472616E736C617465282D312C2D31
        29223E0D0A09093C7061746820643D224D2032332C36205620332E3220432032
        332C322E35342032322E34362C322032312E382C32204820322E32204320312E
        35342C3220312C322E353420312C332E3220562036205A222069643D22706174
        68352220696E6B73636170653A636F6E6E6563746F722D637572766174757265
        3D223022207374796C653D2266696C6C3A23346238396463222F3E0D0A09093C
        7061746820643D224D20312C3620562032302E38204320312C32312E34362031
        2E35342C323220322E322C323220482032312E3820432032322E34362C323220
        32332C32312E34362032332C32302E3820562036222069643D22706174683722
        20696E6B73636170653A636F6E6E6563746F722D6375727661747572653D2230
        22207374796C653D2266696C6C3A23653665396565222F3E0D0A09093C706174
        6820643D224D2032312E382C3220482031382E30323632204C2031322E323838
        352C323220482032312E3820432032322E34362C32322032332C32312E343620
        32332C32302E38205620332E3220432032332C322E35342032322E34362C3220
        32312E382C32205A222069643D2270617468392220696E6B73636170653A636F
        6E6E6563746F722D6375727661747572653D223022207374796C653D226F7061
        636974793A302E30363030303030313B66696C6C3A23323331663230222F3E0D
        0A093C2F673E0D0A093C70617468207374796C653D2266696C6C3A2364623434
        35333B7374726F6B653A236666666666663B7374726F6B652D77696474683A32
        2E32303030303030353B7374726F6B652D6D697465726C696D69743A343B7374
        726F6B652D6461736861727261793A6E6F6E653B7374726F6B652D6F70616369
        74793A312220643D226D2032322E3231333338342C31332E3435303133206320
        2D302E33363135332C302E3034313439202D302E3534383138382C302E343033
        393834202D302E3831303136312C302E363139323039202D322E323130373339
        2C322E323039393339202D342E3431373633362C342E3432333732202D362E36
        32373333392C362E363334363935202D302E3434363631342C312E3034323331
        38202D302E3839333232392C322E303834363335202D312E3333393834332C33
        2E31323639353320302E3130363637382C302E32323435363520302E32393337
        382C302E3033393720302E3435343635312C2D302E303131363220302E393333
        3733362C2D302E34303034323220312E3836373437322C2D302E383030383435
        20322E3830313230382C2D312E32303132363720322E3337303235342C2D322E
        33373139333420342E3733393638332C2D342E37343436393520372E31303933
        37392C2D372E31313731383520302E3330393039312C2D302E33303130343920
        302E30323734382C2D302E363735323234202D302E3233313131352C2D302E38
        3835343132202D302E3336383838382C2D302E333630373532202D302E373232
        3130332C2D302E373338383237202D312E3130313336382C2D312E3038383130
        38202D302E30373531372C2D302E3034393934202D302E3136353133322C2D30
        2E3037373336202D302E3235353431322C2D302E3037373236207A222069643D
        22706174683839342220696E6B73636170653A636F6E6E6563746F722D637572
        7661747572653D2230222F3E0D0A093C672069643D2267393338223E0D0A0909
        3C70617468207374796C653D2266696C6C3A236462343435332220696E6B7363
        6170653A636F6E6E6563746F722D6375727661747572653D2230222069643D22
        7061746831332220643D226D2032332E383032362C31352E35303034202D302E
        363330342C302E36333034202D312E393134392C2D312E3931343920302E3633
        30342C2D302E36333034206320302E313830362C2D302E3138303620302E3437
        33352C2D302E3138303620302E363534312C30206C20312E323630382C312E32
        363038206320302E313830362C302E3138303620302E313830362C302E343733
        3420302C302E36353431207A222F3E0D0A09093C72656374207472616E73666F
        726D3D22726F74617465282D34352922207374796C653D2266696C6C3A236363
        64306439222069643D2272656374313522206865696768743D22302E36333139
        30303031222077696474683D22302E39303237303030312220793D2232352E30
        38333332342220783D22342E30373633323439222F3E0D0A09093C7265637420
        7472616E73666F726D3D22726F74617465282D34352922207374796C653D2266
        696C6C3A23653665396565222069643D2272656374313722206865696768743D
        22312E333534222077696474683D22302E39303237303030312220793D223235
        2E37313531362220783D22342E30373633363132222F3E0D0A09093C72656374
        207472616E73666F726D3D22726F74617465282D34352922207374796C653D22
        66696C6C3A23636364306439222069643D227265637431392220686569676874
        3D22302E3732323139393938222077696474683D22302E393032373030303122
        20793D2232372E3036393136322220783D22342E30373632383937222F3E0D0A
        09093C706F6C79676F6E207374796C653D2266696C6C3A236666646462303B73
        74726F6B652D6C696E656A6F696E3A6D69746572222069643D22706F6C79676F
        6E32312220706F696E74733D2231362E363931392C32322E363138312031342E
        3737372C32302E373033322031332E343336362C32332E383330382031332E35
        3634332C32332E3935383520222F3E0D0A09093C706F6C79676F6E207374796C
        653D2266696C6C3A233635366437383B7374726F6B652D6C696E656A6F696E3A
        6D69746572222069643D22706F6C79676F6E32332220706F696E74733D223133
        2E343336362C32332E383330382031332E353634332C32332E39353835203134
        2E333638352C32332E363133382031332E373831332C32332E3032363620222F
        3E0D0A09093C70617468207374796C653D2266696C6C3A236666636535352220
        696E6B73636170653A636F6E6E6563746F722D6375727661747572653D223022
        2069643D227061746832352220643D226D2032312E303635382C31352E333031
        206320302C30202D352E353731392C352E353739202D352E373731342C352E37
        373835202D302E313939352C302E31393935202D302E373130312C2D302E3138
        3335202D302E343436382C2D302E3434363820302E323633332C2D302E323633
        3320352E373731342C2D352E3737383520352E373731342C2D352E3737383520
        7A222F3E0D0A09093C70617468207374796C653D2266696C6C3A236666643537
        362220696E6B73636170653A636F6E6E6563746F722D6375727661747572653D
        2230222069643D227061746832372220643D226D2032322E303233322C31362E
        32353834206320302C30202D352E343736322C352E34383333202D352E373731
        342C352E37373835202D302E323935322C302E32393532202D312E313838382C
        2D302E37323631202D302E393537342C2D302E3935373420302E323331342C2D
        302E3233313320352E373731342C2D352E3737383520352E373731342C2D352E
        37373835207A222F3E0D0A09093C70617468207374796C653D2266696C6C3A23
        6636626234332220696E6B73636170653A636F6E6E6563746F722D6375727661
        747572653D2230222069643D227061746832392220643D226D2032322E303233
        322C31362E32353834206320302C30202D352E3532342C352E35343731202D35
        2E373633342C352E37383634202D302E323339342C302E3233393320302E3331
        31322C302E3639343120302E353032372C302E3530323720302E313931352C2D
        302E3139313520352E373731342C2D352E3737383520352E373731342C2D352E
        37373835207A222F3E0D0A09093C706F6C79676F6E20706F696E74733D223136
        2E363931392C32322E363138312031342E3737372C32302E373033322031332E
        343336362C32332E383330382031332E353634332C32332E3935383520222069
        643D22706F6C79676F6E38383322207374796C653D2266696C6C3A2366666464
        62303B7374726F6B652D6C696E656A6F696E3A6D69746572222F3E0D0A09093C
        706F6C79676F6E20706F696E74733D2231332E343336362C32332E3833303820
        31332E353634332C32332E393538352031342E333638352C32332E3631333820
        31332E373831332C32332E3032363620222069643D22706F6C79676F6E383835
        22207374796C653D2266696C6C3A233635366437383B7374726F6B652D6C696E
        656A6F696E3A6D69746572222F3E0D0A09093C7061746820643D226D2032312E
        303635382C31352E333031206320302C30202D352E353731392C352E35373920
        2D352E373731342C352E37373835202D302E313939352C302E31393935202D30
        2E373130312C2D302E31383335202D302E343436382C2D302E3434363820302E
        323633332C2D302E3236333320352E373731342C2D352E3737383520352E3737
        31342C2D352E37373835207A222069643D22706174683838372220696E6B7363
        6170653A636F6E6E6563746F722D6375727661747572653D223022207374796C
        653D2266696C6C3A23666663653535222F3E0D0A09093C7061746820643D226D
        2032322E303233322C31362E32353834206320302C30202D352E343736322C35
        2E34383333202D352E373731342C352E37373835202D302E323935322C302E32
        393532202D312E313838382C2D302E37323631202D302E393537342C2D302E39
        35373420302E323331342C2D302E3233313320352E373731342C2D352E373738
        3520352E373731342C2D352E37373835207A222069643D227061746838383922
        20696E6B73636170653A636F6E6E6563746F722D6375727661747572653D2230
        22207374796C653D2266696C6C3A23666664353736222F3E0D0A09093C706174
        6820643D226D2032322E303233322C31362E32353834206320302C30202D352E
        3532342C352E35343731202D352E373633342C352E37383634202D302E323339
        342C302E3233393320302E333131322C302E3639343120302E353032372C302E
        3530323720302E313931352C2D302E3139313520352E373731342C2D352E3737
        383520352E373731342C2D352E37373835207A222069643D2270617468383931
        2220696E6B73636170653A636F6E6E6563746F722D6375727661747572653D22
        3022207374796C653D2266696C6C3A23663662623433222F3E0D0A093C2F673E
        0D0A3C2F7376673E0D0A}
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 3
      ParentShowHint = False
      PopupMenu = MainPopupMenu
      ShowHint = True
      TabOrder = 1
    end
    object NroRemesaCtrl: TcxDBIntegerEdit
      Left = 154
      Top = 5
      DataBinding.DataField = 'NroRemesa'
      DataBinding.DataSource = RemesaDataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroRemesaCtrlPropertiesQueryRequest
      Properties.MaxLength = 8
      Properties.MinValue = 1.000000000000000000
      TabOrder = 0
      Width = 60
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 8
      TabStop = False
      Caption = 'N'#186' de remesa'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object ejercicioLabel: TcxLabel
      Left = 337
      Top = 8
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 80
    end
    object EstadoLabel: TcxLabel
      Left = 430
      Top = 8
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 393
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 465
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      851
      34)
    Height = 34
    Width = 851
    object Panel2: TcxGroupBox
      Left = 250
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 348
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
      object emitirButton: TgBitBtn
        Left = 262
        Top = 1
        Width = 85
        Height = 28
        Caption = 'E&mitir'
        Enabled = True
        OptionsImage.ImageIndex = 28
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 3
        OnClick = emitirButtonClick
        GlyphBitmap = gmDocSingle
      end
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 34
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
    Height = 431
    Width = 841
    object Panel1: TcxGroupBox
      Left = 2
      Top = 374
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      DesignSize = (
        837
        55)
      Height = 55
      Width = 837
      object Label23: TcxLabel
        Left = 612
        Top = 32
        TabStop = False
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Importe remesa'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 17
        Width = 93
      end
      object Label6: TcxLabel
        Left = 8
        Top = 8
        TabStop = False
        Caption = 'Cancelaciones'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label8: TcxLabel
        Left = 200
        Top = 8
        TabStop = False
        Caption = 'Impagados'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label10: TcxLabel
        Left = 8
        Top = 32
        TabStop = False
        Caption = 'Pendiente'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label11: TcxLabel
        Left = 199
        Top = 32
        TabStop = False
        Caption = 'Resto'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label9: TcxLabel
        Left = 425
        Top = 8
        TabStop = False
        Caption = '%'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label12: TcxLabel
        Left = 612
        Top = 8
        TabStop = False
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Remesable'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 17
        Width = 64
      end
      object ImporteCancelacionesLabel: TcxLabel
        Left = 96
        Top = 4
        TabStop = False
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
        Transparent = True
        Height = 25
        Width = 95
        AnchorX = 191
        AnchorY = 17
      end
      object ImportePendienteLabel: TcxLabel
        Left = 96
        Top = 28
        TabStop = False
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
        Transparent = True
        Height = 25
        Width = 95
        AnchorX = 191
        AnchorY = 41
      end
      object ImporteImpagadosLabel: TcxLabel
        Left = 276
        Top = 4
        TabStop = False
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
        Transparent = True
        Height = 25
        Width = 95
        AnchorX = 371
        AnchorY = 17
      end
      object ImporteRestoLabel: TcxLabel
        Left = 276
        Top = 28
        TabStop = False
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
        Transparent = True
        Height = 25
        Width = 95
        AnchorX = 371
        AnchorY = 41
      end
      object PorcentajeLabel: TcxLabel
        Left = 375
        Top = 4
        TabStop = False
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
        Transparent = True
        Height = 25
        Width = 41
        AnchorX = 416
        AnchorY = 17
      end
      object ImporteRemesableLabel: TcxLabel
        Left = 709
        Top = 4
        TabStop = False
        Anchors = [akTop, akRight]
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
        Transparent = True
        Height = 25
        Width = 118
        AnchorX = 827
        AnchorY = 17
      end
      object ImporteRemesaLabel: TcxLabel
        Left = 709
        Top = 28
        TabStop = False
        Anchors = [akTop, akRight]
        AutoSize = False
        ParentFont = False
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = -15
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.LookAndFeel.NativeStyle = False
        Style.TextStyle = [fsBold]
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 25
        Width = 118
        AnchorX = 827
        AnchorY = 41
      end
    end
    object Panel3: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        837
        137)
      Height = 137
      Width = 837
      object MostrarCtrl: TcxRadioGroup
        Left = 148
        Top = 86
        Alignment = alCenterCenter
        Properties.DefaultValue = 0
        Properties.ImmediatePost = True
        Properties.Items = <
          item
            Caption = 'de la remesa'
            Value = 0
          end
          item
            Caption = 'de la remesa y pendientes'
            Value = 1
          end>
        Properties.OnEditValueChanged = MostrarCtrlPropertiesEditValueChanged
        ItemIndex = 0
        Style.BorderStyle = ebsNone
        TabOrder = 4
        Height = 46
        Width = 193
      end
      object FechaCtrl: TcxDBDateEdit
        Left = 147
        Top = 4
        DataBinding.DataField = 'Fecha'
        DataBinding.DataSource = RemesaDataSource
        Properties.Required = True
        Properties.OnValidate = FechaCtrlPropertiesValidate
        TabOrder = 0
        Width = 100
      end
      object FechaVtoInicialCtrl: TcxDBDateEdit
        Left = 147
        Top = 58
        DataBinding.DataField = 'FechaVtoInicial'
        DataBinding.DataSource = RemesaDataSource
        Properties.Required = True
        Properties.OnValuePosted = FechaVtoCtrlPropertiesValuePosted
        Properties.OnValidate = FechaVtoCtrlPropertiesValidate
        TabOrder = 2
        Width = 100
      end
      object FechaVtoFinalCtrl: TcxDBDateEdit
        Left = 308
        Top = 58
        DataBinding.DataField = 'FechaVtoFinal'
        DataBinding.DataSource = RemesaDataSource
        Properties.Required = True
        Properties.OnValuePosted = FechaVtoCtrlPropertiesValuePosted
        Properties.OnValidate = FechaVtoCtrlPropertiesValidate
        TabOrder = 3
        Width = 100
      end
      object EntidadCtrl: TcxDBTextEdit
        Left = 147
        Top = 31
        DescriptionLabel = Label7
        DataBinding.DataField = 'SubcuentaEntidad'
        DataBinding.DataSource = RemesaDataSource
        Properties.Required = True
        Properties.OnEnter = EntidadCtrlPropertiesEnter
        Properties.OnQueryRequest = EntidadCtrlPropertiesQueryRequest
        Properties.OnEditRequest = EntidadCtrlPropertiesEditRequest
        Properties.TextEditPad = tpRightZero
        Properties.PadAlways = True
        Properties.OnValidate = EntidadCtrlPropertiesValidate
        TabOrder = 1
        Width = 74
      end
      object FiltroButton: TgBitBtn
        Left = 348
        Top = 104
        Width = 85
        Height = 28
        Caption = 'F&iltro'
        Enabled = True
        OptionsImage.ImageIndex = 12
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 5
        OnClick = FiltroButtonClick
        GlyphBitmap = gmFields
      end
      object IncluirButton: TgBitBtn
        Left = 660
        Top = 104
        Width = 85
        Height = 28
        Hint = 'P'#250'lselo para incluir  en la remesa todos los efectos mostrados.'
        Anchors = [akTop, akRight]
        Caption = '&Incluir'
        Enabled = True
        OptionsImage.ImageIndex = 46
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = IncluirButtonClick
        GlyphBitmap = gmPlus
      end
      object ExcluirButton: TgBitBtn
        Left = 748
        Top = 104
        Width = 85
        Height = 28
        Hint = 'P'#250'lselo para excluir de la remesa a todos los efectos mostrados.'
        Anchors = [akTop, akRight]
        Caption = '&Excluir'
        Enabled = True
        OptionsImage.ImageIndex = 47
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnClick = IncluirButtonClick
        GlyphBitmap = gmMinus
      end
      object Label3: TcxLabel
        Left = 8
        Top = 7
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label1: TcxLabel
        Left = 8
        Top = 62
        TabStop = False
        Caption = 'Vencimientos. Desde el'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label4: TcxLabel
        Left = 8
        Top = 87
        TabStop = False
        Caption = 'Mostrar los efectos'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label5: TcxLabel
        Left = 8
        Top = 34
        Hint = 'C'#243'digo de la subcuenta de cargo o entidad financiera'
        TabStop = False
        Caption = 'Cuenta financiera'
        ParentShowHint = False
        ShowHint = True
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label7: TcxLabel
        Left = 244
        Top = 34
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 607
      end
      object Label2: TcxLabel
        Left = 255
        Top = 62
        TabStop = False
        Caption = 'hasta el'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
    end
    object Grid: TcxGrid
      Left = 2
      Top = 139
      Width = 799
      Height = 235
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      PopupMenu = GridPopupMenu
      TabOrder = 2
      object TableView: TcxGridDBTableView
        Tag = 282627000
        Navigator.Buttons.CustomButtons = <>
        FilterBox.Position = fpTop
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = TableViewCustomDrawCell
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = EfectoCobrarDataSource
        DataController.Filter.OnChanged = TableViewDataControllerFilterChanged
        DataController.KeyFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems.OnSummary = TableViewDataControllerSummaryFooterSummaryItemsSummary
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            FieldName = 'Importe'
            Column = TableViewImporte
          end>
        DataController.Summary.SummaryGroups = <>
        DataController.Summary.OnAfterSummary = TableViewDataControllerSummaryAfterSummary
        OptionsBehavior.IncSearch = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsCustomize.ColumnMoving = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object TableViewIncluido: TcxGridDBColumn
          Caption = 'Inc.'
          DataBinding.FieldName = 'Incluido'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.NullStyle = nssUnchecked
          Visible = False
        end
        object TableViewSerie: TcxGridDBColumn
          Caption = 'Se.'
          DataBinding.FieldName = 'Serie'
        end
        object TableViewNroFactura: TcxGridDBColumn
          Caption = 'N'#186' factura'
          DataBinding.FieldName = 'NroFactura'
        end
        object TableViewNroEfecto: TcxGridDBColumn
          Caption = 'N'#186' ef.'
          DataBinding.FieldName = 'NroEfecto'
          Width = 35
        end
        object TableViewCliente: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'SubcuentaCliente'
        end
        object TableViewNombre: TcxGridDBColumn
          DataBinding.FieldName = 'Nombre'
        end
        object TableViewEntidad: TcxGridDBColumn
          DataBinding.FieldName = 'SubcuentaEntidad'
          Visible = False
        end
        object TableViewFechaLibramiento: TcxGridDBColumn
          Caption = 'Libramiento'
          DataBinding.FieldName = 'FechaLibramiento'
        end
        object TableViewFechaVencimiento: TcxGridDBColumn
          Caption = 'Vencimiento'
          DataBinding.FieldName = 'FechaVencimiento'
        end
        object TableViewImporte: TcxGridDBColumn
          DataBinding.FieldName = 'Importe'
        end
        object TableViewEjercicio: TcxGridDBColumn
          DataBinding.FieldName = 'Ejercicio'
          Visible = False
        end
        object TableViewEjercicioRemesa: TcxGridDBColumn
          DataBinding.FieldName = 'EjercicioRemesa'
          Visible = False
        end
        object TableViewNroRemesa: TcxGridDBColumn
          DataBinding.FieldName = 'NroRemesa'
          Visible = False
        end
        object TableViewImpagado: TcxGridDBColumn
          DataBinding.FieldName = 'Impagado'
          Visible = False
        end
        object TableViewCancelado: TcxGridDBColumn
          DataBinding.FieldName = 'Cancelado'
          Visible = False
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
    object TableViewManager: TGridTableViewController
      Left = 801
      Top = 139
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 3
      Visible = False
      TableView = TableView
      ShiftRecords = True
      UseGridFilterBox = False
      OnUserSelection = TableViewManagerUSerSelection
      Height = 235
      Width = 38
    end
  end
  object RemesaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforePost = RemesaTableBeforePost
    AfterDelete = RemesaTableAfterDelete
    OnNewRecord = RemesaTableNewRecord
    TableName = 'Remesa'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    AutoIncFieldName = 'NroRemesa'
    OnCanEditRecord = RemesaTableCanEditRecord
    OnSetKey = RemesaTableSetKey
    OnRecordChanged = RemesaTableRecordChanged
    OnCloseRecord = RemesaTableCloseRecord
    OnUpdateState = RemesaTableUpdateState
    OnRemotePost = RemesaTableRemotePost
    OnRemoteDelete = RemesaTableRemoteDelete
    RemoteEdit = True
    Left = 656
    Top = 1
  end
  object EfectoCobrarQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    OnCalcFields = EfectoCobrarQueryCalcFields
    Left = 596
    Top = 1
    object EfectoCobrarQueryIncluido: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'Incluido'
      Calculated = True
    end
    object EfectoCobrarQueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object EfectoCobrarQuerySerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object EfectoCobrarQueryNroFactura: TIntegerField
      FieldName = 'NroFactura'
    end
    object EfectoCobrarQueryNroEfecto: TSmallintField
      FieldName = 'NroEfecto'
    end
    object EfectoCobrarQuerySubcuentaCliente: TWideStringField
      FieldName = 'SubcuentaCliente'
      Size = 9
    end
    object EfectoCobrarQueryNombre: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Nombre'
      Size = 40
      Calculated = True
    end
    object EfectoCobrarQuerySubcuentaEntidad: TWideStringField
      FieldName = 'SubcuentaEntidad'
      Required = True
      Size = 9
    end
    object EfectoCobrarQueryFechaLibramiento: TDateField
      FieldName = 'FechaLibramiento'
    end
    object EfectoCobrarQueryFechaVencimiento: TDateField
      FieldName = 'FechaVencimiento'
    end
    object EfectoCobrarQueryImporte: TBCDField
      FieldName = 'Importe'
    end
    object EfectoCobrarQueryEjercicioRemesa: TSmallintField
      FieldName = 'EjercicioRemesa'
    end
    object EfectoCobrarQueryNroRemesa: TIntegerField
      FieldName = 'NroRemesa'
    end
    object EfectoCobrarQueryImpagado: TBooleanField
      FieldName = 'Impagado'
    end
    object EfectoCobrarQueryCancelado: TBooleanField
      FieldName = 'Cancelado'
    end
    object EfectoCobrarQueryFechaCobro: TDateField
      FieldName = 'FechaCobro'
    end
    object EfectoCobrarQueryConcepto: TWideStringField
      FieldName = 'Concepto'
      Size = 30
    end
    object EfectoCobrarQueryImporteCobrado: TBCDField
      FieldName = 'ImporteCobrado'
    end
    object EfectoCobrarQueryConceptoCobro: TWideStringField
      FieldName = 'ConceptoCobro'
      Size = 30
    end
    object EfectoCobrarQueryCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object EfectoCobrarQueryVendedor: TWideStringField
      FieldName = 'Vendedor'
      Size = 2
    end
    object EfectoCobrarQueryGrupoFacturacion: TWideStringField
      FieldName = 'GrupoFacturacion'
      Size = 3
    end
    object EfectoCobrarQueryRevisado: TBooleanField
      FieldName = 'Revisado'
    end
    object EfectoCobrarQueryVolverAEmitir: TBooleanField
      FieldName = 'VolverAEmitir'
    end
    object EfectoCobrarQueryNroEfectoReemitido: TSmallintField
      FieldName = 'NroEfectoReemitido'
    end
    object EfectoCobrarQueryFechaEmision: TDateField
      FieldName = 'FechaEmision'
    end
    object EfectoCobrarQueryFormaDePago: TWideStringField
      FieldName = 'FormaDePago'
      Size = 2
    end
    object EfectoCobrarQueryDiferenciaCambio: TBCDField
      FieldName = 'DiferenciaCambio'
    end
    object EfectoCobrarQueryGenerarEfectoDiferencia: TBooleanField
      FieldName = 'GenerarEfectoDiferencia'
    end
    object EfectoCobrarQuerySubcuentaDiferencia: TWideStringField
      FieldName = 'SubcuentaDiferencia'
      Size = 9
    end
    object EfectoCobrarQueryGastosGestion: TBCDField
      FieldName = 'GastosGestion'
    end
    object EfectoCobrarQueryGastosDevolucion: TBCDField
      FieldName = 'GastosDevolucion'
    end
    object EfectoCobrarQuerySubcuentaGastos: TWideStringField
      FieldName = 'SubcuentaGastos'
      Size = 9
    end
    object EfectoCobrarQueryNroAsientoCartera: TIntegerField
      FieldName = 'NroAsientoCartera'
    end
    object EfectoCobrarQueryNroAsientoCobro: TIntegerField
      FieldName = 'NroAsientoCobro'
    end
    object EfectoCobrarQueryFechaCancelacion: TDateField
      FieldName = 'FechaCancelacion'
    end
    object EfectoCobrarQueryNroAstoCancelacion: TIntegerField
      FieldName = 'NroAstoCancelacion'
    end
    object EfectoCobrarQueryFechaImpagado: TDateField
      FieldName = 'FechaImpagado'
    end
    object EfectoCobrarQueryNroAsientoImpagado: TIntegerField
      FieldName = 'NroAsientoImpagado'
    end
    object EfectoCobrarQueryNroEfectoDiferencia: TSmallintField
      FieldName = 'NroEfectoDiferencia'
    end
    object EfectoCobrarQueryAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
  end
  object FormManager: TgxFormManager
    BackDropForm = True
    Dataset = RemesaTable
    FirstKeyControl = NroRemesaCtrl
    FirstDataControl = FechaCtrl
    Model = fmEditForm
    RelatedDocsMenu = RelacionesPopupMenu
    ShowQueryOption = False
    OnAutoEditChanged = FormManagerAutoEditChanged
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnReportFormRequest = FormManagerReportFormRequest
    OnActivateRelatedDocsButton = FormManagerActivateRelatedDocsButton
    OnQueryGridRequest = FormManagerQueryGridRequest
    OnShowCantEditMessage = FormManagerShowCantEditMessage
    Left = 704
    Top = 2
  end
  object RemesaDataSource: TDataSource
    DataSet = RemesaTable
    Left = 626
    Top = 2
  end
  object EfectoCobrarDataSource: TDataSource
    DataSet = EfectoCobrarQuery
    Enabled = False
    Left = 567
  end
  object EfectoCobrarAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 596
    Top = 40
  end
  object BarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'GridPopupMenu'
      'MainPopupMenu'
      'RelacionesPopupMenu')
    Categories.ItemsVisibles = (
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = False
    Left = 419
    Top = 45
    PixelsPerInch = 96
    object AnotacionImpagadosItem: TdxBarButton
      Caption = '&Anotaci'#243'n de impagados'
      Category = 1
      Visible = ivAlways
      OnClick = AnotacionImpagadosItemClick
    end
    object Cancelarefecto1: TdxBarButton
      Caption = '&Cancelaci'#243'n'
      Category = 1
      Visible = ivAlways
      OnClick = Cancelarefecto1Click
    end
    object EditarEfectoItem: TdxBarButton
      Caption = '&Edici'#243'n'
      Category = 1
      Visible = ivAlways
      OnClick = EditarEfectoItemClick
    end
    object FichaClienteItem: TdxBarButton
      Caption = '&Ficha del cliente'
      Category = 1
      Visible = ivAlways
      OnClick = FichaClienteItemClick
    end
    object AcerptacionItem: TdxBarButton
      Caption = 'Ace&ptaci'#243'n'
      Category = 2
      Visible = ivAlways
      OnClick = AcerptacionItemClick
    end
    object AnotarCobroItem: TdxBarButton
      Caption = 'Co&bro'
      Category = 2
      Visible = ivAlways
      OnClick = AnotarCobroItemClick
    end
    object DescontarItem: TdxBarButton
      Caption = '&Descuento'
      Category = 2
      Visible = ivAlways
      OnClick = DescontarItemClick
    end
    object CancelarRemesaItem: TdxBarButton
      Caption = 'Ca&ncelaci'#243'n'
      Category = 2
      Visible = ivAlways
      OnClick = CancelarRemesaItemClick
    end
    object FichaItem: TdxBarButton
      Caption = 'Ficha de la entidad financiera'
      Category = 3
      Visible = ivAlways
      OnClick = FichaItemClick
    end
    object AsientoAceptacionItem: TdxBarButton
      Caption = 'Asiento de &aceptaci'#243'n'
      Category = 3
      Visible = ivAlways
      OnClick = AsientoAceptacionItemClick
    end
    object AsientoCobroItem: TdxBarButton
      Caption = 'Asiento de &cobro'
      Category = 3
      Visible = ivAlways
      OnClick = AsientoCobroItemClick
    end
    object AsientoDescuentoItem: TdxBarButton
      Caption = 'Asiento de &descuento'
      Category = 3
      Visible = ivAlways
      OnClick = AsientoDescuentoItemClick
    end
    object AsientoCancelacionItem: TdxBarButton
      Caption = 'Asiento de ca&ncelacion'
      Category = 3
      Visible = ivAlways
      OnClick = AsientoCancelacionItemClick
    end
  end
  object GridPopupMenu: TdxBarPopupMenu
    BarManager = BarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemLinks = <
      item
        Visible = True
        ItemName = 'AnotacionImpagadosItem'
      end
      item
        Visible = True
        ItemName = 'Cancelarefecto1'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'EditarEfectoItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'FichaClienteItem'
      end>
    UseOwnFont = True
    Left = 452
    Top = 46
    PixelsPerInch = 96
  end
  object MainPopupMenu: TdxBarPopupMenu
    BarManager = BarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemLinks = <
      item
        Visible = True
        ItemName = 'AcerptacionItem'
      end
      item
        Visible = True
        ItemName = 'AnotarCobroItem'
      end
      item
        Visible = True
        ItemName = 'DescontarItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'CancelarRemesaItem'
      end>
    UseOwnFont = True
    Left = 484
    Top = 46
    PixelsPerInch = 96
  end
  object RelacionesPopupMenu: TdxBarPopupMenu
    BarManager = BarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemLinks = <
      item
        Visible = True
        ItemName = 'FichaItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'AsientoAceptacionItem'
      end
      item
        Visible = True
        ItemName = 'AsientoCobroItem'
      end
      item
        Visible = True
        ItemName = 'AsientoDescuentoItem'
      end
      item
        Visible = True
        ItemName = 'AsientoCancelacionItem'
      end>
    UseOwnFont = True
    Left = 516
    Top = 46
    PixelsPerInch = 96
  end
end
