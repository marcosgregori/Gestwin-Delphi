object MntPexForm: TMntPexForm
  Left = 400
  Top = 247
  HelpContext = 80515
  BorderStyle = bsDialog
  Caption = 'Proveedores externos'
  ClientHeight = 226
  ClientWidth = 451
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Position = poDefault
  Visible = True
  TextHeight = 17
  object KeyScreen: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    ExplicitWidth = 424
    Height = 35
    Width = 451
    object CodigoCtrl: TcxDBTextEdit
      Left = 105
      Top = 6
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      TabOrder = 0
      Width = 46
    end
    object codigoCtrlCaption: TcxLabel
      Left = 12
      Top = 9
      Caption = 'Codigo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object DataScreen: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 35
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
    ExplicitWidth = 414
    ExplicitHeight = 143
    DesignSize = (
      441
      156)
    Height = 156
    Width = 441
    object NombreCtrl: TcxDBTextEdit
      Left = 100
      Top = 8
      DataBinding.DataField = 'Nombre'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 221
    end
    object DomicilioCtrl: TcxDBTextEdit
      Left = 100
      Top = 35
      DataBinding.DataField = 'Domicilio'
      DataBinding.DataSource = DataSource
      TabOrder = 1
      Width = 221
    end
    object LocalidadCtrl: TcxDBTextEdit
      Left = 100
      Top = 62
      DataBinding.DataField = 'Localidad'
      DataBinding.DataSource = DataSource
      TabOrder = 2
      Width = 151
    end
    object PaisCtrl: TcxDBTextEdit
      Left = 100
      Top = 89
      DescriptionLabel = DescPaisLabel
      DataBinding.DataField = 'CodigoPais'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = PaisCtrlPropertiesQueryRequest
      Properties.OnEditRequest = PaisCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = PaisCtrlPropertiesValidate
      TabOrder = 3
      Width = 32
    end
    object CodigoProvinciaCtrl: TcxDBTextEdit
      Left = 100
      Top = 116
      DescriptionLabel = DescCPLabel
      DataBinding.DataField = 'CodigoProvincia'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoProvinciaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoProvinciaCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnEditValueChanged = CodigoProvinciaCtrlPropertiesEditValueChanged
      Properties.OnValidate = CodigoProvinciaCtrlPropertiesValidate
      TabOrder = 4
      Width = 25
    end
    object CodigoPostalCtrl: TcxDBTextEdit
      Left = 127
      Top = 116
      DescriptionLabel = DescCPLabel
      DataBinding.DataField = 'CodigoPostal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoPostalCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoPostalCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = CodigoPostalCtrlPropertiesValidate
      TabOrder = 5
      Width = 32
    end
    object Label1: TcxLabel
      Left = 6
      Top = 11
      Caption = 'Nombre'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 6
      Top = 38
      Caption = 'Domicilio'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 6
      Top = 66
      Caption = 'Localidad'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 7
      Top = 92
      Caption = 'Pais'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescPaisLabel: TcxLabel
      Left = 167
      Top = 93
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clNavy
      Style.Font.Height = -11
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 258
      Height = 18
      Width = 271
    end
    object Label4: TcxLabel
      Left = 7
      Top = 119
      Caption = 'Provincia / C.P.'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescCPLabel: TcxLabel
      Left = 167
      Top = 120
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clNavy
      Style.Font.Height = -11
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 258
      Height = 18
      Width = 271
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 191
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    ExplicitTop = 178
    ExplicitWidth = 424
    DesignSize = (
      451
      35)
    Height = 35
    Width = 451
    object Panel2: TcxGroupBox
      Left = 96
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 82
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
  object FormManager: TgxFormManager
    Dataset = ProveedorExternoTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = NombreCtrl
    Model = fmEditForm
    ShowQueryOption = False
    Left = 358
    Top = 4
  end
  object ProveedorExternoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ProveedorExterno'
    IndexFieldNames = 'Codigo'
    Left = 328
    Top = 4
    object ProveedorExternoTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 5
    end
    object ProveedorExternoTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object ProveedorExternoTableDomicilio: TWideStringField
      FieldName = 'Domicilio'
      Size = 40
    end
    object ProveedorExternoTableLocalidad: TWideStringField
      FieldName = 'Localidad'
      Size = 30
    end
    object ProveedorExternoTableCodigoPais: TWideStringField
      FieldName = 'CodigoPais'
      Size = 3
    end
    object ProveedorExternoTableCodigoProvincia: TWideStringField
      FieldName = 'CodigoProvincia'
      Size = 2
    end
    object ProveedorExternoTableCodigoPostal: TWideStringField
      FieldName = 'CodigoPostal'
      Size = 3
    end
  end
  object DataSource: TDataSource
    DataSet = ProveedorExternoTable
    Left = 298
    Top = 4
  end
end
