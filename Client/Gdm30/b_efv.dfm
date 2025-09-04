object BoxEfvForm: TBoxEfvForm
  Left = 423
  Top = 250
  HelpType = htKeyword
  HelpKeyword = 'b_efv'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Generaci'#243'n de facturas de venta'
  ClientHeight = 455
  ClientWidth = 551
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
    DesignSize = (
      541
      414)
    Height = 414
    Width = 541
    object gxRangeBox7: TgxRangeBox
      Left = 141
      Top = 240
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object ImprimirCtrl: TcxDBCheckBox
      Left = 11
      Top = 372
      AutoSize = False
      Caption = 'Im&primir'
      DataBinding.DataField = 'Imprimir'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 8
      Transparent = True
      Height = 25
      Width = 165
    end
    object PageControl: TgxFilterPageControl
      Left = 3
      Top = 86
      Width = 532
      Height = 132
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 2
      Properties.ActivePage = ClienteTabSheet
      Properties.CustomButtons.Buttons = <>
      Properties.MultiLine = True
      OnCheckBoxClick = PageControlCheckBoxClick
      ClientRectBottom = 128
      ClientRectLeft = 4
      ClientRectRight = 528
      ClientRectTop = 28
      object ClienteTabSheet: TcxTabSheet
        Caption = 'Clien&te'
        DesignSize = (
          524
          100)
        object gxRangeBox2: TgxRangeBox
          Left = 136
          Top = 15
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ClienteInicialCtrl: TcxDBTextEdit
          Left = 151
          Top = 6
          DescriptionLabel = Label6
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
        object DesglosarRegAuxiliarCtrl: TcxDBCheckBox
          Left = 5
          Top = 54
          AutoSize = False
          Caption = 'Des&glosar por registro auxiliar'
          DataBinding.DataField = 'DesglosarRegAuxiliar'
          DataBinding.DataSource = DataSource
          Properties.Alignment = taRightJustify
          Properties.MultiLine = True
          Properties.NullStyle = nssUnchecked
          TabOrder = 2
          Transparent = True
          Height = 39
          Width = 166
        end
        object Label3: TcxLabel
          Left = 9
          Top = 9
          TabStop = False
          Caption = 'C'#243'digo de cliente'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
        end
        object Label6: TcxLabel
          Left = 222
          Top = 7
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
          Width = 297
          AnchorY = 17
        end
        object Label12: TcxLabel
          Left = 222
          Top = 34
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 5
          Transparent = True
          Height = 20
          Width = 297
          AnchorY = 44
        end
      end
      object GrupoClienteTabSheet: TcxTabSheet
        Caption = '&Grupo de cliente'
        ExplicitLeft = 0
        ExplicitWidth = 532
        ExplicitHeight = 104
        DesignSize = (
          524
          100)
        object gxRangeBox3: TgxRangeBox
          Left = 136
          Top = 14
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object GrupoInicialCtrl: TcxDBTextEdit
          Left = 151
          Top = 6
          DescriptionLabel = Label13
          DataBinding.DataField = 'GrupoInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = GrupolCtrlPropertiesQueryRequest
          Properties.OnValidate = GrupoCtrlPropertiesValidate
          TabOrder = 0
          Width = 32
        end
        object GrupoFinalCtrl: TcxDBTextEdit
          Left = 151
          Top = 33
          DescriptionLabel = Label16
          DataBinding.DataField = 'GrupoFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = GrupolCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightHighest
          Properties.PadAlways = True
          Properties.OnValidate = GrupoCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object Label11: TcxLabel
          Left = 8
          Top = 9
          TabStop = False
          Caption = 'C'#243'digo de grupo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object Label13: TcxLabel
          Left = 222
          Top = 7
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 3
          Transparent = True
          ExplicitWidth = 301
          Height = 20
          Width = 293
          AnchorY = 17
        end
        object Label16: TcxLabel
          Left = 222
          Top = 34
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 4
          Transparent = True
          ExplicitWidth = 302
          Height = 20
          Width = 294
          AnchorY = 44
        end
      end
      object VendedorTabSheet: TcxTabSheet
        Caption = '&Vendedor'
        ExplicitLeft = 0
        ExplicitWidth = 532
        ExplicitHeight = 104
        DesignSize = (
          524
          100)
        object gxRangeBox4: TgxRangeBox
          Left = 137
          Top = 15
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object VendedorInicialCtrl: TcxDBTextEdit
          Left = 152
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
          Left = 152
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
          Caption = 'C'#243'digo de vendedor'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object Label21: TcxLabel
          Left = 222
          Top = 8
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 3
          Transparent = True
          ExplicitWidth = 304
          Height = 20
          Width = 296
          AnchorY = 18
        end
        object Label22: TcxLabel
          Left = 222
          Top = 34
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 4
          Transparent = True
          ExplicitWidth = 304
          Height = 20
          Width = 296
          AnchorY = 44
        end
      end
      object FormaCobroTabSheet: TcxTabSheet
        Caption = '&Forma de cobro'
        ImageIndex = 4
        ExplicitLeft = 0
        ExplicitWidth = 532
        ExplicitHeight = 104
        DesignSize = (
          524
          100)
        object gxRangeBox5: TgxRangeBox
          Left = 138
          Top = 15
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FormaCobroInicialCtrl: TcxDBTextEdit
          Left = 153
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
          Left = 153
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
        object Label14: TcxLabel
          Left = 8
          Top = 9
          TabStop = False
          Caption = 'C'#243'd. de forma cobro'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object Label23: TcxLabel
          Left = 222
          Top = 7
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 3
          Transparent = True
          ExplicitWidth = 307
          Height = 20
          Width = 299
          AnchorY = 17
        end
        object Label24: TcxLabel
          Left = 222
          Top = 34
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 4
          Transparent = True
          ExplicitWidth = 307
          Height = 20
          Width = 299
          AnchorY = 44
        end
      end
      object RegistroAuxiliarTabSheet: TcxTabSheet
        Caption = '&Reg. auxiliar'
        ImageIndex = 5
        ExplicitLeft = 0
        ExplicitWidth = 532
        ExplicitHeight = 104
        DesignSize = (
          524
          100)
        object gxRangeBox6: TgxRangeBox
          Left = 136
          Top = 42
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object RegAuxiliarInicialCtrl: TcxDBTextEdit
          Left = 151
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
          Left = 151
          Top = 60
          DescriptionLabel = Label26
          DataBinding.DataField = 'RegAuxiliarFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = RegAuxiliarCtrlPropertiesQueryRequest
          Properties.OnValidate = RegAuxiliarCtrlPropertiesValidate
          TabOrder = 2
          Width = 32
        end
        object CodigoClienteCtrl: TcxDBTextEdit
          Left = 151
          Top = 6
          DescriptionLabel = Label18
          DataBinding.DataField = 'CodigoCliente'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object Label7: TcxLabel
          Left = 8
          Top = 36
          TabStop = False
          Caption = 'Registro auxiliar'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
        end
        object Label17: TcxLabel
          Left = 8
          Top = 9
          TabStop = False
          Caption = 'Cliente'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
        end
        object Label18: TcxLabel
          Left = 222
          Top = 7
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 5
          Transparent = True
          ExplicitWidth = 304
          Height = 20
          Width = 296
          AnchorY = 17
        end
        object Label25: TcxLabel
          Left = 222
          Top = 34
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 6
          Transparent = True
          ExplicitWidth = 304
          Height = 20
          Width = 296
          AnchorY = 44
        end
        object Label26: TcxLabel
          Left = 222
          Top = 61
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Properties.Alignment.Vert = taVCenter
          TabOrder = 7
          Transparent = True
          ExplicitWidth = 304
          Height = 20
          Width = 296
          AnchorY = 71
        end
      end
    end
    object SerieFacturacionCtrl: TcxDBTextEdit
      Left = 158
      Top = 7
      DescriptionLabel = Label20
      DataBinding.DataField = 'SerieFacturacion'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieFacturacionCtrlPropertiesQueryRequest
      Properties.OnValuePosted = SerieFacturacionCtrlPropertiesValuePosted
      Properties.OnValidate = SerieFacturacionCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 158
      Top = 232
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 3
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 158
      Top = 259
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 4
      Width = 100
    end
    object NroFacturaInicialCtrl: TcxDBTextEdit
      Left = 158
      Top = 34
      DataBinding.DataField = 'PrimerNroFactura'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = NroFacturaCtrlPropertiesQueryRequest
      Properties.MaxLength = 8
      TabOrder = 1
      Width = 62
    end
    object FechaFacturacionCtrl: TcxDBDateEdit
      Left = 158
      Top = 286
      DataBinding.DataField = 'FechaFacturacion'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = FechaFacturacionCtrlPropertiesValidate
      TabOrder = 5
      Width = 100
    end
    object ImporteMinimoCtrl: TcxDBCurrencyEdit
      Left = 158
      Top = 313
      DataBinding.DataField = 'ImporteMinimo'
      DataBinding.DataSource = DataSource
      Properties.AssignedValues.DisplayFormat = True
      Properties.DecimalPlaces = 2
      Properties.UseThousandSeparator = True
      TabOrder = 6
      Width = 72
    end
    object Label5: TcxLabel
      Left = 14
      Top = 62
      TabStop = False
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object Label19: TcxLabel
      Left = 14
      Top = 10
      TabStop = False
      Caption = 'Serie de facturaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
    end
    object Label20: TcxLabel
      Left = 229
      Top = 10
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 11
      Transparent = True
      Height = 20
      Width = 260
      AnchorY = 20
    end
    object Label9: TcxLabel
      Left = 14
      Top = 236
      TabStop = False
      Caption = 'Fecha de albar'#225'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 14
      Top = 38
      TabStop = False
      Caption = 'Primer n'#186' de factura'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 14
      Top = 290
      TabStop = False
      Caption = 'Fecha de facturaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 14
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 14
      Top = 317
      TabStop = False
      Caption = 'Importe m'#237'nimo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 15
      Transparent = True
    end
    object UnaFacturaPorAlbaranCtrl: TcxDBCheckBox
      Left = 11
      Top = 340
      AutoSize = False
      Caption = 'Emitir una factura por cada albar'#225'n'
      DataBinding.DataField = 'UnaFacturaPorAlbaran'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 7
      Transparent = True
      Height = 32
      Width = 165
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 419
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      551
      36)
    Height = 36
    Width = 551
    object Panel3: TcxGroupBox
      Left = 190
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
    FirstDataControl = SerieFacturacionCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 406
    Top = 12
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 342
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    OnNewRecord = DataNewRecord
    Left = 375
    Top = 12
    object DataSerieFacturacion: TWideStringField
      FieldName = 'SerieFacturacion'
      Size = 2
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
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
    object DataCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object DataRegAuxiliarInicial: TWideStringField
      FieldName = 'RegAuxiliarInicial'
      Size = 3
    end
    object DataRegAuxiliarFinal: TWideStringField
      FieldName = 'RegAuxiliarFinal'
      Size = 3
    end
    object DataPrimerNroFactura: TIntegerField
      FieldName = 'PrimerNroFactura'
    end
    object DataDesglosarRegAuxiliar: TBooleanField
      FieldName = 'DesglosarRegAuxiliar'
    end
    object DataFechaFacturacion: TDateField
      FieldName = 'FechaFacturacion'
    end
    object DataImporteMinimo: TBCDField
      FieldName = 'ImporteMinimo'
    end
    object DataUnaFacturaPorAlbaran: TBooleanField
      FieldName = 'UnaFacturaPorAlbaran'
    end
    object DataImprimir: TBooleanField
      FieldName = 'Imprimir'
    end
  end
  object RelacionAlbaranesTable: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.ServerTmpDatabase
    Timeout = 6000
    TableName = 'RelacionAlbaranes'
    IndexFieldNames = 'NroRegistro'
    TableType = ttTemporal
    Left = 374
    Top = 42
  end
end
