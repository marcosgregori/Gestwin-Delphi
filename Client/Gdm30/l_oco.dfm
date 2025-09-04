object RptOcoForm: TRptOcoForm
  Left = 433
  Top = 249
  HelpType = htKeyword
  HelpKeyword = 'l_oco'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de proveedores ordenado por compras (A,B,C)'
  ClientHeight = 253
  ClientWidth = 611
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
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    ExplicitWidth = 506
    ExplicitHeight = 182
    DesignSize = (
      601
      212)
    Height = 212
    Width = 601
    object gxRangeBox1: TgxRangeBox
      Left = 98
      Top = 10
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 98
      Top = 68
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object ProveedorInicialCtrl: TcxDBTextEdit
      Left = 114
      Top = 5
      DescriptionLabel = Label4
      DataBinding.DataField = 'ProveedorInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = ProveedorCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object ProveedorFinalCtrl: TcxDBTextEdit
      Left = 114
      Top = 32
      DescriptionLabel = Label7
      DataBinding.DataField = 'ProveedorFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = ProveedorCtrlPropertiesValidate
      TabOrder = 1
      Width = 46
    end
    object MesInicialCtrl: TcxDBSpinEdit
      Left = 114
      Top = 59
      DescriptionLabel = Label2
      DataBinding.DataField = 'MesInicial'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.OnValidate = MesCtrlPropertiesValidate
      TabOrder = 2
      Width = 55
    end
    object MesFinalCtrl: TcxDBSpinEdit
      Left = 114
      Top = 86
      DescriptionLabel = Label5
      DataBinding.DataField = 'MesFinal'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.OnValidate = MesCtrlPropertiesValidate
      TabOrder = 3
      Width = 55
    end
    object ImporteMinimoCtrl: TcxDBCurrencyEdit
      Left = 114
      Top = 113
      DataBinding.DataField = 'ImporteMinimo'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 10
      TabOrder = 4
      Width = 81
    end
    object ImporteMaximoCtrl: TcxDBCurrencyEdit
      Left = 114
      Top = 140
      DataBinding.DataField = 'ImporteMaximo'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 10
      TabOrder = 5
      Width = 81
    end
    object MostrarCtrl: TcxDBSpinEdit
      Left = 114
      Top = 167
      DataBinding.DataField = 'Mostrar'
      DataBinding.DataSource = DataSource
      Properties.MaxValue = 99999.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 6
      Width = 81
    end
    object Label3: TcxLabel
      Left = 11
      Top = 8
      TabStop = False
      Caption = 'Proveedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 11
      Top = 62
      TabStop = False
      Caption = 'Mes'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 209
      Top = 62
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 385
    end
    object Label5: TcxLabel
      Left = 209
      Top = 89
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 385
    end
    object Label1: TcxLabel
      Left = 11
      Top = 117
      TabStop = False
      Caption = 'Importe m'#237'nimo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 11
      Top = 144
      TabStop = False
      Caption = 'Importe m'#225'ximo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 11
      Top = 171
      TabStop = False
      Caption = 'Mostrar solo los'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 209
      Top = 170
      TabStop = False
      Caption = 'primeros.'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 209
      Top = 8
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 385
    end
    object Label7: TcxLabel
      Left = 209
      Top = 35
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 385
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 217
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 187
    ExplicitWidth = 516
    DesignSize = (
      611
      36)
    Height = 36
    Width = 611
    object Panel3: TcxGroupBox
      Left = 220
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
    Model = fmReportForm
    
    FirstDataControl = ProveedorInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 432
    Top = 12
  end
  object ProveedorDatEconTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 15000
    TableName = 'ProveedorDatEcon'
    IndexFieldNames = 'Ejercicio;Codigo'
    Left = 310
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_oco'
    HideReportList = False
    SQLItems = <>
    ToPrinter = False
    Left = 340
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 401
    Top = 12
    object DataProveedorInicial: TWideStringField
      FieldName = 'ProveedorInicial'
      Size = 5
    end
    object DataProveedorFinal: TWideStringField
      FieldName = 'ProveedorFinal'
      Size = 5
    end
    object DataMesInicial: TSmallintField
      FieldName = 'MesInicial'
    end
    object DataMesFinal: TSmallintField
      FieldName = 'MesFinal'
    end
    object DataImporteMinimo: TBCDField
      FieldName = 'ImporteMinimo'
    end
    object DataImporteMaximo: TBCDField
      FieldName = 'ImporteMaximo'
    end
    object DataMostrar: TIntegerField
      FieldName = 'Mostrar'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 370
    Top = 12
  end
end
