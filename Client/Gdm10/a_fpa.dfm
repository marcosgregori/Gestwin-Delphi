object MntFpaForm: TMntFpaForm
  Left = 607
  Top = 261
  HelpType = htKeyword
  HelpKeyword = 'a_fpa'
  HelpContext = 3103
  BorderStyle = bsDialog
  Caption = 'Formas de pago'
  ClientHeight = 426
  ClientWidth = 556
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 36
    Width = 556
    object CodigoCtrl: TcxDBTextEdit
      Left = 180
      Top = 6
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = FormaPagoDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 0
      Width = 25
    end
    object codigoCtrlCaption: TcxLabel
      Left = 15
      Top = 9
      TabStop = False
      Caption = 'Codigo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 390
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      556
      36)
    Height = 36
    Width = 556
    object Panel2: TcxGroupBox
      Left = 146
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 261
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
      object DeleteButton: TgBitBtn
        Left = 175
        Top = 1
        Width = 85
        Height = 28
        Caption = '&Suprimir'
        Enabled = True
        ModalResult = 3
        OptionsImage.ImageIndex = 5
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 2
        GlyphBitmap = gmDelete
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
    DesignSize = (
      546
      354)
    Height = 354
    Width = 546
    object Bevel1: TShape
      Left = 10
      Top = 178
      Width = 526
      Height = 1
      Anchors = [akLeft, akTop, akRight]
      Pen.Color = clBtnShadow
      ExplicitWidth = 496
    end
    object Bevel2: TShape
      Left = 10
      Top = 313
      Width = 526
      Height = 1
      Anchors = [akLeft, akTop, akRight]
      Pen.Color = clBtnShadow
      ExplicitWidth = 496
    end
    object DescripcionCtrl: TcxDBTextEdit
      Left = 175
      Top = 7
      DataBinding.DataField = 'Descripcion'
      DataBinding.DataSource = FormaPagoDataSource
      Properties.Required = True
      TabOrder = 0
      Width = 361
    end
    object PlazosCtrl: TcxDBSpinEdit
      Left = 175
      Top = 34
      DataBinding.DataField = 'Plazos'
      DataBinding.DataSource = FormaPagoDataSource
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 99.000000000000000000
      Properties.OnEditValueChanged = PlazosCtrlPropertiesEditValueChanged
      TabOrder = 1
      Width = 60
    end
    object PrimerVencimientoCtrl: TcxDBSpinEdit
      Left = 175
      Top = 61
      DataBinding.DataField = 'PrimerVencimiento'
      DataBinding.DataSource = FormaPagoDataSource
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 999.000000000000000000
      TabOrder = 2
      Width = 60
    end
    object IntervaloCtrl: TcxDBSpinEdit
      Left = 175
      Top = 88
      DataBinding.DataField = 'Intervalo'
      DataBinding.DataSource = FormaPagoDataSource
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 999.000000000000000000
      Properties.ReadOnly = False
      TabOrder = 3
      Width = 60
    end
    object crearRegistroCtrl: TcxDBCheckBox
      Left = 7
      Top = 186
      AutoSize = False
      Caption = '&Generar efectos'
      DataBinding.DataField = 'CrearRegistro'
      DataBinding.DataSource = FormaPagoDataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 6
      Transparent = True
      Height = 23
      Width = 185
    end
    object DescuentoPPCtrl: TcxDBCheckBox
      Left = 7
      Top = 209
      AutoSize = False
      Caption = 'Ap&licar dto. p. p.'
      DataBinding.DataField = 'DescuentoPP'
      DataBinding.DataSource = FormaPagoDataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = DescuentoPPCtrlPropertiesEditValueChanged
      TabOrder = 7
      Transparent = True
      Height = 23
      Width = 185
    end
    object EmitirCtrl: TcxDBCheckBox
      Left = 7
      Top = 262
      AutoSize = False
      Caption = 'Emitir &documento de pago'
      DataBinding.DataField = 'Emitir'
      DataBinding.DataSource = FormaPagoDataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 11
      Transparent = True
      Height = 23
      Width = 185
    end
    object TipoDeDocumentoCtrl: TcxDBIndexedComboBox
      Left = 175
      Top = 116
      DataBinding.DataField = 'TipoDeDocumento'
      DataBinding.DataSource = FormaPagoDataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Letra de cambio'
        'Recibo'
        'Cheque bancario o pagar'#233
        'Transferencia'
        'Pago certificado'
        'Confirming')
      Properties.OnEditValueChanged = TipoDeDocumentoCtrlPropertiesEditValueChanged
      Properties.FirstIndexValue = 1
      TabOrder = 4
      Width = 188
    end
    object RecargoFinancieroCtrl: TcxDBCheckBox
      Left = 7
      Top = 236
      AutoSize = False
      Caption = 'So&portar recargo financ.'
      DataBinding.DataField = 'RecargoFinanciero'
      DataBinding.DataSource = FormaPagoDataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = RecargoFinancieroCtrlPropertiesEditValueChanged
      TabOrder = 9
      Transparent = True
      Height = 23
      Width = 185
    end
    object NoContabilizarCtrl: TcxDBCheckBox
      Left = 7
      Top = 286
      AutoSize = False
      Caption = '&No contabilizar'
      DataBinding.DataField = 'NoContabilizar'
      DataBinding.DataSource = FormaPagoDataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 12
      Transparent = True
      Height = 23
      Width = 185
    end
    object TipoDescuentoPPCtrl: TcxDBCurrencyEdit
      Left = 326
      Top = 209
      DataBinding.DataField = 'TipoDescuentoPP'
      DataBinding.DataSource = FormaPagoDataSource
      Properties.MaxLength = 5
      Properties.MaxValue = 100.000000000000000000
      Properties.MinValue = -100.000000000000000000
      TabOrder = 8
      Width = 46
    end
    object TipoRecargoFinancCtrl: TcxDBCurrencyEdit
      Left = 326
      Top = 236
      DataBinding.DataField = 'TipoRecargoFinanc'
      DataBinding.DataSource = FormaPagoDataSource
      Properties.MaxLength = 5
      Properties.MaxValue = 100.000000000000000000
      Properties.MinValue = -100.000000000000000000
      TabOrder = 10
      Width = 46
    end
    object GastosCtrl: TcxDBIndexedComboBox
      Left = 175
      Top = 143
      DataBinding.DataField = 'Gastos'
      DataBinding.DataSource = FormaPagoDataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Por nuestra cuenta'
        'Por cuenta del acreedor')
      TabOrder = 5
      Width = 139
    end
    object CanalPreferenteCtrl: TcxDBTextEdit
      Left = 175
      Top = 319
      DescriptionLabel = descCanalLabel
      DataBinding.DataField = 'CanalPreferente'
      DataBinding.DataSource = FormaPagoDataSource
      Properties.OnQueryRequest = CanalPreferenteCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CanalPreferenteCtrlPropertiesEditRequest
      Properties.TextEditPad = tpRightZero
      Properties.OnValidate = CanalPreferenteCtrlPropertiesValidate
      TabOrder = 13
      Width = 74
    end
    object Label1: TcxLabel
      Left = 10
      Top = 11
      TabStop = False
      Caption = 'Descripci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 14
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 10
      Top = 38
      TabStop = False
      Caption = 'N'#186' de plazos'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 15
      Transparent = True
    end
    object capPrimerVencimientoLabel: TcxLabel
      Left = 10
      Top = 65
      TabStop = False
      Caption = 'Primer vencimiento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 16
      Transparent = True
    end
    object capIntervaloLabel: TcxLabel
      Left = 10
      Top = 92
      TabStop = False
      Caption = 'Intervalo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 17
      Transparent = True
    end
    object capTipoDocumentoLabel: TcxLabel
      Left = 10
      Top = 120
      TabStop = False
      Caption = 'Tipo de documento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 18
      Transparent = True
    end
    object capDtoPPLabel: TcxLabel
      Left = 206
      Top = 213
      TabStop = False
      Caption = ' Descuento p.p.'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 19
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 206
      Top = 240
      TabStop = False
      Caption = ' Recargo financiero'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 20
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 378
      Top = 213
      TabStop = False
      Caption = '%'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 21
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 378
      Top = 240
      TabStop = False
      Caption = '%'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 22
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 10
      Top = 147
      TabStop = False
      Caption = 'Gastos'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 23
      Transparent = True
    end
    object Label33: TcxLabel
      Left = 10
      Top = 323
      TabStop = False
      Caption = 'Canal preferente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 24
      Transparent = True
    end
    object descCanalLabel: TcxLabel
      Left = 270
      Top = 323
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 25
      Transparent = True
      Height = 19
      Width = 266
    end
  end
  object FormManager: TgxFormManager
    Dataset = FormaPagoTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 440
    Top = 2
  end
  object FormaPagoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = FormaPagoTableNewRecord
    TableName = 'FormaPago'
    IndexFieldNames = 'Codigo'
    AutoIncFieldName = 'Codigo'
    Left = 410
    Top = 3
  end
  object FormaPagoDataSource: TDataSource
    DataSet = FormaPagoTable
    Left = 378
    Top = 3
  end
end
