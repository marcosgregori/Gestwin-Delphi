object MntMveForm: TMntMveForm
  Left = 309
  Top = 279
  HelpType = htKeyword
  HelpKeyword = 'a_mve'
  BorderStyle = bsDialog
  ClientHeight = 569
  ClientWidth = 1130
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
    TabOrder = 0
    OnEnter = KeyPanelEnter
    PanelKind = epKeyPanel
    Height = 36
    Width = 1130
    object TituloDocumentoLabel: TcxLabel
      AlignWithMargins = True
      Left = 885
      Top = 5
      Margins.Right = 10
      TabStop = False
      Align = alRight
      AutoSize = False
      Caption = 'ALBAR'#193'N DE VENTA'
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
      TabOrder = 1
      Transparent = True
      Height = 26
      Width = 233
      AnchorX = 1118
      AnchorY = 18
    end
    object Panel1: TcxGroupBox
      AlignWithMargins = True
      Left = 133
      Top = 4
      Margins.Top = 2
      Margins.Bottom = 2
      Align = alLeft
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 0
      Transparent = True
      Height = 28
      Width = 134
      object SerieCtrl: TcxDBTextEdit
        Left = 0
        Top = 0
        Align = alLeft
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = MovimientoDataSource
        Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
        Properties.OnEditRequest = SerieCtrlPropertiesEditRequest
        Properties.OnValidate = SerieCtrlPropertiesValidate
        TabOrder = 0
        ExplicitHeight = 21
        Width = 28
      end
      object SeparadorSerieLabel: TcxLabel
        Left = 28
        Top = 0
        TabStop = False
        Align = alLeft
        AutoSize = False
        Caption = '-'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        TabOrder = 1
        Transparent = True
        Height = 28
        Width = 10
        AnchorX = 33
        AnchorY = 14
      end
      object NroDocumentoCtrl: TcxDBIntegerEdit
        Left = 65
        Top = 0
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
        TabOrder = 2
        ExplicitHeight = 21
        Width = 66
      end
      object LockRangeButton: TgxLockRangeButton
        AlignWithMargins = True
        Left = 38
        Top = 0
        Width = 24
        Height = 28
        Hint = 
          'Bloqueo del campo (Navegar fijando este campo).'#13'Teclas <Ctrl>+<B' +
          '>'
        Margins.Left = 0
        Margins.Top = 0
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
        OptionsImage.Spacing = 2
        ParentShowHint = False
        ShowHint = True
        SpeedButtonOptions.GroupIndex = 1
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.AllowAllUp = True
        SpeedButtonOptions.Down = True
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 3
        EditControl = SerieCtrl
        OnLockRange = LockRangeButtonLockRange
      end
    end
    object NroDocumentoCaptionLabel: TcxLabel
      AlignWithMargins = True
      Left = 14
      Top = 5
      Margins.Left = 8
      Margins.Right = 0
      TabStop = False
      Align = alLeft
      AutoSize = False
      Caption = 'N'#186'  de pedido'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 2
      Transparent = True
      Height = 26
      Width = 116
      AnchorY = 18
    end
    object EstadoLabel: TcxLabel
      AlignWithMargins = True
      Left = 274
      Top = 5
      Margins.Left = 4
      TabStop = False
      Align = alClient
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 3
      Transparent = True
      Height = 26
      Width = 431
      AnchorY = 18
    end
    object OrigenLabel: TcxLabel
      Left = 788
      Top = 2
      TabStop = False
      Align = alRight
      AutoSize = False
      Caption = 'CAPTURADOR'
      ParentColor = False
      Style.LookAndFeel.NativeStyle = False
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
      Height = 32
      Width = 94
      AnchorX = 835
      AnchorY = 18
    end
    object AnuladoLabel: TcxLabel
      Left = 708
      Top = 2
      TabStop = False
      Align = alRight
      AutoSize = False
      Caption = 'ANULADO'
      ParentColor = False
      ParentFont = False
      Style.Color = clBtnFace
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -15
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
      TabOrder = 5
      Transparent = True
      Visible = False
      Height = 32
      Width = 80
      AnchorX = 748
      AnchorY = 18
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 533
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      1130
      36)
    Height = 36
    Width = 1130
    object ButtonContainerPanel: TcxGroupBox
      Left = 144
      Top = 0
      Anchors = [akTop]
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 842
      object OkButton: TgBitBtn
        Left = 2
        Top = 2
        Width = 86
        Height = 32
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
      object DeleteButton: TgBitBtn
        AlignWithMargins = True
        Left = 176
        Top = 2
        Width = 86
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
        Left = 392
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Caption = 'Fac&turar'
        Enabled = True
        OptionsImage.ImageIndex = 64
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 4
        OnClick = FacturarButtonClick
        GlyphBitmap = gmInvoice
      end
      object FacturaDirectaButton: TgBitBtn
        AlignWithMargins = True
        Left = 295
        Top = 2
        Width = 95
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Caption = '&Fra directa'
        Enabled = True
        OptionsImage.ImageIndex = 65
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 3
        OnClick = FacturaDirectaButtonClick
        GlyphBitmap = gmInvoiceOk
      end
      object ExportarButton: TgBitBtn
        AlignWithMargins = True
        Left = 479
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Caption = 'E&xportar'
        Enabled = True
        OptionsImage.ImageIndex = 30
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 5
        OnClick = ExportarButtonClick
        GlyphBitmap = gmExport
      end
      object CloseButton: TgBitBtn
        AlignWithMargins = True
        Left = 90
        Top = 2
        Width = 84
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
      object FirmarButton: TgBitBtn
        AlignWithMargins = True
        Left = 566
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Caption = 'Fi&rmar'
        Enabled = True
        OptionsImage.ImageIndex = 61
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 6
        Visible = False
        OnClick = FirmarButtonClick
        GlyphBitmap = gmSign
      end
      object HojaCargaButton: TgBitBtn
        AlignWithMargins = True
        Left = 653
        Top = 2
        Width = 100
        Height = 32
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Caption = '&Hoja carga'
        Enabled = True
        OptionsImage.ImageIndex = 28
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 7
        Visible = False
        GlyphBitmap = gmDocSingle
      end
      object LanzarButton: TgBitBtn
        AlignWithMargins = True
        Left = 755
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Caption = '&Lanzar'
        Enabled = True
        OptionsImage.ImageIndex = 33
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 8
        Visible = False
        GlyphBitmap = gmGears
      end
    end
    object FirmadoLabel: TcxLabel
      Left = 1031
      Top = 6
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
      Height = 25
      Width = 94
      AnchorX = 1078
      AnchorY = 19
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
    OnEnter = DataPanelEnter
    PanelKind = epDataPanel
    Height = 497
    Width = 1120
    object BottomPanel: TcxGroupBox
      Left = 2
      Top = 435
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Transparent = True
      Height = 60
      Width = 1116
      object Bottom1ScrollBox: TcxScrollBox
        Left = 2
        Top = 2
        Width = 184
        Height = 56
        Align = alLeft
        BorderStyle = cxcbsNone
        TabOrder = 0
        Transparent = True
        VertScrollBar.Visible = False
        object ServidoPanel: TgxScrollBoxPanel
          Left = 0
          Top = 54
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Transparent = True
          Height = 27
          Width = 184
          object ServidoCtrl: TcxDBCheckBox
            Left = 6
            Top = 1
            AutoSize = False
            Caption = 'Servido'
            DataBinding.DataField = 'Servido'
            DataBinding.DataSource = MemDataSource
            Properties.OnValuePosted = ServidoCtrlPropertiesValuePosted
            Properties.Alignment = taRightJustify
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 0
            Transparent = True
            Height = 21
            Width = 95
          end
        end
        object NoFacturarPanel: TgxScrollBoxPanel
          Left = 0
          Top = 27
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Height = 27
          Width = 184
          object NoFacturarCtrl: TcxDBCheckBox
            Left = 6
            Top = 1
            AutoSize = False
            Caption = 'No facturar'
            DataBinding.DataField = 'NoFacturar'
            DataBinding.DataSource = MovimientoDataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            TabOrder = 0
            Transparent = True
            Height = 21
            Width = 95
          end
        end
        object EstadoPanel: TgxScrollBoxPanel
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 2
          Transparent = True
          Height = 27
          Width = 184
          object EstadoCtrl: TcxDBIndexedComboBox
            Left = 85
            Top = 1
            DataBinding.DataField = 'Situacion'
            DataBinding.DataSource = MovimientoDataSource
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'Pendiente'
              'Aceptado'
              'Cancelado')
            TabOrder = 0
            Width = 91
          end
          object Label19: TcxLabel
            Left = 10
            Top = 5
            TabStop = False
            Caption = 'Estado'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object EnviadoPanel: TgxScrollBoxPanel
          Left = 0
          Top = 81
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 3
          Transparent = True
          Height = 27
          Width = 184
          object EnviadoCtrl: TcxDBCheckBox
            Left = 6
            Top = 1
            AutoSize = False
            Caption = 'Enviado'
            DataBinding.DataField = 'Enviado'
            DataBinding.DataSource = MemDataSource
            Properties.OnValuePosted = EnviadoCtrlPropertiesValuePosted
            Properties.Alignment = taRightJustify
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = False
            TabOrder = 0
            Transparent = True
            Height = 21
            Width = 95
          end
        end
      end
      object Bottom2ScrollBox: TcxScrollBox
        Left = 186
        Top = 2
        Width = 250
        Height = 56
        Align = alLeft
        BorderStyle = cxcbsNone
        TabOrder = 1
        Transparent = True
        VertScrollBar.Visible = False
        object EntregaACuentaPanel: TgxScrollBoxPanel
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Transparent = True
          Height = 27
          Width = 250
          object EntregaACuentaCtrl: TcxDBCurrencyEdit
            Left = 95
            Top = 2
            DataBinding.DataField = 'EntregaACuenta'
            DataBinding.DataSource = MovimientoDataSource
            Properties.MaxLength = 8
            TabOrder = 0
            Width = 71
          end
          object Label18: TcxLabel
            Left = 9
            Top = 5
            TabStop = False
            Caption = 'A cuenta/Efec.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
          object EntregasACuentaPedidosLabel: TcxLabel
            AlignWithMargins = True
            Left = 172
            Top = 3
            Hint = 
              'Entregas a cuenta anotadas en los pedidos incluidos en este alba' +
              'r'#225'n.'
            TabStop = False
            AutoSize = False
            ParentShowHint = False
            ShowHint = True
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
            TabOrder = 2
            Transparent = True
            Height = 23
            Width = 75
            AnchorX = 247
            AnchorY = 15
          end
        end
        object PortesPanel: TgxScrollBoxPanel
          Left = 0
          Top = 27
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Transparent = True
          Height = 27
          Width = 250
          object PortesCtrl: TcxDBCurrencyEdit
            Left = 95
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
            Top = 4
            TabStop = False
            Caption = 'Portes'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
      end
      object CantidadTotalPanel: TcxGroupBox
        AlignWithMargins = True
        Left = 526
        Top = 2
        Margins.Left = 6
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Height = 56
        Width = 82
        object CantidadLabel: TcxLabel
          Left = 0
          Top = 5
          TabStop = False
          Caption = 'Cantidad'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object FooterPanelCantidad: TcxLabel
          Left = 0
          Top = 27
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
          AnchorX = 77
          AnchorY = 40
        end
      end
      object ServidoTotalPanel: TcxGroupBox
        AlignWithMargins = True
        Left = 614
        Top = 2
        Margins.Left = 6
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 3
        Height = 56
        Width = 76
        object FooterPanelServido: TcxLabel
          Left = 0
          Top = 27
          TabStop = False
          CaptionLabel = ServidoLabel
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
          TabOrder = 0
          Transparent = True
          Height = 25
          Width = 75
          AnchorX = 75
          AnchorY = 40
        end
        object ServidoLabel: TcxLabel
          Left = 1
          Top = 5
          TabStop = False
          Caption = 'Servido'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
      end
      object PesoTotalPanel: TcxGroupBox
        AlignWithMargins = True
        Left = 696
        Top = 2
        Margins.Left = 6
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 4
        Height = 56
        Width = 80
        object FooterPanelPeso: TcxLabel
          Left = 0
          Top = 27
          TabStop = False
          CaptionLabel = PesoLabel
          AutoSize = False
          ParentShowHint = False
          ShowHint = True
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
          TabOrder = 0
          Transparent = True
          Height = 25
          Width = 75
          AnchorX = 75
          AnchorY = 40
        end
        object PesoLabel: TcxLabel
          Left = 0
          Top = 5
          TabStop = False
          Caption = 'Peso'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
      end
      object TotalesPanel: TcxGroupBox
        Left = 850
        Top = 2
        Align = alRight
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 5
        Transparent = True
        Height = 56
        Width = 264
        object cxLabel4: TcxLabel
          Left = 7
          Top = 5
          TabStop = False
          Caption = 'Importe'
          Style.BorderStyle = ebsNone
          Style.Edges = [bLeft, bTop, bRight, bBottom]
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 0
          Transparent = True
          AnchorY = 14
        end
        object cxLabel5: TcxLabel
          Left = 7
          Top = 31
          TabStop = False
          Caption = 'Total (I.V.A. Inc.)'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
        object FooterPanelImporte: TcxLabel
          Left = 107
          Top = 1
          TabStop = False
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
          TabOrder = 2
          Transparent = True
          Height = 25
          Width = 113
          AnchorX = 220
          AnchorY = 14
        end
        object FooterPanelIVAIncluido: TcxLabel
          Left = 107
          Top = 27
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
          Style.TransparentBorder = True
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
          AnchorX = 220
          AnchorY = 40
        end
      end
      object AltoTotalPanel: TcxGroupBox
        AlignWithMargins = True
        Left = 442
        Top = 2
        Margins.Left = 6
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 6
        Visible = False
        Height = 56
        Width = 78
        object FooterPanelAlto: TcxLabel
          Left = 0
          Top = 27
          TabStop = False
          CaptionLabel = AltoLabel
          AutoSize = False
          ParentShowHint = False
          ShowHint = True
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
          TabOrder = 0
          Transparent = True
          Height = 25
          Width = 75
          AnchorX = 75
          AnchorY = 40
        end
        object AltoLabel: TcxLabel
          Left = 0
          Top = 5
          TabStop = False
          Caption = 'Alto'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
      end
    end
    object TopPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      Constraints.MaxHeight = 390
      Constraints.MinHeight = 113
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Transparent = True
      DesignSize = (
        1116
        114)
      Height = 114
      Width = 1116
      object FechaCtrl: TcxDBDateEdit
        Left = 126
        Top = 28
        DataBinding.DataField = 'Fecha'
        DataBinding.DataSource = MovimientoDataSource
        Properties.Required = True
        Properties.OnValidate = FechaCtrlPropertiesValidate
        TabOrder = 1
        Width = 100
      end
      object TopScrollBox: TcxScrollBox
        Left = -1
        Top = 53
        Width = 430
        Height = 55
        Anchors = [akLeft, akTop, akBottom]
        AutoScroll = False
        BorderStyle = cxcbsNone
        HorzScrollBar.Range = 0
        HorzScrollBar.Visible = False
        TabOrder = 2
        Transparent = True
        VertScrollBar.Increment = 27
        VertScrollBar.Range = 345
        VertScrollBar.Tracking = True
        object FechaAplicacionPanel: TgxScrollBoxPanel
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Transparent = True
          Height = 27
          Width = 413
          object FechaAplicacionCtrl: TcxDBDateEdit
            Left = 127
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
            Caption = 'Fecha de entrega'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 1
            Transparent = True
            AnchorY = 13
          end
        end
        object GrupoClientePanel: TgxScrollBoxPanel
          Left = 0
          Top = 81
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 3
          Transparent = True
          Height = 27
          Width = 413
          object GrupoClienteCtrl: TcxDBTextEdit
            Left = 127
            Top = 1
            DescriptionLabel = Label1
            DataBinding.DataField = 'GrupoFacturacion'
            DataBinding.DataSource = MovimientoDataSource
            Properties.OnQueryRequest = GrupoClienteCtrlPropertiesQueryRequest
            Properties.OnEditRequest = GrupoClienteCtrlPropertiesEditRequest
            Properties.OnValidate = GrupoClienteCtrlPropertiesValidate
            TabOrder = 0
            Width = 34
          end
          object Label1: TcxLabel
            Left = 230
            Top = 2
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 1
            Transparent = True
            Height = 20
            Width = 200
            AnchorY = 12
          end
          object Label5: TcxLabel
            Left = 6
            Top = 4
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
          Top = 189
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 7
          Transparent = True
          Height = 27
          Width = 413
          object VendedorCtrl: TcxDBTextEdit
            Left = 127
            Top = 1
            DescriptionLabel = Label7
            DataBinding.DataField = 'CodigoVendedor'
            DataBinding.DataSource = MovimientoDataSource
            Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
            Properties.OnEditRequest = VendedorCtrlPropertiesEditRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = VendedorCtrlPropertiesValidate
            TabOrder = 0
            Width = 25
          end
          object Label7: TcxLabel
            Left = 230
            Top = 2
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 1
            Transparent = True
            Height = 20
            Width = 200
            AnchorY = 12
          end
          object Label8: TcxLabel
            Left = 6
            Top = 4
            TabStop = False
            Caption = 'Vendedor'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
        end
        object FormaCobroPanel: TgxScrollBoxPanel
          Left = 0
          Top = 162
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 6
          Transparent = True
          Height = 27
          Width = 413
          object FormaCobroCtrl: TcxDBTextEdit
            Left = 127
            Top = 0
            DescriptionLabel = Label11
            DataBinding.DataField = 'CodigoFormaCobro'
            DataBinding.DataSource = MovimientoDataSource
            Properties.OnQueryRequest = FormaCobroCtrlPropertiesQueryRequest
            Properties.OnEditRequest = FormaCobroCtrlPropertiesEditRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = FormaCobroCtrlPropertiesValidate
            TabOrder = 0
            Width = 25
          end
          object Label11: TcxLabel
            Left = 230
            Top = 1
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 1
            Transparent = True
            Height = 20
            Width = 200
            AnchorY = 11
          end
          object Label13: TcxLabel
            Left = 6
            Top = 3
            TabStop = False
            Caption = 'Forma de cobro'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
        end
        object RegistroAuxiliarPanel: TgxScrollBoxPanel
          Left = 0
          Top = 54
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 2
          Transparent = True
          Height = 27
          Width = 413
          object RegistroAuxiliarCtrl: TcxDBTextEdit
            Left = 127
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
            Left = 230
            Top = 2
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 1
            Transparent = True
            Height = 20
            Width = 200
            AnchorY = 12
          end
          object RegistroAuxiliarLabel: TcxLabel
            Left = 6
            Top = 4
            TabStop = False
            Caption = 'Registro auxiliar'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 2
            Transparent = True
            AnchorY = 13
          end
        end
        object CentroCostePanel: TgxScrollBoxPanel
          Left = 0
          Top = 243
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 9
          Transparent = True
          Height = 27
          Width = 413
          object CentroCosteCtrl: TcxDBTextEdit
            Left = 127
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
            Left = 230
            Top = 2
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 1
            Transparent = True
            Height = 20
            Width = 200
            AnchorY = 12
          end
          object Label12: TcxLabel
            Left = 6
            Top = 4
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
          Top = 108
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 4
          Transparent = True
          Height = 27
          Width = 413
          object TransportistaCtrl: TcxDBTextEdit
            Left = 127
            Top = 1
            DescriptionLabel = Label16
            DataBinding.DataField = 'CodigoTransportista'
            DataBinding.DataSource = MovimientoDataSource
            Properties.OnQueryRequest = TransportistaCtrlPropertiesQueryRequest
            Properties.OnEditRequest = TransportistaCtrlPropertiesEditRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = TransportistaCtrlPropertiesValidate
            TabOrder = 0
            Width = 25
          end
          object Label16: TcxLabel
            Left = 230
            Top = 2
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 1
            Transparent = True
            Height = 20
            Width = 200
            AnchorY = 12
          end
          object Label17: TcxLabel
            Left = 6
            Top = 4
            TabStop = False
            Caption = 'Transportista'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
        end
        object NroDocumentoPropietarioPanel: TgxScrollBoxPanel
          Left = 0
          Top = 216
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 8
          Transparent = True
          Height = 27
          Width = 413
          object NroDocumentoPropietarioCtrl: TcxDBTextEdit
            Left = 127
            Top = 1
            DataBinding.DataField = 'NroDocumentoPropietario'
            DataBinding.DataSource = MovimientoDataSource
            TabOrder = 0
            Width = 101
          end
          object Label21: TcxLabel
            Left = 6
            Top = 5
            TabStop = False
            Caption = 'Su n'#186' de pedido'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object OperarioPanel: TgxScrollBoxPanel
          Left = 0
          Top = 135
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 5
          Transparent = True
          Height = 27
          Width = 413
          object CodigoOperarioCtrl: TcxDBTextEdit
            Left = 127
            Top = 1
            DescriptionLabel = NombreOperarioLabel
            DataBinding.DataField = 'CodigoOperario'
            DataBinding.DataSource = MovimientoDataSource
            Properties.OnQueryRequest = CodigoOperarioCtrlPropertiesQueryRequest
            Properties.OnEditRequest = CodigoOperarioCtrlPropertiesEditRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = CodigoOperarioCtrlPropertiesValidate
            TabOrder = 0
            Width = 46
          end
          object NombreOperarioLabel: TcxLabel
            Left = 230
            Top = 2
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 1
            Transparent = True
            Height = 20
            Width = 200
            AnchorY = 12
          end
          object OperarioLabel: TcxLabel
            Left = 6
            Top = 4
            TabStop = False
            Caption = 'Operario'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
        end
        object FormaEnvioPanel: TgxScrollBoxPanel
          Left = 0
          Top = 270
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 10
          Transparent = True
          Height = 27
          Width = 413
          object FormaEnvioCtrl: TcxDBTextEdit
            Left = 127
            Top = 1
            DescriptionLabel = DescFormaEnvioLabel
            DataBinding.DataField = 'FormaEnvio'
            DataBinding.DataSource = MovimientoDataSource
            Properties.OnQueryRequest = FormaEnvioCtrlPropertiesQueryRequest
            Properties.OnEditRequest = FormaEnvioCtrlPropertiesEditRequest
            Properties.OnValuePosted = FormaEnvioCtrlPropertiesValuePosted
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = FormaEnvioCtrlPropertiesValidate
            TabOrder = 0
            Width = 25
          end
          object DescFormaEnvioLabel: TcxLabel
            Left = 230
            Top = 2
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 1
            Transparent = True
            Height = 20
            Width = 200
            AnchorY = 12
          end
          object CaptionFormaEnvioLabel: TcxLabel
            Left = 6
            Top = 4
            TabStop = False
            Caption = 'Forma de env'#237'o'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
        end
        object DepartamentoPanel: TgxScrollBoxPanel
          Left = 0
          Top = 27
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Transparent = True
          Height = 27
          Width = 413
          object OrganismoPublicoCtrl: TcxDBTextEdit
            Left = 127
            Top = 1
            DescriptionLabel = cxLabel1
            DataBinding.DataField = 'OrganismoPublico'
            DataBinding.DataSource = MovimientoDataSource
            Properties.OnQueryRequest = OrganismoPublicoCtrlPropertiesQueryRequest
            Properties.OnEditRequest = OrganismoPublicoCtrlPropertiesEditRequest
            Properties.OnValidate = OrganismoPublicoCtrlPropertiesValidate
            TabOrder = 0
            Width = 90
          end
          object cxLabel1: TcxLabel
            Left = 230
            Top = 2
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 1
            Transparent = True
            Height = 20
            Width = 170
            AnchorY = 12
          end
          object cxLabel3: TcxLabel
            Left = 6
            Top = 4
            TabStop = False
            Caption = 'Unidad tramitadora'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 2
            Transparent = True
            AnchorY = 13
          end
        end
        object OfertaPanel: TgxScrollBoxPanel
          Left = 0
          Top = 297
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 11
          Transparent = True
          Height = 27
          Width = 413
          object cxLabel7: TcxLabel
            Left = 6
            Top = 5
            TabStop = False
            Caption = 'Oferta'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 0
            Transparent = True
          end
          object OpcionCtrl: TcxDBIndexedComboBox
            Left = 127
            Top = 1
            DataBinding.DataField = 'Opcion'
            DataBinding.DataSource = MovimientoDataSource
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'Presupuesto'
              'Administraci'#243'n'
              'Administraci'#243'n sin hoja de horas')
            TabOrder = 1
            Width = 214
          end
        end
      end
      object ClienteCtrl: TcxDBTextEdit
        Left = 126
        Top = 1
        DescriptionLabel = Label9
        DataBinding.DataField = 'Propietario'
        DataBinding.DataSource = MovimientoDataSource
        Properties.Required = True
        Properties.OnExtendedFunction = ClienteCtrlPropertiesExtendedFunction
        Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
        Properties.OnEditRequest = ClienteCtrlPropertiesEditRequest
        Properties.OnValuePosted = ClienteCtrlPropertiesValuePosted
        Properties.TextEditPad = tpLeftZero
        Properties.PadAlways = True
        Properties.OnEditValueChanged = ClienteCtrlPropertiesEditValueChanged
        Properties.OnValidate = ClienteCtrlPropertiesValidate
        TabOrder = 0
        Width = 46
      end
      object Label3: TcxLabel
        Left = 6
        Top = 32
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
      end
      object Label10: TcxLabel
        Left = 6
        Top = 4
        TabStop = False
        Caption = 'C'#243'digo cliente'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
      end
      object Label9: TcxLabel
        Left = 267
        Top = 4
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 7
        Transparent = True
        Height = 20
        Width = 536
        AnchorY = 14
      end
      object CamposLibresScrollBox: TcxScrollBox
        Left = 435
        Top = 27
        Width = 373
        Height = 82
        Anchors = [akLeft, akTop, akBottom]
        AutoScroll = False
        BorderStyle = cxcbsNone
        HorzScrollBar.Range = 0
        HorzScrollBar.Visible = False
        TabOrder = 3
        Transparent = True
        VertScrollBar.Increment = 27
        VertScrollBar.Range = 145
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
          Width = 356
          object CampoLibre5Ctrl: TcxDBTextEdit
            Left = 130
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
            Width = 120
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
          Width = 356
          object CampoLibre4Ctrl: TcxDBTextEdit
            Left = 130
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
            Width = 120
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
          Width = 356
          object CampoLibre3Ctrl: TcxDBTextEdit
            Left = 130
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
            Width = 120
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
          Width = 356
          object CampoLibre1Ctrl: TcxDBTextEdit
            Left = 130
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
            Width = 120
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
          Width = 356
          object CampoLibre2Ctrl: TcxDBTextEdit
            Left = 130
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
            Width = 120
          end
        end
      end
      object AvisoButton: TgBitBtn
        Left = 175
        Top = 0
        Width = 26
        Height = 26
        Hint = 'Mostrar el aviso asociado al cliente.\nTeclas [Ctrl]+[O]'
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
        TabOrder = 9
        TabStop = False
        Visible = False
        OnClick = AvisoButtonClick
        GlyphBitmap = gmWarning
      end
      object BotonesGroupBox: TcxGroupBox
        Left = 1014
        Top = 2
        Align = alRight
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 8
        Height = 110
        Width = 100
        object ConsumosPreciosButton: TgBitBtn
          Left = 2
          Top = 6
          Width = 96
          Height = 32
          Margins.Left = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alBottom
          Caption = 'C&onsumos'
          Enabled = True
          OptionsImage.ImageIndex = 55
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 4
          OptionsImage.Spacing = 5
          TabOrder = 0
          TabStop = False
          OnClick = ConsumosPreciosButtonClick
          GlyphBitmap = gmWindowList
        end
        object ImportarButton: TgBitBtn
          AlignWithMargins = True
          Left = 2
          Top = 41
          Width = 96
          Height = 32
          Margins.Left = 0
          Margins.Right = 0
          Align = alBottom
          Caption = '&Importar'
          Enabled = True
          OptionsImage.ImageIndex = 31
          OptionsImage.Images = ApplicationContainer.ButtonImageList
          OptionsImage.Margin = 4
          OptionsImage.Spacing = 5
          TabOrder = 1
          TabStop = False
          OnClick = ImportarButtonClick
          GlyphBitmap = gmImport
        end
        object DocumentosGroupBox: TcxGroupBox
          Left = 2
          Top = 76
          Align = alBottom
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 2
          Height = 32
          Width = 96
          object CarpetaDocumentosButton: TgBitBtn
            AlignWithMargins = True
            Left = 67
            Top = 0
            Width = 29
            Height = 32
            Hint = 'Seleccionar  la carpeta de documentos'
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alRight
            Enabled = True
            OptionsImage.ImageIndex = 21
            OptionsImage.Images = ApplicationContainer.ButtonImageList
            PaintStyle = bpsGlyph
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            TabStop = False
            OnClick = DirectorioDocumentosItemClick
            GlyphBitmap = gmFolder
          end
          object DocumentosButton: TgBitBtn
            AlignWithMargins = True
            Left = 0
            Top = 0
            Width = 64
            Height = 32
            Hint = 'Abrir la carpeta de documentos'
            Margins.Left = 0
            Margins.Top = 0
            Margins.Bottom = 0
            Align = alClient
            Caption = '&Doc.'
            Enabled = True
            OptionsImage.ImageIndex = 29
            OptionsImage.Images = ApplicationContainer.ButtonImageList
            OptionsImage.Margin = 4
            OptionsImage.Spacing = 5
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            TabStop = False
            OnClick = DocumentosButtonClick
            GlyphBitmap = gmDocStack
          end
        end
      end
      object AnotacionButton: TgBitBtn
        Left = 233
        Top = 28
        Width = 25
        Height = 25
        Hint = 'Mostrar la anotaci'#243'n del documento'
        Enabled = True
        OptionsImage.ImageIndex = 66
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 4
        TabStop = False
        OnClick = AnotacionButtonClick
        GlyphBitmap = gmComment
      end
    end
    object GridGroupBox: TcxGroupBox
      Left = 2
      Top = 124
      Align = alClient
      Alignment = alCenterCenter
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 1
      Transparent = True
      Height = 311
      Width = 1116
      object Panel3: TcxGroupBox
        Left = 0
        Top = 0
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 0
        Height = 311
        Width = 1116
        object PaginasPanel: TcxGroupBox
          Left = 0
          Top = 0
          Align = alLeft
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 0
          Height = 311
          Width = 250
          object Panel4: TcxGroupBox
            AlignWithMargins = True
            Left = 0
            Top = 0
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 2
            Align = alTop
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 1
            Height = 23
            Width = 250
            object PaginasLabel: TcxLabel
              Left = 0
              Top = -1
              TabStop = False
              AutoSize = False
              Caption = 'P'#225'ginas'
              ParentFont = False
              Style.Font.Charset = ANSI_CHARSET
              Style.Font.Color = clGray
              Style.Font.Height = -13
              Style.Font.Name = 'Segoe UI'
              Style.Font.Style = [fsBold]
              Style.Shadow = False
              Style.IsFontAssigned = True
              TabOrder = 0
              Transparent = True
              Height = 20
              Width = 244
            end
          end
          object PageGrid: TcxGrid
            Left = 0
            Top = 25
            Width = 212
            Height = 286
            Align = alClient
            TabOrder = 0
            object PageGridView: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              FilterBox.CustomizeDialog = False
              ScrollbarAnnotations.CustomAnnotations = <>
              DataController.DataModeController.SmartRefresh = True
              DataController.DataSource = GrupoLineaDataSource
              DataController.KeyFieldNames = 'Ejercicio;NroOperacion;NroPagina'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.PostponedSynchronization = False
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.FocusFirstCellOnNewRecord = True
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
              object PageGridViewGrupoDocumento: TcxGridDBColumn
                Caption = 'Gr.'
                DataBinding.FieldName = 'CodigoGrupo'
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.OnQueryRequest = PageGridViewGrupoDocumentoPropertiesQueryRequest
                Properties.OnEditRequest = PageGridViewGrupoDocumentoPropertiesEditRequest
                Properties.OnValuePosted = PageGridViewGrupoDocumentoPropertiesValuePosted
                Properties.OnValidate = PageGridViewGrupoDocumentoPropertiesValidate
                Width = 30
              end
              object PageGridViewDescripcion: TcxGridDBColumn
                Caption = 'Descripci'#243'n'
                DataBinding.FieldName = 'Descripcion'
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.Required = True
                Properties.OnEnter = PageGridViewDescripcionPropertiesEnter
                Width = 173
              end
            end
            object PageGridLevel: TcxGridLevel
              GridView = PageGridView
            end
          end
          object PageGridViewManager: TGridTableViewController
            Left = 212
            Top = 25
            Align = alRight
            Enabled = False
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TransparentBorder = False
            TabOrder = 2
            TableView = PageGridView
            ShiftRecords = True
            UseGridFilterBox = False
            OnDelete = PageGridViewManagerDelete
            OnRowShift = PageGridViewManagerRowShift
            OnRowInsert = PageGridViewManagerRowInsert
            Height = 286
            Width = 38
          end
        end
        object PaginacionSplitter: TcxSplitter
          Left = 250
          Top = 0
          Width = 8
          Height = 311
          Cursor = crHSplit
          HotZoneClassName = 'TcxSimpleStyle'
          Control = PaginasPanel
        end
        object Grid: TcxGrid
          Left = 258
          Top = 0
          Width = 820
          Height = 311
          Align = alClient
          TabOrder = 1
          OnEnter = GridEnter
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
                FieldName = 'CantidadProcesada'
                Column = GridViewServido
              end
              item
                Format = '#.###,00'
                Kind = skSum
                FieldName = 'Peso'
                Column = GridViewPeso
              end
              item
                Format = '#.###,00'
                Kind = skSum
                OnGetText = GridViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems3GetText
                FieldName = 'ImporteNeto'
                Column = GridViewImporte
              end
              item
                Format = '#.###,00'
                Kind = skSum
                FieldName = 'CuotaIVA'
              end
              item
                Format = '#.###,00'
                Kind = skSum
                FieldName = 'CuotaRE'
              end
              item
                Format = '#.###,00'
                Kind = skSum
                FieldName = 'Alto'
                Column = GridViewAlto
              end>
            DataController.Summary.SummaryGroups = <>
            DataController.Summary.OnAfterSummary = GridViewAfterSummary
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
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Preview.Column = GridViewAnotacion
            object GridViewCodigoArticulo: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'CodigoArticulo'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Required = True
              Properties.OnEnter = GridViewCodigoArticuloPropertiesEnter
              Properties.OnExtendedFunction = GridViewCodigoArticuloPropertiesExtendedFunction
              Properties.OnQueryRequest = GridViewCodigoArticuloPropertiesQueryRequest
              Properties.OnEditRequest = GridViewCodigoArticuloPropertiesEditRequest
              Properties.OnValuePosted = GridViewCodigoArticuloPropertiesValuePosted
              Properties.OnValidate = GridViewCodigoArticuloPropertiesValidate
              Width = 95
            end
            object GridViewCodigoClaseA: TcxGridDBColumn
              Tag = 1
              Caption = 'ClsA'
              DataBinding.FieldName = 'CodigoClaseA'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.OnQueryRequest = GridViewCodigoClasePropertiesQueryRequest
              Properties.OnEditRequest = GridViewCodigoClasePropertiesEditRequest
              Properties.OnValuePosted = GridViewCodigoClasePropertiesValuePosted
              Properties.OnValidate = GridViewCodigoClasePropertiesValidate
              Visible = False
              Width = 30
            end
            object GridViewCodigoClaseB: TcxGridDBColumn
              Tag = 2
              Caption = 'ClsB'
              DataBinding.FieldName = 'CodigoClaseB'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.OnQueryRequest = GridViewCodigoClasePropertiesQueryRequest
              Properties.OnEditRequest = GridViewCodigoClasePropertiesEditRequest
              Properties.OnValuePosted = GridViewCodigoClasePropertiesValuePosted
              Properties.OnValidate = GridViewCodigoClasePropertiesValidate
              Visible = False
              Width = 30
            end
            object GridViewCodigoClaseC: TcxGridDBColumn
              Tag = 3
              Caption = 'ClsC'
              DataBinding.FieldName = 'CodigoClaseC'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.OnQueryRequest = GridViewCodigoClasePropertiesQueryRequest
              Properties.OnEditRequest = GridViewCodigoClasePropertiesEditRequest
              Properties.OnValuePosted = GridViewCodigoClasePropertiesValuePosted
              Properties.OnValidate = GridViewCodigoClasePropertiesValidate
              Visible = False
              Width = 30
            end
            object GridViewLoteFabricacion: TcxGridDBColumn
              Caption = 'Lote'
              DataBinding.FieldName = 'LoteFabricacion'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.OnEnter = GridViewLoteFabricacionPropertiesEnter
              Properties.OnExtendedFunction = GridViewLoteFabricacionPropertiesExtendedFunction
              Properties.OnQueryRequest = GridViewLoteFabricacionPropertiesQueryRequest
              Properties.OnValuePosted = GridViewLoteFabricacionPropertiesValuePosted
              Visible = False
            end
            object GridViewNumeroSerie: TcxGridDBColumn
              Caption = 'N'#186' de serie'
              DataBinding.FieldName = 'NumeroSerie'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.OnQueryRequest = GridViewNumeroSeriePropertiesQueryRequest
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
              Caption = 'Fecha ent.'
              DataBinding.FieldName = 'FechaAplicacion'
              PropertiesClassName = 'TcxDateEditProperties'
              Properties.SaveTime = False
              Visible = False
              Width = 90
            end
            object GridViewDescripcion: TcxGridDBColumn
              Caption = 'Descripci'#243'n'
              DataBinding.FieldName = 'Descripcion'
              PropertiesClassName = 'TcxTextEditProperties'
              Width = 300
            end
            object GridViewTipoLinea: TcxGridDBColumn
              Caption = 'T.Ln'
              DataBinding.FieldName = 'TipoLinea'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.OnQueryRequest = GridViewTipoLineaPropertiesQueryRequest
              Properties.OnEditRequest = GridViewTipoLineaPropertiesEditRequest
              Properties.MaxLength = 3
              Properties.OnValidate = GridViewTipoLineaPropertiesValidate
              Visible = False
              HeaderHint = 'Tipo de l'#237'nea'
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
              Width = 30
            end
            object GridViewUbicacion: TcxGridDBColumn
              Caption = 'Ubic.'
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
              Properties.Nullable = False
              Visible = False
              Width = 50
            end
            object GridViewAncho: TcxGridDBColumn
              DataBinding.FieldName = 'Ancho'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.OnValuePosted = GridViewDimensionPropertiesValuePosted
              Properties.Nullable = False
              Visible = False
              Width = 50
            end
            object GridViewAlto: TcxGridDBColumn
              DataBinding.FieldName = 'Alto'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.OnValuePosted = GridViewDimensionPropertiesValuePosted
              Properties.Nullable = False
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
              Properties.OnValuePosted = GridViewBultosPropertiesValuePosted
              Properties.Nullable = False
              Visible = False
              Width = 50
            end
            object GridViewPesoEnvase: TcxGridDBColumn
              Caption = 'Peso env.'
              DataBinding.FieldName = 'PesoEnvase'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.OnValuePosted = GridViewPesoEnvasePropertiesValuePosted
              Properties.Nullable = False
              Visible = False
              HeaderHint = 'Peso unitario del envase'
              Width = 75
            end
            object GridViewTara: TcxGridDBColumn
              DataBinding.FieldName = 'Tara'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Nullable = False
              Properties.ReadOnly = False
              Visible = False
              HeaderHint = 'Tara total'
              Options.Editing = False
              Options.Focusing = False
              Width = 75
            end
            object GridViewPeso: TcxGridDBColumn
              DataBinding.FieldName = 'Peso'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Nullable = False
              Visible = False
              HeaderHint = 'Peso total'
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
              Width = 80
            end
            object GridViewCantidadCargada: TcxGridDBColumn
              Caption = 'Cargado'
              DataBinding.FieldName = 'CantidadCargada'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Nullable = False
              Visible = False
              Options.Editing = False
              Options.Focusing = False
              Width = 80
            end
            object GridViewParametros: TcxGridDBColumn
              Caption = 'Par'#225'metros'
              DataBinding.FieldName = 'Parametros'
              PropertiesClassName = 'TcxCheckComboBoxProperties'
              Properties.Delimiter = ','
              Properties.EmptySelectionText = ' '
              Properties.Alignment.Horz = taLeftJustify
              Properties.DropDownRows = 14
              Properties.Items = <>
              Visible = False
              Width = 145
            end
            object GridViewServido: TcxGridDBColumn
              Caption = 'Servido'
              DataBinding.FieldName = 'CantidadProcesada'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.OnValuePosted = GridViewServidoPropertiesValuePosted
              Properties.Nullable = False
              Visible = False
              Options.Editing = False
              Options.Focusing = False
              Width = 80
            end
            object GridViewPrecioDivisa: TcxGridDBColumn
              Caption = 'Precio divisa'
              DataBinding.FieldName = 'PrecioDivisa'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.OnEditRequest = GridViewPrecioDivisaPropertiesEditRequest
              Properties.OnValuePosted = GridViewPrecioDivisaPropertiesValuePosted
              Properties.Nullable = False
              Properties.OnValidate = GridViewPrecioDivisaPropertiesValidate
              Visible = False
              Width = 80
            end
            object GridViewPrecio: TcxGridDBColumn
              DataBinding.FieldName = 'Precio'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.OnEnter = GridViewPrecioPropertiesEnter
              Properties.OnExtendedFunction = GridViewPrecioPropertiesExtendedFunction
              Properties.OnQueryRequest = GridViewPrecioPropertiesQueryRequest
              Properties.OnValuePosted = GridViewPrecioPropertiesValuePosted
              Properties.Nullable = False
              Width = 80
            end
            object GridViewCodigoTipoIVA: TcxGridDBColumn
              Caption = 'Tipo'
              DataBinding.FieldName = 'CodigoTipoIVA'
              PropertiesClassName = 'TcxSpinEditProperties'
              Properties.OnQueryRequest = GridViewCodigoTipoIVAPropertiesQueryRequest
              Properties.OnEditRequest = GridViewCodigoTipoIVAPropertiesEditRequest
              Properties.OnValuePosted = GridViewCodigoTipoIVAPropertiesValuePosted
              Properties.DisplayFormat = '#'
              Properties.EditFormat = '#'
              Properties.ImmediatePost = True
              Properties.MaxValue = 24.000000000000000000
              Visible = False
              HeaderHint = 'Tipo de I.V.A. de la l'#237'nea'
              Width = 35
            end
            object GridViewPrecioIVA: TcxGridDBColumn
              Caption = 'I.V.A. inc.'
              DataBinding.FieldName = 'PrecioIVA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.OnValuePosted = GridViewPrecioIVAPropertiesValuePosted
              Properties.Nullable = False
              Properties.OnValidate = GridViewPrecioIVAPropertiesValidate
              Visible = False
              Width = 80
            end
            object GridViewPuntoVerde: TcxGridDBColumn
              Caption = 'EcoTasa'
              DataBinding.FieldName = 'PuntoVerde'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.OnValuePosted = GridViewUpdatePropertiesValuePosted
              Properties.Nullable = False
              Properties.OnValidate = GridViewPuntoVerdePropertiesValidate
              Visible = False
            end
            object GridViewRecargo: TcxGridDBColumn
              DataBinding.FieldName = 'Recargo'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.OnQueryRequest = GridViewPrecioPropertiesQueryRequest
              Properties.OnValuePosted = GridViewUpdatePropertiesValuePosted
              Properties.Nullable = False
              Visible = False
            end
            object GridViewImporteRecargo: TcxGridDBColumn
              Caption = 'Imp. recargo'
              DataBinding.FieldName = 'ImporteRecargo'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Visible = False
              Width = 100
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
              Width = 50
            end
            object GridViewImporte: TcxGridDBColumn
              Caption = 'Importe'
              DataBinding.FieldName = 'ImporteNeto'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Nullable = False
              OnGetCellHint = GridViewImporteGetCellHint
              OnGetDisplayText = GridViewImporteGetDisplayText
              Options.Editing = False
              Options.Focusing = False
              Width = 100
            end
            object GridViewImporteTotal: TcxGridDBColumn
              Caption = 'Importe'
              DataBinding.FieldName = 'ImporteTotal'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.AssignedValues.DisplayFormat = True
              Properties.Nullable = False
              Visible = False
              OnGetCellHint = GridViewImporteGetCellHint
              OnGetDisplayText = GridViewImporteTotalGetDisplayText
              Options.Editing = False
              Options.Focusing = False
              Width = 100
            end
            object GridViewDocumentoOrigen: TcxGridDBColumn
              AlternateCaption = 'Documento origen'
              Caption = 'Orig.'
              DataBinding.FieldName = 'TieneRegistroOrigen'
              PropertiesClassName = 'TcxCheckBoxProperties'
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
                20783D223070782220793D22307078222077696474683D223430222068656967
                68743D223230222076696577426F783D223020302034302032302220656E6162
                6C652D6261636B67726F756E643D226E6577203020302032342032342220736F
                6469706F64693A646F636E616D653D22676F746F2D6C6566742D677269642E73
                76672220696E6B73636170653A76657273696F6E3D22302E39322E3220283563
                33653830642C20323031372D30382D303629223E0D0A093C6D65746164617461
                2069643D226D657461646174613138223E0D0A09093C7264663A5244463E0D0A
                0909093C63633A576F726B207264663A61626F75743D22223E0D0A090909093C
                64633A666F726D61743E696D6167652F7376672B786D6C3C2F64633A666F726D
                61743E0D0A090909093C64633A74797065207264663A7265736F757263653D22
                687474703A2F2F7075726C2E6F72672F64632F64636D69747970652F5374696C
                6C496D616765222F3E0D0A090909093C64633A7469746C652F3E0D0A0909093C
                2F63633A576F726B3E0D0A09093C2F7264663A5244463E0D0A093C2F6D657461
                646174613E0D0A093C646566732069643D22646566733136222F3E0D0A093C73
                6F6469706F64693A6E616D6564766965772070616765636F6C6F723D22236666
                666666662220626F72646572636F6C6F723D22233636363636362220626F7264
                65726F7061636974793D223122206F626A656374746F6C6572616E63653D2231
                30222067726964746F6C6572616E63653D22313022206775696465746F6C6572
                616E63653D2231302220696E6B73636170653A706167656F7061636974793D22
                302220696E6B73636170653A70616765736861646F773D22322220696E6B7363
                6170653A77696E646F772D77696474683D22313932302220696E6B7363617065
                3A77696E646F772D6865696768743D2231303137222069643D226E616D656476
                6965773134222073686F77677269643D2266616C73652220696E6B7363617065
                3A7A6F6F6D3D2231312E3836363037312220696E6B73636170653A63783D2233
                342E3639383033382220696E6B73636170653A63793D22392E39373737363437
                2220696E6B73636170653A77696E646F772D783D222D382220696E6B73636170
                653A77696E646F772D793D222D332220696E6B73636170653A77696E646F772D
                6D6178696D697A65643D22312220696E6B73636170653A63757272656E742D6C
                617965723D224C617965725F31222F3E0D0A093C72656374207374796C653D22
                6F7061636974793A313B66696C6C3A236666666666663B66696C6C2D6F706163
                6974793A303B7374726F6B653A6E6F6E653B7374726F6B652D77696474683A30
                2E31303431393036393B7374726F6B652D6D697465726C696D69743A343B7374
                726F6B652D6461736861727261793A6E6F6E653B7374726F6B652D6F70616369
                74793A31222069643D2272656374383238222077696474683D2234302E313134
                33373622206865696768743D2231392E39353535332220783D22302220793D22
                302E303434343730323636222F3E0D0A093C672069643D2267383435223E0D0A
                09093C67207472616E73666F726D3D226D617472697828302E38353437333435
                362C302C302C302E38353437333435362C31392E3734333239312C2D302E3235
                36353930313929222069643D2269636F6E223E0D0A0909093C636972636C6520
                7374796C653D2266696C6C3A23663766386639222063783D223132222063793D
                2231322220723D223130222069643D22636972636C65383438222F3E0D0A0909
                093C70617468207374796C653D2266696C6C3A233835393161312220696E6B73
                636170653A636F6E6E6563746F722D6375727661747572653D22302220643D22
                4D2031392E373738322C342E323231382031382E353736312C352E3432333920
                432032302E323539312C372E313036392032312E332C392E343331392032312E
                332C3132206320302C352E31333632202D342E313633382C392E33202D392E33
                2C392E33202D322E353638312C30202D342E383933312C2D312E30343039202D
                362E353736312C2D322E37323339204C20342E323231382C31392E3737383220
                4320362E323132342C32312E3736383820382E393632342C32332031322C3233
                2031382E303735312C32332032332C31382E303735312032332C31322032332C
                382E393632342032312E373638382C362E323132342031392E373738322C342E
                32323138205A222069643D2270617468383530222F3E0D0A0909093C70617468
                207374796C653D226F7061636974793A302E30353B66696C6C3A233163323032
                352220696E6B73636170653A636F6E6E6563746F722D6375727661747572653D
                22302220643D224D20342E393238392C31392E30373131204320362E37333836
                2C32302E3838303720392E323338362C32322031322C32322031372E35323238
                2C32322032322C31372E353232382032322C31322032322C392E323338362032
                302E383830372C362E373338362031392E303731312C342E39323839205A2220
                69643D2270617468383532222F3E0D0A0909093C70617468207374796C653D22
                66696C6C3A233939613261662220696E6B73636170653A636F6E6E6563746F72
                2D6375727661747572653D22302220643D224D20352E343233392C31382E3537
                3631204320332E373430392C31362E3839333120322E372C31342E3536383120
                322E372C313220322E372C362E3836333820362E383633382C322E372031322C
                322E37206320322E353638312C3020342E383933312C312E3034303920362E35
                3736312C322E37323339204C2031392E373738322C342E323231382043203137
                2E373837362C322E323331322031352E303337362C312031322C3120352E3932
                34392C3120312C352E3932343920312C3132206320302C332E3033373620312E
                323331322C352E3738373620332E323231382C372E37373832207A222069643D
                2270617468383534222F3E0D0A0909093C70617468207374796C653D2266696C
                6C3A233835393161312220696E6B73636170653A636F6E6E6563746F722D6375
                727661747572653D22302220643D224D20362E313136372C31312E3634343520
                31312E3931352C352E38343632206320302E313535362C2D302E313535362030
                2E343130312C2D302E3135353620302E353635372C30206C20302E383438352C
                302E38343835206320302E313535362C302E3135353620302E313535362C302E
                3434353420302C302E36303039204C20392E363630312C3131206820382E3031
                3935206320302E32322C3020302E343230342C302E3130393520302E34323034
                2C302E33323935207620312E3220432031382E312C31322E373439352031372E
                383939362C31332031372E363739362C3133204820392E36363435206C20332E
                363634372C332E36323934206320302E313535362C302E3135353620302E3135
                35362C302E3339323520302C302E35343831206C202D302E383438352C302E38
                3339372063202D302E313535362C302E31353536202D302E343130312C302E31
                353132202D302E353635372C2D302E30303434204C20362E393635332C31332E
                3036303920362E313136382C31322E32313133204320352E393631312C31322E
                3035353720352E393631312C31312E3820362E313136372C31312E3634343520
                5A222069643D2270617468383536222F3E0D0A09093C2F673E0D0A09093C7265
                6374207374796C653D226F7061636974793A313B66696C6C3A23666666666666
                3B66696C6C2D6F7061636974793A303B7374726F6B653A6E6F6E653B7374726F
                6B652D77696474683A302E30373234373737313B7374726F6B652D6D69746572
                6C696D69743A343B7374726F6B652D6461736861727261793A6E6F6E653B7374
                726F6B652D6F7061636974793A31222069643D22726563743833322220776964
                74683D2232312E36323030393422206865696768743D22362E36363536303834
                2220783D22313139312E323738312220793D22313138342E3931373122207472
                616E73666F726D3D226D617472697828302E37313130343434342C2D302E3730
                3331343730372C2D302E36393431383331312C302E37313937393834352C302C
                3029222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
              Properties.GlyphCount = 2
              Properties.ReadOnly = True
              HeaderHint = 
                'Si se muestra un bot'#243'n, '#233'ste da acceso a la l'#237'nea del documento ' +
                'que origin'#243' este registro'
              MinWidth = 34
              Options.Editing = False
              Options.Focusing = False
              Width = 51
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
              Properties.ReadOnly = True
              Visible = False
              HeaderHint = 'Si se muestra indica que la l'#237'nea tiene documentos asociados'
              Options.Editing = False
              Options.Focusing = False
              Width = 34
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
              Options.Editing = False
            end
            object GridViewNroPagina: TcxGridDBColumn
              DataBinding.FieldName = 'NroPagina'
              Visible = False
            end
            object GridViewCuotaIVA: TcxGridDBColumn
              DataBinding.FieldName = 'CuotaIVA'
              Visible = False
            end
            object GridViewCuotaRE: TcxGridDBColumn
              DataBinding.FieldName = 'CuotaRE'
              Visible = False
            end
            object GridViewProcesada: TcxGridDBColumn
              DataBinding.FieldName = 'Procesada'
              Visible = False
            end
            object GridViewCampoLibre1: TcxGridDBColumn
              DataBinding.FieldName = 'CampoLIbre1'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.OnValidate = GridViewCampoLibre1PropertiesValidate
              Visible = False
              Width = 150
            end
            object GridViewCampoLibre2: TcxGridDBColumn
              DataBinding.FieldName = 'CampoLibre2'
              PropertiesClassName = 'TcxTextEditProperties'
              Visible = False
              Width = 150
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
              Width = 120
            end
            object GridViewCampoLibre5: TcxGridDBColumn
              DataBinding.FieldName = 'CampoLibre5'
              PropertiesClassName = 'TcxTextEditProperties'
              Visible = False
              Width = 120
            end
            object GridViewEjercicio: TcxGridDBColumn
              DataBinding.FieldName = 'Ejercicio'
              Visible = False
            end
            object GridViewNroOperacion: TcxGridDBColumn
              DataBinding.FieldName = 'NroOperacion'
              Visible = False
            end
            object GridViewNroLinea: TcxGridDBColumn
              DataBinding.FieldName = 'NroLinea'
              Visible = False
            end
            object GridViewFecha: TcxGridDBColumn
              DataBinding.FieldName = 'Fecha'
              Visible = False
            end
            object GridViewAsignacionOrigen: TcxGridDBColumn
              DataBinding.FieldName = 'AsignacionOrigen'
              Visible = False
            end
            object GridViewTipoMovimientoOrigen: TcxGridDBColumn
              DataBinding.FieldName = 'TipoMovimientoOrigen'
              Visible = False
            end
            object GridViewUIDArticulo: TcxGridDBColumn
              DataBinding.FieldName = 'UIDArticulo'
              Visible = False
            end
            object GridViewCantidad: TcxGridDBColumn
              DataBinding.FieldName = 'Cantidad'
              Visible = False
            end
            object GridViewPorcentajeRecargo: TcxGridDBColumn
              DataBinding.FieldName = 'PorcentajeRecargo'
              Visible = False
            end
            object GridViewContribucionRAP: TcxGridDBColumn
              DataBinding.FieldName = 'ContribucionRAP'
              Visible = False
            end
            object GridViewOferta: TcxGridDBColumn
              DataBinding.FieldName = 'Oferta'
              Visible = False
            end
            object GridViewImporteBruto: TcxGridDBColumn
              DataBinding.FieldName = 'ImporteBruto'
              Visible = False
            end
            object GridViewImporteDescuento: TcxGridDBColumn
              DataBinding.FieldName = 'ImporteDescuento'
              Visible = False
            end
            object GridViewNoCalcularMargen: TcxGridDBColumn
              DataBinding.FieldName = 'NoCalcularMargen'
              Visible = False
            end
          end
          object GridLevel: TcxGridLevel
            GridView = GridView
          end
        end
        object Panel2: TcxGroupBox
          Left = 1078
          Top = 0
          Align = alRight
          PanelStyle.Active = True
          ParentBackground = False
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 3
          Height = 311
          Width = 38
          object TableViewManager: TGridTableViewController
            Left = 0
            Top = 0
            Align = alClient
            Enabled = False
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TransparentBorder = False
            TabOrder = 0
            TableView = GridView
            ShiftRecords = True
            UseGridFilterBox = False
            BeforeValidateTableView = TableViewManagerBeforeValidateTableView
            OnRowShift = TableViewManagerRowShift
            OnCanDeleteRow = TableViewManagerCanDeleteRow
            OnCanInsertRow = TableViewManagerCanInsertRow
            OnCanShiftRow = TableViewManagerCanShiftRow
            OnCanShowDocument = TableViewManagerCanShowDocument
            Height = 273
            Width = 38
          end
          object OpcionesLineaButton: TgBitBtn
            Left = 0
            Top = 273
            Width = 38
            Height = 38
            Align = alBottom
            Caption = '&Manufactura'
            Enabled = True
            OptionsImage.Glyph.SourceHeight = 28
            OptionsImage.Glyph.SourceWidth = 28
            OptionsImage.Images = ApplicationContainer.ButtonImageList
            PaintStyle = bpsGlyph
            ParentShowHint = False
            ShowHint = True
            SpeedButtonOptions.CanBeFocused = False
            SpeedButtonOptions.Flat = True
            SpeedButtonOptions.Transparent = True
            TabOrder = 1
            Visible = False
          end
        end
      end
    end
    object DataPanelSplitter: TcxSplitter
      Left = 2
      Top = 116
      Width = 1116
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
    Dataset = MovimientoTable
    FirstKeyControl = NroDocumentoCtrl
    FirstDataControl = ClienteCtrl
    Model = fmEditForm
    RelatedDocsMenu = RelacionesPopupMenu
    ShowQueryOption = False
    OnAutoEditChanged = FormManagerAutoEditChanged
    OnInitializeForm = FormManagerInitializeForm
    OnCreateForm = FormManagerCreateForm
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
    OnQueryGridRequest = FormManagerQueryGridRequest
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    OnSetupToolBar = FormManagerSetupToolBar
    OnUpdateButtonsState = FormManagerUpdateButtonsState
    OnShowCantEditMessage = FormManagerShowCantEditMessage
    Left = 695
    Top = 233
  end
  object MovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterEdit = MovimientoTableAfterEdit
    BeforePost = MovimientoTableBeforePost
    BeforeDelete = MovimientoTableBeforeDelete
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
    Left = 662
    Top = 233
  end
  object MovimientoDataSource: TDataSource
    DataSet = MovimientoTable
    Left = 624
    Top = 233
  end
  object LineaMovimientoDataSource: TDataSource
    DataSet = LineaMovimientoTable
    Enabled = False
    Left = 469
    Top = 233
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 695
    Top = 265
    object DataServido: TBooleanField
      FieldName = 'Servido'
    end
    object DataEnviado: TBooleanField
      FieldName = 'Enviado'
    end
  end
  object MemDataSource: TDataSource
    DataSet = Data
    Left = 625
    Top = 265
  end
  object LineaMovimientoAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'TipoMovimientoOrigen;EjercicioOrigen;NroOperacionOrigen'
    AutoIncFieldName = 'NroLinea'
    Left = 894
    Top = 232
  end
  object GrupoLineaMovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterClose = GrupoLineaMovimientoTableAfterClose
    AfterPost = GrupoLineaMovimientoTableAfterPost
    BeforeDelete = GrupoLineaMovimientoTableBeforeDelete
    OnNewRecord = GrupoLineaMovimientoTableNewRecord
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    MasterFields = 'Ejercicio;NroOperacion'
    MasterSource = MovimientoDataSource
    AutoIncFieldName = 'NroPagina'
    MasterRelation = mrTied
    Left = 577
    Top = 233
    object GrupoLineaMovimientoTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object GrupoLineaMovimientoTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object GrupoLineaMovimientoTableNroPagina: TSmallintField
      FieldName = 'NroPagina'
      Required = True
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
    Left = 542
    Top = 233
  end
  object LineaMovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterOpen = LineaMovimientoTableAfterOpen
    AfterClose = LineaMovimientoTableAfterClose
    BeforeInsert = LineaMovimientoTableBeforeInsert
    BeforeEdit = LineaMovimientoTableBeforeEdit
    AfterEdit = LineaMovimientoTableAfterEdit
    BeforePost = LineaMovimientoTableBeforePost
    AfterPost = LineaMovimientoTableAfterPost
    BeforeDelete = LineaMovimientoTableBeforeDelete
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
    Left = 505
    Top = 233
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
    object LineaMovimientoTableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
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
    object LineaMovimientoTableLoteFabricacion: TWideStringField
      FieldName = 'LoteFabricacion'
    end
    object LineaMovimientoTableNumeroSerie: TWideStringField
      FieldName = 'NumeroSerie'
      Size = 40
    end
    object LineaMovimientoTableFechaCaducidad: TDateField
      FieldName = 'FechaCaducidad'
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
    object LineaMovimientoTableCantidadAjustada: TBCDField
      FieldName = 'CantidadAjustada'
    end
    object LineaMovimientoTableCantidadCargada: TBCDField
      FieldKind = fkCalculated
      FieldName = 'CantidadCargada'
      Calculated = True
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
    end
    object LineaMovimientoTablePeso: TBCDField
      FieldName = 'Peso'
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
    object LineaMovimientoTableImporteRecargo: TBCDField
      FieldName = 'ImporteRecargo'
      Precision = 16
    end
    object LineaMovimientoTablePorcentajeRecargo: TBCDField
      FieldName = 'PorcentajeRecargo'
      Precision = 16
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
    object LineaMovimientoTableOferta: TBooleanField
      FieldName = 'Oferta'
    end
    object LineaMovimientoTableImporteBruto: TBCDField
      FieldName = 'ImporteBruto'
    end
    object LineaMovimientoTableImporteDescuento: TBCDField
      FieldName = 'ImporteDescuento'
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
    object LineaMovimientoTableTieneDocumentosAsociados: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'TieneDocumentosAsociados'
      Calculated = True
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
  object BarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'RelacionesPopupMenu'
      'PopupMenu')
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
    Left = 785
    Top = 232
    PixelsPerInch = 96
    object ConsultaArticulosItem: TdxBarButton
      Caption = 'Articulos'
      Category = 0
      Hint = 'Articulos'
      Visible = ivAlways
      ShortCut = 115
      OnClick = ConsultaArticulosItemClick
    end
    object ConsultaArticulosRelacionadosItem: TdxBarButton
      Caption = 'Art'#237'culos relacionados'
      Category = 0
      Hint = 'Art'#237'culos relacionados'
      Visible = ivAlways
      ShortCut = 117
      OnClick = ConsultaArticulosRelacionadosItemClick
    end
    object ConsultaArticulosEquivalentesItem: TdxBarButton
      Caption = 'Art'#237'culos alternativos o equivalentes'
      Category = 0
      Hint = 'Art'#237'culos alternativos o equivalentes'
      Visible = ivAlways
      ShortCut = 118
      OnClick = ConsultaArticulosEquivalentesItemClick
    end
    object NoPedirAlProveedorItem: TdxBarButton
      Caption = 'No pedir al proveedor'
      Category = 0
      Hint = 'No pedir al proveedor'
      Visible = ivNever
      ButtonStyle = bsChecked
      OnClick = NoPedirAlProveedorItemClick
    end
    object DirectorioDocumentosItem: TdxBarButton
      Caption = 'Directorio de documentos'
      Category = 0
      Hint = 'Directorio de documentos'
      Visible = ivAlways
      OnClick = DirectorioDocumentosItemClick
    end
    object DocumentosOrigenItem: TdxBarButton
      Caption = 'Relacion de documentos cuyo origen es '#233'sta linea'
      Category = 0
      Hint = 'Relacion de documentos cuyo origen es '#233'sta linea'
      Visible = ivAlways
      OnClick = DocumentosOrigenItemClick
    end
    object LineasDocumentoItem: TdxBarButton
      Caption = '&Documentos cuyo origen es este'
      Category = 1
      Hint = 'Documentos cuyo origen es este'
      Visible = ivAlways
      OnClick = LineasDocumentoItemClick
    end
    object FacturaVentaItem: TdxBarButton
      Caption = '&Factura de venta'
      Category = 1
      Visible = ivAlways
      OnClick = FacturaVentaItemClick
    end
    object DocumentoOrigenItem: TdxBarButton
      Caption = 'Documento origen'
      Category = 1
      Visible = ivAlways
      OnClick = DocumentoOrigenItemClick
    end
    object EditarDocItem: TdxBarButton
      Caption = 'Editar'
      Category = 2
      Visible = ivAlways
      OnClick = EditarDocItemClick
    end
    object FichaArticuloItem: TdxBarButton
      Caption = 'Ficha del art'#237'culo'
      Category = 2
      Visible = ivAlways
      OnClick = FichaArticuloItemClick
    end
    object FichaMovimientosArticuloItem: TdxBarButton
      Caption = 'Relaci'#243'n de movimientos del art'#237'culo'
      Category = 2
      Visible = ivAlways
      OnClick = FichaMovimientosArticuloItemClick
    end
    object TrazaItem: TdxBarButton
      Caption = 'Traza del art'#237'culo'
      Category = 2
      Visible = ivAlways
      OnClick = TrazaItemClick
    end
    object VincularPedidoItem: TdxBarButton
      Caption = 'Vincular el albar'#225'n a un pedido existente'
      Category = 2
      Visible = ivAlways
      ImageIndex = 16
      OnClick = VincularPedidoItemClick
    end
    object SuprimirVinculosItem: TdxBarButton
      Caption = 'Suprimir todos los v'#237'nculos con pedidos'
      Category = 2
      Visible = ivAlways
      ImageIndex = 17
      OnClick = SuprimirVinculosItemClick
    end
    object DarPorServidaItem: TdxBarButton
      Caption = 'Dar por servida la l'#237'nea'
      Category = 2
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = DarPorServidaItemClick
    end
    object ActualizarRelacionesItem: TdxBarButton
      Caption = 'Actualizar relaciones del documento'
      Category = 2
      Visible = ivAlways
      OnClick = ActualizarRelacionesItemClick
    end
    object CopiarAnotacionItem: TdxBarButton
      Caption = 'Copiar la anotaci'#243'n del art'#237'culo'
      Category = 2
      Visible = ivAlways
      OnClick = CopiarAnotacionItemClick
    end
    object MostrarAnotacionesItem: TdxBarButton
      Caption = 'Mostrar anotaciones'
      Category = 2
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = MostrarAnotacionesItemClick
    end
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
        ItemName = 'FacturaVentaItem'
      end
      item
        Visible = True
        ItemName = 'DocumentoOrigenItem'
      end>
    UseOwnFont = True
    OnPopup = RelacionesPopupMenuPopup
    Left = 817
    Top = 232
    PixelsPerInch = 96
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
        ItemName = 'FichaArticuloItem'
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
        ItemName = 'DocumentosOrigenItem'
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
        ItemName = 'DarPorServidaItem'
      end
      item
        Visible = True
        ItemName = 'NoPedirAlProveedorItem'
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
    OnPopup = PopupMenuPopup
    Left = 849
    Top = 232
    PixelsPerInch = 96
  end
  object ConsultaArticulosPopupMenu: TdxBarPopupMenu
    BarManager = BarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemLinks = <
      item
        Visible = True
      end
      item
        Visible = True
      end
      item
        Visible = True
        ItemName = 'ConsultaArticulosItem'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'ConsultaArticulosRelacionadosItem'
      end
      item
        Visible = True
        ItemName = 'ConsultaArticulosEquivalentesItem'
      end>
    UseOwnFont = True
    Left = 820
    Top = 266
    PixelsPerInch = 96
  end
end
