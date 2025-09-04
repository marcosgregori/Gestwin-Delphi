object BoxSdsForm: TBoxSdsForm
  Left = 536
  Top = 312
  HelpType = htKeyword
  HelpKeyword = 'b_sds'
  HelpContext = 1131
  BorderStyle = bsDialog
  Caption = 'Sustituci'#243'n de subcuentas'
  ClientHeight = 275
  ClientWidth = 580
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
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
      570
      233)
    Height = 233
    Width = 570
    object SubcuentaActualCtrl: TcxDBTextEdit
      Left = 142
      Top = 7
      DescriptionLabel = Label1
      DataBinding.DataField = 'SubcuentaActual'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = SubcuentaCtrlPropertiesEditRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = SubcuentaActualCtrlPropertiesValidate
      TabOrder = 0
      Width = 74
    end
    object SubcuentaNuevaCtrl: TcxDBTextEdit
      Left = 142
      Top = 34
      DescriptionLabel = NombreSubcuentaNuevaLabel
      DataBinding.DataField = 'SubcuentaNueva'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = SubcuentaCtrlPropertiesEditRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = SubcuentaNuevaCtrlPropertiesValidate
      TabOrder = 1
      Width = 74
    end
    object cxDBCheckBox1: TcxDBCheckBox
      Left = 10
      Top = 62
      AutoSize = False
      Caption = 'Todos los ejercicios'
      DataBinding.DataField = 'TodosLosEjercicios'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 2
      Transparent = True
      Height = 23
      Width = 149
    end
    object Label3: TcxLabel
      Left = 13
      Top = 10
      TabStop = False
      Caption = 'Subcuenta actual'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 13
      Top = 37
      TabStop = False
      Caption = 'Subcuenta nueva'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 226
      Top = 10
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
      Height = 19
      Width = 341
    end
    object NombreSubcuentaNuevaLabel: TcxLabel
      Left = 226
      Top = 37
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
      Height = 19
      Width = 341
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 6
      Top = 96
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 7
      Height = 111
      Width = 554
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 6
        Top = 22
        Margins.Left = 4
        Margins.Top = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        Caption = 
          'Este proceso realiza la sustituci'#243'n del c'#243'digo de una subcuenta ' +
          'por otro. Para ello se sustituyen todas las referencias a la mis' +
          'ma en todos los ficheros DE MOVIMIENTOS del ejercicio activo. Si' +
          ' se marca la opci'#243'n correspondiente el proceso se ralizar'#225' en TO' +
          'DOS LOS EJERCICIOS existentes y afectar'#225' tambi'#233'n a los ficheros ' +
          'maestros.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 543
      end
    end
  end
  object buttonPanel: TgxEditPanel
    Left = 0
    Top = 238
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      580
      37)
    Height = 37
    Width = 580
    object Panel2: TcxGroupBox
      Left = 205
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
    FirstDataControl = SubcuentaActualCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 458
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 425
    Top = 12
    object DataSubcuentaActual: TWideStringField
      FieldName = 'SubcuentaActual'
      Size = 9
    end
    object DataSubcuentaNueva: TWideStringField
      FieldName = 'SubcuentaNueva'
      Size = 9
    end
    object DataSuprimir: TBooleanField
      FieldName = 'Suprimir'
    end
    object DataTodosLosEjercicios: TBooleanField
      FieldName = 'TodosLosEjercicios'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 394
    Top = 12
  end
end
