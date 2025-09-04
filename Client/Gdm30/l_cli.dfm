object RptCliForm: TRptCliForm
  Left = 462
  Top = 263
  HelpType = htKeyword
  HelpKeyword = 'l_cli'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de clientes'
  ClientHeight = 291
  ClientWidth = 614
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
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
      604
      250)
    Height = 250
    Width = 604
    object OrdenarCtrl: TcxDBCheckBox
      Left = 9
      Top = 161
      AutoSize = False
      Caption = '&Ordenar alfab'#233'ticamente'
      DataBinding.DataField = 'Ordenar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 1
      Transparent = True
      Height = 23
      Width = 187
    end
    object TodosLosDatosCtrl: TcxDBCheckBox
      Left = 9
      Top = 183
      AutoSize = False
      Caption = '&Todos los datos de la ficha'
      DataBinding.DataField = 'TodosLosDatos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 2
      Transparent = True
      Height = 28
      Width = 187
    end
    object PageControl: TcxPageControl
      Left = 4
      Top = 29
      Width = 597
      Height = 126
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 122
      ClientRectLeft = 4
      ClientRectRight = 593
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = 'C&'#243'digo de cliente'
        DesignSize = (
          589
          94)
        object gxRangeBox2: TgxRangeBox
          Left = 151
          Top = 17
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object ClienteInicialCtrl: TcxDBTextEdit
          Left = 169
          Top = 8
          DescriptionLabel = Label2
          DataBinding.DataField = 'ClienteInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.PadAlways = True
          Properties.OnValidate = ClienteCtrlPropertiesValidate
          TabOrder = 0
          Width = 46
        end
        object ClienteFinalCtrl: TcxDBTextEdit
          Left = 169
          Top = 35
          DescriptionLabel = Label6
          DataBinding.DataField = 'ClienteFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = ClienteCtrlPropertiesValidate
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
          Left = 241
          Top = 11
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 342
        end
        object Label6: TcxLabel
          Left = 241
          Top = 38
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 342
        end
      end
      object GrupoClienteTabSheet: TcxTabSheet
        Caption = '&Grupo de cliente'
        DesignSize = (
          589
          94)
        object gxRangeBox1: TgxRangeBox
          Left = 152
          Top = 17
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object GrupoInicialCtrl: TcxDBTextEdit
          Left = 170
          Top = 8
          DescriptionLabel = Label8
          DataBinding.DataField = 'GrupoInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = GrupoCtrlPropertiesQueryRequest
          Properties.OnValidate = GrupoCtrlPropertiesValidate
          TabOrder = 0
          Width = 32
        end
        object GrupoFinalCtrl: TcxDBTextEdit
          Left = 170
          Top = 35
          DescriptionLabel = Label12
          DataBinding.DataField = 'GrupoFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = GrupoCtrlPropertiesQueryRequest
          Properties.OnValidate = GrupoCtrlPropertiesValidate
          TabOrder = 1
          Width = 32
        end
        object Label7: TcxLabel
          Left = 7
          Top = 11
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label8: TcxLabel
          Left = 243
          Top = 11
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 335
        end
        object Label12: TcxLabel
          Left = 243
          Top = 38
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 335
        end
      end
      object VendedorTabSheet: TcxTabSheet
        Caption = '&Vendedor'
        ImageIndex = 3
        DesignSize = (
          589
          94)
        object gxRangeBox3: TgxRangeBox
          Left = 151
          Top = 17
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object VendedorInicialCtrl: TcxDBTextEdit
          Left = 170
          Top = 8
          DescriptionLabel = Label15
          DataBinding.DataField = 'VendedorInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = VendedorCtrlPropertiesValidate
          TabOrder = 0
          Width = 25
        end
        object VendedorFinalCtrl: TcxDBTextEdit
          Left = 170
          Top = 35
          DescriptionLabel = Label16
          DataBinding.DataField = 'vendedorFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = VendedorCtrlPropertiesValidate
          TabOrder = 1
          Width = 25
        end
        object Label11: TcxLabel
          Left = 7
          Top = 11
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label15: TcxLabel
          Left = 241
          Top = 11
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 366
        end
        object Label16: TcxLabel
          Left = 241
          Top = 38
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 366
        end
      end
      object TabSheet3: TcxTabSheet
        Caption = 'C'#243'digo &postal'
        ImageIndex = 2
        DesignSize = (
          589
          94)
        object gxRangeBox4: TgxRangeBox
          Left = 153
          Top = 43
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object CodigoPostalInicialCtrl: TcxDBTextEdit
          Left = 198
          Top = 34
          DescriptionLabel = Label13
          DataBinding.DataField = 'CodigoPostalInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = CodigoPostalInicialCtrlPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = CodigoPostalCtrlPropertiesValidate
          TabOrder = 2
          Width = 33
        end
        object CodigoPostalFinalCtrl: TcxDBTextEdit
          Left = 198
          Top = 61
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
          Left = 171
          Top = 34
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
          Left = 171
          Top = 61
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
          Left = 171
          Top = 7
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
          Top = 37
          Caption = 'C'#243'digo postal'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label9: TcxLabel
          Left = 5
          Top = 10
          Caption = 'C'#243'digo pais'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label10: TcxLabel
          Left = 244
          Top = 10
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 340
        end
        object Label13: TcxLabel
          Left = 244
          Top = 37
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 340
        end
        object Label14: TcxLabel
          Left = 244
          Top = 64
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 340
        end
      end
      object cxTabSheet1: TcxTabSheet
        Caption = 'Forma de cobro'
        ImageIndex = 4
        DesignSize = (
          589
          94)
        object gxRangeBox5: TgxRangeBox
          Left = 151
          Top = 17
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FormaCobroInicialCtrl: TcxDBTextEdit
          Left = 170
          Top = 8
          DescriptionLabel = Label18
          DataBinding.DataField = 'FormaCobroInicial'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = FormaCobroPropertiesQueryRequest
          Properties.TextEditPad = tpLeftZero
          Properties.OnValidate = FormaCobroCtrlPropertiesValidate
          TabOrder = 0
          Width = 25
        end
        object FormaCobroFinalCtrl: TcxDBTextEdit
          Left = 170
          Top = 35
          DescriptionLabel = Label19
          DataBinding.DataField = 'FormaCobroFinal'
          DataBinding.DataSource = DataSource
          Properties.OnQueryRequest = FormaCobroPropertiesQueryRequest
          Properties.TextEditPad = tpLeftHighest
          Properties.PadAlways = True
          Properties.OnValidate = FormaCobroCtrlPropertiesValidate
          TabOrder = 1
          Width = 25
        end
        object Label17: TcxLabel
          Left = 7
          Top = 11
          Caption = 'C'#243'digo'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
        end
        object Label18: TcxLabel
          Left = 241
          Top = 11
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 345
        end
        object Label19: TcxLabel
          Left = 241
          Top = 38
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          Style.TextColor = clNavy
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          Transparent = True
          Height = 19
          Width = 345
        end
      end
    end
    object Label4: TcxLabel
      Left = 11
      Top = 6
      Caption = 'Seleccionar y agrupar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object IncluirObsoletosCtrl: TcxDBCheckBox
      Left = 8
      Top = 211
      AutoSize = False
      Caption = '&Incluir obsoletos'
      DataBinding.DataField = 'IncluirObsoletos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 4
      Transparent = True
      Height = 21
      Width = 188
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
      614
      36)
    Height = 36
    Width = 614
    object Panel3: TcxGroupBox
      Left = 222
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
    FirstDataControl = ClienteInicialCtrl
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
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataOrdenar: TBooleanField
      FieldName = 'Ordenar'
    end
    object DataTodosLosDatos: TBooleanField
      FieldName = 'TodosLosDatos'
    end
    object DataGrupoInicial: TWideStringField
      FieldName = 'GrupoInicial'
      Size = 3
    end
    object DataGrupoFinal: TWideStringField
      FieldName = 'GrupoFinal'
      Size = 3
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
    object DataVendedorInicial: TWideStringField
      FieldName = 'VendedorInicial'
      Size = 2
    end
    object DataVendedorFinal: TWideStringField
      FieldName = 'VendedorFinal'
      Size = 2
    end
    object DataCodigoPais: TWideStringField
      FieldName = 'CodigoPais'
      Size = 3
    end
    object DataFormaCobroInicial: TWideStringField
      FieldName = 'FormaCobroInicial'
      Size = 2
    end
    object DataFormaCobroFinal: TWideStringField
      FieldName = 'FormaCobroFinal'
      Size = 2
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
    FileName = 'dm30\l_cli'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 346
    Top = 12
  end
end
