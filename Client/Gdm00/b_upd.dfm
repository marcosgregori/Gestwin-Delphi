object BoxUpdForm: TBoxUpdForm
  Left = 501
  Top = 313
  HelpType = htKeyword
  HelpKeyword = 'b_upd'
  HelpContext = 224
  BorderStyle = bsDialog
  Caption = 'CONTROL AUTOM'#193'TICO DE VERSIONES'
  ClientHeight = 321
  ClientWidth = 558
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  HelpFile = 'hs00'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  TextHeight = 17
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 285
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    DesignSize = (
      558
      36)
    Height = 36
    Width = 558
    object Panel3: TcxGroupBox
      Left = 190
      Top = 2
      Anchors = [akTop]
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 32
      Width = 177
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 85
        Height = 28
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
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
        OnClick = OkButtonClick
        GlyphBitmap = gmOk
      end
      object CerrarButton: TgBitBtn
        AlignWithMargins = True
        Left = 90
        Top = 2
        Width = 85
        Height = 28
        Margins.Top = 0
        Margins.Right = 0
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
        OnClick = CerrarButtonClick
        GlyphBitmap = gmClose
      end
    end
  end
  object Panel2: TgxEditPanel
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
    TabOrder = 1
    PanelKind = epInputPanel
    Height = 280
    Width = 548
    object Image1: TcxImage
      Left = 9
      Top = 13
      ParentColor = True
      Picture.Data = {
        0B546478535647496D6167653C3F786D6C2076657273696F6E3D22312E302220
        656E636F64696E673D225554462D38223F3E0D0A3C7376672076657273696F6E
        3D22312E31222069643D224C617965725F312220786D6C6E733D22687474703A
        2F2F7777772E77332E6F72672F323030302F7376672220786D6C6E733A786C69
        6E6B3D22687474703A2F2F7777772E77332E6F72672F313939392F786C696E6B
        2220783D223070782220793D22307078222077696474683D2232347078222068
        65696768743D2232347078222076696577426F783D2230203020323420323422
        20656E61626C652D6261636B67726F756E643D226E6577203020302032342032
        342220786D6C3A73706163653D227072657365727665223E262331303B202026
        23393B2623393B2623393B2623393B2623393B2623393B2623393B3C67206964
        3D2269636F6E2220786D6C3A73706163653D227072657365727665223E202020
        202623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
        3B2623393B2623393B2623393B2623393B2623393B2623393B3C6720786D6C3A
        73706163653D227072657365727665223E262331333B262331303B3C70617468
        20643D224D31302E303137342C3848322E32632D302E36362C302C2D312E322C
        302E35342C2D312E322C312E3276312E3868392E303237334331302E30323437
        2C31302E313938352C31302E303231312C392E313136362C31302E303137342C
        387A222066696C6C3D2223344238394443222F3E0D0A3C7061746820643D224D
        31322E333537362C31342E39373438632D312E343837392C2D302E373332342C
        2D322E333236322C2D312E3637372C2D322E3332362C2D322E3635393663302C
        2D302E303131362C2D302E303031372C2D302E353238332C2D302E303034332C
        2D312E333135324832763131683131762D362E373433394331322E37382C3135
        2E313638382C31322E353634322C31352E303736352C31322E333537362C3134
        2E393734387A222066696C6C3D2223463646374642222F3E0D0A3C7061746820
        643D224D31332C31352E32353631563138682D33762D3368322E34313235632D
        302E3031382C2D302E303038372C2D302E3033372C2D302E303136342C2D302E
        303534392C2D302E30323532632D302E353937392C2D302E323934332C2D312E
        303838382C2D302E363233332C2D312E343634362C2D302E3937343848313076
        2D33483976334836762D33483576334832762D3348317631302E3863302C302E
        36362C302E35342C312E322C312E322C312E326831302E3663302E36362C302C
        312E322C2D302E35342C312E322C2D312E32762D362E323037364331332E3635
        35362C31352E343936342C31332E333231362C31352E333833392C31332C3135
        2E323536317A4D352C32324832762D3368335632327A4D352C31384832762D33
        68335631387A4D392C32324836762D3368335632327A4D392C31384836762D33
        68335631387A4D31332C3232682D33762D3368335632327A222066696C6C3D22
        23414142324244222F3E0D0A3C7061746820643D224D31322E333537362C3134
        2E39373438632D312E343234372C2D302E373031332C2D322E323531372C2D31
        2E353937322C2D322E333139342C2D322E353334384C372E363838352C323348
        31322E3863302E36362C302C312E322C2D302E35342C312E322C2D312E32762D
        362E323037364331332E34322C31352E343330382C31322E383636312C31352E
        323235322C31322E333537362C31342E393734387A222066696C6C3D22233233
        3146323022206F7061636974793D22302E3035222F3E0D0A09093C2F673E0D0A
        3C6720786D6C3A73706163653D227072657365727665223E262331333B262331
        303B3C7061746820643D224D32332E303338332C322E3639313163302C2D312E
        303933372C2D322E373735392C2D312E363931312C2D362E3034392C2D312E36
        393131632D332E3237332C302C2D352E393436342C302E353937342C2D352E39
        3436342C312E3639313163302C302E303232382C2D302E303031372C302E3034
        35332C302E303030362C302E30363736632D302E303031322C2D302E3030322C
        2D302E303034342C2D302E303033392C2D302E303035352C2D302E3030353863
        302C302E313030382C302E303132372C392E343836362C302E303132362C392E
        353632364331312E303530342C31332E343335332C31332E373239382C31352C
        31372E303032392C313563302E303233382C302C302E303937312C302E303031
        312C302E303937312C302E30303156342E3434374332302E322C342E34333734
        2C32332E303338332C332E373736382C32332E303338332C322E363931317A22
        2066696C6C2D72756C653D226576656E6F6464222066696C6C3D222346464345
        3535222F3E0D0A3C7061746820643D224D32332C322E37373335632D302E342C
        302E383731382C2D322E393232392C312E343833322C2D352E3839372C312E34
        383332632D302E303231332C302C2D302E3030332C2D302E303030322C2D302E
        3030332C2D302E303030337631302E37343563332E312C2D302E303031312C35
        2E392C2D312E353139372C352E392C2D322E373037324332332C31322E313832
        352C32332C322E393435382C32332C322E373733357A222066696C6C2D72756C
        653D226576656E6F6464222066696C6C3D2223463642423433222F3E0D0A3C70
        61746820643D224D31372C31312E3430363863322E393734322C302C352E3631
        2C2D312E303634332C352E393839312C2D312E3933363163302E303337342C2D
        302E303835392C2D302E3030312C302E373036352C2D302E3030312C302E3739
        3831632D302E353536342C302E373931312C2D322E373338382C312E37383835
        2C2D362E303131392C312E37383835632D332E3237332C302C2D352E33353138
        2C2D312E313031392C2D352E393236342C2D312E383933632D302E3032312C2D
        302E303336372C2D302E303137372C2D302E363435342C302E303131392C2D30
        2E373135354331312E353630322C31302E323939362C31332E3937352C31312E
        343036382C31372C31312E343036387A4D31372C372E3832393463322E393734
        322C302C352E36312C2D312E303035362C352E393839312C2D312E3735363163
        302E303337342C2D302E3037342C2D302E3030312C302E373031372C2D302E30
        30312C302E37383035632D302E353536342C302E363831312C2D322E37333838
        2C312E363236312C2D362E303131392C312E36323631632D332E3237332C302C
        2D352E333531382C2D302E3934352C2D352E393236342C2D312E36323631632D
        302E3032312C2D302E303331352C2D302E303137372C2D302E363535312C302E
        303131392C2D302E373135354331312E353630322C362E383730392C31332E39
        37352C372E383239342C31372C372E383239347A4D31372C342E313934396332
        2E393734322C302C352E36312C2D302E373139342C352E393839312C2D312E34
        33383963302E303337342C2D302E303730392C2D302E3030312C302E36373237
        2C2D302E3030312C302E37343833632D302E353536342C302E363532392C2D32
        2E373338382C312E333134322C2D362E303131392C312E33313432632D332E32
        37332C302C2D352E333531382C2D302E373233362C2D352E393236342C2D312E
        33373636632D302E3032312C2D302E303330322C2D302E303137372C2D302E36
        32382C302E303131392C2D302E363835394331312E353630322C332E34353832
        2C31332E3937352C342E313934392C31372C342E313934397A222066696C6C2D
        72756C653D226576656E6F6464222066696C6C3D222343313846333622206F70
        61636974793D22302E37222F3E0D0A09093C2F673E0D0A3C7061746820643D22
        4D32322E342C31382E3630393463302C2D302E303838352C2D302E303334332C
        2D302E313731352C2D302E303936362C2D302E323333386C2D322E343431342C
        2D322E34343937632D302E303632332C2D302E303632342C2D302E313435342C
        2D302E303936372C2D302E3233342C2D302E30393637632D302E303838352C30
        2C2D302E313731362C302E303334332C2D302E323333392C302E303936366C2D
        302E343839342C302E343839346C2D312E393031392C312E39363135632D302E
        303631322C302E303631322C2D302E303935352C302E313434322C2D302E3039
        35352C302E3233323863302C302E303838352C302E303334332C302E31373135
        2C302E303936362C302E323333386C302E343839342C302E3438393463302E30
        3631322C302E303631322C302E313338362C302E303939352C302E323137362C
        302E3130373663302E303839372C302E303039322C302E313939332C2D302E30
        3230382C302E3236332C2D302E303834364C31392C31382E3330393376312E30
        33323563302C312E3730342C2D302E353836372C322E323538322C2D322E3137
        36392C322E323538324831352E343834632D302E313532342C302C2D302E3238
        342C302E313034382C2D302E3238342C302E3530343376302E3437323563302C
        302E323934372C302E303630372C302E343233322C302E323739342C302E3432
        333268312E333433384331392E313633332C32332C32302E342C32312E373833
        312C32302E342C31392E33343138762D312E303335376C302E393936312C312E
        3034383663302E303634382C302E303634382C302E313334362C302E30393438
        2C302E323230332C302E3038353463302E303735342C2D302E303038322C302E
        313431382C2D302E303435342C302E323033382C2D302E313037356C302E3438
        36332C2D302E343839344332322E333638392C31382E3738312C32322E342C31
        382E363937392C32322E342C31382E363039347A222066696C6C3D2223353336
        383830222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
      Properties.FitMode = ifmProportionalStretch
      Properties.ShowFocusRect = False
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Transparent = True
      Height = 50
      Width = 50
    end
    object PageControl: TcxPageControl
      Left = 60
      Top = 2
      Width = 482
      Height = 264
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      Properties.HideTabs = True
      Properties.Options = [pcoGradientClientArea, pcoRedrawOnResize]
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = False
      ClientRectBottom = 263
      ClientRectLeft = 1
      ClientRectRight = 481
      ClientRectTop = 1
      object TabSheet1: TcxTabSheet
        TabVisible = False
        object cxGroupBox1: TcxGroupBox
          Left = 14
          Top = 53
          Alignment = alCenterCenter
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 91
          Width = 453
          object cxLabel1: TcxLabel
            AlignWithMargins = True
            Left = 0
            Top = 38
            Margins.Left = 8
            Margins.Top = 0
            Margins.Bottom = 0
            TabStop = False
            Caption = 
              'No realice este proceso si no ha efectuado una o m'#225's COPIAS DE S' +
              'EGURIDAD de sus datos. Tampoco deber'#237'a iniciarlo si sospecha que' +
              ' alguno de sus ficheros est'#225' en mal estado.'
            Style.TextStyle = []
            Properties.WordWrap = True
            Transparent = True
            Width = 453
          end
          object cxLabel2: TcxLabel
            AlignWithMargins = True
            Left = 0
            Top = 2
            Margins.Left = 8
            Margins.Top = 0
            Margins.Bottom = 0
            TabStop = False
            Caption = 
              'El CONTROL AUTOMATICO DE VERSIONES actualiza todos los ficheros ' +
              'de la empresa en curso que lo requieran.'
            Style.TextStyle = []
            Properties.WordWrap = True
            Transparent = True
            Width = 448
          end
        end
        object TitleLabel: TcxLabel
          Left = 14
          Top = 13
          TabStop = False
          AutoSize = False
          Caption = 
            'Se ha detectado la presencia de un fichero que pertenece (probab' +
            'lemente) a una VERSION ANTERIOR del producto.'
          Style.TextColor = clGreen
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.WordWrap = True
          Transparent = True
          Height = 42
          Width = 449
        end
        object TodasLasEmpresasCtrl: TcxCheckBox
          Left = 24
          Top = 160
          Caption = 'Actualizar todas las Empresas existentes'
          ParentShowHint = False
          Properties.Alignment = taLeftJustify
          ShowHint = False
          State = cbsChecked
          TabOrder = 2
          Transparent = True
        end
        object cxLabel3: TcxLabel
          Left = 45
          Top = 186
          TabStop = False
          AutoSize = False
          Caption = 
            'NO DEBE HABER NINGUN USUARIO trabajando en NINGUNA de las Empres' +
            'as a actualizar.'
          Style.TextColor = clRed
          Properties.Alignment.Horz = taLeftJustify
          Properties.WordWrap = True
          Transparent = True
          Height = 38
          Width = 422
        end
      end
      object TabSheet2: TcxTabSheet
        TabVisible = False
        DesignSize = (
          480
          262)
        object DictionaryProgressBar: TcxProgressBar
          Left = 14
          Top = 91
          CaptionLabel = ProcesoLabel
          Anchors = [akLeft, akTop, akRight]
          Properties.BeginColor = 15448477
          Properties.EndColor = 8404992
          Properties.PeakValue = 50.000000000000000000
          Properties.SolidTextColor = True
          Style.LookAndFeel.Kind = lfUltraFlat
          Style.LookAndFeel.NativeStyle = True
          StyleDisabled.LookAndFeel.Kind = lfUltraFlat
          StyleDisabled.LookAndFeel.NativeStyle = True
          StyleFocused.LookAndFeel.Kind = lfUltraFlat
          StyleFocused.LookAndFeel.NativeStyle = True
          StyleHot.LookAndFeel.Kind = lfUltraFlat
          StyleHot.LookAndFeel.NativeStyle = True
          TabOrder = 0
          Width = 458
        end
        object FileProgressBar: TcxProgressBar
          Left = 14
          Top = 142
          CaptionLabel = FicheroLabel
          Anchors = [akLeft, akTop, akRight]
          Properties.BeginColor = 15448477
          Properties.EndColor = 8404992
          Properties.PeakColor = clLime
          Properties.PeakSize = 30
          Properties.SolidTextColor = True
          Style.LookAndFeel.Kind = lfUltraFlat
          Style.LookAndFeel.NativeStyle = True
          StyleDisabled.LookAndFeel.Kind = lfUltraFlat
          StyleDisabled.LookAndFeel.NativeStyle = True
          StyleFocused.LookAndFeel.Kind = lfUltraFlat
          StyleFocused.LookAndFeel.NativeStyle = True
          StyleHot.LookAndFeel.Kind = lfUltraFlat
          StyleHot.LookAndFeel.NativeStyle = True
          TabOrder = 1
          Width = 458
        end
        object Label9: TcxLabel
          Left = 14
          Top = 121
          TabStop = False
          Caption = 'Fichero :'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object FicheroLabel: TcxLabel
          Left = 89
          Top = 121
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 367
        end
        object Label2: TcxLabel
          Left = 14
          Top = 70
          TabStop = False
          CaptionLabel = Label2
          Caption = 'Proceso :'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object ProcesoLabel: TcxLabel
          Left = 86
          Top = 70
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 368
        end
        object cxLabel4: TcxLabel
          AlignWithMargins = True
          Left = 14
          Top = 11
          Margins.Left = 8
          Margins.Top = 0
          Margins.Bottom = 0
          TabStop = False
          AutoSize = False
          Caption = 
            'Realizando la actualizaci'#243'n y adaptaci'#243'n de los ficheros de dato' +
            's de la aplicaci'#243'n. Este proceso puede prolongarse un tiempo si ' +
            'las tablas contienen mucha informaci'#243'n.'
          Style.TextStyle = []
          Properties.WordWrap = True
          Transparent = True
          Height = 59
          Width = 457
        end
      end
    end
  end
  object EmpresaTable: TnxeTable
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Empresa'
    IndexFieldNames = 'Codigo'
    Left = 16
    Top = 192
  end
end
