object RptRapForm: TRptRapForm
  Left = 355
  Top = 257
  HelpType = htKeyword
  HelpKeyword = 'l_rac'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de registros auxiliares de proveedores'
  ClientHeight = 109
  ClientWidth = 462
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  Position = poDefault
  Visible = True
  TextHeight = 20
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 4
    Top = 4
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
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
    ExplicitWidth = 416
    ExplicitHeight = 78
    DesignSize = (
      454
      70)
    Height = 70
    Width = 454
    object gxRangeBox1: TgxRangeBox
      Left = 92
      Top = 17
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object ProveedorInicialCtrl: TcxDBTextEdit
      Left = 97
      Top = 6
      DescriptionLabel = Label3
      DataBinding.DataField = 'ProveedorInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = ProveedorCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object ProveedorFinalCtrl: TcxDBTextEdit
      Left = 97
      Top = 33
      DescriptionLabel = Label2
      DataBinding.DataField = 'ProveedorFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = ProveedorCtrlPropertiesValidate
      TabOrder = 1
      Width = 46
    end
    object Label1: TcxLabel
      Left = 12
      Top = 9
      TabStop = False
      Caption = 'Proveedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 154
      Top = 9
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 356
      Height = 19
      Width = 293
    end
    object Label2: TcxLabel
      Left = 154
      Top = 36
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 356
      Height = 19
      Width = 293
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 74
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 82
    ExplicitWidth = 424
    DesignSize = (
      462
      35)
    Height = 35
    Width = 462
    object Panel3: TcxGroupBox
      Left = 148
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 129
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
    FirstDataControl = ProveedorInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 346
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 315
    Top = 10
    object DataProveedorInicial: TWideStringField
      FieldName = 'ProveedorInicial'
      Size = 5
    end
    object DataProveedorFinal: TWideStringField
      FieldName = 'ProveedorFinal'
      Size = 5
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 282
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_rap'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 250
    Top = 10
  end
end
