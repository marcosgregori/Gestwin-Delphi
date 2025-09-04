object MntRvvForm: TMntRvvForm
  Left = 451
  Top = 387
  HelpType = htKeyword
  HelpKeyword = 'a_rvv'
  BorderStyle = bsDialog
  Caption = 'Relaciones contables de ventas'
  ClientHeight = 187
  ClientWidth = 632
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
      622
      146)
    Height = 146
    Width = 622
    object CuentaVentasCtrl: TcxDBTextEdit
      Left = 185
      Top = 5
      DescriptionLabel = Label10
      DataBinding.DataField = 'CuentaVentas'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEnter = CuentaVentasCtrlPropertiesEnter
      Properties.OnQueryRequest = CuentaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CuentaCtrlPropertiesEditRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = CuentaCtrlPropertiesValidate
      TabOrder = 0
      Width = 74
    end
    object CuentaDevolucionesCtrl: TcxDBTextEdit
      Left = 185
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
      Left = 185
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
      Left = 185
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
      Left = 185
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
      TabStop = False
      Caption = 'Ventas'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 273
      Top = 11
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 6
      Transparent = True
      Height = 20
      Width = 345
      AnchorY = 21
    end
    object Label2: TcxLabel
      Left = 10
      Top = 35
      TabStop = False
      Caption = 'Devoluciones de ventas'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
    end
    object Label11: TcxLabel
      Left = 273
      Top = 38
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 8
      Transparent = True
      Height = 20
      Width = 345
      AnchorY = 48
    end
    object Label1: TcxLabel
      Left = 10
      Top = 62
      TabStop = False
      Caption = 'Descuentos por pronto pago'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 273
      Top = 65
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 10
      Transparent = True
      Height = 20
      Width = 345
      AnchorY = 75
    end
    object Label5: TcxLabel
      Left = 10
      Top = 89
      TabStop = False
      Caption = 'Recargos financieros'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 273
      Top = 92
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 12
      Transparent = True
      Height = 20
      Width = 345
      AnchorY = 102
    end
    object Label7: TcxLabel
      Left = 10
      Top = 113
      TabStop = False
      Caption = 'Portes'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 273
      Top = 116
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      TabOrder = 14
      Transparent = True
      Height = 20
      Width = 345
      AnchorY = 126
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 151
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      632
      36)
    Height = 36
    Width = 632
    object Panel3: TcxGroupBox
      Left = 229
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
    FirstDataControl = CuentaVentasCtrl
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
    object DataCuentaVentas: TWideStringField
      FieldName = 'CuentaVentas'
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
