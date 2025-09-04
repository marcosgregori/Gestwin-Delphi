object MntPde119Form: TMntPde119Form
  Left = 447
  Top = 280
  BorderStyle = bsDialog
  Caption = 'Configuraci'#243'n AUNA'
  ClientHeight = 378
  ClientWidth = 727
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 17
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
    TabOrder = 0
    PanelKind = epInputPanel
    Height = 337
    Width = 717
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 103
      Align = alTop
      Caption = 'AUNA Distribuci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextColor = clGrayText
      Style.TextStyle = [fsBold]
      TabOrder = 1
      DesignSize = (
        707
        220)
      Height = 220
      Width = 707
      object cxLabel1: TcxLabel
        Left = 10
        Top = 39
        TabStop = False
        Caption = 'API-Key'
        Transparent = True
      end
      object APIKeyCtrl: TcxDBTextEdit
        Left = 147
        Top = 38
        DataBinding.DataField = 'APIKey'
        DataBinding.DataSource = DataSource
        TabOrder = 0
        Width = 298
      end
      object cxLabel2: TcxLabel
        Left = 10
        Top = 66
        TabStop = False
        Caption = 'ID socio'
        Transparent = True
      end
      object IdSocioCtrl: TcxDBTextEdit
        Left = 147
        Top = 65
        DataBinding.DataField = 'IdSocio'
        DataBinding.DataSource = DataSource
        TabOrder = 1
        Width = 78
      end
      object cxLabel5: TcxLabel
        Left = 10
        Top = 123
        TabStop = False
        Caption = 'Almacenes'
        Transparent = True
      end
      object IdAlmacen1Ctrl: TcxDBTextEdit
        Left = 147
        Top = 123
        DataBinding.DataField = 'IdAlmacen1'
        DataBinding.DataSource = DataSource
        Properties.OnValidate = IdAlmacen1CtrlPropertiesValidate
        TabOrder = 2
        Width = 78
      end
      object ActualizarButton: TgBitBtn
        Left = 604
        Top = 36
        Width = 94
        Height = 29
        Anchors = [akTop, akRight]
        Caption = 'Actualizar'
        Enabled = True
        OptionsImage.ImageIndex = 24
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 11
        OnClick = ActualizarButtonClick
        GlyphBitmap = gmNetwork
      end
      object CodigoAlmacen1Ctrl: TcxDBTextEdit
        Left = 241
        Top = 124
        DescriptionLabel = DescAlmacenLabel
        DataBinding.DataField = 'CodigoAlmacen1'
        DataBinding.DataSource = DataSource
        Enabled = False
        Properties.OnQueryRequest = CodigoAlmacenCtrlPropertiesQueryRequest
        Properties.OnValidate = CodigoAlmacenCtrlPropertiesValidate
        TabOrder = 3
        Width = 25
      end
      object DescAlmacenLabel: TcxLabel
        Left = 304
        Top = 127
        AutoSize = False
        Enabled = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 353
      end
      object cxLabel6: TcxLabel
        Left = 147
        Top = 97
        TabStop = False
        Caption = 'ID AUNA'
        Style.TextColor = clGreen
        Transparent = True
      end
      object cxLabel7: TcxLabel
        Left = 239
        Top = 97
        TabStop = False
        Caption = 'Alm.'
        Style.TextColor = clGreen
        Transparent = True
      end
      object cxLabel8: TcxLabel
        Left = 304
        Top = 97
        TabStop = False
        Caption = 'Nombre'
        Style.TextColor = clGreen
        Transparent = True
      end
      object IdAlmacen2Ctrl: TcxDBTextEdit
        Left = 147
        Top = 149
        DataBinding.DataField = 'IdAlmacen2'
        DataBinding.DataSource = DataSource
        Properties.OnValidate = IdAlmacen2CtrlPropertiesValidate
        TabOrder = 4
        Width = 78
      end
      object CodigoAlmacen2Ctrl: TcxDBTextEdit
        Left = 241
        Top = 150
        DescriptionLabel = cxLabel9
        DataBinding.DataField = 'CodigoAlmacen2'
        DataBinding.DataSource = DataSource
        Enabled = False
        Properties.OnQueryRequest = CodigoAlmacenCtrlPropertiesQueryRequest
        Properties.OnValidate = CodigoAlmacenCtrlPropertiesValidate
        TabOrder = 5
        Width = 25
      end
      object cxLabel9: TcxLabel
        Left = 304
        Top = 153
        AutoSize = False
        Enabled = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 353
      end
      object cxLabel10: TcxLabel
        Left = 304
        Top = 179
        AutoSize = False
        Enabled = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 353
      end
      object IdAlmacen3Ctrl: TcxDBTextEdit
        Left = 147
        Top = 175
        DataBinding.DataField = 'IdAlmacen3'
        DataBinding.DataSource = DataSource
        Properties.OnValidate = IdAlmacen3CtrlPropertiesValidate
        TabOrder = 6
        Width = 78
      end
      object CodigoAlmacen3Ctrl: TcxDBTextEdit
        Left = 241
        Top = 177
        DescriptionLabel = cxLabel10
        DataBinding.DataField = 'CodigoAlmacen3'
        DataBinding.DataSource = DataSource
        Enabled = False
        Properties.OnQueryRequest = CodigoAlmacenCtrlPropertiesQueryRequest
        Properties.OnValidate = CodigoAlmacenCtrlPropertiesValidate
        TabOrder = 7
        Width = 25
      end
    end
    object cxGroupBox2: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Align = alTop
      Caption = 'CLC Integraci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextColor = clGrayText
      Style.TextStyle = [fsBold]
      TabOrder = 0
      DesignSize = (
        707
        92)
      Height = 92
      Width = 707
      object cxLabel3: TcxLabel
        Left = 8
        Top = 27
        TabStop = False
        Caption = 'Nombre de usuario'
        Transparent = True
      end
      object cxLabel4: TcxLabel
        Left = 8
        Top = 54
        TabStop = False
        Caption = 'Palabra de paso'
        Transparent = True
      end
      object NombreUsuarioCtrl: TcxDBTextEdit
        Left = 147
        Top = 26
        DataBinding.DataField = 'NombreUsuario'
        DataBinding.DataSource = DataSource
        TabOrder = 0
        Width = 147
      end
      object PasswordCtrl: TcxDBTextEdit
        Left = 147
        Top = 53
        DataBinding.DataField = 'Password'
        DataBinding.DataSource = DataSource
        Properties.EchoMode = eemPassword
        TabOrder = 1
        Width = 147
      end
      object cxImage1: TcxImage
        Left = 667
        Top = 23
        Anchors = [akTop, akRight]
        Picture.Data = {
          0D546478536D617274496D6167653C3F786D6C2076657273696F6E3D22312E30
          2220656E636F64696E673D225554462D38223F3E0D0A3C73766720786D6C6E73
          3D22687474703A2F2F7777772E77332E6F72672F323030302F7376672220786D
          6C3A73706163653D227072657365727665222077696474683D22323470782220
          6865696768743D2232347078222076657273696F6E3D22312E3122207374796C
          653D2273686170652D72656E646572696E673A67656F6D657472696350726563
          6973696F6E3B20746578742D72656E646572696E673A67656F6D657472696350
          7265636973696F6E3B20696D6167652D72656E646572696E673A6F7074696D69
          7A655175616C6974793B2066696C6C2D72756C653A6576656E6F64643B20636C
          69702D72756C653A6576656E6F6464222076696577426F783D22302030203232
          2E39342032322E39342220786D6C6E733A786C696E6B3D22687474703A2F2F77
          77772E77332E6F72672F313939392F786C696E6B2220786D6C6E733A786F646D
          3D22687474703A2F2F7777772E636F72656C2E636F6D2F636F72656C64726177
          2F6F646D2F32303033223E262331333B262331303B203C6465667320786D6C3A
          73706163653D227072657365727665223E20203C7374796C6520747970653D22
          746578742F6373732220786D6C3A73706163653D227072657365727665223E20
          2020266C743B215B43444154415B262331333B262331303B202020202E737472
          31207B7374726F6B653A234645464546453B7374726F6B652D77696474683A30
          2E31333B7374726F6B652D6D697465726C696D69743A32322E393235367D2623
          31333B262331303B202020202E73747230207B7374726F6B653A233242324132
          393B7374726F6B652D77696474683A302E31333B7374726F6B652D6D69746572
          6C696D69743A32322E393235367D262331333B262331303B202020202E66696C
          30207B66696C6C3A233144323835397D262331333B262331303B202020202E66
          696C31207B66696C6C3A234643423433337D262331333B262331303B20202020
          2E66696C32207B66696C6C3A77686974657D262331333B262331303B2020205D
          5D2667743B262331333B262331303B20203C2F7374796C653E0D0A093C2F6465
          66733E0D0A3C672069643D224C6179657220312220786D6C3A73706163653D22
          7072657365727665223E262331333B262331303B3C6D65746164617461206964
          3D22436F72656C436F727049445F30436F72656C2D4C61796572222F3E0D0A3C
          636972636C6520636C6173733D2266696C302073747230222063783D2231312E
          3437222063793D2231312E34372220723D2231312E34222F3E0D0A3C70617468
          20636C6173733D2266696C3120737472302220643D224D342E36362031342E37
          336C312E393520302E303463302E30332C2D322E31202D302E31362C2D342E32
          3120302E30392C2D362E3320302E30362C2D302E353520302E34352C2D312E32
          20302E38342C2D312E353920302E33372C2D302E333820302E38362C2D302E35
          3220312E33382C2D302E363220302E34362C2D302E3120302E39362C3020312E
          33392C302E3220302E34352C302E3220302E36362C302E333320302E39382C30
          2E373120302E32332C302E323820302E34342C302E363720302E35382C312E30
          3220302E30352C302E313320302E31332C302E3520302E31332C302E36346C2D
          302E303220322E393320322E303420302E3832632D302E30332C2D312E343420
          2D302E31352C2D332E3632202D302E31342C2D342E3236202D302E30372C2D30
          2E3538202D302E33312C2D312E3135202D302E36322C2D312E3634202D302E32
          382C2D302E3436202D302E35362C2D302E39202D302E39352C2D312E3237202D
          302E33342C2D302E3332202D302E35352C2D302E3438202D302E39352C2D302E
          3731202D302E33342C2D302E3138202D312E30312C2D302E3432202D312E3338
          2C2D302E3436202D302E35342C2D302E3037202D312E31312C2D302E3035202D
          312E36342C302E3036202D302E34362C302E31202D302E38392C302E3239202D
          312E32392C302E3534202D302E33382C302E3233202D302E37312C302E353620
          2D312E30322C302E3838202D302E32352C302E3237202D302E34372C302E3537
          202D302E36362C302E3839202D302E31392C302E3332202D302E32382C302E35
          34202D302E342C302E3839202D302E30392C302E3235202D302E32342C302E39
          202D302E32352C312E31376C2D302E303620362E30367A222F3E0D0A3C706174
          6820636C6173733D2266696C3220737472312220643D224D31372E353520382E
          31376C2D312E3935202D302E3035632D302E30332C322E3120302E31362C342E
          3232202D302E30392C362E33202D302E30372C302E3536202D302E34352C312E
          3231202D302E38352C312E36202D302E33372C302E3337202D302E38362C302E
          3531202D312E33372C302E3632202D302E34362C302E31202D302E39372C3020
          2D312E342C2D302E32202D302E34352C2D302E32202D302E36362C2D302E3333
          202D302E39372C2D302E3731202D302E32342C2D302E3238202D302E34352C2D
          302E3637202D302E35382C2D312E3032202D302E30352C2D302E3133202D302E
          31342C2D302E35202D302E31332C2D302E363420302C2D302E393820302E3031
          2C2D312E393520302E30322C2D322E39336C2D312E3939202D302E3863302E30
          322C312E3434202D302E30322C332E333420302E30342C332E393820302E3038
          2C302E383620302E33352C312E3420302E36362C312E3920302E32392C302E34
          3620302E35362C302E383920302E39362C312E323620302E33332C302E333220
          302E35342C302E343920302E39352C302E373120302E33332C302E313820312C
          302E343320312E33372C302E343720302E35352C302E303620312E31312C302E
          303420312E36352C2D302E303720302E34352C2D302E303920302E38392C2D30
          2E323920312E32382C2D302E353320302E33392C2D302E323420302E37312C2D
          302E353620312E30322C2D302E383920302E32362C2D302E323620302E34382C
          2D302E353720302E36372C2D302E383820302E31392C2D302E333220302E3237
          2C2D302E353520302E342C2D302E383920302E30392C2D302E323620302E3234
          2C2D302E3920302E32342C2D312E31386C302E3037202D362E30357A222F3E0D
          0A093C2F673E0D0A3C2F7376673E0D0A}
        Properties.FitMode = ifmProportionalStretch
        Properties.ReadOnly = True
        Properties.ShowFocusRect = False
        Style.BorderStyle = ebsNone
        TabOrder = 4
        Transparent = True
        Height = 33
        Width = 38
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 342
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      727
      36)
    Height = 36
    Width = 727
    object Panel3: TcxGroupBox
      Left = 278
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
  object FormManager: TgxFormManager
    Dataset = Data
    Model = fmPersistentInputForm
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 422
    Top = 20
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 359
    Top = 20
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    
    Left = 391
    Top = 20
    object DataHost: TStringField
      FieldName = 'Host'
      Size = 80
    end
    object DataNombreUsuario: TStringField
      FieldName = 'NombreUsuario'
      Size = 30
    end
    object DataPassword: TStringField
      FieldName = 'Password'
    end
    object DataAPIKey: TStringField
      FieldName = 'APIKey'
      Size = 42
    end
    object DataIdSocio: TStringField
      FieldName = 'IdSocio'
      Size = 4
    end
    object DataIdAlmacen1: TStringField
      FieldName = 'IdAlmacen1'
      Size = 4
    end
    object DataIdAlmacen2: TStringField
      FieldName = 'IdAlmacen2'
      Size = 4
    end
    object DataIdAlmacen3: TStringField
      FieldName = 'IdAlmacen3'
      Size = 4
    end
    object DataCodigoAlmacen1: TStringField
      FieldName = 'CodigoAlmacen1'
      Size = 2
    end
    object DataCodigoAlmacen2: TStringField
      FieldName = 'CodigoAlmacen2'
      Size = 2
    end
    object DataCodigoAlmacen3: TStringField
      FieldName = 'CodigoAlmacen3'
      Size = 2
    end
  end
end
