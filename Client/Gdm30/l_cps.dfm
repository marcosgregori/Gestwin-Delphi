object RptCpsForm: TRptCpsForm
  Left = 511
  Top = 325
  HelpType = htKeyword
  HelpKeyword = 'l_cps'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de art'#237'culos pendientes de servir'
  ClientHeight = 546
  ClientWidth = 619
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
    Height = 505
    Width = 609
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        605
        260)
      Height = 260
      Width = 605
      object Shape1: TShape
        Left = 7
        Top = 143
        Width = 589
        Height = 1
        Anchors = [akLeft, akTop, akRight]
        Pen.Color = clBtnShadow
      end
      object gxRangeBox1: TgxRangeBox
        Left = 104
        Top = 15
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object gxRangeBox2: TgxRangeBox
        Left = 104
        Top = 68
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object gxRangeBox3: TgxRangeBox
        Left = 104
        Top = 161
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object gxRangeBox4: TgxRangeBox
        Left = 104
        Top = 214
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object AlmacenFinalCtrl: TcxDBTextEdit
        Left = 120
        Top = 232
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
      object AlmacenInicialCtrl: TcxDBTextEdit
        Left = 120
        Top = 205
        DescriptionLabel = Label8
        DataBinding.DataField = 'AlmacenInicial'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
        Properties.OnValidate = AlmacenCtrlPropertiesValidate
        TabOrder = 7
        Width = 25
      end
      object ArticuloFinalCtrl: TcxDBTextEdit
        Left = 120
        Top = 178
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
      object ArticuloInicialCtrl: TcxDBTextEdit
        Left = 120
        Top = 151
        DescriptionLabel = Label4
        DataBinding.DataField = 'ArticuloInicial'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
        Properties.ExpandZeroes = False
        Properties.OnValidate = ArticuloCtrlPropertiesValidate
        TabOrder = 5
        Width = 125
      end
      object ClienteFinalCtrl: TcxDBTextEdit
        Left = 120
        Top = 33
        DescriptionLabel = Label2
        DataBinding.DataField = 'ClienteFinal'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
        Properties.TextEditPad = tpLeftHighest
        Properties.PadAlways = True
        Properties.OnValidate = ClienteCtrlPropertiesValidate
        TabOrder = 1
        Width = 46
      end
      object ClienteInicialCtrl: TcxDBTextEdit
        Left = 120
        Top = 6
        DescriptionLabel = Label16
        DataBinding.DataField = 'ClienteInicial'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
        Properties.TextEditPad = tpLeftZero
        Properties.PadAlways = True
        Properties.OnValidate = ClienteCtrlPropertiesValidate
        TabOrder = 0
        Width = 46
      end
      object FechaEntregaCtrl: TcxDBCheckBox
        Left = 7
        Top = 114
        AutoSize = False
        Caption = 'Fecha de entrega'
        DataBinding.DataField = 'FechaEntrega'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        TabOrder = 4
        Transparent = True
        Height = 25
        Width = 133
      end
      object FechaFinalCtrl: TcxDBDateEdit
        Left = 120
        Top = 87
        DataBinding.DataField = 'FechaFinal'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        TabOrder = 3
        Width = 100
      end
      object FechaInicialCtrl: TcxDBDateEdit
        Left = 120
        Top = 60
        DataBinding.DataField = 'FechaInicial'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        TabOrder = 2
        Width = 100
      end
      object Label1: TcxLabel
        Left = 11
        Top = 154
        TabStop = False
        Caption = 'Art'#237'culo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label16: TcxLabel
        Left = 256
        Top = 9
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
      object Label2: TcxLabel
        Left = 256
        Top = 36
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
      object Label3: TcxLabel
        Left = 11
        Top = 9
        TabStop = False
        Caption = 'Cliente'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label4: TcxLabel
        Left = 256
        Top = 154
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 345
      end
      object Label5: TcxLabel
        Left = 11
        Top = 208
        TabStop = False
        Caption = 'Almacen'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label6: TcxLabel
        Left = 11
        Top = 64
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label7: TcxLabel
        Left = 256
        Top = 181
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 345
      end
      object Label8: TcxLabel
        Left = 256
        Top = 208
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 345
      end
      object Label9: TcxLabel
        Left = 256
        Top = 235
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 19
        Width = 345
      end
    end
    object TransportistaGroupBox: TcxGroupBox
      Left = 2
      Top = 262
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      DesignSize = (
        605
        54)
      Height = 54
      Width = 605
      object gxRangeBox5: TgxRangeBox
        Left = 103
        Top = 9
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object TransportistaInicialCtrl: TcxDBTextEdit
        Left = 120
        Top = 0
        DescriptionLabel = cxLabel2
        DataBinding.DataField = 'TransportistaInicial'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = TransportistaCtrlPropertiesQueryRequest
        Properties.TextEditPad = tpLeftZero
        Properties.OnValidate = TransportistaCtrlPropertiesValidate
        TabOrder = 0
        Width = 28
      end
      object TransportistaFinalCtrl: TcxDBTextEdit
        Left = 120
        Top = 27
        DescriptionLabel = cxLabel3
        DataBinding.DataField = 'TransportistaFinal'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = TransportistaCtrlPropertiesQueryRequest
        Properties.TextEditPad = tpLeftHighest
        Properties.PadAlways = True
        Properties.OnValidate = TransportistaCtrlPropertiesValidate
        TabOrder = 1
        Width = 28
      end
      object cxLabel1: TcxLabel
        Left = 11
        Top = 3
        TabStop = False
        Caption = 'Transportista'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object cxLabel2: TcxLabel
        Left = 256
        Top = 3
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
      object cxLabel3: TcxLabel
        Left = 256
        Top = 30
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
    end
    object cxGroupBox3: TcxGroupBox
      AlignWithMargins = True
      Left = 2
      Top = 319
      Margins.Left = 0
      Margins.Right = 0
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Height = 64
      Width = 605
      object AgrupacionCtrl: TcxDBRadioGroup
        Left = 111
        Top = 27
        CaptionLabel = Label10
        Alignment = alCenterCenter
        DataBinding.DataField = 'Agrupacion'
        DataBinding.DataSource = DataSource
        Properties.Columns = 2
        Properties.Items = <
          item
            Caption = 'cliente'
            Value = 0
          end
          item
            Caption = 'art'#237'culo'
            Value = 1
          end>
        Properties.OnChange = AgrupacionCtrlPropertiesChange
        Style.BorderStyle = ebsNone
        TabOrder = 1
        Height = 29
        Width = 158
      end
      object Label10: TcxLabel
        Left = 26
        Top = 33
        TabStop = False
        Caption = 'Agrupar por'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object DesglosarCtrl: TcxDBCheckBox
        Left = 7
        Top = 3
        AutoSize = False
        Caption = 'Desglosar'
        DataBinding.DataField = 'Desglosar'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.OnChange = DesglosarCtrlPropertiesChange
        TabOrder = 0
        Transparent = True
        Height = 23
        Width = 133
      end
    end
    object ParametrosGroupBox: TcxGroupBox
      Left = 2
      Top = 386
      Align = alClient
      Caption = 'Par'#225'metros'
      TabOrder = 3
      Visible = False
      ExplicitTop = 380
      Height = 117
      Width = 605
      object ParametrosCtrl: TcxDBCheckGroup
        Left = 2
        Top = 22
        Align = alClient
        Alignment = alCenterCenter
        Properties.Columns = 4
        Properties.EditValueFormat = cvfInteger
        Properties.Items = <>
        Style.BorderStyle = ebsNone
        TabOrder = 0
        DataBinding.DataField = 'Parametros'
        DataBinding.DataSource = DataSource
        Height = 93
        Width = 601
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 510
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      619
      36)
    Height = 36
    Width = 619
    object Panel3: TcxGroupBox
      Left = 224
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
    FirstDataControl = ClienteInicialCtrl
    Model = fmReportForm
    ShowQueryOption = True
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 484
    Top = 14
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_cps0'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 390
    Top = 14
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 422
    Top = 14
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 453
    Top = 14
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
    object DataFechaEntrega: TBooleanField
      FieldName = 'FechaEntrega'
    end
    object DataDesglosar: TBooleanField
      FieldName = 'Desglosar'
    end
    object DataAgrupacion: TSmallintField
      FieldName = 'Agrupacion'
    end
    object DataParametros: TIntegerField
      FieldName = 'Parametros'
    end
    object DataTransportistaInicial: TStringField
      FieldName = 'TransportistaInicial'
      Size = 2
    end
    object DataTransportistaFinal: TStringField
      FieldName = 'TransportistaFinal'
      Size = 2
    end
  end
end
