object RptVenForm: TRptVenForm
  Left = 355
  Top = 257
  HelpType = htKeyword
  HelpKeyword = 'l_ven'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de vendedores'
  ClientHeight = 187
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
    ExplicitTop = 7
    ExplicitWidth = 479
    ExplicitHeight = 149
    DesignSize = (
      513
      146)
    Height = 146
    Width = 513
    object gxRangeBox1: TgxRangeBox
      Left = 154
      Top = 17
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object VendedorInicialCtrl: TcxDBTextEdit
      Left = 171
      Top = 8
      DescriptionLabel = Label3
      DataBinding.DataField = 'VendedorInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = VendedorCtrlPropertiesValidate
      TabOrder = 0
      Width = 28
    end
    object VendedorFinalCtrl: TcxDBTextEdit
      Left = 171
      Top = 35
      DescriptionLabel = Label2
      DataBinding.DataField = 'VendedorFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = VendedorCtrlPropertiesValidate
      TabOrder = 1
      Width = 28
    end
    object OrdenarCtrl: TcxDBCheckBox
      Left = 9
      Top = 63
      AutoSize = False
      Caption = 'Ordenar alfab'#233'ticamente'
      DataBinding.DataField = 'Ordenar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 2
      Transparent = True
      Height = 25
      Width = 179
    end
    object MostrarComisionesCtrl: TcxDBCheckBox
      Left = 9
      Top = 85
      AutoSize = False
      Caption = 'Mostrar comisiones'
      DataBinding.DataField = 'MostrarComisiones'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 3
      Transparent = True
      Height = 25
      Width = 179
    end
    object cxDBCheckBox1: TcxDBCheckBox
      Left = 9
      Top = 108
      AutoSize = False
      Caption = 'Mostrar todos los datos'
      DataBinding.DataField = 'TodosLosDatos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 4
      Transparent = True
      Height = 25
      Width = 179
    end
    object Label1: TcxLabel
      Left = 12
      Top = 11
      TabStop = False
      Caption = 'Vendedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 216
      Top = 11
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 274
      Height = 19
      Width = 308
    end
    object Label2: TcxLabel
      Left = 216
      Top = 38
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 274
      Height = 19
      Width = 308
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 151
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 125
    ExplicitWidth = 468
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
    
    FirstDataControl = VendedorInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 376
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 347
    Top = 10
    object DataVendedorInicial: TWideStringField
      FieldName = 'VendedorInicial'
      Size = 2
    end
    object DataVendedorFinal: TWideStringField
      FieldName = 'VendedorFinal'
      Size = 2
    end
    object DataOrdenar: TBooleanField
      FieldName = 'Ordenar'
    end
    object DataMostrarComisiones: TBooleanField
      FieldName = 'MostrarComisiones'
    end
    object DataTodosLosDatos: TBooleanField
      FieldName = 'TodosLosDatos'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 314
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_ven'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 280
    Top = 11
  end
end
