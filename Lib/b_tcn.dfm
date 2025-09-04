object TecladoFrame: TTecladoFrame
  Left = 0
  Top = 0
  Width = 196
  Height = 285
  Anchors = [akTop, akRight]
  Color = clBtnFace
  Ctl3D = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentBackground = False
  ParentColor = False
  ParentCtl3D = False
  ParentFont = False
  TabOrder = 0
  TabStop = True
  Visible = False
  object Panel2: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    Ctl3D = False
    PanelStyle.Active = True
    ParentCtl3D = False
    Style.LookAndFeel.NativeStyle = True
    Style.TransparentBorder = False
    StyleDisabled.LookAndFeel.NativeStyle = True
    TabOrder = 0
    Transparent = True
    Height = 285
    Width = 196
    object Panel1: TcxGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Transparent = True
      OnMouseDown = Panel1MouseDown
      OnMouseMove = Panel1MouseMove
      OnMouseUp = Panel1MouseUp
      Height = 32
      Width = 190
      object LeftRightButton: TcxButton
        Left = 2
        Top = 0
        Width = 29
        Height = 30
        Hint = 'Desplaza el teclado a izquierda o derecha'
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          617965725F312220783D223070782220793D22307078222077696474683D2231
          3622206865696768743D223136222076696577426F783D223020302031362031
          362220656E61626C652D6261636B67726F756E643D226E657720302030203234
          2032342220786D6C6E733D22687474703A2F2F7777772E77332E6F72672F3230
          30302F7376672220786D6C3A73706163653D227072657365727665223E202009
          3C67207472616E73666F726D3D226D6174726978282D302E3431323933322C20
          302C20302C202D302E3433323930342C2031362E3037333538342C2031332E33
          353130393529222069643D2269636F6E22207374796C653D222220786D6C3A73
          706163653D227072657365727665223E2020202009093C7061746820643D226D
          20322E3137352C31312E3939373520382E363937342C2D382E36393734206320
          302E323333332C2D302E3233333320302E363135322C2D302E3233333320302E
          383438352C30206C20312E323732382C312E32373238206320302E323333332C
          302E3233333320302E323333332C302E3635323720302C302E383836204C2037
          2E343930312C313120682031332E34323933206320302E33332C3020302E3538
          30362C302E3139353120302E353830362C302E35323531207620312E38204320
          32312E352C31332E363535312032312E323439342C31342032302E393139342C
          3134204820372E34393637206C20352E3439372C352E34353936206320302E32
          3333332C302E3233333320302E323333332C302E3539363520302C302E383239
          38206C202D312E323732382C312E323633342063202D302E323333332C302E32
          333333202D302E363135322C302E32323837202D302E383438352C2D302E3030
          3437204C20332E343437382C31342E3132313120322E3137352C31322E383437
          312063202D302E323333332C2D302E32333333202D302E323333332C2D302E36
          31363320302C2D302E38343936207A222069643D227061746832373930362220
          7374796C653D2266696C6C3A23336261656461222F3E0D0A093C2F673E0D0A09
          3C67207472616E73666F726D3D226D617472697828302E3431323933322C2030
          2C20302C20302E3433323930342C202D302E3031373137332C20322E35313636
          393129222069643D22672D3122207374796C653D222220786D6C3A7370616365
          3D227072657365727665223E2020202009093C7061746820643D226D20322E31
          37352C31312E3939373520382E363937342C2D382E36393734206320302E3233
          33332C2D302E3233333320302E363135322C2D302E3233333320302E38343835
          2C30206C20312E323732382C312E32373238206320302E323333332C302E3233
          333320302E323333332C302E3635323720302C302E383836204C20372E343930
          312C313120682031332E34323933206320302E33332C3020302E353830362C30
          2E3139353120302E353830362C302E35323531207620312E3820432032312E35
          2C31332E363535312032312E323439342C31342032302E393139342C31342048
          20372E34393637206C20352E3439372C352E34353936206320302E323333332C
          302E3233333320302E323333332C302E3539363520302C302E38323938206C20
          2D312E323732382C312E323633342063202D302E323333332C302E3233333320
          2D302E363135322C302E32323837202D302E383438352C2D302E30303437204C
          20332E343437382C31342E3132313120322E3137352C31322E38343731206320
          2D302E323333332C2D302E32333333202D302E323333332C2D302E3631363320
          302C2D302E38343936207A222069643D22706174682D3122207374796C653D22
          66696C6C3A23336261656461222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
        OptionsImage.Spacing = 0
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 0
        OnClick = LeftRightButtonClick
      end
      object UpDownButton: TcxButton
        Left = 33
        Top = 0
        Width = 29
        Height = 30
        Hint = 'Desplaza el teclado arriba o abajo'
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          617965725F312220783D223070782220793D22307078222077696474683D2231
          3622206865696768743D223136222076696577426F783D223020302031362031
          362220656E61626C652D6261636B67726F756E643D226E657720302030203234
          2032342220786D6C6E733D22687474703A2F2F7777772E77332E6F72672F3230
          30302F7376672220786D6C3A73706163653D227072657365727665223E202009
          3C67207472616E73666F726D3D226D617472697828302C202D302E3431323933
          322C20302E3433323930342C20302C20322E3631313030332C2031352E393739
          32373129222069643D2269636F6E22207374796C653D222220786D6C3A737061
          63653D227072657365727665223E2020202009093C7061746820643D226D2032
          2E3137352C31312E3939373520382E363937342C2D382E36393734206320302E
          323333332C2D302E3233333320302E363135322C2D302E3233333320302E3834
          38352C30206C20312E323732382C312E32373238206320302E323333332C302E
          3233333320302E323333332C302E3635323720302C302E383836204C20372E34
          3930312C313120682031332E34323933206320302E33332C3020302E35383036
          2C302E3139353120302E353830362C302E35323531207620312E382043203231
          2E352C31332E363535312032312E323439342C31342032302E393139342C3134
          204820372E34393637206C20352E3439372C352E34353936206320302E323333
          332C302E3233333320302E323333332C302E3539363520302C302E3832393820
          6C202D312E323732382C312E323633342063202D302E323333332C302E323333
          33202D302E363135322C302E32323837202D302E383438352C2D302E30303437
          204C20332E343437382C31342E3132313120322E3137352C31322E3834373120
          63202D302E323333332C2D302E32333333202D302E323333332C2D302E363136
          3320302C2D302E38343936207A222069643D2270617468323739303622207374
          796C653D2266696C6C3A23336261656461222F3E0D0A093C2F673E0D0A093C67
          207472616E73666F726D3D226D617472697828302C20302E3431323933322C20
          2D302E3433323930342C20302C2031332E3434353430382C202D302E31313134
          383529222069643D22672D3122207374796C653D222220786D6C3A7370616365
          3D227072657365727665223E2020202009093C7061746820643D226D20322E31
          37352C31312E3939373520382E363937342C2D382E36393734206320302E3233
          33332C2D302E3233333320302E363135322C2D302E3233333320302E38343835
          2C30206C20312E323732382C312E32373238206320302E323333332C302E3233
          333320302E323333332C302E3635323720302C302E383836204C20372E343930
          312C313120682031332E34323933206320302E33332C3020302E353830362C30
          2E3139353120302E353830362C302E35323531207620312E3820432032312E35
          2C31332E363535312032312E323439342C31342032302E393139342C31342048
          20372E34393637206C20352E3439372C352E34353936206320302E323333332C
          302E3233333320302E323333332C302E3539363520302C302E38323938206C20
          2D312E323732382C312E323633342063202D302E323333332C302E3233333320
          2D302E363135322C302E32323837202D302E383438352C2D302E30303437204C
          20332E343437382C31342E3132313120322E3137352C31322E38343731206320
          2D302E323333332C2D302E32333333202D302E323333332C2D302E3631363320
          302C2D302E38343936207A222069643D22706174682D3122207374796C653D22
          66696C6C3A23336261656461222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
        OptionsImage.Spacing = 0
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 1
        OnClick = UpDownButtonClick
      end
      object ModoButton: TcxButton
        Left = 67
        Top = 0
        Width = 29
        Height = 30
        Hint = 'Cambio de modo (Teclado num'#233'rico / Calculadora )'
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
          3D227072657365727665223E262331303B2020093C672069643D2269636F6E22
          20786D6C3A73706163653D227072657365727665223E2020202009093C706174
          6820643D224D31392E3732352C323348332E32373543322E353730382C32332C
          322C32322E343239322C322C32312E37323556322E32373543322C312E353730
          382C322E353730382C312C332E3237352C316831362E343563302E373034322C
          302C312E3237352C302E353730382C312E3237352C312E3237357631392E3435
          4332312C32322E343239322C32302E343239322C32332C31392E3732352C3233
          7A222066696C6C3D2223384539343943222F3E0D0A09093C7061746820643D22
          4D31382E343337352C3948342E3536323543342E323531382C392C342C382E37
          3438322C342C382E34333735762D342E38373543342C332E323531382C342E32
          3531382C332C342E353632352C336831332E38373563302E333130372C302C30
          2E353632352C302E323531382C302E353632352C302E3536323576342E383735
          4331392C382E373438322C31382E373438322C392C31382E343337352C397A22
          2066696C6C3D2223374445324337222F3E0D0A09093C7061746820643D224D31
          302E3237352C3135682D352E3535632D302E343030342C302C2D302E3732352C
          2D302E333234362C2D302E3732352C2D302E373235762D332E353563302C2D30
          2E343030342C302E333234362C2D302E3732352C302E3732352C2D302E373235
          68352E353563302E343030342C302C302E3732352C302E333234362C302E3732
          352C302E37323576332E35354331312C31342E363735342C31302E363735342C
          31352C31302E3237352C31357A4D31312C32302E323735762D332E353563302C
          2D302E343030342C2D302E333234362C2D302E3732352C2D302E3732352C2D30
          2E373235682D352E3535632D302E343030342C302C2D302E3732352C302E3332
          34362C2D302E3732352C302E37323576332E353563302C302E343030342C302E
          333234362C302E3732352C302E3732352C302E37323568352E35354331302E36
          3735342C32312C31312C32302E363735342C31312C32302E3237357A4D31392C
          31342E323735762D332E353563302C2D302E343030342C2D302E333234362C2D
          302E3732352C2D302E3732352C2D302E373235682D352E3535632D302E343030
          342C302C2D302E3732352C302E333234362C2D302E3732352C302E3732357633
          2E353563302C302E343030342C302E333234362C302E3732352C302E3732352C
          302E37323568352E35354331382E363735342C31352C31392C31342E36373534
          2C31392C31342E3237357A222066696C6C3D2223453645394545222F3E0D0A09
          093C7061746820643D224D31382E3237352C3231682D352E3535632D302E3430
          30342C302C2D302E3732352C2D302E333234362C2D302E3732352C2D302E3732
          35762D332E353563302C2D302E343030342C302E333234362C2D302E3732352C
          302E3732352C2D302E37323568352E353563302E343030342C302C302E373235
          2C302E333234362C302E3732352C302E37323576332E35354331392C32302E36
          3735342C31382E363735342C32312C31382E3237352C32317A222066696C6C3D
          2223463642423433222F3E0D0A09093C7061746820643D224D31372E39363631
          2C352E3938313263302C312E313630392C2D302E343730312C312E393637372C
          2D312E343237382C312E39363737632D302E393735322C302C2D312E34303437
          2C2D302E383736352C2D312E343130352C2D312E3934343563302C2D312E3039
          37312C302E343538362C2D312E393536312C312E343333372C2D312E39353631
          4331372E353635362C342E303438332C31372E393636312C342E393437392C31
          372E393636312C352E393831327A4D31362E303130312C362E3030343463302C
          302E383634382C302E3230392C312E3237372C302E353435362C312E32373763
          302E333432352C302C302E353238322C2D302E343239352C302E353238322C2D
          312E3238383663302C2D302E383335382C2D302E31382C2D312E3237372C2D30
          2E3533342C2D312E3237374331362E323330372C342E373135382C31362E3031
          30312C352E313232312C31362E303130312C362E303034347A4D392E332C3132
          4838762D312E33483776312E3348352E37763168312E3376312E336831762D31
          2E3368312E335631327A4D392E332C313848352E37763168332E365631387A4D
          31372E313236332C31332E343139324C31362E323037312C31322E356C302E39
          3139322C2D302E393139326C2D302E373037312C2D302E373037314C31352E35
          2C31312E373932396C2D302E393139322C2D302E393139326C2D302E37303731
          2C302E373037316C302E393139322C302E393139326C2D302E393139322C302E
          393139326C302E373037312C302E373037316C302E393139322C2D302E393139
          326C302E393139322C302E393139324C31372E313236332C31332E343139327A
          222066696C6C3D2223343334413534222F3E0D0A09093C7061746820643D224D
          31392E3737352C31682D332E373839384C392E383636372C32334831392E3863
          302E363632372C302C312E322C2D302E353337332C312E322C2D312E3256322E
          3232354332312C312E353438352C32302E343531352C312C31392E3737352C31
          7A222066696C6C3D222332343238324422206F7061636974793D22302E31222F
          3E0D0A09093C7061746820643D224D31372E332C3138682D332E36762D316833
          2E365631387A4D31372E332C3139682D332E36763168332E365631397A222066
          696C6C3D2223464646464646222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
        OptionsImage.Spacing = 0
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 2
        OnClick = ModoButtonClick
      end
      object CloseMDIFormButton: TcxButton
        Left = 159
        Top = 0
        Width = 29
        Height = 30
        Hint = 'Cierra el teclado num'#233'rico'
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
          3D227072657365727665223E262331303B2020093C672069643D2269636F6E22
          20786D6C3A73706163653D227072657365727665223E2020202009093C706174
          6820643D224D31392E333533392C31372E323332364C31342E313231332C3132
          6C352E323332362C2D352E3233323663302E323333332C2D302E323333332C30
          2E323333332C2D302E363135322C302C2D302E383438356C2D312E323732382C
          2D312E32373238632D302E323333332C2D302E323333332C2D302E363135322C
          2D302E323333332C2D302E383438352C304C31322C392E383738374C362E3736
          37342C342E36343631632D302E323333332C2D302E323333332C2D302E363135
          322C2D302E323333332C2D302E383438352C304C342E363436312C352E393138
          39632D302E323333332C302E323333332C2D302E323333332C302E363135322C
          302C302E383438354C392E383738372C31326C2D352E323332362C352E323332
          36632D302E323333332C302E323333332C2D302E323333332C302E363135322C
          302C302E383438356C312E323732382C312E3237323863302E323333332C302E
          323333332C302E363135322C302E323333332C302E383438352C304C31322C31
          342E313231336C352E323332362C352E3233323663302E323333332C302E3233
          33332C302E363135322C302E323333332C302E383438352C306C312E32373238
          2C2D312E323732384331392E353837332C31372E383437382C31392E35383733
          2C31372E343635392C31392E333533392C31372E323332367A222066696C6C3D
          2223444234343533222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
        OptionsImage.Spacing = 0
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 3
        OnClick = CloseMDIFormButtonClick
      end
    end
    object PageControl: TcxPageControl
      AlignWithMargins = True
      Left = 3
      Top = 41
      Width = 190
      Height = 241
      Align = alClient
      TabOrder = 1
      Properties.ActivePage = cxTabSheet1
      Properties.CustomButtons.Buttons = <>
      Properties.HideTabs = True
      Properties.Options = [pcoGradientClientArea, pcoRedrawOnResize]
      Properties.Style = 5
      LookAndFeel.NativeStyle = True
      ClientRectBottom = 241
      ClientRectRight = 190
      ClientRectTop = 0
      object cxTabSheet1: TcxTabSheet
        Caption = 'cxTabSheet1'
        Color = clBtnFace
        ImageIndex = 0
        ParentColor = False
        ExplicitWidth = 0
        ExplicitHeight = 0
        object SpeedButton4: TcxButton
          Tag = 48
          Left = 5
          Top = 191
          Width = 44
          Height = 45
          Caption = '0  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          OptionsImage.Spacing = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 0
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = NumericButtonClick
        end
        object SpeedButton5: TcxButton
          Tag = 148
          Left = 140
          Top = 7
          Width = 44
          Height = 45
          Caption = #172' '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          OptionsImage.Spacing = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 1
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Symbol'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton5Click
        end
        object SpeedButton6: TcxButton
          Tag = 44
          Left = 50
          Top = 191
          Width = 44
          Height = 45
          Caption = ',  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          OptionsImage.Spacing = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 2
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton6Click
        end
        object SpeedButton7: TcxButton
          Tag = 49
          Left = 5
          Top = 145
          Width = 44
          Height = 45
          Caption = '1  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 3
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = NumericButtonClick
        end
        object SpeedButton8: TcxButton
          Tag = 50
          Left = 50
          Top = 145
          Width = 44
          Height = 45
          Caption = '2  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 4
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = NumericButtonClick
        end
        object SpeedButton9: TcxButton
          Tag = 51
          Left = 95
          Top = 145
          Width = 44
          Height = 45
          Caption = '3  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 5
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = NumericButtonClick
        end
        object SpeedButton10: TcxButton
          Tag = 52
          Left = 5
          Top = 99
          Width = 44
          Height = 45
          Caption = '4  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          OptionsImage.Spacing = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 6
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = NumericButtonClick
        end
        object SpeedButton11: TcxButton
          Tag = 53
          Left = 50
          Top = 99
          Width = 44
          Height = 45
          Caption = '5  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 7
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = NumericButtonClick
        end
        object SpeedButton12: TcxButton
          Tag = 54
          Left = 95
          Top = 99
          Width = 44
          Height = 45
          Caption = '6  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 8
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = NumericButtonClick
        end
        object SpeedButton27: TcxButton
          Tag = 55
          Left = 5
          Top = 53
          Width = 44
          Height = 45
          Caption = '7  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 9
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = NumericButtonClick
        end
        object SpeedButton31: TcxButton
          Tag = 56
          Left = 50
          Top = 53
          Width = 44
          Height = 45
          Caption = '8  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 10
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = NumericButtonClick
        end
        object SpeedButton32: TcxButton
          Tag = 57
          Left = 95
          Top = 53
          Width = 44
          Height = 45
          Caption = '9  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 11
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = NumericButtonClick
        end
        object SpeedButton35: TcxButton
          Left = 5
          Top = 7
          Width = 44
          Height = 45
          Caption = 'Esc   '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 12
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          OnClick = SpeedButton35Click
        end
        object SpeedButton36: TcxButton
          Left = 50
          Top = 7
          Width = 44
          Height = 45
          Caption = 'Supr'
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          OptionsImage.Spacing = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 13
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          OnClick = SpeedButton36Click
        end
        object SpeedButton37: TcxButton
          Left = 95
          Top = 191
          Width = 89
          Height = 45
          Caption = '       <|'
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 5
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 14
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton37Click
        end
        object SpeedButton2: TcxButton
          Left = 140
          Top = 145
          Width = 44
          Height = 45
          Caption = '|'#172' '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 5
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 15
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Symbol'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton2Click
        end
        object SpeedButton40: TcxButton
          Left = 140
          Top = 53
          Width = 44
          Height = 45
          Caption = #173
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 6
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 16
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Symbol'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton40Click
        end
        object SpeedButton41: TcxButton
          Left = 140
          Top = 99
          Width = 44
          Height = 45
          Caption = #175
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 9
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 17
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Symbol'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton41Click
        end
        object SpeedButton3: TcxButton
          Left = 95
          Top = 7
          Width = 44
          Height = 45
          Caption = '-     '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          OptionsImage.Spacing = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 18
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton3Click
        end
      end
      object cxTabSheet2: TcxTabSheet
        Caption = 'cxTabSheet2'
        ImageIndex = 1
        DesignSize = (
          190
          241)
        object Shape1: TShape
          Left = 5
          Top = 2
          Width = 182
          Height = 30
          Brush.Color = clBlack
          Pen.Style = psClear
        end
        object SpeedButton13: TcxButton
          Tag = 48
          Left = 5
          Top = 225
          Width = 44
          Height = 45
          Caption = '0  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          OptionsImage.Spacing = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 0
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton22Click
        end
        object SpeedButton14: TcxButton
          Tag = 148
          Left = 97
          Top = 225
          Width = 44
          Height = 45
          Caption = #172'  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          OptionsImage.Spacing = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 1
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Symbol'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton14Click
        end
        object SpeedButton15: TcxButton
          Tag = 44
          Left = 51
          Top = 225
          Width = 44
          Height = 45
          Caption = ',  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          OptionsImage.Spacing = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 2
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton22Click
        end
        object SpeedButton16: TcxButton
          Tag = 49
          Left = 5
          Top = 179
          Width = 44
          Height = 45
          Caption = '1  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 3
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton22Click
        end
        object SpeedButton17: TcxButton
          Tag = 50
          Left = 51
          Top = 179
          Width = 44
          Height = 45
          Caption = '2  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 4
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton22Click
        end
        object SpeedButton18: TcxButton
          Tag = 51
          Left = 97
          Top = 179
          Width = 44
          Height = 45
          Caption = '3  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 5
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton22Click
        end
        object SpeedButton19: TcxButton
          Tag = 52
          Left = 5
          Top = 132
          Width = 44
          Height = 45
          Caption = '4  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          OptionsImage.Spacing = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 6
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton22Click
        end
        object SpeedButton20: TcxButton
          Tag = 53
          Left = 51
          Top = 132
          Width = 44
          Height = 45
          Caption = '5  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 7
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton22Click
        end
        object SpeedButton21: TcxButton
          Tag = 54
          Left = 97
          Top = 132
          Width = 44
          Height = 45
          Caption = '6  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 8
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton22Click
        end
        object SpeedButton22: TcxButton
          Tag = 55
          Left = 5
          Top = 85
          Width = 44
          Height = 45
          Caption = '7  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 9
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton22Click
        end
        object SpeedButton23: TcxButton
          Tag = 56
          Left = 51
          Top = 85
          Width = 44
          Height = 45
          Caption = '8  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 10
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton22Click
        end
        object SpeedButton24: TcxButton
          Tag = 57
          Left = 97
          Top = 85
          Width = 44
          Height = 45
          Caption = '9  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 11
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton22Click
        end
        object SpeedButton25: TcxButton
          Left = 143
          Top = 85
          Width = 44
          Height = 45
          Caption = '+   '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 12
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton25Click
        end
        object SpeedButton26: TcxButton
          Tag = 15
          Left = 143
          Top = 179
          Width = 44
          Height = 91
          Caption = 'Intro'
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 4
          OptionsImage.Spacing = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 13
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnClick = SpeedButton26Click
        end
        object ClearButton: TcxButton
          Left = 5
          Top = 39
          Width = 44
          Height = 45
          Caption = 'C   '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 14
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = ClearButtonClick
        end
        object SpeedButton28: TcxButton
          Left = 51
          Top = 39
          Width = 44
          Height = 45
          Caption = '/  '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          OptionsImage.Spacing = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 15
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton28Click
        end
        object SpeedButton29: TcxButton
          Left = 97
          Top = 39
          Width = 44
          Height = 45
          Caption = '*   '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 5
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 16
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton29Click
        end
        object SpeedButton30: TcxButton
          Left = 143
          Top = 39
          Width = 44
          Height = 45
          Caption = '-   '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          OptionsImage.Spacing = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 17
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton30Click
        end
        object SpeedButton1: TcxButton
          Left = 143
          Top = 132
          Width = 44
          Height = 45
          Caption = '=   '
          OptionsImage.Layout = blGlyphTop
          OptionsImage.Margin = 0
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 18
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = ResultadoClick
        end
        object ValorLabel: TcxLabel
          Left = 13
          Top = 7
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          ParentFont = False
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clLime
          Style.Font.Height = -15
          Style.Font.Name = 'Tahoma'
          Style.Font.Style = [fsBold]
          Style.TextColor = clLime
          Style.TransparentBorder = False
          Style.IsFontAssigned = True
          Properties.Alignment.Horz = taRightJustify
          Transparent = True
          Height = 18
          Width = 166
          AnchorX = 179
        end
      end
    end
  end
end
