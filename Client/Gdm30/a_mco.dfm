object MntMcoForm: TMntMcoForm
  Left = 309
  Top = 279
  HelpType = htKeyword
  HelpKeyword = 'a_mco'
  BorderStyle = bsDialog
  ClientHeight = 556
  ClientWidth = 1008
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
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    Style.TransparentBorder = True
    TabOrder = 0
    OnEnter = KeyPanelEnter
    PanelKind = epKeyPanel
    Height = 64
    Width = 1008
    object LockRangeButton: TgxLockRangeButton
      Left = 185
      Top = 6
      Width = 24
      Height = 24
      Hint = 
        'Bloqueo del campo (Navegar fijando este campo).\nTeclas [Ctrl]+[' +
        'B]'
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
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
        23393B2623393B3C672069643D2269636F6E2220786D6C3A73706163653D2270
        72657365727665223E262331333B262331303B3C636972636C652063783D2231
        32222063793D2231322220723D2231302E39383939222066696C6C3D22234635
        42353334222F3E0D0A3C7061746820643D224D31392E373731312C342E323238
        39632D302E3031352C2D302E3031352C2D302E303330352C2D302E303239352C
        2D302E303435362C2D302E303434346C2D31352E3534312C31352E3534316330
        2E303134392C302E303135312C302E303239342C302E303330352C302E303434
        342C302E3034353663342E323931382C342E323931382C31312E323530332C34
        2E323931382C31352E353432312C305332342E303632392C382E353230382C31
        392E373731312C342E323238397A222066696C6C3D222344323930304122206F
        7061636974793D22302E35222F3E0D0A3C7061746820643D224D31302E362C31
        3648382E34632D302E323230392C302C2D302E342C2D302E313739312C2D302E
        342C2D302E3456382E3463302C2D302E323230392C302E313739312C2D302E34
        2C302E342C2D302E3468322E3263302E323230392C302C302E342C302E313739
        312C302E342C302E3476372E324331312C31352E383230392C31302E38323039
        2C31362C31302E362C31367A222066696C6C3D2223464546454646222F3E0D0A
        3C7061746820643D224D31352E362C3136682D322E32632D302E323230392C30
        2C2D302E342C2D302E313739312C2D302E342C2D302E3456382E3463302C2D30
        2E323230392C302E313739312C2D302E342C302E342C2D302E3468322E326330
        2E323230392C302C302E342C302E313739312C302E342C302E3476372E324331
        362C31352E383230392C31352E383230392C31362C31352E362C31367A222066
        696C6C3D2223464546454646222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
      OptionsImage.ImageIndex = 18
      OptionsImage.Spacing = 2
      ParentShowHint = False
      ShowHint = True
      SpeedButtonOptions.GroupIndex = 1
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.AllowAllUp = True
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
      TabOrder = 2
      EditControl = ProveedorCtrl
      OnLockRange = LockRangeButtonLockRange
    end
    object ProveedorCtrl: TcxDBTextEdit
      Left = 135
      Top = 6
      DescriptionLabel = Label9
      DataBinding.DataField = 'Propietario'
      DataBinding.DataSource = MovimientoDataSource
      Properties.Required = True
      Properties.OnExtendedFunction = ProveedorCtrlPropertiesExtendedFunction
      Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
      Properties.OnEditRequest = ProveedorCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = ProveedorCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object Panel1: TcxGroupBox
      Left = 136
      Top = 33
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.LookAndFeel.NativeStyle = False
      Style.TransparentBorder = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      TabOrder = 1
      Transparent = True
      Height = 25
      Width = 124
      object NroDocumentoCtrl: TcxDBIntegerEdit
        Left = 43
        Top = 0
        Align = alLeft
        AutoSize = False
        DataBinding.DataField = 'NroDocumento'
        DataBinding.DataSource = MovimientoDataSource
        Properties.Required = True
        Properties.OnQueryRequest = NroPedidoCtrlPropertiesQueryRequest
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxLength = 8
        Properties.MaxValue = 99999999.000000000000000000
        Properties.MinValue = 1.000000000000000000
        Style.TransparentBorder = False
        TabOrder = 1
        Height = 25
        Width = 79
      end
      object SerieCtrl: TcxDBTextEdit
        Left = 0
        Top = 0
        Align = alLeft
        AutoSize = False
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = MovimientoDataSource
        Properties.OnQueryRequest = NroPedidoCtrlPropertiesQueryRequest
        Style.TransparentBorder = False
        TabOrder = 0
        Visible = False
        Height = 25
        Width = 28
      end
      object SeparadorSerieLabel: TcxLabel
        Left = 28
        Top = 0
        TabStop = False
        Align = alLeft
        AutoSize = False
        Caption = ' -'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 2
        Transparent = True
        Visible = False
        Height = 25
        Width = 15
        AnchorY = 13
      end
    end
    object NroDocumentoCaptionLabel: TcxLabel
      Left = 15
      Top = 37
      TabStop = False
      Caption = 'Serie - N'#186' albar'#225'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
    object EstadoLabel: TcxLabel
      Left = 270
      Top = 37
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
      Height = 19
      Width = 437
    end
    object Label10: TcxLabel
      Left = 14
      Top = 9
      TabStop = False
      Caption = 'C'#243'digo proveedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 270
      Top = 9
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
      Height = 19
      Width = 321
    end
    object AvisoButton: TgBitBtn
      Left = 210
      Top = 5
      Width = 26
      Height = 26
      Hint = 'Mostrar el aviso asociado al proveedor.\nTeclas [Ctrl]+[O]'
      Cancel = True
      Enabled = True
      ModalResult = 5
      OptionsImage.ImageIndex = 8
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      PaintStyle = bpsGlyph
      ParentShowHint = False
      ShowHint = True
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
      TabOrder = 7
      TabStop = False
      Visible = False
      OnClick = AvisoButtonClick
      GlyphBitmap = gmWarning
    end
    object CaptionsPanel: TcxGroupBox
      Left = 608
      Top = 2
      Align = alRight
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.LookAndFeel.NativeStyle = False
      Style.TransparentBorder = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      TabOrder = 8
      Transparent = True
      DesignSize = (
        398
        60)
      Height = 60
      Width = 398
      object TituloDocumentoLabel: TcxLabel
        AlignWithMargins = True
        Left = 135
        Top = 2
        Margins.Top = 0
        TabStop = False
        AutoSize = False
        Caption = 'ALBAR'#193'N DE COMPRA'
        ParentColor = False
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = cl3DDkShadow
        Style.Font.Height = -23
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = [fsBold]
        Style.TextColor = cl3DDkShadow
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 0
        Transparent = True
        Height = 37
        Width = 258
        AnchorX = 393
        AnchorY = 21
      end
      object OrigenLabel: TcxLabel
        Left = 3
        Top = 10
        TabStop = False
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'APROVISIONAMIENTO'
        ParentColor = False
        Style.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.NativeStyle = False
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Properties.LineOptions.OuterColor = clHighlight
        Properties.ShowAccelChar = False
        TabOrder = 1
        Transparent = True
        Visible = False
        Height = 25
        Width = 136
        AnchorX = 71
        AnchorY = 23
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 520
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      1008
      36)
    Height = 36
    Width = 1008
    object ButtonContainerPanel: TcxGroupBox
      Left = 238
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 532
      object OkButton: TgBitBtn
        Left = 2
        Top = 2
        Width = 85
        Height = 32
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
        Left = 89
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 2
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
        GlyphBitmap = gmClose
      end
      object DeleteButton: TgBitBtn
        AlignWithMargins = True
        Left = 176
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alLeft
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
      object FacturarButton: TgBitBtn
        AlignWithMargins = True
        Left = 271
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'Fac&turar'
        Enabled = True
        OptionsImage.ImageIndex = 65
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 3
        OnClick = FacturarButtonClick
        GlyphBitmap = gmInvoiceOk
      end
      object ExportarButton: TgBitBtn
        AlignWithMargins = True
        Left = 358
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'E&xportar'
        Enabled = True
        OptionsImage.ImageIndex = 30
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 4
        TabStop = False
        OnClick = ExportarButtonClick
        GlyphBitmap = gmExport
      end
      object EnviarButton: TgBitBtn
        AlignWithMargins = True
        Left = 445
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'Enviar'
        Enabled = True
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.SourceHeight = 18
        OptionsImage.Glyph.SourceWidth = 18
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
          7061746820643D224D31372E363732362C342E32383733632D302E373730352C
          302C2D312E353031372C302E313730342C2D322E313631382C302E3437343363
          2D302E393139392C2D322E323233362C2D332E303033322C2D332E373736332C
          2D352E343237352C2D332E37373633632D322E393937382C302C2D352E343734
          362C322E333733342C2D352E383733372C352E34353439632D312E383331332C
          302E353639352C2D332E313538372C322E323530332C2D332E313538372C342E
          3233353663302C332E333732312C322E373239382C342E313538362C352E3038
          35372C342E3332343268302E323139376C342E353930372C2D342E3539303663
          302E323633392C2D302E3236342C302E363135362C2D302E343039342C302E39
          3930312C2D302E3430393463302E333734342C302C302E373236312C302E3134
          35342C302E393930312C302E343039334C31372E353230322C313568302E3636
          353268302E36393863322E353734362C2D302E323832322C342E30372C2D322E
          3531382C342E30372C2D352E333038384332322E393533342C362E373033392C
          32302E353839312C342E323837332C31372E363732362C342E323837337A2220
          66696C6C2D72756C653D226576656E6F6464222066696C6C3D22233544394345
          43222F3E0D0A3C7061746820643D224D31372E363732362C342E32383733632D
          302E373730352C302C2D312E353031372C302E313730342C2D322E313631382C
          302E34373433632D302E323038342C2D302E353033392C2D302E343737322C2D
          302E393732382C2D302E373935352C2D312E333937356C2D332E333833392C36
          2E3737343363302E313836362C2D302E303839362C302E3339322C2D302E3133
          38332C302E363035352C2D302E3133383363302E333734342C302C302E373236
          312C302E313435342C302E393930312C302E343039334C31372E353230322C31
          3568302E3636353268302E36393863322E353734362C2D302E323832322C342E
          30372C2D322E3531382C342E30372C2D352E333038384332322E393533342C36
          2E373033392C32302E353839312C342E323837332C31372E363732362C342E32
          3837337A222066696C6C2D72756C653D226576656E6F6464222066696C6C3D22
          23344238394443222F3E0D0A3C7061746820643D224D31312E363533392C3131
          2E313136364C362E343631342C31362E333039632D302E313535342C302E3135
          35342C2D302E313535342C302E343039372C302C302E353635316C302E383437
          372C302E3834373763302E313535342C302E313535342C302E343339392C302E
          313535342C302E353935332C304C31312C31342E3635363476372E3934333963
          302C302E323139382C302E313139352C302E333939372C302E333339332C302E
          3339393768312E3139383863302E323139382C302C302E343631392C2D302E31
          3739392C302E343631392C2D302E33393937762D372E393339356C332E303239
          392C332E30363163302E313535342C302E313535342C302E333934312C302E31
          3535342C302E353439352C306C302E383339392C2D302E3834373763302E3135
          35342C2D302E313535342C302E313531352C2D302E343039372C2D302E303033
          392C2D302E353635316C2D342E333436372C2D342E333434386C2D302E383438
          372C2D302E383437374331322E303634362C31302E393631312C31312E383039
          332C31302E393631312C31312E363533392C31312E313136367A222066696C6C
          3D2223444234343533222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 5
        Visible = False
      end
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 64
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
    Height = 456
    Width = 998
    object BottomPanel: TGridTableViewPanel
      Left = 2
      Top = 393
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 3
      Transparent = True
      Grid = Grid
      Height = 61
      Width = 994
      object BottomScrollBox: TcxScrollBox
        Left = 2
        Top = 2
        Width = 255
        Height = 57
        Align = alLeft
        BorderStyle = cxcbsNone
        HorzScrollBar.Visible = False
        TabOrder = 0
        Transparent = True
        VertScrollBar.Visible = False
        object RecibidoPanel: TgxScrollBoxPanel
          Left = 0
          Top = 54
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 2
          Height = 27
          Width = 255
          object RecibidoCtrl: TcxDBCheckBox
            Left = 6
            Top = 1
            AutoSize = False
            Caption = 'Recibido'
            DataBinding.DataField = 'Recibido'
            DataBinding.DataSource = MemDataSource
            Properties.OnValuePosted = RecibidoCtrlPropertiesValuePosted
            Properties.Alignment = taRightJustify
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 0
            Transparent = True
            Height = 27
            Width = 135
          end
        end
        object PortesPanel: TgxScrollBoxPanel
          Left = 0
          Top = 81
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 3
          Height = 27
          Width = 255
          object PortesCtrl: TcxDBCurrencyEdit
            Left = 124
            Top = 1
            DataBinding.DataField = 'Portes'
            DataBinding.DataSource = MovimientoDataSource
            Properties.OnValuePosted = PortesCtrlPropertiesValuePosted
            Properties.MaxLength = 8
            TabOrder = 0
            Width = 71
          end
          object Label6: TcxLabel
            Left = 10
            Top = 5
            TabStop = False
            Caption = 'Portes'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object NoFacturarPanel: TgxScrollBoxPanel
          Left = 0
          Top = 27
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Transparent = True
          Height = 27
          Width = 255
          object NoFacturarCtrl: TcxDBCheckBox
            Left = 6
            Top = 1
            AutoSize = False
            Caption = 'No facturar'
            DataBinding.DataField = 'NoFacturar'
            DataBinding.DataSource = MovimientoDataSource
            Properties.Alignment = taRightJustify
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            Properties.OnChange = NoFacturarCtrlPropertiesChange
            TabOrder = 0
            Transparent = True
            Height = 27
            Width = 135
          end
        end
        object RevisadoPanel: TgxScrollBoxPanel
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Transparent = True
          Height = 27
          Width = 255
          object RevisadoCtrl: TcxDBCheckBox
            Left = 6
            Top = 1
            AutoSize = False
            Caption = 'Revisado'
            DataBinding.DataField = 'Revisado'
            DataBinding.DataSource = MovimientoDataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            TabOrder = 0
            Transparent = True
            Height = 27
            Width = 135
          end
        end
      end
      object FillPanel: TcxGroupBox
        Left = 257
        Top = 2
        Align = alLeft
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Transparent = True
        Height = 57
        Width = 178
      end
      object CantidadTotalPanel: TcxGroupBox
        Left = 435
        Top = 2
        Align = alLeft
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Transparent = True
        Height = 57
        Width = 81
        object CantidadLabel: TcxLabel
          Left = 3
          Top = 6
          TabStop = False
          Caption = 'Cantidad'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object FooterPanelCantidad: TcxLabel
          Left = 2
          Top = 29
          TabStop = False
          CaptionLabel = CantidadLabel
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 1
          Transparent = True
          Height = 25
          Width = 77
          AnchorX = 79
          AnchorY = 42
        end
      end
      object RecibidoTotalPanel: TcxGroupBox
        Left = 516
        Top = 2
        Align = alLeft
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 3
        Transparent = True
        Height = 57
        Width = 77
        object FooterPanelRecibido: TcxLabel
          Left = 0
          Top = 29
          TabStop = False
          CaptionLabel = RecibidoLabel
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
          Height = 25
          Width = 75
          AnchorX = 75
          AnchorY = 42
        end
        object RecibidoLabel: TcxLabel
          Left = 1
          Top = 6
          TabStop = False
          Caption = 'Servido'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
      end
      object PesoTotalPanel: TcxGroupBox
        Left = 593
        Top = 2
        Align = alLeft
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 4
        Transparent = True
        Height = 57
        Width = 79
        object FooterPanelPeso: TcxLabel
          Left = 0
          Top = 29
          TabStop = False
          CaptionLabel = PesoLabel
          AutoSize = False
          ParentShowHint = False
          ShowHint = True
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
          Height = 25
          Width = 75
          AnchorX = 75
          AnchorY = 42
        end
        object PesoLabel: TcxLabel
          Left = 0
          Top = 6
          TabStop = False
          Caption = 'Peso'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
      end
      object TotalesPanel: TcxGroupBox
        Left = 738
        Top = 2
        Align = alRight
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 5
        Transparent = True
        DesignSize = (
          254
          57)
        Height = 57
        Width = 254
        object cxLabel4: TcxLabel
          Left = 6
          Top = 6
          TabStop = False
          Caption = 'Importe'
          Style.BorderStyle = ebsNone
          Style.Edges = [bLeft, bTop, bRight, bBottom]
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 0
          Transparent = True
          AnchorY = 15
        end
        object cxLabel5: TcxLabel
          Left = 6
          Top = 33
          TabStop = False
          Caption = 'Total (I.V.A. Inc.)'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
        object FooterPanelImporte: TcxLabel
          Left = 102
          Top = 2
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
          TabOrder = 2
          Transparent = True
          Height = 25
          Width = 113
          AnchorX = 215
          AnchorY = 15
        end
        object FooterPanelIVAIncluido: TcxLabel
          Left = 102
          Top = 29
          TabStop = False
          AutoSize = False
          ParentFont = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = -15
          Style.Font.Name = 'Segoe UI'
          Style.Font.Style = [fsBold]
          Style.LookAndFeel.NativeStyle = False
          Style.TextStyle = [fsBold]
          Style.IsFontAssigned = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 3
          Transparent = True
          Height = 25
          Width = 113
          AnchorX = 215
          AnchorY = 42
        end
        object AsignarAlmacenButton: TgBitBtn
          Left = 222
          Top = 4
          Width = 30
          Height = 30
          Hint = 'Asignar un mismo almac'#233'n a todas las l'#237'neas\nTeclas [Alt]+[M]'
          Anchors = [akTop, akRight]
          Caption = 'Asignar al&mac'#233'n'
          Enabled = True
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
            3D227072657365727665223E262331303B20203C672069643D226D61696E2220
            786D6C3A73706163653D227072657365727665223E202020203C636C69705061
            74682069643D22636C69705F6D61736B2220786D6C3A73706163653D22707265
            7365727665223E2020202020203C7061746820643D224D31372E313532342C32
            332E37373334632D302E303034312C2D302E303130372C2D302E303038312C2D
            302E303231372C2D302E303131392C2D302E303332366C2D322E363033312C2D
            372E35303037632D302E303937342C2D302E323734352C2D302E333034332C2D
            302E383538372C302E3035372C2D312E3337303163302E323038382C2D302E32
            3935342C302E353434322C2D302E343634392C302E393230342C2D302E343634
            3963302E323533392C302C302E343933362C302E303737312C302E373135332C
            302E313632336C372E353039362C322E3537353163302E303932362C302E3033
            32382C302E3137392C302E303638352C302E323630332C302E31303636563048
            307632346831372E323534344331372E323138382C32332E393239382C31372E
            313834332C32332E383535382C31372E313532342C32332E373733347A222F3E
            0D0A09093C2F636C6970506174683E0D0A3C672069643D2269636F6E2220636C
            69702D706174683D2275726C2823636C69705F6D61736B292220786D6C3A7370
            6163653D227072657365727665223E2020202020203C672069643D227472616E
            73666F726D65645F69636F6E22207472616E73666F726D3D227472616E736C61
            7465282D31202D31292220786D6C3A73706163653D227072657365727665223E
            262331333B262331303B3C7061746820643D224D312E303032332C32312E3234
            37374C312E303531332C352E3863302E303030382C2D302E323631342C302E31
            3337362C2D302E353033352C302E333631312C2D302E3633396C342E34303834
            2C2D332E3035323443352E3933382C322E303337362C362E303732352C322C36
            2E323039362C326831362E3034303563302E343134322C302C302E373439392C
            302E333335382C302E373439392C302E373439397631342E3034323363302C30
            2E313335392C2D302E303336392C302E323639332C2D302E313036392C302E33
            3835384C31392E392C32312E36333539632D302E313335352C302E323235392C
            2D302E333739362C302E333634312C2D302E363433312C302E3336343148312E
            3735323343312E333337322C32322C312E3030312C32312E363632382C312E30
            3032332C32312E323437377A222066696C6C3D2223443141443935222F3E0D0A
            3C7061746820643D224D31392E392C32312E363335396C302E312C2D302E3134
            383956352E373037316C322E393937392C2D322E3939386C302C30632D302E30
            3230362C2D302E333831352C2D302E333235362C2D302E363836342C2D302E37
            30372C2D302E3730376C302C304C31392E323932392C3548312E3634356C2D30
            2E323332362C302E313631632D302E323233352C302E313335352C2D302E3336
            30332C302E333737362C2D302E333631312C302E3633396C2D302E303030362C
            302E3248313976313668302E323536394331392E353230342C32322C31392E37
            3634352C32312E383631382C31392E392C32312E363335397A222066696C6C3D
            222346464646464622206F7061636974793D22302E3736222F3E0D0A3C706174
            6820643D224D32322E32352C324832312E346C2D352E363331372C332E323138
            36632D302E323632362C302E313832352C2D302E3435382C302E343436322C2D
            302E353536312C302E373530364C31302E352C323268382E3735363963302E32
            3633342C302C302E353037352C2D302E313338322C302E363433312C2D302E33
            3634316C322E393933312C2D342E3435373863302E303639392C2D302E313136
            362C302E313036392C2D302E323439392C302E313036392C2D302E3338353856
            322E37354332332C322E333335382C32322E363634322C322C32322E32352C32
            7A222066696C6C3D222332343238324422206F7061636974793D22302E303822
            2F3E0D0A3C7061746820643D224D31352E352C326C2D332E352C332E3576342E
            3136323563302C302E313836342C2D302E313531312C302E333337352C2D302E
            333337352C302E33333735682D322E33323543392E313531312C31302C392C39
            2E383438392C392C392E3636323556352E356C352E303632352C2D332E354831
            352E357A222066696C6C2D72756C653D226576656E6F6464222066696C6C3D22
            23384537323545222F3E0D0A3C7061746820643D224D31312E333632312C3230
            48332E36383334632D302E333735392C302C2D302E363833342C2D302E333037
            352C2D302E363833342C2D302E36383334762D352E36323563302C2D302E3337
            35392C302E333037352C2D302E363833342C302E363833342C2D302E36383334
            68372E3637383763302E333735392C302C302E363833342C302E333037352C30
            2E363833342C302E3638333476352E3632354331322E303435352C31392E3639
            32352C31312E373337392C32302C31312E333632312C32307A222066696C6C3D
            2223453645394545222F3E0D0A3C7061746820643D224D342E313932322C3138
            2E38333437682D302E31373536632D302E313037332C302C2D302E313934322C
            2D302E3038372C2D302E313934322C2D302E31393432762D342E323732376330
            2C2D302E313037332C302E3038372C2D302E313934322C302E313934322C2D30
            2E3139343268302E3137353663302E313037332C302C302E313934322C302E30
            38372C302E313934322C302E3139343276342E3237323743342E333836342C31
            382E373437382C342E323939342C31382E383334372C342E313932322C31382E
            383334377A4D31312E322C31382E36343035762D342E3237323763302C2D302E
            313037332C2D302E3038372C2D302E313934322C2D302E313934322C2D302E31
            393432682D302E31373536632D302E313037332C302C2D302E313934322C302E
            3038372C2D302E313934322C302E3139343276342E3237323763302C302E3130
            37332C302E3038372C302E313934322C302E313934322C302E3139343268302E
            313735364331312E3131332C31382E383334372C31312E322C31382E37343738
            2C31312E322C31382E363430357A4D372E323637342C31372E38363336762D33
            2E3439353963302C2D302E313037332C2D302E3038372C2D302E313934322C2D
            302E313934322C2D302E31393432682D302E31373536632D302E313037332C30
            2C2D302E313934322C302E3038372C2D302E313934322C302E3139343276332E
            3439353963302C302E313037332C302E3038372C302E313934322C302E313934
            322C302E3139343268302E3137353643372E313830342C31382E303537392C37
            2E323637342C31372E393730392C372E323637342C31372E383633367A4D382E
            333739372C31372E38363336762D332E3439353963302C2D302E313037332C2D
            302E3038372C2D302E313934322C2D302E313934322C2D302E31393432682D30
            2E31373536632D302E313037332C302C2D302E313934322C302E3038372C2D30
            2E313934322C302E3139343276332E3439353963302C302E313037332C302E30
            38372C302E313934322C302E313934322C302E3139343268302E313735364338
            2E323932372C31382E303537392C382E333739372C31372E393730392C382E33
            3739372C31372E383633367A4D392E363833342C31342E31373336682D302E33
            353133632D302E323134352C302C2D302E333838342C302E313733392C2D302E
            333838342C302E3338383476332E3130373463302C302E323134352C302E3137
            33392C302E333838342C302E333838342C302E3338383468302E333531336330
            2E323134352C302C302E333838342C2D302E313733392C302E333838342C2D30
            2E333838345631342E3536324331302E303731392C31342E333437352C392E38
            39382C31342E313733362C392E363833342C31342E313733367A4D352E363930
            322C31342E31373336682D302E33353133632D302E323134352C302C2D302E33
            3838342C302E313733392C2D302E333838342C302E3338383476332E31303734
            63302C302E323134352C302E313733392C302E333838342C302E333838342C30
            2E3338383468302E3335313363302E323134352C302C302E333838342C2D302E
            313733392C302E333838342C2D302E333838345631342E35363243362E303738
            362C31342E333437352C352E393034372C31342E313733362C352E363930322C
            31342E313733367A222066696C6C3D2223353336383830222F3E0D0A3C706174
            6820643D224D362E303036332C31382E38333437682D302E37333937632D302E
            313037332C302C2D302E313934322C2D302E3038372C2D302E313934322C2D30
            2E313934326C302C3063302C2D302E313037332C302E3038372C2D302E313934
            322C302E313934322C2D302E3139343268302E3733393763302E313037332C30
            2C302E313934322C302E3038372C302E313934322C302E313934326C302C3043
            362E323030352C31382E373437382C362E313133352C31382E383334372C362E
            303036332C31382E383334377A4D382E303434362C31382E363430354C382E30
            3434362C31382E3634303563302C2D302E313037332C2D302E3038372C2D302E
            313934322C2D302E313934322C2D302E31393432682D302E37333937632D302E
            313037332C302C2D302E313934322C302E3038372C2D302E313934322C302E31
            3934326C302C3063302C302E313037332C302E3038372C302E313934322C302E
            313934322C302E3139343268302E3733393743372E393537372C31382E383334
            372C382E303434362C31382E373437382C382E303434362C31382E363430357A
            4D31302E303731392C31382E363430354C31302E303731392C31382E36343035
            63302C2D302E313037332C2D302E3038372C2D302E313934322C2D302E313934
            322C2D302E31393432682D302E37333937632D302E313037332C302C2D302E31
            3934322C302E3038372C2D302E313934322C302E313934326C302C3063302C30
            2E313037332C302E3038372C302E313934322C302E313934322C302E31393432
            68302E3733393743392E393834392C31382E383334372C31302E303731392C31
            382E373437382C31302E303731392C31382E363430357A222066696C6C3D2223
            414142324244222F3E0D0A0909093C2F673E0D0A09093C2F673E0D0A3C672069
            643D226F7665726C61792220786D6C3A73706163653D22707265736572766522
            3E262331333B262331303B3C7061746820643D224D32332E343135342C31382E
            303838346C2D372E353237362C2D322E35383132632D302E353134382C2D302E
            313939382C2D302E353934322C2D302E3132372C2D302E343035372C302E3430
            35316C322E363033312C372E3530303763302E323134342C302E353534372C30
            2E343934362C302E353535392C302E383432372C2D302E303131356C312E3331
            31352C2D322E313436316C322E373231322C322E36393663302E323831342C30
            2E323831312C312E323730392C2D302E373336342C302E393839352C2D312E30
            3137356C2D322E363934362C2D322E363933356C322E313438332C2D312E3331
            30314332342E3032312C31382E353330352C32342E3032312C31382E33303237
            2C32332E343135342C31382E303838347A222066696C6C2D72756C653D226576
            656E6F6464222066696C6C3D2223414142324244222F3E0D0A3C706174682064
            3D224D31382E303835322C32332E3431323963302E323134342C302E35353437
            2C302E343934362C302E353535392C302E383432372C2D302E303131356C312E
            333131352C2D322E313436316C322E373231322C322E36393663302E31333831
            2C302E3133382C302E343436362C2D302E303337312C302E363931392C2D302E
            323834316C2D382E323536312C2D382E313835632D302E303231362C302E3037
            37362C302E303039392C302E323136322C302E303835372C302E34334C31382E
            303835322C32332E343132397A222066696C6C2D72756C653D226576656E6F64
            64222066696C6C3D222338453934394322206F7061636974793D22302E35222F
            3E0D0A09093C2F673E0D0A093C2F673E0D0A3C2F7376673E0D0A}
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          PaintStyle = bpsGlyph
          ParentShowHint = False
          ShowHint = True
          SpeedButtonOptions.Flat = True
          SpeedButtonOptions.Transparent = True
          TabOrder = 4
          Visible = False
          OnClick = AsignarAlmacenButtonClick
        end
      end
    end
    object TopPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      Constraints.MaxHeight = 320
      Constraints.MinHeight = 63
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 0
      Transparent = True
      DesignSize = (
        994
        63)
      Height = 63
      Width = 994
      object FechaCtrl: TcxDBDateEdit
        Left = 127
        Top = 4
        DataBinding.DataField = 'Fecha'
        DataBinding.DataSource = MovimientoDataSource
        Properties.Required = True
        Properties.OnValidate = FechaCtrlPropertiesValidate
        TabOrder = 0
        Width = 100
      end
      object Label3: TcxLabel
        Left = 7
        Top = 9
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object TopScrollBox: TcxScrollBox
        Left = 2
        Top = 31
        Width = 430
        Height = 27
        Anchors = [akLeft, akTop, akBottom]
        AutoScroll = False
        BorderStyle = cxcbsNone
        Color = cl3DLight
        HorzScrollBar.Range = 0
        HorzScrollBar.Visible = False
        ParentColor = False
        TabOrder = 1
        Transparent = True
        VertScrollBar.Increment = 27
        VertScrollBar.Range = 110
        object FechaAplicacionPanel: TgxScrollBoxPanel
          Left = 0
          Top = 54
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 2
          Transparent = True
          Height = 27
          Width = 413
          object FechaAplicacionCtrl: TcxDBDateEdit
            Left = 126
            Top = 1
            DataBinding.DataField = 'FechaAplicacion'
            DataBinding.DataSource = MovimientoDataSource
            Properties.Required = True
            Properties.OnValidate = FechaAplicacionCtrlPropertiesValidate
            TabOrder = 0
            Width = 100
          end
          object FechaAplicacionCaptionLabel: TcxLabel
            Left = 6
            Top = 4
            TabStop = False
            Caption = 'Fecha de recepci'#243'n'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object CentroCostePanel: TgxScrollBoxPanel
          Left = 0
          Top = 27
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Transparent = True
          Height = 27
          Width = 413
          object CentroCosteCtrl: TcxDBTextEdit
            Left = 126
            Top = 1
            DescriptionLabel = Label4
            DataBinding.DataField = 'CentroCoste'
            DataBinding.DataSource = MovimientoDataSource
            Properties.OnQueryRequest = CentroCosteCtrlPropertiesQueryRequest
            Properties.OnEditRequest = CentroCosteCtrlPropertiesEditRequest
            Properties.OnValidate = CentroCosteCtrlPropertiesValidate
            TabOrder = 0
            Width = 40
          end
          object Label4: TcxLabel
            Left = 246
            Top = 3
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
            Height = 19
            Width = 194
          end
          object Label12: TcxLabel
            Left = 6
            Top = 3
            TabStop = False
            Caption = 'Centro de coste'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
        end
        object RegistroAuxiliarPanel: TgxScrollBoxPanel
          Left = 0
          Top = 0
          Align = alTop
          Ctl3D = False
          PanelStyle.Active = True
          ParentCtl3D = False
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Transparent = True
          Height = 27
          Width = 413
          object RegistroAuxiliarCtrl: TcxDBTextEdit
            Left = 126
            Top = 1
            DescriptionLabel = Label14
            DataBinding.DataField = 'RegistroAuxiliar'
            DataBinding.DataSource = MovimientoDataSource
            Properties.OnQueryRequest = RegistroAuxiliarCtrlPropertiesQueryRequest
            Properties.OnEditRequest = RegistroAuxiliarCtrlPropertiesEditRequest
            Properties.OnValidate = RegistroAuxiliarCtrlPropertiesValidate
            TabOrder = 0
            Width = 34
          end
          object Label14: TcxLabel
            Left = 246
            Top = 4
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
            Height = 19
            Width = 194
          end
          object RegistroAuxiliarLabel: TcxLabel
            Left = 6
            Top = 4
            TabStop = False
            Caption = 'Registro auxiliar'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
        end
        object OperarioPanel: TgxScrollBoxPanel
          Left = 0
          Top = 81
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 3
          Height = 27
          Width = 413
          object CodigoOperarioCtrl: TcxDBTextEdit
            Left = 126
            Top = 1
            DescriptionLabel = NombreOperarioLabel
            DataBinding.DataField = 'CodigoOperario'
            DataBinding.DataSource = MovimientoDataSource
            Properties.OnQueryRequest = CodigoOperarioCtrlPropertiesQueryRequest
            Properties.OnEditRequest = CodigoOperarioCtrlPropertiesEditRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = CodigoOperarioCtrlPropertiesValidate
            TabOrder = 0
            Width = 43
          end
          object NombreOperarioLabel: TcxLabel
            Left = 246
            Top = 3
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
            Height = 19
            Width = 194
          end
          object cxLabel2: TcxLabel
            Left = 6
            Top = 3
            TabStop = False
            Caption = 'Operario'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
        end
      end
      object AnotacionButton: TgBitBtn
        Left = 229
        Top = 5
        Width = 28
        Height = 24
        Hint = 'Mostrar la anotaci'#243'n del documento'
        Enabled = True
        OptionsImage.ImageIndex = 66
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 2
        TabStop = False
        OnClick = AnotacionButtonClick
        GlyphBitmap = gmComment
      end
      object CamposLibresScrollBox: TcxScrollBox
        Left = 435
        Top = 3
        Width = 357
        Height = 52
        Anchors = [akLeft, akTop, akBottom]
        AutoScroll = False
        BorderStyle = cxcbsNone
        HorzScrollBar.Range = 0
        HorzScrollBar.Visible = False
        TabOrder = 5
        Transparent = True
        VertScrollBar.Increment = 27
        VertScrollBar.Range = 146
        VertScrollBar.Tracking = True
        object CLScrollBoxPanel5: TgxScrollBoxPanel
          Left = 0
          Top = 108
          Align = alTop
          Ctl3D = False
          PanelStyle.Active = True
          ParentCtl3D = False
          Style.BorderStyle = ebsNone
          TabOrder = 4
          Visible = False
          Height = 27
          Width = 340
          object CampoLibre5Ctrl: TcxDBTextEdit
            Left = 115
            Top = 1
            CaptionLabel = CLLabel5
            DataBinding.DataField = 'CampoLibre5'
            DataBinding.DataSource = MovimientoDataSource
            TabOrder = 0
            Width = 220
          end
          object CLLabel5: TcxLabel
            Left = 6
            Top = 4
            TabStop = False
            AutoSize = False
            Caption = 'Campo libre 5'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
            Height = 17
            Width = 110
          end
        end
        object CLScrollBoxPanel4: TgxScrollBoxPanel
          Left = 0
          Top = 81
          Align = alTop
          Ctl3D = False
          PanelStyle.Active = True
          ParentCtl3D = False
          Style.BorderStyle = ebsNone
          TabOrder = 3
          Visible = False
          Height = 27
          Width = 340
          object CampoLibre4Ctrl: TcxDBTextEdit
            Left = 115
            Top = 1
            CaptionLabel = CLLabel4
            DataBinding.DataField = 'CampoLibre4'
            DataBinding.DataSource = MovimientoDataSource
            TabOrder = 0
            Width = 220
          end
          object CLLabel4: TcxLabel
            Left = 6
            Top = 4
            TabStop = False
            AutoSize = False
            Caption = 'Campo libre 4'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
            Height = 17
            Width = 110
          end
        end
        object CLScrollBoxPanel3: TgxScrollBoxPanel
          Left = 0
          Top = 54
          Align = alTop
          Ctl3D = False
          PanelStyle.Active = True
          ParentCtl3D = False
          Style.BorderStyle = ebsNone
          TabOrder = 2
          Visible = False
          Height = 27
          Width = 340
          object CampoLibre3Ctrl: TcxDBTextEdit
            Left = 115
            Top = 1
            CaptionLabel = CLLabel3
            DataBinding.DataField = 'CampoLibre3'
            DataBinding.DataSource = MovimientoDataSource
            TabOrder = 0
            Width = 220
          end
          object CLLabel3: TcxLabel
            Left = 6
            Top = 4
            TabStop = False
            AutoSize = False
            Caption = 'Campo libre 3'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
            Height = 17
            Width = 110
          end
        end
        object CLScrollBoxPanel1: TgxScrollBoxPanel
          Left = 0
          Top = 0
          Align = alTop
          Ctl3D = False
          PanelStyle.Active = True
          ParentCtl3D = False
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Visible = False
          Height = 27
          Width = 340
          object CampoLibre1Ctrl: TcxDBTextEdit
            Left = 115
            Top = 1
            CaptionLabel = CLLabel1
            DataBinding.DataField = 'CampoLibre1'
            DataBinding.DataSource = MovimientoDataSource
            TabOrder = 0
            Width = 220
          end
          object CLLabel1: TcxLabel
            Left = 6
            Top = 4
            TabStop = False
            AutoSize = False
            Caption = 'Campo libre 1'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
            Height = 17
            Width = 110
          end
        end
        object CLScrollBoxPanel2: TgxScrollBoxPanel
          Left = 0
          Top = 27
          Align = alTop
          Ctl3D = False
          PanelStyle.Active = True
          ParentCtl3D = False
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Visible = False
          Height = 27
          Width = 340
          object CampoLibre2Ctrl: TcxDBTextEdit
            Left = 115
            Top = 1
            CaptionLabel = CLLabel2
            DataBinding.DataField = 'CampoLibre2'
            DataBinding.DataSource = MovimientoDataSource
            TabOrder = 0
            Width = 220
          end
          object CLLabel2: TcxLabel
            Left = 6
            Top = 4
            TabStop = False
            AutoSize = False
            Caption = 'Campo libre 2'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
            Height = 17
            Width = 110
          end
        end
      end
      object cxGroupBox1: TcxGroupBox
        Left = 906
        Top = 0
        Align = alRight
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 4
        Height = 63
        Width = 88
        object ImportarButton: TgBitBtn
          AlignWithMargins = True
          Left = 0
          Top = 31
          Width = 84
          Height = 32
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 4
          Margins.Bottom = 0
          Align = alBottom
          Caption = '&Importar'
          Enabled = True
          OptionsImage.ImageIndex = 31
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 4
          OptionsImage.Spacing = 5
          TabOrder = 0
          TabStop = False
          OnClick = importarButtonClick
          GlyphBitmap = gmImport
        end
        object PreciosButton: TgBitBtn
          AlignWithMargins = True
          Left = 0
          Top = -1
          Width = 84
          Height = 32
          Hint = 
            'Rejilla de c'#225'lculo de precios de venta a partir del precio de co' +
            'mpra y su margen comercial.'
          Margins.Left = 0
          Margins.Right = 4
          Margins.Bottom = 0
          Align = alBottom
          Caption = 'P&recios'
          Enabled = True
          OptionsImage.ImageIndex = 55
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 4
          OptionsImage.Spacing = 5
          TabOrder = 1
          TabStop = False
          OnClick = PreciosButtonClick
          GlyphBitmap = gmWindowList
        end
      end
    end
    object Grid: TcxGrid
      Left = 2
      Top = 73
      Width = 956
      Height = 320
      Align = alClient
      TabOrder = 1
      OnExit = GridExit
      object GridView: TcxGridDBTableView
        PopupMenu = RejillaPopupMenu
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellClick = GridViewCellClick
        OnCellDblClick = GridViewCellDblClick
        OnCustomDrawCell = GridViewCustomDrawCell
        OnFocusedItemChanged = GridViewFocusedItemChanged
        OnFocusedRecordChanged = GridViewFocusedRecordChanged
        OnInitEdit = GridViewInitEdit
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = LineaMovimientoDataSource
        DataController.KeyFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems.OnSummary = GridViewFooterSummaryItems
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            FieldName = 'Cantidad'
            Column = GridViewCantidad
          end
          item
            FieldName = 'CantidadProcesada'
            Column = GridViewRecibido
          end
          item
            Kind = skSum
            FieldName = 'Peso'
            Column = GridViewPeso
          end
          item
            Kind = skSum
            FieldName = 'ImporteNeto'
            Column = GridViewImporte
          end
          item
            Kind = skSum
            FieldName = 'CuotaIVA'
          end>
        DataController.Summary.SummaryGroups = <>
        DataController.Summary.OnAfterSummary = GridViewAfterSummary
        OptionsBehavior.PostponedSynchronization = False
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.FocusFirstCellOnNewRecord = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsBehavior.PullFocusing = True
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Appending = True
        OptionsData.DeletingConfirmation = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.FooterAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Preview.Column = GridViewAnotacion
        object GridViewCodigoArticulo: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CodigoArticulo'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Required = True
          Properties.OnQueryRequest = GridViewCodigoArticuloPropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoArticuloPropertiesEditRequest
          Properties.OnValuePosted = GridViewCodigoArticuloPropertiesValuePosted
          Properties.OnValidate = GridViewCodigoArticuloPropertiesValidate
          Width = 78
        end
        object GridViewCodigoClaseA: TcxGridDBColumn
          Tag = 1
          Caption = 'ClsA'
          DataBinding.FieldName = 'CodigoClaseA'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCodigoClasePropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoClasePropertiesEditRequest
          Properties.OnValidate = GridViewCodigoClasePropertiesValidate
          Visible = False
          Width = 21
        end
        object GridViewCodigoClaseB: TcxGridDBColumn
          Tag = 2
          Caption = 'ClsB'
          DataBinding.FieldName = 'CodigoClaseB'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCodigoClasePropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoClasePropertiesEditRequest
          Properties.OnValidate = GridViewCodigoClasePropertiesValidate
          Visible = False
          Width = 21
        end
        object GridViewCodigoClaseC: TcxGridDBColumn
          Tag = 3
          Caption = 'ClsC'
          DataBinding.FieldName = 'CodigoClaseC'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCodigoClasePropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoClasePropertiesEditRequest
          Properties.OnValidate = GridViewCodigoClasePropertiesValidate
          Visible = False
          Width = 21
        end
        object GridViewLoteFabricacion: TcxGridDBColumn
          Caption = 'Lote'
          DataBinding.FieldName = 'LoteFabricacion'
          PropertiesClassName = 'TcxTextEditProperties'
          Visible = False
        end
        object GridViewNumeroSerie: TcxGridDBColumn
          Caption = 'N'#186' serie'
          DataBinding.FieldName = 'NumeroSerie'
          PropertiesClassName = 'TcxTextEditProperties'
          Visible = False
          MinWidth = 40
          Width = 180
        end
        object GridViewFechaCaducidad: TcxGridDBColumn
          Caption = 'Caducidad'
          DataBinding.FieldName = 'FechaCaducidad'
          Visible = False
          Width = 90
        end
        object GridViewFechaAplicacion: TcxGridDBColumn
          Caption = 'Fecha recep.'
          DataBinding.FieldName = 'FechaAplicacion'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.SaveTime = False
          Visible = False
          HeaderHint = 'Fecha de recepci'#243'n'
          Width = 80
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 348
        end
        object GridViewTipoLinea: TcxGridDBColumn
          Caption = 'Tipo'
          DataBinding.FieldName = 'TipoLinea'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewTipoLineaPropertiesQueryRequest
          Properties.OnEditRequest = GridViewTipoLineaPropertiesEditRequest
          Properties.OnValidate = GridViewTipoLineaPropertiesValidate
          Visible = False
          Width = 35
        end
        object GridViewCodigoAlmacen: TcxGridDBColumn
          Caption = 'Alm.'
          DataBinding.FieldName = 'CodigoAlmacen'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnEnter = GridViewCodigoAlmacenPropertiesEnter
          Properties.OnQueryRequest = GridViewCodigoAlmacenPropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoAlmacenPropertiesEditRequest
          Properties.OnValuePosted = GridViewCodigoAlmacenPropertiesValuePosted
          Properties.OnValidate = GridViewCodigoAlmacenPropertiesValidate
          Visible = False
          Width = 29
        end
        object GridViewUbicacion: TcxGridDBColumn
          Caption = 'Ubicac.'
          DataBinding.FieldName = 'Ubicacion'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewUbicacionPropertiesQueryRequest
          Properties.OnEditRequest = GridViewUbicacionPropertiesEditRequest
          Properties.OnValidate = GridViewUbicacionPropertiesValidate
          Visible = False
        end
        object GridViewLargo: TcxGridDBColumn
          DataBinding.FieldName = 'Largo'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValuePosted = GridViewDimensionPropertiesValuePosted
          Visible = False
          Width = 50
        end
        object GridViewAncho: TcxGridDBColumn
          DataBinding.FieldName = 'Ancho'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValuePosted = GridViewDimensionPropertiesValuePosted
          Visible = False
          Width = 50
        end
        object GridViewAlto: TcxGridDBColumn
          DataBinding.FieldName = 'Alto'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValuePosted = GridViewDimensionPropertiesValuePosted
          Visible = False
          Width = 50
        end
        object GridViewNroCajas: TcxGridDBColumn
          Caption = 'Cajas'
          DataBinding.FieldName = 'NroCajas'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValuePosted = GridViewNroCajasPropertiesValuePosted
          Properties.Nullable = False
          Visible = False
          Width = 50
        end
        object GridViewBultos: TcxGridDBColumn
          DataBinding.FieldName = 'Bultos'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValuePosted = GridViewUpdatePropertiesValuePosted
          Properties.AssignedValues.DisplayFormat = True
          Properties.Nullable = False
          Visible = False
          Width = 50
        end
        object GridViewPesoEnvase: TcxGridDBColumn
          Caption = 'Peso env.'
          DataBinding.FieldName = 'PesoEnvase'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValuePosted = GridViewPesoEnvasePropertiesValuePosted
          Visible = False
          HeaderHint = 'Peso unitario del envase'
          Width = 75
        end
        object GridViewTara: TcxGridDBColumn
          DataBinding.FieldName = 'Tara'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Visible = False
          Options.Editing = False
          Options.Focusing = False
          Width = 75
        end
        object GridViewPeso: TcxGridDBColumn
          DataBinding.FieldName = 'Peso'
          Visible = False
          Width = 75
        end
        object GridViewCantidad: TcxGridDBColumn
          DataBinding.FieldName = 'Cantidad'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValuePosted = GridViewCantidadPropertiesValuePosted
          Properties.OnValidate = GridViewCantidadPropertiesValidate
          Width = 80
        end
        object GridViewRecibido: TcxGridDBColumn
          Caption = 'Recibido'
          DataBinding.FieldName = 'CantidadProcesada'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValuePosted = GridViewRecibidoPropertiesValuePosted
          Visible = False
          OnGetDataText = GridViewRecibidoGetDataText
          Options.Editing = False
          Options.Focusing = False
          Width = 80
        end
        object GridViewProcesada: TcxGridDBColumn
          DataBinding.FieldName = 'Procesada'
          Visible = False
          Width = 80
        end
        object GridViewPrecioDivisa: TcxGridDBColumn
          Caption = 'Precio divisa'
          DataBinding.FieldName = 'PrecioDivisa'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnEditRequest = GridViewPrecioDivisaPropertiesEditRequest
          Properties.OnValuePosted = GridViewPrecioDivisaPropertiesValuePosted
          Properties.OnValidate = GridViewPrecioDivisaPropertiesValidate
          Visible = False
          Width = 80
        end
        object GridViewPrecio: TcxGridDBColumn
          DataBinding.FieldName = 'Precio'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnEnter = GridViewPrecioPropertiesEnter
          Properties.OnExtendedFunction = GridViewPrecioPropertiesExtendedFunction
          Properties.OnValuePosted = GridViewUpdatePropertiesValuePosted
          Width = 80
        end
        object GridViewPuntoVerde: TcxGridDBColumn
          Caption = 'EcoTasa'
          DataBinding.FieldName = 'PuntoVerde'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValuePosted = GridViewUpdatePropertiesValuePosted
          Properties.OnValidate = GridViewPuntoVerdePropertiesValidate
          Visible = False
        end
        object GridViewDescuento: TcxGridDBColumn
          Caption = '% Dto.'
          DataBinding.FieldName = 'Descuento'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValuePosted = GridViewUpdatePropertiesValuePosted
          Properties.MaxLength = 6
          Properties.MaxValue = 100.000000000000000000
          Properties.MinValue = -100.000000000000000000
          Width = 48
        end
        object GridViewImporte: TcxGridDBColumn
          Caption = 'Importe'
          DataBinding.FieldName = 'ImporteNeto'
          OnGetCellHint = GridViewImporteGetCellHint
          OnGetDisplayText = GridViewImporteGetDisplayText
          Options.Editing = False
          Options.Focusing = False
          Width = 100
        end
        object GridViewDocumentoOrigen: TcxGridDBColumn
          Caption = 'Orig.'
          DataBinding.FieldName = 'TieneRegistroOrigen'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.DisplayGrayed = 'False'
          Properties.Glyph.SourceDPI = 96
          Properties.Glyph.Data = {
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
            20783D223070782220793D22307078222077696474683D2233382E3337373435
            3322206865696768743D2231392E323134353038222076696577426F783D2230
            20302033382E3337373435332031392E3231343530382220656E61626C652D62
            61636B67726F756E643D226E6577203020302032342032342220736F6469706F
            64693A646F636E616D653D22676F746F2D6C6566742D677269642E7376672220
            696E6B73636170653A76657273696F6E3D22302E39322E322028356333653830
            642C20323031372D30382D303629223E0D0A093C6D657461646174612069643D
            226D657461646174613138223E0D0A09093C7264663A5244463E0D0A0909093C
            63633A576F726B207264663A61626F75743D22223E0D0A090909093C64633A66
            6F726D61743E696D6167652F7376672B786D6C3C2F64633A666F726D61743E0D
            0A090909093C64633A74797065207264663A7265736F757263653D2268747470
            3A2F2F7075726C2E6F72672F64632F64636D69747970652F5374696C6C496D61
            6765222F3E0D0A090909093C64633A7469746C652F3E0D0A0909093C2F63633A
            576F726B3E0D0A09093C2F7264663A5244463E0D0A093C2F6D65746164617461
            3E0D0A093C646566732069643D22646566733136222F3E0D0A093C736F646970
            6F64693A6E616D6564766965772070616765636F6C6F723D2223666666666666
            2220626F72646572636F6C6F723D22233636363636362220626F726465726F70
            61636974793D223122206F626A656374746F6C6572616E63653D223130222067
            726964746F6C6572616E63653D22313022206775696465746F6C6572616E6365
            3D2231302220696E6B73636170653A706167656F7061636974793D2230222069
            6E6B73636170653A70616765736861646F773D22322220696E6B73636170653A
            77696E646F772D77696474683D22313634302220696E6B73636170653A77696E
            646F772D6865696768743D22383537222069643D226E616D6564766965773134
            222073686F77677269643D2266616C73652220696E6B73636170653A7A6F6F6D
            3D2232312E3539313831312220696E6B73636170653A63783D2231382E303634
            3138352220696E6B73636170653A63793D22392E303536393939352220696E6B
            73636170653A77696E646F772D783D22302220696E6B73636170653A77696E64
            6F772D793D22352220696E6B73636170653A77696E646F772D6D6178696D697A
            65643D22302220696E6B73636170653A63757272656E742D6C617965723D224C
            617965725F31222F3E0D0A093C72656374207374796C653D226F706163697479
            3A313B66696C6C3A236666666666663B66696C6C2D6F7061636974793A303B73
            74726F6B653A6E6F6E653B7374726F6B652D77696474683A302E313B7374726F
            6B652D6D697465726C696D69743A343B7374726F6B652D646173686172726179
            3A6E6F6E653B7374726F6B652D6F7061636974793A31222069643D2272656374
            383238222077696474683D2233382E33373734353322206865696768743D2231
            392E3231343530382220783D22302220793D2230222F3E0D0A093C672069643D
            2269636F6E22207472616E73666F726D3D226D617472697828302E382C302C30
            2C302E382C31392E3139353934362C302E303737383731303929223E0D0A0909
            3C636972636C652069643D22636972636C653834382220723D22313022206379
            3D223132222063783D22313222207374796C653D2266696C6C3A236637663866
            39222F3E0D0A09093C706174682069643D22706174683835302220643D224D20
            31392E373738322C342E323231382031382E353736312C352E34323339204320
            32302E323539312C372E313036392032312E332C392E343331392032312E332C
            3132206320302C352E31333632202D342E313633382C392E33202D392E332C39
            2E33202D322E353638312C30202D342E383933312C2D312E30343039202D362E
            353736312C2D322E37323339204C20342E323231382C31392E37373832204320
            362E323132342C32312E3736383820382E393632342C32332031322C32332031
            382E303735312C32332032332C31382E303735312032332C31322032332C382E
            393632342032312E373638382C362E323132342031392E373738322C342E3232
            3138205A2220696E6B73636170653A636F6E6E6563746F722D63757276617475
            72653D223022207374796C653D2266696C6C3A23383539316131222F3E0D0A09
            093C706174682069643D22706174683835322220643D224D20342E393238392C
            31392E30373131204320362E373338362C32302E3838303720392E323338362C
            32322031322C32322031372E353232382C32322032322C31372E353232382032
            322C31322032322C392E323338362032302E383830372C362E37333836203139
            2E303731312C342E39323839205A2220696E6B73636170653A636F6E6E656374
            6F722D6375727661747572653D223022207374796C653D226F7061636974793A
            302E30353B66696C6C3A23316332303235222F3E0D0A09093C70617468206964
            3D22706174683835342220643D224D20352E343233392C31382E353736312043
            20332E373430392C31362E3839333120322E372C31342E3536383120322E372C
            313220322E372C362E3836333820362E383633382C322E372031322C322E3720
            6320322E353638312C3020342E383933312C312E3034303920362E353736312C
            322E37323339204C2031392E373738322C342E3232313820432031372E373837
            362C322E323331322031352E303337362C312031322C3120352E393234392C31
            20312C352E3932343920312C3132206320302C332E3033373620312E32333132
            2C352E3738373620332E323231382C372E37373832207A2220696E6B73636170
            653A636F6E6E6563746F722D6375727661747572653D223022207374796C653D
            2266696C6C3A23393961326166222F3E0D0A09093C706174682069643D227061
            74683835362220643D224D20362E313136372C31312E363434352031312E3931
            352C352E38343632206320302E313535362C2D302E3135353620302E34313031
            2C2D302E3135353620302E353635372C30206C20302E383438352C302E383438
            35206320302E313535362C302E3135353620302E313535362C302E3434353420
            302C302E36303039204C20392E363630312C3131206820382E30313935206320
            302E32322C3020302E343230342C302E3130393520302E343230342C302E3332
            3935207620312E3220432031382E312C31322E373439352031372E383939362C
            31332031372E363739362C3133204820392E36363435206C20332E363634372C
            332E36323934206320302E313535362C302E3135353620302E313535362C302E
            3339323520302C302E35343831206C202D302E383438352C302E383339372063
            202D302E313535362C302E31353536202D302E343130312C302E31353132202D
            302E353635372C2D302E30303434204C20362E393635332C31332E3036303920
            362E313136382C31322E32313133204320352E393631312C31322E3035353720
            352E393631312C31312E3820362E313136372C31312E36343435205A2220696E
            6B73636170653A636F6E6E6563746F722D6375727661747572653D2230222073
            74796C653D2266696C6C3A23383539316131222F3E0D0A093C2F673E0D0A3C2F
            7376673E0D0A}
          Properties.GlyphCount = 2
          HeaderHint = 
            'Si se muestra un bot'#243'n, '#233'ste da acceso a la l'#237'nea del documento ' +
            'que origin'#243' este registro'
          MinWidth = 35
          Options.Editing = False
          Options.Focusing = False
          Width = 35
        end
        object GridViewNroRegistro: TcxGridDBColumn
          DataBinding.FieldName = 'NroRegistro'
          Visible = False
        end
        object GridViewNroRegistroOrigen: TcxGridDBColumn
          DataBinding.FieldName = 'NroRegistroOrigen'
          Visible = False
        end
        object GridViewEjercicioOrigen: TcxGridDBColumn
          DataBinding.FieldName = 'EjercicioOrigen'
          Visible = False
        end
        object GridViewNroOperacionOrigen: TcxGridDBColumn
          DataBinding.FieldName = 'NroOperacionOrigen'
          Visible = False
        end
        object GridViewAnotacion: TcxGridDBColumn
          DataBinding.FieldName = 'Anotacion'
          PropertiesClassName = 'TcxRichEditProperties'
          Properties.StreamModes = [resmPlainRtf, resmUnicode]
        end
        object GridViewCodigoTipoIVA: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoTipoIVA'
          Visible = False
          Options.Editing = False
        end
        object GridViewCuotaIVA: TcxGridDBColumn
          DataBinding.FieldName = 'CuotaIVA'
          Visible = False
        end
        object GridViewCuotaRE: TcxGridDBColumn
          DataBinding.FieldName = 'CuotaRE'
          Visible = False
        end
        object GridViewImporteTotal: TcxGridDBColumn
          DataBinding.FieldName = 'ImporteTotal'
          Visible = False
          OnGetDisplayText = GridViewImporteTotalGetDisplayText
        end
        object GridViewCampoLibre1: TcxGridDBColumn
          DataBinding.FieldName = 'CampoLibre1'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.MaxLength = 40
          Visible = False
        end
        object GridViewCampoLibre2: TcxGridDBColumn
          DataBinding.FieldName = 'CampoLibre2'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.MaxLength = 40
          Visible = False
        end
        object GridViewCampoLibre3: TcxGridDBColumn
          DataBinding.FieldName = 'CampoLibre3'
          PropertiesClassName = 'TcxDateEditProperties'
          Visible = False
          Width = 90
        end
        object GridViewCampoLibre4: TcxGridDBColumn
          DataBinding.FieldName = 'CampoLibre4'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Visible = False
        end
        object GridViewCampoLibre5: TcxGridDBColumn
          DataBinding.FieldName = 'CampoLibre5'
          PropertiesClassName = 'TcxTextEditProperties'
          Visible = False
        end
        object GridViewSerieOrigen: TcxGridDBColumn
          Caption = 'Se.'
          DataBinding.FieldName = 'SerieOrigen'
          Visible = False
        end
        object GridViewNroDocumentoOrigen: TcxGridDBColumn
          Caption = 'N'#186' Doc.'
          DataBinding.FieldName = 'NroDocumentoOrigen'
          Visible = False
          Width = 65
        end
        object GridViewTieneDocumentosAsociados: TcxGridDBColumn
          AlternateCaption = 'Tiene documentos asociados'
          Caption = 'Doc.'
          DataBinding.FieldName = 'TieneDocumentosAsociados'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.Glyph.SourceDPI = 96
          Properties.Glyph.Data = {
            3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
            462D38223F3E0D0A3C7376672076657273696F6E3D22312E312220786D6C6E73
            3D22687474703A2F2F7777772E77332E6F72672F323030302F7376672220786D
            6C6E733A786C696E6B3D22687474703A2F2F7777772E77332E6F72672F313939
            392F786C696E6B2220783D223070782220793D2230707822206865696768743D
            22307078222077696474683D22307078222076696577426F783D223020302034
            30203230223E0D0A093C67207461673D225F64782E6D756C74696672616D652E
            737667223E0D0A09093C726563742069643D2272656374383238222066696C6C
            3D2223464646464646222066696C6C2D6F7061636974793D223022207374726F
            6B653D226E6F6E6522207374726F6B652D77696474683D22302E313034313922
            20783D223070782220793D22302E3034343437707822206865696768743D2231
            392E39353535337078222077696474683D2234302E3131343338707822207278
            3D22307078222072793D22307078222F3E0D0A09093C67207472616E73666F72
            6D3D226D617472697828302E38393434352030203020302E383934343520392E
            333031373320332E323132363729223E0D0A0909093C706174682066696C6C3D
            22234536453945452220643D224D20323820302E383536204C2032362E303539
            202D332E303236204C2031352E353735202D332E30323620432031342E393334
            202D332E3032362031342E3431202D322E3530322031342E3431202D312E3836
            32204C2031342E34312031372E31363420432031342E34312031372E38303520
            31342E3933342031382E3332392031352E3537352031382E333239204C203330
            2E3731382031382E33323920432033312E3335392031382E3332392033312E38
            38332031372E3830352033312E3838332031372E313634204C2033312E383833
            20322E373938204C20323820302E383536205A222F3E0D0A0909093C70617468
            2066696C6C3D22234141423242442220643D224D2032362E303539202D332E30
            3236204C2032362E30353920312E36333320432032362E30353920322E323734
            2032362E35383320322E3739382032372E32323420322E373938204C2033312E
            38383320322E373938204C2032362E303539202D332E303236205A222F3E0D0A
            0909093C67207472616E73666F726D3D226D617472697828302E363530303720
            30203020302E36353030372031372E353930353520322E373336333629223E0D
            0A090909093C706174682066696C6C3D22233544394345432220643D224D2038
            2E323838203231204C20352E373133203231204320352E333139203231203520
            32302E36383120352032302E323837204C20352031332E373132204320352031
            332E33313820352E3331392031322E39393920352E3731332031322E39393920
            4C20382E3238382031322E393939204320382E3638322031322E39393920392E
            3030312031332E33313820392E3030312031332E373132204C20392E30303120
            32302E323837204320392032302E36383120382E36383120323120382E323838
            203231205A222F3E0D0A090909093C706174682066696C6C3D22233442383944
            432220643D224D20382E323838203133204C2037203133204C2037203231204C
            20382E323838203231204320382E36383220323120392E3030312032302E3638
            3120392E3030312032302E323837204C20392E3030312031332E373132204320
            392031332E33313920382E36383120313320382E323838203133205A222F3E0D
            0A090909093C706174682066696C6C3D22233544394345432220643D224D2031
            332E323838203231204C2031302E37313320323120432031302E333139203231
            2031302032302E3638312031302032302E323837204C20313020372E37313320
            4320313020372E3331392031302E33313920372031302E3731332037204C2031
            332E323838203720432031332E36383220372031342E30303120372E33313920
            31342E30303120372E373133204C2031342E3030312032302E32383820432031
            342032302E3638312031332E3638312032312031332E323838203231205A222F
            3E0D0A090909093C706174682066696C6C3D22233442383944432220643D224D
            2031332E3238382037204C2031322037204C203132203231204C2031332E3238
            3820323120432031332E3638322032312031342E3030312032302E3638312031
            342E3030312032302E323837204C2031342E30303120372E3731332043203134
            20372E3331392031332E36383120372031332E3238382037205A222F3E0D0A09
            0909093C706174682066696C6C3D22233544394345432220643D224D2031382E
            323838203231204C2031352E37313320323120432031352E3331392032312031
            352032302E3638312031352032302E323837204C2031352031302E3731322043
            2031352031302E3331382031352E33313920392E3939392031352E3731332039
            2E393939204C2031382E32383820392E39393920432031382E36383220392E39
            39392031392E3030312031302E3331382031392E3030312031302E373132204C
            2031392E3030312032302E32383720432031392032302E3638312031382E3638
            312032312031382E323838203231205A222F3E0D0A090909093C706174682066
            696C6C3D22233442383944432220643D224D2031382E323838203130204C2031
            37203130204C203137203231204C2031382E32383820323120432031382E3638
            322032312031392E3030312032302E3638312031392E3030312032302E323837
            204C2031392E3030312031302E37313220432031392031302E3331392031382E
            3638312031302031382E323838203130205A222F3E0D0A0909093C2F673E0D0A
            0909093C706174682066696C6C3D222332333146323022206F7061636974793D
            22302E30362220643D224D2033312E38383320322E373938204C2032372E3232
            3420322E373938204C2031392E3834362031382E333239204C2033302E373138
            2031382E33323920432033312E3336322031382E3332392033312E3838332031
            372E3830382033312E3838332031372E313634204C2033312E38383320322E37
            3938205A222F3E0D0A0909093C706174682066696C6C3D222336353644373822
            206F7061636974793D22302E352220643D224D2032352E303620342E33303820
            432032352E303620342E30342032342E38343220332E3832332032342E353735
            20332E383233204C2031362E38303920332E38323320432031362E3534312033
            2E3832332031362E33323320342E30342031362E33323320342E333038204320
            31362E33323320342E3537362031362E35343120342E3739342031362E383039
            20342E373934204C2032342E35373520342E37393420432032342E3834322034
            2E3739342032352E303620342E3537362032352E303620342E333038205A204D
            2032352E303620322E33363720432032352E303620322E3039392032342E3834
            3220312E3838322032342E35373520312E383832204C2031362E38303920312E
            38383220432031362E35343120312E3838322031362E33323320322E30393920
            31362E33323320322E33363720432031362E33323320322E3633352031362E35
            343120322E3835322031362E38303920322E383532204C2032342E3537352032
            2E38353220432032342E38343220322E3835322032352E303620322E36333520
            32352E303620322E333637205A204D2032352E303620302E3432352043203235
            2E303620302E3135382032342E383432202D302E30362032342E353735202D30
            2E3036204C2031362E383039202D302E303620432031362E353431202D302E30
            362031362E33323320302E3135382031362E33323320302E3432352043203136
            2E33323320302E3639332031362E35343120302E3931312031362E3830392030
            2E393131204C2032342E35373520302E39313120432032342E38343220302E39
            31312032352E303620302E3639332032352E303620302E343235205A204D2032
            392E39313320362E323520432032392E39313320352E3938322032392E363936
            20352E3736342032392E34323820352E373634204C2031362E38303920352E37
            363420432031362E35343120352E3736342031362E33323320352E3938322031
            362E33323320362E323520432031362E33323320362E3531382031362E353431
            20362E3733352031362E38303920362E373335204C2032392E34323820362E37
            333520432032392E36393620362E3733352032392E39313320362E3531382032
            392E39313320362E3235205A204D2032332E34363420382E3139312043203233
            2E34363420372E3932332032332E32343720372E3730362032322E3937392037
            2E373036204C2031362E38303920372E37303620432031362E35343120372E37
            30362031362E33323320372E3932332031362E33323320382E31393120432031
            362E33323320382E3435392031362E35343120382E3637372031362E38303920
            382E363737204C2032322E39373920382E36373720432032332E32343720382E
            3637372032332E34363420382E3435392032332E34363420382E313931205A20
            4D2032332E3436342031302E31333320432032332E34363420392E3836352032
            332E32343720392E3634372032322E39373920392E363437204C2031362E3830
            3920392E36343720432031362E35343120392E3634372031362E33323320392E
            3836352031362E3332332031302E31333320432031362E3332332031302E3430
            312031362E3534312031302E3631382031362E3830392031302E363138204C20
            32322E3937392031302E36313820432032332E3234372031302E363138203233
            2E3436342031302E3430312032332E3436342031302E313333205A204D203230
            2E3232362031322E30373420432032302E3232362031312E3830362032302E30
            30382031312E3538392031392E37342031312E353839204C2031362E38303920
            31312E35383920432031362E3534312031312E3538392031362E333233203131
            2E3830362031362E3332332031322E30373420432031362E3332332031322E33
            34322031362E3534312031322E3535392031362E3830392031322E353539204C
            2031392E37342031322E35353920432032302E3030382031322E353539203230
            2E3232362031322E3334322032302E3232362031322E303734205A204D203230
            2E3232362031342E30313520432032302E3232362031332E3734382032302E30
            30382031332E35332031392E37342031332E3533204C2031362E383039203133
            2E353320432031362E3534312031332E35332031362E3332332031332E373438
            2031362E3332332031342E30313520432031362E3332332031342E3238332031
            362E3534312031342E3530312031362E3830392031342E353031204C2031392E
            37342031342E35303120432032302E3030382031342E3530312032302E323236
            2031342E3238332032302E3232362031342E303135205A204D2032302E323236
            2031352E39353720432032302E3232362031352E3638392032302E3030382031
            352E3437322031392E37342031352E343732204C2031362E3830392031352E34
            373220432031362E3534312031352E3437322031362E3332332031352E363839
            2031362E3332332031352E39353720432031362E3332332031362E3232352031
            362E3534312031362E3434322031362E3830392031362E343432204C2031392E
            37342031362E34343220432032302E3030382031362E3434322032302E323236
            2031362E3232352032302E3232362031352E393537205A222F3E0D0A09093C2F
            673E0D0A093C2F673E0D0A3C2F7376673E0D0A}
          Properties.GlyphCount = 2
          Visible = False
          HeaderHint = 'Si se muestra indica que la l'#237'nea tiene documentos asociados'
          Width = 34
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object TableViewManager: TGridTableViewController
      Left = 958
      Top = 73
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 2
      TableView = GridView
      ShiftRecords = True
      UseGridFilterBox = False
      OnDelete = TableViewManagerDelete
      OnRowShift = TableViewManagerRowShift
      OnCanDeleteRow = TableViewManagerCanDeleteRow
      OnCanInsertRow = TableViewManagerCanInsertRow
      OnCanShiftRow = TableViewManagerCanShiftRow
      OnCanShowDocument = TableViewManagerCanShowDocument
      Height = 320
      Width = 38
    end
    object DataPanelSplitter: TcxSplitter
      Left = 2
      Top = 65
      Width = 994
      Height = 8
      HotZoneClassName = 'TcxSimpleStyle'
      AlignSplitter = salTop
      MinSize = 8
      Control = TopPanel
      ExplicitWidth = 8
    end
  end
  object FormManager: TgxFormManager
    BackDropForm = True
    BrowseTable = BrowseMovimientoTable
    Dataset = MovimientoTable
    FirstKeyControl = ProveedorCtrl
    FirstDataControl = FechaCtrl
    Model = fmEditForm
    RelatedDocsMenu = RelacionesPopupMenu
    ShowQueryOption = False
    OnAutoEditChanged = FormManagerAutoEditChanged
    OnInitializeForm = FormManagerInitializeForm
    OnShowForm = FormManagerShowForm
    OnPreparedForm = FormManagerPreparedForm
    OnCopyCurrentRecord = FormManagerCopyCurrentRecord
    OnReportRequest = FormManagerReportRequest
    OnReportFormRequest = FormManagerReportFormRequest
    OnActivateRelatedDocsButton = FormManagerActivateRelatedDocsButton
    OnLabelsRequest = FormManagerLabelsRequest
    OnNoteRequest = FormManagerNoteRequest
    OnQueryGridRequest = FormManagerQueryGridRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    OnGetAccessLevel = FormManagerGetAccessLevel
    OnSetupToolBar = FormManagerSetupToolBar
    OnUpdateButtonsState = FormManagerUpdateButtonsState
    Left = 888
    Top = 224
  end
  object MovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeInsert = MovimientoTableBeforeInsert
    BeforePost = MovimientoTableBeforePost
    BeforeDelete = MovimientoTableBeforeDelete
    BeforeScroll = MovimientoTableBeforeScroll
    OnNewRecord = MovimientoTableNewRecord
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento'
    AutoIncFieldName = 'NroDocumento'
    OnCanEditRecord = MovimientoTableCanEditRecord
    OnSetKey = MovimientoTableSetKey
    OnRecordChanged = MovimientoTableRecordChanged
    OnUpdateState = MovimientoTableUpdateState
    OnGetAutoIncValue = MovimientoTableGetAutoIncValue
    OnRemotePost = MovimientoTableRemotePost
    OnRemoteDelete = MovimientoTableRemoteDelete
    RemoteEdit = True
    Left = 787
    Top = 222
  end
  object MovimientoDataSource: TDataSource
    DataSet = MovimientoTable
    Left = 756
    Top = 224
  end
  object LineaMovimientoDataSource: TDataSource
    DataSet = LineaMovimientoTable
    Enabled = False
    Left = 693
    Top = 224
  end
  object LineaMovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeInsert = LineaMovimientoTableBeforeInsert
    BeforeEdit = LineaMovimientoTableBeforeEdit
    AfterEdit = LineaMovimientoTableAfterEdit
    BeforePost = LineaMovimientoTableBeforePost
    AfterPost = LineaMovimientoTableAfterPost
    OnCalcFields = LineaMovimientoTableCalcFields
    OnNewRecord = LineaMovimientoTableNewRecord
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    MasterFields = 'Ejercicio;NroOperacion'
    MasterSource = MovimientoDataSource
    AutoIncFieldName = 'NroLinea'
    MasterRelation = mrTied
    OnRecordChanged = LineaMovimientoTableRecordChanged
    OnRemotePost = LineaMovimientoTableRemotePost
    OnRemoteDelete = LineaMovimientoTableRemoteDelete
    RemoteEdit = True
    Left = 725
    Top = 224
    object LineaMovimientoTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object LineaMovimientoTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object LineaMovimientoTableNroPagina: TSmallintField
      FieldName = 'NroPagina'
    end
    object LineaMovimientoTableNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object LineaMovimientoTableNroRegistro: TUnsignedAutoIncField
      FieldName = 'NroRegistro'
    end
    object LineaMovimientoTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object LineaMovimientoTableFechaCaducidad: TDateField
      FieldName = 'FechaCaducidad'
    end
    object LineaMovimientoTableAsignacionOrigen: TSmallintField
      FieldName = 'AsignacionOrigen'
    end
    object LineaMovimientoTableTipoMovimientoOrigen: TSmallintField
      FieldName = 'TipoMovimientoOrigen'
    end
    object LineaMovimientoTableEjercicioOrigen: TSmallintField
      FieldName = 'EjercicioOrigen'
    end
    object LineaMovimientoTableNroOperacionOrigen: TIntegerField
      FieldName = 'NroOperacionOrigen'
    end
    object LineaMovimientoTableNroRegistroOrigen: TIntegerField
      FieldName = 'NroRegistroOrigen'
    end
    object LineaMovimientoTableUIDArticulo: TGuidField
      FieldName = 'UIDArticulo'
      Size = 38
    end
    object LineaMovimientoTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object LineaMovimientoTableCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object LineaMovimientoTableCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object LineaMovimientoTableCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object LineaMovimientoTableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object LineaMovimientoTableLoteFabricacion: TWideStringField
      FieldName = 'LoteFabricacion'
    end
    object LineaMovimientoTableNumeroSerie: TWideStringField
      FieldName = 'NumeroSerie'
      Size = 40
    end
    object LineaMovimientoTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object LineaMovimientoTableTipoLinea: TWideStringField
      FieldName = 'TipoLinea'
      Size = 3
    end
    object LineaMovimientoTableCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object LineaMovimientoTableUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
    object LineaMovimientoTableCantidad: TBCDField
      FieldName = 'Cantidad'
    end
    object LineaMovimientoTableCantidadProcesada: TBCDField
      FieldName = 'CantidadProcesada'
    end
    object LineaMovimientoTableProcesada: TBooleanField
      FieldName = 'Procesada'
    end
    object LineaMovimientoTablePesoEnvase: TBCDField
      FieldName = 'PesoEnvase'
      Precision = 16
    end
    object LineaMovimientoTableTara: TBCDField
      FieldName = 'Tara'
      Precision = 16
    end
    object LineaMovimientoTablePeso: TBCDField
      FieldName = 'Peso'
      Precision = 16
    end
    object LineaMovimientoTablePrecioDivisa: TBCDField
      FieldName = 'PrecioDivisa'
    end
    object LineaMovimientoTablePrecio: TFloatField
      FieldName = 'Precio'
    end
    object LineaMovimientoTableRecargo: TBCDField
      FieldName = 'Recargo'
    end
    object LineaMovimientoTablePuntoVerde: TBCDField
      FieldName = 'PuntoVerde'
    end
    object LineaMovimientoTableContribucionRAP: TBCDField
      FieldName = 'ContribucionRAP'
      Precision = 16
    end
    object LineaMovimientoTableDescuento: TBCDField
      FieldName = 'Descuento'
    end
    object LineaMovimientoTableNroCajas: TBCDField
      FieldName = 'NroCajas'
    end
    object LineaMovimientoTableLargo: TBCDField
      FieldName = 'Largo'
    end
    object LineaMovimientoTableAncho: TBCDField
      FieldName = 'Ancho'
    end
    object LineaMovimientoTableAlto: TBCDField
      FieldName = 'Alto'
    end
    object LineaMovimientoTableBultos: TBCDField
      FieldName = 'Bultos'
    end
    object LineaMovimientoTableImporteBruto: TBCDField
      FieldName = 'ImporteBruto'
    end
    object LineaMovimientoTableImporteDescuento: TBCDField
      FieldName = 'ImporteDescuento'
    end
    object LineaMovimientoTableImporteRecargo: TBCDField
      FieldName = 'ImporteRecargo'
      Precision = 16
    end
    object LineaMovimientoTablePorcentajeRecargo: TBCDField
      FieldName = 'PorcentajeRecargo'
      Precision = 16
    end
    object LineaMovimientoTableImporteNeto: TBCDField
      FieldName = 'ImporteNeto'
    end
    object LineaMovimientoTableNoCalcularMargen: TBooleanField
      FieldName = 'NoCalcularMargen'
    end
    object LineaMovimientoTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object LineaMovimientoTableTieneRegistroOrigen: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'TieneRegistroOrigen'
      Calculated = True
    end
    object LineaMovimientoTableSerieOrigen: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'SerieOrigen'
      Size = 2
      Calculated = True
    end
    object LineaMovimientoTableNroDocumentoOrigen: TLongWordField
      FieldKind = fkCalculated
      FieldName = 'NroDocumentoOrigen'
      Calculated = True
    end
    object LineaMovimientoTableCantidadAjustada: TBCDField
      FieldName = 'CantidadAjustada'
    end
    object LineaMovimientoTableTieneDocumentosAsociados: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'TieneDocumentosAsociados'
      Calculated = True
    end
    object LineaMovimientoTableOferta: TBooleanField
      FieldName = 'Oferta'
    end
    object LineaMovimientoTableCodigoTipoIVA: TSmallintField
      FieldName = 'CodigoTipoIVA'
    end
    object LineaMovimientoTableCuotaIVA: TBCDField
      FieldName = 'CuotaIVA'
    end
    object LineaMovimientoTableCuotaRE: TBCDField
      FieldName = 'CuotaRE'
    end
    object LineaMovimientoTablePrecioIVA: TBCDField
      FieldName = 'PrecioIVA'
    end
    object LineaMovimientoTableImporteTotal: TBCDField
      FieldName = 'ImporteTotal'
    end
    object LineaMovimientoTableParametros: TWordField
      FieldName = 'Parametros'
    end
    object LineaMovimientoTableCampoLibre1: TWideStringField
      FieldName = 'CampoLibre1'
      Size = 40
    end
    object LineaMovimientoTableCampoLibre2: TWideStringField
      FieldName = 'CampoLibre2'
      Size = 40
    end
    object LineaMovimientoTableCampoLibre3: TDateField
      FieldName = 'CampoLibre3'
    end
    object LineaMovimientoTableCampoLibre4: TBCDField
      FieldName = 'CampoLibre4'
      Precision = 16
    end
    object LineaMovimientoTableCampoLibre5: TWideStringField
      FieldName = 'CampoLibre5'
      Size = 40
    end
  end
  object Data: TgxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 787
    Top = 254
    object DataRecibido: TBooleanField
      FieldName = 'Recibido'
    end
  end
  object MemDataSource: TDataSource
    DataSet = Data
    Left = 755
    Top = 254
  end
  object RelacionAlbaranesTable: TnxeTable
    Database = SessionDataModule.TmpDatabase
    Timeout = 6000
    TableName = 'RelacionAlbaranes'
    IndexFieldNames = 'NroRegistro'
    TableType = ttTemporal
    Left = 585
    Top = 224
  end
  object LineaMovimientoAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'TipoMovimientoOrigen;EjercicioOrigen;NroOperacionOrigen'
    AutoIncFieldName = 'NroLinea'
    Left = 586
    Top = 256
  end
  object BarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'PopupMenu'
      'RelacionesPopupMenu')
    Categories.ItemsVisibles = (
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = False
    Left = 585
    Top = 305
    PixelsPerInch = 96
    object EditarDocItem: TdxBarButton
      Caption = 'Editar'
      Category = 1
      Visible = ivAlways
      OnClick = EditarDocItemClick
    end
    object FichaMovimientosArticuloItem: TdxBarButton
      Caption = 'Ficha de movimientos del art'#237'culo'
      Category = 1
      Visible = ivAlways
      OnClick = FichaMovimientosArticuloItemClick
    end
    object TrazaItem: TdxBarButton
      Caption = 'Traza del art'#237'culo'
      Category = 1
      Visible = ivAlways
      OnClick = TrazaItemClick
    end
    object FichaArticuloItem: TdxBarButton
      Caption = 'Ficha del art'#237'culo'
      Category = 1
      Visible = ivAlways
      OnClick = FichaArticuloItemClick
    end
    object VincularPedidoItem: TdxBarButton
      Caption = 'Vincular el albar'#225'n a un pedido existente'
      Category = 1
      Visible = ivAlways
      ImageIndex = 16
      OnClick = VincularPedidoItemClick
    end
    object SuprimirVinculosItem: TdxBarButton
      Caption = 'Suprimir todos los v'#237'nculos con pedidos'
      Category = 1
      Visible = ivAlways
      ImageIndex = 17
      OnClick = SuprimirVinculosItemClick
    end
    object DarPorRecibidaItem: TdxBarButton
      Caption = 'Dar por recibida la l'#237'nea'
      Category = 1
      Visible = ivAlways
      OnClick = DarPorRecibidaItemClick
    end
    object ActualizarRelacionesItem: TdxBarButton
      Caption = 'Actualizar relaciones del documento'
      Category = 1
      Visible = ivAlways
      OnClick = ActualizarRelacionesItemClick
    end
    object CopiarAnotacionItem: TdxBarButton
      Caption = 'Copiar la anotaci'#243'n del art'#237'culo'
      Category = 1
      Visible = ivAlways
      OnClick = CopiarAnotacionItemClick
    end
    object MostrarAnotacionesItem: TdxBarButton
      Caption = 'Mostrar anotaciones'
      Category = 1
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = MostrarAnotacionesItemClick
    end
    object LineasDocumentoItem: TdxBarButton
      Caption = '&Documentos cuyo origen es este '
      Category = 2
      Hint = 'Documentos cuyo origen es este '
      Visible = ivAlways
      OnClick = LineasDocumentoItemClick
    end
    object FacturaCompraItem: TdxBarButton
      Caption = '&Factura de compra'
      Category = 2
      Visible = ivAlways
      OnClick = FacturaCompraItemClick
    end
    object DocumentoOrigenItem: TdxBarButton
      Caption = 'Documento origen'
      Category = 2
      Visible = ivAlways
      OnClick = DocumentoOrigenItemClick
    end
  end
  object RejillaPopupMenu: TdxBarPopupMenu
    BarManager = BarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemLinks = <
      item
        Visible = True
        ItemName = 'EditarDocItem'
      end
      item
        Visible = True
        ItemName = 'FichaMovimientosArticuloItem'
      end
      item
        Visible = True
        ItemName = 'TrazaItem'
      end
      item
        Visible = True
        ItemName = 'FichaArticuloItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'VincularPedidoItem'
      end
      item
        Visible = True
        ItemName = 'SuprimirVinculosItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'DarPorRecibidaItem'
      end
      item
        Visible = True
        ItemName = 'ActualizarRelacionesItem'
      end
      item
        Visible = True
        ItemName = 'CopiarAnotacionItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'MostrarAnotacionesItem'
      end>
    UseOwnFont = True
    OnPopup = RejillaPopupMenuPopup
    Left = 665
    Top = 305
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
        ItemName = 'LineasDocumentoItem'
      end
      item
        Visible = True
        ItemName = 'FacturaCompraItem'
      end
      item
        Visible = True
        ItemName = 'DocumentoOrigenItem'
      end>
    UseOwnFont = True
    OnPopup = RelacionesPopupMenuPopup
    Left = 625
    Top = 305
    PixelsPerInch = 96
  end
  object BrowseMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Fecha'
    AutoIncFieldName = 'NroDocumento'
    RemoteEdit = True
    Left = 851
    Top = 224
  end
end
