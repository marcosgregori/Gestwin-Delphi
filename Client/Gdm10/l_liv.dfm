object rptLivForm: TrptLivForm
  Left = 409
  Top = 279
  HelpType = htKeyword
  HelpKeyword = 'l_liv'
  HelpContext = 2120
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Liquidaci'#243'n del I.V.A.'
  ClientHeight = 199
  ClientWidth = 387
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
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
    Height = 158
    Width = 377
    object gxRangeBox1: TgxRangeBox
      Left = 84
      Top = 92
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 100
      Top = 84
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnEditValueChanged = FechaInicialCtrlPropertiesEditValueChanged
      TabOrder = 2
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 100
      Top = 111
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 3
      Width = 100
    end
    object PeriodoCtrl: TcxDBIndexedComboBox
      Left = 100
      Top = 57
      DataBinding.DataField = 'Periodo'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        '<Definido por el usuario>'
        'Primer trimestre'
        'Segundo trimestre'
        'Tercer trimestre'
        'Cuarto trimestre')
      Properties.OnChange = PeriodoCtrlPropertiesChange
      TabOrder = 1
      Width = 179
    end
    object PeriodicidadCtrl: TcxDBRadioGroup
      Left = 92
      Top = 6
      Alignment = alCenterCenter
      DataBinding.DataField = 'Periodicidad'
      DataBinding.DataSource = DataSource
      Properties.Items = <
        item
          Caption = 'mensual'
          Value = 0
        end
        item
          Caption = 'trimestral'
          Value = 1
        end>
      Properties.OnChange = PeriodicidadCtrlPropertiesChange
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 49
      Width = 185
    end
    object Label4: TcxLabel
      Left = 10
      Top = 88
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
    object PeriodoLabel: TcxLabel
      Left = 10
      Top = 61
      TabStop = False
      Caption = 'Per'#237'odo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 10
      Top = 9
      TabStop = False
      Caption = 'Periodicidad'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 163
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      387
      36)
    Height = 36
    Width = 387
    object Panel3: TcxGroupBox
      Left = 108
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
    FirstDataControl = PeriodicidadCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 314
    Top = 10
  end
  object ApunteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 314
    Top = 40
  end
  object AsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Fecha'
    Left = 282
    Top = 40
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_liv'
    HideReportList = False
    SQLItems = <>
    ToPrinter = False
    Left = 250
    Top = 40
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 283
    Top = 10
    object DataPeriodicidad: TSmallintField
      FieldName = 'Periodicidad'
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataPeriodo: TSmallintField
      FieldName = 'Periodo'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 250
    Top = 10
  end
  object SQLQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    ReadOnly = True
    Left = 314
    Top = 71
  end
end
