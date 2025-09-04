object MntOduForm: TMntOduForm
  Left = 456
  Top = 211
  HelpType = htKeyword
  HelpKeyword = 'a_odu'
  BorderStyle = bsDialog
  Caption = 'Mantenimiento de opciones de usuario'
  ClientHeight = 576
  ClientWidth = 641
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
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 36
    Width = 641
    object CodigoCtrl: TcxDBTextEdit
      Left = 99
      Top = 7
      DescriptionLabel = DescUsuarioLabel
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object Label3: TcxLabel
      Left = 18
      Top = 9
      Caption = 'Codigo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
    object DescUsuarioLabel: TcxLabel
      Left = 137
      Top = 9
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
      Height = 17
      Width = 326
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 540
    HelpContext = 202
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    ExplicitTop = 537
    DesignSize = (
      641
      36)
    Height = 36
    Width = 641
    object Panel2: TcxGroupBox
      Left = 233
      Top = 4
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 173
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
    ExplicitHeight = 501
    Height = 504
    Width = 631
    object cxScrollBox1: TcxScrollBox
      Left = 2
      Top = 2
      Width = 627
      Height = 500
      Align = alClient
      BorderStyle = cxcbsNone
      LookAndFeel.ScrollbarMode = sbmClassic
      TabOrder = 0
      Transparent = True
      ExplicitHeight = 497
      object ComprasPanel: TcxGroupBox
        AlignWithMargins = True
        Left = 2
        Top = 0
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        Caption = 'Compras'
        Style.BorderStyle = ebsNone
        Style.TextStyle = [fsBold]
        TabOrder = 0
        Height = 140
        Width = 623
        object Compras_OcultarPreciosCtrl: TcxDBCheckBox
          Left = 7
          Top = 24
          Caption = 'Ocultar los precios de compra'
          DataBinding.DataField = 'Compras_OcultarPrecios'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.MultiLine = True
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = OcultarPreciosCompraCtrlPropertiesEditValueChanged
          TabOrder = 0
          Transparent = True
          Width = 200
        end
        object Compras_MostrarStockCtrl: TcxDBCheckBox
          Left = 7
          Top = 47
          Caption = 'Mostrar stock en l'#237'nea'
          DataBinding.DataField = 'Compras_MostrarStock'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.AllowGrayed = True
          Properties.OnEditValueChanged = OcultarPreciosCompraCtrlPropertiesEditValueChanged
          TabOrder = 1
          Transparent = True
        end
        object cxLabel7: TcxLabel
          Left = 9
          Top = 74
          Caption = 'Valores por defecto'
          Style.TextColor = clGreen
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
        end
        object cxLabel8: TcxLabel
          Left = 528
          Top = 66
          Caption = 'Restringir su uso'
          Style.TextColor = clGreen
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taCenter
          Properties.WordWrap = True
          TabOrder = 5
          Transparent = True
          Width = 56
          AnchorX = 556
        end
        object cxLabel9: TcxLabel
          Left = 11
          Top = 105
          Caption = 'Almac'#233'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 6
          Transparent = True
        end
        object Compras_AlmacenDefectoCtrl: TcxDBTextEdit
          Left = 178
          Top = 102
          CaptionLabel = cxLabel9
          DescriptionLabel = cxLabel10
          DataBinding.DataField = 'Compras_AlmacenDefecto'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = AlmacenDefectoCtrlPropertiesQueryRequest
          Properties.OnEditRequest = AlmacenDefectoCtrlPropertiesEditRequest
          Properties.OnValidate = AlmacenDefectoCtrlPropertiesValidate
          TabOrder = 2
          Width = 25
        end
        object cxLabel10: TcxLabel
          Left = 227
          Top = 105
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 7
          Transparent = True
          Height = 17
          Width = 225
        end
        object Compras_RestringirAlmacenCtrl: TcxDBCheckBox
          Left = 546
          Top = 102
          Caption = '  '
          DataBinding.DataField = 'Compras_RestringirAlmacen'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taCenter
          Properties.FullFocusRect = True
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          TabOrder = 3
          Transparent = True
          Width = 24
        end
      end
      object VentasPanel: TcxGroupBox
        AlignWithMargins = True
        Left = 2
        Top = 144
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        Caption = 'Ventas'
        Style.BorderStyle = ebsNone
        Style.TextStyle = [fsBold]
        TabOrder = 1
        ExplicitTop = 141
        Height = 250
        Width = 623
        object OpcionesVentaPanel: TcxGroupBox
          AlignWithMargins = True
          Left = 4
          Top = 24
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          Alignment = alCenterCenter
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 0
          Height = 90
          Width = 615
          object Ventas_DesactivarTabletaFirmaCtrl: TcxDBCheckBox
            Left = 6
            Top = 71
            Caption = 'Desactivar la tableta de firma'
            DataBinding.DataField = 'Ventas_DesactivarTabletaFirma'
            DataBinding.DataSource = DataSource
            Enabled = False
            Properties.Alignment = taLeftJustify
            Properties.AllowGrayed = True
            TabOrder = 3
            Transparent = True
          end
          object Ventas_MostrarRentabilidadCtrl: TcxDBCheckBox
            Left = 305
            Top = 0
            Caption = 'Mostrar rentabilidad de los documentos'
            DataBinding.DataField = 'Ventas_MostrarRentabilidad'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taLeftJustify
            Properties.AllowGrayed = True
            Properties.MultiLine = True
            TabOrder = 4
            Transparent = True
            Width = 259
          end
          object Ventas_MostrarRiesgoAlbaranesCtrl: TcxDBCheckBox
            Left = 6
            Top = 46
            Caption = 'Mostrar riesgo en albaranes'
            DataBinding.DataField = 'Ventas_MostrarRiesgoAlbaranes'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taLeftJustify
            Properties.AllowGrayed = True
            TabOrder = 2
            Transparent = True
          end
          object Ventas_MostrarRiesgoPedidosCtrl: TcxDBCheckBox
            Left = 6
            Top = 23
            Caption = 'Mostrar riesgo en pedidos'
            DataBinding.DataField = 'Ventas_MostrarRiesgoPedidos'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taLeftJustify
            Properties.AllowGrayed = True
            TabOrder = 1
            Transparent = True
          end
          object Ventas_MostrarStockCtrl: TcxDBCheckBox
            Left = 6
            Top = 0
            Caption = 'Mostrar stock en l'#237'nea'
            DataBinding.DataField = 'Ventas_MostrarStock'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taLeftJustify
            Properties.AllowGrayed = True
            Properties.OnEditValueChanged = OcultarPreciosCompraCtrlPropertiesEditValueChanged
            TabOrder = 0
            Transparent = True
          end
        end
        object cxGroupBox4: TcxGroupBox
          AlignWithMargins = True
          Left = 4
          Top = 118
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Alignment = alCenterCenter
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          Style.TextStyle = [fsBold]
          TabOrder = 1
          Height = 128
          Width = 615
          object cxLabel3: TcxLabel
            Left = 9
            Top = 92
            Caption = 'Vendedor'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 6
            Transparent = True
          end
          object cxLabel4: TcxLabel
            Left = 228
            Top = 92
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 7
            Transparent = True
            Height = 19
            Width = 309
          end
          object cxLabel5: TcxLabel
            Left = 524
            Top = -4
            Caption = 'Restringir su uso'
            Style.TextColor = clGreen
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taCenter
            Properties.WordWrap = True
            TabOrder = 8
            Transparent = True
            Width = 56
            AnchorX = 552
          end
          object cxLabel6: TcxLabel
            Left = 9
            Top = 6
            Caption = 'Valores por defecto'
            Style.TextColor = clGreen
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 9
            Transparent = True
          end
          object Label4: TcxLabel
            Left = 9
            Top = 38
            Caption = 'Serie'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 10
            Transparent = True
          end
          object Label7: TcxLabel
            Left = 228
            Top = 38
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 11
            Transparent = True
            Height = 19
            Width = 309
          end
          object Label8: TcxLabel
            Left = 9
            Top = 65
            Caption = 'Almac'#233'n'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 12
            Transparent = True
          end
          object Label9: TcxLabel
            Left = 228
            Top = 63
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 13
            Transparent = True
            Height = 19
            Width = 309
          end
          object SerieDefectoCtrl: TcxDBTextEdit
            Left = 178
            Top = 35
            DescriptionLabel = Label7
            DataBinding.DataField = 'Ventas_SerieDefecto'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = SerieDefectoCtrlPropertiesQueryRequest
            Properties.OnEditRequest = SerieDefectoCtrlPropertiesEditRequest
            Properties.OnValidate = SerieDefectoCtrlPropertiesValidate
            TabOrder = 0
            Width = 25
          end
          object VendedorDefectoCtrl: TcxDBTextEdit
            Left = 178
            Top = 89
            DescriptionLabel = cxLabel4
            DataBinding.DataField = 'Ventas_VendedorDefecto'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = VendedorDefectoCtrlPropertiesQueryRequest
            Properties.OnEditRequest = VendedorDefectoCtrlPropertiesEditRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = VendedorDefectoCtrlPropertiesValidate
            TabOrder = 4
            Width = 25
          end
          object Ventas_AlmacenDefectoCtrl: TcxDBTextEdit
            Left = 178
            Top = 62
            CaptionLabel = Label8
            DescriptionLabel = Label9
            DataBinding.DataField = 'Ventas_AlmacenDefecto'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = AlmacenDefectoCtrlPropertiesQueryRequest
            Properties.OnEditRequest = AlmacenDefectoCtrlPropertiesEditRequest
            Properties.OnValidate = AlmacenDefectoCtrlPropertiesValidate
            TabOrder = 2
            Width = 25
          end
          object Ventas_RestringirAlmacenCtrl: TcxDBCheckBox
            Left = 542
            Top = 64
            Caption = '  '
            DataBinding.DataField = 'Ventas_RestringirAlmacen'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 3
            Transparent = True
            Width = 24
          end
          object Ventas_RestringirSerieCtrl: TcxDBCheckBox
            Left = 542
            Top = 33
            Caption = '  '
            DataBinding.DataField = 'Ventas_RestringirSerie'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 1
            Transparent = True
            Width = 24
          end
          object Ventas_RestringirVendedorCtrl: TcxDBCheckBox
            Left = 542
            Top = 95
            Caption = '  '
            DataBinding.DataField = 'Ventas_RestringirVendedor'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taCenter
            Properties.FullFocusRect = True
            Properties.ImmediatePost = True
            Properties.NullStyle = nssUnchecked
            TabOrder = 5
            Transparent = True
            Width = 24
          end
        end
      end
      object cxGroupBox3: TcxGroupBox
        AlignWithMargins = True
        Left = 2
        Top = 398
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        Caption = 'Informaci'#243'n'
        Style.BorderStyle = ebsNone
        Style.TextStyle = [fsBold]
        TabOrder = 2
        ExplicitTop = 395
        Height = 92
        Width = 623
        object cxLabel1: TcxLabel
          AlignWithMargins = True
          Left = 10
          Top = 43
          Margins.Left = 8
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 
            'Tenga en cuenta que, si el usuario accede a una Empresa distinta' +
            ', estos c'#243'digos puede que no existan. La restricci'#243'n de uso evit' +
            'a que el usuario utilice otras series, almacenes o c'#243'digos de ve' +
            'ndedor.'
          Style.TextColor = cl3DDkShadow
          Properties.WordWrap = True
          TabOrder = 0
          Transparent = True
          Width = 608
        end
        object cxLabel2: TcxLabel
          AlignWithMargins = True
          Left = 10
          Top = 22
          Margins.Left = 8
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 
            'La serie, almac'#233'n y vendedor por defecto son los de la Empresa a' +
            'ctualmente activa.'
          Style.TextColor = cl3DDkShadow
          Properties.WordWrap = True
          TabOrder = 1
          Transparent = True
          Width = 608
        end
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = UsuarioTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = Compras_OcultarPreciosCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    Left = 438
    Top = 47
  end
  object UsuarioTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Usuario'
    IndexFieldNames = 'Codigo'
    Left = 408
    Top = 47
  end
  object DataSource: TDataSource
    DataSet = UsuarioTable
    Left = 376
    Top = 47
  end
end
