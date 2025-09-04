object boxGccForm: TboxGccForm
  Left = 378
  Top = 192
  HelpType = htKeyword
  HelpKeyword = 'b_gcc'
  BorderStyle = bsDialog
  Caption = 'Generaci'#243'n de consumos habituales de clientes'
  ClientHeight = 485
  ClientWidth = 513
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
      503
      444)
    Height = 444
    Width = 503
    object gxRangeBox1: TgxRangeBox
      Left = 136
      Top = 14
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 136
      Top = 68
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 151
      Top = 59
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 2
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 151
      Top = 86
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 3
      Width = 100
    end
    object MaximoCtrl: TcxDBSpinEdit
      Left = 151
      Top = 139
      DataBinding.DataField = 'Maximo'
      DataBinding.DataSource = DataSource
      Properties.MaxValue = 9999.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 5
      Width = 64
    end
    object ClienteInicialCtrl: TcxDBTextEdit
      Left = 151
      Top = 5
      DescriptionLabel = Label3
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
      Left = 151
      Top = 32
      DescriptionLabel = Label5
      DataBinding.DataField = 'ClienteFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = ClienteCtrlPropertiesValidate
      TabOrder = 1
      Width = 46
    end
    object CantidadMinimaCtrl: TcxDBCurrencyEdit
      Left = 151
      Top = 112
      DataBinding.DataField = 'CantidadMinima'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 8
      TabOrder = 4
      Width = 67
    end
    object OrdenacionCtrl: TcxDBRadioGroup
      Left = 141
      Top = 169
      Alignment = alCenterCenter
      DataBinding.DataField = 'Ordenacion'
      DataBinding.DataSource = DataSource
      Properties.Items = <
        item
          Caption = 'cantidad'
          Value = 0
        end
        item
          Caption = 'c'#243'digo de art'#237'culo'
          Value = 1
        end
        item
          Caption = 'descripci'#243'n'
          Value = '2'
        end>
      Style.BorderStyle = ebsNone
      TabOrder = 6
      Height = 72
      Width = 170
    end
    object Label7: TcxLabel
      Left = 12
      Top = 62
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 12
      Top = 142
      TabStop = False
      Caption = 'Como m'#225'ximo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 12
      Top = 240
      TabStop = False
      Caption = 
        'Valores por defecto alternativos en pedidos y albaranes de preve' +
        'nta'
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 12
      Top = 8
      TabStop = False
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
    end
    object Label12: TcxLabel
      Left = 12
      Top = 115
      TabStop = False
      Caption = 'Cantidad m'#237'nima'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
    end
    object Label13: TcxLabel
      Left = 12
      Top = 173
      TabStop = False
      Caption = 'Ordenar por ...'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 14
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 224
      Top = 8
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 15
      Transparent = True
      Height = 19
      Width = 302
    end
    object Label5: TcxLabel
      Left = 224
      Top = 35
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 16
      Transparent = True
      Height = 19
      Width = 302
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 322
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 17
      Height = 110
      Width = 485
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        Caption = 
          'Este proceso genera la relaci'#243'n de consumos habituales de cada c' +
          'liente a partir de los albaranes de venta de los mismos y/o de l' +
          'a informaci'#243'n disponible sobre precios y descuentos. Si ya exist' +
          'e una relaci'#243'n de consumos de el/los cliente/s '#233'sta ser'#225' sustitu' +
          'ida por la generada.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 470
      end
    end
    object UltimoPrecioCtrl: TcxDBCheckBox
      Left = 24
      Top = 263
      AutoSize = False
      Caption = #218'ltimo precio'
      DataBinding.DataField = 'UltimoPrecio'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 7
      Transparent = True
      Height = 20
      Width = 142
    end
    object UltimoDescuentoCtrl: TcxDBCheckBox
      Left = 24
      Top = 289
      AutoSize = False
      Caption = #218'ltimo descuento'
      DataBinding.DataField = 'UltimoDescuento'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = True
      TabOrder = 8
      Transparent = True
      Height = 20
      Width = 142
    end
    object cxLabel2: TcxLabel
      Left = 182
      Top = 263
      TabStop = False
      AutoSize = False
      Caption = 
        'Estos valores se aplicar'#225'n en lugar del precio y descuento actua' +
        'les.'
      Style.TextColor = clGray
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.WordWrap = True
      TabOrder = 18
      Transparent = True
      Height = 46
      Width = 281
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 449
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      513
      36)
    Height = 36
    Width = 513
    object Panel3: TcxGroupBox
      Left = 170
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
    FirstDataControl = ClienteInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 460
    Top = 14
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 429
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
    object DataMaximo: TSmallintField
      FieldName = 'Maximo'
    end
    object DataCantidadMinima: TBCDField
      FieldName = 'CantidadMinima'
    end
    object DataOrdenacion: TSmallintField
      FieldName = 'Ordenacion'
    end
    object DataUltimoPrecio: TBooleanField
      FieldName = 'UltimoPrecio'
    end
    object DataUltimoDescuento: TBooleanField
      FieldName = 'UltimoDescuento'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 396
    Top = 14
  end
end
