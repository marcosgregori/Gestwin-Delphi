object MntFcoForm: TMntFcoForm
  Left = 528
  Top = 215
  HelpType = htKeyword
  HelpKeyword = 'a_fco'
  HelpContext = 3105
  BorderStyle = bsDialog
  Caption = 'Formas de cobro'
  ClientHeight = 506
  ClientWidth = 570
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
    Width = 570
    object CodigoCtrl: TcxDBTextEdit
      Left = 187
      Top = 5
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = FormaCobroDataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 0
      Width = 27
    end
    object codigoCtrlCaption: TcxLabel
      Left = 17
      Top = 8
      Caption = 'Codigo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 470
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      570
      36)
    Height = 36
    Width = 570
    object Panel2: TcxGroupBox
      Left = 157
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 260
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
    Height = 434
    Width = 560
    object DefaultPanel: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        556
        420)
      Height = 420
      Width = 556
      object Shape2: TShape
        Left = 10
        Top = 386
        Width = 536
        Height = 1
        Anchors = [akLeft, akTop, akRight]
        Pen.Color = clBtnShadow
        ExplicitWidth = 515
      end
      object Shape1: TShape
        Left = 10
        Top = 228
        Width = 536
        Height = 1
        Anchors = [akLeft, akTop, akRight]
        Pen.Color = clBtnShadow
        ExplicitWidth = 515
      end
      object DescripcionCtrl: TcxDBTextEdit
        Left = 180
        Top = 7
        DataBinding.DataField = 'Descripcion'
        DataBinding.DataSource = FormaCobroDataSource
        Properties.Required = True
        TabOrder = 0
        Width = 369
      end
      object PlazosCtrl: TcxDBSpinEdit
        Left = 180
        Top = 34
        DataBinding.DataField = 'Plazos'
        DataBinding.DataSource = FormaCobroDataSource
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
        Left = 180
        Top = 61
        DataBinding.DataField = 'PrimerVencimiento'
        DataBinding.DataSource = FormaCobroDataSource
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxValue = 999.000000000000000000
        TabOrder = 2
        Width = 60
      end
      object IntervaloCtrl: TcxDBSpinEdit
        Left = 180
        Top = 88
        DataBinding.DataField = 'Intervalo'
        DataBinding.DataSource = FormaCobroDataSource
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxValue = 999.000000000000000000
        TabOrder = 3
        Width = 60
      end
      object AceptadoCtrl: TcxDBCheckBox
        Left = 8
        Top = 169
        AutoSize = False
        Caption = 'Ace&ptado'
        DataBinding.DataField = 'Aceptado'
        DataBinding.DataSource = FormaCobroDataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        TabOrder = 7
        Transparent = True
        Height = 23
        Width = 191
      end
      object crearRegistroCtrl: TcxDBCheckBox
        Left = 7
        Top = 238
        AutoSize = False
        Caption = '&Generar efectos'
        DataBinding.DataField = 'CrearRegistro'
        DataBinding.DataSource = FormaCobroDataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        TabOrder = 9
        Transparent = True
        Height = 23
        Width = 190
      end
      object DescuentoPPCtrl: TcxDBCheckBox
        Left = 7
        Top = 262
        AutoSize = False
        Caption = 'Ap&licar descuento p. p.'
        DataBinding.DataField = 'DescuentoPP'
        DataBinding.DataSource = FormaCobroDataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.OnEditValueChanged = DescuentoPPCtrlPropertiesEditValueChanged
        TabOrder = 10
        Transparent = True
        Height = 23
        Width = 190
      end
      object EmitirCtrl: TcxDBCheckBox
        Left = 7
        Top = 313
        AutoSize = False
        Caption = 'Emitir &documento de cobro'
        DataBinding.DataField = 'Emitir'
        DataBinding.DataSource = FormaCobroDataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        TabOrder = 14
        Transparent = True
        Height = 23
        Width = 190
      end
      object RecargoFinancieroCtrl: TcxDBCheckBox
        Left = 7
        Top = 289
        AutoSize = False
        Caption = 'A&plicar recargo financiero'
        DataBinding.DataField = 'RecargoFinanciero'
        DataBinding.DataSource = FormaCobroDataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.OnEditValueChanged = RecargoFinancieroCtrlPropertiesEditValueChanged
        TabOrder = 12
        Transparent = True
        Height = 23
        Width = 190
      end
      object TipoDescuentoPPCtrl: TcxDBCurrencyEdit
        Left = 336
        Top = 261
        DataBinding.DataField = 'TipoDescuentoPP'
        DataBinding.DataSource = FormaCobroDataSource
        Properties.MaxLength = 5
        Properties.MaxValue = 100.000000000000000000
        Properties.MinValue = -100.000000000000000000
        TabOrder = 11
        Width = 46
      end
      object TipoRecargoFinancCtrl: TcxDBCurrencyEdit
        Left = 336
        Top = 288
        DataBinding.DataField = 'TipoRecargoFinanc'
        DataBinding.DataSource = FormaCobroDataSource
        Properties.MaxLength = 5
        Properties.MaxValue = 100.000000000000000000
        Properties.MinValue = -100.000000000000000000
        TabOrder = 13
        Width = 46
      end
      object NoContabilizarCtrl: TcxDBCheckBox
        Left = 7
        Top = 336
        AutoSize = False
        Caption = '&No contabilizar'
        DataBinding.DataField = 'NoContabilizar'
        DataBinding.DataSource = FormaCobroDataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        TabOrder = 15
        Transparent = True
        Height = 23
        Width = 190
      end
      object DiaCobro1Ctrl: TcxDBSpinEdit
        Left = 180
        Top = 115
        DataBinding.DataField = 'DiaCobro1'
        DataBinding.DataSource = FormaCobroDataSource
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.ImmediatePost = True
        Properties.MaxValue = 31.000000000000000000
        Properties.OnEditValueChanged = DiaCobro1CtrlPropertiesEditValueChanged
        TabOrder = 4
        Width = 60
      end
      object DiaCobro2Ctrl: TcxDBSpinEdit
        Left = 261
        Top = 115
        DataBinding.DataField = 'DiaCobro2'
        DataBinding.DataSource = FormaCobroDataSource
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#'
        Properties.EditFormat = '#'
        Properties.MaxValue = 31.000000000000000000
        TabOrder = 5
        Width = 60
      end
      object Meses30DiasCtrl: TcxDBCheckBox
        Left = 7
        Top = 359
        AutoSize = False
        Caption = 'Meses de &30 d'#237'as'
        DataBinding.DataField = 'Meses30Dias'
        DataBinding.DataSource = FormaCobroDataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        TabOrder = 16
        Transparent = True
        Height = 23
        Width = 190
      end
      object CanalPreferenteCtrl: TcxDBTextEdit
        Left = 180
        Top = 394
        DescriptionLabel = DescCanalLabel
        DataBinding.DataField = 'CanalPreferente'
        DataBinding.DataSource = FormaCobroDataSource
        Properties.OnQueryRequest = CanalPreferenteCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CanalPreferenteCtrlPropertiesEditRequest
        Properties.TextEditPad = tpRightZero
        Properties.OnValidate = CanalPreferenteCtrlPropertiesValidate
        TabOrder = 17
        Width = 74
      end
      object TipoDeDocumentoCtrl: TcxDBIndexedComboBox
        Left = 180
        Top = 142
        DataBinding.DataField = 'TipoDeDocumento'
        DataBinding.DataSource = FormaCobroDataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          'Letra de cambio'
          'Recibo'
          'Pagar'#233)
        Properties.OnEditValueChanged = TipoDeDocumentoCtrlPropertiesEditValueChanged
        Properties.FirstIndexValue = 1
        TabOrder = 6
        Width = 169
      end
      object GastosCtrl: TcxComboBox
        Left = 180
        Top = 194
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          'Sin gastos'
          'Con gastos'
          'Orden de protesto')
        TabOrder = 8
        Width = 169
      end
      object Label1: TcxLabel
        Left = 10
        Top = 11
        Caption = 'Descripci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 18
        Transparent = True
      end
      object Label2: TcxLabel
        Left = 10
        Top = 38
        Caption = 'N'#186' de plazos'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 19
        Transparent = True
      end
      object capPrimerVencimientoLabel: TcxLabel
        Left = 10
        Top = 65
        Caption = 'Primer vencimiento'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 20
        Transparent = True
      end
      object capIntervaloLabel: TcxLabel
        Left = 10
        Top = 91
        Caption = 'Intervalo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 21
        Transparent = True
      end
      object capTipoDocumentoLabel: TcxLabel
        Left = 10
        Top = 146
        Caption = 'Tipo de documento'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 22
        Transparent = True
      end
      object capGastos: TcxLabel
        Left = 10
        Top = 199
        Caption = 'Gastos'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 23
        Transparent = True
      end
      object capDtoPPLabel: TcxLabel
        Left = 214
        Top = 265
        Caption = ' Descuento p.p.'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 24
        Transparent = True
      end
      object Label3: TcxLabel
        Left = 214
        Top = 292
        Caption = ' Recargo financiero'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 25
        Transparent = True
      end
      object Label4: TcxLabel
        Left = 388
        Top = 265
        Caption = '%'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 26
        Transparent = True
      end
      object Label5: TcxLabel
        Left = 388
        Top = 292
        Caption = '%'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 27
        Transparent = True
      end
      object Label22: TcxLabel
        Left = 10
        Top = 119
        Caption = 'D'#237'as de cobro'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 28
        Transparent = True
      end
      object Label23: TcxLabel
        Left = 247
        Top = 119
        Caption = 'y'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 29
        Transparent = True
      end
      object Label33: TcxLabel
        Left = 10
        Top = 397
        Caption = 'Canal preferente'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 30
        Transparent = True
      end
      object DescCanalLabel: TcxLabel
        Left = 268
        Top = 399
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 31
        Transparent = True
        Height = 19
        Width = 281
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = FormaCobroTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 433
    Top = 2
  end
  object FormaCobroTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforePost = FormaCobroTableBeforePost
    OnNewRecord = FormaCobroTableNewRecord
    TableName = 'FormaCobro'
    IndexFieldNames = 'Codigo'
    AutoIncFieldName = 'Codigo'
    OnGetRecord = FormaCobroTableGetRecord
    Left = 403
    Top = 2
  end
  object FormaCobroDataSource: TDataSource
    DataSet = FormaCobroTable
    Left = 373
    Top = 2
  end
end
