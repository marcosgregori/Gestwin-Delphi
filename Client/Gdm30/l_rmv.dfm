object RptRmvForm: TRptRmvForm
  Left = 464
  Top = 235
  HelpType = htKeyword
  HelpKeyword = 'l_rmv'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de rentabilidad de las ventas por '
  ClientHeight = 471
  ClientWidth = 509
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
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
    Height = 430
    Width = 499
    object SeriePanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        495
        33)
      Height = 33
      Width = 495
      object SerieFacturacionCtrl: TcxDBTextEdit
        Left = 136
        Top = 6
        DescriptionLabel = Label2
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = SerieFacturacionCtrlPropertiesQueryRequest
        Properties.OnValidate = SerieFacturacionCtrlPropertiesValidate
        TabOrder = 0
        Width = 25
      end
      object Label1: TcxLabel
        Left = 12
        Top = 10
        TabStop = False
        Caption = 'Serie de facturaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label2: TcxLabel
        Left = 223
        Top = 10
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Transparent = True
        Height = 20
        Width = 260
        AnchorY = 20
      end
    end
    object Panel1: TcxGroupBox
      Left = 2
      Top = 35
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      DesignSize = (
        495
        393)
      Height = 393
      Width = 495
      object PageControl1: TcxPageControl
        Left = 4
        Top = 24
        Width = 484
        Height = 118
        Anchors = [akLeft, akTop, akRight]
        Focusable = False
        TabOrder = 0
        Properties.ActivePage = TabSheet1
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 118
        ClientRectRight = 484
        ClientRectTop = 28
        object TabSheet1: TcxTabSheet
          Caption = 'N'#186' de &documento'
          ExplicitLeft = 4
          ExplicitTop = 33
          ExplicitWidth = 476
          ExplicitHeight = 81
          object gxRangeBox2: TgxRangeBox
            Left = 137
            Top = 15
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object NroDocumentoInicialCtrl: TcxDBTextEdit
            Left = 154
            Top = 8
            DataBinding.DataField = 'NroDocumentoInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = DocumentoCtrlPropertiesQueryRequest
            TabOrder = 0
            Width = 67
          end
          object NroDocumentoFinalCtrl: TcxDBTextEdit
            Left = 154
            Top = 35
            DataBinding.DataField = 'NroDocumentoFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = DocumentoCtrlPropertiesQueryRequest
            TabOrder = 1
            Width = 67
          end
          object DocumentoLabel: TcxLabel
            Left = 8
            Top = 10
            TabStop = False
            Caption = 'N'#186' de albar'#225'n'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
        end
        object TabSheet2: TcxTabSheet
          Caption = '&Fecha'
          ExplicitLeft = 4
          ExplicitTop = 33
          ExplicitWidth = 476
          ExplicitHeight = 81
          object gxRangeBox1: TgxRangeBox
            Left = 137
            Top = 11
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object FechaAplicacionCtrl: TcxDBCheckBox
            Left = 5
            Top = 56
            AutoSize = False
            Caption = 'Fecha de aplicaci'#243'n'
            DataBinding.DataField = 'SeleccionFechaAplicacion'
            DataBinding.DataSource = DataSource
            Properties.Alignment = taRightJustify
            Properties.NullStyle = nssUnchecked
            TabOrder = 2
            Transparent = True
            Height = 25
            Width = 166
          end
          object FechaInicialCtrl: TcxDBDateEdit
            Left = 154
            Top = 3
            DataBinding.DataField = 'FechaInicial'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            TabOrder = 0
            Width = 100
          end
          object FechaFinalCtrl: TcxDBDateEdit
            Left = 154
            Top = 30
            DataBinding.DataField = 'FechaFinal'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            TabOrder = 1
            Width = 100
          end
          object Label6: TcxLabel
            Left = 8
            Top = 7
            TabStop = False
            Caption = 'Fecha'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
        end
      end
      object DetalladoCtrl: TcxDBCheckBox
        Left = 10
        Top = 330
        AutoSize = False
        Caption = 'Listado detallado'
        DataBinding.DataField = 'Detallado'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.OnChange = DetalladoCtrlPropertiesChange
        TabOrder = 4
        Transparent = True
        Height = 25
        Width = 170
      end
      object SituacionCtrl: TcxDBIndexedComboBox
        Left = 163
        Top = 356
        CaptionLabel = Label8
        DataBinding.DataField = 'Situacion'
        DataBinding.DataSource = DataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          '<Todos>'
          'Pendientes de recibir (totalmente)'
          'Pendientes de recibir (total o parcialmente)'
          'Parcialmente recibidos'
          'Totalmente recibidos')
        TabOrder = 5
        Width = 233
      end
      object IniciarPaginaGrupoCtrl: TcxDBCheckBox
        Left = 9
        Top = 306
        AutoSize = False
        Caption = 'P'#225'gina nueva por grupo'
        DataBinding.DataField = 'IniciarPaginaGrupo'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 3
        Transparent = True
        Height = 25
        Width = 171
      end
      object PageControl2: TcxPageControl
        Left = 4
        Top = 147
        Width = 484
        Height = 129
        Anchors = [akLeft, akTop, akRight]
        Focusable = False
        TabOrder = 1
        Properties.ActivePage = ClienteTabSheet
        Properties.CustomButtons.Buttons = <>
        Properties.MultiLine = True
        ClientRectBottom = 129
        ClientRectRight = 484
        ClientRectTop = 28
        object ClienteTabSheet: TcxTabSheet
          Caption = 'Clien&te'
          ExplicitLeft = 4
          ExplicitTop = 33
          ExplicitWidth = 476
          ExplicitHeight = 92
          DesignSize = (
            484
            101)
          object gxRangeBox3: TgxRangeBox
            Left = 137
            Top = 15
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object ClienteInicialCtrl: TcxDBTextEdit
            Left = 154
            Top = 7
            DescriptionLabel = Label4
            DataBinding.DataField = 'ClienteInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpLeftZero
            Properties.PadAlways = True
            Properties.OnValidate = ClienteCtrlPropertiesValidate
            TabOrder = 0
            Width = 46
          end
          object ClienteFinalCtrl: TcxDBTextEdit
            Left = 154
            Top = 34
            DescriptionLabel = Label7
            DataBinding.DataField = 'ClienteFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpLeftHighest
            Properties.PadAlways = True
            Properties.OnValidate = ClienteCtrlPropertiesValidate
            TabOrder = 1
            Width = 46
          end
          object Label3: TcxLabel
            Left = 8
            Top = 10
            TabStop = False
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label4: TcxLabel
            Left = 215
            Top = 8
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            Transparent = True
            ExplicitWidth = 257
            Height = 20
            Width = 265
            AnchorY = 18
          end
          object Label7: TcxLabel
            Left = 215
            Top = 35
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            Transparent = True
            ExplicitWidth = 257
            Height = 20
            Width = 265
            AnchorY = 45
          end
        end
        object GrupoClienteTabSheet: TcxTabSheet
          Caption = '&Grupo de cliente'
          ExplicitLeft = 4
          ExplicitTop = 33
          ExplicitWidth = 476
          ExplicitHeight = 92
          DesignSize = (
            484
            101)
          object gxRangeBox6: TgxRangeBox
            Left = 137
            Top = 15
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object GrupoInicialCtrl: TcxDBTextEdit
            Left = 154
            Top = 6
            DescriptionLabel = Label15
            DataBinding.DataField = 'GrupoInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = GrupoCtrlPropertiesQueryRequest
            Properties.OnValidate = GrupoCtrlPropertiesValidate
            TabOrder = 0
            Width = 32
          end
          object GrupoFinalCtrl: TcxDBTextEdit
            Left = 154
            Top = 33
            DescriptionLabel = Label16
            DataBinding.DataField = 'GrupoFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = GrupoCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpRightHighest
            Properties.PadAlways = True
            Properties.OnValidate = GrupoCtrlPropertiesValidate
            TabOrder = 1
            Width = 32
          end
          object Label14: TcxLabel
            Left = 8
            Top = 9
            TabStop = False
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label15: TcxLabel
            Left = 215
            Top = 7
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            Transparent = True
            ExplicitWidth = 257
            Height = 20
            Width = 265
            AnchorY = 17
          end
          object Label16: TcxLabel
            Left = 215
            Top = 34
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            Transparent = True
            ExplicitWidth = 257
            Height = 20
            Width = 265
            AnchorY = 44
          end
        end
        object VendedorTabSheet: TcxTabSheet
          Caption = '&Vendedor'
          ExplicitLeft = 4
          ExplicitTop = 33
          ExplicitWidth = 476
          ExplicitHeight = 92
          DesignSize = (
            484
            101)
          object gxRangeBox7: TgxRangeBox
            Left = 137
            Top = 14
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object VendedorInicialCtrl: TcxDBTextEdit
            Left = 154
            Top = 6
            DescriptionLabel = Label21
            DataBinding.DataField = 'VendedorInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpLeftZero
            Properties.PadAlways = True
            Properties.OnValidate = VendedorCtrlPropertiesValidate
            TabOrder = 0
            Width = 25
          end
          object VendedorFinalCtrl: TcxDBTextEdit
            Left = 154
            Top = 33
            DescriptionLabel = Label22
            DataBinding.DataField = 'VendedorFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpLeftHighest
            Properties.PadAlways = True
            Properties.OnValidate = VendedorCtrlPropertiesValidate
            TabOrder = 1
            Width = 25
          end
          object Label17: TcxLabel
            Left = 8
            Top = 9
            TabStop = False
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label21: TcxLabel
            Left = 215
            Top = 8
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            Transparent = True
            ExplicitWidth = 257
            Height = 20
            Width = 265
            AnchorY = 18
          end
          object Label22: TcxLabel
            Left = 215
            Top = 34
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            Transparent = True
            ExplicitWidth = 257
            Height = 20
            Width = 265
            AnchorY = 44
          end
        end
        object FormaCobroTabSheet: TcxTabSheet
          Caption = '&Forma de cobro'
          ImageIndex = 4
          ExplicitLeft = 4
          ExplicitTop = 33
          ExplicitWidth = 476
          ExplicitHeight = 92
          DesignSize = (
            484
            101)
          object gxRangeBox8: TgxRangeBox
            Left = 137
            Top = 13
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object FormaCobroInicialCtrl: TcxDBTextEdit
            Left = 154
            Top = 6
            DescriptionLabel = Label23
            DataBinding.DataField = 'FormaCobroInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = FormaCobroCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpLeftZero
            Properties.PadAlways = True
            Properties.OnValidate = FormaCobroCtrlPropertiesValidate
            TabOrder = 0
            Width = 25
          end
          object FormaCobroFinalCtrl: TcxDBTextEdit
            Left = 154
            Top = 33
            DescriptionLabel = Label24
            DataBinding.DataField = 'FormaCobroFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = FormaCobroCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpLeftHighest
            Properties.PadAlways = True
            Properties.OnValidate = FormaCobroCtrlPropertiesValidate
            TabOrder = 1
            Width = 25
          end
          object Label18: TcxLabel
            Left = 8
            Top = 9
            TabStop = False
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label23: TcxLabel
            Left = 215
            Top = 7
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            Transparent = True
            ExplicitWidth = 256
            Height = 20
            Width = 264
            AnchorY = 17
          end
          object Label24: TcxLabel
            Left = 215
            Top = 34
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            Transparent = True
            ExplicitWidth = 256
            Height = 20
            Width = 264
            AnchorY = 44
          end
        end
        object RegistroAuxiliarTabSheet: TcxTabSheet
          Caption = '&Registro auxiliar'
          ImageIndex = 5
          ExplicitLeft = 4
          ExplicitTop = 33
          ExplicitWidth = 476
          ExplicitHeight = 92
          DesignSize = (
            484
            101)
          object gxRangeBox9: TgxRangeBox
            Left = 137
            Top = 42
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object RegAuxiliarInicialCtrl: TcxDBTextEdit
            Left = 154
            Top = 33
            DescriptionLabel = Label26
            DataBinding.DataField = 'RegistroAuxiliarInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = RegAuxiliarCtrlPropertiesQueryRequest
            Properties.OnValidate = RegAuxiliarCtrlPropertiesValidate
            TabOrder = 1
            Width = 32
          end
          object RegAuxiliarFinalCtrl: TcxDBTextEdit
            Left = 154
            Top = 60
            DescriptionLabel = Label27
            DataBinding.DataField = 'RegistroAuxiliarFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = RegAuxiliarCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpRightHighest
            Properties.PadAlways = True
            Properties.OnValidate = RegAuxiliarCtrlPropertiesValidate
            TabOrder = 2
            Width = 32
          end
          object CodigoClienteCtrl: TcxDBTextEdit
            Left = 154
            Top = 6
            DescriptionLabel = Label25
            DataBinding.DataField = 'CodigoCliente'
            DataBinding.DataSource = DataSource
            Properties.Required = True
            Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpLeftZero
            Properties.PadAlways = True
            Properties.OnValidate = ClienteCtrlPropertiesValidate
            TabOrder = 0
            Width = 46
          end
          object RegistroAuxiliarLabel: TcxLabel
            Left = 8
            Top = 36
            TabStop = False
            Caption = 'Registro auxiliar'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label20: TcxLabel
            Left = 8
            Top = 9
            TabStop = False
            Caption = 'Cliente'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Transparent = True
          end
          object Label25: TcxLabel
            Left = 215
            Top = 7
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            Transparent = True
            ExplicitWidth = 257
            Height = 20
            Width = 265
            AnchorY = 17
          end
          object Label26: TcxLabel
            Left = 215
            Top = 34
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            Transparent = True
            ExplicitWidth = 257
            Height = 20
            Width = 265
            AnchorY = 44
          end
          object Label27: TcxLabel
            Left = 215
            Top = 61
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            Transparent = True
            ExplicitWidth = 257
            Height = 20
            Width = 265
            AnchorY = 71
          end
        end
      end
      object AgruparCtrl: TcxDBCheckBox
        Left = 9
        Top = 282
        AutoSize = False
        Caption = 'Agrupar'
        DataBinding.DataField = 'Agrupar'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.ImmediatePost = True
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Properties.OnEditValueChanged = AgruparCtrlPropertiesEditValueChanged
        TabOrder = 2
        Transparent = True
        Height = 25
        Width = 171
      end
      object Label5: TcxLabel
        Left = 12
        Top = 5
        TabStop = False
        Caption = 'Seleccionar por ...'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label8: TcxLabel
        Left = 14
        Top = 360
        TabStop = False
        Caption = 'Situaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 435
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      509
      36)
    Height = 36
    Width = 509
    object Panel3: TcxGroupBox
      Left = 169
      Top = 3
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
  object FormManager: TgxFormManager
    Dataset = Data
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 448
    Top = 18
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_rmv'
    HideReportList = False
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'SELECT  '#13#10'Movimientos.Ejercicio, '#13#10'Movimientos.NroOperacion, '#13#10'M' +
          'ovimientos.TipoMovimiento, '#13#10'Movimientos.Propietario,'#13#10'Movimient' +
          'os.Serie,    '#13#10'Movimientos.NroDocumento, '#13#10'Movimientos.Situacion' +
          ','#13#10'Movimientos.Facturado,'#13#10'Movimientos.NroFactura,'#13#10'Movimientos.' +
          'Traspasado,'#13#10'Movimientos.Anotacion,'#13#10'LineaMovimiento.*,         ' +
          '                             '#13#10'CAST ( '#39#39' AS NVARCHAR(60) ) AS Es' +
          'tadoDocumento,'#13#10'Cliente.Nombre AS ClienteNombre,'#13#10'<Campos>'#13#10'CAST' +
          '( 0.0 AS BCD(16,4) ) AS Pendiente,'#13#10'CAST( 0.0 AS BCD(16,4) ) AS ' +
          'ImporteBruto,'#13#10'CAST( 0.0 AS BCD(16,4) ) AS DescuentoArticulo,'#13#10'C' +
          'AST( 0.0 AS BCD(16,4) ) AS ImportePendiente,'#13#10'CAST( 0.0 AS BCD(1' +
          '6,4) ) AS ImporteNeto,'#13#10'CAST( 0.0 AS BCD(16,4) ) AS StockActual,' +
          #13#10'CAST( 0.0 AS BCD(16,4) ) AS Coste,'#13#10'CAST( 0.0 AS BCD(16,4) ) A' +
          'S Margen,'#13#10'CAST( 0.0 AS BCD(16,4) ) AS MargenPorcentual,'#13#10'CAST( ' +
          '0.0 AS BCD(16,4) ) AS ImporteNetoCalculado,'#13#10'CAST( 0.0 AS BCD(16' +
          ',4) ) AS CosteCalculado,'#13#10'True AS EsCosteReal'#13#10#13#10'FROM( SELECT * ' +
          '                                        '#13#10'      FROM Movimiento ' +
          '                    '#13#10'      WHERE <Seleccion> ) AS Movimientos'#13#10 +
          'LEFT JOIN Cliente ON ( Movimientos.Propietario=Cliente.Codigo )'#13 +
          #10'LEFT JOIN LineaMovimiento ON ( Movimientos.Ejercicio=LineaMovim' +
          'iento.Ejercicio AND Movimientos.NroOperacion=LineaMovimiento.Nro' +
          'Operacion )'#13#10'<Tablas>  '#13#10'<SeleccionLineas>'#13#10'ORDER BY'#13#10'<Ordenacio' +
          'n>'#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    OnSetReportName = ReportSetReportName
    Left = 414
    Top = 18
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 383
    Top = 18
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataNroDocumentoInicial: TIntegerField
      FieldName = 'NroDocumentoInicial'
      DisplayFormat = '#'
    end
    object DataNroDocumentoFinal: TIntegerField
      FieldName = 'NroDocumentoFinal'
      DisplayFormat = '#'
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataValorar: TBooleanField
      FieldName = 'Valorar'
    end
    object DataDetallado: TBooleanField
      FieldName = 'Detallado'
    end
    object DataSeleccionFechaAplicacion: TBooleanField
      FieldName = 'SeleccionFechaAplicacion'
    end
    object DataSituacion: TSmallintField
      FieldName = 'Situacion'
    end
    object DataLineasPendientes: TBooleanField
      FieldName = 'LineasPendientes'
    end
    object DataIniciarPaginaGrupo: TBooleanField
      FieldName = 'IniciarPaginaGrupo'
    end
    object DataGrupoInicial: TWideStringField
      FieldName = 'GrupoInicial'
      Size = 3
    end
    object DataGrupoFinal: TWideStringField
      FieldName = 'GrupoFinal'
      Size = 3
    end
    object DataVendedorInicial: TWideStringField
      FieldName = 'VendedorInicial'
      Size = 2
    end
    object DataVendedorFinal: TWideStringField
      FieldName = 'VendedorFinal'
      Size = 2
    end
    object DataRegistroAuxiliarInicial: TWideStringField
      FieldName = 'RegistroAuxiliarInicial'
      Size = 3
    end
    object DataRegistroAuxiliarFinal: TWideStringField
      FieldName = 'RegistroAuxiliarFinal'
      Size = 3
    end
    object DataFormaCobroInicial: TWideStringField
      FieldName = 'FormaCobroInicial'
      Size = 2
    end
    object DataFormaCobroFinal: TWideStringField
      FieldName = 'FormaCobroFinal'
      Size = 2
    end
    object DataCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object DataAgrupar: TBooleanField
      FieldName = 'Agrupar'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 350
    Top = 18
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 318
    Top = 18
  end
end
