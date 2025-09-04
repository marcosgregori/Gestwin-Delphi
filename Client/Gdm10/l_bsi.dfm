object RptBsiForm: TRptBsiForm
  Left = 366
  Top = 246
  HelpType = htKeyword
  HelpKeyword = 'l_bsi'
  HelpContext = 1121
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Balance de situaci'#243'n'
  ClientHeight = 224
  ClientWidth = 489
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
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
      479
      183)
    Height = 183
    Width = 479
    object gxRangeBox1: TgxRangeBox
      Left = 143
      Top = 10
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object ModeloAbreviadoCtrl: TcxDBCheckBox
      Left = 10
      Top = 60
      AutoSize = False
      Caption = '&Modelo abreviado'
      DataBinding.DataField = 'ModeloAbreviado'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 2
      Transparent = True
      Height = 25
      Width = 169
    end
    object PeriodoInicialCtrl: TcxDBSpinEdit
      Left = 161
      Top = 4
      DescriptionLabel = Label3
      DataBinding.DataField = 'PeriodoInicial'
      DataBinding.DataSource = DataSource
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 14.000000000000000000
      Properties.OnValidate = PeriodoCtrlPropertiesValidate
      TabOrder = 0
      Width = 48
    end
    object PeriodoFinalCtrl: TcxDBSpinEdit
      Left = 161
      Top = 31
      DescriptionLabel = Label2
      DataBinding.DataField = 'PeriodoFinal'
      DataBinding.DataSource = DataSource
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 14.000000000000000000
      Properties.OnValidate = PeriodoCtrlPropertiesValidate
      TabOrder = 1
      Width = 48
    end
    object SaldosFinalesCtrl: TcxDBCheckBox
      Left = 33
      Top = 101
      AutoSize = False
      Caption = '&Saldos finales en el ejercicio anterior'
      DataBinding.DataField = 'SaldosFinales'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 4
      Transparent = True
      Height = 52
      Width = 146
    end
    object DesglosarCtrl: TcxDBCheckBox
      Left = 10
      Top = 144
      AutoSize = False
      Caption = 'Desglosar cuentas'
      DataBinding.DataField = 'Desglosar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 5
      Transparent = True
      Height = 25
      Width = 169
    end
    object BalanceComparativoCtrl: TcxDBCheckBox
      Left = 10
      Top = 83
      AutoSize = False
      Caption = 'Balance comparativo'
      DataBinding.DataField = 'Comparativo'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = BalanceComparativoCtrlPropertiesEditValueChanged
      TabOrder = 3
      Transparent = True
      Height = 25
      Width = 169
    end
    object Label4: TcxLabel
      Left = 14
      Top = 8
      Caption = 'Periodo (Mes)'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 217
      Top = 7
      Anchors = [akLeft]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 142
    end
    object Label2: TcxLabel
      Left = 217
      Top = 32
      Anchors = [akLeft]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 142
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 188
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      489
      36)
    Height = 36
    Width = 489
    object Panel3: TcxGroupBox
      Left = 158
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
    FirstDataControl = PeriodoInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 346
    Top = 62
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_bsi'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    BeforeStart = ReportBeforeStart
    Left = 318
    Top = 92
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 316
    Top = 62
    object DataPeriodoInicial: TSmallintField
      FieldName = 'PeriodoInicial'
    end
    object DataPeriodoFinal: TSmallintField
      FieldName = 'PeriodoFinal'
    end
    object DataSaldosFinales: TBooleanField
      FieldName = 'SaldosFinales'
    end
    object DataModeloAbreviado: TBooleanField
      FieldName = 'ModeloAbreviado'
    end
    object DataDesglosar: TBooleanField
      FieldName = 'Desglosar'
    end
    object DataComparativo: TBooleanField
      FieldName = 'Comparativo'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 285
    Top = 62
  end
end
