object BoxAvpForm: TBoxAvpForm
  Left = 439
  Top = 269
  HelpType = htKeyword
  HelpKeyword = 'b_avp'
  BorderStyle = bsDialog
  Caption = 'Actualizaci'#243'n de precios (ventas peri'#243'dicas)'
  ClientHeight = 325
  ClientWidth = 587
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
      577
      284)
    Height = 284
    Width = 577
    object gxRangeBox2: TgxRangeBox
      Left = 141
      Top = 63
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object ClienteInicialCtrl: TcxDBTextEdit
      Left = 158
      Top = 59
      DescriptionLabel = Label1
      DataBinding.DataField = 'ClienteInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
      Properties.OnEditRequest = ClienteCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = ClienteCtrlPropertiesValidate
      TabOrder = 2
      Width = 46
    end
    object ClienteFinalCtrl: TcxDBTextEdit
      Left = 158
      Top = 86
      DescriptionLabel = Label2
      DataBinding.DataField = 'ClienteFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
      Properties.OnEditRequest = ClienteCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = ClienteCtrlPropertiesValidate
      TabOrder = 3
      Width = 46
    end
    object SerieCtrl: TcxDBTextEdit
      Left = 158
      Top = 32
      DescriptionLabel = DescSerieLabel
      DataBinding.DataField = 'Serie'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnEditRequest = SerieCtrlPropertiesEditRequest
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object SuprimirCtrl: TcxDBCheckBox
      Left = 7
      Top = 142
      Hint = 
        'Suprime el precio de los art'#237'culos codificados para que se apliq' +
        'ue siempre el precio actual cuando se generen los albaranes de v' +
        'enta.'
      AutoSize = False
      Caption = 'Suprimir precios'
      DataBinding.DataField = 'SuprimirPrecios'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 5
      Transparent = True
      Height = 21
      Width = 168
    end
    object FechaCtrl: TcxDBDateEdit
      Left = 158
      Top = 113
      DataBinding.DataField = 'Fecha'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 4
      Width = 100
    end
    object Label7: TcxLabel
      Left = 9
      Top = 63
      TabStop = False
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 9
      Top = 36
      TabStop = False
      Caption = 'Serie de facturaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
    end
    object DescSerieLabel: TcxLabel
      Left = 241
      Top = 36
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
      Height = 19
      Width = 325
    end
    object Label3: TcxLabel
      Left = 9
      Top = 116
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 241
      Top = 63
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
      Height = 19
      Width = 325
    end
    object Label2: TcxLabel
      Left = 241
      Top = 89
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
      Height = 19
      Width = 325
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 193
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 12
      Height = 80
      Width = 556
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 11
        Top = 19
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alTop
        Caption = 
          'Este proceso actualiza los precios de los art'#237'culos de las ficha' +
          's de ventas peri'#243'dicas seleccionadas teniendo en cuenta las tari' +
          'fas y descuentos aplicables al cliente.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 539
      end
    end
    object cxDBCheckBox1: TcxDBCheckBox
      Left = 7
      Top = 165
      Hint = 
        'Actualiza las descripciones de los art'#237'culos utilizando la ques ' +
        'existe actualmente en su ficha.'
      AutoSize = False
      Caption = 'Actualizar descripciones'
      DataBinding.DataField = 'ActualizarDescripciones'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 13
      Transparent = True
      Height = 21
      Width = 168
    end
    object cxLabel2: TcxLabel
      Left = 9
      Top = 8
      TabStop = False
      Caption = 'Tipo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 14
      Transparent = True
    end
    object TipoCtrl: TcxDBSpinEdit
      Left = 158
      Top = 5
      DescriptionLabel = DescTipoLabel
      DataBinding.DataField = 'Tipo'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = TipoCtrlPropertiesQueryRequest
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.OnValidate = TipoCtrlPropertiesValidate
      TabOrder = 0
      Width = 50
    end
    object DescTipoLabel: TcxLabel
      Left = 241
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
      Width = 325
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 289
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      587
      36)
    Height = 36
    Width = 587
    object Panel3: TcxGroupBox
      Left = 208
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
    FirstDataControl = TipoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 504
    Top = 26
  end
  object VentaPeriodicaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'VentaPeriodica'
    IndexFieldNames = 'Tipo;Serie;CodigoCliente'
    Left = 380
    Top = 24
  end
  object LineaVentaPeriodicaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaVentaPeriodica'
    IndexFieldNames = 'NroFicha;NroRegistro'
    Left = 348
    Top = 24
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 474
    Top = 26
    object DataTipo: TSmallintField
      FieldName = 'Tipo'
    end
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
    object DataSuprimirPrecios: TBooleanField
      FieldName = 'SuprimirPrecios'
    end
    object DataFecha: TDateField
      FieldName = 'Fecha'
    end
    object DataActualizarDescripciones: TBooleanField
      FieldName = 'ActualizarDescripciones'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 445
    Top = 26
  end
end
