object MntPde7Form: TMntPde7Form
  Left = 554
  Top = 310
  HelpType = htKeyword
  HelpKeyword = 'a_pde7'
  BorderStyle = bsDialog
  Caption = 'Configuraci'#243'n de producci'#243'n'
  ClientHeight = 537
  ClientWidth = 679
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 501
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      679
      36)
    Height = 36
    Width = 679
    object Panel3: TcxGroupBox
      Left = 252
      Top = 4
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 174
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
  object dataPanel: TgxEditPanel
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
    Height = 496
    Width = 669
    object cxPageControl1: TcxPageControl
      Left = 2
      Top = 2
      Width = 665
      Height = 492
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = cxTabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 488
      ClientRectLeft = 4
      ClientRectRight = 661
      ClientRectTop = 28
      object AlmacenesTabSheet: TcxTabSheet
        Caption = 'Ficheros'
        ImageIndex = 0
        object cxGroupBox1: TcxGroupBox
          AlignWithMargins = True
          Left = 6
          Top = 130
          Margins.Left = 6
          Align = alTop
          Caption = 'Almacenes'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.LookAndFeel.NativeStyle = False
          Style.TextStyle = [fsBold]
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          TabOrder = 1
          Transparent = True
          DesignSize = (
            648
            168)
          Height = 168
          Width = 648
          object AlmacenComponentesCtrl: TcxDBTextEdit
            Left = 215
            Top = 26
            DescriptionLabel = descComponentesLabel
            DataBinding.DataField = 'AlmacenComponentes'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
            Properties.OnEditRequest = AlmacenCtrlPropertiesEditRequest
            Properties.OnValidate = AlmacenCtrlPropertiesValidate
            TabOrder = 0
            Width = 25
          end
          object AlmacenProdAcabadoCtrl: TcxDBTextEdit
            Left = 215
            Top = 53
            DescriptionLabel = descAcabadoLabel
            DataBinding.DataField = 'AlmacenProductoAcabado'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
            Properties.OnEditRequest = AlmacenCtrlPropertiesEditRequest
            Properties.OnValidate = AlmacenCtrlPropertiesValidate
            TabOrder = 1
            Width = 25
          end
          object Label2: TcxLabel
            Left = 10
            Top = 28
            TabStop = False
            Caption = 'Componentes'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object descComponentesLabel: TcxLabel
            Left = 265
            Top = 28
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
            Height = 19
            Width = 395
          end
          object Label5: TcxLabel
            Left = 10
            Top = 56
            TabStop = False
            Caption = 'Producto acabado'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object descAcabadoLabel: TcxLabel
            Left = 265
            Top = 56
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
            Height = 19
            Width = 395
          end
          object AlmacenExtraccionesCtrl: TcxDBTextEdit
            Left = 215
            Top = 80
            DescriptionLabel = cxLabel4
            DataBinding.DataField = 'AlmacenExtracciones'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
            Properties.OnEditRequest = AlmacenCtrlPropertiesEditRequest
            Properties.OnValidate = AlmacenCtrlPropertiesValidate
            TabOrder = 2
            Width = 25
          end
          object cxLabel3: TcxLabel
            Left = 10
            Top = 83
            TabStop = False
            Caption = 'Extracciones e incorporaciones'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel4: TcxLabel
            Left = 265
            Top = 83
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
            Height = 19
            Width = 395
          end
          object AlmacenarProdDefectuososCtrl: TcxDBCheckBox
            Left = 6
            Top = 109
            AutoSize = False
            Caption = 'Almacenar los prod. defectuosos'
            DataBinding.DataField = 'AlmacenarProdDefectuosos'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            Properties.OnChange = AlmacenarProdDefectuososCtrlPropertiesChange
            TabOrder = 3
            Transparent = True
            Height = 21
            Width = 227
          end
          object AlmacenProdDefectuosoCtrl: TcxDBTextEdit
            Left = 215
            Top = 135
            CaptionLabel = CapProductoDefectuosoLabel
            DescriptionLabel = cxLabel6
            DataBinding.DataField = 'AlmacenProdDefectuoso'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
            Properties.OnEditRequest = AlmacenCtrlPropertiesEditRequest
            Properties.OnValidate = AlmacenCtrlPropertiesValidate
            TabOrder = 4
            Width = 25
          end
          object CapProductoDefectuosoLabel: TcxLabel
            Left = 10
            Top = 138
            TabStop = False
            Caption = 'Producto defectuoso'
            Enabled = False
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel6: TcxLabel
            Left = 265
            Top = 138
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Enabled = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
            Height = 17
            Width = 395
          end
        end
        object cxGroupBox3: TcxGroupBox
          AlignWithMargins = True
          Left = 6
          Top = 304
          Margins.Left = 6
          Align = alTop
          Caption = 'Listas de materiales'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.LookAndFeel.NativeStyle = False
          Style.TextStyle = [fsBold]
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          TabOrder = 2
          Transparent = True
          Height = 60
          Width = 648
          object DecimalesComponentesCtrl: TcxDBSpinEdit
            Left = 215
            Top = 24
            DataBinding.DataField = 'DecimalesComponentes'
            DataBinding.DataSource = DataSource
            Properties.AssignedValues.MinValue = True
            Properties.MaxValue = 6.000000000000000000
            TabOrder = 0
            Width = 48
          end
          object Label10: TcxLabel
            Left = 10
            Top = 28
            TabStop = False
            Caption = 'Decimales componentes'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
        end
        object cxGroupBox4: TcxGroupBox
          AlignWithMargins = True
          Left = 6
          Top = 370
          Margins.Left = 6
          Align = alTop
          Caption = 'Calendario'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.LookAndFeel.NativeStyle = False
          Style.TextStyle = [fsBold]
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          TabOrder = 3
          Transparent = True
          Height = 60
          Width = 648
          object cxLabel7: TcxLabel
            Left = 10
            Top = 27
            TabStop = False
            Caption = 'Tipo de jornada del s'#225'bado'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object TipoJornadaSabadoCtrl: TcxDBIndexedComboBox
            Left = 215
            Top = 24
            DataBinding.DataField = 'TipoJornadaSabado'
            DataBinding.DataSource = DataSource
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'Festivo'
              'Media jornada'
              'Completa'
              '')
            TabOrder = 1
            Width = 147
          end
        end
        object ArticulosGroupBox: TcxGroupBox
          AlignWithMargins = True
          Left = 6
          Top = 3
          Margins.Left = 6
          Align = alTop
          Caption = 'Art'#237'culos'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.LookAndFeel.NativeStyle = False
          Style.TextStyle = [fsBold]
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.NativeStyle = False
          TabOrder = 0
          Transparent = True
          Height = 121
          Width = 648
          object ExisteClaseACtrl: TcxDBCheckBox
            Left = 10
            Top = 39
            Caption = 'Clase A'
            DataBinding.DataField = 'ExisteClaseA'
            DataBinding.DataSource = DataSource
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            Properties.OnChange = ExisteClaseACtrlPropertiesChange
            Style.TransparentBorder = False
            TabOrder = 0
            Transparent = True
          end
          object NombreClaseACtrl: TcxDBTextEdit
            Left = 215
            Top = 37
            DataBinding.DataField = 'NombreClaseA'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            TabOrder = 1
            Width = 81
          end
          object NombreClaseBCtrl: TcxDBTextEdit
            Left = 215
            Top = 64
            DataBinding.DataField = 'NombreClaseB'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            TabOrder = 3
            Width = 81
          end
          object ExisteClaseBCtrl: TcxDBCheckBox
            Left = 10
            Top = 66
            Caption = 'Clase B'
            DataBinding.DataField = 'ExisteClaseB'
            DataBinding.DataSource = DataSource
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            Properties.OnChange = ExisteClaseBCtrlPropertiesChange
            Style.TransparentBorder = False
            TabOrder = 2
            Transparent = True
          end
          object NombreClaseCCtrl: TcxDBTextEdit
            Left = 215
            Top = 91
            DataBinding.DataField = 'NombreClaseC'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            TabOrder = 5
            Width = 81
          end
          object ExisteClaseCCtrl: TcxDBCheckBox
            Left = 10
            Top = 93
            Caption = 'Clase C'
            DataBinding.DataField = 'ExisteClaseC'
            DataBinding.DataSource = DataSource
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            Properties.OnChange = ExisteClaseCCtrlPropertiesChange
            Style.TransparentBorder = False
            TabOrder = 4
            Transparent = True
          end
        end
      end
      object cxTabSheet1: TcxTabSheet
        Caption = 'Fabricaci'#243'n'
        ImageIndex = 2
        object cxGroupBox5: TcxGroupBox
          AlignWithMargins = True
          Left = 6
          Top = 3
          Margins.Left = 6
          Align = alTop
          Caption = #211'rdenes de fabricaci'#243'n'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 0
          Transparent = True
          Height = 214
          Width = 648
          object cxLabel5: TcxLabel
            Left = 8
            Top = 28
            TabStop = False
            Caption = 'Retraso m'#225'ximo lanzamiento'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object RetrasoMaximoLanzamientoCtrl: TcxDBSpinEdit
            Left = 250
            Top = 24
            DataBinding.DataField = 'RetrasoMaximoLanzamiento'
            DataBinding.DataSource = DataSource
            Properties.AssignedValues.MinValue = True
            Properties.MaxValue = 99.000000000000000000
            TabOrder = 1
            Width = 48
          end
          object cxLabel8: TcxLabel
            Left = 8
            Top = 55
            TabStop = False
            Caption = 'Retraso m'#225'ximo entre tareas'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object RetrasoMaximoTareasCtrl: TcxDBSpinEdit
            Left = 250
            Top = 51
            DataBinding.DataField = 'RetrasoMaximoTareas'
            DataBinding.DataSource = DataSource
            Properties.AssignedValues.MinValue = True
            Properties.MaxValue = 99.000000000000000000
            TabOrder = 3
            Width = 48
          end
          object cxLabel9: TcxLabel
            Left = 308
            Top = 27
            TabStop = False
            Caption = 'd'#237'as.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel10: TcxLabel
            Left = 308
            Top = 54
            TabStop = False
            Caption = 'd'#237'as.'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object cxLabel11: TcxLabel
            Left = 8
            Top = 82
            TabStop = False
            Caption = 'M'#233'todo de numeraci'#243'n de lotes'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object MetodoNumeracionLotesCtrl: TcxDBIndexedComboBox
            Left = 250
            Top = 78
            DataBinding.DataField = 'MetodoNumeracionLote'
            DataBinding.DataSource = DataSource
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'Ninguno'
              'N'#250'mero correlativo'
              'Ejercicio + N'#250'mero correlativo'
              'N'#250'mero de la orden de fabricaci'#243'n'
              'Ejercicio + N'#250'mero de la orden de fabricaci'#243'n'
              'Formato 1 : ddmm#a'
              'Formato 2 : amm####'
              'Formato 3 : aa-mm-#######')
            TabOrder = 7
            Width = 232
          end
          object MantenerTurnoEnAsignacionCtrl: TcxDBCheckBox
            Left = 5
            Top = 111
            AutoSize = False
            Caption = 'Asignar a un mismo turno cada proceso'
            DataBinding.DataField = 'MantenerTurnoEnAsignacion'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = AlmacenarProdDefectuososCtrlPropertiesChange
            TabOrder = 8
            Transparent = True
            Height = 25
            Width = 262
          end
          object NoDescontarComponentesCtrl: TcxDBCheckBox
            Left = 5
            Top = 136
            AutoSize = False
            Caption = 'No descontar componentes en el lanzamiento'
            DataBinding.DataField = 'NoDescontarComponentes'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = AlmacenarProdDefectuososCtrlPropertiesChange
            TabOrder = 9
            Transparent = True
            Height = 33
            Width = 262
          end
          object NoLanzarOrdenesRecursivasCtrl: TcxDBCheckBox
            Left = 3
            Top = 175
            Hint = 
              'No crear '#243'rdenes de fabricaci'#243'n de los componentes inclu'#237'dos en ' +
              'una lista de materiales\ny que que tengan a su vez una lista de ' +
              'materiales y procesos.'
            AutoSize = False
            Caption = 'No lanzar '#243'rdenes de los componentes de forma recursiva'
            DataBinding.DataField = 'NoLanzarOrdenesRecursivas'
            DataBinding.DataSource = DataSource
            ParentShowHint = False
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = AlmacenarProdDefectuososCtrlPropertiesChange
            ShowHint = True
            Style.TransparentBorder = True
            TabOrder = 10
            Transparent = True
            Height = 32
            Width = 262
          end
        end
        object cxGroupBox6: TcxGroupBox
          AlignWithMargins = True
          Left = 6
          Top = 223
          Margins.Left = 6
          Align = alTop
          Caption = 'Informes de fabricaci'#243'n'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 1
          Transparent = True
          Height = 144
          Width = 648
          object MermaExcesoArticulosCtrl: TcxDBCheckBox
            Left = 5
            Top = 28
            AutoSize = False
            Caption = 'Permitir introducir mermas y/o excesos'
            DataBinding.DataField = 'MermaExcesoArticulos'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = AlmacenarProdDefectuososCtrlPropertiesChange
            TabOrder = 0
            Transparent = True
            Height = 25
            Width = 262
          end
          object IncorporarExtraerArticulosCtrl: TcxDBCheckBox
            Left = 4
            Top = 52
            AutoSize = False
            Caption = 'Incorporar y extraer art'#237'culos semi-elaborados'
            DataBinding.DataField = 'IncorporarExtraerArticulos'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = AlmacenarProdDefectuososCtrlPropertiesChange
            TabOrder = 1
            Transparent = True
            Height = 34
            Width = 263
          end
          object RealizarProduccionPrevistaCtrl: TcxDBCheckBox
            Left = 5
            Top = 87
            AutoSize = False
            Caption = 'Realizar siempre la producci'#243'n prevista'
            DataBinding.DataField = 'RealizarProduccionPrevista'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = AlmacenarProdDefectuososCtrlPropertiesChange
            TabOrder = 2
            Transparent = True
            Height = 23
            Width = 262
          end
        end
      end
      object CierreTabSheet: TcxTabSheet
        Caption = 'Cierre'
        ImageIndex = 1
        object cxGroupBox2: TcxGroupBox
          AlignWithMargins = True
          Left = 6
          Top = 3
          Margins.Left = 6
          Align = alTop
          Caption = 'Hojas de carga'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 0
          Transparent = True
          DesignSize = (
            648
            82)
          Height = 82
          Width = 648
          object SerieAlbaranesSalidaCtrl: TcxDBTextEdit
            Left = 226
            Top = 53
            CaptionLabel = Label4
            DescriptionLabel = descSerieSalidaLabel
            DataBinding.DataField = 'SerieAlbaranesSalida'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = SerieAlbaranesSalidaCtrlPropertiesQueryRequest
            Properties.OnEditRequest = SerieAlbaranesSalidaCtrlPropertiesEditRequest
            Properties.OnValidate = SerieAlbaranesSalidaCtrlPropertiesValidate
            TabOrder = 1
            Width = 25
          end
          object Label4: TcxLabel
            Left = 13
            Top = 56
            TabStop = False
            Caption = 'Serie de los albaranes de salida'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object descSerieSalidaLabel: TcxLabel
            Left = 273
            Top = 56
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
            Height = 19
            Width = 365
          end
          object cxLabel2: TcxLabel
            Left = 13
            Top = 29
            TabStop = False
            Caption = 'Documento de las hojas de carga'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object DocumentoHojaCargaCtrl: TcxDBIndexedComboBox
            Left = 226
            Top = 25
            CaptionLabel = cxLabel2
            DataBinding.DataField = 'DocumentoHojaCarga'
            DataBinding.DataSource = DataSource
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.ImmediatePost = True
            Properties.Items.Strings = (
              'Pedido'
              'Albar'#225'n')
            Properties.OnChange = DocumentoHojaCargaCtrlPropertiesChange
            TabOrder = 0
            Width = 78
          end
        end
        object cxGroupBox7: TcxGroupBox
          AlignWithMargins = True
          Left = 6
          Top = 158
          Margins.Left = 6
          Align = alTop
          Caption = 'Coste de producto acabado'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 1
          Transparent = True
          Height = 90
          Width = 648
          object cxLabel12: TcxLabel
            Left = 13
            Top = 32
            TabStop = False
            Caption = 'M'#233'todo de c'#225'lculo del coste'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object MetodoCalculoCosteCtrl: TcxDBIndexedComboBox
            Left = 226
            Top = 28
            CaptionLabel = cxLabel12
            DataBinding.DataField = 'MetodoCalculoCoste'
            DataBinding.DataSource = DataSource
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.ImmediatePost = True
            Properties.Items.Strings = (
              'Coste neto calculado por la aplicaci'#243'n'
              'Coste neto + Incremento porcentual fijo'
              'Precio de compra de la ficha')
            Properties.OnChange = cxDBIndexedComboBox1PropertiesChange
            TabOrder = 1
            Width = 251
          end
          object cxLabel13: TcxLabel
            Left = 13
            Top = 59
            TabStop = False
            Caption = 'Incremento porcentual fijo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object IncrementoPorcentualCosteCtrl: TcxDBCurrencyEdit
            Left = 226
            Top = 56
            CaptionLabel = cxLabel13
            DescriptionLabel = descSerieSalidaLabel
            DataBinding.DataField = 'IncrementoPorcentualCoste'
            DataBinding.DataSource = DataSource
            TabOrder = 3
            Width = 51
          end
          object PorcentajeLabel: TcxLabel
            Left = 283
            Top = 59
            TabStop = False
            Caption = '%'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.WordWrap = True
            Transparent = True
            Width = 11
          end
        end
        object cxGroupBox8: TcxGroupBox
          AlignWithMargins = True
          Left = 6
          Top = 254
          Margins.Left = 6
          Align = alTop
          Caption = 'Precio de salida del producto'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 2
          Transparent = True
          Height = 90
          Width = 648
          object cxLabel15: TcxLabel
            Left = 13
            Top = 32
            TabStop = False
            Caption = 'M'#233'todo de asignaci'#243'n del precio'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object MetodoCalculoMargenCtrl: TcxDBIndexedComboBox
            Left = 226
            Top = 28
            CaptionLabel = cxLabel15
            DataBinding.DataField = 'MetodoCalculoMargen'
            DataBinding.DataSource = DataSource
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.ImmediatePost = True
            Properties.Items.Strings = (
              'No asignar precio de venta'
              'Coste neto + Margen porcentual fijo'
              'Precio de venta de la ficha')
            Properties.OnChange = cxDBIndexedComboBox2PropertiesChange
            TabOrder = 1
            Width = 251
          end
          object cxLabel16: TcxLabel
            Left = 13
            Top = 59
            TabStop = False
            Caption = 'Margen porcentual fijo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object MargenPorcentualVentaCtrl: TcxDBCurrencyEdit
            Left = 226
            Top = 56
            CaptionLabel = cxLabel16
            DescriptionLabel = descSerieSalidaLabel
            DataBinding.DataField = 'MargenPorcentualVenta'
            DataBinding.DataSource = DataSource
            TabOrder = 3
            Width = 51
          end
          object MargenPorcentualLabel: TcxLabel
            Left = 283
            Top = 59
            TabStop = False
            Caption = '%'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.WordWrap = True
            Transparent = True
            Width = 11
          end
        end
        object cxGroupBox9: TcxGroupBox
          AlignWithMargins = True
          Left = 6
          Top = 350
          Margins.Left = 6
          Align = alTop
          Caption = 'Automatismos'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 4
          Transparent = True
          Height = 61
          Width = 648
          object AjusteAutomaticoConsumosCtrl: TcxDBCheckBox
            Left = 9
            Top = 25
            AutoSize = False
            Caption = 'Ajuste autom'#225'tico de consumos'
            DataBinding.DataField = 'AjusteAutomaticoConsumos'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.MultiLine = True
            Properties.NullStyle = nssUnchecked
            Properties.OnEditValueChanged = AlmacenarProdDefectuososCtrlPropertiesChange
            TabOrder = 0
            Transparent = True
            Height = 23
            Width = 235
          end
        end
        object cxGroupBox10: TcxGroupBox
          AlignWithMargins = True
          Left = 6
          Top = 91
          Margins.Left = 6
          Align = alTop
          Caption = 'Coste de componentes dispuestos para fabricaci'#243'n'
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 3
          Transparent = True
          Height = 61
          Width = 648
          object cxLabel1: TcxLabel
            Left = 15
            Top = 34
            TabStop = False
            Caption = 'Coste a aplicar en la salida'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object CosteComponentesCtrl: TcxDBIndexedComboBox
            Left = 228
            Top = 30
            CaptionLabel = cxLabel1
            DataBinding.DataField = 'CosteComponentes'
            DataBinding.DataSource = DataSource
            Properties.Alignment.Horz = taLeftJustify
            Properties.DropDownListStyle = lsFixedList
            Properties.ImmediatePost = True
            Properties.Items.Strings = (
              'Coste ultima entrada'
              'Coste medio'
              'Mejor valor disponible')
            Properties.OnChange = cxDBIndexedComboBox1PropertiesChange
            TabOrder = 1
            Width = 179
          end
        end
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = ExisteClaseACtrl
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnDestroyForm = FormManagerDestroyForm
    OnOkButton = FormManagerOkButton
    Left = 618
    Top = 17
  end
  object LineaHojaCargaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaHojaCarga'
    IndexFieldNames = 'Ejercicio;NroHoja;NroLinea'
    Left = 522
    Top = 17
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 556
    Top = 17
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 586
    Top = 17
    object DataDecimalesComponentes: TSmallintField
      FieldName = 'DecimalesComponentes'
    end
    object DataAlmacenComponentes: TWideStringField
      FieldName = 'AlmacenComponentes'
      Size = 2
    end
    object DataAlmacenProductoAcabado: TWideStringField
      FieldName = 'AlmacenProductoAcabado'
      Size = 2
    end
    object DataSerieAlbaranesSalida: TWideStringField
      FieldName = 'SerieAlbaranesSalida'
      Size = 2
    end
    object DataDocumentoHojaCarga: TSmallintField
      FieldName = 'DocumentoHojaCarga'
    end
    object DataAlmacenExtracciones: TWideStringField
      DisplayWidth = 2
      FieldName = 'AlmacenExtracciones'
      Size = 2
    end
    object DataAlmacenarProdDefectuosos: TBooleanField
      FieldName = 'AlmacenarProdDefectuosos'
    end
    object DataAlmacenProdDefectuoso: TWideStringField
      FieldName = 'AlmacenProdDefectuoso'
      Size = 2
    end
    object DataTipoJornadaSabado: TSmallintField
      FieldName = 'TipoJornadaSabado'
    end
    object DataRetrasoMaximoLanzamiento: TSmallintField
      FieldName = 'RetrasoMaximoLanzamiento'
    end
    object DataRetrasoMaximoTareas: TSmallintField
      FieldName = 'RetrasoMaximoTareas'
    end
    object DataMetodoNumeracionLote: TSmallintField
      FieldName = 'MetodoNumeracionLote'
    end
    object DataMantenerTurnoEnAsignacion: TBooleanField
      FieldName = 'MantenerTurnoEnAsignacion'
    end
    object DataNoDescontarComponentes: TBooleanField
      FieldName = 'NoDescontarComponentes'
    end
    object DataNoLanzarOrdenesRecursivas: TBooleanField
      FieldName = 'NoLanzarOrdenesRecursivas'
    end
    object DataIncorporarExtraerArticulos: TBooleanField
      FieldName = 'IncorporarExtraerArticulos'
    end
    object DataMermaExcesoArticulos: TBooleanField
      FieldName = 'MermaExcesoArticulos'
    end
    object DataRealizarProduccionPrevista: TBooleanField
      FieldName = 'RealizarProduccionPrevista'
    end
    object DataMetodoCalculoCoste: TSmallintField
      FieldName = 'MetodoCalculoCoste'
    end
    object DataMetodoCalculoMargen: TSmallintField
      FieldName = 'MetodoCalculoMargen'
    end
    object DataIncrementoPorcentualCoste: TCurrencyField
      FieldName = 'IncrementoPorcentualCoste'
    end
    object DataMargenPorcentualVenta: TCurrencyField
      FieldName = 'MargenPorcentualVenta'
    end
    object DataAjusteAutomaticoConsumos: TBooleanField
      FieldName = 'AjusteAutomaticoConsumos'
    end
    object DataNombreClaseA: TStringField
      FieldName = 'NombreClaseA'
      Size = 10
    end
    object DataNombreClaseB: TStringField
      FieldName = 'NombreClaseB'
      Size = 10
    end
    object DataNombreClaseC: TStringField
      FieldName = 'NombreClaseC'
      Size = 10
    end
    object DataExisteClaseA: TBooleanField
      FieldName = 'ExisteClaseA'
    end
    object DataExisteClaseB: TBooleanField
      FieldName = 'ExisteClaseB'
    end
    object DataExisteClaseC: TBooleanField
      FieldName = 'ExisteClaseC'
    end
    object DataCosteComponentes: TSmallintField
      FieldName = 'CosteComponentes'
    end
  end
end
