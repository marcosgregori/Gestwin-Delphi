object rptBssForm: TrptBssForm
  Left = 574
  Top = 450
  HelpType = htKeyword
  HelpKeyword = 'l_bss'
  HelpContext = 1119
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Balance de comprobaci'#243'n de sumas y saldos'
  ClientHeight = 242
  ClientWidth = 615
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
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
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    DesignSize = (
      605
      201)
    Height = 201
    Width = 605
    object gxRangeBox1: TgxRangeBox
      Left = 155
      Top = 13
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object SaldosInicialesCtrl: TcxDBCheckBox
      Left = 10
      Top = 138
      AutoSize = False
      Caption = '&Incluir saldos de apertura'
      DataBinding.DataField = 'SaldosIniciales'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 5
      Transparent = True
      Height = 21
      Width = 178
    end
    object ExcluirSaldoCeroCtrl: TcxDBCheckBox
      Left = 10
      Top = 161
      AutoSize = False
      Caption = '&Excluir saldos nulos'
      DataBinding.DataField = 'ExcluirSaldosNulos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 6
      Transparent = True
      Height = 21
      Width = 178
    end
    object PeriodoCtrl: TcxDBSpinEdit
      Left = 171
      Top = 111
      DescriptionLabel = Label6
      DataBinding.DataField = 'Periodo'
      DataBinding.DataSource = DataSource
      Properties.OnValuePosted = PeriodoCtrlPropertiesValuePosted
      Properties.AssignedValues.MinValue = True
      Properties.ImmediatePost = True
      Properties.MaxValue = 14.000000000000000000
      Properties.OnValidate = PeriodoCtrlPropertiesValidate
      TabOrder = 4
      Width = 42
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 171
      Top = 6
      DescriptionLabel = Label7
      DataBinding.DataField = 'CodigoInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpMiddleZero
      Properties.OnEditValueChanged = CodigoInicialCtrlPropertiesEditValueChanged
      Properties.OnValidate = CodigoInicialCtrlPropertiesValidate
      TabOrder = 0
      Width = 74
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 171
      Top = 33
      DescriptionLabel = Label9
      DataBinding.DataField = 'CodigoFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpMiddleZero
      Properties.OnValidate = CodigoFinalCtrlPropertiesValidate
      TabOrder = 1
      Width = 74
    end
    object SeleccionCentroCosteCtrl: TcxDBRadioGroup
      Left = 171
      Top = 60
      Alignment = alCenterCenter
      DataBinding.DataField = 'SeleccionCentroCoste'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Todos'
          Value = 0
        end
        item
          Caption = 'Solo el ...'
          Value = 1
        end>
      Properties.OnChange = SeleccionCentroCosteCtrlPropertiesChange
      TabOrder = 2
      Height = 48
      Width = 132
    end
    object CentroCosteCtrl: TcxDBTextEdit
      Left = 256
      Top = 80
      DescriptionLabel = descCentroCosteLabel
      DataBinding.DataField = 'CentroCoste'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CentroCosteCtrlPropertiesQueryRequest
      Properties.OnValidate = CentroCosteCtrlPropertiesValidate
      TabOrder = 3
      Width = 40
    end
    object Label5: TcxLabel
      Left = 14
      Top = 114
      Caption = 'Periodo (mes)'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 321
      Top = 114
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 278
    end
    object Label3: TcxLabel
      Left = 14
      Top = 9
      Caption = 'C'#243'digo de cuenta'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 14
      Top = 60
      Caption = 'Centros de coste'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 321
      Top = 9
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 278
    end
    object Label9: TcxLabel
      Left = 321
      Top = 36
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 278
    end
    object descCentroCosteLabel: TcxLabel
      Left = 321
      Top = 83
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 278
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 206
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 190
    DesignSize = (
      615
      36)
    Height = 36
    Width = 615
    object Panel3: TcxGroupBox
      Left = 222
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 172
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
    Left = 472
    Top = 12
  end
  object report: TgxReportManager
    FileName = 'dm10\l_bss'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    BeforeStart = reportBeforeStart
    Left = 374
    Top = 14
  end
  object SaldosTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Saldos'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    Left = 472
    Top = 44
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 441
    Top = 14
    object DataCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
      Size = 9
    end
    object DataCodigoFinal: TWideStringField
      DisplayWidth = 9
      FieldName = 'CodigoFinal'
      Size = 9
    end
    object DataSeleccionCentroCoste: TSmallintField
      FieldName = 'SeleccionCentroCoste'
    end
    object DataCentroCoste: TWideStringField
      FieldName = 'CentroCoste'
      Size = 4
    end
    object DataPeriodo: TSmallintField
      FieldName = 'Periodo'
    end
    object DataSaldosIniciales: TBooleanField
      FieldName = 'SaldosIniciales'
    end
    object DataExcluirSaldosNulos: TBooleanField
      FieldName = 'ExcluirSaldosNulos'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 408
    Top = 14
  end
end
