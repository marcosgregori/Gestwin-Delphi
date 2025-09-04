object BoxCcrForm: TBoxCcrForm
  Left = 619
  Top = 458
  HelpContext = 80515
  BorderStyle = bsDialog
  Caption = 'Copia de registros'
  ClientHeight = 181
  ClientWidth = 533
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Position = poDefault
  Visible = True
  TextHeight = 17
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 145
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epButtonsPanel
    ExplicitTop = 148
    ExplicitWidth = 402
    DesignSize = (
      533
      36)
    Height = 36
    Width = 533
    object Panel3: TcxGroupBox
      Left = 180
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 114
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
    TabOrder = 1
    PanelKind = epInputPanel
    ExplicitLeft = 7
    ExplicitWidth = 577
    ExplicitHeight = 143
    DesignSize = (
      523
      140)
    Height = 140
    Width = 523
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 63
      Align = alBottom
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 2
      ExplicitTop = 66
      ExplicitWidth = 567
      Height = 72
      Width = 513
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 6
        Top = 22
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        Caption = 
          'Indique los c'#243'digos de empresa y/o usuario y pulse [Aceptar] par' +
          'a crear una copia del registro actual.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        Transparent = True
        ExplicitTop = 14
        ExplicitWidth = 559
        ExplicitHeight = 42
        Width = 505
      end
    end
    object Label2: TcxLabel
      Left = 9
      Top = 31
      TabStop = False
      Caption = 'C'#243'digo de usuario'
      Transparent = True
    end
    object LabelCtrl6: TcxLabel
      Left = 212
      Top = 31
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      ExplicitWidth = 350
      Height = 21
      Width = 296
      AnchorY = 42
    end
    object LabelCtrl1: TcxLabel
      Left = 9
      Top = 6
      TabStop = False
      Caption = 'C'#243'digo de empresa'
      Transparent = True
    end
    object LabelCtrl5: TcxLabel
      Left = 212
      Top = 6
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      ExplicitWidth = 350
      Height = 21
      Width = 296
      AnchorY = 17
    end
    object UsuarioCtrl: TcxDBTextEdit
      Left = 140
      Top = 30
      DescriptionLabel = LabelCtrl6
      DataBinding.DataField = 'CodigoUsuario'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = UsuarioCtrlPropertiesQueryRequest
      Properties.OnEditRequest = UsuarioCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = UsuarioCtrlPropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object EmpresaCtrl: TcxDBTextEdit
      Left = 140
      Top = 5
      DescriptionLabel = LabelCtrl5
      DataBinding.DataField = 'CodigoEmpresa'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = EmpresaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = EmpresaCtrlPropertiesEditRequest
      Properties.CharCase = ecUpperCase
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = EmpresaCtrlPropertiesValidate
      Style.TransparentBorder = True
      TabOrder = 0
      Width = 35
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = EmpresaCtrl
    ShowQueryOption = False
    OnOkButton = FormManagerOkButton
    Left = 384
    Top = 94
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 353
    Top = 94
    object DataCodigoEmpresa: TStringField
      FieldName = 'CodigoEmpresa'
      Size = 3
    end
    object DataCodigoUsuario: TStringField
      FieldName = 'CodigoUsuario'
      Size = 2
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 320
    Top = 94
  end
end
