object MntOrpForm: TMntOrpForm
  Left = 475
  Top = 299
  HelpType = htKeyword
  HelpKeyword = 'a_orp'
  BorderStyle = bsDialog
  Caption = 'Organismos p'#250'blicos'
  ClientHeight = 319
  ClientWidth = 597
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs206'
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
    Height = 60
    Width = 597
    object CodigoCtrl: TcxDBTextEdit
      Left = 134
      Top = 31
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.PadAlways = True
      TabOrder = 1
      Width = 110
    end
    object codigoCtrlCaption: TcxLabel
      Left = 16
      Top = 34
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Transparent = True
    end
    object cxLabel1: TcxLabel
      Left = 16
      Top = 8
      Caption = 'Tipo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
    object TipoCtrl: TcxDBIndexedComboBox
      Left = 134
      Top = 4
      DataBinding.DataField = 'Tipo'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Oficina contable'
        #211'rgano gestor'
        'Unidad tramitadora'
        #211'rgano proponente')
      Properties.OnChange = TipoCtrlPropertiesChange
      TabOrder = 0
      Width = 152
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 283
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      597
      36)
    Height = 36
    Width = 597
    object Panel4: TcxGroupBox
      Left = 166
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 263
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
    Top = 60
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
      587
      223)
    Height = 223
    Width = 587
    object Label1: TcxLabel
      Left = 10
      Top = 10
      Caption = 'Nombre'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 0
      Transparent = True
    end
    object NombreCtrl: TcxDBTextEdit
      Left = 129
      Top = 6
      DataBinding.DataField = 'Nombre'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 419
    end
    object DomicilioCtrl: TcxDBTextEdit
      Left = 129
      Top = 33
      DataBinding.DataField = 'Domicilio'
      DataBinding.DataSource = DataSource
      TabOrder = 2
      Width = 248
    end
    object LocalidadCtrl: TcxDBTextEdit
      Left = 129
      Top = 60
      DataBinding.DataField = 'Localidad'
      DataBinding.DataSource = DataSource
      TabOrder = 3
      Width = 169
    end
    object capDomicilioLabel: TcxLabel
      Left = 10
      Top = 36
      Caption = 'Domicilio'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
    end
    object capLocalidadLabel: TcxLabel
      Left = 10
      Top = 64
      Caption = 'Localidad'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object CodigoProvinciaCtrl: TcxDBTextEdit
      Left = 129
      Top = 114
      DescriptionLabel = DescCPLabel
      DataBinding.DataField = 'CodigoProvincia'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoProvinciaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoProvinciaCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoProvinciaCtrlPropertiesValidate
      TabOrder = 5
      Width = 25
    end
    object CodigoPostalCtrl: TcxDBTextEdit
      Left = 155
      Top = 114
      DescriptionLabel = DescCPLabel
      DataBinding.DataField = 'CodigoPostal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.TextEditPad = tpLeftZero
      TabOrder = 6
      Width = 32
    end
    object PaisCtrl: TcxDBTextEdit
      Left = 129
      Top = 87
      DescriptionLabel = DescPaisLabel
      DataBinding.DataField = 'CodigoPais'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEnter = PaisCtrlPropertiesEnter
      Properties.OnQueryRequest = PaisCtrlPropertiesQueryRequest
      Properties.OnEditRequest = PaisCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = PaisCtrlPropertiesValidate
      TabOrder = 4
      Width = 32
    end
    object capProvinciaLabel: TcxLabel
      Left = 10
      Top = 118
      Caption = 'Provincia / C.P.'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
    end
    object DescCPLabel: TcxLabel
      Left = 248
      Top = 118
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
      Height = 19
      Width = 334
    end
    object Label8: TcxLabel
      Left = 10
      Top = 90
      Caption = 'Pais'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
    end
    object DescPaisLabel: TcxLabel
      Left = 248
      Top = 90
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
      Height = 19
      Width = 334
    end
    object CodigoCentroCtrl: TcxDBTextEdit
      Left = 129
      Top = 141
      CaptionLabel = CodigoCentroLabel
      DescriptionLabel = cxLabel3
      DataBinding.DataField = 'CodigoCentro'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCentroCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCentroCtrlPropertiesValidate
      TabOrder = 7
      Width = 110
    end
    object CodigoCentroLabel: TcxLabel
      Left = 10
      Top = 144
      Caption = #211'rgano gestor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 14
      Transparent = True
    end
    object cxLabel3: TcxLabel
      Left = 248
      Top = 144
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 15
      Transparent = True
      Height = 18
      Width = 323
    end
    object CodigoPaisEnNIFCtrl: TcxDBCheckBox
      Left = 7
      Top = 167
      AutoSize = False
      Caption = 'Incluir el c'#243'digo del pais en el N.I.F.'
      DataBinding.DataField = 'CodigoPaisEnNIF'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 16
      Transparent = True
      Height = 40
      Width = 138
    end
  end
  object FormManager: TgxFormManager
    Dataset = OrganismoPublicoTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = NombreCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 493
    Top = 5
  end
  object DataSource: TDataSource
    DataSet = OrganismoPublicoTable
    Left = 429
    Top = 5
  end
  object OrganismoPublicoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    OnNewRecord = OrganismoPublicoTableNewRecord
    TableName = 'OrganismoPublico'
    IndexFieldNames = 'Tipo;Codigo'
    OnGetRecord = OrganismoPublicoTableGetRecord
    Left = 461
    Top = 5
  end
end
