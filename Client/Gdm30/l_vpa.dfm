object RptVpaForm: TRptVpaForm
  Left = 536
  Top = 278
  HelpType = htKeyword
  HelpKeyword = 'l_vpe'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de ventas peri'#243'dicas por art'#237'culo'
  ClientHeight = 424
  ClientWidth = 605
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
  PixelsPerInch = 96
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
    ExplicitHeight = 294
    DesignSize = (
      595
      383)
    Height = 383
    Width = 595
    object gxRangeBox3: TgxRangeBox
      Left = 122
      Top = 276
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox4: TgxRangeBox
      Left = 123
      Top = 70
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox1: TgxRangeBox
      Left = 123
      Top = 17
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object SeleccionSerieCtrl: TcxDBRadioGroup
      Left = 129
      Top = 189
      Alignment = alRightBottom
      DataBinding.DataField = 'SeleccionSerie'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Todas'
          Value = 0
        end
        item
          Caption = 'Solo la ...'
          Value = 1
        end>
      Properties.OnEditValueChanged = SeleccionSerieCtrlPropertiesEditValueChanged
      Style.BorderStyle = ebsNone
      TabOrder = 6
      Height = 47
      Width = 117
    end
    object SerieCtrl: TcxDBTextEdit
      Left = 215
      Top = 208
      DescriptionLabel = Label20
      DataBinding.DataField = 'Serie'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 7
      Width = 25
    end
    object PeriodicidadCtrl: TcxDBIndexedComboBox
      Left = 137
      Top = 240
      DataBinding.DataField = 'Periodicidad'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        '<Todas>'
        'Anual'
        'Semestral'
        'Cuatrimestral'
        'Trimestral'
        'Bimensual'
        'Mensual')
      Properties.OnEditValueChanged = PeriodicidadCtrlPropertiesEditValueChanged
      TabOrder = 8
      Width = 103
    end
    object MesPagoInicialCtrl: TcxDBSpinEdit
      Left = 137
      Top = 268
      CaptionLabel = Label7
      DescriptionLabel = Label2
      DataBinding.DataField = 'MesPagoInicial'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.MaxValue = 12.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = MesPagoCtrlPropertiesValidate
      TabOrder = 9
      Width = 56
    end
    object MesPagoFinalCtrl: TcxDBSpinEdit
      Left = 137
      Top = 295
      DescriptionLabel = Label5
      DataBinding.DataField = 'MesPagoFinal'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.MaxValue = 12.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = MesPagoCtrlPropertiesValidate
      TabOrder = 10
      Width = 56
    end
    object ValorarCtrl: TcxDBCheckBox
      Left = 7
      Top = 324
      AutoSize = False
      Caption = 'Valorar (mostrar precios y dtos.) '
      DataBinding.DataField = 'Valorar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 11
      Transparent = True
      Height = 37
      Width = 148
    end
    object Label19: TcxLabel
      Left = 10
      Top = 196
      TabStop = False
      Caption = 'Serie de facturaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label20: TcxLabel
      Left = 257
      Top = 211
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 330
    end
    object Label3: TcxLabel
      Left = 10
      Top = 244
      TabStop = False
      Caption = 'Periodicidad'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 10
      Top = 272
      TabStop = False
      Caption = 'Mes de aplicaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 252
      Top = 273
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 337
    end
    object Label5: TcxLabel
      Left = 252
      Top = 297
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 337
    end
    object ArticuloInicialCtrl: TcxDBTextEdit
      Left = 138
      Top = 62
      DescriptionLabel = cxLabel2
      DataBinding.DataField = 'ArticuloInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 2
      Width = 102
    end
    object ArticuloFinalCtrl: TcxDBTextEdit
      Left = 138
      Top = 89
      DescriptionLabel = cxLabel3
      DataBinding.DataField = 'ArticuloFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 3
      Width = 102
    end
    object cxLabel1: TcxLabel
      Left = 11
      Top = 68
      TabStop = False
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel2: TcxLabel
      Left = 253
      Top = 68
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 328
    end
    object cxLabel3: TcxLabel
      Left = 253
      Top = 92
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 328
    end
    object cxDBCheckBox1: TcxDBCheckBox
      Left = 7
      Top = 152
      AutoSize = False
      Caption = 'Incluir l'#237'neas sin codificar'
      DataBinding.DataField = 'LineasSinCodificar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 5
      Transparent = True
      Height = 37
      Width = 148
    end
    object CodigoClienteInicialCtrl: TcxDBTextEdit
      Left = 138
      Top = 8
      DescriptionLabel = cxLabel4
      DataBinding.DataField = 'ClienteInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object CodigoClienteFinalCtrl: TcxDBTextEdit
      Left = 138
      Top = 35
      DescriptionLabel = cxLabel5
      DataBinding.DataField = 'ClienteFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
      TabOrder = 1
      Width = 46
    end
    object Label1: TcxLabel
      Left = 11
      Top = 11
      TabStop = False
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel4: TcxLabel
      Left = 253
      Top = 11
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 336
    end
    object cxLabel5: TcxLabel
      Left = 253
      Top = 38
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 336
    end
    object cxLabel6: TcxLabel
      Left = 11
      Top = 122
      TabStop = False
      Caption = 'Agrupar por ...'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object AgruparCtrl: TcxDBRadioGroup
      Left = 132
      Top = 122
      Alignment = alRightBottom
      DataBinding.DataField = 'Agrupar'
      DataBinding.DataSource = DataSource
      Properties.Columns = 2
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Cliente'
          Value = 0
        end
        item
          Caption = 'Art'#237'culo'
          Value = 1
        end>
      Properties.OnEditValueChanged = SeleccionSerieCtrlPropertiesEditValueChanged
      Style.BorderStyle = ebsNone
      TabOrder = 4
      Height = 24
      Width = 205
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 388
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 299
    DesignSize = (
      605
      36)
    Height = 36
    Width = 605
    object Panel3: TcxGroupBox
      Left = 217
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
    
    ShowQueryOption = True
    OnInitializeForm = InitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 424
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 392
    Top = 10
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DataPeriodicidad: TSmallintField
      FieldName = 'Periodicidad'
    end
    object DataMesPagoInicial: TSmallintField
      FieldName = 'MesPagoInicial'
    end
    object DataMesPagoFinal: TSmallintField
      FieldName = 'MesPagoFinal'
    end
    object DataSeleccionSerie: TSmallintField
      FieldName = 'SeleccionSerie'
    end
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
    end
    object DataValorar: TBooleanField
      FieldName = 'Valorar'
    end
    object DataLineasSinCodificar: TBooleanField
      FieldName = 'LineasSinCodificar'
    end
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataAgrupar: TSmallintField
      FieldName = 'Agrupar'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 363
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_vpa'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 330
    Top = 11
  end
end
