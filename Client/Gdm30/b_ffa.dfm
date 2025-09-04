object boxFfaForm: TboxFfaForm
  Left = 482
  Top = 335
  HelpType = htKeyword
  HelpKeyword = 'b_ffa'
  BorderStyle = bsDialog
  Caption = 'Filtro de ficha de art'#237'culos'
  ClientHeight = 222
  ClientWidth = 541
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
  object DataPanel: TgxEditPanel
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
      531
      181)
    Height = 181
    Width = 531
    object TipoMovimientoCtrl: TcxDBSpinEdit
      Left = 135
      Top = 6
      DescriptionLabel = DescTipoMovimientoLabel
      DataBinding.DataField = 'TipoMovimiento'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = TipoMovimientoCtrlPropertiesQueryRequest
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 99.000000000000000000
      Properties.OnEditValueChanged = TipoMovimientoCtrlPropertiesEditValueChanged
      Properties.OnValidate = TipoMovimientoCtrlPropertiesValidate
      TabOrder = 0
      Width = 56
    end
    object CodigoClaseACtrl: TcxDBTextEdit
      Tag = 1
      Left = 135
      Top = 60
      CaptionLabel = capClaseALabel
      DescriptionLabel = DescClaseALabel
      DataBinding.DataField = 'CodigoClaseA'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 2
      Width = 32
    end
    object CodigoClaseBCtrl: TcxDBTextEdit
      Tag = 2
      Left = 135
      Top = 87
      CaptionLabel = capClaseBLabel
      DescriptionLabel = DescClaseBLabel
      DataBinding.DataField = 'CodigoClaseB'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 3
      Width = 32
    end
    object CodigoClaseCCtrl: TcxDBTextEdit
      Tag = 3
      Left = 135
      Top = 114
      CaptionLabel = capClaseCLabel
      DescriptionLabel = DescClaseBLabel
      DataBinding.DataField = 'CodigoClaseC'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 4
      Width = 32
    end
    object LoteFabricacionCtrl: TcxDBTextEdit
      Left = 135
      Top = 141
      DataBinding.DataField = 'LoteFabricacion'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = LoteFabricacionCtrlPropertiesQueryRequest
      TabOrder = 5
      Width = 114
    end
    object CodigoPropietarioCtrl: TcxDBTextEdit
      Left = 135
      Top = 33
      CaptionLabel = Label4
      DescriptionLabel = DescPropietarioLabel
      DataBinding.DataField = 'CodigoPropietario'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = CodigoPropietarioCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = CodigoPropietarioCtrlPropertiesValidate
      TabOrder = 1
      Width = 46
    end
    object Label7: TcxLabel
      Left = 11
      Top = 9
      Caption = 'Tipo de movimiento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
    end
    object DescTipoMovimientoLabel: TcxLabel
      Left = 206
      Top = 9
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
      Height = 19
      Width = 319
    end
    object capClaseALabel: TcxLabel
      Left = 11
      Top = 63
      Caption = 'Clase A '
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
    end
    object capClaseBLabel: TcxLabel
      Left = 11
      Top = 90
      Caption = 'Clase B'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object DescClaseALabel: TcxLabel
      Left = 206
      Top = 63
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
      Height = 19
      Width = 319
    end
    object DescClaseBLabel: TcxLabel
      Left = 206
      Top = 90
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
      Height = 19
      Width = 319
    end
    object capClaseCLabel: TcxLabel
      Left = 11
      Top = 117
      Caption = 'Clase C'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
    end
    object DescClaseCLabel: TcxLabel
      Left = 206
      Top = 117
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
      Height = 19
      Width = 319
    end
    object Label1: TcxLabel
      Left = 11
      Top = 144
      Caption = 'Lote de fabricaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 14
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 11
      Top = 36
      Caption = 'Propietario'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 15
      Transparent = True
    end
    object DescPropietarioLabel: TcxLabel
      Left = 206
      Top = 36
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 16
      Transparent = True
      Height = 19
      Width = 319
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 186
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      541
      36)
    Height = 36
    Width = 541
    object Panel3: TcxGroupBox
      Left = 185
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
    FirstDataControl = TipoMovimientoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 456
    Top = 14
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 427
    Top = 14
    object DataTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object DataCodigoPropietario: TWideStringField
      FieldName = 'CodigoPropietario'
      Size = 5
    end
    object DataCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object DataCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object DataCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object DataLoteFabricacion: TWideStringField
      FieldName = 'LoteFabricacion'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 396
    Top = 14
  end
end
