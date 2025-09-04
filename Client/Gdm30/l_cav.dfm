object RptCavForm: TRptCavForm
  Left = 511
  Top = 325
  HelpType = htKeyword
  HelpKeyword = 'l_cav'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de cartera de venta de art'#237'culos'
  ClientHeight = 547
  ClientWidth = 602
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
    DesignSize = (
      592
      506)
    Height = 506
    Width = 592
    object Bevel1: TShape
      Left = 7
      Top = 353
      Width = 574
      Height = 1
      Anchors = [akLeft, akTop, akRight]
      Pen.Color = clBtnShadow
      ExplicitWidth = 546
    end
    object gxRangeBox3: TgxRangeBox
      Left = 125
      Top = 370
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox4: TgxRangeBox
      Left = 125
      Top = 424
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object SerieRangeBox: TgxRangeBox
      Left = 128
      Top = 13
      Width = 13
      Height = 37
      Hint = 
        'Los campos situados a la derecha marcan un rango de valores.'#13'Arr' +
        'iba el l'#237'mite inferior y abajo el superior.'
      ParentShowHint = False
      ShowHint = True
    end
    object ArticuloInicialCtrl: TcxDBTextEdit
      Left = 141
      Top = 362
      DescriptionLabel = Label4
      DataBinding.DataField = 'ArticuloInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 5
      Width = 125
    end
    object ArticuloFinalCtrl: TcxDBTextEdit
      Left = 141
      Top = 389
      DescriptionLabel = Label7
      DataBinding.DataField = 'ArticuloFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 6
      Width = 125
    end
    object AlmacenInicialCtrl: TcxDBTextEdit
      Left = 141
      Top = 416
      DescriptionLabel = Label8
      DataBinding.DataField = 'AlmacenInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
      Properties.OnValidate = AlmacenCtrlPropertiesValidate
      TabOrder = 7
      Width = 25
    end
    object AlmacenFinalCtrl: TcxDBTextEdit
      Left = 141
      Top = 443
      DescriptionLabel = Label9
      DataBinding.DataField = 'AlmacenFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = AlmacenCtrlPropertiesValidate
      TabOrder = 8
      Width = 25
    end
    object SituacionCtrl: TcxDBIndexedComboBox
      Left = 141
      Top = 321
      CaptionLabel = Label10
      DataBinding.DataField = 'Situacion'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      TabOrder = 4
      Width = 220
    end
    object PageControl2: TcxPageControl
      Left = 7
      Top = 189
      Width = 576
      Height = 126
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 3
      Properties.ActivePage = ClienteTabSheet
      Properties.CustomButtons.Buttons = <>
      Properties.MultiLine = True
      ClientRectBottom = 122
      ClientRectLeft = 4
      ClientRectRight = 572
      ClientRectTop = 33
      object ClienteTabSheet: TcxTabSheet
        Caption = 'Clien&te'
        DesignSize = (
          568
          89)
        object gxRangeBox5: TgxRangeBox
          Left = 120
          Top = 14
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ClienteInicialCtrl: TcxDBTextEdit
          Left = 135
          Top = 6
          DescriptionLabel = Label11
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
          Left = 135
          Top = 33
          DescriptionLabel = Label12
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
          Left = 9
          Top = 9
          TabStop = False
          Caption = 'C'#243'digo de cliente'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label11: TcxLabel
          Left = 270
          Top = 7
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 20
          Width = 300
          AnchorY = 17
        end
        object Label12: TcxLabel
          Left = 270
          Top = 34
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 20
          Width = 300
          AnchorY = 44
        end
      end
      object GrupoClienteTabSheet: TcxTabSheet
        Caption = '&Grupo de cliente'
        DesignSize = (
          568
          89)
        object gxRangeBox6: TgxRangeBox
          Left = 120
          Top = 14
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object GrupoInicialCtrl: TcxDBTextEdit
          Left = 135
          Top = 6
          DescriptionLabel = Label14
          DataBinding.DataField = 'GrupoInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = GrupoCtrlPropertiesQueryRequest
          Properties.OnValidate = GrupoCtrlPropertiesValidate
          TabOrder = 0
          Width = 32
        end
        object GrupoFinalCtrl: TcxDBTextEdit
          Left = 135
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
        object Label13: TcxLabel
          Left = 8
          Top = 9
          TabStop = False
          Caption = 'C'#243'digo de grupo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label14: TcxLabel
          Left = 246
          Top = 7
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 20
          Width = 317
          AnchorY = 17
        end
        object Label16: TcxLabel
          Left = 246
          Top = 34
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 20
          Width = 317
          AnchorY = 44
        end
      end
      object VendedorTabSheet: TcxTabSheet
        Caption = '&Vendedor'
        DesignSize = (
          568
          89)
        object gxRangeBox7: TgxRangeBox
          Left = 120
          Top = 14
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object VendedorInicialCtrl: TcxDBTextEdit
          Left = 135
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
          Left = 135
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
        object Label15: TcxLabel
          Left = 8
          Top = 10
          TabStop = False
          Caption = 'C'#243'digo vendedor'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label21: TcxLabel
          Left = 246
          Top = 8
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 20
          Width = 318
          AnchorY = 18
        end
        object Label22: TcxLabel
          Left = 246
          Top = 34
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 20
          Width = 318
          AnchorY = 44
        end
      end
      object FormaCobroTabSheet: TcxTabSheet
        Caption = '&Forma de cobro'
        ImageIndex = 4
        DesignSize = (
          568
          89)
        object gxRangeBox8: TgxRangeBox
          Left = 120
          Top = 14
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FormaCobroInicialCtrl: TcxDBTextEdit
          Left = 135
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
          Left = 135
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
        object Label17: TcxLabel
          Left = 8
          Top = 10
          TabStop = False
          Caption = 'C'#243'd. forma cobro'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label23: TcxLabel
          Left = 246
          Top = 8
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 20
          Width = 318
          AnchorY = 18
        end
        object Label24: TcxLabel
          Left = 246
          Top = 34
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 20
          Width = 318
          AnchorY = 44
        end
      end
      object RegistroAuxiliarTabSheet: TcxTabSheet
        Caption = '&Registro auxiliar'
        ImageIndex = 5
        DesignSize = (
          568
          89)
        object gxRangeBox9: TgxRangeBox
          Left = 120
          Top = 42
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object RegAuxiliarInicialCtrl: TcxDBTextEdit
          Left = 135
          Top = 33
          DescriptionLabel = Label25
          DataBinding.DataField = 'RegAuxiliarInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = RegAuxiliarCtrlPropertiesQueryRequest
          Properties.OnValidate = RegAuxiliarCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object RegAuxiliarFinalCtrl: TcxDBTextEdit
          Left = 135
          Top = 61
          DescriptionLabel = Label26
          DataBinding.DataField = 'RegAuxiliarFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = RegAuxiliarCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightHighest
          Properties.PadAlways = True
          Properties.OnValidate = RegAuxiliarCtrlPropertiesValidate
          TabOrder = 2
          Width = 32
        end
        object CodigoClienteCtrl: TcxDBTextEdit
          Left = 135
          Top = 6
          DescriptionLabel = Label20
          DataBinding.DataField = 'CodigoCliente'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object RegistroAuxiliarLabel: TcxLabel
          Left = 8
          Top = 36
          TabStop = False
          Caption = 'C'#243'd. reg. auxiliar'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label19: TcxLabel
          Left = 8
          Top = 9
          TabStop = False
          Caption = 'C'#243'digo del cliente'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label20: TcxLabel
          Left = 246
          Top = 7
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 20
          Width = 318
          AnchorY = 17
        end
        object Label25: TcxLabel
          Left = 246
          Top = 34
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 20
          Width = 318
          AnchorY = 44
        end
        object Label26: TcxLabel
          Left = 246
          Top = 62
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          Transparent = True
          Height = 20
          Width = 318
          AnchorY = 72
        end
      end
    end
    object PageControl1: TcxPageControl
      Left = 7
      Top = 84
      Width = 576
      Height = 95
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 2
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 91
      ClientRectLeft = 4
      ClientRectRight = 572
      ClientRectTop = 33
      object TabSheet1: TcxTabSheet
        Caption = 'N'#186' de &documento'
        object gxRangeBox2: TgxRangeBox
          Left = 117
          Top = 11
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object NroDocumentoInicialCtrl: TcxDBTextEdit
          Left = 132
          Top = 3
          DataBinding.DataField = 'NroDocumentoInicial'
          DataBinding.DataSource = DataSource
          TabOrder = 0
          Width = 67
        end
        object NroDocumentoFinalCtrl: TcxDBTextEdit
          Left = 132
          Top = 30
          DataBinding.DataField = 'NroDocumentoFinal'
          DataBinding.DataSource = DataSource
          TabOrder = 1
          Width = 67
        end
        object DocumentoLabel: TcxLabel
          Left = 8
          Top = 7
          TabStop = False
          Caption = 'N'#186' de albar'#225'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = '&Fecha'
        object gxRangeBox1: TgxRangeBox
          Left = 117
          Top = 10
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FechaInicialCtrl: TcxDBDateEdit
          Tag = 3
          Left = 132
          Top = 3
          DataBinding.DataField = 'FechaInicial'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 0
          Width = 100
        end
        object FechaFinalCtrl: TcxDBDateEdit
          Left = 132
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
    object MostrarCosteCtrl: TcxDBIndexedComboBox
      Left = 141
      Top = 470
      CaptionLabel = Label29
      DataBinding.DataField = 'MostrarCoste'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'No mostrar'
        'Mostrar coste medio'
        'Mostrar '#250'ltimo coste')
      TabOrder = 9
      Width = 156
    end
    object Label1: TcxLabel
      Left = 11
      Top = 365
      TabStop = False
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 11
      Top = 419
      TabStop = False
      Caption = 'Almacen'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 277
      Top = 363
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 308
      AnchorY = 373
    end
    object Label7: TcxLabel
      Left = 277
      Top = 390
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 308
      AnchorY = 400
    end
    object Label8: TcxLabel
      Left = 277
      Top = 417
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 308
      AnchorY = 427
    end
    object Label9: TcxLabel
      Left = 277
      Top = 444
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 308
      AnchorY = 454
    end
    object Label10: TcxLabel
      Left = 11
      Top = 325
      TabStop = False
      Caption = 'Situaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label27: TcxLabel
      Left = 14
      Top = 63
      TabStop = False
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label29: TcxLabel
      Left = 11
      Top = 467
      TabStop = False
      Caption = 'Coste'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object SerieInicialCtrl: TcxDBTextEdit
      Left = 143
      Top = 7
      DescriptionLabel = cxLabel7
      DataBinding.DataField = 'SerieInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieFacturacionCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieFacturacionCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object SerieFinalCtrl: TcxDBTextEdit
      Left = 143
      Top = 34
      DescriptionLabel = cxLabel8
      DataBinding.DataField = 'SerieFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieFacturacionCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = SerieFacturacionCtrlPropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object cxLabel6: TcxLabel
      Left = 11
      Top = 10
      TabStop = False
      Caption = 'Serie'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object SerieEditSelector: TgxEditSelector
      Left = 222
      Top = 7
      Alignment = alCenterCenter
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 20
      SelectorOptions.StartEdit = SerieInicialCtrl
      SelectorOptions.EndEdit = SerieFinalCtrl
      SelectorOptions.GridView = SeriesFacturacionTableView
      SelectorOptions.RangeBox = SerieRangeBox
      SelectorOptions.FieldName = 'Codigo'
      Height = 25
      Width = 25
    end
    object cxLabel7: TcxLabel
      Left = 277
      Top = 8
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 303
      AnchorY = 18
    end
    object cxLabel8: TcxLabel
      Left = 277
      Top = 35
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 303
      AnchorY = 45
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 511
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      602
      36)
    Height = 36
    Width = 602
    object Panel3: TcxGroupBox
      Left = 215
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
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = SerieInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 478
    Top = 12
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 476
    Top = 47
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 444
    Top = 47
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_cav'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 386
    Top = 12
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 416
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 447
    Top = 12
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
    end
    object DataAlmacenInicial: TWideStringField
      FieldName = 'AlmacenInicial'
      Size = 2
    end
    object DataAlmacenFinal: TWideStringField
      FieldName = 'AlmacenFinal'
      Size = 2
    end
    object DataSituacion: TSmallintField
      FieldName = 'Situacion'
    end
    object DataRegAuxiliarInicial: TWideStringField
      FieldName = 'RegAuxiliarInicial'
      Size = 3
    end
    object DataRegAuxiliarFinal: TWideStringField
      FieldName = 'RegAuxiliarFinal'
      Size = 3
    end
    object DataCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
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
    object DataFormaCobroInicial: TWideStringField
      FieldName = 'FormaCobroInicial'
      Size = 2
    end
    object DataFormaCobroFinal: TWideStringField
      FieldName = 'FormaCobroFinal'
      Size = 2
    end
    object DataNroDocumentoInicial: TIntegerField
      FieldName = 'NroDocumentoInicial'
    end
    object DataNroDocumentoFinal: TIntegerField
      FieldName = 'NroDocumentoFinal'
    end
    object DataMostrarCoste: TSmallintField
      FieldName = 'MostrarCoste'
    end
    object DataSerieInicial: TStringField
      FieldName = 'SerieInicial'
      Size = 2
    end
    object DataSerieFinal: TStringField
      FieldName = 'SerieFinal'
      Size = 2
    end
  end
  object SeriesFacturacionTable: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.InMemoryDatabase
    Timeout = 6000
    StoreDefs = True
    FieldDefs = <
      item
        Name = 'NroRegistro'
        DataType = ftSmallint
      end
      item
        Name = 'Codigo'
        DataType = ftString
        Size = 9
      end
      item
        Name = 'Descripcion'
        DataType = ftString
        Size = 80
      end>
    IndexDefs = <
      item
        Name = 'Sequential Access Index'
        Options = [ixPrimary, ixUnique, ixDescending, ixCaseInsensitive]
      end
      item
        Name = 'Index1'
        Fields = 'NroRegistro'
      end
      item
        Name = 'Index2'
        Fields = 'Codigo'
      end>
    AutoIncFieldName = 'NroRegistro'
    TableType = ttMemVirtual
    Left = 477
    Top = 84
    object SeriesFacturacionTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
    end
    object SeriesFacturacionTableCodigo: TStringField
      DisplayWidth = 2
      FieldName = 'Codigo'
      Size = 2
    end
    object SeriesFacturacionTableDescripcion: TStringField
      DisplayWidth = 30
      FieldName = 'Descripcion'
      Size = 30
    end
  end
  object SeriesFacturacionDataSource: TDataSource
    DataSet = SeriesFacturacionTable
    Left = 443
    Top = 84
  end
  object GridViewRepository: TcxGridViewRepository
    Left = 410
    Top = 84
    object SeriesFacturacionTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = SeriesFacturacionDataSource
      DataController.KeyFieldNames = 'NroRegistro'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.FocusFirstCellOnNewRecord = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsData.Appending = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object SeriesFacturacionTableViewCodigo: TcxGridDBColumn
        DataBinding.FieldName = 'Codigo'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.OnQueryRequest = SerieFacturacionCtrlPropertiesQueryRequest
        Properties.OnValidate = SeriesFacturacionTableViewCodigoPropertiesValidate
        Width = 80
      end
      object SeriesFacturacionTableViewDescripcion: TcxGridDBColumn
        DataBinding.FieldName = 'Descripcion'
        Options.Editing = False
        Options.Focusing = False
        Width = 350
      end
    end
  end
end
