object BoxIeaForm: TBoxIeaForm
  Left = 538
  Top = 286
  HelpType = htKeyword
  HelpKeyword = 'b_eia'
  HelpContext = 1129
  BorderStyle = bsDialog
  Caption = 'Exportaci'#243'n e importaci'#243'n de art'#237'culos'
  ClientHeight = 401
  ClientWidth = 574
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
    Height = 360
    Width = 564
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        560
        174)
      Height = 174
      Width = 560
      object Shape1: TShape
        Left = 2
        Top = 171
        Width = 556
        Height = 1
        Align = alBottom
        Pen.Color = clBtnShadow
        ExplicitLeft = 8
        ExplicitTop = 169
        ExplicitWidth = 532
      end
      object DestinoOrigenCtrl: TcxDBRadioGroup
        Left = 129
        Top = 60
        Alignment = alCenterCenter
        DataBinding.DataField = 'DestinoOrigen'
        DataBinding.DataSource = DataSource
        Properties.ImmediatePost = True
        Properties.Items = <
          item
            Caption = 'Fichero'
            Value = 0
          end
          item
            Caption = 'Correo electr'#243'nico (e-mail)'
            Value = 1
          end>
        Properties.OnEditValueChanged = DestinoOrigenCtrlPropertiesEditValueChanged
        Style.BorderStyle = ebsNone
        TabOrder = 0
        Height = 48
        Width = 191
      end
      object destinoOrigenLabel: TcxLabel
        Left = 8
        Top = 63
        Caption = 'Destino'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object DireccionCorreoCtrl: TcxDBTextEdit
        Left = 136
        Top = 139
        CaptionLabel = Label9
        DescriptionLabel = Label10
        DataBinding.DataField = 'DireccionCorreo'
        DataBinding.DataSource = DataSource
        Enabled = False
        Properties.Required = True
        Properties.OnQueryRequest = DireccionCorreoCtrlPropertiesQueryRequest
        Properties.OnEditRequest = DireccionCorreoCtrlPropertiesEditRequest
        Properties.TextEditPad = tpLeftZero
        Properties.PadAlways = True
        Properties.OnValidate = DireccionCorreoCtrlPropertiesValidate
        TabOrder = 2
        Width = 25
      end
      object ExaminarButton: TgBitBtn
        Left = 456
        Top = 110
        Width = 104
        Height = 27
        Anchors = [akTop, akRight]
        Caption = 'E&xaminar ...'
        Enabled = True
        OptionsImage.ImageIndex = 21
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 3
        TabStop = False
        OnClick = ExaminarButtonClick
        GlyphBitmap = gmFolder
      end
      object FormatoCtrl: TcxDBIndexedComboBox
        Left = 136
        Top = 5
        DataBinding.DataField = 'Formato'
        DataBinding.DataSource = DataSource
        Properties.OnValuePosted = TipoExportacionValuePosted
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'GESTWIN'
          'Texto delimitado por comas (ASCII)')
        TabOrder = 4
        Width = 211
      end
      object Label10: TcxLabel
        Left = 256
        Top = 145
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Enabled = False
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -11
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.TransparentBorder = False
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
        Height = 19
        Width = 299
      end
      object Label2: TcxLabel
        Left = 8
        Top = 35
        Caption = 'Proceso'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
      end
      object Label3: TcxLabel
        Left = 8
        Top = 115
        Caption = 'Directorio'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
      end
      object Label8: TcxLabel
        Left = 8
        Top = 9
        Caption = 'Formato'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
      end
      object Label9: TcxLabel
        Left = 8
        Top = 142
        Caption = 'Direcci'#243'n de correo'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
      end
      object PathCtrl: TcxDBTextEdit
        Left = 136
        Top = 111
        Anchors = [akLeft, akTop, akRight]
        DataBinding.DataField = 'Path'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnValidate = PathCtrlPropertiesValidate
        TabOrder = 10
        Width = 311
      end
      object ProcesoCtrl: TcxDBIndexedComboBox
        Left = 136
        Top = 32
        DataBinding.DataField = 'Proceso'
        DataBinding.DataSource = DataSource
        Properties.OnValuePosted = TipoExportacionValuePosted
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'Exportar'
          'Importar')
        TabOrder = 11
        Width = 97
      end
    end
    object SeleccionFechaPanel: TcxGroupBox
      Left = 2
      Top = 176
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      DesignSize = (
        560
        140)
      Height = 140
      Width = 560
      object gxRangeBox1: TgxRangeBox
        Left = 119
        Top = 91
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object gxRangeBox2: TgxRangeBox
        Left = 119
        Top = 12
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object FechaInicialCtrl: TcxDBDateEdit
        Left = 134
        Top = 86
        CaptionLabel = FechaLabel
        DataBinding.DataField = 'FechaInicial'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        TabOrder = 3
        Width = 100
      end
      object FechaFinalCtrl: TcxDBDateEdit
        Left = 134
        Top = 113
        DataBinding.DataField = 'FechaFinal'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        TabOrder = 4
        Width = 100
      end
      object FechaLabel: TcxLabel
        Left = 8
        Top = 89
        Caption = 'Fecha de alta'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
      end
      object FamiliaCtrl: TcxDBTextEdit
        Left = 135
        Top = 59
        DescriptionLabel = descFamiliaLabel
        DataBinding.DataField = 'CodigoFamilia'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = FamiliaCtrlPropertiesQueryRequest
        Properties.OnValidate = FamiliaCtrlPropertiesValidate
        TabOrder = 2
        Width = 62
      end
      object Label25: TcxLabel
        Left = 8
        Top = 62
        Caption = 'Familia'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 6
        Transparent = True
      end
      object descFamiliaLabel: TcxLabel
        Left = 256
        Top = 62
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
        Height = 19
        Width = 303
      end
      object CodigoArticuloInicialCtrl: TcxDBTextEdit
        Left = 134
        Top = 5
        DescriptionLabel = Label7
        DataBinding.DataField = 'CodigoArticuloInicial'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
        Properties.ExpandZeroes = False
        TabOrder = 0
        Width = 109
      end
      object CodigoArticuloFinalCtrl: TcxDBTextEdit
        Left = 134
        Top = 32
        DescriptionLabel = cxLabel1
        DataBinding.DataField = 'CodigoArticuloFinal'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
        Properties.ExpandZeroes = False
        Properties.TextEditPad = tpRightHighest
        Properties.PadAlways = True
        Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
        TabOrder = 1
        Width = 109
      end
      object Label1: TcxLabel
        Left = 8
        Top = 8
        Caption = 'C'#243'digo'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
      end
      object Label7: TcxLabel
        Left = 256
        Top = 8
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
        Height = 19
        Width = 299
      end
      object cxLabel1: TcxLabel
        Left = 256
        Top = 35
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 10
        Transparent = True
        Height = 19
        Width = 303
      end
    end
    object CampoLibre9Panel: TcxGroupBox
      Left = 2
      Top = 316
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Height = 23
      Width = 560
      object CampoLibre9Ctrl: TcxDBCheckBox
        Left = 6
        Top = 2
        AutoSize = False
        Caption = 'Campo 9'
        DataBinding.DataField = 'CampoLibre9'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        TabOrder = 0
        Transparent = True
        Height = 21
        Width = 146
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 365
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      574
      36)
    Height = 36
    Width = 574
    object Panel3: TcxGroupBox
      Left = 202
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
    FirstDataControl = FormatoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 486
    Top = 16
  end
  object ArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 485
    Top = 170
  end
  object ExternArticuloTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 485
    Top = 200
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 455
    Top = 16
    object DataProceso: TSmallintField
      FieldName = 'Proceso'
    end
    object DataPath: TWideStringField
      FieldName = 'Path'
      Size = 125
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
    object DataDestinoOrigen: TSmallintField
      FieldName = 'DestinoOrigen'
    end
    object DataDireccionCorreo: TWideStringField
      FieldName = 'DireccionCorreo'
      Size = 2
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataCodigoArticuloInicial: TStringField
      FieldName = 'CodigoArticuloInicial'
    end
    object DataCodigoArticuloFinal: TStringField
      FieldName = 'CodigoArticuloFinal'
    end
    object DataCodigoFamilia: TStringField
      FieldName = 'CodigoFamilia'
      Size = 6
    end
    object DataCampoLibre9: TBooleanField
      FieldName = 'CampoLibre9'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 424
    Top = 16
  end
end
