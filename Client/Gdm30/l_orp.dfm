object RptOrpForm: TRptOrpForm
  Left = 355
  Top = 257
  HelpType = htKeyword
  HelpKeyword = 'l_orp'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de organismos p'#250'blicos'
  ClientHeight = 164
  ClientWidth = 581
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
    ExplicitHeight = 118
    DesignSize = (
      571
      123)
    Height = 123
    Width = 571
    object gxRangeBox1: TgxRangeBox
      Left = 145
      Top = 42
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 163
      Top = 33
      DescriptionLabel = Label3
      DataBinding.DataField = 'CodigoInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = OrganismoPublicoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = OrganismoPublicoCtrlPropertiesValidate
      TabOrder = 1
      Width = 103
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 163
      Top = 60
      DescriptionLabel = Label2
      DataBinding.DataField = 'CodigoFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = OrganismoPublicoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = OrganismoPublicoCtrlPropertiesValidate
      TabOrder = 2
      Width = 103
    end
    object Label1: TcxLabel
      Left = 12
      Top = 36
      TabStop = False
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 262
      Top = 37
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
      Height = 15
      Width = 306
    end
    object Label2: TcxLabel
      Left = 262
      Top = 63
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
      Height = 15
      Width = 306
    end
    object cxLabel1: TcxLabel
      Left = 12
      Top = 5
      TabStop = False
      Caption = 'Tipo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
    end
    object TipoCtrl: TcxDBIndexedComboBox
      Left = 163
      Top = 6
      DataBinding.DataField = 'Tipo'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Oficina contable'
        #211'rgano gestor'
        'Unidad tramitadora'
        #211'rgano proponente')
      TabOrder = 0
      Width = 128
    end
    object OrdenarCtrl: TcxDBCheckBox
      Left = 9
      Top = 87
      AutoSize = False
      Caption = 'Ordenar alfab'#233'ticamente'
      DataBinding.DataField = 'Ordenar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 3
      Transparent = True
      Height = 26
      Width = 172
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 128
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 123
    DesignSize = (
      581
      36)
    Height = 36
    Width = 581
    object Panel3: TcxGroupBox
      Left = 206
      Top = 4
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
    FirstDataControl = CodigoInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 494
    Top = 14
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 465
    Top = 14
    object DataOrganismoPublicoInicial: TWideStringField
      DisplayWidth = 10
      FieldName = 'CodigoInicial'
      Size = 10
    end
    object DataOrganismoPublicoFinal: TWideStringField
      FieldName = 'CodigoFinal'
      Size = 10
    end
    object DataTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object DataOrdenar: TBooleanField
      FieldName = 'Ordenar'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 432
    Top = 14
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_orp'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 398
    Top = 15
  end
end
