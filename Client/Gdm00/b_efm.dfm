object boxEfmForm: TboxEfmForm
  Left = 360
  Top = 180
  HelpType = htKeyword
  HelpKeyword = 'b_efm'
  HelpContext = 6167
  BorderStyle = bsDialog
  Caption = 'Exportaci'#243'n e importaci'#243'n de ficheros'
  ClientHeight = 424
  ClientWidth = 599
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  Position = poDefault
  Visible = True
  OnResize = FormResize
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
      589
      383)
    Height = 383
    Width = 589
    object ProcesoCtrl: TcxDBIndexedComboBox
      Left = 133
      Top = 6
      DataBinding.DataField = 'Proceso'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        'Exportar'
        'Importar')
      Properties.OnEditValueChanged = ProcesoCtrlPropertiesChange
      TabOrder = 0
      Width = 109
    end
    object PathCtrl: TcxDBTextEdit
      Left = 133
      Top = 78
      CaptionLabel = Label3
      Anchors = [akLeft, akTop, akRight]
      DataBinding.DataField = 'Path'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = PathCtrlPropertiesValidate
      TabOrder = 2
      Width = 359
    end
    object examinarButton: TgBitBtn
      Left = 496
      Top = 74
      Width = 89
      Height = 32
      Anchors = [akTop, akRight]
      Caption = 'E&xaminar'
      Enabled = True
      OptionsImage.ImageIndex = 21
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 3
      TabStop = False
      OnClick = examinarButtonClick
      GlyphBitmap = gmFolder
    end
    object DestinoOrigenCtrl: TcxDBRadioGroup
      Left = 133
      Top = 34
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
      Properties.OnEditValueChanged = DestinoOrigenCtrlPropertiesChange
      TabOrder = 1
      Transparent = True
      Height = 39
      Width = 185
    end
    object DireccionCorreoCtrl: TcxDBTextEdit
      Left = 133
      Top = 105
      CaptionLabel = Label5
      DescriptionLabel = Label6
      DataBinding.DataField = 'DireccionCorreo'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.Required = True
      Properties.OnQueryRequest = DireccionCorreoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = DireccionCorreoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = DireccionCorreoCtrlPropertiesValidate
      TabOrder = 4
      Width = 33
    end
    object CheckListBox: TcxCheckListBox
      Left = 7
      Top = 136
      Width = 485
      Height = 241
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = 2
      EditValueFormat = cvfIndices
      Items = <>
      Sorted = True
      TabOrder = 5
    end
    object seleccionBtn: TgBitBtn
      Left = 497
      Top = 136
      Width = 89
      Height = 32
      Anchors = [akTop, akRight]
      Caption = '&Todos'
      Enabled = True
      ModalResult = 8
      OptionsImage.ImageIndex = 9
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 6
      TabStop = False
      OnClick = seleccionBtnClick
      GlyphBitmap = gmAll
    end
    object Label2: TcxLabel
      Left = 10
      Top = 10
      Caption = 'Proceso'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 10
      Top = 81
      Caption = 'Path (directorio)'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object destinoOrigenLabel: TcxLabel
      Left = 10
      Top = 38
      Caption = 'Destino'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 10
      Top = 108
      Caption = 'Direcci'#243'n de correo'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 183
      Top = 108
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 326
    end
  end
  object buttonPanel: TgxEditPanel
    Left = 0
    Top = 388
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      599
      36)
    Height = 36
    Width = 599
    object Panel2: TcxGroupBox
      Left = 213
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
    FirstDataControl = ProcesoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 483
    Top = 9
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 422
    Top = 8
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 452
    Top = 8
    object DataProceso: TSmallintField
      FieldName = 'Proceso'
    end
    object DataDestinoOrigen: TSmallintField
      FieldName = 'DestinoOrigen'
    end
    object DataPath: TWideStringField
      FieldName = 'Path'
      Size = 128
    end
    object DataDireccionCorreo: TWideStringField
      FieldName = 'DireccionCorreo'
      Size = 2
    end
  end
end
