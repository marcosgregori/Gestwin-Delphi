object RptFeiForm: TRptFeiForm
  Left = 421
  Top = 278
  HelpType = htKeyword
  HelpKeyword = 'l_fei'
  HelpContext = 4103
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Fichas de elementos del inmovilizado'
  ClientHeight = 238
  ClientWidth = 503
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
    DesignSize = (
      493
      197)
    Height = 197
    Width = 493
    object PageControl: TcxPageControl
      Left = 8
      Top = 28
      Width = 478
      Height = 97
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 93
      ClientRectLeft = 4
      ClientRectRight = 474
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = '&Elemento'
        DesignSize = (
          470
          65)
        object gxRangeBox1: TgxRangeBox
          Left = 89
          Top = 13
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object CodigoInicialCtrl: TcxDBTextEdit
          Left = 104
          Top = 6
          DescriptionLabel = Label2
          DataBinding.DataField = 'CodigoInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightZero
          Properties.PadAlways = True
          Properties.OnValidate = CodigoCtrlPropertiesValidate
          TabOrder = 0
          Width = 74
        end
        object CodigoFinalCtrl: TcxDBTextEdit
          Left = 104
          Top = 33
          DescriptionLabel = Label8
          DataBinding.DataField = 'CodigoFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightHighest
          Properties.PadAlways = True
          Properties.OnValidate = CodigoCtrlPropertiesValidate
          TabOrder = 1
          Width = 74
        end
        object Label1: TcxLabel
          Left = 9
          Top = 10
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object Label2: TcxLabel
          Left = 199
          Top = 10
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
          Height = 19
          Width = 272
        end
        object Label8: TcxLabel
          Left = 199
          Top = 36
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
          Height = 19
          Width = 272
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = '&Proveedor'
        ExplicitLeft = 0
        ExplicitWidth = 478
        ExplicitHeight = 69
        DesignSize = (
          470
          65)
        object gxRangeBox2: TgxRangeBox
          Left = 89
          Top = 13
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ProveedorInicialCtrl: TcxDBTextEdit
          Left = 104
          Top = 6
          DescriptionLabel = Label9
          DataBinding.DataField = 'ProveedorInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightZero
          Properties.PadAlways = True
          Properties.OnValidate = ProveedorCtrlPropertiesValidate
          TabOrder = 0
          Width = 74
        end
        object ProveedorFinalCtrl: TcxDBTextEdit
          Left = 104
          Top = 33
          DescriptionLabel = Label5
          DataBinding.DataField = 'ProveedorFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpRightHighest
          Properties.PadAlways = True
          Properties.OnValidate = ProveedorCtrlPropertiesValidate
          TabOrder = 1
          Width = 74
        end
        object Label4: TcxLabel
          Left = 9
          Top = 10
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
        object Label5: TcxLabel
          Left = 199
          Top = 36
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 3
          Transparent = True
          ExplicitWidth = 275
          Height = 19
          Width = 267
        end
        object Label9: TcxLabel
          Left = 199
          Top = 10
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 4
          Transparent = True
          ExplicitWidth = 275
          Height = 19
          Width = 267
        end
      end
      object TabSheet3: TcxTabSheet
        Caption = '&Fecha de compra'
        ExplicitLeft = 0
        ExplicitWidth = 478
        ExplicitHeight = 69
        object gxRangeBox3: TgxRangeBox
          Left = 89
          Top = 13
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FechaInicialCtrl: TcxDBDateEdit
          Left = 104
          Top = 6
          DataBinding.DataField = 'FechaInicial'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 0
          Width = 90
        end
        object FechaFinalCtrl: TcxDBDateEdit
          Left = 104
          Top = 33
          DataBinding.DataField = 'FechaFinal'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 1
          Width = 90
        end
        object Label6: TcxLabel
          Left = 9
          Top = 9
          Caption = 'Fecha'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
      end
    end
    object UnaPorHojaCtrl: TcxDBCheckBox
      Left = 14
      Top = 135
      AutoSize = False
      Caption = ' Una ficha por hoja'
      DataBinding.DataField = 'UnaPorHoja'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 1
      Transparent = True
      Height = 21
      Width = 157
    end
    object SimulacionCtrl: TcxDBCheckBox
      Left = 14
      Top = 159
      AutoSize = False
      Caption = ' Simular amortizaci'#243'n completa'
      DataBinding.DataField = 'Simulacion'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taLeftJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 2
      Transparent = True
      Height = 21
      Width = 214
    end
    object Label3: TcxLabel
      Left = 14
      Top = 7
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 202
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      503
      36)
    Height = 36
    Width = 503
    object Panel3: TcxGroupBox
      Left = 165
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
    FirstDataControl = CodigoInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 424
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 423
    Top = 80
    object DataCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
      Size = 9
    end
    object DataCodigoFinal: TWideStringField
      DisplayWidth = 2
      FieldName = 'CodigoFinal'
      Size = 9
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataProveedorInicial: TWideStringField
      FieldName = 'ProveedorInicial'
      Size = 9
    end
    object DataProveedorFinal: TWideStringField
      FieldName = 'ProveedorFinal'
      Size = 9
    end
    object DataUnaPorHoja: TBooleanField
      FieldName = 'UnaPorHoja'
    end
    object DataSimulacion: TBooleanField
      FieldName = 'Simulacion'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 392
    Top = 80
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_fei'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 360
    Top = 80
  end
  object InmovilizadoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Inmovilizado'
    IndexFieldNames = 'Codigo'
    Left = 422
    Top = 48
  end
  object LineaInmovilizadoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaInmovilizado'
    IndexFieldNames = 'Codigo;NroRegistro'
    Left = 390
    Top = 48
  end
end
