object BoxRmvForm: TBoxRmvForm
  Left = 309
  Top = 279
  HelpType = htKeyword
  HelpKeyword = 'b_rmv'
  BorderStyle = bsDialog
  ClientHeight = 488
  ClientWidth = 894
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
    PanelKind = epKeyPanel
    DesignSize = (
      894
      36)
    Height = 36
    Width = 894
    object Panel1: TcxGroupBox
      Left = 132
      Top = 4
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 0
      Height = 28
      Width = 133
      object Panel2: TcxGroupBox
        Left = 132
        Top = 0
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 28
        Width = 1
      end
      object SeparadorSerieLabel: TcxLabel
        Left = 55
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
        AnchorX = 60
        AnchorY = 14
      end
      object LockRangeButton: TgxLockRangeButton
        AlignWithMargins = True
        Left = 31
        Top = 0
        Width = 24
        Height = 28
        Hint = 
          'Bloqueo del campo (Navegar fijando este campo).'#13'Teclas <Ctrl>+<B' +
          '>'
        Margins.Left = 4
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
        OptionsImage.Spacing = 2
        ParentShowHint = False
        ShowHint = True
        SpeedButtonOptions.GroupIndex = 1
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.AllowAllUp = True
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 2
        EditControl = SerieCtrl
        OnLockRange = LockRangeButtonLockRange
      end
      object SerieCtrl: TcxDBTextEdit
        Left = 0
        Top = 0
        Align = alLeft
        AutoSize = False
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = MovimientoDataSource
        Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
        Properties.OnEditRequest = SerieCtrlPropertiesEditRequest
        Properties.MaxLength = 8
        Properties.OnValidate = SerieCtrlPropertiesValidate
        TabOrder = 3
        Height = 28
        Width = 27
      end
      object NroDocumentoCtrl: TcxDBTextEdit
        Left = 65
        Top = 0
        Align = alLeft
        DataBinding.DataField = 'NroDocumento'
        DataBinding.DataSource = MovimientoDataSource
        Properties.Required = True
        Properties.OnQueryRequest = NroDocumentoCtrlPropertiesQueryRequest
        Properties.MaxLength = 8
        TabOrder = 4
        Width = 67
      end
    end
    object TituloDocumentoLabel: TcxLabel
      Left = 608
      Top = 3
      TabStop = False
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'VENTA'
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clSilver
      Style.Font.Height = -21
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taRightJustify
      TabOrder = 1
      Transparent = True
      Height = 25
      Width = 257
      AnchorX = 865
    end
    object NroDocumentoCaptionLabel: TcxLabel
      Left = 13
      Top = 9
      TabStop = False
      Caption = 'N'#186'  de documento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
    object EstadoLabel: TcxLabel
      Left = 277
      Top = 9
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
      Height = 19
      Width = 338
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 454
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      894
      34)
    Height = 34
    Width = 894
    object Panel3: TcxGroupBox
      Left = 361
      Top = 2
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 176
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
    Height = 418
    Width = 884
    object bottomPanel: TcxGroupBox
      Left = 2
      Top = 354
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 3
      Height = 62
      Width = 880
      object TotalesPanel: TcxGroupBox
        Left = 486
        Top = 2
        Align = alRight
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        TabOrder = 2
        Transparent = True
        Height = 58
        Width = 392
        object FooterPanelCoste: TcxLabel
          Left = 200
          Top = 4
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TextColor = clNavy
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 0
          Transparent = True
          Height = 25
          Width = 88
          AnchorX = 288
          AnchorY = 17
        end
        object FooterPanelImporteNeto: TcxLabel
          Left = 292
          Top = 4
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TextColor = clNavy
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
          AnchorX = 369
          AnchorY = 17
        end
        object FooterPanelMargen: TcxLabel
          Left = 200
          Top = 30
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TextColor = clNavy
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 2
          Transparent = True
          Height = 25
          Width = 88
          AnchorX = 288
          AnchorY = 43
        end
        object FooterPanelMargenPorcentual: TcxLabel
          Left = 292
          Top = 30
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          Style.TextColor = clNavy
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 3
          Transparent = True
          Height = 25
          Width = 77
          AnchorX = 369
          AnchorY = 43
        end
        object GridTableViewPanelLabel1: TcxLabel
          Left = 375
          Top = 32
          TabStop = False
          Caption = '%'
          Style.BorderStyle = ebsNone
          Style.LookAndFeel.NativeStyle = True
          StyleDisabled.LookAndFeel.NativeStyle = True
          StyleFocused.LookAndFeel.NativeStyle = True
          StyleHot.LookAndFeel.NativeStyle = True
          TabOrder = 4
          Transparent = True
        end
        object Label7: TcxLabel
          Left = 37
          Top = 6
          TabStop = False
          Caption = 'Coste / Importe neto'
          Style.BorderStyle = ebsNone
          Style.LookAndFeel.NativeStyle = True
          StyleDisabled.LookAndFeel.NativeStyle = True
          StyleFocused.LookAndFeel.NativeStyle = True
          StyleHot.LookAndFeel.NativeStyle = True
          TabOrder = 5
          Transparent = True
        end
        object Label8: TcxLabel
          Left = 37
          Top = 32
          TabStop = False
          Caption = 'Margen total / porcentual'
          Style.BorderStyle = ebsNone
          Style.LookAndFeel.NativeStyle = True
          StyleDisabled.LookAndFeel.NativeStyle = True
          StyleFocused.LookAndFeel.NativeStyle = True
          StyleHot.LookAndFeel.NativeStyle = True
          TabOrder = 6
          Transparent = True
        end
      end
      object Bottom2ScrollBox: TcxScrollBox
        Left = 161
        Top = 5
        Width = 208
        Height = 58
        BorderStyle = cxcbsNone
        TabOrder = 0
        Transparent = True
        VertScrollBar.Visible = False
        object EntregaACuentaPanel: TgxScrollBoxPanel
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 27
          Width = 208
          object EntregaACuentaCtrl: TcxDBCurrencyEdit
            Left = 128
            Top = 1
            DataBinding.DataField = 'EntregaACuenta'
            DataBinding.DataSource = MovimientoDataSource
            Enabled = False
            Properties.MaxLength = 8
            Properties.ReadOnly = True
            TabOrder = 0
            Width = 71
          end
          object Label18: TcxLabel
            Left = 9
            Top = 5
            TabStop = False
            Caption = 'A cuenta / Efectivo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object PortesPanel: TgxScrollBoxPanel
          Left = 0
          Top = 27
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Height = 27
          Width = 208
          object PortesCtrl: TcxDBCurrencyEdit
            Left = 128
            Top = 1
            DataBinding.DataField = 'Portes'
            DataBinding.DataSource = MovimientoDataSource
            Enabled = False
            Properties.MaxLength = 8
            Properties.ReadOnly = True
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
      object Bottom1ScrollBox: TcxScrollBox
        Left = 0
        Top = 5
        Width = 152
        Height = 81
        BorderStyle = cxcbsNone
        TabOrder = 1
        Transparent = True
        VertScrollBar.Visible = False
        object ServidoPanel: TgxScrollBoxPanel
          Left = 0
          Top = 54
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 27
          Width = 152
          object ServidoCtrl: TcxDBCheckBox
            Left = 6
            Top = 1
            AutoSize = False
            Caption = 'Servido'
            DataBinding.DataField = 'Servido'
            DataBinding.DataSource = MemDataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            Properties.ReadOnly = True
            TabOrder = 0
            Transparent = True
            Height = 25
            Width = 123
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
          Width = 152
          object NoFacturarCtrl: TcxDBCheckBox
            Left = 6
            Top = 1
            AutoSize = False
            Caption = 'No facturar'
            DataBinding.DataField = 'NoFacturar'
            DataBinding.DataSource = MovimientoDataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            Properties.ReadOnly = True
            TabOrder = 0
            Transparent = True
            Height = 25
            Width = 123
          end
        end
        object RevisadoPanel: TgxScrollBoxPanel
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 2
          Height = 27
          Width = 152
          object RevisadoCtrl: TcxDBCheckBox
            Left = 6
            Top = 1
            AutoSize = False
            Caption = 'Revisado'
            DataBinding.DataField = 'Revisado'
            DataBinding.DataSource = MovimientoDataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            Properties.ReadOnly = True
            TabOrder = 0
            Transparent = True
            Height = 25
            Width = 123
          end
        end
      end
    end
    object TopPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        880
        60)
      Height = 60
      Width = 880
      object FechaCtrl: TcxDBDateEdit
        Left = 125
        Top = 28
        DataBinding.DataField = 'Fecha'
        DataBinding.DataSource = MovimientoDataSource
        Properties.Required = True
        Properties.ReadOnly = True
        TabOrder = 1
        Width = 100
      end
      object ClienteCtrl: TcxDBTextEdit
        Left = 125
        Top = 1
        DescriptionLabel = Label9
        DataBinding.DataField = 'Propietario'
        DataBinding.DataSource = MovimientoDataSource
        Properties.Required = True
        Properties.TextEditPad = tpLeftZero
        Properties.PadAlways = True
        Properties.ReadOnly = True
        Properties.OnValidate = ClienteCtrlPropertiesValidate
        TabOrder = 0
        Width = 46
      end
      object Label3: TcxLabel
        Left = 6
        Top = 33
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
      object Label10: TcxLabel
        Left = 6
        Top = 5
        TabStop = False
        Caption = 'C'#243'digo cliente'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object Label9: TcxLabel
        Left = 223
        Top = 4
        TabStop = False
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
        Height = 19
        Width = 492
      end
      object ExpandirButton: TcxButton
        Left = 833
        Top = 27
        Width = 20
        Height = 20
        Hint = 'Expandir todos los grupos'
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Anchors = [akTop, akRight]
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          0000000000007412000074120000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000001212
          12232020203F2020203F2020203F2020203F2020203F2020203F2020203F2020
          203F2020203F2020203F121212230000000000000000000000001616162B7E7E
          7EF9808080FF808080FF808080FF808080FF808080FF808080FF808080FF8080
          80FF808080FF808080FF7D7D7DF70A0A0A1300000000000000002020203F8080
          80FFAAAAAAFFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0
          B0FFB0B0B0FFA4A4A4FF808080FF1010101F00000000000000002020203F8080
          80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
          C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
          80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFFFFFFFFFFFFFFFFFC0C0C0FFC0C0
          C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
          80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFFFFFFFFFFFFFFFFFC0C0C0FFC0C0
          C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
          80FFB8B8B8FFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
          80FFB8B8B8FFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
          80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFFFFFFFFFFFFFFFFFC0C0C0FFC0C0
          C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
          80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFFFFFFFFFFFFFFFFFC0C0C0FFC0C0
          C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
          80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
          C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
          80FFAAAAAAFFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0
          B0FFB0B0B0FFA4A4A4FF808080FF1010101F0000000000000000121212237C7C
          7CF6808080FF808080FF808080FF808080FF808080FF808080FF808080FF8080
          80FF808080FF808080FF797979F00808080F0000000000000000000000001212
          12232020203F2020203F2020203F2020203F2020203F2020203F2020203F2020
          203F2020203F2020203F12121223000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000}
        OptionsImage.Spacing = -1
        ParentShowHint = False
        ShowHint = True
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 5
        TabStop = False
        OnClick = ExpandirButtonClick
      end
      object ColapsarButton: TcxButton
        Left = 853
        Top = 27
        Width = 20
        Height = 20
        Hint = 'Colapsar todos los grupos'
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Anchors = [akTop, akRight]
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          0000000000007412000074120000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000001212
          12232020203F2020203F2020203F2020203F2020203F2020203F2020203F2020
          203F2020203F2020203F121212230000000000000000000000001616162B7E7E
          7EF9808080FF808080FF808080FF808080FF808080FF808080FF808080FF8080
          80FF808080FF808080FF7D7D7DF70A0A0A1300000000000000002020203F8080
          80FFAAAAAAFFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0
          B0FFB0B0B0FFA4A4A4FF808080FF1010101F00000000000000002020203F8080
          80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
          C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
          80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
          C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
          80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
          C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
          80FFB8B8B8FFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
          80FFB8B8B8FFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
          80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
          C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
          80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
          C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
          80FFB8B8B8FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
          C0FFC0C0C0FFB0B0B0FF808080FF1010101F00000000000000002020203F8080
          80FFAAAAAAFFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0
          B0FFB0B0B0FFA4A4A4FF808080FF1010101F0000000000000000121212237C7C
          7CF6808080FF808080FF808080FF808080FF808080FF808080FF808080FF8080
          80FF808080FF808080FF797979F00808080F0000000000000000000000001212
          12232020203F2020203F2020203F2020203F2020203F2020203F2020203F2020
          203F2020203F2020203F12121223000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000}
        OptionsImage.Spacing = -1
        ParentShowHint = False
        ShowHint = True
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 6
        TabStop = False
        OnClick = ColapsarButtonClick
      end
    end
    object Grid: TcxGrid
      Left = 2
      Top = 62
      Width = 842
      Height = 292
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 1
      object GridView: TcxGridDBTableView
        PopupMenu = PopupMenu
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = GridViewCustomDrawCell
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = LineaMovimientoDataSource
        DataController.KeyFieldNames = 'NroRegistro'
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Kind = skSum
            Position = spFooter
            FieldName = 'ImporteNetoCalculo'
            Column = GridViewImporte
          end
          item
            Kind = skSum
            Position = spFooter
            FieldName = 'CosteCalculo'
            Column = GridViewCoste
          end
          item
            Kind = skSum
            Position = spFooter
            Column = GridViewMargen
          end
          item
            Kind = skSum
            Position = spFooter
            Column = GridViewMargenPorcentual
          end>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            FieldName = 'ImporteNetoCalculo'
            Column = GridViewImporteNetoCalculo
          end
          item
            Kind = skSum
            FieldName = 'CosteCalculo'
            Column = GridViewCosteCalculo
          end>
        DataController.Summary.SummaryGroups = <>
        DataController.Summary.OnAfterSummary = GridViewDataControllerSummaryAfterSummary
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
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.ExpandButtonsForEmptyDetails = False
        OptionsView.FooterAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.GroupFooterMultiSummaries = True
        OptionsView.GroupFooters = gfVisibleWhenExpanded
        OptionsView.Indicator = True
        object GridViewNoCalcularMargen: TcxGridDBColumn
          Caption = 'NC'
          DataBinding.FieldName = 'NoCalcularMargen'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          OnGetCellHint = GridViewNoCalcularMargenGetCellHint
          Width = 24
        end
        object GridViewCabeceraPagina: TcxGridDBColumn
          DataBinding.FieldName = 'CabeceraPagina'
          Visible = False
        end
        object GridViewNroPagina: TcxGridDBColumn
          Caption = 'N'#186' p'#225'gina'
          DataBinding.FieldName = 'NroPagina'
          Visible = False
          OnGetDisplayText = GridViewNroPaginaGetDisplayText
        end
        object GridViewCodigoArticulo: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CodigoArticulo'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Required = True
          Options.Editing = False
          Width = 57
        end
        object GridViewCodigoClaseA: TcxGridDBColumn
          Tag = 1
          Caption = 'ClsA'
          DataBinding.FieldName = 'CodigoClaseA'
          PropertiesClassName = 'TcxTextEditProperties'
          Options.Editing = False
          Width = 21
        end
        object GridViewCodigoClaseB: TcxGridDBColumn
          Tag = 2
          Caption = 'ClsB'
          DataBinding.FieldName = 'CodigoClaseB'
          PropertiesClassName = 'TcxTextEditProperties'
          Options.Editing = False
          Width = 21
        end
        object GridViewCodigoClaseC: TcxGridDBColumn
          Tag = 3
          Caption = 'ClsC'
          DataBinding.FieldName = 'CodigoClaseC'
          PropertiesClassName = 'TcxTextEditProperties'
          Options.Editing = False
          Width = 21
        end
        object GridViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Options.Editing = False
          Width = 211
        end
        object GridViewCodigoAlmacen: TcxGridDBColumn
          Caption = 'Alm.'
          DataBinding.FieldName = 'CodigoAlmacen'
          PropertiesClassName = 'TcxTextEditProperties'
          Visible = False
          Options.Editing = False
          Width = 30
        end
        object GridViewUbicacion: TcxGridDBColumn
          Caption = 'Ubicac.'
          DataBinding.FieldName = 'Ubicacion'
          PropertiesClassName = 'TcxTextEditProperties'
          Visible = False
          Options.Editing = False
        end
        object GridViewLargo: TcxGridDBColumn
          DataBinding.FieldName = 'Largo'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Visible = False
          Options.Editing = False
          Width = 50
        end
        object GridViewAncho: TcxGridDBColumn
          DataBinding.FieldName = 'Ancho'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Visible = False
          Options.Editing = False
          Width = 50
        end
        object GridViewAlto: TcxGridDBColumn
          DataBinding.FieldName = 'Alto'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Visible = False
          Options.Editing = False
          Width = 50
        end
        object GridViewNroCajas: TcxGridDBColumn
          Caption = 'Cajas'
          DataBinding.FieldName = 'NroCajas'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Visible = False
          Options.Editing = False
          Width = 50
        end
        object GridViewCantidad: TcxGridDBColumn
          Caption = 'Cantidad'
          DataBinding.FieldName = 'CantidadAjustada'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
          Width = 44
        end
        object GridViewServido: TcxGridDBColumn
          Caption = 'Servido'
          DataBinding.FieldName = 'CantidadProcesada'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
          Options.Focusing = False
          Width = 46
        end
        object GridViewPrecio: TcxGridDBColumn
          DataBinding.FieldName = 'Precio'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
          Width = 57
        end
        object GridViewPuntoVerde: TcxGridDBColumn
          DataBinding.FieldName = 'PuntoVerde'
          Visible = False
          Options.Editing = False
        end
        object GridViewRecargo: TcxGridDBColumn
          DataBinding.FieldName = 'Recargo'
          Options.Editing = False
          Width = 45
        end
        object GridViewDescuento: TcxGridDBColumn
          Caption = '% Dto.'
          DataBinding.FieldName = 'Descuento'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Options.Editing = False
          Width = 39
        end
        object GridViewImporte: TcxGridDBColumn
          Caption = 'Importe'
          DataBinding.FieldName = 'ImporteNeto'
          Options.Editing = False
          Options.Focusing = False
          Width = 71
        end
        object GridViewCoste: TcxGridDBColumn
          DataBinding.FieldName = 'Coste'
          Options.Editing = False
          Width = 55
        end
        object GridViewEsCosteReal: TcxGridDBColumn
          Caption = 'Real'
          DataBinding.FieldName = 'EsCosteReal'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.Glyph.SourceDPI = 96
          Properties.Glyph.Data = {
            424D820200000000000036000000280000001500000007000000010020000000
            00000000000074120000741200000000000000000000FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF000000FF000000FF000000FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFC0C0C0FFC0C0C0FFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF0000
            00FF000000FF000000FF000000FFFFFFFFFFFFFFFFFFC0C0C0FFC0C0C0FFC0C0
            C0FFC0C0C0FFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF000000FFFFFFFFFF000000FF0000
            00FF000000FFFFFFFFFFC0C0C0FFC0C0C0FFFFFFFFFFC0C0C0FFC0C0C0FFC0C0
            C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000000FF000000FF000000FFC0C0
            C0FFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0FFC0C0C0FFC0C0C0FFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF000000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFC0C0C0FFC0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0
            C0FF}
          Properties.GlyphCount = 3
          Properties.NullStyle = nssUnchecked
          Width = 29
        end
        object GridViewMargen: TcxGridDBColumn
          DataBinding.FieldName = 'Margen'
          Options.Editing = False
          Width = 50
        end
        object GridViewMargenPorcentual: TcxGridDBColumn
          Caption = '% Marg.'
          DataBinding.FieldName = 'MargenPorcentual'
          Options.Editing = False
          Width = 50
        end
        object GridViewImporteNetoCalculo: TcxGridDBColumn
          DataBinding.FieldName = 'ImporteNetoCalculo'
          Visible = False
        end
        object GridViewCosteCalculo: TcxGridDBColumn
          DataBinding.FieldName = 'CosteCalculo'
          Visible = False
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridView
      end
    end
    object TableViewManager: TGridTableViewController
      Left = 844
      Top = 62
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 2
      Visible = False
      HighlightFixedColumns = False
      TableView = GridView
      ShiftRecords = False
      UseGridFilterBox = False
      OnUserSelection = TableViewManagerUserSelection
      Height = 292
      Width = 38
    end
  end
  object FormManager: TgxFormManager
    Dataset = MovimientoTable
    FirstKeyControl = SerieCtrl
    FirstDataControl = ClienteCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnShowForm = FormManagerShowForm
    OnReportRequest = FormManagerReportRequest
    OnNoteRequest = FormManagerNoteRequest
    Left = 698
    Top = 40
  end
  object MovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    CanInsert = False
    CanEdit = False
    CanModify = False
    OnSetKey = MovimientoTableSetKey
    OnGetRecord = MovimientoTableGetRecord
    OnRecordChanged = MovimientoTableRecordChanged
    OnUpdateState = MovimientoTableUpdateState
    Left = 666
    Top = 40
  end
  object MovimientoDataSource: TDataSource
    DataSet = MovimientoTable
    Left = 635
    Top = 40
  end
  object LineaMovimientoDataSource: TDataSource
    DataSet = LineaMovimientoQuery
    Left = 572
    Top = 40
  end
  object LineaMovimientoQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    BeforeOpen = LineaMovimientoQueryBeforeOpen
    AfterOpen = LineaMovimientoQueryAfterOpen
    BeforeClose = LineaMovimientoQueryBeforeClose
    AfterClose = LineaMovimientoQueryAfterClose
    OnCalcFields = LineaMovimientoQueryCalcFields
    DataSource = MovimientoDataSource
    RequestLive = True
    SQL.Strings = (
      'SELECT LineaMovimiento.*, Cantidad as CantidadAjustada'
      'FROM LineaMovimiento'
      
        'WHERE LineaMovimiento.Ejercicio=:Ejercicio and LineaMovimiento.N' +
        'roOperacion=:NroOperacion'
      'ORDER BY Ejercicio, NroOperacion, NroPagina, NroLinea')
    AutoIncFieldName = 'NroLinea'
    Left = 605
    Top = 40
    ParamData = <
      item
        DataType = ftSmallint
        Name = 'Ejercicio'
        ParamType = ptUnknown
      end
      item
        DataType = ftLongWord
        Name = 'NroOperacion'
        ParamType = ptUnknown
      end>
    object LineaMovimientoQueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object LineaMovimientoQueryNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object LineaMovimientoQueryCabeceraPagina: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'CabeceraPagina'
      Size = 30
      Calculated = True
    end
    object LineaMovimientoQueryCodigoGrupo: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'CodigoGrupo'
      Size = 2
      Calculated = True
    end
    object LineaMovimientoQueryDescripcionGrupo: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'DescripcionGrupo'
      Size = 30
      Calculated = True
    end
    object LineaMovimientoQueryNroPagina: TSmallintField
      FieldName = 'NroPagina'
    end
    object LineaMovimientoQueryNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object LineaMovimientoQueryNroRegistro: TUnsignedAutoIncField
      FieldName = 'NroRegistro'
    end
    object LineaMovimientoQueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object LineaMovimientoQueryTipoMovimientoOrigen: TSmallintField
      FieldName = 'TipoMovimientoOrigen'
    end
    object LineaMovimientoQueryAsignacionOrigen: TSmallintField
      FieldName = 'AsignacionOrigen'
    end
    object LineaMovimientoQueryEjercicioOrigen: TSmallintField
      FieldName = 'EjercicioOrigen'
    end
    object LineaMovimientoQueryNroOperacionOrigen: TIntegerField
      FieldName = 'NroOperacionOrigen'
    end
    object LineaMovimientoQueryNroRegistroOrigen: TIntegerField
      FieldName = 'NroRegistroOrigen'
    end
    object LineaMovimientoQueryUIDArticulo: TGuidField
      FieldName = 'UIDArticulo'
      Size = 38
    end
    object LineaMovimientoQueryCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object LineaMovimientoQueryCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object LineaMovimientoQueryCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object LineaMovimientoQueryCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object LineaMovimientoQueryLoteFabricacion: TWideStringField
      FieldName = 'LoteFabricacion'
    end
    object LineaMovimientoQueryNumeroSerie: TWideStringField
      FieldName = 'NumeroSerie'
      Size = 40
    end
    object LineaMovimientoQueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object LineaMovimientoQueryCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object LineaMovimientoQueryUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
    object LineaMovimientoQueryCantidad: TBCDField
      FieldName = 'Cantidad'
    end
    object LineaMovimientoQueryCantidadAjustada: TBCDField
      FieldName = 'CantidadAjustada'
    end
    object LineaMovimientoQueryCantidadProcesada: TBCDField
      FieldName = 'CantidadProcesada'
    end
    object LineaMovimientoQueryPrecio: TFloatField
      FieldName = 'Precio'
    end
    object LineaMovimientoQueryPrecioDivisa: TBCDField
      FieldName = 'PrecioDivisa'
    end
    object LineaMovimientoQueryRecargo: TBCDField
      FieldName = 'Recargo'
    end
    object LineaMovimientoQueryPuntoVerde: TBCDField
      FieldName = 'PuntoVerde'
    end
    object LineaMovimientoQueryDescuento: TBCDField
      FieldName = 'Descuento'
    end
    object LineaMovimientoQueryNroCajas: TBCDField
      FieldName = 'NroCajas'
    end
    object LineaMovimientoQueryLargo: TBCDField
      FieldName = 'Largo'
    end
    object LineaMovimientoQueryAncho: TBCDField
      FieldName = 'Ancho'
    end
    object LineaMovimientoQueryAlto: TBCDField
      FieldName = 'Alto'
    end
    object LineaMovimientoQueryBultos: TBCDField
      FieldName = 'Bultos'
    end
    object LineaMovimientoQueryImporteBruto: TBCDField
      FieldName = 'ImporteBruto'
    end
    object LineaMovimientoQueryImporteDescuento: TBCDField
      FieldName = 'ImporteDescuento'
    end
    object LineaMovimientoQueryImporteNeto: TBCDField
      FieldName = 'ImporteNeto'
    end
    object LineaMovimientoQueryNoCalcularMargen: TBooleanField
      FieldName = 'NoCalcularMargen'
    end
    object LineaMovimientoQueryCoste: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Coste'
      Calculated = True
    end
    object LineaMovimientoQueryMargen: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Margen'
      Calculated = True
    end
    object LineaMovimientoQueryMargenPorcentual: TBCDField
      FieldKind = fkCalculated
      FieldName = 'MargenPorcentual'
      Calculated = True
    end
    object LineaMovimientoQueryAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object LineaMovimientoQueryCosteCalculo: TBCDField
      FieldKind = fkCalculated
      FieldName = 'CosteCalculo'
      Calculated = True
    end
    object LineaMovimientoQueryImporteNetoCalculo: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ImporteNetoCalculo'
      Calculated = True
    end
    object LineaMovimientoQueryRegistroOrigen: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'RegistroOrigen'
      Calculated = True
    end
    object LineaMovimientoQueryTextoMovimientoOrigen: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'TextoMovimientoOrigen'
      Calculated = True
    end
    object LineaMovimientoQueryEsCosteReal: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'EsCosteReal'
      Calculated = True
    end
  end
  object Data: TgxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 610
    Top = 128
    object DataServido: TBooleanField
      FieldName = 'Servido'
    end
  end
  object MemDataSource: TDataSource
    DataSet = Data
    Left = 580
    Top = 128
  end
  object LineaMovimientoAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'TipoMovimientoOrigen;EjercicioOrigen;NroOperacionOrigen'
    Left = 485
    Top = 40
  end
  object GrupoLineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    Left = 451
    Top = 40
    object GrupoLineaMovimientoTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
      Required = True
    end
    object GrupoLineaMovimientoTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
      Required = True
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
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'PopupMenu')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 367
    Top = 39
    PixelsPerInch = 96
    object EditarDocItem: TdxBarButton
      Caption = 'Editar'
      Category = 1
      Visible = ivAlways
      OnClick = EditarDocItemClick
    end
    object Fichadelartculo1: TdxBarButton
      Caption = 'Mantenimiento del art'#237'culo'
      Category = 1
      Visible = ivAlways
      OnClick = Fichadelartculo1Click
    end
    object FichaArticuloItem: TdxBarButton
      Caption = 'Ficha de movimientos del art'#237'culo'
      Category = 1
      Visible = ivAlways
      OnClick = FichaArticuloItemClick
    end
    object TrazaItem: TdxBarButton
      Caption = 'Traza del art'#237'culo'
      Category = 1
      Visible = ivAlways
      OnClick = TrazaItemClick
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
        ItemName = 'Fichadelartculo1'
      end
      item
        Visible = True
        ItemName = 'FichaArticuloItem'
      end
      item
        Visible = True
        ItemName = 'TrazaItem'
      end>
    UseOwnFont = False
    OnPopup = PopupMenuPopup
    Left = 400
    Top = 40
    PixelsPerInch = 96
  end
end
