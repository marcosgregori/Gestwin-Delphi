object BoxUeeForm: TBoxUeeForm
  Left = 513
  Top = 371
  HelpType = htKeyword
  HelpKeyword = 'b_uee'
  HelpContext = 100
  ActiveControl = UsuarioCtrl
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'Selecci'#243'n de usuario, empresa y ejercicio'
  ClientHeight = 166
  ClientWidth = 469
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  KeyPreview = True
  Position = poDefault
  Visible = True
  TextHeight = 17
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 130
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      469
      36)
    Height = 36
    Width = 469
    object Panel3: TgxEditPanel
      Left = 142
      Top = 3
      Anchors = [akTop]
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 0
      Height = 30
      Width = 186
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 90
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
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
      object cerrarButton: TgBitBtn
        AlignWithMargins = True
        Left = 94
        Top = 0
        Width = 90
        Height = 30
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
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
    DesignSize = (
      459
      125)
    Height = 125
    Width = 459
    object Label2: TcxLabel
      Left = 8
      Top = 6
      TabStop = False
      Caption = 'C'#243'digo de usuario'
      Transparent = True
    end
    object LabelCtrl3: TcxLabel
      Left = 8
      Top = 60
      TabStop = False
      Caption = 'Fecha'
      Transparent = True
    end
    object LabelCtrl4: TcxLabel
      Left = 8
      Top = 89
      TabStop = False
      Caption = 'Ejercicio'
      Transparent = True
    end
    object LabelCtrl6: TcxLabel
      Left = 206
      Top = 6
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 21
      Width = 247
      AnchorY = 17
    end
    object LabelCtrl1: TcxLabel
      Left = 8
      Top = 33
      TabStop = False
      Caption = 'C'#243'digo de empresa'
      Transparent = True
    end
    object LabelCtrl5: TcxLabel
      Left = 206
      Top = 33
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 21
      Width = 247
      AnchorY = 44
    end
    object UsuarioCtrl: TcxDBTextEdit
      Left = 137
      Top = 5
      DescriptionLabel = LabelCtrl6
      DataBinding.DataField = 'CodigoUsuario'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = UsuarioCtrlPropertiesQueryRequest
      Properties.OnEditRequest = UsuarioCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnEditValueChanged = UsuarioCtrlPropertiesEditValueChanged
      Properties.OnValidate = UsuarioCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object FechaCtrl: TcxDBDateEdit
      Left = 137
      Top = 59
      DataBinding.DataField = 'Fecha'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValuePosted = FechaCtrlPropertiesValuePosted
      Properties.DateButtons = [btnClear, btnToday]
      Properties.DateOnError = deToday
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 2
      Width = 100
    end
    object EmpresaCtrl: TcxDBTextEdit
      Left = 137
      Top = 32
      DescriptionLabel = LabelCtrl5
      DataBinding.DataField = 'CodigoEmpresa'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = empresaCtrlPropertiesQueryRequest
      Properties.OnEditRequest = empresaCtrlPropertiesEditRequest
      Properties.CharCase = ecUpperCase
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = empresaCtrlPropertiesValidate
      Style.TransparentBorder = True
      TabOrder = 1
      Width = 35
    end
    object EjercicioLabel: TcxLabel
      Left = 137
      Top = 87
      TabStop = False
      AutoSize = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 25
      Width = 41
      AnchorX = 178
      AnchorY = 100
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = UsuarioCtrl
    ShowQueryOption = False
    AfterDestroyForm = FormManagerAfterDestroyForm
    OnInitializeForm = InitializeForm
    OnShowForm = FormManagerShowForm
    OnCanClose = FormManagerCanClose
    OnOkButton = FormManagerOkButton
    Left = 396
    Top = 8
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 364
    Top = 8
    object DataCodigoUsuario: TWideStringField
      FieldName = 'CodigoUsuario'
      Size = 2
    end
    object DataCodigoEmpresa: TWideStringField
      FieldName = 'CodigoEmpresa'
      Size = 3
    end
    object DataFecha: TDateField
      FieldName = 'Fecha'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 332
    Top = 8
  end
end
