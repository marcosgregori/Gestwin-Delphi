object MntCliForm: TMntCliForm
  Left = 379
  Top = 262
  HelpType = htKeyword
  HelpKeyword = 'a_cli'
  ActiveControl = CloseButton
  BorderStyle = bsDialog
  Caption = 'Clientes'
  ClientHeight = 571
  ClientWidth = 890
  Color = clBtnFace
  Constraints.MinHeight = 20
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
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
    Height = 36
    Width = 890
    object CodigoCtrl: TcxDBTextEdit
      Left = 151
      Top = 6
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = ClienteDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 0
      Width = 46
    end
    object codigoCtrlCaption: TcxLabel
      Left = 18
      Top = 9
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
    Top = 535
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      890
      36)
    Height = 36
    Width = 890
    object ButtonsContainerPanel: TcxGroupBox
      Left = 256
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 377
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 85
        Height = 32
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
      object DocumentosExternosButton: TgBitBtn
        AlignWithMargins = True
        Left = 280
        Top = 2
        Width = 95
        Height = 32
        Hint = 'Abrir la carpeta de documentos externos del cliente'
        Margins.Left = 8
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Caption = 'Doc. e&xtern.'
        Enabled = True
        OptionsImage.ImageIndex = 22
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 2
        OptionsImage.Spacing = 2
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = DocumentosExternosButtonClick
        GlyphBitmap = gmFolderOpen
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
    Height = 499
    Width = 880
    object PageControl: TcxPageControl
      Left = 2
      Top = 2
      Width = 876
      Height = 495
      Align = alClient
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = DatosGeneralesTabSheet
      Properties.CustomButtons.Buttons = <>
      Properties.Options = [pcoGradient, pcoGradientClientArea, pcoRedrawOnResize]
      OnChange = PageControlChange
      ClientRectBottom = 491
      ClientRectLeft = 4
      ClientRectRight = 872
      ClientRectTop = 28
      object DatosGeneralesTabSheet: TcxTabSheet
        Caption = 'Datos &generales'
        object GeneralScrollBox: TcxScrollBox
          Left = 0
          Top = 0
          Width = 868
          Height = 463
          Align = alClient
          BorderStyle = cxcbsNone
          LookAndFeel.ScrollbarMode = sbmClassic
          TabOrder = 0
          Transparent = True
          object GeneralTopPanel: TcxGroupBox
            Left = 0
            Top = 0
            Align = alTop
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 0
            Transparent = True
            DesignSize = (
              868
              224)
            Height = 224
            Width = 868
            object NombreCtrl: TcxDBTextEdit
              Left = 140
              Top = 8
              DataBinding.DataField = 'Nombre'
              DataBinding.DataSource = ClienteDataSource
              Properties.Required = True
              TabOrder = 0
              Width = 396
            end
            object DomicilioCtrl: TcxDBTextEdit
              Left = 140
              Top = 35
              DataBinding.DataField = 'Domicilio'
              DataBinding.DataSource = ClienteDataSource
              TabOrder = 1
              Width = 396
            end
            object LocalidadCtrl: TcxDBTextEdit
              Left = 140
              Top = 62
              DataBinding.DataField = 'Localidad'
              DataBinding.DataSource = ClienteDataSource
              TabOrder = 2
              Width = 260
            end
            object TelefonoCtrl: TcxDBTextEdit
              Left = 140
              Top = 170
              DataBinding.DataField = 'Telefono'
              DataBinding.DataSource = ClienteDataSource
              TabOrder = 8
              Width = 151
            end
            object FaxCtrl: TcxDBTextEdit
              Left = 293
              Top = 170
              DataBinding.DataField = 'Fax'
              DataBinding.DataSource = ClienteDataSource
              TabOrder = 9
              Width = 151
            end
            object NIFCtrl: TcxDBTextEdit
              Left = 140
              Top = 143
              DescriptionLabel = DescNIF
              DataBinding.DataField = 'NIF'
              DataBinding.DataSource = ClienteDataSource
              Properties.CharCase = ecUpperCase
              Properties.ExpandZeroes = False
              Properties.OnValidate = NIFCtrlPropertiesValidate
              TabOrder = 6
              Width = 116
            end
            object PaisCtrl: TcxDBTextEdit
              Left = 140
              Top = 89
              DescriptionLabel = DescPaisLabel
              DataBinding.DataField = 'CodigoPais'
              DataBinding.DataSource = ClienteDataSource
              Properties.Required = True
              Properties.OnEnter = PaisCtrlPropertiesEnter
              Properties.OnQueryRequest = PaisCtrlPropertiesQueryRequest
              Properties.OnEditRequest = PaisCtrlPropertiesEditRequest
              Properties.OnValuePosted = PaisCtrlPropertiesValuePosted
              Properties.TextEditPad = tpLeftZero
              Properties.PadAlways = True
              Properties.OnValidate = PaisCtrlPropertiesValidate
              TabOrder = 3
              Width = 32
            end
            object CodigoProvinciaCtrl: TcxDBTextEdit
              Left = 140
              Top = 116
              CaptionLabel = ProvinciaCaptionLabel
              DescriptionLabel = DescCPLabel
              DataBinding.DataField = 'CodigoProvincia'
              DataBinding.DataSource = ClienteDataSource
              Properties.OnQueryRequest = CodigoProvinciaCtrlPropertiesQueryRequest
              Properties.OnEditRequest = CodigoProvinciaCtrlPropertiesEditRequest
              Properties.TextEditPad = tpLeftZero
              Properties.OnEditValueChanged = CodigoProvinciaCtrlPropertiesEditValueChanged
              Properties.OnValidate = CodigoProvinciaCtrlPropertiesValidate
              TabOrder = 4
              Width = 25
            end
            object CodigoPostalCtrl: TcxDBTextEdit
              Left = 167
              Top = 116
              DescriptionLabel = DescCPLabel
              DataBinding.DataField = 'CodigoPostal'
              DataBinding.DataSource = ClienteDataSource
              Properties.OnQueryRequest = CodigoPostalCtrlPropertiesQueryRequest
              Properties.OnEditRequest = CodigoPostalCtrlPropertiesEditRequest
              Properties.TextEditPad = tpLeftZero
              Properties.OnValidate = CodigoPostalCtrlPropertiesValidate
              TabOrder = 5
              Width = 35
            end
            object EMailCtrl: TcxDBTextEdit
              Left = 140
              Top = 197
              DataBinding.DataField = 'EMail'
              DataBinding.DataSource = ClienteDataSource
              Properties.OnValidate = EMailCtrlPropertiesValidate
              TabOrder = 10
              Width = 396
            end
            object Label19: TcxLabel
              Left = 9
              Top = 11
              TabStop = False
              Caption = 'Nombre'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 12
              Transparent = True
            end
            object Label6: TcxLabel
              Left = 9
              Top = 38
              TabStop = False
              Caption = 'Domicilio'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 13
              Transparent = True
            end
            object Label7: TcxLabel
              Left = 9
              Top = 65
              TabStop = False
              Caption = 'Localidad'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 14
              Transparent = True
            end
            object Label8: TcxLabel
              Left = 9
              Top = 92
              TabStop = False
              Caption = 'Pais'
              Style.ReadOnly = False
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 15
              Transparent = True
            end
            object DescPaisLabel: TcxLabel
              Left = 261
              Top = 92
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 16
              Transparent = True
              Height = 19
              Width = 596
            end
            object Label9: TcxLabel
              Left = 9
              Top = 173
              TabStop = False
              Caption = 'Tel'#233'fono / Fax'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 17
              Transparent = True
            end
            object Label10: TcxLabel
              Left = 9
              Top = 200
              TabStop = False
              Caption = 'Direcci'#243'n de correo'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 18
              Transparent = True
            end
            object NIFLabel: TcxLabel
              Left = 9
              Top = 146
              TabStop = False
              Caption = 'N.I.F.'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 19
              Transparent = True
            end
            object ProvinciaCaptionLabel: TcxLabel
              Left = 9
              Top = 119
              TabStop = False
              Caption = 'Provincia / C.P.'
              Style.ReadOnly = True
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 20
              Transparent = True
            end
            object DescCPLabel: TcxLabel
              Left = 261
              Top = 119
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 21
              Transparent = True
              Height = 19
              Width = 596
            end
            object DescNIF: TcxLabel
              Left = 261
              Top = 146
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 22
              Transparent = True
              Height = 19
              Width = 607
            end
            object EnviarCorreoBtn: TgBitBtn
              Left = 540
              Top = 195
              Width = 92
              Height = 29
              Caption = '&Redactar'
              Enabled = True
              OptionsImage.ImageIndex = 52
              OptionsImage.Images = ApplicationContainer.ButtonImageList
              OptionsImage.Margin = 4
              OptionsImage.Spacing = 5
              TabOrder = 11
              OnClick = EnviarCorreoBtnClick
              GlyphBitmap = gmSendMail
            end
            object TipoIdentificacionCtrl: TcxDBIndexedComboBox
              Left = 259
              Top = 143
              DataBinding.DataField = 'TipoIdentificacion'
              DataBinding.DataSource = ClienteDataSource
              Properties.Alignment.Horz = taLeftJustify
              Properties.DropDownListStyle = lsFixedList
              Properties.DropDownRows = 16
              Properties.ImmediatePost = True
              Properties.Items.Strings = (
                'N.I.F.-I.V.A.'
                'Pasaporte'
                
                  'Doc. oficial de identif. expedido por el pais o territorio de re' +
                  'sidencia'
                'Certificado de residencia'
                'Otro documento probatorio')
              TabOrder = 7
              Width = 412
            end
          end
          object GeneralBottomPanel: TcxGroupBox
            Left = 0
            Top = 224
            Align = alTop
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 1
            Transparent = True
            DesignSize = (
              868
              163)
            Height = 163
            Width = 868
            object SubcuentaCtrl: TcxDBTextEdit
              Left = 140
              Top = 0
              DescriptionLabel = DescSubcuentaLabel
              DataBinding.DataField = 'Subcuenta'
              DataBinding.DataSource = ClienteDataSource
              Properties.Required = True
              Properties.OnEnter = SubcuentaCtrlPropertiesEnter
              Properties.OnQueryRequest = CuentaCtrlPropertiesQueryRequest
              Properties.OnEditRequest = CuentaCtrlPropertiesEditRequest
              Properties.TextEditPad = tpRightZero
              Properties.PadAlways = True
              Properties.OnEditValueChanged = SubcuentaCtrlPropertiesEditValueChanged
              Properties.OnValidate = CuentaCtrlPropertiesValidate
              TabOrder = 0
              Width = 74
            end
            object Factura_MonedaCtrl: TcxDBIndexedComboBox
              Left = 140
              Top = 27
              DataBinding.DataField = 'Factura_Moneda'
              DataBinding.DataSource = ClienteDataSource
              Properties.Alignment.Horz = taLeftJustify
              Properties.DropDownListStyle = lsFixedList
              Properties.ImmediatePost = True
              Properties.Items.Strings = (
                'Euros'
                'Divisa')
              Properties.OnChange = Factura_MonedaCtrlPropertiesChange
              Properties.OnValidate = Factura_MonedaCtrlPropertiesValidate
              TabOrder = 1
              Width = 101
            end
            object CodigoDivisaCtrl: TcxDBTextEdit
              Left = 140
              Top = 54
              DescriptionLabel = DescCodigoDivisaLabel
              DataBinding.DataField = 'CodigoDivisa'
              DataBinding.DataSource = ClienteDataSource
              Properties.OnQueryRequest = CodigoDivisaCtrlPropertiesQueryRequest
              Properties.OnEditRequest = CodigoDivisaCtrlPropertiesEditRequest
              Properties.OnValidate = CodigoDivisaCtrlPropertiesValidate
              TabOrder = 2
              Width = 32
            end
            object FechaAltaCtrl: TcxDBDateEdit
              Left = 140
              Top = 81
              DataBinding.DataField = 'FechaAlta'
              DataBinding.DataSource = ClienteDataSource
              Properties.Required = True
              Properties.OnEnter = FechaAltaCtrlPropertiesEnter
              Properties.DateButtons = [btnClear, btnToday]
              Properties.DateOnError = deToday
              TabOrder = 3
              Width = 100
            end
            object Label27: TcxLabel
              Left = 9
              Top = 3
              TabStop = False
              Caption = 'Subcuenta'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 7
              Transparent = True
            end
            object DescSubcuentaLabel: TcxLabel
              Left = 261
              Top = 3
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 8
              Transparent = True
              Height = 19
              Width = 596
            end
            object Label25: TcxLabel
              Left = 9
              Top = 31
              TabStop = False
              Caption = 'Moneda'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 9
              Transparent = True
            end
            object capCodigoDivisaLabel: TcxLabel
              Left = 9
              Top = 55
              TabStop = False
              Caption = 'C'#243'digo de divisa'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 10
              Transparent = True
            end
            object DescCodigoDivisaLabel: TcxLabel
              Left = 261
              Top = 55
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 11
              Transparent = True
              Height = 19
              Width = 596
            end
            object Label42: TcxLabel
              Left = 9
              Top = 84
              TabStop = False
              Caption = 'Fecha de alta'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 12
              Transparent = True
            end
            object ObsoletoCtrl: TcxDBCheckBox
              Left = 6
              Top = 137
              AutoSize = False
              Caption = 'Obsoleto'
              DataBinding.DataField = 'Obsoleto'
              DataBinding.DataSource = ClienteDataSource
              Properties.Alignment = taRightJustify
              Properties.NullStyle = nssUnchecked
              TabOrder = 6
              Transparent = True
              Height = 21
              Width = 152
            end
            object cxLabel8: TcxLabel
              Left = 9
              Top = 111
              TabStop = False
              Caption = 'Documentos externos'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 13
              Transparent = True
            end
            object DocumentosExternosCtrl: TcxDBTextEdit
              Left = 140
              Top = 108
              Hint = 
                'Indique el camino (path) al directorio de los documentos del cli' +
                'ente. Si est'#225' en un entorno de red debe utilizar paths UNC, del ' +
                'tipo \\Servidor\Carpeta, para que sea accesible desde cualquier ' +
                'puesto de trabajo.'
              DataBinding.DataField = 'DocumentosExternos'
              DataBinding.DataSource = ClienteDataSource
              Properties.OnValidate = DocumentosExternosCtrlPropertiesValidate
              TabOrder = 4
              Width = 396
            end
            object ExaminarButton: TgBitBtn
              Left = 540
              Top = 106
              Width = 92
              Height = 29
              Caption = 'Exa&minar'
              Enabled = True
              OptionsImage.ImageIndex = 23
              OptionsImage.Images = ApplicationContainer.ButtonImageList
              OptionsImage.Margin = 4
              OptionsImage.Spacing = 5
              TabOrder = 5
              OnClick = ExaminarButtonClick
              GlyphBitmap = gmFolderBrowser
            end
          end
          object TiendaVirtualPanel: TcxGroupBox
            Left = 0
            Top = 387
            Align = alTop
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 2
            Transparent = True
            Height = 29
            Width = 868
            object TiendaVirtualCtrl: TcxDBCheckBox
              Left = 6
              Top = 0
              AutoSize = False
              Caption = 'Cliente tienda virtual'
              DataBinding.DataField = 'TiendaVirtual'
              DataBinding.DataSource = ClienteDataSource
              Properties.Alignment = taRightJustify
              Properties.MultiLine = True
              Properties.NullStyle = nssUnchecked
              Properties.OnEditValueChanged = TiendaVirtualCtrlPropertiesEditValueChanged
              TabOrder = 0
              Transparent = True
              Height = 25
              Width = 152
            end
          end
        end
      end
      object EnviosTabSheet: TcxTabSheet
        Caption = '&Env'#237'os'
        TabVisible = False
        object EnviosScrollBox: TcxScrollBox
          Left = 0
          Top = 0
          Width = 868
          Height = 463
          Align = alClient
          BorderStyle = cxcbsNone
          LookAndFeel.ScrollbarMode = sbmClassic
          TabOrder = 0
          Transparent = True
        end
      end
      object FacturacionTabSheet: TcxTabSheet
        Caption = '&Facturaci'#243'n'
        object ModeloImpositivoPanel: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Transparent = True
          DesignSize = (
            868
            61)
          Height = 61
          Width = 868
          object Factura_ModeloIVACtrl: TcxDBIndexedComboBox
            Left = 141
            Top = 7
            DataBinding.DataField = 'Factura_ModeloIVA'
            DataBinding.DataSource = ClienteDataSource
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.ImmediatePost = True
            Properties.Items.Strings = (
              'Exento de I.V.A.'
              'Sin recargo de equivalencia'
              'Con recargo de equivalencia'
              'Tipo fijo de I.V.A.')
            Properties.OnChange = Factura_ModeloIVACtrlPropertiesEditValueChange
            Properties.OnValidate = Factura_ModeloIVACtrlPropertiesValidate
            TabOrder = 0
            Width = 212
          end
          object Factura_TipoFijoIVACtrl: TcxDBSpinEdit
            Left = 430
            Top = 7
            DescriptionLabel = DescTipoFijoLabel
            DataBinding.DataField = 'Factura_TipoFijoIVA'
            DataBinding.DataSource = ClienteDataSource
            Properties.OnQueryRequest = Factura_TipoFijoIVACtrlPropertiesQueryRequest
            Properties.OnEditRequest = Factura_TipoFijoIVACtrlPropertiesEditRequest
            Properties.AssignedValues.MinValue = True
            Properties.DisplayFormat = '#'
            Properties.EditFormat = '#'
            Properties.ImmediatePost = True
            Properties.MaxValue = 24.000000000000000000
            Properties.OnValidate = Factura_TipoFijoIVACtrlPropertiesValidate
            TabOrder = 1
            Width = 58
          end
          object Factura_TipoRetCtrl: TcxDBSpinEdit
            Left = 140
            Top = 35
            DescriptionLabel = DescRetencionLabel
            DataBinding.DataField = 'Factura_TipoRet'
            DataBinding.DataSource = ClienteDataSource
            Properties.OnQueryRequest = Factura_TipoRetCtrlPropertiesQueryRequest
            Properties.OnEditRequest = Factura_TipoRetCtrlPropertiesEditRequest
            Properties.AssignedValues.MinValue = True
            Properties.DisplayFormat = '#'
            Properties.EditFormat = '#'
            Properties.ImmediatePost = True
            Properties.MaxValue = 12.000000000000000000
            Properties.OnValidate = Factura_TipoRetCtrlPropertiesValidate
            TabOrder = 2
            Width = 59
          end
          object Label13: TcxLabel
            Left = 10
            Top = 10
            TabStop = False
            Caption = 'Modelo impositivo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
          end
          object capTipoFijoLabel: TcxLabel
            Left = 370
            Top = 11
            TabStop = False
            Caption = 'Tipo fijo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
          end
          object DescTipoFijoLabel: TcxLabel
            Left = 507
            Top = 11
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 5
            Transparent = True
            Height = 19
            Width = 346
          end
          object capRetencionLabel: TcxLabel
            Left = 9
            Top = 38
            TabStop = False
            Caption = 'Tipo de retenci'#243'n'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 6
            Transparent = True
          end
          object DescRetencionLabel: TcxLabel
            Left = 244
            Top = 38
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 7
            Transparent = True
            Height = 19
            Width = 469
          end
        end
      end
      object CobrosTabSheet: TcxTabSheet
        Caption = 'C&obros'
        object cxScrollBox1: TcxScrollBox
          Left = 0
          Top = 0
          Width = 868
          Height = 463
          Align = alClient
          BorderStyle = cxcbsNone
          LookAndFeel.ScrollbarMode = sbmClassic
          TabOrder = 0
          Transparent = True
          object CCCPanel: TcxGroupBox
            Left = 0
            Top = 251
            Align = alTop
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 1
            Transparent = True
            DesignSize = (
              868
              27)
            Height = 27
            Width = 868
            object Cobro_CodigoEntidadCtrl: TcxDBTextEdit
              Left = 178
              Top = 1
              DescriptionLabel = cxLabel3
              DataBinding.DataField = 'Cobro_CodigoEntidad'
              DataBinding.DataSource = ClienteDataSource
              Properties.OnQueryRequest = Cobro_CodigoEntidadCtrlPropertiesQueryRequest
              Properties.OnEditRequest = Cobro_CodigoEntidadCtrlPropertiesEditRequest
              Properties.OnValuePosted = Cobro_CodigoEntidadCtrlPropertiesValuePosted
              Properties.TextEditPad = tpLeftZero
              Properties.OnValidate = Cobro_CodigoEntidadCtrlPropertiesValidate
              TabOrder = 1
              Width = 39
            end
            object Cobro_CodigoSucursalCtrl: TcxDBTextEdit
              Left = 219
              Top = 1
              DataBinding.DataField = 'Cobro_CodigoSucursal'
              DataBinding.DataSource = ClienteDataSource
              Properties.OnExtendedFunction = Cobro_DCCtrlPropertiesExtendedFunction
              Properties.TextEditPad = tpLeftZero
              Properties.OnValidate = Cobro_CCCPropertiesValidate
              TabOrder = 2
              Width = 39
            end
            object Cobro_CuentaCtrl: TcxDBTextEdit
              Left = 287
              Top = 1
              DataBinding.DataField = 'Cobro_Cuenta'
              DataBinding.DataSource = ClienteDataSource
              Properties.OnExtendedFunction = Cobro_DCCtrlPropertiesExtendedFunction
              Properties.TextEditPad = tpLeftZero
              Properties.OnValidate = Cobro_CCCPropertiesValidate
              TabOrder = 4
              Width = 78
            end
            object Cobro_DCCtrl: TcxDBTextEdit
              Left = 260
              Top = 1
              DataBinding.DataField = 'Cobro_DC'
              DataBinding.DataSource = ClienteDataSource
              Properties.OnExtendedFunction = Cobro_DCCtrlPropertiesExtendedFunction
              Properties.TextEditPad = tpLeftZero
              Properties.OnValidate = Cobro_CCCPropertiesValidate
              TabOrder = 3
              Width = 25
            end
            object Label29: TcxLabel
              Left = 9
              Top = 5
              TabStop = False
              Caption = 'IBAN / C.C.C.'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 5
              Transparent = True
            end
            object cxLabel3: TcxLabel
              Left = 399
              Top = 4
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 6
              Transparent = True
              Height = 17
              Width = 462
            end
            object DCIBANCtrl: TcxTextEdit
              Left = 140
              Top = 1
              TabStop = False
              Properties.ReadOnly = True
              Style.TextColor = clNavy
              TabOrder = 0
              Width = 36
            end
          end
          object CobrosPanel: TcxGroupBox
            Left = 0
            Top = 0
            Align = alTop
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 0
            Transparent = True
            DesignSize = (
              868
              251)
            Height = 251
            Width = 868
            object Cobro_NombreCtrl: TcxDBTextEdit
              Left = 140
              Top = 8
              DataBinding.DataField = 'Cobro_Nombre'
              DataBinding.DataSource = ClienteDataSource
              TabOrder = 0
              Width = 396
            end
            object Cobro_DomicilioCtrl: TcxDBTextEdit
              Left = 140
              Top = 35
              DataBinding.DataField = 'Cobro_Domicilio'
              DataBinding.DataSource = ClienteDataSource
              TabOrder = 1
              Width = 396
            end
            object Cobro_LocalidadCtrl: TcxDBTextEdit
              Left = 140
              Top = 62
              DataBinding.DataField = 'Cobro_Localidad'
              DataBinding.DataSource = ClienteDataSource
              TabOrder = 2
              Width = 260
            end
            object Cobro_CodigoPostalCtrl: TcxDBTextEdit
              Left = 166
              Top = 89
              DescriptionLabel = DescCPCobroLabel
              DataBinding.DataField = 'Cobro_CodigoPostal'
              DataBinding.DataSource = ClienteDataSource
              Properties.OnQueryRequest = Cobro_CodigoPostalCtrlPropertiesQueryRequest
              Properties.OnEditRequest = Cobro_CodigoPostalCtrlPropertiesEditRequest
              Properties.TextEditPad = tpLeftZero
              Properties.OnValidate = Cobro_CodigoPostalCtrlPropertiesValidate
              TabOrder = 4
              Width = 35
            end
            object Cobro_FormaCobroCtrl: TcxDBTextEdit
              Left = 140
              Top = 116
              DescriptionLabel = DescFormaCobroLabel
              DataBinding.DataField = 'Cobro_FormaCobro'
              DataBinding.DataSource = ClienteDataSource
              Properties.Required = True
              Properties.OnQueryRequest = Cobro_FormaCobroCtrlPropertiesQueryRequest
              Properties.OnEditRequest = Cobro_FormaCobroCtrlPropertiesEditRequest
              Properties.TextEditPad = tpLeftZero
              Properties.PadAlways = True
              Properties.OnValidate = Cobro_FormaCobroCtrlPropertiesValidate
              TabOrder = 5
              Width = 25
            end
            object Cobro_EntidadCtrl: TcxDBTextEdit
              Left = 140
              Top = 198
              DataBinding.DataField = 'Cobro_Entidad'
              DataBinding.DataSource = ClienteDataSource
              TabOrder = 9
              Width = 226
            end
            object Cobro_SucursalCtrl: TcxDBTextEdit
              Left = 140
              Top = 225
              DataBinding.DataField = 'Cobro_Sucursal'
              DataBinding.DataSource = ClienteDataSource
              TabOrder = 10
              Width = 226
            end
            object Cobro_CodigoProvCtrl: TcxDBTextEdit
              Left = 140
              Top = 89
              CaptionLabel = CobrosProvinciaCaptionLabel
              DescriptionLabel = DescCPCobroLabel
              DataBinding.DataField = 'Cobro_CodigoProv'
              DataBinding.DataSource = ClienteDataSource
              Properties.OnQueryRequest = CodigoProvinciaCtrlPropertiesQueryRequest
              Properties.OnEditRequest = CodigoProvinciaCtrlPropertiesEditRequest
              Properties.TextEditPad = tpLeftZero
              Properties.OnEditValueChanged = Cobro_CodigoProvCtrlPropertiesEditValueChanged
              Properties.OnValidate = CodigoProvinciaCtrlPropertiesValidate
              TabOrder = 3
              Width = 25
            end
            object Cobro_MesNoCobroCtrl: TcxDBIndexedComboBox
              Left = 140
              Top = 171
              DataBinding.DataField = 'Cobro_MesNoCobro'
              DataBinding.DataSource = ClienteDataSource
              Properties.Alignment.Horz = taLeftJustify
              Properties.DropDownListStyle = lsFixedList
              Properties.Items.Strings = (
                '(Ninguno)'
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
              TabOrder = 8
              Width = 145
            end
            object Cobro_DiaCobro1Ctrl: TcxDBSpinEdit
              Left = 140
              Top = 143
              DataBinding.DataField = 'Cobro_DiaCobro1'
              DataBinding.DataSource = ClienteDataSource
              Properties.AssignedValues.MinValue = True
              Properties.DisplayFormat = '#'
              Properties.EditFormat = '#'
              Properties.ImmediatePost = True
              Properties.MaxValue = 31.000000000000000000
              Properties.OnChange = Cobro_DiaCobro1CtrlPropertiesChange
              Properties.OnEditValueChanged = Cobro_DiaCobro1CtrlPropertiesChange
              Properties.OnValidate = Cobro_DiaCobro1CtrlPropertiesValidate
              TabOrder = 6
              Width = 60
            end
            object Cobro_DiaCobro2Ctrl: TcxDBSpinEdit
              Left = 220
              Top = 143
              DataBinding.DataField = 'Cobro_DiaCobro2'
              DataBinding.DataSource = ClienteDataSource
              Enabled = False
              Properties.AssignedValues.MinValue = True
              Properties.DisplayFormat = '#'
              Properties.EditFormat = '#'
              Properties.ImmediatePost = True
              Properties.MaxValue = 31.000000000000000000
              TabOrder = 7
              Width = 60
            end
            object Label16: TcxLabel
              Left = 9
              Top = 12
              TabStop = False
              Caption = 'Nombre'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 11
              Transparent = True
            end
            object Label17: TcxLabel
              Left = 9
              Top = 39
              TabStop = False
              Caption = 'Domicilio'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 12
              Transparent = True
            end
            object Label18: TcxLabel
              Left = 9
              Top = 66
              TabStop = False
              Caption = 'Localidad'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 13
              Transparent = True
            end
            object CobrosProvinciaCaptionLabel: TcxLabel
              Left = 9
              Top = 92
              TabStop = False
              Caption = 'Provincia / C.P.'
              Style.ReadOnly = True
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 14
              Transparent = True
            end
            object DescCPCobroLabel: TcxLabel
              Left = 260
              Top = 92
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 15
              Transparent = True
              Height = 19
              Width = 578
            end
            object Label21: TcxLabel
              Left = 9
              Top = 120
              TabStop = False
              Caption = 'Forma de cobro'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 16
              Transparent = True
            end
            object DescFormaCobroLabel: TcxLabel
              Left = 260
              Top = 119
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 17
              Transparent = True
              Height = 19
              Width = 578
            end
            object Label26: TcxLabel
              Left = 9
              Top = 196
              TabStop = False
              Caption = 'Entidad'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 18
              Transparent = True
            end
            object Label28: TcxLabel
              Left = 9
              Top = 226
              TabStop = False
              Caption = 'Sucursal'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 19
              Transparent = True
            end
            object Label22: TcxLabel
              Left = 9
              Top = 147
              TabStop = False
              Caption = 'D'#237'as de cobro'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 20
              Transparent = True
            end
            object Label23: TcxLabel
              Left = 207
              Top = 147
              TabStop = False
              Caption = 'y'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 21
              Transparent = True
            end
            object Label24: TcxLabel
              Left = 9
              Top = 175
              TabStop = False
              Caption = 'Mes de no cobro'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 22
              Transparent = True
            end
          end
          object IBANPanel: TcxGroupBox
            Left = 0
            Top = 278
            Align = alTop
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 2
            Transparent = True
            Height = 54
            Width = 868
            object Cobro_IBANCtrl: TcxDBTextEdit
              Left = 140
              Top = 28
              DataBinding.DataField = 'Cobro_IBAN'
              DataBinding.DataSource = ClienteDataSource
              Properties.OnValidate = Cobro_IBANCtrlPropertiesValidate
              TabOrder = 1
              Width = 396
            end
            object cxLabel7: TcxLabel
              Left = 9
              Top = 30
              TabStop = False
              Caption = 'IBAN'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 2
              Transparent = True
            end
            object cxLabel9: TcxLabel
              Left = 9
              Top = 5
              TabStop = False
              Caption = 'BIC'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 3
              Transparent = True
            end
            object Cobro_BICCtrl: TcxDBTextEdit
              Left = 140
              Top = 1
              DataBinding.DataField = 'Cobro_BIC'
              DataBinding.DataSource = ClienteDataSource
              TabOrder = 0
              Width = 90
            end
          end
          object MandatoPanel: TcxGroupBox
            Left = 0
            Top = 332
            Align = alTop
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 3
            Transparent = True
            DesignSize = (
              868
              110)
            Height = 110
            Width = 868
            object Cobro_CodigoINEPlazaCtrl: TcxDBTextEdit
              Left = 140
              Top = 82
              DataBinding.DataField = 'Cobro_CodigoINEPlaza'
              DataBinding.DataSource = ClienteDataSource
              Properties.OnValidate = Cobro_CodigoINEPlazaCtrlPropertiesValidate
              TabOrder = 5
              Width = 74
            end
            object Cobro_CtaEntidadCtrl: TcxDBTextEdit
              Left = 140
              Top = 28
              DescriptionLabel = DescCanalLabel
              DataBinding.DataField = 'Cobro_CtaEntidad'
              DataBinding.DataSource = ClienteDataSource
              Properties.Required = True
              Properties.OnEnter = Cobro_CtaEntidadCtrlPropertiesEnter
              Properties.OnQueryRequest = CuentaCtrlPropertiesQueryRequest
              Properties.OnEditRequest = CuentaCtrlPropertiesEditRequest
              Properties.TextEditPad = tpRightZero
              Properties.PadAlways = True
              Properties.OnValidate = Cobro_CtaEntidadCtrlPropertiesValidate
              TabOrder = 3
              Width = 74
            end
            object Cobro_RiesgoLimiteCtrl: TcxDBCurrencyEdit
              Left = 140
              Top = 55
              DataBinding.DataField = 'Cobro_RiesgoLimite'
              DataBinding.DataSource = ClienteDataSource
              Properties.MaxLength = 9
              TabOrder = 4
              Width = 74
            end
            object Label32: TcxLabel
              Left = 9
              Top = 86
              TabStop = False
              Caption = 'C'#243'digo I.N.E.'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 6
              Transparent = True
            end
            object Label33: TcxLabel
              Left = 9
              Top = 32
              TabStop = False
              Caption = 'Canal preferente'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 7
              Transparent = True
            end
            object DescCanalLabel: TcxLabel
              Left = 232
              Top = 33
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 8
              Transparent = True
              Height = 19
              Width = 578
            end
            object Label3: TcxLabel
              Left = 9
              Top = 59
              TabStop = False
              Caption = 'Riesgo l'#237'mite'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 9
              Transparent = True
            end
            object Cobro_ReferenciaMandatoCtrl: TcxDBTextEdit
              Left = 140
              Top = 1
              DataBinding.DataField = 'Cobro_ReferenciaMandato'
              DataBinding.DataSource = ClienteDataSource
              Properties.OnExtendedFunction = Cobro_ReferenciaMandatoCtrlPropertiesExtendedFunction
              TabOrder = 0
              Width = 225
            end
            object cxLabel4: TcxLabel
              Left = 9
              Top = 4
              TabStop = False
              Caption = 'Referencia mandato'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 10
              Transparent = True
            end
            object cxLabel5: TcxLabel
              Left = 373
              Top = 4
              TabStop = False
              Caption = 'Fecha'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 11
              Transparent = True
            end
            object Cobro_FechaMandatoCtrl: TcxDBDateEdit
              Left = 416
              Top = 1
              DataBinding.DataField = 'Cobro_FechaMandato'
              DataBinding.DataSource = ClienteDataSource
              Properties.OnValuePosted = Cobro_FechaMandatoCtrlPropertiesValuePosted
              Properties.DateButtons = [btnClear, btnToday]
              Properties.DateOnError = deToday
              Properties.OnValidate = Cobro_FechaMandatoCtrlPropertiesValidate
              TabOrder = 1
              Width = 100
            end
            object cxLabel6: TcxLabel
              Left = 525
              Top = 5
              TabStop = False
              Caption = 'Ciclo'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 12
              Transparent = True
            end
            object Cobro_CicloMandatoCtrl: TcxDBIndexedComboBox
              Left = 567
              Top = 1
              Hint = 
                'Si el ciclo es "Recurrente" es porque ya se han pasado m'#225's '#243'rden' +
                'es de adeudo utilizando '#233'ste mandato, si es "Primero" es porque ' +
                'es la primera vez que se utiliza y "'#218'ltimo" si ser'#225' la '#250'ltima ve' +
                'z que se haga.'
              DataBinding.DataField = 'Cobro_CicloMandato'
              DataBinding.DataSource = ClienteDataSource
              Properties.Alignment.Horz = taLeftJustify
              Properties.DropDownListStyle = lsFixedList
              Properties.Items.Strings = (
                'Recurrente'
                'Primero'
                #218'ltimo')
              TabOrder = 2
              Width = 94
            end
          end
        end
      end
      object ContactosTabSheet: TcxTabSheet
        Caption = 'Contactos'
        ImageIndex = 5
        TabVisible = False
      end
      object TabSheet5: TcxTabSheet
        Caption = 'Co&ntactos y anotaciones'
        ImageIndex = 4
        object ContactosGroupBox: TcxGroupBox
          Left = 0
          Top = 18
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Transparent = True
          Height = 200
          Width = 868
          object Grid: TcxGrid
            Left = 2
            Top = 2
            Width = 826
            Height = 196
            Align = alClient
            TabOrder = 0
            object GridView: TcxGridDBTableView
              Tag = 263622736
              Navigator.Buttons.CustomButtons = <>
              ScrollbarAnnotations.CustomAnnotations = <>
              DataController.DataSource = DireccionContactoData
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <
                item
                  Kind = skSum
                  FieldName = 'Importe'
                end>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.PostponedSynchronization = False
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.FocusFirstCellOnNewRecord = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsBehavior.PullFocusing = True
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnHidingOnGrouping = False
              OptionsCustomize.ColumnHorzSizing = False
              OptionsCustomize.ColumnMoving = False
              OptionsCustomize.ColumnSorting = False
              OptionsData.Appending = True
              OptionsData.DeletingConfirmation = False
              OptionsSelection.InvertSelect = False
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              object GridViewNombre: TcxGridDBColumn
                DataBinding.FieldName = 'Nombre'
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.Required = True
                Width = 250
              end
              object GridViewCargo: TcxGridDBColumn
                DataBinding.FieldName = 'Cargo'
                Width = 180
              end
              object GridViewFijo: TcxGridDBColumn
                DataBinding.FieldName = 'Fijo'
                Width = 125
              end
              object GridViewMovil: TcxGridDBColumn
                Caption = 'M'#243'vil'
                DataBinding.FieldName = 'Movil'
                Width = 125
              end
              object GridViewFax: TcxGridDBColumn
                DataBinding.FieldName = 'Fax'
                Width = 125
              end
              object GridViewCorreo: TcxGridDBColumn
                DataBinding.FieldName = 'Correo'
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.OnValidate = GridViewCorreoPropertiesValidate
                Width = 250
              end
              object GridViewTipoDocumento: TcxGridDBColumn
                Caption = 'Documen.'
                DataBinding.FieldName = 'TipoDocumento'
                PropertiesClassName = 'TcxIndexedComboBoxProperties'
                Properties.Alignment.Horz = taLeftJustify
                Properties.DropDownListStyle = lsFixedList
                Properties.Items.Strings = (
                  'Ninguno'
                  'Presupuesto'
                  'Pedido'
                  'Albar'#225'n'
                  'Factura'
                  'Todos')
                HeaderHint = 'Documento asociado'
                Width = 100
              end
            end
            object GridLevel: TcxGridLevel
              GridView = GridView
            end
          end
          object TableViewManager: TGridTableViewController
            Left = 828
            Top = 2
            Align = alRight
            Enabled = False
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TransparentBorder = False
            TabOrder = 1
            TableView = GridView
            ShiftRecords = True
            UseGridFilterBox = False
            Height = 196
            Width = 38
          end
        end
        object cxGroupBox2: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 18
          Width = 868
          object cxLabel1: TcxLabel
            Left = 7
            Top = 2
            TabStop = False
            Caption = 'Contactos'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 0
            Transparent = True
          end
        end
        object cxGroupBox3: TcxGroupBox
          Left = 0
          Top = 226
          Align = alClient
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 2
          Transparent = True
          Height = 237
          Width = 868
          object cxLabel2: TcxLabel
            Left = 7
            Top = 3
            TabStop = False
            Caption = 'Anotaciones'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 0
            Transparent = True
          end
          inline TAnnotationFrame1: TAnnotationFrame
            Left = 2
            Top = 23
            Width = 864
            Height = 212
            Align = alBottom
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 1
            ExplicitLeft = 2
            ExplicitTop = 23
            ExplicitWidth = 864
            ExplicitHeight = 212
            inherited AnnotationPanel: TcxGroupBox
              ExplicitWidth = 864
              ExplicitHeight = 180
              Height = 180
              Width = 864
              inherited AnnotationRichEdit: TcxDBRichEdit
                DataBinding.DataField = 'Anotacion'
                DataBinding.DataSource = ClienteDataSource
                ExplicitWidth = 860
                ExplicitHeight = 135
                Height = 135
                Width = 860
              end
              inherited Ruler: TfrxRuler
                Width = 860
                ExplicitWidth = 860
              end
            end
            inherited ButtonsBar: TcxGroupBox
              ExplicitWidth = 864
              Width = 864
              inherited FontNameComboBox: TcxFontNameComboBox
                ExplicitHeight = 28
              end
              inherited FontSizeComboBox: TcxComboBox
                ExplicitHeight = 28
              end
            end
          end
        end
        object cxSplitter1: TcxSplitter
          Left = 0
          Top = 218
          Width = 868
          Height = 8
          AlignSplitter = salTop
          Control = ContactosGroupBox
        end
      end
      object AvisosTabSheet: TcxTabSheet
        Caption = 'A&visos'
        ImageIndex = 4
        object Panel1: TcxGroupBox
          Left = 0
          Top = 398
          Align = alBottom
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Transparent = True
          Height = 65
          Width = 868
          object BloqueadoCtrl: TcxDBCheckBox
            Left = 6
            Top = 27
            AutoSize = False
            Caption = 'Bloqueado'
            DataBinding.DataField = 'Bloqueado'
            DataBinding.DataSource = ClienteDataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            TabOrder = 1
            Transparent = True
            Height = 25
            Width = 119
          end
          object MostrarAvisoCtrl: TcxDBCheckBox
            Left = 6
            Top = 4
            AutoSize = False
            Caption = 'Mostrar aviso'
            DataBinding.DataField = 'MostrarAviso'
            DataBinding.DataSource = ClienteDataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            TabOrder = 0
            Transparent = True
            Height = 25
            Width = 119
          end
        end
        inline AnnotationFrame1: TAnnotationFrame
          Left = 0
          Top = 0
          Width = 868
          Height = 398
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 868
          ExplicitHeight = 398
          inherited AnnotationPanel: TcxGroupBox
            ExplicitWidth = 868
            ExplicitHeight = 366
            Height = 366
            Width = 868
            inherited AnnotationRichEdit: TcxDBRichEdit
              DataBinding.DataField = 'Aviso'
              DataBinding.DataSource = ClienteDataSource
              ExplicitWidth = 864
              ExplicitHeight = 321
              Height = 321
              Width = 864
            end
            inherited Ruler: TfrxRuler
              Width = 864
              ExplicitWidth = 864
            end
          end
          inherited ButtonsBar: TcxGroupBox
            ExplicitWidth = 868
            Width = 868
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
  object FormManager: TgxFormManager
    Dataset = ClienteTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = NombreCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnCopyCurrentRecord = FormManagerCopyCurrentRecord
    OnReportRequest = FormManagerReportRequest
    OnReportFormRequest = FormManagerReportFormRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 552
    Top = 3
  end
  object ClienteTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterEdit = ClienteTableAfterEdit
    BeforePost = ClienteTableBeforePost
    BeforeCancel = ClienteTableBeforeCancel
    BeforeDelete = ClienteTableBeforeDelete
    OnNewRecord = ClienteTableNewRecord
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    AutoIncFieldName = 'Codigo'
    OnGetRecord = ClienteTableGetRecord
    OnUpdateState = ClienteTableUpdateState
    Left = 520
    Top = 3
  end
  object ClienteDataSource: TDataSource
    DataSet = ClienteTable
    Left = 490
    Top = 3
  end
  object DireccionContactoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = DireccionContactoTableNewRecord
    TableName = 'DireccionContacto'
    IndexFieldNames = 'Tipo;Codigo;NroRegistro'
    MasterSource = ClienteDataSource
    AutoIncFieldName = 'NroRegistro'
    MasterRelation = mrBalanced
    OnApplyMasterRange = DireccionContactoTableApplyMasterRange
    Left = 456
    Top = 3
    object DireccionContactoTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object DireccionContactoTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object DireccionContactoTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
    end
    object DireccionContactoTableNombre: TWideStringField
      FieldName = 'Nombre'
      Required = True
      Size = 60
    end
    object DireccionContactoTableCargo: TWideStringField
      FieldName = 'Cargo'
      Size = 40
    end
    object DireccionContactoTableFijo: TWideStringField
      FieldName = 'Fijo'
      Size = 40
    end
    object DireccionContactoTableMovil: TWideStringField
      FieldName = 'Movil'
      Size = 40
    end
    object DireccionContactoTableFax: TWideStringField
      FieldName = 'Fax'
      Size = 40
    end
    object DireccionContactoTableCorreo: TWideStringField
      FieldName = 'Correo'
      Size = 80
    end
    object DireccionContactoTableTipoDocumento: TSmallintField
      FieldName = 'TipoDocumento'
    end
  end
  object DireccionContactoData: TDataSource
    DataSet = DireccionContactoTable
    Left = 425
    Top = 3
  end
  object BarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'ReportFormsPopupMenu')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 313
    Top = 3
    PixelsPerInch = 96
    object ImpresionMandatosItem: TdxBarButton
      Caption = 'Impresi'#243'n de '#243'rdenes de domiciliaci'#243'n o mandatos'
      Category = 1
      Visible = ivAlways
      OnClick = ImpresionMandatosItemClick
    end
  end
  object ReportFormsPopupMenu: TdxBarPopupMenu
    BarManager = BarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemLinks = <
      item
        Visible = True
        ItemName = 'ImpresionMandatosItem'
      end>
    UseOwnFont = True
    Left = 346
    Top = 3
    PixelsPerInch = 96
  end
end
