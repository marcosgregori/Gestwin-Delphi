object MntArtForm: TMntArtForm
  Left = 456
  Top = 244
  HelpType = htKeyword
  HelpKeyword = 'a_art'
  VertScrollBar.Style = ssHotTrack
  ActiveControl = CloseButton
  BorderStyle = bsDialog
  Caption = 'Articulos'
  ClientHeight = 622
  ClientWidth = 972
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
  Position = poDefault
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
    Height = 36
    Width = 972
    object CodigoCtrl: TcxDBTextEdit
      Left = 164
      Top = 6
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = ArticuloDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      TabOrder = 0
      Width = 130
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
    Top = 586
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      972
      36)
    Height = 36
    Width = 972
    object Panel5: TcxGroupBox
      Left = 135
      Top = 0
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 701
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 90
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
        Left = 96
        Top = 2
        Width = 90
        Height = 32
        Margins.Left = 4
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
        Left = 190
        Top = 2
        Width = 90
        Height = 32
        Margins.Left = 4
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
      object datEconButton: TgBitBtn
        AlignWithMargins = True
        Left = 505
        Top = 2
        Width = 95
        Height = 32
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Caption = '&Resultados'
        Enabled = True
        OptionsImage.ImageIndex = 35
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 3
        OnClick = datEconButtonClick
        GlyphBitmap = gmGraph
      end
      object MovimientosButton: TgBitBtn
        AlignWithMargins = True
        Left = 317
        Top = 2
        Width = 95
        Height = 32
        Hint = 'Acceso a la ficha de movimientos del art'#237'culo'
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Caption = '&Movimien.'
        Enabled = True
        OptionsImage.ImageIndex = 12
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = MovimientosButtonClick
        GlyphBitmap = gmFields
      end
      object RejillaButton: TgBitBtn
        AlignWithMargins = True
        Left = 416
        Top = 2
        Width = 85
        Height = 32
        Hint = 'Rejilla de edici'#243'n r'#225'pida de art'#237'culos'
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Caption = 'Re&jilla'
        Enabled = True
        OptionsImage.ImageIndex = 48
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = RejillaButtonClick
        GlyphBitmap = gmEditField
      end
      object DocumentosExternosButton: TgBitBtn
        AlignWithMargins = True
        Left = 604
        Top = 2
        Width = 95
        Height = 32
        Hint = 'Abrir la carpeta de documentos externos del art'#237'culo'
        Margins.Left = 4
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
        TabOrder = 6
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
    Height = 550
    Width = 962
    object PageControl: TcxPageControl
      Left = 2
      Top = 34
      Width = 958
      Height = 514
      Align = alClient
      Focusable = False
      TabOrder = 1
      Properties.ActivePage = DatosGeneralesTabSheet
      Properties.CustomButtons.Buttons = <>
      OnChange = PageControlChange
      ClientRectBottom = 510
      ClientRectLeft = 4
      ClientRectRight = 954
      ClientRectTop = 28
      object DatosGeneralesTabSheet: TcxTabSheet
        Caption = '&Datos generales'
        object cxGroupBox28: TcxGroupBox
          Left = 589
          Top = 0
          Align = alClient
          Alignment = alCenterCenter
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Transparent = True
          Height = 482
          Width = 361
          object ImagenCtrl: TcxDBImage
            Left = 2
            Top = 2
            Align = alClient
            DataBinding.DataField = 'Imagen'
            DataBinding.DataSource = ArticuloDataSource
            Properties.FitMode = ifmProportionalStretch
            Properties.GraphicClassName = 'TdxSmartImage'
            Properties.PopupMenuLayout.MenuItems = [pmiCut, pmiCopy, pmiPaste, pmiDelete, pmiLoad, pmiSave]
            TabOrder = 0
            ZoomingOptions.ShowZoomTrackBar = True
            Height = 478
            Width = 357
          end
        end
        object cxGroupBox27: TcxGroupBox
          Left = 0
          Top = 0
          Align = alLeft
          Alignment = alCenterCenter
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Transparent = True
          DesignSize = (
            581
            482)
          Height = 482
          Width = 581
          object ArticuloConEnvaseCtrl: TcxDBCheckBox
            Left = 3
            Top = 308
            AutoSize = False
            Caption = 'Art'#237'culo con envase'
            DataBinding.DataField = 'ConEnvase'
            DataBinding.DataSource = ArticuloDataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = False
            TabOrder = 10
            Transparent = True
            Visible = False
            Height = 24
            Width = 169
          end
          object CodigoBarrasCtrl: TcxDBTextEdit
            Left = 157
            Top = 117
            Hint = 
              'Pulse [F11] para comprobar un c'#243'digo EAN13 o generar su d'#237'gito d' +
              'e control (utiice el caracter '#39'*'#39' como comod'#237'n). \nTambi'#233'n puede' +
              ' generar un c'#243'digo EAN5 autom'#225'tico si el campo est'#225' vac'#237'o.'
            DataBinding.DataField = 'CodigoBarras'
            DataBinding.DataSource = ArticuloDataSource
            ParentShowHint = False
            Properties.OnExtendedFunction = CodigoBarrasCtrlPropertiesExtendedFunction
            Properties.OnQueryRequest = CodigoBarrasCtrlPropertiesQueryRequest
            Properties.OnEditRequest = CodigoBarrasCtrlPropertiesEditRequest
            ShowHint = True
            TabOrder = 5
            Width = 130
          end
          object cxGroupBox4: TcxGroupBox
            Left = 5
            Top = 170
            Alignment = alCenterCenter
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 7
            Transparent = True
            Height = 83
            Width = 257
            object LargoCtrl: TcxDBCurrencyEdit
              Left = 152
              Top = 1
              DataBinding.DataField = 'Largo'
              DataBinding.DataSource = ArticuloDataSource
              Properties.MaxLength = 8
              TabOrder = 0
              Width = 67
            end
            object AnchoCtrl: TcxDBCurrencyEdit
              Left = 152
              Top = 28
              DataBinding.DataField = 'Ancho'
              DataBinding.DataSource = ArticuloDataSource
              Properties.MaxLength = 8
              TabOrder = 1
              Width = 67
            end
            object AltoCtrl: TcxDBCurrencyEdit
              Left = 152
              Top = 55
              DataBinding.DataField = 'Alto'
              DataBinding.DataSource = ArticuloDataSource
              Properties.MaxLength = 8
              TabOrder = 2
              Width = 67
            end
            object Label22: TcxLabel
              Left = 16
              Top = 4
              TabStop = False
              Caption = 'Largo'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 3
              Transparent = True
            end
            object Label23: TcxLabel
              Left = 16
              Top = 31
              TabStop = False
              Caption = 'Ancho'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 4
              Transparent = True
            end
            object Label24: TcxLabel
              Left = 16
              Top = 58
              TabStop = False
              Caption = 'Alto'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 5
              Transparent = True
            end
          end
          object cxLabel4: TcxLabel
            Left = 5
            Top = 256
            TabStop = False
            Caption = 'Fecha de alta'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 12
            Transparent = True
          end
          object descFamiliaLabel: TcxLabel
            Left = 247
            Top = 10
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 13
            Transparent = True
            Height = 19
            Width = 333
          end
          object FamiliaCtrl: TcxDBTextEdit
            Left = 157
            Top = 7
            DescriptionLabel = descFamiliaLabel
            DataBinding.DataField = 'Familia'
            DataBinding.DataSource = ArticuloDataSource
            Properties.OnQueryRequest = FamiliaCtrlPropertiesQueryRequest
            Properties.OnEditRequest = FamiliaCtrlPropertiesEditRequest
            Properties.OnValidate = FamiliaCtrlPropertiesValidate
            TabOrder = 0
            Width = 65
          end
          object FechaAltaCtrl: TcxDBDateEdit
            Left = 157
            Top = 253
            DataBinding.DataField = 'FechaAlta'
            DataBinding.DataSource = ArticuloDataSource
            Properties.Required = True
            Properties.DateButtons = [btnClear, btnToday]
            Properties.DateOnError = deToday
            TabOrder = 8
            Width = 100
          end
          object FijarMedidasCtrl: TcxDBCheckBox
            Left = 5
            Top = 146
            AutoSize = False
            Caption = 'Medidas fijas'
            DataBinding.DataField = 'FijarMedidas'
            DataBinding.DataSource = ArticuloDataSource
            Properties.Alignment = taRightJustify
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = FijarMedidasCtrlPropertiesEditValueChanged
            Style.TransparentBorder = False
            TabOrder = 6
            Transparent = True
            Height = 21
            Width = 166
          end
          object Label15: TcxLabel
            Left = 5
            Top = 120
            TabStop = False
            Caption = 'C'#243'digo de barras'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 14
            Transparent = True
          end
          object Label25: TcxLabel
            Left = 5
            Top = 10
            TabStop = False
            Caption = 'Familia'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 15
            Transparent = True
          end
          object Label26: TcxLabel
            Left = 5
            Top = 37
            TabStop = False
            Caption = 'Tipo de I.V.A.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 16
            Transparent = True
          end
          object NoAplicarRetencionCtrl: TcxDBCheckBox
            Left = 3
            Top = 89
            AutoSize = False
            Caption = 'No aplicar retenci'#243'n'
            DataBinding.DataField = 'NoAplicarRetencion'
            DataBinding.DataSource = ArticuloDataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = False
            TabOrder = 4
            Transparent = True
            Height = 21
            Width = 168
          end
          object NoAplicarTipoFijoCtrl: TcxDBCheckBox
            Left = 3
            Top = 63
            Hint = 'No aplicar tipo fijo de I.V.A.'
            AutoSize = False
            Caption = 'No aplicar tipo fijo'
            DataBinding.DataField = 'NoAplicarTipoFijo'
            DataBinding.DataSource = ArticuloDataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = False
            TabOrder = 3
            Transparent = True
            Height = 21
            Width = 168
          end
          object TipoIVACtrl: TcxDBSpinEdit
            Left = 157
            Top = 34
            DescriptionLabel = DescTipoIVALabel
            DataBinding.DataField = 'TipoIVA'
            DataBinding.DataSource = ArticuloDataSource
            Properties.Required = True
            Properties.OnQueryRequest = TipoIVACtrlPropertiesQueryRequest
            Properties.OnEditRequest = TipoIVACtrlPropertiesEditRequest
            Properties.DisplayFormat = '#'
            Properties.ImmediatePost = True
            Properties.MaxValue = 24.000000000000000000
            Properties.MinValue = 1.000000000000000000
            Properties.OnValidate = TipoIVACtrlPropertiesValidate
            TabOrder = 1
            Width = 57
          end
          object cxGroupBox31: TcxGroupBox
            Left = 237
            Top = 32
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TransparentBorder = False
            TabOrder = 2
            Transparent = True
            Height = 29
            Width = 333
            object PaisesIVAButton: TgBitBtn
              Left = 0
              Top = 0
              Width = 76
              Height = 29
              Hint = 'Edici'#243'n de los tipos de I.V.A. por pais intracomunitario'
              Margins.Left = 4
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              Align = alLeft
              Caption = 'Paises'
              Enabled = True
              OptionsImage.ImageIndex = 12
              OptionsImage.Images = ApplicationContainer.ButtonImageList
              OptionsImage.Margin = 4
              OptionsImage.Spacing = 5
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnClick = PaisesIVAButtonClick
              GlyphBitmap = gmFields
            end
            object DescTipoIVALabel: TcxLabel
              AlignWithMargins = True
              Left = 86
              Top = 3
              Margins.Left = 10
              TabStop = False
              Align = alClient
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              Properties.Alignment.Vert = taVCenter
              TabOrder = 1
              Transparent = True
              Height = 23
              Width = 244
              AnchorY = 15
            end
          end
          object cxLabel11: TcxLabel
            Left = 5
            Top = 283
            TabStop = False
            Caption = 'Documentos externos'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 17
            Transparent = True
          end
          object DocumentosExternosCtrl: TcxDBTextEdit
            Left = 157
            Top = 280
            Hint = 
              'Indique el camino (path) al directorio de los documentos del cli' +
              'ente. Si est'#225' en un entorno de red debe utilizar paths UNC, del ' +
              'tipo \\Servidor\Carpeta, para que sea accesible desde cualquier ' +
              'puesto de trabajo.'
            Anchors = [akLeft, akTop, akRight]
            DataBinding.DataField = 'DocumentosExternos'
            DataBinding.DataSource = ArticuloDataSource
            TabOrder = 9
            Width = 329
          end
          object ExaminarButton: TgBitBtn
            Left = 493
            Top = 278
            Width = 87
            Height = 29
            Anchors = [akTop, akRight]
            Caption = 'Exa&minar'
            Enabled = True
            OptionsImage.ImageIndex = 23
            OptionsImage.Images = ApplicationContainer.ButtonImageList
            OptionsImage.Margin = 4
            OptionsImage.Spacing = 5
            TabOrder = 18
            OnClick = ExaminarButtonClick
            GlyphBitmap = gmFolderBrowser
          end
          object ArticuloPeligrosoCtrl: TcxDBCheckBox
            Left = 3
            Top = 333
            AutoSize = False
            Caption = 'Peligroso'
            DataBinding.DataField = 'Peligroso'
            DataBinding.DataSource = ArticuloDataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = False
            TabOrder = 11
            Transparent = True
            Visible = False
            Height = 24
            Width = 169
          end
        end
        object cxSplitter2: TcxSplitter
          Left = 581
          Top = 0
          Width = 8
          Height = 482
          Control = cxGroupBox27
        end
      end
      object preciosTabSheet: TcxTabSheet
        Caption = '&Precios'
        object cxScrollBox1: TcxScrollBox
          Left = 0
          Top = 0
          Width = 950
          Height = 482
          Align = alClient
          BorderStyle = cxcbsNone
          TabOrder = 0
          Transparent = True
          object cxGroupBox1: TcxGroupBox
            AlignWithMargins = True
            Left = 3
            Top = 3
            Align = alTop
            Caption = 'Compras'
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TextStyle = [fsBold]
            Style.TransparentBorder = True
            TabOrder = 0
            Transparent = True
            DesignSize = (
              944
              114)
            Height = 114
            Width = 944
            object Precio_CompraCtrl: TcxDBCurrencyEdit
              Left = 154
              Top = 51
              DataBinding.DataField = 'Precio_Compra'
              DataBinding.DataSource = ArticuloDataSource
              Properties.MaxLength = 10
              Properties.OnEditValueChanged = Precio_CompraEditValueChanged
              TabOrder = 1
              Width = 82
            end
            object Dto_CompraCtrl: TcxDBCurrencyEdit
              Left = 154
              Top = 78
              DataBinding.DataField = 'Dto_Compra'
              DataBinding.DataSource = ArticuloDataSource
              Properties.MaxLength = 5
              Properties.OnEditValueChanged = Precio_CompraEditValueChanged
              TabOrder = 3
              Width = 47
            end
            object CodigoProveedorCtrl: TcxDBTextEdit
              Left = 154
              Top = 24
              DescriptionLabel = Label10
              DataBinding.DataField = 'CodigoProveedor'
              DataBinding.DataSource = ArticuloDataSource
              Properties.OnQueryRequest = CodigoProveedorCtrlPropertiesQueryRequest
              Properties.OnEditRequest = CodigoProveedorCtrlPropertiesEditRequest
              Properties.TextEditPad = tpLeftZero
              Properties.OnValidate = CodigoProveedorCtrlPropertiesValidate
              TabOrder = 0
              Width = 47
            end
            object Label31: TcxLabel
              Left = 11
              Top = 54
              TabStop = False
              Caption = 'Precio de compra'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 4
              Transparent = True
            end
            object Label32: TcxLabel
              Left = 11
              Top = 81
              TabStop = False
              Caption = 'Descuento'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 5
              Transparent = True
            end
            object Label33: TcxLabel
              Left = 210
              Top = 81
              TabStop = False
              Caption = '%'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 6
              Transparent = True
            end
            object Label9: TcxLabel
              Left = 11
              Top = 27
              TabStop = False
              Caption = 'Proveedor habitual'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 7
              Transparent = True
            end
            object Label10: TcxLabel
              Left = 265
              Top = 27
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              Properties.Alignment.Vert = taVCenter
              TabOrder = 8
              Transparent = True
              Height = 20
              Width = 668
              AnchorY = 37
            end
            object cxLabel5: TcxLabel
              Left = 264
              Top = 54
              TabStop = False
              Caption = 'Unidades'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 9
              Transparent = True
            end
            object UnidadesPrecioCompraCtrl: TcxDBSpinEdit
              Left = 389
              Top = 51
              Hint = 'Unidades al precio de compra indicado..'
              CaptionLabel = cxLabel5
              DataBinding.DataField = 'UnidadesPrecioCompra'
              DataBinding.DataSource = ArticuloDataSource
              Properties.Alignment.Horz = taRightJustify
              Properties.LargeIncrement = 100.000000000000000000
              Properties.MaxValue = 999999.000000000000000000
              Properties.MinValue = 1.000000000000000000
              TabOrder = 2
              Width = 86
            end
          end
          object cxGroupBox2: TcxGroupBox
            AlignWithMargins = True
            Left = 3
            Top = 123
            Align = alClient
            Caption = 'Ventas'
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            Style.TextStyle = [fsBold]
            TabOrder = 1
            Transparent = True
            DesignSize = (
              944
              356)
            Height = 356
            Width = 944
            object Precio_VentaCtrl: TcxDBCurrencyEdit
              Left = 154
              Top = 26
              DataBinding.DataField = 'Precio_Venta'
              DataBinding.DataSource = ArticuloDataSource
              Properties.MaxLength = 10
              Properties.OnEditValueChanged = Precio_VentaCtrlPropertiesEditValueChanged
              TabOrder = 0
              Width = 81
            end
            object Dto_VentaCtrl: TcxDBCurrencyEdit
              Left = 154
              Top = 80
              DataBinding.DataField = 'Dto_Venta'
              DataBinding.DataSource = ArticuloDataSource
              Properties.MaxLength = 5
              TabOrder = 5
              Width = 46
            end
            object ComisionCtrl: TcxDBCurrencyEdit
              Left = 154
              Top = 107
              DataBinding.DataField = 'Comision'
              DataBinding.DataSource = ArticuloDataSource
              Properties.AssignedValues.DisplayFormat = True
              Properties.DecimalPlaces = 2
              Properties.MaxLength = 5
              TabOrder = 6
              Width = 46
            end
            object PrecioVentaIVACtrl: TcxCurrencyEdit
              Left = 613
              Top = 26
              Properties.Alignment.Horz = taRightJustify
              Properties.AssignedValues.DisplayFormat = True
              Properties.MaxLength = 10
              Properties.OnValidate = PrecioVentaIVACtrlPropertiesValidate
              TabOrder = 2
              Width = 74
            end
            object Recargo_VentaCtrl: TcxDBCurrencyEdit
              Left = 154
              Top = 53
              DataBinding.DataField = 'Recargo_Venta'
              DataBinding.DataSource = ArticuloDataSource
              TabOrder = 3
              Width = 67
            end
            object MargenComercialCtrl: TcxDBCurrencyEdit
              Left = 154
              Top = 134
              DataBinding.DataField = 'MargenComercial'
              DataBinding.DataSource = ArticuloDataSource
              Properties.MaxLength = 5
              Properties.OnEditValueChanged = Precio_CompraEditValueChanged
              Properties.OnValidate = MargenComercialCtrlPropertiesValidate
              TabOrder = 7
              Width = 46
            end
            object PuntoVerdeCtrl: TcxDBCurrencyEdit
              Left = 389
              Top = 53
              DataBinding.DataField = 'PuntoVerde'
              DataBinding.DataSource = ArticuloDataSource
              TabOrder = 4
              Width = 60
            end
            object OfertaCtrl: TcxDBCheckBox
              Left = 8
              Top = 191
              AutoSize = False
              Caption = 'Art'#237'culo en oferta'
              DataBinding.DataField = 'Oferta'
              DataBinding.DataSource = ArticuloDataSource
              Properties.Alignment = taRightJustify
              Properties.ImmediatePost = True
              Properties.NullStyle = nssUnchecked
              Properties.OnEditValueChanged = OfertaCtrlPropertiesEditValueChanged
              TabOrder = 9
              Transparent = True
              Height = 21
              Width = 163
            end
            object Label1: TcxLabel
              Left = 11
              Top = 29
              TabStop = False
              Caption = 'Precio de venta'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 10
              Transparent = True
            end
            object Label2: TcxLabel
              Left = 11
              Top = 83
              TabStop = False
              Caption = 'Descuento'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 11
              Transparent = True
            end
            object Label4: TcxLabel
              Left = 11
              Top = 110
              TabStop = False
              Caption = 'Comisi'#243'n'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 12
              Transparent = True
            end
            object Label5: TcxLabel
              Left = 208
              Top = 83
              TabStop = False
              Caption = '%'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 13
              Transparent = True
            end
            object Label8: TcxLabel
              Left = 208
              Top = 110
              TabStop = False
              Caption = '%'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 14
              Transparent = True
            end
            object Label20: TcxLabel
              Left = 499
              Top = 29
              TabStop = False
              Caption = 'I.V.A. incluido'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 15
              Transparent = True
            end
            object recargoLabel: TcxLabel
              Left = 11
              Top = 56
              TabStop = False
              Caption = 'Recargo'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 16
              Transparent = True
            end
            object Label27: TcxLabel
              Left = 11
              Top = 137
              TabStop = False
              Caption = 'Margen comercial'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 17
              Transparent = True
            end
            object Label28: TcxLabel
              Left = 208
              Top = 137
              TabStop = False
              Caption = '%'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 18
              Transparent = True
            end
            object Label14: TcxLabel
              Left = 265
              Top = 56
              TabStop = False
              Caption = 'Tasa RAEE / Ecotasa'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 19
              Transparent = True
            end
            object ParametrosOfertaGroupBox: TcxGroupBox
              AlignWithMargins = True
              Left = 5
              Top = 211
              Alignment = alCenterCenter
              Anchors = [akLeft, akTop, akRight]
              Style.BorderStyle = ebsNone
              TabOrder = 20
              Height = 87
              Width = 934
              object OfertaFechaInicialCtrl: TcxDBDateEdit
                Left = 149
                Top = 7
                CaptionLabel = Label6
                DataBinding.DataField = 'OfertaFechaInicial'
                DataBinding.DataSource = ArticuloDataSource
                Properties.Required = True
                TabOrder = 0
                Width = 100
              end
              object OfertaFechaFinalCtrl: TcxDBDateEdit
                Left = 384
                Top = 7
                CaptionLabel = Label7
                DataBinding.DataField = 'OfertaFechaFinal'
                DataBinding.DataSource = ArticuloDataSource
                Properties.Required = True
                TabOrder = 1
                Width = 100
              end
              object OfertaPrecioVentaCtrl: TcxDBCurrencyEdit
                Left = 149
                Top = 34
                CaptionLabel = Label29
                DataBinding.DataField = 'OfertaPrecioVenta'
                DataBinding.DataSource = ArticuloDataSource
                Properties.MaxLength = 10
                TabOrder = 2
                Width = 81
              end
              object OfertaPrecioVentaIVACtrl: TcxCurrencyEdit
                Left = 384
                Top = 34
                CaptionLabel = Label34
                Properties.Alignment.Horz = taRightJustify
                Properties.AssignedValues.DisplayFormat = True
                Properties.MaxLength = 10
                Properties.OnValidate = OfertaPrecioVentaIVACtrlPropertiesValidate
                TabOrder = 3
                Width = 74
              end
              object OfertaDescuentoCtrl: TcxDBCurrencyEdit
                Left = 149
                Top = 61
                CaptionLabel = Label35
                DataBinding.DataField = 'OfertaDescuento'
                DataBinding.DataSource = ArticuloDataSource
                Properties.MaxLength = 5
                TabOrder = 4
                Width = 46
              end
              object Label6: TcxLabel
                Left = 23
                Top = 10
                TabStop = False
                Caption = 'Desde el'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 5
                Transparent = True
              end
              object Label7: TcxLabel
                Left = 259
                Top = 10
                TabStop = False
                Caption = 'hasta el'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 6
                Transparent = True
              end
              object Label29: TcxLabel
                Left = 23
                Top = 37
                TabStop = False
                Caption = 'Precio de venta'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 7
                Transparent = True
              end
              object Label34: TcxLabel
                Left = 259
                Top = 37
                TabStop = False
                Caption = 'I.V.A. incluido'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 8
                Transparent = True
              end
              object Label35: TcxLabel
                Left = 23
                Top = 64
                TabStop = False
                Caption = 'Descuento'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 9
                Transparent = True
              end
              object Label36: TcxLabel
                Left = 202
                Top = 64
                TabStop = False
                Caption = '%'
                Style.TransparentBorder = False
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 10
                Transparent = True
              end
            end
            object cxLabel6: TcxLabel
              Left = 264
              Top = 29
              TabStop = False
              Caption = 'Unidades'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 21
              Transparent = True
            end
            object UnidadesPrecioVentaCtrl: TcxDBSpinEdit
              Left = 389
              Top = 26
              Hint = 'Unidades al precio de venta indicado'
              CaptionLabel = cxLabel6
              DataBinding.DataField = 'UnidadesPrecioVenta'
              DataBinding.DataSource = ArticuloDataSource
              Properties.Alignment.Horz = taRightJustify
              Properties.LargeIncrement = 100.000000000000000000
              Properties.MaxValue = 999999.000000000000000000
              Properties.MinValue = 1.000000000000000000
              TabOrder = 1
              Width = 86
            end
            object cxLabel14: TcxLabel
              Left = 11
              Top = 164
              TabStop = False
              Caption = 'Cantidad m'#237'nima'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 22
              Transparent = True
            end
            object CantidadMinimaVentaCtrl: TcxDBCurrencyEdit
              Left = 154
              Top = 161
              DataBinding.DataField = 'CantidadMinimaVenta'
              DataBinding.DataSource = ArticuloDataSource
              Properties.MaxLength = 5
              TabOrder = 8
              Width = 67
            end
          end
        end
      end
      object AlmacenTabSheet: TcxTabSheet
        Caption = 'A&lmac'#233'n'
        object StockMaximoMinimoPanel: TcxGroupBox
          Left = 0
          Top = 60
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Height = 29
          Width = 950
          object Stock_MinimoCtrl: TcxDBCurrencyEdit
            Left = 156
            Top = 2
            DataBinding.DataField = 'Stock_Minimo'
            DataBinding.DataSource = ArticuloDataSource
            Properties.MaxLength = 10
            TabOrder = 0
            Width = 82
          end
          object Stock_MaximoCtrl: TcxDBCurrencyEdit
            Left = 311
            Top = 2
            DataBinding.DataField = 'Stock_Maximo'
            DataBinding.DataSource = ArticuloDataSource
            TabOrder = 1
            Width = 82
          end
          object Label39: TcxLabel
            Left = 8
            Top = 5
            TabStop = False
            Caption = '"Stock" m'#237'nimo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
          object Label40: TcxLabel
            Left = 248
            Top = 5
            TabStop = False
            Caption = 'y m'#225'ximo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
          end
        end
        object cxGroupBox21: TcxGroupBox
          Left = 0
          Top = 235
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 3
          Height = 148
          Width = 950
          object UnidadesPorCajaCtrl: TcxDBCurrencyEdit
            Left = 156
            Top = 27
            DataBinding.DataField = 'UnidadesPorCaja'
            DataBinding.DataSource = ArticuloDataSource
            Properties.MaxLength = 9
            TabOrder = 1
            Width = 89
          end
          object KilosCtrl: TcxDBCurrencyEdit
            Left = 246
            Top = 54
            DataBinding.DataField = 'Kilos'
            DataBinding.DataSource = ArticuloDataSource
            Properties.MaxLength = 9
            TabOrder = 3
            Width = 83
          end
          object VolumenCtrl: TcxDBCurrencyEdit
            Left = 345
            Top = 54
            DataBinding.DataField = 'Volumen'
            DataBinding.DataSource = ArticuloDataSource
            Properties.MaxLength = 9
            TabOrder = 4
            Width = 83
          end
          object ObsoletoCtrl: TcxDBCheckBox
            Left = 5
            Top = 83
            AutoSize = False
            Caption = 'Obsoleto (no usar)'
            DataBinding.DataField = 'Obsoleto'
            DataBinding.DataSource = ArticuloDataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            Properties.ValueGrayed = 'False'
            TabOrder = 5
            Transparent = True
            Height = 21
            Width = 167
          end
          object NoAfectarStockCtrl: TcxDBCheckBox
            Left = 5
            Top = 106
            AutoSize = False
            Caption = 'No afectar a "stock"'
            DataBinding.DataField = 'NoAfectarStock'
            DataBinding.DataSource = ArticuloDataSource
            Properties.Alignment = taRightJustify
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = NoAfectarStockCtrlPropertiesEditValueChanged
            TabOrder = 6
            Transparent = True
            Height = 21
            Width = 167
          end
          object BultosCtrl: TcxDBCurrencyEdit
            Left = 156
            Top = 54
            Hint = 
              'Si los bultos de la ficha son positivos son el n'#250'mero de bultos\' +
              'n por unidad, si son negativos indican el n'#250'mero de unidades\nqu' +
              'e hay en un bulto.'
            DataBinding.DataField = 'Bultos'
            DataBinding.DataSource = ArticuloDataSource
            ParentShowHint = False
            Properties.MaxLength = 9
            Properties.MaxValue = 999.000000000000000000
            ShowHint = False
            TabOrder = 2
            Width = 77
          end
          object Label42: TcxLabel
            Left = 8
            Top = 30
            TabStop = False
            Caption = 'Unidades por caja'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 7
            Transparent = True
          end
          object capBultosLabel: TcxLabel
            Left = 8
            Top = 57
            TabStop = False
            Caption = 'Bultos / Peso / Volumen'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 8
            Transparent = True
          end
          object s1Label: TcxLabel
            Left = 237
            Top = 57
            TabStop = False
            Caption = '/'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 9
            Transparent = True
          end
          object s2Label: TcxLabel
            Left = 335
            Top = 57
            TabStop = False
            Caption = '/'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 10
            Transparent = True
          end
          object NoAfectarCosteCtrl: TcxDBCheckBox
            Left = 5
            Top = 128
            Hint = 
              'Si marca esta opci'#243'n, las entradas no actualizar'#225'n el coste medi' +
              'o y coste de '#250'ltima entrada del art'#237'culo en el registro de exist' +
              'encias.'
            AutoSize = False
            Caption = 'No afectar al coste'
            DataBinding.DataField = 'NoAfectarCoste'
            DataBinding.DataSource = ArticuloDataSource
            ParentShowHint = False
            Properties.Alignment = taRightJustify
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = NoAfectarStockCtrlPropertiesEditValueChanged
            ShowHint = True
            TabOrder = 11
            Transparent = True
            Height = 21
            Width = 167
          end
          object Label41: TcxLabel
            Left = 8
            Top = 3
            TabStop = False
            Caption = 'Unidades por "pallet"'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 12
            Transparent = True
          end
          object UnidadesPorPalletCtrl: TcxDBCurrencyEdit
            Left = 156
            Top = 0
            DataBinding.DataField = 'UnidadesPorPallet'
            DataBinding.DataSource = ArticuloDataSource
            Properties.MaxLength = 9
            TabOrder = 0
            Width = 89
          end
        end
        object cxGroupBox22: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 60
          Width = 950
          object UbicacionCtrl: TcxDBTextEdit
            Left = 156
            Top = 35
            DescriptionLabel = Label13
            DataBinding.DataField = 'Ubicacion'
            DataBinding.DataSource = ArticuloDataSource
            Properties.OnQueryRequest = UbicacionCtrlPropertiesQueryRequest
            Properties.OnEditRequest = UbicacionCtrlPropertiesEditRequest
            Properties.OnValidate = UbicacionCtrlPropertiesValidate
            TabOrder = 0
            Width = 54
          end
          object CodigoAlmacenCtrl: TcxDBTextEdit
            Left = 156
            Top = 8
            DescriptionLabel = Label12
            DataBinding.DataField = 'CodigoAlmacen'
            DataBinding.DataSource = ArticuloDataSource
            Properties.OnQueryRequest = CodigoAlmacenCtrlPropertiesQueryRequest
            Properties.OnValidate = CodigoAlmacenCtrlPropertiesValidate
            TabOrder = 1
            Width = 26
          end
          object Label43: TcxLabel
            Left = 8
            Top = 38
            TabStop = False
            Caption = 'Ubicaci'#243'n'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
          object Label11: TcxLabel
            Left = 8
            Top = 11
            TabStop = False
            Caption = 'Almac'#233'n'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
          end
          object Label12: TcxLabel
            Left = 242
            Top = 9
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 4
            Transparent = True
            Height = 20
            Width = 369
            AnchorY = 19
          end
          object Label13: TcxLabel
            Left = 242
            Top = 36
            TabStop = False
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 5
            Transparent = True
            Height = 20
            Width = 369
            AnchorY = 46
          end
        end
        object ExistenciasArticuloPanel: TcxGroupBox
          Left = 0
          Top = 89
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 2
          Height = 146
          Width = 950
          object cxLabel15: TcxLabel
            Left = 10
            Top = 6
            TabStop = False
            AutoSize = False
            Caption = '"Stocks" y ubicaciones por almac'#233'n'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.WordWrap = True
            TabOrder = 0
            Transparent = True
            Height = 45
            Width = 131
          end
          object cxGroupBox20: TcxGroupBox
            Left = 155
            Top = -2
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 1
            Height = 147
            Width = 538
            object ExistenciasArticuloGrid: TcxGrid
              Left = 2
              Top = 2
              Width = 496
              Height = 143
              Align = alClient
              TabOrder = 0
              object ExistenciasArticuloTableView: TcxGridDBTableView
                Tag = 585561968
                Navigator.Buttons.CustomButtons = <>
                ScrollbarAnnotations.CustomAnnotations = <>
                DataController.DataModeController.GridMode = True
                DataController.DataSource = ExistenciasArticuloDataSource
                DataController.KeyFieldNames = 'CodigoAlmacen'
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <>
                DataController.Summary.SummaryGroups = <>
                OptionsBehavior.PostponedSynchronization = False
                OptionsCustomize.ColumnFiltering = False
                OptionsCustomize.ColumnGrouping = False
                OptionsCustomize.ColumnHidingOnGrouping = False
                OptionsCustomize.ColumnHorzSizing = False
                OptionsCustomize.ColumnMoving = False
                OptionsCustomize.ColumnSorting = False
                OptionsData.Deleting = False
                OptionsData.DeletingConfirmation = False
                OptionsData.Inserting = False
                OptionsView.ColumnAutoWidth = True
                OptionsView.GroupByBox = False
                object ExistenciasArticuloTableViewCodigoAlmacen: TcxGridDBColumn
                  Caption = 'Alm.'
                  DataBinding.FieldName = 'CodigoAlmacen'
                  Options.Editing = False
                  Options.Focusing = False
                  Options.Grouping = False
                  Width = 35
                end
                object ExistenciasArticuloTableViewNombre: TcxGridDBColumn
                  Caption = 'Nombre'
                  DataBinding.FieldName = 'NombreAlmacen'
                  Options.Editing = False
                  Options.Focusing = False
                  Options.Grouping = False
                  Width = 200
                end
                object ExistenciasArticuloTableViewStockMinimo: TcxGridDBColumn
                  Caption = 'M'#237'nimo'
                  DataBinding.FieldName = 'StockMinimo'
                  Width = 90
                end
                object ExistenciasArticuloTableViewStockMaximo: TcxGridDBColumn
                  Caption = 'M'#225'ximo'
                  DataBinding.FieldName = 'StockMaximo'
                  Width = 90
                end
                object ExistenciasArticuloTableViewUbicacion: TcxGridDBColumn
                  Caption = 'Ubicaci'#243'n'
                  DataBinding.FieldName = 'Ubicacion'
                  PropertiesClassName = 'TcxTextEditProperties'
                  Properties.OnQueryRequest = ExistenciasArticuloTableViewUbicacionPropertiesQueryRequest
                  Properties.OnEditRequest = ExistenciasArticuloTableViewUbicacionPropertiesEditRequest
                  Properties.OnValidate = ExistenciasArticuloTableViewUbicacionPropertiesValidate
                  Width = 70
                end
              end
              object ExistenciasArticuloGridLevel: TcxGridLevel
                GridView = ExistenciasArticuloTableView
              end
            end
            object GridTableViewController3: TGridTableViewController
              Left = 498
              Top = 2
              Align = alRight
              Enabled = False
              PanelStyle.Active = True
              Style.BorderStyle = ebsNone
              Style.TransparentBorder = False
              TabOrder = 1
              TableView = ExistenciasArticuloTableView
              ShiftRecords = False
              UseGridFilterBox = False
              Height = 143
              Width = 38
            end
          end
        end
      end
      object TabSheet3: TcxTabSheet
        Caption = 'Ano&taciones'
        ImageIndex = 6
        inline AnotacionesFrame: TAnnotationFrame
          Left = 0
          Top = 0
          Width = 950
          Height = 482
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          ExplicitWidth = 950
          ExplicitHeight = 482
          inherited AnnotationPanel: TcxGroupBox
            ExplicitWidth = 950
            ExplicitHeight = 450
            Height = 450
            Width = 950
            inherited AnnotationRichEdit: TcxDBRichEdit
              DataBinding.DataField = 'Anotacion'
              DataBinding.DataSource = ArticuloDataSource
              ExplicitWidth = 946
              ExplicitHeight = 405
              Height = 405
              Width = 946
            end
            inherited Ruler: TfrxRuler
              Width = 946
              ExplicitWidth = 946
            end
          end
          inherited ButtonsBar: TcxGroupBox
            ExplicitWidth = 950
            Width = 950
            inherited FontNameComboBox: TcxFontNameComboBox
              ExplicitHeight = 28
            end
            inherited FontSizeComboBox: TcxComboBox
              ExplicitHeight = 28
            end
          end
        end
      end
      object AvisosTabSheet: TcxTabSheet
        Caption = 'A&visos'
        ImageIndex = 0
        object Panel1: TcxGroupBox
          Left = 0
          Top = 455
          Align = alBottom
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Height = 27
          Width = 950
          object MostrarAvisoCtrl: TcxDBCheckBox
            Left = 6
            Top = 3
            AutoSize = False
            Caption = 'Mostrar aviso'
            DataBinding.DataField = 'MostrarAviso'
            DataBinding.DataSource = ArticuloDataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            TabOrder = 0
            Transparent = True
            Height = 21
            Width = 135
          end
        end
        inline AnnotationFrame1: TAnnotationFrame
          Left = 0
          Top = 0
          Width = 950
          Height = 455
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          ExplicitWidth = 950
          ExplicitHeight = 455
          inherited AnnotationPanel: TcxGroupBox
            ExplicitWidth = 950
            ExplicitHeight = 423
            Height = 423
            Width = 950
            inherited AnnotationRichEdit: TcxDBRichEdit
              DataBinding.DataField = 'Aviso'
              DataBinding.DataSource = ArticuloDataSource
              ExplicitWidth = 946
              ExplicitHeight = 378
              Height = 378
              Width = 946
            end
            inherited Ruler: TfrxRuler
              Width = 946
              ExplicitWidth = 946
            end
          end
          inherited ButtonsBar: TcxGroupBox
            ExplicitWidth = 950
            Width = 950
            inherited FontNameComboBox: TcxFontNameComboBox
              ExplicitHeight = 28
            end
            inherited FontSizeComboBox: TcxComboBox
              ExplicitHeight = 28
            end
          end
        end
      end
      object AmpliacionTabSheet: TcxTabSheet
        Caption = 'A&mpliaci'#243'n'
        ImageIndex = 5
        object cxGroupBox5: TcxGroupBox
          Left = 0
          Top = 301
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 11
          Height = 27
          Width = 950
          object CampoLibre12Ctrl: TcxDBSpinEdit
            Left = 157
            Top = 1
            CaptionLabel = cxLabel3
            DataBinding.DataField = 'CampoLibre12'
            DataBinding.DataSource = ArticuloDataSource
            Properties.DisplayFormat = '#'
            TabOrder = 0
            Width = 91
          end
          object cxLabel3: TcxLabel
            Left = 10
            Top = 4
            TabStop = False
            Caption = 'Campo 12'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object cxGroupBox6: TcxGroupBox
          AlignWithMargins = True
          Left = 0
          Top = 385
          Margins.Left = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 14
          Height = 64
          Width = 950
          object CampoLibre15Ctrl: TcxDBMemo
            Left = 157
            Top = 0
            CaptionLabel = campo1Label
            DataBinding.DataField = 'CampoLibre15'
            DataBinding.DataSource = ArticuloDataSource
            TabOrder = 0
            Height = 60
            Width = 604
          end
          object campo1Label: TcxLabel
            Left = 10
            Top = 1
            TabStop = False
            Caption = 'Campo 15'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object cxGroupBox7: TcxGroupBox
          Left = 0
          Top = 449
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 15
          Height = 64
          Width = 950
          object CampoLibre16Ctrl: TcxDBMemo
            Left = 157
            Top = 1
            CaptionLabel = campo2Label
            DataBinding.DataField = 'CampoLibre16'
            DataBinding.DataSource = ArticuloDataSource
            TabOrder = 0
            Height = 60
            Width = 604
          end
          object campo2Label: TcxLabel
            Left = 10
            Top = 3
            TabStop = False
            Caption = 'Campo 16'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object cxGroupBox8: TcxGroupBox
          Left = 0
          Top = 58
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 2
          Height = 27
          Width = 950
          object CampoLibre3Ctrl: TcxDBTextEdit
            Left = 157
            Top = 1
            CaptionLabel = campo3Label
            DataBinding.DataField = 'CampoLibre3'
            DataBinding.DataSource = ArticuloDataSource
            TabOrder = 0
            Width = 350
          end
          object campo3Label: TcxLabel
            Left = 10
            Top = 4
            TabStop = False
            Caption = 'Campo 3'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object cxGroupBox9: TcxGroupBox
          Left = 0
          Top = 85
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 3
          Height = 27
          Width = 950
          object CampoLibre4Ctrl: TcxDBTextEdit
            Left = 157
            Top = 1
            CaptionLabel = campo4Label
            DataBinding.DataField = 'CampoLibre4'
            DataBinding.DataSource = ArticuloDataSource
            TabOrder = 0
            Width = 350
          end
          object campo4Label: TcxLabel
            Left = 10
            Top = 4
            TabStop = False
            Caption = 'Campo 4'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object cxGroupBox10: TcxGroupBox
          Left = 0
          Top = 112
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 4
          Height = 27
          Width = 950
          object CampoLibre5Ctrl: TcxDBCurrencyEdit
            Left = 157
            Top = 1
            CaptionLabel = Campo5Label
            DataBinding.DataField = 'CampoLibre5'
            DataBinding.DataSource = ArticuloDataSource
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.# '#8364';-,0.# '#8364
            TabOrder = 0
            Width = 75
          end
          object Campo5Label: TcxLabel
            Left = 10
            Top = 4
            TabStop = False
            Caption = 'Campo 5'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object cxGroupBox11: TcxGroupBox
          Left = 0
          Top = 139
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 5
          Height = 27
          Width = 950
          object CampoLibre6Ctrl: TcxDBCurrencyEdit
            Left = 157
            Top = 1
            CaptionLabel = Campo6Label
            DataBinding.DataField = 'CampoLibre6'
            DataBinding.DataSource = ArticuloDataSource
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.# '#8364';-,0.# '#8364
            TabOrder = 0
            Width = 75
          end
          object Campo6Label: TcxLabel
            Left = 10
            Top = 4
            TabStop = False
            Caption = 'Campo 6'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object cxGroupBox12: TcxGroupBox
          Left = 0
          Top = 166
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 6
          Height = 27
          Width = 950
          object CampoLibre7Ctrl: TcxDBCurrencyEdit
            Left = 157
            Top = 1
            CaptionLabel = Campo7Label
            DataBinding.DataField = 'CampoLibre7'
            DataBinding.DataSource = ArticuloDataSource
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.# '#8364';-,0.# '#8364
            TabOrder = 0
            Width = 75
          end
          object Campo7Label: TcxLabel
            Left = 10
            Top = 4
            TabStop = False
            Caption = 'Campo 7'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object cxGroupBox13: TcxGroupBox
          Left = 0
          Top = 193
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 7
          Height = 27
          Width = 950
          object CampoLibre8Ctrl: TcxDBCurrencyEdit
            Left = 157
            Top = 1
            CaptionLabel = Campo8Label
            DataBinding.DataField = 'CampoLibre8'
            DataBinding.DataSource = ArticuloDataSource
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.# '#8364';-,0.# '#8364
            TabOrder = 0
            Width = 75
          end
          object Campo8Label: TcxLabel
            Left = 10
            Top = 4
            TabStop = False
            Caption = 'Campo 8'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object cxGroupBox14: TcxGroupBox
          Left = 0
          Top = 220
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 8
          Height = 27
          Width = 950
          object CampoLibre9Ctrl: TcxDBCheckBox
            Left = 9
            Top = 2
            AutoSize = False
            Caption = 'Campo 9'
            DataBinding.DataField = 'CampoLibre9'
            DataBinding.DataSource = ArticuloDataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = False
            TabOrder = 0
            Transparent = True
            Height = 21
            Width = 162
          end
        end
        object cxGroupBox15: TcxGroupBox
          Left = 0
          Top = 247
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 9
          Height = 27
          Width = 950
          object CampoLibre10Ctrl: TcxDBSpinEdit
            Left = 157
            Top = 1
            CaptionLabel = cxLabel1
            DataBinding.DataField = 'CampoLibre10'
            DataBinding.DataSource = ArticuloDataSource
            Properties.DisplayFormat = '#'
            TabOrder = 0
            Width = 91
          end
          object cxLabel1: TcxLabel
            Left = 10
            Top = 4
            TabStop = False
            Caption = 'Campo 10'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object cxGroupBox16: TcxGroupBox
          Left = 0
          Top = 274
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 10
          Height = 27
          Width = 950
          object CampoLibre11Ctrl: TcxDBSpinEdit
            Left = 157
            Top = 1
            CaptionLabel = cxLabel2
            DataBinding.DataField = 'CampoLibre11'
            DataBinding.DataSource = ArticuloDataSource
            Properties.DisplayFormat = '#'
            TabOrder = 0
            Width = 91
          end
          object cxLabel2: TcxLabel
            Left = 10
            Top = 4
            TabStop = False
            Caption = 'Campo 11'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object cxGroupBox3: TcxGroupBox
          Left = 0
          Top = 328
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 12
          Height = 27
          Width = 950
          object CampoLibre13Ctrl: TcxDBTextEdit
            Left = 157
            Top = 1
            CaptionLabel = cxLabel9
            DataBinding.DataField = 'CampoLibre13'
            DataBinding.DataSource = ArticuloDataSource
            TabOrder = 0
            Width = 350
          end
          object cxLabel9: TcxLabel
            Left = 10
            Top = 4
            TabStop = False
            Caption = 'Campo 13'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object cxGroupBox17: TcxGroupBox
          Left = 0
          Top = 355
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 13
          Height = 27
          Width = 950
          object CampoLibre14Ctrl: TcxDBTextEdit
            Left = 157
            Top = 1
            CaptionLabel = cxLabel10
            DataBinding.DataField = 'CampoLibre14'
            DataBinding.DataSource = ArticuloDataSource
            TabOrder = 0
            Width = 350
          end
          object cxLabel10: TcxLabel
            Left = 10
            Top = 4
            TabStop = False
            Caption = 'Campo 14'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object cxGroupBox32: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 31
          Width = 950
          object CampoLibre1Ctrl: TcxDBTextEdit
            Left = 157
            Top = 5
            CaptionLabel = cxLabel16
            DataBinding.DataField = 'CampoLibre1'
            DataBinding.DataSource = ArticuloDataSource
            TabOrder = 0
            Width = 350
          end
          object cxLabel16: TcxLabel
            Left = 10
            Top = 8
            TabStop = False
            Caption = 'Campo 1'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
        object cxGroupBox33: TcxGroupBox
          Left = 0
          Top = 31
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 1
          Height = 27
          Width = 950
          object CampoLibre2Ctrl: TcxDBTextEdit
            Left = 157
            Top = 1
            CaptionLabel = cxLabel17
            DataBinding.DataField = 'CampoLibre2'
            DataBinding.DataSource = ArticuloDataSource
            TabOrder = 0
            Width = 350
          end
          object cxLabel17: TcxLabel
            Left = 10
            Top = 4
            TabStop = False
            Caption = 'Campo 2'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 1
            Transparent = True
          end
        end
      end
      object RelacionesTabSheet: TcxTabSheet
        Caption = 'Relaciones'
        ImageIndex = 10
        object cxSplitter1: TcxSplitter
          Left = 0
          Top = 0
          Width = 950
          Height = 8
          HotZoneClassName = 'TcxSimpleStyle'
          AlignSplitter = salTop
        end
      end
      object TarifaComprasTabSheet: TcxTabSheet
        Caption = 'Tarifas de c&ompra'
        ImageIndex = 8
        DesignSize = (
          950
          482)
        object GridTableViewController2: TGridTableViewController
          Left = 912
          Top = 0
          Align = alRight
          Enabled = False
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TransparentBorder = False
          TabOrder = 0
          Visible = False
          TableView = TarifaComprasTableView
          ShiftRecords = False
          UseGridFilterBox = False
          Height = 482
          Width = 38
        end
        object TarifaComprasGrid: TcxGrid
          Left = 0
          Top = 0
          Width = 912
          Height = 482
          Align = alClient
          TabOrder = 1
          object TarifaComprasTableView: TcxGridDBTableView
            Tag = 585561968
            Navigator.Buttons.CustomButtons = <>
            FindPanel.DisplayMode = fpdmAlways
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataModeController.SmartRefresh = True
            DataController.DataSource = TarifaComprasDataSource
            DataController.KeyFieldNames = 'Codigo'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnHidingOnGrouping = False
            OptionsCustomize.ColumnHorzSizing = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            object TarifaComprasTableViewCodigo: TcxGridDBColumn
              DataBinding.FieldName = 'Codigo'
              Options.Editing = False
            end
            object TarifaComprasTableViewNombre: TcxGridDBColumn
              DataBinding.FieldName = 'Nombre'
              Options.Editing = False
              Width = 220
            end
            object TarifaComprasTableViewReferencia: TcxGridDBColumn
              DataBinding.FieldName = 'Referencia'
              Width = 110
            end
            object TarifaComprasTableViewPrecio: TcxGridDBColumn
              DataBinding.FieldName = 'Precio'
            end
            object TarifaComprasTableViewDescuento: TcxGridDBColumn
              Caption = '% Dto.'
              DataBinding.FieldName = 'Descuento'
              Width = 50
            end
          end
          object TarifaComprasGridLevel: TcxGridLevel
            GridView = TarifaComprasTableView
          end
        end
        object MostrarProveedoresConDatosCtrl: TcxCheckBox
          Left = 658
          Top = 15
          Anchors = [akTop, akRight]
          Caption = 'Mostrar solo proveedores con datos'
          Properties.OnEditValueChanged = MostrarProveedoresConDatosCtrlPropertiesEditValueChanged
          Style.TransparentBorder = False
          TabOrder = 2
          Transparent = True
        end
      end
      object TarifaVentasTabSheet: TcxTabSheet
        Caption = 'Tarifas de &venta'
        ImageIndex = 4
      end
      object FabricacionTabSheet: TcxTabSheet
        Caption = '&Fabricaci'#243'n'
        ImageIndex = 3
        object FabricacionGroupBox: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 39
          Width = 950
          object CalcularPreciosCtrl: TcxDBCheckBox
            Left = 3
            Top = 10
            AutoSize = False
            Caption = 'Calcular precio de coste'
            DataBinding.DataField = 'CalcularPrecios'
            DataBinding.DataSource = ArticuloDataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            TabOrder = 0
            Transparent = True
            Height = 23
            Width = 171
          end
        end
        object ParametrosGroupBox: TcxGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 42
          Align = alTop
          Caption = 'Par'#225'metros'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 1
          Visible = False
          Height = 147
          Width = 944
          object ParametrosCtrl: TcxDBCheckGroup
            AlignWithMargins = True
            Left = 5
            Top = 20
            Margins.Top = 18
            Align = alLeft
            Alignment = alCenterCenter
            ParentFont = False
            Properties.Columns = 3
            Properties.EditValueFormat = cvfInteger
            Properties.Items = <>
            Style.BorderStyle = ebsNone
            Style.Edges = [bLeft, bRight, bBottom]
            Style.TransparentBorder = False
            TabOrder = 0
            Transparent = True
            DataBinding.DataField = 'Parametros'
            DataBinding.DataSource = ArticuloDataSource
            Height = 122
            Width = 404
          end
        end
      end
      object TiendaVirtualTabSheet: TcxTabSheet
        Caption = 'Tienda virtual'
        ImageIndex = 9
        object ClasesArticuloPanel: TcxGroupBox
          Left = 0
          Top = 0
          Align = alClient
          Alignment = alCenterCenter
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 482
          Width = 950
        end
      end
    end
    object Panel2: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = True
      TabOrder = 0
      DesignSize = (
        958
        32)
      Height = 32
      Width = 958
      object DescripcionCtrl: TcxDBTextEdit
        Left = 157
        Top = 3
        Anchors = [akLeft, akTop, akRight]
        DataBinding.DataField = 'Descripcion'
        DataBinding.DataSource = ArticuloDataSource
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Width = 759
      end
      object Label19: TcxLabel
        Left = 9
        Top = 7
        TabStop = False
        Caption = 'Descripci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = ArticuloTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    AfterValidateDataArea = FormManagerAfterValidateDataArea
    OnInitializeForm = FormManagerInitializeForm
    OnCopyCurrentRecord = FormManagerCopyCurrentRecord
    OnReportRequest = FormManagerReportRequest
    OnLabelsRequest = FormManagerLabelsRequest
    OnInsertRecRequest = FormManagerInsertRecRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    OnUpdateButtonsState = FormManagerUpdateButtonsState
    Left = 912
    Top = 3
  end
  object ArticuloTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    AfterEdit = ArticuloTableAfterEdit
    BeforePost = ArticuloTableBeforePost
    BeforeDelete = ArticuloTableBeforeDelete
    OnNewRecord = ArticuloTableNewRecord
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    AutoIncFieldName = 'Codigo'
    OnGetRecord = ArticuloTableGetRecord
    Left = 838
    Top = 2
  end
  object ArticuloDataSource: TDataSource
    DataSet = ArticuloTable
    Left = 804
    Top = 3
  end
  object TarifaComprasDataSource: TDataSource
    DataSet = TarifaComprasCachedDataSet
    Enabled = False
    Left = 803
    Top = 119
  end
  object TarifaComprasCachedDataSet: TnxeCachedDataSet
    Database = SessionDataModule.InMemoryDatabase
    Options = [cdsoSetVisibleFields]
    BeforePost = TarifaComprasCachedDataSetBeforePost
    SourceDataSet = TarifaComprasQuery
    Left = 838
    Top = 119
    object TarifaComprasCachedDataSetCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object TarifaComprasCachedDataSetNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object TarifaComprasCachedDataSetTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object TarifaComprasCachedDataSetCodigoProveedor: TWideStringField
      FieldName = 'CodigoProveedor'
      Size = 5
    end
    object TarifaComprasCachedDataSetCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object TarifaComprasCachedDataSetReferencia: TWideStringField
      FieldName = 'Referencia'
    end
    object TarifaComprasCachedDataSetPrecio: TFloatField
      FieldName = 'Precio'
    end
    object TarifaComprasCachedDataSetDescuento: TBCDField
      FieldName = 'Descuento'
    end
  end
  object TarifaComprasQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    BeforeOpen = TarifaComprasQueryBeforeOpen
    AfterOpen = TarifaComprasQueryAfterOpen
    DataSource = ArticuloDataSource
    SQL.Strings = (
      'SELECT Proveedor.Codigo,'
      '       Proveedor.Nombre,'
      '       TarifaCompras.*'
      
        'FROM   Proveedor LEFT JOIN TarifaCompras ON ( Tipo=0 AND TarifaC' +
        'ompras.CodigoProveedor=Proveedor.Codigo AND TarifaCompras.Codigo' +
        'Articulo=:Codigo )'
      
        'WHERE  :TodosLosProveedores OR ( TarifaCompras.Referencia<>'#39#39' OR' +
        ' TarifaCompras.Precio<>0.0 OR TarifaCompras.Descuento<>0.0 )'
      'ORDER BY Proveedor.Codigo')
    OpenOnMasterActivation = False
    Left = 872
    Top = 119
    ParamData = <
      item
        DataType = ftWideString
        Name = 'Codigo'
        ParamType = ptUnknown
        Size = 20
      end
      item
        DataType = ftBoolean
        Name = 'TodosLosProveedores'
        ParamType = ptUnknown
        Value = True
      end>
  end
  object TarifaComprasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaCompras'
    IndexFieldNames = 'Tipo;CodigoArticulo;CodigoProveedor'
    Left = 906
    Top = 119
  end
  object ExistenciasArticuloQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    AfterOpen = ExistenciasArticuloQueryAfterOpen
    DataSource = ArticuloDataSource
    SQL.Strings = (
      'SELECT Almacen.Codigo AS CodigoAlmacen,'
      '       Almacen.Nombre AS NombreAlmacen,'
      '       ExistenciasArticulo.Ubicacion,'
      '       ExistenciasArticulo.StockMinimo,'
      '       ExistenciasArticulo.StockMaximo'
      
        'FROM   Almacen LEFT JOIN ExistenciasArticulo ON ( CodigoArticulo' +
        '=:Codigo AND ExistenciasArticulo.CodigoAlmacen=Almacen.Codigo )'
      'ORDER  BY CodigoAlmacen')
    OpenOnMasterActivation = False
    Left = 872
    Top = 151
    ParamData = <
      item
        DataType = ftString
        Name = 'Codigo'
        ParamType = ptUnknown
        Size = 20
      end>
  end
  object ExistenciasArticuloCachedDataSet: TnxeCachedDataSet
    Database = SessionDataModule.InMemoryDatabase
    Options = [cdsoSetVisibleFields]
    BeforePost = ExistenciasArticuloCachedDataSetBeforePost
    SourceDataSet = ExistenciasArticuloQuery
    Left = 838
    Top = 151
    object ExistenciasArticuloCachedDataSetCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object ExistenciasArticuloCachedDataSetNombreAlmacen: TWideStringField
      FieldName = 'NombreAlmacen'
      Size = 30
    end
    object ExistenciasArticuloCachedDataSetUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 10
    end
    object ExistenciasArticuloCachedDataSetStockMinimo: TBCDField
      FieldName = 'StockMinimo'
      Precision = 16
    end
    object ExistenciasArticuloCachedDataSetStockMaximo: TBCDField
      FieldName = 'StockMaximo'
      Precision = 16
    end
  end
  object ExistenciasArticuloDataSource: TDataSource
    DataSet = ExistenciasArticuloCachedDataSet
    Enabled = False
    Left = 803
    Top = 151
  end
  object ExistenciasArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ExistenciasArticulo'
    IndexFieldNames = 'CodigoArticulo;CodigoAlmacen'
    Left = 906
    Top = 151
  end
  object BarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
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
    Left = 803
    Top = 185
    PixelsPerInch = 96
    object ListaoArticulosItem: TdxBarButton
      Caption = 'Listado de art'#237'culos'
      Category = 0
      Hint = 'Listado de art'#237'culos'
      Visible = ivAlways
      OnClick = ListaoArticulosItemClick
    end
    object ListadoUbicacionesStocksItem: TdxBarButton
      Caption = 'Listado de stocks m'#237'nimos/m'#225'ximos y ubicaciones de art'#237'culos'
      Category = 1
      Hint = 'Listado de stocks m'#237'nimos/m'#225'ximos y ubicaciones de art'#237'culos'
      Visible = ivAlways
      OnClick = ListadoUbicacionesStocksItemClick
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
        ItemName = 'ListaoArticulosItem'
      end
      item
        Visible = True
        ItemName = 'ListadoUbicacionesStocksItem'
      end>
    UseOwnFont = True
    Left = 838
    Top = 186
    PixelsPerInch = 96
  end
  object StyleRepository: TcxStyleRepository
    Left = 804
    Top = 232
    PixelsPerInch = 96
    object SelectionStyle: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 16511466
      TextColor = clCaptionText
    end
  end
end
