object MntCdbForm: TMntCdbForm
  Left = 369
  Top = 292
  HelpType = htKeyword
  HelpKeyword = 'a_cdb'
  HelpContext = 1106
  BorderStyle = bsDialog
  Caption = 'C'#243'digos de barras'
  ClientHeight = 193
  ClientWidth = 560
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
  object keyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 36
    Width = 560
    object CodigoCtrl: TcxDBTextEdit
      Left = 90
      Top = 6
      DataBinding.DataField = 'CodigoBarras'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      TabOrder = 0
      Width = 130
    end
    object codigoCtrlCaption: TcxLabel
      Left = 17
      Top = 9
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
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
      550
      121)
    Height = 121
    Width = 550
    object CodigoArticuloCtrl: TcxDBTextEdit
      Left = 85
      Top = 6
      DescriptionLabel = DescCodigoLabel
      DataBinding.DataField = 'CodigoArticulo'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoArticuloCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
      TabOrder = 0
      Width = 102
    end
    object CodigoClaseACtrl: TcxDBTextEdit
      Tag = 1
      Left = 85
      Top = 33
      CaptionLabel = CapClaseALabel
      DescriptionLabel = DescClaseALabel
      DataBinding.DataField = 'ClaseA'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 1
      Width = 32
    end
    object CodigoClaseBCtrl: TcxDBTextEdit
      Tag = 2
      Left = 85
      Top = 60
      CaptionLabel = CapClaseBLabel
      DescriptionLabel = DescClaseBLabel
      DataBinding.DataField = 'ClaseB'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 2
      Width = 32
    end
    object CodigoClaseCCtrl: TcxDBTextEdit
      Tag = 3
      Left = 85
      Top = 87
      CaptionLabel = CapClaseCLabel
      DescriptionLabel = DescCalseCLabel
      DataBinding.DataField = 'ClaseC'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 3
      Width = 32
    end
    object capCodigoLabel: TcxLabel
      Left = 12
      Top = 9
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
    object CapClaseALabel: TcxLabel
      Left = 12
      Top = 36
      Caption = 'Clase A '
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object CapClaseBLabel: TcxLabel
      Left = 12
      Top = 63
      Caption = 'Clase B'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
    end
    object DescCodigoLabel: TcxLabel
      Left = 207
      Top = 9
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
      Height = 19
      Width = 337
    end
    object DescClaseALabel: TcxLabel
      Left = 207
      Top = 36
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
      Height = 19
      Width = 337
    end
    object DescClaseBLabel: TcxLabel
      Left = 207
      Top = 63
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
      Height = 19
      Width = 337
    end
    object CapClaseCLabel: TcxLabel
      Left = 12
      Top = 90
      Caption = 'Clase C'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
    end
    object DescCalseCLabel: TcxLabel
      Left = 207
      Top = 90
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
      Height = 19
      Width = 337
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 157
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    ExplicitTop = 158
    DesignSize = (
      560
      36)
    Height = 36
    Width = 560
    object Panel2: TcxGroupBox
      Left = 151
      Top = 4
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 131
      ExplicitTop = 3
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
    Dataset = CodigoBarrasTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = CodigoArticuloCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    OnGetAccessLevel = FormManagerGetAccessLevel
    Left = 472
    Top = 40
  end
  object CodigoBarrasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'CodigoBarras'
    IndexFieldNames = 'CodigoBarras'
    Left = 440
    Top = 42
  end
  object DataSource: TDataSource
    DataSet = CodigoBarrasTable
    Left = 408
    Top = 42
  end
end
