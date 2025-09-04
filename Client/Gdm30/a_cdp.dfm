object MntCdpForm: TMntCdpForm
  Left = 436
  Top = 298
  HelpKeyword = 'b_cdp'
  BorderStyle = bsDialog
  Caption = 'Cambio de precios de art'#237'culos'
  ClientHeight = 391
  ClientWidth = 756
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
    Height = 319
    Width = 746
    object PageControl: TcxPageControl
      Tag = 1
      Left = 2
      Top = 35
      Width = 742
      Height = 223
      Align = alClient
      Focusable = False
      TabOrder = 1
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      TabulationCycle = tcComplete
      ClientRectBottom = 219
      ClientRectLeft = 4
      ClientRectRight = 738
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = '&Seleccionar por ...'
        DesignSize = (
          734
          191)
        object gxRangeBox1: TgxRangeBox
          Left = 154
          Top = 12
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object CodigoInicialCtrl: TcxDBTextEdit
          Left = 169
          Top = 5
          DescriptionLabel = Label3
          DataBinding.DataField = 'CodigoInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
          Properties.MaxLength = 13
          Properties.ExpandZeroes = False
          Properties.OnEditValueChanged = CodigoInicialCtrlPropertiesEditValueChanged
          Properties.OnValidate = CodigoInicialCtrlPropertiesValidate
          TabOrder = 1
          Width = 120
        end
        object CodigoFinalCtrl: TcxDBTextEdit
          Left = 169
          Top = 32
          DescriptionLabel = Label13
          DataBinding.DataField = 'CodigoFinal'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
          Properties.MaxLength = 13
          Properties.ExpandZeroes = False
          Properties.TextEditPad = tpRightHighest
          Properties.PadAlways = True
          Properties.OnEditValueChanged = CodigoFinalCtrlPropertiesEditValueChanged
          TabOrder = 2
          Width = 120
        end
        object SeleccionCtrl: TcxDBRadioGroup
          Left = 5
          Top = 5
          Alignment = alCenterCenter
          DataBinding.DataField = 'Seleccion'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.Items = <
            item
              Caption = 'Art'#237'culo'
              Value = 0
            end
            item
              Caption = 'Familia'
              Value = 1
            end>
          Properties.OnEditValueChanged = SeleccionCtrlPropertiesEditValueChanged
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 48
          Width = 97
        end
        object Label2: TcxLabel
          Left = 105
          Top = 8
          TabStop = False
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
        end
        object Label3: TcxLabel
          Left = 313
          Top = 6
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 4
          Transparent = True
          Height = 20
          Width = 413
          AnchorY = 16
        end
        object Label13: TcxLabel
          Left = 313
          Top = 33
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 5
          Transparent = True
          Height = 20
          Width = 413
          AnchorY = 43
        end
        object Label20: TcxLabel
          Left = 105
          Top = 63
          TabStop = False
          Anchors = [akLeft, akTop, akRight, akBottom]
          AutoSize = False
          Caption = 
            'Puede realizar selecciones especiales utilizando el car'#225'cter com' +
            'od'#237'n '#39'*'#39' (asterisco). Por ejemplo, una selecci'#243'n por familia des' +
            'de el c'#243'digo '#39'A*F'#39' hasta e '#39'A*G'#39' incluir'#237'a a todas las familias ' +
            'que tuvieran como primer caracter '#39'A'#39', cualquier valor como segu' +
            'ndo caracter y el tercero comprendido entre '#39'F'#39' y '#39'G'#39'.'
          Style.TextColor = clGray
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.WordWrap = True
          TabOrder = 6
          Transparent = True
          Height = 112
          Width = 610
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = 'Precio de r&eferencia'
        ImageIndex = 1
        DesignSize = (
          734
          191)
        object PrecioReferenciaCtrl: TcxDBRadioGroup
          Left = 4
          Top = 5
          Alignment = alCenterCenter
          DataBinding.DataField = 'PrecioReferencia'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.Items = <
            item
              Caption = 'Precio de compra'
              Value = 0
            end
            item
              Caption = 'Coste medio'
              Value = 1
            end
            item
              Caption = #218'ltimo coste'
              Value = 2
            end
            item
              Caption = 'Coste (mejor valor disponible)'
              Value = 3
            end
            item
              Caption = 'Precio de venta'
              Value = 4
            end
            item
              Caption = #218'ltimo precio de compra y descuento'
              Value = '5'
            end>
          Properties.OnChange = PrecioReferenciaCtrlPropertiesChange
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 150
          Width = 257
        end
        object OrigenPageControl: TcxPageControl
          Left = 264
          Top = 32
          Width = 458
          Height = 100
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          TabStop = False
          Properties.ActivePage = ProveedorOrigenTabSheet
          Properties.CustomButtons.Buttons = <>
          Properties.HideTabs = True
          TabulationCycle = tcNone
          ClientRectBottom = 96
          ClientRectLeft = 4
          ClientRectRight = 454
          ClientRectTop = 4
          object ProveedorOrigenTabSheet: TcxTabSheet
            ImageIndex = 0
            object ProveedorOrigenCtrl: TcxDBTextEdit
              Left = 157
              Top = 24
              DescriptionLabel = Label16
              DataBinding.DataField = 'ProveedorOrigen'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
              Properties.TextEditPad = tpLeftZero
              Properties.OnValidate = ProveedorCtrlPropertiesValidate
              TabOrder = 0
              Width = 46
            end
            object Label16: TcxLabel
              Left = 243
              Top = 25
              TabStop = False
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              Properties.Alignment.Vert = taVCenter
              TabOrder = 1
              Transparent = True
              Height = 20
              Width = 400
              AnchorY = 35
            end
            object OrigenPrecioCompraCtrl: TcxDBRadioGroup
              Left = 0
              Top = -4
              Alignment = alCenterCenter
              DataBinding.DataField = 'Origen'
              DataBinding.DataSource = DataSource
              Properties.DefaultValue = 0
              Properties.Items = <
                item
                  Caption = 'Ficha del art'#237'culo'
                  Value = 0
                end
                item
                  Caption = 'Tarifa del proveedor'
                  Value = 1
                end>
              Properties.OnChange = OrigenPrecioCompraCtrlPropertiesChange
              Style.BorderStyle = ebsNone
              Style.TransparentBorder = True
              TabOrder = 2
              Transparent = True
              Height = 57
              Width = 151
            end
            object AplicarDescuentoCtrl: TcxDBCheckBox
              Left = 157
              Top = 51
              AutoSize = False
              Caption = 'Aplicar descuento'
              DataBinding.DataField = 'AplicarDescuento'
              DataBinding.DataSource = DataSource
              Properties.Alignment = taRightJustify
              Properties.MultiLine = True
              Properties.NullStyle = nssUnchecked
              Style.TransparentBorder = False
              TabOrder = 3
              Transparent = True
              Height = 21
              Width = 140
            end
          end
          object ClienteOrigenTabSheet: TcxTabSheet
            ImageIndex = 1
            object OrigenPrecioVentaCtrl: TcxDBRadioGroup
              Left = 0
              Top = -4
              Alignment = alCenterCenter
              DataBinding.DataField = 'Origen'
              DataBinding.DataSource = DataSource
              Properties.DefaultValue = 0
              Properties.Items = <
                item
                  Caption = 'Ficha del art'#237'culo'
                  Value = 0
                end
                item
                  Caption = 'Tarifa de venta'
                  Value = 1
                end
                item
                  Caption = 'Tarifa del cliente'
                  Value = 2
                end>
              Properties.OnChange = OrigenPrecioVentaCtrlPropertiesChange
              Style.BorderStyle = ebsNone
              Style.TransparentBorder = True
              TabOrder = 0
              Transparent = True
              Height = 85
              Width = 139
            end
            object TarifaOrigenCtrl: TcxDBTextEdit
              Left = 136
              Top = 26
              DescriptionLabel = Label7
              DataBinding.DataField = 'TarifaOrigen'
              DataBinding.DataSource = DataSource
              Enabled = False
              Properties.Required = True
              Properties.OnQueryRequest = TarifaCtrlPropertiesQueryRequest
              Properties.OnValidate = TarifaOrigenCtrlPropertiesValidate
              TabOrder = 1
              Width = 25
            end
            object ClienteOrigenCtrl: TcxDBTextEdit
              Left = 136
              Top = 53
              DescriptionLabel = Label9
              DataBinding.DataField = 'ClienteOrigen'
              DataBinding.DataSource = DataSource
              Enabled = False
              Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
              Properties.OnValuePosted = ClienteCtrlOrigenPropertiesValuePosted
              Properties.TextEditPad = tpLeftZero
              Properties.OnValidate = ClienteCtrlOrigenPropertiesValidate
              TabOrder = 2
              Width = 46
            end
            object Label7: TcxLabel
              Left = 199
              Top = 27
              TabStop = False
              AutoSize = False
              Enabled = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              Properties.Alignment.Vert = taVCenter
              TabOrder = 3
              Transparent = True
              Height = 20
              Width = 400
              AnchorY = 37
            end
            object Label9: TcxLabel
              Left = 199
              Top = 54
              TabStop = False
              AutoSize = False
              Enabled = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              Properties.Alignment.Vert = taVCenter
              TabOrder = 4
              Transparent = True
              Height = 20
              Width = 400
              AnchorY = 64
            end
          end
        end
        object OrigenLabel: TcxLabel
          Left = 264
          Top = 5
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Caption = 'Origen'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.LineOptions.Alignment = cxllaBottom
          Properties.LineOptions.Visible = True
          TabOrder = 2
          Transparent = True
          Height = 25
          Width = 454
        end
      end
      object TabSheet3: TcxTabSheet
        Caption = '&Operaci'#243'n'
        ImageIndex = 2
        object OperacionCtrl: TcxDBRadioGroup
          Left = 4
          Top = 4
          Alignment = alCenterCenter
          DataBinding.DataField = 'Operacion'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.Items = <
            item
              Caption = 'Copiar'
              Value = 0
            end
            item
              Caption = 'Incrementar (o reducir) un ..'
              Value = 1
            end
            item
              Caption = 'A'#241'adir (o sustraer) ...'
              Value = 2
            end
            item
              Caption = 'Aplicar un margen sobre el precio final del ...'
              Value = 3
            end
            item
              Caption = 'Aplicar el margen comercial de su ficha'
              Value = 4
            end>
          Properties.OnEditValueChanged = OperacionCtrlPropertiesEditValueChanged
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 127
          Width = 297
        end
        object PorcentajeOperacionCtrl: TcxDBTextEdit
          Left = 312
          Top = 25
          CaptionLabel = Label8
          DataBinding.DataField = 'PorcentajeOperacion'
          DataBinding.DataSource = DataSource
          Enabled = False
          TabOrder = 1
          Width = 53
        end
        object ImporteOperacionCtrl: TcxDBCurrencyEdit
          Left = 312
          Top = 52
          CaptionLabel = MonedaLabel
          DataBinding.DataField = 'ImporteOperacion'
          DataBinding.DataSource = DataSource
          Enabled = False
          TabOrder = 2
          Width = 64
        end
        object MargenOperacionCtrl: TcxDBTextEdit
          Left = 312
          Top = 79
          CaptionLabel = Label10
          DataBinding.DataField = 'MargenOperacion'
          DataBinding.DataSource = DataSource
          Enabled = False
          Properties.OnValidate = MargenOperacionCtrlPropertiesValidate
          TabOrder = 3
          Width = 46
        end
        object Label8: TcxLabel
          Left = 371
          Top = 28
          TabStop = False
          Caption = '%.'
          Enabled = False
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
        end
        object MonedaLabel: TcxLabel
          Left = 382
          Top = 55
          TabStop = False
          Caption = 'Euros.'
          Enabled = False
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 5
          Transparent = True
        end
        object Label10: TcxLabel
          Left = 362
          Top = 83
          TabStop = False
          Caption = '%.'
          Enabled = False
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 6
          Transparent = True
        end
      end
      object PrecioFinalTabSheet: TcxTabSheet
        Caption = 'Precio fi&nal'
        ImageIndex = 3
        DesignSize = (
          734
          191)
        object PrecioFinalCtrl: TcxDBRadioGroup
          Left = 4
          Top = 5
          Alignment = alCenterCenter
          DataBinding.DataField = 'PrecioFinal'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.Items = <
            item
              Caption = 'Precio de compra'
              Value = 0
            end
            item
              Caption = 'Precio de venta'
              Value = 1
            end>
          Properties.OnChange = PrecioFinalCtrlPropertiesChange
          Style.BorderStyle = ebsNone
          TabOrder = 0
          Height = 52
          Width = 173
        end
        object RedondearCtrl: TcxDBCheckBox
          Left = 14
          Top = 147
          AutoSize = False
          Caption = '&Redondear el precio final'
          DataBinding.DataField = 'Redondear'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = RedondearCtrlPropertiesEditValueChanged
          TabOrder = 1
          Transparent = True
          Height = 25
          Width = 178
        end
        object Label19: TcxLabel
          Left = 198
          Top = 151
          TabStop = False
          Caption = 'Decimales'
          Enabled = False
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object DecimalesCtrl: TcxDBSpinEdit
          Left = 264
          Top = 147
          CaptionLabel = Label19
          DataBinding.DataField = 'Precision'
          DataBinding.DataSource = DataSource
          Enabled = False
          Properties.AssignedValues.MinValue = True
          Properties.MaxValue = 6.000000000000000000
          TabOrder = 3
          Width = 66
        end
        object DestinoPageControl: TcxPageControl
          Left = 264
          Top = 32
          Width = 458
          Height = 100
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 4
          TabStop = False
          Properties.ActivePage = ClienteDestinoTabSheet
          Properties.CustomButtons.Buttons = <>
          Properties.HideTabs = True
          TabulationCycle = tcNone
          ClientRectBottom = 96
          ClientRectLeft = 4
          ClientRectRight = 454
          ClientRectTop = 4
          object ProveedorDestinoTabSheet: TcxTabSheet
            ImageIndex = 0
            object ProveedorDestinoCtrl: TcxDBTextEdit
              Left = 157
              Top = 23
              DescriptionLabel = cxLabel2
              DataBinding.DataField = 'ProveedorDestino'
              DataBinding.DataSource = DataSource
              Properties.Required = True
              Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
              Properties.TextEditPad = tpLeftZero
              Properties.OnValidate = ProveedorCtrlPropertiesValidate
              TabOrder = 0
              Width = 46
            end
            object cxLabel2: TcxLabel
              Left = 243
              Top = 24
              TabStop = False
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              Properties.Alignment.Vert = taVCenter
              TabOrder = 1
              Transparent = True
              Height = 20
              Width = 400
              AnchorY = 34
            end
            object DestinoPrecioCompraCtrl: TcxDBRadioGroup
              Left = 0
              Top = -4
              Alignment = alCenterCenter
              DataBinding.DataField = 'Destino'
              DataBinding.DataSource = DataSource
              Properties.DefaultValue = 0
              Properties.Items = <
                item
                  Caption = 'Ficha del art'#237'culo'
                  Value = 0
                end
                item
                  Caption = 'Tarifa del proveedor'
                  Value = 1
                end>
              Properties.OnChange = DestinoPrecioCompraCtrlPropertiesChange
              Style.BorderStyle = ebsNone
              Style.TransparentBorder = True
              TabOrder = 2
              Transparent = True
              Height = 57
              Width = 151
            end
          end
          object ClienteDestinoTabSheet: TcxTabSheet
            ImageIndex = 1
            object DestinoPrecioVentaCtrl: TcxDBRadioGroup
              Left = 0
              Top = -5
              Alignment = alCenterCenter
              DataBinding.DataField = 'Destino'
              DataBinding.DataSource = DataSource
              Properties.DefaultValue = 0
              Properties.Items = <
                item
                  Caption = 'Ficha del art'#237'culo'
                  Value = 0
                end
                item
                  Caption = 'Tarifa de venta'
                  Value = 1
                end
                item
                  Caption = 'Tarifa del cliente'
                  Value = 2
                end>
              Properties.OnChange = DestinoPrecioVentaCtrlPropertiesChange
              Style.BorderStyle = ebsNone
              Style.TransparentBorder = True
              TabOrder = 0
              Transparent = True
              Height = 85
              Width = 139
            end
            object TarifaDestinoCtrl: TcxDBTextEdit
              Left = 136
              Top = 26
              DescriptionLabel = cxLabel3
              DataBinding.DataField = 'TarifaDestino'
              DataBinding.DataSource = DataSource
              Enabled = False
              Properties.Required = True
              Properties.OnQueryRequest = TarifaCtrlPropertiesQueryRequest
              Properties.OnValidate = TarifaOrigenCtrlPropertiesValidate
              TabOrder = 1
              Width = 25
            end
            object ClienteDestinoCtrl: TcxDBTextEdit
              Left = 136
              Top = 53
              DescriptionLabel = cxLabel4
              DataBinding.DataField = 'ClienteDestino'
              DataBinding.DataSource = DataSource
              Enabled = False
              Properties.Required = True
              Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
              Properties.TextEditPad = tpLeftZero
              Properties.OnValidate = ClienteCtrlDestinoPropertiesValidate
              TabOrder = 2
              Width = 46
            end
            object cxLabel3: TcxLabel
              Left = 199
              Top = 27
              TabStop = False
              AutoSize = False
              Enabled = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              Properties.Alignment.Vert = taVCenter
              TabOrder = 3
              Transparent = True
              Height = 20
              Width = 400
              AnchorY = 37
            end
            object cxLabel4: TcxLabel
              Left = 199
              Top = 54
              TabStop = False
              AutoSize = False
              Enabled = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              Properties.Alignment.Vert = taVCenter
              TabOrder = 4
              Transparent = True
              Height = 20
              Width = 400
              AnchorY = 64
            end
          end
        end
        object DestinoLabel: TcxLabel
          Left = 264
          Top = 5
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Caption = 'Destino'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.LineOptions.Alignment = cxllaBottom
          Properties.LineOptions.Visible = True
          TabOrder = 5
          Transparent = True
          Height = 25
          Width = 454
        end
      end
    end
    object Panel1: TcxGroupBox
      Left = 2
      Top = 258
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      DesignSize = (
        742
        59)
      Height = 59
      Width = 742
      object BorradorCtrl: TcxDBCheckBox
        Left = 8
        Top = 6
        AutoSize = False
        Caption = 'Emitir un borrador de la operaci'#243'n'
        DataBinding.DataField = 'Borrador'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.OnChange = BorradorCtrlPropertiesChange
        Style.TransparentBorder = False
        TabOrder = 0
        Transparent = True
        Height = 23
        Width = 245
      end
      object EjecutarProcesoButton: TgBitBtn
        Left = 637
        Top = 26
        Width = 89
        Height = 31
        Anchors = [akRight, akBottom]
        Caption = 'E&jecutar'
        Enabled = True
        OptionsImage.ImageIndex = 33
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 1
        OnClick = EjecutarProcesoButtonClick
        GlyphBitmap = gmGears
      end
      object NoAplicarCambiosCtrl: TcxCheckBox
        Left = 26
        Top = 30
        Hint = 
          'No aplicar los cambios en los registros de la apl'#241'icaci'#243'n.\nEmit' +
          'ir tan solo un borrador de comprobaci'#243'n.'
        AutoSize = False
        Caption = 'No aplicar los cambios'
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = False
        TabOrder = 2
        Transparent = True
        Height = 23
        Width = 227
      end
    end
    object Panel2: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 33
      Width = 742
      object DescripcionCtrl: TcxDBTextEdit
        Left = 107
        Top = 3
        DataBinding.DataField = 'Descripcion'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        TabOrder = 0
        Width = 286
      end
      object Label14: TcxLabel
        Left = 8
        Top = 9
        TabStop = False
        Caption = 'Descripci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
    end
  end
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 36
    Width = 756
    object NroRegistroCtrl: TcxDBSpinEdit
      Left = 116
      Top = 6
      DataBinding.DataField = 'NroRegistro'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroRegistroCtrlPropertiesQueryRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 0
      Width = 51
    end
    object codigoCtrlCaption: TcxLabel
      Left = 16
      Top = 9
      TabStop = False
      Caption = 'N'#186' de registro'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 355
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      756
      36)
    Height = 36
    Width = 756
    object cxGroupBox1: TcxGroupBox
      Left = 250
      Top = 4
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 260
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
    end
  end
  object FormManager: TgxFormManager
    Dataset = CambioPreciosTable
    FirstKeyControl = NroRegistroCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    Left = 496
    Top = 8
  end
  object ArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 464
    Top = 44
  end
  object TarifaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaVentas'
    IndexFieldNames = 'Tipo;CodigoTarifa;CodigoArticulo'
    Left = 496
    Top = 44
  end
  object TarifaComprasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaCompras'
    IndexFieldNames = 'Tipo;CodigoProveedor;CodigoArticulo'
    Left = 494
    Top = 74
  end
  object DataSource: TDataSource
    DataSet = CambioPreciosTable
    Left = 432
    Top = 8
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_cdp'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Relacion'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Codigo NVARCHAR(20),'#13#10'Descripcion NV' +
          'ARCHAR(60),'#13#10'CodigoTarifaOrigen NVARCHAR(5),'#13#10'CodigoTarifaDestin' +
          'o NVARCHAR(5),    '#13#10'PrecioCompra1 BCD(16,4),'#13#10'PrecioVenta1 BCD(1' +
          '6,4),'#13#10'PrecioCompra2 BCD(16,4),'#13#10'PrecioVenta2 BCD(16,4),'#13#10'Precio' +
          'Base BCD(16,4) );'#13#10#13#10'CREATE INDEX Index0 ON <TableName> ( Codigo' +
          ' );'#13#10
      end>
    ToPrinter = False
    Left = 430
    Top = 44
  end
  object CambioPreciosTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforePost = CambioPreciosTableBeforePost
    OnNewRecord = CambioPreciosTableNewRecord
    TableName = 'CambioPrecios'
    IndexFieldNames = 'NroRegistro'
    AutoIncFieldName = 'NroRegistro'
    OnUpdateState = CambioPreciosTableUpdateState
    Left = 464
    Top = 8
    object CambioPreciosTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
      Required = True
    end
    object CambioPreciosTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object CambioPreciosTableSeleccion: TSmallintField
      FieldName = 'Seleccion'
    end
    object CambioPreciosTableCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
      Size = 13
    end
    object CambioPreciosTableCodigoFinal: TWideStringField
      FieldName = 'CodigoFinal'
      Size = 13
    end
    object CambioPreciosTableOperacion: TSmallintField
      FieldName = 'Operacion'
    end
    object CambioPreciosTablePorcentajeOperacion: TBCDField
      FieldName = 'PorcentajeOperacion'
      Precision = 16
    end
    object CambioPreciosTableImporteOperacion: TBCDField
      FieldName = 'ImporteOperacion'
      Precision = 16
    end
    object CambioPreciosTableMargenOperacion: TBCDField
      FieldName = 'MargenOperacion'
      Precision = 16
    end
    object CambioPreciosTablePrecioReferencia: TSmallintField
      FieldName = 'PrecioReferencia'
    end
    object CambioPreciosTableOrigen: TSmallintField
      FieldName = 'Origen'
    end
    object CambioPreciosTableProveedorOrigen: TWideStringField
      FieldName = 'ProveedorOrigen'
      Size = 5
    end
    object CambioPreciosTableTarifaOrigen: TWideStringField
      FieldName = 'TarifaOrigen'
      Size = 2
    end
    object CambioPreciosTableClienteOrigen: TWideStringField
      FieldName = 'ClienteOrigen'
      Size = 5
    end
    object CambioPreciosTablePrecioFinal: TSmallintField
      FieldName = 'PrecioFinal'
    end
    object CambioPreciosTableDestino: TSmallintField
      FieldName = 'Destino'
    end
    object CambioPreciosTableProveedorDestino: TWideStringField
      FieldName = 'ProveedorDestino'
      Size = 5
    end
    object CambioPreciosTableTarifaDestino: TWideStringField
      FieldName = 'TarifaDestino'
      Size = 2
    end
    object CambioPreciosTableClienteDestino: TWideStringField
      FieldName = 'ClienteDestino'
      Size = 5
    end
    object CambioPreciosTableAplicarDescuento: TBooleanField
      FieldName = 'AplicarDescuento'
    end
    object CambioPreciosTablePrecision: TSmallintField
      FieldName = 'Precision'
    end
    object CambioPreciosTableRedondear: TBooleanField
      FieldName = 'Redondear'
    end
    object CambioPreciosTableMultiplos5: TBooleanField
      FieldName = 'Multiplos5'
    end
    object CambioPreciosTableBorrador: TBooleanField
      FieldName = 'Borrador'
    end
  end
  object LineaMovimientoQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    ReadOnly = True
    SQL.Strings = (
      
        'SELECT TOP 1 LineaMovimiento.CodigoArticulo, LineaMovimiento.Fec' +
        'ha, LineaMovimiento.Precio, LineaMovimiento.Descuento'
      
        'FROM LineaMovimiento LEFT JOIN Movimiento ON ( LineaMovimiento.E' +
        'jercicio=Movimiento.Ejercicio AND LineaMovimiento.NroOperacion=M' +
        'ovimiento.NroOperacion )'
      
        'WHERE Movimiento.TipoMovimiento=12 AND LineaMovimiento.CodigoArt' +
        'iculo=:CodigoArticulo'
      'ORDER BY Fecha DESC')
    Left = 494
    Top = 106
    ParamData = <
      item
        DataType = ftString
        Name = 'CodigoArticulo'
        ParamType = ptUnknown
      end>
    object LineaMovimientoQueryCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object LineaMovimientoQueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object LineaMovimientoQueryPrecio: TFloatField
      FieldName = 'Precio'
    end
    object LineaMovimientoQueryDescuento: TBCDField
      FieldName = 'Descuento'
      Precision = 16
    end
  end
end
