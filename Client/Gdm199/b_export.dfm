object BoxExportForm: TBoxExportForm
  Left = 412
  Top = 216
  HelpType = htKeyword
  HelpContext = 4104
  BorderStyle = bsDialog
  Caption = 'Exportaci'#243'n de ficheros'
  ClientHeight = 384
  ClientWidth = 608
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs40'
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
    ExplicitHeight = 338
    Height = 343
    Width = 598
    object TablaCtrl: TcxDBComboBox
      Left = 112
      Top = 33
      DataBinding.DataField = 'Tabla'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Sorted = True
      Properties.OnEditValueChanged = TablaCtrlPropertiesEditValueChanged
      TabOrder = 1
      Width = 191
    end
    object NombreFicheroCtrl: TcxDBTextEdit
      Left = 112
      Top = 194
      DataBinding.DataField = 'NombreFichero'
      DataBinding.DataSource = DataSource
      TabOrder = 8
      Width = 151
    end
    object DirectorioCtrl: TcxDBTextEdit
      Left = 112
      Top = 167
      DataBinding.DataField = 'Directorio'
      DataBinding.DataSource = DataSource
      Properties.OnValidate = DirectorioCtrlPropertiesValidate
      TabOrder = 6
      Width = 305
    end
    object gBitBtn3: TgBitBtn
      Left = 423
      Top = 165
      Width = 104
      Height = 28
      Caption = 'Examinar ...'
      Enabled = True
      OptionsImage.ImageIndex = 21
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 7
      OnClick = gBitBtn3Click
      GlyphBitmap = gmFolder
    end
    object TodasCtrl: TcxDBCheckBox
      Left = 8
      Top = 8
      AutoSize = False
      Caption = 'Todas las tablas'
      DataBinding.DataField = 'TodasLasTablas'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = TodasCtrlPropertiesEditValueChanged
      Style.TransparentBorder = True
      TabOrder = 0
      Transparent = True
      Height = 21
      Width = 120
    end
    object EstructuraCtrl: TcxDBCheckBox
      Left = 8
      Top = 62
      AutoSize = False
      Caption = 'Solo estructura'
      DataBinding.DataField = 'Estructura'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = TodasCtrlPropertiesEditValueChanged
      Style.TransparentBorder = True
      TabOrder = 2
      Transparent = True
      Height = 21
      Width = 120
    end
    object FormatoCtrl: TcxRadioGroup
      Left = 103
      Top = 84
      Alignment = alCenterCenter
      Properties.Columns = 3
      Properties.Items = <
        item
          Caption = 'CSV'
          Value = 0
        end
        item
          Caption = 'XML'
          Value = 1
        end
        item
          Caption = 'Interface'
          Value = '2'
        end>
      Properties.OnChange = FormatoCtrlPropertiesChange
      ItemIndex = 0
      Style.BorderStyle = ebsNone
      TabOrder = 3
      Height = 26
      Width = 235
    end
    object Label1: TcxLabel
      Left = 8
      Top = 37
      Margins.Bottom = 0
      TabStop = False
      Caption = 'Tabla'
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 8
      Top = 198
      Margins.Bottom = 0
      TabStop = False
      Caption = 'Fichero'
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 8
      Top = 171
      Margins.Bottom = 0
      TabStop = False
      Caption = 'Directorio'
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 8
      Top = 89
      Margins.Bottom = 0
      TabStop = False
      Caption = 'Formato'
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 8
      Top = 143
      Margins.Bottom = 0
      TabStop = False
      Caption = 'Separador'
      Transparent = True
    end
    object SeparadorCtrl: TcxDBIndexedComboBox
      Left = 112
      Top = 139
      CaptionLabel = Label5
      DataBinding.DataField = 'Separador'
      DataBinding.DataSource = DataSource
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        ','
        ';'
        'TAB')
      TabOrder = 5
      Width = 50
    end
    object CabeceraCtrl: TcxDBCheckBox
      Left = 8
      Top = 112
      Hint = 
        'Incluir una primera l'#237'nea de cabecera con los nombres de los cam' +
        'pos'
      AutoSize = False
      Caption = 'Cabecera'
      DataBinding.DataField = 'Cabecera'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = True
      TabOrder = 4
      Transparent = True
      Height = 21
      Width = 120
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 348
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 343
    DesignSize = (
      608
      36)
    Height = 36
    Width = 608
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
    FirstDataControl = TodasCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 418
    Top = 14
  end
  object ExportTable: TnxeTable
    Timeout = 6000
    TableType = ttRecover
    Left = 324
    Top = 15
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 389
    Top = 14
    object DataTodasLasTablas: TBooleanField
      FieldName = 'TodasLasTablas'
    end
    object DataDirectorio: TWideStringField
      FieldName = 'Directorio'
      Size = 256
    end
    object DataNombreFichero: TWideStringField
      FieldName = 'NombreFichero'
      Size = 80
    end
    object DataTabla: TWideStringField
      FieldName = 'Tabla'
      Size = 40
    end
    object DataEstructura: TBooleanField
      FieldName = 'Estructura'
    end
    object DataSeparador: TSmallintField
      FieldName = 'Separador'
    end
    object DataCabecera: TBooleanField
      FieldName = 'Cabecera'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 356
    Top = 14
  end
end
