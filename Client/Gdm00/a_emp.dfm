object MntEmpForm: TMntEmpForm
  Left = 397
  Top = 186
  HelpType = htKeyword
  HelpKeyword = 'a_emp'
  HelpContext = 200
  ActiveControl = OkButton
  BorderStyle = bsDialog
  Caption = 'Empresas'
  ClientHeight = 522
  ClientWidth = 653
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  Position = poDesigned
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
    Height = 36
    Width = 653
    object CodigoCtrl: TcxDBTextEdit
      Left = 171
      Top = 4
      BeepOnEnter = False
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoTextEditPropertiesQueryRequest
      Properties.CharCase = ecUpperCase
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoTextEditPropertiesValidate
      TabOrder = 0
      OnEnter = CodigoCtrlEnter
      Width = 32
    end
    object codigoCtrlCaption: TcxLabel
      Left = 20
      Top = 8
      TabStop = False
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 486
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      653
      36)
    Height = 36
    Width = 653
    object Panel2: TcxGroupBox
      Left = 194
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 265
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
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
        Left = 90
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
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
        Left = 178
        Top = 2
        Width = 85
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
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
    end
  end
  object dataPanel: TgxEditPanel
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
    Height = 450
    Width = 643
    object PageControl: TcxPageControl
      Left = 2
      Top = 2
      Width = 639
      Height = 446
      Align = alClient
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = cxTabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 442
      ClientRectLeft = 4
      ClientRectRight = 635
      ClientRectTop = 28
      object cxTabSheet1: TcxTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = '&Datos generales'
        ImageIndex = 0
        object cxScrollBox1: TcxScrollBox
          Left = 0
          Top = 0
          Width = 631
          Height = 414
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          BorderStyle = cxcbsNone
          TabOrder = 0
          Transparent = True
          object cxGroupBox8: TcxGroupBox
            Left = 0
            Top = 0
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alTop
            Alignment = alCenterCenter
            PanelStyle.Active = True
            PanelStyle.CaptionIndent = 3
            Style.BorderStyle = ebsNone
            TabOrder = 0
            DesignSize = (
              631
              404)
            Height = 404
            Width = 631
            object CodigoEANCtrl: TcxDBTextEdit
              Left = 160
              Top = 227
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DataBinding.DataField = 'CodigoEAN'
              DataBinding.DataSource = DataSource
              TabOrder = 9
              Width = 129
            end
            object CodigoPaisCtrl: TcxDBTextEdit
              Left = 160
              Top = 91
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DescriptionLabel = descPaisLabel
              DataBinding.DataField = 'CodigoPais'
              DataBinding.DataSource = DataSource
              Properties.OnQueryRequest = CodigoPaisCtrlPropertiesQueryRequest
              Properties.OnEditRequest = CodigoPaisCtrlPropertiesEditRequest
              Properties.TextEditPad = tpLeftZero
              Properties.OnEditValueChanged = CodigoPaisCtrlPropertiesEditValueChanged
              Properties.OnValidate = CodigoPaisCtrlPropertiesValidate
              TabOrder = 3
              Width = 40
            end
            object codigoPostalCtrl: TcxDBTextEdit
              Left = 195
              Top = 118
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DescriptionLabel = descProvinciaLabel
              DataBinding.DataField = 'CodigoPostal'
              DataBinding.DataSource = DataSource
              Properties.OnQueryRequest = codigoPostalCtrlPropertiesQueryRequest
              Properties.OnEditRequest = codigoPostalCtrlPropertiesEditRequest
              Properties.TextEditPad = tpRightZero
              Properties.OnValidate = codigoPostalCtrlPropertiesValidate
              Style.Shadow = False
              TabOrder = 5
              Width = 44
            end
            object CodigoProvinciaCtrl: TcxDBTextEdit
              Left = 160
              Top = 118
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DescriptionLabel = descProvinciaLabel
              DataBinding.DataField = 'CodigoProvincia'
              DataBinding.DataSource = DataSource
              Properties.OnQueryRequest = CodigoProvinciaCtrlPropertiesQueryRequest
              Properties.OnEditRequest = CodigoProvinciaCtrlPropertiesEditRequest
              Properties.TextEditPad = tpLeftZero
              Properties.OnEditValueChanged = CodigoProvinciaCtrlPropertiesEditValueChanged
              Properties.OnValidate = CodigoProvinciaCtrlPropertiesValidate
              TabOrder = 4
              Width = 31
            end
            object CPCtrlCaption: TcxLabel
              Left = 11
              Top = 122
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Provincia / C.P.'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 12
              Transparent = True
            end
            object cxLabel4: TcxLabel
              Left = 11
              Top = 228
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'C'#243'digo EAN'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 13
              Transparent = True
            end
            object DescNIF: TcxLabel
              Left = 301
              Top = 150
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 14
              Transparent = True
              Height = 23
              Width = 306
            end
            object descPaisLabel: TcxLabel
              Left = 301
              Top = 95
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 15
              Transparent = True
              Height = 24
              Width = 306
            end
            object descProvinciaLabel: TcxLabel
              Left = 301
              Top = 122
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 16
              Transparent = True
              Height = 24
              Width = 306
            end
            object DomicilioCtrl: TcxDBTextEdit
              Left = 160
              Top = 37
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DataBinding.DataField = 'Domicilio'
              DataBinding.DataSource = DataSource
              TabOrder = 1
              Width = 420
            end
            object DomicilioCtrlCaption: TcxLabel
              Left = 11
              Top = 41
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Domicilio'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 17
              Transparent = True
            end
            object FaxCtrl: TcxDBTextEdit
              Left = 160
              Top = 200
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DataBinding.DataField = 'Fax'
              DataBinding.DataSource = DataSource
              TabOrder = 8
              Width = 220
            end
            object FaxCtrlCaption: TcxLabel
              Left = 11
              Top = 202
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Fax'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 18
              Transparent = True
            end
            object Label8: TcxLabel
              Left = 11
              Top = 96
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Pais'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 19
              Transparent = True
            end
            object LocalidadCtrl: TcxDBTextEdit
              Left = 160
              Top = 64
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DataBinding.DataField = 'Localidad'
              DataBinding.DataSource = DataSource
              TabOrder = 2
              Width = 300
            end
            object LocalidadCtrlCaption: TcxLabel
              Left = 11
              Top = 67
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Localidad'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 20
              Transparent = True
            end
            object NIFCtrl: TcxDBTextEdit
              Left = 160
              Top = 146
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DescriptionLabel = DescNIF
              DataBinding.DataField = 'NIF'
              DataBinding.DataSource = DataSource
              Properties.OnValidate = NIFCtrlPropertiesValidate
              TabOrder = 6
              Width = 129
            end
            object NIFCtrlCaption: TcxLabel
              Left = 11
              Top = 150
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'N.I.F.'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 21
              Transparent = True
            end
            object NombreCtrl: TcxDBTextEdit
              Left = 160
              Top = 10
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DataBinding.DataField = 'Nombre'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              TabOrder = 0
              Width = 420
            end
            object nombreCtrlCaption: TcxLabel
              Left = 11
              Top = 14
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Nombre'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 22
              Transparent = True
            end
            object TelefonoCtrl: TcxDBTextEdit
              Left = 160
              Top = 173
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DataBinding.DataField = 'Telefono'
              DataBinding.DataSource = DataSource
              TabOrder = 7
              Width = 220
            end
            object TelefonoCtrlCaption: TcxLabel
              Left = 11
              Top = 176
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Telefono'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 23
              Transparent = True
            end
            object EjercicioPartidoCtrl: TcxCheckBox
              Left = 8
              Top = 253
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              AutoSize = False
              Caption = 'Ejercicio partido'
              Properties.Alignment = taRightJustify
              Properties.ImmediatePost = True
              Properties.OnChange = EjercicioPartidoCtrlPropertiesChange
              TabOrder = 10
              Transparent = True
              Height = 29
              Width = 168
            end
            object MesInicialCtrlCaption: TcxLabel
              Left = 38
              Top = 287
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Mes inicial'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 24
              Transparent = True
            end
            object descMesLabel: TcxLabel
              Left = 301
              Top = 287
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 25
              Transparent = True
              Height = 23
              Width = 203
            end
            object Contable_MesInicialCtrl: TcxDBIndexedComboBox
              Left = 159
              Top = 283
              DataBinding.DataField = 'Contable_MesInicial'
              DataBinding.DataSource = DataSource
              Properties.Alignment.Horz = taLeftJustify
              Properties.DropDownListStyle = lsFixedList
              Properties.ImmediatePost = True
              Properties.Items.Strings = (
                'Enero'
                'Febrero'
                'Marzo'
                'Abril'
                'Mayo'
                'Junio'
                'Julio'
                'Agosto'
                'Septiembre'
                'Octubre'
                'Noviembre'
                'Diciembre')
              Properties.FirstIndexValue = 1
              TabOrder = 11
              Width = 135
            end
          end
        end
      end
      object cxTabSheet2: TcxTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Confi&guraci'#243'n'
        ImageIndex = 1
        object cxScrollBox2: TcxScrollBox
          Left = 0
          Top = 0
          Width = 631
          Height = 414
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          BorderStyle = cxcbsNone
          TabOrder = 0
          Transparent = True
          object cxGroupBox1: TcxGroupBox
            AlignWithMargins = True
            Left = 4
            Top = 93
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alTop
            Caption = 'Informaci'#243'n'
            PanelStyle.Active = True
            PanelStyle.CaptionIndent = 3
            Style.BorderStyle = ebsNone
            Style.Edges = [bLeft, bTop, bRight, bBottom]
            Style.TextStyle = [fsBold]
            TabOrder = 1
            Height = 156
            Width = 623
            object Label2: TcxLabel
              AlignWithMargins = True
              Left = 12
              Top = 80
              Margins.Left = 10
              Margins.Top = 0
              Margins.Right = 4
              Margins.Bottom = 0
              TabStop = False
              Align = alTop
              Caption = 
                'Si su instalaci'#243'n es cliente y desea acceder a datos  situados e' +
                'n su puesto de trabajo, puede hacerlo indicando que se utilice e' +
                'l servidor local interno. '#201'sta opci'#243'n puede resultar '#250'til para a' +
                'cceder a datos situados en discos duros locales removibles o mem' +
                'orias flash.'
              Style.TextColor = clGray
              Properties.WordWrap = True
              TabOrder = 0
              Transparent = True
              Width = 605
            end
            object Label3: TcxLabel
              AlignWithMargins = True
              Left = 12
              Top = 25
              Margins.Left = 10
              Margins.Top = 23
              Margins.Right = 4
              Margins.Bottom = 0
              TabStop = False
              Align = alTop
              Caption = 
                'El directorio de localizaci'#243'n de los datos puede ser remoto o lo' +
                'cal, dependiendo del tipo de instalaci'#243'n. Si la aplicaci'#243'n est'#225' ' +
                'instalada como cliente de Terminal Server o como cliente de acce' +
                'so remoto (red local) el directorio es relativo al servidor de d' +
                'atos.'
              Style.TextColor = clGray
              Properties.WordWrap = True
              TabOrder = 1
              Transparent = True
              Width = 605
            end
          end
          object cxGroupBox2: TcxGroupBox
            AlignWithMargins = True
            Left = 4
            Top = 4
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alTop
            Caption = 'Localizaci'#243'n de los datos'
            PanelStyle.Active = True
            PanelStyle.CaptionIndent = 3
            Style.BorderStyle = ebsNone
            Style.TextStyle = [fsBold]
            TabOrder = 0
            DesignSize = (
              623
              81)
            Height = 81
            Width = 623
            object DataPathCtrl: TcxDBTextEdit
              Left = 156
              Top = 32
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Anchors = [akLeft, akTop, akRight]
              DataBinding.DataField = 'DataPath'
              DataBinding.DataSource = DataSource
              Properties.OnValidate = DataPathCtrlPropertiesValidate
              TabOrder = 0
              Width = 338
            end
            object examinarButton: TgBitBtn
              Left = 504
              Top = 27
              Width = 114
              Height = 36
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Anchors = [akTop, akRight]
              Caption = 'E&xaminar'
              Enabled = True
              OptionsImage.ImageIndex = 21
              OptionsImage.Images = ApplicationContainer.ButtonImageList
              OptionsImage.Margin = 5
              OptionsImage.Spacing = 6
              TabOrder = 1
              OnClick = examinarButtonClick
              GlyphBitmap = gmFolder
            end
            object DirectorioLabel: TcxLabel
              Left = 11
              Top = 35
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Directorio'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 2
              Transparent = True
            end
          end
        end
      end
      object cxTabSheet3: TcxTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Calendario'
        ImageIndex = 2
        object cxScrollBox3: TcxScrollBox
          Left = 0
          Top = 0
          Width = 631
          Height = 414
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          BorderStyle = cxcbsNone
          TabOrder = 0
          Transparent = True
          object cxGroupBox4: TcxGroupBox
            AlignWithMargins = True
            Left = 4
            Top = 4
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alTop
            Caption = 'Horario laboral'
            PanelStyle.Active = True
            PanelStyle.CaptionIndent = 3
            Style.BorderStyle = ebsNone
            Style.Edges = [bLeft, bTop, bRight, bBottom]
            Style.TextStyle = [fsBold]
            TabOrder = 0
            Height = 161
            Width = 623
            object gxRangeBox1: TgxRangeBox
              Left = 139
              Top = 33
              Width = 13
              Height = 37
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              ParentShowHint = False
              ShowHint = True
            end
            object cxLabel1: TcxLabel
              Left = 21
              Top = 31
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Inicio'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 2
              Transparent = True
            end
            object cxLabel2: TcxLabel
              Left = 21
              Top = 58
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Fin'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 3
              Transparent = True
            end
            object InicioJornadaLaboralCtrl: TcxDBTimeEdit
              Left = 156
              Top = 26
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DataBinding.DataField = 'InicioJornadaLaboral'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              Properties.TimeFormat = tfHourMin
              TabOrder = 0
              Width = 100
            end
            object FinJornadaLaboralCtrl: TcxDBTimeEdit
              Left = 156
              Top = 53
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DataBinding.DataField = 'FinJornadaLaboral'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              Properties.TimeFormat = tfHourMin
              TabOrder = 1
              Width = 100
            end
            object Image8: TcxImage
              Left = 589
              Top = 2
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Align = alRight
              Picture.Data = {
                0D546478536D617274496D6167653C3F786D6C2076657273696F6E3D22312E30
                2220656E636F64696E673D225554462D38223F3E0D0A3C737667207665727369
                6F6E3D22312E31222069643D224C617965725F312220786D6C6E733D22687474
                703A2F2F7777772E77332E6F72672F323030302F7376672220786D6C6E733A78
                6C696E6B3D22687474703A2F2F7777772E77332E6F72672F313939392F786C69
                6E6B2220783D223070782220793D22307078222077696474683D223234707822
                206865696768743D2232347078222076696577426F783D223020302032342032
                342220656E61626C652D6261636B67726F756E643D226E657720302030203234
                2032342220786D6C3A73706163653D227072657365727665223E262331303B20
                202623393B2623393B2623393B2623393B2623393B3C672069643D2269636F6E
                2220786D6C3A73706163653D227072657365727665223E262331333B26233130
                3B3C7061746820643D224D32312E382C33682D322E3330353163302E30303232
                2C302E303333322C302E303035312C302E303636332C302E303035312C302E31
                76302E3963302C302E3832352C2D302E3637352C312E352C2D312E352C312E35
                732D312E352C2D302E3637352C2D312E352C2D312E35762D302E3963302C2D30
                2E303333372C302E303032392C2D302E303636382C302E303035312C2D302E31
                48372E3439343943372E343937312C332E303333322C372E352C332E30363633
                2C372E352C332E3176302E3963302C302E3832352C2D302E3637352C312E352C
                2D312E352C312E35732D312E352C2D302E3637352C2D312E352C2D312E35762D
                302E3963302C2D302E303333372C302E303032392C2D302E303636382C302E30
                3035312C2D302E3148322E32632D302E36362C302C2D312E322C302E35342C2D
                312E322C312E3276322E3868323256342E324332332C332E35342C32322E3436
                2C332C32312E382C337A222066696C6C3D2223444234343533222F3E0D0A3C70
                61746820643D224D32322C32324832632D302E353532332C302C2D312C2D302E
                343437372C2D312C2D3156376832327631344332332C32312E353532332C3232
                2E353532332C32322C32322C32327A222066696C6C3D2223453645394545222F
                3E0D0A3C7061746820643D224D32312E382C33682D322E3330353163302E3030
                32322C302E303333322C302E303035312C302E303636332C302E303035312C30
                2E3176302E3963302C302E3832352C2D302E3637352C312E352C2D312E352C31
                2E35632D302E343337352C302C2D302E383331362C2D302E3139312C2D312E31
                3036342C2D302E343932334C372E303833312C323248323263302E353532332C
                302C312C2D302E343437372C312C2D31563756342E324332332C332E35342C32
                322E34362C332C32312E382C337A222066696C6C3D222332333146323022206F
                7061636974793D22302E31222F3E0D0A3C7061746820643D224D362C354C362C
                35632D302E35352C302C2D312C2D302E34352C2D312C2D31563263302C2D302E
                35352C302E34352C2D312C312C2D31683063302E35352C302C312C302E34352C
                312C31763243372C342E35352C362E35352C352C362C357A4D31392C34563263
                302C2D302E35352C2D302E34352C2D312C2D312C2D316830632D302E35352C30
                2C2D312C302E34352C2D312C31763263302C302E35352C302E34352C312C312C
                3168304331382E35352C352C31392C342E35352C31392C347A222066696C6C3D
                2223353336383830222F3E0D0A3C7061746820643D224D31342C39682D347633
                683456397A4D31392C39682D347633683456397A4D392C313348357633683456
                31337A4D31342C3133682D34763368345631337A4D31392C3133682D34763368
                345631337A4D392C31374835763368345631377A4D31342C3137682D34763368
                345631377A4D31392C3137682D34763368345631377A222066696C6C3D222338
                4539343943222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
              Properties.Center = False
              Properties.FitMode = ifmProportionalStretch
              Properties.GraphicClassName = 'TdxSmartImage'
              Properties.ReadOnly = True
              Properties.ShowFocusRect = False
              Style.BorderStyle = ebsNone
              StyleFocused.BorderStyle = ebsNone
              StyleHot.BorderStyle = ebsNone
              TabOrder = 4
              Transparent = True
              Height = 157
              Width = 32
            end
            object cxDBCheckGroup1: TcxDBCheckGroup
              AlignWithMargins = True
              Left = 149
              Top = 86
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Alignment = alCenterCenter
              Properties.Required = True
              Properties.Columns = 4
              Properties.EditValueFormat = cvfInteger
              Properties.Items = <
                item
                  Caption = 'Lunes'
                end
                item
                  Caption = 'Martes'
                end
                item
                  Caption = 'Mi'#233'rcoles'
                end
                item
                  Caption = 'Jueves'
                end
                item
                  Caption = 'Viernes'
                end
                item
                  Caption = 'S'#225'bado'
                end
                item
                  Caption = 'Domingo'
                end>
              Style.BorderStyle = ebsNone
              Style.TextStyle = []
              TabOrder = 5
              DataBinding.DataField = 'DiasLaborables'
              DataBinding.DataSource = DataSource
              Height = 61
              Width = 386
            end
            object cxLabel3: TcxLabel
              Left = 21
              Top = 93
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Dias laborables'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 6
              Transparent = True
            end
          end
          object cxGroupBox5: TcxGroupBox
            AlignWithMargins = True
            Left = 4
            Top = 173
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alTop
            Caption = 'Informaci'#243'n'
            PanelStyle.Active = True
            PanelStyle.CaptionIndent = 3
            Style.BorderStyle = ebsNone
            Style.Edges = [bLeft, bTop, bRight, bBottom]
            Style.TextStyle = [fsBold]
            TabOrder = 1
            Height = 84
            Width = 623
            object cxLabel5: TcxLabel
              AlignWithMargins = True
              Left = 12
              Top = 25
              Margins.Left = 10
              Margins.Top = 23
              Margins.Right = 4
              Margins.Bottom = 0
              TabStop = False
              Align = alTop
              Caption = 
                'Los dem'#225's par'#225'metros de trabajo, como son la zona horaria o el p' +
                'rimer d'#237'a de la semana,  se fijan a partir de la configuraci'#243'n d' +
                'el sistema (SO).'
              Style.TextColor = clGray
              Properties.WordWrap = True
              TabOrder = 0
              Transparent = True
              Width = 605
            end
          end
        end
      end
      object DatosRegistralesTabSheet: TcxTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Otros datos'
        ImageIndex = 3
        object cxScrollBox4: TcxScrollBox
          Left = 0
          Top = 0
          Width = 631
          Height = 414
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          BorderStyle = cxcbsNone
          TabOrder = 0
          Transparent = True
          object cxGroupBox6: TcxGroupBox
            AlignWithMargins = True
            Left = 4
            Top = 247
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alTop
            Caption = 'Declaraciones informativas (Modelos 347 y 349)'
            PanelStyle.Active = True
            PanelStyle.CaptionIndent = 3
            Style.BorderStyle = ebsNone
            Style.Edges = [bLeft, bTop, bRight, bBottom]
            Style.TextStyle = [fsBold]
            TabOrder = 1
            Height = 150
            Width = 623
            object cxImage1: TcxImage
              Left = 589
              Top = 2
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Align = alRight
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
              Properties.Center = False
              Properties.FitMode = ifmProportionalStretch
              Properties.ReadOnly = True
              Properties.ShowFocusRect = False
              Style.BorderStyle = ebsNone
              Style.HotTrack = False
              Style.ReadOnly = False
              StyleFocused.BorderStyle = ebsNone
              StyleHot.BorderStyle = ebsNone
              TabOrder = 1
              Transparent = True
              Height = 146
              Width = 32
            end
            object cxLabel7: TcxLabel
              Left = 8
              Top = 30
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              AutoSize = False
              Caption = 'Persona con quien relacionarse'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              Properties.WordWrap = True
              TabOrder = 2
              Transparent = True
              Height = 64
              Width = 136
            end
            object PersonaConQuienRelacionarseCtrl: TcxDBTextEdit
              Left = 156
              Top = 33
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DataBinding.DataField = 'PersonaConQuienRelacionarse'
              DataBinding.DataSource = DataSource
              TabOrder = 0
              Width = 410
            end
            object cxLabel8: TcxLabel
              Left = 156
              Top = 64
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              AutoSize = False
              Caption = 
                'Indique el nombre completo con el primer apellido, segundo apell' +
                'ido y nombre separados por un espacio.'
              Style.TextColor = clMedGray
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              Properties.WordWrap = True
              TabOrder = 3
              Transparent = True
              Height = 45
              Width = 438
            end
            object cxLabel6: TcxLabel
              Left = 156
              Top = 109
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              AutoSize = False
              Caption = 'Por ejemplo : Garc'#237'a L'#243'pez Juan'
              Style.TextColor = clMedGray
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              Properties.WordWrap = True
              TabOrder = 4
              Transparent = True
              Height = 19
              Width = 489
            end
          end
          object cxGroupBox7: TcxGroupBox
            AlignWithMargins = True
            Left = 4
            Top = 4
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alTop
            Caption = 'Datos registrales'
            PanelStyle.Active = True
            PanelStyle.CaptionIndent = 3
            Style.BorderStyle = ebsNone
            Style.Edges = [bLeft, bTop, bRight, bBottom]
            Style.TextStyle = [fsBold]
            TabOrder = 0
            Height = 235
            Width = 623
            object cxImage2: TcxImage
              Left = 589
              Top = 2
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Align = alRight
              Picture.Data = {
                0D546478536D617274496D6167653C3F786D6C2076657273696F6E3D22312E30
                2220656E636F64696E673D225554462D38223F3E0D0A3C737667207665727369
                6F6E3D22312E31222069643D224C617965725F312220786D6C6E733D22687474
                703A2F2F7777772E77332E6F72672F323030302F7376672220786D6C6E733A78
                6C696E6B3D22687474703A2F2F7777772E77332E6F72672F313939392F786C69
                6E6B2220783D223070782220793D22307078222077696474683D223234707822
                206865696768743D2232347078222076696577426F783D223020302032342032
                342220656E61626C652D6261636B67726F756E643D226E657720302030203234
                2032342220786D6C3A73706163653D227072657365727665223E262331303B20
                202623393B2623393B2623393B2623393B2623393B3C672069643D2269636F6E
                2220786D6C3A73706163653D227072657365727665223E202020202623393B26
                23393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B26
                23393B3C6720786D6C3A73706163653D227072657365727665223E262331333B
                262331303B3C7061746820643D224D342E3731372C362E333035386C31342E34
                3735372C2D302E313139336C2D302E303231382C31332E32393648342E363437
                314C342E3731372C362E333035387A222066696C6C2D72756C653D226576656E
                6F6464222066696C6C3D2223453645394545222F3E0D0A3C7061746820643D22
                4D392E353132352C313168342E39373563302E3238332C302C302E353132352C
                302E323239352C302E353132352C302E3531323576372E34373563302C302E32
                38332C2D302E323239352C302E353132352C2D302E353132352C302E35313235
                682D342E393735632D302E3238332C302C2D302E353132352C2D302E32323935
                2C2D302E353132352C2D302E35313235762D372E34373543392C31312E323239
                352C392E323239352C31312C392E353132352C31317A222066696C6C2D72756C
                653D226576656E6F6464222066696C6C3D2223463642423433222F3E0D0A3C67
                20786D6C3A73706163653D227072657365727665223E262331333B262331303B
                3C7061746820643D224D372E322C3137682D302E32762D3768302E3263302E35
                3532332C302C312C2D302E343437372C312C2D3163302C2D302E353532332C2D
                302E343437372C2D312C2D312C2D3148332E38632D302E353532332C302C2D31
                2C302E343437372C2D312C3163302C302E353532332C302E343437372C312C31
                2C3168302E327637682D302E32632D302E353532332C302C2D312C302E343437
                372C2D312C3163302C302E353532332C302E343437372C312C312C3168332E34
                63302E353532332C302C312C2D302E343437372C312C2D3143382E322C31372E
                343437372C372E373532332C31372C372E322C31377A222066696C6C2D72756C
                653D226576656E6F6464222066696C6C3D2223414142324244222F3E0D0A3C70
                61746820643D224D372E322C3137682D302E32762D3768302E3263302E353532
                332C302C312C2D302E343437372C312C2D3163302C2D302E353532332C2D302E
                343437372C2D312C2D312C2D3148352E3576313168312E3763302E353532332C
                302C312C2D302E343437372C312C2D3143382E322C31372E343437372C372E37
                3532332C31372C372E322C31377A222066696C6C2D72756C653D226576656E6F
                6464222066696C6C3D222332343238324422206F7061636974793D22302E3038
                222F3E0D0A0909093C2F673E0D0A3C6720786D6C3A73706163653D2270726573
                65727665223E262331333B262331303B3C7061746820643D224D32302E322C31
                37682D302E32762D3768302E3263302E353532332C302C312C2D302E34343737
                2C312C2D3163302C2D302E353532332C2D302E343437372C2D312C2D312C2D31
                682D332E34632D302E353532332C302C2D312C302E343437372C2D312C316330
                2C302E353532332C302E343437372C312C312C3168302E327637682D302E3263
                2D302E353532332C302C2D312C302E343437372C2D312C3163302C302E353532
                332C302E343437372C312C312C3168332E3463302E353532332C302C312C2D30
                2E343437372C312C2D314332312E322C31372E343437372C32302E373532332C
                31372C32302E322C31377A222066696C6C2D72756C653D226576656E6F646422
                2066696C6C3D2223414142324244222F3E0D0A3C7061746820643D224D32302E
                322C3137682D302E32762D3768302E3263302E353532332C302C312C2D302E34
                3437372C312C2D3163302C2D302E353532332C2D302E343437372C2D312C2D31
                2C2D31682D312E3776313168312E3763302E353532332C302C312C2D302E3434
                37372C312C2D314332312E322C31372E343437372C32302E373532332C31372C
                32302E322C31377A222066696C6C2D72756C653D226576656E6F646422206669
                6C6C3D222332343238324422206F7061636974793D22302E3038222F3E0D0A09
                09093C2F673E0D0A3C7061746820643D224D32332C32312E3433373563302C30
                2E333130372C2D302E323531382C302E353632352C2D302E353632352C302E35
                36323548312E35363235632D302E333130372C302C2D302E353632352C2D302E
                323531382C2D302E353632352C2D302E35363235762D302E33373563302C2D30
                2E333130372C302E323531382C2D302E353632352C302E353632352C2D302E35
                3632356832302E38373563302E333130372C302C302E353632352C302E323531
                382C302E353632352C302E353632355632312E343337357A222066696C6C2D72
                756C653D226576656E6F6464222066696C6C3D2223384539343943222F3E0D0A
                3C7061746820643D224D32322E312C31392E3933373563302C302E333130372C
                2D302E323531382C302E353632352C2D302E353632352C302E3536323548322E
                35363235632D302E333130372C302C2D302E353632352C2D302E323531382C2D
                302E353632352C2D302E35363235762D302E33373563302C2D302E333130372C
                302E323531382C2D302E353632352C302E353632352C2D302E35363235683138
                2E39373563302E333130372C302C302E353632352C302E323531382C302E3536
                32352C302E353632355631392E393337357A222066696C6C2D72756C653D2265
                76656E6F6464222066696C6C3D2223384539343943222F3E0D0A3C6720786D6C
                3A73706163653D227072657365727665223E262331333B262331303B3C706174
                6820643D224D31322E343135332C312E313936366C31302E313930392C352E35
                3330394332332E313632372C372E3032342C32322E393832322C382C32322E33
                3730382C3848312E36313838632D302E36312C302C2D302E373931382C2D302E
                393732372C2D302E323337362C2D312E323731334C31312E343535372C312E31
                39394331312E373630312C312E3033352C31322E313130332C312E303334312C
                31322E343135332C312E313936367A222066696C6C2D72756C653D226576656E
                6F6464222066696C6C3D2223384539343943222F3E0D0A3C636972636C652063
                783D223132222063793D22342E392220723D22312E36222066696C6C2D72756C
                653D226576656E6F6464222066696C6C3D2223453645394545222F3E0D0A0909
                093C2F673E0D0A3C7061746820643D224D32322E343337352C32302E35682D30
                2E3963302E333130372C302C302E353632352C2D302E323531382C302E353632
                352C2D302E35363235762D302E33373563302C2D302E333130372C2D302E3235
                31382C2D302E353632352C2D302E353632352C2D302E353632354832302E3263
                302E353532332C302C312C2D302E343437372C312C2D3163302C2D302E353532
                332C2D302E343437372C2D312C2D312C2D31682D302E32762D3768302E326330
                2E353532332C302C312C2D302E343437372C312C2D3163302C2D302E35353233
                2C2D302E343437372C2D312C2D312C2D3168322E3137303863302E363131342C
                302C302E373931392C2D302E3937362C302E323335342C2D312E323732354C31
                322E343135332C312E31393636632D302E313332342C2D302E303730352C2D30
                2E323733332C2D302E333038342C2D302E343135332C302E3138323656323268
                31302E3433373563302E333130372C302C302E353632352C2D302E323531382C
                302E353632352C2D302E35363235762D302E3337354332332C32302E37353138
                2C32322E373438322C32302E352C32322E343337352C32302E357A222066696C
                6C2D72756C653D226576656E6F6464222066696C6C3D22233234323832442220
                6F7061636974793D22302E3036222F3E0D0A09093C2F673E0D0A093C2F673E0D
                0A3C2F7376673E0D0A}
              Properties.Center = False
              Properties.FitMode = ifmProportionalStretch
              Properties.ReadOnly = True
              Properties.ShowFocusRect = False
              Style.BorderStyle = ebsNone
              Style.HotTrack = False
              Style.ReadOnly = False
              StyleFocused.BorderStyle = ebsNone
              StyleHot.BorderStyle = ebsNone
              TabOrder = 7
              Transparent = True
              Height = 231
              Width = 32
            end
            object Registro_LibroCtrl: TcxDBTextEdit
              Left = 156
              Top = 29
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DataBinding.DataField = 'Registro_Libro'
              DataBinding.DataSource = DataSource
              TabOrder = 0
              Width = 189
            end
            object cxLabel13: TcxLabel
              Left = 8
              Top = 33
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Libro'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 8
              Transparent = True
            end
            object cxLabel14: TcxLabel
              Left = 8
              Top = 61
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Registro mercantil'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 9
              Transparent = True
            end
            object Registro_RegistroMercantilCtrl: TcxDBTextEdit
              Tag = 1
              Left = 156
              Top = 56
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DataBinding.DataField = 'Registro_RegistroMercantil'
              DataBinding.DataSource = DataSource
              TabOrder = 1
              Width = 189
            end
            object cxLabel15: TcxLabel
              Left = 8
              Top = 87
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Hoja'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 10
              Transparent = True
            end
            object Registro_HojaCtrl: TcxDBTextEdit
              Left = 156
              Top = 83
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DataBinding.DataField = 'Registro_Hoja'
              DataBinding.DataSource = DataSource
              TabOrder = 2
              Width = 189
            end
            object cxLabel16: TcxLabel
              Left = 8
              Top = 114
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Folio'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 11
              Transparent = True
            end
            object Registro_FolioCtrl: TcxDBTextEdit
              Left = 156
              Top = 110
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DataBinding.DataField = 'Registro_Folio'
              DataBinding.DataSource = DataSource
              TabOrder = 3
              Width = 189
            end
            object cxLabel17: TcxLabel
              Left = 8
              Top = 141
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Secci'#243'n'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 12
              Transparent = True
            end
            object Registro_SeccionCtrl: TcxDBTextEdit
              Left = 156
              Top = 137
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DataBinding.DataField = 'Registro_Seccion'
              DataBinding.DataSource = DataSource
              TabOrder = 4
              Width = 189
            end
            object cxLabel18: TcxLabel
              Left = 8
              Top = 167
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Tomo'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 13
              Transparent = True
            end
            object Registro_TomoCtrl: TcxDBTextEdit
              Left = 156
              Top = 164
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DataBinding.DataField = 'Registro_Tomo'
              DataBinding.DataSource = DataSource
              TabOrder = 5
              Width = 189
            end
            object cxLabel19: TcxLabel
              Left = 8
              Top = 195
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Caption = 'Otros datos'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 14
              Transparent = True
            end
            object Registro_OtrosDatosCtrl: TcxDBTextEdit
              Left = 156
              Top = 191
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              DataBinding.DataField = 'Registro_OtrosDatos'
              DataBinding.DataSource = DataSource
              TabOrder = 6
              Width = 189
            end
          end
        end
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = EmpresaTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = NombreCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 352
    Top = 4
  end
  object EmpresaTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    AfterEdit = EmpresaTableAfterEdit
    BeforePost = EmpresaTableBeforePost
    AfterPost = EmpresaTableAfterPost
    BeforeDelete = EmpresaTableBeforeDelete
    OnNewRecord = EmpresaTableNewRecord
    TableName = 'Empresa'
    IndexFieldNames = 'Codigo'
    AutoIncFieldName = 'Codigo'
    OnGetRecord = EmpresaTableGetRecord
    OnUpdateState = EmpresaTableUpdateState
    Left = 318
    Top = 4
  end
  object DataSource: TDataSource
    DataSet = EmpresaTable
    Left = 288
    Top = 4
  end
end
