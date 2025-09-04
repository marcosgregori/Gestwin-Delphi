object MntDefForm: TMntDefForm
  Left = 633
  Top = 388
  HelpType = htKeyword
  HelpKeyword = 'a_def'
  BorderStyle = bsDialog
  Caption = 'Tipos de defecto o tara'
  ClientHeight = 207
  ClientWidth = 475
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs70'
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
    Width = 475
    object CodigoCtrl: TcxDBSpinEdit
      Left = 95
      Top = 5
      DataBinding.DataField = 'Codigo'
      DataBinding.DataSource = DefectoDataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 0
      Width = 50
    end
    object codigoCtrlCaption: TcxLabel
      Left = 12
      Top = 8
      TabStop = False
      Caption = 'Codigo'
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
    Height = 135
    Width = 465
    object DescripcionCtrl: TcxDBTextEdit
      Left = 90
      Top = 7
      DataBinding.DataField = 'Descripcion'
      DataBinding.DataSource = DefectoDataSource
      Properties.Required = True
      TabOrder = 0
      Width = 221
    end
    object Label1: TcxLabel
      Left = 8
      Top = 10
      TabStop = False
      Caption = 'Descripci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
    object CodigoClaseACtrl: TcxDBTextEdit
      Tag = 1
      Left = 90
      Top = 34
      CaptionLabel = capClaseALabel
      DescriptionLabel = DescClaseALabel
      DataBinding.DataField = 'CodigoClaseA'
      DataBinding.DataSource = DefectoDataSource
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 1
      Width = 32
    end
    object CodigoClaseBCtrl: TcxDBTextEdit
      Tag = 2
      Left = 90
      Top = 61
      CaptionLabel = capClaseBLabel
      DescriptionLabel = DescClaseBLabel
      DataBinding.DataField = 'CodigoClaseB'
      DataBinding.DataSource = DefectoDataSource
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 2
      Width = 32
    end
    object CodigoClaseCCtrl: TcxDBTextEdit
      Tag = 3
      Left = 90
      Top = 88
      CaptionLabel = capClaseCLabel
      DescriptionLabel = DescClaseCLabel
      DataBinding.DataField = 'CodigoClaseC'
      DataBinding.DataSource = DefectoDataSource
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnEditRequest = CodigoClaseCtrlPropertiesEditRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 3
      Width = 32
    end
    object capClaseALabel: TcxLabel
      Left = 8
      Top = 37
      TabStop = False
      Caption = 'Clase A '
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object capClaseBLabel: TcxLabel
      Left = 8
      Top = 64
      TabStop = False
      Caption = 'Clase B'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
    end
    object DescClaseALabel: TcxLabel
      Left = 144
      Top = 37
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
      Height = 19
      Width = 267
    end
    object DescClaseBLabel: TcxLabel
      Left = 144
      Top = 64
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
      Height = 19
      Width = 267
    end
    object capClaseCLabel: TcxLabel
      Left = 8
      Top = 91
      TabStop = False
      Caption = 'Clase C'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object DescClaseCLabel: TcxLabel
      Left = 144
      Top = 91
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
      Height = 19
      Width = 267
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 171
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      475
      36)
    Height = 36
    Width = 475
    object Panel2: TcxGroupBox
      Left = 110
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
  object FormManager: TgxFormManager
    Dataset = DefectoTable
    FirstKeyControl = CodigoCtrl
    FirstDataControl = DescripcionCtrl
    Model = fmEditForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnReportRequest = FormManagerReportRequest
    Left = 394
    Top = 4
  end
  object DefectoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Defecto'
    IndexFieldNames = 'Codigo'
    AutoIncFieldName = 'Codigo'
    Left = 364
    Top = 4
  end
  object DefectoDataSource: TDataSource
    DataSet = DefectoTable
    Left = 332
    Top = 4
  end
end
