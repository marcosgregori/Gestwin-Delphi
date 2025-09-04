object BoxRopForm: TBoxRopForm
  Left = 490
  Top = 361
  HelpType = htKeyword
  HelpKeyword = 'b_rop'
  HelpContext = 2113
  BorderStyle = bsDialog
  Caption = 'Declaraci'#243'n anual de operaciones (Modelo 347)'
  ClientHeight = 409
  ClientWidth = 608
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object dataPanel: TgxEditPanel
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
    Height = 368
    Width = 598
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 215
      Align = alTop
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Height = 144
      Width = 588
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 6
        Top = 22
        Margins.Left = 4
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Este proceso ha sido dise'#241'ado para facilitarle la presentaci'#243'n d' +
          'el modelo 347 utilizando el programa que ofrece la Agencia Tribu' +
          'taria. Debe realizar la importaci'#243'n de los datos en el mismo y r' +
          'evisar cuidadosamente la informaci'#243'n antes de presentar la decla' +
          'raci'#243'n.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 577
      end
      object cxLabel2: TcxLabel
        AlignWithMargins = True
        Left = 6
        Top = 77
        Margins.Left = 4
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Tenga en cuenta que si solicita una declaraci'#243'n agrupada po N.I.' +
          'F., las operaciones con subcuentas de deudores o acreedores que ' +
          'no tengan asociada una ficha o no tengan fijado el N.I.F. no ser' +
          #225'n incluidos en la misma.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 1
        Transparent = True
        Width = 577
      end
    end
    object cxGroupBox2: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 0
      DesignSize = (
        588
        204)
      Height = 204
      Width = 588
      object gxRangeBox1: TgxRangeBox
        Left = 118
        Top = 8
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object AgruparPorNIFCtrl: TcxDBCheckBox
        Left = 5
        Top = 111
        AutoSize = False
        Caption = 'Agrupar por N.I.F.'
        DataBinding.DataField = 'AgruparPorNIF'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        TabOrder = 4
        Transparent = True
        Height = 24
        Width = 144
      end
      object examinarButton: TgBitBtn
        Left = 484
        Top = 135
        Width = 103
        Height = 29
        Anchors = [akTop, akRight]
        Caption = 'E&xaminar ...'
        Enabled = True
        OptionsImage.ImageIndex = 23
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 6
        TabStop = False
        OnClick = examinarButtonClick
        GlyphBitmap = gmFolderBrowser
      end
      object FechaFinalCtrl: TcxDBDateEdit
        Left = 133
        Top = 29
        DataBinding.DataField = 'FechaFinal'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        TabOrder = 1
        Width = 100
      end
      object FechaInicialCtrl: TcxDBDateEdit
        Left = 133
        Top = 2
        DataBinding.DataField = 'FechaInicial'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        TabOrder = 0
        Width = 100
      end
      object ficheroLabel: TcxLabel
        Left = 8
        Top = 171
        TabStop = False
        Caption = 'Fichero'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
      end
      object Image1: TcxImage
        Left = 539
        Top = 1
        Anchors = [akTop, akRight]
        AutoSize = True
        Picture.Data = {
          0D546478536D617274496D6167653C3F786D6C2076657273696F6E3D22312E30
          2220656E636F64696E673D225554462D38223F3E0D0A3C737667207769647468
          3D223130302522206865696768743D2231303025222076696577426F783D2230
          2030203433203431222076657273696F6E3D22312E312220786D6C6E733D2268
          7474703A2F2F7777772E77332E6F72672F323030302F7376672220786D6C6E73
          3A786C696E6B3D22687474703A2F2F7777772E77332E6F72672F313939392F78
          6C696E6B2220786D6C3A73706163653D2270726573657276652220786D6C6E73
          3A73657269663D22687474703A2F2F7777772E73657269662E636F6D2F222073
          74796C653D2266696C6C2D72756C653A6576656E6F64643B636C69702D72756C
          653A6576656E6F64643B7374726F6B652D6C696E656A6F696E3A726F756E643B
          7374726F6B652D6D697465726C696D69743A312E34313432313B223E26233130
          3B202020202623393B2623393B2623393B2623393B2623393B3C67207472616E
          73666F726D3D226D617472697828302E30303431323136332C302C302C302E30
          303431323136332C342E343735362C342E3439333634292220786D6C3A737061
          63653D227072657365727665223E20202020202020202623393B2623393B2623
          393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B3C70
          61746820643D224D333938342C3537343643343230342C353637312034383933
          2C3530393320353130332C3439323743353237372C3437393020353437382C34
          36333920353632382C3434393943353830362C3433333320353938392E30382C
          343137342E353220363132372E36382C343033332E3843363033362E34342C33
          3835312E343920353733362C3333333720353632312C3331333643353434392C
          3238333920353239322C3235363520353131362C323236354C343131392C3531
          3843333939302E38352C3431312E36303620333839352C3430352E3837392033
          3432352C3430352E38373943323835342C3430352E38373920313333322C3432
          372E343835203936312C34323843313033362C36333020323330392C32373937
          20323436362C333037374C333938342C353734365A22207374796C653D226669
          6C6C3A72676228392C3130302C313539293B222F3E0D0A093C2F673E0D0A3C67
          207472616E73666F726D3D226D617472697828302E30303431323136332C302C
          302C302E30303431323136332C342E343735362C342E3439333634292220786D
          6C3A73706163653D227072657365727665223E20202020202020202623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
          23393B3C7061746820643D224D343431322C3634323843343433352C36353137
          20343435332C3635323320343438372C3636313143343539312C363735302034
          3833362C3731373220343839352C373330384C373930352C3733323443383030
          342C3732363420373936342C3734303120373936342C3731383543373734392C
          3638333620373535392C3634363420373334312C3631303843373230342C3538
          383320363832302E31322C353231302E333220363732362C353035342E303543
          363635312E35342C343933302E343220363536342C3437393220363532332C34
          3735364C353735342C3534333643353332342C3538323420343638342C363139
          3720343431322C363432385A22207374796C653D2266696C6C3A72676228392C
          3130302C313539293B222F3E0D0A093C2F673E0D0A3C67207472616E73666F72
          6D3D226D617472697828302E30303431323136332C302C302C302E3030343132
          3136332C342E343735362C342E3439333634292220786D6C3A73706163653D22
          7072657365727665223E20202020202020202623393B2623393B2623393B2623
          393B2623393B2623393B2623393B2623393B2623393B2623393B3C7061746820
          643D224D3736332C3635373243313034362C3530333420323039332C34303331
          20323139312C3338313043323234382C3336383020323132372C333534352032
          3037372C3334303143313936382C3332373720313935372C3331393120313830
          392C3331323343313434342C33333433203430342C35303035203334372C3536
          3437433332312C35393433203631352C36343630203736332C363537325A2220
          7374796C653D2266696C6C3A726762283235312C35342C3333293B222F3E0D0A
          093C2F673E0D0A3C67207472616E73666F726D3D226D617472697828302E3030
          3431323136332C302C302C302E30303431323136332C342E343735362C342E34
          39333634292220786D6C3A73706163653D227072657365727665223E20202020
          202020202623393B2623393B2623393B2623393B2623393B2623393B2623393B
          2623393B2623393B2623393B3C7061746820643D224D373832372C3231303443
          383037332C3232353120383030352C3237373120373932372C33303235433737
          35322C3335393820373237352C3432323120363836312C343633384336373532
          2C3437343820363636392C3437383020363732362C3530303443363736352C35
          31383820373230342C3538383320373334312C3631303843373535392C363436
          3420373734392C3638333620373936342C3731383543383335302C3734363820
          373734302C3734333720373535322C373433374C353235372C37343338433530
          36362C3734333620353035352C3733393820343930342C373333334335303038
          2C3735383720353330352C3735313220353537372C3735313243363035362C37
          35313220373930382C3735353020383131322C3734373743383230332C373237
          3020373936352C3639393020373836372C3638313743373836372C3638313720
          373138382C3536343120373133302C3535333943363734332C34383634203637
          32322E36312C343935332E3820363931352C3436393143363939332C34363137
          20363939372C3435393920373036322C3435323243373532312C333937372038
          3233392C3331323620383034352C3233333343373938322C3230373720373731
          352C3136363920373438392C3135353543373534362C3136383520373734312C
          3139373820373832372C323130345A22207374796C653D2266696C6C3A726762
          283233322C3233322C323332293B222F3E0D0A093C2F673E0D0A3C6720747261
          6E73666F726D3D226D617472697828302E30303431323136332C302C302C302E
          30303431323136332C342E343735362C342E3439333634292220786D6C3A7370
          6163653D227072657365727665223E20202020202020202623393B2623393B26
          23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B3C
          7061746820643D224D3736332C3635373243313032352C36363032203832372C
          3635343120313137382C3537323543313433312C3531333920313733392C3437
          303820323132302C3432303243323232352C3430363320323439352C33383134
          20323137322C333437374C323037372C3334303143323132372C333534352032
          3234382C3336383020323139312C3338313043323039332C3430333120313034
          362C35303334203736332C363537325A22207374796C653D2266696C6C3A7267
          62283138362C3138362C313836293B222F3E0D0A093C2F673E0D0A3C67207472
          616E73666F726D3D226D617472697828302E30303431323136332C302C302C30
          2E30303431323136332C342E343735362C342E3439333634292220786D6C3A73
          706163653D227072657365727665223E20202020202020202623393B2623393B
          2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B
          3C7061746820643D224D313134362C3732343143313436322C37363732203234
          35332C3734373120323933302C3733303043333230392C373139392033343732
          2C3730393320333733392C3639383343333839382C3639313720343333342C36
          36323520343438372C3636313143343435332C3635323320343433352C363531
          3720343431322C3634323843343239342C3634383020343138322C3635363320
          343035362C3636333343333239302C3730353620313937342C37353732203131
          34362C373234315A22207374796C653D2266696C6C3A726762283138362C3138
          362C313836293B222F3E0D0A093C2F673E0D0A3C67207472616E73666F726D3D
          226D617472697828302E30303431323136332C302C302C302E30303431323136
          332C342E343735362C342E3439333634292220786D6C3A73706163653D227072
          657365727665223E20202020202020202623393B2623393B2623393B2623393B
          2623393B2623393B2623393B2623393B2623393B2623393B3C7061746820643D
          224D363532332C3437353643363536342C3437393220363636352C343937332E
          323420363732362C353032362E323443363636392C343830322E323420363735
          322C3437343820363836312C3436333843373237352C3432323120373735322C
          3335393820373932372C3330323543383030352C3237373120383037332C3232
          353120373832372C3231303443383032332C3239303320373631382C33343339
          20373232342C3339373843363935332C3433343720363730312C343534302036
          3532332C343735365A22207374796C653D2266696C6C3A726762283138362C31
          38362C313836293B222F3E0D0A093C2F673E0D0A3C67207472616E73666F726D
          3D226D617472697828302E30303431323136332C302C302C302E303034313231
          36332C342E343735362C342E3439333634292220786D6C3A73706163653D2270
          72657365727665223E20202020202020202623393B2623393B2623393B262339
          3B2623393B2623393B2623393B2623393B2623393B2623393B3C706174682064
          3D224D363132372E36382C343034342E39324C363233382E34342C333932302E
          323943363137312E37332C333836392E323720363134382C3338303020353936
          322C333530354C353639392C3330363643353639352C3330353920353639312C
          3330353020353638372C333034334C353039372C3230303743353035362C3139
          333520353031372C3138373420343936352C313738384C343333322C36393343
          343235382C35343920343236392C35333820343131392C3531384C353131362C
          3232363543353239322C3235363520353434392C3238333920353632312C3331
          333643353733362C3333333720363035382E36382C333834352E393220363132
          372E36382C343034342E39325A22207374796C653D2266696C6C3A7267622832
          33322C3233322C323332293B222F3E0D0A093C2F673E0D0A3C67207472616E73
          666F726D3D226D617472697828302E30303431323136332C302C302C302E3030
          3431323136332C342E343735362C342E3439333634292220786D6C3A73706163
          653D227072657365727665223E20202020202020202623393B2623393B262339
          3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B3C7061
          746820643D224D343839352C373330384C343930342C3733333343353035352C
          3733393820353036362C3734333620353235372C373433384C373535322C3734
          333743373734302C3734333720383335302C3734363820373936342C37313835
          43373936342C3734303120383030342C3732363420373930352C373332344C34
          3839352C373330385A22207374796C653D2266696C6C3A726762283138362C31
          38362C313836293B222F3E0D0A093C2F673E0D0A3C67207472616E73666F726D
          3D226D617472697828302E30303431323136332C302C302C302E303034313231
          36332C342E343735362C342E3439333634292220786D6C3A73706163653D2270
          72657365727665223E20202020202020202623393B2623393B2623393B262339
          3B2623393B2623393B2623393B2623393B2623393B2623393B3C706174682064
          3D224D363436392C3336343743363237372E33362C333837302E323420353830
          362C3433333320353632382C3434393943353437382C3436333920353237372C
          3437393020353130332C3439323743343839332C3530393320343230342C3536
          373120333938342C3537343643333831312C3539323620323839382C36333231
          20323538372C3634333143313833392C3636393720313638312C363732352038
          31372C36363732433838312C3639363120313031362C3730373720313134362C
          3732343143313937342C3735373220333239302C3730353620343035362C3636
          333343343138322C3635363320343239342C3634383020343431322C36343238
          43343638342C3631393720353332342C3538323420353735342C353433364C36
          3532332C3437353643363730312C3435343020363935332C3433343720373232
          342C3339373843373631382C3334333920383032332C3239303320373832372C
          3231303443373734312C3139373820373534362C3136383520373438392C3135
          35354C373432332C3134383143373332332C3236303320373132342C32383834
          20363436392C333634375A22207374796C653D2266696C6C3A72676228323530
          2C3136392C3432293B222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
        Properties.ReadOnly = True
        Properties.ShowFocusRect = False
        Style.BorderStyle = ebsNone
        TabOrder = 8
        Transparent = True
      end
      object ImporteMinimoCtrl: TcxDBCurrencyEdit
        Left = 133
        Top = 56
        DataBinding.DataField = 'ImporteMinimo'
        DataBinding.DataSource = DataSource
        TabOrder = 2
        Width = 77
      end
      object Label1: TcxLabel
        Left = 8
        Top = 9
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
      end
      object Label3: TcxLabel
        Left = 8
        Top = 59
        TabStop = False
        Caption = 'Importe m'#237'nimo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 10
        Transparent = True
      end
      object Label4: TcxLabel
        Left = 8
        Top = 140
        TabStop = False
        Caption = 'Path (directorio)'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 11
        Transparent = True
      end
      object PathCtrl: TcxDBTextEdit
        Left = 133
        Top = 137
        Anchors = [akLeft, akTop, akRight]
        DataBinding.DataField = 'Path'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnValidate = PathCtrlPropertiesValidate
        TabOrder = 5
        Width = 343
      end
      object TituloLabel: TcxLabel
        Left = 491
        Top = 2
        TabStop = False
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = '347'
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clSilver
        Style.Font.Height = -21
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = [fsBold]
        Style.TextColor = clGrayText
        Style.TransparentBorder = False
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 12
        Transparent = True
        Height = 25
        Width = 43
      end
      object NombreFicheroLabel: TcxLabel
        AlignWithMargins = True
        Left = 133
        Top = 167
        TabStop = False
        AutoSize = False
        Caption = 'MOD347-001.TXT'
        Style.BorderColor = clScrollBar
        Style.BorderStyle = ebsSingle
        Style.Edges = [bBottom]
        Style.LookAndFeel.NativeStyle = False
        Style.TransparentBorder = True
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 13
        Transparent = True
        Height = 25
        Width = 140
        AnchorY = 180
      end
      object Label2: TcxLabel
        Left = 8
        Top = 84
        TabStop = False
        Caption = 'N'#186' de presentaci'#243'n'
        TabOrder = 14
        Transparent = True
      end
      object NroPresentacionCtrl: TcxDBSpinEdit
        Left = 134
        Top = 83
        DataBinding.DataField = 'NroPresentacion'
        DataBinding.DataSource = DataSource
        Properties.MaxValue = 9999.000000000000000000
        Properties.MinValue = 1.000000000000000000
        Properties.OnChange = NroPresentacionCtrlPropertiesChange
        TabOrder = 3
        Width = 65
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 373
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    DesignSize = (
      608
      36)
    Height = 36
    Width = 608
    object Panel3: TcxGroupBox
      Left = 213
      Top = 4
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
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = FechaInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 318
    Top = 8
  end
  object AsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Fecha'
    Left = 318
    Top = 38
  end
  object ApunteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 286
    Top = 38
  end
  object Data: TgxMemData
    Indexes = <
      item
        SortOptions = []
      end>
    SortOptions = []
    Left = 285
    Top = 8
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataPath: TWideStringField
      FieldName = 'Path'
      Size = 256
    end
    object DataAgruparPorNIF: TBooleanField
      FieldName = 'AgruparPorNIF'
    end
    object DataImporteMinimo: TBCDField
      FieldName = 'ImporteMinimo'
    end
    object DataNroPresentacion: TSmallintField
      FieldName = 'NroPresentacion'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 254
    Top = 8
  end
  object ApunteAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 254
    Top = 38
  end
  object ApunteCCTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 254
    Top = 70
  end
end
