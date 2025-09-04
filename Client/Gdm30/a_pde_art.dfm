object BoxPdeArtForm: TBoxPdeArtForm
  Left = 402
  Top = 251
  HelpType = htKeyword
  HelpKeyword = 'a_pde'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Configuraci'#243'n de empresas - Art'#237'culos'
  ClientHeight = 349
  ClientWidth = 768
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 313
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      768
      36)
    Height = 36
    Width = 768
    object Panel2: TcxGroupBox
      Left = 296
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 174
      object OkButton: TgBitBtn
        Left = 0
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
  object Panel1: TgxEditPanel
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
    Height = 308
    Width = 758
    object PageControl: TcxPageControl
      Tag = 1
      Left = 2
      Top = 2
      Width = 754
      Height = 304
      Align = alClient
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = ArticulosTS
      Properties.CustomButtons.Buttons = <>
      Properties.MultiLine = True
      ClientRectBottom = 300
      ClientRectLeft = 4
      ClientRectRight = 750
      ClientRectTop = 28
      object ArticulosTS: TcxTabSheet
        Caption = 'General'
        object cxGroupBox10: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Transparent = True
          Height = 235
          Width = 746
          object CajasCtrl: TcxDBCheckBox
            Left = 12
            Top = 6
            Caption = 'Ca&jas'
            DataBinding.DataField = 'Articulo_Cajas'
            DataBinding.DataSource = DataSource
            Properties.OnValuePosted = Articulo_ClaseCtrlPropertiesValuePosted
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 0
            Transparent = True
          end
          object PalletsCtrl: TcxDBCheckBox
            Left = 12
            Top = 28
            Caption = '"&Pallets"'
            DataBinding.DataField = 'Articulo_Pallets'
            DataBinding.DataSource = DataSource
            Properties.NullStyle = nssUnchecked
            TabOrder = 1
            Transparent = True
          end
          object BultosCtrl: TcxDBCheckBox
            Left = 12
            Top = 50
            Caption = 'Bultos / Kilos / Volumen'
            DataBinding.DataField = 'Articulo_Bultos'
            DataBinding.DataSource = DataSource
            Properties.NullStyle = nssUnchecked
            TabOrder = 2
            Transparent = True
          end
          object Articulo_SoloCodificadosCtrl: TcxDBCheckBox
            Left = 12
            Top = 71
            Caption = 'Permitir solo art'#237'culos codificados'
            DataBinding.DataField = 'Articulo_SoloCodificados'
            DataBinding.DataSource = DataSource
            Properties.NullStyle = nssUnchecked
            TabOrder = 3
            Transparent = True
          end
          object Articulo_MargenSobrePrecioCompraCtrl: TcxDBCheckBox
            Left = 313
            Top = 28
            Caption = 'Calcular el margen comercial a partir del precio de compra'
            DataBinding.DataField = 'Articulo_MargenSobrePrecioCompra'
            DataBinding.DataSource = DataSource
            Properties.NullStyle = nssUnchecked
            TabOrder = 7
            Transparent = True
          end
          object Articulo_EditarMedidasCtrl: TcxDBCheckBox
            Left = 313
            Top = 6
            Hint = 
              'Permite editar las medidas en la ficha aunque no est'#233' activado e' +
              'l largo, ancho o alto en las operaciones de compra o venta.'
            Caption = 'Permitir editar las medidas en la ficha del art'#237'culo'
            DataBinding.DataField = 'Articulo_EditarMedidas'
            DataBinding.DataSource = DataSource
            Properties.NullStyle = nssUnchecked
            TabOrder = 6
            Transparent = True
          end
          object Articulo_DtosCompraEnMargenesCtrl: TcxDBCheckBox
            Left = 313
            Top = 50
            Hint = 
              'Si activa esta opci'#243'n, y calcula sus precios de venta aplicando ' +
              'un margen comercial en la ficha del art'#237'culo, debe tener en cuen' +
              'ta que mayores descuentos  de compra suponen m'#225'rgenes de benefic' +
              'io menores con el mismo precio base del art'#237'culo.'
            Caption = 
              'Incluir el descuento de compra en el c'#225'lculo del margen comercia' +
              'l'
            DataBinding.DataField = 'Articulo_DtosCompraEnMargenes'
            DataBinding.DataSource = DataSource
            ParentShowHint = False
            Properties.NullStyle = nssUnchecked
            ShowHint = True
            TabOrder = 8
            Transparent = True
          end
          object Articulo_StockMinMaxPorAlmacenCtrl: TcxDBCheckBox
            Left = 313
            Top = 71
            Caption = 'Stocks m'#237'nimos/m'#225'ximos y ubicaciones por almac'#233'n'
            DataBinding.DataField = 'Articulo_StockMinMaxPorAlmacen'
            DataBinding.DataSource = DataSource
            ParentShowHint = False
            Properties.NullStyle = nssUnchecked
            ShowHint = True
            TabOrder = 9
            Transparent = True
          end
          object Articulo_PreciosIVACtrl: TcxDBCheckBox
            Left = 313
            Top = 92
            Caption = 'Precios de venta con I.V.A. incluido'
            DataBinding.DataField = 'Articulo_PreciosIVA'
            DataBinding.DataSource = DataSource
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            Properties.OnChange = Articulo_PreciosIVACtrlPropertiesChange
            TabOrder = 10
            Transparent = True
          end
          object Articulo_PuntoVerdeCtrl: TcxDBCheckBox
            Left = 12
            Top = 92
            Caption = 'EcoRAEE / Ecotasa'
            DataBinding.DataField = 'Articulo_PuntoVerde'
            DataBinding.DataSource = DataSource
            Properties.NullStyle = nssUnchecked
            TabOrder = 4
            Transparent = True
          end
          object Articulo_UnidadesPorPrecioCtrl: TcxDBCheckBox
            Left = 313
            Top = 113
            Hint = 
              'Permite fijar las unidades a las que se aplica el precio de comp' +
              'ra o venta indicado en la ficha del art'#237'culo.'
            Caption = 'Unidades por precio de compra y venta'
            DataBinding.DataField = 'Articulo_UnidadesPorPrecio'
            DataBinding.DataSource = DataSource
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 11
            Transparent = True
          end
          object ArticulosRelacionadosCtrl: TcxDBCheckBox
            Left = 313
            Top = 134
            Caption = 'Art'#237'culos relacionados y alternativos o equivalentes'
            DataBinding.DataField = 'Articulo_ArticulosRelacionados'
            DataBinding.DataSource = DataSource
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 12
            Transparent = True
          end
          object ContribucionRAPCtrl: TcxDBCheckBox
            Left = 12
            Top = 113
            Caption = 'Contribucion RAP repercutida en el art'#237'culo'
            DataBinding.DataField = 'Articulo_ContribucionRAPRepercutida'
            DataBinding.DataSource = DataSource
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = True
            TabOrder = 5
            Transparent = True
          end
        end
      end
      object ClasesTS: TcxTabSheet
        Caption = 'Clases'
        ImageIndex = 1
        object cxGroupBox5: TcxGroupBox
          AlignWithMargins = True
          Left = 6
          Top = 3
          Margins.Left = 6
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 0
          Transparent = True
          Height = 142
          Width = 737
          object Articulo_ClaseACtrl: TcxDBCheckBox
            Left = 2
            Top = 10
            Caption = 'Clase A'
            DataBinding.DataField = 'Articulo_ExisteClase1'
            DataBinding.DataSource = DataSource
            Properties.OnValuePosted = Articulo_ClaseCtrlPropertiesValuePosted
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = Articulo_ClaseACtrlPropertiesEditValueChanged
            TabOrder = 0
            Transparent = True
          end
          object Articulo_NombreClase1Ctrl: TcxDBTextEdit
            Left = 86
            Top = 10
            DataBinding.DataField = 'Articulo_NombreClase1'
            DataBinding.DataSource = DataSource
            Properties.OnValuePosted = Articulo_ClaseCtrlPropertiesValuePosted
            TabOrder = 1
            Width = 81
          end
          object Articulo_NombreClase2Ctrl: TcxDBTextEdit
            Left = 86
            Top = 37
            DataBinding.DataField = 'Articulo_NombreClase2'
            DataBinding.DataSource = DataSource
            Properties.OnValuePosted = Articulo_ClaseCtrlPropertiesValuePosted
            TabOrder = 3
            Width = 81
          end
          object Articulo_ClaseBCtrl: TcxDBCheckBox
            Left = 2
            Top = 37
            Caption = 'Clase B'
            DataBinding.DataField = 'Articulo_ExisteClase2'
            DataBinding.DataSource = DataSource
            Properties.OnValuePosted = Articulo_ClaseCtrlPropertiesValuePosted
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = Articulo_ClaseBCtrlPropertiesEditValueChanged
            TabOrder = 2
            Transparent = True
          end
          object Articulo_NombreClase3Ctrl: TcxDBTextEdit
            Left = 86
            Top = 64
            DataBinding.DataField = 'Articulo_NombreClase3'
            DataBinding.DataSource = DataSource
            Properties.OnValuePosted = Articulo_ClaseCtrlPropertiesValuePosted
            TabOrder = 5
            Width = 81
          end
          object Articulo_ClaseCCtrl: TcxDBCheckBox
            Left = 2
            Top = 64
            Caption = 'Clase C'
            DataBinding.DataField = 'Articulo_ExisteClase3'
            DataBinding.DataSource = DataSource
            Properties.OnValuePosted = Articulo_ClaseCtrlPropertiesValuePosted
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = Articulo_ClaseCCtrlPropertiesEditValueChanged
            TabOrder = 4
            Transparent = True
          end
          object cxLabel6: TcxLabel
            Left = 260
            Top = 14
            TabStop = False
            Caption = 'Envase'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 11
            Transparent = True
          end
          object Articulo_EnvaseCtrl: TcxDBIndexedComboBox
            Left = 340
            Top = 10
            CaptionLabel = cxLabel6
            DataBinding.DataField = 'Articulo_Envase'
            DataBinding.DataSource = DataSource
            Properties.OnValuePosted = Articulo_EnvaseCtrlPropertiesValuePosted
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.ImmediatePost = True
            Properties.ImmediateUpdateText = True
            Properties.Items.Strings = (
              '<Ninguno>'
              'Clase A'
              'Clase B'
              'Clase C')
            TabOrder = 7
            Width = 94
          end
          object cxLabel7: TcxLabel
            Left = 260
            Top = 67
            TabStop = False
            AutoSize = False
            Caption = 
              'Solo puede activar estas opciones si dispone del m'#243'dulo opcional' +
              ' de gesti'#243'n de envases y contenedores y utiliza cajas en el caso' +
              ' de los envases.'
            Style.TextColor = clGrayText
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.WordWrap = True
            TabOrder = 13
            Transparent = True
            Height = 40
            Width = 479
          end
          object cxLabel8: TcxLabel
            Left = 449
            Top = 14
            TabStop = False
            Caption = 'Tipo de envase'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 14
            Transparent = True
          end
          object Articulo_TipoEnvaseCtrl: TcxDBIndexedComboBox
            Left = 577
            Top = 10
            CaptionLabel = cxLabel8
            DataBinding.DataField = 'Articulo_TipoEnvase'
            DataBinding.DataSource = DataSource
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'Reutilizable'
              'Desechable')
            TabOrder = 8
            Width = 106
          end
          object Articulo_PermitirModificarPesoCtrl: TcxDBCheckBox
            Left = 260
            Top = 109
            Caption = 'Permitir modificar el peso del envase en los documentos'
            DataBinding.DataField = 'Articulo_PermitirModificarPeso'
            DataBinding.DataSource = DataSource
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            Properties.OnChange = Articulo_PreciosIVACtrlPropertiesChange
            TabOrder = 12
            Transparent = True
          end
          object Articulo_TarifaClaseCtrl: TcxDBCheckBox
            Left = 2
            Top = 90
            Caption = 'Tarifas por clases'
            DataBinding.DataField = 'Articulo_TarifaClase'
            DataBinding.DataSource = DataSource
            Properties.NullStyle = nssUnchecked
            TabOrder = 6
            Transparent = True
          end
          object cxLabel3: TcxLabel
            Left = 260
            Top = 41
            TabStop = False
            Caption = 'Contenedor'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 15
            Transparent = True
          end
          object Articulo_ContenedorCtrl: TcxComboBox
            Left = 340
            Top = 37
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.ImmediatePost = True
            Properties.ImmediateUpdateText = True
            Properties.Items.Strings = (
              '<Ninguno>'
              'ClaseA'
              'ClaseB'
              'ClaseC')
            Style.TransparentBorder = True
            TabOrder = 9
            Text = '<Ninguno>'
            Width = 94
          end
          object cxLabel4: TcxLabel
            Left = 449
            Top = 40
            TabStop = False
            Caption = 'Tipo de contenedor'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 16
            Transparent = True
          end
          object Articulo_TipoContenedorCtrl: TcxDBIndexedComboBox
            Left = 577
            Top = 36
            CaptionLabel = cxLabel4
            DataBinding.DataField = 'Articulo_TipoContenedor'
            DataBinding.DataSource = DataSource
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'Reutilizable'
              'Desechable')
            TabOrder = 10
            Width = 106
          end
        end
      end
      object CamposLibresTS: TcxTabSheet
        Caption = 'Campos de libre configuraci'#243'n'
        ImageIndex = 2
        object CamposLibresArticuloGroupBox: TcxGroupBox
          AlignWithMargins = True
          Left = 20
          Top = 32
          Margins.Left = 6
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 1
          Transparent = True
          Height = 239
          Width = 723
          object Articulo_CampoLibre1Ctrl: TcxDBTextEdit
            Left = 41
            Top = 4
            DataBinding.DataField = 'Articulo_CampoLibre1'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 0
            Width = 116
          end
          object Articulo_CampoLibre2Ctrl: TcxDBTextEdit
            Left = 41
            Top = 31
            DataBinding.DataField = 'Articulo_CampoLibre2'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 2
            Width = 116
          end
          object Articulo_CampoLibre3Ctrl: TcxDBTextEdit
            Left = 41
            Top = 58
            DataBinding.DataField = 'Articulo_CampoLibre3'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 4
            Width = 116
          end
          object Articulo_CampoLibre4Ctrl: TcxDBTextEdit
            Left = 41
            Top = 85
            DataBinding.DataField = 'Articulo_CampoLibre4'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 6
            Width = 116
          end
          object Articulo_CampoLib1ObligCtrl: TcxDBCheckBox
            Left = 165
            Top = 4
            CaptionLabel = cxLabel12
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Articulo_CampoLibOblig1'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 1
            Transparent = True
          end
          object Articulo_CampoLib2ObligCtrl: TcxDBCheckBox
            Left = 165
            Top = 31
            CaptionLabel = cxLabel13
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Articulo_CampoLibOblig2'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 3
            Transparent = True
          end
          object Articulo_CampoLib3ObligCtrl: TcxDBCheckBox
            Left = 165
            Top = 58
            CaptionLabel = cxLabel14
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Articulo_CampoLibOblig3'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 5
            Transparent = True
          end
          object Articulo_CampoLib4ObligCtrl: TcxDBCheckBox
            Left = 165
            Top = 85
            CaptionLabel = cxLabel15
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Articulo_CampoLibOblig4'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 7
            Transparent = True
          end
          object Articulo_CampoLibre5Ctrl: TcxDBTextEdit
            Left = 41
            Top = 112
            DataBinding.DataField = 'Articulo_CampoLibre5'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 8
            Width = 116
          end
          object Articulo_CampoLib5ObligCtrl: TcxDBCheckBox
            Left = 165
            Top = 112
            CaptionLabel = cxLabel16
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Articulo_CampoLibOblig5'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 9
            Transparent = True
          end
          object Articulo_CampoLibre6Ctrl: TcxDBTextEdit
            Left = 41
            Top = 139
            DataBinding.DataField = 'Articulo_CampoLibre6'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 10
            Width = 116
          end
          object Articulo_CampoLib6ObligCtrl: TcxDBCheckBox
            Left = 165
            Top = 139
            CaptionLabel = cxLabel17
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Articulo_CampoLibOblig6'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 11
            Transparent = True
          end
          object Articulo_CampoLibre7Ctrl: TcxDBTextEdit
            Left = 41
            Top = 166
            DataBinding.DataField = 'Articulo_CampoLibre7'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 12
            Width = 116
          end
          object Articulo_CampoLib7ObligCtrl: TcxDBCheckBox
            Left = 165
            Top = 166
            CaptionLabel = cxLabel18
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Articulo_CampoLibOblig7'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 13
            Transparent = True
          end
          object Articulo_CampoLibre8Ctrl: TcxDBTextEdit
            Left = 41
            Top = 193
            DataBinding.DataField = 'Articulo_CampoLibre8'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 14
            Width = 116
          end
          object Articulo_CampoLib8ObligCtrl: TcxDBCheckBox
            Left = 165
            Top = 193
            CaptionLabel = cxLabel19
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Articulo_CampoLibOblig8'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 15
            Transparent = True
          end
          object Articulo_CampoLibre9Ctrl: TcxDBTextEdit
            Left = 335
            Top = 4
            DataBinding.DataField = 'Articulo_CampoLibre9'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 16
            Width = 116
          end
          object Articulo_CampoLib9ObligCtrl: TcxDBCheckBox
            Left = 459
            Top = 4
            CaptionLabel = cxLabel20
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Articulo_CampoLibOblig9'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 17
            Transparent = True
          end
          object Label50: TcxLabel
            Left = 23
            Top = 7
            TabStop = False
            Caption = '1.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 24
            Transparent = True
          end
          object Label51: TcxLabel
            Left = 23
            Top = 35
            TabStop = False
            Caption = '2.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 25
            Transparent = True
          end
          object Label52: TcxLabel
            Left = 22
            Top = 62
            TabStop = False
            Caption = '3.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 26
            Transparent = True
          end
          object Label53: TcxLabel
            Left = 22
            Top = 89
            TabStop = False
            Caption = '4.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 27
            Transparent = True
          end
          object Label29: TcxLabel
            Left = 22
            Top = 116
            TabStop = False
            Caption = '5.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 28
            Transparent = True
          end
          object Label31: TcxLabel
            Left = 22
            Top = 143
            TabStop = False
            Caption = '6.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 29
            Transparent = True
          end
          object Label33: TcxLabel
            Left = 22
            Top = 170
            TabStop = False
            Caption = '7.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 30
            Transparent = True
          end
          object Label34: TcxLabel
            Left = 22
            Top = 196
            TabStop = False
            Caption = '8.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 31
            Transparent = True
          end
          object Label35: TcxLabel
            Left = 316
            Top = 7
            TabStop = False
            Caption = '9.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 32
            Transparent = True
          end
          object Articulo_CampoLibre10Ctrl: TcxDBTextEdit
            Left = 335
            Top = 31
            DataBinding.DataField = 'Articulo_CampoLibre10'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 19
            Width = 116
          end
          object Articulo_CampoLib10ObligCtrl: TcxDBCheckBox
            Left = 459
            Top = 31
            CaptionLabel = cxLabel21
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Articulo_CampoLibOblig10'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 20
            Transparent = True
          end
          object Articulo_CampoLibre11Ctrl: TcxDBTextEdit
            Left = 335
            Top = 58
            DataBinding.DataField = 'Articulo_CampoLibre11'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 21
            Width = 116
          end
          object Articulo_CampoLib11ObligCtrl: TcxDBCheckBox
            Left = 459
            Top = 58
            CaptionLabel = cxLabel22
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Articulo_CampoLibOblig11'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 22
            Transparent = True
          end
          object Articulo_CampoLibre12Ctrl: TcxDBTextEdit
            Left = 335
            Top = 85
            DataBinding.DataField = 'Articulo_CampoLibre12'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 33
            Width = 116
          end
          object Articulo_CampoLib12ObligCtrl: TcxDBCheckBox
            Left = 459
            Top = 85
            CaptionLabel = cxLabel23
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Articulo_CampoLibOblig12'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 23
            Transparent = True
          end
          object cxLabel9: TcxLabel
            Left = 310
            Top = 35
            TabStop = False
            Caption = '10.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 34
            Transparent = True
          end
          object cxLabel10: TcxLabel
            Left = 310
            Top = 62
            TabStop = False
            Caption = '11.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 35
            Transparent = True
          end
          object cxLabel11: TcxLabel
            Left = 310
            Top = 89
            TabStop = False
            Caption = '12.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 36
            Transparent = True
          end
          object cxLabel12: TcxLabel
            Left = 263
            Top = 7
            TabStop = False
            Caption = 'C40'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 37
            Transparent = True
          end
          object cxLabel13: TcxLabel
            Left = 263
            Top = 35
            TabStop = False
            Caption = 'C40'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 38
            Transparent = True
          end
          object cxLabel14: TcxLabel
            Left = 263
            Top = 61
            TabStop = False
            Caption = 'C40'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 39
            Transparent = True
          end
          object cxLabel15: TcxLabel
            Left = 263
            Top = 88
            TabStop = False
            Caption = 'C40'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 40
            Transparent = True
          end
          object cxLabel16: TcxLabel
            Left = 264
            Top = 115
            TabStop = False
            Caption = 'D'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 41
            Transparent = True
          end
          object cxLabel17: TcxLabel
            Left = 263
            Top = 142
            TabStop = False
            Caption = 'D'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 42
            Transparent = True
          end
          object cxLabel18: TcxLabel
            Left = 263
            Top = 169
            TabStop = False
            Caption = 'D'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 43
            Transparent = True
          end
          object cxLabel19: TcxLabel
            Left = 263
            Top = 196
            TabStop = False
            Caption = 'D'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 44
            Transparent = True
          end
          object cxLabel20: TcxLabel
            Left = 558
            Top = 7
            TabStop = False
            Caption = 'L'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 45
            Transparent = True
          end
          object cxLabel21: TcxLabel
            Left = 558
            Top = 35
            TabStop = False
            Caption = 'E'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 46
            Transparent = True
          end
          object cxLabel22: TcxLabel
            Left = 558
            Top = 62
            TabStop = False
            Caption = 'E'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 47
            Transparent = True
          end
          object cxLabel23: TcxLabel
            Left = 558
            Top = 89
            TabStop = False
            Caption = 'E'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 48
            Transparent = True
          end
          object Articulo_CampoLibre13Ctrl: TcxDBTextEdit
            Left = 335
            Top = 112
            DataBinding.DataField = 'Articulo_CampoLibre13'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 49
            Width = 116
          end
          object cxDBCheckBox1: TcxDBCheckBox
            Left = 459
            Top = 112
            CaptionLabel = cxLabel50
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Articulo_CampoLibOblig1'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 50
            Transparent = True
          end
          object cxLabel48: TcxLabel
            Left = 310
            Top = 116
            TabStop = False
            Caption = '13.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 51
            Transparent = True
          end
          object cxLabel50: TcxLabel
            Left = 558
            Top = 116
            TabStop = False
            Caption = 'C40'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 52
            Transparent = True
          end
          object Articulo_CampoLibre14Ctrl: TcxDBTextEdit
            Left = 335
            Top = 139
            DataBinding.DataField = 'Articulo_CampoLibre14'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 53
            Width = 116
          end
          object cxDBCheckBox2: TcxDBCheckBox
            Left = 459
            Top = 139
            CaptionLabel = cxLabel51
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Articulo_CampoLibOblig1'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 54
            Transparent = True
          end
          object cxLabel49: TcxLabel
            Left = 310
            Top = 143
            TabStop = False
            Caption = '14.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 55
            Transparent = True
          end
          object cxLabel51: TcxLabel
            Left = 558
            Top = 142
            TabStop = False
            Caption = 'C40'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 56
            Transparent = True
          end
          object Articulo_CampoLibre15Ctrl: TcxDBTextEdit
            Left = 335
            Top = 166
            DataBinding.DataField = 'Articulo_CampoLibre15'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 57
            Width = 116
          end
          object cxDBCheckBox3: TcxDBCheckBox
            Left = 459
            Top = 166
            CaptionLabel = cxLabel53
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Articulo_CampoLibOblig1'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            TabOrder = 58
            Transparent = True
          end
          object cxLabel52: TcxLabel
            Left = 310
            Top = 170
            TabStop = False
            Caption = '15.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 61
            Transparent = True
          end
          object cxLabel53: TcxLabel
            Left = 558
            Top = 170
            TabStop = False
            Caption = 'M'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 62
            Transparent = True
          end
          object Articulo_CampoLibre16Ctrl: TcxDBTextEdit
            Left = 335
            Top = 193
            DataBinding.DataField = 'Articulo_CampoLibre16'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 59
            Width = 116
          end
          object cxDBCheckBox4: TcxDBCheckBox
            Left = 459
            Top = 193
            CaptionLabel = cxLabel2
            Caption = 'Obligatorio'
            DataBinding.DataField = 'Articulo_CampoLibOblig1'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = True
            TabOrder = 60
            Transparent = True
          end
          object cxLabel1: TcxLabel
            Left = 310
            Top = 196
            TabStop = False
            Caption = '16.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 63
            Transparent = True
          end
          object cxLabel2: TcxLabel
            Left = 558
            Top = 196
            TabStop = False
            Caption = 'M'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 64
            Transparent = True
          end
          object cxDBCheckBox5: TcxDBCheckBox
            Left = 585
            Top = 5
            Hint = 
              'Usar este campo como marca de agrupaci'#243'n de l'#237'neas en la aplicac' +
              'i'#243'n de Preventa Android.'
            CaptionLabel = cxLabel20
            Caption = 'Agrup. preventa'
            DataBinding.DataField = 'Articulo_CampoLib9Agrupacion'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = False
            TabOrder = 18
            Transparent = True
          end
        end
        object Articulo_CamposLibCtrl: TcxDBCheckBox
          Left = 8
          Top = 7
          Caption = 'Usar campos de libre configuraci'#243'n'
          DataBinding.DataField = 'Articulo_CamposLibres'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnChange = Articulo_CamposLibCtrlPropertiesChange
          TabOrder = 0
          Transparent = True
        end
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = EmpresaTable
    FirstDataControl = PageControl
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnDestroyForm = FormManagerDestroyForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 623
    Top = 11
  end
  object EmpresaTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Empresa'
    IndexFieldNames = 'Codigo'
    Left = 575
    Top = 11
  end
  object DataSource: TDataSource
    DataSet = EmpresaTable
    Left = 527
    Top = 11
  end
end
