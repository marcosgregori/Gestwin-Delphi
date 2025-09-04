object MntTckForm: TMntTckForm
  Left = 309
  Top = 279
  HelpType = htKeyword
  HelpKeyword = 'a_tck'
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderStyle = bsDialog
  Caption = 'Tickets de venta'
  ClientHeight = 912
  ClientWidth = 1589
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -20
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs20'
  Position = poDesigned
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
    OnEnter = KeyPanelEnter
    PanelKind = epKeyPanel
    Height = 54
    Width = 1589
    object TituloDocumentoLabel: TcxLabel
      AlignWithMargins = True
      Left = 1297
      Top = 7
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 15
      Margins.Bottom = 5
      TabStop = False
      Align = alRight
      AutoSize = False
      Caption = 'TICKET DE VENTA'
      ParentColor = False
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = cl3DDkShadow
      Style.Font.Height = -32
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.TextColor = cl3DDkShadow
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 1
      Transparent = True
      Height = 40
      Width = 275
      AnchorX = 1572
      AnchorY = 27
    end
    object Panel1: TcxGroupBox
      AlignWithMargins = True
      Left = 178
      Top = 5
      Margins.Left = 5
      Margins.Right = 5
      Align = alLeft
      PanelStyle.Active = True
      PanelStyle.CaptionIndent = 3
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 0
      Height = 44
      Width = 207
      object SerieCtrl: TcxDBTextEdit
        Left = 0
        Top = 0
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alLeft
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = MovimientoDataSource
        Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
        Properties.OnEditRequest = SerieCtrlPropertiesEditRequest
        Properties.OnValidate = SerieCtrlPropertiesValidate
        TabOrder = 0
        Width = 42
      end
      object LockRangeButton: TgxLockRangeButton
        AlignWithMargins = True
        Left = 48
        Top = 0
        Width = 36
        Height = 44
        Hint = 
          'Bloqueo del campo (Navegar fijando este campo).'#13'Teclas <Ctrl>+<B' +
          '>'
        Margins.Left = 6
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
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
        OptionsImage.Spacing = 3
        ParentShowHint = False
        ShowHint = True
        SpeedButtonOptions.GroupIndex = 1
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.AllowAllUp = True
        SpeedButtonOptions.Down = True
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 1
        EditControl = SerieCtrl
        OnLockRange = LockRangeButtonLockRange
      end
      object Label2: TcxLabel
        Left = 84
        Top = 0
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        Align = alLeft
        AutoSize = False
        Caption = '-'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        TabOrder = 2
        Transparent = True
        Height = 44
        Width = 15
        AnchorX = 92
        AnchorY = 22
      end
      object NroDocumentoCtrl: TcxDBIntegerEdit
        Left = 99
        Top = 0
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alLeft
        DataBinding.DataField = 'NroDocumento'
        DataBinding.DataSource = MovimientoDataSource
        Properties.Required = True
        Properties.OnQueryRequest = NroDocumentoCtrlPropertiesQueryRequest
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxLength = 8
        Properties.MaxValue = 99999999.000000000000000000
        Properties.MinValue = 1.000000000000000000
        TabOrder = 3
        Width = 104
      end
    end
    object NroDocumentoCaptionLabel: TcxLabel
      AlignWithMargins = True
      Left = 17
      Top = 7
      Margins.Left = 9
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 5
      TabStop = False
      Align = alLeft
      AutoSize = False
      Caption = 'N'#186'  de ticket'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 2
      Transparent = True
      Height = 40
      Width = 156
      AnchorY = 27
    end
    object EstadoLabel: TcxLabel
      AlignWithMargins = True
      Left = 408
      Top = 7
      Margins.Left = 18
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabStop = False
      Align = alClient
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 3
      Transparent = True
      Height = 40
      Width = 739
      AnchorY = 27
    end
    object AnuladoLabel: TcxLabel
      AlignWithMargins = True
      Left = 1157
      Top = 7
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabStop = False
      Align = alRight
      AutoSize = False
      Caption = 'ANULADO'
      ParentColor = False
      ParentFont = False
      Style.Color = clBtnFace
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -23
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.LookAndFeel.NativeStyle = False
      Style.TextColor = clRed
      Style.TextStyle = [fsBold]
      Style.IsFontAssigned = True
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Horz = taCenter
      Properties.Alignment.Vert = taVCenter
      Properties.LineOptions.OuterColor = clHighlight
      Properties.ShowAccelChar = False
      TabOrder = 4
      Transparent = True
      Visible = False
      Height = 40
      Width = 130
      AnchorX = 1222
      AnchorY = 27
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 858
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    PanelStyle.Active = True
    PanelStyle.CaptionIndent = 3
    Style.BorderStyle = ebsNone
    Style.TransparentBorder = True
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      1589
      54)
    Height = 54
    Width = 1589
    object ButtonContainerPanel: TcxGroupBox
      Left = 252
      Top = 0
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Anchors = []
      PanelStyle.Active = True
      PanelStyle.CaptionIndent = 3
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 54
      Width = 1085
      object OkButton: TgBitBtn
        Left = 2
        Top = 2
        Width = 131
        Height = 50
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alLeft
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
        AlignWithMargins = True
        Left = 136
        Top = 2
        Width = 130
        Height = 50
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
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 1
        GlyphBitmap = gmClose
      end
      object DeleteButton: TgBitBtn
        AlignWithMargins = True
        Left = 269
        Top = 2
        Width = 131
        Height = 50
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
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
      object FacturarButton: TgBitBtn
        AlignWithMargins = True
        Left = 685
        Top = 2
        Width = 130
        Height = 50
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'Fac&turar'
        Enabled = True
        OptionsImage.ImageIndex = 34
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 5
        OnClick = FacturarButtonClick
        GlyphBitmap = gmForm
      end
      object FacturaDirectaButton: TgBitBtn
        AlignWithMargins = True
        Left = 538
        Top = 2
        Width = 144
        Height = 50
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = '&Fra directa'
        Enabled = True
        OptionsImage.ImageIndex = 56
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 4
        OnClick = FacturaDirectaButtonClick
        GlyphBitmap = gmAddForm
      end
      object ExportarButton: TgBitBtn
        AlignWithMargins = True
        Left = 818
        Top = 2
        Width = 131
        Height = 50
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'E&xportar'
        Enabled = True
        OptionsImage.ImageIndex = 30
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 6
        TabStop = False
        OnClick = ExportarButtonClick
        GlyphBitmap = gmExport
      end
      object ImprimirButton: TgBitBtn
        AlignWithMargins = True
        Left = 412
        Top = 2
        Width = 123
        Height = 50
        Margins.Left = 12
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = '&Imprimir'
        Enabled = True
        OptionsImage.ImageIndex = 28
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 3
        OptionsImage.Spacing = 5
        TabOrder = 3
        OnClick = ImprimirButtonClick
        GlyphBitmap = gmDocSingle
      end
      object FirmarButton: TgBitBtn
        AlignWithMargins = True
        Left = 952
        Top = 2
        Width = 127
        Height = 50
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'Fi&rmar'
        Enabled = True
        OptionsImage.ImageIndex = 61
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 7
        OnClick = FirmarButtonClick
        GlyphBitmap = gmSign
      end
    end
    object FirmadoLabel: TcxLabel
      Left = 1440
      Top = 8
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabStop = False
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'FIRMADO'
      ParentColor = False
      Style.BorderStyle = ebsSingle
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
      Height = 37
      Width = 141
      AnchorX = 1511
      AnchorY = 27
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 8
    Top = 54
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
    OnEnter = DataPanelEnter
    PanelKind = epDataPanel
    Height = 804
    Width = 1573
    object BottomPanel: TGridTableViewPanel
      Left = 2
      Top = 672
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alBottom
      PanelStyle.Active = True
      PanelStyle.CaptionIndent = 3
      Style.BorderStyle = ebsNone
      TabOrder = 3
      Transparent = True
      OnEnter = BottomPanelEnter
      Grid = Grid
      Height = 130
      Width = 1569
      object CantidadTotalPanel: TcxGroupBox
        AlignWithMargins = True
        Left = 649
        Top = 2
        Margins.Left = 9
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        PanelStyle.Active = True
        PanelStyle.CaptionIndent = 3
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 126
        Width = 121
        object CantidadLabel: TcxLabel
          Left = 0
          Top = 11
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Cantidad'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object FooterPanelCantidad: TcxLabel
          Left = 2
          Top = 45
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
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
          Height = 38
          Width = 115
          AnchorX = 117
          AnchorY = 64
        end
      end
      object cxGroupBox2: TcxGroupBox
        AlignWithMargins = True
        Left = 11
        Top = 2
        Margins.Left = 9
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        PanelStyle.Active = True
        PanelStyle.CaptionIndent = 3
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 126
        Width = 629
        object EntregaACuentaCtrl: TcxDBCurrencyEdit
          Left = 168
          Top = 87
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          DataBinding.DataField = 'EntregaACuenta'
          DataBinding.DataSource = MovimientoDataSource
          Properties.OnValuePosted = EntregaACuentaCtrlPropertiesValuePosted
          Properties.MaxLength = 8
          TabOrder = 0
          Width = 107
        end
        object EntregaCtrl: TcxDBCurrencyEdit
          Left = 168
          Top = 47
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          DataBinding.DataField = 'EntregaEfectivo'
          DataBinding.DataSource = MovimientoDataSource
          Properties.OnValuePosted = EntregaCtrlPropertiesValuePosted
          Properties.MaxLength = 8
          TabOrder = 1
          Width = 107
        end
        object EntregasACuentaPedidosLabel: TcxLabel
          Left = 284
          Top = 45
          Hint = 
            'Entregas a cuenta anotadas en los pedidos incluidos en este alba' +
            'r'#225'n.'
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
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
          Height = 38
          Width = 117
          AnchorX = 401
          AnchorY = 64
        end
        object FormaCobroCtrl: TcxDBTextEdit
          Left = 168
          Top = 6
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          CaptionLabel = Label13
          DescriptionLabel = Label11
          DataBinding.DataField = 'CodigoFormaCobro'
          DataBinding.DataSource = MovimientoDataSource
          Properties.OnQueryRequest = FormaCobroCtrlPropertiesQueryRequest
          Properties.OnEditRequest = FormaCobroCtrlPropertiesEditRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = FormaCobroCtrlPropertiesValidate
          TabOrder = 3
          Width = 38
        end
        object Label11: TcxLabel
          Left = 284
          Top = 26
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
          Height = 28
          Width = 333
        end
        object Label13: TcxLabel
          Left = 0
          Top = 11
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Forma de cobro'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 5
          Transparent = True
        end
        object Label18: TcxLabel
          Left = 0
          Top = 92
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'A cuenta / Efectivo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 6
          Transparent = True
        end
        object Label6: TcxLabel
          Left = 0
          Top = 51
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          TabStop = False
          Caption = 'Entrega'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 7
          Transparent = True
        end
        object NoFacturarCtrl: TcxDBCheckBox
          Left = 300
          Top = 89
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          AutoSize = False
          Caption = 'No facturar'
          DataBinding.DataField = 'NoFacturar'
          DataBinding.DataSource = MovimientoDataSource
          Properties.Alignment = taRightJustify
          Properties.NullStyle = nssUnchecked
          TabOrder = 8
          Transparent = True
          Height = 31
          Width = 191
        end
      end
      object cxGroupBox3: TcxGroupBox
        AlignWithMargins = True
        Left = 779
        Top = 2
        Margins.Left = 9
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        PanelStyle.Active = True
        PanelStyle.CaptionIndent = 3
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Height = 126
        Width = 788
        object VisorPanel: TcxGroupBox
          AlignWithMargins = True
          Left = 190
          Top = 7
          Margins.Left = 68
          Margins.Top = 5
          Margins.Right = 57
          Margins.Bottom = 30
          Align = alRight
          PanelStyle.Active = True
          PanelStyle.CaptionIndent = 3
          ParentBackground = False
          ParentColor = False
          Style.BorderColor = clHighlightText
          Style.BorderStyle = ebsSingle
          Style.Color = clBlack
          Style.LookAndFeel.Kind = lfUltraFlat
          Style.LookAndFeel.NativeStyle = True
          StyleDisabled.LookAndFeel.Kind = lfUltraFlat
          StyleDisabled.LookAndFeel.NativeStyle = True
          TabOrder = 0
          Height = 87
          Width = 539
          object CaptionTotalIVAIncluidoLabel: TcxLabel
            Left = 297
            Top = 5
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Total'
            ParentFont = False
            Style.Font.Charset = ANSI_CHARSET
            Style.Font.Color = clLime
            Style.Font.Height = -24
            Style.Font.Name = 'Segoe UI'
            Style.Font.Style = []
            Style.TextColor = clLime
            Style.TransparentBorder = False
            Style.IsFontAssigned = True
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 0
            Transparent = True
            AnchorY = 21
          end
          object TotalIVAIncluidoLabel: TcxLabel
            Left = 375
            Top = 6
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            AutoSize = False
            Caption = '00,00'
            ParentFont = False
            Style.Font.Charset = ANSI_CHARSET
            Style.Font.Color = clLime
            Style.Font.Height = -24
            Style.Font.Name = 'Segoe UI'
            Style.Font.Style = []
            Style.TextColor = clLime
            Style.TransparentBorder = False
            Style.IsFontAssigned = True
            Properties.Alignment.Horz = taRightJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 1
            Transparent = True
            Height = 29
            Width = 146
            AnchorX = 521
            AnchorY = 21
          end
          object EntregaEfectivoLabel: TcxLabel
            Left = 129
            Top = 8
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            AutoSize = False
            Caption = '00,00'
            ParentFont = False
            Style.Font.Charset = ANSI_CHARSET
            Style.Font.Color = clLime
            Style.Font.Height = -24
            Style.Font.Name = 'Segoe UI'
            Style.Font.Style = []
            Style.TextColor = clLime
            Style.TransparentBorder = False
            Style.IsFontAssigned = True
            Properties.Alignment.Horz = taRightJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 2
            Transparent = True
            Height = 25
            Width = 152
            AnchorX = 281
            AnchorY = 21
          end
          object CaptionEntregaEfectivoLabel: TcxLabel
            Left = 12
            Top = 5
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Entrega'
            ParentFont = False
            Style.Font.Charset = ANSI_CHARSET
            Style.Font.Color = clLime
            Style.Font.Height = -24
            Style.Font.Name = 'Segoe UI'
            Style.Font.Style = []
            Style.TextColor = clLime
            Style.TransparentBorder = False
            Style.IsFontAssigned = True
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 3
            Transparent = True
            AnchorY = 21
          end
          object CaptionDevolucionRestoLabel: TcxLabel
            Left = 12
            Top = 38
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Devoluci'#243'n'
            ParentFont = False
            Style.Font.Charset = ANSI_CHARSET
            Style.Font.Color = clYellow
            Style.Font.Height = -24
            Style.Font.Name = 'Segoe UI'
            Style.Font.Style = []
            Style.TextColor = clYellow
            Style.TransparentBorder = False
            Style.IsFontAssigned = True
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 4
            Transparent = True
            AnchorY = 54
          end
          object DevolucionRestoLabel: TcxLabel
            Left = 129
            Top = 41
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            AutoSize = False
            Caption = '00,00'
            ParentFont = False
            Style.Font.Charset = ANSI_CHARSET
            Style.Font.Color = clYellow
            Style.Font.Height = -24
            Style.Font.Name = 'Segoe UI'
            Style.Font.Style = []
            Style.TextColor = clYellow
            Style.TransparentBorder = False
            Style.IsFontAssigned = True
            Properties.Alignment.Horz = taRightJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 5
            Transparent = True
            Height = 25
            Width = 152
            AnchorX = 281
            AnchorY = 54
          end
        end
      end
    end
    object TopPanel: TcxGroupBox
      Left = 2
      Top = 2
      Margins.Left = 5
      Margins.Top = 5
      Margins.Bottom = 5
      Align = alTop
      PanelStyle.Active = True
      PanelStyle.CaptionIndent = 3
      Style.BorderStyle = ebsNone
      TabOrder = 0
      OnEnter = TopPanelEnter
      DesignSize = (
        1569
        209)
      Height = 209
      Width = 1569
      object cxGroupBox1: TcxGroupBox
        Left = 1406
        Top = 2
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alRight
        PanelStyle.Active = True
        PanelStyle.CaptionIndent = 3
        Style.BorderStyle = ebsNone
        TabOrder = 7
        Height = 205
        Width = 161
        object ConsumosButton: TgBitBtn
          AlignWithMargins = True
          Left = 5
          Top = 113
          Width = 151
          Height = 43
          Margins.Bottom = 0
          Align = alBottom
          Caption = 'Consu&mos'
          Enabled = True
          OptionsImage.ImageIndex = 55
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 6
          OptionsImage.Spacing = 8
          TabOrder = 0
          TabStop = False
          OnClick = ConsumosButtonClick
          GlyphBitmap = gmWindowList
        end
        object ImportarButton: TgBitBtn
          AlignWithMargins = True
          Left = 5
          Top = 159
          Width = 151
          Height = 44
          Margins.Bottom = 0
          Align = alBottom
          Caption = '&Importar ..'
          Enabled = True
          OptionsImage.ImageIndex = 31
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 3
          OptionsImage.Spacing = 5
          TabOrder = 1
          TabStop = False
          OnClick = ImportarButtonClick
          GlyphBitmap = gmImport
        end
      end
      object FechaCtrl: TcxDBDateEdit
        Left = 168
        Top = 42
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        DataBinding.DataField = 'Fecha'
        DataBinding.DataSource = MovimientoDataSource
        Properties.Required = True
        Properties.OnValidate = FechaCtrlPropertiesValidate
        TabOrder = 1
        Width = 150
      end
      object TopScrollBox: TcxScrollBox
        Left = 0
        Top = 81
        Width = 644
        Height = 122
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Anchors = [akLeft, akTop, akBottom]
        AutoScroll = False
        BorderStyle = cxcbsNone
        HorzScrollBar.Range = 0
        HorzScrollBar.Visible = False
        TabOrder = 2
        Transparent = True
        VertScrollBar.Increment = 27
        VertScrollBar.Range = 0
        VertScrollBar.Tracking = True
        object GrupoClientePanel: TgxScrollBoxPanel
          Left = 0
          Top = 41
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          PanelStyle.Active = True
          PanelStyle.CaptionIndent = 3
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Height = 40
          Width = 644
          object GrupoClienteCtrl: TcxDBTextEdit
            Left = 168
            Top = 2
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            DescriptionLabel = Label1
            DataBinding.DataField = 'GrupoFacturacion'
            DataBinding.DataSource = MovimientoDataSource
            Properties.OnQueryRequest = GrupoClienteCtrlPropertiesQueryRequest
            Properties.OnEditRequest = GrupoClienteCtrlPropertiesEditRequest
            Properties.OnValidate = GrupoClienteCtrlPropertiesValidate
            TabOrder = 0
            Width = 51
          end
          object Label1: TcxLabel
            Left = 311
            Top = 5
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
            Height = 25
            Width = 300
          end
          object Label5: TcxLabel
            Left = 9
            Top = 8
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Grupo de cliente'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
        end
        object VendedorPanel: TgxScrollBoxPanel
          Left = 0
          Top = 122
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          PanelStyle.Active = True
          PanelStyle.CaptionIndent = 3
          Style.BorderStyle = ebsNone
          TabOrder = 3
          Height = 40
          Width = 644
          object VendedorCtrl: TcxDBTextEdit
            Left = 168
            Top = 2
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            DescriptionLabel = Label7
            DataBinding.DataField = 'CodigoVendedor'
            DataBinding.DataSource = MovimientoDataSource
            Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
            Properties.OnEditRequest = VendedorCtrlPropertiesEditRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = VendedorCtrlPropertiesValidate
            TabOrder = 0
            Width = 38
          end
          object Label7: TcxLabel
            Left = 311
            Top = 9
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
            Height = 26
            Width = 300
          end
          object Label8: TcxLabel
            Left = 9
            Top = 11
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Vendedor'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
        end
        object RegistroAuxiliarPanel: TgxScrollBoxPanel
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
          Height = 41
          Width = 644
          object RegistroAuxiliarCtrl: TcxDBTextEdit
            Left = 168
            Top = 2
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            DescriptionLabel = Label14
            DataBinding.DataField = 'RegistroAuxiliar'
            DataBinding.DataSource = MovimientoDataSource
            Properties.OnQueryRequest = RegistroAuxiliarCtrlPropertiesQueryRequest
            Properties.OnEditRequest = RegistroAuxiliarCtrlPropertiesEditRequest
            Properties.OnValidate = RegistroAuxiliarCtrlPropertiesValidate
            TabOrder = 0
            Width = 51
          end
          object Label14: TcxLabel
            Left = 311
            Top = 6
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
            Height = 26
            Width = 300
          end
          object RegistroAuxiliarLabel: TcxLabel
            Left = 9
            Top = 8
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Registro auxiliar'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
        end
        object CentroCostePanel: TgxScrollBoxPanel
          Left = 0
          Top = 162
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          PanelStyle.Active = True
          PanelStyle.CaptionIndent = 3
          Style.BorderStyle = ebsNone
          TabOrder = 4
          Height = 41
          Width = 644
          object CentroCosteCtrl: TcxDBTextEdit
            Left = 168
            Top = 2
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            DescriptionLabel = Label4
            DataBinding.DataField = 'CentroCoste'
            DataBinding.DataSource = MovimientoDataSource
            Properties.OnQueryRequest = CentroCosteCtrlPropertiesQueryRequest
            Properties.OnEditRequest = CentroCosteCtrlPropertiesEditRequest
            Properties.OnValidate = CentroCosteCtrlPropertiesValidate
            TabOrder = 0
            Width = 51
          end
          object Label4: TcxLabel
            Left = 311
            Top = 9
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
            Height = 26
            Width = 300
          end
          object Label12: TcxLabel
            Left = 9
            Top = 11
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Centro de coste'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
        end
        object TransportistaPanel: TgxScrollBoxPanel
          Left = 0
          Top = 81
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          PanelStyle.Active = True
          PanelStyle.CaptionIndent = 3
          Style.BorderStyle = ebsNone
          TabOrder = 2
          Height = 41
          Width = 644
          object TransportistaCtrl: TcxDBTextEdit
            Left = 168
            Top = 2
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            DescriptionLabel = Label16
            DataBinding.DataField = 'CodigoTransportista'
            DataBinding.DataSource = MovimientoDataSource
            Properties.OnQueryRequest = TransportistaCtrlPropertiesQueryRequest
            Properties.OnEditRequest = TransportistaCtrlPropertiesEditRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = TransportistaCtrlPropertiesValidate
            TabOrder = 0
            Width = 38
          end
          object Label16: TcxLabel
            Left = 311
            Top = 9
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
            Height = 26
            Width = 300
          end
          object Label17: TcxLabel
            Left = 9
            Top = 11
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Transportista'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
        end
      end
      object ClienteCtrl: TcxDBTextEdit
        Left = 168
        Top = 2
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        DescriptionLabel = Label9
        DataBinding.DataField = 'Propietario'
        DataBinding.DataSource = MovimientoDataSource
        Properties.Required = True
        Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
        Properties.OnEditRequest = ClienteCtrlPropertiesEditRequest
        Properties.OnValuePosted = ClienteCtrlPropertiesValuePosted
        Properties.TextEditPad = tpLeftZero
        Properties.PadAlways = True
        Properties.OnEditValueChanged = ClienteCtrlPropertiesEditValueChanged
        Properties.OnValidate = ClienteCtrlPropertiesValidate
        TabOrder = 0
        Width = 69
      end
      object Label3: TcxLabel
        Left = 9
        Top = 50
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
      end
      object Label10: TcxLabel
        Left = 9
        Top = 8
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        Caption = 'C'#243'digo cliente'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
      end
      object Label9: TcxLabel
        Left = 311
        Top = 6
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
        Height = 26
        Width = 847
      end
      object CamposLibresScrollBox: TcxScrollBox
        Left = 651
        Top = 39
        Width = 534
        Height = 162
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Anchors = [akLeft, akTop, akBottom]
        AutoScroll = False
        BorderStyle = cxcbsNone
        HorzScrollBar.Range = 0
        HorzScrollBar.Visible = False
        LookAndFeel.ScrollbarMode = sbmClassic
        TabOrder = 3
        Transparent = True
        VertScrollBar.Increment = 27
        VertScrollBar.Range = 0
        VertScrollBar.Tracking = True
        object CLScrollBoxPanel5: TgxScrollBoxPanel
          Left = 0
          Top = 162
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          Ctl3D = False
          PanelStyle.Active = True
          PanelStyle.CaptionIndent = 3
          ParentCtl3D = False
          Style.BorderStyle = ebsNone
          TabOrder = 4
          Height = 41
          Width = 534
          object CampoLibre5Ctrl: TcxDBTextEdit
            Left = 168
            Top = 2
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            CaptionLabel = CLLabel5
            DataBinding.DataField = 'CampoLibre5'
            DataBinding.DataSource = MovimientoDataSource
            TabOrder = 0
            Width = 330
          end
          object CLLabel5: TcxLabel
            Left = 9
            Top = 6
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Campo libre 5'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object CLScrollBoxPanel4: TgxScrollBoxPanel
          Left = 0
          Top = 122
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          Ctl3D = False
          PanelStyle.Active = True
          PanelStyle.CaptionIndent = 3
          ParentCtl3D = False
          Style.BorderStyle = ebsNone
          TabOrder = 3
          Height = 40
          Width = 534
          object CampoLibre4Ctrl: TcxDBTextEdit
            Left = 168
            Top = 2
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            CaptionLabel = CLLabel4
            DataBinding.DataField = 'CampoLibre4'
            DataBinding.DataSource = MovimientoDataSource
            TabOrder = 0
            Width = 330
          end
          object CLLabel4: TcxLabel
            Left = 9
            Top = 6
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Campo libre 4'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object CLScrollBoxPanel3: TgxScrollBoxPanel
          Left = 0
          Top = 81
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          Ctl3D = False
          PanelStyle.Active = True
          PanelStyle.CaptionIndent = 3
          ParentCtl3D = False
          Style.BorderStyle = ebsNone
          TabOrder = 2
          Height = 41
          Width = 534
          object CampoLibre3Ctrl: TcxDBTextEdit
            Left = 168
            Top = 2
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            CaptionLabel = CLLabel3
            DataBinding.DataField = 'CampoLibre3'
            DataBinding.DataSource = MovimientoDataSource
            TabOrder = 0
            Width = 330
          end
          object CLLabel3: TcxLabel
            Left = 9
            Top = 6
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Campo libre 3'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object CLScrollBoxPanel1: TgxScrollBoxPanel
          Left = 0
          Top = 0
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          Ctl3D = False
          PanelStyle.Active = True
          PanelStyle.CaptionIndent = 3
          ParentCtl3D = False
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 41
          Width = 534
          object CampoLibre1Ctrl: TcxDBTextEdit
            Left = 168
            Top = 2
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            CaptionLabel = CLLabel1
            DataBinding.DataField = 'CampoLibre1'
            DataBinding.DataSource = MovimientoDataSource
            TabOrder = 0
            Width = 330
          end
          object CLLabel1: TcxLabel
            Left = 9
            Top = 6
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Campo libre 1'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object CLScrollBoxPanel2: TgxScrollBoxPanel
          Left = 0
          Top = 41
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          Ctl3D = False
          PanelStyle.Active = True
          PanelStyle.CaptionIndent = 3
          ParentCtl3D = False
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Height = 40
          Width = 534
          object CampoLibre2Ctrl: TcxDBTextEdit
            Left = 168
            Top = 2
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            CaptionLabel = CLLabel2
            DataBinding.DataField = 'CampoLibre2'
            DataBinding.DataSource = MovimientoDataSource
            TabOrder = 0
            Width = 330
          end
          object CLLabel2: TcxLabel
            Left = 9
            Top = 6
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            TabStop = False
            Caption = 'Campo libre 2'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
      end
      object AvisoButton: TgBitBtn
        Left = 240
        Top = 0
        Width = 39
        Height = 39
        Hint = 'Mostrar el aviso asociado al cliente.\nTeclas [Ctrl]+[O]'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Cancel = True
        Enabled = True
        ModalResult = 5
        OptionsImage.ImageIndex = 8
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Spacing = 6
        PaintStyle = bpsGlyph
        ParentShowHint = False
        ShowHint = True
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 8
        TabStop = False
        Visible = False
        OnClick = AvisoButtonClick
        GlyphBitmap = gmWarning
      end
      object AnotacionButton: TgBitBtn
        Left = 321
        Top = 42
        Width = 42
        Height = 42
        Hint = 'Mostrar la anotaci'#243'n del documento'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Enabled = True
        OptionsImage.ImageIndex = 66
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Spacing = 6
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 9
        TabStop = False
        OnClick = AnotacionButtonClick
        GlyphBitmap = gmComment
      end
    end
    object Grid: TcxGrid
      Left = 2
      Top = 223
      Width = 1504
      Height = 449
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      TabOrder = 1
      OnEnter = GridEnter
      OnExit = GridExit
      object GridView: TcxGridDBTableView
        PopupMenu = PopupMenu
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellClick = GridViewCellClick
        OnCellDblClick = GridViewCellDblClick
        OnCustomDrawCell = GridViewCustomDrawCell
        OnFocusedItemChanged = GridViewFocusedItemChanged
        OnFocusedRecordChanged = GridViewFocusedRecordChanged
        OnInitEdit = GridViewInitEdit
        OnInitEditValue = GridViewInitEditValue
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = LineaMovimientoDataSource
        DataController.KeyFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems.OnSummary = GridViewFooterSummaryItems
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            FieldName = 'CantidadAjustada'
            Column = GridViewCantidadAjustada
          end
          item
            Kind = skSum
            FieldName = 'ImporteNeto'
            Column = GridViewImporte
          end
          item
            Format = '#.###,00'
            Kind = skSum
            FieldName = 'CuotaIVA'
            Column = GridViewCuotaIVA
          end
          item
            Format = '#.###,00'
            Kind = skSum
            FieldName = 'CuotaRE'
            Column = GridViewCuotaRE
          end>
        DataController.Summary.SummaryGroups = <>
        DataController.Summary.OnAfterSummary = GridViewAfterSummary
        FilterRow.SeparatorWidth = 9
        FixedDataRows.SeparatorWidth = 9
        NewItemRow.SeparatorWidth = 9
        OptionsBehavior.PostponedSynchronization = False
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.FocusFirstCellOnNewRecord = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsBehavior.ImmediateEditor = False
        OptionsBehavior.PullFocusing = True
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Appending = True
        OptionsData.DeletingConfirmation = False
        OptionsSelection.InvertSelect = False
        OptionsView.NavigatorOffset = 75
        OptionsView.ColumnAutoWidth = True
        OptionsView.FixedColumnSeparatorWidth = 3
        OptionsView.FooterAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Preview.Column = GridViewAnotacion
        Preview.LeftIndent = 30
        Preview.RightIndent = 8
        RowLayout.MinValueWidth = 120
        object GridViewCodigoArticulo: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CodigoArticulo'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Required = True
          Properties.OnExtendedFunction = GridViewCodigoArticuloPropertiesExtendedFunction
          Properties.OnQueryRequest = GridViewCodigoArticuloPropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoArticuloPropertiesEditRequest
          Properties.OnValuePosted = GridViewCodigoArticuloPropertiesValuePosted
          Properties.OnValidate = GridViewCodigoArticuloPropertiesValidate
          MinWidth = 30
          Width = 123
        end
        object GridViewCodigoClaseA: TcxGridDBColumn
          Tag = 1
          Caption = 'ClsA'
          DataBinding.FieldName = 'CodigoClaseA'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCodigoClasePropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoClasePropertiesEditRequest
          Properties.OnValidate = GridViewCodigoClaseAPropertiesValidate
          MinWidth = 30
          Width = 45
        end
        object GridViewCodigoClaseB: TcxGridDBColumn
          Tag = 2
          Caption = 'ClsB'
          DataBinding.FieldName = 'CodigoClaseB'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCodigoClasePropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoClasePropertiesEditRequest
          Properties.OnValidate = GridViewCodigoClaseBPropertiesValidate
          MinWidth = 30
          Width = 45
        end
        object GridViewCodigoClaseC: TcxGridDBColumn
          Tag = 3
          Caption = 'ClsC'
          DataBinding.FieldName = 'CodigoClaseC'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewCodigoClasePropertiesQueryRequest
          Properties.OnEditRequest = GridViewCodigoClasePropertiesEditRequest
          Properties.OnValidate = GridViewCodigoClaseCPropertiesValidate
          MinWidth = 30
          Width = 45
        end
        object GridViewLoteFabricacion: TcxGridDBColumn
          Caption = 'Lote'
          DataBinding.FieldName = 'LoteFabricacion'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewLoteFabricacionPropertiesQueryRequest
          Properties.OnValuePosted = GridViewLoteFabricacionPropertiesValuePosted
          Visible = False
          MinWidth = 30
        end
        object GridViewNumeroSerie: TcxGridDBColumn
          Caption = 'N'#186' serie'
          DataBinding.FieldName = 'NumeroSerie'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewNumeroSeriePropertiesQueryRequest
          Visible = False
          MinWidth = 60
          Width = 270
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          PropertiesClassName = 'TcxTextEditProperties'
          MinWidth = 30
          Width = 450
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
          MinWidth = 30
          Width = 45
        end
        object GridViewUbicacion: TcxGridDBColumn
          Caption = 'Ubic.'
          DataBinding.FieldName = 'Ubicacion'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnQueryRequest = GridViewUbicacionPropertiesQueryRequest
          Properties.OnEditRequest = GridViewUbicacionPropertiesEditRequest
          Properties.OnValidate = GridViewUbicacionPropertiesValidate
          Visible = False
          MinWidth = 30
        end
        object GridViewLargo: TcxGridDBColumn
          DataBinding.FieldName = 'Largo'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValuePosted = GridViewDimensionPropertiesValuePosted
          Properties.Nullable = False
          Visible = False
          MinWidth = 30
          Width = 75
        end
        object GridViewAncho: TcxGridDBColumn
          DataBinding.FieldName = 'Ancho'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValuePosted = GridViewDimensionPropertiesValuePosted
          Properties.Nullable = False
          Visible = False
          MinWidth = 30
          Width = 75
        end
        object GridViewAlto: TcxGridDBColumn
          DataBinding.FieldName = 'Alto'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValuePosted = GridViewDimensionPropertiesValuePosted
          Properties.Nullable = False
          Visible = False
          MinWidth = 30
          Width = 75
        end
        object GridViewNroCajas: TcxGridDBColumn
          Caption = 'Cajas'
          DataBinding.FieldName = 'NroCajas'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValuePosted = GridViewNroCajasPropertiesValuePosted
          Properties.Nullable = False
          Visible = False
          MinWidth = 30
          Width = 75
        end
        object GridViewCantidadAjustada: TcxGridDBColumn
          Caption = 'Cantidad'
          DataBinding.FieldName = 'CantidadAjustada'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnEnter = GridViewCantidadAjustadaPropertiesEnter
          Properties.OnExtendedFunction = GridViewCantidadAjustadaPropertiesExtendedFunction
          Properties.OnQueryRequest = GridViewCantidadAjustadaPropertiesQueryRequest
          Properties.OnValuePosted = GridViewCantidadAjustadaPropertiesValuePosted
          Properties.OnValidate = GridViewCantidadAjustadaPropertiesValidate
          MinWidth = 30
        end
        object GridViewPrecio: TcxGridDBColumn
          DataBinding.FieldName = 'Precio'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnEnter = GridViewPrecioPropertiesEnter
          Properties.OnExtendedFunction = GridViewPrecioPropertiesExtendedFunction
          Properties.OnQueryRequest = GridViewPrecioPropertiesQueryRequest
          Properties.OnValuePosted = GridViewPrecioPropertiesValuePosted
          Properties.Nullable = False
          MinWidth = 30
          Width = 120
        end
        object GridViewPrecioIVA: TcxGridDBColumn
          Caption = 'I.V.A. inc.'
          DataBinding.FieldName = 'PrecioIVA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValuePosted = GridViewPrecioIVAPropertiesValuePosted
          Properties.Nullable = False
          Properties.OnValidate = GridViewPrecioIVAPropertiesValidate
          MinWidth = 30
          Width = 120
        end
        object GridViewPuntoVerde: TcxGridDBColumn
          Caption = 'Ecotasa'
          DataBinding.FieldName = 'PuntoVerde'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValuePosted = GridViewUpdatePropertiesValuePosted
          Properties.Nullable = False
          Visible = False
          MinWidth = 30
        end
        object GridViewRecargo: TcxGridDBColumn
          DataBinding.FieldName = 'Recargo'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValuePosted = GridViewUpdatePropertiesValuePosted
          Properties.Nullable = False
          MinWidth = 30
        end
        object GridViewDescuento: TcxGridDBColumn
          Caption = '% Dto.'
          DataBinding.FieldName = 'Descuento'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnQueryRequest = GridViewPrecioPropertiesQueryRequest
          Properties.OnValuePosted = GridViewUpdatePropertiesValuePosted
          Properties.MaxLength = 6
          Properties.MaxValue = 100.000000000000000000
          Properties.MinValue = -100.000000000000000000
          Properties.Nullable = False
          MinWidth = 30
          Width = 75
        end
        object GridViewImporte: TcxGridDBColumn
          Caption = 'Importe'
          DataBinding.FieldName = 'ImporteNeto'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Nullable = False
          Visible = False
          MinWidth = 30
          Options.Editing = False
          Options.Focusing = False
          Width = 150
        end
        object GridViewImporteTotal: TcxGridDBColumn
          Caption = 'Importe'
          DataBinding.FieldName = 'ImporteTotal'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.AssignedValues.DisplayFormat = True
          Properties.Nullable = False
          OnGetCellHint = GridViewImporteTotalGetCellHint
          OnGetDisplayText = GridViewImporteTotalGetDisplayText
          MinWidth = 30
          Options.Editing = False
          Options.Focusing = False
          Width = 150
        end
        object GridViewDocumentoOrigen: TcxGridDBColumn
          Caption = 'Orig.'
          DataBinding.FieldName = 'TieneRegistroOrigen'
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
            737667223E0D0A09093C646566732069643D22646566733136222F3E0D0A0909
            3C726563742069643D2272656374383238222066696C6C3D2223464646464646
            222066696C6C2D6F7061636974793D223022207374726F6B653D226E6F6E6522
            207374726F6B652D77696474683D22302E31303431392220783D223070782220
            793D22302E3034343437707822206865696768743D2231392E39353535337078
            222077696474683D2234302E31313433387078222072783D2230707822207279
            3D22307078222F3E0D0A09093C672069643D2267383435223E0D0A0909093C67
            2069643D2269636F6E22207472616E73666F726D3D226D617472697828302E38
            353437332030203020302E38353437332031392E3734333239202D302E323536
            353929223E0D0A090909093C636972636C652069643D22636972636C65383438
            222066696C6C3D2223463746384639222063783D2231327078222063793D2231
            3270782220723D2231307078222F3E0D0A090909093C706174682069643D2270
            617468383530222066696C6C3D22233835393141312220643D224D2031392E37
            3738322C342E323231382031382E353736312C352E3432333920432032302E32
            3539312C372E313036392032312E332C392E343331392032312E332C31322063
            20302C352E31333632202D342E313633382C392E33202D392E332C392E33202D
            322E353638312C30202D342E383933312C2D312E30343039202D362E35373631
            2C2D322E37323339204C20342E323231382C31392E37373832204320362E3231
            32342C32312E3736383820382E393632342C32332031322C32332031382E3037
            35312C32332032332C31382E303735312032332C31322032332C382E39363234
            2032312E373638382C362E323132342031392E373738322C342E32323138205A
            222F3E0D0A090909093C706174682069643D2270617468383532222066696C6C
            3D222331433230323522206F7061636974793D22302E30352220643D224D2034
            2E393238392C31392E30373131204320362E373338362C32302E383830372039
            2E323338362C32322031322C32322031372E353232382C32322032322C31372E
            353232382032322C31322032322C392E323338362032302E383830372C362E37
            3338362031392E303731312C342E39323839205A222F3E0D0A090909093C7061
            74682069643D2270617468383534222066696C6C3D2223393941324146222064
            3D224D20352E343233392C31382E35373631204320332E373430392C31362E38
            39333120322E372C31342E3536383120322E372C313220322E372C362E383633
            3820362E383633382C322E372031322C322E37206320322E353638312C302034
            2E383933312C312E3034303920362E353736312C322E37323339204C2031392E
            373738322C342E3232313820432031372E373837362C322E323331322031352E
            303337362C312031322C3120352E393234392C3120312C352E3932343920312C
            3132206320302C332E3033373620312E323331322C352E3738373620332E3232
            31382C372E37373832207A222F3E0D0A090909093C706174682069643D227061
            7468383536222066696C6C3D22233835393141312220643D224D20362E313136
            372C31312E363434352031312E3931352C352E38343632206320302E31353536
            2C2D302E3135353620302E343130312C2D302E3135353620302E353635372C30
            206C20302E383438352C302E38343835206320302E313535362C302E31353536
            20302E313535362C302E3434353420302C302E36303039204C20392E36363031
            2C3131206820382E30313935206320302E32322C3020302E343230342C302E31
            30393520302E343230342C302E33323935207620312E3220432031382E312C31
            322E373439352031372E383939362C31332031372E363739362C313320482039
            2E36363435206C20332E363634372C332E36323934206320302E313535362C30
            2E3135353620302E313535362C302E3339323520302C302E35343831206C202D
            302E383438352C302E383339372063202D302E313535362C302E31353536202D
            302E343130312C302E31353132202D302E353635372C2D302E30303434204C20
            362E393635332C31332E3036303920362E313136382C31322E32313133204320
            352E393631312C31322E3035353720352E393631312C31312E3820362E313136
            372C31312E36343435205A222F3E0D0A0909093C2F673E0D0A0909093C726563
            742069643D2272656374383332222066696C6C3D222346464646464622206669
            6C6C2D6F7061636974793D223022207374726F6B653D226E6F6E652220737472
            6F6B652D77696474683D22302E303732343822207472616E73666F726D3D226D
            617472697828302E3731313034202D302E3730333135202D302E363934313820
            302E3731393820302030292220783D22313139312E323738303870782220793D
            22313138342E3931373131707822206865696768743D22362E36363536317078
            222077696474683D2232312E36323030397078222072783D2230707822207279
            3D22307078222F3E0D0A09093C2F673E0D0A093C2F673E0D0A3C2F7376673E0D
            0A}
          Properties.GlyphCount = 2
          Properties.NullStyle = nssUnchecked
          HeaderHint = 
            'Si se muestra un bot'#243'n, '#233'ste da acceso a la l'#237'nea del documento ' +
            'que origin'#243' este registro'
          MinWidth = 30
          Options.Editing = False
          Options.Focusing = False
          Width = 51
        end
        object GridViewNroRegistro: TcxGridDBColumn
          DataBinding.FieldName = 'NroRegistro'
          Visible = False
          MinWidth = 30
        end
        object GridViewNroRegistroOrigen: TcxGridDBColumn
          DataBinding.FieldName = 'NroRegistroOrigen'
          Visible = False
          MinWidth = 30
        end
        object GridViewAnotacion: TcxGridDBColumn
          DataBinding.FieldName = 'Anotacion'
          PropertiesClassName = 'TcxRichEditProperties'
          MinWidth = 30
          Options.Editing = False
        end
        object GridViewCodigoTipoIVA: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoTipoIVA'
          Visible = False
          MinWidth = 30
        end
        object GridViewCuotaIVA: TcxGridDBColumn
          DataBinding.FieldName = 'CuotaIVA'
          Visible = False
          MinWidth = 30
        end
        object GridViewCuotaRE: TcxGridDBColumn
          DataBinding.FieldName = 'CuotaRE'
          Visible = False
          MinWidth = 30
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object TableViewManager: TGridTableViewController
      AlignWithMargins = True
      Left = 1506
      Top = 223
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 5
      Margins.Bottom = 0
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      PanelStyle.CaptionIndent = 3
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 2
      TableView = GridView
      ShiftRecords = True
      UseGridFilterBox = False
      BeforeValidateTableView = TableViewManagerBeforeValidateTableView
      OnRowShift = TableViewManagerRowShift
      OnCanDeleteRow = TableViewManagerCanAlterRow
      OnCanInsertRow = TableViewManagerCanAlterRow
      OnCanShiftRow = TableViewManagerCanShiftRow
      Height = 449
      Width = 60
    end
    object DataPanelSplitter: TcxSplitter
      Left = 2
      Top = 211
      Width = 1569
      Height = 12
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      HotZoneClassName = 'TcxSimpleStyle'
      AlignSplitter = salTop
      DragThreshold = 5
      PositionAfterOpen = 45
      MinSize = 12
      Control = TopPanel
    end
  end
  object FormManager: TgxFormManager
    BackDropForm = True
    Dataset = MovimientoTable
    FirstKeyControl = SerieCtrl
    FirstDataControl = ClienteCtrl
    Model = fmEditForm
    RelatedDocsMenu = RelacionesPopupMenu
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnDestroyForm = FormManagerDestroyForm
    OnShowForm = FormManagerShowForm
    OnPreparedForm = FormManagerPreparedForm
    OnCopyCurrentRecord = FormManagerCopyCurrentRecord
    OnDeleteEmptyHeader = FormManagerDeleteEmptyHeader
    OnReportRequest = FormManagerReportRequest
    OnReportFormRequest = FormManagerReportFormRequest
    OnActivateRelatedDocsButton = FormManagerActivateRelatedDocsButton
    OnLabelsRequest = FormManagerLabelsRequest
    OnNoteRequest = FormManagerNoteRequest
    OnInsertRecRequest = FormManagerInsertRecRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    OnGetAccessLevel = FormManagerGetAccessLevel
    OnUpdateButtonsState = FormManagerUpdateButtonsState
    OnShowCantEditMessage = FormManagerShowCantEditMessage
    Left = 644
    Top = 256
  end
  object MovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterInsert = MovimientoTableAfterInsert
    AfterEdit = MovimientoTableAfterEdit
    BeforePost = MovimientoTableBeforePost
    AfterPost = MovimientoTableAfterPost
    AfterCancel = MovimientoTableAfterCancel
    BeforeScroll = MovimientoTableBeforeScroll
    OnNewRecord = MovimientoTableNewRecord
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    AutoIncFieldName = 'NroDocumento'
    OnCheckDetailDatasets = MovimientoTableCheckDetailDatasets
    OnCanEditRecord = MovimientoTableCanEditRecord
    OnSetKey = MovimientoTableSetKey
    OnGetRecord = MovimientoTableGetRecord
    OnRecordChanged = MovimientoTableRecordChanged
    OnOpenRecord = MovimientoTableOpenRecord
    OnUpdateState = MovimientoTableUpdateState
    OnGetAutoIncValue = MovimientoTableGetAutoIncValue
    OnRemotePost = MovimientoTableRemotePost
    OnRemoteDelete = MovimientoTableRemoteDelete
    RemoteEdit = True
    Left = 612
    Top = 256
  end
  object MovimientoDataSource: TDataSource
    DataSet = MovimientoTable
    Left = 581
    Top = 256
  end
  object LineaMovimientoAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'TipoMovimientoOrigen;EjercicioOrigen;NroOperacionOrigen'
    AutoIncFieldName = 'NroLinea'
    MasterRelation = mrTied
    Left = 333
    Top = 256
  end
  object GrupoLineaMovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterClose = GrupoLineaMovimientoTableAfterClose
    BeforeDelete = GrupoLineaMovimientoTableBeforeDelete
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    MasterFields = 'Ejercicio;NroOperacion'
    MasterSource = MovimientoDataSource
    AutoIncFieldName = 'NroPagina'
    MasterRelation = mrTied
    Left = 549
    Top = 256
    object GrupoLineaMovimientoTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object GrupoLineaMovimientoTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object GrupoLineaMovimientoTableNroPagina: TSmallintField
      FieldName = 'NroPagina'
    end
    object GrupoLineaMovimientoTableCodigoGrupo: TWideStringField
      FieldName = 'CodigoGrupo'
      Size = 2
    end
    object GrupoLineaMovimientoTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object GrupoLineaMovimientoTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
  end
  object GrupoLineaDataSource: TDataSource
    DataSet = GrupoLineaMovimientoTable
    Enabled = False
    Left = 516
    Top = 256
  end
  object LineaMovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterOpen = LineaMovimientoTableAfterOpen
    AfterClose = LineaMovimientoTableAfterClose
    BeforeInsert = LineaMovimientoTableBeforeInsert
    AfterEdit = LineaMovimientoTableAfterEdit
    BeforePost = LineaMovimientoTableBeforePost
    AfterPost = LineaMovimientoTableAfterPost
    AfterDelete = LineaMovimientoTableAfterDelete
    OnCalcFields = LineaMovimientoTableCalcFields
    OnNewRecord = LineaMovimientoTableNewRecord
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    MasterFields = 'Ejercicio;NroOperacion;NroPagina'
    MasterSource = GrupoLineaDataSource
    AutoIncFieldName = 'NroLinea'
    MasterRelation = mrTied
    OnRecordChanged = LineaMovimientoTableRecordChanged
    OnRemotePost = LineaMovimientoTableRemotePost
    OnRemoteDelete = LineaMovimientoTableRemoteDelete
    RemoteEdit = True
    Left = 477
    Top = 256
    object LineaMovimientoTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
      Required = True
    end
    object LineaMovimientoTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
      Required = True
    end
    object LineaMovimientoTableNroPagina: TSmallintField
      FieldName = 'NroPagina'
      Required = True
    end
    object LineaMovimientoTableNroLinea: TSmallintField
      FieldName = 'NroLinea'
      Required = True
    end
    object LineaMovimientoTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object LineaMovimientoTableNroRegistro: TUnsignedAutoIncField
      FieldName = 'NroRegistro'
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
    object LineaMovimientoTableCantidadAjustada: TBCDField
      FieldName = 'CantidadAjustada'
    end
    object LineaMovimientoTableCantidadProcesada: TBCDField
      FieldName = 'CantidadProcesada'
    end
    object LineaMovimientoTablePrecio: TFloatField
      FieldName = 'Precio'
    end
    object LineaMovimientoTablePrecioDivisa: TBCDField
      FieldName = 'PrecioDivisa'
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
    object LineaMovimientoTableNoCalcularMargen: TBooleanField
      FieldName = 'NoCalcularMargen'
    end
    object LineaMovimientoTableTipoLinea: TWideStringField
      FieldName = 'TipoLinea'
      Size = 2
    end
    object LineaMovimientoTableOferta: TBooleanField
      FieldName = 'Oferta'
    end
    object LineaMovimientoTablePesoEnvase: TBCDField
      FieldName = 'PesoEnvase'
      Precision = 16
    end
    object LineaMovimientoTableTara: TBCDField
      FieldName = 'Tara'
    end
    object LineaMovimientoTablePeso: TBCDField
      FieldName = 'Peso'
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
    object LineaMovimientoTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object LineaMovimientoTableTieneRegistroOrigen: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'TieneRegistroOrigen'
      Calculated = True
    end
    object LineaMovimientoTableProcesada: TBooleanField
      FieldName = 'Procesada'
    end
    object LineaMovimientoTableParametros: TWordField
      FieldName = 'Parametros'
    end
    object LineaMovimientoTableFechaCaducidad: TDateField
      FieldName = 'FechaCaducidad'
    end
    object LineaMovimientoTableCampoLibre1: TWideStringField
      FieldName = 'CampoLibre1'
    end
    object LineaMovimientoTableCampoLibre2: TWideStringField
      FieldName = 'CampoLibre2'
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
  object LineaMovimientoDataSource: TDataSource
    DataSet = LineaMovimientoTable
    Enabled = False
    Left = 446
    Top = 256
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
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
    UseSystemFont = True
    Left = 211
    Top = 256
    PixelsPerInch = 144
    object EditarDocItem: TdxBarButton
      Caption = 'Editar'
      Category = 1
      Visible = ivAlways
      OnClick = EditarDocItemClick
    end
    object FichaArticuloItem: TdxBarButton
      Caption = 'Ficha del art'#237'culo'
      Category = 1
      Visible = ivAlways
      OnClick = FichaArticuloItemClick
    end
    object RelacionMovimientoItem: TdxBarButton
      Caption = 'Relaci'#243'n de movimientos del art'#237'culo'
      Category = 1
      Visible = ivAlways
      OnClick = RelacionMovimientoItemClick
    end
    object ActualizarRelacionesItem: TdxBarButton
      Caption = 'Actualizar relaciones del documento'
      Category = 1
      Visible = ivAlways
      OnClick = ActualizarRelacionesItemClick
    end
    object MostrarAnotacionesItem: TdxBarButton
      Caption = 'Mostrar anotaciones'
      Category = 1
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = MostrarAnotacionesItemClick
    end
    object FacturaVentaItem: TdxBarButton
      Caption = '&Factura de venta'
      Category = 2
      Visible = ivAlways
      OnClick = FacturaVentaItemClick
    end
  end
  object PopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'EditarDocItem'
      end
      item
        Visible = True
        ItemName = 'FichaArticuloItem'
      end
      item
        Visible = True
        ItemName = 'RelacionMovimientoItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'ActualizarRelacionesItem'
      end
      item
        Visible = True
        ItemName = 'MostrarAnotacionesItem'
      end>
    UseOwnFont = False
    OnPopup = PopupMenuPopup
    Left = 244
    Top = 256
    PixelsPerInch = 144
  end
  object RelacionesPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'FacturaVentaItem'
      end>
    UseOwnFont = False
    Left = 276
    Top = 256
    PixelsPerInch = 144
  end
  object ComPort: TComPort
    BaudRate = br9600
    Port = 'COM1'
    Parity.Bits = prNone
    StopBits = sbOneStopBit
    DataBits = dbEight
    Events = [evRxChar, evTxEmpty, evRxFlag, evRing, evBreak, evCTS, evDSR, evError, evRLSD, evRx80Full]
    FlowControl.OutCTSFlow = False
    FlowControl.OutDSRFlow = False
    FlowControl.ControlDTR = dtrDisable
    FlowControl.ControlRTS = rtsDisable
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    StoredProps = [spBasic]
    TriggersOnRxChar = True
    OnException = ComPortException
    Left = 213
    Top = 296
  end
end
