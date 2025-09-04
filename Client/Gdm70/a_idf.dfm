object MntIdfForm: TMntIdfForm
  Left = 607
  Top = 376
  HelpContext = 10107
  BorderStyle = bsDialog
  Caption = 'Informes de fabricaci'#243'n'
  ClientHeight = 597
  ClientWidth = 859
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Position = poDefault
  Visible = True
  TextHeight = 17
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    DesignSize = (
      859
      116)
    Height = 116
    Width = 859
    object NroOrdenCtrl: TcxDBIntegerEdit
      Left = 203
      Top = 3
      DescriptionLabel = cxLabel27
      DataBinding.DataField = 'NroOrden'
      DataBinding.DataSource = InformeFabricacionDataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroOrdenCtrlPropertiesQueryRequest
      Properties.AssignedValues.DisplayFormat = True
      Properties.AssignedValues.EditFormat = True
      Properties.MaxLength = 8
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = NroOrdenCtrlPropertiesValidate
      TabOrder = 1
      Width = 71
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 8
      TabStop = False
      Caption = 'N'#186' orden'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
    end
    object EstadoLabel: TcxLabel
      Left = 701
      Top = 7
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
      Height = 16
      Width = 95
    end
    object EjercicioCtrl: TcxDBSpinEdit
      Left = 143
      Top = 4
      DataBinding.DataField = 'Ejercicio'
      DataBinding.DataSource = InformeFabricacionDataSource
      Properties.Required = True
      Properties.OnEnter = EjercicioCtrlPropertiesEnter
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 9999.000000000000000000
      Properties.MinValue = 2000.000000000000000000
      Properties.UseCtrlIncrement = True
      Properties.UseLeftAlignmentOnEditing = False
      Properties.OnValidate = EjercicioCtrlPropertiesValidate
      TabOrder = 0
      Width = 56
    end
    object Tareas1Button: TgBitBtn
      Left = 280
      Top = 5
      Width = 85
      Height = 25
      Caption = 'Tareas'
      Enabled = True
      OptionsImage.ImageIndex = 55
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 2
      OnClick = Tareas1ButtonClick
      GlyphBitmap = gmWindowList
    end
    object cxLabel6: TcxLabel
      Left = 15
      Top = 35
      TabStop = False
      Caption = 'N'#186' proceso'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
    end
    object NroProcesoCtrl: TcxDBSpinEdit
      Left = 143
      Top = 32
      DescriptionLabel = DescOperacionLabel
      DataBinding.DataField = 'NroProceso'
      DataBinding.DataSource = InformeFabricacionDataSource
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 9999.000000000000000000
      Properties.UseCtrlIncrement = True
      Properties.UseLeftAlignmentOnEditing = False
      Properties.OnValidate = NroProcesoCtrlPropertiesValidate
      TabOrder = 3
      Width = 56
    end
    object cxLabel7: TcxLabel
      Left = 15
      Top = 62
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object FechaCtrl: TcxDBDateEdit
      Left = 143
      Top = 59
      DataBinding.DataField = 'Fecha'
      DataBinding.DataSource = InformeFabricacionDataSource
      Properties.Required = True
      Properties.OnEnter = FechaCtrlPropertiesEnter
      TabOrder = 4
      Width = 100
    end
    object cxLabel8: TcxLabel
      Left = 15
      Top = 89
      TabStop = False
      Caption = 'Turno'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
    end
    object TurnoCtrl: TcxDBSpinEdit
      Left = 143
      Top = 86
      DescriptionLabel = DescTurnoLabel
      DataBinding.DataField = 'Turno'
      DataBinding.DataSource = InformeFabricacionDataSource
      Properties.Required = True
      Properties.OnQueryRequest = TurnoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = TurnoCtrlPropertiesEditRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 4.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.UseCtrlIncrement = True
      Properties.UseLeftAlignmentOnEditing = False
      Properties.OnValidate = TurnoCtrlPropertiesValidate
      TabOrder = 5
      Width = 56
    end
    object DescOperacionLabel: TcxLabel
      Left = 414
      Top = 35
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
      Height = 19
      Width = 438
    end
    object DescMaquinaLabel: TcxLabel
      Left = 414
      Top = 62
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
      Height = 19
      Width = 310
    end
    object DescTurnoLabel: TcxLabel
      Left = 414
      Top = 89
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
      Height = 16
      Width = 310
    end
    object cxLabel27: TcxLabel
      Left = 414
      Top = 8
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 14
      Transparent = True
      Height = 19
      Width = 438
    end
    object Tareas2Button: TgBitBtn
      Left = 280
      Top = 32
      Width = 85
      Height = 25
      Caption = 'Tareas'
      Enabled = True
      OptionsImage.ImageIndex = 55
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 15
      OnClick = Tareas2ButtonClick
      GlyphBitmap = gmWindowList
    end
  end
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 116
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
    Height = 445
    Width = 849
    object HeaderGroupBox: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      Alignment = alCenterCenter
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 196
      Width = 845
      object cxGroupBox1: TcxGroupBox
        Left = 2
        Top = 136
        Align = alClient
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 58
        Width = 841
        object cxLabel2: TcxLabel
          Left = 7
          Top = 5
          TabStop = False
          Caption = 'Lote'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object cxLabel12: TcxLabel
          Left = 7
          Top = 29
          TabStop = False
          Caption = 'A procesar'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
        object cxLabel13: TcxLabel
          Left = 405
          Top = 29
          TabStop = False
          Caption = 'Duraci'#243'n prevista'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object LoteBox: TcxLabel
          Left = 134
          Top = 1
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Vert = taVCenter
          TabOrder = 3
          Transparent = True
          Height = 25
          Width = 100
          AnchorY = 14
        end
        object AProcesarBox: TcxLabel
          Left = 134
          Top = 25
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
          TabOrder = 4
          Transparent = True
          Height = 25
          Width = 78
          AnchorX = 212
          AnchorY = 38
        end
        object DuracionPrevistaBox: TcxLabel
          Left = 528
          Top = 25
          TabStop = False
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Vert = taVCenter
          TabOrder = 5
          Transparent = True
          Height = 25
          Width = 60
          AnchorY = 38
        end
      end
      object cxGroupBox2: TcxGroupBox
        Left = 2
        Top = 109
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 27
        Width = 841
        object capClaseCLabel: TcxLabel
          Left = 6
          Top = 5
          TabStop = False
          Caption = 'Clase C'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object DescClaseCLabel: TcxLabel
          Left = 405
          Top = 5
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
          Height = 19
          Width = 267
        end
        object CodigoClaseCBox: TcxLabel
          Tag = 3
          Left = 134
          Top = 1
          TabStop = False
          CaptionLabel = capClaseCLabel
          DescriptionLabel = DescClaseCLabel
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Vert = taVCenter
          TabOrder = 2
          Transparent = True
          Height = 25
          Width = 36
          AnchorY = 14
        end
      end
      object cxGroupBox3: TcxGroupBox
        Left = 2
        Top = 82
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Height = 27
        Width = 841
        object capClaseBLabel: TcxLabel
          Left = 6
          Top = 5
          TabStop = False
          Caption = 'Clase B'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object DescClaseBLabel: TcxLabel
          Left = 405
          Top = 5
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
          Height = 19
          Width = 267
        end
        object CodigoClaseBBox: TcxLabel
          Tag = 2
          Left = 134
          Top = 1
          TabStop = False
          CaptionLabel = capClaseBLabel
          DescriptionLabel = DescClaseBLabel
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Vert = taVCenter
          TabOrder = 2
          Transparent = True
          Height = 25
          Width = 36
          AnchorY = 14
        end
      end
      object cxGroupBox4: TcxGroupBox
        Left = 2
        Top = 55
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 3
        Height = 27
        Width = 841
        object capClaseALabel: TcxLabel
          Left = 6
          Top = 5
          TabStop = False
          Caption = 'Clase A '
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object DescClaseALabel: TcxLabel
          Left = 405
          Top = 5
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
          Height = 19
          Width = 267
        end
        object CodigoClaseABox: TcxLabel
          Tag = 1
          Left = 134
          Top = 1
          TabStop = False
          CaptionLabel = capClaseALabel
          DescriptionLabel = DescClaseALabel
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Vert = taVCenter
          TabOrder = 2
          Transparent = True
          Height = 25
          Width = 36
          AnchorY = 14
        end
      end
      object cxGroupBox5: TcxGroupBox
        Left = 2
        Top = 2
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 4
        DesignSize = (
          841
          53)
        Height = 53
        Width = 841
        object cxLabel3: TcxLabel
          Left = 5
          Top = 6
          TabStop = False
          Caption = 'N'#186' pedido'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 0
          Transparent = True
        end
        object cxLabel1: TcxLabel
          Left = 5
          Top = 30
          TabStop = False
          Caption = 'Art'#237'culo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 1
          Transparent = True
        end
        object DescArticuloLabel: TcxLabel
          Left = 405
          Top = 30
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
          Height = 19
          Width = 402
        end
        object cxLabel28: TcxLabel
          Left = 279
          Top = 6
          TabStop = False
          Caption = 'de'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
        end
        object DescPedidoLabel: TcxLabel
          Left = 405
          Top = 6
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
          Height = 19
          Width = 402
        end
        object EjercicioPedidoBox: TcxLabel
          Left = 134
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
          TabOrder = 5
          Transparent = True
          Height = 25
          Width = 36
          AnchorX = 170
          AnchorY = 15
        end
        object NroPedidoBox: TcxLabel
          Left = 178
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
          TabOrder = 6
          Transparent = True
          Height = 25
          Width = 80
          AnchorX = 258
          AnchorY = 15
        end
        object CodigoArticuloBox: TcxLabel
          Left = 134
          Top = 26
          TabStop = False
          DescriptionLabel = DescArticuloLabel
          AutoSize = False
          Style.BorderColor = clScrollBar
          Style.BorderStyle = ebsSingle
          Style.Edges = [bBottom]
          Style.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.NativeStyle = False
          Properties.Alignment.Vert = taVCenter
          TabOrder = 7
          Transparent = True
          Height = 25
          Width = 124
          AnchorY = 39
        end
      end
    end
    object LinesGroupBox: TcxGroupBox
      Left = 2
      Top = 198
      Align = alClient
      Alignment = alCenterCenter
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 245
      Width = 845
      object DataPageControl: TcxPageControl
        Left = 2
        Top = 2
        Width = 841
        Height = 241
        Align = alClient
        TabOrder = 0
        Properties.ActivePage = FabricacionTS
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 237
        ClientRectLeft = 4
        ClientRectRight = 837
        ClientRectTop = 28
        object FabricacionTS: TcxTabSheet
          Caption = 'Fabricaci'#243'n'
          ImageIndex = 0
          ExplicitTop = 33
          ExplicitHeight = 204
          object cxLabel4: TcxLabel
            Left = 3
            Top = 6
            TabStop = False
            Caption = 'Correctas'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 12
            Transparent = True
          end
          object CorrectasCtrl: TcxDBCurrencyEdit
            Left = 130
            Top = 3
            DataBinding.DataField = 'Correctas'
            DataBinding.DataSource = InformeFabricacionDataSource
            Properties.OnValidate = CorrectasCtrlPropertiesValidate
            TabOrder = 0
            Width = 76
          end
          object cxLabel5: TcxLabel
            Left = 3
            Top = 33
            TabStop = False
            Caption = 'Defectuosas'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 13
            Transparent = True
          end
          object DefectuosasCtrl: TcxDBCurrencyEdit
            Left = 130
            Top = 30
            DataBinding.DataField = 'Defectuosas'
            DataBinding.DataSource = InformeFabricacionDataSource
            Properties.OnValidate = DefectuosasCtrlPropertiesValidate
            TabOrder = 1
            Width = 76
          end
          object cxLabel14: TcxLabel
            Left = 231
            Top = 33
            TabStop = False
            Caption = 'Defecto'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 14
            Transparent = True
          end
          object CodigoDefectoCtrl: TcxDBSpinEdit
            Left = 305
            Top = 30
            DescriptionLabel = cxLabel22
            DataBinding.DataField = 'CodigoDefecto'
            DataBinding.DataSource = InformeFabricacionDataSource
            Properties.OnQueryRequest = CodigoDefectoCtrlPropertiesQueryRequest
            Properties.OnEditRequest = CodigoDefectoCtrlPropertiesEditRequest
            Properties.AssignedValues.MinValue = True
            Properties.DisplayFormat = '#'
            Properties.EditFormat = '#'
            Properties.MaxValue = 9999.000000000000000000
            Properties.UseCtrlIncrement = True
            Properties.UseLeftAlignmentOnEditing = False
            Properties.OnValidate = CodigoDefectoCtrlPropertiesValidate
            TabOrder = 2
            Width = 56
          end
          object IncorpExtraidasCtrl: TcxDBCurrencyEdit
            Left = 130
            Top = 57
            DataBinding.DataField = 'IncorpExtraidas'
            DataBinding.DataSource = InformeFabricacionDataSource
            TabOrder = 4
            Width = 76
          end
          object cxLabel15: TcxLabel
            Left = 3
            Top = 60
            TabStop = False
            Caption = 'Incorp./extra'#237'das +/-'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 15
            Transparent = True
          end
          object MermaExcesoCtrl: TcxDBCurrencyEdit
            Left = 130
            Top = 84
            DataBinding.DataField = 'MermaExceso'
            DataBinding.DataSource = InformeFabricacionDataSource
            Properties.OnEnter = MermaExcesoCtrlPropertiesEnter
            TabOrder = 6
            Width = 76
          end
          object cxLabel16: TcxLabel
            Left = 3
            Top = 87
            TabStop = False
            Caption = 'Exceso/Merma +/-'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 16
            Transparent = True
          end
          object cxLabel17: TcxLabel
            Left = 3
            Top = 114
            TabStop = False
            Caption = 'Inicio'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 17
            Transparent = True
          end
          object cxLabel18: TcxLabel
            Left = 231
            Top = 114
            TabStop = False
            Caption = 'Fin'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 18
            Transparent = True
          end
          object HoraInicioCtrl: TcxDBTimeEdit
            Left = 130
            Top = 111
            DataBinding.DataField = 'HoraInicio'
            DataBinding.DataSource = InformeFabricacionDataSource
            Properties.Required = True
            Properties.OnValuePosted = InicioFinCtrlPropertiesValuePosted
            Properties.TimeFormat = tfHourMin
            Properties.ValidateOnEnter = False
            Properties.OnValidate = InicioFinCtrlPropertiesValidate
            TabOrder = 7
            Width = 63
          end
          object HoraFinalizacionCtrl: TcxDBTimeEdit
            Left = 305
            Top = 111
            DataBinding.DataField = 'HoraFinalizacion'
            DataBinding.DataSource = InformeFabricacionDataSource
            Properties.Required = True
            Properties.OnValuePosted = InicioFinCtrlPropertiesValuePosted
            Properties.TimeFormat = tfHourMin
            Properties.OnValidate = InicioFinCtrlPropertiesValidate
            TabOrder = 8
            Width = 63
          end
          object cxLabel19: TcxLabel
            Left = 405
            Top = 114
            TabStop = False
            Caption = 'Duraci'#243'n'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 19
            Transparent = True
          end
          object cxLabel20: TcxLabel
            Left = 3
            Top = 141
            TabStop = False
            Caption = 'Preparaci'#243'n'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 20
            Transparent = True
          end
          object cxLabel21: TcxLabel
            Left = 231
            Top = 141
            TabStop = False
            Caption = 'Fabricaci'#243'n'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 21
            Transparent = True
          end
          object cxLabel22: TcxLabel
            Left = 401
            Top = 33
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 22
            Transparent = True
            Height = 19
            Width = 313
          end
          object cxLabel23: TcxLabel
            Left = 3
            Top = 168
            TabStop = False
            Caption = 'Incidencia'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 23
            Transparent = True
          end
          object CodigoIncidenciaCtrl: TcxDBSpinEdit
            Left = 130
            Top = 165
            DescriptionLabel = cxLabel24
            DataBinding.DataField = 'CodigoIncidencia'
            DataBinding.DataSource = InformeFabricacionDataSource
            Properties.OnQueryRequest = CodigoIncidenciaCtrlPropertiesQueryRequest
            Properties.OnEditRequest = CodigoIncidenciaCtrlPropertiesEditRequest
            Properties.AssignedValues.MinValue = True
            Properties.DisplayFormat = '#'
            Properties.EditFormat = '#'
            Properties.MaxValue = 9999.000000000000000000
            Properties.UseCtrlIncrement = True
            Properties.UseLeftAlignmentOnEditing = False
            Properties.OnValidate = CodigoIncidenciaCtrlPropertiesValidate
            TabOrder = 11
            Width = 56
          end
          object cxLabel24: TcxLabel
            Left = 231
            Top = 168
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 24
            Transparent = True
            Height = 19
            Width = 352
          end
          object cxLabel25: TcxLabel
            Left = 401
            Top = 60
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 25
            Transparent = True
            Height = 19
            Width = 267
          end
          object IncExtClaseACtrl: TcxDBTextEdit
            Tag = 1
            Left = 306
            Top = 57
            CaptionLabel = cxLabel26
            DescriptionLabel = cxLabel25
            DataBinding.DataField = 'IncExtClaseA'
            DataBinding.DataSource = InformeFabricacionDataSource
            Properties.OnQueryRequest = IncExtClaseACtrlPropertiesQueryRequest
            Properties.OnEditRequest = IncExtClaseACtrlPropertiesEditRequest
            Properties.OnValidate = IncExtClaseACtrlPropertiesValidate
            TabOrder = 5
            Width = 32
          end
          object cxLabel26: TcxLabel
            Left = 231
            Top = 60
            TabStop = False
            Caption = 'Clase A '
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 26
            Transparent = True
          end
          object MasDefectosButton: TgBitBtn
            Left = 714
            Top = 29
            Width = 96
            Height = 27
            Caption = 'Defectos ...'
            Enabled = False
            OptionsImage.ImageIndex = 46
            OptionsImage.Images = ApplicationContainer.ButtonImageList
            OptionsImage.Margin = 2
            OptionsImage.Spacing = 2
            TabOrder = 3
            GlyphBitmap = gmPlus
          end
          object DuracionLabel: TcxLabel
            Left = 528
            Top = 110
            TabStop = False
            AutoSize = False
            Style.BorderColor = clScrollBar
            Style.BorderStyle = ebsSingle
            Style.Edges = [bBottom]
            Style.LookAndFeel.NativeStyle = False
            StyleDisabled.LookAndFeel.NativeStyle = False
            StyleFocused.LookAndFeel.NativeStyle = False
            StyleHot.LookAndFeel.NativeStyle = False
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            TabOrder = 27
            Transparent = True
            Height = 25
            Width = 60
            AnchorX = 558
            AnchorY = 123
          end
          object PreparacionCtrl: TcxDBDurationEdit
            Left = 130
            Top = 138
            DataBinding.DataField = 'Preparacion'
            DataBinding.DataSource = InformeFabricacionDataSource
            Properties.OnValuePosted = PreparacionCtrlPropertiesValuePosted
            TabOrder = 9
            Width = 76
          end
          object FabricacionCtrl: TcxDBDurationEdit
            Left = 305
            Top = 138
            DataBinding.DataField = 'Fabricacion'
            DataBinding.DataSource = InformeFabricacionDataSource
            Properties.Required = True
            Properties.OnEnter = FabricacionCtrlPropertiesEnter
            TabOrder = 10
            Width = 76
          end
        end
        object ComponentesTS: TcxTabSheet
          Caption = 'Componentes'
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object cxGroupBox9: TcxGroupBox
            Left = 0
            Top = 0
            Align = alClient
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 0
            Height = 209
            Width = 833
            object ComponentesGrid: TcxGrid
              Left = 2
              Top = 2
              Width = 791
              Height = 205
              Align = alClient
              TabOrder = 0
              ExplicitHeight = 200
              object ComponentesTableView: TcxGridDBTableView
                Tag = 563294616
                Navigator.Buttons.CustomButtons = <>
                ScrollbarAnnotations.CustomAnnotations = <>
                DataController.DataSource = LineaOFComponenteDataSource
                DataController.KeyFieldNames = 'NroRegistro'
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <
                  item
                    Kind = skSum
                    FieldName = 'Cantidad'
                    Column = ComponentesTableViewCantidad
                    VisibleForCustomization = False
                  end
                  item
                    Kind = skSum
                    FieldName = 'ConsumoPrevisto'
                    Column = ComponentesTableViewConsumoPrevisto
                    VisibleForCustomization = False
                  end
                  item
                    Kind = skSum
                    FieldName = 'ConsumoReal'
                    Column = ComponentesTableViewConsumoReal
                    VisibleForCustomization = False
                  end>
                DataController.Summary.SummaryGroups = <>
                OptionsBehavior.FocusCellOnTab = True
                OptionsBehavior.FocusFirstCellOnNewRecord = True
                OptionsBehavior.FocusCellOnCycle = True
                OptionsCustomize.ColumnFiltering = False
                OptionsCustomize.ColumnGrouping = False
                OptionsCustomize.ColumnHidingOnGrouping = False
                OptionsCustomize.ColumnMoving = False
                OptionsCustomize.ColumnSorting = False
                OptionsData.Appending = True
                OptionsData.DeletingConfirmation = False
                OptionsView.ColumnAutoWidth = True
                OptionsView.GroupByBox = False
                object ComponentesTableViewCodigoArticulo: TcxGridDBColumn
                  Caption = 'Componente'
                  DataBinding.FieldName = 'CodigoArticulo'
                  PropertiesClassName = 'TcxTextEditProperties'
                  Properties.OnQueryRequest = ComponentesTableViewCodigoArticuloPropertiesQueryRequest
                  Properties.OnEditRequest = ComponentesTableViewCodigoArticuloPropertiesEditRequest
                  Properties.OnValidate = ComponentesTableViewCodigoArticuloPropertiesValidate
                  Width = 116
                end
                object ComponentesTableViewDescripcion: TcxGridDBColumn
                  DataBinding.FieldName = 'Descripcion'
                  Options.Editing = False
                  Options.Grouping = False
                  Width = 317
                end
                object ComponentesTableViewCodigoClaseA: TcxGridDBColumn
                  DataBinding.FieldName = 'CodigoClaseA'
                  Width = 23
                end
                object ComponentesTableViewCodigoClaseB: TcxGridDBColumn
                  DataBinding.FieldName = 'CodigoClaseB'
                  Width = 23
                end
                object ComponentesTableViewCodigoClaseC: TcxGridDBColumn
                  DataBinding.FieldName = 'CodigoClaseC'
                  Width = 22
                end
                object ComponentesTableViewLote: TcxGridDBColumn
                  DataBinding.FieldName = 'Lote'
                  PropertiesClassName = 'TcxTextEditProperties'
                  Properties.OnQueryRequest = ComponentesTableViewLotePropertiesQueryRequest
                  Properties.MaxLength = 20
                  Width = 87
                end
                object ComponentesTableViewCantidad: TcxGridDBColumn
                  DataBinding.FieldName = 'Cantidad'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.OnValuePosted = ComponentesTableViewCantidadPropertiesValuePosted
                  Width = 66
                end
                object ComponentesTableViewConsumoPrevisto: TcxGridDBColumn
                  Caption = 'Previsto'
                  DataBinding.FieldName = 'ConsumoPrevisto'
                  Options.Editing = False
                  Options.Focusing = False
                  Width = 68
                end
                object ComponentesTableViewConsumoReal: TcxGridDBColumn
                  Caption = 'Consumo'
                  DataBinding.FieldName = 'ConsumoReal'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Width = 67
                end
              end
              object ComponentesGridLevel: TcxGridLevel
                GridView = ComponentesTableView
              end
            end
            object GridTableViewController1: TGridTableViewController
              Left = 793
              Top = 2
              Align = alRight
              Enabled = False
              PanelStyle.Active = True
              Style.BorderStyle = ebsNone
              Style.TransparentBorder = False
              TabOrder = 1
              TableView = ComponentesTableView
              ShiftRecords = False
              UseGridFilterBox = False
              ExplicitHeight = 200
              Height = 205
              Width = 38
            end
          end
        end
        object OperariosTS: TcxTabSheet
          Caption = 'Operarios'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object TarifasPanel: TcxGroupBox
            Left = 0
            Top = 0
            Align = alClient
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 0
            Height = 209
            Width = 833
            object OperariosGrid: TcxGrid
              Left = 2
              Top = 2
              Width = 791
              Height = 205
              Align = alClient
              TabOrder = 0
              ExplicitHeight = 200
              object OperariosTableView: TcxGridDBTableView
                Tag = 563294616
                Navigator.Buttons.CustomButtons = <>
                ScrollbarAnnotations.CustomAnnotations = <>
                DataController.DataSource = LineaInformeFabricacionDataSource
                DataController.KeyFieldNames = 'Ejercicio;NroOrden;NroProceso;Fecha;Turno;NroRegistro'
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <>
                DataController.Summary.SummaryGroups = <>
                OptionsBehavior.FocusCellOnTab = True
                OptionsBehavior.FocusFirstCellOnNewRecord = True
                OptionsBehavior.FocusCellOnCycle = True
                OptionsCustomize.ColumnFiltering = False
                OptionsCustomize.ColumnGrouping = False
                OptionsCustomize.ColumnHidingOnGrouping = False
                OptionsCustomize.ColumnHorzSizing = False
                OptionsCustomize.ColumnMoving = False
                OptionsCustomize.ColumnSorting = False
                OptionsData.Appending = True
                OptionsData.DeletingConfirmation = False
                OptionsView.ColumnAutoWidth = True
                OptionsView.GroupByBox = False
                object OperariosTableViewCodigoOperario: TcxGridDBColumn
                  Caption = 'Operario'
                  DataBinding.FieldName = 'CodigoOperario'
                  PropertiesClassName = 'TcxTextEditProperties'
                  Properties.Required = True
                  Properties.OnQueryRequest = OperariosTableViewCodigoOperarioPropertiesQueryRequest
                  Properties.OnEditRequest = OperariosTableViewCodigoOperarioPropertiesEditRequest
                  Properties.OnValidate = OperariosTableViewCodigoOperarioPropertiesValidate
                  Width = 35
                end
                object OperariosTableViewNombre: TcxGridDBColumn
                  DataBinding.FieldName = 'Nombre'
                  Options.Editing = False
                  Options.Focusing = False
                end
              end
              object OperariosGridLevel: TcxGridLevel
                GridView = OperariosTableView
              end
            end
            object GridTableViewController: TGridTableViewController
              Left = 793
              Top = 2
              Align = alRight
              Enabled = False
              PanelStyle.Active = True
              Style.BorderStyle = ebsNone
              Style.TransparentBorder = False
              TabOrder = 1
              TableView = OperariosTableView
              ShiftRecords = False
              UseGridFilterBox = False
              ExplicitHeight = 200
              Height = 205
              Width = 38
            end
          end
        end
        object ObservacionesTS: TcxTabSheet
          Caption = 'Observaciones'
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          inline TAnnotationFrame1: TAnnotationFrame
            Left = 0
            Top = 0
            Width = 833
            Height = 209
            Align = alClient
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            ExplicitWidth = 833
            ExplicitHeight = 204
            inherited AnnotationPanel: TcxGroupBox
              ExplicitWidth = 833
              ExplicitHeight = 172
              Height = 177
              Width = 833
              inherited AnnotationRichEdit: TcxDBRichEdit
                DataBinding.DataField = 'Observaciones'
                DataBinding.DataSource = InformeFabricacionDataSource
                ExplicitWidth = 829
                ExplicitHeight = 127
                Height = 132
                Width = 829
              end
              inherited Ruler: TfrxRuler
                Width = 829
                ExplicitWidth = 829
              end
            end
            inherited ButtonsBar: TcxGroupBox
              ExplicitWidth = 833
              Width = 833
              inherited FontNameComboBox: TcxFontNameComboBox
                ExplicitHeight = 28
              end
              inherited FontSizeComboBox: TcxComboBox
                ExplicitHeight = 28
              end
            end
          end
        end
      end
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 561
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      859
      36)
    Height = 36
    Width = 859
    object Panel2: TcxGroupBox
      Left = 246
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 368
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
      object ReasignarButton: TgBitBtn
        Left = 267
        Top = 1
        Width = 97
        Height = 28
        Caption = 'Reasignar'
        Enabled = False
        OptionsImage.ImageIndex = 26
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 3
        GlyphBitmap = gmCalendar
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = InformeFabricacionTable
    FirstKeyControl = EjercicioCtrl
    FirstDataControl = CorrectasCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    BeforePostEditRecord = FormManagerBeforePostEditRecord
    Left = 650
    Top = 10
  end
  object InformeFabricacionTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterInsert = InformeFabricacionTableAfterInsert
    BeforeCancel = InformeFabricacionTableBeforeCancel
    BeforeDelete = InformeFabricacionTableBeforeDelete
    OnNewRecord = InformeFabricacionTableNewRecord
    TableName = 'InformeFabricacion'
    IndexFieldNames = 'Ejercicio;NroOrden;NroProceso;Fecha;Turno'
    AutoIncFieldName = 'NroOrden'
    OnCanEditRecord = InformeFabricacionTableCanEditRecord
    OnGetRecord = InformeFabricacionTableGetRecord
    OnUpdateState = InformeFabricacionTableUpdateState
    OnRemotePost = InformeFabricacionTableRemotePost
    OnRemoteDelete = InformeFabricacionTableRemoteDelete
    RemoteEdit = True
    Left = 618
    Top = 10
  end
  object InformeFabricacionDataSource: TDataSource
    DataSet = InformeFabricacionTable
    Left = 588
    Top = 10
  end
  object LineaInformeFabricacionTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforePost = LineaInformeFabricacionTableBeforePost
    OnCalcFields = LineaInformeFabricacionTableCalcFields
    TableName = 'LineaInformeFabricacion'
    IndexFieldNames = 'Ejercicio;NroOrden;NroProceso;Fecha;Turno;NroRegistro'
    MasterFields = 'Ejercicio;NroOrden;NroProceso;Fecha;Turno'
    MasterSource = InformeFabricacionDataSource
    AutoIncFieldName = 'NroRegistro'
    MasterRelation = mrBalanced
    Left = 618
    Top = 74
    object LineaInformeFabricacionTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
      Required = True
    end
    object LineaInformeFabricacionTableNroOrden: TIntegerField
      FieldName = 'NroOrden'
      Required = True
    end
    object LineaInformeFabricacionTableNroProceso: TSmallintField
      FieldName = 'NroProceso'
      Required = True
    end
    object LineaInformeFabricacionTableFecha: TDateField
      FieldName = 'Fecha'
      Required = True
    end
    object LineaInformeFabricacionTableTurno: TSmallintField
      FieldName = 'Turno'
      Required = True
    end
    object LineaInformeFabricacionTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
      Required = True
    end
    object LineaInformeFabricacionTableCodigoOperario: TWideStringField
      FieldName = 'CodigoOperario'
      Size = 5
    end
    object LineaInformeFabricacionTableNombre: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Nombre'
      Size = 60
      Calculated = True
    end
  end
  object LineaInformeFabricacionDataSource: TDataSource
    DataSet = LineaInformeFabricacionTable
    Left = 588
    Top = 74
  end
  object LineaOFComponenteDataSource: TDataSource
    DataSet = LineaOFComponenteTable
    Left = 588
    Top = 42
  end
  object LineaOFComponenteTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforePost = LineaOFComponenteTableBeforePost
    OnCalcFields = LineaOFComponenteTableCalcFields
    OnNewRecord = LineaOFComponenteTableNewRecord
    TableName = 'LineaOFComponente'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden;NroProceso;NroRegistro'
    MasterSource = InformeFabricacionDataSource
    AutoIncFieldName = 'NroRegistro'
    MasterRelation = mrBalanced
    OnApplyMasterRange = LineaOFComponenteTableApplyMasterRange
    Left = 618
    Top = 42
    object LineaOFComponenteTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
      Required = True
    end
    object LineaOFComponenteTableTipo: TSmallintField
      FieldName = 'Tipo'
      Required = True
    end
    object LineaOFComponenteTableNroOrden: TIntegerField
      FieldName = 'NroOrden'
      Required = True
    end
    object LineaOFComponenteTableNroProceso: TSmallintField
      FieldName = 'NroProceso'
      Required = True
    end
    object LineaOFComponenteTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
      Required = True
    end
    object LineaOFComponenteTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
      Required = True
    end
    object LineaOFComponenteTableDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Descripcion'
      Size = 80
      Calculated = True
    end
    object LineaOFComponenteTableCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object LineaOFComponenteTableCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object LineaOFComponenteTableCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object LineaOFComponenteTableLote: TWideStringField
      FieldName = 'Lote'
    end
    object LineaOFComponenteTableCantidadOriginal: TFloatField
      FieldName = 'CantidadOriginal'
    end
    object LineaOFComponenteTableCantidad: TFloatField
      FieldName = 'Cantidad'
    end
    object LineaOFComponenteTableConsumoPrevisto: TFloatField
      FieldName = 'ConsumoPrevisto'
    end
    object LineaOFComponenteTableConsumoReal: TFloatField
      FieldName = 'ConsumoReal'
    end
  end
  object DefectoInformeFabricacionTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'DefectoInformeFabricacion'
    IndexFieldNames = 'Ejercicio;NroOrden;NroProceso;Fecha;Turno'
    MasterFields = 'Ejercicio;NroOrden;NroProceso;Fecha;Turno'
    MasterSource = InformeFabricacionDataSource
    AutoIncFieldName = 'NroProceso'
    Left = 586
    Top = 114
  end
  object LineaOFOperacionTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaOFOperacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden;NroProceso'
    AutoIncFieldName = 'NroProceso'
    Left = 618
    Top = 114
  end
  object SecuenciaAsignacionTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'SecuenciaAsignacion'
    IndexFieldNames = 'Ejercicio;NroOrdenFabricacion;NroProceso;Fecha;Turno'
    AutoIncFieldName = 'NroProceso'
    Left = 650
    Top = 114
  end
  object SecuenciaAsignacion1Table: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'SecuenciaAsignacion'
    IndexFieldNames = 'Ejercicio;NroOrdenFabricacion;NroProceso;Segmento'
    AutoIncFieldName = 'NroProceso'
    Left = 682
    Top = 114
  end
  object OperariosMaquinaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'OperariosMaquina'
    IndexFieldNames = 'CodigoMaquina;Turno;NroRegistro'
    AutoIncFieldName = 'NroProceso'
    Left = 714
    Top = 114
  end
end
