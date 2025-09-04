object RptEccForm: TRptEccForm
  Left = 536
  Top = 295
  HelpType = htKeyword
  HelpKeyword = 'l_ecc'
  HelpContext = 3108
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de comprobaci'#243'n de efectos a cobrar'
  ClientHeight = 545
  ClientWidth = 527
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  OldCreateOrder = False
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
    DesignSize = (
      517
      504)
    Height = 504
    Width = 517
    object gxRangeBox1: TgxRangeBox
      Left = 124
      Top = 14
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 124
      Top = 121
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox3: TgxRangeBox
      Left = 124
      Top = 175
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox4: TgxRangeBox
      Left = 124
      Top = 362
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox5: TgxRangeBox
      Left = 124
      Top = 416
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object SerieInicialCtrl: TcxDBTextEdit
      Left = 138
      Top = 8
      DescriptionLabel = cxLabel2
      DataBinding.DataField = 'SerieInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object SerieFinalCtrl: TcxDBTextEdit
      Left = 138
      Top = 35
      DescriptionLabel = cxLabel3
      DataBinding.DataField = 'SerieFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 138
      Top = 115
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 3
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 138
      Top = 142
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 4
      Width = 100
    end
    object TipoDocumentoCtrl: TcxDBIndexedComboBox
      Left = 138
      Top = 248
      DataBinding.DataField = 'TipoDocumento'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Todos'
        'Letras de cambio'
        'Recibos'
        'Pagar'#233's')
      TabOrder = 8
      Width = 145
    end
    object SituacionCtrl: TcxDBIndexedComboBox
      Left = 138
      Top = 275
      DataBinding.DataField = 'Situacion'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Todos'
        'Pendientes de cobro'
        'Pendientes de cancelaci'#243'n'
        'Aceptados'
        'Cobrados'
        'Impagados')
      TabOrder = 9
      Width = 145
    end
    object RevisionCtrl: TcxDBIndexedComboBox
      Left = 138
      Top = 302
      DataBinding.DataField = 'Revision'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Todos'
        'Revisados'
        'Pendientes de revisi'#243'n')
      TabOrder = 10
      Width = 145
    end
    object FormaCobroCtrl: TcxDBTextEdit
      Left = 138
      Top = 329
      DescriptionLabel = Label9
      DataBinding.DataField = 'FormaCobro'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = FormaCobroCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = FormaCobroCtrlPropertiesValidate
      TabOrder = 11
      Width = 25
    end
    object ClienteInicialCtrl: TcxDBTextEdit
      Left = 138
      Top = 169
      DescriptionLabel = Label5
      DataBinding.DataField = 'ClienteInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = ClienteCtrlPropertiesValidate
      TabOrder = 5
      Width = 74
    end
    object ClienteFinalCtrl: TcxDBTextEdit
      Left = 138
      Top = 196
      DescriptionLabel = Label7
      DataBinding.DataField = 'ClienteFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = ClienteCtrlPropertiesValidate
      TabOrder = 6
      Width = 74
    end
    object AgruparEntidadCtrl: TcxDBCheckBox
      Left = 6
      Top = 466
      AutoSize = False
      Caption = 'Agrupar por entidad'
      DataBinding.DataField = 'AgruparEntidad'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = AgruparEntidadCtrlPropertiesChange
      TabOrder = 16
      Transparent = True
      Height = 21
      Width = 149
    end
    object EntidadInicialCtrl: TcxDBTextEdit
      Left = 138
      Top = 356
      DescriptionLabel = Label12
      DataBinding.DataField = 'EntidadInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = ClienteCtrlPropertiesValidate
      TabOrder = 12
      Width = 74
    end
    object EntidadFinalCtrl: TcxDBTextEdit
      Left = 138
      Top = 383
      DescriptionLabel = Label13
      DataBinding.DataField = 'EntidadFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = ClienteCtrlPropertiesValidate
      TabOrder = 13
      Width = 74
    end
    object TipoFechaCtrl: TcxDBRadioGroup
      Left = 138
      Top = 62
      Alignment = alCenterCenter
      DataBinding.DataField = 'TipoFecha'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'fecha de vencimiento'
          Value = 0
        end
        item
          Caption = 'fecha de cobro o descuento'
          Value = 1
        end>
      Properties.OnChange = TipoFechaCtrlPropertiesChange
      TabOrder = 2
      Height = 47
      Width = 204
    end
    object Label6: TcxLabel
      Left = 10
      Top = 11
      TabStop = False
      Caption = 'Serie'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object FechaLabel: TcxLabel
      Left = 10
      Top = 118
      TabStop = False
      Caption = 'Vencimiento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 10
      Top = 252
      TabStop = False
      Caption = 'Tipo de documento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 10
      Top = 279
      TabStop = False
      Caption = 'Situaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 10
      Top = 306
      TabStop = False
      Caption = 'Revisi'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 10
      Top = 332
      TabStop = False
      Caption = 'Forma de cobro'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 236
      Top = 332
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 275
    end
    object Label10: TcxLabel
      Left = 10
      Top = 172
      TabStop = False
      Caption = 'Cliente o deudor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 236
      Top = 172
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 275
    end
    object Label7: TcxLabel
      Left = 236
      Top = 199
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 275
    end
    object Label11: TcxLabel
      Left = 10
      Top = 359
      TabStop = False
      Caption = 'Entidad'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label12: TcxLabel
      Left = 236
      Top = 359
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 275
    end
    object Label13: TcxLabel
      Left = 236
      Top = 386
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 275
    end
    object Label14: TcxLabel
      Left = 10
      Top = 66
      TabStop = False
      Caption = 'Seleccionar por'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object AgruparClienteCtrl: TcxDBCheckBox
      Left = 6
      Top = 223
      AutoSize = False
      Caption = 'Agrupar por cliente'
      DataBinding.DataField = 'AgruparCliente'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = AgruparClienteCtrlPropertiesChange
      TabOrder = 7
      Transparent = True
      Height = 21
      Width = 149
    end
    object cxLabel1: TcxLabel
      Left = 10
      Top = 413
      TabStop = False
      Caption = 'Importe'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object ImporteMinimoCtrl: TcxDBCurrencyEdit
      Left = 138
      Top = 410
      DescriptionLabel = Label12
      DataBinding.DataField = 'ImporteMinimo'
      DataBinding.DataSource = DataSource
      TabOrder = 14
      Width = 93
    end
    object ImporteMaximoCtrl: TcxDBCurrencyEdit
      Left = 138
      Top = 437
      DescriptionLabel = Label13
      DataBinding.DataField = 'ImporteMaximo'
      DataBinding.DataSource = DataSource
      TabOrder = 15
      Width = 93
    end
    object cxLabel2: TcxLabel
      Left = 236
      Top = 11
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 275
    end
    object cxLabel3: TcxLabel
      Left = 236
      Top = 38
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 275
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 509
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 458
    DesignSize = (
      527
      36)
    Height = 36
    Width = 527
    object Panel3: TcxGroupBox
      Left = 177
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 165
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
    Left = 442
    Top = 12
  end
  object EfectoCobrarQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    Left = 378
    Top = 42
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 411
    Top = 12
    object DataSerieInicial: TStringField
      FieldName = 'SerieInicial'
      Size = 2
    end
    object DataSerieFinal: TStringField
      FieldName = 'SerieFinal'
      Size = 2
    end
    object DataTipoFecha: TSmallintField
      FieldName = 'TipoFecha'
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataTipoDocumento: TSmallintField
      FieldName = 'TipoDocumento'
    end
    object DataSituacion: TSmallintField
      FieldName = 'Situacion'
    end
    object DataRevision: TSmallintField
      FieldName = 'Revision'
    end
    object DataFormaCobro: TStringField
      FieldName = 'FormaCobro'
      Size = 2
    end
    object DataClienteInicial: TStringField
      FieldName = 'ClienteInicial'
      Size = 9
    end
    object DataClienteFinal: TStringField
      FieldName = 'ClienteFinal'
      Size = 9
    end
    object DataAgruparCliente: TBooleanField
      FieldName = 'AgruparCliente'
    end
    object DataEntidadInicial: TStringField
      FieldName = 'EntidadInicial'
      Size = 9
    end
    object DataEntidadFinal: TStringField
      FieldName = 'EntidadFinal'
      Size = 9
    end
    object DataAgruparEntidad: TBooleanField
      FieldName = 'AgruparEntidad'
    end
    object DataImporteMinimo: TBCDField
      FieldName = 'ImporteMinimo'
    end
    object DataImporteMaximo: TBCDField
      FieldName = 'ImporteMaximo'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 378
    Top = 12
  end
  object report: TgxReportManager
    FileName = 'dm10\l_ecc'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    BeforeStart = reportBeforeStart
    Left = 411
    Top = 42
  end
end
