object RptTraForm: TRptTraForm
  Left = 394
  Top = 275
  HelpType = htKeyword
  HelpKeyword = 'l_tra'
  HelpContext = 1107
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de transportistas'
  ClientHeight = 144
  ClientWidth = 523
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
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
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    ExplicitWidth = 453
    ExplicitHeight = 99
    DesignSize = (
      513
      103)
    Height = 103
    Width = 513
    object gxRangeBox1: TgxRangeBox
      Left = 144
      Top = 15
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 161
      Top = 6
      DescriptionLabel = Label3
      DataBinding.DataField = 'CodigoInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 0
      Width = 28
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 161
      Top = 33
      DescriptionLabel = Label4
      DataBinding.DataField = 'CodigoFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 1
      Width = 28
    end
    object Label1: TcxLabel
      Left = 12
      Top = 9
      TabStop = False
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 219
      Top = 9
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 282
      Height = 19
      Width = 285
    end
    object Label4: TcxLabel
      Left = 219
      Top = 36
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 282
      Height = 19
      Width = 285
    end
    object cxDBCheckBox1: TcxDBCheckBox
      Left = 9
      Top = 61
      AutoSize = False
      Caption = 'Mostrar todos los datos'
      DataBinding.DataField = 'TodosLosDatos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 5
      Transparent = True
      Height = 25
      Width = 170
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 108
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 104
    ExplicitWidth = 463
    DesignSize = (
      523
      36)
    Height = 36
    Width = 523
    object Panel3: TcxGroupBox
      Left = 177
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 175
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
    Model = fmReportForm
    
    FirstDataControl = CodigoInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 419
    Top = 13
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_tra'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 325
    Top = 13
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 388
    Top = 13
    object DataCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
      Size = 2
    end
    object DataCodigoFinal: TWideStringField
      DisplayWidth = 2
      FieldName = 'CodigoFinal'
      Size = 2
    end
    object DataTodosLosDatos: TBooleanField
      FieldName = 'TodosLosDatos'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 355
    Top = 13
  end
end
