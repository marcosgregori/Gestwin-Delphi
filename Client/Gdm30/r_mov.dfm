object RptMovForm: TRptMovForm
  Left = 464
  Top = 235
  HelpType = htKeyword
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  ClientHeight = 543
  ClientWidth = 953
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
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
    Height = 502
    Width = 943
    object SelectionGroupBox: TcxGroupBox
      Left = 2
      Top = 2
      Align = alLeft
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 498
      Width = 577
      object SourcePageControl: TcxPageControl
        Left = 2
        Top = 2
        Width = 573
        Height = 460
        Align = alClient
        TabOrder = 0
        TabStop = False
        Properties.ActivePage = ParametrosTabSheet
        Properties.CustomButtons.Buttons = <>
        Properties.HideTabs = True
        Properties.TabPosition = tpBottom
        OnPageChanging = SourcePageControlPageChanging
        ClientRectBottom = 456
        ClientRectLeft = 4
        ClientRectRight = 569
        ClientRectTop = 4
        object ParametrosTabSheet: TcxTabSheet
          Caption = 'Par'#225'metros'
          ImageIndex = 0
          object SerieVentasPanel: TcxGroupBox
            Left = 0
            Top = 81
            Align = alTop
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 2
            Transparent = True
            DesignSize = (
              565
              53)
            Height = 53
            Width = 565
            object SerieRangeBox: TgxRangeBox
              Left = 121
              Top = 6
              Width = 13
              Height = 37
              Hint = 
                'Los campos situados a la derecha marcan un rango de valores.'#13'Arr' +
                'iba el l'#237'mite inferior y abajo el superior.'
              ParentShowHint = False
              ShowHint = True
              Visible = False
            end
            object SerieInicialCtrl: TcxDBTextEdit
              Left = 136
              Top = 0
              DescriptionLabel = cxLabel7
              DataBinding.DataField = 'SerieInicial'
              DataBinding.DataSource = DataSource
              Properties.OnQueryRequest = SerieFacturacionCtrlPropertiesQueryRequest
              Properties.OnEditRequest = SerieFacturacionCtrlPropertiesEditRequest
              Properties.OnValidate = SerieFacturacionCtrlPropertiesValidate
              TabOrder = 0
              Width = 25
            end
            object SerieFinalCtrl: TcxDBTextEdit
              Left = 136
              Top = 27
              DescriptionLabel = cxLabel8
              DataBinding.DataField = 'SerieFinal'
              DataBinding.DataSource = DataSource
              Enabled = False
              Properties.OnQueryRequest = SerieFacturacionCtrlPropertiesQueryRequest
              Properties.OnEditRequest = SerieFacturacionCtrlPropertiesEditRequest
              Properties.TextEditPad = tpRightHighest
              Properties.PadAlways = True
              Properties.OnValidate = SerieFacturacionCtrlPropertiesValidate
              TabOrder = 1
              Visible = False
              Width = 25
            end
            object cxLabel6: TcxLabel
              Left = 7
              Top = 3
              TabStop = False
              Caption = 'Serie'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 2
              Transparent = True
            end
            object SerieEditSelector: TgxEditSelector
              Left = 217
              Top = 0
              Alignment = alCenterCenter
              PanelStyle.Active = True
              Style.BorderStyle = ebsNone
              Style.TransparentBorder = False
              TabOrder = 3
              EditMode = tesSimple
              SelectorOptions.StartEdit = SerieInicialCtrl
              SelectorOptions.EndEdit = SerieFinalCtrl
              SelectorOptions.GridView = SeriesFacturacionTableView
              SelectorOptions.RangeBox = SerieRangeBox
              SelectorOptions.FieldName = 'Codigo'
              Height = 25
              Width = 25
            end
            object cxLabel7: TcxLabel
              Left = 250
              Top = 1
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
              Width = 288
              AnchorY = 11
            end
            object cxLabel8: TcxLabel
              Left = 250
              Top = 28
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Enabled = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              Properties.Alignment.Vert = taVCenter
              TabOrder = 5
              Transparent = True
              Height = 20
              Width = 288
              AnchorY = 38
            end
          end
          object Panel6: TcxGroupBox
            Left = 0
            Top = 134
            Align = alTop
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 3
            Height = 315
            Width = 565
            object SeleccionarCaptionPanel: TcxLabel
              Left = 2
              Top = 2
              TabStop = False
              Align = alTop
              AutoSize = False
              Caption = ' Seleccionar por ...'
              Style.TextColor = clGreen
              TabOrder = 3
              Transparent = True
              Height = 24
              Width = 561
            end
            object SeleccionPageControl: TcxPageControl
              AlignWithMargins = True
              Left = 4
              Top = 26
              Width = 557
              Height = 121
              Margins.Left = 2
              Margins.Top = 0
              Margins.Right = 2
              Margins.Bottom = 0
              Align = alTop
              TabOrder = 0
              Properties.ActivePage = NroDocumentoTabSheet
              Properties.CustomButtons.Buttons = <>
              ClientRectBottom = 117
              ClientRectLeft = 4
              ClientRectRight = 553
              ClientRectTop = 28
              object NroDocumentoTabSheet: TcxTabSheet
                Caption = 'N'#186' de &documento'
                object gxRangeBox2: TgxRangeBox
                  Left = 113
                  Top = 11
                  Width = 13
                  Height = 37
                  ParentShowHint = False
                  ShowHint = True
                end
                object NroDocumentoInicialCtrl: TcxDBTextEdit
                  Left = 128
                  Top = 4
                  DataBinding.DataField = 'NroDocumentoInicial'
                  DataBinding.DataSource = DataSource
                  Properties.OnQueryRequest = DocumentoCtrlPropertiesQueryRequest
                  Properties.OnValidate = NroDocumentoCtrlPropertiesValidate
                  TabOrder = 0
                  Width = 76
                end
                object NroDocumentoFinalCtrl: TcxDBTextEdit
                  Left = 128
                  Top = 31
                  DataBinding.DataField = 'NroDocumentoFinal'
                  DataBinding.DataSource = DataSource
                  Properties.OnQueryRequest = DocumentoCtrlPropertiesQueryRequest
                  Properties.OnValidate = NroDocumentoCtrlPropertiesValidate
                  TabOrder = 1
                  Width = 76
                end
                object DocumentoLabel: TcxLabel
                  Left = 8
                  Top = 8
                  TabStop = False
                  Caption = 'N'#186' de albar'#225'n'
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 2
                  Transparent = True
                end
              end
              object TabSheet2: TcxTabSheet
                Caption = '&Fecha'
                object gxRangeBox1: TgxRangeBox
                  Left = 113
                  Top = 12
                  Width = 13
                  Height = 37
                  ParentShowHint = False
                  ShowHint = True
                end
                object FechaAplicacionCtrl: TcxDBCheckBox
                  Left = 4
                  Top = 56
                  AutoSize = False
                  Caption = 'Fecha de entrega'
                  DataBinding.DataField = 'FechaEntrega'
                  DataBinding.DataSource = DataSource
                  Properties.Alignment = taRightJustify
                  Properties.NullStyle = nssUnchecked
                  Properties.OnChange = FechaAplicacionCtrlPropertiesChange
                  TabOrder = 2
                  Transparent = True
                  Height = 25
                  Width = 143
                end
                object FechaInicialCtrl: TcxDBDateEdit
                  Left = 128
                  Top = 4
                  DataBinding.DataField = 'FechaInicial'
                  DataBinding.DataSource = DataSource
                  Properties.Required = True
                  Properties.OnValidate = FechaCtrlPropertiesValidate
                  TabOrder = 0
                  Width = 100
                end
                object FechaFinalCtrl: TcxDBDateEdit
                  Left = 128
                  Top = 31
                  DataBinding.DataField = 'FechaFinal'
                  DataBinding.DataSource = DataSource
                  Properties.Required = True
                  Properties.OnValidate = FechaCtrlPropertiesValidate
                  TabOrder = 1
                  Width = 100
                end
                object Label6: TcxLabel
                  Left = 8
                  Top = 8
                  TabStop = False
                  Caption = 'Fecha'
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 3
                  Transparent = True
                end
              end
            end
            object FiltroPageControl: TgxFilterPageControl
              AlignWithMargins = True
              Left = 4
              Top = 157
              Width = 557
              Height = 126
              Margins.Left = 2
              Margins.Top = 10
              Margins.Right = 2
              Margins.Bottom = 0
              Align = alTop
              TabOrder = 1
              Properties.ActivePage = PropietarioTabSheet
              Properties.CustomButtons.Buttons = <>
              OnCheckBoxClick = FiltroPageControlCheckBoxClick
              ClientRectBottom = 122
              ClientRectLeft = 4
              ClientRectRight = 553
              ClientRectTop = 28
              object PropietarioTabSheet: TcxTabSheet
                Caption = 'Propietario'
                DesignSize = (
                  549
                  94)
                object gxRangeBox3: TgxRangeBox
                  Left = 113
                  Top = 15
                  Width = 13
                  Height = 37
                  ParentShowHint = False
                  ShowHint = True
                end
                object PropietarioInicialCtrl: TcxDBTextEdit
                  Left = 128
                  Top = 7
                  DescriptionLabel = Label4
                  DataBinding.DataField = 'PropietarioInicial'
                  DataBinding.DataSource = DataSource
                  Properties.OnQueryRequest = PropietarioCtrlPropertiesQueryRequest
                  Properties.TextEditPad = tpLeftZero
                  Properties.PadAlways = True
                  Properties.OnValidate = PropietarioCtrlPropertiesValidate
                  TabOrder = 0
                  Width = 46
                end
                object PropietarioFinalCtrl: TcxDBTextEdit
                  Left = 128
                  Top = 34
                  DescriptionLabel = Label7
                  DataBinding.DataField = 'PropietarioFinal'
                  DataBinding.DataSource = DataSource
                  Properties.OnQueryRequest = PropietarioCtrlPropertiesQueryRequest
                  Properties.TextEditPad = tpLeftHighest
                  Properties.PadAlways = True
                  Properties.OnValidate = PropietarioCtrlPropertiesValidate
                  TabOrder = 1
                  Width = 46
                end
                object Label3: TcxLabel
                  Left = 8
                  Top = 8
                  TabStop = False
                  Caption = 'C'#243'digo'
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 2
                  Transparent = True
                end
                object Label4: TcxLabel
                  Left = 206
                  Top = 8
                  TabStop = False
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  Style.TextColor = clNavy
                  Properties.Alignment.Horz = taLeftJustify
                  Properties.Alignment.Vert = taVCenter
                  TabOrder = 3
                  Transparent = True
                  Height = 20
                  Width = 331
                  AnchorY = 18
                end
                object Label7: TcxLabel
                  Left = 206
                  Top = 35
                  TabStop = False
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  Style.TextColor = clNavy
                  Properties.Alignment.Horz = taLeftJustify
                  Properties.Alignment.Vert = taVCenter
                  TabOrder = 4
                  Transparent = True
                  Height = 20
                  Width = 331
                  AnchorY = 45
                end
              end
              object GrupoTabSheet: TcxTabSheet
                Caption = '&Grupo'
                DesignSize = (
                  549
                  94)
                object gxRangeBox6: TgxRangeBox
                  Left = 113
                  Top = 14
                  Width = 13
                  Height = 37
                  ParentShowHint = False
                  ShowHint = True
                end
                object GrupoInicialCtrl: TcxDBTextEdit
                  Left = 128
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
                  Left = 128
                  Top = 32
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
                  Top = 7
                  TabStop = False
                  Caption = 'C'#243'digo'
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 2
                  Transparent = True
                end
                object Label15: TcxLabel
                  Left = 215
                  Top = 7
                  TabStop = False
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  Style.TextColor = clNavy
                  Properties.Alignment.Horz = taLeftJustify
                  Properties.Alignment.Vert = taVCenter
                  TabOrder = 3
                  Transparent = True
                  Height = 20
                  Width = 323
                  AnchorY = 17
                end
                object Label16: TcxLabel
                  Left = 215
                  Top = 33
                  TabStop = False
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  Style.TextColor = clNavy
                  Properties.Alignment.Horz = taLeftJustify
                  Properties.Alignment.Vert = taVCenter
                  TabOrder = 4
                  Transparent = True
                  Height = 20
                  Width = 323
                  AnchorY = 43
                end
              end
              object VendedorTabSheet: TcxTabSheet
                Caption = '&Vendedor'
                DesignSize = (
                  549
                  94)
                object gxRangeBox7: TgxRangeBox
                  Left = 113
                  Top = 14
                  Width = 13
                  Height = 37
                  ParentShowHint = False
                  ShowHint = True
                end
                object VendedorInicialCtrl: TcxDBTextEdit
                  Left = 128
                  Top = 6
                  DescriptionLabel = Label21
                  DataBinding.DataField = 'VendedorInicial'
                  DataBinding.DataSource = DataSource
                  Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
                  Properties.TextEditPad = tpLeftZero
                  Properties.OnValidate = VendedorCtrlPropertiesValidate
                  TabOrder = 0
                  Width = 25
                end
                object VendedorFinalCtrl: TcxDBTextEdit
                  Left = 128
                  Top = 32
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
                  Top = 7
                  TabStop = False
                  Caption = 'C'#243'digo'
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 2
                  Transparent = True
                end
                object Label21: TcxLabel
                  Left = 215
                  Top = 7
                  TabStop = False
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  Style.TextColor = clNavy
                  Properties.Alignment.Horz = taLeftJustify
                  Properties.Alignment.Vert = taVCenter
                  TabOrder = 3
                  Transparent = True
                  Height = 20
                  Width = 323
                  AnchorY = 17
                end
                object Label22: TcxLabel
                  Left = 215
                  Top = 33
                  TabStop = False
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  Style.TextColor = clNavy
                  Properties.Alignment.Horz = taLeftJustify
                  Properties.Alignment.Vert = taVCenter
                  TabOrder = 4
                  Transparent = True
                  Height = 20
                  Width = 323
                  AnchorY = 43
                end
              end
              object FormaCobroTabSheet: TcxTabSheet
                Caption = '&Forma de cobro'
                ImageIndex = 4
                DesignSize = (
                  549
                  94)
                object gxRangeBox8: TgxRangeBox
                  Left = 113
                  Top = 15
                  Width = 13
                  Height = 37
                  ParentShowHint = False
                  ShowHint = True
                end
                object FormaCobroInicialCtrl: TcxDBTextEdit
                  Left = 128
                  Top = 6
                  DescriptionLabel = Label23
                  DataBinding.DataField = 'FormaCobroInicial'
                  DataBinding.DataSource = DataSource
                  Properties.OnQueryRequest = FormaCobroCtrlPropertiesQueryRequest
                  Properties.TextEditPad = tpLeftZero
                  Properties.OnValidate = FormaCobroCtrlPropertiesValidate
                  TabOrder = 0
                  Width = 25
                end
                object FormaCobroFinalCtrl: TcxDBTextEdit
                  Left = 128
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
                  Top = 7
                  TabStop = False
                  Caption = 'C'#243'digo'
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 2
                  Transparent = True
                end
                object Label23: TcxLabel
                  Left = 215
                  Top = 7
                  TabStop = False
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  Style.TextColor = clNavy
                  Properties.Alignment.Horz = taLeftJustify
                  Properties.Alignment.Vert = taVCenter
                  TabOrder = 3
                  Transparent = True
                  Height = 20
                  Width = 323
                  AnchorY = 17
                end
                object Label24: TcxLabel
                  Left = 215
                  Top = 34
                  TabStop = False
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  Style.TextColor = clNavy
                  Properties.Alignment.Horz = taLeftJustify
                  Properties.Alignment.Vert = taVCenter
                  TabOrder = 4
                  Transparent = True
                  Height = 20
                  Width = 323
                  AnchorY = 44
                end
              end
              object RegistroAuxiliarTabSheet: TcxTabSheet
                Caption = '&Registro auxiliar'
                ImageIndex = 5
                DesignSize = (
                  549
                  94)
                object gxRangeBox9: TgxRangeBox
                  Left = 113
                  Top = 42
                  Width = 13
                  Height = 37
                  ParentShowHint = False
                  ShowHint = True
                end
                object RegAuxiliarInicialCtrl: TcxDBTextEdit
                  Left = 128
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
                  Left = 128
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
                object CodigoPropietarioCtrl: TcxDBTextEdit
                  Left = 128
                  Top = 6
                  DescriptionLabel = Label25
                  DataBinding.DataField = 'CodigoPropietario'
                  DataBinding.DataSource = DataSource
                  Properties.OnQueryRequest = PropietarioCtrlPropertiesQueryRequest
                  Properties.TextEditPad = tpLeftZero
                  Properties.OnValidate = CodigoPropietarioCtrlPropertiesValidate
                  TabOrder = 0
                  Width = 46
                end
                object RegistroAuxiliarLabel: TcxLabel
                  Left = 8
                  Top = 37
                  TabStop = False
                  Caption = 'Registro auxiliar'
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 3
                  Transparent = True
                end
                object Label20: TcxLabel
                  Left = 8
                  Top = 7
                  TabStop = False
                  Caption = 'Propietario'
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 4
                  Transparent = True
                end
                object Label25: TcxLabel
                  Left = 206
                  Top = 7
                  TabStop = False
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  Style.TextColor = clNavy
                  Properties.Alignment.Horz = taLeftJustify
                  Properties.Alignment.Vert = taVCenter
                  TabOrder = 5
                  Transparent = True
                  Height = 20
                  Width = 323
                  AnchorY = 17
                end
                object Label26: TcxLabel
                  Left = 206
                  Top = 37
                  TabStop = False
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  Style.TextColor = clNavy
                  Properties.Alignment.Horz = taLeftJustify
                  Properties.Alignment.Vert = taVCenter
                  TabOrder = 6
                  Transparent = True
                  Height = 20
                  Width = 323
                  AnchorY = 47
                end
                object Label27: TcxLabel
                  Left = 206
                  Top = 61
                  TabStop = False
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  Style.TextColor = clNavy
                  Properties.Alignment.Horz = taLeftJustify
                  Properties.Alignment.Vert = taVCenter
                  TabOrder = 7
                  Transparent = True
                  Height = 20
                  Width = 323
                  AnchorY = 71
                end
              end
              object TransportistaTabSheet: TcxTabSheet
                Caption = 'Trans&portista'
                ImageIndex = 5
                DesignSize = (
                  549
                  94)
                object gxRangeBox4: TgxRangeBox
                  Left = 113
                  Top = 13
                  Width = 13
                  Height = 37
                  ParentShowHint = False
                  ShowHint = True
                end
                object TransportistaInicialCtrl: TcxDBTextEdit
                  Left = 128
                  Top = 5
                  DescriptionLabel = Label9
                  DataBinding.DataField = 'TransportistaInicial'
                  DataBinding.DataSource = DataSource
                  Properties.OnQueryRequest = TransportistaCtrlPropertiesQueryRequest
                  Properties.TextEditPad = tpLeftZero
                  Properties.PadAlways = True
                  Properties.OnValidate = TransportistaCtrlPropertiesValidate
                  TabOrder = 0
                  Width = 25
                end
                object TransportistaFinalCtrl: TcxDBTextEdit
                  Left = 128
                  Top = 33
                  DescriptionLabel = Label10
                  DataBinding.DataField = 'TransportistaFinal'
                  DataBinding.DataSource = DataSource
                  Properties.OnQueryRequest = TransportistaCtrlPropertiesQueryRequest
                  Properties.TextEditPad = tpLeftHighest
                  Properties.PadAlways = True
                  Properties.OnValidate = TransportistaCtrlPropertiesValidate
                  TabOrder = 1
                  Width = 25
                end
                object Label8: TcxLabel
                  Left = 8
                  Top = 6
                  TabStop = False
                  Caption = 'C'#243'digo'
                  Properties.Alignment.Horz = taLeftJustify
                  TabOrder = 2
                  Transparent = True
                end
                object Label9: TcxLabel
                  Left = 215
                  Top = 6
                  TabStop = False
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  Style.TextColor = clNavy
                  Properties.Alignment.Horz = taLeftJustify
                  Properties.Alignment.Vert = taVCenter
                  TabOrder = 3
                  Transparent = True
                  Height = 20
                  Width = 323
                  AnchorY = 16
                end
                object Label10: TcxLabel
                  Left = 215
                  Top = 34
                  TabStop = False
                  Anchors = [akLeft, akTop, akRight]
                  AutoSize = False
                  Style.TextColor = clNavy
                  Properties.Alignment.Horz = taLeftJustify
                  Properties.Alignment.Vert = taVCenter
                  TabOrder = 4
                  Transparent = True
                  Height = 20
                  Width = 323
                  AnchorY = 44
                end
              end
            end
            object cxGroupBox2: TcxGroupBox
              Left = 2
              Top = 283
              Align = alTop
              PanelStyle.Active = True
              Style.BorderStyle = ebsNone
              TabOrder = 2
              DesignSize = (
                561
                30)
              Height = 30
              Width = 561
              object SituacionLabel: TcxLabel
                Left = 5
                Top = 9
                TabStop = False
                Anchors = [akLeft, akBottom]
                Caption = 'Situaci'#243'n'
                Properties.Alignment.Horz = taLeftJustify
                TabOrder = 0
                Transparent = True
              end
              object SituacionCtrl: TcxDBIndexedComboBox
                Left = 134
                Top = 5
                CaptionLabel = SituacionLabel
                Anchors = [akLeft, akBottom]
                DataBinding.DataField = 'Situacion'
                DataBinding.DataSource = DataSource
                Properties.Alignment.Horz = taLeftJustify
                Properties.DropDownListStyle = lsFixedList
                Properties.ImmediatePost = True
                Properties.Items.Strings = (
                  '<Todos>'
                  'Pendientes de recibir (totalmente)'
                  'Pendientes de recibir (total o parcialmente)'
                  'Parcialmente recibidos'
                  'Totalmente recibidos')
                Properties.OnEditValueChanged = SituacionCtrlPropertiesEditValueChanged
                TabOrder = 1
                Width = 210
              end
            end
          end
          object SerieComprasPanel: TcxGroupBox
            Left = 0
            Top = 29
            Align = alTop
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 1
            Transparent = True
            Height = 52
            Width = 565
            object TodasLasSeriesCtrl: TcxDBCheckBox
              Left = 5
              Top = 0
              AutoSize = False
              Caption = 'Todas las series'
              DataBinding.DataField = 'TodasLasSeries'
              DataBinding.DataSource = DataSource
              Properties.Alignment = taRightJustify
              Properties.ImmediatePost = True
              Properties.MultiLine = True
              Properties.NullStyle = nssUnchecked
              Properties.OnEditValueChanged = TodasLasSeriesCtrlPropertiesEditValueChanged
              Style.TransparentBorder = False
              TabOrder = 0
              Transparent = True
              Height = 25
              Width = 149
            end
            object SerieFacturacionCtrl: TcxDBTextEdit
              Left = 136
              Top = 25
              CaptionLabel = Label1
              DataBinding.DataField = 'Serie'
              DataBinding.DataSource = DataSource
              TabOrder = 1
              Width = 25
            end
            object Label1: TcxLabel
              Left = 7
              Top = 28
              TabStop = False
              Caption = 'Serie'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 2
              Transparent = True
            end
          end
          object TipoMovimientoPanel: TcxGroupBox
            Left = 0
            Top = 0
            Align = alTop
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 0
            DesignSize = (
              565
              29)
            Height = 29
            Width = 565
            object TipoMovimientoCtrl: TcxDBSpinEdit
              Left = 136
              Top = 4
              DescriptionLabel = cxLabel3
              DataBinding.DataField = 'TipoMovimiento'
              DataBinding.DataSource = DataSource
              Properties.OnQueryRequest = TipoMovimientoCtrlPropertiesQueryRequest
              Properties.AssignedValues.MinValue = True
              Properties.DisplayFormat = '#'
              Properties.EditFormat = '#'
              Properties.MaxValue = 99.000000000000000000
              Properties.OnValidate = TipoMovimientoCtrlPropertiesValidate
              TabOrder = 0
              Width = 67
            end
            object cxLabel2: TcxLabel
              Left = 7
              Top = 7
              TabStop = False
              Caption = 'Tipo de movimiento'
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              TabOrder = 1
              Transparent = True
            end
            object cxLabel3: TcxLabel
              Left = 250
              Top = 7
              TabStop = False
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Style.TextColor = clNavy
              Style.TransparentBorder = False
              Properties.Alignment.Horz = taLeftJustify
              Properties.Alignment.Vert = taVCenter
              TabOrder = 2
              Transparent = True
              Height = 20
              Width = 268
              AnchorY = 17
            end
          end
        end
        object RegistrosTabSheet: TcxTabSheet
          Caption = 'Registros'
          ImageIndex = 1
          inline SmvFrame: TSmvFrame
            Left = 0
            Top = 0
            Width = 565
            Height = 452
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            ExplicitWidth = 565
            ExplicitHeight = 452
            inherited TableViewManager: TGridTableViewController
              Left = 527
              TabOrder = 1
              ExplicitLeft = 527
              ExplicitHeight = 452
              Height = 452
            end
            inherited Grid: TcxGrid
              Width = 527
              Height = 452
              TabOrder = 0
              ExplicitWidth = 535
              ExplicitHeight = 460
              inherited GridView: TcxGridDBTableView
                inherited GridViewEjercicio: TcxGridDBColumn
                  Caption = 'Ejerc.'
                  Width = 42
                end
                inherited GridViewSerie: TcxGridDBColumn
                  Width = 25
                end
                inherited GridViewNroDocumento: TcxGridDBColumn
                  Width = 67
                end
                inherited GridViewFecha: TcxGridDBColumn
                  Width = 49
                end
                inherited GridViewPropietario: TcxGridDBColumn
                  Caption = 'Prop.'
                  Width = 51
                end
                inherited GridViewNombre: TcxGridDBColumn
                  Width = 250
                end
                inherited GridViewNroOperacion: TcxGridDBColumn
                  Properties.OnQueryRequest = nil
                  Properties.OnValidate = nil
                end
              end
            end
            inherited RelacionDocumentosTableSource: TDataSource
              Left = 468
              Top = 94
            end
            inherited FrmMovimientoTable: TnxeTable
              Left = 501
              Top = 125
            end
            inherited RelacionDocumentosTable: TnxeTable
              Left = 500
              Top = 94
            end
            inherited SQLSet: TgxSQLSet
              Left = 500
              Top = 158
            end
          end
        end
      end
      object PageControlNavigator: TgxPageControlNavigator
        Left = 2
        Top = 462
        Align = alBottom
        Alignment = alCenterCenter
        ParentBackground = False
        ParentColor = False
        TabOrder = 1
        PageControl = SourcePageControl
        OnClickButton = PageControlNavigatorClickButton
        Height = 34
        Width = 573
      end
    end
    object ParametersScrollBox: TcxGroupBox
      Left = 587
      Top = 2
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 498
      Width = 354
      object cxGroupBox3: TcxGroupBox
        Left = 2
        Top = 376
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 5
        Height = 27
        Width = 350
        object AgruparCtrl: TcxDBCheckBox
          Left = 2
          Top = 0
          Caption = 'Agrupar'
          DataBinding.DataField = 'Agrupar'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnEditValueChanged = AgruparCtrlPropertiesEditValueChanged
          TabOrder = 0
          Transparent = True
        end
      end
      object ImpresoPanel: TcxGroupBox
        Left = 2
        Top = 267
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 4
        Height = 109
        Width = 350
        object CopiaPropietarioCtrl: TcxDBCheckBox
          AlignWithMargins = True
          Left = 2
          Top = 27
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Co&pia para el propietario'
          DataBinding.DataField = 'CopiaPropietario'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          TabOrder = 1
          Transparent = True
          ExplicitTop = 23
        end
        object MostrarDescuentosCtrl: TcxDBCheckBox
          AlignWithMargins = True
          Left = 2
          Top = 2
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Mostrar descuentos'
          DataBinding.DataField = 'MostrarDescuentos'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          TabOrder = 0
          Transparent = True
        end
        object cxGroupBox1: TcxGroupBox
          Left = 2
          Top = 52
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 2
          DesignSize = (
            346
            27)
          Height = 27
          Width = 346
          object cxLabel4: TcxLabel
            Left = 5
            Top = 5
            TabStop = False
            Caption = 'Nro. copias'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 0
            Transparent = True
          end
          object DescNroCopiasLabel: TcxLabel
            Left = 154
            Top = 1
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 1
            Transparent = True
            Height = 20
            Width = 173
            AnchorY = 11
          end
          object NroCopiasCtrl: TcxDBSpinEdit
            Left = 90
            Top = 2
            DescriptionLabel = DescNroCopiasLabel
            DataBinding.DataField = 'NroCopias'
            DataBinding.DataSource = DataSource
            Properties.AssignedValues.MinValue = True
            Properties.DisplayFormat = '#'
            Properties.EditFormat = '#'
            Properties.ImmediatePost = True
            Properties.MaxValue = 99.000000000000000000
            Properties.OnValidate = NroCopiasCtrlPropertiesValidate
            TabOrder = 2
            Width = 54
          end
        end
        object cxGroupBox4: TcxGroupBox
          Left = 2
          Top = 79
          Align = alTop
          PanelStyle.Active = True
          Style.BorderStyle = ebsNone
          TabOrder = 3
          DesignSize = (
            346
            27)
          Height = 27
          Width = 346
          object cxLabel1: TcxLabel
            Left = 5
            Top = 5
            TabStop = False
            Caption = 'Formato'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 0
            Transparent = True
          end
          object FormatoCtrl: TcxDBSpinEdit
            Left = 90
            Top = 2
            DescriptionLabel = FormatoLabel
            DataBinding.DataField = 'Formato'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = FormatoCtrlPropertiesQueryRequest
            Properties.OnEditRequest = FormatoCtrlPropertiesEditRequest
            Properties.AssignedValues.MinValue = True
            Properties.DisplayFormat = '#'
            Properties.EditFormat = '#'
            Properties.MaxValue = 99.000000000000000000
            Properties.OnValidate = FormatoCtrlPropertiesValidate
            TabOrder = 1
            Width = 54
          end
          object FormatoLabel: TcxLabel
            Left = 154
            Top = 3
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            Properties.Alignment.Vert = taVCenter
            TabOrder = 2
            Transparent = True
            Height = 20
            Width = 173
            AnchorY = 13
          end
        end
      end
      object ListadoPanel: TcxGroupBox
        Left = 2
        Top = 91
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 49
        Width = 350
        object IniciarPaginaGrupoCtrl: TcxDBCheckBox
          AlignWithMargins = True
          Left = 2
          Top = 2
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'P'#225'gina nueva por grupo'
          DataBinding.DataField = 'IniciarPaginaGrupo'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.NullStyle = nssUnchecked
          TabOrder = 0
          Transparent = True
        end
        object DetalladoCtrl: TcxDBCheckBox
          AlignWithMargins = True
          Left = 2
          Top = 27
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Listado detallado'
          DataBinding.DataField = 'Detallado'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnChange = DetalladoCtrlPropertiesChange
          TabOrder = 1
          Transparent = True
        end
      end
      object ValorarPanel: TcxGroupBox
        Left = 2
        Top = 140
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 3
        Height = 25
        Width = 350
        object ValorarCtrl: TcxDBCheckBox
          AlignWithMargins = True
          Left = 2
          Top = 2
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Valorar (mostrar precios y dtos.) '
          DataBinding.DataField = 'Valorar'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ValorarCtrlPropertiesQueryRequest
          Properties.Alignment = taLeftJustify
          Properties.NullStyle = nssUnchecked
          TabOrder = 0
          Transparent = True
        end
      end
      object PedidosPanel: TcxGroupBox
        Left = 2
        Top = 43
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 48
        Width = 350
        object ImportePendienteCtrl: TcxDBCheckBox
          AlignWithMargins = True
          Left = 2
          Top = 27
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Mostrar el importe pendiente'
          DataBinding.DataField = 'ImportePendiente'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.NullStyle = nssUnchecked
          TabOrder = 1
          Transparent = True
          ExplicitTop = 23
        end
        object LineasPendientesCtrl: TcxDBCheckBox
          AlignWithMargins = True
          Left = 2
          Top = 2
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Mostrar solo lineas pendientes'
          DataBinding.DataField = 'LineasPendientes'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.NullStyle = nssUnchecked
          TabOrder = 0
          Transparent = True
        end
      end
      object PDFPanel: TcxGroupBox
        Left = 2
        Top = 165
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Height = 102
        Width = 350
        object GenerarFicheroCtrl: TcxDBCheckBox
          AlignWithMargins = True
          Left = 2
          Top = 2
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Generar fichero PDF'
          DataBinding.DataField = 'GenerarFicheroPDF'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnChange = FicheroPDFPropertiesChange
          TabOrder = 0
          Transparent = True
        end
        object EnviarPorCorreoCtrl: TcxDBCheckBox
          AlignWithMargins = True
          Left = 22
          Top = 27
          Margins.Left = 20
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'E&nviar por correo (e-mail)'
          DataBinding.DataField = 'EnviarPorCorreo'
          DataBinding.DataSource = DataSource
          Enabled = False
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Properties.OnChange = FicheroPDFPropertiesChange
          TabOrder = 1
          Transparent = True
        end
        object ExcluirEnviadosCtrl: TcxDBCheckBox
          AlignWithMargins = True
          Left = 42
          Top = 52
          Margins.Left = 40
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Exc&luir los ya enviados'
          DataBinding.DataField = 'ExcluirEnviados'
          DataBinding.DataSource = DataSource
          Enabled = False
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          TabOrder = 2
          Transparent = True
        end
        object ExcluirPropietariosCorreoCtrl: TcxDBCheckBox
          AlignWithMargins = True
          Left = 2
          Top = 77
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'E&xcluir propietarios de correo'
          DataBinding.DataField = 'ExcluirPropietariosCorreo'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taLeftJustify
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          TabOrder = 3
          Transparent = True
        end
      end
      object ImagesGroupBox: TcxGroupBox
        Left = 2
        Top = 2
        Align = alTop
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        TabOrder = 6
        Height = 41
        Width = 350
        object ImpresoButton: TcxButton
          Left = 235
          Top = 2
          Width = 36
          Height = 37
          Hint = 'Imprimir o previsualizar'
          Align = alRight
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
            3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
            462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
            617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
            2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
            77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
            22307078222077696474683D223234707822206865696768743D223234707822
            2076696577426F783D223020302032342032342220656E61626C652D6261636B
            67726F756E643D226E6577203020302032342032342220786D6C3A7370616365
            3D227072657365727665223E262331303B20203C672069643D2269636F6E223E
            0D0A09093C7061746820643D224D322E352C3138632D302E3939392C302C2D31
            2E352C2D302E37352C2D312E352C2D312E3373302C2D342E332C302C2D342E33
            63302C2D322E3937352C302E3232392C2D352E342C312E322C2D352E34683139
            2E3663312E3032372C302C312E322C322E3432352C312E322C352E3473302C33
            2E3733352C302C342E32732D302E3530312C312E342C2D312E352C312E342220
            66696C6C2D72756C653D226576656E6F6464222066696C6C3D22234141423242
            44222F3E0D0A09093C7061746820643D224D312C313476322E353163302C302E
            3935312C302E3332392C312E34392C312E3332382C312E34396831392E323036
            63302E3939392C302C312E3436362C2D302E3533382C312E3436362C2D312E34
            3956313448317A222066696C6C2D72756C653D226576656E6F6464222066696C
            6C3D2223384539343943222F3E0D0A09093C7061746820643D224D31382E3035
            2C313848352E393338632D302E3531382C302C2D302E3933382C2D302E34322C
            2D302E3933382C2D302E3933385631362E303563302C2D302E35382C302E3437
            2C2D312E30352C312E30352C2D312E30356831312E3963302E35382C302C312E
            30352C302E34372C312E30352C312E303576314331392C31372E3537352C3138
            2E3537352C31382C31382E30352C31387A222066696C6C2D72756C653D226576
            656E6F6464222066696C6C3D2223363536443738222F3E0D0A09093C70617468
            20643D224D31382C313676362E34383463302C302E3238352C2D302E3233312C
            302E3531362C2D302E3531362C302E35313648362E353237632D302E3238352C
            302C2D302E3531352C2D302E32332C2D302E3531362C2D302E3531354C362C31
            364831387A222066696C6C2D72756C653D226576656E6F6464222066696C6C3D
            2223453645394545222F3E0D0A09093C7061746820643D224D31382C3136682D
            322E3634386C2D322E3236372C3768342E33393863302E3238352C302C302E35
            31362C2D302E3233312C302E3531362C2D302E3531365631367A222066696C6C
            2D72756C653D226576656E6F6464222066696C6C3D222332333146323022206F
            7061636974793D22302E3036222F3E0D0A09093C7061746820643D224D31392E
            3433382C3763302E3331312C302C302E3536332C302E3235322C302E3536332C
            302E35363376342E30313863302C302E3738342C2D302E3439362C312E343139
            2C2D312E3331392C312E34313948352E33632D302E3832332C302C2D312E3239
            372C2D302E3633352C2D312E3239372C2D312E343139762D342E303263302C2D
            302E33312C302E3235312C2D302E3536312C302E3536312C2D302E3536314831
            392E3433387A222066696C6C2D72756C653D226576656E6F6464222066696C6C
            3D2223353438364335222F3E0D0A09093C7061746820643D224D342C31307631
            2E35383163302C302E3738342C302E3437372C312E3431392C312E332C312E34
            31396831332E33383163302E3832332C302C312E3331392C2D302E3633352C31
            2E3331392C2D312E34313956313048347A222066696C6C2D72756C653D226576
            656E6F6464222066696C6C3D2223334537344145222F3E0D0A09093C70617468
            20643D224D31392C37483556342E3663302C2D302E3333382C302E3237342C2D
            302E3631332C302E3631332C2D302E3631336831322E37373563302E3333382C
            302C302E3631332C302E3237342C302E3631332C302E36313356377A22206669
            6C6C2D72756C653D226576656E6F6464222066696C6C3D222336353644373822
            2F3E0D0A09093C7061746820643D224D362E3439312C312E3030394831372E35
            63302E3237312C302C302E3439312C302E32322C302E3439312C302E3439314C
            31382C37483656312E3543362C312E3232392C362E32322C312E3030392C362E
            3439312C312E3030397A222066696C6C2D72756C653D226576656E6F64642220
            66696C6C3D2223453645394545222F3E0D0A09093C7061746820643D224D3137
            2E3939352C3763302E3030322C2D302E30332C302E3030352C2D302E30362C30
            2E3030352C2D302E30393156312E35373563302C2D302E3331382C2D302E3235
            372C2D302E3537352C2D302E3537352C2D302E353735682D322E303538632D30
            2E3030392C302C2D302E3031362C302E3030352C2D302E3031392C302E303134
            4C31332E34312C374831372E3939357A222066696C6C2D72756C653D22657665
            6E6F6464222066696C6C3D222332333146323022206F7061636974793D22302E
            3036222F3E0D0A09093C7061746820643D224D322E352C3133683163302E3237
            362C302C302E352C302E3232342C302E352C302E35763163302C302E3237362C
            2D302E3232342C302E352C2D302E352C302E3548322E35632D302E3237362C30
            2C2D302E352C2D302E3232342C2D302E352C2D302E35762D3143322C31332E32
            32342C322E3232342C31332C322E352C31337A222066696C6C2D72756C653D22
            6576656E6F6464222066696C6C3D2223454435353634222F3E0D0A09093C7061
            746820643D224D382E352C32302E3568374D382E352C31382E35683722206669
            6C6C3D226E6F6E6522207374726F6B653D222338453934394322207374726F6B
            652D77696474683D223122207374726F6B652D6C696E656361703D22726F756E
            6422207374726F6B652D6D697465726C696D69743D2231222F3E0D0A09093C70
            61746820643D224D31382C31374836762D316831325631377A4D31382C354836
            763268313256357A222066696C6C3D222332333146323022206F706163697479
            3D22302E31222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
          PaintStyle = bpsGlyph
          ParentShowHint = False
          ShowHint = True
          SpeedButtonOptions.GroupIndex = 1
          SpeedButtonOptions.Down = True
          SpeedButtonOptions.Transparent = True
          TabOrder = 0
          OnClick = ImpresoButtonClick
        end
        object MailButton: TcxButton
          Left = 271
          Top = 2
          Width = 36
          Height = 37
          Hint = 'Enviar por correo'
          Align = alRight
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
            3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
            462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
            617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
            2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
            77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
            22307078222077696474683D223234707822206865696768743D223234707822
            2076696577426F783D223020302032342032342220656E61626C652D6261636B
            67726F756E643D226E6577203020302032342032342220786D6C3A7370616365
            3D227072657365727665223E262331303B20203C672069643D226D61696E223E
            0D0A09093C636C6970506174682069643D22636C69705F6D61736B223E0D0A09
            09093C7061746820643D224D31342C31392E3563302C2D332E303332372C322E
            343637332C2D352E352C352E352C2D352E3563312E383538382C302C332E3530
            33392C302E393237382C342E352C322E33343336563048307632346831362E33
            3433364331342E393237382C32332E303033392C31342C32312E333538382C31
            342C31392E357A222F3E0D0A09093C2F636C6970506174683E0D0A09093C6720
            69643D2269636F6E2220636C69702D706174683D2275726C2823636C69705F6D
            61736B29223E0D0A0909093C672069643D227472616E73666F726D65645F6963
            6F6E22207472616E73666F726D3D227472616E736C617465282D31202D312922
            3E0D0A090909093C7061746820643D224D312E333037352C342E333736354331
            2E313136352C342E353736362C312C342E383430382C312C352E313239347631
            332E3734313263302C302E333332362C302E313534382C302E363332382C302E
            342C302E383463302E323132372C302E313739372C32302E393837332C302E31
            3739372C32312E322C3063302E323435322C2D302E323037322C302E342C2D30
            2E353037342C302E342C2D302E383456352E3132393463302C2D302E33333236
            2C2D302E313534382C2D302E363332382C2D302E333939392C2D302E38333939
            4332322E333837342C342E313039372C312E353237362C342E313435372C312E
            333037352C342E333736357A222066696C6C3D2223414142324244222F3E0D0A
            090909093C7061746820643D224D31302E303537312C31312E353239346C2D38
            2E383631332C372E3935363443312E343130362C31392E373934362C312E3738
            30382C32302C322E322C32306831392E3663302E343139322C302C302E373839
            342C2D302E323035342C312E303034312C2D302E353134326C2D382E38363133
            2C2D372E393536344331322E382C31302E363037312C31312E313636372C3130
            2E353934352C31302E303537312C31312E353239347A222066696C6C3D222343
            4344304439222F3E0D0A090909093C7061746820643D224D31322C31352E3338
            38324C312E313935392C342E3532363663302E323134382C2D302E333235332C
            32312E333933352C2D302E333235332C32312E363038332C304C31322C31352E
            333838327A222066696C6C3D222332343238324422206F7061636974793D2230
            2E3231222F3E0D0A090909093C7061746820643D224D31322C31332E34313138
            4C312E313935392C342E3531343243312E343130362C342E323035342C312E37
            3830382C342C322E322C346831392E3663302E343139322C302C302E37383934
            2C302E323035342C312E303034312C302E353134324C31322C31332E34313138
            7A222066696C6C3D2223453645394545222F3E0D0A0909093C2F673E0D0A0909
            3C2F673E0D0A09093C672069643D226F7665726C6179223E0D0A0909093C6369
            72636C652063783D2231392E35222063793D2231392E352220723D22342E3438
            3939222066696C6C3D2223344643304538222F3E0D0A0909093C706174682064
            3D224D32322E363734392C31362E33323531632D302E303036312C2D302E3030
            36312C2D302E303132342C2D302E303132312C2D302E303138362C2D302E3031
            38326C2D362E333439332C362E3334393363302E303036312C302E303036322C
            302E3031322C302E303132352C302E303138322C302E3031383663312E373533
            342C312E373533342C342E353936332C312E373533342C362E333439372C3053
            32342E343238332C31382E303738362C32322E363734392C31362E333235317A
            222066696C6C3D222333424145444122206F7061636974793D22302E37222F3E
            0D0A0909093C7061746820643D224D32322E333431372C31392E333536346C2D
            322E363939312C2D322E36393931632D302E303737382C2D302E303737382C2D
            302E323035312C2D302E303737382C2D302E323832382C306C2D302E34323433
            2C302E34323433632D302E303737382C302E303737382C2D302E303737382C30
            2E323035362C302C302E323833344C32302E35372C3139682D332E3730393863
            2D302E31312C302C2D302E323630322C302E303838392C2D302E323630322C30
            2E3139383976302E3663302C302E31312C302E313530322C302E323031312C30
            2E323630322C302E3230313168332E373037366C2D312E363332332C312E3633
            3138632D302E303737382C302E303737382C2D302E303737382C302E32303438
            2C302C302E323832366C302E343234332C302E3432343163302E303737382C30
            2E303737382C302E323035312C302E303737372C302E323832382C2D302E3030
            30316C322E323734392C2D322E323734396C302E343234332C2D302E34323433
            4332322E343139342C31392E353631342C32322E343139342C31392E34333431
            2C32322E333431372C31392E333536347A222066696C6C3D2223464646464646
            222F3E0D0A09093C2F673E0D0A093C2F673E0D0A3C2F7376673E0D0A}
          PaintStyle = bpsGlyph
          ParentShowHint = False
          ShowHint = True
          SpeedButtonOptions.GroupIndex = 1
          SpeedButtonOptions.Transparent = True
          TabOrder = 1
          OnClick = MailButtonClick
        end
        object PDFButton: TcxButton
          Left = 307
          Top = 2
          Width = 41
          Height = 37
          Hint = 'Generar fichero PDF'
          Align = alRight
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
            3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
            462D38223F3E0D0A3C7376672077696474683D22313030252220686569676874
            3D2231303025222076696577426F783D22302030203234203234222076657273
            696F6E3D22312E3122207374796C653D2266696C6C2D72756C653A6576656E6F
            64643B636C69702D72756C653A6576656E6F64643B7374726F6B652D6C696E65
            6A6F696E3A726F756E643B7374726F6B652D6D697465726C696D69743A323B22
            20786D6C6E733D22687474703A2F2F7777772E77332E6F72672F323030302F73
            7667223E0D0A093C7061746820643D224D20332E34303920312E35204C203230
            2E35393120312E3520432032312E36343520312E352032322E3520322E333535
            2032322E3520332E343039204C2032322E352032302E35393120432032322E35
            2032312E3634352032312E3634352032322E352032302E3539312032322E3520
            4C20332E3430392032322E35204320322E3335352032322E3520312E35203231
            2E36343520312E352032302E353931204C20312E3520332E343039204320312E
            3520322E33353520322E33353520312E3520332E34303920312E35205A222073
            74796C653D2266696C6C3A726762283231392C36382C3833293B66696C6C2D72
            756C653A6E6F6E7A65726F3B222F3E0D0A093C7061746820643D224D20382E34
            30352031322E313336204320372E3930322031322E31333620372E3536372031
            312E38353920372E35332031312E343133204320372E3530342031312E303836
            20372E3637382031302E32313320392E38353920392E31363620432031302E30
            303920382E3831372031302E34373120372E3639312031302E38373820362E31
            3320432031302E373520352E3930392031302E32393720352E3037312031302E
            32323520342E32303120432031302E31333220332E3038342031302E37343720
            322E3931312031312E30313520322E383920432031312E303320322E38383920
            31312E30353220322E3838382031312E30373820322E38383820432031312E32
            313620322E3838382031312E34383520322E3932312031312E37323620332E31
            343220432031322E30303820332E3430312031322E31363220332E3830382031
            322E31383820342E33353420432031322E32313920352E3032382031322E3134
            20352E37342031312E39363420362E34313220432031322E30383320362E3630
            382031322E34303720372E3131312031332E32393320372E3920432031332E35
            363820372E3833322031342E32313120372E3639372031342E373220372E3635
            3620432031342E38313620372E3634382031342E39313320372E363433203135
            2E30303920372E36343320432031352E39333220372E3634332031362E353139
            20372E3938392031362E35383320382E353720432031362E36313420382E3934
            312031362E343720392E32322031362E31363920392E33373920432031352E39
            323920392E3530362031352E36343720392E3532392031352E34393520392E35
            343220432031352E34353420392E3534352031352E34313120392E3534362031
            352E33363520392E35343620432031342E38323520392E3534362031332E3931
            3820392E3332352031332E313220382E37303220432031322E37353120382E38
            30322031312E37323220392E3038382031302E39343920392E34363520432031
            302E3637342031302E31303120392E3734332031322E303320382E3532372031
            322E313331204320382E3438352031322E31333420382E3434342031322E3133
            3620382E3430352031322E313336205A204D20382E3234362031312E33353320
            4320382E3237392031312E33383220382E3239392031312E33383620382E3333
            342031312E333933204C20382E3334372031312E333935204320382E34343920
            31312E33373620382E3630382031312E32343720382E3737372031312E303438
            204320382E3938312031302E38303720392E3136312031302E35333220392E33
            30332031302E323934204320382E3331392031302E393120382E323534203131
            2E33313620382E3235342031312E3332204C20382E3235322031312E33333320
            4320382E3234382031312E333420382E3234362031312E33343720382E323436
            2031312E333533205A204D2031342E31333720382E343620432031342E353134
            20382E3633352031342E38383520382E37342031352E31343520382E37342043
            2031352E313720382E37342031352E31393320382E3733382031352E32313620
            382E37333720432031352E34373820382E3731362031352E34363620382E3538
            322031352E34363220382E35333120432031352E34353520382E352031352E33
            343820382E3337382031342E39333420382E33373820432031342E3836372038
            2E3337382031342E37393720382E3338312031342E37323220382E3338372043
            2031342E35303120382E3430342031342E33303720382E3433322031342E3133
            3720382E3436205A204D2031312E37323520372E33343420432031312E363335
            20372E36382031312E35303320382E31322031312E33363520382E3439362043
            2031312E36303420382E3430362031312E39373520382E3237332031322E3435
            3120382E31323420432031322E32333620372E3932312031312E39363520372E
            36352031312E37323520372E333434205A204D2031302E39383520332E363532
            20432031302E39313120332E3834342031302E393720342E3333372031312E31
            323120342E38353920432031312E32303520342E3234352031312E313920332E
            3738312031312E30373820332E36333120432031312E30363420332E36322031
            312E30353620332E36322031312E30343620332E3632204C2031312E30333720
            332E363220432031312E30323120332E3632312031312E30313320332E363231
            2031302E39383520332E363532205A22207374796C653D2266696C6C3A207768
            6974653B2066696C6C2D72756C653A206E6F6E7A65726F3B222F3E0D0A093C70
            61746820643D224D20352E3437362032302E323038204C20342E353737203230
            2E323038204C20342E3537372031342E313038204C20362E37352031342E3130
            38204320372E3431382031342E31303820372E39332031342E323620382E3238
            362031342E353636204320382E3633352031342E38373820382E38312031352E
            32393120382E38312031352E383032204C20382E38312031362E323831204320
            382E38312031362E37393220382E3633352031372E32303520382E3238362031
            372E353137204320372E39332031372E38323920372E3431382031372E393835
            20362E37352031372E393835204C20352E3437362031372E393835204C20352E
            3437362032302E323038205A204D20362E37352031342E383436204C20352E34
            37362031342E383436204C20352E3437362031372E323538204C20362E373520
            31372E323538204320372E3132322031372E32353820372E3430322031372E31
            373120372E3539322031362E393938204320372E3738392031362E3832362037
            2E3838382031362E35383720372E3838382031362E323831204C20372E383838
            2031352E383032204320372E3838382031352E35303320372E3738392031352E
            32363720372E3539322031352E303935204320372E3430322031342E39323820
            372E3132322031342E38343620362E37352031342E383436205A204D2031322E
            3531342032302E323038204C2031302E3335322032302E323038204C2031302E
            3335322031342E313038204C2031322E3531342031342E31303820432031332E
            3331382031342E3130382031332E3933332031342E3331372031342E33353720
            31342E37333620432031342E3738392031352E3136322031352E303036203135
            2E3734332031352E3030362031362E3438204C2031352E3030362031372E3832
            3620432031352E3030362031382E35372031342E3738392031392E3135342031
            342E3335372031392E353820432031332E3933332031392E3939392031332E33
            31382032302E3230382031322E3531342032302E323038205A204D2031322E35
            30332031342E383436204C2031312E3235312031342E383436204C2031312E32
            35312031392E3438204C2031322E3530332031392E343820432031332E353537
            2031392E34382031342E3038342031382E3932392031342E3038342031372E38
            3236204C2031342E3038342031362E343820432031342E3038342031352E3339
            312031332E3535372031342E3834362031322E3530332031342E383436205A20
            4D2032302E3239392031362E393039204C2032302E3239392031372E36343620
            4C2031372E3737342031372E363436204C2031372E3737342032302E32303820
            4C2031362E3837352032302E323038204C2031362E3837352031342E31303820
            4C2032302E3630372031342E313038204C2032302E3630372031342E38343620
            4C2031372E3737342031342E383436204C2031372E3737342031362E39303920
            4C2032302E3239392031362E393039205A22207374796C653D2266696C6C3A20
            726762283235352C203235352C20323535293B2077686974652D73706163653A
            207072653B222F3E0D0A3C2F7376673E0D0A}
          PaintStyle = bpsGlyph
          ParentShowHint = False
          ShowHint = True
          SpeedButtonOptions.GroupIndex = 2
          SpeedButtonOptions.AllowAllUp = True
          SpeedButtonOptions.Transparent = True
          TabOrder = 2
          OnClick = PDFButtonClick
        end
      end
    end
    object Splitter: TcxSplitter
      Left = 579
      Top = 2
      Width = 8
      Height = 498
      HotZoneClassName = 'TcxSimpleStyle'
      Control = SelectionGroupBox
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 507
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      953
      36)
    Height = 36
    Width = 953
    object Panel3: TcxGroupBox
      Left = 391
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 176
      object OkButton: TgBitBtn
        Left = 3
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
        Left = 90
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
    FirstDataControl = TipoMovimientoCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 514
    Top = 19
  end
  object Report: TgxReportManager
    HideReportList = False
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'SELECT'#13#10#13#10'False AS RegistroProcesado,'#13#10'  '#13#10'DocumentoyLineas.*,'#13#10 +
          '  '#13#10'CAST( '#39#39' AS NVARCHAR(80) ) AS EstadoDocumento,  '#13#10'CAST( 0.0 ' +
          'AS BCD(16,4) ) AS Pendiente,'#13#10'CAST( 0.0 AS BCD(16,4) ) AS Import' +
          'ePendiente,    '#13#10'CAST( 0.0 AS BCD(16,4) ) AS StockActual,'#13#10'CAST(' +
          ' 0.0 AS BCD(16,4) ) AS EnvasesDeposito,    '#13#10'CAST( 0.0 AS BCD(16' +
          ',4)  ) AS Coste,'#13#10'CAST( 0.0 AS BCD(16,4) ) AS Margen'#13#10'          ' +
          '                                  '#13#10'<Campos>'#13#10'INTO <TableName>  ' +
          '                                 '#13#10'FROM ( SELECT Documento.*,'#13#10' ' +
          '      <ListaCamposLineas>'#13#10'       FROM ( <SelectMovimientos> ) A' +
          'S Documento'#13#10#9'   <LineasTabla> ) AS DocumentoyLineas'#13#10'       <Ta' +
          'blas>'#13#10'<WhereExterno>                            '#13#10'ORDER BY <Ord' +
          'enacion>'#13#10'  '#13#10
      end
      item
        Title = 'Rejilla'
        SQLText = 
          'SELECT SYSTEM_ROW# AS NroRegistro,'#13#10'       Ejercicio,'#13#10'       Nr' +
          'oOperacion,                                   '#13#10'       Serie, '#13#10 +
          '       NroDocumento, '#13#10'       Fecha,                  '#13#10'       P' +
          'ropietario,'#13#10'       DescripcionMovimiento                       ' +
          '                            '#13#10'       <Campos>'#13#10'INTO <NombreTabla' +
          '>                                                               ' +
          '                                                                ' +
          '                '#13#10'FROM Movimiento                              '#13 +
          #10'<Tablas>                '#13#10'WHERE <Seleccion>      '#13#10'ORDER BY <Or' +
          'denacion>;'#13#10#13#10'CREATE UNIQUE INDEX Index0 ON <NombreTabla>( NroRe' +
          'gistro );    '#13#10'  '#13#10
      end
      item
        Title = 'ListaCamposMovimiento'
        SQLText = 
          'Movimiento.Ejercicio,   '#13#10'Movimiento.NroOperacion,   '#13#10'Movimient' +
          'o.TipoMovimiento,   '#13#10'Movimiento.Propietario,   '#13#10'Movimiento.Ser' +
          'ie,   '#13#10'Movimiento.NroDocumento,    '#13#10'Movimiento.Fecha,   '#13#10'Movi' +
          'miento.FechaEmision,'#13#10'Movimiento.FechaAuxiliar,'#13#10'Movimiento.Desc' +
          'ripcionMovimiento,    '#13#10'Movimiento.GrupoFacturacion,   '#13#10'Movimie' +
          'nto.RegistroAuxiliar,   '#13#10'Movimiento.CodigoVendedor,   '#13#10'Movimie' +
          'nto.CodigoOperario,   '#13#10'Movimiento.CentroCoste,   '#13#10'Movimiento.F' +
          'ormaEnvio,   '#13#10'Movimiento.EjercicioFactura,   '#13#10'Movimiento.Propi' +
          'etarioFactura,   '#13#10'Movimiento.SerieFactura,   '#13#10'Movimiento.NroFa' +
          'ctura,   '#13#10'Movimiento.NoFacturar,   '#13#10'Movimiento.Facturado,   '#13#10 +
          'Movimiento.Traspasado,   '#13#10'Movimiento.Origen,   '#13#10'Movimiento.Eje' +
          'rcicioOrigen,   '#13#10'Movimiento.NroOperacionOrigen,   '#13#10'Movimiento.' +
          'NroDocumentoPropietario,   '#13#10'Movimiento.EntregaACuenta,   '#13#10'Movi' +
          'miento.EntregaEfectivo,   '#13#10'Movimiento.CodigoTransportista,   '#13#10 +
          'Movimiento.Portes,'#13#10'Movimiento.CodigoFormaCobro,'#13#10'Movimiento.Org' +
          'anismoPublico, '#13#10'Movimiento.Situacion,'#13#10'Movimiento.CampoLibre1,'#13 +
          #10'Movimiento.CampoLibre2,'#13#10'Movimiento.CampoLibre3,'#13#10'Movimiento.Ca' +
          'mpoLibre4,'#13#10'Movimiento.CampoLibre5,    '#13#10'Movimiento.Creado,'#13#10'Mov' +
          'imiento.Revisado,'#13#10'Movimiento.Anotacion  '#13#10
      end
      item
        Title = 'ListaCamposLineas'
        SQLText = 
          'LineaMovimiento.FechaAplicacion AS FechaAplicacion,   '#13#10'LineaMov' +
          'imiento.NroPagina, '#13#10'LineaMovimiento.NroLinea, '#13#10'LineaMovimiento' +
          '.NroRegistro, '#13#10'LineaMovimiento.CodigoArticulo, '#13#10'LineaMovimient' +
          'o.CodigoClaseA, '#13#10'LineaMovimiento.CodigoClaseB, '#13#10'LineaMovimient' +
          'o.CodigoClaseC, '#13#10'LineaMovimiento.LoteFabricacion,'#13#10'LineaMovimie' +
          'nto.NumeroSerie,'#13#10'LineaMovimiento.CampoLibre1,'#13#10'LineaMovimiento.' +
          'CampoLibre2,'#13#10'LineaMovimiento.CampoLibre3,'#13#10'LineaMovimiento.Camp' +
          'oLibre4,    '#13#10'LineaMovimiento.Descripcion,         '#13#10'LineaMovimi' +
          'ento.CodigoAlmacen,'#13#10'LineaMovimiento.Ubicacion, '#13#10'LineaMovimient' +
          'o.Cantidad, '#13#10'LineaMovimiento.CantidadAjustada,'#13#10'LineaMovimiento' +
          '.CantidadProcesada,'#13#10'LineaMovimiento.Procesada,'#13#10'LineaMovimiento' +
          '.PrecioDivisa,'#13#10'LineaMovimiento.Precio,'#13#10'LineaMovimiento.Recargo' +
          ','#13#10'LineaMovimiento.PuntoVerde,'#13#10'LineaMovimiento.Descuento,'#13#10'Line' +
          'aMovimiento.NroCajas,'#13#10'LineaMovimiento.Largo,'#13#10'LineaMovimiento.A' +
          'ncho,'#13#10'LineaMovimiento.Alto,'#13#10'LineaMovimiento.Bultos,'#13#10'LineaMovi' +
          'miento.NoCalcularMargen,'#13#10'LineaMovimiento.TipoLinea,'#13#10'LineaMovim' +
          'iento.Oferta,'#13#10'LineaMovimiento.PesoEnvase,'#13#10'LineaMovimiento.Tara' +
          ','#13#10'LineaMovimiento.Peso,'#13#10'LineaMovimiento.ImporteBruto,'#13#10'LineaMo' +
          'vimiento.ImporteDescuento,'#13#10'LineaMovimiento.ImporteNeto,'#13#10'LineaM' +
          'ovimiento.CodigoTipoIVA,'#13#10'LineaMovimiento.CuotaIVA,'#13#10'LineaMovimi' +
          'ento.CuotaRE,'#13#10'LineaMovimiento.PrecioIVA,'#13#10'LineaMovimiento.Impor' +
          'teTotal,'#13#10'LineaMovimiento.Parametros,'#13#10'LineaMovimiento.Anotacion' +
          '                                                    '#13#10'  '#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    OnSetReportName = ReportSetReportName
    Left = 482
    Top = 19
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 447
    Top = 19
    object DataTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object DataTodasLasSeries: TBooleanField
      FieldName = 'TodasLasSeries'
    end
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DataPropietarioInicial: TWideStringField
      FieldName = 'PropietarioInicial'
      Size = 5
    end
    object DataPropietarioFinal: TWideStringField
      FieldName = 'PropietarioFinal'
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
    object DataFechaEntrega: TBooleanField
      FieldName = 'FechaEntrega'
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
    object DataCodigoPropietario: TWideStringField
      FieldName = 'CodigoPropietario'
      Size = 5
    end
    object DataAgrupar: TBooleanField
      FieldName = 'Agrupar'
    end
    object DataImportePendiente: TBooleanField
      FieldName = 'ImportePendiente'
    end
    object DataTransportistaInicial: TWideStringField
      FieldName = 'TransportistaInicial'
      Size = 2
    end
    object DataTransportistaFinal: TWideStringField
      FieldName = 'TransportistaFinal'
      Size = 2
    end
    object DataMostrarDescuentos: TBooleanField
      FieldName = 'MostrarDescuentos'
    end
    object DataCopiaPropietario: TBooleanField
      FieldName = 'CopiaPropietario'
    end
    object DataNroCopias: TSmallintField
      FieldName = 'NroCopias'
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
    object DataGenerarFicheroPDF: TBooleanField
      FieldName = 'GenerarFicheroPDF'
    end
    object DataEnviarPorCorreo: TBooleanField
      FieldName = 'EnviarPorCorreo'
    end
    object DataExcluirEnviados: TBooleanField
      FieldName = 'ExcluirEnviados'
    end
    object DataExcluirPropietariosCorreo: TBooleanField
      FieldName = 'ExcluirPropietariosCorreo'
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
  object DataSource: TDataSource
    DataSet = Data
    Left = 414
    Top = 19
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 380
    Top = 19
  end
  object GridViewRepository: TcxGridViewRepository
    Left = 448
    Top = 50
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
  object SeriesFacturacionDataSource: TDataSource
    DataSet = SeriesFacturacionTable
    Left = 481
    Top = 50
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
        Name = 'CuentasTablenxInd1'
        Fields = 'NroRegistro'
      end>
    AutoIncFieldName = 'NroRegistro'
    TableType = ttMemVirtual
    Left = 515
    Top = 50
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
end
