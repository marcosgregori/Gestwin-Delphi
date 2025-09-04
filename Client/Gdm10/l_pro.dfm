object RptProForm: TRptProForm
  Left = 462
  Top = 263
  HelpType = htKeyword
  HelpKeyword = 'l_pra'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de proveedores'
  ClientHeight = 291
  ClientWidth = 607
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
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
      597
      250)
    Height = 250
    Width = 597
    object OrdenarCtrl: TcxDBCheckBox
      Left = 8
      Top = 166
      AutoSize = False
      Caption = '&Ordenar alfab'#233'ticamente'
      DataBinding.DataField = 'Ordenar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 1
      Transparent = True
      Height = 25
      Width = 187
    end
    object TodosLosDatosCtrl: TcxDBCheckBox
      Left = 8
      Top = 189
      AutoSize = False
      Caption = '&Todos los datos de la ficha'
      DataBinding.DataField = 'TodosLosDatos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 2
      Transparent = True
      Height = 25
      Width = 187
    end
    object PageControl: TcxPageControl
      Left = 4
      Top = 28
      Width = 590
      Height = 127
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 123
      ClientRectLeft = 4
      ClientRectRight = 586
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = 'C&'#243'digo de proveedor'
        DesignSize = (
          582
          95)
        object gxRangeBox2: TgxRangeBox
          Left = 150
          Top = 14
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ProveedorInicialCtrl: TcxDBTextEdit
          Left = 168
          Top = 8
          DescriptionLabel = Label2
          DataBinding.DataField = 'ProveedorInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = ProveedorCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object ProveedorFinalCtrl: TcxDBTextEdit
          Left = 168
          Top = 35
          DescriptionLabel = Label6
          DataBinding.DataField = 'ProveedorFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = ProveedorCtrlPropertiesValidate
          TabOrder = 1
          Width = 46
        end
        object Label5: TcxLabel
          Left = 6
          Top = 11
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label2: TcxLabel
          Left = 240
          Top = 12
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 339
        end
        object Label6: TcxLabel
          Left = 240
          Top = 40
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 339
        end
      end
      object TabSheet3: TcxTabSheet
        Caption = 'C'#243'digo &postal'
        ImageIndex = 2
        DesignSize = (
          582
          95)
        object gxRangeBox4: TgxRangeBox
          Left = 151
          Top = 40
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object CodigoPostalInicialCtrl: TcxDBTextEdit
          Left = 196
          Top = 33
          DescriptionLabel = Label13
          DataBinding.DataField = 'CodigoPostalInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoPostalInicialCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = CodigoPostalInicialCtrlPropertiesValidate
          TabOrder = 2
          Width = 33
        end
        object CodigoPostalFinalCtrl: TcxDBTextEdit
          Left = 196
          Top = 60
          DescriptionLabel = Label14
          DataBinding.DataField = 'CodigoPostalFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoPostalFinalCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = CodigoPostalFinalCtrlPropertiesValidate
          TabOrder = 4
          Width = 33
        end
        object ProvinciaInicialCtrl: TcxDBTextEdit
          Left = 169
          Top = 33
          DescriptionLabel = Label13
          DataBinding.DataField = 'ProvinciaInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProvinciaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnEditValueChanged = ProvinciaInicialCtrlPropertiesEditValueChanged
          Properties.OnValidate = ProvinciaCtrlPropertiesValidate
          TabOrder = 1
          Width = 25
        end
        object ProvinciaFinalCtrl: TcxDBTextEdit
          Left = 169
          Top = 60
          DescriptionLabel = Label14
          DataBinding.DataField = 'ProvinciaFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ProvinciaCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnEditValueChanged = ProvinciaFinalCtrlPropertiesEditValueChanged
          Properties.OnValidate = ProvinciaCtrlPropertiesValidate
          TabOrder = 3
          Width = 25
        end
        object CodigoPaisCtrl: TcxDBTextEdit
          Left = 169
          Top = 6
          DescriptionLabel = Label10
          DataBinding.DataField = 'CodigoPais'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoPaisCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = CodigoPaisCtrlPropertiesValidate
          TabOrder = 0
          Width = 32
        end
        object Label1: TcxLabel
          Left = 5
          Top = 36
          Caption = 'C'#243'digo postal'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label9: TcxLabel
          Left = 5
          Top = 9
          Caption = 'C'#243'digo pais'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label10: TcxLabel
          Left = 242
          Top = 9
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 334
        end
        object Label13: TcxLabel
          Left = 242
          Top = 37
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 334
        end
        object Label14: TcxLabel
          Left = 242
          Top = 63
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 334
        end
      end
    end
    object Label4: TcxLabel
      Left = 8
      Top = 4
      Caption = 'Seleccionar y agrupar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object IncluirObsoletosCtrl: TcxDBCheckBox
      Left = 8
      Top = 212
      AutoSize = False
      Caption = '&Incluir obsoletos'
      DataBinding.DataField = 'IncluirObsoletos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 4
      Transparent = True
      Height = 25
      Width = 187
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 255
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      607
      36)
    Height = 36
    Width = 607
    object Panel3: TcxGroupBox
      Left = 218
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
    FirstDataControl = ProveedorInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 442
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 413
    Top = 10
    object DataProveedorInicial: TWideStringField
      FieldName = 'ProveedorInicial'
      Size = 5
    end
    object DataProveedorFinal: TWideStringField
      FieldName = 'ProveedorFinal'
      Size = 5
    end
    object DataOrdenar: TBooleanField
      FieldName = 'Ordenar'
    end
    object DataTodosLosDatos: TBooleanField
      FieldName = 'TodosLosDatos'
    end
    object DataCodigoPostalInicial: TWideStringField
      FieldName = 'CodigoPostalInicial'
      Size = 3
    end
    object DataCodigoPostalFinal: TWideStringField
      FieldName = 'CodigoPostalFinal'
      Size = 3
    end
    object DataProvinciaInicial: TWideStringField
      FieldName = 'ProvinciaInicial'
      Size = 2
    end
    object DataProvinciaFinal: TWideStringField
      FieldName = 'ProvinciaFinal'
      Size = 2
    end
    object DataCodigoPais: TWideStringField
      FieldName = 'CodigoPais'
      Size = 3
    end
    object DataIncluirObsoletos: TBooleanField
      FieldName = 'IncluirObsoletos'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 380
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_pro'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    AfterStart = ReportAfterStart
    Left = 346
    Top = 10
  end
end
