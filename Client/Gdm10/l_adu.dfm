object RptAduForm: TRptAduForm
  Left = 437
  Top = 288
  HelpType = htKeyword
  HelpKeyword = 'l_adu'
  HelpContext = 3137
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Antig'#252'edad de las deudas de clientes'
  ClientHeight = 218
  ClientWidth = 566
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
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 182
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    DesignSize = (
      566
      36)
    Height = 36
    Width = 566
    object Panel3: TcxGroupBox
      Left = 196
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 123
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
    TabOrder = 1
    PanelKind = epInputPanel
    DesignSize = (
      556
      177)
    Height = 177
    Width = 556
    object gxRangeBox1: TgxRangeBox
      Left = 196
      Top = 13
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object VencimientoInicialCtrl: TcxDBDateEdit
      Left = 212
      Top = 7
      DataBinding.DataField = 'VencimientoInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 0
      Width = 100
    end
    object VencimientoFinalCtrl: TcxDBDateEdit
      Left = 212
      Top = 34
      DataBinding.DataField = 'VencimientoFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 100
    end
    object AgruparPorClienteCtrl: TcxDBCheckBox
      Left = 7
      Top = 138
      AutoSize = False
      Caption = 'Agrupar por cliente'
      DataBinding.DataField = 'AgruparPorCliente'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 3
      Transparent = True
      Height = 23
      Width = 221
    end
    object Label3: TcxLabel
      Left = 8
      Top = 10
      Caption = 'Vencimiento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxGroupBox1: TcxGroupBox
      Left = 3
      Top = 61
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Excluir los efectos'
      TabOrder = 2
      Height = 77
      Width = 550
      object ExcluirRevisadosCtrl: TcxDBCheckBox
        Left = 3
        Top = 17
        AutoSize = False
        Caption = 'Revisados'
        DataBinding.DataField = 'ExcluirRevisados'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        TabOrder = 0
        Transparent = True
        Height = 23
        Width = 222
      end
      object ExcluirAceptadosCtrl: TcxDBCheckBox
        Left = 3
        Top = 41
        AutoSize = False
        Caption = 'Inclu'#237'dos en remesas aceptadas'
        DataBinding.DataField = 'ExcluirAceptados'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        TabOrder = 1
        Transparent = True
        Height = 23
        Width = 222
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = VencimientoInicialCtrl
    Model = fmReportForm
    ShowQueryOption = True
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 328
    Top = 82
  end
  object report: TgxReportManager
    FileName = 'dm10\l_adu'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    BeforeStart = reportBeforeStart
    Left = 301
    Top = 112
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 299
    Top = 82
    object DataVencimientoInicial: TDateField
      FieldName = 'VencimientoInicial'
    end
    object DataVencimientoFinal: TDateField
      FieldName = 'VencimientoFinal'
    end
    object DataAgruparPorCliente: TBooleanField
      FieldName = 'AgruparPorCliente'
    end
    object DataExcluirRevisados: TBooleanField
      FieldName = 'ExcluirRevisados'
    end
    object DataExcluirAceptados: TBooleanField
      FieldName = 'ExcluirAceptados'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 266
    Top = 82
  end
end
