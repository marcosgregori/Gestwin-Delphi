object MntRccForm: TMntRccForm
  Left = 451
  Top = 387
  HelpType = htKeyword
  HelpKeyword = 'a_rcc'
  BorderStyle = bsDialog
  Caption = 'Relaciones contables de compras'
  ClientHeight = 190
  ClientWidth = 639
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
      629
      149)
    Height = 149
    Width = 629
    object CuentaComprasCtrl: TcxDBTextEdit
      Left = 183
      Top = 5
      DescriptionLabel = Label10
      DataBinding.DataField = 'CuentaCompras'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEnter = CuentaComprasCtrlPropertiesEnter
      Properties.OnQueryRequest = CuentaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CuentaCtrlPropertiesEditRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = CuentaCtrlPropertiesValidate
      TabOrder = 0
      Width = 74
    end
    object CuentaDevolucionesCtrl: TcxDBTextEdit
      Left = 183
      Top = 32
      DescriptionLabel = Label11
      DataBinding.DataField = 'CuentaDevoluciones'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEnter = CuentaDevolucionesCtrlPropertiesEnter
      Properties.OnQueryRequest = CuentaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CuentaCtrlPropertiesEditRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = CuentaCtrlPropertiesValidate
      TabOrder = 1
      Width = 74
    end
    object CuentaDescuentoCtrl: TcxDBTextEdit
      Left = 183
      Top = 59
      DescriptionLabel = Label3
      DataBinding.DataField = 'CuentaDescuento'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEnter = CuentaDescuentoCtrlPropertiesEnter
      Properties.OnQueryRequest = CuentaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CuentaCtrlPropertiesEditRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = CuentaCtrlPropertiesValidate
      TabOrder = 2
      Width = 74
    end
    object CuentaRecargoCtrl: TcxDBTextEdit
      Left = 183
      Top = 86
      DescriptionLabel = Label6
      DataBinding.DataField = 'CuentaRecargo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEnter = CuentaRecargoCtrlPropertiesEnter
      Properties.OnQueryRequest = CuentaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CuentaCtrlPropertiesEditRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = CuentaCtrlPropertiesValidate
      TabOrder = 3
      Width = 74
    end
    object CuentaPortesCtrl: TcxDBTextEdit
      Left = 183
      Top = 113
      DescriptionLabel = Label8
      DataBinding.DataField = 'CuentaPortes'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEnter = CuentaPortesCtrlPropertiesEnter
      Properties.OnQueryRequest = CuentaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CuentaCtrlPropertiesEditRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = CuentaCtrlPropertiesValidate
      TabOrder = 4
      Width = 74
    end
    object Label4: TcxLabel
      Left = 10
      Top = 8
      Caption = 'Compras'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 271
      Top = 11
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
      Height = 19
      Width = 354
    end
    object Label2: TcxLabel
      Left = 10
      Top = 35
      Caption = 'Devoluciones de compras'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
    end
    object Label11: TcxLabel
      Left = 271
      Top = 38
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
      Height = 19
      Width = 354
    end
    object Label1: TcxLabel
      Left = 10
      Top = 62
      Caption = 'Descuentos por pronto pago'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 271
      Top = 65
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
      Height = 19
      Width = 354
    end
    object Label5: TcxLabel
      Left = 10
      Top = 89
      Caption = 'Recargos financieros'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 271
      Top = 92
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
      Height = 19
      Width = 354
    end
    object Label7: TcxLabel
      Left = 10
      Top = 115
      Caption = 'Portes'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 271
      Top = 118
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 14
      Transparent = True
      Height = 19
      Width = 354
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 154
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      639
      36)
    Height = 36
    Width = 639
    object Panel3: TcxGroupBox
      Left = 234
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
    FirstDataControl = CuentaComprasCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 446
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 413
    Top = 12
    object DataCuentaCompras: TWideStringField
      FieldName = 'CuentaCompras'
      Size = 9
    end
    object DataCuentaDevoluciones: TWideStringField
      FieldName = 'CuentaDevoluciones'
      Size = 9
    end
    object DataCuentaDescuento: TWideStringField
      FieldName = 'CuentaDescuento'
      Size = 9
    end
    object DataCuentaRecargo: TWideStringField
      FieldName = 'CuentaRecargo'
      Size = 9
    end
    object DataCuentaPortes: TWideStringField
      FieldName = 'CuentaPortes'
      Size = 9
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 380
    Top = 12
  end
end
