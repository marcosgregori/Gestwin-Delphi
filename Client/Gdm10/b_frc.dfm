object BoxFrcForm: TBoxFrcForm
  Left = 402
  Top = 224
  HelpType = htKeyword
  HelpKeyword = 'b_frc'
  HelpContext = 3003
  BorderStyle = bsDialog
  Caption = 'Filtro de efectos a cobrar'
  ClientHeight = 169
  ClientWidth = 426
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 133
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      426
      36)
    Height = 36
    Width = 426
    object Panel3: TcxGroupBox
      Left = 123
      Top = 3
      Anchors = []
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
      416
      128)
    Height = 128
    Width = 416
    object TipoDocumentoCtrl: TcxDBIndexedComboBox
      Left = 134
      Top = 6
      DataBinding.DataField = 'TipoDocumento'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        'Todos'
        'Letras de cambio'
        'Recibos'
        'Pagar'#233's')
      Properties.OnEditValueChanged = TipoDocumentoCtrlPropertiesEditValueChanged
      TabOrder = 0
      Width = 165
    end
    object RevisionCtrl: TcxDBIndexedComboBox
      Left = 134
      Top = 33
      DataBinding.DataField = 'Revision'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Todos'
        'Revisados'
        'Pendientes de revisi'#243'n')
      TabOrder = 1
      Width = 165
    end
    object FormaCobroCtrl: TcxDBTextEdit
      Left = 134
      Top = 60
      DescriptionLabel = Label9
      DataBinding.DataField = 'FormaCobro'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = FormaCobroCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = FormaCobroCtrlPropertiesValidate
      TabOrder = 2
      Width = 28
    end
    object IncluirAbonosCtrl: TcxDBCheckBox
      Left = 8
      Top = 87
      AutoSize = False
      Caption = '&Incluir abonos'
      DataBinding.DataField = 'IncluirAbonos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 3
      Transparent = True
      Height = 23
      Width = 143
    end
    object Label1: TcxLabel
      Left = 11
      Top = 10
      Caption = 'Tipo de documento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 11
      Top = 37
      Caption = 'Revisi'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 11
      Top = 64
      Caption = 'Forma de cobro'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 193
      Top = 64
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
      Height = 19
      Width = 233
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = TipoDocumentoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 362
    Top = 10
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 300
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <
      item
        SortOptions = []
      end>
    SortOptions = []
    Left = 331
    Top = 10
    object DataTipoDocumento: TSmallintField
      FieldName = 'TipoDocumento'
    end
    object DataRevision: TSmallintField
      FieldName = 'Revision'
    end
    object DataFormaCobro: TWideStringField
      FieldName = 'FormaCobro'
      Size = 2
    end
    object DataIncluirAbonos: TBooleanField
      FieldName = 'IncluirAbonos'
    end
  end
end
