object RptAovForm: TRptAovForm
  Left = 433
  Top = 249
  HelpType = htKeyword
  HelpKeyword = 'l_aov'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de art'#237'culos ordenado por ventas (A,B,C)'
  ClientHeight = 276
  ClientWidth = 517
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
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    DesignSize = (
      507
      235)
    Height = 235
    Width = 507
    object gxRangeBox1: TgxRangeBox
      Left = 100
      Top = 13
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 100
      Top = 68
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object ArticuloInicialCtrl: TcxDBTextEdit
      Left = 116
      Top = 5
      DescriptionLabel = Label4
      DataBinding.DataField = 'ArticuloInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 0
      Width = 86
    end
    object ArticuloFinalCtrl: TcxDBTextEdit
      Left = 116
      Top = 32
      DescriptionLabel = Label7
      DataBinding.DataField = 'ArticuloFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 1
      Width = 86
    end
    object MesInicialCtrl: TcxDBSpinEdit
      Left = 116
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
      Left = 116
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
      Left = 116
      Top = 113
      DataBinding.DataField = 'ImporteMinimo'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 10
      TabOrder = 4
      Width = 81
    end
    object ImporteMaximoCtrl: TcxDBCurrencyEdit
      Left = 116
      Top = 140
      DataBinding.DataField = 'ImporteMaximo'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 10
      TabOrder = 5
      Width = 81
    end
    object MostrarCtrl: TcxDBSpinEdit
      Left = 116
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
      Top = 9
      Caption = 'Articulo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 11
      Top = 63
      Caption = 'Mes'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 231
      Top = 63
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 269
    end
    object Label5: TcxLabel
      Left = 231
      Top = 89
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 269
    end
    object Label1: TcxLabel
      Left = 11
      Top = 116
      Caption = 'Importe m'#237'nimo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 11
      Top = 143
      Caption = 'Importe m'#225'ximo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 11
      Top = 170
      Caption = 'Mostrar solo los'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 203
      Top = 170
      Caption = 'primeros.'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 231
      Top = 9
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 269
    end
    object Label7: TcxLabel
      Left = 231
      Top = 35
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 269
    end
    object ComparativoCtrl: TcxDBCheckBox
      Left = 9
      Top = 196
      Hint = 
        'Muestra los importes del mismo periodo del ejercicio anterior y ' +
        'su aumento o disminuci'#243'n'
      AutoSize = False
      Caption = 'Comparativo'
      DataBinding.DataField = 'Comparativo'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = ComparativoCtrlPropertiesChange
      TabOrder = 17
      Transparent = True
      Height = 23
      Width = 124
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 240
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      517
      36)
    Height = 36
    Width = 517
    object Panel3: TcxGroupBox
      Left = 173
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
    FirstDataControl = ArticuloInicialCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 432
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_aov1'
    HideReportList = False
    SQLItems = <>
    ToPrinter = False
    OnSetReportName = ReportSetReportName
    Left = 340
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 401
    Top = 12
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
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
    object DataComparativo: TBooleanField
      FieldName = 'Comparativo'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 370
    Top = 12
  end
  object ArticuloDatEconTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ArticuloDatEcon'
    IndexFieldNames = 
      'Ejercicio;Codigo;CodigoClaseA;CodigoClaseB;CodigoClaseC;CodigoAl' +
      'macen'
    Left = 398
    Top = 44
  end
end
