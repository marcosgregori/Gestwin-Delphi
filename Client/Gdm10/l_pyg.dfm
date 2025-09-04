object RptPygForm: TRptPygForm
  Left = 445
  Top = 398
  HelpType = htKeyword
  HelpKeyword = 'l_pyg'
  HelpContext = 1120
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Cuenta de p'#233'rdidas y ganancias'
  ClientHeight = 270
  ClientWidth = 534
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
      524
      229)
    Height = 229
    Width = 524
    object gxRangeBox1: TgxRangeBox
      Left = 128
      Top = 9
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object SeleccionCentroCosteCtrl: TcxDBRadioGroup
      Left = 144
      Top = 59
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
      Height = 50
      Width = 131
    end
    object ModeloAbreviadoCtrl: TcxDBCheckBox
      Left = 9
      Top = 109
      AutoSize = False
      Caption = '&Modelo abreviado'
      DataBinding.DataField = 'ModeloAbreviado'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 4
      Transparent = True
      Height = 21
      Width = 152
    end
    object PeriodoInicialCtrl: TcxDBSpinEdit
      Left = 144
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
      Width = 52
    end
    object PeriodoFinalCtrl: TcxDBSpinEdit
      Left = 144
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
      Width = 52
    end
    object SaldosFinalesCtrl: TcxDBCheckBox
      Left = 21
      Top = 154
      AutoSize = False
      Caption = '&Saldos finales en el ejercicio anterior'
      DataBinding.DataField = 'SaldosFinales'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Properties.UseAlignmentWhenInplace = True
      TabOrder = 6
      Transparent = True
      Height = 36
      Width = 141
    end
    object DesglosarCtrl: TcxDBCheckBox
      Left = 8
      Top = 190
      AutoSize = False
      Caption = 'Desglosar cuentas'
      DataBinding.DataField = 'Desglosar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 7
      Transparent = True
      Height = 21
      Width = 154
    end
    object ComparativoCtrl: TcxDBCheckBox
      Left = 8
      Top = 133
      AutoSize = False
      Caption = 'Balance comparativo'
      DataBinding.DataField = 'Comparativo'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = ComparativoCtrlPropertiesEditValueChanged
      TabOrder = 5
      Transparent = True
      Height = 21
      Width = 153
    end
    object CentroCosteCtrl: TcxDBTextEdit
      Left = 229
      Top = 78
      DescriptionLabel = descCentroCosteLabel
      DataBinding.DataField = 'CentroCoste'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CentroCosteCtrlPropertiesQueryRequest
      Properties.OnValidate = CentroCosteCtrlPropertiesValidate
      TabOrder = 3
      Width = 40
    end
    object Label8: TcxLabel
      Left = 12
      Top = 63
      Caption = 'Centros de coste'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 12
      Top = 8
      Caption = 'Periodo (Mes)'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 285
      Top = 8
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 232
    end
    object Label2: TcxLabel
      Left = 285
      Top = 34
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 232
    end
    object descCentroCosteLabel: TcxLabel
      Left = 285
      Top = 81
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 232
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 234
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      534
      36)
    Height = 36
    Width = 534
    object Panel3: TcxGroupBox
      Left = 181
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
    Left = 458
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_pyg'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 368
    Top = 12
  end
  object ExistenciaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Existencia'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    Left = 460
    Top = 42
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 428
    Top = 12
    object DataPeriodoInicial: TSmallintField
      FieldName = 'PeriodoInicial'
    end
    object DataPeriodoFinal: TSmallintField
      FieldName = 'PeriodoFinal'
    end
    object DataSeleccionCentroCoste: TSmallintField
      FieldName = 'SeleccionCentroCoste'
    end
    object DataCentroCoste: TWideStringField
      FieldName = 'CentroCoste'
      Size = 4
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
    Left = 397
    Top = 12
  end
end
