object BoxFrpForm: TBoxFrpForm
  Left = 402
  Top = 224
  HelpType = htKeyword
  HelpKeyword = 'b_frp'
  HelpContext = 3003
  BorderStyle = bsDialog
  Caption = 'Filtro de efectos a pagar'
  ClientHeight = 147
  ClientWidth = 491
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
    Top = 111
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 76
    DesignSize = (
      491
      36)
    Height = 36
    Width = 491
    object Panel3: TcxGroupBox
      Left = 156
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
    ExplicitHeight = 71
    DesignSize = (
      481
      106)
    Height = 106
    Width = 481
    object TipoDocumentoCtrl: TcxDBIndexedComboBox
      Left = 132
      Top = 6
      DataBinding.DataField = 'TipoDocumento'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        'Todos'
        'Letra de cambio'
        'Recibo'
        'Cheque bancario o pagar'#233
        'Transferencia'
        'Pago certificado'
        'Confirming')
      Properties.OnEditValueChanged = TipoDocumentoCtrlPropertiesEditValueChanged
      TabOrder = 0
      Width = 165
    end
    object FormaPagoCtrl: TcxDBTextEdit
      Left = 132
      Top = 62
      DescriptionLabel = Label9
      DataBinding.DataField = 'FormaPago'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = FormaPagoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = FormaPagoCtrlPropertiesValidate
      TabOrder = 2
      Width = 28
    end
    object Label1: TcxLabel
      Left = 11
      Top = 10
      Caption = 'Tipo de documento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 3
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 11
      Top = 66
      Caption = 'Forma de pago'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 194
      Top = 65
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      ParentFont = False
      Style.TextColor = clNavy
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
      Height = 19
      Width = 278
    end
    object RevisionCtrl: TcxDBIndexedComboBox
      Left = 132
      Top = 34
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
    object Label3: TcxLabel
      Left = 11
      Top = 38
      Caption = 'Revisi'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
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
    object DataFormaPago: TWideStringField
      FieldName = 'FormaPago'
      Size = 2
    end
    object DataRevision: TSmallintField
      FieldName = 'Revision'
    end
  end
end
