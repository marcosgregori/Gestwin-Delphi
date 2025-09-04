object BoxPdeComForm: TBoxPdeComForm
  Left = 402
  Top = 251
  HelpType = htKeyword
  HelpKeyword = 'a_pde'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Configuraci'#243'n de empresas - Compras'
  ClientHeight = 356
  ClientWidth = 808
  Color = clBtnFace
  DoubleBuffered = True
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
    Top = 320
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      808
      36)
    Height = 36
    Width = 808
    object Panel2: TcxGroupBox
      Left = 316
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
    Height = 315
    Width = 798
    object PageControl: TcxPageControl
      Tag = 1
      Left = 2
      Top = 2
      Width = 794
      Height = 311
      Align = alClient
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = ComprasTS
      Properties.CustomButtons.Buttons = <>
      Properties.MultiLine = True
      ExplicitLeft = -88
      ExplicitTop = 3
      ClientRectBottom = 311
      ClientRectRight = 794
      ClientRectTop = 28
      object ComprasTS: TcxTabSheet
        Caption = 'General'
        object Compras_ActTarifasCtrl: TcxDBCheckBox
          Left = 13
          Top = 197
          Caption = 'Actualizar tarifas autom'#225'ticamente'
          DataBinding.DataField = 'Compras_ActTarifas'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 10
          Transparent = True
        end
        object Compras_AlmacenDefecCtrl: TcxDBTextEdit
          Left = 194
          Top = 86
          DescriptionLabel = Label40
          DataBinding.DataField = 'Compras_AlmacenDefec'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
          Properties.OnEditRequest = AlmacenCtrlPropertiesEditRequest
          Properties.OnValidate = AlmacenCtrlPropertiesValidate
          TabOrder = 6
          Width = 25
        end
        object Compras_CalculoCtrl: TcxDBIndexedComboBox
          Left = 194
          Top = 167
          CaptionLabel = metodoCalculoLabel
          DataBinding.DataField = 'Compras_Calculo'
          DataBinding.DataSource = DataSource
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.Items.Strings = (
            '<Ninguno>'
            'Cristal')
          TabOrder = 9
          Width = 87
        end
        object Compras_CantidadesCtrl: TcxDBIndexedComboBox
          Left = 194
          Top = 113
          DataBinding.DataField = 'Compras_Cantidades'
          DataBinding.DataSource = DataSource
          Properties.Alignment.Horz = taLeftJustify
          Properties.DropDownListStyle = lsFixedList
          Properties.ImmediatePost = True
          Properties.Items.Strings = (
            'Unidades'
            'Largo x Ancho'
            'Largo x Ancho x Alto')
          Properties.OnEditValueChanged = Compras_CantidadesCtrlPropertiesEditValueChanged
          TabOrder = 7
          Width = 147
        end
        object Compras_DecCajasCtrl: TcxDBSpinEdit
          Left = 558
          Top = 9
          DataBinding.DataField = 'Compras_DecCajas'
          DataBinding.DataSource = DataSource
          Properties.AssignedValues.MinValue = True
          Properties.MaxValue = 2.000000000000000000
          TabOrder = 3
          Width = 50
        end
        object Compras_DecCantidadCtrl: TcxDBSpinEdit
          Left = 209
          Top = 9
          DataBinding.DataField = 'Compras_DecCantidad'
          DataBinding.DataSource = DataSource
          Properties.AssignedValues.MinValue = True
          Properties.MaxValue = 4.000000000000000000
          TabOrder = 0
          Width = 50
        end
        object Compras_DecDtoCtrl: TcxDBSpinEdit
          Left = 453
          Top = 9
          DataBinding.DataField = 'Compras_DecDto'
          DataBinding.DataSource = DataSource
          Properties.AssignedValues.MinValue = True
          Properties.MaxValue = 2.000000000000000000
          TabOrder = 2
          Width = 50
        end
        object Compras_DecPrecioCtrl: TcxDBSpinEdit
          Left = 321
          Top = 9
          DataBinding.DataField = 'Compras_DecPrecio'
          DataBinding.DataSource = DataSource
          Properties.AssignedValues.MinValue = True
          Properties.MaxValue = 6.000000000000000000
          TabOrder = 1
          Width = 50
        end
        object Compras_DivisasCtrl: TcxDBCheckBox
          Left = 13
          Top = 246
          Caption = 'Precios en divisa'
          DataBinding.DataField = 'Compras_Divisas'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 12
          Transparent = True
        end
        object Compras_EmitirFrasCtrl: TcxDBCheckBox
          Left = 13
          Top = 40
          Caption = 'Emitir facturas'
          DataBinding.DataField = 'Compras_EmitirFras'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 4
          Transparent = True
        end
        object Compras_FechaCaducidadCtrl: TcxDBCheckBox
          Left = 422
          Top = 184
          Caption = 'Fecha de caducidad'
          DataBinding.DataField = 'Compras_FechaCaducidad'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 16
          Transparent = True
        end
        object Compras_FechaRecepcionPorLineaCtrl: TcxDBCheckBox
          Left = 422
          Top = 161
          Caption = 'Fechas de recepci'#243'n por l'#237'nea de pedido'
          DataBinding.DataField = 'Compras_FechaRecepcionPorLinea'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 15
          Transparent = True
        end
        object Compras_NombreCajasCtrl: TcxDBTextEdit
          Left = 194
          Top = 140
          CaptionLabel = nombreCajasComprasLabel
          DataBinding.DataField = 'Compras_NombreCajas'
          DataBinding.DataSource = DataSource
          TabOrder = 8
          OnEnter = Compras_NombreCajasCtrlEnter
          Width = 46
        end
        object Compras_NrosSerieCtrl: TcxDBCheckBox
          Left = 13
          Top = 220
          Caption = 'Gesti'#243'n de n'#250'meros de serie'
          DataBinding.DataField = 'Compras_NrosSerie'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 11
          Transparent = True
        end
        object Compras_OperariosCtrl: TcxDBCheckBox
          Left = 422
          Top = 138
          Caption = 'Operarios en los albaranes'
          DataBinding.DataField = 'Compras_Operarios'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 14
          Transparent = True
        end
        object Compras_UtilizarPrecioOfertasCtrl: TcxDBCheckBox
          Left = 422
          Top = 40
          Caption = 'Tener en cuenta los precios y descuentos de las ofertas'
          DataBinding.DataField = 'Compras_UtilizarPrecioOfertas'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 13
          Transparent = True
        end
        object Compras_VerStockCtrl: TcxDBCheckBox
          Left = 13
          Top = 63
          Caption = 'Mostrar stock en l'#237'nea'
          DataBinding.DataField = 'Compras_VerStock'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          TabOrder = 5
          Transparent = True
        end
        object cxLabel54: TcxLabel
          Left = 445
          Top = 208
          TabStop = False
          AutoSize = False
          Caption = 
            'Solo puede activar esta opci'#243'n si dispone del m'#243'dulo opcional de' +
            ' trazabilidad y tiene activados los lotes .'
          Style.TextColor = clGrayText
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.WordWrap = True
          Transparent = True
          Height = 41
          Width = 324
        end
        object Label32: TcxLabel
          Left = 17
          Top = 117
          TabStop = False
          Caption = 'Cantidades'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label40: TcxLabel
          Left = 238
          Top = 90
          TabStop = False
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 180
        end
        object Label41: TcxLabel
          Left = 17
          Top = 90
          TabStop = False
          Caption = 'Almac'#233'n por defecto'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label48: TcxLabel
          Left = 443
          Top = 64
          TabStop = False
          AutoSize = False
          Caption = 
            'Si marca esta opci'#243'n los precios y descuentos incluidos en ofert' +
            'as vigentes ser'#225' tenido en cuenta para determinar el precio y el' +
            ' descuento de compra actual del art'#237'culo.'
          Style.TextColor = cl3DDkShadow
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.WordWrap = True
          Transparent = True
          Height = 74
          Width = 332
        end
        object Label5: TcxLabel
          Left = 20
          Top = 13
          TabStop = False
          Caption = 'N'#186' de decimales en .. Cantidad'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label6: TcxLabel
          Left = 269
          Top = 13
          TabStop = False
          Caption = ', precio'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label7: TcxLabel
          Left = 378
          Top = 13
          TabStop = False
          Caption = ', descuento'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label8: TcxLabel
          Left = 511
          Top = 13
          TabStop = False
          Caption = 'y cajas'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object metodoCalculoLabel: TcxLabel
          Left = 17
          Top = 171
          TabStop = False
          Caption = 'M'#233'todo especial de c'#225'lculo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object nombreCajasComprasLabel: TcxLabel
          Left = 17
          Top = 143
          TabStop = False
          Caption = 'Nombre'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
      object cxTabSheet1: TcxTabSheet
        Caption = 'Albaranes'
        ImageIndex = 2
        object Compras_EditarBultosAlbaranCtrl: TcxDBCheckBox
          Left = 7
          Top = 9
          Hint = 
            'Indica si debe mostrarse una columna adicional en el mantenimien' +
            'to de albaranes de venta que permita modificar el n'#250'mero de bult' +
            'os calculado en cada l'#237'nea.'
          Caption = 'Mostrar y editar el n'#250'mero de bultos o contenedores'
          DataBinding.DataField = 'Compras_EditarBultosAlbaran'
          DataBinding.DataSource = DataSource
          Properties.NullStyle = nssUnchecked
          Style.TransparentBorder = False
          TabOrder = 0
          Transparent = True
        end
        object cxLabel8: TcxLabel
          Left = 46
          Top = 36
          TabStop = False
          Caption = 'Nombre'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Compras_NombreBultosCtrl: TcxDBTextEdit
          Left = 109
          Top = 33
          CaptionLabel = cxLabel8
          DataBinding.DataField = 'Compras_NombreBultos'
          DataBinding.DataSource = DataSource
          TabOrder = 2
          Width = 81
        end
      end
      object CamposLibresTS: TcxTabSheet
        Caption = 'Campos de libre configuraci'#243'n'
        ImageIndex = 1
        object CamposLibresComprasGroupBox: TcxGroupBox
          Left = 38
          Top = 58
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 1
          Transparent = True
          Height = 169
          Width = 239
          object Compras_CampoLibre1Ctrl: TcxDBTextEdit
            Left = 28
            Top = 26
            CaptionLabel = cxLabel2
            DataBinding.DataField = 'Compras_CampoLibre1'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 0
            Width = 116
          end
          object Compras_CampoLibre2Ctrl: TcxDBTextEdit
            Left = 28
            Top = 53
            CaptionLabel = cxLabel3
            DataBinding.DataField = 'Compras_CampoLibre2'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 2
            Width = 116
          end
          object Compras_CampoLibreObligatorio1Ctrl: TcxDBCheckBox
            Left = 169
            Top = 28
            DataBinding.DataField = 'Compras_CampoLibreObligatorio1'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 1
            Transparent = True
            Width = 21
          end
          object Compras_CampoLibreObligatorio2Ctrl: TcxDBCheckBox
            Left = 169
            Top = 55
            DataBinding.DataField = 'Compras_CampoLibreObligatorio2'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 3
            Transparent = True
            Width = 21
          end
          object cxLabel2: TcxLabel
            Left = 7
            Top = 29
            TabStop = False
            Caption = '1.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel3: TcxLabel
            Left = 7
            Top = 56
            TabStop = False
            Caption = '2.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Compras_CampoLibre3Ctrl: TcxDBTextEdit
            Left = 28
            Top = 80
            CaptionLabel = cxLabel56
            DataBinding.DataField = 'Compras_CampoLibre3'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 4
            Width = 116
          end
          object Compras_CampoLibre4Ctrl: TcxDBTextEdit
            Left = 28
            Top = 107
            CaptionLabel = cxLabel57
            DataBinding.DataField = 'Compras_CampoLibre4'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 6
            Width = 116
          end
          object Compras_CampoLibreObligatorio3Ctrl: TcxDBCheckBox
            Left = 169
            Top = 82
            DataBinding.DataField = 'Compras_CampoLibreObligatorio3'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 5
            Transparent = True
            Width = 21
          end
          object Compras_CampoLibreObligatorio4Ctrl: TcxDBCheckBox
            Left = 169
            Top = 109
            DataBinding.DataField = 'Compras_CampoLibreObligatorio4'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 7
            Transparent = True
            Width = 21
          end
          object cxLabel56: TcxLabel
            Left = 7
            Top = 83
            TabStop = False
            Caption = '3.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel57: TcxLabel
            Left = 7
            Top = 110
            TabStop = False
            Caption = '4.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Compras_CampoLibre5Ctrl: TcxDBTextEdit
            Left = 28
            Top = 134
            CaptionLabel = cxLabel60
            DataBinding.DataField = 'Compras_CampoLibre5'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 12
            Width = 116
          end
          object Compras_CampoLibreObligatorio5Cltr: TcxDBCheckBox
            Left = 169
            Top = 136
            DataBinding.DataField = 'Compras_CampoLibreObligatorio5'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 13
            Transparent = True
            Width = 21
          end
          object cxLabel60: TcxLabel
            Left = 7
            Top = 137
            TabStop = False
            Caption = '5.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxHeader4: TcxHeader
            Left = 30
            Top = 1
            Width = 196
            Height = 22
            Sections = <
              item
                Text = 'Nombre'
                Width = 115
              end
              item
                Text = 'Obligatorio'
                Width = 80
              end>
          end
        end
        object CamposLibresLineasComprasGroupBox: TcxGroupBox
          Left = 338
          Top = 58
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 3
          Transparent = True
          Height = 177
          Width = 345
          object Compras_CampoLibreLineas1Ctrl: TcxDBTextEdit
            Left = 27
            Top = 26
            CaptionLabel = cxLabel75
            DataBinding.DataField = 'Compras_CampoLibreLineas1'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 0
            Width = 116
          end
          object Compras_CampoLibreLineas2Ctrl: TcxDBTextEdit
            Left = 28
            Top = 53
            CaptionLabel = cxLabel76
            DataBinding.DataField = 'Compras_CampoLibreLineas2'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 3
            Width = 116
          end
          object Compras_CampoLibreLineasOblig1Ctrl: TcxDBCheckBox
            Left = 185
            Top = 28
            DataBinding.DataField = 'Compras_CampoLibreLineasOblig1'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.NullStyle = nssUnchecked
            TabOrder = 1
            Transparent = True
            Width = 21
          end
          object Compras_CampoLibreLineasOblig2Ctrl: TcxDBCheckBox
            Left = 185
            Top = 55
            DataBinding.DataField = 'Compras_CampoLibreLineasOblig2'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.NullStyle = nssUnchecked
            TabOrder = 4
            Transparent = True
            Width = 21
          end
          object cxLabel75: TcxLabel
            Left = 7
            Top = 29
            TabStop = False
            Caption = '1.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel76: TcxLabel
            Left = 7
            Top = 56
            TabStop = False
            Caption = '2.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Compras_CampoLibreLineas3Ctrl: TcxDBTextEdit
            Left = 28
            Top = 80
            CaptionLabel = cxLabel77
            DataBinding.DataField = 'Compras_CampoLibreLineas3'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 6
            Width = 116
          end
          object Compras_CampoLibreLineas4Ctrl: TcxDBTextEdit
            Left = 28
            Top = 107
            CaptionLabel = cxLabel78
            DataBinding.DataField = 'Compras_CampoLibreLineas4'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 9
            Width = 116
          end
          object Compras_CampoLibreLineasOblig3Ctrl: TcxDBCheckBox
            Left = 185
            Top = 82
            DataBinding.DataField = 'Compras_CampoLibreLineasOblig3'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.NullStyle = nssUnchecked
            TabOrder = 7
            Transparent = True
            Width = 21
          end
          object Compras_CampoLibreLineasOblig4Ctrl: TcxDBCheckBox
            Left = 185
            Top = 109
            DataBinding.DataField = 'Compras_CampoLibreLineasOblig4'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.NullStyle = nssUnchecked
            TabOrder = 10
            Transparent = True
            Width = 21
          end
          object cxLabel77: TcxLabel
            Left = 7
            Top = 83
            TabStop = False
            Caption = '3.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel78: TcxLabel
            Left = 7
            Top = 110
            TabStop = False
            Caption = '4.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxHeader3: TcxHeader
            Left = 28
            Top = 0
            Width = 276
            Height = 22
            Sections = <
              item
                Text = 'Nombre'
                Width = 115
              end
              item
                Text = 'Obligatorio'
                Width = 80
              end
              item
                Text = 'Posici'#243'n'
                Width = 80
              end>
          end
          object Compras_CampoLibreLineasPos1Ctrl: TcxDBSpinEdit
            Left = 237
            Top = 26
            DataBinding.DataField = 'Compras_CampoLibreLineasPos1'
            DataBinding.DataSource = DataSource
            Properties.MaxValue = 25.000000000000000000
            Properties.MinValue = 1.000000000000000000
            TabOrder = 2
            Width = 50
          end
          object Compras_CampoLibreLineasPos2Ctrl: TcxDBSpinEdit
            Left = 237
            Top = 53
            DataBinding.DataField = 'Compras_CampoLibreLineasPos2'
            DataBinding.DataSource = DataSource
            Properties.MaxValue = 25.000000000000000000
            Properties.MinValue = 1.000000000000000000
            TabOrder = 5
            Width = 50
          end
          object Compras_CampoLibreLineasPos3Ctrl: TcxDBSpinEdit
            Left = 237
            Top = 80
            DataBinding.DataField = 'Compras_CampoLibreLineasPos3'
            DataBinding.DataSource = DataSource
            Properties.MaxValue = 25.000000000000000000
            Properties.MinValue = 1.000000000000000000
            TabOrder = 8
            Width = 50
          end
          object Compras_CampoLibreLineasPos4Ctrl: TcxDBSpinEdit
            Left = 237
            Top = 107
            DataBinding.DataField = 'Compras_CampoLibreLineasPos4'
            DataBinding.DataSource = DataSource
            Properties.MaxValue = 25.000000000000000000
            Properties.MinValue = 1.000000000000000000
            TabOrder = 11
            Width = 50
          end
          object cxLabel79: TcxLabel
            Left = 159
            Top = 29
            TabStop = False
            Caption = 'C40'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel80: TcxLabel
            Left = 159
            Top = 56
            TabStop = False
            Caption = 'C40'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel81: TcxLabel
            Left = 159
            Top = 83
            TabStop = False
            Caption = 'F'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel82: TcxLabel
            Left = 159
            Top = 110
            TabStop = False
            Caption = 'N'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Compras_CampoLibreLineasPos5Ctrl: TcxDBSpinEdit
            Left = 237
            Top = 134
            DataBinding.DataField = 'Compras_CampoLibreLineasPos5'
            DataBinding.DataSource = DataSource
            Properties.MaxValue = 25.000000000000000000
            Properties.MinValue = 1.000000000000000000
            TabOrder = 21
            Width = 50
          end
          object Compras_CampoLibreLineasOblig5Ctrl: TcxDBCheckBox
            Left = 185
            Top = 137
            DataBinding.DataField = 'Compras_CampoLibreLineasOblig5'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.NullStyle = nssUnchecked
            Style.TransparentBorder = False
            TabOrder = 22
            Transparent = True
            Width = 21
          end
          object cxLabel7: TcxLabel
            Left = 159
            Top = 137
            TabStop = False
            Caption = 'C40'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Compras_CampoLibreLineas5Ctrl: TcxDBTextEdit
            Left = 28
            Top = 134
            CaptionLabel = cxLabel6
            DataBinding.DataField = 'Compras_CampoLibreLineas5'
            DataBinding.DataSource = DataSource
            Enabled = False
            TabOrder = 24
            Width = 116
          end
          object cxLabel6: TcxLabel
            Left = 7
            Top = 137
            TabStop = False
            Caption = '5.'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
        end
        object Compras_CamposLibresCtrl: TcxDBCheckBox
          Left = 12
          Top = 30
          Caption = 'Usar campos de libre configuraci'#243'n'
          DataBinding.DataField = 'Compras_CamposLibres'
          DataBinding.DataSource = DataSource
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = Compras_CamposLibresCtrlPropertiesEditValueChanged
          TabOrder = 0
          Transparent = True
        end
        object Compras_CamposLibresLineasCtrl: TcxDBCheckBox
          Left = 318
          Top = 30
          Caption = 'Usar campos de libre configuraci'#243'n'
          DataBinding.DataField = 'Compras_CamposLibresLineas'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = Compras_CamposLibresLineasCtrlPropertiesEditValueChanged
          TabOrder = 2
          Transparent = True
        end
        object cxLabel1: TcxLabel
          Left = 16
          Top = 8
          Caption = 'Cabecera'
          Style.TextColor = clNavy
          Transparent = True
        end
        object cxLabel4: TcxLabel
          Left = 317
          Top = 8
          Caption = 'L'#237'neas'
          Style.TextColor = clNavy
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
    OnOkButton = FormManagerOkButton
    Left = 333
    Top = 261
  end
  object EmpresaTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    BeforeOpen = EmpresaTableBeforeOpen
    TableName = 'Empresa'
    IndexFieldNames = 'Codigo'
    Left = 301
    Top = 261
  end
  object DataSource: TDataSource
    DataSet = EmpresaTable
    Left = 269
    Top = 261
  end
end
