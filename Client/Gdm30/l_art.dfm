object RptArtForm: TRptArtForm
  Left = 540
  Top = 400
  HelpType = htKeyword
  HelpKeyword = 'l_art'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de art'#237'culos'
  ClientHeight = 399
  ClientWidth = 598
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
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
    Height = 358
    Width = 588
    object GroupBox1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        584
        319)
      Height = 319
      Width = 584
      object codigosBarrasLabel: TcxLabel
        Left = 203
        Top = 296
        Caption = '(incluye las anotaciones de la ficha)'
        Style.TextColor = clGray
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
      end
      object IncluirObsoletosCtrl: TcxDBCheckBox
        Left = 9
        Top = 266
        AutoSize = False
        Caption = '&Incluir art'#237'culos obsoletos'
        DataBinding.DataField = 'IncluirObsoletos'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 6
        Transparent = True
        Height = 21
        Width = 184
      end
      object IVAIncluidoCtrl: TcxDBCheckBox
        Left = 9
        Top = 215
        AutoSize = False
        Caption = '&Precios con I.V.A. incluido'
        DataBinding.DataField = 'IVAIncluido'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 4
        Transparent = True
        Height = 21
        Width = 184
      end
      object Label3: TcxLabel
        Left = 7
        Top = 3
        Caption = 'Seleccionar y agrupar por ...'
        Style.TextColor = clGreen
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
      end
      object Label6: TcxLabel
        Left = 13
        Top = 139
        Caption = 'Modelo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 10
        Transparent = True
      end
      object ModeloCtrl: TcxDBIndexedComboBox
        Left = 176
        Top = 134
        DataBinding.DataField = 'Modelo'
        DataBinding.DataSource = DataSource
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'Listado con los datos m'#225's representativos'
          'Fichas con todos los datos del art'#237'culo'
          'Lista de precios de compra'
          'Lista de precios de venta')
        Properties.OnChange = ModeloCtrlPropertiesChange
        TabOrder = 1
        Width = 271
      end
      object MostrarCodigosBarrasCtrl: TcxDBCheckBox
        Left = 9
        Top = 293
        AutoSize = False
        Caption = 'Mostrar c'#243'digos de barras'
        DataBinding.DataField = 'MostrarCodigosBarras'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 7
        Transparent = True
        Height = 21
        Width = 184
      end
      object MostrarDescuentosCtrl: TcxDBCheckBox
        Left = 9
        Top = 241
        AutoSize = False
        Caption = '&Mostrar descuentos'
        DataBinding.DataField = 'MostrarDescuentos'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 5
        Transparent = True
        Height = 21
        Width = 184
      end
      object NoValorarCtrl: TcxDBCheckBox
        Left = 9
        Top = 189
        AutoSize = False
        Caption = 'No &valorar'
        DataBinding.DataField = 'NoValorar'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Properties.OnEditValueChanged = NoValorarCtrlPropertiesEditValueChanged
        TabOrder = 3
        Transparent = True
        Height = 21
        Width = 184
      end
      object OrdenarCtrl: TcxDBCheckBox
        Left = 9
        Top = 165
        AutoSize = False
        Caption = '&Ordenar alfab'#233'ticamente'
        DataBinding.DataField = 'Ordenar'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 2
        Transparent = True
        Height = 21
        Width = 184
      end
      object PageControl: TcxPageControl
        Left = 3
        Top = 25
        Width = 581
        Height = 103
        Anchors = [akLeft, akTop, akRight]
        Focusable = False
        TabOrder = 0
        Properties.ActivePage = TabSheet1
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 99
        ClientRectLeft = 4
        ClientRectRight = 577
        ClientRectTop = 28
        object TabSheet1: TcxTabSheet
          Caption = 'A&rt'#237'culo'
          DesignSize = (
            573
            71)
          object gxRangeBox1: TgxRangeBox
            Left = 152
            Top = 15
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object CodigoArticuloInicialCtrl: TcxDBTextEdit
            Left = 167
            Top = 7
            DescriptionLabel = Label7
            DataBinding.DataField = 'CodigoArticuloInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
            Properties.ExpandZeroes = False
            Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
            TabOrder = 0
            Width = 102
          end
          object CodigoArticuloFinalCtrl: TcxDBTextEdit
            Left = 167
            Top = 34
            DescriptionLabel = Label8
            DataBinding.DataField = 'CodigoArticuloFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
            Properties.ExpandZeroes = False
            Properties.TextEditPad = tpRightHighest
            Properties.PadAlways = True
            Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
            TabOrder = 1
            Width = 102
          end
          object Label1: TcxLabel
            Left = 9
            Top = 11
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
          object Label7: TcxLabel
            Left = 280
            Top = 11
            DescriptionLabel = Label1
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
            Height = 19
            Width = 291
          end
          object Label8: TcxLabel
            Left = 280
            Top = 38
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
            Height = 19
            Width = 291
          end
        end
        object TabSheet2: TcxTabSheet
          Caption = '&Familia'
          DesignSize = (
            573
            71)
          object gxRangeBox2: TgxRangeBox
            Left = 152
            Top = 15
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object CodigoFamiliaInicialCtrl: TcxDBTextEdit
            Left = 167
            Top = 7
            DescriptionLabel = Label9
            DataBinding.DataField = 'CodigoFamiliaInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoFamiliaCtrlPropertiesQueryRequest
            Properties.OnValidate = CodigoFamiliaCtrlPropertiesValidate
            TabOrder = 0
            Width = 62
          end
          object CodigoFamiliaFinalCtrl: TcxDBTextEdit
            Left = 167
            Top = 34
            DescriptionLabel = Label10
            DataBinding.DataField = 'CodigoFamiliaFinal'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = CodigoFamiliaCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpRightHighest
            Properties.OnValidate = CodigoFamiliaCtrlPropertiesValidate
            TabOrder = 1
            Width = 62
          end
          object Label4: TcxLabel
            Left = 8
            Top = 11
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
          object Label9: TcxLabel
            Left = 280
            Top = 11
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
            Height = 19
            Width = 289
          end
          object Label10: TcxLabel
            Left = 280
            Top = 38
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
            Height = 19
            Width = 289
          end
        end
        object TabSheet3: TcxTabSheet
          Caption = '&Proveedor'
          ImageIndex = 2
          DesignSize = (
            573
            71)
          object gxRangeBox3: TgxRangeBox
            Left = 147
            Top = 16
            Width = 13
            Height = 37
            ParentShowHint = False
            ShowHint = True
          end
          object ProveedorInicialCtrl: TcxDBTextEdit
            Left = 165
            Top = 7
            DescriptionLabel = Label2
            DataBinding.DataField = 'ProveedorInicial'
            DataBinding.DataSource = DataSource
            Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
            Properties.TextEditPad = tpLeftZero
            Properties.OnValidate = ProveedorCtrlPropertiesValidate
            TabOrder = 0
            Width = 46
          end
          object ProveedorFinalCtrl: TcxDBTextEdit
            Left = 165
            Top = 34
            DescriptionLabel = Label11
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
            Top = 10
            Caption = 'C'#243'digo'
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 2
            Transparent = True
          end
          object Label2: TcxLabel
            Left = 280
            Top = 10
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 3
            Transparent = True
            Height = 19
            Width = 289
          end
          object Label11: TcxLabel
            Left = 280
            Top = 37
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Style.TextColor = clNavy
            Style.TransparentBorder = False
            Properties.Alignment.Horz = taLeftJustify
            TabOrder = 4
            Transparent = True
            Height = 19
            Width = 289
          end
        end
      end
    end
    object TiendaGroupBox: TcxGroupBox
      Left = 2
      Top = 321
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Height = 23
      Width = 584
      object SoloArticulosTiendaCtrl: TcxDBCheckBox
        Left = 9
        Top = 0
        AutoSize = False
        Caption = 'Solo art'#237'culos de la tienda'
        DataBinding.DataField = 'SoloArticulosTienda'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = False
        TabOrder = 0
        Transparent = True
        Height = 21
        Width = 184
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 363
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      598
      36)
    Height = 36
    Width = 598
    object Panel3: TcxGroupBox
      Left = 214
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
    FirstDataControl = CodigoArticuloInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 462
    Top = 10
  end
  object report: TgxReportManager
    FileName = 'dm30\l_art'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    OnSetReportName = reportSetReportName
    Left = 364
    Top = 9
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 431
    Top = 10
    object DataCodigoArticuloInicial: TWideStringField
      FieldName = 'CodigoArticuloInicial'
    end
    object DataCodigoArticuloFinal: TWideStringField
      FieldName = 'CodigoArticuloFinal'
    end
    object DataCodigoFamiliaInicial: TWideStringField
      FieldName = 'CodigoFamiliaInicial'
      Size = 6
    end
    object DataCodigoFamiliaFinal: TWideStringField
      FieldName = 'CodigoFamiliaFinal'
      Size = 6
    end
    object DataProveedorInicial: TWideStringField
      FieldName = 'ProveedorInicial'
      Size = 5
    end
    object DataProveedorFinal: TWideStringField
      FieldName = 'ProveedorFinal'
      Size = 5
    end
    object DataModelo: TSmallintField
      FieldName = 'Modelo'
    end
    object DataIVAIncluido: TBooleanField
      FieldName = 'IVAIncluido'
    end
    object DataIncluirObsoletos: TBooleanField
      FieldName = 'IncluirObsoletos'
    end
    object DataMostrarDescuentos: TBooleanField
      FieldName = 'MostrarDescuentos'
    end
    object DataOrdenar: TBooleanField
      FieldName = 'Ordenar'
    end
    object DataNoValorar: TBooleanField
      FieldName = 'NoValorar'
    end
    object DataMostrarCodigosBarras: TBooleanField
      FieldName = 'MostrarCodigosBarras'
    end
    object DataSoloArticulosTienda: TBooleanField
      FieldName = 'SoloArticulosTienda'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 398
    Top = 10
  end
end
